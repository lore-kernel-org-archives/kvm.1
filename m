Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0B470456
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932423; cv=none; b=Z+UZxdzmhQXxEAAEPJpIQiLr4u7qDghVbzSbKixCSWnOmUr21prqWfFlN5wtRZE+IiQdllK+s9qqzJpvR4SffD5ujjUfeFZ9CN2bk72/0gggJ7cswaN+WstbFlrIWuswbLCkF9jRbz6HpZeNc3cboVPEux+M4uk65DxsQ69VhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932423; c=relaxed/simple;
	bh=slq9Gy3m4qAtOsurc3gwLfxdzwRbCk5g9ITP/Q+ilX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FPUSBzfa9emSrx38OQKgsB31qWA1D4kMaVcjCFMqxqadPxCPEw0k+6Q71Hd99fYuTT5GXbRGW0YR64B1bIxfYWLoKnsWy4xtETF0lWRanYryliQFfqbG2HuePYvDWTibkV80EnCgnn2+6fHQnJoSoUNr/MC7X+gWPg1G5B9YyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDXOuo9X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDXOuo9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50ADA1F000FF;
	Fri,  2 Oct 2026 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932422;
	bh=YVLCNMtLrlv88DAadfcLV8Ulbk12fXZFuwgBcdnBm8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDXOuo9Xas++SZ/3K5ZMscq9BXnjGZr7QK1Op2f2QDCwz7PVGam/5lWjebufH+xZ/
	 ZT6S57X4kH9dm6zwAwirQTRVF7yg4gWxLLFjfThgU9rHBnbGH75CadJeSFXmXRUP/n
	 VtvSaTAmdTsVibNgy+ogB3kvMp01n5BKbAcXP3lwhEYdl28oFk/fLKcEohy9JJgUgK
	 p3lNtshKkaPD9JPDw/ECc0y//zeIJDyE1kti4h4JaFCQY7bSG8grEvwIHFjiA0cpYc
	 SK9aWhNctchyNoNJVwaJ4lkGkiaFOkdUve41oxy+tM4AKmj6+04wpyBiPGXoReJiED
	 jOpjmk71eBPLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] KVM: x86: Unmap VMAs for KVM-internal memslots
 when the memslot is freed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261001202234.3794060-4-seanjc@google.com>
References: <20261001202234.3794060-1-seanjc@google.com>
 <20261001202234.3794060-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:41 +0000
Message-Id: <20261002091342.50ADA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: double unmap of internal memslot VMA causes host UAF
--

commit 120ca6d762cdf95d09e394aff4bb4af6d01288d6
Author: Sean Christopherson <seanjc@google.com>
KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is freed

This commit unmaps KVM-created VMAs for KVM-internal memslots when the
associated memslot is freed directly, instead of using x86's internal API,
to prevent VMA leaks on teardown.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 79468ddfe4736..e91bd79dd3cc6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -10066,6 +10048,16 @@ void kvm_arch_free_memslot(struct kvm *kvm, stru=
ct kvm_memory_slot *slot)
>  	}
> =20
>  	kvm_page_track_free_memslot(slot);
> +
> +	/*
> +	 * Free memory regions allocated on behalf of userspace, unless the
> +	 * memory map has changed due to process exit or fd copying.  Leak the
> +	 * mapping on failure, e.g. if the task is killed, worst case scenario,
> +	 * the page(s) will be reclaimed when the process exits.
> +	 */
> +	if (current->mm =3D=3D kvm->mm && slot->id >=3D KVM_USER_MEM_SLOTS &&
> +	    !WARN_ON_ONCE(!slot->npages))
> +		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
>  }

[Severity: High]
Does this unconditionally unmap the VMA for every freed internal memslot ob=
ject,
potentially leading to a double unmap?

In __x86_set_memory_region(), the twin memslot objects are created with the
exact same userspace_addr for each address space:

	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
		struct kvm_userspace_memory_region2 m;

		m.slot =3D id | (i << 16);
		m.flags =3D 0;
		m.guest_phys_addr =3D gpa;
		m.userspace_addr =3D hva;
...

When the VM is destroyed or the memslot is deleted, KVM iterates over all
address spaces and calls kvm_arch_free_memslot() for each memslot object.

Because vm_munmap() is called here without checking if slot->as_id is 0, co=
uld
it unmap the same HVA range multiple times?

If a concurrent thread maps memory between the two unmaps, the new memory
might be silently unmapped, potentially leading to memory corruption and
use-after-free in the host.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001202234.3794=
060-1-seanjc@google.com?part=3D3

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6A339861
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427518; cv=none; b=MgVJhKET3wKWUELe6Z4Hbj5B7ZRwG8GbvLkdG9EHgV4U9Kj/YIgGn9gK89wvP+A/r6Rr8ScpdsbTM1janJ9k3mNJOdSYbMKVAs81MQk3XQP8HpzL0pf+Im4SI852DaJ9mhs4oE5yOYKOWT9qfA1jXz4OiwYVVm17nZ+u3xlX3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427518; c=relaxed/simple;
	bh=S4KeznrIz9GD7P/9tQ5HcTQVooiPTJsRqw6YJ74NZAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dKfqFTI+DnXd+T/pf8znsx0PjDcqtEpr7CPM0yAtcMssiAFplu44VK340UBOvjBhvG2WBqi5WbSGVWPxbdmVv1Cn/dKvdB9TYXBNyiEeAkD4IneY9XOv7Lsk0tpB/QJmc9PUK1ZfEA5rCMMUzdtc4UGVT30OsaQE56yN4Ug3oCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBpG0SPL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBpG0SPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB7D1F000E9;
	Thu, 25 Jun 2026 22:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782427517;
	bh=vDQutogaHlPqV8mIQ4h/8g1zOIfsKGxdxlyddccjxCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BBpG0SPL4m4FEDTAifFAjIpCG1hnO3+I1YqUQdoejTCbEwZGuUYflk1efKaFtG14O
	 e8Au2a9raD0sfWkp3qGwn1mhtT2zy1fbEGcvlkezrjF7uGYJfVy/52njIBNJv+AGYH
	 mcr6LoazAXsREJQwmu75XlqDa6rCQn42gUislTGw7Hr1gF/YEXXUhE9LV7uaKLKnN+
	 7AdAdbbMu0Qeag9TwfBL/kSxhxT4oaXv9IJ57/TiWnnoOLmneJXP6AL9xR/D0BLQjE
	 G3Nbtjk8THXt3lUZNUuGEji/zuqfh3Fa9Bw8Mji8S75gNr+tXbbZMCbwNwEIEc4bfw
	 v6iITRNk339AQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625222229.3367197-6-seanjc@google.com>
References: <20260625222229.3367197-1-seanjc@google.com>
 <20260625222229.3367197-6-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:45:17 +0000
Message-Id: <20260625224517.6BB7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Deleting a guest_memfd-backed memslot severs invalidation call=
backs but leaves the VMSA loaded in hardware, allowing the pages to be free=
d while in-use and crashing the host.
--

commit 1d8649cc04198822af1b4661735a4bc1d852fe1f
Author: Sean Christopherson <seanjc@google.com>

KVM: SEV: Forcefully invalidate SNP VMSA if its backing gmem page is zapped

This commit wires up a gmem_invalidate_range() call for SNP VMs. It forces
vCPUs to reload or recheck their guest-provided VMSA if the backing
guest_memfd page is being invalidated.

Closes: https://lore.kernel.org/all/aimMWzAf5b3luM0b@v4bel

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1618acc3ca647..8ec5041934dbc 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_=
file *f, pgoff_t start,
>  		}
> =20
>  		flush |=3D kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> +#endif
>  	}
> =20
>  	if (flush)

[Severity: Critical]
Does this invalidation path cover the case where the memslot is unbound bef=
ore
the guest_memfd pages are freed?

If userspace deletes the memslot (e.g., via KVM_SET_USER_MEMORY_REGION2),
kvm_gmem_unbind() removes the slot from the f->bindings xarray.

If userspace then closes the guest_memfd file descriptor,
__kvm_gmem_invalidate_start() will iterate over f->bindings here, find it
empty, and skip calling kvm_arch_gmem_invalidate_range().

Since the vCPU is never kicked to reload the VMSA, the hardware could still=
 be
actively using the page. When sev_gmem_free_folio() attempts to transition =
the
pages to shared via rmp_make_shared(), the hardware will reject it with
FAIL_INUSE.

Could this leak the encrypted page to the host allocator and subsequently
cause an RMP violation #PF?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625222229.3367=
197-1-seanjc@google.com?part=3D5

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA032475CF
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025583; cv=none; b=UD3h5RoxM094dFW8QTjFWWhQBjXiWUkGxKAmvtgtbH+YlRr/yEc/C9OHRQEeU6P8qDWW76L7XGEZ2maX10hR4w2N4wBH51TnVV6iO+WUSZ1YtPBmKAeVBgBU2OxhMzBJn8A7GTOkZ/YJIJgLGPxGPlNMy+hGRIMVSsFCmzEKYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025583; c=relaxed/simple;
	bh=+qfiOErA/N25TrI/l0lI5CQBm79NhrPVBVbcjG39Yw4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VhxhQfoFNKLsNSdy355z0Eqv/9r8qeZnaK4EFkL287MaLhyGZK3pbD2zBTk5p0nbPwpO9pqQrbppSLXaUcG0guUi7jZ/ngub6nFQbfIZ9P/biTowpKqPu/lpjxAfEXPLizi2BUcZDtqnAPNd0E/KTBivCGHxcEwtZ9ILvpZG28Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KoAn3Tum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KoAn3Tum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A91F000FF;
	Mon, 21 Sep 2026 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025581;
	bh=U1LzjUrgjAvASiVP4s+H6Dyi3lnlcz9fJJU+wra+qR0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KoAn3TumLOexrabK7UspqxTOggVPHz90bnk1kSyOS38FlC+RVhTb+ymSevl9zE1IZ
	 7uK9XsQ9Kwi3Viofeg5DPypO8LHK8CcheZxFEchi/HrSHFkSys9+0Pr5Z89RsQM4Hn
	 aiikXrtYIwV/TMf60BwHbDtv2z7ZVU9k1AQxguAkJ4tWrTZ6Uf1e91O2Wn7ZpTCx8Z
	 FiOjMbw0/oq0pd8Wirgau14e8cAHXQ/m1UTzcxZ66oY71nDH1sl8z8gSz2lUcfMDbg
	 3INzeBRVAqxVyx0cdQbTqxauAW/1mI82iD5AlOuZRf880bzV4n1jFcuF4NzZTtk58G
	 xht3fuyNeY5Rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] KVM: guest_memfd: Establish
 memslot<=>guest_memfd bindings *after* memslot is ready
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921210616.1024168-5-seanjc@google.com>
References: <20260921210616.1024168-1-seanjc@google.com>
 <20260921210616.1024168-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:19:40 +0000
Message-Id: <20260921211941.5E8A91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: arm64 guest_memfd creation always fails with -EINVAL
--

commit 4ef8ddb233e05072a60b26ea82b2f5c73a298a71
Author: Sean Christopherson <seanjc@google.com>

KVM: guest_memfd: Establish memslot<=3D>guest_memfd bindings *after* memslo=
t is ready

This patch delays binding a memslot to a guest_memfd instance until after
the memslot is prepared. It accomplishes this by moving the kvm_gmem_bind()
call directly into kvm_set_memslot(), running it after the call to
kvm_prepare_memory_region().

Closes: https://lore.kernel.org/all/20260826170551.BEF801F000E9@smtp.kernel=
.org

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -1944,6 +1945,15 @@ static int kvm_set_memslot(struct kvm *kvm,
>  	r =3D kvm_prepare_memory_region(kvm, old, new, change);
>  	if (r)
>  		goto err;
> =20
> +	if (change =3D=3D KVM_MR_CREATE && (new->flags & KVM_MEM_GUEST_MEMFD)) {
> +		r =3D kvm_gmem_bind(kvm, new, gmem_fd, gmem_offset);

[Severity: High]
Does this new initialization order break guest_memfd creation on arm64?

By moving the kvm_gmem_bind() call to execute after kvm_prepare_memory_regi=
on(),
the KVM_MEMSLOT_GMEM_ONLY flag is not populated in time for the architecture
specific hooks.

In virt/kvm/guest_memfd.c:kvm_gmem_bind(), the flag is assigned:

    if (kvm_gmem_supports_mmap(inode))
        slot->flags |=3D KVM_MEMSLOT_GMEM_ONLY;

Because kvm_prepare_memory_region() now runs before this assignment, the
architecture hook in arch/arm64/kvm/mmu.c:kvm_arch_prepare_memory_region()
evaluates the flag before it is set:

    if (kvm_slot_has_gmem(new) && !kvm_memslot_is_gmem_only(new))
        return -EINVAL;

Will this cause all userspace attempts to create a guest_memfd memslot via
KVM_SET_USER_MEMORY_REGION2 on arm64 to unconditionally fail with -EINVAL?

> +		if (r) {
> +			kvm_arch_free_memslot(kvm, new);
> +			kvm_destroy_dirty_bitmap(new);
> +			goto err;
> +		}
> +	}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210616.1024=
168-1-seanjc@google.com?part=3D4

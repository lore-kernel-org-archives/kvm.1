Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1AD42CAFC
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332036; cv=none; b=Wd7VWD0aZ34hQnhZwimz90ntofCK0kzLOlJSqU2qYbIAca8f1GC2C7eQ4f0mTuvCgTD0r1OHjqPKyhFUcHcH8fju3zepkWv3NvajTFRUReNjNXVxWhwnNtzAbOMrp/ESw6eI70vcp5SwMKQrLCK69BjFv0K/9SAe+YW6T1Yq3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332036; c=relaxed/simple;
	bh=eLXaZticS6cfIqzV3iiIcpLNzKxdxKFS4bSTmcEXZmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=raPSnyXrYROBaHGxAy3VLMGANkZEfBD6W0kloAPQvx7Yv/ak12kJLapX8gDnvMijwVPcQaCIEqHxSnnjVMnQ+PCD6cC4ClmTUaTMnpO4kzlC/BoXRW3Y1LUKo5v4rfwv6+BCL8VEGgrlGmocLq/I0asByaD7Bf7hzKpGnIiuFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nX9fe6RW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nX9fe6RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A8B1F000E9;
	Mon,  6 Jul 2026 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332034;
	bh=QOoTAirduMZ+QOkSmhJeLVwiCBb93rsTplbfZCZ9908=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nX9fe6RWPI8Njwxz7404bMlDCYdBjJGU39xf0h4Px1DMGnlfqW3BB+9gSV+B24ffE
	 yIEIo4lhe6kJAytt1W95p9dOmE7m9YsAJxsJRI7ym/fBHpeSSKGGbotfEvGXAvXmqA
	 xIpulmG4MpT+YpxgX3unGuoPP7URFzG/TC31PCMPBOig/cr/PhTx2wQ75UgCkdG+dA
	 g3sQl+uF2BAUwL8wrdGSYgxzHQQcxiQulJcBX1/5JYvaR0NblrEwDF4lPrvhQOQNcy
	 qUM+EEh+qiEarsh1qKLFCAB16Dq7qPOq1CGIQ1tWLp5xIHZ5UiwkN4cHhRRXHobhae
	 6cZRWCd2mfHaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: x86: Reject user memory regions covering the
 APIC base
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tim Wiederhake" <twiederh@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706092021.3625908-6-twiederh@redhat.com>
References: <20260706092021.3625908-2-twiederh@redhat.com>
 <20260706092021.3625908-6-twiederh@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:00:33 +0000
Message-Id: <20260706100034.86A8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added APIC base memslot check unconditionally rejects KV=
M's internal APIC access page, breaking VMX vCPU creation and triggering a =
guaranteed VMA leak.

Pre-existing issues:
- [High] Preexisting Use-After-Free in KVM_CREATE_IRQCHIP due to lockless r=
ead of the memslots array.
--

commit 75a39a0e2b5c8384d4f938fb4214b675289701b6
Author: Tim Wiederhake <twiederh@redhat.com>

KVM: x86: Reject user memory regions covering the APIC base

This commit adds an explicit check in kvm_arch_prepare_memory_region()
to reject user space attempts to map guest memory covering the default
APIC base address when an in-kernel irqchip is in use.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cb7f759a7b21e..f7f2bd4d8b334 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c

[ ... ]

> @@ -10129,12 +10129,19 @@ int kvm_arch_prepare_memory_region(struct kvm *=
kvm,
>  		return -EINVAL;
> =20
>  	if (change =3D=3D KVM_MR_CREATE || change =3D=3D KVM_MR_MOVE) {
> +		const gfn_t apic_gfn =3D gpa_to_gfn(APIC_DEFAULT_PHYS_BASE);
> +
>  		if ((new->base_gfn + new->npages - 1) > kvm_mmu_max_gfn())
>  			return -EINVAL;
> =20
>  		if (kvm_is_gfn_alias(kvm, new->base_gfn + new->npages - 1))
>  			return -EINVAL;
> =20
> +		if (irqchip_in_kernel(kvm) &&
> +		    new->base_gfn <=3D apic_gfn &&
> +		    apic_gfn < new->base_gfn + new->npages)
> +			return -EEXIST;

[Severity: High]
Could this check inadvertently catch KVM's own internal memslot allocations,
such as APIC_ACCESS_PAGE_PRIVATE_MEMSLOT?

When kvm_alloc_apic_access_page() attempts to allocate the internal memslot
exactly at APIC_DEFAULT_PHYS_BASE, it appears this new check will intercept
it and return -EEXIST, which would break vCPU creation.

Furthermore, if this returns -EEXIST during an internal memslot allocation,
could it cause a VMA memory leak?

Looking at __x86_set_memory_region() in arch/x86/kvm/x86.c:

	hva =3D vm_mmap(NULL, 0, size, PROT_READ | PROT_WRITE,
		      MAP_SHARED | MAP_ANONYMOUS, 0);
	...
	for (i =3D 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
		...
		r =3D kvm_set_internal_memslot(kvm, &m);
		if (r < 0)
			return ERR_PTR_USR(r);
	}

If kvm_set_internal_memslot() fails here because the new check returns
-EEXIST, the error path returns immediately without calling vm_munmap()
to clean up the VMA allocated earlier.

> +
>  		return kvm_alloc_memslot_metadata(kvm, new);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but while looking at the APIC
base and irqchip code, I noticed a potential use-after-free when
KVM_CREATE_IRQCHIP accesses the memslots array.

Looking at kvm_arch_vm_ioctl() in arch/x86/kvm/x86.c:

	case KVM_CREATE_IRQCHIP: {
		mutex_lock(&kvm->lock);
		...
		r =3D -EEXIST;
		if (gfn_to_memslot(kvm, gpa_to_gfn(APIC_DEFAULT_PHYS_BASE)))
			goto create_irqchip_unlock;

Is it safe to call gfn_to_memslot() here outside of any SRCU read-side
critical section and without holding kvm->slots_lock?

A concurrent thread executing KVM_SET_USER_MEMORY_REGION (which holds
kvm->slots_lock but not kvm->lock) could install a new memslots array, issue
synchronize_srcu(), and free the old memslots array while KVM_CREATE_IRQCHIP
is still traversing it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706092021.3625=
908-2-twiederh@redhat.com?part=3D4

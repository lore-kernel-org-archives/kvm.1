Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059BE33ADA8
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935178; cv=none; b=NUsOZZrrzzIGVlTd/wfVuqeHgknBISRfYsnHcFh1UiJbLnN0CVuQOvya6YLAVNmtdIrASLnF+cnB0+b35XMk1IzMb1WVRlM+X1BAGulhRdJcoo/hSMrx6dRUfjW5HN2N1N906Ao+/LFvfM2Ta0VUcqQNM82E+/M/2N0jNq/8Vug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935178; c=relaxed/simple;
	bh=qybFSxd0rESnMX8pu3sLJ/KL8huWQi8eTFgr5jt4elQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GDQwcO39zFiJcwCXkV3gxKDFWkvq7Uoqnt+fiv+q1Z/3ip5y2wJPgMb6ryIpjONMDnAMDcHzhAWmv6kQfPkeECIuRRmGi6Ld6yaPdfcYh0nyezBeWyR9myePgfXj1S1FUybiuRDqzHyxyeNChsRlI8Ep8FRxlWHBua798OvNjWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PyK3Rdev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PyK3Rdev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909CA1F00893;
	Mon,  8 Jun 2026 16:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935175;
	bh=vAD9JaNBsKnpeKlTIHU2uryh19UuZVBDpAHfHZ1Aa/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PyK3Rdev+vnG2wdVFYCSXVYXwY53gY7xobOgiUBhnN6L/W0OLHXFvcEtNWa7OS3p0
	 JKCdyA0G74hKlFaliltKYysUMbDKjMggN2eleeIXfIR10CgNLEKSEWYRjzCC3bZGMz
	 rL9MhDqxWD9IVuclZWxtYuYyXT2Hhfk48zYyvYQAMA540juK7EmLxqo0Zw7K7MWlWB
	 ujoRn/rNYHt2bbbTrnkFhj9EoHmVbKQTAhZVCny14Efpyix5RFWNbCP2LqdeeLHPaT
	 IE0OftSikmpcnODysDbS3kQau+7bPxMjHINEPcXjSNVC4VD1khp9La4jichSrfMpJk
	 wAstHibS0eP+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/60] kvm: Move VCPU locking to struct kvm_vcpu_common
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-18-joro@8bytes.org>
References: <20260608144252.351443-18-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:12:55 +0000
Message-Id: <20260608161255.909CA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Interrupt handlers for KVM arch timers and VGIC maintenance de=
reference `common->current_vcpu` before verifying if `common` is `NULL`, ca=
using a host kernel panic.
- [High] TOCTOU race in KVM_CREATE_VCPU allows userspace to bypass kvm->max=
_vcpus limit by moving `kvm->created_vcpus` increment out of the `kvm->lock=
` critical section.
- [High] Assigning `vcpu->vcpu_idx` locklessly in `kvm_vcpu_init_common()` =
allows concurrent vCPU creations to evaluate the same index, causing a `-EB=
USY` error in `xa_insert()` and triggering a host DoS via `WARN_ON_ONCE()`.
--

commit 67b86047d814218cd13d6ae4125264614146e77c
Author: Joerg Roedel <joerg.roedel@amd.com>

kvm: Move VCPU locking to struct kvm_vcpu_common

Fields in struct kvm_vcpu which are protected by these locks is going
to move to struct kvm_vcpu_common. So move the locks as well.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 611bba515ac07..c8085c23e18e8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -330,6 +330,13 @@ struct kvm_vcpu_common {
>  	/* Currently active VCPU */
>  	struct kvm_vcpu *current_vcpu;

[Severity: Critical]
This isn't a bug introduced by this patch, but from an earlier patch
in this series. Does this cause a crash?

In the arm64 timer and VGIC interrupt handlers, common is dereferenced
to retrieve current_vcpu before checking if common itself is NULL:

arch/arm64/kvm/arch_timer.c:kvm_arch_timer_handler() {
    struct kvm_vcpu_common *common =3D *(struct kvm_vcpu_common **)dev_id;
    struct kvm_vcpu *vcpu =3D common->current_vcpu;
    ...
}

arch/arm64/kvm/vgic/vgic-init.c:vgic_maintenance_handler() {
    struct kvm_vcpu_common *common =3D *(struct kvm_vcpu_common **)data;
    struct kvm_vcpu *vcpu =3D common->current_vcpu;
    ...
}

Since kvm_running_vcpu is cleared during vcpu_put() and kvm_sched_out(),
an interrupt firing shortly after could observe a NULL common pointer.

Would this lead to a crash when common->current_vcpu is dereferenced?

[ ... ]
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 009adede51ba6..84ac6792a2227 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -466,6 +466,8 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu=
, struct kvm *kvm, unsigned
> =20
>  	common->vcpu_idx =3D atomic_read(&kvm->online_vcpus);

[Severity: High]
This isn't a bug introduced by this patch, but from an earlier patch
in this series. Is there a race condition here?

In kvm_vm_ioctl_create_vcpu(), the maximum vCPU limit is checked under
kvm->lock, but the lock is then dropped:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
    ...
    if (kvm->created_vcpus >=3D kvm->max_vcpus) {
        mutex_unlock(&kvm->lock);
        return -EINVAL;
    }
    ...
}

Later, in kvm_vcpu_init_common(), the kvm->created_vcpus increment happens
under a newly acquired lock:

virt/kvm/kvm_main.c:kvm_vcpu_init_common() {
    ...
    mutex_lock(&kvm->lock);
    kvm->created_vcpus++;
    mutex_unlock(&kvm->lock);
    ...
}

Because the lock is dropped between the check and the increment, concurrent
vCPU creations can pass the limit check simultaneously.=20

Can this allow an unbounded number of vCPUs to be created, bypassing capaci=
ty
constraints and potentially causing a host-side denial of service?

[Severity: High]
This is also a pre-existing issue, but could this lockless assignment cause
a denial of service?

Because common->vcpu_idx =3D atomic_read(&kvm->online_vcpus); is assigned
without holding a lock, concurrent creations can evaluate the same index.

They later serialize on kvm->lock before insertion:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
    ...
    r =3D xa_insert(&kvm->planes[0]->vcpu_array, vcpu->vcpu_idx, vcpu,
                  GFP_KERNEL_ACCOUNT);
    WARN_ON_ONCE(r =3D=3D -EBUSY);
    ...
}

Will the second thread attempt to insert at the already-occupied index, fail
with -EBUSY, and unexpectedly trigger the WARN_ON_ONCE()?=20

As this is reachable by unprivileged userspace, could this crash the host if
panic_on_warn is set?

> =20
> +	mutex_init(&common->mutex);
> +
>  	common->kvm =3D kvm;
>  	common->current_vcpu =3D vcpu;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D17

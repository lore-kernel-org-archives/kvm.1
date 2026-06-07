Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9122370A
	for <kvm@vger.kernel.org>; Sun,  7 Jun 2026 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855696; cv=none; b=hH4HpIBI4Y27N4a02LyQIRLyrBjLjMJ3MZxz9awIJgZ+/pBj6LQ3L58eJQZmT9u774oRMPhQWsGeDMotgDgD12uqwCMydnv2N3dX67x0HfsKIAAP/obTGWZqZUmKpAWqcCVVU5uwAFBaTiBQ1Kz04kJt2Vo7WV6Wf/UNDIpKDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855696; c=relaxed/simple;
	bh=O8eCoetuVwDwmef9Kb7N6RpcqXZBxo7WGWr+qjEhYP8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cjL0om+QlvKUCboVthnMa6hhqObK5eAOlfKl/ZSeM27wVKUCwJQKBEaN7U2eoBNvxdRR0/7DRux2nMryfaaafM2/Ad7RedyYMrPZ7ysXwN+RBDZkWuWCEdYWxHVAbdN7v28T/VmxeKK2ieBpH2gYwGqw3SmRWsUfDdS4lsXlnuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdrEUT3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdrEUT3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FBC1F00893;
	Sun,  7 Jun 2026 18:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780855695;
	bh=JpIgeYMPG/mzMTlguUOHjy+bt5AD9Ahxt6BlFXMVP1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdrEUT3GjeQhF+AQTZ+hWO9srSbcfjrCiCn6lZyy9JYPK3A0BzJ0PyBYjeMPEqkHl
	 4zMlNnS/khV53Qmynrd6STGlSHJdCsPqRTJCfpkOLpHC0x3p6Bb12lBFvOoH6pcCJr
	 NhjPU3xams8iyu+W34HuIjV6BrC736SBVmqp+Pu13YTQHf2Lv5pF0R9Eb/mbOQQG18
	 E8S72W63qAGF3V7bqYEyuIwwAoHojfkEwCMq5CY91yW2lRAp7RKkyE55k8BaEW34py
	 doOp8XMUzIaKQrlUp9A2dF4FjcKLLxpKqDAOu494drRNFK+YEXeVpx1tmB4IYrIRav
	 O4vkWkKFfp06A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: arm64: Add kvm_for_each_vncr_tlb() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Zyngier" <maz@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260607175745.297793-1-maz@kernel.org>
References: <20260607175745.297793-1-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 18:08:15 +0000
Message-Id: <20260607180815.85FBC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The `kvm_for_each_vncr_tlb` macro introduces an unbraced `if` state=
ment, exposing callers to a dangling `else` vulnerability.

Pre-existing issues:
- [High] Concurrent lockless publication and observation of `vcpu->arch.vnc=
r_tlb` lacks memory barriers and `READ_ONCE()`, risking uninitialized memor=
y access.
- [High] Unconditional allocation in `kvm_vcpu_allocate_vncr_tlb` leaks mem=
ory if `kvm_arch_vcpu_run_pid_change` is restarted.
--

commit 03a7f368fcb61f7b51d0623ed1c15d57166b377e
Author: Marc Zyngier <maz@kernel.org>
Subject: KVM: arm64: Add kvm_for_each_vncr_tlb() helper

This commit introduces a new helper macro kvm_for_each_vncr_tlb() to=20
iterate over vCPUs that have a valid vncr_tlb allocated. It then
converts kvm_invalidate_vncr_ipa() and invalidate_vncr_va() to use
this new iterator.

Link: https://lore.kernel.org/r/aiUvSbrWndQeUPc8@v4bel

> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index 883b6c1008fbb..e25d7289aa9e5 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -897,9 +897,21 @@ static void invalidate_vncr(struct vncr_tlb *vt)
>  		clear_fixmap(vncr_fixmap(vt->cpu));
>  }
> =20
> +/*
> + * VNCR TLB invalidation occurs from MMU notifiers or TLBI instructions,=
 and
> + * either can race against a vcpu not being onlined yet (no pseudo-TLB
> + * allocated). Similarly, the TLB might be invalid.  Skip those, as they
> + * obviously don't participate in the invalidation at this stage.
> + */
> +#define kvm_for_each_vncr_tlb(idx, vcpup, tlbp, kvm)	\
> +	kvm_for_each_vcpu(idx, vcpup, kvm)		\
> +		if (((tlbp) =3D vcpup->arch.vncr_tlb) &&	\
> +		    (tlbp)->valid)

[Severity: High]
This isn't a bug introduced by this patch, but can we read uninitialized
memory here due to a missing memory barrier?

When vcpu->arch.vncr_tlb is allocated in kvm_vcpu_allocate_vncr_tlb(),
it is assigned via a plain store without smp_store_release(), and not
under kvm->mmu_lock.

Concurrently, the MMU notifier path (which holds kvm->mmu_lock) iterates
over vCPUs and reads this pointer locklessly using a plain load here without
READ_ONCE() or smp_load_acquire().=20

On weakly-ordered architectures, could the observing CPU see a non-NULL
pointer before the zero-initialization of kzalloc_obj() is visible?

If so, tlbp->valid could be evaluated using uninitialized memory.
If it evaluates to true, invalidate_vncr() could read garbage from
vt->cpu and trigger the BUG_ON() in vncr_fixmap(), causing a host panic.

[Severity: High]
This is a pre-existing issue, but does kvm_vcpu_allocate_vncr_tlb() leak
memory if KVM_RUN is restarted?

In kvm_arch_vcpu_run_pid_change(), kvm_vcpu_allocate_vncr_tlb() is
called during the first KVM_RUN and unconditionally allocates the pointer
with kzalloc_obj().

If subsequent initialization steps in kvm_arch_vcpu_run_pid_change() fail
(like kvm_timer_enable()), it returns an error to userspace without
marking the vCPU as having run.

If userspace repeatedly invokes the KVM_RUN ioctl after a failure,
could kvm_vcpu_allocate_vncr_tlb() be executed again, overwriting the
previous vncr_tlb allocation without freeing it and leaking memory?

[Severity: Low]
Does the unbraced if in this macro expose callers to a dangling else
vulnerability?

While current usages are safely enclosed in braces, if a future caller uses
this macro inside an unbraced if block and attempts to attach an else,
the compiler could incorrectly bind it to this hidden internal if.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607175745.2977=
93-1-maz@kernel.org?part=3D1

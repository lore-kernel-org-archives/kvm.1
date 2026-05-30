Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9F30EF77
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 06:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780121974; cv=none; b=bI8SKJuQOMuhEV07Kx7Drwzi2e9i+q2rHSK5wm5+pf+izfW3LnAxJhw8J3eTkUwAR7huRwU4jMiVaHUvY9WlD/+Kg0UjTEJtuhEnznpTiOr+8RGrbrQxxH61JyR5haJjxbIUmPgGl6l+l7/h/aLb7JN47El2Dedq5RJu47VWARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780121974; c=relaxed/simple;
	bh=n5g09V5SUqy+D8YFLmVHfLInzGYfYa26rwfutdSskTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QeWOmroJxvTxHR+6JzoujDdIEL3wjMWWpBau0mvP7L0M9UGRK5v82fI00KwEQqg55flaoTPImM8/P9EZF+T4n/k78FXzsluBR23O/a8rIINU2mWJFeHL2CBqaCG5x9iP/LgYItMOnHIK7gU3I12SlEWyjV00dj6m8Db85oamvzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEOGFNmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEOGFNmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7849D1F00893;
	Sat, 30 May 2026 06:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780121972;
	bh=+Cf+TDxOIwqCXGb1Tk7Dev9mDMCLt744ST/zGK+Ruhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEOGFNmYbrX3TZVmVkdlfYrhLPuPPu4Y1+RqnIrHqXEBPymXMkEAgZmk08mINfImT
	 Pfw7ezOXZRrNLAiQjFHHGY5gjHZKV18FKvsAgrTC752IF0mbllTb7K4DmKahUlHGsM
	 iACQi/lWOcH8wGM9T44zHTpr5CgLjBMfymXyeZh3KgbwRvWtd66af8gImQj61Wf+pw
	 wc+J7DTrFmWEyUB3lwLPvtLZWXpFoTdgVmrU5i6RO6qkMIqyT59rSu09lK05T0yvX+
	 FjZfsS6wHOSPIh48Wy87w5rX916OTBD9MaYQh1O+3tXaO166whbsb4n7chEK8f0Dvc
	 G2WdojLf+S8AA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/20] KVM: x86: Use gfn_to_pfn_cache for
 record_steal_time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529165114.748639-21-seanjc@google.com>
References: <20260529165114.748639-21-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 06:19:32 +0000
Message-Id: <20260530061932.7849D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling sleepable operations while holding an rwlock (gpc->lock) i=
n record_steal_time() causes 'scheduling while atomic' bugs.
- [High] Calling read_unlock() on an RT rwlock from sched_out() triggers wa=
ke_up_process() while rq->lock is held, causing an ABBA deadlock.
--

commit cb799f9970f13f02eaea4c9d6c87fa7537434bcf
Author: Carsten Stollmaier <stollmc@amazon.com>
KVM: x86: Use gfn_to_pfn_cache for record_steal_time

This commit reverts to using the gfn_to_pfn_cache for guest steal time and
preempted status updates to avoid mmap_lock contention with userfaultfd. It
replaces unsafe_put_user accesses with plain C reads and writes. It also
uses a read_trylock in the scheduler path to avoid sleeping under PREEMPT_R=
T.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3746,42 +3744,20 @@ static void record_steal_time(struct kvm_vcpu *vc=
pu)
[ ... ]
> +	CLASS(gpc_map_local, st_map)(gpc, sizeof(*st));
> +	if (IS_ERR(st_map))
> +		return;
> =20
> -	st =3D (struct kvm_steal_time __user *)ghc->hva;
>  	/*
>  	 * Doing a TLB flush here, on the guest's behalf, can avoid
>  	 * expensive IPIs.
>  	 */
>  	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
[ ... ]
> +		u8 st_preempted =3D xchg(&st->preempted, 0);
> =20
>  		vcpu->arch.st.preempted =3D 0;
> =20
> @@ -3789,39 +3765,30 @@ static void record_steal_time(struct kvm_vcpu *vc=
pu)
>  				       st_preempted & KVM_VCPU_FLUSH_TLB);
>  		if (st_preempted & KVM_VCPU_FLUSH_TLB)
>  			kvm_vcpu_flush_tlb_guest(vcpu);

[Severity: High]
Does this introduce a scheduling while atomic bug on non-PREEMPT_RT kernels?

The CLASS(gpc_map_local, st_map) macro acquires a read_lock on gpc->lock,
which disables preemption. While this lock is held, if the guest supports
PV TLB flush, the code calls kvm_vcpu_flush_tlb_guest().

If TDP is disabled (shadow paging), kvm_vcpu_flush_tlb_guest() calls
kvm_mmu_sync_roots() and eventually mmu_sync_children(). This path can yield
via cond_resched_rwlock_write(). Yielding while preemption is disabled by
the gpc read lock will trigger a BUG.

The old code safely dropped the user access guard before executing the
TLB flush, avoiding this issue.

[ ... ]
> @@ -5260,20 +5227,32 @@ static void kvm_steal_time_set_preempted(struct k=
vm_vcpu *vcpu)
[ ... ]
> -	st =3D (struct kvm_steal_time __user *)ghc->hva;
> -	BUILD_BUG_ON(sizeof(st->preempted) !=3D sizeof(preempted));
> -
> -	if (!copy_to_user_nofault(&st->preempted, &preempted, sizeof(preempted)=
))
> -		vcpu->arch.st.preempted =3D KVM_VCPU_PREEMPTED;
> +	/*
> +	 * Use a trylock as this is called from the scheduler path (via
> +	 * kvm_sched_out), where rwlock_t is not safe on PREEMPT_RT (it
> +	 * becomes sleepable).  Setting preempted is best-effort anyway;
> +	 * the old HVA-based code used copy_to_user_nofault() which could
> +	 * also silently fail.
> +	 *
> +	 * Since we only trylock and bail on failure, there is no risk of
> +	 * deadlock with an interrupt handler, so no need to disable
> +	 * interrupts.
> +	 */
> +	CLASS(gpc_try_map_local, st_map)(gpc, sizeof(st->preempted));
> +	if (IS_ERR(st_map))
>  		return;
> =20
> -	mark_page_dirty_in_slot(vcpu->kvm, ghc->memslot, gpa_to_gfn(ghc->gpa));
> +	st =3D *st_map;
> +	WRITE_ONCE(st->preempted, KVM_VCPU_PREEMPTED);
> +	vcpu->arch.st.preempted =3D KVM_VCPU_PREEMPTED;
> +}

[Severity: High]
Can this cause an ABBA deadlock in the scheduler on PREEMPT_RT?

kvm_steal_time_set_preempted() is called during a vCPU context switch
via kvm_sched_out(), which is a preempt notifier hook. This runs with
the local CPUs runqueue lock (rq->lock) held.

While the code correctly uses a trylock to avoid sleeping when acquiring
the lock, the CLASS macro destructor will implicitly call read_unlock()
at the end of the function. On PREEMPT_RT kernels, unlocking an rt_rwlock
can wake up a waiting writer, such as a concurrent kvm_gpc_refresh().

If a writer is woken, rt_mutex_wake_up_q() calls wake_up_process(), which
attempts to acquire the target tasks rq->lock via try_to_wake_up().
Attempting to acquire a runqueue lock while the local CPUs rq->lock is
already held violates scheduler lock ordering and leads to a deadlock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529165114.7486=
39-1-seanjc@google.com?part=3D20

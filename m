Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A2D3E315C;
	Sun, 20 Sep 2026 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941351; cv=none; b=bGOxsTptkhoWkMQJDzn7rcedcWzqBhis3aIwfJvk7/wo8j2zxw9U3ILIA3IpZqFun3F1otMCF59sVPU1p+1GMPWuin3Um7e8jrcAlPGvYG2tkyCmXF9ugEONstd5XBXnHRi9H668eBvHmG5BU/2oOYMhXlgmlK4OAD9yXcOdliE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941351; c=relaxed/simple;
	bh=U+4HRlc0Ez5ZnCYK9vcEfVaMoVNqeHjCN4Uao8rqg5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pdY7CQSKtPaCi624XkNFBV6CiY1VldL2k8ow3aSfc9ZAG/nEpbjgChGwUeigOk5yLSzLsyUMDX0EgDucBUNGq+KiT+aNoqCmvLk7+TJ4A2ntgUyAQTrFCvdENHWO4Z9yFzqgJj6iLvkPOMCmliJ2PV4qAuJpoJayNopZiROj/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6QFVxMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6QFVxMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475D31F000FF;
	Sun, 20 Sep 2026 21:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941342;
	bh=jHc7kUr7nKxBFuF97msF0xIWaU7+c82xHl9mlbzIZHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6QFVxMotwdSdaDIB81v71cg5r1ToWMM2zpa+6vwaz9ljI+yVDVnaV0Rre13CQh2C
	 2AmOcZnJPNM+h+f+qelK8b0/lQ6EwwxbbYa1vUv7sBjMi5WUTN7MtQlNIN69qJQio5
	 jhhEGQC3GQnBqDsRsAr29EyjBDRdxJwTIl/U21j1AVqD4qFLdkkDA2pe/6TozUmw/+
	 S+xL0sqnUnA6IlSDRayDoU9QpzKkjsC6i7p4aKY8Him4UGLN+DKt+Rd3LgpCRhqbhp
	 0X0yHlihNCi4qbrI7sjgsbSmcA+euE6+6+p6ya6sO6DYlvKyJwXER0CBfDyz8E/aU0
	 P4c+7hB7reZeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers
 instead of a rwlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260920211920.928306-2-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-2-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:55:41 +0000
Message-Id: <20260920215542.475D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] kvm: concurrent MMU notifiers skip SRCU wait causing Use-After=
-Free
- [High] kvm: mmu_notifier_invalidate_range_start unconditionally sleeps, b=
reaking OOM reaper
- [Low] kvm: compilation failure due to fabricated atomic SRCU API
--

commit 47eed0ef4a708a1117920edb2f9b64f3a7b2a8d4
Author: David Woodhouse <dwmw@amazon.co.uk>
KVM: pfncache: Use atomic SRCU for readers instead of a rwlock

This commit replaces the per-cache rwlock with a dedicated per-VM atomic
SRCU domain (kvm->gpc_srcu) for the read side in the KVM pfncache. Readers
now run under an atomic SRCU read lock, allowing them to execute in hardirq
and sched-out paths without spinning or failing.

Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D208f7f3e5f59c11aeb90
Reported-by: syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D919877893c9d28162dc2

> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -635,6 +635,13 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
>  DECLARE_LOCK_GUARD_1_ATTRS(srcu, __acquires_shared(_T), __releases_share=
d(*(struct srcu_struct **)_T))
>  #define class_srcu_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu, _T)
> =20
> +DEFINE_LOCK_GUARD_1(srcu_atomic, struct srcu_struct,
> +		    _T->idx =3D srcu_read_lock_atomic(_T->lock),
> +		    srcu_read_unlock_atomic(_T->lock, _T->idx),
> +		    int idx)
> +DECLARE_LOCK_GUARD_1_ATTRS(srcu_atomic, __acquires_shared(_T), __release=
s_shared(*(struct srcu_struct **)_T))

[Severity: Low]
Does this code rely on a fabricated atomic SRCU API?=20

The functions srcu_read_lock_atomic() and srcu_read_unlock_atomic() do not
exist in the Linux kernel tree, which will cause a build failure when
compiling.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1152,6 +1152,8 @@ static struct kvm *kvm_create_vm(unsigned long type=
, const char *fdname)
>  		goto out_err_no_srcu;
>  	if (init_srcu_struct(&kvm->irq_srcu))
>  		goto out_err_no_irq_srcu;
> +	if (init_srcu_struct_atomic(&kvm->gpc_srcu))
> +		goto out_err_no_gpc_srcu;

[Severity: Low]
Is init_srcu_struct_atomic() a valid function?=20

Using a non-existent API here will also result in a compilation error.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1719,18 +1719,18 @@ static void kvm_setup_guest_pvclock(struct pvcloc=
k_vcpu_time_info *ref_hv_clock,
>  {
>  	struct pvclock_vcpu_time_info *guest_hv_clock;
>  	struct pvclock_vcpu_time_info hv_clock;
> -	unsigned long flags;
> +	int idx;
> =20
>  	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
> =20
> -	read_lock_irqsave(&gpc->lock, flags);
> +	idx =3D srcu_read_lock_atomic(&vcpu->kvm->gpc_srcu);

[Severity: Low]
Could this use of srcu_read_lock_atomic() break the build since the function
does not exist?

> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -26,35 +26,115 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *k=
vm, unsigned long start,

[ ... ]

>  		unsigned long gpc_uhva;
>  		int old, new;
> =20
> -		read_lock_irq(&gpc->lock);
> +		old =3D atomic_read_acquire(&gpc->state);
> +		if (!(old & (GPC_VALID | GPC_BECOMING_VALID)))
> +			continue;

[Severity: Critical]
Can this condition cause a use-after-free when concurrent MMU notifiers run?

If Thread A clears GPC_VALID (setting GPC_INVALIDATING), drops gpc_lock, and
blocks in synchronize_srcu_expedited(), a concurrent Thread B could read
gpc->state as GPC_INVALIDATING.=20

Thread B would hit this check, skip the cache, and return immediately witho=
ut
waiting for its own grace period.=20

The core MM could then free the physical page while Thread A is still waiti=
ng
for KVM readers that are actively dereferencing the freed page.

[ ... ]

> +	 * (The one allocation in the SRCU grace-period machinery itself =E2=80=
=94
> +	 * the srcu_node tree on the one-time upgrade of a contended
> +	 * srcu_struct =E2=80=94 is dealt with separately, by having srcu_gp_en=
d()
> +	 * allocate with GFP_NOWAIT and fall back to a preallocated spare,
> +	 * so the grace period never blocks in reclaim either.)
> +	 */
> +	if (cleared)
> +		synchronize_srcu_expedited(&kvm->gpc_srcu);
> +
> +	/*

[Severity: High]
Does this code unconditionally sleep inside an MMU notifier callback?

The OOM reaper sets range->may_block to false and must not be blocked. Call=
ing
synchronize_srcu_expedited() here violates that constraint and could lead to
deadlocks if the OOM reaper blocks on resources held by the dying process.

[ ... ]

> +	 * GPC_VALID precisely so that this path knows those readers may
> +	 * exist. Our own grace-period wait below necessarily begins after
> +	 * that clear, so waiting here covers them; only then may
> +	 * reader-visible fields (uhva, gpa, memslot, and later pfn/khva) be
> +	 * mutated or the old mapping torn down.
> +	 */
> +	must_drain =3D atomic_xchg(&gpc->state, 0) &
> +		     (GPC_VALID | GPC_INVALIDATING);
> +	if (must_drain)
> +		synchronize_srcu_expedited(&gpc->kvm->gpc_srcu);
> =20
>  	old_pfn =3D gpc->pfn;

[Severity: High]
Are we using a sleeping synchronization function in the mutator path?

This appears to contradict the commit message's claim that readers are wait=
ed
on by a spinning atomic domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D1

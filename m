Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839DF3D7D6A
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962170; cv=none; b=IPBmNgEbTAj3NFJ4psFq2c3rQNxwP9RSUefogaBRBVE962yNUvIdlPAcyFQ2KR1gM+y9J/D+RMnOsb+QfoGJAZ75qFLuxvv24LJEuyjoxUSTkoWdNfW3rLfLIqdeASk4d63M1LyUOyYQILmui5xRpgYE4iDEopSpt9p8UfOl784=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962170; c=relaxed/simple;
	bh=JY3Hgb2S7M3T/126dp7l2+xiRNbX3t6X6K7vU3zN8BY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QxXdG7HsyrgvITGb3+XHuofz9aHJnBYzDXbSdICrqCZhwvLhR8K/GLUqxnUmZpIJ9y4XGaBAnamacwelnLPD+EtOeEbmDXHapCH+YH4iGMaxOQgNloNYhgo2hgJLJaXZUQjr/xO9DCaFpv6/sPdv0yJfUR3kIxz8Q0uUimMt1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxlt17z2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxlt17z2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CA61F000E9;
	Wed,  5 Aug 2026 20:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785962169;
	bh=Qg02DuZrHRBXwxPV0KQDPTGQ1mQl4Iyp2hKtHnLLe80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xxlt17z28hoo2l5M7z8vivTN7MSAAg9CJhvjbkz005xqewphsWvFmn6QGsax6DCW7
	 H8dx+PHDX+3MwTU6SbEZW5yFEnKdz8ZhoYgKLgv7uaLzzEKZGF8EESccaNkGLnSU8y
	 gHkJZt6++ZK9W9hkkXdfPbSzQ1WkXv1+43npla/zsiHFNBqOZNhT6CLBtLIMQeVV6Q
	 sfgwrLAeeJlubHDuHd/GF9A5f3JUJZJGb046gb13H8SxhpPKksTvnRU+Y0j4Op9EPG
	 0pwRkarq40m4XChyGLqPpzYXdT19PFwG2WsBf0aeHIrWwYQuzs4cDObQ5G5ZLn2iHH
	 YTFLv+4kxbqHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of a
 rwlock
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?V29vZGhvdXNlLCBEYXZpZA==?= <dwmw@amazon.co.uk>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805195528.3853473-4-dwmw@amazon.co.uk>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
 <20260805195528.3853473-4-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 20:36:07 +0000
Message-Id: <20260805203608.D3CA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Time-of-check to time-of-use (TOCTOU) race in the lockless MMU=
 notifier retry protocol, leading to a Use-After-Free of physical pages.
- [Critical] Conditional execution of `synchronize_rcu()` based on `gpc->va=
lid =3D=3D false` bypasses the grace period, leading to Use-After-Free.
- [Medium] vCPU kick nested inside RCU read-side critical section, extendin=
g memory invalidation latency.
- [Medium] Data race on `gpc->generation` in `kvm_gpc_check()` due to missi=
ng `READ_ONCE()`.

Pre-existing issues:
- [Critical] Multiple callers access KVM memslot structures without holding=
 `srcu_read_lock(&kvm->srcu)`, leading to Use-After-Free of memslots and th=
eir dirty bitmaps.
--

--- Patch [3]: [PATCH v3 3/7] KVM: pfncache: Use RCU for readers instead of=
 a rwlock ---
commit c7d30d550717790c51bcbb357dd39cfdd3210219
Author: Woodhouse, David <dwmw@amazon.co.uk>

KVM: pfncache: Use RCU for readers instead of a rwlock

Replace the per-cache rwlock with RCU for the read side. Readers now
run under rcu_read_lock() alone, which works in any context.

Link: https://syzkaller.appspot.com/bug?extid=3D208f7f3e5f59c11aeb90

> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -416,20 +414,12 @@ static void kvm_xen_update_runstate_guest(struct kv=
m_vcpu *v, bool atomic)
> =20
>   retry:
>  	/*
> -	 * Attempt to obtain the GPC lock on *both* (if there are two)
> -	 * gfn_to_pfn caches that cover the region.
> +	 * Check *both* (if there are two) gfn_to_pfn caches that cover
> +	 * the region, under a single RCU read-side critical section.
>  	 */
> -	if (atomic) {
> -		local_irq_save(flags);
> -		if (!read_trylock(&gpc1->lock)) {
> -			local_irq_restore(flags);
> -			return;
> -		}
> -	} else {
> -		read_lock_irqsave(&gpc1->lock, flags);
> -	}
> +	rcu_read_lock();
>  	while (!kvm_gpc_check(gpc1, user_len1)) {
> -		read_unlock_irqrestore(&gpc1->lock, flags);
> +		rcu_read_unlock();

[Severity: Critical]
This is a pre-existing issue, but does this code need to hold
srcu_read_lock(&kvm->srcu) before accessing the KVM memslot structures?

kvm_xen_update_runstate_guest initiates the access sequence holding only
rcu_read_lock. Later, kvm_gpc_mark_dirty_in_slot dereferences gpc->memslot.

Since rcu_read_lock does not block synchronize_srcu when memslots are
deleted, could this allow a memslot to be freed concurrently while a reader
is iterating over it or marking pages dirty?

[ ... ]
> @@ -1855,10 +1826,8 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn =
*xe, struct kvm *kvm)
>  	/*
>  	 * If this port wasn't already set, and if it isn't masked, then
>  	 * we try to set the corresponding bit in the in-kernel shadow of
>  	 * evtchn_pending_sel for the target vCPU. And if *that* wasn't
>  	 * already set, then we kick the vCPU in question to write to the
>  	 * *real* evtchn_pending_sel in its own guest vcpu_info struct.
>  	 */
>  	if (test_and_set_bit(xe->port, pending_bits)) {
>  		rc =3D 0; /* It was already raised */
>  	} else if (test_bit(xe->port, mask_bits)) {
>  		rc =3D -ENOTCONN; /* Masked */
>  		kvm_xen_check_poller(vcpu, xe->port);
>  	} else {
>  		rc =3D 1; /* Delivered to the bitmap in shared_info. */
>  		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel=
 */
> -		read_unlock_irqrestore(&gpc->lock, flags);
>  		gpc =3D &vcpu->arch.xen.vcpu_info_cache;
> =20
> -		read_lock_irqsave(&gpc->lock, flags);
>  		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
>  			/*
>  			 * Could not access the vcpu_info. Set the bit in-kernel
> @@ -1892,7 +1861,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *=
xe, struct kvm *kvm)
>  	}
> =20
>   out_rcu:
> -	read_unlock_irqrestore(&gpc->lock, flags);
> +	rcu_read_unlock();
>  	srcu_read_unlock(&kvm->srcu, idx);

[Severity: Medium]
Does the fallback path for masked event channels synchronously issue a vCPU
kick while still inside the RCU read-side critical section?

In kvm_xen_set_evtchn_fast, if the port is masked, kvm_xen_check_poller is
called directly, which eventually executes kvm_vcpu_kick.

Since this path doesn't defer the kick until after out_rcu and
rcu_read_unlock, could this artificially extend the grace period and delay
host memory invalidations?

> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -26,35 +26,49 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kv=
m, unsigned long start,
>  				       unsigned long end)
>  {
>  	struct gfn_to_pfn_cache *gpc;
> +	bool cleared =3D false;
> =20
>  	spin_lock(&kvm->gpc_lock);
>  	list_for_each_entry(gpc, &kvm->gpc_list, list) {
> -		read_lock_irq(&gpc->lock);
> -
> -		/* Only a single page so no need to care about length */
> -		if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
> +		if (smp_load_acquire(&gpc->valid) &&
>  		    gpc->uhva >=3D start && gpc->uhva < end) {
> -			read_unlock_irq(&gpc->lock);
> -
> -			/*
> -			 * There is a small window here where the cache could
> -			 * be modified, and invalidation would no longer be
> -			 * necessary. Hence check again whether invalidation
> -			 * is still necessary once the write lock has been
> -			 * acquired.
> -			 */
> -
> -			write_lock_irq(&gpc->lock);
> -			if (gpc->valid && !is_error_noslot_pfn(gpc->pfn) &&
> -			    gpc->uhva >=3D start && gpc->uhva < end)
> -				gpc->valid =3D false;
> -			write_unlock_irq(&gpc->lock);
> -			continue;
> +			WRITE_ONCE(gpc->valid, false);
> +			cleared =3D true;
>  		}
> -
> -		read_unlock_irq(&gpc->lock);
>  	}
>  	spin_unlock(&kvm->gpc_lock);
> +
> +	/*
> +	 * Readers may still be using the old mapping, having sampled
> +	 * gpc->valid before it was cleared. Wait for them all to drain
> +	 * before the caller proceeds to zap the page tables; like a TLB
> +	 * shootdown, this guarantees no access via the stale mapping
> +	 * once the invalidation completes.
> +	 *
> +	 * This wait is safe even on unblockable ranges (the OOM reaper):
> +	 * the constraint there is not "no sleeping" but "no blocking on
> +	 * anything which may itself depend on memory allocation to make
> +	 * progress" (see the reasoning in commit 312364f3534c and its
> +	 * discussion). An RCU grace period has no such dependency: GPC
> +	 * readers never allocate, never take mmap_lock, and never sleep.
> +	 */
> +	if (cleared)
> +		synchronize_rcu();
>  }

[Severity: Critical]
Could this conditional wait bypass the grace period and lead to a regression
with physical pages being freed too early?

If a concurrent mutator like __kvm_gpc_refresh transitions gpc->valid to
false and is currently blocking on its own synchronize_rcu wait, the MMU
notifier will see valid as false, skip the wait since cleared is false, and
return immediately.

This would allow the host memory subsystem to free the page while the
original mutator is still waiting for active RCU readers to finish.

[ ... ]
> @@ -74,6 +88,22 @@ bool kvm_gpc_check(struct gfn_to_pfn_cache *gpc, unsig=
ned long len)
>  {
>  	struct kvm_memslots *slots =3D kvm_memslots(gpc->kvm);
> =20
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> +			 "kvm_gpc_check() without RCU read lock");
> +
> +	/*
> +	 * Check valid *first*. The acquire pairs with the release-publish
> +	 * in hva_to_pfn_retry(), so every field read below =E2=80=94 and any u=
se
> +	 * of gpc->khva by the caller =E2=80=94 is guaranteed to be from the
> +	 * published generation, not a stale value reordered from before
> +	 * the publish. The fields are then stable for the remainder of
> +	 * the RCU read-side critical section, because every mutator
> +	 * clears valid and waits a full grace period before changing
> +	 * anything.
> +	 */
> +	if (!smp_load_acquire(&gpc->valid))
> +		return false;
> +
>  	if (!gpc->active)
>  		return false;

[Severity: Medium]
Should the read of gpc->generation use READ_ONCE?

Concurrent writers in __kvm_gpc_refresh modify gpc->generation using
WRITE_ONCE. Omitting READ_ONCE here in kvm_gpc_check might theoretically
result in a torn 64-bit read on 32-bit KVM host builds, potentially matching
a bogus slots->generation and resulting in a false-positive validation of
the cache.

[ ... ]
> @@ -224,20 +242,17 @@ static kvm_pfn_t hva_to_pfn_retry(struct gfn_to_pfn=
_cache *gpc)
>  			kvm_release_page_unused(page);
>  			goto out_error;
>  		}
> -
> -		write_lock_irq(&gpc->lock);
> -
> -		/*
> -		 * Other tasks must wait for _this_ refresh to complete before
> -		 * attempting to refresh.
> -		 */
> -		WARN_ON_ONCE(gpc->valid);
>  	} while (mmu_notifier_retry_cache(gpc->kvm, gpc_seq));
> =20
> -	gpc->valid =3D true;
>  	gpc->pfn =3D new_pfn;
>  	gpc->khva =3D new_khva + offset_in_page(gpc->uhva);
> =20
> +	/*
> +	 * Publish. Pairs with the smp_load_acquire() in kvm_gpc_check();
> +	 * the pfn/khva stores above must be visible before valid is.
> +	 */
> +	smp_store_release(&gpc->valid, true);
> +
>  	/*
>  	 * Put the reference to the _new_ page.  The page is now tracked by the
>  	 * cache and can be safely migrated, swapped, etc... as the cache will

[Severity: Critical]
Is a barrier needed here to order the mmu_notifier_retry_cache check against
the publication of gpc->valid?

If the MMU notifier starts executing after the retry check but before the
valid flag is published, it could observe valid as false in
gfn_to_pfn_cache_invalidate_start and skip invalidation.

This could allow the MMU notifier to proceed to zap the page tables and the
memory subsystem to free the physical page, while this function completes
and leaves the cache marked as valid but pointing to a freed physical page.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805195528.3853=
473-1-dwmw@amazon.co.uk?part=3D3

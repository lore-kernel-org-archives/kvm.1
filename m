Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75122383C84;
	Sun, 20 Sep 2026 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789941210; cv=none; b=synZqXXQ2GvIM371tBzQ+DDP960pEIowgd7cjHPvtpACvmx4zIHTIffOx9W3o/8J4D/7fvUgvvzSsvqSFZqJchk0ecwmwLLC0yHxiS4lRc6/E/PquQ1lB7R/6b/SCVorMmBMqgF4QWcy9jKci/wdwE2w9TNofRlxJuz51eLNGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789941210; c=relaxed/simple;
	bh=NCBCS6jBI9w3PmhtjOB3Kr6HJyLRWEVwRz6QTzecFAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fo1jB2vS5UbD+fInJBfxk8jhGx1OR6bBkSndGEtEmaJeybN6C5Vag+YJxgK81SM5meQjoz4KsGYMHefMqYvAshfKpCZaUB8eBW0MTzz6uVlddsKjIPKLrn06oqPHYZrb5Mb11L2wXcG9rKBVFBOPKoVOq0rbh0XFOcsdmpljojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+t4Nrvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+t4Nrvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B701F000FF;
	Sun, 20 Sep 2026 21:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789941200;
	bh=dc/N/3lQTaqv7+9kFxPbQMmXKveSI7roSx6cdxrn228=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h+t4NrvoLMY1I0/3uU/HBfrFlvBNxmfI+35Lds/4nCLzFMXRfKww2vJCElx/4gCyw
	 iAFrUtl4fu01dYhrbzHr1Gv+7maX8dQB/7hVpZzm5H8PfN84hoIcrTC75KMjxitTAs
	 T7Eu5cKOLmQlBNUJ2K459B2FDLdsLPXE1W0wFr4PNsSmhMLjcr6cj2If3BA6OcEUfb
	 miQ9cKvVak/ceAfigX5IE34umHYnafTGbz85BSF5s6jXf7Ekw+gmkpPB6aBQ4fJfcB
	 onuSwxdZibTrskxAdlptQVwja773zcFzJZwFs/oyJaTUE41jG2bC38tWYSBHHmQk0r
	 tlIUdYyCqXjFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/17] KVM: pfncache: Add guest-mode pinning
 (GUEST_USES_PFN successor)
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260920211920.928306-8-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
 <20260920211920.928306-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 21:53:20 +0000
Message-Id: <20260920215320.84B701F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] kvm: uaf in pfncache due to bypassed vcpu kick on concurrent i=
nvalidation
- [Low] kvm: build failure due to non-existent synchronize_srcu_atomic API
--

commit f94174d271f1e35cea5e589d0bf75a4374e505a9
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
   =20
This commit reinstates support for pfn caches used directly from guest
mode. It attempts to provide guarantees that the vCPU is kicked out
of guest mode and waits when the cache is invalidated, ensuring that
a stale mapping is not used.

Link: https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com
Link: https://lore.kernel.org/all/ZQiR8IpqOZrOpzHC@google.com
Link: https://lore.kernel.org/all/agJnqh7ACEkB-ftx@google.com
Link: https://lore.kernel.org/all/20260102142429.896101-1-griffoul@gmail.com

> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 2fe50dfa3fc16..e15d9a475fed7 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c

[ ... ]

> @@ -91,10 +93,60 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kv=
m, unsigned long start,
> =20
>  			if (old & GPC_VALID)
>  				cleared =3D true;
> +
> +			/*
> +			 * If a vCPU has the pfn pinned for direct use from
> +			 * guest mode, it must be forced out of guest mode
> +			 * before the invalidation may complete. The pin bit
> +			 * was set with a cmpxchg only while GPC_VALID held,
> +			 * so this same read of 'old' cannot miss it. It is
> +			 * NOT cleared here: only the vCPU itself (on request
> +			 * service, before re-pinning) or a mutator's xchg
> +			 * (which inherits the kick duty) may clear it. A
> +			 * stale pin costs at most a spurious request bit:
> +			 * kvm_make_vcpus_request_mask() only IPIs and waits
> +			 * for targets actually in guest mode.
> +			 */
> +			if (old & GPC_GUEST_USING) {

[Severity: Critical]
Does the early skip condition in this loop fail to check for GPC_GUEST_USIN=
G?

Looking at the existing context just before this hunk in
gfn_to_pfn_cache_invalidate_start():

        old =3D atomic_read_acquire(&gpc->state);
        if (!(old & (GPC_VALID | GPC_BECOMING_VALID)))
                continue;

If Thread A clears GPC_VALID (but leaves GPC_GUEST_USING set), and
concurrently Thread B runs mmu_notifier_invalidate_range_start(), it seems
Thread B would evaluate the above condition as true, skipping the cache
entirely and ignoring the pin.

Could this allow core MM to free the physical page while the vCPU is still
running in guest mode and using the freed page in its hardware control
structures, leading to a use-after-free?

[ ... ]

> @@ -122,7 +174,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kv=
m, unsigned long start,
>  	 * so the grace period never blocks in reclaim either.)
>  	 */
>  	if (cleared)
> -		synchronize_srcu_expedited(&kvm->gpc_srcu);
> +		synchronize_srcu_atomic(&kvm->gpc_srcu);

[Severity: Low]
Is synchronize_srcu_atomic() a defined API in the kernel? It looks like
this patch replaces synchronize_srcu_expedited() with this function, but
it does not appear to exist, which could cause build failures.

[ ... ]

> @@ -498,10 +644,10 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cach=
e *gpc, gpa_t gpa, unsigned l
>  	 * reader-visible fields (uhva, gpa, memslot, and later pfn/khva) be
>  	 * mutated or the old mapping torn down.
>  	 */
> -	must_drain =3D atomic_xchg(&gpc->state, 0) &
> -		     (GPC_VALID | GPC_INVALIDATING);
> -	if (must_drain)
> -		synchronize_srcu_expedited(&gpc->kvm->gpc_srcu);
> +	old_state =3D atomic_xchg(&gpc->state, 0);
> +	gpc_kick_pinned_vcpu(gpc, old_state);

[Severity: Critical]
Does clearing the state to 0 here prematurely hide the GPC_GUEST_USING pin
from concurrent MMU notifiers?

It appears this completely wipes the pin before waiting for the vCPU. If a
concurrent invalidation occurs before the vCPU exits, it might bypass the
vCPU kick because the pin was erased, potentially exposing the same
use-after-free window.

> +	if (old_state & (GPC_VALID | GPC_INVALIDATING))
> +		synchronize_srcu_atomic(&gpc->kvm->gpc_srcu);

[Severity: Low]
As noted above, synchronize_srcu_atomic() does not appear to exist.

[ ... ]

> @@ -687,8 +836,9 @@ void kvm_gpc_deactivate(struct gfn_to_pfn_cache *gpc)
>  		 * readers outstanding =E2=80=94 it left GPC_INVALIDATING set to say
>  		 * so =E2=80=94 and the unmap below must not run under those readers.
>  		 */
> -		if (atomic_xchg(&gpc->state, 0) &
> -		    (GPC_VALID | GPC_INVALIDATING))
> +		old_state =3D atomic_xchg(&gpc->state, 0);
> +		gpc_kick_pinned_vcpu(gpc, old_state);

[Severity: Critical]
Similarly, does this zeroing of the state in kvm_gpc_deactivate() hide the
GPC_GUEST_USING pin from concurrent invalidators before the vCPU actually
exits?

> +		if (old_state & (GPC_VALID | GPC_INVALIDATING))
>  			synchronize_srcu_atomic(&kvm->gpc_srcu);

[Severity: Low]
This also uses synchronize_srcu_atomic() which does not seem to be defined.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920211920.9283=
06-1-dwmw2@infradead.org?part=3D7

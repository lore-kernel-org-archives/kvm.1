Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFAE48164E
	for <kvm@vger.kernel.org>; Wed,  5 Aug 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964533; cv=none; b=S0PC6qt9aLTOpVvJIYM7cg4xRYv++SMt7SMD5nDJVmEBBvuSyT+BJBc4mDfdY+urasRTeq9Nbo6nWFWoxsh//1j9Per/nv8EwbFsGB8YX+mMgoEDmuNb6p0qBxBI2E5JEss9sisVYtdkL76W7NkZnK0OPYxKEs7b65C7TKicANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964533; c=relaxed/simple;
	bh=ei9NCRoVCnYH4J5O5NDTTOwaFJkcnX2tsNgNHoohDAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZj5sMm9NRpzK7Kp8zzseUWL2mHTlca04vaqZKHptQxnAhVRtOUHAajHfMcwR84+wSuEZjuyo+yhJh5uvZcVjsHwwQn509YHuZOLpOKEf1mp8jblmQk/Z7ePoUfFKy2krfhbdUku6eeoBkPo2A0HR0x470o2aaFpT003YsiBxn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sk3yw5mw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sk3yw5mw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3141F1F000E9;
	Wed,  5 Aug 2026 21:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785964511;
	bh=GZ0WSCzXJEwY1HjIR+roEy4FfhXiFLdGjhA+Y+UNpgI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sk3yw5mw17I9PEgrMUQd0V6AFK46rKc2gfxDX2+ZrzC7cHejRlEiIJy9IvfFEZDa5
	 rgmIzzeUWxJBJIZClbAvTd5A24aSZhWlCj5bZDofhbuN5NqGqxMecEPVukVGpT3C99
	 Y2XkAxaVtRGOqlxhezivAgbH0YflLYGEUxTLQfNm0nkvNN6T4KeZNpgy1GjhX9kI1m
	 UQFIDepDGepRtF8LrQ7nAV1co6sTKcJY44+qQovZ/EzvUsECne/FC0J6PZvlyWxCTI
	 zU5jZhkpJyJ03bvuOA++8Vxa/Kacio9AzUbkbgvESDT0fA5v93Dye5sM34WpTZl9x2
	 Fj1SFks3SuI0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/7] KVM: x86: Use gfn_to_pfn_cache for steal time /
 preempted status
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?V29vZGhvdXNlLCBEYXZpZA==?= <dwmw@amazon.co.uk>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260805195528.3853473-8-dwmw@amazon.co.uk>
References: <20260805195528.3853473-1-dwmw@amazon.co.uk>
 <20260805195528.3853473-8-dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:15:10 +0000
Message-Id: <20260805211511.3141F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Sleeping in RCU read-side critical section due to TLB flush
--

--- Patch [7]: [PATCH v3 7/7] KVM: x86: Use gfn_to_pfn_cache for steal time=
 / preempted status ---
commit 7254897a5d4882376acaff67e062dd687ad49ea0
Author: Woodhouse, David <dwmw@amazon.co.uk>
KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status

This commit transitions the guest steal time and preempted status recording
to use the gfn_to_pfn_cache, resolving mmap_lock contention associated with
userfaultfd. It replaces explicit asm exception fixups and unsafe_put_user()
calls with plain C accesses protected by rcu_read_lock().

> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -2064,42 +2062,27 @@ static void record_steal_time(struct kvm_vcpu *vc=
pu)
>  	if (WARN_ON_ONCE(current->mm !=3D vcpu->kvm->mm))
>  		return;
> =20
> -	slots =3D kvm_memslots(vcpu->kvm);
> +	/* We rely on the fact that it fits in a single page. */
> +	BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
> =20
> -	if (unlikely(slots->generation !=3D ghc->generation ||
> -		     gpa !=3D ghc->gpa ||
> -		     kvm_is_error_hva(ghc->hva) || !ghc->memslot)) {
> -		/* We rely on the fact that it fits in a single page. */
> -		BUILD_BUG_ON((sizeof(*st) - 1) & KVM_STEAL_VALID_BITS);
> +	rcu_read_lock();
> +	while (!kvm_gpc_check(gpc, sizeof(*st))) {
[ ... ]
> +		if (kvm_gpc_refresh(gpc, sizeof(*st)))
>  			return;
> +
> +		rcu_read_lock();
>  	}
> =20
> -	st =3D (struct kvm_steal_time __user *)ghc->hva;
> +	st =3D gpc->khva;
> +
[ ... ]
>  	if (guest_pv_has(vcpu, KVM_FEATURE_PV_TLB_FLUSH)) {
> -		u8 st_preempted =3D 0;
[ ... ]
> +		u8 st_preempted =3D xchg(&st->preempted, 0);
> =20
>  		vcpu->arch.st.preempted =3D 0;
> =20
> @@ -2107,39 +2090,33 @@ static void record_steal_time(struct kvm_vcpu *vc=
pu)
>  				       st_preempted & KVM_VCPU_FLUSH_TLB);
>  		if (st_preempted & KVM_VCPU_FLUSH_TLB)
>  			kvm_vcpu_flush_tlb_guest(vcpu);

[Severity: Critical]
Can this sleep in an RCU read-side critical section?

When TDP is disabled and shadow paging is in use, kvm_vcpu_flush_tlb_guest()
calls kvm_mmu_sync_roots(), which can yield the CPU.

Looking at the call chain:

kvm_vcpu_flush_tlb_guest()
  -> kvm_mmu_sync_roots()
    -> mmu_sync_children()
      -> cond_resched_rwlock_write(&vcpu->kvm->mmu_lock)

Because this TLB flush is now called while holding rcu_read_lock() for the
gfn_to_pfn_cache access, will this trigger a scheduling while atomic panic
and potential RCU stalls when a guest requests a TLB flush?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805195528.3853=
473-1-dwmw@amazon.co.uk?part=3D7

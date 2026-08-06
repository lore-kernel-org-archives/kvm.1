Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074A8499F04
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786054460; cv=none; b=HuwB8pbNFBHNbNnrAVUlmUfJ5ccPGqJ9ExYYyjomLLm3qOcYxInBBHfpYR0Xt5zwY2g83OMac3LtclO1L9leqnJh9WmLJIjo/o1475Ru3LnTFfBH6kG4OGGTdfK6+9yzM1tjjgrg57b9+OpG7iBQRbNWu5AsXli9nHdkSEci5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786054460; c=relaxed/simple;
	bh=s25MYkp4+ZBXhKVD8tj5ZinPdGUDBAE6M14U5muWsUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ILkiFFtFM0aHaVUIS0bwDPkUiGNu/hQg+jRjQF1RHyO2soqYR0qSiMYeG8FlMbqJFozCHQr2/UhiIletPuC0ybTvAVk7OqllkSRkxPUdiAM6UqbIX1MJbYAX4SLm7i/zgqM3KvWC7Yj+I4gPGTIx1yWTCKip2fNA+pUc2P4v/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB3nE7fC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NB3nE7fC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08551F000E9;
	Thu,  6 Aug 2026 22:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786054458;
	bh=fzgrqA+5AAKvu7TQniH4KC8XfDAmAyBp79ky09SBghA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NB3nE7fCZrHTbhZNud7BTMbiD/BPBPHLxOR5Rfy+H6EBYUDNpvIYpvPBI+J4F8JfL
	 E93lljwlqpmNajjX0FX8FOFsYYKO37A/HtUIadyOh/0jZkSyACas60uTIZN7xwDszQ
	 1cQ3fkk7CmepIiQFU1Dnq4RHWGMALqWLqjUFFDCSgjbjypx4n/wIbZuxzMPdjtSYk0
	 FEF/F8OmGUYWt/3SL1P37Z5NK79icY3Bqusx3dJnp0riK6T4fnfL/GBNrQWlx0t4xJ
	 8fWyM0OtOPAWT2woay4sW/hCEqJ74BSnYSKBWZ+z2iN3nKBzM/N+EhgMFonxam2bcA
	 qXqa/ByxIkauw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against
 unexpected root invalidation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806214050.78058-3-seanjc@google.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 22:14:18 +0000
Message-Id: <20260806221418.B08551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Moving `kvm_mmu_reload()` inside the retry loop after `mmu_topup_m=
emory_caches()` causes deterministic memory cache underflows on the first p=
age fault if roots are reloaded.
- [Medium] Failure to re-reload the MMU upon detecting an obsolete root.

Pre-existing issues:
- [High] Memory cache depletion during the `RET_PF_RETRY` loop due to missi=
ng `mmu_topup_memory_caches()` inside the loop.
--

--- Patch [2]: [PATCH 2/4] KVM: x86/mmu: Harden "map private PFN" against u=
nexpected root invalidation ---
commit 22d402057a7ea26b753baa57f8845602fe5a1b81
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Harden "map private PFN" against unexpected root invalidation

This commit moves the MMU reload inside the tight loop in
kvm_tdp_mmu_map_private_pfn() to better handle unexpected root invalidation=
s.
It also adds a warning if the root is invalidated after the initial reload.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 621b0a42f2a14..c6cac893cbad8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c

[ ... ]

> @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *v=
cpu, gfn_t gfn, kvm_pfn_t pfn)
>  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
>  		return -EPERM;
> =20
> -	r =3D kvm_mmu_reload(vcpu);
> -	if (r)
> -		return r;
> -
>  	r =3D mmu_topup_memory_caches(vcpu, false);
>  	if (r)
>  		return r;

[Severity: High]
Since mmu_topup_memory_caches() is outside the loop, but kvm_mmu_reload()
was moved inside, is it possible for the reload to consume cache items
when allocating new roots?

If the root is invalid and kvm_mmu_load() allocates new roots, this
consumes items from mmu_page_header_cache and mmu_shadow_page_cache. When
execution proceeds to kvm_tdp_mmu_map() expecting fully topped up
caches, could this lead to a cache underflow and a host warning or panic?

> @@ -5199,10 +5195,21 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *=
vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
>  			return -EIO;
> =20
> +		r =3D kvm_mmu_reload(vcpu);
> +		if (r)
> +			return r;
> +
>  		cond_resched();
> =20
>  		guard(read_lock)(&kvm->mmu_lock);
> =20
> +		/*
> +		 * Because slots_lock is held, it should be impossible for roots
> +		 * to be invalidated after the initial MMU reload.  WARN, but
> +		 * continue and re-reload the MMU to try and keep the VM alive.
> +		 */
> +		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> +

[Severity: Medium]
The comment mentions "continue and re-reload the MMU", but does this actual=
ly
fall through directly to kvm_tdp_mmu_map() with an obsolete root?

If the mapping succeeds, it might return RET_PF_FIXED. This would exit the
loop instead of forcing a retry. Should there be a continue statement after
the WARN_ON_ONCE to enforce the retry behavior described in the comment?

>  		r =3D kvm_tdp_mmu_map(vcpu, &fault);
>  	} while (r =3D=3D RET_PF_RETRY);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but retrying on RET_PF_RETRY
in this loop seems vulnerable to memory cache depletion without the cache t=
opup.

If kvm_tdp_mmu_map() encounters contention, frees its locally allocated sha=
dow
pages, and returns RET_PF_RETRY, the loop repeats without calling
mmu_topup_memory_caches() again. Could this underflow the cache during
repeated retries under high contention?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806214050.7805=
8-1-seanjc@google.com?part=3D2

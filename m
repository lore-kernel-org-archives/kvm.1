Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20584766B8
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787763342; cv=none; b=f90f7yKE8FugB4qK1zF2gsI4d1nseNQ5MmaR3QomfLoxFDRlYgw3hYEJsWTHPSSx2L0ESKCA4KdKKV4m1lbAoNvSn8wdX+EOR8aG06p3nzZNketA4FJH8TX6YKQOUWbjifFNhVj8Prm8LqMohGrKzgx74Bn3PVHty5kD1ZDry/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787763342; c=relaxed/simple;
	bh=d6qOk9m4wLpuJoE3tWrN6MDODK4P98H/sg32JJazEpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NJ09GFu3EsezcDLeKPID74ma/eBxUhpBsnm02rN41arKcww+SEBzYTTRP00W+VIxITk/roj66XwknToEd0GAeCMpTh5LjfqGPmrE62L/QETIrQYJ8Of/ubA1g8nRfS52ALmJaXe6yatkQnPwbcTZqIdLwwayUgMBktgyzVPxE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqHhmiOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqHhmiOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABCE1F000E9;
	Wed, 26 Aug 2026 16:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787763328;
	bh=WWkhe0A2nQveWkRVjn2FC/GNsVBGaNX9K7CICi4KLvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fqHhmiOleSa5yYfJroFpx//pJgwL+38rqp1qdqsw4v4t8oKqJlvdcA8EDfeAK+9jl
	 qGRecSHLJhYhfTRp+d/ygYhzQAQ9FgulmQTvULl5LtaQ7y41mQ2A9+h8GUVTeLGtxP
	 JWsuqBxNdf7TjaBWrYoLt0SnnHn+azgZAHGItjO1p/hhP5mjlzrJyC6QCkWa/E0Jlt
	 6lfVGO1ya+zRaLKCcyMbwwnGu+Qnof913g5nO71E3ae/3aez4S0ZBI8QVRcbuNxuAL
	 ujFlhhukNr3TCVNwnnd8CENRQzHY5bliGWf+pRBU8+zcNA7m2FwUjlcP7x4SY7+t+K
	 ErdPNq2tDuAQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: x86/mmu: Add sanity check to detect stale
 page faults in "map private PFN"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826164214.756512-5-seanjc@google.com>
References: <20260826164214.756512-1-seanjc@google.com>
 <20260826164214.756512-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 16:55:27 +0000
Message-Id: <20260826165527.EABCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Snapshotting `mmu_invalidate_seq` after acquiring `mmu_lock` and a=
fter PFN resolution violates the mandatory MMU retry protocol sequence, byp=
assing generation-safety checks against concurrent invalidations.
--

commit 3d8d7ec872ba8330e37f8fdcf1804dda38c1cf1e
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Add sanity check to detect stale page faults in "map private =
PFN"

This commit adds a check for stale page faults prior to mapping a private P=
FN
into the guest. It intentionally snapshots the invalidation sequence after
acquiring the MMU lock to avoid false positives.

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 19a501029f089..79c450d677b40 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5236,6 +5236,18 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *v=
cpu, gfn_t gfn, kvm_pfn_t pfn)
>  		 */
>  		WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));
> =20
> +		/*
> +		 * Snapshot the invalidation sequence counter after acquiring
> +		 * mmu_lock, as guest_memfd guarantees the validity of the pfn,
> +		 * i.e. any concurrent invalidations are guaranteed to be
> +		 * irrelevant.
> +		 */
> +		fault.mmu_seq =3D vcpu->kvm->mmu_invalidate_seq;
> +		if (is_page_fault_stale(vcpu, &fault)) {

[Severity: High]
Does capturing mmu_invalidate_seq after acquiring mmu_lock and after PFN
resolution bypass the mandatory MMU retry protocol safety checks?

According to the KVM memory management guidelines, the invalidation sequence
should be captured before resolving the PFN, and the lock must be acquired
afterward. By snapshotting the sequence here and immediately checking it
via is_page_fault_stale(), the check effectively compares the counter to
itself, which guarantees it will pass.

Could this bypass allow the installation of stale translations or cause a
use-after-free if the caller's guarantees ever fail in the future?

> +			r =3D RET_PF_RETRY;
> +			continue;
> +		}
> +
>  		r =3D kvm_tdp_mmu_map(vcpu, &fault);
>  	} while (r =3D=3D RET_PF_RETRY);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826164214.7565=
12-1-seanjc@google.com?part=3D4

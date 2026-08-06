Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EAD3E1203
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 21:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053375; cv=none; b=BKsvEnoh6wY81+D64/vBY4X9+vSkDQ3EKENBkATj1R6+KNsQzeXLui60IkVsExjzg7xi7jplYNUgFQUj1G9VpEfqvATSAU07N8qT6HSeIFw0Vbpb7U8K7ecRUde4DEbbHf5/WFY1Gx6vCsLT84XvX/t0LdItTA3GUObRkoxd7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053375; c=relaxed/simple;
	bh=rL9MUXuOz17L8s3xseVfdY0HNsNKZ+y3fMMiM/7EZtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s98AOZWnv85cwqEEOAJjfImBGFKmQ9Pskc159tHIZzZbgycI+AJmp/yDCFex47VZBEAZXZYOs+QVIPYAHKMJ6HzkjEp/Rx2YS4g4wvZsLNGSEmYB2ts/Y3Z7zCMGsOkHHvaumyjNttuXJyjaeYGe+B3vD0+2jMf6uuJREca49+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4fmh2Qk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4fmh2Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B4F1F000E9;
	Thu,  6 Aug 2026 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786053374;
	bh=KCt1GGhx+wANFh6kav8CHkJ7AwW49fYfPoDFK6/HZkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D4fmh2QkuSDCABfWRqyKOt09xothRQbOOvgEk196CpL62yxnrylKAeYaYUeoNbxnm
	 rawe2KJwZv0xWazNKyff0eekOtcj5KaiYmxC+OKwAiiY3paEiCvFAOX1+bYeoUEfnf
	 B+/t3b1KQzvn5K7X0obGt5SLkawbGT0yLo/4n+U0/+F2nSyNbc8mOrgZvXxFxQ70aT
	 nX5qFgE12fZrP2qn4vpNNbXV1MH9WC+YJkOkzD7HkWjVORO7kUg3ObdSMOVu1W629j
	 cSohPNTBjW1/nDkPdptvE6TB1SD8a4V0iOCyJyBRDb3Woz0uWf42ygwkfYLOmru4oO
	 O52p3GNC4TOOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying
 "map private PFN"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260806214050.78058-4-seanjc@google.com>
References: <20260806214050.78058-1-seanjc@google.com>
 <20260806214050.78058-4-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:56:13 +0000
Message-Id: <20260806215614.36B4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The WARN_ON_ONCE check for obsolete roots in kvm_tdp_mmu_map_pri=
vate_pfn is largely ineffective due to being placed after kvm_mmu_reload, w=
hich clears the request bit.
--

--- Patch [3]: [PATCH 3/4] KVM: x86/mmu: Top-up memory caches when retrying=
 "map private PFN" ---
commit 7a1e8c6872a95084f82e79ad3438f87300a97a91
Author: Sean Christopherson <seanjc@google.com>

KVM: x86/mmu: Top-up memory caches when retrying "map private PFN"

This commit moves the top-up of memory caches into the retry loop in
kvm_tdp_mmu_map_private_pfn(). This ensures that the caches are replenished
on every attempt to map the PFN, hardening KVM against potential cache
consumption issues during TDX post-populate callbacks.

Closes: https://lore.kernel.org/all/20260718061050.E17B01F000E9@smtp.kernel=
.org

> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index c6cac893cbad8..379f570ef04f8 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5184,10 +5184,6 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *v=
cpu, gfn_t gfn, kvm_pfn_t pfn)
>  	if (kvm_gfn_is_write_tracked(kvm, fault.slot, fault.gfn))
>  		return -EPERM;
> =20
> -	r =3D mmu_topup_memory_caches(vcpu, false);
> -	if (r)
> -		return r;
> -
>  	do {
>  		if (signal_pending(current))
>  			return -EINTR;

[ ... ]

> @@ -5199,6 +5195,10 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *v=
cpu, gfn_t gfn, kvm_pfn_t pfn)
>  		if (r)
>  			return r;
> =20
> +		r =3D mmu_topup_memory_caches(vcpu, false);
> +		if (r)
> +			return r;
> +
>  		cond_resched();
> =20
>  		guard(read_lock)(&kvm->mmu_lock);

[Severity: Medium]
In kvm_tdp_mmu_map_private_pfn(), is the WARN_ON_ONCE() check for
obsolete roots still effective here?

Just a few lines down from this chunk:

    WARN_ON_ONCE(kvm_test_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu));

Because kvm_mmu_reload() is called higher up in the loop, which internally
invokes kvm_check_request(KVM_REQ_MMU_FREE_OBSOLETE_ROOTS, vcpu), it will
clear the request bit.

If an invalidation occurs during the kvm_tdp_mmu_map() execution, the loop
correctly retries, but the next iteration's kvm_mmu_reload() will silently
clear the request bit before execution reaches the WARN_ON_ONCE() statement.

This seems to leave the assertion only covering the small window between the
reload and the WARN itself, masking potential regressions where roots are
unexpectedly invalidated during the map operation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806214050.7805=
8-1-seanjc@google.com?part=3D3

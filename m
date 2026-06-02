Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB137BE9C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780432588; cv=none; b=Ppx+C6ngUB7cMskvIFSdlfnIpkV5IPtBpoHT9qT+BD4vGPXLV5pR3X6W9+fyjunLbgRZVZZOFp3DYin8b1wm53px4DYriOtfzFU4q/kjLHkgKUW+OmVuzkYoAQbhPOZy4dtpKrPV9vyPGaPlktDswOH7t+INjNIv48qBBPqUy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780432588; c=relaxed/simple;
	bh=dG22dI2EJpPcYY6LsWslcL/HwCdEcBAEv9Etuoiv/JM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VFW5Sbpw66vqsBsfzWguXc9fxlfjwhcEozkw6R/UlWlIrjAU6rrv6fi3rE1UJBhNiauQyG1DPKUKkmGmKuwl4BItR4aY5RZ4uGUKTgWBLHwt8sgoXX5YabB/P830S0R5yBOex5lfAQ5SsMaqHDyLkByy9Ll+a2PPtL+jtdPKdxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsDwwp29; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsDwwp29"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D0D1F00893;
	Tue,  2 Jun 2026 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780432587;
	bh=0auQYBdB7tzoEf0IV8nm6QqFbUkWk7ZjVFIb5G54Ixs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZsDwwp29nyon6R8DRCesTfXGFHlgwJ2HmCNG23nDnIdAGFYeuHUzrIZfPA4KkFMCH
	 KqshsIL7u/FxlVncll/E1BqajBmfAiLHcco2Myh5GBbreXsB+mm5pmm2QedHTfZRpv
	 6pursN1oqGg1/EkKMbq8PXZvIoWXpFdBP9z9RP/4xLCwPOSo+us2bQ91loJV2n7XyK
	 3AEcMSX+RzuOYXCrOQnoVHEIIHIGdqXo6cJ2ovSPrknIdyXN/BKPK6Yuiybw4tU7Ir
	 OCVtL4v2LeYl1A5QhOWZTOSh0aLb+83hTquPXsxh5T9zqWyXSmmElKQgnEts53B12e
	 gj546u2QEYz0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] x86/sev: Initialize RMPOPT configuration MSRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ashish Kalra" <Ashish.Kalra@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <87d473d05c26458773b7957fb96e9b2948641753.1780427587.git.ashish.kalra@amd.com>
References: <87d473d05c26458773b7957fb96e9b2948641753.1780427587.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:36:26 +0000
Message-Id: <20260602203627.37D0D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Late clearing of X86_FEATURE_RMPOPT via setup_clear_cpu_cap() fail=
s to un-patch CPU alternatives, causing snp_setup_rmpopt() to dangerously e=
nable RMPOPT on unsupported Contiguous RMP configurations.
--

commit 551ddbd8061d6e0326ab620a808e849941500d13
Author: Ashish Kalra <ashish.kalra@amd.com>

x86/sev: Initialize RMPOPT configuration MSRs

This commit introduces RMPOPT instruction support to manage per-CPU RMP
optimization structures. It sets up the RMPOPT table base to enable
optimizations for up to 2TB of system RAM once SNP is enabled. It also
attempts to clear the RMPOPT CPU capability if Segmented RMP is disabled.

> diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
> index 989ca9f72ba30..7fdef00ca8f22 100644
> --- a/arch/x86/coco/core.c
> +++ b/arch/x86/coco/core.c
> @@ -172,6 +172,7 @@ static void amd_cc_platform_clear(enum cc_attr attr)
>  	switch (attr) {
>  	case CC_ATTR_HOST_SEV_SNP:
>  		cc_flags.host_sev_snp =3D 0;
> +		setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
>  		break;
>  	default:
>  		break;

[ ... ]

> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 8bcdce98f6dce..089c9a14edc74 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c

[ ... ]

> @@ -488,9 +491,13 @@ static bool __init setup_segmented_rmptable(void)
>  static bool __init setup_rmptable(void)
>  {
>  	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
> -		if (!setup_segmented_rmptable())
> +		if (!setup_segmented_rmptable()) {
> +			setup_clear_cpu_cap(X86_FEATURE_RMPOPT);
>  			return false;
> +		}
>  	} else {
> +		/* Note that Segmented RMP must be enabled to enable RMPOPT. */
> +		setup_clear_cpu_cap(X86_FEATURE_RMPOPT);

[Severity: High]
Will calling setup_clear_cpu_cap() this late in the boot sequence effective=
ly
disable the feature?

Since setup_rmptable() and amd_cc_platform_clear() are invoked during late
IOMMU initialization, this executes after check_bugs() has already permanen=
tly
patched the alternative instructions.

While do_clear_cpu_cap() will trigger a kernel WARNING and update the
in-memory boot_cpu_data array, it cannot undo the static code patching of
static_cpu_has().

>  		if (!setup_contiguous_rmptable())
>  			return false;
>  	}

[ ... ]

> +void snp_setup_rmpopt(void)
> +{
> +	u64 rmpopt_base;
> +	int cpu;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
> +		return;

[Severity: High]
If setup_clear_cpu_cap() failed to un-patch the alternatives earlier, will
cpu_feature_enabled() incorrectly return true here even when falling back to
Contiguous RMP?

Because cpu_feature_enabled() relies on static_cpu_has(), it seems it will
execute the previously patched instruction and erroneously bypass this chec=
k.

Would this result in snp_setup_rmpopt() wrongly configuring
MSR_AMD64_RMPOPT_BASE and dangerously enabling RMPOPT on unsupported
configurations, risking CPU exceptions or memory corruption?

Could a global boolean flag be used to track the RMPOPT state instead of
dynamically mutating a CPU feature after alternatives are patched?

> +
> +	cpus_read_lock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780427587.gi=
t.ashish.kalra@amd.com?part=3D2

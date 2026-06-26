Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE12EDD6C
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473138; cv=none; b=mTV4FulOXrKDvnK+NeXxstLW2aZ5OkJUsqDBOgBxTdoEwgzSgYcdK79LyXylUNpuIoDwtaDmQr/YFX5xneV4AF9rkX+GQmUSerAhMj074abYv9/SijTfQELgXTh66L1qjTouZhOHwXnf8DHqf6YmAXCoJ2Cwx4Ba8/BWTlbQOu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473138; c=relaxed/simple;
	bh=NAP7+jsd3icWyU19FskOFPlxcaV0Lg3+LPHFwttAnN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TyOez3KqOSJtmiaTUcgX+YYOxatiI7bSHxg4BsKN18MC23tvxxYQrKDaOWBPYb8qJrnBqsPruJZMLwXrGKmmm1XmSd8cmE3xh2DmskgYBBk6aTpf9npGCJmHv6j+opVkKPa+0IZvvqe+U5V2RiYXlGDQ58Z90YjhsOlULMnUhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7reA6+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7reA6+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F0A1F000E9;
	Fri, 26 Jun 2026 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782473137;
	bh=+Dx8n8mcepODCAluMIETj7vXrSxTWjCHB3GC2gBPKSA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I7reA6+PgAC0fKn9QCgMDG+YmnQwVWasIw4ZVfktcb8htjPOATDJwuE5eJplyVs5w
	 qs+TKXJqNsnOyajdv6tLJplIiL1Jc3rTQuKT7WMf74Q9Dxazcs2utz1LEQgUNrkpKv
	 qd4VfvoA5h1QtyhBtrlxjKLK5eXYd1CIMlW0f/feoNBiRjX/xnG332NmUWpyY7lzNq
	 s2FVvHVt1KkjjNkyPTP80AyhoSzUpxFx6p5hTjb2Xbvum2p56KDLa9RQCf3TLC9r4x
	 L0ZALuWOAYNmx6BHZRyO8qZNS7W8obEppDDL/aJIcb9TrsnGTiQeUohoMKceqYSa5O
	 C3d4BiUid1IQA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] iommu/amd: Provide kernel command line option
 to enable GAPPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260626105906.14577-6-sarunkod@amd.com>
References: <20260626105906.14577-1-sarunkod@amd.com>
 <20260626105906.14577-6-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 11:25:36 +0000
Message-Id: <20260626112537.22F0A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] The global variable `amd_iommu_gappi` is not cleared to `false` wh=
en `enable_iommus_vapic()` returns early.
- [High] The `CONTROL_GAPPI_EN` feature is enabled but never disabled durin=
g IOMMU teardown or kexec initialization, leaking hardware state.
- [High] The GA log interrupt handler unconditionally re-enables `CONTROL_G=
ALOG_EN` upon an overflow event, even when GAPPI is used and GA log memory =
is uninitialized.

Pre-existing issues:
- [High] `iommu_init_ga_log()` unconditionally allocates memory with `GFP_K=
ERNEL` and reallocates pointers during suspend/resume cycles, causing a mem=
ory leak and a sleep-in-atomic bug.
- [High] `enable_iommus_vapic()` returns immediately on error without rolli=
ng back previously initialized IOMMUs, leading to an inconsistent initializ=
ation state.
--

commit a43ef908c557e1883a80f54d875c75488a6d0f52
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Provide kernel command line option to enable GAPPI

This commit introduces the amd_iommu=3Dgappi command line parameter to enab=
le
the GAPPI extended feature when supported by the IOMMU hardware.

> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3038,11 +3038,20 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
> =20

[Severity: High]
If enable_iommus_vapic() returns early before this point because
FEATURE_GAM_VAPIC is missing or SNP is active, the newly added
amd_iommu_gappi flag is never cleared.

Could this cause issues later in amd_iommu_update_ga() when KVM expects
GAPPI behavior but Virtual APIC mode is logically disabled, triggering
warnings and failing interrupt delivery?

[Severity: High]
When recovering from a previous kernel in the kexec path earlier in this
function, the cleanup loop clears CONTROL_GALOG_EN and CONTROL_GAINT_EN.

Since this patch introduces CONTROL_GAPPI_EN, does the cleanup loop also
need to call iommu_feature_disable(iommu, CONTROL_GAPPI_EN) to prevent
hardware state corruption if the previous kernel left GAPPI active? A
similar omission appears to exist in iommu_disable().

> +	if (amd_iommu_gappi &&
> +	    !(check_feature(FEATURE_GAPPI) &&
> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
> +		pr_warn("GAPPI is not supported.\n");
> +		amd_iommu_gappi =3D false;
> +	}
> +
>  	/* Enabling GAM and SNPAVIC support */
>  	for_each_iommu(iommu) {
> -		if (iommu_init_ga_log(iommu) ||
> -		    iommu_ga_log_enable(iommu))
> -			return;
> +		if (amd_iommu_gappi)
> +			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
> +		else if (iommu_init_ga_log(iommu) ||
> +			 iommu_ga_log_enable(iommu))
> +			 return;

[Severity: High]
When amd_iommu_gappi is true, iommu_init_ga_log() is intentionally bypassed,
meaning the GA log memory is never allocated.

If a spurious GA log overflow interrupt fires, amd_iommu_int_thread_galog()
processes it by calling amd_iommu_restart_ga_log(), which blindly re-enables
CONTROL_GALOG_EN.

Will the hardware then attempt to write log entries to an uninitialized
physical address, potentially causing kernel memory corruption or fatal
IOMMU target aborts?

[Severity: High]
This isn't a bug introduced by this patch, but returning immediately on
failure here leaves the system in an inconsistent state.

If a subsequent IOMMU fails initialization, the loop aborts without rolling
back the features (like CONTROL_GAM_EN or CONTROL_SNPAVIC_EN) enabled on
previously processed IOMMUs. Could this result in partially initialized
interrupt routing?

[Severity: High]
This isn't a bug introduced by this patch, but calling iommu_init_ga_log()
here unconditionally allocates memory with GFP_KERNEL.

During system resume, amd_iommu_syscore_ops.resume calls
enable_iommus_vapic() with hardware interrupts disabled. Does calling a
GFP_KERNEL allocator in this atomic context cause a sleep-in-atomic bug,
and does unconditionally overwriting iommu->ga_log leak the previously
allocated memory on every resume cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626105906.1457=
7-1-sarunkod@amd.com?part=3D5

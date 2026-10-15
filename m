Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBF4A64C5
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 07:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048102; cv=none; b=EeVBC3FHY3O58KQq/VVDnnZ8WFkvI9NxbUV3bAwwB7HhUXaa2WzSKrLKL7NmGUa2hWcOH/MujT3ytSTpYPoeVu7yNcByTktAdomQCoG1pMS1w+i7cYMo46WP7b44I0334tPzEGD6UEdKhKTijfJff2PMpqiS5c8+cAIFKdyo3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048102; c=relaxed/simple;
	bh=BOT0UWP9YXd0Za6BISLj7RumQDPVm4W0GUgYADc61Uc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=WmC2F71hBf7HLLZBYRXegS3OfwQ4qfSt7/ZEVL6m9kIFjeDmmHwKdifVZVFQDD7zaH+rTi1nW6u3DPDP82inMKJCGDrt7pF3PRkhJvh/uUUyDlbY1sByn/5+rLlkeaMjPpKDxyPQVVfgAdzDeCQYZWVYTjvK2sMSkDStPXyx5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGS45h7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGS45h7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C56E1F000C4;
	Thu, 15 Oct 2026 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792048089;
	bh=Cno4ZZUVZ7S7+Z1rUEIRoeh3OnNguzSf/rb/ic/7ipw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XGS45h7yS0Vob01bWxBalfx/Xj6FfWijEWAVQCcClQm3BYSxyIiFxwBW09gbvjofO
	 3VJd9eo9ZVw7ZIyMEGJkv9lYkslokMW/+9/0CYuJKor0GpYQiIBdqSN/XOezTKAq50
	 xuakohKT+P00Y0PjKgXvucleS7AXN9oj1ZlTv/R0rS6LuR3CUpZKdBQ2NPS1+PEW6B
	 JmtTbqfneQLjq7jCjMyqhSYSq7HzqYV6GH9O0ZPaMhrGUQQDVvsPSyh9AedPhQKUUR
	 ezBWOnwGyR2A7yhHB4YgdbxJBjMRSmz+X2FRF5BV9Sis9NH7v3DPnQLVzC6qern1h6
	 4Q0D+qece3TAg==
Message-ID: <sashiko-outbox-172380@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/7] iommu/amd: Provide kernel command line option to
 enable GAPPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sairaj Kodilkar" <sarunkod@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015064515.10700-8-sarunkod@amd.com>
References: <20261015064515.10700-1-sarunkod@amd.com>
 <20261015064515.10700-8-sarunkod@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 07:08:09 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] iommu/amd: NULL pointer dereference in iommu_poll_ga_log() with GA=
PPI
- [Medium] iommu/amd: amd_iommu_gappi state inconsistent on VAPIC fallback
- [Low] iommu/amd: missing GAPPI in feat_str feature name array
--

commit f3f34d41f6c88bbaa635da8109c52cf22d09f580
Author: Sairaj Kodilkar <sarunkod@amd.com>

iommu/amd: Provide kernel command line option to enable GAPPI

Enable GAPPI when the IOMMU GAPPISup extended feature bit is set and
the kernel is booted with the amd_iommu=3Dgappi kernel parameter.

> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_=
iommu_types.h
> index b89a2b3df0a49..51edd617ddca2 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -78,6 +78,7 @@
>  #define FEATURE_X2APIC		BIT_ULL(2)
>  #define FEATURE_NX		BIT_ULL(3)
>  #define FEATURE_GT		BIT_ULL(4)
> +#define FEATURE_GAPPI		BIT_ULL(5)

[Severity: Low]
This isn't a functional bug, but FEATURE_GAPPI is defined as bit 5.=20

In print_iommu_info(), bit 5 is still hardcoded as "[5]" in the feature
string array:

drivers/iommu/amd/init.c:print_iommu_info() {
...
	static const char * const feat_str[] =3D {
		"PreF", "PPR", "X2APIC", "NX", "GT", "[5]",
		"IA", "GA", "HE", "PC"
	};
...
}

Should "[5]" be updated to "GAPPI" so the kernel boot log displays the
correct feature name?

[ ... ]
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ef23e0755c32d..c536e0b3c4ff7 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
[ ... ]
> @@ -3025,10 +3035,19 @@ static void enable_iommus_vapic(void)
>  		return;
>  	}
> =20
> +	if (amd_iommu_gappi &&
> +	    !(check_feature(FEATURE_GAPPI) &&
> +	      AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))) {
> +		pr_warn("GAPPI is not supported.\n");
> +		amd_iommu_gappi =3D false;
> +	}

[Severity: Medium]
If VAPIC is unsupported or disabled due to SNP, the code returns early just
above this diff and falls back to legacy mode:

drivers/iommu/amd/init.c:enable_iommus_vapic() {
...
	if (!check_feature(FEATURE_GAM_VAPIC)) {
		amd_iommu_guest_ir =3D AMD_IOMMU_GUEST_IR_LEGACY_GA;
		return;
	}

	if (amd_iommu_snp_en &&
	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
		pr_warn("Force to disable Virtual APIC due to SNP\n");
		amd_iommu_guest_ir =3D AMD_IOMMU_GUEST_IR_LEGACY_GA;
		return;
	}
...
}

These early returns bypass the new fallback check added here that sets
amd_iommu_gappi =3D false.

If KVM subsequently reads the stale amd_iommu_gappi flag and attempts to set
up IRTE entries using GAPPI parameters, it calls irq_set_vcpu_affinity()
which triggers this check:

drivers/iommu/amd/iommu.c:amd_ir_set_vcpu_affinity() {
...
	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
		return -EINVAL;
...
}

Could this result in a kernel warning and failure to configure the affinity
since the IOMMU driver actually fell back to legacy mode?

> +
>  	/* Enabling GAM and SNPAVIC support */
>  	for_each_iommu(iommu) {
> -		if (iommu_init_ga_log(iommu) ||
> -		    iommu_ga_log_enable(iommu))
> +		if (amd_iommu_gappi)
> +			iommu_feature_enable(iommu, CONTROL_GAPPI_EN);
> +		else if (iommu_init_ga_log(iommu) ||
> +			 iommu_ga_log_enable(iommu))
>  			return;

[Severity: High]
If GAPPI is enabled, we skip allocating the GA log, so iommu->ga_log
remains NULL.

If the previous kernel used the legacy GA log and left an interrupt pending,
or if an unmasked interrupt triggers the handler:

drivers/iommu/amd/iommu.c:iommu_poll_ga_log() {
...
	head =3D readl(iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
	tail =3D readl(iommu->mmio_base + MMIO_GA_TAIL_OFFSET);

	while (head !=3D tail) {
		volatile u64 *raw;
...
		raw =3D (u64 *)(iommu->ga_log + head);
...
		/* Avoid memcpy function-call overhead */
		log_entry =3D *raw;
...
}

Won't the while loop unconditionally dereference iommu->ga_log which is now
NULL, crashing the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015064515.1070=
0-1-sarunkod@amd.com?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD838F92F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076509; cv=none; b=CcUawZW7OAse5OrJCSCZxg9NvyaEuFOXZOAQ1tir4nzKXeKhGOIc/5nkTOcMz+z/W8n09gAnMMPpR1dzKUQKWwBNhXICPrixhTAk3YZZYyRUnQYQT02gBKIyqh/OqPfafikjD5Iq1J13NktQT4dvCDiO4vIntsdz0JngSOYtWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076509; c=relaxed/simple;
	bh=mpNuZvfS6S5qC9jt15cBS6BfX7k3zm4eszBeQCT+nvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PqAJ4nTYit7hjdcdomeTVfOCuW5NUlSZ7GUom0sCCoKcYqklL8F+VlIc5cgSM9PgcCkPUbmZTO4y2YMkPgtPWi6yiIPDCmhW3eCVQ+BwfYg+IlYscHBpEBDl5mQexUPow0Yo/B58ADCSeFdPAL5htXLecjRdz1kzwmUqDVKF/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtND94ts; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtND94ts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AD1D1F00893;
	Fri, 29 May 2026 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076508;
	bh=ZM9i15isEEixYbdphKPig7Vk1Qaw9w1iARtrognsMaY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XtND94ts833TVKpzPGZFetVjtsj56y6FdBBQxu1dJf8As4VM3e8nhRmlPE7iVhHBg
	 ZrJvXnJ6VTYqNgDB7MaOKlFww29dl76+kzNfaU4j50N4TpIJrgxFrvn2TUcYlm06sQ
	 FwUNsdxKNr40+egLSQm/epDCO26E7SHf+6S9L5uumfOsmgs+BWt4TqcGPZTv/aBZWL
	 DPBD34iXP8jbAbIYXtjfmuKBOdJAgGuIZA3hBNIXa9RmcQc7JyyW3kKcmsOHVDTesE
	 YwbZUPLXrFsGa3tQVhtqBbcPtCFy7yka5Mig4rpmTNeCVajOBg4NTk7XA4v0R6ctyK
	 UMcsaVdFKgpjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/27] arm64: Provide arm64 API for non-native
 architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529155050.2902245-7-seiden@linux.ibm.com>
References: <20260529155050.2902245-7-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 17:41:47 +0000
Message-Id: <20260529174148.0AD1D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Moving the large `esr_get_class_string` function to a `static inlin=
e` definition in a widely included header causes unnecessary kernel text bl=
oat.
--

commit f19382b1cbd1896b8ea8e1b5b65a1f8581246812
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: Provide arm64 API for non-native architectures

This commit introduces a new directory include/arch/arm64/asm to store
architecture-agnostic headers for arm64 implementors. As part of this
change, the esr_get_class_string() function and its associated string
mappings are moved from traps.c to a static inline function in esr.h.

> diff --git a/arch/arm64/include/asm/esr.h b/include/arch/arm64/asm/esr.h
> similarity index 88%
> rename from arch/arm64/include/asm/esr.h
> rename to include/arch/arm64/asm/esr.h
> index 7e86d400864e0..a7421cc966f98 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/include/arch/arm64/asm/esr.h
[ ... ]
> @@ -541,7 +542,56 @@ static inline bool esr_iss_is_eretab(unsigned long e=
sr)
>  	return esr & ESR_ELx_ERET_ISS_ERETA;
>  }
> =20
> -const char *esr_get_class_string(unsigned long esr);
> +static inline const char *esr_get_class_string(unsigned long esr)
> +{
> +	switch (ESR_ELx_EC(esr)) {
> +	case ESR_ELx_EC_UNKNOWN:	return "Unknown/Uncategorized";
> +	case ESR_ELx_EC_WFx:		return "WFI/WFE";

[Severity: Low]
Does moving this 45-case switch statement to a static inline function in a
widely included header cause unnecessary kernel text bloat?

Previously, this was implemented as a simple string array in a single
compilation unit (traps.c). By making it a static inline function, the
compiled switch statement and any compiler-generated jump tables or .rodata
string mappings might be unnecessarily duplicated in every compilation unit
that calls it.

While the performance impact is likely negligible since it is primarily cal=
led
in slow-path error handling locations, it might be better to keep the
implementation out of the header.

> +	case ESR_ELx_EC_CP15_32:	return "CP15 MCR/MRC";
> +	case ESR_ELx_EC_CP15_64:	return "CP15 MCRR/MRRC";
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529155050.2902=
245-1-seiden@linux.ibm.com?part=3D6

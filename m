Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E53F9A1A
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073979; cv=none; b=i/d5VVrPTApNVGOGcgSP5yM6V/IYtApxEyflFpyoP0k6sN96wItozIJMc3yTbmofAwBSslE3KIiekUiUtlpNVKMgF92X4CQwQ187bga8v1PZlRj2Bdf+rrWUrd99jx+Sf2SiScwpxNYyCmppTRK+kX0xkCF5mPbl9Sex+q3024U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073979; c=relaxed/simple;
	bh=QxzH5176QV1Z3ehduHKIGQu/MHoL+J9s1KmhHLaMQYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GfUaPGKG9joBFNnJDE9BT0a1Itv4CtaygJicN8PU7NHHRrRpMfSdQtJqOmbZP+qomQ7v8+v+Yd67fxJ1f28w7trVjwHW9+W9sdGcFyt90ZN1dloD55Mc6+FayWwWSy5F3WQw/f4bBup5vCkTd4WzHAnzyukTn+kenRfQgsd1XYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VgiUGXrj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VgiUGXrj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-368b15eeb3bso24949894a91.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073977; x=1780678777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EIfZI+15eXnt1VS1ntObygvWhZxyllpwUaeyj935Nek=;
        b=VgiUGXrj0kd28rwfhj/jVylcMGnXjPfEfylZt/hA39rn478ou6knrVrt9+G1CcG2wi
         Z1xmQSMlMziHsQjtrthewzgojDF6zTRCIt7HoqbduDWNOlX05oYqnYchpHDHCXscYs26
         UzzXbT2YLco6l34+wacQU5tbfnCen22Oq+pbXKITzmvEAWX4+baJY7sY9j5uNcOTt9Fj
         n4PMhfGLlFJjZwNu7tXT0LT6SXBcx5lJC9ScHfh8I9Gz8LKWS85sldtvMuzO5eij9Iqr
         uG6x6W+aeP/hZdySoAYRXe2QQtiBJ2/uSnZz2jkR7R0r/pGmtBJmh4qXb4yBSUjNbmvB
         gdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073977; x=1780678777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIfZI+15eXnt1VS1ntObygvWhZxyllpwUaeyj935Nek=;
        b=SFr+zbLeYZKvXv/LuJ63eJ7AJtQj8WaV0JKSi3JHCv031zhM3QdR0UTzqPE8Wv60nz
         mHIS68iR94QdqC67c7gW+5JM3gJesGlCLHQ67Qcm8eNXf0fUguz7i82n3qKHOOIRWvmY
         J/cMtK3JOFoxmJhrnDgZ05OI/rwsbZcFGS486JDTDb0WxgLC83I1WzmwQK+yGnoP/LR7
         j1CqwESDJ9dD/Pb60LDkD6DneAakORVspZ5FCYVf42+iYM95EKxkWqyLI7JRVEVhacsk
         +ZiwVEstw65MhLftIsKjSmH1c/dqmT13n4rQ3RW/Le8Y4NH5LQH30y3rDUReDVWpJbeG
         ydNA==
X-Forwarded-Encrypted: i=1; AFNElJ8LgVIKUWOqqiSyAIRKkScheQ8lyo1HVIGA+J6vpXQcTbNeVHu0sTu4ARMHv2gfRUcvuKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1REJjKbEjdDNSAczwaCj/nQgX+1vNfXoyj13PMD8iaKGMeydy
	7Yx2XScJNEa2KL5XLAsT0Rm4bzftfQ7ccEPKO/aaj+fRc2bMdDcCpmfVQJGPZfGY3fcDMiXGLXm
	5XwhWQA==
X-Received: from plry22.prod.google.com ([2002:a17:902:b496:b0:2bd:9e64:2df1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e78e:b0:2b4:5cea:f61c
 with SMTP id d9443c01a7336-2bf3679355bmr9901385ad.4.1780073976883; Fri, 29
 May 2026 09:59:36 -0700 (PDT)
Date: Fri, 29 May 2026 09:59:36 -0700
In-Reply-To: <20260529162111.990441F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-8-seanjc@google.com> <20260529162111.990441F00893@smtp.kernel.org>
Message-ID: <ahnF-FehodVd474X@google.com>
Subject: Re: [PATCH v4 07/47] x86/tdx: Force TSC frequency with CPUID-based
 info provided by the TDX-Module
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 2b8f94c3fcc7f..2603f136e29bd 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> 
> [ ... ]
> 
> > @@ -1550,6 +1551,8 @@ void __init tsc_early_init(void)
> >  		known_tsc_khz = tsc_early_khz;
> >  	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> >  		known_tsc_khz = snp_secure_tsc_init();
> > +	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
> > +		known_tsc_khz = tdx_tsc_init();
> 
> [Severity: Medium]
> Does this structure accidentally bypass the TDX APIC timer and TSC capability
> initializations if the user provides the tsc_early_khz boot parameter?
> 
> Previously, setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE) was executed
> unconditionally in tdx_early_init() for TDX guests. With this change, 
> tdx_tsc_init() is skipped entirely when tsc_early_khz is provided due to
> the if/else if chain.

Drat.  But this isn't benign.  I don't see a better option than biting the bullet
and ignoring tsc_early_khz for Coco guests, e.g. in the SNP patch do:

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz = snp_secure_tsc_init();

	if (!known_tsc_khz)
		known_tsc_khz = tsc_early_khz;
	else if (tsc_early_khz)
		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware\n");

and then this becomes:

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz = snp_secure_tsc_init();
	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
		known_tsc_khz = tdx_tsc_init();

	if (!known_tsc_khz)
		known_tsc_khz = tsc_early_khz;
	else if (tsc_early_khz)
		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware\n");

At that point, I think it makes sense to double down and ignore tsc_early_khz if
the hypervisor provides the frequency.  It'll yield cleaner code overall, and
will be easy enough to document, e.g. to end up with:

	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
		known_tsc_khz = snp_secure_tsc_init();
	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
		known_tsc_khz = tdx_tsc_init();

	/*
	 * If the TSC frequency wasn't provided by trusted firmware, try to get
	 * it from the hypervisor (which is untrusted when running as a CoCo guest).
	 */
	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
		known_tsc_khz = x86_init.hyper.get_tsc_khz();

	/*
	 * Mark the TSC frequency as known if it was obtained from a hypervisor
	 * or trusted firmware.  Don't mark the frequency as known if the user
	 * specified the frequency, as the user-provided frequency is intended
	 * as a "starting point", not a known, guaranteed frequency.
	 */
	if (known_tsc_khz)
		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);

	if (!known_tsc_khz)
		known_tsc_khz = tsc_early_khz;
	else if (tsc_early_khz)
		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware or hypervisor\n");

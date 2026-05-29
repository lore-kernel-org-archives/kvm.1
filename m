Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF93DD85E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780071811; cv=none; b=loDK5iKGx++0FODy8RZTivFFaYtv0emv/uTh2YvdqMriz/BfGsOUJQpU/b7G1CAO7kpCWLOlvQnAl0twJf13qpb7mAgi7cxJSRZWNj4Dh47cbliRYjVElPUZTwcmAJmOmkFlvzLskhVXNi9wsVXU2w+0j1CsO/dAjbOVLe+zOho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780071811; c=relaxed/simple;
	bh=pSxoxMhbYF7BHHLDnIxxdXcvcxE9JP52g/U+97KRZUI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6ZyijK67isLfoBq24JOzYerOk4xMzqkEtZuONFUOYiYKYigj9ysBzSZEAGMlr9Izttl9XKRDr1MA12/1SSdx1rpZLNCwmE6fSkzNiv/EtQ5uiN3wkTRrbYGo3bU2G1PY5Ka3oTimL9EBalIuz9y3cqWlzKVKEaJn4J2LoG13I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3bfTX4J; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3bfTX4J"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf281d523eso3558435ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780071809; x=1780676609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Scb9q7Vc7fjy0mJZyLF9pe8pDeFrn1cuBRV6rD40tUE=;
        b=K3bfTX4JecjtDE7MfJqXzQm3x4yY69RoAe4V3aqDIMxepXCDzugj1JrKlN0ZbLIr+K
         w7ccArh4rpSNoWPETw2qhH/3YYkvuvj5wTVwb3v9HTNDsdpF8YToQUJren2rQC2c/P9D
         jn+c7S8+9cNvHhD+3quTo3H6NBh11CPP8EZHQ2sF4qHTepFsKQ9k7f/kDAlhjaatlMYm
         QroWts9Wiv2kOWdaCV/DS0yUfWBzlR4aiMl+dAlEJ2689cKcT5st9OiK/44XOT1R0t3k
         HX5A8pQiXtmbLENbFksRV7wmTQlNwhzT4FaA+xFfMFKG6aKud7L/oO2fLcXYC2KyVcRa
         oz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780071809; x=1780676609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Scb9q7Vc7fjy0mJZyLF9pe8pDeFrn1cuBRV6rD40tUE=;
        b=h1QKmAiFxG75WeibM3RvazbBGCRe1OezI69olVS709WLpgFbxOnC8vW4FciX38zwjn
         c5Z6lmnW9L5WIPJkJ0AMc+xKvDyf02dio+H1HRp8pZv7sFCbxS/++m0DVKtyUkpMmia5
         s2vwP5pO+DIKM57pWD5Bi92B68svYN3Y7QRts5CKxopvRFg0vqao9e8TI+38co7pi/zE
         DqFchDTZsCHlR0tQQOdAnvKDQ4N1nqkQz5Y0k6BnVJHgpsiPxQyt+wCxXagxUXsKL01v
         vT7LOnDVjRop/iuffG/Ion0LobaTY53chJXzAbIANMhaLbrXgT81mhzpPwNoeoY0gNqN
         IPoQ==
X-Gm-Message-State: AOJu0YzfM2PeBi+a4g2hl4txUKkeaJPeZSBT7WB3gq/hN6iXZUDhilEz
	ggZ9wJ/gAJBEXW5mEYaj7gnplvpjtmCgBbqZ5uEc7nnBTg+RfN+stEAL4owk85u6tkrrl7CtB35
	iZMuOZA==
X-Received: from pgct19.prod.google.com ([2002:a05:6a02:5293:b0:c85:746c:1066])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c6:b0:2bd:9c0a:32c
 with SMTP id d9443c01a7336-2bf3683b78dmr6175505ad.19.1780071808895; Fri, 29
 May 2026 09:23:28 -0700 (PDT)
Date: Fri, 29 May 2026 09:23:27 -0700
In-Reply-To: <20260529161442.754A41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-7-seanjc@google.com> <20260529161442.754A41F00893@smtp.kernel.org>
Message-ID: <ahm9fwLDnnby9q0k@google.com>
Subject: Re: [PATCH v4 06/47] x86/sev: Shove SNP's secure/trusted TSC
 frequency directly into "calibration"
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index 833eed5c048a9..2b8f94c3fcc7f 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> [ ... ]
> > @@ -1537,16 +1538,20 @@ static void __init tsc_enable_sched_clock(void)
> >  
> >  void __init tsc_early_init(void)
> >  {
> > +	unsigned int known_tsc_khz = 0;
> > +
> >  	if (!boot_cpu_has(X86_FEATURE_TSC))
> >  		return;
> >  	/* Don't change UV TSC multi-chassis synchronization */
> >  	if (is_early_uv_system())
> >  		return;
> >  
> > -	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> > -		snp_secure_tsc_init();
> > +	if (tsc_early_khz)
> > +		known_tsc_khz = tsc_early_khz;
> > +	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
> > +		known_tsc_khz = snp_secure_tsc_init();
> 
> [Severity: High]
> Does skipping snp_secure_tsc_init() when tsc_early_khz is provided omit
> critical CPU capabilities?
> 
> In the pre-patch code, snp_secure_tsc_init() was called unconditionally to
> set up hardware capabilities before determining frequencies:
> 
> arch/x86/coco/sev/core.c:snp_secure_tsc_init() {
> 	...
> 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> 	...
> }
> 
> By chaining this into an else-if block, if tsc_early_khz is provided
> (e.g., via the kernel command line), snp_secure_tsc_init() is bypassed.

Which is bizarre and awful, but in practice is effectively what was already
happening, because the kernel would simply never invoke x86_platform.calibrate_tsc().

I have no objection to ignoring tsc_early_khz when running as a CoCo guest with
a secure/trusted TSC, but if we want to go that route, I'd like to do it as a
patch on top of everything else, so that it can be easily reverted if it turns
out someone is somehow depending on that combination.

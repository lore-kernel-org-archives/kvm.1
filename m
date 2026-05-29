Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14A36C5BF
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780074063; cv=none; b=Mqfm5qN6aO2692pzrc8PVI3ZVxXCGIFrU+eHdAips6jfmaxexHLRB/xiQff8HL8n1A8qaO7/W09WCAY1TP/hsMjFxrjiAImATw9wiVLrAIncF3Vgtt0lbQSd566rhhgocCYTcTO5kxB6r8G1eTZeySMkoXGLPncqGpIUHRcfNUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780074063; c=relaxed/simple;
	bh=7H128GGtnqbG/RSkM/gC5mRXamm7xUEcaHyboBL1r7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qpW+i7td1l0dlKZbWnUCoSyVVzwv8kF1hxBDYIacFBaFsUHQNdErO2lp79cL0oJ2OPa41fc6ImxX8BR/ygwlH+/nBX3Tpanl4vl4PdtDwpxvemf9GQVO21MqghfGDfiS+2VBt7BcwgbD8KnA7ccZzxcR1UdRUzIi3N27T2YH+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fm7RZHpu; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fm7RZHpu"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c857fa2706aso173936a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780074061; x=1780678861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8OtpbJnY1tjWi0GBlc3JoUE3xbaP0GTQHvl5kMixoc=;
        b=fm7RZHpuEQPD52CL/ZIhAaZSl52swfb3YpKY1KNCR+iFLhCg4SXzZpCRJ9RkNfqQID
         qEXuEyFrwMRvNRq4y4fTd+BcVXg3UpAaT1ajTPXQ4N70dqykhjlcBZaGKOibC+ZsMUey
         MvRaoC+wXWQrLArfxr/IwAOpIt83ntBlUx/j3Np+Gs2MnNIkH/JH2MxmBUaampAdrlYL
         5CtYCMaLqJcyEmJZC4LWz9HQtTg7cjpn+/iGFehDnUbmFqHVL5F2YQI2ewx6LdFE2JEF
         MeE0CsaHQoWGTfFOJZP/tikTURpT9B91qQqcfIGB+ZZ00DOUzS7ub1UgkqoyIVJ8rgoM
         ZtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780074061; x=1780678861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8OtpbJnY1tjWi0GBlc3JoUE3xbaP0GTQHvl5kMixoc=;
        b=mOMFMk+gUsWlRFhqi45FNn6rBzVPgzXzX5Rxp1mMJM/Vf+h2u8BhRoqBHXGzxbDexa
         OF9y/nnIvQYl7WDNn7GbvsKP5Az0h+H3hE8KJtC5IfWSdUR6ESta4JWVZ+yfnvsOMM20
         q/BYPC18fdamZ79Rz3TItTP3wuLvygwJdoCqh6gQTQOObLZK600LheTPogH3erK3Yubl
         fAdBPk6n7l4O+QCZmnlr0nhh8zUn/bLRkIEXASvd4AYJ9nDaF3RkReYVESxFfkbRTMvX
         hT8063TC/TVKQv6riFIdqK2GjGOoq8jea7+yFUds+5vK+EttXfWNVzWw9Rk1Lc0WOMfa
         6lnw==
X-Gm-Message-State: AOJu0YxLY7UmwsovWztmP7g0pJOIYFzG2tQaiVoKeLGV8/tRDeWxfwVe
	189RyuAFrp3yIMBrIxdQe6/Qe8BW0CGFANMW+Aj/SZ0qgdf+x5BU88/SAbScf55jLSCWk8Adjyv
	OFW1k/g==
X-Received: from pglr17.prod.google.com ([2002:a63:5151:0:b0:c80:2656:4e70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:14c:b0:3aa:f9cb:d435
 with SMTP id adf61e73a8af0-3b4280140a1mr64540637.11.1780074061246; Fri, 29
 May 2026 10:01:01 -0700 (PDT)
Date: Fri, 29 May 2026 10:01:00 -0700
In-Reply-To: <20260529164019.519101F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-10-seanjc@google.com> <20260529164019.519101F00899@smtp.kernel.org>
Message-ID: <ahnGTF5uoihLfk1p@google.com>
Subject: Re: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, May 29, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
> > index ad8f2da8003b3..0303fe6a2efa7 100644
> > --- a/arch/x86/kernel/cpu/acrn.c
> > +++ b/arch/x86/kernel/cpu/acrn.c
> > @@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
> >  {
> >  	/* Install system interrupt handler for ACRN hypervisor callback */
> >  	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
> > +
> > +	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> 
> [Severity: Medium]
> Does this unconditionally skip TSC refinement even if the hypervisor fails
> to provide a valid TSC frequency?

Gotta love Sashiko's passive aggressive "questions".

> ACRN TSC frequency is obtained via acrn_get_tsc_khz(), which queries
> cpuid_eax(ACRN_CPUID_TIMING_INFO). If the hypervisor does not support this
> leaf or returns 0, the kernel falls back to early hardware calibration
> (e.g., PIT/HPET via x86_platform.calibrate_tsc()).
> 
> Because X86_FEATURE_TSC_KNOWN_FREQ is unconditionally forced here,
> init_tsc_clocksource() will assume the frequency is known and skip the
> refined calibration phase. This regression locks in the imprecise early
> calibration and could cause time drift.
> 
> I see this regression was addressed in a later commit b0e7d8e1edd52
> ("x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ for PV code")
> which correctly gates the capability setting on known_tsc_khz != 0.

Blech, so many twists and turns.  I'll fix this by adding a prep patch to cache
the CPUID result locally and only register the hooks if it's non-zero, e.g. as
is done by VMware and KVM (later in the series).

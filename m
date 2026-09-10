Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D81560ABF
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063008; cv=none; b=WPloA4dhhhTZx0qpmAiNuUtC9doPCkn1rrPPwquAAIrm2V2lNJtyKBONG5jyJudUN/aTJgiMQzrc5q3LAiKyiaHXdZK6xRZsfTssaPl6WlGaeGWkAbUSdaO81/XutN/IVI/TlwfXJSZf/fDgHVfXGlOhsQ+YabESKF+lKaOIL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063008; c=relaxed/simple;
	bh=xLDdELpaZ92ME6nkeZN2fNUTDVi3mQx5ZlLrH57VYP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aN4712lqpJvmAG421yVygjBedB/uWu5N5vYC+Tf9BSVofRqQhsEa8ryhSSxhHbhvJJrVS4ikwqi/4EE003sD6WmYb4dYz2YzueeXWB6dMnLBrXYtC0d1j+eKOGN8zey+IttXi2mhCzLQlNFrHv53Zf/Um/RihtzwnnKL9JPnPIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tea7fuoo; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tea7fuoo"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so104385a12.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789063005; x=1789667805; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X3fQxh9g5ajoX8Y1OGK5G6oHwPA/wuRadJNv+BCxKRo=;
        b=tea7fuooeBGrrANqJxhyTk9V3lHc70XXj09YsyU6fy0rAV6AinDB/L2b6L5FId48dO
         mbw0X5bljgCDfu157xeETUhzZ992dQ6Oj3aXjIFeh61XLsIYn6iSbeuPe0f7Fctau1VE
         kdFaLlgHROL9Q4zOGxPPAdSeFPFrZmGHWWkv7hS6BnOavsvGhT8kAPDrzQMACo56nUbh
         vhRm87T2jwvhnAg2AZPt3eedPAANW5ZgaBeR0lL1mWjlNhG+6zA6AHVWXJtuLv4nL1R4
         YxTWUNtAWY5XVkoWKoB+qB7Q2Hjc2wETGtFKN3zbIcoDrARbXVnrW2spoYGM6Rv4C+53
         g0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789063005; x=1789667805;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X3fQxh9g5ajoX8Y1OGK5G6oHwPA/wuRadJNv+BCxKRo=;
        b=CtB/yPfBA2A80xlYhIihXpT8X1c9KgWdiMqScj0LM9d6wEpeV+MjhnHwwlFloyyiSX
         2hq305ZMIH06pnjjFIlpz0hLAIrtECNtDNfG06jgUx5JVlrcOmRmtiRgWohBn4tuzjHP
         VMdYC6XPwH1jgl6ifZNYxBkndJZ+76pWUqFFtyIuD2HVjJgvM1+CHXzRM0CUNiAk0mUT
         oO6r8A6HT17P2TTbAYCcbmBI8SbGxDvbwvlJK7XxI2RopEh5rUVIfj/RlMx8h9hdK3Tn
         GSjIHWpdfMy7PiVYAeLtaU+yRqIk2/aQJhB9mBIpalSGrTqFHmWlQH2d6Fi92zskPSzV
         wkLA==
X-Forwarded-Encrypted: i=1; AKwUvBxZEWnUO6X/STcqSGbm4NT56nYRZXWcYrGUjnTXHue6UUM2kM/9eB1GhXYYocd/CpSHgOk=@vger.kernel.org
X-Gm-Message-State: AFuF++ndXB3psqfzaVF5AwAgAJy9SI5zZ0Tuf4poH9dsoKX4yBE3l1fJ
	zg3Mt8OH5GlFAlw39wwxTWxr48Dqihnph1YEnjrdwGZO/BuDREL+ZY0u58HWDFW0oCM4IVQCvoc
	sqN7oiQ==
X-Received: from pgmm13.prod.google.com ([2002:a05:6a02:550d:b0:cc4:a477:43cc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:bea6:b0:3cd:9bb1:c6f5
 with SMTP id adf61e73a8af0-3daed1fa6f1mr77071637.10.1789063004860; Thu, 10
 Sep 2026 10:56:44 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:56:44 -0700
In-Reply-To: <anTB6ksbUs18FEf1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508231353.406465-1-seanjc@google.com> <anTB6ksbUs18FEf1@google.com>
Message-ID: <aqLvXM5SPPlQePXs@google.com>
Subject: Re: [PATCH v3 0/9] perf/x86: Don't write PEBS_ENABLED on KVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Stephane Eranian <eranian@google.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 06, 2026, Sean Christopherson wrote:
> On Fri, May 08, 2026, Sean Christopherson wrote:
> > Sean Christopherson (9):
> >   perf/x86/intel: Ensure guest PEBS path doesn't set unwanted
> >     PERF_GLOBAL_CTRL bits
> >   perf/x86/intel: Don't write PEBS_ENABLED on host<=>guest xfers if CPU
> >     has isolation
> >   perf/x86/intel: Don't context switch DS_AREA (and PEBS config) if PEBS
> >     is unused
> >   perf/x86/intel: Make @data a mandatory param for
> >     intel_guest_get_msrs()
> >   perf/x86/intel: Invert names of intel_ctrl_{guest,host}_mask
> >   perf/x86: KVM: Have perf define a dedicated struct for getting guest
> >     PEBS data
> >   perf/x86/intel: KVM: Handle cross-mapped PEBS PMCs entirely within KVM
> >   KVM: VMX: Drop a redundant pmu->global_ctrl check when processing
> >     pebs_enable
> >   KVM: VMX: Only tell perf to enable PEBS counters for fully enabled
> >     PMCs
> > 
> >  arch/x86/events/core.c            |  5 +-
> >  arch/x86/events/intel/core.c      | 92 +++++++++++++++++++------------
> >  arch/x86/events/intel/lbr.c       |  2 +-
> >  arch/x86/events/perf_event.h      |  7 ++-
> >  arch/x86/include/asm/kvm_host.h   |  9 ---
> >  arch/x86/include/asm/perf_event.h | 11 +++-
> >  arch/x86/kvm/vmx/pmu_intel.c      | 28 +++++++---
> >  arch/x86/kvm/vmx/vmx.c            | 10 ++--
> >  arch/x86/kvm/vmx/vmx.h            | 15 ++++-
> >  9 files changed, 114 insertions(+), 65 deletions(-)
> 
> Ping.  This still applies on Linus' tree and against tip/master.

Ping again.  This fixes a real issue and IMO provides much-needed improvements
for the KVM<=>perf APIs.

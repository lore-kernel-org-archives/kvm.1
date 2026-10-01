Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B32D12EE
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897888; cv=none; b=UKEQcPZ5Vza+pTh7mSFRi0vxc1wHVPtbNHe564MYK0obgmK88hSpP/h4Jg+Me5FrN+CoNAHzg3bzXkddHGvNkJHuEwsfaSE6ZbTQ2SkZlnkRRWQbtGeFXHivj0DOL2ebtGYK4S6m34+0c1/zTMJXoWgTrZc2hv8C+J/YtlARb3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897888; c=relaxed/simple;
	bh=fVE8q1hu6cM1+AbWh3Kf6dl1yrDon73waTO3NY+RGWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h6/xiOSgS/AmOqhidETL3uFKzHZqEtkA8jbRLghV0w76crX9VqEnkNsHC25B0jamGW9G9J29t1jrIIEFJFInCnule0JPD76Rko5/9lBM3J0r95olnqm45SUUTiEiFyIRsjbtMS2VB4IBVaBkQUKJxv2QNtBXw5k3GzYlKiCP9qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cug73maS; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cug73maS"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso4920496a12.1
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790897886; x=1791502686; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nkYu0dzogE5uOyvmD8EqBPbrotViITXGWpbRHU0KqU=;
        b=cug73maS73uERNEe9BsRf8b2tBLFqbHIVI9gUVnhObpDQfZV1dBZMDNfW/aj9Sxi+D
         ouCXzFYZPmS0czY1wHl3OnII8S3+oFBeXLVqxKmMYReUU6cOkRenqdUbShpuZdyt4URR
         /6el3cofOKpv79HCXJMaJ/K6+AnaaQxX31JEajIg9vfr7wsyVCvxls0sEspqpZwuanXr
         ed0sqJ07L4TSReCeicOF+OpqQx+xcr7w0kMGELepazCEiMTXIxl/p3hkTYZ1fL8kKzBy
         OyltQl1Hwtj9jJRSq19aM9HRxRFhJ9b8qt34RCTVN21WW/e7COJWNCxO/F/lq/xYjvX+
         U5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790897886; x=1791502686;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6nkYu0dzogE5uOyvmD8EqBPbrotViITXGWpbRHU0KqU=;
        b=wBf6GRI3ak2hGo1+PxgEpUHnjWF73ZiOpP1zxRmM06tuP4aSRAT2tIG+Uvt+hvZJv4
         uokeowMUj+nf+amaBZy/bSKrKswT+H2/7B8h4KMyLztyidLQAvxlohTAmFQDx4WDU0Vf
         3M4yuYDPM9hiN0QDnxHjPbLpci3Nd64QSXVZCM7EgEhYI9bkGCQgFGhtKHxQSXXGTLYs
         4DIfWIUMcL2OGs3SFPpx5gZy3NVOX3gx0hr603yPxqAS6QzVymVHKSdqMm3jMtT7rtHL
         mYCmBdjA+7DHGDtEs8Zku/FXBI+ogyQvfvuccBzDIjv9wo8BpT6We39RiKlfrKICkUgq
         PNUg==
X-Forwarded-Encrypted: i=1; AKwUvBxX9ii4SLZy8sXT9MWKbTJ5kw9FpbDLtfuTUKyDGbi5znRgxrcv4a4iHkjYbZIsIyIsS18=@vger.kernel.org
X-Gm-Message-State: AFuF++kRg+2rdseDTwtIeVS7e1sX7DvVdD3Se3lo1KT39RJ8I2zd7lZK
	CivHU/cEKIqpaLT6VobT4qRP7bDGvr8mEa1kNXiUTANd/xj6S2BBcf7FqJJpo3HK3gWS/FHEH4+
	ozge9tQ==
X-Received: from pgbfq17.prod.google.com ([2002:a05:6a02:2991:b0:cc7:9b89:2a72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1f89:b0:3dd:a197:7359
 with SMTP id adf61e73a8af0-3e0bd0193b8mr903872637.50.1790897886101; Thu, 01
 Oct 2026 16:38:06 -0700 (PDT)
Date: Thu, 1 Oct 2026 16:38:05 -0700
In-Reply-To: <2dd84890-3c21-4942-a9e4-8e07408620d3@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930210201.3482775-1-seanjc@google.com> <2dd84890-3c21-4942-a9e4-8e07408620d3@amd.com>
Message-ID: <ar7u3WBuxUncIzHc@google.com>
Subject: Re: [kvm-unit-tests PATCH] x86/pmu: Treat all AMD CPUs as having
 instruction/branch overcount errata
From: Sean Christopherson <seanjc@google.com>
To: Sandipan Das <sandipan.das@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 01, 2026, Sandipan Das wrote:
> On 01-10-2026 02:32, Sean Christopherson wrote:
> > diff --git a/x86/pmu.c b/x86/pmu.c
> > index b262ea59..35f8a818 100644
> > --- a/x86/pmu.c
> > +++ b/x86/pmu.c
> > @@ -222,13 +222,8 @@ static void adjust_events_range(struct pmu_event *gp_events,
> >  	 * If HW supports GLOBAL_CTRL MSR, enabling and disabling PMCs are
> >  	 * moved in __precise_loop(). Thus, instructions and branches events
> >  	 * can be verified against a precise count instead of a rough range.
> > -	 *
> > -	 * Skip the precise checks on AMD, as AMD CPUs count VMRUN as a branch
> > -	 * instruction in guest context, which* leads to intermittent failures
> > -	 * as the counts will vary depending on how many asynchronous VM-Exits
> > -	 * occur while running the measured code, e.g. if the host takes IRQs.
> >  	 */
> > -	if (pmu.is_intel && this_cpu_has_perf_global_ctrl()) {
> > +	if (this_cpu_has_perf_global_ctrl()) {
> >  		if (!pmu.errata.instructions_retired_overcount) {
> >  			gp_events[instruction_idx].min = LOOP_INSNS;
> >  			gp_events[instruction_idx].max = LOOP_INSNS;
> > 
> 
> Commit 61a7ee521d ("x86/pmu: Handle instruction overcount issue in overflow
> test") makes measure_for_overflow() always return 1 - LOOP_INSNS (-10000016)
> when pmu.errata.instructions_retired_overcount is true. For runs without
> "perfmon-v2" on a Zen 5 system, I see that the overshoot from this preset value
> is between 125 and 135,

Heh, I was going to say "woah, that's a lot of exits!", then I realized the
loop does a million runs...

> which makes the following condition in check_counter_overflow() fail.
> 
> 	report(cnt.count == 0xffffffffffff || cnt.count < 7, "cntr-%d", i);
> 
> How should we handle this?
> 
> Restrict the condition in measure_for_overflow() to return 1 - LOOP_INSNS
> if (pmu.is_intel && pmu.errata.instructions_retired_overcount)
> 
> or, accept a larger overshoot.

Doesn't it have to be the latter?  Because won't the test fail if the first run
of __measure() from measure_for_overflow() takes more exits than the second run
of __measure()?

> diff --git a/x86/pmu.c b/x86/pmu.c
> index 35f8a8183a..74e30b149d 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -584,6 +584,8 @@ static void check_counter_overflow(void)
>                         else
>                                 report(cnt.count == 1, "cntr-%d", i);
>                 }
> +               else if (pmu.errata.instructions_retired_overcount)
> +                       report(cnt.count == 0xffffffffffff || cnt.count < 150, "cntr-%d", i);

Do you have any idea where the 0xffffffffffff check comes from?  Commit b883751a
("x86/pmu: Update testcases to cover AMD PMU") doesn't explain it at all.

Depending on what's up with the 0xffffffffffff thing, my vote would be to go big
hammer, and express the overflow as a fraction of loop instructions, e.g. allow
for an extra 200 exits:

		if (pmu.errata.instructions_retired_overcount)
			report(cnt.count < N / 5000, "cntr-%d", i);
		else
			report(cnt.count == 1, "cntr-%d", i);

>                 else
>                         report(cnt.count == 0xffffffffffff || cnt.count < 7, "cntr-%d", i);
> 

Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7664725B0BD
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782257608; cv=none; b=nOAeOXJ1I8/J6ufsvhIVUTCv/7AiQ4YoAyek2xz6Ymy73FCQGulZ/Evbap84kUTtmCbOs6oewATIDDU0DT7UOqxXecWvVfzMJGmbl3B8FepYy93JiCFZ4oJj3uUg/KSuwCkHSJvhuezEL5ayc7lo1+4UC+kUZTcMDCWz7lQa7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782257608; c=relaxed/simple;
	bh=60ZeMLqR1meAEfO9RRi8lX/tJE2bPwVhorIaZg2y838=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkQY9RpWTju6iLkonjHVXNjfa1chkk8KIlo3lKtxz2EeCISLaF5yuF6/9dWa19QSFglhjfxpFl/LsfAeJfnWMrn2h5ho3ooQ0fCgFqn1TRKiIG6W09xdVqYzjYveAR1Ke/pZ2SjL45AVM7r/MRr1O4avoOB1VAlKsVfq4g52pcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSLrwmW/; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSLrwmW/"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c891ed872ddso235657a12.2
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782257607; x=1782862407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKcrqLB4jp/lrEWHBH06nGLJwYcOrB0oXIswwGe6IE=;
        b=SSLrwmW/IsHq02hTpp5QJ4tz5xlecawRWZlj/XVh53zFICGXDbyGAPcvBkDzAid7/j
         TQUKrjuBWdmttBxdhg8MVpDWnzqT5PLAGOQaRnXB0pLNmcHW6kLioFXgGX43TcYgnSRA
         AW54/P1DinKYuhbf3R/O9nPo+7tGqlo3DVBlJ7WGPWYQf50EMun04xOA7YYZgkt5fqaT
         Z3h6bPTKV2Tz6xeZXmprufgOZcz6pRu3P/7x/oPmtqZJNyYGk8IypoSLT8RQxxC6ynbg
         QwaQU+4KZryfyxFJJHqlsA3tIHm5Aho2X1VhIAm8x+obnShpAumlyYwfowppIKrLCfwx
         70Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782257607; x=1782862407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFKcrqLB4jp/lrEWHBH06nGLJwYcOrB0oXIswwGe6IE=;
        b=srfOxuLW4Uqd57aWfYY8tUTcd5AzufTCMznWhPfO3ep/f5AKMJAOdoUDkaRVVFdyn3
         9O04+zogL+BBWvtuHO72wFuoP0Cx/u82H19JxxyYXsQzwLTU4Mf1snvWuzHkBlj/LxEJ
         5pBaOdLZcVN+pFWqQ+S6SOalXtuORWG+hYXdtp4cBhVYgjAYv+fnGhzZd4xSrn7indJU
         570sFIRxVYOFIBUtRHwkf+1P4MPMQFj9iywK6olWdjuhDlx+DtNr0JZUGRIDiWiaBjYt
         W3TH/3mije0SkayJbuRCxVSFB5Uum9VIYeAuHIRRdA9PStV3gZZu4iIvKCNINqYE4TXG
         /zaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MMcE35Hjc/8jvdj6V28uIOizodERXy49AzP3xRasIkIvzmBB4mjALLYLtihItRz/WgYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbABw3LAjZcgSgrDSgsBjwMYBd5bdeWxUXxz/wsTQH2sTcWV3q
	HF4ybSwayd8A1t8bUrWBrZSubXa/J4HMzv2fIyOMuEi/pZcFAfKpRIQrMzUytpQtbIy4CgZ9b+Q
	KGUZMVA==
X-Received: from pgmc22.prod.google.com ([2002:a63:1c56:0:b0:c88:dea2:d511])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:117:b0:39c:787:f197
 with SMTP id adf61e73a8af0-3bc53af1770mr18759206637.36.1782257606531; Tue, 23
 Jun 2026 16:33:26 -0700 (PDT)
Date: Tue, 23 Jun 2026 16:33:25 -0700
In-Reply-To: <bcbc4f64-60e9-46a8-bf63-19e7d9d30595@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623041927.178256-1-zide.chen@intel.com> <20260623041927.178256-4-zide.chen@intel.com>
 <20260623044826.592FF1F000E9@smtp.kernel.org> <bcbc4f64-60e9-46a8-bf63-19e7d9d30595@intel.com>
Message-ID: <ajsXxXHz-oIcSXDE@google.com>
Subject: Re: [PATCH V4 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 23, 2026, Zide Chen wrote:
> On 6/22/2026 11:48 PM, sashiko-bot@kernel.org wrote:
> >> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> >> index 59b7a90c79e12..2c3367f5e2dfb 100644
> >> --- a/arch/x86/kvm/vmx/pmu_intel.c
> >> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > [ ... ]
> >> @@ -345,6 +347,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
> >>  		msr_info->data = pmu->fixed_ctr_ctrl;
> >>  		break;
> >> +	case MSR_PERF_METRICS:
> >> +		if (!msr_info->host_initiated)
> >> +			return 1;
> > 
> > [Severity: High]
> > If KVM needs to emulate a guest RDMSR instruction targeting MSR_PERF_METRICS,
> > won't this unconditional return inject a #GP fault into the guest?
> 
> I can't think of a case that KVM needs to emulate RDMSR/WRMSR on
> MSR_PERF_METRICS.

If the literal emulator happens to emulate a RDMSR/WRMSR, KVM should behave
correctly.  Even if that weren't the case, KVM's implementation should adhere to
the architecture.  Assuming MSR_PERF_METRICS is read/write, KVM should emulate
it as such.

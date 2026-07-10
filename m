Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6763DB651;
	Fri, 10 Jul 2026 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695165; cv=none; b=mQAiJ0PG6Ed4wP8Qfj3hjfrJRnULD2sj2oOHmEg6vX32aIEMlclcYWPMt4m3/SC2HELyM0tMHTd7cxxlHINVJqsPyldodQBDyW5EMiqAXkaT2Xr0TOQmOPniPrXaPHiPAeWEYRZxihplb2pBxFQbk9fyOiMggeY4rFeGq9x+NlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695165; c=relaxed/simple;
	bh=ZSkyfDwgP4cABwa0taKafeJbCRSvNiogxsN4H3f1qoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXnsQ2r2H88dHivrtCxwMdaQ1kKNxzFUqjQygAuPNfovNm3MTmJoH/t8E4AVatqAJCbdOOg73uSyLeKJaYN8QJDEse1yiDmbNeTQqh1i1y97dI+Of3/hUtTZ59Ty4G/ZKBv4lQ8H4ZoDpokgM82ng6ZOvDxpwv0FxyHHIXIPlcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M6EXBQDW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M6EXBQDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783695164; x=1815231164;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZSkyfDwgP4cABwa0taKafeJbCRSvNiogxsN4H3f1qoU=;
  b=M6EXBQDWVYSuL2uyTT/veDMhGA/qSnx+l371AuRVxLqCnkwEOJPTo5KN
   79OZXnSMQC6WsbtVxxWBmhoBwRD+bocrGFY5NXEVLaIR+iXoGuTQ2PotF
   trjJiuFabcFD77vNMASqrsBfw6ltGg3YcZjmqXZcaWGkKcMrQEpXKeFse
   8uGxNinOV5+HYieMDv76UGEvxAXoKqS5Sq19IWD5k6ORexHacFiHN6JiA
   Mh33zmiy3AULtKAfbEa4bGHmm+QpcJ9dOHAbn19fUZVLL9svj+nSpokdw
   D+6jGPiVsNnEPtNGGVsNhNEdCw5jhHM0KgngAPtIpZBS7YNwH5V18ytss
   Q==;
X-CSE-ConnectionGUID: gHSlBDQLT1afl4YEpZwwmA==
X-CSE-MsgGUID: SPZR2F9xTNi1jD9OGOdEEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83513216"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83513216"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 07:52:43 -0700
X-CSE-ConnectionGUID: G4GIBUgiR8K5NcD4spfuaw==
X-CSE-MsgGUID: GLItZtA5SimNlh/s/YqgGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259221641"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 07:52:43 -0700
Message-ID: <75a229a6-66b8-4127-b97a-b3861a6528de@intel.com>
Date: Fri, 10 Jul 2026 09:52:41 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com>
 <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/10/2026 3:08 AM, Mi, Dapeng wrote:
> 
> On 7/9/2026 8:35 PM, Jim Mattson wrote:
>> On Mon, Jun 29, 2026 at 7:36 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>
>>> On 6/30/2026 7:19 AM, Zide Chen wrote:
>>>> Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
>>>> support for Topdown (TMA) Level 1 metrics, enumerated by
>>>> IA32_PERF_CAPABILITIES[15].
>>>>
>>>> Only check for non-zero metrics, as they are derived and depend on
>>>> the workload, CPU model, and host scheduling, making precise
>>>> expectations fragile.
>>>>
>>>> Extend the PMU selftest to cover Intel fixed counter 3 by bumping
>>>> MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
>>>>
>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>> ---
>>>> ...
>>>> +static void __guest_test_perf_metrics(void)
>>>> +{
>>>> +     int retiring, bad_spec, fe_bound, be_bound, sum;
>>>> +     u64 global_ctrl, metrics;
>>>> +
>>>> +     if ((guest_get_pmu_version() < 2) ||    /* Does guest have GLOBAL_CTRL? */
>>>> +         !this_cpu_has(X86_FEATURE_PDCM) ||
>>>> +         !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
>>>> +             return;
>>>> +
>>>> +     wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>>>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
>>>> +     wrmsr(MSR_PERF_METRICS, 0);
>>>> +
>>>> +     /* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
>>>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
>>>> +     global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
>>>> +                   PERF_METRICS_GLOBAL_CTRL_ENABLE;
>>>> +
>>>> +     GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
>>>> +
>>>> +     /* Check test results. */
>>>> +     metrics = rdmsr(MSR_PERF_METRICS);
>>> Could we use rdpmc instead of rdmsr here? rdpmc is a preferred way to read
>>> counter value.
>> This is in-guest code, so the unintercepted RDMSR will be much faster
>> than the emulated RDPMC.
>>
>> Should we rethink that preference, or add hardware support for
>> selective RDPMC intercepts?
> 
> Hmm, in current most cases, rdpmc and rdmsr should share consistent
> interception configuration for PERF_METRICS except host and guest have
> different counters bitmap.
> 
> Considering this is a test case, the test coverage should be more important
> than the performance, there should be at least a place to call rdpmc
> against the PERF_METRICS, otherwise, that path won't be validated. 

How about keeping rdmsr() in __guest_test_perf_metrics(), and using
RDPMC in the sanity test?

@@ -369,7 +371,7 @@ static void __guest_test_perf_metrics(void)
        GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
        wrmsr(MSR_PERF_METRICS, 0xdeaddead);

-       GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
+       guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0xdeaddead);
 }

> 


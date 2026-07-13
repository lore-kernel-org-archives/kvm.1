Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED090239E6C;
	Mon, 13 Jul 2026 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925883; cv=none; b=l5dGYLp6VNxEeXGo+gEXim0shSZ8mBzlM8P+YEnx0rr8Un1+MYwvh2rlD4/qJ5V3cdchKqCDTPQmy6obyOLtrBcyW9s4Ide9VsYQpvw+GRBfyfSRDGKBnWN73el1n4gL+y/SizwnaD0TZhfGx2IRrUBy5bQ5zrcBb64kk76Uw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925883; c=relaxed/simple;
	bh=VjYCTy3yxBYc4gK/Y8TYa6taGKRucPYCSPDoxsICp2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rbSq/m2Ovs/mCU5kvbcw5SyCza7/frx4+rv96DNwvwjgMmDw0P1oXqxH6r1zs9cHxuTDQBhb96voOSWhuQP85+S5Cxuwjgl0iIbDnzh2AfZCOm0Yv7uMGIkX01ruM7ujIn1D2zVOwyxEil/apqxEG3K7vXsKwKXBZTj8XatpGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGQEgn1o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGQEgn1o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783925881; x=1815461881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VjYCTy3yxBYc4gK/Y8TYa6taGKRucPYCSPDoxsICp2Q=;
  b=AGQEgn1oPeJpd7FV3SoYnOZqmMUQRNR7/yvHFYJOd9B1nJKgfmco6CYT
   PQQozrX/hh0IV2210jjewgpSH1hWZI3uMfvlJSAri5FGcuNDvV+EdzJcd
   plt+JxIcTaxmAfpgiph8rLy/+kvFCF/wI8pv38xICQbVGBH+u3z1FwccA
   ipT50qKzqNbs/4h4TkncbONAOk/iBzO2e1LM/95VbAAW5lbMBxuE8lz/V
   J6nhGdnENCdPJt8qlrvJftBk4cQMWr0lF2frxYD94kN8NIFumdlXc82TB
   9nqekDr7IocapN2WVjRD3ug9WKuOFE4lqfD7HP/s08SrgT1l5jnh4ANM7
   g==;
X-CSE-ConnectionGUID: jSL2+1mFRBOmMTwyUhD8Lw==
X-CSE-MsgGUID: SCO2frepRlegBqeb9e/zjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95675594"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95675594"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:58:01 -0700
X-CSE-ConnectionGUID: oTiQSTKLS06/LkAWlEY2PQ==
X-CSE-MsgGUID: mBI3fvEOTUOECHgHZyglKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278726482"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:57:57 -0700
Message-ID: <4d3ec192-ad9d-41ff-ae18-7ee8b0948bc1@linux.intel.com>
Date: Mon, 13 Jul 2026 14:57:55 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: "Chen, Zide" <zide.chen@intel.com>, Jim Mattson <jmattson@google.com>
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
 <75a229a6-66b8-4127-b97a-b3861a6528de@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <75a229a6-66b8-4127-b97a-b3861a6528de@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/10/2026 10:52 PM, Chen, Zide wrote:
>
> On 7/10/2026 3:08 AM, Mi, Dapeng wrote:
>> On 7/9/2026 8:35 PM, Jim Mattson wrote:
>>> On Mon, Jun 29, 2026 at 7:36 PM Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>>>> On 6/30/2026 7:19 AM, Zide Chen wrote:
>>>>> Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
>>>>> support for Topdown (TMA) Level 1 metrics, enumerated by
>>>>> IA32_PERF_CAPABILITIES[15].
>>>>>
>>>>> Only check for non-zero metrics, as they are derived and depend on
>>>>> the workload, CPU model, and host scheduling, making precise
>>>>> expectations fragile.
>>>>>
>>>>> Extend the PMU selftest to cover Intel fixed counter 3 by bumping
>>>>> MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
>>>>>
>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>>> ---
>>>>> ...
>>>>> +static void __guest_test_perf_metrics(void)
>>>>> +{
>>>>> +     int retiring, bad_spec, fe_bound, be_bound, sum;
>>>>> +     u64 global_ctrl, metrics;
>>>>> +
>>>>> +     if ((guest_get_pmu_version() < 2) ||    /* Does guest have GLOBAL_CTRL? */
>>>>> +         !this_cpu_has(X86_FEATURE_PDCM) ||
>>>>> +         !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
>>>>> +             return;
>>>>> +
>>>>> +     wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>>>>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
>>>>> +     wrmsr(MSR_PERF_METRICS, 0);
>>>>> +
>>>>> +     /* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
>>>>> +     wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
>>>>> +     global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
>>>>> +                   PERF_METRICS_GLOBAL_CTRL_ENABLE;
>>>>> +
>>>>> +     GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
>>>>> +
>>>>> +     /* Check test results. */
>>>>> +     metrics = rdmsr(MSR_PERF_METRICS);
>>>> Could we use rdpmc instead of rdmsr here? rdpmc is a preferred way to read
>>>> counter value.
>>> This is in-guest code, so the unintercepted RDMSR will be much faster
>>> than the emulated RDPMC.
>>>
>>> Should we rethink that preference, or add hardware support for
>>> selective RDPMC intercepts?
>> Hmm, in current most cases, rdpmc and rdmsr should share consistent
>> interception configuration for PERF_METRICS except host and guest have
>> different counters bitmap.
>>
>> Considering this is a test case, the test coverage should be more important
>> than the performance, there should be at least a place to call rdpmc
>> against the PERF_METRICS, otherwise, that path won't be validated. 
> How about keeping rdmsr() in __guest_test_perf_metrics(), and using
> RDPMC in the sanity test?
>
> @@ -369,7 +371,7 @@ static void __guest_test_perf_metrics(void)
>         GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
>         wrmsr(MSR_PERF_METRICS, 0xdeaddead);
>
> -       GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
> +       guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0xdeaddead);
>  }

Yes, it looks good for me. guest_test_rdpmc() can cover both the
interception and pass-through cases for rdpmc. 


>

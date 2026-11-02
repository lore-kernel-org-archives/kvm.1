Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641137;
	b=Ly7SUOhFpqf1cidIcZp6fa5pZn+40Jm4LcayaV6+iCXo75SIMwBo0/pYsWfN9vqrtAVi
	 IdctJjsAmefNUlMglJcicyhLlIusGmJflT9E/ffvLvfmf0f6aSTwbDi6cyHe8DNoF4Y0L
	 fcvdgkLNPyhhX5ySF0qbRRPQlnA3/MpwB0HwhLk4igRiFZFnIyTcHjBnDNJBzM9B6x+XK
	 cXNzKbvd/haBENvZOJvooidBr/SFtwSDZ7bYzKCHvg0qFZw8XrjIix9U/s/9NoEhSihgc
	 zPq4/TGDthztVvmqW8kGSxJHPByJjBSWUmdCVC6YdzYc2OSlN4yi9QNmQFmnxynwd/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641137;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EtHURPyBuVT/RzDl6b0UYWncJlvUP04MUiLmGHTRNCs=;
	b=WiZu1OcdGE/w4qKWbxzJWcKc5Lt+s07qHTELybLVCGkADrHMajqNjetOuGHivpi/Tr6M
	 2ZVCO9pmCB6biRUZt4UFsZ91pP/T8bJ33w/SZx/x+gpemhhjn+B4P4WexHkmjAUok0bUr
	 UARlSTWK2cEDA43aDfHDBC7I8MZCf8iXe+hE9QnXkEPs4gvztTfaFYHEVlLPwcZd88uKm
	 qH76EU4jfLx5UqDPdqahCgYUB+WYw5hTTNP+VeQT/yYgGEhVVWkRdE4Ivo3H1PccMo8DE
	 zHZG2fdp6WsBapDOle+48hK4Rl5If3MqolK8KHA3XjdALRBxr8sDf2U0wTGIertmhfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZkpmqGsf;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686EA606A33F;
	Mon,  2 Nov 2026 17:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 686EA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZkpmqGsf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793641136; x=1825177136;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bZOIIBXYV74zrsyt+L3ACO1GNpToLKZJ3ppCmQf6EYo=;
  b=ZkpmqGsfnHNJsrDqAKVjnKWm9qyH8GFaCBXZwwc1q9JPT9eFR9TOrRSv
   sjsNI+pwRD2eEf154BoKYJvsa6XiLIWuHI3euPBEoNCfi3B5z4kPm38V8
   FXaorZ9U2M9FtOLmweLg8xcJghMhc50Q2bWQC83oyEi9MJMt2VM5D5aN+
   xuoxlb/tI/HtKF5EcZleDcuT4qtI6mHimXIsk27jDJd2CY5HVI4Byl/mQ
   mpi+ajmmi3hKJ3Zu2U+WVgun+ybJEJRWphX1FELo/8jJpZooExkhtLvo8
   v0ZL8yHVzaIt9Ic6kxo8YO5BG7giAdxJ0hCT+zamWBcViHUSKDsGvQUyK
   g==;
X-CSE-ConnectionGUID: mPd32t1US26lJYRtFa2yTQ==
X-CSE-MsgGUID: JH5SwAbYTwSIKq+nZl/WcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2227264"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2227264"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:38:56 -0800
X-CSE-ConnectionGUID: nywL0X0FSyiDYVEN6ERyTg==
X-CSE-MsgGUID: vwOkkRtGRnWdxgsO+GvTrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6292462"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:38:55 -0800
Message-ID: <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
Date: Mon, 2 Nov 2026 11:38:53 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <auUQgRVFASkWtkoK@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/2026 5:13 PM, Yosry Ahmed wrote:
>>> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>>                 msr_info->data = 0;
>>>                 break;
>>>         default:
>>> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>                 if (!msr_info->host_initiated)
>>>                         pmu->global_status &= ~data;
>>>                 break;
>>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>> +               if (data & pmu->global_status_rsvd)
>>> +                       return 1;
>>> +               if (!msr_info->host_initiated)
>>> +                       pmu->global_status |= data;
>>> +               break;
>>
>> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"),
>> IA32_PERF_GLOBAL_STATUS.CondChgd[bit 63] cannot be set by writing to
>> IA32_PERF_GLOBAL_STATUS_SET, because IA32_PERF_GLOBAL_STATUS_SET[bit 63] is
>> reserved.  In other words, it is not possible to save/restore
>> IA32_PERF_GLOBAL_STATUS when bit 63 is set.
>>
>> Because bit 63 is clear in pmu->global_status_rsvd:
>>
>> 1. An intercepted guest WRMSR(MSR_CORE_PERF_GLOBAL_STATUS_SET, BIT_ULL(63))
>>    succeeds instead of injecting #GP(0) and sets bit 63 in
>>    pmu->global_status.
>> 2. When bit 63 is set in pmu->global_status (whether it was set by
>>    kvm_pmu_set_msr() or by intel_mediated_pmu_put()), the next
>>    intel_mediated_pmu_load() will try to write an illegal value to
>>    MSR_CORE_PERF_GLOBAL_STATUS_SET. I don't think we get a #GP, because
>>    every wrmsr is "safe" these days, but the write will be ignored.
> 
> On SPR, it does produce a #GP that gets ignored (and logged) and the bit
> is not set.  Interestingly, on CLX, the write goes through and the bit
> is set. Didn't check other CPUs.

Good catch! I tested a few more CPUs (DMR/CWF/SRF/GNR/NVL/LNL), and all
of them #GP on writes that set bit 63.

However, SKX, CLX, and ICX accept writes with bit 63 set and do not
generate #GP. On those systems, bit 63 also becomes visible when reading
back GLOBAL_STATUS. This behavior is documented in their errata:

SKX95/CLX89/ICX166. Bit 63 of IA32_PERF_GLOBAL_STATUS_SET MSR (391H) is
reserved. Due to this erratum, setting the bit will not result in #GP.

SKX:
https://cdrdv2-public.intel.com/336065/336065_Intel%20Xeon%20Processor%20Scalable%20Family%20Public%20Specification%20Update_rev17.pdf

CLX:
https://cdrdv2-public.intel.com/338848/338848_2nd%20Gen%20Intel%C2%AE%20Xeon%C2%AE%20Scalable%20Processors%20Specification%20Update_Rev028US.pdf

ICX:
https://cdrdv2-public.intel.com/637780/637780_3rd_Gen_Xeon_Scalable_Spec_Update_026US.pdf

Given that SKX95/CLX89/ICX166 document this behavior as an erratum,
while SPR and newer CPUs appear to follow the SDM and #GP, should KVM
continue to inject #GP for writes that set bit 63?


>> OTOH, what about PerfMon v4 bits 58 (GLOBAL_STATUS_LBRS_FROZEN), 59
>> (GLOBAL_STATUS_COUNTERS_FROZEN), and 61 (GLOBAL_STATUS_OVF_UNCORE)?  Per
>> Intel SDM Vol. 4, Table 2-2, those bits are valid in
>> IA32_PERF_GLOBAL_STATUS, IA32_PERF_GLOBAL_STATUS_RESET, and
>> IA32_PERF_GLOBAL_STATUS_SET when CPUID.0AH:EAX[7:0] > 3.
>>
>> When those MSRs are passed through in mediated mode, the guest can set bits
>> 58, 59, or 61 in hardware via IA32_PERF_GLOBAL_STATUS_SET. Leaving those
>> bits set in pmu->global_status_rsvd for pmu->version >= 4 will break
>> KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) as well as any intercepted guest
>> writes to GLOBAL_OVF_CTRL / GLOBAL_STATUS_SET.
>>
>> As I pointed out in patch 04/16, we can't pass through the PMU global
>> controls unless their reserved bits match hardware.
> 
> I think there are two other relevant (but pre-existing) problems here:
> 
> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
> guest. If a host PT PMI arrives while the guest context is loaded, bit
> 55 will be set for the guest, and the guest won't be able to clear it if
> OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
> Similarly, the value can't be restored through KVM_SET_MSRS.

I think mediated vPMU assumes that no host PMIs can be generated while
guest PMU state is loaded.

If PT state can leak into the guest via bit 55, similar leakage can also
occur for other status bits, e.g. when the guest exposes fewer
general-purpose or fixed counters than the host.

The scenario where both host and guest can be active simultaneously is
handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
filter guest-owned status bits.

https://lore.kernel.org/kvm/20260821222002.54907-1-zide.chen@intel.com/T/#m90394fda6d71ed0dd539a579abfb0c1df1e044fe

> (I think the PMI may also be lost as LVTPC points at the mediated vPMU
> vector)
> 
> 2. On AMD, bit 58 and 59 have a similar problem. HW accepts those bits
> but they are reserved for the guest, so the guest can set them if
> GLOBAL_STATUS_SET is passed through, but userspace cannot restore them.

Right. That seems orthogonal to this series and could be addressed with
follow-up fixes.

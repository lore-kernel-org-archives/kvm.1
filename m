Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F28128469F
	for <kvm@vger.kernel.org>; Thu, 18 Jun 2026 02:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781749297; cv=none; b=VbnRdPX8OLyMS7XXC6kgqxpgyONRa4/hhBHlYUi3Tz8vpVJm6B/UttUmfsyDd+TCCrhGCvPzURJeC766ynMGaVSAbLL2iK/gFCjacvxudmnjZDun8W4j7Ju0RK6BFfOMMLjvbuie7HPTZEfNgAc3nqCDUABYXQuYOuQ1Tcf77+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781749297; c=relaxed/simple;
	bh=7ZlSTveinR0pjpLMclMmhj+u2tPYKB+Pfup8wdUyqfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abm6UB8BfTmHBia86MmnhtymLVwFEIyFl4wEo+X4ApkjVUFr+Nbx9sPH4bnRfFC5UCX05JX+9qGVID+LtMIJZ7BEVLzxj09Ndynnz83jR2ehzTQrvDQlP3V1lhVoTpx8hjRCQRdL4v+MKzc2dNEUKiBHFjolGvzN6kaDjn+21Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtzSLs5V; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtzSLs5V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781749295; x=1813285295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ZlSTveinR0pjpLMclMmhj+u2tPYKB+Pfup8wdUyqfU=;
  b=BtzSLs5VZkUvHL2wkioPrIQDB9/8/gqkFaKR1pmmsaQLW39ckYxxWlcH
   /xQ3dqPoNE+D2zVABea2aM5RvvvnzWbdytoCiFAqafVGkQsNX03qw42R7
   8NvE3cYrp/0GErtTuQqaZDS69Ld8+NHTYGbzBgGNO7LvmbaBs7vnUhgEo
   SZJUlqNBFNULVphw1lLzq6YSJ/krbTtVpLZPFTu5x81hO5lv+baogF6fQ
   4wwXjQpAvrpE+omOez7RQ6aupGwSVMHORPTa4mh4PYCoVSn6DsBRMecGX
   u8CVRzmu5m0Idr9o0FjtketFBb7WtAfRfeDpqwF9cqCzR1TaKuVWXIGob
   Q==;
X-CSE-ConnectionGUID: c+r1OYgSQVWrcLAmQY21lQ==
X-CSE-MsgGUID: G9U0GTjBQCu6uOnGkqyYsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82577694"
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="82577694"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 19:21:35 -0700
X-CSE-ConnectionGUID: F/IQLI63RbmQ+hoK7WwX5A==
X-CSE-MsgGUID: /ZbTDrSCQhuensFWeKAj9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,210,1774335600"; 
   d="scan'208";a="247343372"
Received: from unknown (HELO [10.238.3.104]) ([10.238.3.104])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 19:21:34 -0700
Message-ID: <ba9eead0-371a-4720-ae9d-e84993c7253c@linux.intel.com>
Date: Thu, 18 Jun 2026 10:21:31 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: "Chen, Zide" <zide.chen@intel.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260615230118.50718-4-zide.chen@intel.com>
 <20260615232619.BBF811F000E9@smtp.kernel.org>
 <5e03d30e-b33b-476e-b7e6-8ff4979ff8db@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <5e03d30e-b33b-476e-b7e6-8ff4979ff8db@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/17/2026 12:29 AM, Chen, Zide wrote:
>
> On 6/15/2026 6:26 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [High] Guest-reachable WARN_ON_ONCE assertions in MSR_PERF_METRICS accessors allow unprivileged guests to trigger host-side denial of service.
>> - [High] Software updates to MSR_PERF_METRICS via KVM ioctls or VCPU reset are silently clobbered by stale hardware MSR values during vcpu_put().
>> - [High] MSR_PERF_METRICS is passed through to the guest without context switching if the guest has a PMU version of 0, bypassing host isolation.
>> --
>>
>> commit 65a5a5edf8809e596749d317875bbc842f4eb7fc
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
>>
>> This commit exposes the IA32_PERF_METRICS MSR to guests when mediated
>> vPMU is enabled. It allows host access via kvm_pmu_{get,set}_msr() and
>> handles save/restore during PMU context switches.
>>
>>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>>> index 05a59f4acfdd3..61102aa5e2f9e 100644
>>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> [ ... ]
>>
>>> @@ -335,6 +337,10 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>>  		msr_info->data = pmu->fixed_ctr_ctrl;
>>>  		break;
>>> +	case MSR_PERF_METRICS:
>>> +		WARN_ON_ONCE(!msr_info->host_initiated);
>> [Severity: High]
>> Could this WARN_ON_ONCE() be triggered by an unprivileged guest?
>>
>> If a guest forces KVM's instruction emulator to handle the MSR access, for
>> example by executing RDMSR over an MMIO page, the emulator might process the
>> instruction and invoke KVM's MSR handlers with host_initiated = false.
> Yes, in theory, it's possible for the RDMSR/WRMSR to be handled in the
> emulator path and WARN_ON_ONCE() could be unexpectedly triggered.
>
> Since WARN_ON() is not intended to handle untrusted input, it's better
> to use a defensive check and reject non-host-initiated accesses:
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 19daee29b731..6073227bdd20 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -348,7 +348,8 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
>                 msr_info->data = pmu->fixed_ctr_ctrl;
>                 break;
>         case MSR_PERF_METRICS:
> -               WARN_ON_ONCE(!msr_info->host_initiated);
> +               if (!msr_info->host_initiated)
> +                       return 1;
>                 msr_info->data = pmu->perf_metrics;
>                 break;
>         case MSR_IA32_PEBS_ENABLE:
> @@ -401,7 +402,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu,
> struct msr_data *msr_info)
>                         reprogram_fixed_counters(pmu, data);
>                 break;
>         case MSR_PERF_METRICS:
> -               WARN_ON_ONCE(!msr_info->host_initiated);
> +               if (!msr_info->host_initiated)
> +                       return 1;

Per my understanding, WARN_ON_ONCE() only prints the warning message once
and it should not spam Host log too much, but it's fine for me to remove
them. Thanks.


>
>
>
>> This would unconditionally trigger the warning and allow the guest to spam
>> the host kernel log or cause a host panic if panic_on_warn is enabled.
>>
>>> +		msr_info->data = pmu->perf_metrics;
>>> +		break;
>>>  	case MSR_IA32_PEBS_ENABLE:
>>>  		msr_info->data = pmu->pebs_enable;
>>>  		break;
>> [ ... ]
>>
>>> @@ -384,6 +390,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>  		if (pmu->fixed_ctr_ctrl != data)
>>>  			reprogram_fixed_counters(pmu, data);
>>>  		break;
>>> +	case MSR_PERF_METRICS:
>>> +		WARN_ON_ONCE(!msr_info->host_initiated);
>> [Severity: High]
>> Can a malicious guest also trigger this WARN_ON_ONCE() by executing WRMSR
>> over an MMIO page to force instruction emulation?
> Ditto.
>>> +
>>> +		/*
>>> +		 * If TMA level 2 is not supported, bits [63:32] are reserved
>>> +		 * and ignored on write, so no validation is needed here.
>>> +		 */
>>> +		pmu->perf_metrics = data;
>>> +		break;
>>>  	case MSR_IA32_PEBS_ENABLE:
>> [ ... ]
>>
>>> @@ -622,6 +642,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>>>  
>>>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>>>  {
>>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>> +
>>> +	pmu->perf_metrics = 0;
>>>  	intel_pmu_release_guest_lbr_event(vcpu);
>>>  }
>> [ ... ]
>>
>>> @@ -821,6 +851,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>>>  	 */
>>>  	if (pmu->fixed_ctr_ctrl_hw)
>>>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>>> +
>>> +	if (vcpu_has_perf_metrics(vcpu)) {
>>> +		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
>> [Severity: High]
>> Does this rdpmc() call silently clobber software updates made to
>> pmu->perf_metrics?
>>
>> When the VCPU is loaded during a KVM_SET_MSRS ioctl or VCPU reset, updates
>> to pmu->perf_metrics in intel_pmu_set_msr() or intel_pmu_reset() modify the
>> software struct but do not synchronously write to the active hardware MSR.
> This is safe.
>
> After intel_pmu_set_msr() or intel_pmu_reset(),
> intel_mediated_pmu_load() is called to sync the state to hardware before
> the next intel_mediated_pmu_put().
>
>
>> Later, when the VCPU is descheduled, intel_mediated_pmu_put() reads the
>> physical MSR (which still holds the old pre-update value) and overwrites the
>> software state.
>>
>> Will this permanently discard the new software state and break live
>> migration or VCPU resets?
>>
>>> +		if (pmu->perf_metrics)
>>> +			wrmsrq(MSR_PERF_METRICS, 0);
>>> +	}
>>>  }
>> [ ... ]
>>
>>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>>> index 9324d60839419..475e72c733cee 100644
>>> --- a/arch/x86/kvm/vmx/vmx.c
>>> +++ b/arch/x86/kvm/vmx/vmx.c
>>> @@ -4247,6 +4247,9 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>>  				  MSR_TYPE_RW, intercept);
>>>  	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>>>  				  MSR_TYPE_RW, intercept);
>>> +
>>> +	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS, MSR_TYPE_RW,
>>> +				  !vcpu_has_perf_metrics(vcpu));
>> [Severity: High]
>> Could clearing the intercept here allow the guest direct, unintercepted
>> access to the host's physical MSR_PERF_METRICS register without a context
>> switch?
>>
>> If enable_mediated_pmu is true, KVM exposes PERF_CAP_PERF_METRICS. A VMM
>> could configure a VCPU with MSR_IA32_PERF_CAPABILITIES.PERF_METRICS=1 but
>> leave the PMU version at 0.
>>
>> In this scenario, vcpu_has_perf_metrics() would return true, clearing the
>> intercept. However, because the PMU version is 0,
>> kvm_vcpu_has_mediated_pmu() returns false.
>>
>> This causes the context-switch handlers kvm_mediated_pmu_load() and
>> kvm_mediated_pmu_put() to exit early.
>>
>> Does this bypass host isolation and allow the guest to leak or clobber host
>> PMU state?
> Yes, you are right.
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 7cffe1619a1f..28027d302d90 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4266,7 +4266,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct
> kvm_vcpu *vcpu)
>                                   MSR_TYPE_RW, intercept);
>
>         vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS, MSR_TYPE_RW,
> -                                 !vcpu_has_perf_metrics(vcpu));
> +                                 !has_mediated_pmu ||
> !vcpu_has_perf_metrics(vcpu));
>  }
>
>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>
>>>  }
>>>  
>>>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>

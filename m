Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52353D093A
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004458; cv=none; b=jiZ8gEcj+3ABZf6W2WCW69fqxr6iZflyoT1Lz9BzxMkj4qnSad+tq4j/mxU+2fYCh4HsRPamOILNQiXLXCtYJTFuQ/3eKqgP5RzX3twASxuX78sUD62qyvx35XQIN9pXqZt+Ln3ZH9U+4bvRb4k9AA/uZJAQiGOWNNlbYDVwql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004458; c=relaxed/simple;
	bh=98f3kBfQFZ5A0IguOXdsffrH65Vrk+htFazTIuMYkxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooxxuSwuQHZHsi0K3J0q3Hc/2kUPs/wtNAAEx5K91yOLL1gPLMlyA5puThNyIM26csDVcS+3SX3nf61NXeIxlvNP7kBiyi3WWiRylo/8q6qfmqvxXKGkFVd8V8pCrMeqRbF8F/ZNFZwdzo1KxjFLzqHwpnoy3q52ODJimNl3Ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYRV05Km; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYRV05Km"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787004454; x=1818540454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=98f3kBfQFZ5A0IguOXdsffrH65Vrk+htFazTIuMYkxY=;
  b=fYRV05KmyUd/ee2rsquhBqplRTW0BQOp9+3ktbCELTXWPU2im1qjUr4/
   dx5LH0xvRSHLmoY5pk7PL+2azZZP8m+PuHvcmXLzF8PwwnpwjWC4OVzOI
   mxzz4CXhIxnoJxfU8kGqfW+55pHBcLq4PaXvFdIv36VuXUMxs7OGzN5Xy
   kVzl4FJBfW4e8JRWFDDjaQn1aqA2aQsByuKKVhxFHSVrHhWp58yXMcnqT
   xuTwhAUseqX/gXDs3++mcS73dWb0MnuOO3wge2f3tL2QD2483Blx2yGH+
   jFVeaYQ1sph/fdoj4tD+S2XLDHlWklfdYdXLYv9BsZXaAoHrux0ujfo5P
   A==;
X-CSE-ConnectionGUID: C9aXExlAQu2Oiu+OBH1XRg==
X-CSE-MsgGUID: tu4n49CnRsqBu1fLs1FxYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87251536"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87251536"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 15:07:32 -0700
X-CSE-ConnectionGUID: r20Q0ElxQbSLpIFx2gYE9w==
X-CSE-MsgGUID: uDJpDXH+SAiUCOLRidWznA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="265073423"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 15:07:33 -0700
Message-ID: <cf2fab68-a0be-403c-8ca8-80880fa3879d@intel.com>
Date: Mon, 17 Aug 2026 17:07:31 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-6-zide.chen@intel.com>
 <20260817190429.7CD481F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260817190429.7CD481F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/2026 2:04 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Unvalidated guest/userspace writes to MSR_PERF_METRICS cause host kernel WARN/Oops during PMU context load.
> - [High] Missing RDPMC emulation for PERF_METRICS causes guest #GP when RDPMC is intercepted.
> - [High] Missing RDPMC intercept allows information leak of host MSR_PERF_METRICS.
> 
> Pre-existing issues:
> - [High] Intercepting MSR_CORE_PERF_GLOBAL_STATUS during mediated PMU operation breaks PMIs by returning stale overflow data to the guest.
> --
> 
> --- Patch [5]: [PATCH v8 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU ---
> commit 3c012e6d223702ac2057eaf2c6a15810c5334d8c
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
> 
> This patch exposes the IA32_PERF_METRICS MSR to the guest when mediated
> vPMU is enabled. It allows host/guest PMU context switching to save and
> restore this MSR, and intercepts MSR_CORE_PERF_GLOBAL_CTRL if the host
> supports PERF_METRICS but it is not exposed to the guest.
> 
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 913a0ecbf2609..2fddcbc8924d4 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>>  	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
>>  }
>>  
>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
>> +{
>> +	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
>> +		!kvm_vcpu_has_perf_metrics(vcpu);
>> +}
>> +
> 
> [Severity: High]
> Does this code miss checking for kvm_need_perf_metrics_intercept() in
> kvm_need_rdpmc_intercept()?

Yes, it's included in patch 7/8.

> If mediated PMU is active and the PMU counter topology matches the host,
> RDPMC exiting is disabled. The guest can execute RDPMC with ECX=(1<<29)
> directly on the hardware. Since intel_mediated_pmu_load() skips clearing
> MSR_PERF_METRICS when the guest lacks the feature, the guest might observe
> the host's raw active MSR_PERF_METRICS value.
> 
>>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>  {
>>  	return kvm_need_any_pmc_intercept(vcpu) ||
>> +	       kvm_need_perf_metrics_intercept(vcpu) ||
>>  	       !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
>>  }
> 
> [Severity: High]
> This is a pre-existing issue, but does forcing intercepts here break PMIs
> for guests lacking PERF_METRICS?
> 
> By returning true here, MSR_CORE_PERF_GLOBAL_STATUS and
> MSR_CORE_PERF_GLOBAL_OVF_CTRL are intercepted. During mediated PMU
> operation, hardware updates the physical GLOBAL_STATUS directly on
> overflow. Because KVM does not sync the physical MSR to
> pmu->global_status on every VM-exit (only on vcpu_put()), guest reads
> of the intercepted GLOBAL_STATUS could return stale cached data (0),
> potentially hiding hardware PMIs from the guest.

False positive.

GLOBAL_STATUS is synced to pmu->global_status in
intel_mediated_pmu_load() in every VM exit. So it won't return stale
data to guest reads of the intercepted GLOBAL_STATUS.

> 
> [ ... ]
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 100c072b7fb38..1fd0480baf680 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> [ ... ]
>> @@ -346,6 +348,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		msr_info->data = pmu->fixed_ctr_ctrl;
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		msr_info->data = pmu->perf_metrics;
>> +		break;
> 
> [Severity: High]
> Does KVM also need to emulate RDPMC for PERF_METRICS?

Yes, it's implemented in the following patches.>
> The SDM specifies that IA32_PERF_METRICS can be read using the RDPMC
> instruction with ECX = (1<<29) | 0. However, intel_rdpmc_ecx_to_pmc() only
> recognizes GP counters (type 0) and fixed counters (type 1<<30).
> 
> If KVM intercepts RDPMC, could a guest attempt to read PERF_METRICS via
> RDPMC fall through to the default case and return NULL, causing KVM to
> inject a #GP?
> 
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		msr_info->data = pmu->pebs_enable;
>>  		break;
> [ ... ]
>> @@ -395,6 +400,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (pmu->fixed_ctr_ctrl != data)
>>  			reprogram_fixed_counters(pmu, data);
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		/*
>> +		 * Bits [63:32] are ignored on hardware that supports only
>> +		 * level-1 metrics, but may be valid on hardware that supports
>> +		 * level-2 metrics. Preserve guest writes verbatim.
>> +		 */
>> +		pmu->perf_metrics = data;
>> +		break;
> 
> [Severity: Critical]
> Is it safe to accept untrusted guest or userspace data here without
> validation?

As the comments suggest, no #GP is caused.
> If a malicious guest or host userspace (via KVM_SET_MSRS) injects a value
> with reserved bits set into pmu->perf_metrics, it could cause a host #GP
> during vcpu_load() when intel_mediated_pmu_load() blindly writes this
> value to the physical MSR using the unsafe wrmsrq() macro.
> 
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		if (data & pmu->pebs_enable_rsvd)
>>  			return 1;
> [ ... ]
>> @@ -803,6 +821,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>  	u64 global_status, toggle;
>>  
>> +	if (kvm_vcpu_has_perf_metrics(vcpu))
>> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
>> +
> 
> [Severity: Critical]
> Could this wrmsrq() cause a host oops or panic?
> 
> As mentioned above, if pmu->perf_metrics contains unvalidated data with
> reserved bits set, wrmsrq() (which lacks an exception table entry) will
> trigger a host #GP.

No, no #GP in this case.
>>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>>  	toggle = pmu->global_status ^ global_status;
> 


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA53250BF2;
	Fri, 27 Mar 2026 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642997; cv=none; b=KwUCUPED65GFE2LAPTzEOkjyi0i75IMgaHNgNW5JglgsVJKBZYqgvuTNbbClJmZ1Rfh41CnXfqzPQDUqbnomo5m0FOXMOUjVhe9MCPxdZg8gPyKAyB5GK9DzRmJpRwhLobnr4RJwShywSFCmyZ43ZIgt10mkK/gBD/MCYXBVSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642997; c=relaxed/simple;
	bh=Y8hSTJXhZUhPtyW2Ery+/e9NHHVrPJDStgVzAgk/qug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I63yoOnOoeugG4AvxMrtT6x3w9ESUuYzK5/0v1THN2gMqJH64B4x+UARI9aNzub9WDolmJsZhxBXSqUyCCaqNJpFEiawlVckEK/TeibMeo1WhZQ4t4u5YkUGDGJTkfSvSL6/io2RfqGWWnVN4LxFwn8qzwrtO4SRFBS+6OKYRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtijwO3F; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtijwO3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642996; x=1806178996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y8hSTJXhZUhPtyW2Ery+/e9NHHVrPJDStgVzAgk/qug=;
  b=gtijwO3FIIngyfD2WCFQvXIwwvnPO5BpY7QX6ubMOGP1c90CuN68zWl+
   JrLJ1Aq02jPtzBhFzDWB1YbSHWzhFrkRmyGKj16PwE+F5qGKEMU8oQC72
   +q6N9hs+3ZAoNPodRWEDv3M0PwkgA6udx0dxym8HkLXFgdHuPNQxmqsGI
   3cOg099K8vZ0t9kUopauHts5k3PcCWcyr8hg+kXl99uLpayz1wZJ0wyiR
   ng2Dym32NpwEUREVV9cueRYlTmLhb5OIMrXkDwj0BqpTnqNb/RV5sqLs0
   bphAecEdB4ceApr5TRwKgdFICjD8ICit+1E6Gl/VbIjtfPTS7/GmXMji6
   Q==;
X-CSE-ConnectionGUID: XZeqzxGPTCmpCwSyt1CV3g==
X-CSE-MsgGUID: rp+B0qtDSlaAsfD2Bwy8Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="78322930"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="78322930"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:23:15 -0700
X-CSE-ConnectionGUID: KKzbfiQKRuOjUvzqurj45A==
X-CSE-MsgGUID: RTpPXIqiQxmGQ/KXhMebow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220559633"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.169]) ([10.241.240.169])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:23:14 -0700
Message-ID: <2ef97755-bb53-40d6-81e0-70737e681d04@intel.com>
Date: Fri, 27 Mar 2026 13:23:14 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260226230606.146532-1-zide.chen@intel.com>
 <20260226230606.146532-4-zide.chen@intel.com>
 <20242e71-3914-46c5-b0b7-1a30a07a750a@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20242e71-3914-46c5-b0b7-1a30a07a750a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/2026 10:54 PM, Mi, Dapeng wrote:
> 
> On 2/27/2026 7:06 AM, Zide Chen wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
>> built-in support for Topdown Microarchitecture Analysis (TMA) L1
>> metrics via the IA32_PERF_METRICS MSR.
>>
>> Expose this capability only when mediated vPMU is enabled, as emulating
>> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>>
>> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
>> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES is.  Allow
>> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>>
>> Save and restore this MSR on host/guest PMU context switches so that
>> host PMU activity does not clobber the guest value, and guest state
>> is not leaked into the host.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h   |  1 +
>>  arch/x86/include/asm/msr-index.h  |  1 +
>>  arch/x86/include/asm/perf_event.h |  1 +
>>  arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
>>  arch/x86/kvm/vmx/pmu_intel.h      |  5 +++++
>>  arch/x86/kvm/vmx/vmx.c            |  6 ++++++
>>  arch/x86/kvm/x86.c                |  6 +++++-
>>  7 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 4666b2c7988f..bf817c613451 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -575,6 +575,7 @@ struct kvm_pmu {
>>  	u64 global_status_rsvd;
>>  	u64 reserved_bits;
>>  	u64 raw_event_mask;
>> +	u64 perf_metrics;
>>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>>  
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index da5275d8eda6..337667a7ad1b 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -331,6 +331,7 @@
>>  #define PERF_CAP_PEBS_FORMAT		0xf00
>>  #define PERF_CAP_FW_WRITES		BIT_ULL(13)
>>  #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
>> +#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
>>  #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
>>  #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>>  					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index ff5acb8b199b..dfead3a34b74 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -445,6 +445,7 @@ static inline bool is_topdown_idx(int idx)
>>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
>>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
>>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
>> +#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
>>  
>>  #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
>>  /*
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 9da47cf2af63..61bb2086f94a 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -180,6 +180,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>  	switch (msr) {
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		return kvm_pmu_has_perf_global_ctrl(pmu);
>> +	case MSR_PERF_METRICS:
>> +		return vcpu_has_perf_metrics(vcpu);
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>>  		break;
>> @@ -335,6 +337,10 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		msr_info->data = pmu->fixed_ctr_ctrl;
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		WARN_ON(!msr_info->host_initiated);
> 
> WARN_ON_ONCE() should be good enough.

Sure, and seems it's more reasonable to move the check to
intel_is_valid_msr().
> 
> 
>> +		msr_info->data = pmu->perf_metrics;
>> +		break;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		msr_info->data = pmu->pebs_enable;
>>  		break;
>> @@ -384,6 +390,10 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (pmu->fixed_ctr_ctrl != data)
>>  			reprogram_fixed_counters(pmu, data);
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		WARN_ON(!msr_info->host_initiated);
> 
> ditto.
> 
> 
>> +		pmu->perf_metrics = data;
>> +		break;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		if (data & pmu->pebs_enable_rsvd)
>>  			return 1;
>> @@ -579,6 +589,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  		pmu->global_status_rsvd &=
>>  				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
>>  
>> +	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
>> +		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
>> +		pmu->global_status_rsvd &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
>> +	}
>> +
>>  	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>>  		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
>>  			pmu->pebs_enable_rsvd = counter_rsvd;
>> @@ -622,6 +637,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>>  
>>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>>  {
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	pmu->perf_metrics = 0;
>>  	intel_pmu_release_guest_lbr_event(vcpu);
>>  }
>>  
>> @@ -793,6 +811,13 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>  	u64 global_status, toggle;
>>  
>> +	/*
>> +	 * PERF_METRICS MSR must be restored closely after fixed counter 3
>> +	 * (kvm_pmu_load_guest_pmcs()).
>> +	 */
>> +	if (vcpu_has_perf_metrics(vcpu))
>> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
>> +
>>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>>  	toggle = pmu->global_status ^ global_status;
>>  	if (global_status & toggle)
>> @@ -821,6 +846,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>>  	 */
>>  	if (pmu->fixed_ctr_ctrl_hw)
>>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>> +
>> +	if (vcpu_has_perf_metrics(vcpu)) {
>> +		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
>> +		if (pmu->perf_metrics)
>> +			wrmsrq(MSR_PERF_METRICS, 0);
>> +	}
>>  }
>>  
>>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
>> index 5d9357640aa1..2ec547223b09 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.h
>> +++ b/arch/x86/kvm/vmx/pmu_intel.h
>> @@ -40,4 +40,9 @@ struct lbr_desc {
>>  
>>  extern struct x86_pmu_lbr vmx_lbr_caps;
>>  
>> +static inline bool vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
>> +{
>> +	return !!(vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PERF_METRICS);
>> +}
>> +
>>  #endif /* __KVM_X86_VMX_PMU_INTEL_H */
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 967b58a8ab9d..4ade1394460a 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4338,6 +4338,9 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  				  MSR_TYPE_RW, intercept);
>>  	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>>  				  MSR_TYPE_RW, intercept);
>> +
>> +	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS, MSR_TYPE_RW,
>> +				  !vcpu_has_perf_metrics(vcpu));
>>  }
>>  
>>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>> @@ -8183,6 +8186,9 @@ static __init u64 vmx_get_perf_capabilities(void)
>>  		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
>>  	}
>>  
>> +	if (enable_mediated_pmu)
>> +		perf_cap |= host_perf_cap & PERF_CAP_PERF_METRICS;
>> +
>>  	return perf_cap;
>>  }
>>  
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 2ab7a4958620..4d0e38303aa5 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -357,7 +357,7 @@ static const u32 msrs_to_save_pmu[] = {
>>  	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>>  	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>>  	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
>> -	MSR_CORE_PERF_GLOBAL_CTRL,
>> +	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
>>  	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>>  
>>  	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
>> @@ -7675,6 +7675,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>>  		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
>>  			return;
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		if (!(kvm_caps.supported_perf_cap & PERF_CAP_PERF_METRICS))
>> +			return;
>> +		break;
>>  	case MSR_ARCH_PERFMON_PERFCTR0 ...
>>  	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>>  		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=


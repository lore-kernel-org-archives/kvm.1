Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C8359A66;
	Tue, 23 Jun 2026 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782250721; cv=none; b=mKjYqxhYts2wSMQgZ4B66NWJCbfo2Ldo8QPdnCYoVCn3lODs7BRX0SweE53dgZp/iDUkDExo128C741Ung3q6o7xYaBaNXaGY3+lZW2qsICzvOp0NpJL6ZXf+l/KmpRHk+l4xGkpw0I2sVZoBE8f43mvld/s1VhTpcW8ef8Rx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782250721; c=relaxed/simple;
	bh=2YdEIU46MFVp5/oSq1gfUtvQ6uCRRPPDWooKW9DSB+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOmuc2fhjiAhsjdhtJAt1LpO2ysU8FQyWzxcVX3nBaEtXostLthpn7mOzuQpJLGA6+5vNaSS2Jj4vAjpUjP12Rd2uIwVuQn66v+5kDw4pi4kpPwgx9QUSTgEu1NYFcOchnR3AKtjScHto3kq7QwUPQh2DX1RnwHdcAvhWMnSGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VDCKAzU/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VDCKAzU/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782250720; x=1813786720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2YdEIU46MFVp5/oSq1gfUtvQ6uCRRPPDWooKW9DSB+k=;
  b=VDCKAzU/oXqTq+QxIuPFtfeClWnnpMwUsGtFpMr+8GaftRUmDIMTOo+u
   fATyl/zOZrn37cEhfAyJi3HH8LcremzoYMZYqQ1oZrQ8gws03Yj6bO7RP
   IvbMuHsUyH06g4LMVUwukMZJmFaHFwmOk5b0ZSANooliZ9WhtgQWTs0Dz
   EIk2yKCr5X0iPXZo1qe9Ov3vdu/tkXL25C8jetJKcbPjQYc6jgwF8exEx
   d0XntAOOv41IsVvbBpIG97q8ual/AZyCuRa0nU+0ftSVhrRecban96Z6s
   y37FlCjVzSW+TjtSKEos31ZzmQvKXIE7eqAu7V5bi2qi5l0+16oEPoJUE
   g==;
X-CSE-ConnectionGUID: qYsAQ1H7Q32ES6IwI1HeMg==
X-CSE-MsgGUID: ofw/8gGmTqiMFtDB3uY4pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82888989"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82888989"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 14:38:40 -0700
X-CSE-ConnectionGUID: widOoU7lT32FrOWwiRrzoQ==
X-CSE-MsgGUID: YfIqJe+2QgaU5ona9oloLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="247290887"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 14:38:38 -0700
Message-ID: <e806dc4c-1d61-4152-8bbf-33d8922745d2@intel.com>
Date: Tue, 23 Jun 2026 16:38:37 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260623041927.178256-1-zide.chen@intel.com>
 <20260623041927.178256-4-zide.chen@intel.com>
 <8d6a2a1c-3d96-4250-a967-2ff4109cb4b8@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <8d6a2a1c-3d96-4250-a967-2ff4109cb4b8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/23/2026 2:04 AM, Mi, Dapeng wrote:
> 
> On 6/23/2026 12:19 PM, Zide Chen wrote:
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
>> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
>> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>>
>> Save and restore this MSR on host/guest PMU context switches so that
>> host PMU activity does not clobber the guest value, and guest state
>> is not leaked into the host.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v4:
>> - Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
>>   host_initiated. (Sashiko)
>> - Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
>> - Remove the redundant !! in vcpu_has_perf_metrics().
>> v3:
>> - Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
>> - Add comments to explain why don't validate writes on PERF_METRICS.
>> ---
>>  arch/x86/include/asm/kvm_host.h   |  1 +
>>  arch/x86/include/asm/msr-index.h  |  1 +
>>  arch/x86/include/asm/perf_event.h |  1 +
>>  arch/x86/kvm/vmx/pmu_intel.c      | 38 +++++++++++++++++++++++++++++++
>>  arch/x86/kvm/vmx/pmu_intel.h      |  5 ++++
>>  arch/x86/kvm/vmx/vmx.c            |  7 ++++++
>>  arch/x86/kvm/x86.c                |  6 ++++-
>>  7 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index edd414f8ee95..4f549ef012d2 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -594,6 +594,7 @@ struct kvm_pmu {
>>  	u64 global_status_rsvd;
>>  	u64 reserved_bits;
>>  	u64 raw_event_mask;
>> +	u64 perf_metrics;
>>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>>  
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 18c4be75e927..fdcaeb6c8352 100644
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
>> index 1eb13673e889..bc2e1cbcd9b9 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -447,6 +447,7 @@ static inline bool is_topdown_idx(int idx)
>>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
>>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
>>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
>> +#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
>>  
>>  #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
>>  /*
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 59b7a90c79e1..2c3367f5e2df 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -188,6 +188,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>  	switch (msr) {
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		return kvm_pmu_has_perf_global_ctrl(pmu);
>> +	case MSR_PERF_METRICS:
>> +		return vcpu_has_perf_metrics(vcpu);
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>>  		break;
>> @@ -345,6 +347,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		msr_info->data = pmu->fixed_ctr_ctrl;
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		if (!msr_info->host_initiated)
>> +			return 1;
>> +		msr_info->data = pmu->perf_metrics;
>> +		break;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		msr_info->data = pmu->pebs_enable;
>>  		break;
>> @@ -394,6 +401,16 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (pmu->fixed_ctr_ctrl != data)
>>  			reprogram_fixed_counters(pmu, data);
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		if (!msr_info->host_initiated)
>> +			return 1;
>> +
>> +		/*
>> +		 * If TMA level 2 is not supported, bits [63:32] are reserved
>> +		 * and ignored on write, so no validation is needed here.
>> +		 */
>> +		pmu->perf_metrics = data;
>> +		break;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		if (data & pmu->pebs_enable_rsvd)
>>  			return 1;
>> @@ -589,6 +606,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
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
>> @@ -632,6 +654,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>>  
>>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>>  {
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +	pmu->perf_metrics = 0;
>>  	intel_pmu_release_guest_lbr_event(vcpu);
>>  }
>>  
>> @@ -803,6 +828,13 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>  	u64 global_status, toggle;
>>  
>> +	/*
>> +	 * PERF_METRICS MSR must be restored closely after fixed counter 3,
>> +	 * which was just restored by kvm_pmu_load_guest_pmcs().
>> +	 */
>> +	if (vcpu_has_perf_metrics(vcpu))
>> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
> 
> Copy Sashiko's comments here.
> 
> "
> 
> [Severity: High]
> If the guest is configured without PERF_CAP_PERF_METRICS but with mediated
> PMU enabled, RDPMC exiting might be disabled. Since
> intel_mediated_pmu_load() skips writing to MSR_PERF_METRICS in this case,
> could the guest execute RDPMC and read the un-scrubbed host metrics, leaking
> host microarchitectural state?
> 
> "
> 
> This is a real concern. Besides MSR interception, we need to care about the
> rdpmc interception. When the guest has different configuration on perf
> metrics with host, rdpmc needs to be intercepted. Thanks.

Yes, my bad! This actuallly was in the initial implementation.
>> +
>>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>>  	toggle = pmu->global_status ^ global_status;
>>  	if (global_status & toggle)
>> @@ -831,6 +863,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
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
>> index 5d9357640aa1..57705773dc49 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.h
>> +++ b/arch/x86/kvm/vmx/pmu_intel.h
>> @@ -40,4 +40,9 @@ struct lbr_desc {
>>  
>>  extern struct x86_pmu_lbr vmx_lbr_caps;
>>  
>> +static inline bool vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
>> +{
>> +	return vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PERF_METRICS;
>> +}
>> +
>>  #endif /* __KVM_X86_VMX_PMU_INTEL_H */
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index a1a5edb39a7e..584d99ef6026 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4260,6 +4260,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  				  MSR_TYPE_RW, intercept);
>>  	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>>  				  MSR_TYPE_RW, intercept);
>> +
>> +	intercept = !has_mediated_pmu || !vcpu_has_perf_metrics(vcpu);
>> +	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
>> +				  MSR_TYPE_RW, intercept);
>>  }
>>  
>>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
>> @@ -8084,6 +8088,9 @@ static __init u64 vmx_get_perf_capabilities(void)
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
>> index e872398c12fc..9623f558f359 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -352,7 +352,7 @@ static const u32 msrs_to_save_pmu[] = {
>>  	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>>  	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>>  	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
>> -	MSR_CORE_PERF_GLOBAL_CTRL,
>> +	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
>>  	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>>  
>>  	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
>> @@ -7679,6 +7679,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
> 


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E30473C61;
	Tue, 28 Jul 2026 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271355; cv=none; b=QqsjWlgPykY70qE7nF5aDP/uxYSaAZCtIfPJWlyfIhNutOApbtG904hSW1qIrvi4zfbf2MJrubbeiMorN/FpJ3q5sAm3D01II0isZDaejT0MFCBLRJmJ0uWWNiY/YxX3JHHgS2kDxg6h45KitgSyX/I5eYOy1WmIeZ1tGH6+A+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271355; c=relaxed/simple;
	bh=k853VDoByJEIuAY3qBSgqT0IOyue1U91rwPzuPqPtbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r8KJkmSDdoh1QLebQUDQsI3oP2xRy9WGT3uvly4za2tT8Kyofg2x9HI8dV/BK26Dzc7w26mTyZ08k/yJv/01sZeTU8ZlcmdgZS+N1BI4Y9FhEXkYZeblI+8SxnvCh2ZqZQddYubWqx7h9yJ4eVOuBlxKSmC+jzQlh+9fEq+Qdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8fkiatI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8fkiatI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785271353; x=1816807353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k853VDoByJEIuAY3qBSgqT0IOyue1U91rwPzuPqPtbw=;
  b=H8fkiatIe6K6W7q3dgitHeWClX9ZVUEfp1wkhDuoTAswUhsMOCbtmdB9
   zmxRng5W1oenNfnxROZEjbpdvgzvU/KHqGa1O8cbhFJ+YEHfl4c1YbQpm
   So/CaHU4YVt1h0MXgrHlQvYzMmNqPA+5+IxSutkGhoMlJUbNaGhDu98/X
   xOai5S8bm1CXK0cOMwFBMbdodZSXcrrbGFVnLNXQ1QNe4A9k5HDsXLVJl
   +DqPeJLF25mjDX1oOTPHt95W20BsE9vZsGMVIDbZaapyXyuhDdFm7VKdF
   Ga5bhJfvoysXeOlvEYNP/Tx6hFTorRFW2NgjAv4fcQ5lESqv0H9WfXKyq
   A==;
X-CSE-ConnectionGUID: s2kSPSn6RbmHQhQ/M+31dA==
X-CSE-MsgGUID: eQrEsUXWT9WL0rb7Ih6PXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="84997130"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="84997130"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 13:42:32 -0700
X-CSE-ConnectionGUID: xqlZcq37QV6CaGhH5JRDuA==
X-CSE-MsgGUID: IXZzjXFxTKq6ljA1FYWv+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="289768907"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 13:42:31 -0700
Message-ID: <5a03c9c8-09b1-42fa-a086-63734aa17f6d@intel.com>
Date: Tue, 28 Jul 2026 15:42:30 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-5-zide.chen@intel.com> <amkC3aR32DMkjdzH@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <amkC3aR32DMkjdzH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/28/2026 2:28 PM, Sean Christopherson wrote:
> On Tue, Jul 07, 2026, Zide Chen wrote:
>> pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
>> may include non-contiguous GP or fixed counters.
>>
>> pmu->all_valid_pmc_mask already holds a bitmap indicating both fixed
>> and general-purpose counters, and loops over valid counters can be
>> done via pmu->all_valid_pmc_mask alone. Extend it to a union so that
>> the u64 alias is available for convenient mask arithmetic operations.
>>
>> Add the necessary helpers to prepare for bitmap-based PMC counter
>> implementation.
>>
>> No functional change intended.
>>
>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/include/asm/kvm_host.h |  5 ++-
>>  arch/x86/kvm/pmu.h              | 55 +++++++++++++++++++++++++++++----
>>  2 files changed, 53 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 395b6f20e9ac..f648dc168685 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -643,7 +643,10 @@ struct kvm_pmu {
>>  		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>>  		atomic64_t __reprogram_pmi;
>>  	};
>> -	DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
>> +	union {
>> +		DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
>> +		u64 all_valid_pmc_mask64;
>> +	};
>>  	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
>>  
>>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index cdbefda844b9..95dc95a9ae37 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -88,6 +88,32 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>>  }
>>  
>> +static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
>> +{
>> +	return pmu->all_valid_pmc_mask64 &
>> +	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
>> +}
>> +
>> +static inline unsigned long kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
>> +{
>> +	return (pmu->all_valid_pmc_mask64 >> KVM_FIXED_PMC_BASE_IDX) &
>> +		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
>> +}
>> +
>> +static inline bool kvm_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> 
> kvm_is_gp_pmc_supported()
>     ^^

OK. Will rename:

kvm_gp_pmc_supported -> kvm_is_gp_pmc_supported
kvm_fixed_pmc_supported -> kvm_is_fixed_pmc_supported
>> +{
>> +	unsigned long bitmap = kvm_gp_pmc_mask(pmu);
>> +
>> +	return idx < KVM_MAX_NR_GP_COUNTERS && test_bit(idx, &bitmap);
> 
> Why generate the full bitmap?  Isn't this equivalent in practice?
> 
> 	return idx < KVM_MAX_NR_GP_COUNTERS &&
> 	       test_bit(idx, pmu->all_valid_pmc_mask);

Yes, that's simpler. I'll use all_valid_pmc_mask directly in both the GP
and fixed helpers.

> 
>> +static inline bool kvm_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
>> +{
>> +	unsigned long bitmap = kvm_fixed_pmc_mask(pmu);
>> +
>> +	return idx < KVM_MAX_NR_FIXED_COUNTERS && test_bit(idx, &bitmap);
>> +}
>> +
>>  /*
>>   * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
>>   * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
>> @@ -104,11 +130,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>>   */
>>  static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>>  {
>> -	if (idx < pmu->nr_arch_gp_counters)
>> +	if (kvm_gp_pmc_supported(pmu, idx))
>>  		return &pmu->gp_counters[idx];
>>  
>>  	idx -= KVM_FIXED_PMC_BASE_IDX;
>> -	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
>> +	if (kvm_fixed_pmc_supported(pmu, idx))
>>  		return &pmu->fixed_counters[idx];
>>  
>>  	return NULL;
>> @@ -120,6 +146,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>>  			continue;				\
>>  		else						\
>>  
>> +/*
>> + * @mask must be an lvalue of type unsigned long because for_each_set_bit()
>> + * takes its address.
>> + *
>> + * @type is token-pasted into KVM_MAX_NR_##type##_COUNTERS to match one of the
>> + * counter defines, e.g. GP, FIXED, AMD_GP, INTEL_GP, or INTEL_FIXED. This
>> + * reflects what KVM supports, not the underlying host's PMU capabilities.
>> + */
>> +#define kvm_for_each_set_pmc_idx(i, mask, type)		\
>> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_##type##_COUNTERS)
> 
> 
> Provide dedciated macros instead of requiring the caller to pass in a type and
> then doing token pasting, e.g.
> 
>   #define kvm_for_each_gp_counter()
> 
>   #define kvm_for_each_fixed_counter()

Do you mean having only two macros, and using
KVM_MAX_NR_{GP,FIXED}_COUNTERS for Intel, AMD, and the common PMU code?

That should work, since all_valid_pmc_mask64 is already constrained by
KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS, so iterating up to
KVM_MAX_NR_{GP,FIXED}_COUNTERS would be safe.

>>  static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
>>  {
>>  	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
>> @@ -168,9 +205,12 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
>>  static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
>>  					 u32 base)
>>  {
>> -	if (msr >= base && msr < base + pmu->nr_arch_gp_counters) {
>> +	if (msr >= base && msr < base + KVM_MAX_NR_GP_COUNTERS) {
>>  		u32 index = array_index_nospec(msr - base,
>> -					       pmu->nr_arch_gp_counters);
>> +					       KVM_MAX_NR_GP_COUNTERS);
>> +
>> +		if (!kvm_gp_pmc_supported(pmu, index))
>> +			return NULL;
>>  
>>  		return &pmu->gp_counters[index];
>>  	}
>> @@ -183,9 +223,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
>>  {
>>  	int base = MSR_CORE_PERF_FIXED_CTR0;
>>  
>> -	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
>> +	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
>>  		u32 index = array_index_nospec(msr - base,
>> -					       pmu->nr_arch_fixed_counters);
>> +					       KVM_MAX_NR_FIXED_COUNTERS);
>> +
>> +		if (!kvm_fixed_pmc_supported(pmu, index))
>> +			return NULL;
>>  
>>  		return &pmu->fixed_counters[index];
>>  	}
>> -- 
>> 2.54.0
>>


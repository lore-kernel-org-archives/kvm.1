Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022732;
	b=AoM3EtbxpiSRdrydccJshatEHo+nwaydUQ9yo+4Vbjqqgoe/nIHNLlZrJg9+v17mDC09
	 rhOpwJbsnDPcfNgwe0F/alrGckmyEFZOB9fOJFwaUaobe3j4cTuHE0QNa7Y6MQVa1C+IM
	 PsPuuLQbdezBEoWI+Eww/xhNWA2iWEsqGOysf4fyukMfT3maKHFKVXlNBanxw2/H5AO8x
	 UFjJeRB/jdD5vUpfogppyMlwbCR0IcDJ326HSJ5wDUvqXGcGaHtMUNBnerAdSLNhz5RF6
	 7Rjq+YPGMylWOmpF+T4xc2/0aOIrsBmhkb4pJJ+RPsSS8nGBFS/wjf0iAaxzuvPSJWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022732;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=qP4mQMmZIy9Cp/7L0+1C5A0k/UUgKzbI85AykGMTNzs=;
	b=k2isL9n888TUW3+F6hwdvH2gBml2lVI6C+nASQXDT9jBHEjtNkyRkE4i2WUIVre2GLh3
	 g2ZqL+VktXf6F6UGNBBFBPpjTNkLAE0YEdYSU7CQp99NXGKPvC4iWrx7mp4EurJV3/GD+
	 vlhn3be/nyfcmjrF3KpwTXzEft1li7Pmjkng05q8DuVzBpK/aOru3gOr3RnIx2gKb5nsH
	 D5SD2N25YhQlkXN0oZM8a7mxKz4+f5xZLhN11kf9lomflUV3EEwY5wAYhb9UmHq4Nil/j
	 yteh2HKte68hg9U08Xp+Vu590Hisr9FN2jrf+jglRQu7hKopMST7YBR+DHiFW8X6NGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=akwELalT;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F53606A330;
	Wed, 18 Nov 2026 17:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1F53606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=akwELalT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795022731; x=1826558731;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+I5hBpWzECpQNVBS1GESKzJe+Ymp4ocfhWklyEOLjQ=;
  b=akwELalTofKY1K8R2Xae3pZ2tOMye8121RoeOhjNpfBVEepEP5Iz9JXM
   lzzYTCerJJx6tOnvqakB/dE5Fg074eoncUKKEGtgox7nXvoaWonqclh3R
   Y+AgLYfIu6W6uT9Z86b0VABx4Ld6VjzzRh4TnULr5vv/rs2dlvle173wn
   MwCd8whiLrHrJNSIo5s0C95MPJYiFlWIDhvt+CdPLRSIROQ40HecrTTD6
   HxXMpQ66aC3DT2v9recZXTpZd9KcAlPoyOFbVWGtbwk6Gwr6FOdQXJ6v3
   KDQdXRiyiQMGSXrhdWZsbx9Bb51IvlZzf6euiHNwO7bmKM8YHn5UxID5L
   Q==;
X-CSE-ConnectionGUID: HYF3t3n3R7SuPY4F9KcSJQ==
X-CSE-MsgGUID: L1YDtcxjRJezVTq/kiwa0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3888141"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3888141"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:25:30 -0800
X-CSE-ConnectionGUID: stKUwBfvQLWY9q72HH+CrQ==
X-CSE-MsgGUID: xTX1uvTDTj2oIAINZyDynA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9996349"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 09:25:30 -0800
Message-ID: <77f19d29-224d-474d-afc2-25f0ae1bd6cc@intel.com>
Date: Wed, 18 Nov 2026 11:25:28 -0600
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
Subject: Re: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-7-zide.chen@intel.com> <avz3U-w-CBtTM0uH@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <avz3U-w-CBtTM0uH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/2026 6:58 PM, Yosry Ahmed wrote:
> On Thu, Nov 12, 2026 at 01:32:12PM -0700, Zide Chen wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Populate and use pmc_exists directly when walking guest-visible PMCs,
>> instead of relying on pmu->nr_arch_{gp,fixed}_counters as intermediate
>> state, in preparation for switching KVM's host PMU capabilities from
>> counter counts to counter bitmaps.
>>
>> Extend pmu->pmc_exists to a union so that the u64 alias (pmc_exists64)
>> is available for mask arithmetic operations. Introduce
>> kvm_{gp,fixed}_pmc_mask() to extract the respective counter bitmasks,
>> and provide the kvm_for_each_{gp,fixed}_counter() iterator macros to
>> replace open-coded counter index loops.
>>
>> Consolidate PMU MSR intercept setup in VMX and SVM into single loops.
>> In SVM, this also fixes legacy counter interception by re-enabling
>> intercepts if a vCPU's counter count is narrowed.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> [..]
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index fbab4f5c9181..b312f80f5cda 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -88,6 +88,18 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>>  }
>>  
>> +static inline u64 kvm_gp_pmc_mask(struct kvm_pmu *pmu)
>> +{
>> +	return pmu->pmc_exists64 &
>> +	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
>> +}
>> +
>> +static inline u64 kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
>> +{
>> +	return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
>> +	       GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
> 
> Why do we need to & with the
> KVM_MAX_NR_GP_COUNTERS/KVM_MAX_NR_FIXED_COUNTERS mask here? Isn't
> pmc_exists64 already clamped?

For kvm_gp_pmc_mask(), masking with GENMASK_ULL(31, 0) is required to
strip off the fixed counter bits [34:32] and bit 58.

For kvm_fixed_pmc_mask(), bit 58 (INTEL_PMC_IDX_FIXED_VLBR) could show
up at bit (58 - 32) = 26 in the returned fixed mask. So the mask is
necessary to strip it off.

> 
>> +}
>> +
>>  static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
>>  {
>>  	return idx < KVM_MAX_NR_GP_COUNTERS &&
> [..]
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index fadc466cd600..68d23c7877a2 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -71,14 +71,14 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>>  
>>  	pmu->fixed_ctr_ctrl = data;
>>  	pmu->fixed_ctr_ctrl_hw = data;
>> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
>> +	kvm_for_each_fixed_counter(i, pmu) {
>>  		u8 new_ctrl = fixed_ctrl_field(data, i);
>>  		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
>>  
>>  		if (old_ctrl == new_ctrl)
>>  			continue;
>>  
>> -		pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
>> +		pmc = &pmu->fixed_counters[i];
> 
> By bypassing the helper we lose the array_index_nospec(), right? Same
> applies if we directly access the array elsewhere.

Right, but array_index_nospec() is only needed when the index comes from
untrusted guest input (like in get_fixed_pmc()).

Here 'i' is an internal loop iterator bounded by
KVM_MAX_NR_FIXED_COUNTERS and kvm_fixed_pmc_mask(). Direct indexing
&pmu->fixed_counters[i] matches kvm_pmu_{load,put}_guest_pmcs() in pmu.c.


>>  
>>  		__set_bit(KVM_FIXED_PMC_BASE_IDX + i, pmu->pmc_in_use);
>>  		kvm_pmu_request_counter_reprogram(pmc);
> [..]
>> @@ -497,7 +501,7 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>>  {
>>  	int i;
>>  
>> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
>> +	kvm_for_each_fixed_counter(i, pmu)
>>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>>  }
>>  
>> @@ -505,11 +509,13 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
>> +	int nr_gp_counters, nr_fixed_counters;
>>  	struct kvm_cpuid_entry2 *entry;
>>  	union cpuid10_eax eax;
>>  	union cpuid10_edx edx;
>>  	u64 perf_capabilities;
>>  	u64 counter_rsvd;
>> +	u64 fixed_mask;
>>  
>>  	if (!lbr_desc)
>>  		return;
>> @@ -535,8 +541,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	if (!pmu->version)
>>  		return;
>>  
>> -	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
>> -					 kvm_pmu_cap.num_counters_gp);
>>  	eax.split.bit_width = min_t(int, eax.split.bit_width,
>>  				    kvm_pmu_cap.bit_width_gp);
>>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
>> @@ -544,6 +548,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  				      kvm_pmu_cap.events_mask_len);
>>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>>  
>> +	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
>> +				  kvm_pmu_cap.num_counters_fixed);
>> +	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
> 
> Probably clearer to move these right above where fixed_mask is used.

Agreed. Additionally, fixed counters only exist starting in PMU v2, so
it makes sense to move the fixed-counter setup down after the
'pmu->version == 1' check.

The reason it was originally placed higher up is that in the upcoming
patch ("Populate CPUID.0AH:ECX fixed-counter bitmap"), fixed_mask will
also incorporate CPUID.0AH:ECX. But 'entry' is repurposed to look up
leaf 7.0 right above the version == 1 check, which clobbers leaf 0AH.

To move fixed_mask down cleanly, we need separate entry_10 and
entry_7 variables. Since that adjustment is not tiny, I propose
splitting it out into a separate preparation patch, not to mess up this
already large patch.

> 
>> +
>> +	nr_gp_counters = min_t(int, eax.split.num_counters,
>> +			       kvm_pmu_cap.num_counters_gp);
>> +	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
>> +
>>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>>  	if (entry &&
>>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
>> @@ -565,8 +577,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	if (pmu->version == 1)
>>  		return;
>>  
>> -	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
>> -					    kvm_pmu_cap.num_counters_fixed);
>> +	pmu->pmc_exists64 |= fixed_mask << KVM_FIXED_PMC_BASE_IDX;
>>  	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
>>  					  kvm_pmu_cap.bit_width_fixed);
>>  	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
>> @@ -575,8 +586,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  						 INTEL_FIXED_0_USER |
>>  						 INTEL_FIXED_0_ENABLE_PMI);
>>  
>> -	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
>> -			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>> +	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
>> +			 (kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
> 
> Can we use pmc_exists64 here like the AMD code?

Unlike AMD, Intel's may have bit 58 (INTEL_PMC_IDX_FIXED_VLBR) set.
counter_rsvd is sued to specifically restricts the unreserved bits to
valid GP and fixed counters.

> 
>>  	pmu->global_ctrl_rsvd = counter_rsvd;
>>  
>>  	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
>> @@ -591,7 +602,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
>>  			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
>>  		} else {
>> -			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
>> +			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
>>  		}
>>  	}
>>  }


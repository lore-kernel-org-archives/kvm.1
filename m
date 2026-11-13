Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594163;
	b=bA/z4vQX/OyIQ6wUObLJok25hIZJZ3+VBVfvL8fO6kAHQoIoeXp3mGrfJdlIddiwaVHO
	 m9gcX/83/OMecb3ObmcE8IzS08NkQeLF0i3HP8cnHz/ocLgr/qM455yfQQgx6iGMvjyvd
	 WJdvChkQoFaZaMPj5nQNGp69tjT7beAJ3+8YO5NpE6AeEMGBgQYKB6vFG8KMd4sTBsyZU
	 KD4dxMkiLLygQr5/FEc5CFWuX9Z6AIV/0uWoiFhHgsNe+nwE3Lv/lnprTDRbqyRG7FUWC
	 pvS1bGGkCIw/bUiL/gOGPqW7E3/E9bX5wgya4NYg7pjq01Vv4v4fDe23DUdpwvACNWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594163;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=IqzoU+3enczpSWtf+dXVpkMExXL8ltIAkfd6DAJvt9o=;
	b=pjjJW7COPduJxEOyE9vDf1fGQ1iY8mCBjG9wj9b1/NNfEwGh60qcfQkUtoEVhjy9qzrp
	 R5QtE/7sVq+4oB/LH+fR7Hdx9oXH5vW/phnjcsP3hAJWgv/imLalyN2ayYaXJ4bwKAINU
	 V7CrmfS21ODfynXua4nG7DynpgMLDyGCGX2K9L1qdi97DlgT1ihStx7+jgc3KjrjTejpH
	 E1HU40avmbw/dNsfIMlq5njMHxQPH9bDkmOM9NvSHGnczMiciouGhFoACQwILRayK+8/w
	 Y4iHrew4lRpxKCHdY5yoFEV8cDBQMK2q7900vTei+KYw4s5+eVzNFCk6M42Taj7uUJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R4L0xzhb;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6630606A323;
	Fri, 13 Nov 2026 18:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6630606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R4L0xzhb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794594163; x=1826130163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RLt6bmT1T200I+l51L4W7gcZpysiqvAtz8ihlO2UTUs=;
  b=R4L0xzhb4gxhFCvW2KJndie0W+iD82IbNwJLy7bPG9j4T8Xtgot9yQqh
   jkICcIomat2t0FirB6uM4hscOIPwaIp99Ei5X8qE8O4rniFP7Q0wZT60Q
   uXRwJUZqDf3C2ru7xnqY2kVQ4sb8KReN+Denm6kWwTioV2XeGV6YO9c4Q
   DH0qasjt3p6LqOLNZiMJKHu5rfk8Enok9ZhYyBqiasSmVkNtcWl5ZY9yd
   UwiEKnxYrhCbekrSt9olSMCnZvjW+Kfka5mTjOHV9VH32Nk6F1z3Z16rW
   lrT/qVxadMsUpoCKD3ONgO+L7OBIxFlPYJ2Waoh0NiGO3hWwNelQfYtG8
   w==;
X-CSE-ConnectionGUID: F3Zfmni4TtS2aZ0jcbSPNA==
X-CSE-MsgGUID: jIXMJo2pTBWFbJqXd6BzMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3298561"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3298561"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:22:42 -0800
X-CSE-ConnectionGUID: 8ZWm3YhdTUWy+R8mdHtNVA==
X-CSE-MsgGUID: mGxQjURkSsiBP9VUQx4GJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8899393"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:22:42 -0800
Message-ID: <34b7e735-9ed9-477d-8e88-c4d6440201a9@intel.com>
Date: Fri, 13 Nov 2026 12:22:40 -0600
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
Subject: Re: [PATCH v4 09/21] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Xudong Hao <xudong.hao@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-10-zide.chen@intel.com>
 <792c8390-5c39-4e60-bbd5-0901f3d5b2a1@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <792c8390-5c39-4e60-bbd5-0901f3d5b2a1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/13/2026 12:40 AM, Mi, Dapeng wrote:
> 
> On 11/13/2026 4:32 AM, Zide Chen wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
>> starting with PerfMon v5, and support non-contiguous GP counters
>> through the Architectural PerfMon Extension (CPUID leaf 23H).
>>
>> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
>> which may contain sparse bits representing non-contiguous counters.
>> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
>> bitmask fields, including iterating kvm_host_pmu bitmasks directly in
>> VMX and SVM PMU MSR intercept setup.
>>
>> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
>> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
>> the number of consecutive counters starting at index 0.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v4:
>> - Cleanly substitute kvm_pmu_cap.num_counters_{gp,fixed} with
>>   find_first_zero_bit() in intel_pmu_refresh() without throwaway
>>   code churn.
>> - Use find_first_zero_bit() instead of hweight64() for AMD CPUID
>>   0x80000022 EBX[3:0] (NumCorePmc) and svm_set_cpu_caps() to enumerate
>>   contiguous counters. (Yosry)
>> - Do not carry over Jim's Reviewed-by from v3 due to reworking counter
>>   clamping in intel_pmu_refresh().
>>
>> v3:
>> - Iterate kvm_host_pmu bitmasks directly in VMX and SVM intercept loops.
>> - Clamp nr_{gp,fixed}_counters to the number of contiguous counters
>>   supported by KVM in intel_pmu_refresh(). (Jim, Sashiko)
>> - Drop redundant !enable_mediated_pmu clamp on fixed_cntr_mask64.
>>   (Sashiko)
>> ---
>>  arch/x86/kvm/cpuid.c         | 17 ++++++++++++++---
>>  arch/x86/kvm/msrs.c          | 12 ++++++------
>>  arch/x86/kvm/pmu.c           | 17 ++++++++---------
>>  arch/x86/kvm/svm/pmu.c       |  2 +-
>>  arch/x86/kvm/svm/svm.c       |  8 ++++----
>>  arch/x86/kvm/vmx/pmu_intel.c | 18 +++++++++++++++---
>>  arch/x86/kvm/vmx/vmx.c       |  4 ++--
>>  7 files changed, 50 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index adafd6fa2c54..427871ec365f 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1535,10 +1535,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		}
>>  
>>  		eax.split.version_id = kvm_pmu_cap.version;
>> -		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
>> +
>> +		/* Contiguous GP counters only. */
>> +		eax.split.num_counters =
>> +			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +					    KVM_MAX_NR_GP_COUNTERS);
>>  		eax.split.bit_width = kvm_pmu_cap.bit_width_gp;
>>  		eax.split.mask_length = kvm_pmu_cap.events_mask_len;
>> -		edx.split.num_counters_fixed = kvm_pmu_cap.num_counters_fixed;
>> +
>> +		/* Contiguous fixed counters only. */
>> +		edx.split.num_counters_fixed =
>> +			find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>> +					    KVM_MAX_NR_FIXED_COUNTERS);
>>  		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
>>  
>>  		if (kvm_pmu_cap.version)
>> @@ -1903,7 +1911,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  
>>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>>  
>> -		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
>> +		/* Contiguous GP counters only. */
>> +		ebx.split.num_core_pmc =
>> +			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +					    KVM_MAX_NR_GP_COUNTERS);
>>  		entry->ebx = ebx.full;
>>  		break;
>>  	}
>> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
>> index e91650af44c2..01fb130a7d24 100644
>> --- a/arch/x86/kvm/msrs.c
>> +++ b/arch/x86/kvm/msrs.c
>> @@ -2621,20 +2621,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>>  		break;
>>  	case MSR_ARCH_PERFMON_PERFCTR0 ...
>>  	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>> -		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
>> -		    kvm_pmu_cap.num_counters_gp)
>> +		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_PERFCTR0) &
>> +		      kvm_pmu_cap.cntr_mask64))
>>  			return;
>>  		break;
>>  	case MSR_ARCH_PERFMON_EVENTSEL0 ...
>>  	     MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
>> -		if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
>> -		    kvm_pmu_cap.num_counters_gp)
>> +		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_EVENTSEL0) &
>> +		      kvm_pmu_cap.cntr_mask64))
>>  			return;
>>  		break;
>>  	case MSR_ARCH_PERFMON_FIXED_CTR0 ...
>>  	     MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
>> -		if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
>> -		    kvm_pmu_cap.num_counters_fixed)
>> +		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_FIXED_CTR0) &
>> +		      kvm_pmu_cap.fixed_cntr_mask64))
>>  			return;
>>  		break;
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index d203cbc7fd12..e1999a6c85d7 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -20,7 +20,6 @@
>>  #include <asm/perf_event.h>
>>  #include <asm/cpu_device_id.h>
>>  #include "x86.h"
>> -#include "cpuid.h"
>>  #include "lapic.h"
>>  #include "pmu.h"
>>  
>> @@ -156,8 +155,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>  		 * there are a non-zero number of counters, but fewer than what
>>  		 * is architecturally required.
>>  		 */
>> -		if (!kvm_host_pmu.num_counters_gp ||
>> -		    WARN_ON_ONCE(kvm_host_pmu.num_counters_gp < min_nr_gp_ctrs))
>> +		if (!kvm_host_pmu.cntr_mask64 ||
>> +		    WARN_ON_ONCE(hweight64(kvm_host_pmu.cntr_mask64) < min_nr_gp_ctrs))
>>  			enable_pmu = false;
>>  		else if (is_intel && !kvm_host_pmu.version)
>>  			enable_pmu = false;
>> @@ -177,10 +176,10 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>  
>>  	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
>>  	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
>> -	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
>> -					  pmu_ops->MAX_NR_GP_COUNTERS);
>> -	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
>> -					     KVM_MAX_NR_FIXED_COUNTERS);
>> +	kvm_pmu_cap.cntr_mask64 &=
>> +		GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
>> +	kvm_pmu_cap.fixed_cntr_mask64 &=
>> +		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
>>  
>>  	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
>>  		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
>> @@ -788,8 +787,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>>  	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
>>  	 * capabilities themselves may be a subset of hardware capabilities.
>>  	 */
>> -	return kvm_gp_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_gp) - 1 ||
>> -	       kvm_fixed_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_fixed) - 1;
>> +	return kvm_gp_pmc_mask(pmu) != kvm_host_pmu.cntr_mask64 ||
>> +	       kvm_fixed_pmc_mask(pmu) != kvm_host_pmu.fixed_cntr_mask64;
>>  }
>>  
>>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
>> index 64215024e70e..5eedf9b35fce 100644
>> --- a/arch/x86/kvm/svm/pmu.c
>> +++ b/arch/x86/kvm/svm/pmu.c
>> @@ -196,7 +196,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	}
>>  
>>  	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
>> -			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
>> +			    kvm_pmu_cap.cntr_mask64;
>>  
>>  	if (pmu->version > 1) {
>>  		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index e21abcedea70..5b9c9d149486 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -773,7 +773,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
>>  
>>  	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
>> -	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++)
>> +	for_each_set_bit(i, kvm_host_pmu.cntr_mask, AMD64_NUM_COUNTERS_CORE)
>>  		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>>  					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
>>  
>> @@ -5719,9 +5719,9 @@ static __init void svm_set_cpu_caps(void)
>>  		 * access to enough counters to virtualize "core" support,
>>  		 * otherwise limit vPMU support to the legacy number of counters.
>>  		 */
>> -		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
>> -			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
>> -							  kvm_pmu_cap.num_counters_gp);
>> +		if (find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +					KVM_MAX_NR_GP_COUNTERS) < AMD64_NUM_COUNTERS_CORE)
>> +			kvm_pmu_cap.cntr_mask64 &= GENMASK_ULL(AMD64_NUM_COUNTERS - 1, 0);
>>  		else
>>  			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
>>  
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 68d23c7877a2..a240b74ac704 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -493,7 +493,8 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>>  	 * have a known encoding for the associated general purpose event.
>>  	 */
>>  	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
>> -	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
>> +	WARN_ON_ONCE(!eventsel &&
>> +		     (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
>>  	return eventsel;
>>  }
>>  
>> @@ -548,12 +549,23 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  				      kvm_pmu_cap.events_mask_len);
>>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>>  
>> +	/*
>> +	 * CPUID.0AH:EDX[4:0] can only enumerate contiguous counters. Clamp the
>> +	 * value to the number of contiguous fixed counters supported by KVM.
>> +	 */
>>  	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
>> -				  kvm_pmu_cap.num_counters_fixed);
>> +				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>> +						      KVM_MAX_NR_FIXED_COUNTERS));
>> +
>>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>>  
>> +	/*
>> +	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
>> +	 * value to the number of contiguous GP counters supported by KVM.
>> +	 */
>>  	nr_gp_counters = min_t(int, eax.split.num_counters,
>> -			       kvm_pmu_cap.num_counters_gp);
>> +			       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +						   KVM_MAX_NR_GP_COUNTERS));
>>  	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
>>  
>>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 944ecbf351cf..9db6107943ec 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4264,7 +4264,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  
>>  	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
>>  
>> -	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++) {
>> +	for_each_set_bit(i, kvm_host_pmu.cntr_mask, INTEL_PMC_MAX_GENERIC) {
> 
> Nit: This seems a long standing bug, kvm_host_pmu instead of kvm_pmu_cap
> should be used here. Better put a stand-alone patch to fix this issue at
> the header of this patch series if possible. 

Actually, it seems to me using kvm_pmu_cap here is not a bug in
upstream. MSR bitmaps by default are all-intercepted, and guest PMCs are
clamped to kvm_pmu_cap, so counters beyond kvm_pmu_cap can never be
exposed to the guest.

Looking closer at the history, exposing kvm_host_pmu to vendor code in
patch 6 was originally added in v2 when vmx.c had two loops and needed
it to compute "host_only_gp_mask = kvm_host_pmu.cntr_mask64 & ~gp_mask".

In v3, patch 5 consolidated VMX and SVM into single loops, which
eliminated the host_only mask calculation. Using kvm_host_pmu is
intuitively "more" correct, but not a must.

kvm_pmu_cap.cntr_mask can be used in this patch:

-  for_each_set_bit(i, kvm_host_pmu.cntr_mask, INTEL_PMC_MAX_GENERIC) {
+  for_each_set_bit(i, kvm_pmu_cap.cntr_mask, INTEL_PMC_MAX_GENERIC) {
       bool pmc_intercept = intercept || !test_bit(i, &gp_mask);

       vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
                          MSR_TYPE_RW, pmc_intercept);
       vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
                          pmc_intercept || !fw_writes_is_enabled(vcpu));
   }

Thus, patch 6 ("KVM: x86/pmu: Expose kvm_host_pmu to vendor modules")
could be dropped, keeping kvm_host_pmu encapsulated as static to pmu.c.

> 
> Thanks.
> 
> 
>>  		bool pmc_intercept = intercept || !test_bit(i, &gp_mask);
>>  
>>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
>> @@ -4273,7 +4273,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>  					  pmc_intercept || !fw_writes_is_enabled(vcpu));
>>  	}
>>  
>> -	for (i = 0; i < kvm_pmu_cap.num_counters_fixed; i++) {
>> +	for_each_set_bit(i, kvm_host_pmu.fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
>>  		bool pmc_intercept = intercept || !test_bit(i, &fixed_mask);
>>  
>>  		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,


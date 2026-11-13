Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552051;
	b=zW3zkulSfj3HEH4fH4biiYSjBrsFkT2doBVsw938X+CQeeC8kWj3Zyxm78++5FsFVf6g
	 NEMIZiFGr4kutb0rFDJuH4gFG99o1B92hbyG216Oq/RdlVJiYcor+/j7IJcLNpvrNJPdy
	 TwMg4CSPcFfTwTDaAHtSXA6AaKGSl2dQlHOXeG6cbTisz7kEtTQ2BNia0nOO0KPQ7JXDS
	 U3+ACs7CyDPAkRjdWTZCWSRXcDu+ub3ZOVMm/LODcqlwo5Falchm2HtC6E86DrD4tRdn2
	 c2XnYKAXOoLhmuLXMWVEvq9efRBxQed9jUUrgqn5/Nl1CbmzHuKN3+J0QARBhNxR2ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552051;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Qe5+s2T0kPgOAUEO4EQLm40Xw5y4/hGjRXXYVBNVrAw=;
	b=pgHKVPDTykmvXn1oUhCC+N/epW7mrVQMoZ86ZJc8uXk5aGW4XEtLJiptUvZy8IGzbwGT
	 w4nTttQXeQYsMppz8YqE23DyY9i8fMBpQyS3mCRdoCyRDcqO6cuaBcxDV7lwKmopWIThY
	 9tFgsmTrNkqQF5v1aqjAEfyFoaSbjvgEo8Vbt0CCr02CYji1DVWGSSAydaY1TTer1h7r3
	 GeHBNOlw6oLh8Jxyw7TmkIChhd9PKDTjQL2vPSluVWr+XAI4+yVLdzMkHITFfriMaALNO
	 AZrSo6pmi268gMPOTtGSDOKhdzckCgobBnbAjZ/If20uut+7ClI2zwHMq6xjyzDH4Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D7SiJ+Mf;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA2606A321;
	Fri, 13 Nov 2026 06:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1AA2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D7SiJ+Mf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794552051; x=1826088051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DFxuBdbDa4CySF14l0T76VFLK/ztGlGebXOfVbLt8/A=;
  b=D7SiJ+MfGlTFpkGZCzJDRGfW/1AH+eoLEteWDAC/Edm1ujPbE74wY4Jw
   QH9DQnBz8qLks0P2vD4bnxKLks0g27teA/0+w1iACEvPauQ80/fSCFstv
   oPgHN/VJCux28gY5VX2WkzH7viUx44NX0kdDRXFDSI9VpfDJBH+sRlrrw
   Z0VixP5NrD7lBAZo48+R/39Lyqtt+wrd6QBG9uEhADsAZ/sGYzObWucJ9
   bcjV5wX3sa3mfM7RAtt7zEvC3LN57pidneuRlgKQoaB6RmH4DkvWZ4Ruw
   gUyRGHHvCOPXYVZkO5E2kIdMOqr6cSUWq/ihc85Z3tXxlSl55ACZBmnpQ
   Q==;
X-CSE-ConnectionGUID: auPUuHOqQVi/kXhmcLQSvw==
X-CSE-MsgGUID: 47u2oK8fTCis4EHG3BAJJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3344365"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3344365"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 22:40:50 -0800
X-CSE-ConnectionGUID: 0jgWS2nWTqOWKZPRGFeFkQ==
X-CSE-MsgGUID: /UaFGOccQ/WEVyQWcn7i7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9132906"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 22:40:46 -0800
Message-ID: <792c8390-5c39-4e60-bbd5-0901f3d5b2a1@linux.intel.com>
Date: Fri, 13 Nov 2026 14:40:43 +0800
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
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Yosry Ahmed <yosry@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-10-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261112203227.289379-10-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/13/2026 4:32 AM, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
> starting with PerfMon v5, and support non-contiguous GP counters
> through the Architectural PerfMon Extension (CPUID leaf 23H).
>
> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
> which may contain sparse bits representing non-contiguous counters.
> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
> bitmask fields, including iterating kvm_host_pmu bitmasks directly in
> VMX and SVM PMU MSR intercept setup.
>
> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
> the number of consecutive counters starting at index 0.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v4:
> - Cleanly substitute kvm_pmu_cap.num_counters_{gp,fixed} with
>   find_first_zero_bit() in intel_pmu_refresh() without throwaway
>   code churn.
> - Use find_first_zero_bit() instead of hweight64() for AMD CPUID
>   0x80000022 EBX[3:0] (NumCorePmc) and svm_set_cpu_caps() to enumerate
>   contiguous counters. (Yosry)
> - Do not carry over Jim's Reviewed-by from v3 due to reworking counter
>   clamping in intel_pmu_refresh().
>
> v3:
> - Iterate kvm_host_pmu bitmasks directly in VMX and SVM intercept loops.
> - Clamp nr_{gp,fixed}_counters to the number of contiguous counters
>   supported by KVM in intel_pmu_refresh(). (Jim, Sashiko)
> - Drop redundant !enable_mediated_pmu clamp on fixed_cntr_mask64.
>   (Sashiko)
> ---
>  arch/x86/kvm/cpuid.c         | 17 ++++++++++++++---
>  arch/x86/kvm/msrs.c          | 12 ++++++------
>  arch/x86/kvm/pmu.c           | 17 ++++++++---------
>  arch/x86/kvm/svm/pmu.c       |  2 +-
>  arch/x86/kvm/svm/svm.c       |  8 ++++----
>  arch/x86/kvm/vmx/pmu_intel.c | 18 +++++++++++++++---
>  arch/x86/kvm/vmx/vmx.c       |  4 ++--
>  7 files changed, 50 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index adafd6fa2c54..427871ec365f 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1535,10 +1535,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		}
>  
>  		eax.split.version_id = kvm_pmu_cap.version;
> -		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
> +
> +		/* Contiguous GP counters only. */
> +		eax.split.num_counters =
> +			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +					    KVM_MAX_NR_GP_COUNTERS);
>  		eax.split.bit_width = kvm_pmu_cap.bit_width_gp;
>  		eax.split.mask_length = kvm_pmu_cap.events_mask_len;
> -		edx.split.num_counters_fixed = kvm_pmu_cap.num_counters_fixed;
> +
> +		/* Contiguous fixed counters only. */
> +		edx.split.num_counters_fixed =
> +			find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
> +					    KVM_MAX_NR_FIXED_COUNTERS);
>  		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
>  
>  		if (kvm_pmu_cap.version)
> @@ -1903,7 +1911,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>  
> -		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
> +		/* Contiguous GP counters only. */
> +		ebx.split.num_core_pmc =
> +			find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +					    KVM_MAX_NR_GP_COUNTERS);
>  		entry->ebx = ebx.full;
>  		break;
>  	}
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index e91650af44c2..01fb130a7d24 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -2621,20 +2621,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>  		break;
>  	case MSR_ARCH_PERFMON_PERFCTR0 ...
>  	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
> -		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
> -		    kvm_pmu_cap.num_counters_gp)
> +		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_PERFCTR0) &
> +		      kvm_pmu_cap.cntr_mask64))
>  			return;
>  		break;
>  	case MSR_ARCH_PERFMON_EVENTSEL0 ...
>  	     MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
> -		if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
> -		    kvm_pmu_cap.num_counters_gp)
> +		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_EVENTSEL0) &
> +		      kvm_pmu_cap.cntr_mask64))
>  			return;
>  		break;
>  	case MSR_ARCH_PERFMON_FIXED_CTR0 ...
>  	     MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
> -		if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
> -		    kvm_pmu_cap.num_counters_fixed)
> +		if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_FIXED_CTR0) &
> +		      kvm_pmu_cap.fixed_cntr_mask64))
>  			return;
>  		break;
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index d203cbc7fd12..e1999a6c85d7 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -20,7 +20,6 @@
>  #include <asm/perf_event.h>
>  #include <asm/cpu_device_id.h>
>  #include "x86.h"
> -#include "cpuid.h"
>  #include "lapic.h"
>  #include "pmu.h"
>  
> @@ -156,8 +155,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>  		 * there are a non-zero number of counters, but fewer than what
>  		 * is architecturally required.
>  		 */
> -		if (!kvm_host_pmu.num_counters_gp ||
> -		    WARN_ON_ONCE(kvm_host_pmu.num_counters_gp < min_nr_gp_ctrs))
> +		if (!kvm_host_pmu.cntr_mask64 ||
> +		    WARN_ON_ONCE(hweight64(kvm_host_pmu.cntr_mask64) < min_nr_gp_ctrs))
>  			enable_pmu = false;
>  		else if (is_intel && !kvm_host_pmu.version)
>  			enable_pmu = false;
> @@ -177,10 +176,10 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>  
>  	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
>  	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
> -	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
> -					  pmu_ops->MAX_NR_GP_COUNTERS);
> -	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
> -					     KVM_MAX_NR_FIXED_COUNTERS);
> +	kvm_pmu_cap.cntr_mask64 &=
> +		GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
> +	kvm_pmu_cap.fixed_cntr_mask64 &=
> +		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
>  
>  	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
>  		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
> @@ -788,8 +787,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>  	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
>  	 * capabilities themselves may be a subset of hardware capabilities.
>  	 */
> -	return kvm_gp_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_gp) - 1 ||
> -	       kvm_fixed_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_fixed) - 1;
> +	return kvm_gp_pmc_mask(pmu) != kvm_host_pmu.cntr_mask64 ||
> +	       kvm_fixed_pmc_mask(pmu) != kvm_host_pmu.fixed_cntr_mask64;
>  }
>  
>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 64215024e70e..5eedf9b35fce 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -196,7 +196,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  	}
>  
>  	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> -			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> +			    kvm_pmu_cap.cntr_mask64;
>  
>  	if (pmu->version > 1) {
>  		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index e21abcedea70..5b9c9d149486 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -773,7 +773,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
>  
>  	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
> -	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++)
> +	for_each_set_bit(i, kvm_host_pmu.cntr_mask, AMD64_NUM_COUNTERS_CORE)
>  		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>  					  MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
>  
> @@ -5719,9 +5719,9 @@ static __init void svm_set_cpu_caps(void)
>  		 * access to enough counters to virtualize "core" support,
>  		 * otherwise limit vPMU support to the legacy number of counters.
>  		 */
> -		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
> -			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
> -							  kvm_pmu_cap.num_counters_gp);
> +		if (find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +					KVM_MAX_NR_GP_COUNTERS) < AMD64_NUM_COUNTERS_CORE)
> +			kvm_pmu_cap.cntr_mask64 &= GENMASK_ULL(AMD64_NUM_COUNTERS - 1, 0);
>  		else
>  			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
>  
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 68d23c7877a2..a240b74ac704 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -493,7 +493,8 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  	 * have a known encoding for the associated general purpose event.
>  	 */
>  	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> -	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
> +	WARN_ON_ONCE(!eventsel &&
> +		     (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
>  	return eventsel;
>  }
>  
> @@ -548,12 +549,23 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				      kvm_pmu_cap.events_mask_len);
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
> +	/*
> +	 * CPUID.0AH:EDX[4:0] can only enumerate contiguous counters. Clamp the
> +	 * value to the number of contiguous fixed counters supported by KVM.
> +	 */
>  	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> -				  kvm_pmu_cap.num_counters_fixed);
> +				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
> +						      KVM_MAX_NR_FIXED_COUNTERS));
> +
>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>  
> +	/*
> +	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
> +	 * value to the number of contiguous GP counters supported by KVM.
> +	 */
>  	nr_gp_counters = min_t(int, eax.split.num_counters,
> -			       kvm_pmu_cap.num_counters_gp);
> +			       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +						   KVM_MAX_NR_GP_COUNTERS));
>  	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
>  
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 944ecbf351cf..9db6107943ec 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4264,7 +4264,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  
>  	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
>  
> -	for (i = 0; i < kvm_pmu_cap.num_counters_gp; i++) {
> +	for_each_set_bit(i, kvm_host_pmu.cntr_mask, INTEL_PMC_MAX_GENERIC) {

Nit: This seems a long standing bug, kvm_host_pmu instead of kvm_pmu_cap
should be used here. Better put a stand-alone patch to fix this issue at
the header of this patch series if possible. 

Thanks.


>  		bool pmc_intercept = intercept || !test_bit(i, &gp_mask);
>  
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
> @@ -4273,7 +4273,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  					  pmc_intercept || !fw_writes_is_enabled(vcpu));
>  	}
>  
> -	for (i = 0; i < kvm_pmu_cap.num_counters_fixed; i++) {
> +	for_each_set_bit(i, kvm_host_pmu.fixed_cntr_mask, INTEL_PMC_MAX_FIXED) {
>  		bool pmc_intercept = intercept || !test_bit(i, &fixed_mask);
>  
>  		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,

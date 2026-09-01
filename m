Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2325776;
	Tue,  1 Sep 2026 03:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788233576; cv=none; b=MkHhhG0DpJf+02OFLjbaMEs58U7K7aTNasrq6PZBcHsLzmz4KygOabn/+8L0w0iaToF95DcEV0mniUsYAkhDFRJdgq1mo3xBqXZ8w8GkqH20RNMXy0PgzEKn/7gHvHKjuH8yW0zfyu3LwmzWb1+qQdL1zkNH60+WIzruu34osV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788233576; c=relaxed/simple;
	bh=HUikrqy/PEdZzPZ4G8ooZ3kBbhhLbO9KeBbojD3VI8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rs0b5RElD4NIS2KGd4dvZZSDb6PKNhfBnkCEVWfYU6fdlq4kuBHxAsRZtSyDRo1wiERKJqCjLd0aaHav0Y4mbggKoeYeSaHR79RXMFK1t6uA07iom8V/RiNUEnSP436V7W5KEGsTzCX2gLxl+nbZciGmxKZfdHR8EQW9Z8z6pvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzrnTHRl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzrnTHRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788233574; x=1819769574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HUikrqy/PEdZzPZ4G8ooZ3kBbhhLbO9KeBbojD3VI8o=;
  b=hzrnTHRlEZwGMFSXpX0r1RhgLhe6SwOkutrkbiaSMk+s2dkoCbpl/+VF
   90lrtgVe3WpkIz1b9GZg22+mWpNTckJDWfBcJ2bCFrcC4GdRbnO6UIRdV
   2wAZa0H3O3Tlg0vSCuVUU9BEr1lfCmDnykxa4aCRbk2hD92y/Sk5vqqd6
   fbJ23HBTRqdt3g5gnE3zEcyoSzHllSUyUgnD0y43hz267eG55H7Fgi6/3
   nxxVjWvEFLnwC/VuB49lDyTqCe4IU5FHYoKNpHb0Jb/4HGk+CJ7PwShX3
   Ft9XhsLTZ6UXkEp5gzD5uNBTNCtjR2HwoYlkxtaLEA+QYkHLlOod0u9N/
   g==;
X-CSE-ConnectionGUID: Db3Ak8JTT5CKSDnmMKiCtA==
X-CSE-MsgGUID: +BuAAQFPTRyHydBr7GmEEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88855629"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88855629"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:32:53 -0700
X-CSE-ConnectionGUID: yYCzCeWuT4OSAJrT5wrmLw==
X-CSE-MsgGUID: HLDLnQ+WS7Wp6MN9s8kEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="267166887"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:32:50 -0700
Message-ID: <c12b2e2f-8872-405a-98e1-e594889797b4@linux.intel.com>
Date: Tue, 1 Sep 2026 11:32:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-10-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-10-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/28/2026 6:37 AM, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
> starting with PerfMon v5, and support non-contiguous GP counters
> through the Architectural PerfMon Extension (CPUID leaf 23H).
>
> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
> which may contain sparse bits representing non-contiguous counters.
> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
> bitmask fields.
>
> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
> the number of consecutive counters starting at index 0.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/cpuid.c         | 14 +++++++++++---
>  arch/x86/kvm/msrs.c          | 12 ++++++------
>  arch/x86/kvm/pmu.c           | 21 ++++++++++++---------
>  arch/x86/kvm/svm/pmu.c       |  2 +-
>  arch/x86/kvm/svm/svm.c       |  9 +++++----
>  arch/x86/kvm/vmx/pmu_intel.c |  7 ++++---
>  arch/x86/kvm/vmx/vmx.c       |  7 +++++--
>  7 files changed, 44 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ddb022cb203a..106e719e7aee 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1528,10 +1528,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
> @@ -1896,7 +1904,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>  
> -		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
> +		ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);
>  		entry->ebx = ebx.full;
>  		break;
>  	}
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 66fa7140d65d..49ab49f7c96e 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -2610,20 +2610,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
> index 7837e2e1af98..437a7bc49bf8 100644
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
> @@ -177,10 +176,14 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
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
> +
> +	/* Legacy vPMU exposes at most 3 fixed counters. */
> +	if (!enable_mediated_pmu)
> +		kvm_pmu_cap.fixed_cntr_mask64 &= GENMASK_ULL(2, 0);
>  
>  	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
>  		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
> @@ -786,8 +789,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
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
> index 0943ccc1d6b8..fb5a298244ec 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -203,7 +203,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  	}
>  
>  	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> -			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> +			    kvm_pmu_cap.cntr_mask64;
>  
>  	if (pmu->version > 1) {
>  		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fb8442a08b63..6f3427027e99 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -754,6 +754,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  	bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> +	unsigned long host_only_gp_mask;
>  	int i;
>  
>  	if (!enable_mediated_pmu)
> @@ -772,7 +773,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>  					  MSR_TYPE_RW, intercept);
>  
> -	for ( ; i < kvm_pmu_cap.num_counters_gp; i++)
> +	host_only_gp_mask = kvm_pmu_cap.cntr_mask64 & ~gp_mask;
> +	kvm_for_each_gp_counter(i, host_only_gp_mask)
>  		svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>  					     MSR_TYPE_RW);
>  
> @@ -5563,9 +5565,8 @@ static __init void svm_set_cpu_caps(void)
>  		 * access to enough counters to virtualize "core" support,
>  		 * otherwise limit vPMU support to the legacy number of counters.
>  		 */
> -		if (kvm_pmu_cap.num_counters_gp < AMD64_NUM_COUNTERS_CORE)
> -			kvm_pmu_cap.num_counters_gp = min(AMD64_NUM_COUNTERS,
> -							  kvm_pmu_cap.num_counters_gp);
> +		if (hweight64(kvm_pmu_cap.cntr_mask64) < AMD64_NUM_COUNTERS_CORE)
> +			kvm_pmu_cap.cntr_mask64 &= GENMASK_ULL(AMD64_NUM_COUNTERS - 1, 0);
>  		else
>  			kvm_cpu_cap_check_and_set(X86_FEATURE_PERFCTR_CORE);
>  
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 926d1c57f8bf..4df55a3e21da 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -491,7 +491,8 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  	 * have a known encoding for the associated general purpose event.
>  	 */
>  	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> -	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
> +	WARN_ON_ONCE(!eventsel &&
> +		     (kvm_pmu_cap.fixed_cntr_mask64 & BIT_ULL(index)));
>  	return eventsel;
>  }
>  
> @@ -548,7 +549,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
>  	fixed_cntr_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
> -	fixed_cntr_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
> +	fixed_cntr_mask &= kvm_pmu_cap.fixed_cntr_mask64;
>  
>  	/*
>  	 * The number of counters comes from guest CPUID data. Clamp the value
> @@ -556,7 +557,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	 */
>  	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
>  	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> -			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> +			    kvm_pmu_cap.cntr_mask64;
>  
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (entry &&
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index be994adbd954..56daf5c61082 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4230,6 +4230,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  	bool has_mediated_pmu = kvm_vcpu_has_mediated_pmu(vcpu);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	unsigned long host_only_gp_mask, host_only_fixed_mask;
>  	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>  	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>  	bool intercept = !has_mediated_pmu;
> @@ -4252,23 +4253,25 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  
>  	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
>  
> +	host_only_gp_mask = kvm_host_pmu.cntr_mask64 & ~gp_mask;
>  	kvm_for_each_gp_counter(i, gp_mask) {
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
>  					  MSR_TYPE_RW, intercept);
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
>  					  intercept || !fw_writes_is_enabled(vcpu));
>  	}
> -	for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
> +	for_each_set_bit(i, &host_only_gp_mask, INTEL_PMC_MAX_GENERIC) {
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
>  					  MSR_TYPE_RW, true);
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i,
>  					  MSR_TYPE_RW, true);
>  	}
>  
> +	host_only_fixed_mask = kvm_host_pmu.fixed_cntr_mask64 & ~fixed_mask;
>  	kvm_for_each_fixed_counter(i, fixed_mask)
>  		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>  					  MSR_TYPE_RW, intercept);
> -	for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
> +	for_each_set_bit(i, &host_only_fixed_mask, INTEL_PMC_MAX_FIXED)
>  		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>  					  MSR_TYPE_RW, true);
>  

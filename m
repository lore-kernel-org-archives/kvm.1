Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A3C19E839;
	Thu, 30 Apr 2026 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777515594; cv=none; b=nTmSBN+xGDualZ+EwsckRH/joXS9EWC2uRAN/OqPjmpiNBQ0bH1gv42gm9Zjk67XPoaZkRFPBynjRbnexus7ZGkqJXXZw/T0z03H81bnsTdqsb69bk0z/oMOGYkdoz5XF7QumvtuvrmRdidtk6p+HO7Y/gogUjHM4SHDzJ3k7L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777515594; c=relaxed/simple;
	bh=ZQ8pl4PUITLBxwbMUG2QpqPDeEQFM+JHL/EckPD7MFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGCcQQG/duuZLiU1rNmRorokCR9H2K8QJ59+owXulVhDUihFecBBehy5DxeJJp3ZExtKkf3D4siKdu7h5slOhS/WvPDNKA7HEHJehNUFAmZOg2WPL1Bdt2C/r9hCWKaqtDw/1FyNojty2MwKUVsg4izwvUDYa+1RzfsJ4A+AgAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0/5dNtQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0/5dNtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777515592; x=1809051592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZQ8pl4PUITLBxwbMUG2QpqPDeEQFM+JHL/EckPD7MFU=;
  b=K0/5dNtQs67nEcIloYZELB4pHSwm3iTJLkjzMjy3MMqF+ajoXLZqQAuz
   yW0ldZ69m8An7QYYuXSXRNZf1207BmHzEfmo1H0vHSpNtSX5KUE9pF/V9
   hPp1Ih6AawCY+9lxZgnxp4vXegL8VBC0wWzXD8nBubQGl/Den3ZANHD+o
   3SJ0cBpEdSas/2VcrcJv9SgSqUUtSz+Ckrpof3+NnvPhmooCoEMCffA3k
   Preh+4mRlAOXqJSckDfBAMNOhXTCJ8dnIsvMcYDBq6A/U4knsKyV/+O8w
   Bn5yJiyCXJJfP88SCEBXHMs3z9BcrG6veuAkaahZHUhLqL4IZ4SvDteqf
   Q==;
X-CSE-ConnectionGUID: 1ZT/K5KrSqSqtP0dWRR3EQ==
X-CSE-MsgGUID: RqpcOikFT/K2Q0e7yx1aZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88769249"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="88769249"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:19:51 -0700
X-CSE-ConnectionGUID: ZpzBjWtzQhKnIFWe3/jPpQ==
X-CSE-MsgGUID: jXzSwnz0Q/uQ2Yxsz0hzrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238770914"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:19:49 -0700
Message-ID: <6d472e6e-ad75-4d0f-8475-469875806cc4@linux.intel.com>
Date: Thu, 30 Apr 2026 10:19:46 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] KVM: x86/pmu: Support Intel fixed counter 3 on
 mediated vPMU
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
 <20260423174639.56149-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260423174639.56149-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/24/2026 1:46 AM, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Starting with Ice Lake, Intel introduces fixed counter 3, which counts
> TOPDOWN.SLOTS - the number of available slots for an unhalted logical
> processor.  It serves as the denominator for top-level metrics in the
> Top-down Microarchitecture Analysis method.
>
> Emulating this counter on legacy vPMU would require introducing a new
> generic perf encoding for the Intel-specific TOPDOWN.SLOTS event in
> order to call perf_get_hw_event_config().  This is undesirable as it
> would pollute the generic perf event encoding.
>
> Moreover, KVM does not intend to emulate IA32_PERF_METRICS in the
> legacy vPMU model, and without IA32_PERF_METRICS, emulating this
> counter has little practical value.  Therefore, expose fixed counter
> 3 to guests only when mediated vPMU is enabled.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Don't advertise fixed counter 3 to userspace if the host doesn't
>   support it.
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/cpuid.c            | 9 +++++++--
>  arch/x86/kvm/pmu.c              | 4 ++++
>  arch/x86/kvm/x86.c              | 4 ++--
>  4 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index c470e40a00aa..cb736a4c72ea 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -556,7 +556,7 @@ struct kvm_pmc {
>  #define KVM_MAX_NR_GP_COUNTERS		KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
>  						KVM_MAX_NR_AMD_GP_COUNTERS)
>  
> -#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	3
> +#define KVM_MAX_NR_INTEL_FIXED_COUNTERS	4
>  #define KVM_MAX_NR_AMD_FIXED_COUNTERS	0
>  #define KVM_MAX_NR_FIXED_COUNTERS	KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
>  						KVM_MAX_NR_AMD_FIXED_COUNTERS)
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e69156b54cff..d87a26f740e5 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1505,7 +1505,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	case 0xa: { /* Architectural Performance Monitoring */
>  		union cpuid10_eax eax = { };
> -		union cpuid10_edx edx = { };
> +		union cpuid10_edx edx = { }, host_edx;
>  
>  		if (!enable_pmu || !static_cpu_has(X86_FEATURE_ARCH_PERFMON)) {
>  			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> @@ -1516,9 +1516,14 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
>  		eax.split.bit_width = kvm_pmu_cap.bit_width_gp;
>  		eax.split.mask_length = kvm_pmu_cap.events_mask_len;
> -		edx.split.num_counters_fixed = kvm_pmu_cap.num_counters_fixed;
>  		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
>  
> +		/* Guest does not support non-contiguous fixed counters. */
> +		host_edx = (union cpuid10_edx)entry->edx;
> +		edx.split.num_counters_fixed =
> +			 min_t(int, kvm_pmu_cap.num_counters_fixed,
> +			       host_edx.split.num_counters_fixed);

kvm_pmu_cap are derived from kvm_pmu_host which already represents host
fixed counters number, why host fixed counters number is checked again here?

Besides, we can't only depend on the fixed counters number to check if
fixed counter 3 is supported on host, e.g., CWF supports fixed counter 4, 5
and 6 but doesn't support fixed counter 3. Before adding PerfmonExt (0x23)
CPUID leaves support in KVM, we need to check the  CPUID.0xa.ecx to get the
real fixed countera bitmap and then check if fixed counter 3 is supported.

Thanks.


> +
>  		if (kvm_pmu_cap.version)
>  			edx.split.anythread_deprecated = 1;
>  
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index e218352e3423..9ff4a6a9cd0b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -148,12 +148,16 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>  	}
>  
>  	memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
> +
>  	kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
>  	kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
>  					  pmu_ops->MAX_NR_GP_COUNTERS);
>  	kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
>  					     KVM_MAX_NR_FIXED_COUNTERS);
>  
> +	if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
> +		kvm_pmu_cap.num_counters_fixed = 3;
> +
>  	kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
>  		perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
>  	kvm_pmu_eventsel.BRANCH_INSTRUCTIONS_RETIRED =
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0a1b63c63d1a..604072d9354f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -360,7 +360,7 @@ static const u32 msrs_to_save_base[] = {
>  
>  static const u32 msrs_to_save_pmu[] = {
>  	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
> -	MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
> +	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>  	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
>  	MSR_CORE_PERF_GLOBAL_CTRL,
>  	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
> @@ -7756,7 +7756,7 @@ static void kvm_init_msr_lists(void)
>  {
>  	unsigned i;
>  
> -	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
> +	BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
>  			 "Please update the fixed PMCs in msrs_to_save_pmu[]");
>  
>  	num_msrs_to_save = 0;

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F25695;
	Thu, 20 Aug 2026 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787187373; cv=none; b=oYzQI501Y0PllHUwtqhvSHSEOfVhINNC3qDuK3lNN2mNvC7WkwEobbw040whmqmDBrZo+2A7ZwN70mX1xi2m9Mo1BMlQtskSiwb/3JPYyM44S57eOLWSj7e4CmnyME88JWwE+iXOEuIJsrjcYzAGiXiISuqHFCWQY+bdkWNtMF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787187373; c=relaxed/simple;
	bh=57UNup5B1ADf9JasLR1GgMiI1lwBUR8roKrIyY55GHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4G/O1vOZQOsbjIMGFW0QLIBA5ZT+DwhqJM4iRDcFl1wgeTPwoqep9ob1iKObK5obOuqE2AIp/2+p6QkoVaGcHRt7Nj6nSqYn6c1p2ODduIZrXIbpqLW7xPjPYINiwp6+yss3JdZe5FHRxLc1lMbWQst7Gqo0HZLI0Omzf/bL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBXcshwa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBXcshwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787187371; x=1818723371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=57UNup5B1ADf9JasLR1GgMiI1lwBUR8roKrIyY55GHM=;
  b=EBXcshwahMU8fzB4wwAiVMQmkxMW3Q1FtqvIB5GBXHupuEFTteZALNZF
   YvvJyjGHW7DW4Org8f5z1usnYcn6Gjc2igiq8bj47p/yGU05Zo5FU3QSC
   JhOYKUmsjehYV3XROtLhf5GuSw92FdEhhNwhZyH2HP5Rx+cH9auS5+ZpX
   stPI9h+io4oJ58vF3BAug9EN4OTYbj6NFu9DKSZIhjufiHLhGqqVODWJO
   yBx2UDyg7GTt5U16aYA+TlyiUOXGU1mWSpVYz8PUnWK+afEX9R5ricOGI
   iu7jU9qy3BtgbVo1Ti4j9TeabachX5TmRGOKq7P8y/r00pTQ741CxgESM
   Q==;
X-CSE-ConnectionGUID: 93DosZe+QKyH0/zgc9mj8w==
X-CSE-MsgGUID: VsE8NVeGRfGgcwxTHtJvag==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="91524388"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="91524388"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 17:56:10 -0700
X-CSE-ConnectionGUID: QR0HrIZWRzOorDkyILkeJw==
X-CSE-MsgGUID: UZjWWHzWR0KC6V0zuuXevQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="266372671"
Received: from unknown (HELO [10.238.3.58]) ([10.238.3.58])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 17:56:08 -0700
Message-ID: <5fa22009-0606-4523-9a84-e49c9b67fde2@linux.intel.com>
Date: Thu, 20 Aug 2026 08:56:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-6-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260817183143.226156-6-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/18/2026 2:31 AM, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
> built-in support for Topdown Microarchitecture Analysis (TMA) L1
> metrics via the IA32_PERF_METRICS MSR.
>
> Expose this capability only when mediated vPMU is enabled, as emulating
> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>
> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>
> Save and restore this MSR on host/guest PMU context switches so that
> host PMU activity does not clobber the guest value, and guest state
> is not leaked into the host.
>
> If the host supports PERF_METRICS but it is not exposed to the guest,
> MSR_CORE_PERF_GLOBAL_CTRL must be intercepted so the guest cannot
> enable PERF_METRICS via GLOBAL_CTRL[48].
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v8:
> - Intercept global ctrl MSR if host supports PerfMetrics but not
>   enabled in the guest.
> v7:
> - Clear bit 48 in global_ctrl_rsvd instead of explicitly clearing it in
>   global_status_rsvd, allowing it to propagate through the assignment
>   from global_ctrl_rsvd.
> - Add comments documenting the all-zero PERF_METRICS/FC3 write-order
>   exception.
> - Add nested_vmx_merge_msr_bitmaps_rw(MSR_PERF_METRICS);
> v5:
> - Remove host_initiated check in set/get MSR handlers.
> v4:
> - Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
>   host_initiated. (Sashiko)
> - Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
> - Remove the redundant !! in vcpu_has_perf_metrics().
> v3:
> - Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
> - Add comments to explain why we don't validate writes on PERF_METRICS.
> ---
>  arch/x86/include/asm/kvm_host.h  |  1 +
>  arch/x86/include/asm/msr-index.h |  1 +
>  arch/x86/kvm/msrs.c              |  6 +++++-
>  arch/x86/kvm/pmu.c               |  7 +++++++
>  arch/x86/kvm/pmu.h               |  5 +++++
>  arch/x86/kvm/vmx/nested.c        |  2 ++
>  arch/x86/kvm/vmx/pmu_intel.c     | 34 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c           |  7 +++++++
>  8 files changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d893fa5be838..7166efdf79ce 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -583,6 +583,7 @@ struct kvm_pmu {
>  	u64 global_status_rsvd;
>  	u64 reserved_bits;
>  	u64 raw_event_mask;
> +	u64 perf_metrics;
>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>  
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 18c4be75e927..fdcaeb6c8352 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -331,6 +331,7 @@
>  #define PERF_CAP_PEBS_FORMAT		0xf00
>  #define PERF_CAP_FW_WRITES		BIT_ULL(13)
>  #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
> +#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
>  #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
>  #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>  					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 1fbd8f08a7f0..2b2cc6bf3ce7 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -219,7 +219,7 @@ static const u32 msrs_to_save_pmu[] = {
>  	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>  	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>  	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
> -	MSR_CORE_PERF_GLOBAL_CTRL,
> +	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
>  	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>  
>  	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
> @@ -2608,6 +2608,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>  		     intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
>  			return;
>  		break;
> +	case MSR_PERF_METRICS:
> +		if (!(kvm_caps.supported_perf_cap & PERF_CAP_PERF_METRICS))
> +			return;
> +		break;
>  	case MSR_ARCH_PERFMON_PERFCTR0 ...
>  	     MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>  		if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 913a0ecbf260..2fddcbc8924d 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>  	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
>  }
>  
> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> +{
> +	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
> +		!kvm_vcpu_has_perf_metrics(vcpu);
> +}
> +
>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>  {
>  	return kvm_need_any_pmc_intercept(vcpu) ||
> +	       kvm_need_perf_metrics_intercept(vcpu) ||
>  	       !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 82f955e5a450..be578013ed83 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -279,6 +279,11 @@ static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.perf_capabilities;
>  }
>  
> +static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
> +{
> +	return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
> +}
> +
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
>  int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 7ed79894d11d..e81b8a5423c8 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -717,6 +717,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
>  	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
>  	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
>  	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
> +
> +	nested_vmx_merge_msr_bitmaps_rw(MSR_PERF_METRICS);
>  }
>  
>  /*
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 100c072b7fb3..1fd0480baf68 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -189,6 +189,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
> +	case MSR_PERF_METRICS:
> +		return kvm_vcpu_has_perf_metrics(vcpu);
>  	case MSR_IA32_PEBS_ENABLE:
>  		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
>  		break;
> @@ -346,6 +348,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data = pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_PERF_METRICS:
> +		msr_info->data = pmu->perf_metrics;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		msr_info->data = pmu->pebs_enable;
>  		break;
> @@ -395,6 +400,14 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (pmu->fixed_ctr_ctrl != data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> +	case MSR_PERF_METRICS:
> +		/*
> +		 * Bits [63:32] are ignored on hardware that supports only
> +		 * level-1 metrics, but may be valid on hardware that supports
> +		 * level-2 metrics. Preserve guest writes verbatim.
> +		 */
> +		pmu->perf_metrics = data;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		if (data & pmu->pebs_enable_rsvd)
>  			return 1;
> @@ -577,6 +590,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>  	pmu->global_ctrl_rsvd = counter_rsvd;
> +	if (perf_capabilities & PERF_CAP_PERF_METRICS)
> +		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
>  
>  	/*
>  	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
> @@ -633,6 +648,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>  
>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>  {
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	pmu->perf_metrics = 0;
>  	intel_pmu_release_guest_lbr_event(vcpu);
>  }
>  
> @@ -803,6 +821,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	u64 global_status, toggle;
>  
> +	if (kvm_vcpu_has_perf_metrics(vcpu))
> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
> +
>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>  	toggle = pmu->global_status ^ global_status;
>  	if (global_status & toggle)
> @@ -831,6 +852,19 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>  	 */
>  	if (pmu->fixed_ctr_ctrl_hw)
>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +
> +	if (kvm_vcpu_has_perf_metrics(vcpu)) {
> +		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
> +		/*
> +		 * The SDM requires restoring fixed counter 3 before
> +		 * PERF_METRICS. However, this path writes 0 to PERF_METRICS
> +		 * before fixed counter 3. For this all-zero case, the
> +		 * resulting hardware state is therefore the same regardless
> +		 * of write order.
> +		 */
> +		if (pmu->perf_metrics)
> +			wrmsrq(MSR_PERF_METRICS, 0);
> +	}
>  }
>  
>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6e9d197982b7..8cb9d642277a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4277,6 +4277,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  				  MSR_TYPE_RW, intercept);
>  	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>  				  MSR_TYPE_RW, intercept);
> +
> +	intercept = !has_mediated_pmu || !kvm_vcpu_has_perf_metrics(vcpu);
> +	vmx_set_intercept_for_msr(vcpu, MSR_PERF_METRICS,
> +				  MSR_TYPE_RW, intercept);
>  }
>  
>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)
> @@ -8068,6 +8072,9 @@ static __init u64 vmx_get_perf_capabilities(void)
>  		perf_cap &= ~PERF_CAP_PEBS_BASELINE;
>  	}
>  
> +	if (enable_mediated_pmu)
> +		perf_cap |= kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS;
> +
>  	return perf_cap;
>  }
>  

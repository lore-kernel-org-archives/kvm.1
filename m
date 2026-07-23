Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C42C86D;
	Thu, 23 Jul 2026 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824257; cv=none; b=NeiNPkhPUgYF0HukqMFvrgs+3e7QDrjlpYB0jxEYfJPTIXR8V2q/Im5H2KgUPX/MJJ9OEH2IEbHkxLEjZuyOMTFM7HpJqZPH8wmRwHmdKFLh4mT6xfxRYFqfbUQ9ikC8Y7I8vcd2QWYFux0KVPHmOJqB+50LYo6S/6km5XIktNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824257; c=relaxed/simple;
	bh=ZU4EKq62WYgI4lju8VcJOLIsVSnBvjImVHyH2flYWuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2N3NK8+L7RLXeD1hhQDjKbvfk5Sz1ee3pGnvwzCLRs7rEea2FObNA6tIYukIj+3yk48QO06MO0Gabq0pQ9snVwSm4hKsFHSYMDP2ddoslFwdCC3KlSvc+FGC0sFVj46xQkV7Rnw17jcWkIhD51sqMMnbcGM4m4Luo/1LYRPGnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ULcLWJoS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ULcLWJoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784824255; x=1816360255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZU4EKq62WYgI4lju8VcJOLIsVSnBvjImVHyH2flYWuI=;
  b=ULcLWJoSKa8UN9j44yCN19IoET0VF5bqr5Ls4EGf21tm93jK/O9x+gne
   bhgcIKZ9+Q4JaYJWK1X3feZIycRwfWwcuD02NC+JcN7XDQwEnFS4M5p8X
   SEG7fic1FFbTuDPlAcVMmq8N/8u9B5doZDHYlGY0PvUUASVuzftLdgfYw
   UjOMSjypIdlypQp59au2CZJyU9JU+tN60OUXmRybU92pAQtcfINOlrWZO
   Yv2tC9i0XTPqfpshuiQQqSBlseTix0+pU12RhQpSp/zquOQ08Kphl806X
   E3mQcvpNYA9D74rfwfhO6YbQ7ZQ5eVvdWjm31Q4LKf24ORtoqPs7hDv2u
   A==;
X-CSE-ConnectionGUID: /qFI5QyKS3ulaeSul2mzuQ==
X-CSE-MsgGUID: S0JRM1tLR1CiVfttB/gRJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89381032"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="89381032"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 09:30:54 -0700
X-CSE-ConnectionGUID: zXzF2R3fT0qm8QDsy6GlYA==
X-CSE-MsgGUID: RfWjPi3ASsyLzz6HhoWKPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="263428130"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 09:30:53 -0700
Message-ID: <14186951-940a-41ce-9810-42ab4688d048@intel.com>
Date: Thu, 23 Jul 2026 11:30:52 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-6-zide.chen@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260629231938.15129-6-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/29/2026 6:19 PM, Zide Chen wrote:
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
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
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
>  arch/x86/include/asm/kvm_host.h   |  1 +
>  arch/x86/include/asm/msr-index.h  |  1 +
>  arch/x86/include/asm/perf_event.h |  1 +
>  arch/x86/kvm/msrs.c               |  6 +++++-
>  arch/x86/kvm/pmu.h                |  5 +++++
>  arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c            |  7 +++++++
>  7 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 80f638588bf7..96376d8a5199 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -630,6 +630,7 @@ struct kvm_pmu {
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
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 1eb13673e889..bc2e1cbcd9b9 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -447,6 +447,7 @@ static inline bool is_topdown_idx(int idx)
>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
> +#define GLOBAL_STATUS_PERF_METRICS_OVF		BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
>  
>  #define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
>  /*
> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> index 3bf42d90ad14..c751a8dbd45d 100644
> --- a/arch/x86/kvm/msrs.c
> +++ b/arch/x86/kvm/msrs.c
> @@ -230,7 +230,7 @@ static const u32 msrs_to_save_pmu[] = {
>  	MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>  	MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>  	MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
> -	MSR_CORE_PERF_GLOBAL_CTRL,
> +	MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
>  	MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>  
>  	/* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
> @@ -2625,6 +2625,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
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
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 1b2f66a2e915..3066cade5790 100644
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
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index e426ddc8add4..225afd3937c3 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -188,6 +188,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
> +	case MSR_PERF_METRICS:
> +		return kvm_vcpu_has_perf_metrics(vcpu);
>  	case MSR_IA32_PEBS_ENABLE:
>  		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
>  		break;
> @@ -345,6 +347,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data = pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_PERF_METRICS:
> +		msr_info->data = pmu->perf_metrics;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		msr_info->data = pmu->pebs_enable;
>  		break;
> @@ -394,6 +399,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (pmu->fixed_ctr_ctrl != data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> +	case MSR_PERF_METRICS:
> +		/*
> +		 * On platforms that support only hardware level-1, bits [63:32]
> +		 * are reserved and ignored by hardware. If hardware level-2 is also
> +		 * supported, they may contain valid metric data.
> +		 * Either way, guest writes are passed through verbatim.
> +		 */
> +		pmu->perf_metrics = data;
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		if (data & pmu->pebs_enable_rsvd)
>  			return 1;
> @@ -589,6 +603,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  		pmu->global_status_rsvd &=
>  				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
>  
> +	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
> +		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
> +		pmu->global_status_rsvd &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
> +	}
> +

Nit: the following code looks cleaner. Since bits [48:0] are identical
between the GLOBAL_CTRL and GLOBAL_STATUS MSRs, follow the existing
pattern of deriving global_status_rsvd from global_ctrl_rsvd, then
handle bits [63:49] separately.

@@ -577,6 +590,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
        counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
                         ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) <<
KVM_FIXED_PMC_BASE_IDX));
        pmu->global_ctrl_rsvd = counter_rsvd;
+       if (perf_capabilities & PERF_CAP_PERF_METRICS)
+               pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;

        /*
         * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
         * share reserved bit definitions.  The kernel just happens to use
         * OVF_CTRL for the names.
         */
        pmu->global_status_rsvd = pmu->global_ctrl_rsvd
                        & ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
                            MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);


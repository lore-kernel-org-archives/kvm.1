Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71C3B2FE7;
	Tue,  1 Sep 2026 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232056; cv=none; b=V1h22PpnqAO+ryM8DY0aN86k56TmPFQXtaUizUC5HLQdFaj0dgJDjYVclMn6hNp+WSxV0drVw6JY1m8IX/bRTU45nInnQV7Pq+fqCNlc0WMnRhhD9NB3gW5C8uqViL1aGMraCUEvKElB142a0oR9Tju+MuhV1JJJOYQvyyOz91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232056; c=relaxed/simple;
	bh=aivXxpPBqyH62FaY3tMP07dxeHXjlR9jmFfvDSB6Z54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=djhlDc8LA+z9GsuUXtYxraS0xNbt6RGx2pWJe1qFqgL25PX8sQHxcNQTFB4DQ1nY3fic7U9q+dCdN9oPMqJH9vVztXAQZfPNnmSpv2fTCgmi50W1gj6C41SDrMJHSY+wlvE/Z4ijTImyLxYKhWqgPWyIiRLCqQ8RU49RKtkr4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHA/+Pij; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHA/+Pij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788232054; x=1819768054;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aivXxpPBqyH62FaY3tMP07dxeHXjlR9jmFfvDSB6Z54=;
  b=eHA/+Pij0Mtq82rjE9CvuoVtIAIzm5fpdvBvvxuPMc0Op/j8nfB0wKU7
   GBhWJXrs0u4amWUAOoFvpMQPOtx6wF05nqjMh4DsN82MWt5Ou9xfrWcKA
   ENvYYt3r2SKXCYKlkp+DCJY7m7N9bK1ALMnsj5SmeWE2SwGsKNq30+6o3
   qv7mMCMugAMQCE5a0bXRj4Vcph3aOv0/HmuLC3V33/KA0yr0+GBwhRqEo
   eNhfwhC0TiTtoxTVxAZeSwFIWdtCFEXm6mdyPOa25P4IJ/ivzeg3Py5Gq
   OwqzKz5f4MJy9NOBN9lnUXINW0pm5ZsYfatLa2X/9pyrBUZdiXDeOM/k6
   Q==;
X-CSE-ConnectionGUID: w4kM+EatQbqpPjei92r02Q==
X-CSE-MsgGUID: lYdxLYKgR7+yuIOdWlFgww==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88853290"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88853290"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:07:34 -0700
X-CSE-ConnectionGUID: ABWoG1P7RRKjSKNtlRLDqA==
X-CSE-MsgGUID: VNmO97GwT4aPqrNf6OLozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="267161243"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 20:07:31 -0700
Message-ID: <2bb5aa22-42f0-4d65-a1f9-572084ba2eec@linux.intel.com>
Date: Tue, 1 Sep 2026 11:07:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/28/2026 6:37 AM, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> This is a preparatory step toward fully bitmap-based PMU capability
> handling. Later patches switch KVM's view of host PMU capabilities from
> counter counts to counter bitmaps.
>
> Populate and use pmc_exists directly when walking guest-visible PMCs,
> instead of relying on pmu->nr_arch_{gp,fixed}_counters as intermediate
> state.
>
> Iterate counters via the newly added pmc_exists based helpers, and
> remove the now-redundant nr_arch_{gp,fixed}_counters fields from struct
> kvm_pmu.
>
> Note: {vmx,svm}_recalc_pmu_msr_intercepts() may leave stale intercepts
> on GP MSRs after CPUID narrowing. This corner case is resolved by the
> following patch: "KVM: x86/pmu: Switch to bitmask-based KVM PMU
> capabilities".
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Fix AMD legacy PMU MSR intercept handling for guest PMU
>   narrowing reconfiguration by adding for_each_clear_bit_from().
> - Re-word the stale interception changelog part.
> ---
>  arch/x86/include/asm/kvm_host.h |  2 --
>  arch/x86/kvm/pmu.c              | 26 +++++++++----------
>  arch/x86/kvm/svm/pmu.c          | 25 ++++++++----------
>  arch/x86/kvm/svm/svm.c          |  8 ++++--
>  arch/x86/kvm/vmx/nested.c       |  6 +++--
>  arch/x86/kvm/vmx/pmu_intel.c    | 46 ++++++++++++++++++++++-----------
>  arch/x86/kvm/vmx/vmx.c          |  6 +++--
>  7 files changed, 68 insertions(+), 51 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 49a8a2e9cee0..717ba98c08c9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -569,8 +569,6 @@ struct kvm_pmc {
>  
>  struct kvm_pmu {
>  	u8 version;
> -	unsigned nr_arch_gp_counters;
> -	unsigned nr_arch_fixed_counters;
>  	unsigned available_event_types;
>  	u64 fixed_ctr_ctrl;
>  	u64 fixed_ctr_ctrl_hw;
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 964e74bdaaa7..b0fcd0a538d2 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -785,8 +785,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>  	 * KVM's capabilities are constrained based on KVM support, i.e. KVM's
>  	 * capabilities themselves may be a subset of hardware capabilities.
>  	 */
> -	return pmu->nr_arch_gp_counters != kvm_host_pmu.num_counters_gp ||
> -	       pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
> +	return kvm_gp_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_gp) - 1 ||
> +	       kvm_fixed_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_fixed) - 1;
>  }
>  
>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
> @@ -985,8 +985,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	kvm_pmu_reset(vcpu);
>  
>  	pmu->version = 0;
> -	pmu->nr_arch_gp_counters = 0;
> -	pmu->nr_arch_fixed_counters = 0;
>  	pmu->counter_bitmask[KVM_PMC_GP] = 0;
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
>  	/*
> @@ -1014,16 +1012,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	 * in the global controls).  Emulate that behavior when refreshing the
>  	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
>  	 */
> -	if (pmu->nr_arch_gp_counters &&
> +	if (kvm_gp_pmc_mask(pmu) &&
>  	    (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_pmu(vcpu)))
> -		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
> +		pmu->global_ctrl = kvm_gp_pmc_mask(pmu);
>  
>  	if (kvm_vcpu_has_mediated_pmu(vcpu))
>  		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
> -
> -	bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
> -	bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
> -		   pmu->nr_arch_fixed_counters);
>  }
>  
>  void kvm_pmu_init(struct kvm_vcpu *vcpu)
> @@ -1332,6 +1326,8 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
>  static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>  	struct kvm_pmc *pmc;
>  	u32 i;
>  
> @@ -1340,14 +1336,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
>  	 * is intercepted if hardware has counters that aren't visible to the
>  	 * guest (KVM will inject #GP as appropriate).
>  	 */
> -	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +	kvm_for_each_gp_counter(i, gp_mask) {
>  		pmc = &pmu->gp_counters[i];
>  
>  		if (pmc->counter != rdpmc(i))
>  			wrmsrq(gp_counter_msr(i), pmc->counter);
>  		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
>  	}
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +	kvm_for_each_fixed_counter(i, fixed_mask) {
>  		pmc = &pmu->fixed_counters[i];
>  
>  		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
> @@ -1390,6 +1386,8 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
>  static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>  	struct kvm_pmc *pmc;
>  	u32 i;
>  
> @@ -1397,7 +1395,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
>  	 * Clear selectors and counters to ensure hardware doesn't count using
>  	 * guest controls when the host (perf) restores its state.
>  	 */
> -	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +	kvm_for_each_gp_counter(i, gp_mask) {
>  		pmc = &pmu->gp_counters[i];
>  
>  		pmc->counter = rdpmc(i);
> @@ -1407,7 +1405,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
>  			wrmsrq(gp_eventsel_msr(i), 0);
>  	}
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +	kvm_for_each_fixed_counter(i, fixed_mask) {
>  		pmc = &pmu->fixed_counters[i];
>  
>  		pmc->counter = rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i);
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 52224872e0d4..0943ccc1d6b8 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -27,12 +27,11 @@ enum pmu_type {
>  
>  static struct kvm_pmc *amd_pmu_get_pmc(struct kvm_pmu *pmu, int pmc_idx)
>  {
> -	unsigned int num_counters = pmu->nr_arch_gp_counters;
> -
> -	if (pmc_idx >= num_counters)
> +	if (!kvm_is_gp_pmc_supported(pmu, pmc_idx))
>  		return NULL;
>  
> -	return &pmu->gp_counters[array_index_nospec(pmc_idx, num_counters)];
> +	pmc_idx = array_index_nospec(pmc_idx, KVM_MAX_NR_AMD_GP_COUNTERS);
> +	return &pmu->gp_counters[pmc_idx];
>  }
>  
>  static inline struct kvm_pmc *get_gp_pmc_amd(struct kvm_pmu *pmu, u32 msr,
> @@ -77,7 +76,7 @@ static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  
> -	if (idx >= pmu->nr_arch_gp_counters)
> +	if (!kvm_is_gp_pmc_supported(pmu, idx))
>  		return -EINVAL;
>  
>  	return 0;
> @@ -117,7 +116,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  		return pmu->version > 1;
>  	default:
>  		if (msr > MSR_F15H_PERF_CTR5 &&
> -		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
> +		    msr < MSR_F15H_PERF_CTL0 + 2 * hweight_long(kvm_gp_pmc_mask(pmu)))
>  			return pmu->version > 1;
>  		break;
>  	}
> @@ -184,6 +183,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  
>  static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
> +	unsigned int nr_gp_counters = AMD64_NUM_COUNTERS;
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	union cpuid_0x80000022_ebx ebx;
>  
> @@ -197,18 +197,16 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  		BUILD_BUG_ON(x86_feature_cpuid(X86_FEATURE_PERFMON_V2).function != 0x80000022 ||
>  			     x86_feature_cpuid(X86_FEATURE_PERFMON_V2).index);
>  		ebx.full = kvm_find_cpuid_entry_index(vcpu, 0x80000022, 0)->ebx;
> -		pmu->nr_arch_gp_counters = ebx.split.num_core_pmc;
> +		nr_gp_counters = ebx.split.num_core_pmc;
>  	} else if (guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
> -		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS_CORE;
> -	} else {
> -		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
> +		nr_gp_counters = AMD64_NUM_COUNTERS_CORE;
>  	}
>  
> -	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
> -					 kvm_pmu_cap.num_counters_gp);
> +	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> +			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
>  
>  	if (pmu->version > 1) {
> -		pmu->global_ctrl_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
> +		pmu->global_ctrl_rsvd = ~pmu->pmc_exists64;
>  		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
>  	}
>  
> @@ -227,7 +225,6 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
>  	/* not applicable to AMD; but clean them to prevent any fall out */
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
> -	pmu->nr_arch_fixed_counters = 0;
>  }
>  
>  static void amd_pmu_init(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 9d607b98bd06..fb8442a08b63 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -753,18 +753,22 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  {
>  	bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>  	int i;
>  
>  	if (!enable_mediated_pmu)
>  		return;
>  
>  	/* Legacy counters are always available for AMD CPUs with a PMU. */
> -	for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
> +	for_each_set_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
>  		svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>  					  MSR_TYPE_RW, intercept);
> +	for_each_clear_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
> +		svm_enable_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
> +					     MSR_TYPE_RW);
>  
>  	intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
> -	for (i = 0; i < pmu->nr_arch_gp_counters; i++)
> +	kvm_for_each_gp_counter(i, gp_mask)
>  		svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>  					  MSR_TYPE_RW, intercept);
>  
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 7ed79894d11d..0cff369982ae 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -697,6 +697,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>  	int i;
>  
>  	/*
> @@ -706,12 +708,12 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
>  	if (!kvm_vcpu_has_mediated_pmu(vcpu))
>  		return;
>  
> -	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +	kvm_for_each_gp_counter(i, gp_mask) {
>  		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
>  		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
>  	}
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> +	kvm_for_each_fixed_counter(i, fixed_mask)
>  		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
>  
>  	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 9fdae437e569..926d1c57f8bf 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -66,12 +66,13 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  	 * hardware, e.g. to ensure the event filter is enforced.
>  	 */
>  	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw;
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>  	struct kvm_pmc *pmc;
>  	int i;
>  
>  	pmu->fixed_ctr_ctrl = data;
>  	pmu->fixed_ctr_ctrl_hw = data;
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +	kvm_for_each_fixed_counter(i, fixed_mask) {
>  		u8 new_ctrl = fixed_ctrl_field(data, i);
>  		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
>  
> @@ -107,6 +108,8 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	if (WARN_ON_ONCE(!pmu->version))
>  		return NULL;
>  
> +	idx &= INTEL_RDPMC_INDEX_MASK;
> +
>  	/*
>  	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
>  	 * are supported on all architectural PMUs, i.e. on all virtual PMUs
> @@ -117,23 +120,25 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	 */
>  	switch (type) {
>  	case INTEL_RDPMC_FIXED:
> +		if (!kvm_is_fixed_pmc_supported(pmu, idx))
> +			return NULL;
> +
>  		counters = pmu->fixed_counters;
> -		num_counters = pmu->nr_arch_fixed_counters;
> +		num_counters = KVM_MAX_NR_INTEL_FIXED_COUNTERS;
>  		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
>  		break;
>  	case INTEL_RDPMC_GP:
> +		if (!kvm_is_gp_pmc_supported(pmu, idx))
> +			return NULL;
> +
>  		counters = pmu->gp_counters;
> -		num_counters = pmu->nr_arch_gp_counters;
> +		num_counters = KVM_MAX_NR_INTEL_GP_COUNTERS;
>  		bitmask = pmu->counter_bitmask[KVM_PMC_GP];
>  		break;
>  	default:
>  		return NULL;
>  	}
>  
> -	idx &= INTEL_RDPMC_INDEX_MASK;
> -	if (idx >= num_counters)
> -		return NULL;
> -
>  	*mask &= bitmask;
>  	return &counters[array_index_nospec(idx, num_counters)];
>  }
> @@ -492,9 +497,10 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  
>  static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>  {
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>  	int i;
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> +	kvm_for_each_fixed_counter(i, fixed_mask)
>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>  }
>  
> @@ -506,6 +512,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	union cpuid10_eax eax;
>  	union cpuid10_edx edx;
>  	u64 perf_capabilities;
> +	u64 fixed_cntr_mask;
> +	int nr_gp_counters;
>  	u64 counter_rsvd;
>  
>  	if (!lbr_desc)
> @@ -532,8 +540,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (!pmu->version)
>  		return;
>  
> -	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
> -					 kvm_pmu_cap.num_counters_gp);
>  	eax.split.bit_width = min_t(int, eax.split.bit_width,
>  				    kvm_pmu_cap.bit_width_gp);
>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
> @@ -541,6 +547,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				      kvm_pmu_cap.events_mask_len);
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
> +	fixed_cntr_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
> +	fixed_cntr_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
> +
> +	/*
> +	 * The number of counters comes from guest CPUID data. Clamp the value
> +	 * to avoid a shift-by-64 in BIT_ULL().
> +	 */
> +	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
> +	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> +			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> +
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
> @@ -562,8 +579,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (pmu->version == 1)
>  		return;
>  
> -	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> -					    kvm_pmu_cap.num_counters_fixed);
> +	pmu->pmc_exists64 |= fixed_cntr_mask << INTEL_PMC_IDX_FIXED;
>  	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
>  					  kvm_pmu_cap.bit_width_fixed);
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
> @@ -572,8 +588,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  						 INTEL_FIXED_0_USER |
>  						 INTEL_FIXED_0_ENABLE_PMI);
>  
> -	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
> -			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
> +	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
> +			((u64)kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
>  	pmu->global_ctrl_rsvd = counter_rsvd;
>  
>  	/*
> @@ -596,7 +612,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
>  			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
>  		} else {
> -			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
> +			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
>  		}
>  	}
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index d3789b2ee18e..be994adbd954 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4230,6 +4230,8 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  	bool has_mediated_pmu = kvm_vcpu_has_mediated_pmu(vcpu);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>  	bool intercept = !has_mediated_pmu;
>  	int i;
>  
> @@ -4250,7 +4252,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  
>  	vm_exit_controls_changebit(vmx, vm_exit_controls_bits, has_mediated_pmu);
>  
> -	for (i = 0; i < pmu->nr_arch_gp_counters; i++) {
> +	kvm_for_each_gp_counter(i, gp_mask) {
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
>  					  MSR_TYPE_RW, intercept);
>  		vmx_set_intercept_for_msr(vcpu, MSR_IA32_PMC0 + i, MSR_TYPE_RW,
> @@ -4263,7 +4265,7 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  					  MSR_TYPE_RW, true);
>  	}
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> +	kvm_for_each_fixed_counter(i, fixed_mask)
>  		vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>  					  MSR_TYPE_RW, intercept);
>  	for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)

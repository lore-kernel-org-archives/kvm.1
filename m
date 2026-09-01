Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CAA3DDB0A;
	Tue,  1 Sep 2026 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230632; cv=none; b=cYrFHXsO7ddXaMd7NPgXSNSCj2uufrqb6bNA6cCHU4AP37ll6yx/33Yk2X/rsJeKq2btMZbzwFyldqB3q4c6C/0nXv0tAn4UvtyJOaF4yyepwXg7b2Yrw2L0D/Qw7q/R8/actVCtdA1fyeIiKleiq9LQqivJxo7n4oTTlzaKG/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230632; c=relaxed/simple;
	bh=SHlpgdmkY/kfdxCB7w9CDewJ9ySzomlcrVMpDtgh4Ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjJN9wHP8mz6xagUMIBgSzbZaHqeBFukY9VVcmEBCEjEEYl248AGqATyg81obNNyYdjb8jCR4uac6wZyMadHHf1SBKLXqDkTgFdC9tlLt7nijRQokHk/ftL1CWhON7iFSfks2HWuC9IxjQvUTntFB+AY43AwFZfU38/G6wYJpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ges1gwEM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ges1gwEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788230627; x=1819766627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SHlpgdmkY/kfdxCB7w9CDewJ9ySzomlcrVMpDtgh4Ts=;
  b=Ges1gwEMdRrmhuFyVMVoGn1MCMhNOr3yPyUd3dA0AYS+oygXl6SUV3qY
   7HpJO97Ly5Lq6W6k5mo33vg49escnoUggOk9gyTwQ5on0uqi1F6uT9iHX
   fNVTbUFiBfa5lqEYDJN1KeM+9E/SvMlKzxozr+o0UuVZupzZQByYUvxDn
   5jYx1zXS0MfnJBX/deG+0l45Wujb0OnPbQFBhHaetXHoFx67+HEolTLbY
   FSy27+SJYLCq2wJV+7VGEWx8dw/gloAa1LyXxUVbO1oRZWdJSyXdm5418
   qGiX8CzbPUGqfS1H4Wjl3ZARlwVmb9Dzxfcs6JmjutlYLZdRffBEHD368
   w==;
X-CSE-ConnectionGUID: iLvmdXD2THudz+AlluM/cg==
X-CSE-MsgGUID: lfZcMpq/S2O2rqIwyZV4qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92460311"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92460311"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:43:39 -0700
X-CSE-ConnectionGUID: HjoFYR/5TZy6Ex7Svvd2UQ==
X-CSE-MsgGUID: NPsuqi+qTqWGMCj+zvBQAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="274218807"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:43:36 -0700
Message-ID: <95652547-e849-4c82-9b2d-3dfee829166c@linux.intel.com>
Date: Tue, 1 Sep 2026 10:43:33 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-6-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-6-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/28/2026 6:37 AM, Zide Chen wrote:
> pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
> may include non-contiguous GP or fixed counters.
>
> pmu->pmc_exists already holds a bitmap indicating both fixed and
> general-purpose counters, and loops over valid counters can be done via
> pmu->pmc_exists alone. Extend it to a union so that the u64 alias is
> available for convenient mask arithmetic operations.
>
> Add the necessary helpers to prepare for bitmap-based PMC counter
> implementation.
>
> No functional change intended.
>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Rename kvm_{gp,fixed}_pmc_supported() to kvm_is_{gp,fixed}_pmc_supported()
>   and simplify them by removing the temporary bitmap. (Sean)
> - Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter()
>   and kvm_for_each_fixed_counter(). (Sean)
> ---
>  arch/x86/include/asm/kvm_host.h |  5 +++-
>  arch/x86/kvm/pmu.h              | 53 +++++++++++++++++++++++++++++----
>  2 files changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 90d80483df7f..49a8a2e9cee0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -594,7 +594,10 @@ struct kvm_pmu {
>  		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>  		atomic64_t __reprogram_pmi;
>  	};
> -	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> +	union {
> +		DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> +		u64 pmc_exists64;
> +	};
>  	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
>  
>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 090c9bbb74f4..b7a319b1eccc 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -88,6 +88,30 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>  }
>  
> +static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return pmu->pmc_exists64 &
> +	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
> +}
> +
> +static inline unsigned long kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
> +		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
> +}
> +
> +static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> +{
> +	return idx < KVM_MAX_NR_GP_COUNTERS &&
> +	       test_bit(idx, pmu->pmc_exists);
> +}
> +
> +static inline bool kvm_is_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> +{
> +	return idx < KVM_MAX_NR_FIXED_COUNTERS &&
> +	       test_bit(KVM_FIXED_PMC_BASE_IDX + idx, pmu->pmc_exists);
> +}
> +
>  /*
>   * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
>   * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
> @@ -104,11 +128,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>   */
>  static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>  {
> -	if (idx < pmu->nr_arch_gp_counters)
> +	if (kvm_is_gp_pmc_supported(pmu, idx))
>  		return &pmu->gp_counters[idx];
>  
>  	idx -= KVM_FIXED_PMC_BASE_IDX;
> -	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
> +	if (kvm_is_fixed_pmc_supported(pmu, idx))
>  		return &pmu->fixed_counters[idx];
>  
>  	return NULL;
> @@ -120,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>  			continue;				\
>  		else						\
>  
> +/*
> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
> + * so iteration up to KVM's maximum counter count is safe.
> + */
> +#define kvm_for_each_gp_counter(i, mask)	\
> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> +
> +#define kvm_for_each_fixed_counter(i, mask)	\
> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> +
>  static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
>  {
>  	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> @@ -168,9 +203,12 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
>  static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
>  					 u32 base)
>  {
> -	if (msr >= base && msr < base + pmu->nr_arch_gp_counters) {
> +	if (msr >= base && msr < base + KVM_MAX_NR_GP_COUNTERS) {
>  		u32 index = array_index_nospec(msr - base,
> -					       pmu->nr_arch_gp_counters);
> +					       KVM_MAX_NR_GP_COUNTERS);
> +
> +		if (!kvm_is_gp_pmc_supported(pmu, index))
> +			return NULL;
>  
>  		return &pmu->gp_counters[index];
>  	}
> @@ -183,9 +221,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
>  {
>  	int base = MSR_CORE_PERF_FIXED_CTR0;
>  
> -	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
> +	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
>  		u32 index = array_index_nospec(msr - base,
> -					       pmu->nr_arch_fixed_counters);
> +					       KVM_MAX_NR_FIXED_COUNTERS);
> +
> +		if (!kvm_is_fixed_pmc_supported(pmu, index))
> +			return NULL;
>  
>  		return &pmu->fixed_counters[index];
>  	}

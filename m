Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0351218821;
	Tue, 30 Jun 2026 02:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786189; cv=none; b=ii2v9eKoKkk/IqGCNcjv4QDmFa2UvBGkZ5Di05Ks4pZ4Dld7Xn3VsaWUx3w8G2Vmu2dW372XXw45H48T3/+hamVIpObToHag8NnANbjvEuHtd6G9y0MuR+CxEMLduRtZne9Ido/vU6aVHW81EUIJSBimMLtWGqINqg2OFAlZyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786189; c=relaxed/simple;
	bh=yY78cNPDAVHKBpflXgDgjGKK26oj8Tk3C/HzuuLICHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXWbC+nx6DykkBdDSNryUOZb9ts3nfuYyr1WrhMnw3E5SRI+m9L4rjcgu9+xcX5HXka2BIyAGG3A5Tn3FTCvNbdR7DFOKLjXMV4wSbtUCrrEvPO76OfNZnnm5d4mTTpGHVLl4WukUKRyKATftCRizkm3TkFy8TbXx0+4Eag9MLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJSPVm6L; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJSPVm6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782786187; x=1814322187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yY78cNPDAVHKBpflXgDgjGKK26oj8Tk3C/HzuuLICHg=;
  b=TJSPVm6Ljxu5N9WIqh/B3zS+xj0NEgoDuGbQmyYsAGiUTbfsxt513ClY
   ItXU+rtiPVgf2AMAms7cW/2veMPzxI3ITRKpm1KcRT75O8hV1uf3fTTzB
   6yJv98JoQN5jlyQgVHfrcZRUDswbETNV2v/E7cncXJ0cWNTBZN5ogxPW5
   siJwaDEF8UBiuPk8FRuuUqt9/l7wYQhS3ToS+sW5SEIROgWN+L74W93vL
   H6aUYKitiLBGxwqKJQakPb8/uFzjvNEtOsN32CiE63W5TM1UpImgfgSi4
   xF60GNR4tq+RZsSOUzrsQFRL883LCs6WDOBWvwiKAzf9mKBy0iZrH1mom
   g==;
X-CSE-ConnectionGUID: AqewJtypThWkKSWNcjDJlw==
X-CSE-MsgGUID: gzQq4x/tRgyL0+PPEQJmRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83578016"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83578016"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:23:07 -0700
X-CSE-ConnectionGUID: mFiE3fRGQ1ua49rvKCFr2w==
X-CSE-MsgGUID: Vbsvz8noTFWVdFaA4nR0Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="282193568"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:23:04 -0700
Message-ID: <5222a31f-249f-4afe-a76a-4e1309371b6a@linux.intel.com>
Date: Tue, 30 Jun 2026 10:23:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/8] KVM: x86/pmu: Move RDPMC emulation into per-vendor
 callbacks
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260629231938.15129-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/30/2026 7:19 AM, Zide Chen wrote:
> The current RDPMC emulation splits responsibility: rdpmc_ecx_to_pmc()
> in each vendor returns a kvm_pmc, then common code calls
> pmc_read_counter().
>
> This design cannot support RDPMC reads that don't map to a counter,
> such as PERF_METRICS on Intel platforms.
>
> Replace rdpmc_ecx_to_pmc() with emulate_rdpmc(), which takes full
> ownership of the emulation and writes the result directly into @data.
>
> Also drop the redundant bitmask in intel_emulate_rdpmc() since
> pmc_read_counter() already applies the counter's bit-width mask.

Nice cleanup.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v6: new patch.
> ---
>  arch/x86/include/asm/kvm-x86-pmu-ops.h |  2 +-
>  arch/x86/kvm/pmu.c                     |  9 +--------
>  arch/x86/kvm/pmu.h                     |  4 ++--
>  arch/x86/kvm/svm/pmu.c                 | 13 +++++++++----
>  arch/x86/kvm/vmx/pmu_intel.c           | 25 ++++++++++++-------------
>  5 files changed, 25 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index 4a223c2793e3..4b50ed058aed 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -13,7 +13,7 @@
>   * KVM_X86_PMU_OP_OPTIONAL() can be used for those functions that can have
>   * a NULL definition.
>   */
> -KVM_X86_PMU_OP(rdpmc_ecx_to_pmc)
> +KVM_X86_PMU_OP(emulate_rdpmc)
>  KVM_X86_PMU_OP(msr_idx_to_pmc)
>  KVM_X86_PMU_OP_OPTIONAL(check_rdpmc_early)
>  KVM_X86_PMU_OP(is_valid_msr)
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index f82ba63767d0..8ef2d4761790 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -768,8 +768,6 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> -	struct kvm_pmc *pmc;
> -	u64 mask = ~0ull;
>  
>  	if (!pmu->version)
>  		return 1;
> @@ -777,17 +775,12 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  	if (is_vmware_backdoor_pmc(idx))
>  		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
>  
> -	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
> -	if (!pmc)
> -		return 1;
> -
>  	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
>  	    (kvm_x86_call(get_cpl)(vcpu) != 0) &&
>  	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
>  		return 1;
>  
> -	*data = pmc_read_counter(pmc) & mask;
> -	return 0;
> +	return kvm_pmu_call(emulate_rdpmc)(vcpu, idx, data);
>  }
>  
>  static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 3066cade5790..cdbefda844b9 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -24,8 +24,8 @@
>  #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED
>  
>  struct kvm_pmu_ops {
> -	struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
> -		unsigned int idx, u64 *mask);
> +	int (*emulate_rdpmc)(struct kvm_vcpu *vcpu, unsigned int idx,
> +			     u64 *data);
>  	struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
>  	int (*check_rdpmc_early)(struct kvm_vcpu *vcpu, unsigned int idx);
>  	bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index c18286545a7a..0517fd4bbcd7 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -84,10 +84,15 @@ static int amd_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx)
>  }
>  
>  /* idx is the ECX register of RDPMC instruction */
> -static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
> -	unsigned int idx, u64 *mask)
> +static int amd_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx, u64 *data)
>  {
> -	return amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
> +	struct kvm_pmc *pmc = amd_pmu_get_pmc(vcpu_to_pmu(vcpu), idx);
> +
> +	if (!pmc)
> +		return 1;
> +
> +	*data = pmc_read_counter(pmc);
> +	return 0;
>  }
>  
>  static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
> @@ -302,7 +307,7 @@ static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
>  }
>  
>  struct kvm_pmu_ops amd_pmu_ops __initdata = {
> -	.rdpmc_ecx_to_pmc = amd_rdpmc_ecx_to_pmc,
> +	.emulate_rdpmc = amd_emulate_rdpmc,
>  	.msr_idx_to_pmc = amd_msr_idx_to_pmc,
>  	.check_rdpmc_early = amd_check_rdpmc_early,
>  	.is_valid_msr = amd_is_valid_msr,
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 225afd3937c3..080677372c9b 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -84,14 +84,13 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  	}
>  }
>  
> -static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
> -					    unsigned int idx, u64 *mask)
> +static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
> +			       u64 *data)
>  {
>  	unsigned int type = idx & INTEL_RDPMC_TYPE_MASK;
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> -	struct kvm_pmc *counters;
> +	struct kvm_pmc *counters, *pmc;
>  	unsigned int num_counters;
> -	u64 bitmask;
>  
>  	/*
>  	 * The encoding of ECX for RDPMC is different for architectural versus
> @@ -104,7 +103,9 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	 * as KVM doesn't support such PMUs.
>  	 */
>  	if (WARN_ON_ONCE(!pmu->version))
> -		return NULL;
> +		return 1;
> +
> +	idx &= INTEL_RDPMC_INDEX_MASK;
>  
>  	/*
>  	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
> @@ -118,23 +119,21 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>  	case INTEL_RDPMC_FIXED:
>  		counters = pmu->fixed_counters;
>  		num_counters = pmu->nr_arch_fixed_counters;
> -		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
>  		break;
>  	case INTEL_RDPMC_GP:
>  		counters = pmu->gp_counters;
>  		num_counters = pmu->nr_arch_gp_counters;
> -		bitmask = pmu->counter_bitmask[KVM_PMC_GP];
>  		break;
>  	default:
> -		return NULL;
> +		return 1;
>  	}
>  
> -	idx &= INTEL_RDPMC_INDEX_MASK;
>  	if (idx >= num_counters)
> -		return NULL;
> +		return 1;
>  
> -	*mask &= bitmask;
> -	return &counters[array_index_nospec(idx, num_counters)];
> +	pmc = &counters[array_index_nospec(idx, num_counters)];
> +	*data = pmc_read_counter(pmc);
> +	return 0;
>  }
>  
>  static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)
> @@ -865,7 +864,7 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>  }
>  
>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
> -	.rdpmc_ecx_to_pmc = intel_rdpmc_ecx_to_pmc,
> +	.emulate_rdpmc = intel_emulate_rdpmc,
>  	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
>  	.is_valid_msr = intel_is_valid_msr,
>  	.get_msr = intel_pmu_get_msr,

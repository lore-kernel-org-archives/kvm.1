Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEE3D8900;
	Tue,  1 Sep 2026 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228580; cv=none; b=OMkH6zSXwuUv2tP11ubKwTGMkrO3v+781ueKsVMrw1keQGnlusexAJQdYjvBdj+YUTYbsmdB+NF67suuh3GAnoHGFHAmLujRj9PaOhuGV8ydncgdQXxMTG507DRPx1e2hHCq8vFD//CTio+XLyZi6AWaPNF99IiQ3lWPyah7BJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228580; c=relaxed/simple;
	bh=uEjlDUKwfLlsnbQV0/RxiMQ4MPgPDmHcZ6BZjyZhzJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEQPsCbsMX5ZL9Sm+5R+/aDOK7AkFEyleO4FK9iryXtALDv58QoMnRatkuLRqpqq+VUebql/Chcl6ypbiiKs7SUjXniHODe08/eiKDMo/pCD+vGOqel16w3l2Pr00MVaGzQ1yl8dPzUcWsBr90wJakbQdhN1UNjCUglifkNtI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaWeiFH2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaWeiFH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788228572; x=1819764572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uEjlDUKwfLlsnbQV0/RxiMQ4MPgPDmHcZ6BZjyZhzJM=;
  b=SaWeiFH2OQS8hKUOCjqEKiIg6oSahJyplmzZ92QeJeRQP/wTdGJwlTNc
   qU9zXUPJ2bepow0OqDqGgl4c1rfJcJBZJZPkqQRVJoOD5JPQGt4Jo/0TR
   A4ToDw69hL7KrcKGdImrYdiLsFdfMV2hEvKvB2kMrwjII+ULOdOHnKZl6
   6dzXJBepT/1WIwTTv/Jt84+2mzli6tF9X3A5spW++sDu4UkCHaT3AmgvY
   ZY52NvBQmdwimU8GMOyO8hQ6Y3o6hSaS8T7kahcJNa4X0wYcylNiFMaAk
   mElkehDNkxWJQ2o4qpkYjVwKgRiv6xfgSF8jE7thkrVavR/pk0UNOKu/y
   g==;
X-CSE-ConnectionGUID: NL3kW8SERUGeU/nVUAbwZg==
X-CSE-MsgGUID: u/kITdfDTxKQs/CSp+/Rfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88572835"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88572835"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:09:24 -0700
X-CSE-ConnectionGUID: az+XLRC2SY294+2xJ71Hsg==
X-CSE-MsgGUID: OzbCbCzKRuionxJyF9mN+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="307172400"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:09:20 -0700
Message-ID: <8d8b9fa5-9913-4fec-ac5f-159d07e1bd0e@linux.intel.com>
Date: Tue, 1 Sep 2026 10:09:18 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] KVM: x86/pmu: Rename all_valid_pmc_idx to
 pmc_exists
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 8/28/2026 6:37 AM, Zide Chen wrote:
> all_valid_pmc_idx is a bitmap of valid PMC indices, not an index
> itself; rename it to pmc_exists to better reflect what it holds and
> keep the name consistent with other fields in the same struct.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Pick the name pmc_exists other than all_valid_pmc_mask. (Sean)
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/pmu.c              | 10 +++++-----
>  arch/x86/kvm/vmx/pmu_intel.c    |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 283847619ff8..e473796da7d9 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -594,7 +594,7 @@ struct kvm_pmu {
>  		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>  		atomic64_t __reprogram_pmi;
>  	};
> -	DECLARE_BITMAP(all_valid_pmc_idx, X86_PMC_IDX_MAX);
> +	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>  	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
>  
>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a7d60c8785cd..8f2effee3b7b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -950,7 +950,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
>  	bitmap_zero(pmu->reprogram_pmi, X86_PMC_IDX_MAX);
>  	bitmap_zero(pmu->pmc_has_mode_specific_enables, X86_PMC_IDX_MAX);
>  
> -	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx) {
> +	kvm_for_each_pmc(pmu, pmc, i, pmu->pmc_exists) {
>  		pmc_stop_counter(pmc);
>  		pmc->counter = 0;
>  		pmc->emulated_counter = 0;
> @@ -996,7 +996,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
>  	pmu->pebs_enable_rsvd = ~0ull;
>  	pmu->pebs_data_cfg_rsvd = ~0ull;
> -	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
> +	bitmap_zero(pmu->pmc_exists, X86_PMC_IDX_MAX);
>  
>  	if (!vcpu->kvm->arch.enable_pmu)
>  		return;
> @@ -1017,8 +1017,8 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (kvm_vcpu_has_mediated_pmu(vcpu))
>  		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
>  
> -	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
> -	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
> +	bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
> +	bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
>  		   pmu->nr_arch_fixed_counters);
>  }
>  
> @@ -1040,7 +1040,7 @@ void kvm_pmu_cleanup(struct kvm_vcpu *vcpu)
>  
>  	pmu->need_cleanup = false;
>  
> -	bitmap_andnot(bitmask, pmu->all_valid_pmc_idx,
> +	bitmap_andnot(bitmask, pmu->pmc_exists,
>  		      pmu->pmc_in_use, X86_PMC_IDX_MAX);
>  
>  	kvm_for_each_pmc(pmu, pmc, i, bitmask) {
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index e71ddd51ae56..322a3ad580dd 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -557,7 +557,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  		lbr_desc->records.nr = 0;
>  
>  	if (lbr_desc->records.nr)
> -		bitmap_set(pmu->all_valid_pmc_idx, INTEL_PMC_IDX_FIXED_VLBR, 1);
> +		bitmap_set(pmu->pmc_exists, INTEL_PMC_IDX_FIXED_VLBR, 1);
>  
>  	if (pmu->version == 1)
>  		return;

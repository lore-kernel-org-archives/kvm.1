Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963493;
	b=TAhfhJf2GpPSyP4lJBghiLEzYSLbrrqCMM1tiYBqDBGl+GsgxDuXOsVwgzA4UJpGmKvo
	 lnUCA3tJkepTwk86TRmgtpZ1gUAOPX78O5u6r4epC84uRuASfn6tWXHciBcqebZ9SYGb9
	 bI5gfHjYZpu+SNajgLW6DcMBfHrtvmlZsC06tVzeRWUV4K3MI/poAOorJstwBeFAv4UAU
	 2le1j7Obukh+kilzg1jSXJtq782fBkwqTgBlGyHkvs0SV60ROi8yTwuL6QO8TQEdL1nN8
	 yhyGUDYeawBwjHTrn958KIew49h4lGPIgW7uJFZOJeCIwI3Qt/z0ZYbv4i3Rp3eWmcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963493;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wBE8sKj+3HE3UXWmfRe8niL1RmnJmiTat6NFs2C2wPI=;
	b=bROxoBOS+bukgoDisF9Xi/aggS4JYploKOk3D0L9/CDpJy5NdSa7XrFLTWDVuV65+IUY
	 fFlESwGscuroCG4/14ka7xWhYEDAcLzpiA07TCBgdklDlUydD4qPOCk5+Y892ekMQMkf/
	 RZSP9wmRx5vRMKUIopM482ZpttcrfTSuWvN8ghZ/WgWoZYJUap5j3eqmb2G1VFcJearW9
	 pELR8nP0wZLMfoYCb87vbho+IqMTHPLDohpZKVIqDOXddHubj6ALUWFuru0wXJNDYbEDd
	 JzfTYo/BUomnfmYyZzMA6tZswOc/MS0GxqDn8sPsJKkjgUeRjPPZuvk4ZlETcs6HSiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLVvjgRu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D3C606A32A;
	Wed, 18 Nov 2026 00:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dLVvjgRu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBAF1F000C4;
	Wed, 18 Nov 2026 00:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963492;
	bh=wBE8sKj+3HE3UXWmfRe8niL1RmnJmiTat6NFs2C2wPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dLVvjgRue8cIX5NmGgmRjrLscYFKCaQ/UB8YRfTkyJXMZeNNvwVPZ5Rhxd+P76iFX
	 TQCqJFZ9NLD/Zmv9uatyMdPxzJgXdUHEgwy4G92gs+uAFpDavmJIhgsNIq2RJOMhaH
	 wSOqkafRxz4i7ZzbblGHUDxhvbwot15Rzm1ITrjS0R+S5sEChihwoKsxymk5tMmDvp
	 3oPKP9426WOW2mr4/4hL2fTZIhY5OIKC1P465zS0+LfHK/IM7IDM2ArzBrsIuKp/Ns
	 s7ZwUTPLRkEN9gkhWXHb6GP7S4QB1EHNYSwUNWn+k+8HidgjhD1N+4MGXJOQ55xBC+
	 rhN6adqpMUqoQ==
Date: Wed, 18 Nov 2026 00:58:10 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
Message-ID: <avz3U-w-CBtTM0uH@google.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-7-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112203227.289379-7-zide.chen@intel.com>

On Thu, Nov 12, 2026 at 01:32:12PM -0700, Zide Chen wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Populate and use pmc_exists directly when walking guest-visible PMCs,
> instead of relying on pmu->nr_arch_{gp,fixed}_counters as intermediate
> state, in preparation for switching KVM's host PMU capabilities from
> counter counts to counter bitmaps.
> 
> Extend pmu->pmc_exists to a union so that the u64 alias (pmc_exists64)
> is available for mask arithmetic operations. Introduce
> kvm_{gp,fixed}_pmc_mask() to extract the respective counter bitmasks,
> and provide the kvm_for_each_{gp,fixed}_counter() iterator macros to
> replace open-coded counter index loops.
> 
> Consolidate PMU MSR intercept setup in VMX and SVM into single loops.
> In SVM, this also fixes legacy counter interception by re-enabling
> intercepts if a vCPU's counter count is narrowed.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Co-developed-by: Zide Chen <zide.chen@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
[..]
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index fbab4f5c9181..b312f80f5cda 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -88,6 +88,18 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>  }
>  
> +static inline u64 kvm_gp_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return pmu->pmc_exists64 &
> +	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
> +}
> +
> +static inline u64 kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
> +	       GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);

Why do we need to & with the
KVM_MAX_NR_GP_COUNTERS/KVM_MAX_NR_FIXED_COUNTERS mask here? Isn't
pmc_exists64 already clamped?

> +}
> +
>  static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
>  {
>  	return idx < KVM_MAX_NR_GP_COUNTERS &&
[..]
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index fadc466cd600..68d23c7877a2 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -71,14 +71,14 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  
>  	pmu->fixed_ctr_ctrl = data;
>  	pmu->fixed_ctr_ctrl_hw = data;
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> +	kvm_for_each_fixed_counter(i, pmu) {
>  		u8 new_ctrl = fixed_ctrl_field(data, i);
>  		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
>  
>  		if (old_ctrl == new_ctrl)
>  			continue;
>  
> -		pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
> +		pmc = &pmu->fixed_counters[i];

By bypassing the helper we lose the array_index_nospec(), right? Same
applies if we directly access the array elsewhere.

>  
>  		__set_bit(KVM_FIXED_PMC_BASE_IDX + i, pmu->pmc_in_use);
>  		kvm_pmu_request_counter_reprogram(pmc);
[..]
> @@ -497,7 +501,7 @@ static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>  {
>  	int i;
>  
> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
> +	kvm_for_each_fixed_counter(i, pmu)
>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>  }
>  
> @@ -505,11 +509,13 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
> +	int nr_gp_counters, nr_fixed_counters;
>  	struct kvm_cpuid_entry2 *entry;
>  	union cpuid10_eax eax;
>  	union cpuid10_edx edx;
>  	u64 perf_capabilities;
>  	u64 counter_rsvd;
> +	u64 fixed_mask;
>  
>  	if (!lbr_desc)
>  		return;
> @@ -535,8 +541,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (!pmu->version)
>  		return;
>  
> -	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
> -					 kvm_pmu_cap.num_counters_gp);
>  	eax.split.bit_width = min_t(int, eax.split.bit_width,
>  				    kvm_pmu_cap.bit_width_gp);
>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
> @@ -544,6 +548,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				      kvm_pmu_cap.events_mask_len);
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
> +	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> +				  kvm_pmu_cap.num_counters_fixed);
> +	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;

Probably clearer to move these right above where fixed_mask is used.

> +
> +	nr_gp_counters = min_t(int, eax.split.num_counters,
> +			       kvm_pmu_cap.num_counters_gp);
> +	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
> +
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
> @@ -565,8 +577,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (pmu->version == 1)
>  		return;
>  
> -	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> -					    kvm_pmu_cap.num_counters_fixed);
> +	pmu->pmc_exists64 |= fixed_mask << KVM_FIXED_PMC_BASE_IDX;
>  	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
>  					  kvm_pmu_cap.bit_width_fixed);
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
> @@ -575,8 +586,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  						 INTEL_FIXED_0_USER |
>  						 INTEL_FIXED_0_ENABLE_PMI);
>  
> -	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
> -			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
> +	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
> +			 (kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));

Can we use pmc_exists64 here like the AMD code?

>  	pmu->global_ctrl_rsvd = counter_rsvd;
>  
>  	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
> @@ -591,7 +602,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
>  			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
>  		} else {
> -			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
> +			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
>  		}
>  	}
>  }

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993675;
	b=YzgFHnl7GFte25BX9LS1jLpXoiPyVWOsGC+wDNkssd6TtdVE/JSiUZMwPVMNPou+lNxU
	 YzV1a20uP/a1bIWyuQ6WEVhM8JPXTmy7hX4xVXUpxTvvx1+k7M32Sy2BVo1LaBCAo33jp
	 zsHkGESXxeX+8pBPdrrQbDnJArbp41GuEauMsyhb9WYdFdrq5WSQcROBte8pzWUbwlBsu
	 yIVucbznZZlqJE2MapaWdS0aH+0YJC1jUI4HMe0Xy9ipE3Bj1n1w0BLENBEdLgheBti0J
	 18Rgz/YSfNZVDkdswzvAdq01ahnAHYyasf/qBdOc0HxAvDr/11XWY5JNuPzk4m235TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993675;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=88C97N6UH9Uyrq41e1ngidp2rYbzeD72tqfq3U+ZGhg=;
	b=wYy4ZEQG0ZDzBnzQUlbm+7ZS23a7PPGiOzy91Sqe72MhneUItMhKQlhIUrVF8G+0jSSz
	 o7GIe6QlfHAD+a7yX/U9wLAws64ZD+MyEY6ou0PnbJ6QwdAcXmOsWccU+U1nMG9VjG+ij
	 4XWdYx0iDnorSEv3fIOMyRjXJpT7myCJy0gXA8+NwAv/6mYFNp8et3b6E+/183yiHzuBu
	 Txzg7Cw2grTksERacGJKxkTgdx4OyJKwYTvxVtYUFJEup1jSoGJQpn0gSfTPsagAPVpUj
	 OmK0xxMozEfBlPZl64w6Z5We0l0FZ/eVLW8qW+s2sYYG5Fu6+FyUWqXD1O2hpwl+tfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVYMyLm1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD4606A337;
	Fri,  6 Nov 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVYMyLm1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89641F008A4;
	Fri,  6 Nov 2026 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793993674;
	bh=88C97N6UH9Uyrq41e1ngidp2rYbzeD72tqfq3U+ZGhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bVYMyLm1nDv27Q2qjtwhqnzl4hU2tyTPpIn+sRFquHEo6/5vMMdWZsKKjCjhWYYHc
	 TfTVg0v24uLDFhjNjnQmmogI+G8fXKuWqf76T0QEW6RcnJ/eTyHjflEppwmFApBkQq
	 FhwrKE+W/4f2jfp8mGYSm47ULtFcT328UvVYB/0+Blc8+7eYoz5eWUghd73epEyAFO
	 iJF/Nj+eRYLnvmamsx9uZANUrfs/0TSIJtrtFIKiMP7Z2MIA9Su6R5kHKQoXn7SPiZ
	 2IGve5m0VEfd9wAvfkh4uhBnZPtNNV+P3eO+l2fIVPUI+zDi0vSrI6+hDdLz9IvY+6
	 OneYkL/ql9WXw==
Date: Fri, 6 Nov 2026 19:34:32 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 05/18] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
Message-ID: <au4pSeg5AcHEbfDv@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-6-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-6-zide.chen@intel.com>

> @@ -979,8 +979,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	kvm_pmu_reset(vcpu);
>  
>  	pmu->version = 0;
> -	pmu->nr_arch_gp_counters = 0;
> -	pmu->nr_arch_fixed_counters = 0;
>  	pmu->counter_bitmask[KVM_PMC_GP] = 0;
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
>  	/*
> @@ -1008,16 +1006,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
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

I understand the vendor modules are responsible of initializing this
now, but should we clear it before calling into the vendors like other
fields above?

>  }
>  
>  void kvm_pmu_init(struct kvm_vcpu *vcpu)
> @@ -1328,6 +1322,8 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
>  static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);

All these should go away if we pass the pmu into the iterators.

>  	struct kvm_pmc *pmc;
>  	u32 i;
>  
> @@ -1336,14 +1332,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
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
[..]
> @@ -117,7 +116,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  		return pmu->version > 1;
>  	default:
>  		if (msr > MSR_F15H_PERF_CTR5 &&
> -		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
> +		    msr < MSR_F15H_PERF_CTL0 + 2 * hweight_long(kvm_gp_pmc_mask(pmu)))

This assumes the MSRs are contiguous, which IIUC is always true, but I
wonder if it should also be handled since the series claims to also
prepare for discontiguous GP counters.

>  			return pmu->version > 1;
>  		break;
>  	}
[..]
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

num_counters is no longer an accurate name, is it? Maybe max_counter
(and use KVM_MAX_* - 1) or max_nr_counters?

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
> @@ -495,9 +500,10 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
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
> @@ -509,6 +515,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	union cpuid10_eax eax;
>  	union cpuid10_edx edx;
>  	u64 perf_capabilities;
> +	u64 fixed_mask;
> +	int nr_gp_counters;
>  	u64 counter_rsvd;
>  
>  	if (!lbr_desc)
> @@ -535,8 +543,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (!pmu->version)
>  		return;
>  
> -	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
> -					 kvm_pmu_cap.num_counters_gp);
>  	eax.split.bit_width = min_t(int, eax.split.bit_width,
>  				    kvm_pmu_cap.bit_width_gp);
>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
> @@ -544,6 +550,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				      kvm_pmu_cap.events_mask_len);
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
> +	fixed_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
> +	fixed_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;

Why not do min() like the old code?

> +
> +	/*
> +	 * The number of counters comes from guest CPUID data. Clamp the value
> +	 * to avoid a shift-by-64 in BIT_ULL().
> +	 */
> +	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
> +	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> +			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);

Why not just do min(eax.split.num_counters, kvm_pmu_cap.num_counters_gp)
directly like it used to be?

> +
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
> @@ -565,8 +582,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (pmu->version == 1)
>  		return;
>  
> -	pmu->nr_arch_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> -					    kvm_pmu_cap.num_counters_fixed);
> +	pmu->pmc_exists64 |= fixed_mask << INTEL_PMC_IDX_FIXED;
>  	edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
>  					  kvm_pmu_cap.bit_width_fixed);
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
> @@ -575,8 +591,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  						 INTEL_FIXED_0_USER |
>  						 INTEL_FIXED_0_ENABLE_PMI);
>  
> -	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
> -			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
> +	counter_rsvd = ~((u64)kvm_gp_pmc_mask(pmu) |
> +			 ((u64)kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
>  	pmu->global_ctrl_rsvd = counter_rsvd;
>  
>  	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
> @@ -591,7 +607,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
>  			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
>  		} else {
> -			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
> +			pmu->pebs_enable_rsvd = ~(u64)kvm_gp_pmc_mask(pmu);
>  		}
>  	}
>  }

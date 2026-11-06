Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995543;
	b=SuT/MlsGQQRPVDW2SEI7qtrIrLHrU2mskqxScPNAkiz3zwK/gGUW9WRiSy0Mxd69JceF
	 ut+Euv5LjvmBYkLIDRaqjPVYJjraxwCfqQQq8UzgMgDK8tfITIgabQf6CLz72409eftjc
	 ESyxpkLMpzcpRX7MZcum3LJhJfC/YDsWGsPw4ZLvJfHzv3PXSTNb+IKc1/VTibayiIAU1
	 dGOfWtGKYfwyOV8mIBAe7ciFtkWed84r9QBHlxRbSkh9epZyuHoDPdmdf7aducsFk+BqJ
	 0WqhYVyeMAr+QYCziCe6uejQF/xTON2XVIuhnBHoVndb+B5dOd2X/JdpkYApezTAK7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995543;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DXxoL98QCRNwCGckBEQzGBg1h5hzKBx69crOcdi0dRc=;
	b=2QFFcLSu0Mw5dUDkKvyJKtNCu7XbSSR6w9yAWbhBKC9LCDoIOWywJpWBe96eEkW1Za3W
	 Bg1HYxDsBbJ2wQEP/GhkjkGeIP/96jCjjI1fZcs+SekJ2FyMVgpdFlrn0c+uZDBDflp4u
	 NLUD6j3C3REfSTZP3TafwOsGQm/nkl8uhZ5eDD8YGp3GnVnGtB71bdq6NfrMxe/Q9nSiH
	 vwitFv+g9JoEkCuBduNeFGAWmC6j5M9Zwmjnxb3VZvcWQ4juj3MoaFjHmkAOTM5W7Mw0O
	 iQh1zC67ghx8Il4xxP1jnBoKRcZKfC6wGxC6hPnQ7pxjCsZdY9w29DCGm4O/9zI2vNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIMkbi4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D317606A326;
	Fri,  6 Nov 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIMkbi4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7A21F0089F;
	Fri,  6 Nov 2026 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793995542;
	bh=DXxoL98QCRNwCGckBEQzGBg1h5hzKBx69crOcdi0dRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIMkbi4yc77dZ6oyyyPoG+Zy5y38RYADLo4bGPk4FmcqYE/eAizYw+WYqm45y7uy0
	 Vin0wiJmkrRLxFF5JzfMbjdA8bU36SpjZKhBwKkgShkJzSugE3h85YqEl5/NcPuxtr
	 qD1/hR9Ay6IuEyuAstjId43SFlGvPpWsbq2rV71J/TxL6txzc+j4ya8StW8STxGbIa
	 86A23OT1SiCOmBfd+lnBuiuA6iexwSRFnlo0Qz6P/PSEsCYMdP3vFHkP+JXZOW3cTr
	 WBy69WyF35UMJ2Yw2Ycj4kJ0xPKqiH0lPtYA3Iizir35KxQniyxo8+DBBf7Xofuq9V
	 qbSFslGHCOahg==
Date: Fri, 6 Nov 2026 20:05:40 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 08/18] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
Message-ID: <au4wUM4fwB47Yss9@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-9-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-9-zide.chen@intel.com>

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index adafd6fa2c54..3310c370c5fa 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1535,10 +1535,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
> @@ -1903,7 +1911,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>  
> -		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
> +		ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);

Should this be the number of contiguous counters?

>  		entry->ebx = ebx.full;
>  		break;
>  	}
[..]  
> @@ -516,7 +517,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	union cpuid10_edx edx;
>  	u64 perf_capabilities;
>  	u64 fixed_mask;
> -	int nr_gp_counters;
> +	int nr_gp_counters, nr_fixed_counters;
>  	u64 counter_rsvd;
>  
>  	if (!lbr_desc)
> @@ -550,16 +551,25 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				      kvm_pmu_cap.events_mask_len);
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
> -	fixed_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
> -	fixed_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
> +	/*
> +	 * CPUID.0AH:EDX[4:0] can only enumerate contiguous counters. Clamp the
> +	 * value to the number of contiguous fixed counters supported by KVM.
> +	 */
> +	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> +				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
> +						      KVM_MAX_NR_FIXED_COUNTERS));
> +
> +	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
> +	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;

Isn't nr_fixed_counters already clamped to the number of contiguous bits
in fixed_cntr_mask?

>  
>  	/*
> -	 * The number of counters comes from guest CPUID data. Clamp the value
> -	 * to avoid a shift-by-64 in BIT_ULL().
> +	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
> +	 * value to the number of contiguous GP counters supported by KVM.
>  	 */
> -	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
> -	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
> -			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> +	nr_gp_counters = min_t(int, eax.split.num_counters,
> +			       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
> +						   KVM_MAX_NR_GP_COUNTERS));
> +	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
>  
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);

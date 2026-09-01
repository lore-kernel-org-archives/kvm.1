Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF953321DE;
	Tue,  1 Sep 2026 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245863; cv=none; b=tVOL6L8BDMwAhYZwIzA5Qcu+6uzPjfSsHtX3PfuEMwlOeuxhJ+vA+UTmQ5kks/PMfd8Bu5jDw5oDBbujzx4AFkG1F9/heU09zwKD4vjsGXd0wHhNEeHD1DyvuOAO8nhEfSEicP5dOfUlVXMaWY2h7jxHNx4jSpiFD1HMdsnLPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245863; c=relaxed/simple;
	bh=WuEehMtA+IxOr6i6fMyrgbqu1/2+jUZ4vb3wTYi47a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQjG1I+/ubTNWZWpoOxz7ll8oubhPerYFVRBMoMxoxmWPSsnqm85WX+nCecetwi8AbFU2gjcbGm5+2YbWBduhDgbjJ4ri2jg0JZKaSSaoIs2VA7ILLiDp+gy0Vfh1/N/GI5PxZC/g32E8G38BBjWqNXPLfZZF9gjE5d80Bs3WEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1U6OCrD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1U6OCrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245861; x=1819781861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WuEehMtA+IxOr6i6fMyrgbqu1/2+jUZ4vb3wTYi47a0=;
  b=W1U6OCrDYXETIskDwl1H3g8Dids+WYbf9bXxcW/kiy4uQDpyHP4ojflZ
   8jXoSmljdA01izX0yLaBVmMGwmIlyRn3Qa5rNRxii+YvTd7EMXysUravC
   ORYFrUI4UjXMZ6X5O4qjVFSamz7FfWWvao8KFV/3mMvRIxnjs9tKkSfmD
   qWdEumDuOsJdgB3XAUfM0RmSF+kqBVevIQG0I7x0hlpuyxycDfggkopu1
   Mvs9SP5Lj6KVv0sHg6DA4TDRzEYSTdNH/wFvimJ3Jbhm1FiGsjvOt0DeH
   yErq5PDYcWbc4Y+LKMUaLx3bkQVLE4Bx56legIINz4t+kh9TQBkN/Dz/T
   Q==;
X-CSE-ConnectionGUID: K6zbf8Z9Svmddakxi9f94A==
X-CSE-MsgGUID: TvuKCzdmRGiLddiDfBHnrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92478635"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92478635"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:57:41 -0700
X-CSE-ConnectionGUID: yz/vJrMBQGCnikgHJg6cFw==
X-CSE-MsgGUID: xKD0Q0N2TC6Z5ccIo5lu/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="298899397"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:57:36 -0700
Message-ID: <1bc5d41b-103f-46ba-bcb6-bac930014030@linux.intel.com>
Date: Tue, 1 Sep 2026 14:57:35 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] KVM: x86/pmu: Factor out fixed counter control
 bit calculation
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-14-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-14-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 8/28/2026 6:37 AM, Zide Chen wrote:
> Rename intel_pmu_enable_fixed_counter_bits() to
> intel_pmu_fixed_ctrl_bits() and have it return the computed fixed
> counter control mask instead of updating fixed_ctr_ctrl_rsvd directly.
>
> Accumulate the desired fixed counter control bits during PMU setup and
> apply them once in intel_pmu_refresh().
>
> Move the helper next to intel_pmu_set_msr() so it can also be reused
> there, which will be needed for upcoming ANYTHREAD_DEPRECATION
> emulation.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2: New patch
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 1ce69e764ae1..c7472778137a 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -421,6 +421,18 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	return 0;
>  }
>  
> +static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
> +{
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	u64 fixed_ctrl_bits = 0;
> +	int i;
> +
> +	kvm_for_each_fixed_counter(i, fixed_mask)
> +		fixed_ctrl_bits |= intel_fixed_bits_by_idx(i, bits);
> +
> +	return fixed_ctrl_bits;
> +}
> +
>  static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -533,20 +545,12 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  	return eventsel;
>  }
>  
> -static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
> -{
> -	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> -	int i;
> -
> -	kvm_for_each_fixed_counter(i, fixed_mask)
> -		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
> -}
> -
>  static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  	struct lbr_desc *lbr_desc = vcpu_to_lbr_desc(vcpu);
>  	struct kvm_cpuid_entry2 *entry;
> +	u64 fixed_enable_bits = 0;
>  	union cpuid10_eax eax;
>  	union cpuid10_edx edx;
>  	u64 perf_capabilities;
> @@ -625,9 +629,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  					  kvm_pmu_cap.bit_width_fixed);
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
>  
> -	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
> -						 INTEL_FIXED_0_USER |
> -						 INTEL_FIXED_0_ENABLE_PMI);
> +	fixed_enable_bits |= INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |
> +			     INTEL_FIXED_0_ENABLE_PMI;
>  
>  	counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
>  			((u64)kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
> @@ -651,11 +654,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			pmu->pebs_enable_rsvd = counter_rsvd;
>  			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
> -			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
> +			fixed_enable_bits |= ICL_FIXED_0_ADAPTIVE;
>  		} else {
>  			pmu->pebs_enable_rsvd = ~kvm_gp_pmc_mask(pmu);
>  		}
>  	}
> +
> +	pmu->fixed_ctr_ctrl_rsvd &=
> +		~intel_pmu_fixed_ctrl_bits(pmu, fixed_enable_bits);
>  }
>  
>  static void intel_pmu_init(struct kvm_vcpu *vcpu)

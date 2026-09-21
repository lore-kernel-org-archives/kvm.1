Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CE136654F;
	Mon, 21 Sep 2026 07:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974704; cv=none; b=chK0Rub3YmND+mgu6ZTtE4TwpTzhr3sZI/GuchZ4Tr6wB4i098mvpuw/K1PdiJyp4paX7iXR8+k2l9KSQzv4gRnMiziNAf370PXcFbKqbBR4bh8xZEGErB5igG/f2QTh4XiY8L0UpgiPMZpuHrJFBmkEAwLjRyRhDjdWQNBPazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974704; c=relaxed/simple;
	bh=VyQSGci/9bb0imSr+5Vhc7IR6K+G0J63dbLAu3h5GMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=re7YGJ1TWImYtt/QV7XHymxvFNqwNg7GVhywlxQ8Dv4/fvmP+fRJXN1zydazRhm2pjFew6imonwQImTE3+u/i/gd3zGlIG7EiQ7g/57dsFHehd3aXHtnmFe9kZtMBi+PnkhF4PrOjuWO0ai/V/ydiYJ66JzZKEQWLJlhMmfjvOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OZOfyX96; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OZOfyX96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789974703; x=1821510703;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VyQSGci/9bb0imSr+5Vhc7IR6K+G0J63dbLAu3h5GMk=;
  b=OZOfyX96824hJxPKfDf3WRbAcEJ42xrrTyk+gP16USayURKytpF7hAyM
   sBYsWtBRfCl7mF1W26W5zSIkyP68DLwRQ9iWcQ3ZDASF2HWT7nfTMfQZv
   BV3SiDNR8vP4J8ftDnacCD9W6vmksDu1IvabTY1cDJ9QGaGypTy1DHUXM
   fSIJ4kahwcN76/9YLo4357FtiSKCy/7SisSPo1mnvlFQgI2Q5vmPBE6At
   5LhAk7WVX1BvwhUPVdtuEdzkZW/qzfbfzApJVF/yvc8DMJ8dZA9ACZWsE
   WXiuwnHZPHPu38tOWqN9euvYPieQY5EDLo2imrNLhwx13JmkxchlJdPi5
   Q==;
X-CSE-ConnectionGUID: NymyirpQTd+UWX3LfP+etQ==
X-CSE-MsgGUID: wfrg9uKzTHKdniEXdCywzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="107972521"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="107972521"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 00:11:42 -0700
X-CSE-ConnectionGUID: /z1N45STROOpJKHhwtA3Eg==
X-CSE-MsgGUID: wgh6xs7YTtuJSb5MVDPGww==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 00:11:38 -0700
Message-ID: <63f95d2c-2aaa-480f-b8cb-62196f1c00de@linux.intel.com>
Date: Mon, 21 Sep 2026 15:11:32 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/12] KVM: x86/pmu: Reject writes to reserved
 MSR_PERF_METRICS bits
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-12-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260918193937.569414-12-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 9/19/2026 3:39 AM, Zide Chen wrote:
> When the host CPU supports only 4 Topdown metrics, bits [63:32] of
> MSR_PERF_METRICS are reserved.
>
> Derive pmu->perf_metrics_rsvd from the number of supported Topdown
> metrics and use it to validate writes. Reject any attempts to set
> reserved bits in MSR_PERF_METRICS.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v9: new patch.
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/pmu.c              |  1 +
>  arch/x86/kvm/vmx/pmu_intel.c    | 18 +++++++++++++++++-
>  3 files changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 052bf377dedb..31454ecee371 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -585,6 +585,7 @@ struct kvm_pmu {
>  	u64 reserved_bits;
>  	u64 raw_event_mask;
>  	u64 perf_metrics;
> +	u64 perf_metrics_rsvd;
>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>  
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 0df283a169b6..41f2d31c495f 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -1006,6 +1006,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->fixed_ctr_ctrl_rsvd = ~0ull;
>  	pmu->pebs_enable_rsvd = ~0ull;
>  	pmu->pebs_data_cfg_rsvd = ~0ull;
> +	pmu->perf_metrics_rsvd = ~0ull;
>  	bitmap_zero(pmu->all_valid_pmc_idx, X86_PMC_IDX_MAX);
>  
>  	if (!vcpu->kvm->arch.enable_pmu)
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index fab0891ad46a..98e2fb80347a 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -417,6 +417,9 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
>  	case MSR_PERF_METRICS:
> +		if (data & pmu->perf_metrics_rsvd)
> +			return 1;
> +
>  		pmu->perf_metrics = data;
>  		break;
>  	case MSR_IA32_PEBS_ENABLE:
> @@ -601,9 +604,22 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>  	pmu->global_ctrl_rsvd = counter_rsvd;
> -	if (perf_capabilities & PERF_CAP_PERF_METRICS)
> +	if (perf_capabilities & PERF_CAP_PERF_METRICS) {
>  		pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
>  
> +		/*
> +		 * PERF_METRICS has one 8-bit field per metric. At 8 metrics,
> +		 * skip computing the mask and set perf_metrics_rsvd to 0
> +		 * directly, since BIT_ULL(64) is undefined.
> +		 */
> +		if (kvm_pmu_cap.num_topdown_events < INTEL_TD_METRIC_NUM)
> +			pmu->perf_metrics_rsvd =
> +				~(BIT_ULL(kvm_pmu_cap.num_topdown_events *
> +					  INTEL_TD_METRIC_FIELD_BITS) - 1);
> +		else
> +			pmu->perf_metrics_rsvd = 0;
> +	}
> +
>  	/*
>  	 * GLOBAL_STATUS and GLOBAL_OVF_CONTROL (a.k.a. GLOBAL_STATUS_RESET)
>  	 * share reserved bit definitions.  The kernel just happens to use

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515B35E1CC;
	Tue,  1 Sep 2026 06:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245114; cv=none; b=PLyZYi3hBcwOHyoV2iaoIF9YljOLYKL3ZH8m/ICCk9KfbfHa/2sV7iKL6Mi1I/zQUbAUNBtUbJ2L723EzJiVJwr4Lz87cJ7KheTCDNn7qU6ITI2EX+kI+QuP9dAcDVIpeZWRIAIPAMmPpAPiAtIZJw5bhXFDsF9iLCxlLBkf4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245114; c=relaxed/simple;
	bh=P81lfRJgve7IF4yAqJ0ph9Ai8OPu6/aIs701ZVqMu40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JqIJuy4op8w8NqAHtuOUTp/i7WolUX9H5aN43/bOONBE8AQeGMC3akkw212vmpBFm9nTxyldyB1wQ06hipx1jrkGzkmEPvo6D42W+2H/2uv4VIebj5wXMwGTESlF7xnLA52tMh/Tu2wrACwva3GIMUWKznzoLi3sFWXVoaIwigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZN/dc2c2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZN/dc2c2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245112; x=1819781112;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P81lfRJgve7IF4yAqJ0ph9Ai8OPu6/aIs701ZVqMu40=;
  b=ZN/dc2c2e7fgRgFjaggEVGyWyoO3woBOJvbeanD5ivw22rP21c0fidkZ
   AMZpdIfdVX4H22C0U29UDqpmF4hdRuqkJ4LHkAviyc64I0pHGLD3k6ez/
   6kb0J5l9ju3JMznQ/sX1c7q8V1BkFjRxttj6b8sb5HfLXxWJLRNtg7Mbs
   sajxjICVLvn+MksZdfs5iPy4f10aCcea0k6jnlqREDsEZhCIXmusGJ/t+
   tCdVqj5CSpaC8tuvkd5M1PHDNkYw7HtNaAx8Cdj7s3O1Ns6YQoi5W2X6R
   6NZPSdm6NntR1kCdnq24KQkwlwI4pQ/NThhYQtc7FuqA2atTTd9mLRb+l
   Q==;
X-CSE-ConnectionGUID: pG8fEfZQRdqtac+xaPVFtw==
X-CSE-MsgGUID: VtJWZbsORU+YHkWhe9EqUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92477290"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92477290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:45:12 -0700
X-CSE-ConnectionGUID: TyNIs2cDRTm7Wxo34Jv5bg==
X-CSE-MsgGUID: Ckx6FEG7Q6KBjUyotlEs5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272793891"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:45:09 -0700
Message-ID: <d2285a85-e5b5-4fd5-8f2f-68f2dee5763d@linux.intel.com>
Date: Tue, 1 Sep 2026 14:45:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-12-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/28/2026 6:37 AM, Zide Chen wrote:
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
> allow software to set individual bits in the global status MSR. Reads
> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
>
> IA32_PERF_GLOBAL_INUSE (0x392) is also introduced in v4, to track
> which counters and the PMI are currently claimed by other agents,
> allowing independent software agents to check counter availability
> without a shared scheduler arbitrating between them.
>
> IA32_PERF_GLOBAL_INUSE is an read-only MSR, and any write attempt
> results in a #GP.
>
> Neither MSR is part of the VM state, so they don't need to be
> advertised to userspace, nor saved and restored during live
> migration.
>
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Change intel_pmu_get_global_inuse() to return u64, to match the
>   surrounding code style.
> - Add the missing vmcs02 updates for these two MSRs.
> - Change "> 3" to ">= 4" to make the "v4-gated" more obvious and match
>   the existing code style.
> ---
>  arch/x86/include/asm/msr-index.h |  4 ++++
>  arch/x86/kvm/pmu.c               |  9 ++++++++
>  arch/x86/kvm/vmx/nested.c        |  2 ++
>  arch/x86/kvm/vmx/pmu_intel.c     | 37 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c           |  4 ++++
>  5 files changed, 56 insertions(+)
>
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 11b99d237e05..0b093cf41edf 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1240,6 +1240,10 @@
>  #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
>  #define MSR_CORE_PERF_GLOBAL_STATUS_SET	0x00000391
> +#define MSR_CORE_PERF_GLOBAL_INUSE	0x00000392
> +
> +/* Intel IA32_PERF_GLOBAL_INUSE MSR */
> +#define PERF_GLOBAL_INUSE_PMI_INUSE	BIT_ULL(63)
>  
>  #define MSR_PERF_METRICS		0x00000329
>  
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 437a7bc49bf8..7c05cf5157bf 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -832,6 +832,8 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	case MSR_CORE_PERF_GLOBAL_CTRL:
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		return vcpu_to_pmu(vcpu)->version >= 4;
>  	default:
>  		break;
>  	}
> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>  		msr_info->data = 0;
>  		break;
>  	default:
> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (!msr_info->host_initiated)
>  			pmu->global_status &= ~data;
>  		break;
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		if (data & pmu->global_status_rsvd)
> +			return 1;
> +		if (!msr_info->host_initiated)
> +			pmu->global_status |= data;
> +		break;
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  		if (!msr_info->host_initiated)
>  			pmu->global_status |= data & ~pmu->global_status_rsvd;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0cff369982ae..ae7dd3636e70 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -719,6 +719,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
>  	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
>  	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
>  	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
> +	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_STATUS_SET);
> +	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_INUSE);
>  }
>  
>  /*
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 4df55a3e21da..3070fba2687f 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -194,6 +194,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
> +	case MSR_CORE_PERF_GLOBAL_INUSE:
> +		return pmu->version >= 4;
>  	case MSR_IA32_PEBS_ENABLE:
>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>  		break;
> @@ -341,6 +343,38 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> +	bool pmi_inuse = false;
> +	u64 eventsel, data = 0;
> +	u32 fixed_ctrl;
> +	int i;
> +
> +	kvm_for_each_gp_counter(i, gp_mask) {
> +		eventsel = pmu->gp_counters[i].eventsel;
> +
> +		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)

Why to check ARCH_PERFMON_EVENTSEL_EVENT instead of
ARCH_PERFMON_EVENTSEL_ENABLE here? Suppose only
ARCH_PERFMON_EVENTSEL_ENABLE is set, then the counter is in use.

Thanks.


> +			data |= BIT_ULL(i);
> +		pmi_inuse |= eventsel & ARCH_PERFMON_EVENTSEL_INT;
> +	}
> +	kvm_for_each_fixed_counter(i, fixed_mask) {
> +		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
> +
> +		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
> +			data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
> +		pmi_inuse |= fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
> +	}
> +	pmi_inuse |= pmu->pebs_enable;
> +
> +	if (pmi_inuse)
> +		data |= PERF_GLOBAL_INUSE_PMI_INUSE;
> +
> +	return data;
> +}
> +
>  static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -351,6 +385,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data = pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_CORE_PERF_GLOBAL_INUSE:
> +		msr_info->data = intel_pmu_get_global_inuse(vcpu);
> +		break;
>  	case MSR_IA32_PEBS_ENABLE:
>  		msr_info->data = pmu->pebs_enable;
>  		break;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 56daf5c61082..2dabb7e64956 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4282,6 +4282,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>  				  MSR_TYPE_RW, intercept);
>  	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>  				  MSR_TYPE_RW, intercept);
> +	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS_SET,
> +				  MSR_TYPE_RW, intercept || pmu->version < 4);
> +	vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_INUSE,
> +				  MSR_TYPE_RW, intercept || pmu->version < 4);
>  }
>  
>  static void vmx_recalc_msr_intercepts(struct kvm_vcpu *vcpu)

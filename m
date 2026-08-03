Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4763AA4E4;
	Mon,  3 Aug 2026 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789449; cv=none; b=HExv8Pp7FTbj1noD/X9FhCiHrECs07ooDKqaIGiIGWHz709B63lVqXF//YUqhNDZD1WvsXGN2rM0Nj3VtJltXmlFhevYzw5oYx9+boYxz4i/1UvRZ32nFmuSqyg61IeGQJJgJ3T3pYJenqKam3rEYxfY590/CIbDIoGZEEjqVOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789449; c=relaxed/simple;
	bh=T2xeUIw/QjmeT0MG9ktXCkfmTgrNiOSpO2tTxiB/I0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEPQ9nWixz6X3ZDZYearQCnHZyfoxaIaWDfct8KBhItdHT2dz+3LWyvhiocHP2Ufjyrgl42tD4uamin+AW9J2IfaSXPu83kYb9X9bvsOuBMs+ubAf76lELruXkBgLOssoZ6Ei/CaTA0DrZVF/m88j3DNaFbwdsogQe2lHug/xmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/Eu0aXF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/Eu0aXF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785789447; x=1817325447;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T2xeUIw/QjmeT0MG9ktXCkfmTgrNiOSpO2tTxiB/I0g=;
  b=H/Eu0aXFw71wUiNnsTStAISxMSQ/6pYAkgn0ePK/iKAf0njrb9mLUGGv
   xij+bSEobk6e0h6fK1fxqu79tuL7eKR+iAnw20hxv+I15oG2Hx/UCuKkk
   pCqd0O9yhDriKlpcSycB9gJxBaPpJMiPYOR4Feam6dwzVVuOaeKLf1B7Z
   wOGU269R4msMP0iUvxo5s3SdyIc608xn50JktYKMoUMJGjnWyOAhdgj8I
   K42uUz+RV83fV5lDKfkhxJQanzO4xgf6sGBHBR/vz6tyMu0gAbb+mPW7g
   52j9PBw93gQJ5Kzb6Kp+qfOZ6aj+87MtoAf0ZUaA6igtRORAhg+8Tl4SB
   A==;
X-CSE-ConnectionGUID: f5szpYUcQHqo+14vJMj7mw==
X-CSE-MsgGUID: jPrNOePkTpupGfLT/1HjHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73871980"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="73871980"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:37:27 -0700
X-CSE-ConnectionGUID: ZPvjF6IrRyysRwxwTqceDg==
X-CSE-MsgGUID: E7orxtYyS0mlIacbXNZk2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="257428259"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:37:26 -0700
Message-ID: <da5eb9da-cac3-4304-a948-10ecaaab7524@intel.com>
Date: Mon, 3 Aug 2026 15:37:25 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Yang Weijiang <weijiang.yang@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-11-zide.chen@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260707183405.15571-11-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/2026 1:34 PM, Zide Chen wrote:
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
> allow software to set individual bits in the global status MSR. Reads
> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
> 
> IA32_PERF_GLOBAL_INUSE (0x392) is also introduced in v4, to track
> which counters and the PMI are currently claimed by other agents,
> allowing independent software agents to check counter availability
> without a shared scheduler arbitrating between them.
> 
> IA32_PERF_GLOBAL_INUSE is an R/O MSR, and any write attempt results
> in a #GP.
> 
> Neither MSR is part of the VM state, so they don't need to be
> advertised to userspace, nor saved and restored during live
> migration.
> 
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h |  4 ++++
>  arch/x86/kvm/pmu.c               |  9 ++++++++
>  arch/x86/kvm/vmx/pmu_intel.c     | 38 ++++++++++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.c           |  4 ++++
>  4 files changed, 55 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index feee92aab504..46ca6b56628b 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -1241,6 +1241,10 @@
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
> index bc2ca60114e9..7d58f7a2a2db 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -834,6 +834,8 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	case MSR_CORE_PERF_GLOBAL_CTRL:
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
> +		return vcpu_to_pmu(vcpu)->version > 3;
>  	default:
>  		break;
>  	}
> @@ -867,6 +869,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>  		msr_info->data = 0;
>  		break;
>  	default:
> @@ -933,6 +936,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 425f17aa9be2..cb6f9c272e03 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -205,6 +205,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
> +	case MSR_CORE_PERF_GLOBAL_INUSE:
> +		return pmu->version > 3;
>  	case MSR_PERF_METRICS:
>  		return kvm_vcpu_has_perf_metrics(vcpu);
>  	case MSR_IA32_PEBS_ENABLE:
> @@ -354,6 +356,40 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>  	return true;
>  }
>  
> +static int intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu,
> +				      struct msr_data *msr_info)

Since intel_pmu_get_global_inuse() cannot realistically fail, returning
an int solely to propagate 0 is unnecessary. Change it to return the
emulated GLOBAL_INUSE value directly and remove the now-unused msr_info
parameter.

> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> +	bool pmi_inuse = false;
> +	u32 fixed_ctrl;
> +	u64 eventsel;
> +	int i;
> +
> +	msr_info->data = 0;
> +	kvm_for_each_set_pmc_idx(i, gp_mask, INTEL_GP) {
> +		eventsel = pmu->gp_counters[i].eventsel;
> +
> +		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
> +			msr_info->data |= BIT_ULL(i);
> +		pmi_inuse |= eventsel & ARCH_PERFMON_EVENTSEL_INT;
> +	}
> +	kvm_for_each_set_pmc_idx(i, fixed_mask, INTEL_FIXED) {
> +		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
> +
> +		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
> +			msr_info->data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
> +		pmi_inuse |= fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
> +	}
> +	pmi_inuse |= pmu->pebs_enable;
> +
> +	if (pmi_inuse)
> +		msr_info->data |= PERF_GLOBAL_INUSE_PMI_INUSE;
> +
> +	return 0;
> +}
> +
>  static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -364,6 +400,8 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		msr_info->data = pmu->fixed_ctr_ctrl;
>  		break;
> +	case MSR_CORE_PERF_GLOBAL_INUSE:
> +		return intel_pmu_get_global_inuse(vcpu, msr_info);

Additional benefit is to keep code style consistency:

               msr_info->data = intel_pmu_get_global_inuse(vcpu);
               break;

>  	case MSR_PERF_METRICS:
>  		msr_info->data = pmu->perf_metrics;
>  		break;

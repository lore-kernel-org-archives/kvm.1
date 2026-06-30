Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB1248F64;
	Tue, 30 Jun 2026 02:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786213; cv=none; b=D+3ziOcwhhmFelABsYiOVYSAh1+yG39rurLGTsMermlc0SW+IVcEz+Vek1WsbWo83JgD1Rdrw2fDntMJG4rAEnqnmGRVT1EbPLj1gDhQC+RIJTqrTyzmwI/tsLBvUAnpto5VesHINzHEWvSIX+CAoqjr45cl4ku9GatVapa/y2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786213; c=relaxed/simple;
	bh=fxAMzJz/AX2Ub5K5tWSy7JbCkcADEsyHZGxdhP6+KyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jH1anc8XYKnDSM81yR0IFNLAE7/tL9iscYtHxpYgr8CDsKnFcp7LBPxhtJO4FZqDK/3MaMvqWJFYiJT3LRefgCOy5DMWswugmA/94Sgw5JGl054UxrFoYQHiwDJmL9VGtCj+4DAYhSTeslz6Z4bALk4R41Cih1/AAaAs7XBZx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSG8Iez3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSG8Iez3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782786212; x=1814322212;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fxAMzJz/AX2Ub5K5tWSy7JbCkcADEsyHZGxdhP6+KyA=;
  b=mSG8Iez3cqEnQfibVdbYOSw2Ax5smoD5rgzxMmko7jcVqaTHmcurAr3/
   bBxgnXPEgboI1IbH43hnmvRHVxVGvZvNtsrwFaCHmBorwbRzvd4PEOMga
   o5n+MO9HEWlJnGLeyOd+d14fZsqGnPWANtpUj94oc3kPEU6z7m35DHiPH
   PUF7uq37No/LnQddLKnm83Xn8yFRbR3lQpidglXMTeMH5YWjf70evqHHa
   s0pYnZ6FplrtEgHTU6eYMlbUGuEvQPToShE0G0erRz6jj6IOgHydFhEVx
   nefMcOd695dzDwQmPiLDFdNVxssgzGi1QwtU1O4JS4++5Y9wLrEgV+xgS
   Q==;
X-CSE-ConnectionGUID: r5d1FcBmSbax/VCa7Tpy0g==
X-CSE-MsgGUID: r9QEkc0CTW+I4tvwSqhBhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94091096"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94091096"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:23:32 -0700
X-CSE-ConnectionGUID: DJVaWLCpT8i4pMUAo1nv3g==
X-CSE-MsgGUID: YfgxEhF1QkeF10euEZXQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="249489339"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:23:29 -0700
Message-ID: <7cce9e44-3cc6-4265-8e83-0a49f1e7c2f5@linux.intel.com>
Date: Tue, 30 Jun 2026 10:23:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260629231938.15129-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 6/30/2026 7:19 AM, Zide Chen wrote:
> If the host has the PERF_METRICS capability but it's not present on
> the guest, RDPMC interception must be enabled and KVM should inject
> an #GP when the guest attempts a PERF_METRICS RDPMC.
>
> If the guest has PERF_METRICS but RDPMC interception is enabled for
> other reasons, KVM needs to emulate RDPMC with type 2000H.
>
> For simplicity, Metrics Clear Mode is not supported.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v6:
> - Merge kvm_pmu_rdpmc_metrics() into intel_emulate_rdpmc().
> - Reject non-zero index.
> v5:
> - new patch.
> ---
>  arch/x86/kvm/pmu.c           |  7 +++++++
>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 8ef2d4761790..04b9c840f218 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -806,6 +806,12 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>  
> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> +{
> +	return (kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS) &&
> +		!kvm_vcpu_has_perf_metrics(vcpu);
> +}
> +
>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -818,6 +824,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  		return true;
>  
>  	return kvm_need_any_pmc_intercept(vcpu) ||
> +	       kvm_need_perf_metrics_intercept(vcpu) ||
>  	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>  	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
>  }
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 080677372c9b..93b5a8360377 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -30,6 +30,7 @@
>   */
>  #define INTEL_RDPMC_GP		0
>  #define INTEL_RDPMC_FIXED	INTEL_PMC_FIXED_RDPMC_BASE
> +#define INTEL_RDPMC_METRICS	INTEL_PMC_FIXED_RDPMC_METRICS
>  
>  #define INTEL_RDPMC_TYPE_MASK	GENMASK(31, 16)
>  #define INTEL_RDPMC_INDEX_MASK	GENMASK(15, 0)
> @@ -124,6 +125,19 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
>  		counters = pmu->gp_counters;
>  		num_counters = pmu->nr_arch_gp_counters;
>  		break;
> +	case INTEL_RDPMC_METRICS:
> +		if (!kvm_vcpu_has_perf_metrics(vcpu))
> +			return 1;
> +
> +		/*
> +		 * The index in ECX[15:0] is implementation specific, but no
> +		 * platform currently supports a non-zero index.
> +		 */
> +		if (idx)
> +			return 1;
> +
> +		*data = pmu->perf_metrics;
> +		return 0;
>  	default:
>  		return 1;
>  	}

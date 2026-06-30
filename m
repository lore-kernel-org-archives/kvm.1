Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9841A683E;
	Tue, 30 Jun 2026 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785982; cv=none; b=XV8dyR5kbgG66Eqikd1/b4F+I8m/yL8iSOP9XBaqugBGb1S0Ui5OocBsaZs8m7ZKd6awJAXiwFzKIYDIDe8w/Yawb6B+WfvSFENY1UX+N1IlElwppzpG51vsKjD0STybIJ9qUUCsV88M4u2k/FddNz6cvzgQfBVTwRwznMl8Dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785982; c=relaxed/simple;
	bh=RSH7Dr64TGEbOcmzNlDoQUKYnRgoPQaj1YC7/imSH6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wfa1194LtpfVD4U8kbdNRPlacklMafGzxgXql34DSaIe29Q14Zom8y6hctQJQVCpDc48TTZEEa9I/SCp0VykPbBgvKoflozSXaNbiqkUFoH90bPZXH/V5WXDF17Df1MGSgUHR8SZIoDLZ0xwAyWx0A1WyzIeKkLOMBvs3pOYTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmniCIUt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmniCIUt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782785982; x=1814321982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RSH7Dr64TGEbOcmzNlDoQUKYnRgoPQaj1YC7/imSH6o=;
  b=gmniCIUtDxxo8GK4uhoAO0QopmqmqXCFFl6DiatcFrcl6aC4ZCj8CjUS
   Iqk9bjrj9f1k7n4l2A0eN+mEpFX+5bXJ5+poDqyOsLC7tRtP/8JtL+F+l
   hrdq9xQPYINzMptSP7QE3WmXMn4DcOv4ecqqrGNFoMSR30DUlESdSLCQj
   GX+0naPm/faI/e39huD58lVUQwfpQZRtPKRXNe5kmbgQ65RAoXZJQaVoD
   qooXtyj/C1PFKlpWSqF9shOIxBmwzqm3s+Y+YBYPW58yrH7krrLywCKu5
   6jhY+BDUx64IegQetqO1exk9Tf3i9sjyhQveVurvUGM1vm9Zm8nZlXvH+
   Q==;
X-CSE-ConnectionGUID: D4xb5iguQaCQAxn5nwYt6g==
X-CSE-MsgGUID: Abb6JQ7RS4m3wMC0+OlugQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="109041666"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="109041666"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:19:41 -0700
X-CSE-ConnectionGUID: CNLRlBhYQvqRoRBx4Ns/QA==
X-CSE-MsgGUID: EP8+mqRDTsq10S4j6dtRng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="247671485"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:18:29 -0700
Message-ID: <d983fecd-f8be-44c1-8564-2a47474067d3@linux.intel.com>
Date: Tue, 30 Jun 2026 10:18:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] KVM: x86/pmu: Rename and move
 vcpu_get_perf_capabilities() to pmu.h
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260629231938.15129-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 6/30/2026 7:19 AM, Zide Chen wrote:
> This is in preparation for it to be called from common x86 code, for
> example kvm_need_rdpmc_intercept(), to check the guest's PERF_METRICS
> capability.
>
> Rename it to kvm_vcpu_get_perf_caps() to indicate that it's part of
> the common API, and shorten _capabilities to _caps.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v5: new patch.
> ---
>  arch/x86/kvm/pmu.h           |  8 ++++++++
>  arch/x86/kvm/vmx/pmu_intel.c |  6 +++---
>  arch/x86/kvm/vmx/pmu_intel.h | 10 +---------
>  3 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index a5821d7c87f9..1b2f66a2e915 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -271,6 +271,14 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
>  				  X86_PMC_IDX_MAX);
>  }
>  
> +static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
> +{
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> +		return 0;
> +
> +	return vcpu->arch.perf_capabilities;
> +}
> +
>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
>  int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index f15af497d27f..e426ddc8add4 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -189,13 +189,13 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>  		return kvm_pmu_has_perf_global_ctrl(pmu);
>  	case MSR_IA32_PEBS_ENABLE:
> -		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
> +		ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
>  		break;
>  	case MSR_IA32_DS_AREA:
>  		ret = guest_cpu_cap_has(vcpu, X86_FEATURE_DS);
>  		break;
>  	case MSR_PEBS_DATA_CFG:
> -		perf_capabilities = vcpu_get_perf_capabilities(vcpu);
> +		perf_capabilities = kvm_vcpu_get_perf_caps(vcpu);
>  		ret = (perf_capabilities & PERF_CAP_PEBS_BASELINE) &&
>  			((perf_capabilities & PERF_CAP_PEBS_FORMAT) > 3);
>  		break;
> @@ -550,7 +550,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
>  	}
>  
> -	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
> +	perf_capabilities = kvm_vcpu_get_perf_caps(vcpu);
>  	if (intel_pmu_lbr_is_compatible(vcpu) &&
>  	    (perf_capabilities & PERF_CAP_LBR_FMT))
>  		memcpy(&lbr_desc->records, &vmx_lbr_caps, sizeof(vmx_lbr_caps));
> diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
> index 5d9357640aa1..afdbbc9991d6 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.h
> +++ b/arch/x86/kvm/vmx/pmu_intel.h
> @@ -6,17 +6,9 @@
>  
>  #include "cpuid.h"
>  
> -static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
> -{
> -	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
> -		return 0;
> -
> -	return vcpu->arch.perf_capabilities;
> -}
> -
>  static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
>  {
> -	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
> +	return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_FW_WRITES) != 0;
>  }
>  
>  bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);

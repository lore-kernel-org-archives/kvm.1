Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410482641CA;
	Thu, 25 Jun 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379031; cv=none; b=i1U7HFTInUQJOpJNV7Sf06XNC9fa9O90Nzo0qLyA39iPO/j6kqBpcqujGjbDINr0/wB6F3gl+poXl9cbrH5hy89QMs4HziGsRjHewrJU20N4s+WyRe1iwWIMAR1DzaMOXkwLzyOSCY/+FtSmNRlvdLeiqLgqyIrOXlV7ktjJ2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379031; c=relaxed/simple;
	bh=65S+UBt8/Or0XRgZXTqU3zE1M55lWi8MYko6T7vnCp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfiDlN7kE58CpRNvffeUDKNR/iOReUs60el5g7R53cqg/ko356YD8OZXiJLwFP0JR3dDZtu85zA5Bu5op234vPNTXSqSrpgzRrIIGK7pgrirHDKNORtvW0y+KXf/QgZ54Pq7jGHmCOuTFkKMgbkpKybzedJWy/f90EMci0bnufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=chp81na8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="chp81na8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782379029; x=1813915029;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=65S+UBt8/Or0XRgZXTqU3zE1M55lWi8MYko6T7vnCp4=;
  b=chp81na8EpEFhPTy+xMz3r+ptA0kIccKyQ0wEn5tbRulc1KMrnXj/jLG
   VAHEXKrsEjlA+uenqE25affLY5yXt/V8816aKkZ+46rNqpCj8IvevaTNn
   Kn2N5Q/PTV4JXiXp3zzsYMnhA7s0p9SZadksDufQqi4e5FcrTuTfIXxOT
   L753bfcUhmlP3BconomJ/7fgJWlgKsfhVk/+D+cM/8NWpmI/WOt5SBTTE
   XpyGt6Z5j3dy4Wu3bp5NupCwUbIox75DAw+d+AbUXpmg2zne8GkaB6tJI
   etcbclGDfFvlJJskj6+BPZ/MMnvWspdqeyqHEQLavZml9Sub5lwjiGxGP
   Q==;
X-CSE-ConnectionGUID: jK+VTFLySHCz+7MxVsjSDw==
X-CSE-MsgGUID: mwErf7NNQYKVGN83FugWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94547828"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94547828"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 02:17:09 -0700
X-CSE-ConnectionGUID: BzW2fr5bTD2bfvnj7Rt16Q==
X-CSE-MsgGUID: raq87Nw3SLOBJ+W5VsPn2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246131298"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 02:17:06 -0700
Message-ID: <e3058805-9215-48dc-ad37-ec530a6c8212@linux.intel.com>
Date: Thu, 25 Jun 2026 17:17:03 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/7] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
 <20260625034555.141453-7-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260625034555.141453-7-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/25/2026 11:45 AM, Zide Chen wrote:
> If the host has the PERF_METRICS capability but it's not present on
> the guest, RDPMC interception must be enabled and KVM should inject
> an #GP when the guest attempts to read it.
>
> If the guest has PERF_METRICS, but RDPMC interception is enabled for
> other reasons, KVM needs to emulate RDPMC with type 2000H.
>
> For simplicity, Metrics Clear Mode is not supported.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v5: new patch.
> ---
>  arch/x86/kvm/pmu.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 7aafc5db1346..af5b14f44e4b 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -755,6 +755,16 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  	return 0;
>  }
>  
> +static int kvm_pmu_rdpmc_metrics(struct kvm_vcpu *vcpu,
> +				 unsigned idx, u64 *data)
> +{
> +	if (!kvm_vcpu_has_perf_metrics(vcpu))
> +		return 1;
> +
> +	*data = vcpu_to_pmu(vcpu)->perf_metrics;
> +	return 0;
> +}
> +
>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -767,15 +777,18 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>  	if (is_vmware_backdoor_pmc(idx))
>  		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
>  
> -	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
> -	if (!pmc)
> -		return 1;
> -
>  	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
>  	    (kvm_x86_call(get_cpl)(vcpu) != 0) &&
>  	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
>  		return 1;
>  
> +	if (idx & INTEL_PMC_FIXED_RDPMC_METRICS)

I'm not quite sure if this check is good enough. Although the SDM vol.2
says "Performance metrics use type 2000H. This type can be used only if
IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[bit 15]=1. For this type, the
index in ECX[15:0] is implementation specific." It doesn't say the PMC
index must be 0, but we always set the PMC index to 0 when reading topdown
metrics.

Could you please test to run the rdpmc instruction to read topdown metrics
with valid and invalid PMC index on real HW and look what would happen? Thanks.


> +		return kvm_pmu_rdpmc_metrics(vcpu, idx, data);
> +
> +	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
> +	if (!pmc)
> +		return 1;
> +
>  	*data = pmc_read_counter(pmc) & mask;
>  	return 0;
>  }
> @@ -803,6 +816,14 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>  
> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
> +{
> +	if (!(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS))
> +		return false;
> +
> +	return !kvm_vcpu_has_perf_metrics(vcpu);
> +}
> +
>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -815,6 +836,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>  		return true;
>  
>  	return kvm_need_any_pmc_intercept(vcpu) ||
> +	       kvm_need_perf_metrics_intercept(vcpu) ||
>  	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>  	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
>  }

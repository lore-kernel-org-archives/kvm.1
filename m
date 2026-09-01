Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0FB47141D;
	Tue,  1 Sep 2026 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249686; cv=none; b=Jpg+bO6lUv1rhKA9IYVMaHcJIHjlEUIhCdC23SfFzPxcDfIuOTPFx1dU4+G2XYfDqqn8PFFMs+yTHH8M2+Yd6jHjaRHNP+p+D6J4Yjqrca6jW3eSifNsnXGH0RFJUOtWRHmspkjYy0GSN02x/1sbsKfnjCOuGSUOSJ47WIljn2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249686; c=relaxed/simple;
	bh=tuVbGajlreknBFVL7UGn9g2l7D9HvA/787rtr9Q5rL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=crePANi7TUybUzAO850LqQD8/4VNTLhp7puNu27qTBiYysG42aAt6CfSIK5lr8KM2sbX4V5RgutV+5pMFcwyKFmuGL0SPlwh4kEJESpHAC3Hl0CfR3YluTsSood78avZSMFOYhpOwiRChFreQ8gf20Dc76ebkNjlwk/Bf0N7NzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSCXyaDB; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSCXyaDB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788249681; x=1819785681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tuVbGajlreknBFVL7UGn9g2l7D9HvA/787rtr9Q5rL0=;
  b=SSCXyaDBSJLEFGv37rX/kmLWcAVXDkyrk9So92KZ5jhBeNkzVkMOcGv5
   gmiMZJSoP1efcd1SiijsgvG5oBUb9KVTDh6QjJllEKEtT5viV7pP6DUFm
   i+pFBveQhbnMUEEqBC/UMsU5gfWvXcp/diBq78DCqRW9LZ7TkxXA29Qqr
   x4yNfoiPwcFaxkbMldAPqSB0VGX24mMoak2TwrCkgC0PAdwPM4S+6TV0B
   JYS0Zy18nbo6SKJTWwg25yLXzSU5ckbZspBSxQCPctbpPHcuQmzl6voW2
   7VWANH7XW2tPOit1kVdpX99I01EnjLXkJfwP1HpQNsLOQ2qsEPjg9ju1F
   w==;
X-CSE-ConnectionGUID: g6wOMeGWQ+elNiqZQTCuvg==
X-CSE-MsgGUID: 2gclyMgIQt+F8+iqpMbQ0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="99004738"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="99004738"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:01:18 -0700
X-CSE-ConnectionGUID: 4nmwm1jBQwqqUMX06brDtw==
X-CSE-MsgGUID: lkbGMcl4RueLpSZS83oPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265777298"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:01:14 -0700
Message-ID: <89e1cb41-81b6-4f20-9fc2-d436dd77d988@linux.intel.com>
Date: Tue, 1 Sep 2026 16:01:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] KVM: x86/pmu: Ignore AnyThread bit if
 CPUID.0AH:EDX[15] is set
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-15-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-15-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 8/28/2026 6:37 AM, Zide Chen wrote:
> Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
> (CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
> and that writes to the AnyThread bit in IA32_PERFEVTSELx are ignored.
>
> When ANYTHREAD_DEPRECATION is present in the guest CPUID, emulate the
> architectural behavior and silently ignore writes to the AnyThread bit
> instead of injecting #GP.
>
> Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
> guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
> not configured for a PerfMon v5+ guest.
>
> Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
> bit doesn't exist below version 5.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Advertise anythread_deprecated only if kvm_pmu_cap.version >= 5.
> - Add the missing AnyThr bit handling for IA32_FIXED_CTR_CTRL.
> - Update the comments to be clearer.
> ---
>  arch/x86/kvm/cpuid.c         |  2 +-
>  arch/x86/kvm/vmx/pmu_intel.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 63201d4ea4a1..ef208906b3ee 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1542,7 +1542,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  					    KVM_MAX_NR_FIXED_COUNTERS);
>  		edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
>  
> -		if (kvm_pmu_cap.version)
> +		if (kvm_pmu_cap.version >= 5)
>  			edx.split.anythread_deprecated = 1;
>  
>  		entry->eax = eax.full;
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index c7472778137a..599c69dfa6e3 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -446,6 +446,12 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (data & pmu->fixed_ctr_ctrl_rsvd)
>  			return 1;
>  
> +		/*
> +		 * This is to emulate ANYTHREAD_DEPRECATION. Guests without
> +		 * support for it would have had the write rejected by
> +		 * pmu->fixed_ctr_ctrl_rsvd above.
> +		 */
> +		data &= ~intel_pmu_fixed_ctrl_bits(pmu, INTEL_FIXED_0_ANYTHREAD);
>  		if (pmu->fixed_ctr_ctrl != data)
>  			reprogram_fixed_counters(pmu, data);
>  		break;
> @@ -494,6 +500,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			if (data & eventsel_rsvd)
>  				return 1;
>  
> +			/* See above comments for MSR_CORE_PERF_FIXED_CTR_CTRL. */
> +			data &= ~ARCH_PERFMON_EVENTSEL_ANY;
>  			if (data != pmc->eventsel) {
>  				pmc->eventsel = data;
>  				pmc->eventsel_hw = data;
> @@ -603,6 +611,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
>  			    kvm_pmu_cap.cntr_mask64;
>  
> +	/*
> +	 * AnyThread counting is not supported by KVM due to cross-VM
> +	 * information leakage concerns on SMT cores. Therefore, AnyThread
> +	 * remains unavailable for PerfMon v3/v4 guests, where AnyThread
> +	 * deprecation is not enumerated.
> +	 */
> +	if (pmu->version >= 5 && edx.split.anythread_deprecated) {
> +		pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
> +		fixed_enable_bits |= INTEL_FIXED_0_ANYTHREAD;
> +	}
> +
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&

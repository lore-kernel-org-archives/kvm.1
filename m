Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508CE370AEB
	for <kvm@vger.kernel.org>; Fri, 28 Aug 2026 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787948540; cv=none; b=NjhbpNkiXwCBLQkVyWyiGm1gFKPSYT+YhaiaafInPRO5HKcH9Me6mSJFLZ84z0V/26+tOg/M1H9+qb9yiIUABejcidcFatTc/V5IbFnmslunkyJxacLfDI77ekpWCcoPgOLgb1FF2O8sksndZBvVGlcCECiVsEs6dIZhWHs/49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787948540; c=relaxed/simple;
	bh=+STKQwumvZwRHD0R+KPdZUSZl0+nlRs8ym/kTUCDp84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfdZsE/XL25mPVnS7+IBF1CLmTOEpEXCC8k1ESEmnzNit227SEIq4t+dACNTsZD2sz8ungFZ1InhNYbQKKHfxBPPSj672syBOspZyVI6haAye4BOXdQW4kaWonpvq7ql9MSQLjF7gHt5tOfTUuvscxh1xQDM9sTKRvCeMvdiT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qch2syLV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qch2syLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787948538; x=1819484538;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+STKQwumvZwRHD0R+KPdZUSZl0+nlRs8ym/kTUCDp84=;
  b=Qch2syLVO3oUEYZwm+Je9zIEWPOu5WXsU9U8UexD6P4sFZw4w6N74Qq9
   a+bW/bfL0XzWCxey8fIV53IKg1UUxqgALPzTuZ4kNzSUAE0oS84oeYNri
   zTK6uQpuT5XNiidqs8Fsm35hnxWQqYq+CHZ1yP6e+9N33gIBIfTLazNp1
   RwXngpHcfetI2Y4ecdGkf3jkcCYNBu23hvRpwhm6+qbJKnMS+y9d0PEeM
   tRuCQot7cJNkDCX8P11+qrX1YTWW77vNAARkCMv5i079aykYWqKpBaSmA
   i5AyQB4SOcJKM1p8j5kfMxlSI+4nMpjlQT/6BcTOBXz2lDFXynb5wCOCi
   A==;
X-CSE-ConnectionGUID: O9+8X3C3QRGDhpHBEA+XlQ==
X-CSE-MsgGUID: sgHX/PA8T1KDfEBNIy1hSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="87594845"
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="87594845"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 13:22:17 -0700
X-CSE-ConnectionGUID: ZP1ULuRcS/iwejxusn9ULA==
X-CSE-MsgGUID: p1k/nzROSE6y+2Y0AF2jYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,249,1779174000"; 
   d="scan'208";a="272464134"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 13:22:17 -0700
Message-ID: <18d181c1-ccfc-42c7-950a-6104714c20c0@intel.com>
Date: Fri, 28 Aug 2026 15:22:16 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <20260827230531.9652B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260827230531.9652B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/2026 6:05 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Incorrect IN_USE bit calculation for fixed counters in IA32_PERF_GLOBAL_INUSE omits the INTEL_FIXED_0_ENABLE_PMI condition.
> - [Medium] Emulated writes to MSR_CORE_PERF_GLOBAL_STATUS_SET fail to trigger a PMI when the corresponding global_ctrl bit is set.
> --
> 
> commit a29f967a55c3b6e45cb682091b4b9a33c0b976dc
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and GLOBAL_INUSE MSRs
> 
> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) and
> IA32_PERF_GLOBAL_INUSE (0x392). This patch adds emulation for both MSRs
> in KVM, but there appear to be a few issues with the implementation.
> 
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 437a7bc49bf84..7c05cf5157bfc 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
> [ ... ]
>> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status &= ~data;
>>  		break;
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +		if (data & pmu->global_status_rsvd)
>> +			return 1;
>> +		if (!msr_info->host_initiated)
>> +			pmu->global_status |= data;
>> +		break;
> 
> [Severity: Medium]
> Will emulated guest writes to MSR_CORE_PERF_GLOBAL_STATUS_SET fail to trigger
> a PMI when the corresponding global_ctrl bit is set?
> 
> This handler correctly updates the global status, but it appears to omit the
> required secondary side-effect of generating a performance monitoring interrupt.
> 
> If a guest writes a 1 to a bit in MSR_CORE_PERF_GLOBAL_STATUS_SET while the
> corresponding bit in IA32_PERF_GLOBAL_CTRL is enabled, it seems the interrupt
> will silently fail to generate because the code doesn't check global_ctrl or
> set KVM_REQ_PMI.

According to the Intel SDM, IA32_PERF_GLOBAL_STATUS_SET only sets the
corresponding bits in IA32_PERF_GLOBAL_STATUS, but not generate a PMI.

Generating a PMI / KVM_REQ_PMI on writes to this MSR would deviate from
hardware behavior and cause spurious PMIs in the guest, e.g., during
live migration state restoration, or during KVM pmu context switch.

> 
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status |= data & ~pmu->global_status_rsvd;
> [ ... ]
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 4df55a3e21da9..3070fba2687f4 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> [ ... ]
>> @@ -341,6 +343,38 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>>  	return true;
>>  }
>>  
>> +static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>> +	bool pmi_inuse = false;
>> +	u64 eventsel, data = 0;
>> +	u32 fixed_ctrl;
>> +	int i;
>> +
>> +	kvm_for_each_gp_counter(i, gp_mask) {
>> +		eventsel = pmu->gp_counters[i].eventsel;
>> +
>> +		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
>> +			data |= BIT_ULL(i);
>> +		pmi_inuse |= eventsel & ARCH_PERFMON_EVENTSEL_INT;
>> +	}
>> +	kvm_for_each_fixed_counter(i, fixed_mask) {
>> +		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
>> +
>> +		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
>> +			data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
> 
> [Severity: Medium]
> Does this code improperly omit INTEL_FIXED_0_ENABLE_PMI when calculating the
> IN_USE bit for fixed counters?
> 
> If a fixed counter is configured only for PMI (without OS or User bits), this
> code seems to falsely report it as unused, which violates the Intel SDM
> specification for FCn_InUse. 
> 
> Should INTEL_FIXED_0_ENABLE_PMI be included in this condition to ensure the
> availability check remains accurate?

False positive. The implementation strictly follows the SDM:

IA32_PERF_GLOBAL_INUSE.FC0_InUse[bit 32]: This bit reflects the logical
state of (IA32_FIXED_CTR_CTRL[1:0] != 0).

Also I verified that the behavior is same between the host and the guest
in this regard.

Note that in practice, reading this MSR on the host may be inconsistent.
The Linux perf driver clear the EN bit but not the whole EvtSel MSRs
after a perf event finishes, so the corresponding bits in INUSE may
remain set. In contrast, kvm_pmu_put_guest_pmcs() explicitly clears
these MSRs, which means the in-use bits will be cleared on physical CPUs
running a vCPU.



> 
>> +		pmi_inuse |= fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
>> +	}
>> +	pmi_inuse |= pmu->pebs_enable;
>> +
>> +	if (pmi_inuse)
>> +		data |= PERF_GLOBAL_INUSE_PMI_INUSE;
>> +
>> +	return data;
>> +}
> 


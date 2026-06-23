Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2603B47D6
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 21:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251300; cv=none; b=Ixqa3La/D7hQumBnLrQNMGE8OuA4uhXgdYHe89w+Dydxzy6f9BsY/BqvjkBaE/wxJmd0Sky5phYsYadcio8hyYlERCfeJ0QErd0u7WcKkPHmWprGXeDbsxVFcNmGUE/xtvhmjIDNZfhqinQwJrj5hWzqU/dgQF4HOgsbOOgv6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251300; c=relaxed/simple;
	bh=XDRjselLyGTrO7IW9GHyhzHDGef+XvTdob8AZ4D5Meo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTMTZvAdT0MCBCbz0nq9JxngSNHjuBz3hwZBcF4tGXaCpfFWx+scKINESL5uVRlSgbMoG/c1eVjdT3UeIYCN0URH9z6Io2JidXhp+5LwMahNP1DuO/OSncck+OOCxXDVdz/S6k6P2TXN2aqXeXbaKf6gtZlSZfDHuENoro9oSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnS070IQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnS070IQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782251297; x=1813787297;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XDRjselLyGTrO7IW9GHyhzHDGef+XvTdob8AZ4D5Meo=;
  b=LnS070IQlgQ9LXE7XYtI/ezEPIDlp9vkjAU6FevCufqV3JsguzXyWvUu
   x+Znxzduq4RUv/90xD8PwJPd5xmYF6JwojWHwuA6bN5zSYU1cFHPkOqMy
   ssvQkkxWMWgON9Z62RVLodC27uYJiTR8ykaoXqEw5wc9UgbBwM+DDkaHj
   K/6gLiROtnmTuZ3bf47pJVini+sAXYTHEMqpjWb7S2OJjHGeYm50it5sx
   xrhOp1jKQky+SXay0fkqz68iE9yNtmYcOHTKqSj6dKScOKVwi1zCvV7pG
   e1XMezeWP1XQy2qlm5jjd75ZxOE4eGQxCjeXuuQXGtSjqut0mV2iUF4AU
   w==;
X-CSE-ConnectionGUID: BCI67Ab6SXahqVe+uQms7w==
X-CSE-MsgGUID: o0tU7ze+TcalFwTvDEpbaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82889550"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="82889550"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 14:48:16 -0700
X-CSE-ConnectionGUID: vllrBncYQlWnkqD146Ah9g==
X-CSE-MsgGUID: l3IOzUBqRkKQoH7p1EYQUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="247292224"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 14:48:15 -0700
Message-ID: <bcbc4f64-60e9-46a8-bf63-19e7d9d30595@intel.com>
Date: Tue, 23 Jun 2026 16:48:15 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260623041927.178256-1-zide.chen@intel.com>
 <20260623041927.178256-4-zide.chen@intel.com>
 <20260623044826.592FF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260623044826.592FF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/22/2026 11:48 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Emulation of guest RDMSR and WRMSR for MSR_PERF_METRICS unconditionally injects a #GP fault, breaking emulation and nested virtualization.
> - [High] KVM_SET_MSRS for MSR_PERF_METRICS is silently discarded, breaking live migration of TMA metrics.
> - [High] Host Topdown microarchitectural metrics are leaked to the guest via the RDPMC instruction when mediated PMU is enabled but the guest lacks the PERF_METRICS capability.
> --
> 
> commit 3d014d661f0ac59ad10f0335ced10697e72d7bf6
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Subject: KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
> 
> This commit exposes the IA32_PERF_METRICS MSR to the guest when mediated vPMU
> is enabled. It handles the MSR in kvm_pmu_{get,set}_msr() for host accesses
> and saves/restores the value on PMU context switches to avoid clobbering host
> data or leaking guest state.
> 
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 59b7a90c79e12..2c3367f5e2dfb 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> [ ... ]
>> @@ -345,6 +347,11 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		msr_info->data = pmu->fixed_ctr_ctrl;
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		if (!msr_info->host_initiated)
>> +			return 1;
> 
> [Severity: High]
> If KVM needs to emulate a guest RDMSR instruction targeting MSR_PERF_METRICS,
> won't this unconditional return inject a #GP fault into the guest?

I can't think of a case that KVM needs to emulate RDMSR/WRMSR on
MSR_PERF_METRICS.
>> +		msr_info->data = pmu->perf_metrics;
>> +		break;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		msr_info->data = pmu->pebs_enable;
>>  		break;
>> @@ -394,6 +401,16 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (pmu->fixed_ctr_ctrl != data)
>>  			reprogram_fixed_counters(pmu, data);
>>  		break;
>> +	case MSR_PERF_METRICS:
>> +		if (!msr_info->host_initiated)
>> +			return 1;
> 
> [Severity: High]
> Similarly, if KVM emulates a guest WRMSR instruction targeting
> MSR_PERF_METRICS, does returning 1 here cause the emulator to incorrectly
> inject a #GP fault?

Ditto.
>> +
>> +		/*
>> +		 * If TMA level 2 is not supported, bits [63:32] are reserved
>> +		 * and ignored on write, so no validation is needed here.
>> +		 */
>> +		pmu->perf_metrics = data;
> 
> [Severity: High]
> When restoring guest state during live migration, userspace calls KVM_SET_MSRS
> which is wrapped in vcpu_load() and vcpu_put(). Since intel_pmu_set_msr()
> updates pmu->perf_metrics without updating the hardware MSR, won't the
> subsequent intel_mediated_pmu_put() during vcpu_put() read the stale hardware
> MSR and overwrite this newly restored value?

No, this won't happen.
>> +		break;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		if (data & pmu->pebs_enable_rsvd)
>>  			return 1;
> [ ... ]
>> @@ -803,6 +828,13 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>  	u64 global_status, toggle;
>>  
>> +	/*
>> +	 * PERF_METRICS MSR must be restored closely after fixed counter 3,
>> +	 * which was just restored by kvm_pmu_load_guest_pmcs().
>> +	 */
>> +	if (vcpu_has_perf_metrics(vcpu))
>> +		wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
>> +
> 
> [Severity: High]
> If the guest is configured without PERF_CAP_PERF_METRICS but with mediated
> PMU enabled, RDPMC exiting might be disabled. Since
> intel_mediated_pmu_load() skips writing to MSR_PERF_METRICS in this case,
> could the guest execute RDPMC and read the un-scrubbed host metrics, leaking
> host microarchitectural state?

You are right. RDPMC exiting needs to be disabled in this case.
>>  	rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>>  	toggle = pmu->global_status ^ global_status;
>>  	if (global_status & toggle)
>> @@ -831,6 +863,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>>  	 */
>>  	if (pmu->fixed_ctr_ctrl_hw)
>>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>> +
>> +	if (vcpu_has_perf_metrics(vcpu)) {
>> +		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
>> +		if (pmu->perf_metrics)
>> +			wrmsrq(MSR_PERF_METRICS, 0);
>> +	}
>>  }
> 


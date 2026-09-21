Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4846EF72
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983569; cv=none; b=X+NaJQN4nJUierLBhHDLitELNwjoEYNqlAFDABxPXoWCysnvLxBOMZuIve84mZtXQCcjt+tFwK9rRA2rVEKuvYW0768c/OxsKGfn/W3i4Y335vLm+dch2Y8Wjyqm2QAJzAqLXC9yhVeL5oexrCXvfYhcVgO2EehxMfnirwQWENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983569; c=relaxed/simple;
	bh=5qs67O9O4X0BC+o/8CNVHrVTiAbkAXPQSAKyMHXk4Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kDh8KsIW1x1DJ94WNdLVzep7svnxODj7gT5PKa803YmZUP9AHTQNjxoDznBhc6a5fUBLZ+6YitqURqg4wuxAiA5r/s1oLycX4m9WMAi1FjzxYV8/P5jqb1anquqoJOxCRM66PpGuO7HWjJ4nwN3IYdTwaMul/M7M1yncyJHIUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFQODTDF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFQODTDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789983566; x=1821519566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5qs67O9O4X0BC+o/8CNVHrVTiAbkAXPQSAKyMHXk4Sg=;
  b=PFQODTDFW48uUne7zRj9dnVhoqlTMA1kBJzRdop/Jq4itSVmSqUZ86J7
   /+V+FZ4YoiJh4Ph5I48CDwaUnym9bQXZBq9S2RRuLA51DsZH1+Urzy2+N
   ajKJtgbCNRG3HiGZOHTSiI3h2CBooidsGi5AZAXxY5ic/VoqufMMyDgsF
   9cAoMC7KYVA5h3xHvyE9x6Y7zrDAs5Zvp6tLCdb1zCgTZyKSmagXXYuG1
   CV0gC3gCfvDF2De3t0nPxWq2ZhFWiCZW7w+Td6JSnud/3XypTdUcnIAun
   9Dk6i+FzwKRihuwe2Qqofy5edFoAVWaxfPkfO+UkFKX/ci3sk52zfq2mo
   Q==;
X-CSE-ConnectionGUID: WHmyr/HnTKWZWv/cAwjpsA==
X-CSE-MsgGUID: DFYhnac8SjWHppeBk83qkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90503094"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90503094"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:39:25 -0700
X-CSE-ConnectionGUID: rvfaqZ8qThmHrmOCZH9wyQ==
X-CSE-MsgGUID: QJh34q2oToy6mCUA98boZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="271114303"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 02:39:24 -0700
Message-ID: <1de5af16-06a5-4b97-ba92-0a4ac02c32ff@linux.intel.com>
Date: Mon, 21 Sep 2026 17:39:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/12] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
To: sashiko-reviews@lists.linux.dev, Zide Chen <zide.chen@intel.com>
Cc: kvm@vger.kernel.org
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-13-zide.chen@intel.com>
 <20260918202200.F39971F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260918202200.F39971F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/19/2026 4:22 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] pmu: event filter mistakenly strips METRICS_CLEAR_EN from fixed_ctr_ctrl_hw
> - [Medium] pmu: METRICS_CLEAR_EN unmasked without validating fixed counter bounds
> - [Low] pmu: emulation incorrectly ties PERF_METRICS clearing to SLOTS PMC existence
> --
>
> commit 8ba3725c32dbde4a1c3935cb433e898e06425b83
> Author: Zide Chen <zide.chen@intel.com>
>
> KVM: x86/pmu: Support RDPMC Metrics Clear Mode
>
> This commit adds support for PERF_CAP_RDPMC_METRICS_CLEAR (bit 19 of
> IA32_PERF_CAPABILITIES). It advertises this capability to guests when the
> mediated PMU is enabled and the host reports it, unmasking the relevant
> control bit. It also updates intel_emulate_rdpmc() to replicate the
> clear-on-read behavior for consistency.
>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 98e2fb80347a1..3e5e8bae67ab0 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> [ ... ]
>> @@ -138,6 +149,18 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
>>  			return 1;
>>  
>>  		*data = pmu->perf_metrics;
>> +
>> +		/*
>> +		 * Per the SDM, RDPMC of PERF_METRICS clears both PERF_METRICS
>> +		 * and the SLOTS fixed counter when Metrics Clear Mode is
>> +		 * enabled via INTEL_FIXED_3_METRICS_CLEAR in FIXED_CTR_CTRL.
>> +		 */
>> +		pmc = kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
>> +		if (pmc && intel_pmu_metrics_clear_enabled(pmu)) {
>> +			pmu->perf_metrics = 0;
>> +			pmc_write_counter(pmc, 0);
>> +		}
>> +
> [Severity: Low]
> Does tying the clearing of PERF_METRICS to the existence of the SLOTS PMC in
> intel_emulate_rdpmc() violate the hardware specification?
>
> If the guest executes RDPMC natively and triggers an interception, and the
> SLOTS counter is not exposed to the guest (making kvm_pmc_idx_to_pmc return
> NULL), but METRICS_CLEAR_EN is enabled, this code silently skips clearing
> PERF_METRICS.
>
> Should the clearing of pmu->perf_metrics be performed independently of whether
> the software PMC object for the SLOTS counter exists?
>
>>  		return 0;
>>  	default:
>>  		return 1;
> [ ... ]
>> @@ -601,6 +624,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  						 INTEL_FIXED_0_USER |
>>  						 INTEL_FIXED_0_ENABLE_PMI);
>>  
>> +	if (perf_capabilities & PERF_CAP_RDPMC_METRICS_CLEAR)
>> +		pmu->fixed_ctr_ctrl_rsvd &=
>> +			~intel_fixed_bits_by_idx(INTEL_FIXED_SLOTS_IDX,
>> +						 INTEL_FIXED_3_METRICS_CLEAR);
>> +
> [Severity: Medium]
> Does intel_pmu_refresh() unconditionally unmask the METRICS_CLEAR_EN bit
> without verifying if the guest topology actually exposes the SLOTS counter?
>
> If a VM is configured with 3 or fewer fixed counters, this unmasking would
> allow the unprivileged guest OS to write to bit 14 in
> MSR_CORE_PERF_FIXED_CTR_CTRL without triggering the expected #GP.
>
> Should this be gated by checking if pmu->nr_arch_fixed_counters >
> INTEL_FIXED_SLOTS_IDX?

This sounds like a real risk. Should we mask out PERF_METRICS from guest
PERF_CAPABILITIES in intel_pmu_refresh() if guest doesn't advertise fixed
counter 3?


>
> [Severity: High]
> Does this patch inadvertently cause event filters to strip the METRICS_CLEAR_EN
> bit in kvm_mediated_pmu_refresh_event_filter()?
>
> When a host-level event filter denies the SLOTS counter (counter 3) from
> counting, KVM applies a 0xf hardware mask that zeroes all 4 configuration bits
> for the counter:
>
> arch/x86/kvm/pmu.c:kvm_mediated_pmu_refresh_event_filter() {
> ...
> 	} else {
> 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
>
> 		pmu->fixed_ctr_ctrl_hw &= ~mask;
> 		if (allowed)
> 			pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
> 	}
> }
>
> Since this mask covers the entire 4-bit configuration block, it will also clear
> bit 14 (METRICS_CLEAR_EN) from hardware. If the guest sets METRICS_CLEAR_EN and
> then executes RDPMC natively, it will lead to un-cleared stale metrics.
>
> Should the mask be updated to avoid interfering with this newly introduced
> feature bit?

This is another tricky corner case. The best way should be disabling
PERF_METRICS along with fixed counter 3. But Intel HW doesn't provide a way
to disable PERF_METRICS except the EN_PERF_METRICS bit in PERF_GLOBAL_CTRL.
Since PERF_GLOBAL_CTRL could be in pass-through mode and guest could
directly overwrite PERF_GLOBAL_CTRL, it becomes meaningless for KVM
clearing EN_PERF_METRICS bit for guest PERF_GLOBAL_CTRL.

For the filter mask, it may be good enough to only mask out
(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER).

Thanks.


>
>>  	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
>>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>>  	pmu->global_ctrl_rsvd = counter_rsvd;

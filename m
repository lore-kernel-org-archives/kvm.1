Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793141820;
	b=EGI8A6mfiNc5GS3rqJfi01Nfi0/OgQ6BsFlx96E0Y448yn4fXYUEgXJ2oEIR0SiI3P2L
	 zqpjF3K6bJp3q53nDTO7t1eSJAmlBcCi4604DDOXKwmoU32oz4C0772zEFcUSPvpUN3Fi
	 BUJwAGQHlMCOa/zh4i6vAaV0s2+5sI4SFkBDIkPh4k8XWW7Dg94+ORGZNgxDzDYnDYAAE
	 Jwahk1rVDPsTqlpzHcWbvNhZFR8/RDJShWdYlWJwixsIB/5/pUPL8RgHW1alKy6UOz0VP
	 yvlYgHr61+AJ2yf0kLJERcI7lSfMx/fU+dScw4bNmnPIvw92MoZ1h8guDVwJ9HwiOkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793141820;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gIVns6+2kR7Rl7cmy4htyby4FQjdtEx7csuUjrR4iLk=;
	b=F130/u5v/q46NJS0VJ72GXNUl2k47DUb89G0qOAn1sn85RyKAHSEdxq9biMKoCHciLI7
	 c7zOhZ/Y6UQ0dnbTsiww9FDoFC1W2oN/mAuW8O3tYlvFyhHE8yXnVzrQVndLzSUfEKi5k
	 9tVtrngWYggJaKajhIQQ5fuigkVgXGiWFT7bRbUdIALKMV3yT/yh8Tf/obFZ0PhkrYPTm
	 LsxypdBdQiGoCMsolwoYrnOolvImm0/aYPE9mKnmrVXDX7Y00MUcz8kzDNpRhMb7tObRv
	 J/iEHE2DhcRZnBxaALtIO8HnQNOEjaIxAykqZSEb/ZfYH009boPgX/cE3wvI2b4rM3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ia0l5YsQ;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654B606A31D
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 22:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6654B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ia0l5YsQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793141818; x=1824677818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sOlyCuSZxE0bpLNopzU/8YOcrlV8+AwrSCT7isibU64=;
  b=Ia0l5YsQfifRZH2wzIMpg6e5f1qQFOZvfYPs5UHUPDQvvzHmjcMJ5sHu
   ON/uK4CEjP58Gpw3RfQfF43TZ9kH5vebJpr+LS3JHhM2yL7I6FG3pu+oP
   ddbu/4RM4Q24wp3NQYpoTTwUqzhm+E2x8yHO0hJdntv1bx974wGIc1ShH
   XCBqjFaE5diwy7D9yiTjmknChew4np62TVzi90JnXPsEHZQXnc38lZxQO
   KLJ+6iY4Jb7YdWHpaK2zwV8MO+ceR+zfI8THKhpr2chUC64Qcvce9eF2G
   xoc9mbTwLpozWUzPPn5Q+J3Q8+GH8Xt5e7XuJFxdq8qPEEfRorPwQrt+T
   A==;
X-CSE-ConnectionGUID: coxP653nT7S/xJrHgNe3pw==
X-CSE-MsgGUID: sLHc3+kySwerXRIqAsZWAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1946899"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1946899"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:56:58 -0700
X-CSE-ConnectionGUID: 47NJByKORP2a9ouAGCSZiw==
X-CSE-MsgGUID: Eowt1B9AQoS9P7g39cH8WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4998129"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 15:56:57 -0700
Message-ID: <1e3230bc-800c-4862-9bb8-ff1074e76fc8@intel.com>
Date: Tue, 27 Oct 2026 17:56:56 -0500
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/12] KVM: x86/pmu: Support RDPMC Metrics Clear Mode
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-13-zide.chen@intel.com>
 <20260918202200.F39971F000FF@smtp.kernel.org>
 <1de5af16-06a5-4b97-ba92-0a4ac02c32ff@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <1de5af16-06a5-4b97-ba92-0a4ac02c32ff@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/21/2026 4:39 AM, Mi, Dapeng wrote:
> 
> On 9/19/2026 4:22 AM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>> - [High] pmu: event filter mistakenly strips METRICS_CLEAR_EN from fixed_ctr_ctrl_hw
>> - [Medium] pmu: METRICS_CLEAR_EN unmasked without validating fixed counter bounds
>> - [Low] pmu: emulation incorrectly ties PERF_METRICS clearing to SLOTS PMC existence
>> --
>>
>> commit 8ba3725c32dbde4a1c3935cb433e898e06425b83
>> Author: Zide Chen <zide.chen@intel.com>
>>
>> KVM: x86/pmu: Support RDPMC Metrics Clear Mode
>>
>> This commit adds support for PERF_CAP_RDPMC_METRICS_CLEAR (bit 19 of
>> IA32_PERF_CAPABILITIES). It advertises this capability to guests when the
>> mediated PMU is enabled and the host reports it, unmasking the relevant
>> control bit. It also updates intel_emulate_rdpmc() to replicate the
>> clear-on-read behavior for consistency.
>>
>>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>>> index 98e2fb80347a1..3e5e8bae67ab0 100644
>>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> [ ... ]
>>> @@ -138,6 +149,18 @@ static int intel_emulate_rdpmc(struct kvm_vcpu *vcpu, unsigned int idx,
>>>  			return 1;
>>>  
>>>  		*data = pmu->perf_metrics;
>>> +
>>> +		/*
>>> +		 * Per the SDM, RDPMC of PERF_METRICS clears both PERF_METRICS
>>> +		 * and the SLOTS fixed counter when Metrics Clear Mode is
>>> +		 * enabled via INTEL_FIXED_3_METRICS_CLEAR in FIXED_CTR_CTRL.
>>> +		 */
>>> +		pmc = kvm_pmc_idx_to_pmc(pmu, INTEL_PMC_IDX_FIXED_SLOTS);
>>> +		if (pmc && intel_pmu_metrics_clear_enabled(pmu)) {
>>> +			pmu->perf_metrics = 0;
>>> +			pmc_write_counter(pmc, 0);
>>> +		}
>>> +
>> [Severity: Low]
>> Does tying the clearing of PERF_METRICS to the existence of the SLOTS PMC in
>> intel_emulate_rdpmc() violate the hardware specification?
>>
>> If the guest executes RDPMC natively and triggers an interception, and the
>> SLOTS counter is not exposed to the guest (making kvm_pmc_idx_to_pmc return
>> NULL), but METRICS_CLEAR_EN is enabled, this code silently skips clearing
>> PERF_METRICS.
>>
>> Should the clearing of pmu->perf_metrics be performed independently of whether
>> the software PMC object for the SLOTS counter exists?
>>
>>>  		return 0;
>>>  	default:
>>>  		return 1;
>> [ ... ]
>>> @@ -601,6 +624,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>>  						 INTEL_FIXED_0_USER |
>>>  						 INTEL_FIXED_0_ENABLE_PMI);
>>>  
>>> +	if (perf_capabilities & PERF_CAP_RDPMC_METRICS_CLEAR)
>>> +		pmu->fixed_ctr_ctrl_rsvd &=
>>> +			~intel_fixed_bits_by_idx(INTEL_FIXED_SLOTS_IDX,
>>> +						 INTEL_FIXED_3_METRICS_CLEAR);
>>> +
>> [Severity: Medium]
>> Does intel_pmu_refresh() unconditionally unmask the METRICS_CLEAR_EN bit
>> without verifying if the guest topology actually exposes the SLOTS counter?
>>
>> If a VM is configured with 3 or fewer fixed counters, this unmasking would
>> allow the unprivileged guest OS to write to bit 14 in
>> MSR_CORE_PERF_FIXED_CTR_CTRL without triggering the expected #GP.
>>
>> Should this be gated by checking if pmu->nr_arch_fixed_counters >
>> INTEL_FIXED_SLOTS_IDX?
> 
> This sounds like a real risk. Should we mask out PERF_METRICS from guest
> PERF_CAPABILITIES in intel_pmu_refresh() if guest doesn't advertise fixed
> counter 3?

Yes, will checks the availability of guest FC3 in
kvm_vcpu_has_perf_metrics() as well.

>>
>> [Severity: High]
>> Does this patch inadvertently cause event filters to strip the METRICS_CLEAR_EN
>> bit in kvm_mediated_pmu_refresh_event_filter()?
>>
>> When a host-level event filter denies the SLOTS counter (counter 3) from
>> counting, KVM applies a 0xf hardware mask that zeroes all 4 configuration bits
>> for the counter:
>>
>> arch/x86/kvm/pmu.c:kvm_mediated_pmu_refresh_event_filter() {
>> ...
>> 	} else {
>> 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
>>
>> 		pmu->fixed_ctr_ctrl_hw &= ~mask;
>> 		if (allowed)
>> 			pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
>> 	}
>> }
>>
>> Since this mask covers the entire 4-bit configuration block, it will also clear
>> bit 14 (METRICS_CLEAR_EN) from hardware. If the guest sets METRICS_CLEAR_EN and
>> then executes RDPMC natively, it will lead to un-cleared stale metrics.
>>
>> Should the mask be updated to avoid interfering with this newly introduced
>> feature bit?
> 
> This is another tricky corner case. The best way should be disabling
> PERF_METRICS along with fixed counter 3. But Intel HW doesn't provide a way
> to disable PERF_METRICS except the EN_PERF_METRICS bit in PERF_GLOBAL_CTRL.
> Since PERF_GLOBAL_CTRL could be in pass-through mode and guest could
> directly overwrite PERF_GLOBAL_CTRL, it becomes meaningless for KVM
> clearing EN_PERF_METRICS bit for guest PERF_GLOBAL_CTRL.
> 
> For the filter mask, it may be good enough to only mask out
> (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER).

Yes, the 0xf mask erroneously strips bit 14 (METRICS_CLEAR_EN).
Since event filtering is only intended to prevent counter
increments, mask out only (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER) is
sufficient, which also leaves the PMI enable bit intact.

This also matches the GP counter handling, which only masks out the
necessary enable bit and keep all other bits unchanged.

@@ -557,7 +574,9 @@ static void
kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
                        pmc->eventsel_hw |= pmc->eventsel &
                                            ARCH_PERFMON_EVENTSEL_ENABLE;
        } else {
-               u64 mask = intel_fixed_bits_by_idx(pmc->idx -
KVM_FIXED_PMC_BASE_IDX, 0xf);
+               u64 mask = intel_fixed_bits_by_idx(pmc->idx -
KVM_FIXED_PMC_BASE_IDX,
+                                                  INTEL_FIXED_0_KERNEL |
+                                                  INTEL_FIXED_0_USER);
> 
>>
>>>  	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
>>>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>>>  	pmu->global_ctrl_rsvd = counter_rsvd;


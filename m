Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4032B9A8
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 23:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196531; cv=none; b=mtkokq7JiwC2RurUGs7nuuvY0nADvw1obkQZ32FQcjC5fPNRmja0HpMUyOhwTxMfSQUk4lVIWgh3FCGM4yWMJMQb4KH/dC67/oNcyNP3qAx7j1uMQTH8LDiEFBFAtgoe1yr4Tf4XbeGGMh7/7FdcB++t0JqeVM7ri+8/07ppQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196531; c=relaxed/simple;
	bh=lJmuZY0S7QDv4ckH6M3o6VxfiVoT5kOQyRqJ20K45eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVKKRxjFZB98wVqFtn39u9BYDEUWLqEJ5bdl54MH9OTr55fm5a+TlmtsydVNBQGKmxXzdM+4uM2pagPCXeKRur9xsuLmMfDxNRYGVzB+fNugAYZTlqKBkMPnwnjPN7Ystam7Is/NrFHSRFaEzuUK1x7qMdMv68skzWn5Re92BhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSEh7a/A; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSEh7a/A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785196529; x=1816732529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lJmuZY0S7QDv4ckH6M3o6VxfiVoT5kOQyRqJ20K45eo=;
  b=DSEh7a/AzBwGgqwOhfqNGESC7c2x2KoRIlshHIZSGLHsEyr10eIL77z/
   Km+YR42mCqyCKg5uuqbXls2Twz9rx4YcQhbB0LGcKK93GFFiVarqWGUyC
   N/40JFDgzFnM+kZvz3W8UhpAJwV4rR3iN7RT2reH75p/Cy+8OyIbaJZ3f
   5ElZz5Vb9JCQTe+Z96QcKeef1x/dIrEAADcJ4u9J8GHeosd4Bg5SQBGlw
   AN8KQR/6JPIiFz6fITzI5t6/qOi137NNpHcpH6c0dK1hBOTQSpSri0/jk
   lazfmT7Xf1CTawICXhko3Q9i/Kz902nnGAZAVQc0jZlT8lrTeNRMaxKn/
   w==;
X-CSE-ConnectionGUID: ceMeWAtrS2ORrK/tGHSeYA==
X-CSE-MsgGUID: 1VpV0buvQE6DGOJwARwHHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85538830"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85538830"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 16:55:29 -0700
X-CSE-ConnectionGUID: p9DI3qnjSUa4Fn00ElArog==
X-CSE-MsgGUID: wVd+uPkYQAKAk/lH1WGkwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="263036384"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 16:55:28 -0700
Message-ID: <b5294274-3db1-43c7-afdb-e85db4d17404@intel.com>
Date: Mon, 27 Jul 2026 18:55:27 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/9] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-6-zide.chen@intel.com>
 <20260727195009.4851A1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260727195009.4851A1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/2026 2:50 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Guest PMU state in MSR_PERF_METRICS is leaked to the host and other VMs because KVM fails to clear it on PMU context switch when the guest is configured without the PERF_CAP_PERF_METRICS feature.
> --
> 
> --- Patch [5]: [PATCH v7 5/9] KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU ---
> commit 2933f2f58fa948287c388e166de23d159332fdf8
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> KVM: x86/pmu: Support PERF_METRICS MSR in mediated vPMU
> 
> This commit exposes the IA32_PERF_METRICS MSR to guests when mediated
> vPMU is enabled. It handles passthrough of the MSR and saves or restores
> its state during PMU context switches to prevent clobbering or leaking
> state.
> 
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> 
> [ ... ]
> 
>> @@ -831,6 +852,19 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>>  	 */
>>  	if (pmu->fixed_ctr_ctrl_hw)
>>  		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>> +
>> +	if (kvm_vcpu_has_perf_metrics(vcpu)) {
>         ^^^^
> 
> [Severity: High]
> Could this leak guest PMU state to the host or other VMs?
> 
> In intel_mediated_pmu_put(), this checks if the guest has the
> PERF_CAP_PERF_METRICS capability before clearing MSR_PERF_METRICS.
> However, if the physical CPU supports this feature but the guest is
> configured without it, could the guest still activate it?
> 
> If KVM configures MSR_CORE_PERF_GLOBAL_CTRL for passthrough (which happens
> when counter counts match, as kvm_need_perf_global_ctrl_intercept() only
> checks counter counts), the guest can write to bit 48 of
> MSR_CORE_PERF_GLOBAL_CTRL. The hardware PMU would then start updating
> MSR_PERF_METRICS.

Good catch. It's a basic yet important issue and something I should have
thought of earlier.

If the host supports PerfMetrics but it is not exposed to the guest,
MSR_CORE_PERF_GLOBAL_CTRL must be intercepted so the guest cannot enable
bit 48.

With the following code, the guest cannot activate MSR_PERF_METRICS, and
the leak concern goes away.

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 9292407f0353..474207c6413d 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -819,6 +819,7 @@ static bool kvm_need_any_pmc_intercept(struct
kvm_vcpu *vcpu)
 bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
 {
        return kvm_need_any_pmc_intercept(vcpu) ||
+              kvm_need_perf_metrics_intercept(vcpu) ||
               !kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);

> Since kvm_vcpu_has_perf_metrics() returns false in this scenario, this path
> would skip clearing the physical MSR_PERF_METRICS on VM-exit, leaving guest
> state in the hardware register for the next VM or host to read.
> 
>> +		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
>> +		/*
>> +		 * The SDM requires restoring fixed counter 3 before
>> +		 * PERF_METRICS. However, this path writes 0 to PERF_METRICS
>> +		 * before fixed counter 3. For this all-zero case, the
>> +		 * resulting hardware state is therefore the same regardless
>> +		 * of write order.
>> +		 */
>> +		if (pmu->perf_metrics)
>> +			wrmsrq(MSR_PERF_METRICS, 0);
>> +	}
>>  }
> 


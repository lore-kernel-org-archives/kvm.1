Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5610A37A847
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194214; cv=none; b=uT7CmF51zxyonGg1NoKPkuxBPgueM4woCAfmB399hprZ6+vLLkjj8RldtQ/Rj9W7VOKR76fYbS2UsZymS1f7nkU4+66ePK+R1Yl9hUMOhnKg0f+1jYNdqLBQyKgmdY2Nx4+sP6jLuD93znMpi0JJtn++VYSLMyaWEK+1oQM2ewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194214; c=relaxed/simple;
	bh=C85A++KuUYqiv6lPWfg2CoF8YvF8NaICP8JNtTWmuVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvNwoyyfQ4c2edd8TqeYGLrIP7VVGA7QyVeMm3tmoYmTEvNQxIIush/TXVE9L5Kz4OCAyUrD6wTpZnztwGUQ3YQ5q1h6TuCnzSEGuhAYUGnY3mSkD1m+5yF2KhcPzN3Hy21W+nj6nFKetC9W+jB8p2kaEqX6SgQ0TL439N2kgHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcLbNGfW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcLbNGfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785194211; x=1816730211;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C85A++KuUYqiv6lPWfg2CoF8YvF8NaICP8JNtTWmuVM=;
  b=YcLbNGfWNDTRIuJm//6JIcxqITXrF9wk0TJ3F7dk4X3YMsSV0L3B3Mq7
   1inAKiv/4Aq1oJd83p9wW/aGwe7ZbV1gLcqK/GGI0chzRgisb4783xmhs
   RV3Sno/nESSPufy4eOIk05zj0LiUuDcDBYKWh+qWTLmnAwwTanzDa4YqC
   EVPnlFdcH4DC+J7LPViWwyLawc7CLUNgiW7xQ5EnNjdLENxFEw9Cwii+p
   G9o417vQkKxQuGYKCKpsGGEdJGhOn5nMkP7V5MMsmd7Z0UByV9of3RgeT
   K50gQaksIZuMBDBfy9wig0NbL7/gcIWoV+y4mKKV87PJIywUAuT0vD8zJ
   A==;
X-CSE-ConnectionGUID: jytMKw8VRfK3LDjaBcX3Yw==
X-CSE-MsgGUID: ESevfFNOSoOXtH2wXwFPdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89662452"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="89662452"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 16:16:51 -0700
X-CSE-ConnectionGUID: bjJGES+LQPOuK5wS7KufLg==
X-CSE-MsgGUID: YgvBlmFaSEqo+FTJ75SsHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="259598215"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 16:16:51 -0700
Message-ID: <f2a2588e-b198-4895-98f3-e907071a243a@intel.com>
Date: Mon, 27 Jul 2026 18:16:49 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES
 in kvm_host
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-5-zide.chen@intel.com>
 <20260727194448.CD47F1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260727194448.CD47F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/2026 2:44 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Incomplete replacement of raw MSR_IA32_PERF_CAPABILITIES read leaves KVM vulnerable to kernel panics during module initialization.
> --
> 
> --- Patch [4]: [PATCH v7 4/9] KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host ---
> commit 6a6d946c1225761f83ef8a8498aa4ccab5425b72
> Author: Mingwei Zhang <mizhang@google.com>
> 
> KVM: x86/pmu: Snapshot host IA32_PERF_CAPABILITIES in kvm_host
>     
> Cache the unadulterated snapshot of perf_capabilities so that KVM can
> compare guest vPMU capabilities against raw hardware capabilities.
> 
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 0626e835e9eb7..e0114f248a9ef 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
> [ ... ]
>> @@ -7033,6 +7033,10 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
>>  	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
>>  		rdmsrq(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
>>  
>> +	if (boot_cpu_has(X86_FEATURE_PDCM))
>> +		rdmsrq_safe(MSR_IA32_PERF_CAPABILITIES,
>> +			    &kvm_host.perf_capabilities);
>> +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but there is an incomplete
> replacement of a raw MSR_IA32_PERF_CAPABILITIES read elsewhere that leaves
> KVM vulnerable to kernel panics during module initialization.
> 
> If a nested hypervisor exposes CPUID.PDCM but faults on the MSR access, the
> raw rdmsrq() in intel_pmu_is_mediated_pmu_supported() can trigger a #GP and
> panic the kernel:

I don't think KVM needs to handle that case. In
intel_pmu_is_mediated_pmu_supported(), If CPUID.1:ECX.PDCM is advertised
in an Intel platform but reading IA32_PERF_CAPABILITIES causes a #GP,
that's a bug in the underlying hypervisor.

The reason I used rdmsrq_safe() here is that this code lives in common
x86 code. In theory, a non-Intel architecture could potentially
implement CPUID.1:ECX[15] without supporting IA32_PERF_CAPABILITIES.

rdmsrq_safe() is a defensive safeguard.

> arch/x86/kvm/vmx/pmu_intel.c:intel_pmu_is_mediated_pmu_supported() {
>     ...
>     rdmsrq(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
>     ...
> }
> 
> While this patch safely caches the MSR using rdmsrq_safe() here in
> kvm_x86_vendor_init(), this snapshot is populated after
> kvm_init_pmu_capability() has already run.
> 
> Because of this ordering, intel_pmu_is_mediated_pmu_supported() cannot
> currently use this safely cached value, as it would incorrectly read 0.
> 
> Would it make sense to reorder the initialization so the snapshot is
> populated before kvm_init_pmu_capability() runs, and then update
> intel_pmu_is_mediated_pmu_supported() to use kvm_host.perf_capabilities
> to avoid the #GP risk?
> 
>>  	WARN_ON_ONCE(kvm_nr_uret_msrs);
>>  
>>  	r = ops->hardware_setup();
> 


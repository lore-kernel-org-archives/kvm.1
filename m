Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23C4779A3
	for <kvm@vger.kernel.org>; Tue, 16 Jun 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627528; cv=none; b=AERkxfpsg7nWIIQ/ihvy2T5NiJcfrdtGCtlvRpeNmhFrSENIcOy/CxgxXyWTyxVH84ijqL3Vq5CJB8+TEhFxeBi9w/Lq8JLnsIXhpA8nMQv5s9AJe/9G8kuoueM/L6zqOxcagbpxFnm2QqRL3IL1QdfSqrTTaUuZY2BSJH/mKr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627528; c=relaxed/simple;
	bh=Fj8TzhLob2NdJBaiwdtFI+rXY+7QYb5l9Qj7g4zGkdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJp0oXGRsWuh0HILYwJLG86XcIC69qZqhv0FHBwIK/ukt2WKYKSE+S/dN18yp1/sQOgQLnJzUWM7usMDfjAwVxe6BT+dFJVyCuXBfHijMcxeBo+My2GAtkKD5hBimvzXLqmcGQ6zSBhvhr8hmhg0UeSSxzO1YFS8eUO0PGS0HfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkXmcbQu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkXmcbQu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781627526; x=1813163526;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fj8TzhLob2NdJBaiwdtFI+rXY+7QYb5l9Qj7g4zGkdo=;
  b=dkXmcbQuHo8y3pKjpVSgHetzdC2DUkiX2bHHape6hXfgxzD66mAD9ghU
   UYonwChoejQg9lEaopPu7GoBzT3qQnDUzVSGoaJwPkbAZJzl4GC6HzYap
   Re4l/I7l4S1KJeIirVA4QfJHu11N6pD7EFAY0j3UqiT2v1c3bsbA5r4ZJ
   EbKCB8vMBy7dvNz0ac8olBksOBoN6ny4xyQSFgoePDZUP3S38OsErDAHq
   ORiCtkzfvFskTLCNRTl2d2o1nGWZ/tJ7+Wmzu8NS0wnbCaS13/Y9X6c+x
   a7mJZr5NI3+aedzqX6jKo73QEKe80tlcb/1xzwxcf2J9OejLPSkTHMJV4
   A==;
X-CSE-ConnectionGUID: 40wLR39JRWqpIopWO6/Eig==
X-CSE-MsgGUID: H2M87C8gT/ezdExi1+eQng==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="86237274"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="86237274"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 09:32:06 -0700
X-CSE-ConnectionGUID: umCaix6vQuqo2ZJTKYwl3g==
X-CSE-MsgGUID: n6QsVB3gQSGDnnLFpUoZyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="251740188"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 09:32:05 -0700
Message-ID: <9f1d6940-3180-4aff-841b-82baa3ab0029@intel.com>
Date: Tue, 16 Jun 2026 11:32:04 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] KVM: selftests: Add perf_metrics and fixed counter
 3 tests
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260615230118.50718-5-zide.chen@intel.com>
 <20260615232652.768D71F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260615232652.768D71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/15/2026 6:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] A malicious or misconfigured guest can trigger a host-side WARN_ON_ONCE by forcing KVM to emulate an RDMSR or WRMSR to MSR_PERF_METRICS, leading to log spam or a host kernel panic.
> --
> 
> commit 2e12d71150f3902b3e1f245bbcb48d6fe2235b4a
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: selftests: Add perf_metrics and fixed counter 3 tests
> 
> This commit adds a selftest to exercise IA32_PERF_METRICS support for Topdown
> (TMA) Level 1 metrics. It checks for non-zero metrics derived from the
> workload and extends the PMU selftest to cover Intel fixed counter 3 by
> bumping MAX_NR_FIXED_COUNTERS to 4.
> 
>> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> index dc6afac3aa919..d4688a7d1e556 100644
>> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> [ ... ]
>> @@ -318,6 +322,56 @@ static void guest_test_arch_event(u8 idx)
>>  				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
>>  }
>>  
>> +static void guest_test_perf_metrics(void)
>> +{
>> +	int retiring, bad_spec, fe_bound, be_bound, sum;
>> +	u64 global_ctrl, metrics;
>> +
>> +	if ((guest_get_pmu_version() < 2) ||	/* Does guest have GLOBAL_CTRL? */
>> +	    !this_cpu_has(X86_FEATURE_PDCM) ||
>> +	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
>> +		return;
>> +
>> +	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>> +	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
>> +	wrmsr(MSR_PERF_METRICS, 0);
> 
> [Severity: High]
> This is a pre-existing issue, but since this test now exercises
> MSR_PERF_METRICS, is it possible for a guest to trigger a host-side
> WARN_ON_ONCE by forcing KVM to emulate RDMSR or WRMSR to MSR_PERF_METRICS?
> 
> Looking at KVM's emulation path in arch/x86/kvm/vmx/pmu_intel.c,
> intel_pmu_get_msr() and intel_pmu_set_msr() both contain a WARN_ON_ONCE:
> 
> intel_pmu_get_msr() {
>     ...
>     case MSR_PERF_METRICS:
>         WARN_ON_ONCE(!msr_info->host_initiated);
>         msr_info->data = pmu->perf_metrics;
>         break;
> }
> 
> If a malicious guest forces instruction emulation for RDMSR or WRMSR targeting
> this MSR (for example, by using the KVM_FEP forced emulation prefix, or by
> executing the instruction from a page that triggers an EPT violation on
> fetch), the instruction is processed by KVM's software emulator.
> 
> The emulator calls kvm_emulate_msr_read() or kvm_emulate_msr_write(), which
> explicitly set msr_info.host_initiated = false.
> 
> Could this trigger the WARN_ON_ONCE in intel_pmu_get_msr() or
> intel_pmu_set_msr() and allow an unprivileged guest to spam the host kernel
> log or panic the host if panic_on_warn is enabled?


Yes, it's good to change this in patch 3/4 to avoid the WARN_ON_ONCE().

        case MSR_PERF_METRICS:
-               WARN_ON_ONCE(!msr_info->host_initiated);
+               if (!msr_info->host_initiated)
+                       return 1;

> 
>> +
>> +	/* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
>> +	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
>> +	global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
>> +		      PERF_METRICS_GLOBAL_CTRL_ENABLE;
>> +
>> +	GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
>> +
>> +	/* Check test results. */
>> +	metrics = rdmsr(MSR_PERF_METRICS);
> 


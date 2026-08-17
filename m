Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7BA47255B
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003070; cv=none; b=ANbsvvDekntt2L5ILATAcrSFE58YqiPbBi0o+ZvBvr6w1iZZgivPWNW6qoRp++g18qV8RC6UHF33xUuR2TUIkUxBm0ncXVwzqIe8m1Rr/db1hgZ2k9Oqm1LsH1rcp5EOXZ/3/RYil2iaU8lwEgpLhAThGRVA6Gd0BbKZwiMW+sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003070; c=relaxed/simple;
	bh=PxWnnOZ/yY7v4dndJ3/3pM20e0F+LIWiHptKJdD1bhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vpo9mOWkd1F9ZpYO7FtLcztT8AwXz4PxMy703W3SFCqbivHxaaHtE9J1drFoby4x/GmlwaK4DyI8Wg4/7CgL4zFePAPooza+7D2OA8DIXW70dCMFWHXZMtqIIh617yuIky17yQqft9FTw3BCTKxSBjzXWQVKZDXRZ0UPUdSm/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cai8MlLV; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cai8MlLV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787003068; x=1818539068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PxWnnOZ/yY7v4dndJ3/3pM20e0F+LIWiHptKJdD1bhw=;
  b=cai8MlLV+98AG8vlypenjzQcNSgcqW8NOWhf2bD3BZKm8Fx8l8biiTgs
   ONd249TQAlKd96PIGJr5OENTdX2i8to8yiRwX5gz82c9XBl1cckJ379kD
   7Y0hjvuPx4HEB0SMiH08T2dORQXXXPLu4g4xIe85SEkL22gVOYiGJXOMj
   7DWJsGZ4/kThlFB+X/6VfW+h0sRkngQjfyyvThACZxrDu2qRgbgwfCI4t
   9LHcK+2czp3n9BgHcGJ38kFT6mvSa1AG6Sb+JVuNJ4vBlbP8Gia/peBma
   WMDORke4/tFyW1JUnioR2qsHqxvVsCJNHeWPYaUEEdB+fX5MgIxxRNI/t
   Q==;
X-CSE-ConnectionGUID: MNgHEN7ATMGFVpdrU82eWg==
X-CSE-MsgGUID: 5rcbAB9hSAaQpFs2EG4fBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="75017754"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="75017754"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 14:44:27 -0700
X-CSE-ConnectionGUID: rnwie4CjTI6lAatQFGKo/w==
X-CSE-MsgGUID: PLohCAVCRW2xRGsMxaYdJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263275500"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 14:44:27 -0700
Message-ID: <d1b2f17d-f147-4636-9d99-088dda11813b@intel.com>
Date: Mon, 17 Aug 2026 16:44:25 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-9-zide.chen@intel.com>
 <20260817185753.605521F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260817185753.605521F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/2026 1:57 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Unhandled #GP / Selftest Crash when writing 0xdeaddead to MSR_PERF_METRICS.
> --
> 
> --- Patch [8]: [PATCH v8 8/8] KVM: selftests: Add PERF_METRICS and fixed counter 3 tests ---
> commit 19d6869fac1fbdcc63ff54623403cec33b922848
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: selftests: Add PERF_METRICS and fixed counter 3 tests
> 
> This commit adds a test case to exercise IA32_PERF_METRICS for Topdown
> (TMA) Level 1 metrics and extends the PMU selftest to cover Intel fixed
> counter 3.
> 
>> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> [ ... ]
>> +static void __guest_test_perf_metrics(void)
>> +{
> [ ... ]
>> +	/* Sanity check after PERF_METRICS disabled. */
>> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
>> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
>> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
>> +
>> +	guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0xdeaddead);
>> +}
> 
> [Severity: Medium]
> Will this wrmsr(MSR_PERF_METRICS, 0xdeaddead) cause an unhandled #GP and
> crash the selftest on hosts with Mediated PMU pass-through?
> 
> Writing an architecturally invalid non-zero value to MSR_PERF_METRICS
> generates a #GP on real hardware. Under Mediated PMU, KVM configures the
> VMCS to pass-through MSR accesses directly to hardware, so this fault
> would be injected into the guest.

0xdeaddead is a valid non-zero value. So this statement is supposed to
work well.

> 
> If the hardware silently discards the write instead of faulting, will the
> subsequent guest_test_rdpmc() assertion fail because it expects to read back
> 0xdeaddead, while the hardware holds the previous value?
> 


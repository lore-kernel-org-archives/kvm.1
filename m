Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAC434041B
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396790; cv=none; b=RctH3HgKuUbAf1GccUpypAQApKoB253n7RHhkpt0n+AqlMt0je8+eDcpi4X520q1DUMi8xMkCUU4ylN2B2tedX77AiQf+Qn5x7f9rWqlE2gzZfRQmk1T2yAN8ixnSknKTi+xNb8zQNbqHmXdlyNZhI4L2qy8YxzWffSIL/3CtHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396790; c=relaxed/simple;
	bh=G706vcviaf0G4ghVL1kjZ6StRVxllMw8TNZjddiYHio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZHnnaW16WIE92yp+IxI6Fjn8aZNO8OrZRuIctEmnhEav6V4E+TkMtb7BNYpaQIh5Ge+dLk3flVtbnirPZxRzURHuxuHA+bn1lyNYRG8JoVtqGvDqMoB0zLL8QJrqJ8t+S99zWnxIcCKY5XzChf9uVspVNE6X7NSRGqxB6B3Xyv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3atKU1R; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3atKU1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782396789; x=1813932789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G706vcviaf0G4ghVL1kjZ6StRVxllMw8TNZjddiYHio=;
  b=X3atKU1RTEEKjaijA73tqQzi/c65al/Sxl+tMKPoL62rq9qQOIYZ0SIP
   4lPtPHYe1Q20CCz1dLIJHTrir9lfY4uswEzOOOeEYD5BgDfJDh6O8ijfT
   N6XKfPEhzTx9aQomOAofPZtmMuNeNRxHrP4KwNSoKiHnIAM89bd9VHxXh
   zWyTqBBopgpOOM/yHggalYZpb7y7qj4a3VuDd/zSxRtPdx5Ed1SIGQ1j3
   WN+qtGn+6P/1hhvU9lJkzZ2grqgxn5rhTnuX3QurpZ5Na8L57tOGZTS6b
   Uqp/WyK3A0HE33gbryGYSGK3jg1+ZpW7oGVASZSxy/6H1MtePzlfulN+u
   w==;
X-CSE-ConnectionGUID: h/y+urOQQBuLZtLZOeQCDw==
X-CSE-MsgGUID: qRk/q/m8S/uOFrJ/91pexw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="87018693"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="87018693"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:13:08 -0700
X-CSE-ConnectionGUID: zBzqMGkuQ3muAPWBZrT6Fg==
X-CSE-MsgGUID: 1l4C5aF3QF6SDluOxrRA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="250919254"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:13:09 -0700
Message-ID: <1a2dc028-7770-461f-b2d3-c7efa0d901eb@intel.com>
Date: Thu, 25 Jun 2026 09:13:08 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 7/7] KVM: selftests: Add perf_metrics and fixed counter
 3 tests
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260625034555.141453-1-zide.chen@intel.com>
 <20260625034555.141453-8-zide.chen@intel.com>
 <20260625041342.B303E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260625041342.B303E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/24/2026 11:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The selftest assumes that MSR_PERF_METRICS retains arbitrary written values like 0xdeaddead, which contradicts the Intel SDM and will fail on hardware when mediated PMU passthrough is used.
> --
> 
> commit e4e21b97cacf777b041e2f100421a3f415696310
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: selftests: Add perf_metrics and fixed counter 3 tests
> 
> This commit adds a test case to exercise IA32_PERF_METRICS, validating the
> architectural support for Topdown Level 1 metrics. It also extends the PMU
> selftest to cover Intel fixed counter 3.
> 
>> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> 
> [ ... ]
> 
>> @@ -318,6 +322,56 @@ static void guest_test_arch_event(u8 idx)
> 
> [ ... ]
> 
>> +static void guest_test_perf_metrics(void)
>> +{
> 
> [ ... ]
> 
>> +	/* Sanity check after PERF_METRICS disabled. */
>> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
>> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
>> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
>> +
>> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
> 
> [Severity: Medium]
> Will writing a reserved value to MSR_PERF_METRICS cause test failures on
> hardware with mediated PMU passthrough?
> 
> The Intel SDM specifies that a write of 0 clears the metrics, and other
> write values are reserved.

This MSR is writable.


> When mediated PMU is enabled, KVM disables MSR intercepts for
> MSR_PERF_METRICS. This means the guest executes the wrmsr instruction
> directly on the physical CPU. The hardware will likely reject the reserved
> 0xdeaddead value with a #GP exception, or mask the write, causing the
> GUEST_ASSERT_EQ check to fail.
> 
>> +}
> 


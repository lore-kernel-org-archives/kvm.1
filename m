Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BB38F233
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764356; cv=none; b=liKlZXlgUPOIa3djx+IJAyvOhx8t5MTo80i7TgDyU8oLKPz74O8QdpQEy3Zn6QolDg4IHH9Dbrb9rOuRmJ3VRrwGKiCbKary8bYwg65tGHFagBawX3DG277su5IuwLnzDgbTQNrLAzlrZXwIQHMiZKdiMPTCFxGX503QCYPWbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764356; c=relaxed/simple;
	bh=cOeDfhLG2aM5gTAA1q/6V0Oa4dqIdy3u4c+r0Ksj8xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHckMlxw5S7c1RcXqLQ9ktv95OuAfuSl3Wbj5Mo3kIDgq3xn/hRChDhGsrpSQH0TPY5L04cpJ1NioOWUrZ3xNcWvKq0dfoh0ybv/sexWus6s1kSEsDNIQXvNwRNZc4Uo1JUmaQ4Hx5NFdIuC73nPBrMg5PA21CsPs3kA0SV7Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hfq0ZEmU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hfq0ZEmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789764354; x=1821300354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cOeDfhLG2aM5gTAA1q/6V0Oa4dqIdy3u4c+r0Ksj8xQ=;
  b=Hfq0ZEmUEyJYfa6yqQDWayOTLvVN8VPPVIWKPUVlQJ6wX4P21OrfzhZ8
   LIbs843xCYA3J2ww/NY8d61WeAC+kWVPwzXgzezmU0xY2IUDW3hg+5+dt
   UB8t7CNyynjQqEZA/PC7n3vQ8uGYVxi4byQlQOxxm//ukDL82S2Q1gaN7
   doQFotqeSBNrN8lDIxrWkfP8svQdtJq1kANgHEe3pBoWBsyJF8QZqfncE
   WFPDdaKQU2aSVJPAE3eyearfSxx+04nx14IOrCzEPVTQU/1UJxQMjZDY4
   0MNeAg8tdtAKug0nIzM87jZwufPovT/lb/DXfogRLiZFRqTcAJ5WVL4F9
   w==;
X-CSE-ConnectionGUID: rcw4B+QuREykQBgdHXxEmA==
X-CSE-MsgGUID: ghuCtw5uR6mjszC2aq5lmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="90161572"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="90161572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:45:53 -0700
X-CSE-ConnectionGUID: sahz2QylQoSxEIqFmDo3zw==
X-CSE-MsgGUID: w5mYESLmQDCrHt1lGqboeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271239397"
Received: from calunden-mobl.amr.corp.intel.com (HELO [10.246.168.184]) ([10.246.168.184])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 13:45:53 -0700
Message-ID: <52d94f44-e047-4453-9adb-4192c4f925f0@intel.com>
Date: Fri, 18 Sep 2026 15:45:53 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/12] KVM: selftests: Add PERF_METRICS and fixed
 counter 3 tests
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-9-zide.chen@intel.com>
 <20260918200815.2CC4E1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260918200815.2CC4E1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/2026 3:08 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] selftests: unconditional MSR read causes assertion failure on older kernels
> --
> 
> commit c5ae582e90bae306393c4bf2f37f04a11e37ba5f
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: selftests: Add PERF_METRICS and fixed counter 3 tests
> 
> This commit adds a test case to exercise IA32_PERF_METRICS for Topdown Level
> 1 metrics. It also extends the PMU selftest to cover Intel fixed counter 3 by
> bumping the maximum number of fixed counters and validating functionality.
> 
>> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> [ ... ]
>> @@ -653,8 +657,85 @@ static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
> [ ... ]
>>  static void test_intel_counters(void)
>>  {
>> +	u64 advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
> 
> [Severity: Medium]
> Will this unconditional MSR read cause an assertion failure on older kernels?
> 
> When running the selftest on a host kernel prior to 5.9, KVM does not
> expose MSR_IA32_PERF_CAPABILITIES as a feature MSR. Calling
> kvm_get_feature_msr() unconditionally in test_intel_counters() causes the
> underlying ioctl to fail and return 0, which triggers an assertion failure
> rather than skipping the feature gracefully.
> 
> Other MSR accesses in this file appear to be guarded by checking
> kvm_has_perf_caps first. Could we apply a similar check before reading
> advertised_perf_caps so the test remains compatible with older environments?

Yes, you are right. It should be guarded with kvm_has_perf_caps.

>>  	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
>>  	unsigned int i;
>>  	u8 v;
> [ ... ]
> 


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601061;
	b=ooYj89L9+8jaFEShiVlPNcUK9dujC1V4h5V8z1GRyYsf7BCVbgf3hCUa1TRUdT98dM6p
	 PTcLQs62jINSpA4vnUyaWSsR07zGOSohCdwON018V6UcfYh7qxHfmigIvaZZ4jdtYQnO6
	 Ph9B6nx11IZcsPIdEPIoWh/XDdTINo07TZ5ohw0z0ZUWgS2AWpEANX8/ZKMQbMN9SJ7KA
	 0VikYchFwrbWnWoN8Nh7BOix60ljq/T0PS5h2HZd4XlkOv3puyqLVQjawamBBFnSKkVsH
	 kxM/Qns3saqKLkgHUlxCCA5a6kojek6rMUgDFZn2X/9W48z6v2ahy7ewOd+MXi8Ve/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601061;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sQw4GvATXFtrzEViTcI7yXb0PY3EJAnllv1+ldzoAew=;
	b=Le4bCga4ymcv96qSQoDVYS1I20EyJIy0DKNY8PnT33Pec7lwXuf72TxhqDUgZw0mq5DS
	 7FKPGUt7Bpohis4Ig4Jb5czp3TCLaOpZo/U4sQNrOckZU+7OF1eKpIyLJTnPYVY+mUVaQ
	 x38VDsC3GhHz+1zCzseWweEr3IpBiiYSWEfzFV7SgSHxm8gehf75qdiMK+EQHpD+qO2s/
	 DgrDJeI81ZV1ydN+0uyvt+Tlfj7ceBdYKQAMc8BqznHapxRjUGQch87BKdkIQfuWQmnSg
	 ds/sRS3iYEofQszcwdrzxmHdbeOyNTYp8CP+GDzJwapWPpRhKMVEEFr+mWbchIb9HXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Na7LhR87;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D3A606A332
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 20:17:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60D3A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Na7LhR87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794601061; x=1826137061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FLioU4cDbbnRDreB0K/kLhwrT7wLL1csVX23RCfV9/0=;
  b=Na7LhR87jFvmPWijzZu3VtuDKhCj6zsvCd6AKe8mwfs7+1yJ0Wjpn4Oz
   PvCSmMhByEa82HX/S6nwnM7t04Z/h3AcgQFJzbEI0xXJcTpzyNdWMgX5p
   Pf/O2+hDX2OJFqzIfNLnJ9guaf+AkDhMoI+bYUBgjxKfXnAI4KmDPJamO
   9KZEonybfasViTZjE1zkJwHTkf1mI2OqqLrTrhlWtDHkFydXBW+zoH+3T
   yLnewWEsV5XuSQTsr013vYX3wMEczj3T3lmSMkbynKpEenLlzTPiGHZhj
   towE1BYmnNru8JqyBME4Q6w7rXE48Zo1lRx4E7MaQ0duaWjIwtPqQ3QRQ
   A==;
X-CSE-ConnectionGUID: a0QdmscWRQOvfVMxe1Dr1A==
X-CSE-MsgGUID: 3/YfS/jQR3mzUSzYO1zC5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3446814"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3446814"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 12:17:41 -0800
X-CSE-ConnectionGUID: ipjc2YimRcKAr4DI/2LA0A==
X-CSE-MsgGUID: 3xVpcVvLTgm3oq0L90T70g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9325321"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 12:17:40 -0800
Message-ID: <2a3c1d34-b3f3-47f1-ae15-c3b466f0a363@intel.com>
Date: Fri, 13 Nov 2026 14:17:39 -0600
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
Subject: Re: [PATCH v4 21/21] KVM: selftests: Support fixed counters bitmap in
 pmu_counters_test
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-22-zide.chen@intel.com>
 <sashiko-outbox-211841@kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <sashiko-outbox-211841@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/12/2026 3:00 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] KVM: selftests: missing EDX/ECX combinations in
>   test_fixed_counters()
> --
> 
> commit 3d8b2ca900bb2a01f5f9cee15fc9a12bc40184ad
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> KVM: selftests: Support fixed counters bitmap in pmu_counters_test
> 
> This commit updates this_pmu_has() to check the guest PMU version before
> consulting CPUID.0AH:ECX and updates test_fixed_counters() to test
> supported fixed counter bitmasks alongside CPUID.0AH:EDX[4:0].
> 
>> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> index c3e784e16348c..61e6fe5b6ef48 100644
>> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> 
> [ ... ]
> 
>> @@ -631,25 +632,43 @@ static void __test_fixed_counters(struct kvm_vcpu *vcpu, u8 nr_fixed_counters,
>>  static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
>>  {
>>  	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
>> +	unsigned long fixed_subset;
>>  	struct kvm_vcpu **vcpus;
>>  	struct kvm_vm *vm;
>> +	u32 fixed_bitmap;
>>  	int i = 0;
>> -	u32 k;
>>  	u8 j;
>>  
>>  	pr_info("Testing %u fixed counters, PMU version %u, perf_caps = %lx\n",
>>  		nr_fixed_counters, pmu_version, perf_capabilities);
>>  
>> +	fixed_bitmap = BIT(nr_fixed_counters) - 1;
>> +	if (pmu_version >= 5)
>> +		fixed_bitmap |= kvm_cpu_property(X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK);
>>  
>> -	vm = pmu_vm_create_with_vcpus((nr_fixed_counters + 1) * BIT(nr_fixed_counters),
>> +	/* One vCPU per subset of fixed_bitmap, plus one per legacy EDX test. */
>> +	vm = pmu_vm_create_with_vcpus(BIT(__builtin_popcount(fixed_bitmap)) + nr_fixed_counters,
>>  				      guest_test_fixed_counters,
>>  				      pmu_version, perf_capabilities, &vcpus);
>>  
>> -	for (j = 0; j <= nr_fixed_counters; j++) {
>> -		for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
>> -			__test_fixed_counters(vcpus[i++], j, k);
>> +	for (fixed_subset = 0; fixed_subset <= fixed_bitmap; fixed_subset++) {
>> +		u32 nr_contiguous;
>> +
>> +		/*
>> +		 * The loop walks all values from 0 to fixed_bitmap, so skip any
>> +		 * value that is not a subset of fixed_bitmap.
>> +		 */
>> +		if (fixed_subset & ~fixed_bitmap)
>> +			continue;
>> +
>> +		nr_contiguous = find_first_zero_bit(&fixed_subset,
>> +						    MAX_NR_FIXED_COUNTERS);
>> +		__test_fixed_counters(vcpus[i++], nr_contiguous, fixed_subset);
>>  	}
>>  
>> +	for (j = 1; j <= nr_fixed_counters; j++)
>> +		__test_fixed_counters(vcpus[i++], j, 0);
>> +
>>  	pmu_vm_free(vm, vcpus);
>>  }
> 
> [Severity: Medium]
> Does deriving nr_contiguous from fixed_subset drop test coverage for fixed
> counters enabled solely via CPUID.0AH:ECX when EDX[4:0] is 0?
> 
> Whenever bit 0 of fixed_subset is set, find_first_zero_bit() returns at
> least 1, and the second loop only tests supported_bitmask == 0 with j >= 1.
> As a result, fixed counter 0 (and any contiguous prefix of fixed_subset
> starting at bit 0) is never tested with nr_fixed_counters == 0 and ECX[i]
> set, nor does a guest with pmu_version < 5 get tested with EDX[4:0] == 0
> and a non-zero contiguous ECX mask to verify that KVM ignores ECX.

The mentioned configuration is architecturally invalid and can be
ignored: if fixed counter 0 is supported (ECX[0] == 1), EDX[4:0] cannot
be zero.

Furthermore, verifying that KVM ignores ECX on pmu_version < 5 with
EDX[4:0] == 0 is already tested for all subsets where bit 0 is clear
(e.g. subsets 2, 4, 6), where find_first_zero_bit() returns 0 and the
guest explicitly asserts #GP.

> 
> In addition, gating X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK on
> pmu_version >= 5 skips non-contiguous host ECX bits when testing guest
> pmu_version < 5, so the test never verifies that KVM ignores those bits on
> older PMU versions.  Keeping the outer loop over j in 0..nr_fixed_counters
> and the inner loop over subsets of an unconditionally constructed
> fixed_bitmap would cover all (EDX[4:0], ECX) combinations across all PMU
> versions.
> 

The proposed nested loop produces massive duplication without covering
any new counter configurations.

In contrast, the current single loop exercises all 2^N unique subsets of
available counters exactly once with consistent EDX/ECX pairs, and the
second loop explicitly exercises legacy EDX-only enumeration (ECX = 0).

Therefore, I prefer to keep the current implementation.

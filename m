Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0363144D696;
	Thu, 30 Apr 2026 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777572795; cv=none; b=myEkdbCPRPo0T3XpetEIC9uCx5n/jpYt26LmXjYmAn4WDhRWhnS++4Uon80wgG4lUqhKUoag5wCQY/lBbw/4tomnmO0T8I2qJ6W1iufSzO9kZuCxogJ/ucBQSmD/Y4G6iM4lVTNWbqnBCXfwD8oTFDgqwH1Zq1tC/EJhuMBq4oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777572795; c=relaxed/simple;
	bh=LYB0vdSnmmgqu9vy8xbcoEteK3nJmODwR6e1NHMEEsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=do66Ur2cOMc/sOk27CYtgHdmDBA8sooIjVvqabars124wXoT4ulUtt/Vo0BHOoVyeiynp/CVHLIiYwHuHFZCGvmgna/3Ic+1HR8qBUhceit/4TZTwtoduneQaldYFiASSm0M6Do5kS9os9WjLvoE3ed6g45MCskr9deT61/ceNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exp7mjMZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exp7mjMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777572792; x=1809108792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LYB0vdSnmmgqu9vy8xbcoEteK3nJmODwR6e1NHMEEsA=;
  b=exp7mjMZEroncQA7eollEx9L21y1CERniFVpS4IF3sznaTHytPV9+EPB
   iOoEn8yE9ZqXTtwzcSAPlZfDM3S6wwp5dOh6ON38/Mfr2aO8fyrbUCfys
   vqoFB9Z+6+XtGxapkbXP/hd64L3gIkX1WUmNDbwYcAAx2NtQ/TlKTnsVC
   oY7eMpF4WgB951Gz4PsQrQ9BfPw5yNXAHlLlvKdMZq4ExtHpgh1J9FaWs
   PpgD8RFybYhsr6288eYKE0JiXSCYTJx3IESe5G1pLu85yxF/a0GVenrp+
   mHbMw8kJvR3VZIbSND/G2OLtiBnDbyEh1tAD+v96QWYmnbRZim/Y9ag+p
   A==;
X-CSE-ConnectionGUID: F5fS9BG0Q+mgSdSdXzk0LA==
X-CSE-MsgGUID: +nKyx/flTAKznBul3HpMmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="77700944"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="77700944"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 11:13:11 -0700
X-CSE-ConnectionGUID: 8tHonS9/TN21/xnsvyQf3w==
X-CSE-MsgGUID: va2wVeGrTcaYudrJRpq4BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239666918"
Received: from unknown (HELO [10.241.241.75]) ([10.241.241.75])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 11:13:10 -0700
Message-ID: <be178a25-8680-4b85-826a-8a15bf858c7e@intel.com>
Date: Thu, 30 Apr 2026 11:13:10 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 4/4] KVM: selftests: Add perf_metrics and fixed counter
 3 tests
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
 <20260423174639.56149-5-zide.chen@intel.com>
 <9bad0de9-18ab-422d-b020-9b08d8e10296@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <9bad0de9-18ab-422d-b020-9b08d8e10296@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/2026 7:26 PM, Mi, Dapeng wrote:
> 
> On 4/24/2026 1:46 AM, Zide Chen wrote:
>> Add a selftest to exercise IA32_PERF_METRICS, i.e. architectural
>> support for Topdown (TMA) Level 1 metrics, enumerated by
>> IA32_PERF_CAPABILITIES[15].
>>
>> Only check for non-zero metrics, as they are derived and depend on
>> the workload, CPU model, and host scheduling, making precise
>> expectations fragile.
>>
>> Extend the PMU selftest to cover Intel fixed counter 3 by bumping
>> MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V2: New patch.
>> ---
>>  tools/arch/x86/include/asm/msr-index.h        |  1 +
>>  tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
>>  .../selftests/kvm/x86/pmu_counters_test.c     | 71 +++++++++++++++++--
>>  3 files changed, 70 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
>> index 6673601246b3..31ecbea42459 100644
>> --- a/tools/arch/x86/include/asm/msr-index.h
>> +++ b/tools/arch/x86/include/asm/msr-index.h
>> @@ -331,6 +331,7 @@
>>  #define PERF_CAP_PEBS_FORMAT		0xf00
>>  #define PERF_CAP_FW_WRITES		BIT_ULL(13)
>>  #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
>> +#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
>>  #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
>>  #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>>  					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
>> diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
>> index 72575eadb63a..c68d6435422c 100644
>> --- a/tools/testing/selftests/kvm/include/x86/pmu.h
>> +++ b/tools/testing/selftests/kvm/include/x86/pmu.h
>> @@ -46,6 +46,9 @@
>>  /* Fixed PMC controls, Intel only. */
>>  #define FIXED_PMC_GLOBAL_CTRL_ENABLE(_idx)	BIT_ULL((32 + (_idx)))
>>  
>> +/* PERF_METRICS enable, Intel only. */
>> +#define PERF_METRICS_GLOBAL_CTRL_ENABLE		BIT_ULL(48)
>> +
>>  #define FIXED_PMC_KERNEL			BIT_ULL(0)
>>  #define FIXED_PMC_USER				BIT_ULL(1)
>>  #define FIXED_PMC_ANYTHREAD			BIT_ULL(2)
>> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> index 3eaa216b96c0..240bcf9184c2 100644
>> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
>> @@ -6,6 +6,7 @@
>>  
>>  #include "pmu.h"
>>  #include "processor.h"
>> +#include <linux/bitfield.h>
>>  
>>  /* Number of iterations of the loop for the guest measurement payload. */
>>  #define NUM_LOOPS			10
>> @@ -241,17 +242,20 @@ do {										\
>>  	);									\
>>  } while (0)
>>  
>> -#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
>> +#define GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP)				\
>>  do {										\
>> -	wrmsr(_pmc_msr, 0);							\
>> -										\
>>  	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
>>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt %[m]", FEP);	\
>>  	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
>>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush  %[m]", FEP);	\
>>  	else									\
>>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
>> -										\
>> +} while (0)
>> +
>> +#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
>> +do {										\
>> +	wrmsr(_pmc_msr, 0);							\
>> +	GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP);				\
>>  	guest_assert_event_count(_idx, _pmc, _pmc_msr);				\
>>  } while (0)
>>  
>> @@ -318,6 +322,55 @@ static void guest_test_arch_event(uint8_t idx)
>>  				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
>>  }
>>  
>> +static void guest_test_perf_metrics(void)
>> +{
>> +	int retiring, bad_spec, fe_bound, be_bound;
>> +	uint64_t global_ctrl, metrics;
>> +
>> +	if ((guest_get_pmu_version() < 2) ||	/* Does guest has GLOBAL_CTRL? */
>> +	    !this_cpu_has(X86_FEATURE_PDCM) ||
>> +	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
>> +		return;
>> +
>> +	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>> +	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
>> +	wrmsr(MSR_PERF_METRICS, 0);
>> +
>> +	/* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS . */
>> +	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
>> +	global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
>> +		      PERF_METRICS_GLOBAL_CTRL_ENABLE;
>> +
>> +	GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
>> +
>> +	/* Check test results. */
>> +	metrics = rdmsr(MSR_PERF_METRICS);
>> +	retiring = FIELD_GET(GENMASK_ULL(7, 0), metrics);
>> +	bad_spec = FIELD_GET(GENMASK_ULL(15, 8), metrics);
>> +	fe_bound = FIELD_GET(GENMASK_ULL(23, 16), metrics);
>> +	be_bound = FIELD_GET(GENMASK_ULL(31, 24), metrics);
>> +
>> +	/*
>> +	 * Be conservative: the measured payload definitely retires work, so
>> +	 * Retiring should be non-zero.
>> +	 */
>> +	GUEST_ASSERT_NE(metrics, 0ULL);
>> +	GUEST_ASSERT_NE(retiring, 0ULL);
>> +
>> +	/*
>> +	 * The derived percentage of the metrics should be close to 100%.
> 
> Better say "The sum of the 4 level-1 topdown metrics should be close to
> 100%" which is preciser.

Yes, thanks.
> 
> Thanks.
> 
> 
>> +	 * 3 is chosen as a loose sanity check.
>> +	 */
>> +	GUEST_ASSERT(abs(retiring + bad_spec + fe_bound + be_bound - 0xff) < 3);
>> +
>> +	/* Sanity check after PERF_METRICS disabled. */
>> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
>> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
>> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
>> +
>> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
>> +}
>> +
>>  static void guest_test_arch_events(void)
>>  {
>>  	uint8_t i;
>> @@ -325,6 +378,8 @@ static void guest_test_arch_events(void)
>>  	for (i = 0; i < NR_INTEL_ARCH_EVENTS; i++)
>>  		guest_test_arch_event(i);
>>  
>> +	guest_test_perf_metrics();
>> +
>>  	GUEST_DONE();
>>  }
>>  
>> @@ -361,7 +416,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
>>   * other than PMCs in the future.
>>   */
>>  #define MAX_NR_GP_COUNTERS	8
>> -#define MAX_NR_FIXED_COUNTERS	3
>> +#define MAX_NR_FIXED_COUNTERS	4
>>  
>>  #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
>>  __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
>> @@ -586,6 +641,7 @@ static void test_intel_counters(void)
>>  	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
>>  	uint8_t nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
>>  	uint8_t pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
>> +	uint64_t advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
>>  	unsigned int i;
>>  	uint8_t v, j;
>>  	uint32_t k;
>> @@ -593,6 +649,7 @@ static void test_intel_counters(void)
>>  	const uint64_t perf_caps[] = {
>>  		0,
>>  		PMU_CAP_FW_WRITES,
>> +		PERF_CAP_PERF_METRICS,
>>  	};
>>  
>>  	/*
>> @@ -650,6 +707,10 @@ static void test_intel_counters(void)
>>  			if (!kvm_has_perf_caps && perf_caps[i])
>>  				continue;
>>  
>> +			/* Ignore unsupported features. */
>> +			if (perf_caps[i] & ~advertised_perf_caps)
>> +				continue;
>> +
>>  			pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
>>  				v, perf_caps[i]);
>>  


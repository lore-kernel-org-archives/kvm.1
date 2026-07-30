Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C92370D5A;
	Thu, 30 Jul 2026 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380310; cv=none; b=tIlsOealUSIYMaYjiiaM0DtfA963jyPPNY5RvvrtPveXhCeEiNqo1BDL5WeMjLlQhZUE67PHKTQoBDq1r597pzhgEQgC1z+30uJ9R4RI3u7PJMxMismPB2xz55l8AuTtw5AMXXx9VXdOmhQ7jBJCPz+SfWlvq3C/di19+7ULx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380310; c=relaxed/simple;
	bh=SFSZE9BInnGnGyldACZ/gGg0XLDvlYC8EYZv62LThY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPpWb08p9krjr55l7B9KgEmJ/d30Tj+OFQ1ATFxMlXPl2qBOZt9PuQRxiT7bzgnETBbCH3/3D5bqWrohRx7G5pMaGKJhFFdGCe2jZnyXYx8EbxS/BXYz3IsKPiyn7qWDCo/2ZHxIrZINJm6qT3I8advesGC1xx22fXfTUXPWRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+UgZ/rg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+UgZ/rg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785380308; x=1816916308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SFSZE9BInnGnGyldACZ/gGg0XLDvlYC8EYZv62LThY8=;
  b=g+UgZ/rgT9Gp4ApS4n+C4P4QRveCDiPnPCBdct5KtX5btcn2Ki3XREBp
   zW10vGzN4vFkR3ZOzMCNF6BvuMJWlzRFBVKRtz3q8VNpbbKl/J+mAnODU
   4OQpiFLOJSugFblUTKULIYLqp9tK0xgrxJU9gHti94ljzW+DsgeTwtBbC
   gFTZy7Np9FSMzGu8yBTMKNLf4IRvV1gNoAcNJgVb3degQyeV0wLZ/SFDN
   yh1ibIce8MI9f7VxKyDlLO/iZvTi+K2upxUc1YsCgRywtiUygESKls4uv
   RkZNOrYQ8jfWjse8QMmMAf+sbHY5rFNs5pS3sBFw1peeZwqe3p/J2m0f9
   A==;
X-CSE-ConnectionGUID: 7boWRY5fSkqgUR/XV/TqSg==
X-CSE-MsgGUID: PBshuUZpTxeyoglwAfvSxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85848593"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85848593"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 19:58:28 -0700
X-CSE-ConnectionGUID: 6AbkIaqVTV6+pnw5fpZkJA==
X-CSE-MsgGUID: IRkXUrbHT/KbczQm3tuW3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="258942127"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.178]) ([10.124.241.178])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 19:58:25 -0700
Message-ID: <7cbed207-51f8-4707-b21c-432f49515aa5@linux.intel.com>
Date: Thu, 30 Jul 2026 10:58:22 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-10-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260727192131.582105-10-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 7/28/2026 3:21 AM, Zide Chen wrote:
> Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
> support for Topdown (TMA) Level 1 metrics, enumerated by
> IA32_PERF_CAPABILITIES[15].
>
> Only check for non-zero metrics, as they are derived and depend on
> the workload, CPU model, and host scheduling, making precise
> expectations fragile.
>
> Extend the PMU selftest to cover Intel fixed counter 3 by bumping
> MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v7:
> - Use RDPMC instead of RDMSR in PERF_METRICS sanity test.
> v6:
> - Move perf metrics test out of test_arch_events(); it doesn't belong
>   there, and this also avoids redundant runs of perf metrics test.
> - Correct the +/-3 error margin.
> v3:
> - Slightly reword comment to explain the sum of Topdown metrics
>   is close to 100%.
> - Change abs() with explicit bounds (sum >= 0xfd && sum <= 0x102)
>   for better readability.
> v2:
> - New patch.
> ---
>  tools/arch/x86/include/asm/msr-index.h        |  1 +
>  tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
>  .../selftests/kvm/x86/pmu_counters_test.c     | 94 ++++++++++++++++++-
>  3 files changed, 93 insertions(+), 5 deletions(-)
>
> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
> index eff29645719b..e7745e2cd543 100644
> --- a/tools/arch/x86/include/asm/msr-index.h
> +++ b/tools/arch/x86/include/asm/msr-index.h
> @@ -331,6 +331,7 @@
>  #define PERF_CAP_PEBS_FORMAT		0xf00
>  #define PERF_CAP_FW_WRITES		BIT_ULL(13)
>  #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
> +#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
>  #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
>  #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>  					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
> diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
> index 608ed83d7c6a..6c19503e0bb7 100644
> --- a/tools/testing/selftests/kvm/include/x86/pmu.h
> +++ b/tools/testing/selftests/kvm/include/x86/pmu.h
> @@ -52,6 +52,9 @@
>  /* Fixed PMC controls, Intel only. */
>  #define FIXED_PMC_GLOBAL_CTRL_ENABLE(_idx)	BIT_ULL((32 + (_idx)))
>  
> +/* PERF_METRICS enable, Intel only. */
> +#define PERF_METRICS_GLOBAL_CTRL_ENABLE		BIT_ULL(48)
> +
>  #define FIXED_PMC_KERNEL			BIT_ULL(0)
>  #define FIXED_PMC_USER				BIT_ULL(1)
>  #define FIXED_PMC_ANYTHREAD			BIT_ULL(2)
> diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> index dc6afac3aa91..8294a0089a85 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2023, Tencent, Inc.
>   */
>  #include <x86intrin.h>
> +#include <linux/bitfield.h>
>  
>  #include "pmu.h"
>  #include "processor.h"
> @@ -241,17 +242,20 @@ do {										\
>  	);									\
>  } while (0)
>  
> -#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
> +#define GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP)				\
>  do {										\
> -	wrmsr(_pmc_msr, 0);							\
> -										\
>  	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt %[m]", FEP);	\
>  	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush  %[m]", FEP);	\
>  	else									\
>  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
> -										\
> +} while (0)
> +
> +#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
> +do {										\
> +	wrmsr(_pmc_msr, 0);							\
> +	GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP);				\
>  	guest_assert_event_count(_idx, _pmc, _pmc_msr);				\
>  } while (0)
>  
> @@ -361,7 +365,7 @@ static void test_arch_events(u8 pmu_version, u64 perf_capabilities,
>   * other than PMCs in the future.
>   */
>  #define MAX_NR_GP_COUNTERS	8
> -#define MAX_NR_FIXED_COUNTERS	3
> +#define MAX_NR_FIXED_COUNTERS	4
>  
>  #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
>  __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
> @@ -580,11 +584,81 @@ static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities,
>  	kvm_vm_free(vm);
>  }
>  
> +static void __guest_test_perf_metrics(void)
> +{
> +	int retiring, bad_spec, fe_bound, be_bound, sum;
> +	u64 global_ctrl, metrics;
> +
> +	if ((guest_get_pmu_version() < 2) ||	/* Does guest have GLOBAL_CTRL? */
> +	    !this_cpu_has(X86_FEATURE_PDCM) ||
> +	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
> +		return;
> +
> +	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
> +	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
> +	wrmsr(MSR_PERF_METRICS, 0);
> +
> +	/* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
> +	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
> +	global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
> +		      PERF_METRICS_GLOBAL_CTRL_ENABLE;
> +
> +	GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
> +
> +	/* Check test results. */
> +	metrics = rdmsr(MSR_PERF_METRICS);
> +	retiring = FIELD_GET(GENMASK_ULL(7, 0), metrics);
> +	bad_spec = FIELD_GET(GENMASK_ULL(15, 8), metrics);
> +	fe_bound = FIELD_GET(GENMASK_ULL(23, 16), metrics);
> +	be_bound = FIELD_GET(GENMASK_ULL(31, 24), metrics);
> +
> +	/*
> +	 * Be conservative: the measured payload definitely retires work, so
> +	 * Retiring should be non-zero.
> +	 */
> +	GUEST_ASSERT_NE(metrics, 0ULL);
> +	GUEST_ASSERT_NE(retiring, 0ULL);
> +
> +	/*
> +	 * Each level-1 Topdown metric is an integer fraction of 0xff.
> +	 * A +/-3 error margin is chosen for a loose sanity check.
> +	 */
> +	sum = retiring + bad_spec + fe_bound + be_bound;
> +	GUEST_ASSERT(sum >= 0xfc && sum <= 0x102);
> +
> +	/* Sanity check after PERF_METRICS disabled. */
> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
> +
> +	guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0xdeaddead);
> +}
> +
> +static void guest_test_perf_metrics(void)
> +{
> +	__guest_test_perf_metrics();
> +	GUEST_DONE();
> +}
> +
> +static void test_perf_metrics(u8 pmu_version, u64 perf_capabilities)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +
> +	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_perf_metrics,
> +					 pmu_version, perf_capabilities);
> +
> +	run_vcpu(vcpu);
> +
> +	kvm_vm_free(vm);
> +}
> +
>  static void test_intel_counters(void)
>  {
>  	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
>  	u8 nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
>  	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
> +	u64 advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
>  	unsigned int i;
>  	u8 v, j;
>  	u32 k;
> @@ -592,6 +666,7 @@ static void test_intel_counters(void)
>  	const u64 perf_caps[] = {
>  		0,
>  		PMU_CAP_FW_WRITES,
> +		PERF_CAP_PERF_METRICS,
>  	};
>  
>  	/*
> @@ -649,6 +724,10 @@ static void test_intel_counters(void)
>  			if (!kvm_has_perf_caps && perf_caps[i])
>  				continue;
>  
> +			/* Ignore unsupported features. */
> +			if (perf_caps[i] & ~advertised_perf_caps)
> +				continue;
> +
>  			pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
>  				v, perf_caps[i]);
>  
> @@ -675,6 +754,11 @@ static void test_intel_counters(void)
>  				for (k = 0; k <= (BIT(nr_fixed_counters) - 1); k++)
>  					test_fixed_counters(v, perf_caps[i], j, k);
>  			}
> +
> +			pr_info("Testing Perf Metrics, PMU version %u, perf_caps = %lx\n",
> +				v, perf_caps[i]);
> +
> +			test_perf_metrics(v, perf_caps[i]);
>  		}
>  	}
>  }

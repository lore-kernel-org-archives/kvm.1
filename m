Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF5155C97;
	Tue, 30 Jun 2026 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782786994; cv=none; b=PgwSy0jQeUM/CRsEzTsh5sfbpTQufru9KYR1s55jWIeVeTGokt20WQlJG1Ihrccq2MKQkw0WBaDgeuHNDkAy75nV48U/ZMc/0i6AYwB4eTIcAApAh/dLKdmdphFtKNBET18HlAGgK6/PONw60ERlDgkdBguoXzCNFZC/9x2Cvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782786994; c=relaxed/simple;
	bh=A2N5dSL3qiC+CBCOQ1H/7ajXE/VuN6GehE79ahZvMKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTOHRKyJbJPKxbuLYYZS9mb46uH+8v3k+omdvFJRDXeWhhoMEyN85PA36jEq5zLucEfShtLz4o8jdrNWDIx60yGeXXotjgCSHHlKVd3QsrPINAd3RLAEQgBavYaMdZhINP5uANwyv2xZykJuQ9m4vGQZUgxorLsaeCam7sqRoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U22l5Ytr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U22l5Ytr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782786992; x=1814322992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2N5dSL3qiC+CBCOQ1H/7ajXE/VuN6GehE79ahZvMKA=;
  b=U22l5YtrkRBOSb2O5knunOCbgmoetbV1eIS9EulAHPQqMiaRN+/RRvd9
   6A/Qa0KF4UemojJaqs3fSrk1EltReT8vJL/7dxBcklIk8kRdYf9JZW8hU
   yEnQ0hbUErc3wPtu85Pakeb9ajhgt3XxCs0QeHkRT6oLxsJfi2PS4EIXY
   5Nxzsah4jAYAssULSP0LLcnf5/F56a4WI4KlpEgZyAku+dvnIIiGDXmVz
   Ps0JDPrY9jx5FuvfYtS6e3kCEB9hEZP1kO2diTYdZk3kX0ZVciUkYM6n8
   PSu04VObajb4yZhV0CmGydtuSyWPCTxGfNfCmjfVsOI7SIWHTXJed7/E7
   Q==;
X-CSE-ConnectionGUID: zF9gD1zmTJCkwPU9AUhemg==
X-CSE-MsgGUID: sEBqk87TRQCwh1yxRMVLhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="82603120"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="82603120"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:36:31 -0700
X-CSE-ConnectionGUID: ETpu95hOQ+mqwlwijdY9bg==
X-CSE-MsgGUID: h0tbFZYKSC6Z/SCc5hdaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="245785949"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:36:29 -0700
Message-ID: <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com>
Date: Tue, 30 Jun 2026 10:36:26 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-9-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260629231938.15129-9-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/30/2026 7:19 AM, Zide Chen wrote:
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
> v6:
> - Move perf metrics test out of test_arch_events(); it doesn't belong
>   there, and this also avoids redundant runs of perf metrics test.
> - Correct the +/-3 error margin.
> v3:
> - Slightly reword comment to explain the sum of topdown metrics
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
> index dc6afac3aa91..38057754e024 100644
> --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> @@ -6,6 +6,7 @@
>  
>  #include "pmu.h"
>  #include "processor.h"
> +#include <linux/bitfield.h>
>  
>  /* Number of iterations of the loop for the guest measurement payload. */
>  #define NUM_LOOPS			10
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
> @@ -318,6 +322,75 @@ static void guest_test_arch_event(u8 idx)
>  				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
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

Could we use rdpmc instead of rdmsr here? rdpmc is a preferred way to read
counter value.


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
> +	 * Each level-1 topdown metrics is an integer fraction of 255.
> +	 * An +/-3 error margin is chosen for a loose sanity check.
> +	 */
> +	sum = retiring + bad_spec + fe_bound + be_bound;
> +	GUEST_ASSERT(sum >= 0xfc && sum <= 0x102);
> +
> +	/* Sanity check after PERF_METRICS disabled. */
> +	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);

Better rdpmc as well here.

> +	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
> +
> +	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);

We can still use rdmsr here, then rdpmc and wrmsr/rdmsr for PERF_METRICS
are all validated. 

Thanks.


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
>  static void guest_test_arch_events(void)
>  {
>  	u8 i;
> @@ -361,7 +434,7 @@ static void test_arch_events(u8 pmu_version, u64 perf_capabilities,
>   * other than PMCs in the future.
>   */
>  #define MAX_NR_GP_COUNTERS	8
> -#define MAX_NR_FIXED_COUNTERS	3
> +#define MAX_NR_FIXED_COUNTERS	4
>  
>  #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
>  __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
> @@ -585,6 +658,7 @@ static void test_intel_counters(void)
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

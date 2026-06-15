Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7F3BFE3A;
	Mon, 15 Jun 2026 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565016; cv=none; b=LDn8WCbKvrkpA8yaF7KrdZ9FmMaG9oReuEqHyikBw2GMthbJZelqPd5MOwDf1W9NIzWuxSiCM1K68u7uj3rHwtxj21npPlV16WhZyBnHfCDMV+DyanHHm8syMaAcCa/x1sI9Zu31x2nzKNzSkpEmKa06c1ENKLjlkblVfLytrXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565016; c=relaxed/simple;
	bh=Hx7BNwD2GIEFBYxeKQ5msWLCZhL6lQHoZdWJ0g1xYmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwPnyV3Fjzvgpx5QxZKWXfia+Bie5UJFJL1MN0FOLYc5rOXjU5YLCw6lwS6FRRGzfBpdpdxZnDPj22OTpodm5IjKAOkMraTGuPKz2xsMhihU237JvkH+fAFN4vNueYfSMV2UuLnK/IvI0WDiO/YSIWdZ6NsmhMhbHIPEXg4zn/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvYNcJNz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvYNcJNz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781565012; x=1813101012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hx7BNwD2GIEFBYxeKQ5msWLCZhL6lQHoZdWJ0g1xYmM=;
  b=IvYNcJNzlxgQAk1fRbdnKuXjcB5AO7gTwlV+/6z6413umaMa7VmbI+3D
   JYfML4VsV8MmTjYWIOP3n6wdRFOmaA24kjJU/51+tb/ah/2Hj4zE0dlvC
   oZrv1zO+Mce9eCCOb9h4Qg8XizTwGh3mqBZR6MvC8sbnSpQjb8aLkkP/r
   xyrHA24COvX+GFdVsP9cwtIWIO2ePb9xi0C282bAIa1lSxybtufWjRVnC
   K17iZKJPRtPGyh8jEKu76oIqB+zVDewmleyKNOn958z3gNV+ZSxq7wHmh
   0nqEW/TqsowSSEYFtDry2gjviuRqx5JvpCr837PZmOFpmDZvQKi2jMf2O
   g==;
X-CSE-ConnectionGUID: CpeLAbwTQ8y4PVwr6jmtWA==
X-CSE-MsgGUID: r/naJvBFSOyU4V1YXehemg==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99738608"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="99738608"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 16:10:08 -0700
X-CSE-ConnectionGUID: 7KbJBpeVTuC3RQAqCPi0Sw==
X-CSE-MsgGUID: 2lFOpIyyRoCtBW7uR+7rQw==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 16:10:07 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH V3 4/4] KVM: selftests: Add perf_metrics and fixed counter 3 tests
Date: Mon, 15 Jun 2026 16:01:18 -0700
Message-ID: <20260615230118.50718-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615230118.50718-1-zide.chen@intel.com>
References: <20260615230118.50718-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to exercise IA32_PERF_METRICS, i.e. architectural
support for Topdown (TMA) Level 1 metrics, enumerated by
IA32_PERF_CAPABILITIES[15].

Only check for non-zero metrics, as they are derived and depend on
the workload, CPU model, and host scheduling, making precise
expectations fragile.

Extend the PMU selftest to cover Intel fixed counter 3 by bumping
MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Slightly reword comment to explain the sum of topdown metrics
  is close to 100%.
- Change abs() with explicit bounds (sum >= 0xfd && sum <= 0x102)
  for better readability.
v2:
- New patch.
---
---
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 72 +++++++++++++++++--
 3 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index eff29645719b..e7745e2cd543 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -331,6 +331,7 @@
 #define PERF_CAP_PEBS_FORMAT		0xf00
 #define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 608ed83d7c6a..6c19503e0bb7 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -52,6 +52,9 @@
 /* Fixed PMC controls, Intel only. */
 #define FIXED_PMC_GLOBAL_CTRL_ENABLE(_idx)	BIT_ULL((32 + (_idx)))
 
+/* PERF_METRICS enable, Intel only. */
+#define PERF_METRICS_GLOBAL_CTRL_ENABLE		BIT_ULL(48)
+
 #define FIXED_PMC_KERNEL			BIT_ULL(0)
 #define FIXED_PMC_USER				BIT_ULL(1)
 #define FIXED_PMC_ANYTHREAD			BIT_ULL(2)
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index dc6afac3aa91..d4688a7d1e55 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -6,6 +6,7 @@
 
 #include "pmu.h"
 #include "processor.h"
+#include <linux/bitfield.h>
 
 /* Number of iterations of the loop for the guest measurement payload. */
 #define NUM_LOOPS			10
@@ -241,17 +242,20 @@ do {										\
 	);									\
 } while (0)
 
-#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
+#define GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP)				\
 do {										\
-	wrmsr(_pmc_msr, 0);							\
-										\
 	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
 		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt %[m]", FEP);	\
 	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
 		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush  %[m]", FEP);	\
 	else									\
 		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
-										\
+} while (0)
+
+#define GUEST_TEST_EVENT(_idx, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)		\
+do {										\
+	wrmsr(_pmc_msr, 0);							\
+	GUEST_RUN_PAYLOAD(_ctrl_msr, _value, FEP);				\
 	guest_assert_event_count(_idx, _pmc, _pmc_msr);				\
 } while (0)
 
@@ -318,6 +322,56 @@ static void guest_test_arch_event(u8 idx)
 				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
 }
 
+static void guest_test_perf_metrics(void)
+{
+	int retiring, bad_spec, fe_bound, be_bound, sum;
+	u64 global_ctrl, metrics;
+
+	if ((guest_get_pmu_version() < 2) ||	/* Does guest have GLOBAL_CTRL? */
+	    !this_cpu_has(X86_FEATURE_PDCM) ||
+	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
+		return;
+
+	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
+	wrmsr(MSR_PERF_METRICS, 0);
+
+	/* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS. */
+	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(3, FIXED_PMC_KERNEL));
+	global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(3) |
+		      PERF_METRICS_GLOBAL_CTRL_ENABLE;
+
+	GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "");
+
+	/* Check test results. */
+	metrics = rdmsr(MSR_PERF_METRICS);
+	retiring = FIELD_GET(GENMASK_ULL(7, 0), metrics);
+	bad_spec = FIELD_GET(GENMASK_ULL(15, 8), metrics);
+	fe_bound = FIELD_GET(GENMASK_ULL(23, 16), metrics);
+	be_bound = FIELD_GET(GENMASK_ULL(31, 24), metrics);
+
+	/*
+	 * Be conservative: the measured payload definitely retires work, so
+	 * Retiring should be non-zero.
+	 */
+	GUEST_ASSERT_NE(metrics, 0ULL);
+	GUEST_ASSERT_NE(retiring, 0ULL);
+
+	/*
+	 * The sum of the 4 level-1 topdown metrics should be close to 100%.
+	 * 3 is chosen as a loose sanity check.
+	 */
+	sum = retiring + bad_spec + fe_bound + be_bound;
+	GUEST_ASSERT(sum >= 0xfd && sum <= 0x102);
+
+	/* Sanity check after PERF_METRICS disabled. */
+	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
+	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
+
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0xdeaddead);
+}
+
 static void guest_test_arch_events(void)
 {
 	u8 i;
@@ -325,6 +379,8 @@ static void guest_test_arch_events(void)
 	for (i = 0; i < NR_INTEL_ARCH_EVENTS; i++)
 		guest_test_arch_event(i);
 
+	guest_test_perf_metrics();
+
 	GUEST_DONE();
 }
 
@@ -361,7 +417,7 @@ static void test_arch_events(u8 pmu_version, u64 perf_capabilities,
  * other than PMCs in the future.
  */
 #define MAX_NR_GP_COUNTERS	8
-#define MAX_NR_FIXED_COUNTERS	3
+#define MAX_NR_FIXED_COUNTERS	4
 
 #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
 __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
@@ -585,6 +641,7 @@ static void test_intel_counters(void)
 	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
 	u8 nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
+	u64 advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
 	unsigned int i;
 	u8 v, j;
 	u32 k;
@@ -592,6 +649,7 @@ static void test_intel_counters(void)
 	const u64 perf_caps[] = {
 		0,
 		PMU_CAP_FW_WRITES,
+		PERF_CAP_PERF_METRICS,
 	};
 
 	/*
@@ -649,6 +707,10 @@ static void test_intel_counters(void)
 			if (!kvm_has_perf_caps && perf_caps[i])
 				continue;
 
+			/* Ignore unsupported features. */
+			if (perf_caps[i] & ~advertised_perf_caps)
+				continue;
+
 			pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
 				v, perf_caps[i]);
 
-- 
2.54.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AB93A9DB3;
	Thu, 23 Apr 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966903; cv=none; b=DQ/M6gUomtOwhjVzS15fAWeYG8nlH9hWxTpSStkRpSlAhiCvcIJI3eR9W0mo8raOvVcREdKxTrP/kl3ys8hOoYPHdje9sCB+smkgCTykDnQMPgjC9x4Lc5nEOKbB3hcRDxN11WqwvdcxX+3VjC07OqmZ3AoCTxcBvenGSCvVL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966903; c=relaxed/simple;
	bh=i7avbi1uvlc9L9M2IKksxrQMDJjQz1WSwyRlhlyRXk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYR1E5TY7D4tTLdzA1HQ6NdaanxwEK22rXrJ1fGQx9BTVNk98LHlIkBtjn5hGaSr2gaSYMk6BduAuB4vv38grMExxIsC2e4egTftvYmP6mR2ili1l94Q28OLOZ643Jo0jhPro95h9wZwFBJQbZw0gTkXTKySHXH8jFFQIYdpt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y7D+2N0G; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y7D+2N0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966902; x=1808502902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i7avbi1uvlc9L9M2IKksxrQMDJjQz1WSwyRlhlyRXk8=;
  b=Y7D+2N0Gf6YDZSB7gC0GEVVn6HOdSIUW0lMdQY8SHCEmeNEPSROYJiQR
   IjkVPanOeUKpjjFqxbYrmHwIzl+L1Qnc9zwRhlsbbjFG33qGH1Zc0NCm5
   sg9QjXghvAV2uQVQva8ar83b5iHh5NuV0vJWYkR78I1jaLD28jj8n4Mu3
   Kpt9NN+rJaMN5UZYTCoVhKFzUs+pIFKTFvlsigqdclTG4srWsUnOFmeDf
   lHV31sUy29nMUGnGuJXRzoM9dLCP9LygJlEoUPlIYswDPss526eXHH8cV
   QGObo+xSREC5bgTgFucCY96jfETEh/6OXClPQ5YZNfhKJkrP8Z0HpzWus
   Q==;
X-CSE-ConnectionGUID: DK6qrNN+So22gEem1YE4Cw==
X-CSE-MsgGUID: 1loK7RX+QySRIj+GLKlfVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="89407722"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="89407722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
X-CSE-ConnectionGUID: Q8C6cMZgQhWXiVgzTv5A3g==
X-CSE-MsgGUID: amTDkEoUQ5KbHVimlj8L/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="236707820"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:54:57 -0700
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
Subject: [PATCH V2 4/4] KVM: selftests: Add perf_metrics and fixed counter 3 tests
Date: Thu, 23 Apr 2026 10:46:39 -0700
Message-ID: <20260423174639.56149-5-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423174639.56149-1-zide.chen@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
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
V2: New patch.
---
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 71 +++++++++++++++++--
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 6673601246b3..31ecbea42459 100644
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
index 72575eadb63a..c68d6435422c 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -46,6 +46,9 @@
 /* Fixed PMC controls, Intel only. */
 #define FIXED_PMC_GLOBAL_CTRL_ENABLE(_idx)	BIT_ULL((32 + (_idx)))
 
+/* PERF_METRICS enable, Intel only. */
+#define PERF_METRICS_GLOBAL_CTRL_ENABLE		BIT_ULL(48)
+
 #define FIXED_PMC_KERNEL			BIT_ULL(0)
 #define FIXED_PMC_USER				BIT_ULL(1)
 #define FIXED_PMC_ANYTHREAD			BIT_ULL(2)
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index 3eaa216b96c0..240bcf9184c2 100644
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
 
@@ -318,6 +322,55 @@ static void guest_test_arch_event(uint8_t idx)
 				FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
 }
 
+static void guest_test_perf_metrics(void)
+{
+	int retiring, bad_spec, fe_bound, be_bound;
+	uint64_t global_ctrl, metrics;
+
+	if ((guest_get_pmu_version() < 2) ||	/* Does guest has GLOBAL_CTRL? */
+	    !this_cpu_has(X86_FEATURE_PDCM) ||
+	    !(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
+		return;
+
+	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
+	wrmsr(MSR_PERF_METRICS, 0);
+
+	/* Enable fixed ctr3 (TOPDOWN.SLOTS) and PERF_METRICS . */
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
+	 * The derived percentage of the metrics should be close to 100%.
+	 * 3 is chosen as a loose sanity check.
+	 */
+	GUEST_ASSERT(abs(retiring + bad_spec + fe_bound + be_bound - 0xff) < 3);
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
 	uint8_t i;
@@ -325,6 +378,8 @@ static void guest_test_arch_events(void)
 	for (i = 0; i < NR_INTEL_ARCH_EVENTS; i++)
 		guest_test_arch_event(i);
 
+	guest_test_perf_metrics();
+
 	GUEST_DONE();
 }
 
@@ -361,7 +416,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
  * other than PMCs in the future.
  */
 #define MAX_NR_GP_COUNTERS	8
-#define MAX_NR_FIXED_COUNTERS	3
+#define MAX_NR_FIXED_COUNTERS	4
 
 #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
 __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
@@ -586,6 +641,7 @@ static void test_intel_counters(void)
 	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
 	uint8_t nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
 	uint8_t pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
+	uint64_t advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
 	unsigned int i;
 	uint8_t v, j;
 	uint32_t k;
@@ -593,6 +649,7 @@ static void test_intel_counters(void)
 	const uint64_t perf_caps[] = {
 		0,
 		PMU_CAP_FW_WRITES,
+		PERF_CAP_PERF_METRICS,
 	};
 
 	/*
@@ -650,6 +707,10 @@ static void test_intel_counters(void)
 			if (!kvm_has_perf_caps && perf_caps[i])
 				continue;
 
+			/* Ignore unsupported features. */
+			if (perf_caps[i] & ~advertised_perf_caps)
+				continue;
+
 			pr_info("Testing arch events, PMU version %u, perf_caps = %lx\n",
 				v, perf_caps[i]);
 
-- 
2.53.0


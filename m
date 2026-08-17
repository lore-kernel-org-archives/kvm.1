Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62D646D2CE;
	Mon, 17 Aug 2026 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992093; cv=none; b=XUZJgANmbxKrS+6wGPmNbYsWvem3qPtTsP84gsnexK015FlYbBRwu5zkDGLR0UZ4WHbOrmq2J4lEA0yIZM4tetXVocBNbEXHXwLbJgxB2xeoHftd0XgRUNEgiQWl29GNkM7OTtFchYxZMcp17q7XjvXvy+E9oNghzfdA1AfIWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992093; c=relaxed/simple;
	bh=CA2oEWXAGzXMaflBM9URHLErnrCMESPPejAA4r7Xsuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY7Ut8D8sEaUoHnlMTcBvFbvhLc1QJ631zx3GWdtpTPZeJEV5ZrHvmmG9vwf9N0pUWn93N/rDvyGV6MdIup1o3BnpM8cXuvHiezoN03Mz2fBRYjKJrzsF8yjh52SweJWpblHIpaN7vRIj77CYvYy0cl3d3RgzSoeWrS5RbJr/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAhoPCPN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAhoPCPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786992092; x=1818528092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CA2oEWXAGzXMaflBM9URHLErnrCMESPPejAA4r7Xsuw=;
  b=eAhoPCPN4+vwGvJfu+A0KqQBv1D+mGwhIu8CvWC8Qa94N7VJvsdsU0KF
   owcpVEF7+eONkaRBcwRpT8Ow8tS1ObYdusy9Agx9c8vxI8c0p36NxzQ4U
   bqad8Ak33vltnMPZrLoJIx4BxNgZrhUCvv4Rqc/8/JKlh+vAVO9r8J6Tx
   SjAZSnDSpptbkQeap5QayKBQuTdAIw98hWo25i3YYnKxuHu+VZgQ+0Xb2
   kyxorNvlrVBfxMusBF3XK/ITHHh96HlGZZ6jTEW9gJpr/6u9GiRG3emMN
   CITAkOdzYSxaAE1RNlH3Ue1GHr7Jjl28LkOuOQg+E66XoRPUVhtSW9gAz
   A==;
X-CSE-ConnectionGUID: 7Cc6tlBETQeXZeDjbaEI5Q==
X-CSE-MsgGUID: AVcHZ10PSk2wzsPPE68Z2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="98066102"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="98066102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:25 -0700
X-CSE-ConnectionGUID: kCJeJ5KhQ6WjzomJwDr6cA==
X-CSE-MsgGUID: 52ZH8L2RR8C4hw7nvvYYFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263656978"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 11:41:24 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v8 8/8] KVM: selftests: Add PERF_METRICS and fixed counter 3 tests
Date: Mon, 17 Aug 2026 11:31:42 -0700
Message-ID: <20260817183143.226156-9-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817183143.226156-1-zide.chen@intel.com>
References: <20260817183143.226156-1-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to exercise IA32_PERF_METRICS, i.e. architectural
support for Topdown (TMA) Level 1 metrics, enumerated by
IA32_PERF_CAPABILITIES[15].

Only check for non-zero metrics, as they are derived and depend on
the workload, CPU model, and host scheduling, making precise
expectations fragile.

Extend the PMU selftest to cover Intel fixed counter 3 by bumping
MAX_NR_FIXED_COUNTERS to 4 and validating basic functionality.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
v7:
- Use RDPMC instead of RDMSR in PERF_METRICS sanity test.
v6:
- Move perf metrics test out of test_arch_events(); it doesn't belong
  there, and this also avoids redundant runs of perf metrics test.
- Correct the +/-3 error margin.
v3:
- Slightly reword comment to explain the sum of Topdown metrics
  is close to 100%.
- Change abs() with explicit bounds (sum >= 0xfd && sum <= 0x102)
  for better readability.
v2:
- New patch.
---
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 93 ++++++++++++++++++-
 3 files changed, 92 insertions(+), 5 deletions(-)

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
index c3e784e16348..5abcf21d8612 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2023, Tencent, Inc.
  */
 #include <x86intrin.h>
+#include <linux/bitfield.h>
 
 #include "pmu.h"
 #include "processor.h"
@@ -254,17 +255,20 @@ do {										\
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
 
@@ -412,7 +416,7 @@ static void test_arch_events(u8 pmu_version, u64 perf_capabilities)
  * other than PMCs in the future.
  */
 #define MAX_NR_GP_COUNTERS	8
-#define MAX_NR_FIXED_COUNTERS	3
+#define MAX_NR_FIXED_COUNTERS	4
 
 #define GUEST_ASSERT_PMC_MSR_ACCESS(insn, msr, expect_gp, vector)		\
 __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
@@ -653,8 +657,81 @@ static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
 	pmu_vm_free(vm, vcpus);
 }
 
+static void __guest_test_perf_metrics(void)
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
+	GUEST_ASSERT_NE(metrics, 0);
+	GUEST_ASSERT_NE(retiring, 0);
+
+	/*
+	 * Each level-1 Topdown metric is an integer fraction of 0xff.
+	 * A +/-3 error margin is chosen for a loose sanity check.
+	 */
+	sum = retiring + bad_spec + fe_bound + be_bound;
+	GUEST_ASSERT(sum >= 0xfc && sum <= 0x102);
+
+	/* Sanity check after PERF_METRICS disabled. */
+	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
+	wrmsr(MSR_PERF_METRICS, 0xdeaddead);
+
+	guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0xdeaddead);
+}
+
+static void guest_test_perf_metrics(void)
+{
+	__guest_test_perf_metrics();
+	GUEST_DONE();
+}
+
+static void test_perf_metrics(u8 pmu_version, u64 perf_capabilities)
+{
+	struct kvm_vcpu **vcpus;
+	struct kvm_vm *vm;
+
+	pr_info("Testing Perf Metrics, PMU version %u, perf_caps = %lx\n",
+		pmu_version, perf_capabilities);
+
+	vm = pmu_vm_create_with_vcpus(1, guest_test_perf_metrics,
+				      pmu_version, perf_capabilities, &vcpus);
+
+	run_vcpu(vcpus[0]);
+
+	pmu_vm_free(vm, vcpus);
+}
+
 static void test_intel_counters(void)
 {
+	u64 advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
 	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
 	unsigned int i;
 	u8 v;
@@ -662,6 +739,7 @@ static void test_intel_counters(void)
 	const u64 perf_caps[] = {
 		0,
 		PMU_CAP_FW_WRITES,
+		PERF_CAP_PERF_METRICS,
 	};
 
 	/*
@@ -699,9 +777,14 @@ static void test_intel_counters(void)
 			if (!kvm_has_perf_caps && perf_caps[i])
 				continue;
 
+			/* Ignore unsupported features. */
+			if (perf_caps[i] & ~advertised_perf_caps)
+				continue;
+
 			test_arch_events(v, perf_caps[i]);
 			test_gp_counters(v, perf_caps[i]);
 			test_fixed_counters(v, perf_caps[i]);
+			test_perf_metrics(v, perf_caps[i]);
 		}
 	}
 }
-- 
2.55.0


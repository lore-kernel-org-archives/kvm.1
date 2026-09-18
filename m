Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947F0522EF2;
	Fri, 18 Sep 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761017; cv=none; b=b0ESNvTaeeIt+raYCX2hK8BJKmO4aIX3EnDSLDVmWr+j6Ko1UsNnlAFOlCHC2BCvIvT8K6sKOhVbvMfanGuWqKhxPgmVq5jkRBbqHeugG9vkYbaeUv14WmMGTjM7VndAq8mHv6Vyrz91/iiyOOZ4oHZ5rFW/c6RQy+XBlPF4uYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761017; c=relaxed/simple;
	bh=aIIrGDZ4sE5rICzp3juJdv95tEjqoHLPN6GA1Qhh7AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qwa3VXPChvyn78L0TZBByrFtqDahdlXsbDpfYmJO8phEdwnVKsKZdrg/Na1/cDtRLPhwlciTgjy5eG4Z21y2GUUE5JEFzsKlu9qe4/CZc1LLK69okr1oWUjKNI2uI62exomPxOQzaUj8+A51uhnfa/Jh0PfD605mjg8nFWwmnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjsIv09s; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjsIv09s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789761007; x=1821297007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aIIrGDZ4sE5rICzp3juJdv95tEjqoHLPN6GA1Qhh7AI=;
  b=bjsIv09sLcG5OMyfXnMKx6mQnThctNsbRkKcilXUb9HSjziNZYI8UiBv
   gMbHnMkAECHZCJag1+00atbLW/MvsGiLKPRJgO4OmdAghM7BQAuFMFXCu
   eeNrRHdS2nQxCUTaRJ+NbL3mlWGy/Td5brbv4zc+at0OnvYMRHpiWo/de
   CWOzlzez+Ba+BiOwCXPMoqQkjs3M8W7U+8uM9S0/HlTaazyE/Cj2pALMa
   a0Wwki3qfiAUXJIGhSn63l35wkpixpWCXSVmMf54rXWuVDdU7wWsULgix
   +L+KgjXY4SaSY4jAbzSERXmfitGuOuw25ZKVZRPVZOnkwDiG16bT/qllb
   w==;
X-CSE-ConnectionGUID: 53TQzWJoT4iWwnVg+6a/SA==
X-CSE-MsgGUID: GH4oM1BKThmfnQx0EEHuSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="790327"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="790327"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
X-CSE-ConnectionGUID: fCgV7BAnQPyA5o9/rKMjTA==
X-CSE-MsgGUID: OexmLlwxRgSn7HxtRKncEQ==
X-ExtLoop1: 1
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 12:50:00 -0700
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v9 08/12] KVM: selftests: Add PERF_METRICS and fixed counter 3 tests
Date: Fri, 18 Sep 2026 12:39:33 -0700
Message-ID: <20260918193937.569414-9-zide.chen@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918193937.569414-1-zide.chen@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
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
---
 tools/arch/x86/include/asm/msr-index.h        |  1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |  3 +
 .../selftests/kvm/x86/pmu_counters_test.c     | 97 ++++++++++++++++++-
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 18c4be75e927..fdcaeb6c8352 100644
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
index c3e784e16348..cf09b587a4ac 100644
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
@@ -653,8 +657,85 @@ static void test_fixed_counters(u8 pmu_version, u64 perf_capabilities)
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
+	/*
+	 * Burn some cycles; MSR_CORE_PERF_GLOBAL_CTRL is left zeroed after
+	 * GUEST_RUN_PAYLOAD() returns, so PERF_METRICS is not counting.
+	 */
+	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
+	/* Confirm PERF_METRICS did not advance while counting was disabled. */
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
@@ -662,6 +743,7 @@ static void test_intel_counters(void)
 	const u64 perf_caps[] = {
 		0,
 		PMU_CAP_FW_WRITES,
+		PERF_CAP_PERF_METRICS,
 	};
 
 	/*
@@ -699,9 +781,14 @@ static void test_intel_counters(void)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557216;
	b=GUy8KZgkiX0DVqhhlfJwDZ9XfJBBuauH8K1qHgxgalNeJZT0TiC35v1XQGmSEm9L+9oY
	 xPMTy5x5ZOBZt4Hc4508hadQ8aqLpalBTJkMajsMlEYDhdFcbmvb0T2nsGyaKpq1aYf8F
	 ofFYOdDTRxPGxCCvcKcjsKXoYZS1dFJMQviT9OkV8UfHdGBR1nqrY8fFIJMRCBQ/VNERj
	 oKxD0GE+De+WsO8B8lLT0xQmDnKdSvhsxSeBJdy8go/OgGXXa1xivQGsMqIP6QXAAKTs4
	 uTiH5ysvZZC/mu34JCyyk6b8FzfUTJGexFJc7ZkQfblaksq8sJ2h5IiDuUyyzKRhWnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557216;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yw8NPBf5o6liEKlFfs2dKNQyQpy6PgTm37JcdYlh50o=;
	b=Lc/HSayDTF6EtJz3NEyDLk6wtKQF+5KGnhLbWykhmU47sOmsCYHjLXvp4VT8UgfBaIgx
	 znobUz8bqZKbMgdFPA8QZZ09znmqo+sz2idpFsINrTOuGZi2PKOVDzmyMayDAW9TMLHAt
	 7wNXDgWC9n6cY7GdhEVyEF0gtIO7O1ga0Z75Gd2fo0EcNJQL/5c80/QOzN0Wodejo1j4j
	 k7adBzljl8HSQp6PuNHZQ3nCNK+fF+jgXgFbhHRHfqJyqT/jeh63b4XfiA0rsvAcOk2w1
	 dhq+BrEKqQzzo/znldilRwy7VLDhiuK1gdJVMGAmdq329Ru+Akj/CF5bGswnhEBjpiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hPTcKmEg;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7960A6F61;
	Tue, 24 Nov 2026 21:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91E7960A6F61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hPTcKmEg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795557214; x=1827093214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yjumPIyRQytSNbgIsQv4L2h2dgCrn8I9v0aT9bw0TGo=;
  b=hPTcKmEgi6G46VYIFNHFYHLnpL/TP61EFFufm0i4jGJQ+HGDGi2FIHhE
   AQz8YKDtBqpYfFNMTth56P/rIK9xLN2HqIpqlXBZB1f+qkAgPISWiZDup
   e4pYNrXFBQs5+OTsqSaO/Q/ShmI3Urrh+zi4KB7AhcgVF2pOzjvY+JMaW
   WIRJizEIjCZ3EeCGN5VTlqWm1U52wD9J2hPSPSBon3OhxVpE944g8tmzr
   lcGC2DfZBt3Bit8Tqaurp2r2MqwnTPzghoqCQJJeVQ17AfLpZc4Hnahca
   mypONrRNE1qHvKJucxWlUouZuS8W1/GH3alWRDq6apjtyUtL/C9AjFISc
   A==;
X-CSE-ConnectionGUID: rvIFbP71RG+2C2Lze+k2Bw==
X-CSE-MsgGUID: E42NV3L7SdGHJMv8s62jYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4306094"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4306094"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:32 -0800
X-CSE-ConnectionGUID: KOgqveNrRIGnQw4fjtsfpg==
X-CSE-MsgGUID: OBy51t07RVmyJ4UO6R1LbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12271970"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 13:53:31 -0800
From: Zide Chen <zide.chen@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Andi Kleen <ak@linux.intel.com>,
	Stephane Eranian <eranian@google.com>,
	linux-kernel@vger.kernel.org,
	Mingwei Zhang <mizhang@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Das Sandipan <Sandipan.Das@amd.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: [PATCH v10 18/18] KVM: selftests: Add Topdown PERF_METRICS test
Date: Tue, 24 Nov 2026 14:39:01 -0700
Message-ID: <20261124213901.120572-19-zide.chen@intel.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124213901.120572-1-zide.chen@intel.com>
References: <20261124213901.120572-1-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated selftest to verify Intel Topdown (PERF_METRICS) support
under the mediated vPMU.

Verify across PMU versions and capability combinations:
- Positive Topdown counting.
- RDPMC Metrics Clear Mode.
- RDPMC (native and FEP), RDMSR, and WRMSR access to PERF_METRICS.
- Behavior when fixed counter 3 is absent.
- Behavior when PERF_CAP_PERF_METRICS is unadvertised.
- Host userspace save/restore via KVM_SET_MSRS and KVM_GET_MSRS.

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v10:
- Move Topdown metrics tests to a dedicated file to avoid bloating
  pmu_counters_test.c.
- Add coverage for RDPMC Metrics Clear Mode, host MSR access, and
  capability permutations.
---
 tools/arch/x86/include/asm/msr-index.h        |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/x86/pmu_perf_metrics_test.c | 391 ++++++++++++++++++
 4 files changed, 400 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/pmu_perf_metrics_test.c

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 18c4be75e927..851f5c6b9ade 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -331,7 +331,9 @@
 #define PERF_CAP_PEBS_FORMAT		0xf00
 #define PERF_CAP_FW_WRITES		BIT_ULL(13)
 #define PERF_CAP_PEBS_BASELINE		BIT_ULL(14)
+#define PERF_CAP_PERF_METRICS		BIT_ULL(15)
 #define PERF_CAP_PEBS_TIMING_INFO	BIT_ULL(17)
+#define PERF_CAP_RDPMC_METRICS_CLEAR	BIT_ULL(19)
 #define PERF_CAP_PEBS_MASK		(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 					 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
 					 PERF_CAP_PEBS_TIMING_INFO)
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index be5eb2dd85aa..71e0b36089e2 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -106,6 +106,7 @@ TEST_GEN_PROGS_x86 += x86/nested_x2apic_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
+TEST_GEN_PROGS_x86 += x86/pmu_perf_metrics_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
 TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test
diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index c06ac78db01f..8ffb26a1d824 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -50,11 +50,17 @@
 #define INTEL_RDPMC_FAST			BIT_ULL(31)
 
 /* Fixed PMC controls, Intel only. */
+#define FIXED_PMC_SLOTS_IDX			3
 #define FIXED_PMC_GLOBAL_CTRL_ENABLE(_idx)	BIT_ULL((32 + (_idx)))
 
+/* PERF_METRICS enable, Intel only. */
+#define GLOBAL_CTRL_EN_PERF_METRICS		BIT_ULL(48)
+
 #define FIXED_PMC_KERNEL			BIT_ULL(0)
 #define FIXED_PMC_USER				BIT_ULL(1)
 #define FIXED_PMC_ANYTHREAD			BIT_ULL(2)
+/* Fixed counter 3 reuses bit 2 for METRICS_CLEAR_EN (Intel only). */
+#define FIXED_PMC_METRICS_CLEAR			BIT_ULL(2)
 #define FIXED_PMC_ENABLE_PMI			BIT_ULL(3)
 #define FIXED_PMC_NR_BITS			4
 #define FIXED_PMC_CTRL(_idx, _val)		((_val) << ((_idx) * FIXED_PMC_NR_BITS))
diff --git a/tools/testing/selftests/kvm/x86/pmu_perf_metrics_test.c b/tools/testing/selftests/kvm/x86/pmu_perf_metrics_test.c
new file mode 100644
index 000000000000..07a6c948e4cd
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/pmu_perf_metrics_test.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for KVM Topdown Microarchitecture Analysis (TMA) and PERF_METRICS.
+ *
+ * Copyright (C) 2026, Intel Corporation
+ */
+
+#include <linux/bitfield.h>
+
+#include "processor.h"
+#include "pmu.h"
+
+/* Number of iterations of the loop for the guest measurement payload. */
+#define NUM_LOOPS			10
+#define PERF_METRICS_TEST_VAL		0x12345678ULL
+#define SLOTS_TEST_VAL			0x12345ULL
+
+static void guest_test_rdpmc(u32 rdpmc_idx, bool expect_success, u64 expected_val)
+{
+	u8 vector;
+	u64 val;
+
+	vector = rdpmc_safe(rdpmc_idx, &val);
+	__GUEST_ASSERT(expect_success ? !vector : vector == GP_VECTOR,
+		       "Expected %s on RDPMC(0x%x), got %s",
+		       expect_success ? "no fault" : "#GP", rdpmc_idx, ex_str(vector));
+	if (expect_success)
+		GUEST_ASSERT_EQ(val, expected_val);
+
+	if (!is_forced_emulation_enabled)
+		return;
+
+	vector = rdpmc_safe_fep(rdpmc_idx, &val);
+	__GUEST_ASSERT(expect_success ? !vector : vector == GP_VECTOR,
+		       "Expected %s on FEP RDPMC(0x%x), got %s",
+		       expect_success ? "no fault" : "#GP", rdpmc_idx, ex_str(vector));
+	if (expect_success)
+		GUEST_ASSERT_EQ(val, expected_val);
+}
+
+static void assert_rdpmc_metrics_cleared(u8 vector, u64 val)
+{
+	__GUEST_ASSERT(!vector, "Expected no fault on RDPMC(0x%llx), got %s",
+		       INTEL_RDPMC_METRICS, ex_str(vector));
+	GUEST_ASSERT_EQ(val, PERF_METRICS_TEST_VAL);
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0);
+	GUEST_ASSERT_EQ(rdmsr(MSR_CORE_PERF_FIXED_CTR3), 0);
+}
+
+static void guest_test_no_perf_metrics(void)
+{
+	u64 metrics;
+	u8 vector;
+
+	/*
+	 * When PERF_METRICS is not exposed to the guest, all accesses
+	 * must fault (#GP): MSR_PERF_METRICS, GLOBAL_CTRL bit 48,
+	 * and RDPMC of metrics type.
+	 */
+	vector = rdmsr_safe(MSR_PERF_METRICS, &metrics);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	vector = wrmsr_safe(MSR_PERF_METRICS, 0);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	vector = wrmsr_safe(MSR_CORE_PERF_GLOBAL_CTRL,
+			    GLOBAL_CTRL_EN_PERF_METRICS);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	guest_test_rdpmc(INTEL_RDPMC_METRICS, false, 0);
+
+	/*
+	 * If RDPMC Metrics Clear capability is set without PERF_METRICS,
+	 * setting METRICS_CLEAR_EN in FIXED_CTR_CTRL must still #GP.
+	 */
+	if (this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS) > FIXED_PMC_SLOTS_IDX) {
+		vector = wrmsr_safe(MSR_CORE_PERF_FIXED_CTR_CTRL,
+				    FIXED_PMC_CTRL(FIXED_PMC_SLOTS_IDX,
+						   FIXED_PMC_KERNEL | FIXED_PMC_METRICS_CLEAR));
+		GUEST_ASSERT_EQ(vector, GP_VECTOR);
+	}
+}
+
+static void guest_test_no_slots_counter(void)
+{
+	u8 vector;
+
+	/*
+	 * Without fixed counter 3, all metric fields are reserved: reads
+	 * return 0, writing 0 succeeds, and non-zero writes #GP.
+	 */
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), 0);
+
+	vector = wrmsr_safe(MSR_PERF_METRICS, 0);
+	GUEST_ASSERT_EQ(vector, 0);
+
+	vector = wrmsr_safe(MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	vector = wrmsr_safe(MSR_CORE_PERF_GLOBAL_CTRL,
+			    GLOBAL_CTRL_EN_PERF_METRICS);
+	GUEST_ASSERT_EQ(vector, 0);
+
+	vector = wrmsr_safe(MSR_CORE_PERF_FIXED_CTR3, 0);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	vector = wrmsr_safe(MSR_CORE_PERF_FIXED_CTR_CTRL,
+			    FIXED_PMC_CTRL(FIXED_PMC_SLOTS_IDX, FIXED_PMC_METRICS_CLEAR));
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+
+	guest_test_rdpmc(INTEL_RDPMC_METRICS, true, 0);
+}
+
+static void guest_test_full_perf_metrics(void)
+{
+	int retiring, bad_spec, fe_bound, be_bound, sum, loops;
+	u64 global_ctrl, metrics, val;
+	u8 vector;
+
+	wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
+	wrmsr(MSR_CORE_PERF_FIXED_CTR3, 0);
+	wrmsr(MSR_PERF_METRICS, 0);
+
+	/* Enable fixed counter 3 (TOPDOWN.SLOTS) and PERF_METRICS. */
+	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL,
+	      FIXED_PMC_CTRL(FIXED_PMC_SLOTS_IDX, FIXED_PMC_KERNEL));
+	global_ctrl = FIXED_PMC_GLOBAL_CTRL_ENABLE(FIXED_PMC_SLOTS_IDX) |
+		      GLOBAL_CTRL_EN_PERF_METRICS;
+
+	GUEST_RUN_PAYLOAD(MSR_CORE_PERF_GLOBAL_CTRL, global_ctrl, "", NUM_LOOPS);
+
+	/* Check test results. */
+	metrics = rdmsr(MSR_PERF_METRICS);
+	vector = rdpmc_safe(INTEL_RDPMC_METRICS, &val);
+	GUEST_ASSERT_EQ(vector, 0);
+	GUEST_ASSERT_EQ(val, metrics);
+
+	retiring = FIELD_GET(GENMASK_ULL(7, 0), metrics);
+	bad_spec = FIELD_GET(GENMASK_ULL(15, 8), metrics);
+	fe_bound = FIELD_GET(GENMASK_ULL(23, 16), metrics);
+	be_bound = FIELD_GET(GENMASK_ULL(31, 24), metrics);
+
+	/*
+	 * Be conservative: the measured payload definitely retires work, so
+	 * Retiring should be non-zero.
+	 */
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
+	loops = NUM_LOOPS;
+
+	__asm__ __volatile__("loop ." : "+c"(loops));
+
+	/* Confirm PERF_METRICS did not advance while counting was disabled. */
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), metrics);
+
+	/*
+	 * Only use the 4 level-1 metric fields (bits [31:0]), which are present
+	 * whether the CPU supports 4 or 8 Topdown events.
+	 */
+	wrmsr(MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+
+	/* Force a VM-exit to verify KVM restores MSR_PERF_METRICS on VM-entry. */
+	GUEST_SYNC(0);
+	GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), PERF_METRICS_TEST_VAL);
+
+	guest_test_rdpmc(INTEL_RDPMC_METRICS, true, PERF_METRICS_TEST_VAL);
+
+	/*
+	 * Test RDPMC Metrics Clear Mode if supported, or verify that setting
+	 * METRICS_CLEAR_EN injects #GP if the capability is absent.
+	 */
+	if (rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_RDPMC_METRICS_CLEAR) {
+		wrmsr(MSR_CORE_PERF_FIXED_CTR3, SLOTS_TEST_VAL);
+		wrmsr(MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+
+		/* Enable Metrics Clear Mode for fixed counter 3. */
+		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL,
+		      FIXED_PMC_CTRL(FIXED_PMC_SLOTS_IDX,
+				     FIXED_PMC_KERNEL | FIXED_PMC_METRICS_CLEAR));
+
+		/* Confirm RDMSR does not clear either register. */
+		GUEST_ASSERT_EQ(rdmsr(MSR_PERF_METRICS), PERF_METRICS_TEST_VAL);
+		GUEST_ASSERT_EQ(rdmsr(MSR_CORE_PERF_FIXED_CTR3), SLOTS_TEST_VAL);
+
+		/* RDPMC of PERF_METRICS must return the value and clear both. */
+		vector = rdpmc_safe(INTEL_RDPMC_METRICS, &val);
+		assert_rdpmc_metrics_cleared(vector, val);
+
+		if (is_forced_emulation_enabled) {
+			wrmsr(MSR_CORE_PERF_FIXED_CTR3, SLOTS_TEST_VAL);
+			wrmsr(MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+			vector = rdpmc_safe_fep(INTEL_RDPMC_METRICS, &val);
+			assert_rdpmc_metrics_cleared(vector, val);
+		}
+
+		/* Restore FIXED_CTR_CTRL to normal counting. */
+		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL,
+		      FIXED_PMC_CTRL(FIXED_PMC_SLOTS_IDX, FIXED_PMC_KERNEL));
+	} else {
+		vector = wrmsr_safe(MSR_CORE_PERF_FIXED_CTR_CTRL,
+				    FIXED_PMC_CTRL(FIXED_PMC_SLOTS_IDX,
+						   FIXED_PMC_KERNEL | FIXED_PMC_METRICS_CLEAR));
+		GUEST_ASSERT_EQ(vector, GP_VECTOR);
+	}
+}
+
+static void guest_test_perf_metrics(void)
+{
+	if (!(rdmsr(MSR_IA32_PERF_CAPABILITIES) & PERF_CAP_PERF_METRICS))
+		guest_test_no_perf_metrics();
+	else if (this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS) <= FIXED_PMC_SLOTS_IDX)
+		guest_test_no_slots_counter();
+	else
+		guest_test_full_perf_metrics();
+
+	GUEST_DONE();
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	do {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_PRINTF:
+			pr_info("%s", uc.buffer);
+			break;
+		case UCALL_DONE:
+			break;
+		default:
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	} while (uc.cmd != UCALL_DONE);
+}
+
+static void test_one_perf_metrics(u8 pmu_version, u64 perf_capabilities,
+				  u8 nr_fixed_counters)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_test_perf_metrics);
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, perf_capabilities);
+
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_VERSION, pmu_version);
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS, nr_fixed_counters);
+
+	run_vcpu(vcpu);
+
+	kvm_vm_free(vm);
+}
+
+static void test_perf_metrics(u8 pmu_version, u64 perf_capabilities)
+{
+	u8 nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
+
+	pr_info("Testing Perf Metrics, PMU version %u, perf_caps = 0x%lx\n",
+		pmu_version, perf_capabilities);
+
+	/* Test with full/supported fixed counters (fixed counter 3 present if supported). */
+	test_one_perf_metrics(pmu_version, perf_capabilities, nr_fixed_counters);
+
+	/* Test with fixed counter 3 absent. */
+	if (nr_fixed_counters > FIXED_PMC_SLOTS_IDX)
+		test_one_perf_metrics(pmu_version, perf_capabilities, FIXED_PMC_SLOTS_IDX);
+}
+
+static void test_guest_perf_metrics(void)
+{
+	u8 pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
+	const u64 perf_caps[] = {
+		0,
+		PERF_CAP_PERF_METRICS,
+		PERF_CAP_PERF_METRICS | PERF_CAP_RDPMC_METRICS_CLEAR,
+		PERF_CAP_RDPMC_METRICS_CLEAR,
+	};
+	u64 advertised_perf_caps;
+	u8 max_pmu_version;
+	unsigned int i;
+	u8 v;
+
+	max_pmu_version = max_t(typeof(pmu_version), pmu_version, 5);
+	advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
+
+	for (v = 2; v <= max_pmu_version; v++) {
+		for (i = 0; i < ARRAY_SIZE(perf_caps); i++) {
+			/* Ignore unsupported features. */
+			if (perf_caps[i] & ~advertised_perf_caps)
+				continue;
+
+			test_perf_metrics(v, perf_caps[i]);
+		}
+	}
+}
+
+static void test_host_perf_metrics(void)
+{
+	u64 advertised_perf_caps;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 val;
+	int ret;
+
+	advertised_perf_caps = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
+	if (!(advertised_perf_caps & PERF_CAP_PERF_METRICS))
+		return;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, advertised_perf_caps);
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_VERSION, 2);
+
+	/*
+	 * Case 1: Fixed counter 3 present and PERF_METRICS exposed.
+	 * Host can write 0 and valid non-zero values to MSR_PERF_METRICS.
+	 */
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS,
+				FIXED_PMC_SLOTS_IDX + 1);
+
+	ret = _vcpu_set_msr(vcpu, MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+	TEST_ASSERT_EQ(ret, 1);
+	val = vcpu_get_msr(vcpu, MSR_PERF_METRICS);
+	TEST_ASSERT_EQ(val, PERF_METRICS_TEST_VAL);
+
+	ret = _vcpu_set_msr(vcpu, MSR_PERF_METRICS, 0);
+	TEST_ASSERT_EQ(ret, 1);
+	val = vcpu_get_msr(vcpu, MSR_PERF_METRICS);
+	TEST_ASSERT_EQ(val, 0);
+
+	/*
+	 * Case 2: Fixed counter 3 absent.
+	 * Host writing 0 succeeds (for migration/probe), non-zero fails.
+	 */
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS,
+				FIXED_PMC_SLOTS_IDX);
+
+	ret = _vcpu_set_msr(vcpu, MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+	TEST_ASSERT_EQ(ret, 0);
+
+	ret = _vcpu_set_msr(vcpu, MSR_PERF_METRICS, 0);
+	TEST_ASSERT_EQ(ret, 1);
+
+	/*
+	 * Case 3: PERF_CAP_PERF_METRICS not exposed (even with fixed counter 3 present).
+	 * Non-zero writes must fail. Writing 0 succeeds as KVM allows
+	 * writing 0 to advertised feature MSRs for compatibility.
+	 */
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_FIXED_COUNTERS,
+				FIXED_PMC_SLOTS_IDX + 1);
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
+
+	ret = _vcpu_set_msr(vcpu, MSR_PERF_METRICS, PERF_METRICS_TEST_VAL);
+	TEST_ASSERT_EQ(ret, 0);
+
+	ret = _vcpu_set_msr(vcpu, MSR_PERF_METRICS, 0);
+	TEST_ASSERT_EQ(ret, 1);
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+
+	TEST_REQUIRE(host_cpu_is_intel);
+	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
+	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) >= 2);
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
+
+	test_host_perf_metrics();
+	test_guest_perf_metrics();
+
+	return 0;
+}
-- 
2.56.1


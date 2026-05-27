Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D93DFC94;
	Wed, 27 May 2026 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779925652; cv=none; b=QTXQV8hbrZYJPdGWyl25rtvMhCs9f+BY8EmA8qXOlWCZSbcXoL6VFqsJrFlhrE3PccWGS9wb8KDqTGAQIIPSXV8sdMg5awjQn0P66N/0+IkeogpCRR6i8efoVv9bOAZcbKYLoF8ibHJkQy60osGd+3+oHlIqtlJzIll/4iYCDwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779925652; c=relaxed/simple;
	bh=htyzYObhK3/cOuj6AyO0FGGU7bBU3a64wSW49SLrOYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6MONI4qch5lABMIi0J94vgGzp7TaFVTLGNPmvZ0N9SXeMnBf7kpeSZ9CQEiHdl/oWQWc8g/umCblGqBQYIu7hRpnNjXkZpVRO6t0CUrKlUzHfvHywOp9N4PipVv/ViCA0KMp0J4DeltcHyWpMGKVmZXeCdYzWn+CnHsbCYxz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd1749ux; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd1749ux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369791F000E9;
	Wed, 27 May 2026 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779925650;
	bh=1U24eWW9n3ACEjNCNLe2CqY0Gd2RUHuKZSqNGo/OPpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yd1749uxPX+bYLLb0F4WoiJGlXHSEoLk1/XJp/LHCOnqqCKD+5VCE9V2/xUjm8T0j
	 nfFbDsM/BTchn/J9TwSyNM03ZoiGrY+01/MvSRrPInvzwnWnS5G3+EMt7Be7Fu22jQ
	 E0YfBLt5ZSpyOBVoCONtt0f0UXe27z0JmdVh6Z+9ANpT+lskDdbHkJxQFvhSWidwXo
	 Wx/sZ4WceJohdEYuTXQXXM1XHBHsrjp+w/hJAtClfqt0pZbG6B/L2Qn95sZIT8St7N
	 7t1bvqSrFQ8h/ijpabtDqPsiARSKM9DNlYxpk00BdMK74KzY3LqWpnDDC0wajr8oBH
	 f3WRJWRAigiHA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v7 17/17] KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only bits
Date: Wed, 27 May 2026 23:47:11 +0000
Message-ID: <20260527234711.4175166-18-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
In-Reply-To: <20260527234711.4175166-1-yosry@kernel.org>
References: <20260527234711.4175166-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Mattson <jmattson@google.com>

Add a selftest to verify KVM correctly virtualizes the AMD PMU Host-Only
(bit 41) and Guest-Only (bit 40) event selector bits across all relevant
SVM state transitions.

The test programs 4 PMCs simultaneously with all combinations of the
Host-Only and Guest-Only bits, then verifies correct counting behavior
with EFER.SVME clear and set, as well as in host mode and guest mode.
The test also verifies that updating Host-Only / Guest-Only bits for a
PMC works as intended, and that event filtering is still respected.

Signed-off-by: Jim Mattson <jmattson@google.com>
Co-developed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 216 ++++++++++++++++++
 3 files changed, 223 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2908eca1647a1..4449851bc0f23 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -119,6 +119,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
+TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 98537cc8840d1..608ed83d7c6a6 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -38,6 +38,12 @@
 #define ARCH_PERFMON_EVENTSEL_INV		BIT_ULL(23)
 #define ARCH_PERFMON_EVENTSEL_CMASK		GENMASK_ULL(31, 24)
 
+/*
+ * These are AMD-specific bits.
+ */
+#define AMD64_EVENTSEL_GUESTONLY		BIT_ULL(40)
+#define AMD64_EVENTSEL_HOSTONLY			BIT_ULL(41)
+
 /* RDPMC control flags, Intel only. */
 #define INTEL_RDPMC_METRICS			BIT_ULL(29)
 #define INTEL_RDPMC_FIXED			BIT_ULL(30)
diff --git a/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
new file mode 100644
index 0000000000000..ee4633ab79aa7
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM nested SVM PMU Host-Only/Guest-Only test
+ *
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Test that KVM correctly virtualizes the AMD PMU Host-Only (bit 41) and
+ * Guest-Only (bit 40) event selector bits across all SVM state
+ * transitions.
+ *
+ * Programs 4 PMCs simultaneously with all combinations of Host-Only and
+ * Guest-Only bits, then verifies correct counting behavior with different
+ * combinations of EFER.SVME and host/guest mode -- as well as event filtering.
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "pmu.h"
+
+#define EVENTSEL_RETIRED_INSNS	(ARCH_PERFMON_EVENTSEL_OS |	\
+				 ARCH_PERFMON_EVENTSEL_USR |	\
+				 ARCH_PERFMON_EVENTSEL_ENABLE |	\
+				 AMD_ZEN_INSTRUCTIONS_RETIRED)
+
+/* PMC configurations: index corresponds to Host-Only | Guest-Only bits */
+#define PMC_NONE	0  /* Neither bit set */
+#define PMC_G		1  /* Guest-Only bit set */
+#define PMC_H		2  /* Host-Only bit set */
+#define PMC_HG		3  /* Both bits set */
+#define NR_PMCS		4
+
+#define LOOP_INSNS	1000
+
+static __always_inline void run_instruction_loop(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < LOOP_INSNS; i++)
+		__asm__ __volatile__("nop");
+}
+
+static __always_inline void read_counters(uint64_t *counts)
+{
+	int i;
+
+	for (i = 0; i < NR_PMCS; i++)
+		counts[i] = rdmsr(MSR_F15H_PERF_CTR + 2 * i);
+}
+
+static __always_inline void run_and_measure(uint64_t *deltas)
+{
+	uint64_t before[NR_PMCS], after[NR_PMCS];
+	int i;
+
+	read_counters(before);
+	run_instruction_loop();
+	read_counters(after);
+
+	for (i = 0; i < NR_PMCS; i++)
+		deltas[i] = after[i] - before[i];
+}
+
+static void assert_pmc_counts(uint64_t *deltas, unsigned int expected_counting)
+{
+	int i;
+
+	for (i = 0; i < NR_PMCS; i++) {
+		if (expected_counting & BIT(i))
+			GUEST_ASSERT_NE(deltas[i], 0);
+		else
+			GUEST_ASSERT_EQ(deltas[i], 0);
+	}
+}
+
+static uint64_t l2_deltas[NR_PMCS];
+
+static void l2_guest_code(void)
+{
+	run_and_measure(l2_deltas);
+	vmmcall();
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t deltas[NR_PMCS];
+	uint64_t eventsel;
+	int i;
+
+	/* Program 4 PMCs with all combinations of Host-Only/Guest-Only bits */
+	for (i = 0; i < NR_PMCS; i++) {
+		eventsel = EVENTSEL_RETIRED_INSNS;
+		if (i & PMC_G)
+			eventsel |= AMD64_EVENTSEL_GUESTONLY;
+		if (i & PMC_H)
+			eventsel |= AMD64_EVENTSEL_HOSTONLY;
+		wrmsr(MSR_F15H_PERF_CTL + 2 * i, eventsel);
+		wrmsr(MSR_F15H_PERF_CTR + 2 * i, 0);
+	}
+
+	/* Step 1: SVME=0 - Only the counter with neither bits set counts */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE));
+
+	/* Step 2: Set SVME=1 - In L1 "host mode"; Guest-Only stops */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 3: VMRUN to L2 - In "guest mode"; Host-Only stops */
+	generic_svm_setup(svm, l2_guest_code);
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	assert_pmc_counts(l2_deltas, BIT(PMC_NONE) | BIT(PMC_G) | BIT(PMC_HG));
+
+	/* Step 4: After VMEXIT to L1 - Back in "host mode"; Guest-Only stops */
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 5: Set KVM_PMU_EVENT_DENY - all counters stop */
+	GUEST_SYNC(KVM_PMU_EVENT_DENY);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, 0);
+
+	/* Step 6: Set KVM_PMU_EVENT_ALLOW - back to all except Guest-only */
+	GUEST_SYNC(KVM_PMU_EVENT_ALLOW);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 7: Clear Host-Only for PMC_HG - counter stops in "host mode" */
+	eventsel = rdmsr(MSR_F15H_PERF_CTL + 2 * PMC_HG);
+	wrmsr(MSR_F15H_PERF_CTL + 2 * PMC_HG, eventsel & ~AMD64_EVENTSEL_HOSTONLY);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H));
+
+	/* Step 8: Restore Host-Only for PMC_HG - counter counts again */
+	wrmsr(MSR_F15H_PERF_CTL + 2 * PMC_HG, eventsel);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE) | BIT(PMC_H) | BIT(PMC_HG));
+
+	/* Step 9: Clear SVME - Only the counter with neither bits set counts */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, BIT(PMC_NONE));
+
+	GUEST_DONE();
+}
+
+static struct kvm_pmu_event_filter *alloc_event_filter(u64 event)
+{
+	struct kvm_pmu_event_filter *filter;
+
+	filter = malloc(sizeof(*filter) + sizeof(event));
+	TEST_ASSERT(filter != NULL, "Filter allocation failed");
+
+	memset(filter, 0, sizeof(*filter));
+	memcpy(filter->events, &event, sizeof(event));
+	filter->nevents = 1;
+	filter->action = KVM_PMU_EVENT_ALLOW;
+
+	return filter;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_pmu_event_filter *filter;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t svm_gva;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+	TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
+	TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >= 0x17);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	filter = alloc_event_filter(AMD_ZEN_INSTRUCTIONS_RETIRED);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			goto done;
+		case UCALL_DONE:
+			goto done;
+		case UCALL_SYNC:
+			filter->action = uc.args[1];
+			vm_ioctl(vm, KVM_SET_PMU_EVENT_FILTER, filter);
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+			goto done;
+		}
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.54.0.794.g4f17f83d09-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B3E396B8B;
	Thu, 26 Mar 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774494753; cv=none; b=PiC9l+knhpxlGuw0mjl+A7VnjTk/ld37xRavdyhAD008fkxQ7AO8QKsuzODuHCUP2Mqpbn5OsnQkAClLb4pNharPYBn2/W8BHtgf/ZQb/VoN5HDxAyLKdDRqIhZ1MG259T2F7G6T62ZOGaXnYhUIpgpClLWCjeQnBDk03MI5iQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774494753; c=relaxed/simple;
	bh=9x6ZHeTmvd8fNhSBTKWSMIP/96D/CY1ahn+LcSJ18ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmLbOBvdgnurJitb2CvaEyKhvMqcWFcjF9lNCInmgjsmBFQ/gWsYDqhPYnz1qdaGuG8cen27tVBcCSXVXRdsUoqUpRb/ePj8iq/5w0nPqG5a3OIaaE91f0j36d8QdVzZ2VUlQ+9e7OMjji8wjqlZSHrI1MqOEAI6jwggB+Hqht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6L2nVm1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6L2nVm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ECCC4CEF7;
	Thu, 26 Mar 2026 03:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774494753;
	bh=9x6ZHeTmvd8fNhSBTKWSMIP/96D/CY1ahn+LcSJ18ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E6L2nVm1nfQGfP0ja7E82JJkfMetsYyjTlZiBhDV4ww6JUgmKURFZU/rx26cQ50q+
	 rpz8dNjniKczwc4DwE9gYrE2uaxnDT+p+i9tfxNbU9NofpJWNrvQFHJP9FUizUTDSh
	 91Hu/4suCuNhUC4l912zCjIqVEqFkkYW8ecKhuexzWix8j1jZ4qCAU9UwDyE6tlU2a
	 3WdmR41yzKoTxIzHBMMW0CsaGOhymiVANken2YRAAyrle44AvSHRCjl7fSxu3JU3ME
	 fsG1ldkCz6oMsLDuY/Wm6UPCztF7wFPER7JvQlgJNVtlOX3wytx7+qg8TOLOyQBuGq
	 FInl19a509+wg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v4 6/6] KVM: selftests: Add svm_pmu_host_guest_test for Host-Only/Guest-Only bits
Date: Thu, 26 Mar 2026 03:11:50 +0000
Message-ID: <20260326031150.3774017-7-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260326031150.3774017-1-yosry@kernel.org>
References: <20260326031150.3774017-1-yosry@kernel.org>
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
Host-Only and Guest-Only bits, then verifies correct counting behavior:
  1. SVME=0: all counters count (Host-Only/Guest-Only bits ignored)
  2. Set SVME=1: Host-Only and neither/both count; Guest-Only stops
  3. VMRUN to L2: Guest-Only and neither/both count; Host-Only stops
  4. VMEXIT to L1: Host-Only and neither/both count; Guest-Only stops
  5. Clear SVME=0: all counters count (bits ignored again)

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/pmu.h |   6 +
 .../selftests/kvm/include/x86/processor.h     |   2 +
 .../kvm/x86/svm_pmu_host_guest_test.c         | 199 ++++++++++++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 3d372d78a2756..9418c45291231 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_invalid_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
+TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 72575eadb63a0..af9b279c78df4 100644
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
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index d8634a760a609..4cc1ba8752347 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -19,6 +19,8 @@
 #include "kvm_util.h"
 #include "ucall_common.h"
 
+#define __stack_aligned__	__aligned(16)
+
 extern bool host_cpu_is_intel;
 extern bool host_cpu_is_amd;
 extern bool host_cpu_is_hygon;
diff --git a/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
new file mode 100644
index 0000000000000..a08c03a40d4f6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_pmu_host_guest_test.c
@@ -0,0 +1,199 @@
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
+ * Guest-Only bits, then verifies correct counting behavior through:
+ *   1. SVME=0: all counters count (Host-Only/Guest-Only bits ignored)
+ *   2. Set SVME=1: Host-Only and neither/both count; Guest-Only stops
+ *   3. VMRUN to L2: Guest-Only and neither/both count; Host-Only stops
+ *   4. VMEXIT to L1: Host-Only and neither/both count; Guest-Only stops
+ *   5. Clear SVME=0: all counters count (bits ignored again)
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
+#define L2_GUEST_STACK_SIZE	255
+
+#define EVENTSEL_RETIRED_INSNS	(ARCH_PERFMON_EVENTSEL_OS |	\
+				 ARCH_PERFMON_EVENTSEL_USR |	\
+				 ARCH_PERFMON_EVENTSEL_ENABLE |	\
+				 AMD_ZEN_INSTRUCTIONS_RETIRED)
+
+/* PMC configurations: index corresponds to Host-Only | Guest-Only bits */
+#define PMC_NEITHER	0  /* Neither bit set */
+#define PMC_GUESTONLY	1  /* Guest-Only bit set */
+#define PMC_HOSTONLY	2  /* Host-Only bit set */
+#define PMC_BOTH	3  /* Both bits set */
+#define NR_PMCS		4
+
+/* Bitmasks for which PMCs should be counting in each state */
+#define COUNTS_ALL	(BIT(PMC_NEITHER) | BIT(PMC_GUESTONLY) | \
+			 BIT(PMC_HOSTONLY) | BIT(PMC_BOTH))
+#define COUNTS_L1	(BIT(PMC_NEITHER) | BIT(PMC_HOSTONLY) | BIT(PMC_BOTH))
+#define COUNTS_L2	(BIT(PMC_NEITHER) | BIT(PMC_GUESTONLY) | BIT(PMC_BOTH))
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
+struct test_data {
+	uint64_t l2_deltas[NR_PMCS];
+	bool l2_done;
+};
+
+static struct test_data *test_data;
+
+static void l2_guest_code(void)
+{
+	run_and_measure(test_data->l2_deltas);
+	test_data->l2_done = true;
+	vmmcall();
+}
+
+static void l1_guest_code(struct svm_test_data *svm, struct test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE] __stack_aligned__;
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t deltas[NR_PMCS];
+	uint64_t eventsel;
+	int i;
+
+	test_data = data;
+
+	/* Program 4 PMCs with all combinations of Host-Only/Guest-Only bits */
+	for (i = 0; i < NR_PMCS; i++) {
+		eventsel = EVENTSEL_RETIRED_INSNS;
+		if (i & PMC_GUESTONLY)
+			eventsel |= AMD64_EVENTSEL_GUESTONLY;
+		if (i & PMC_HOSTONLY)
+			eventsel |= AMD64_EVENTSEL_HOSTONLY;
+		wrmsr(MSR_F15H_PERF_CTL + 2 * i, eventsel);
+		wrmsr(MSR_F15H_PERF_CTR + 2 * i, 0);
+	}
+
+	/* Step 1: SVME=0 - Host-Only/Guest-Only bits ignored; all count */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_ALL);
+
+	/* Step 2: Set SVME=1 - In L1 "host mode"; Guest-Only stops */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) | EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_L1);
+
+	/* Step 3: VMRUN to L2 - In "guest mode"; Host-Only stops */
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+	assert_pmc_counts(data->l2_deltas, COUNTS_L2);
+
+	/* Step 4: After VMEXIT to L1 - Back in "host mode"; Guest-Only stops */
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_L1);
+
+	/* Step 5: Clear SVME - Host-Only/Guest-Only bits ignored; all count */
+	wrmsr(MSR_EFER, rdmsr(MSR_EFER) & ~EFER_SVME);
+	run_and_measure(deltas);
+	assert_pmc_counts(deltas, COUNTS_ALL);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	vm_vaddr_t svm_gva, data_gva;
+	struct test_data *data_hva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+	TEST_REQUIRE(get_kvm_amd_param_bool("enable_mediated_pmu"));
+	TEST_REQUIRE(host_cpu_is_amd && kvm_cpu_family() >= 0x17);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	data_gva = vm_vaddr_alloc_page(vm);
+	data_hva = addr_gva2hva(vm, data_gva);
+	memset(data_hva, 0, sizeof(*data_hva));
+
+	vcpu_args_set(vcpu, 2, svm_gva, data_gva);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unknown ucall %lu", uc.cmd);
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.53.0.1018.g2bb0e51243-goog


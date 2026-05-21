Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EC223323;
	Thu, 21 May 2026 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386399; cv=none; b=Y4I/9zcSWFQUN44+ftx69ion/gOvXIfwjy8xnBihJ+pdzPm7Q0SISDzVw5+u2wNQdb2ZDo1AZEqvlTl57LHnI8QESXSPaFCoV2nC7sDTT+/LswYuMKs38B461R9ajQIoudfI7WSczumBQ1NdbMuIWgXBP9drKUqmRBWKIstUNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386399; c=relaxed/simple;
	bh=i9hroFvTWPqkdNEB8k+tU0LkwSbAkDu374ImdJ3kQ9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgoSkj4VfMop0/RZyCs89hbyd0baxNDUD9Xi3CHkhDb1GyumxcahGa14rB6lmLmnA8qNStdJmwxOijRYYxL5fn01VEhFJT3Np3jLlbhoKzYW3JSkR39EmkOZ0cnFh3gicSWL2aLew0T1ZosCq5P88ca9Q3bK5UhH7DSu6GiqiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKdBndz0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKdBndz0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E021F00A3B;
	Thu, 21 May 2026 17:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779386396;
	bh=vxNkT5bmhErSaBfiVMcn+pLwQL9vS6PSTSmEOJPT7Z0=;
	h=From:To:Cc:Subject:Date;
	b=jKdBndz0los9Ee75T5UEiotp8urfL+k87bEn6DKQ2AIS+OxMnDO2p3gTFk5DP3SYN
	 qNPERMyxcV89Hnr6i3I2Jp5AmpClLqVyRSs0tCkjnGHpo9fbEN5aNDRumzbgF24gzL
	 etn3mM1uxQovohzaO7qfoRUsTatT1adT3Dof4AgrxU4+jGud4LscuOTflsVKMAbQwS
	 TFuxvxZ/MxJxooxk5+q+8TqdVJtNBOsRwxLxS4w1VPhh01EJCZFwvKyy4puGXgPSwQ
	 5v/INX0Nl9qZuPLvDvBdoXa2/9PzBLRn7cU44/3HQEpsgWo9WtupDM2X807y7LY3K8
	 kugxfmivhjmWw==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3] KVM: selftests: Add a test for gPAT handling in L2
Date: Thu, 21 May 2026 17:59:48 +0000
Message-ID: <20260521175948.522757-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT is disabled, verify that KVM
correctly virtualizes the host PAT MSR and the guest PAT register for
nested SVM guests.

With nested NPT disabled:
 * L1 and L2 share the same PAT
 * The vmcb12.g_pat is ignored

With nested NPT enabled:
 * An invalid g_pat in vmcb12 causes VMEXIT_INVALID
 * RDMSR(IA32_PAT) from L2 returns the value of the guest PAT register
 * WRMSR(IA32_PAT) from L2 is reflected in vmcb12's g_pat on VMEXIT
 * RDMSR(IA32_PAT) from L1 returns the value of the host PAT MSR
 * Save/restore with the vCPU in guest mode preserves both hPAT and gPAT

Originally-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---

v2 -> v3:
- Fixed multiple VM-Entries test case.
- Fixed typos.

v1 -> v2:
- Rewrote most of the test to dedup L1 and L2 code, move assertions to
  L2 where possible to simplify the test, and drop the shared test
  struct.

v1 is essentially the patch in v7 of Jim's gPAT series [*]
[*]https://lore.kernel.org/kvm/20260327234023.2659476-10-jmattson@google.com/

---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 202 ++++++++++++++++++
 2 files changed, 203 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89f..d658dc7cd2b14 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -117,6 +117,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
+TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
new file mode 100644
index 0000000000000..ed7cae7a6b4bd
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Test that KVM correctly virtualizes the PAT MSR and VMCB g_pat field
+ * for nested SVM guests:
+ *
+ * o With nested NPT disabled:
+ *     - L1 and L2 share the same PAT
+ *     - The vmcb12.g_pat is ignored
+ * o With nested NPT enabled:
+ *     - Invalid g_pat in vmcb12 should cause VMEXIT_INVALID
+ *     - L2 should see vmcb12.g_pat via RDMSR, not L1's PAT
+ *     - L2's writes to PAT should be saved to vmcb12 on exit
+ *     - L1's PAT should be restored after #VMEXIT from L2
+ *     - State save/restore should preserve both L1's and L2's PAT values
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
+
+#define L2_GUEST_STACK_SIZE 256
+
+#define PAT_DEFAULT		0x0007040600070406ULL
+#define L1_PAT_VALUE		0x0007040600070404ULL  /* Change PA0 to WT */
+#define L2_VMCB12_PAT		0x0606060606060606ULL  /* All WB */
+#define L2_PAT_MODIFIED		0x0606060606060604ULL  /* Change PA0 to WT */
+#define INVALID_PAT_VALUE	0x0808080808080808ULL  /* 8 is reserved */
+
+bool npt_enabled;
+int nr_iterations;
+
+static void l2_guest_code(void)
+{
+	u64 expected_pat = npt_enabled ? L2_VMCB12_PAT : L1_PAT_VALUE;
+	int i;
+
+	for (i = 0; i < nr_iterations; i++) {
+		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_pat);
+		GUEST_SYNC(1);
+		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_pat);
+
+		wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+		expected_pat = L2_PAT_MODIFIED;
+
+		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
+		GUEST_SYNC(2);
+		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
+
+		vmmcall();
+	}
+}
+
+static void l1_guest_code(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+	int i;
+
+	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	generic_svm_setup(svm, l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = L2_VMCB12_PAT;
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	for (i = 0; i < nr_iterations; i++) {
+		run_guest(vmcb, svm->vmcb_gpa);
+
+		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+
+		/*
+		 * If NPT is enabled by L1, L2 has a unique PAT and L1's PAT is
+		 * unchanged. Otherwise, PAT is shared between L1 and L2.
+		 */
+		if (npt_enabled) {
+			GUEST_ASSERT_EQ(vmcb->save.g_pat, L2_PAT_MODIFIED);
+			GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+		} else {
+			GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
+		}
+		vmcb->save.rip += 3; /* skip over VMMCALL */
+	}
+
+	GUEST_DONE();
+}
+
+static void l1_guest_code_invalid_gpat(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+
+	/* VMRUN should fail without running L2 */
+	generic_svm_setup(svm, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = INVALID_PAT_VALUE;
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_ERR);
+	GUEST_DONE();
+}
+
+static void run_test(const char *test_name, void *guest_code, bool do_save_restore)
+{
+	struct kvm_x86_state *state;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t svm_gva;
+
+	pr_info("Testing: %s\n", test_name);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
+		      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+
+	if (npt_enabled) {
+		vm_enable_npt(vm);
+		tdp_identity_map_default_memslots(vm);
+	}
+
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 1, svm_gva);
+	sync_global_to_guest(vm, npt_enabled);
+	sync_global_to_guest(vm, nr_iterations);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			if (do_save_restore) {
+				pr_info("  Save/restore at sync point %ld\n",
+					uc.args[1]);
+				state = vcpu_save_state(vcpu);
+				kvm_vm_release(vm);
+				vcpu = vm_recreate_with_one_vcpu(vm);
+				vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
+					      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+				vcpu_load_state(vcpu, state);
+				kvm_x86_state_cleanup(state);
+			}
+			break;
+		case UCALL_DONE:
+			pr_info("  PASSED\n");
+			kvm_vm_free(vm);
+			return;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+}
+
+#define NPT_DISABLED 0
+#define NPT_ENABLED 1
+
+#define NO_SAVE_RESTORE 0
+#define DO_SAVE_RESTORE 1
+
+#define NESTED_PAT_TEST(test_name, guest_code, npt, sr, iter)	\
+({								\
+	npt_enabled = npt;					\
+	nr_iterations = iter;					\
+	run_test(test_name, guest_code, sr);			\
+})
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
+		     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+
+	NESTED_PAT_TEST("Invalid gPAT", l1_guest_code_invalid_gpat,
+			NPT_ENABLED, NO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Nested NPT disabled", l1_guest_code,
+			NPT_DISABLED, NO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
+			NPT_ENABLED, NO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Save/Restore", l1_guest_code,
+			NPT_ENABLED, DO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Multiple VM-Entries", l1_guest_code,
+			NPT_ENABLED, NO_SAVE_RESTORE, 10);
+
+	return 0;
+}

base-commit: 4f256d5770febb9d61f9b57a4c79c491bf4987f1
-- 
2.54.0.794.g4f17f83d09-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821FC368D52;
	Thu, 21 May 2026 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330897; cv=none; b=C9AUliuUGndeNQALQME/akNzitd6r0NLHFKG7Npj8TXW1Mdu9CKG4jQsa+0NZGSTXGLzI5bZqivgP6RO8hJikEMfIR6RmQs81Aos/IL71pbtbKusIk26W+Ry1R9bz54zqhSRH/xA00+jTXAccHINvtprsjYgfJqeJmqBRI/zhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330897; c=relaxed/simple;
	bh=lj0ODuSh/QonZbpUPNa9pcc69wvtEH44VGa9sp7wHRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPcK5WnHSUjx/Jun3hkZXUxh9jVMKwBgv6rne43vCy0TzWalaoMZeX47EW2UQizjsPtYxmVlDjJ0d1gV7dTC1REsJMdr0dESlb+1mTECXNQuXIromd9HnbmoHOVMHNShfEZ4CjBYM7VDCnGj1HfHyuSZ71path75vCV3JEH4HoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+qc4dJx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+qc4dJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A091F000E9;
	Thu, 21 May 2026 02:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779330896;
	bh=uPFQmbDkx0TcbE7d5GGmH+tvz+hDsohqdoZFU+qU7rU=;
	h=From:To:Cc:Subject:Date;
	b=l+qc4dJxg/QzBwhcmkCw/SGejU+Iti42ALLejK4zscBZBVxnIe5ucO6VBddrqWXkN
	 ehSnq51Ig8GzwtXP2F2LaZHSUCTFjJXXA9Aa1DQB1tS+SfrClFyvtEXH2TRGx28WQq
	 0Qw60KrUSucXZUAE6YZFwoHHp9im9DkpNSvPetc0tHEVdXT7X0Ocbgl4O+yGRTC1Xv
	 2pJZPWZO0/bihf+CJrGla2CrSrTDz9RBZXPYH6gFJLZh5uANluKA7s5O9Wi7rRbsaJ
	 BCP84J1BuQU3vdapzNxtLO+HIg+3U11Cnsx+uIbyceASUM/3lKA0hbxYTyztPHttsv
	 px5nsHXGpHswQ==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v2] KVM: selftests: Add a test for gPAT handling in L2
Date: Thu, 21 May 2026 02:34:48 +0000
Message-ID: <20260521023448.3826878-1-yosry@kernel.org>
X-Mailer: git-send-email 2.54.0.669.g59709faab0-goog
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

v1 is essentially the patch in v7 of Jim's gPAT series [*]

v1 -> v2:
- Rewrote most of the test to dedup L1 and L2 code, move assertions to
  L2 where possible to simplify the test, and drop the shared test
  struct.

[*]https://lore.kernel.org/kvm/20260327234023.2659476-10-jmattson@google.com/

---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 200 ++++++++++++++++++
 2 files changed, 201 insertions(+)
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
index 0000000000000..6c474783b2f23
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -0,0 +1,200 @@
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
+	u64 expected_initial_pat = npt_enabled ? L2_VMCB12_PAT : L1_PAT_VALUE;
+	int i;
+
+	for (i = 0; i < nr_iterations; i++) {
+		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_initial_pat);
+		GUEST_SYNC(1);
+		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_initial_pat);
+
+		wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
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
+	NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
+			NPT_DISABLED, NO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
+			NPT_ENABLED, NO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Save/Restore", l1_guest_code,
+			NPT_ENABLED, DO_SAVE_RESTORE, 1);
+
+	NESTED_PAT_TEST("Multile VM-Entries", l1_guest_code,
+			NPT_ENABLED, NO_SAVE_RESTORE, 1);
+
+	return 0;
+}

base-commit: 4f256d5770febb9d61f9b57a4c79c491bf4987f1
-- 
2.54.0.669.g59709faab0-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A70352926;
	Tue, 24 Feb 2026 22:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972463; cv=none; b=bt27ywinI9/eHfPeXPRqYw8elBzGFgw5/7P+KzefGcZ2vW84AZG9iWl0NfI209UbwL5FG7iviWoiYXMxUed6P5MDkdap17xfn0TxFOYoR6kqAdOunGr3mPgE+4T+Etcnx0wFJ5eyiTmMQUpsxjjlVdsUGphtipBu9T//SMOAaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972463; c=relaxed/simple;
	bh=j5MTxH2ZUc2Um2PtXTxg0iEINlTGV/IJPm7hODaEIpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkdE0uEdIcglSicdMONm1c35OT+mri6N5ma500rXn4U7BEAyaX31Zgs3cjZ1EzLAe64W5zliZkK94+7tAwCbMdRpn9yGhUonqCN1Sx/GX6N2sjW2EjAumUhCgotY9VPCCHOK7KzTD2nHlEYfc4Haf2HDcCjpkvFxXwMVSZKjkuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWpt5+pr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWpt5+pr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28DBC2BCB1;
	Tue, 24 Feb 2026 22:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771972463;
	bh=j5MTxH2ZUc2Um2PtXTxg0iEINlTGV/IJPm7hODaEIpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWpt5+prx1HpijmbAs1NeqkPWpYsG4fHECKVRfLfz3GbOqq22bgyPbW7/9aHKSMis
	 G1w/M1F/wJuSvzSckAA0Ks+b8vFCZT/t76hCvi0jbli+HgQx4OduX33cy9wV8ePkEr
	 u9zpiTvMt54pxTt9jg3xrWLSpG2Z7o5A+RgAg9RVh2OzxSGkwQjH9vF0duij1RAV3H
	 VOvwgAed8AinyJ42okHykngzhi5J5P67A9GkKhdVQGfjxfGndHQfzlJVqlS+rdbnfN
	 OwP+yGkgkfvoSmI31G5YqITNlF0A4JSYKXBL2syGCmRxvU1kDkBDcy1XhKz0AeTjoN
	 ujJLi9275XEYA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v6 04/31] KVM: selftests: Add a test for LBR save/restore (ft. nested)
Date: Tue, 24 Feb 2026 22:33:38 +0000
Message-ID: <20260224223405.3270433-5-yosry@kernel.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260224223405.3270433-1-yosry@kernel.org>
References: <20260224223405.3270433-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest exercising save/restore with usage of LBRs in both L1 and
L2, and making sure all LBRs remain intact.

Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   5 +
 .../selftests/kvm/x86/svm_lbr_nested_state.c  | 145 ++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index fdec90e854671..36b48e766e499 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -112,6 +112,7 @@ TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
+TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 4ebae4269e681..db0171935197d 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1360,6 +1360,11 @@ static inline bool kvm_is_ignore_msrs(void)
 	return get_kvm_param_bool("ignore_msrs");
 }
 
+static inline bool kvm_is_lbrv_enabled(void)
+{
+	return !!get_kvm_amd_param_integer("lbrv");
+}
+
 uint64_t *vm_get_pte(struct kvm_vm *vm, uint64_t vaddr);
 
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
diff --git a/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c b/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
new file mode 100644
index 0000000000000..bf16abb1152e0
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_lbr_nested_state.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Google, Inc.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+
+#define L2_GUEST_STACK_SIZE 64
+
+#define DO_BRANCH() do { asm volatile("jmp 1f\n 1: nop"); } while (0)
+
+struct lbr_branch {
+	u64 from, to;
+};
+
+volatile struct lbr_branch l2_branch;
+
+#define RECORD_AND_CHECK_BRANCH(b)					\
+do {									\
+	wrmsr(MSR_IA32_DEBUGCTLMSR, DEBUGCTLMSR_LBR);			\
+	DO_BRANCH();							\
+	(b)->from = rdmsr(MSR_IA32_LASTBRANCHFROMIP);			\
+	(b)->to = rdmsr(MSR_IA32_LASTBRANCHTOIP);			\
+	/* Disable LBR right after to avoid overriding the IPs */	\
+	wrmsr(MSR_IA32_DEBUGCTLMSR, 0);					\
+									\
+	GUEST_ASSERT_NE((b)->from, 0);					\
+	GUEST_ASSERT_NE((b)->to, 0);					\
+} while (0)
+
+#define CHECK_BRANCH_MSRS(b)						\
+do {									\
+	GUEST_ASSERT_EQ((b)->from, rdmsr(MSR_IA32_LASTBRANCHFROMIP));	\
+	GUEST_ASSERT_EQ((b)->to, rdmsr(MSR_IA32_LASTBRANCHTOIP));	\
+} while (0)
+
+#define CHECK_BRANCH_VMCB(b, vmcb)					\
+do {									\
+	GUEST_ASSERT_EQ((b)->from, vmcb->save.br_from);			\
+	GUEST_ASSERT_EQ((b)->to, vmcb->save.br_to);			\
+} while (0)
+
+static void l2_guest_code(struct svm_test_data *svm)
+{
+	/* Record a branch, trigger save/restore, and make sure LBRs are intact */
+	RECORD_AND_CHECK_BRANCH(&l2_branch);
+	GUEST_SYNC(true);
+	CHECK_BRANCH_MSRS(&l2_branch);
+	vmmcall();
+}
+
+static void l1_guest_code(struct svm_test_data *svm, bool nested_lbrv)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+	struct lbr_branch l1_branch;
+
+	/* Record a branch, trigger save/restore, and make sure LBRs are intact */
+	RECORD_AND_CHECK_BRANCH(&l1_branch);
+	GUEST_SYNC(true);
+	CHECK_BRANCH_MSRS(&l1_branch);
+
+	/* Run L2, which will also do the same */
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	if (nested_lbrv)
+		vmcb->control.virt_ext = LBR_CTL_ENABLE_MASK;
+	else
+		vmcb->control.virt_ext &= ~LBR_CTL_ENABLE_MASK;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(svm->vmcb->control.exit_code == SVM_EXIT_VMMCALL);
+
+	/* Trigger save/restore one more time before checking, just for kicks */
+	GUEST_SYNC(true);
+
+	/*
+	 * If LBR_CTL_ENABLE is set, L1 and L2 should have separate LBR MSRs, so
+	 * expect L1's LBRs to remain intact and L2 LBRs to be in the VMCB.
+	 * Otherwise, the MSRs are shared between L1 & L2 so expect L2's LBRs.
+	 */
+	if (nested_lbrv) {
+		CHECK_BRANCH_MSRS(&l1_branch);
+		CHECK_BRANCH_VMCB(&l2_branch, vmcb);
+	} else {
+		CHECK_BRANCH_MSRS(&l2_branch);
+	}
+	GUEST_DONE();
+}
+
+void test_lbrv_nested_state(bool nested_lbrv)
+{
+	struct kvm_x86_state *state = NULL;
+	struct kvm_vcpu *vcpu;
+	vm_vaddr_t svm_gva;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	pr_info("Testing with nested LBRV %s\n", nested_lbrv ? "enabled" : "disabled");
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vcpu_alloc_svm(vm, &svm_gva);
+	vcpu_args_set(vcpu, 2, svm_gva, nested_lbrv);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			/* Save the vCPU state and restore it in a new VM on sync */
+			pr_info("Guest triggered save/restore.\n");
+			state = vcpu_save_state(vcpu);
+			kvm_vm_release(vm);
+			vcpu = vm_recreate_with_one_vcpu(vm);
+			vcpu_load_state(vcpu, state);
+			kvm_x86_state_cleanup(state);
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+done:
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_is_lbrv_enabled());
+
+	test_lbrv_nested_state(/*nested_lbrv=*/false);
+	test_lbrv_nested_state(/*nested_lbrv=*/true);
+
+	return 0;
+}
-- 
2.53.0.414.gf7e9f6c205-goog


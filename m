Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AC30C608
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009856; cv=none; b=HaUHGDBRjdWlmcReeSloNihA6MGZBgdxR6gg2THyi+11IY1s0ff5FdITCikFaIWH/IxjocoLVaitzsHb+DYdyuMzDin3vwoganZwKTio8nYUU6RzFO3OOs1QTsJ6IWLbZxMMxsPE2GyUkLRsI/hkEAsKFBQ6msZoGY8MzBjqdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009856; c=relaxed/simple;
	bh=GGRZl68Llgx6lGeNSQnw+qbKeWKGEXi5gSd2sDcpU4E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AjrIGtEY9qnoE0oie9Bw5rdUvUd/hKReXD6b4gCd7UtqZZBNqrXZc7iAv68xX4/07dtp++6cqtmsr5qjR3KBPZ8I7ClBGaLMyvut8ur9YmIrJauiwjsaeCuy30PzmPKyD3x3BFZIRkFOUK7iHBNyS7f9sxtJxxHqPazx1qQhdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d0zxMOad; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d0zxMOad"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fc4636bbso25804126a91.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 16:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780009854; x=1780614654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzywWud4AK9OePSMTKsfVaxpUXL5dilU7/IMR8TGdbo=;
        b=d0zxMOadduwzwDAI3149dwz7sg0TaseL0XvlbZG5TKcrja+GXLlqJdMF4WYmxOrTtF
         2u18T49mUMQFtYWPEhkl6dMIF/7u8Zr178EjwPKpKfRe5lFVq+1GLHrTanY8uXEBPfcU
         u7XXsY/wr9/KCHa/39x7Xymv84ieX4FXVZ306q94Pfz8bS0PwdhOCwWwP5jnwPwy6ZKU
         kzhp5IkSrmYVbYdOMjHeZw0ihnYl29ZgOxX6QXiH5dVXWRpwmjvA26FseUTrtnPwn1Dt
         JNjZS+EDkaQZIKq0Q+3QgkXlYSAYxoVJ6552eTgUbLzuGF43uFmQhUM4yA30mBYEFB9y
         ZeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780009854; x=1780614654;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FzywWud4AK9OePSMTKsfVaxpUXL5dilU7/IMR8TGdbo=;
        b=pGAG2JlqG73EAY+BwzzQqLUizA9f8qmRIYscrxqA8BJTC84bkcsT9i3kAZwTT3soc1
         HMka4GmVZpn9Dw0wpkm4R0SjLtSyY/vyrOYQPF2urUGrRWgFhxeUndVleGiXIhxoPc0X
         Tp1kdf4MBCk2geBENcTYA/abVhgJdLI7pA4m0ga6znIMZ6cqSjwN5SC60JgWEtrJLWB2
         DjXge3frpq7tVcbrh9bRTURMDLEnPX9ncmzRI3Jdbf/RmEhOMpenQk2yaJLacmLQR+qQ
         lmXBtVAAQfJy0HI0bSGUv8mq2dCSIDubthR5EbaV8y5G96475SgLfdOd1rzJSOHkeM9Z
         UNTg==
X-Gm-Message-State: AOJu0YwugyDTnTse5dBaALdvYDnAy3zGReKn2XXblpA1rAO8qSRap5+3
	LJd9i1IhoDczQtp2NGdX7uaCmgw8dEX10wlKlVUcoOlAbxMiZKxqLxWQfXmzVQh0pJwmmMaQUeN
	OEHnqVg==
X-Received: from pjtf2.prod.google.com ([2002:a17:90a:c282:b0:36b:8abb:86be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7ce:b0:368:b724:6d53
 with SMTP id 98e67ed59e1d1-36bbcac91bbmr619149a91.4.1780009854080; Thu, 28
 May 2026 16:10:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 May 2026 16:10:52 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260528231052.404737-1-seanjc@google.com>
Subject: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Yosry Ahmed <yosry@kernel.org>

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

Verify that save/restore with the vCPU in guest mode behaves as expected in
both cases, e.g. preserves both hPAT and gPAT when NPT is enabled.

Originally-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
[sean: use even fancier macro shenanigans]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v4:
 - Stop trying to use macros, and use macros.
 - Identity map TDP after allocating SVM to play nice with upcoming automatic
   stack allocation/configuration.
 - Run the npt=false testcase if NPT is unsupported, instead of skipping the
   entire test.
 - Run multiple iterations and save/restore for npt=false as well.
 - Run the variants via the main run macro.
 - Name the run macro so it looks like a function.
 - Drop printfs leftover from initial development.

v3:
 - Fixed multiple VM-Entries test case.
 - Fixed typos.

v2:
 - Rewrote most of the test to dedup L1 and L2 code, move assertions to
   L2 where possible to simplify the test, and drop the shared test
   struct.

v1: https://lore.kernel.org/kvm/20260327234023.2659476-10-jmattson@google.com

 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 195 ++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2908eca1647a..e0ddd3ff9472 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -118,6 +118,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
+TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
 TEST_GEN_PROGS_x86 += x86/sync_regs_test
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
new file mode 100644
index 000000000000..a319966c9ef0
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -0,0 +1,195 @@
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
+static void run_test(void *guest_code, bool do_save_restore, int nr_iters)
+{
+	struct kvm_x86_state *state;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t svm_gva;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
+		      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+
+	if (npt_enabled)
+		vm_enable_npt(vm);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	if (npt_enabled)
+		tdp_identity_map_default_memslots(vm);
+
+	vcpu_args_set(vcpu, 1, svm_gva);
+
+	nr_iterations = nr_iters;
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
+			kvm_vm_free(vm);
+			return;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+}
+
+#define gpat_test(test_name, guest_code, npt_setting)			\
+do {									\
+	npt_setting;							\
+									\
+	pr_info("Testing: " test_name "\n");				\
+	run_test(guest_code, false, 1);					\
+									\
+	if (guest_code == l1_guest_code) {				\
+		pr_info("Testing: " test_name " Save/Restore\n");	\
+		run_test(guest_code, true, 1);				\
+									\
+		pr_info("Testing: " test_name " Multiple VMRUNs\n");	\
+		run_test(guest_code, false, 10);			\
+	}								\
+} while (0)
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
+		     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+
+	if (!kvm_cpu_has(X86_FEATURE_NPT))
+		goto skip_npt;
+
+	gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled = true);
+	gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);
+skip_npt:
+	gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
+	return 0;
+}

base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.54.0.823.g6e5bcc1fc9-goog


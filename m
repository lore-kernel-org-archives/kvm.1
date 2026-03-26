Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07225423A7B
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547423; cv=none; b=di52IVB0EJM15sLKcAP2GvSVT1bX2aPM/qkmOTb+BzG+vYhgA3pcW9VmYe4euqklM8gZ8XIB/DKpeUZc/qtLi2maPaf2hjiOzcxfEiDSTn47VDgMLF7jIn6r1ykWYSe7DyYYpk9k448TKgf280SDuxCJUcqysi2p6680iTOx+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547423; c=relaxed/simple;
	bh=J6e0QheWsV205OBFE1w2/3od2KuiGQ8chN9jIhmli0w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A7uqqXSluEB8ITHKX1AHQ5h+8gqaYpOsjEOg4JnK7cSiqNa+aD/FDTOmo6NkT38tgNO4+6bvgzwkzEMQ4UnPrmKFzo6oNoaHdEw+kLajStBWdOV+QZkL5s3ixuAlQOTccKOpejDaVyyzGTNDTc8Yk6Kn/NvPCgg7Iol1GeNR+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lz04P53p; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lz04P53p"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35c1107da15so1840002a91.2
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547417; x=1775152217; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ/TyFghnFVNjOubdAxCNj3tm5pGnzmt2n9T/T2hdlg=;
        b=Lz04P53pZLUWlBq0C/yXraa/TTbB/Amyxnajxy3ETbs8153UpLb9j9cFxl9d36PY2h
         CrXImzEq1xMG2U7dMi5VnXw7ARmzD1l2FT2QzUJpHWJDDqxbTOuDLyyLsMC8lkplo9kT
         YNd3A0y/vkNBeyOkjP6v83R7BlVeZs+G9oRCsag/j8wHLNQ3rnYK7MJUBUWtDAR28DWa
         QCikq5VMqdoM30Vo09c0gpTgYXAimOKq8ap9+T0fQWpXy4oyxwKLvDPibC9O+13O+H56
         eaDMZnkwAatEXPS1JyVXRiENoC43l+0sZoO8euc6BTO2+qWQscwbYvgvbMiIka9NQCcB
         +Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547417; x=1775152217;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ/TyFghnFVNjOubdAxCNj3tm5pGnzmt2n9T/T2hdlg=;
        b=Vybh0rRvRw0iDLU+O8SX91KrVrXHCP+0OxgZKQtGpXcrn9zCIoja4kYfUQwdYpXy3v
         3vy4LnO06YYoO/Tcal04IEC5qTnJ/pBfIeA1tQzY01fLHWmbxgclpcRo6BIXzMSwBnKC
         poWRY+Jy36vRaJ5at3XCx7CEQrl/d/2J8hWJ95JYRBa5vVifPVQxJbXIhEO7/1ryWHBf
         7L2OVF/M52HsURtob8riFuIOSk3y2Azrmcx7VHWIOPVh23mQfgPYXMPKHE2XdWWFZDsz
         OovxMu0q3XRkdmOkXkGpgREG054/7amzwsEPoWuY9eZbIlPveU42y8yx0Ztpdr9BQaAQ
         2TOA==
X-Forwarded-Encrypted: i=1; AJvYcCU6wyMUx7NL1fmuFLC1/zTwjH9LZePpmKzHEZvIuFXX6xFEVeIJQh1aqXEOqWHUAiSzzmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHeLyYL5Aphow3l+xt6wJTBAeN9WmgJ9V8idAqz7/MJzsAc2af
	V/y356RVKgnKE4NXb2e0IuTSyvw4SZK/6q4sxz1RYbcuHHzW/6+ii7Y7KW6+eDB8wQMutRipOLz
	tk5zZ09Nyyu0CVQ==
X-Received: from pjbsl12.prod.google.com ([2002:a17:90b:2e0c:b0:35c:e2c:6921])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c0c:b0:354:a332:1a61 with SMTP id 98e67ed59e1d1-35c0dc8143emr8104477a91.5.1774547416255;
 Thu, 26 Mar 2026 10:50:16 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:28 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-11-jmattson@google.com>
Subject: [PATCH v6 10/10] KVM: selftests: nSVM: Add svm_nested_pat test
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

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

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 tools/arch/x86/include/uapi/asm/kvm.h         |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/svm_nested_pat_test.c   | 304 ++++++++++++++++++
 3 files changed, 307 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_pat_test.c

diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 7ceff6583652..be6f428a79aa 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -476,6 +476,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_SLOT_ZAP_ALL		(1 << 7)
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 #define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
+#define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT	(1 << 11)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
@@ -530,6 +531,7 @@ struct kvm_svm_nested_state_data {
 
 struct kvm_svm_nested_state_hdr {
 	__u64 vmcb_pa;
+	__u64 gpat;
 };
 
 /* for KVM_CAP_NESTED_STATE */
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 3d372d78a275..88871572ee9d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -113,6 +113,7 @@ TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
 TEST_GEN_PROGS_x86 += x86/svm_nested_invalid_vmcb12_gpa
+TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
new file mode 100644
index 000000000000..704f31a079a9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM nested SVM PAT test
+ *
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
+/*
+ * Shared state between L1 and L2 for verification.
+ */
+struct pat_test_data {
+	uint64_t l2_pat_read;
+	uint64_t l2_pat_after_write;
+	uint64_t l1_pat_after_vmexit;
+	uint64_t vmcb12_gpat_after_exit;
+	bool l2_done;
+};
+
+static struct pat_test_data *pat_data;
+
+static void l2_guest_code(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static void l2_guest_code_saverestoretest(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+
+	GUEST_SYNC(1);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), pat_data->l2_pat_read);
+
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+
+	GUEST_SYNC(2);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
+
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static void l2_guest_code_multi_vmentry(void)
+{
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+	pat_data->l2_pat_after_write = rdmsr(MSR_IA32_CR_PAT);
+	vmmcall();
+
+	pat_data->l2_pat_read = rdmsr(MSR_IA32_CR_PAT);
+	pat_data->l2_done = true;
+	vmmcall();
+}
+
+static struct vmcb *l1_common_setup(struct svm_test_data *svm,
+				    struct pat_test_data *data,
+				    void *l2_guest_code,
+				    void *l2_guest_stack)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	pat_data = data;
+
+	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	generic_svm_setup(svm, l2_guest_code, l2_guest_stack);
+
+	vmcb->save.g_pat = L2_VMCB12_PAT;
+	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
+
+	return vmcb;
+}
+
+static void l1_assert_l2_state(struct pat_test_data *data, uint64_t expected_pat_read)
+{
+	GUEST_ASSERT(data->l2_done);
+	GUEST_ASSERT_EQ(data->l2_pat_read, expected_pat_read);
+	GUEST_ASSERT_EQ(data->l2_pat_after_write, L2_PAT_MODIFIED);
+}
+
+static void l1_svm_code_npt_disabled(struct svm_test_data *svm,
+				     struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb;
+
+	vmcb = l1_common_setup(svm, data, l2_guest_code,
+			       &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	l1_assert_l2_state(data, L1_PAT_VALUE);
+
+	data->l1_pat_after_vmexit = rdmsr(MSR_IA32_CR_PAT);
+	GUEST_ASSERT_EQ(data->l1_pat_after_vmexit, L2_PAT_MODIFIED);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_invalid_gpat(struct svm_test_data *svm,
+				     struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb;
+
+	vmcb = l1_common_setup(svm, data, l2_guest_code,
+			       &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	vmcb->save.g_pat = INVALID_PAT_VALUE;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_ERR);
+	GUEST_ASSERT(!data->l2_done);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_npt_enabled(struct svm_test_data *svm,
+				    struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb;
+
+	vmcb = l1_common_setup(svm, data, l2_guest_code,
+			       &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	l1_assert_l2_state(data, L2_VMCB12_PAT);
+
+	data->vmcb12_gpat_after_exit = vmcb->save.g_pat;
+	GUEST_ASSERT_EQ(data->vmcb12_gpat_after_exit, L2_PAT_MODIFIED);
+
+	data->l1_pat_after_vmexit = rdmsr(MSR_IA32_CR_PAT);
+	GUEST_ASSERT_EQ(data->l1_pat_after_vmexit, L1_PAT_VALUE);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_saverestore(struct svm_test_data *svm,
+				    struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb;
+
+	vmcb = l1_common_setup(svm, data, l2_guest_code_saverestoretest,
+			       &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+	GUEST_ASSERT_EQ(vmcb->save.g_pat, L2_PAT_MODIFIED);
+
+	GUEST_DONE();
+}
+
+static void l1_svm_code_multi_vmentry(struct svm_test_data *svm,
+				      struct pat_test_data *data)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb;
+
+	vmcb = l1_common_setup(svm, data, l2_guest_code_multi_vmentry,
+			       &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+
+	GUEST_ASSERT_EQ(data->l2_pat_after_write, L2_PAT_MODIFIED);
+	GUEST_ASSERT_EQ(vmcb->save.g_pat, L2_PAT_MODIFIED);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	vmcb->save.rip += 3;  /* vmmcall */
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	GUEST_ASSERT(data->l2_done);
+	GUEST_ASSERT_EQ(data->l2_pat_read, L2_PAT_MODIFIED);
+	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
+
+	GUEST_DONE();
+}
+
+static void run_test(void *l1_code, const char *test_name, bool npt_enabled,
+		     bool do_save_restore)
+{
+	struct pat_test_data *data_hva;
+	vm_vaddr_t svm_gva, data_gva;
+	struct kvm_x86_state *state;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	pr_info("Testing: %s\n", test_name);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_code);
+	vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
+		      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+	if (npt_enabled)
+		vm_enable_npt(vm);
+
+	vcpu_alloc_svm(vm, &svm_gva);
+
+	data_gva = vm_vaddr_alloc_page(vm);
+	data_hva = addr_gva2hva(vm, data_gva);
+	memset(data_hva, 0, sizeof(*data_hva));
+
+	if (npt_enabled)
+		tdp_identity_map_default_memslots(vm);
+
+	vcpu_args_set(vcpu, 2, svm_gva, data_gva);
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
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
+		     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
+
+	run_test(l1_svm_code_npt_disabled, "nested NPT disabled", false, false);
+
+	run_test(l1_svm_code_invalid_gpat, "invalid g_pat", true, false);
+
+	run_test(l1_svm_code_npt_enabled, "nested NPT enabled", true, false);
+
+	run_test(l1_svm_code_saverestore, "save/restore", true, true);
+
+	run_test(l1_svm_code_multi_vmentry, "multiple entries", true, false);
+
+	return 0;
+}
-- 
2.53.0.1018.g2bb0e51243-goog


Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB2397688
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779492430; cv=none; b=iK6+WMXt55TzmrBFeBCf0eC3x5b+7ZuhOpF9DWcNOMFVdUJ+jvwKgAghUW4zzUDuUgOKeDm6KqSYEwgWurvUqLvizBc15/XvOkSWjAfTrHcHUh2V4LRMN67+tZ+FWz6L2963/4qAce1fgwjSxzTinEkunR2xuwqOoLpHnSHCYys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779492430; c=relaxed/simple;
	bh=Yk8d51k2KEvSQa3bEY3ZmVW7akAyseGfnqCOpB1rCtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rKaiAIPwIKRD97MGk4l6QgkSlSZVdx6EVjENDQ7SpNxUmWrmw6OM6n1hyYiBUjFHFoL9GF0obd6saNC3Icx15IBoTSWn7yoMM1ktfMvzkQP2WF1chokWUWIXW5jEHtYoUsWGJq1eM53kCdgvpvxSFJUKcM73mgk2774qvsulOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mM4xOAn7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mM4xOAn7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so78887415ad.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 16:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779492428; x=1780097228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xjZlVRSbkNxFG74UY3S/ZMtgusKOWOlshHLNu65IK0Y=;
        b=mM4xOAn72781LX5XpfTcvQwjB+WLhW+Rmrua9AmnrijASHt38v5vpssJ4SyzIbrl23
         uwdvGQD+a2sOU93DSrDUU5k2Dc6oM2gP0knJ1KU0ojIPaa0Zp9WKpuJe/LuSzU9GlSuc
         yBA/13kzuijPKW7a736RsaqERc2SJlbZRrmFKR7Jmp8Gb20RpL8RVdXfie+l12iyLHoX
         kHoqp7LQz13z6iE9JgoaYM8YQbp3laute/GNYiU1Gweqv4iDV7wF2SKJVSQ/ca6h95bI
         lGpY5ksjTxzgf3LGWSQTM4yiUFZyFYrHGegyEuAEtqHZ9eqJqCZ4AwqQLounfEYvKD7W
         KOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779492428; x=1780097228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjZlVRSbkNxFG74UY3S/ZMtgusKOWOlshHLNu65IK0Y=;
        b=hMs3TYKp5rBhfKRlYu1DdSsjM7LgRn1GdyQcV3PTdNMyNwtTv8JIsFmoBRec5JJRk6
         ihLAAgPL9QApXDhQYTCLO78jTTWes8nEmeSQATtkWujqQt6Om8m4ALNsb+7Tu2gO1d+k
         SYWrWJ+n1jB6ErBhHharqaS06hPINfcZpZyn0mXVcInP51bPA7HUBMFdJoxd+bWBssVC
         GYC3Al+tMnl+o0q7yV2OcEdTjq8zxvdJTFInXNExohBs8B6g9FTS1zAW4kibpCYtX0te
         p/JEYuT4R4wA8sVIjW9rfntYI86s+V83g+rCEB8ktfgoXQjKpVzie/Gau1lwJ5ZeeDMk
         NnoA==
X-Gm-Message-State: AOJu0YwM5lCYZXAQbjdPGda3yS7DI6fb4jyXVRvhWwPZVRsRBqzJsxLQ
	TWUq7kdDqQ9FxTv9Fpw83CPzVFUHXpuyBo2i65CHRQseMBtQd9yDFD+UuZaGjCUjWSJIEo6TUUj
	5QWOGKg==
X-Received: from pgee26.prod.google.com ([2002:a63:1e1a:0:b0:c79:788d:5b72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f05:b0:2be:1eb1:eaf7
 with SMTP id d9443c01a7336-2beb05b5f70mr63466925ad.24.1779492428028; Fri, 22
 May 2026 16:27:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 16:27:01 -0700
In-Reply-To: <20260522232701.3671446-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522232701.3671446-6-seanjc@google.com>
Subject: [PATCH v4 5/5] KVM: selftests: Add nested page fault injection test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kevin Cheng <chengkev@google.com>

Add a test that exercises nested page fault injection during L2
execution. L2 executes I/O string instructions (OUTSB/INSB) that access
memory restricted in L1's nested page tables (NPT/EPT), triggering a
nested page fault that L0 must inject to L1.

The test supports both AMD SVM (NPF) and Intel VMX (EPT violation) and
verifies that:
  - The exit reason is an NPF/EPT violation
  - The access type and permission bits are correct
  - The faulting GPA is correct

Three test cases are implemented:
  - Unmap the final data page (final translation fault, OUTSB read)
  - Unmap a PT page (page walk fault, OUTSB read)
  - Write-protect the final data page (protection violation, INSB write)
  - Write-protect a PT page (protection violation on A/D update, OUTSB
    read)

Signed-off-by: Kevin Cheng <chengkev@google.com>
[sean: name it nested_tdp_fault_test, consolidate asserts]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   9 +
 .../selftests/kvm/x86/nested_tdp_fault_test.c | 313 ++++++++++++++++++
 3 files changed, 323 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 82fa943b9503..2908eca1647a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -97,6 +97,7 @@ TEST_GEN_PROGS_x86 += x86/nested_emulation_test
 TEST_GEN_PROGS_x86 += x86/nested_exceptions_test
 TEST_GEN_PROGS_x86 += x86/nested_invalid_cr3_test
 TEST_GEN_PROGS_x86 += x86/nested_set_state_test
+TEST_GEN_PROGS_x86 += x86/nested_tdp_fault_test
 TEST_GEN_PROGS_x86 += x86/nested_tsc_adjust_test
 TEST_GEN_PROGS_x86 += x86/nested_tsc_scaling_test
 TEST_GEN_PROGS_x86 += x86/nested_vmsave_vmload_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 851ffcd3340c..06878e7c7347 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1573,6 +1573,15 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa);
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(PFERR_GUEST_PAGE_BIT)
 #define PFERR_IMPLICIT_ACCESS	BIT_ULL(PFERR_IMPLICIT_ACCESS_BIT)
 
+#define EPT_VIOLATION_ACC_READ		BIT(0)
+#define EPT_VIOLATION_ACC_WRITE		BIT(1)
+#define EPT_VIOLATION_ACC_INSTR		BIT(2)
+#define EPT_VIOLATION_PROT_READ		BIT(3)
+#define EPT_VIOLATION_PROT_WRITE	BIT(4)
+#define EPT_VIOLATION_PROT_EXEC		BIT(5)
+#define EPT_VIOLATION_GVA_IS_VALID	BIT(7)
+#define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)
+
 bool sys_clocksource_is_based_on_tsc(void);
 
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
new file mode 100644
index 000000000000..fa95568f55ff
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_tdp_fault_test.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025, Google, Inc.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "vmx.h"
+
+#define L2_GUEST_STACK_SIZE 64
+
+enum test_type {
+	TEST_FINAL_PAGE_UNMAPPED,	    /* Final data page not present */
+	TEST_PT_PAGE_UNMAPPED,		    /* Page table page not present */
+	TEST_FINAL_PAGE_WRITE_PROTECTED,    /* Final data page read-only */
+	TEST_PT_PAGE_WRITE_PROTECTED,	    /* Page table page read-only */
+};
+
+static gva_t l2_test_page;
+static void (*l2_entry)(void);
+
+#define TEST_IO_PORT 0x80
+#define TEST1_VADDR 0x8000000ULL
+#define TEST2_VADDR 0x10000000ULL
+#define TEST3_VADDR 0x18000000ULL
+#define TEST4_VADDR 0x20000000ULL
+
+/*
+ * L2 executes OUTS reading from l2_test_page, triggering a nested page
+ * fault on the read access.
+ */
+static void l2_guest_code_outs(void)
+{
+	asm volatile("outsb" ::"S"(l2_test_page), "d"(TEST_IO_PORT) : "memory");
+	GUEST_FAIL("L2 should not reach here");
+}
+
+/*
+ * L2 executes INS writing to l2_test_page, triggering a nested page
+ * fault on the write access.
+ */
+static void l2_guest_code_ins(void)
+{
+	asm volatile("insb" ::"D"(l2_test_page), "d"(TEST_IO_PORT) : "memory");
+	GUEST_FAIL("L2 should not reach here");
+}
+
+#define GUEST_ASSERT_EXIT_QUAL(ac_eq, ex_eq)		\
+	__GUEST_ASSERT((ac_eq) == (ex_eq),		\
+		       "Wanted EXIT_QUAL '0x%lx', got '0x%lx'", ex_eq, ac_eq)
+
+static void l1_vmx_code(struct vmx_pages *vmx, u64 expected_fault_gpa,
+			u64 test_type)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	u64 exit_qual;
+
+	GUEST_ASSERT(vmx->vmcs_gpa);
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	GUEST_ASSERT(load_vmcs(vmx));
+
+	prepare_vmcs(vmx, l2_entry, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	GUEST_ASSERT(!vmlaunch());
+
+	/* Verify we got an EPT violation exit */
+	__GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_EPT_VIOLATION,
+		       "Expected EPT violation (0x%x), got 0x%lx",
+		       EXIT_REASON_EPT_VIOLATION,
+		       vmreadz(VM_EXIT_REASON));
+
+	__GUEST_ASSERT(vmreadz(GUEST_PHYSICAL_ADDRESS) == expected_fault_gpa,
+		       "Expected guest_physical_address = 0x%lx, got 0x%lx",
+		       expected_fault_gpa,
+		       vmreadz(GUEST_PHYSICAL_ADDRESS));
+
+	exit_qual = vmreadz(EXIT_QUALIFICATION);
+
+	/*
+	 * Note, EPT page table accesses are always read+write, e.g. so that
+	 * the CPU can do A/D updates at-will.
+	 */
+	switch (test_type) {
+	case TEST_FINAL_PAGE_UNMAPPED:
+		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_READ |
+						  EPT_VIOLATION_GVA_IS_VALID |
+						  EPT_VIOLATION_GVA_TRANSLATED);
+		break;
+	case TEST_PT_PAGE_UNMAPPED:
+		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_READ |
+						  EPT_VIOLATION_ACC_WRITE |
+						  EPT_VIOLATION_GVA_IS_VALID);
+		break;
+	case TEST_FINAL_PAGE_WRITE_PROTECTED:
+		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_WRITE |
+						  EPT_VIOLATION_PROT_READ |
+						  EPT_VIOLATION_PROT_EXEC |
+						  EPT_VIOLATION_GVA_IS_VALID |
+						  EPT_VIOLATION_GVA_TRANSLATED);
+		break;
+	case TEST_PT_PAGE_WRITE_PROTECTED:
+		GUEST_ASSERT_EXIT_QUAL(exit_qual, EPT_VIOLATION_ACC_READ |
+						  EPT_VIOLATION_ACC_WRITE |
+						  EPT_VIOLATION_PROT_READ |
+						  EPT_VIOLATION_PROT_EXEC |
+						  EPT_VIOLATION_GVA_IS_VALID);
+		break;
+	}
+
+	GUEST_DONE();
+}
+
+#define GUEST_ASSERT_NPF_EC(ac_ec, ex_ec)		\
+	__GUEST_ASSERT((ac_ec) == (ex_ec),		\
+		       "Wanted NPF error code '0x%lx', got '0x%lx'", (u64)(ex_ec), ac_ec)
+
+
+static void l1_svm_code(struct svm_test_data *svm, u64 expected_fault_gpa,
+			 u64 test_type)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	struct vmcb *vmcb = svm->vmcb;
+	u64 exit_info_1;
+
+	generic_svm_setup(svm, l2_entry,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	/* Verify we got an NPF exit */
+	__GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_NPF,
+		       "Expected NPF exit (0x%x), got 0x%lx", SVM_EXIT_NPF,
+		       vmcb->control.exit_code);
+
+	__GUEST_ASSERT(vmcb->control.exit_info_2 == expected_fault_gpa,
+		       "Expected exit_info_2 = 0x%lx, got 0x%lx",
+		       expected_fault_gpa,
+		       vmcb->control.exit_info_2);
+
+	exit_info_1 = vmcb->control.exit_info_1;
+
+	/*
+	 * Note, without GMET enabled, NPT walks are always user accesses.  And
+	 * like EPT, page table accesses are always read+write.
+	 */
+	switch (test_type) {
+	case TEST_FINAL_PAGE_UNMAPPED:
+		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_USER_MASK |
+						 PFERR_GUEST_FINAL_MASK);
+		break;
+	case TEST_PT_PAGE_UNMAPPED:
+		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_WRITE_MASK |
+						 PFERR_USER_MASK |
+						 PFERR_GUEST_PAGE_MASK);
+		break;
+	case TEST_FINAL_PAGE_WRITE_PROTECTED:
+		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_PRESENT_MASK |
+						 PFERR_WRITE_MASK |
+						 PFERR_USER_MASK |
+						 PFERR_GUEST_FINAL_MASK);
+		break;
+	case TEST_PT_PAGE_WRITE_PROTECTED:
+		GUEST_ASSERT_NPF_EC(exit_info_1, PFERR_PRESENT_MASK |
+						 PFERR_WRITE_MASK |
+						 PFERR_USER_MASK |
+						 PFERR_GUEST_PAGE_MASK);
+		break;
+	}
+
+	GUEST_DONE();
+}
+
+static void l1_guest_code(void *data, u64 expected_fault_gpa,
+			  u64 test_type)
+{
+	if (this_cpu_has(X86_FEATURE_VMX))
+		l1_vmx_code(data, expected_fault_gpa, test_type);
+	else
+		l1_svm_code(data, expected_fault_gpa, test_type);
+}
+
+/* Returns the GPA of the PT page that maps @vaddr. */
+static u64 get_pt_gpa_for_vaddr(struct kvm_vm *vm, u64 vaddr)
+{
+	u64 *pte;
+
+	pte = vm_get_pte(vm, vaddr);
+	TEST_ASSERT(pte && (*pte & 0x1), "PTE not present for vaddr 0x%lx",
+		    (unsigned long)vaddr);
+
+	return addr_hva2gpa(vm, (void *)((u64)pte & ~0xFFFULL));
+}
+
+static void run_test(enum test_type type)
+{
+	gpa_t expected_fault_gpa;
+	gva_t nested_gva;
+
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm_enable_tdp(vm);
+
+	if (kvm_cpu_has(X86_FEATURE_VMX))
+		vcpu_alloc_vmx(vm, &nested_gva);
+	else
+		vcpu_alloc_svm(vm, &nested_gva);
+
+	switch (type) {
+	case TEST_FINAL_PAGE_UNMAPPED:
+		/*
+		 * Unmap the final data page from NPT/EPT. The guest page
+		 * table walk succeeds, but the final GPA->HPA translation
+		 * fails. L2 reads from the page via OUTS.
+		 */
+		l2_entry = l2_guest_code_outs;
+		l2_test_page = vm_alloc(vm, vm->page_size, TEST1_VADDR);
+		expected_fault_gpa = addr_gva2gpa(vm, l2_test_page);
+		break;
+	case TEST_PT_PAGE_UNMAPPED:
+		/*
+		 * Unmap a page table page from NPT/EPT. The hardware page
+		 * table walk fails when translating the PT page's GPA
+		 * through NPT/EPT. L2 reads from the page via OUTS.
+		 */
+		l2_entry = l2_guest_code_outs;
+		l2_test_page = vm_alloc(vm, vm->page_size, TEST2_VADDR);
+		expected_fault_gpa = get_pt_gpa_for_vaddr(vm, l2_test_page);
+		break;
+	case TEST_FINAL_PAGE_WRITE_PROTECTED:
+		/*
+		 * Write-protect the final data page in NPT/EPT.  The page
+		 * is present and readable, but not writable.  L2 writes to
+		 * the page via INS, triggering a protection violation.
+		 */
+		l2_entry = l2_guest_code_ins;
+		l2_test_page = vm_alloc(vm, vm->page_size, TEST3_VADDR);
+		expected_fault_gpa = addr_gva2gpa(vm, l2_test_page);
+		break;
+	case TEST_PT_PAGE_WRITE_PROTECTED:
+		/*
+		 * Write-protect a page table page in NPT/EPT.  The page is
+		 * present and readable, but not writable.  The guest page
+		 * table walk needs write access to set A/D bits, so it
+		 * triggers a protection violation on the PT page.
+		 * L2 reads from the page via OUTS.
+		 */
+		l2_entry = l2_guest_code_outs;
+		l2_test_page = vm_alloc(vm, vm->page_size, TEST4_VADDR);
+		expected_fault_gpa = get_pt_gpa_for_vaddr(vm, l2_test_page);
+		break;
+	}
+
+	tdp_identity_map_default_memslots(vm);
+
+	if (type == TEST_FINAL_PAGE_WRITE_PROTECTED ||
+	    type == TEST_PT_PAGE_WRITE_PROTECTED)
+		*tdp_get_pte(vm, expected_fault_gpa) &= ~PTE_WRITABLE_MASK(&vm->stage2_mmu);
+	else
+		*tdp_get_pte(vm, expected_fault_gpa) &= ~(PTE_PRESENT_MASK(&vm->stage2_mmu) |
+							   PTE_READABLE_MASK(&vm->stage2_mmu) |
+							   PTE_WRITABLE_MASK(&vm->stage2_mmu) |
+							   PTE_EXECUTABLE_MASK(&vm->stage2_mmu));
+
+	sync_global_to_guest(vm, l2_entry);
+	sync_global_to_guest(vm, l2_test_page);
+	vcpu_args_set(vcpu, 3, nested_gva, expected_fault_gpa, (u64)type);
+
+	/*
+	 * For the INS-based write test, KVM emulates the instruction and
+	 * first reads from the I/O port, which exits to userspace.
+	 * Re-enter the guest so emulation can proceed to the memory
+	 * write, where the nested page fault is triggered.
+	 */
+	for (;;) {
+		vcpu_run(vcpu);
+
+		if (vcpu->run->exit_reason == KVM_EXIT_IO &&
+		    vcpu->run->io.port == TEST_IO_PORT &&
+		    vcpu->run->io.direction == KVM_EXIT_IO_IN) {
+			continue;
+		}
+		break;
+	}
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected exit reason: %d", vcpu->run->exit_reason);
+	}
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) || kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has_tdp());
+
+	run_test(TEST_FINAL_PAGE_UNMAPPED);
+	run_test(TEST_PT_PAGE_UNMAPPED);
+	run_test(TEST_FINAL_PAGE_WRITE_PROTECTED);
+	run_test(TEST_PT_PAGE_WRITE_PROTECTED);
+
+	return 0;
+}
-- 
2.54.0.794.g4f17f83d09-goog


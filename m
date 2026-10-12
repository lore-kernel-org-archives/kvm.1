Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1854195C0;
	Mon, 12 Oct 2026 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848222; cv=none; b=LXiNOPFgvusbTl5f8h+y8oGbj61iV5rEOzAXSdbpRGln+0bbvhUxPrRjB7i3154Sz4ROaLpv4DJEM6a+ChL/DvCcY82+da9H6zqShxozDntQa+jSg5NC4OT221wBGazI58mg1yTkVxeCFb/awUp5kTqUP6kDRLdqz54FUGoHJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848222; c=relaxed/simple;
	bh=BZwv15zs720ZXOZKHAc/jYBHfQk/oKd7ME0PV/SMTLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVj7xEErCJLHg/Vepd1D1kCrq9UxSeNWPtOOREr4cwKbg5MSl0q0/3aOpBol6076FeebvxEfh+oUd8vKQOUqD+kSEW2XpEvGpAgRRO15Oh2cyRzsq4iBDe4I7l9R/XZos82mrw5WvpqeRprLvvEcgairDqAXEFGiLXsxBHwsUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSxmRMWe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSxmRMWe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA31F008A1;
	Mon, 12 Oct 2026 23:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848219;
	bh=g3mbmAcRYzoKs7ahhyUSj+o4HNBwzBI580JgyUE/mkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSxmRMWe9F+cfZGtQ0NyX+GlpAKvxWzcOlBNLukJhP94dbTLl+nqjU5KYn8ZkIJRj
	 M0PVeNlxKFy7E95/rKPX7yCH24XFhc5AwsjeGDvwVszw6017GTwu70TLo+q8cA3wA7
	 8dF4yc+TEcgfp07UzdRaY46aWxShu4r+sJ3wLt/BuLUToGcLGCiXNuTxuBffbtJKRt
	 Hge7n8b/qOF+FWl5QBITZAVyvwM6uEElApDeI1p3pg6doo0BWBH+oYQG1cfj2+IJLC
	 J9Zl94H8geWJ/4qNJ//9QPsBzkVtXi6fJED7vE4O5H4bQQA7jX2I0g3LNcYe8hgi8X
	 XL7GFw1JPnbBA==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 27/27] KVM: selftests: Add a test for nested TLB flushes
Date: Mon, 12 Oct 2026 23:36:38 +0000
Message-ID: <20261012233638.2546339-28-yosry@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261012233638.2546339-1-yosry@kernel.org>
References: <20261012233638.2546339-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test that exercises most common scenarios for TLB flushes. The
test is split into two testing scenarios:
1. Guest-triggered TLB flushes
2. KVM-triggered TLB flushes

For (1), the test runs an L1 guest that keeps switching an L2 PTE (or
TDP PTE) between two GPAs, flushes the TLB, and runs L2 to check that
accessing that address accesses the correct page. A missed TLB flush
causes L2 to access the wrong GPA through a stale TLB entry. The test
exercises multiple ways for L1 to flush the TLB, including changing L2's
ASID/VPID, flushing L2's entire ASID/VPID/EPTP, or flushing an
individual L2 GVA (using INVLPGA/INVVPID) when L1 does not enable TDP.

On AMD, the test also checks that an ASID flush (or an ASID change)
flushes shadow NPT mappings for all nCR3 roots, not just the current
one, by using multiple nested NPT trees.

For (2), the test creates a memslot with 2 pages, and keeps moving the
base GPA of the memslot between a TEST_GPA and TEST_GPA - PAGE_SIZE,
essentially resulting in the TEST_GPA being switched between two
underlying HPAs. KVM should flush the TLB for both L1 and L2 contexts
when updating a GPA -> HPA mapping.

The test runs an L1 guest that verifies access to page 1, triggers the
memslot move, and checks that both L1 and L2 now (correctly) access
page 2. This verifies that a TLB flush in L1's context flushes the TLB
for both L1 and L2. After that, the test does the opposite and triggers
the memslot move from L2, to double check that a TLB flush in L2's
context flushes the TLB for both L1 and L2.

The test runs various test cases with TDP on/off in L1, and actually
catches multiple injected bugs (in SVM), including:
- Missing the TLB flush on nested VM-Enter if ASID12 changes.
- Missing the TLB flush on nested VM-Enter if L1 uses
  TLB_CONTROL_FLUSH_ASID.
- Missing the nested NPT resync on nested VM-Enter if L1 uses
  TLB_CONTROL_FLUSH_ASID with nested NPT enabled.
- Missing the TLB flush when emulating INVLPGA.
- Missing flushing both L1 and L2 ASIDs when handling KVM_REQ_TLB_FLUSH.

Assisted-by: LLM
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   5 +
 tools/testing/selftests/kvm/include/x86/vmx.h |  21 +
 .../testing/selftests/kvm/lib/x86/processor.c |  36 ++
 .../selftests/kvm/x86/nested_tlb_flush_test.c | 526 ++++++++++++++++++
 6 files changed, 590 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index be5eb2dd85aa2..5347c56786b08 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -122,6 +122,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
+TEST_GEN_PROGS_x86 += x86/nested_tlb_flush_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index ffec2291b1e1f..62d255aee5a34 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1617,6 +1617,7 @@ void tdp_map(struct kvm_vm *vm, gpa_t l2_gpa, gpa_t gpa, u64 size);
 void tdp_identity_map_default_memslots(struct kvm_vm *vm);
 void tdp_identity_map_1g(struct kvm_vm *vm,  u64 addr, u64 size);
 u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa);
+gpa_t tdp_copy_page_tables(struct kvm_vm *vm);
 
 /*
  * Basic CPU control in CR0
diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
index c8539166270ea..d2a6bf8503f78 100644
--- a/tools/testing/selftests/kvm/include/x86/svm.h
+++ b/tools/testing/selftests/kvm/include/x86/svm.h
@@ -316,4 +316,9 @@ struct __attribute__ ((__packed__)) vmcb {
 
 #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
 
+static inline void invlpga(unsigned long addr, u32 asid)
+{
+	asm volatile("invlpga %0, %1" : : "a"(addr), "c"(asid) : "memory");
+}
+
 #endif /* SELFTEST_KVM_SVM_H */
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 8fd97434eee5c..4f2a0e3ac5ba1 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -518,4 +518,25 @@ static inline bool kvm_cpu_has_vmx_virtualize_apic_accesses(void)
 void vm_enable_ept(struct kvm_vm *vm);
 void prepare_virtualize_apic_accesses(struct vmx_pages *vmx, struct kvm_vm *vm);
 
+static inline void invvpid(unsigned long ext, u16 vpid, gva_t gva)
+{
+	struct {
+		u64 vpid : 16;
+		u64 rsvd : 48;
+		u64 gva;
+	} operand = { vpid, 0, gva };
+
+	asm volatile("invvpid %0, %1" : : "m"(operand), "r"(ext) : "memory");
+}
+
+static inline void invept(unsigned long ext, u64 eptp)
+{
+	struct {
+		u64 eptp;
+		u64 rsvd;
+	} operand = { eptp, 0 };
+
+	asm volatile("invept %0, %1" : : "m"(operand), "r"(ext) : "memory");
+}
+
 #endif /* SELFTEST_KVM_VMX_H */
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 8374afd08bafe..57ecf8b381b5a 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -554,6 +554,42 @@ void tdp_identity_map_1g(struct kvm_vm *vm, u64 addr, u64 size)
 	__tdp_map(vm, addr, addr, size, PG_LEVEL_1G);
 }
 
+static gpa_t __virt_copy_page_tables(struct kvm_vm *vm, struct kvm_mmu *mmu,
+				     gpa_t table_gpa, int level)
+{
+	gpa_t copy_gpa = vm_alloc_page_table(vm);
+	u64 *copy = addr_gpa2hva(vm, copy_gpa);
+	gpa_t pa;
+	int i;
+
+	memcpy(copy, addr_gpa2hva(vm, table_gpa), vm->page_size);
+	if (level == PG_LEVEL_4K)
+		return copy_gpa;
+
+	for (i = 0; i < vm->page_size / sizeof(u64); i++) {
+		if (!is_present_pte(mmu, &copy[i]) || is_huge_pte(mmu, &copy[i]))
+			continue;
+
+		/* Clear only the address bits, preserving C/S bits and flags */
+		pa = vm_untag_gpa(vm, PTE_GET_PA(copy[i]));
+		copy[i] &= ~pa;
+		copy[i] |= __virt_copy_page_tables(vm, mmu, pa, level - 1);
+	}
+	return copy_gpa;
+}
+
+/*
+ * Deep copy all levels of the TDP page tables, such that no page table pages
+ * are shared with the original.  Returns the GPA of the new root.
+ */
+gpa_t tdp_copy_page_tables(struct kvm_vm *vm)
+{
+	struct kvm_mmu *mmu = &vm->stage2_mmu;
+
+	TEST_ASSERT(mmu->pgd_created, "TDP page tables not created");
+	return __virt_copy_page_tables(vm, mmu, mmu->pgd, mmu->pgtable_levels);
+}
+
 /*
  * Set Unusable Segment
  *
diff --git a/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
new file mode 100644
index 0000000000000..fb32b7bf6b19f
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
@@ -0,0 +1,526 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Test TLB flushes with nested virtualization across three cases:
+ * 1. When L1 updates L2's (shadow) page tables
+ * 2. When L1 updates nested TDP
+ * 3. When KVM updates mappings on the host (KVM-induced TLB flushes)
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
+#include "vmx.h"
+
+#define NR_ITERATIONS	100
+
+#define VAL1		0x11111111ULL
+#define VAL2		0x22222222ULL
+
+#define TEST_VADDR	0x10000000ULL
+#define TEST_GPA	0x30000000ULL
+#define TEST_NESTED_GPA	0x40000000ULL
+
+#define TEST_MEMSLOT	10
+
+#define SYNC_MOVE_MEMSLOT 1
+
+enum guest_flush_method {
+	TLB_FLUSH_TAG = 0,
+	TLB_FLUSH_VADDR,
+	TLB_CHANGE_TAG,
+	TLB_FLUSH_NONE,
+};
+
+static u64 *pte_gva;
+static gpa_t test_gpa[2];
+static enum guest_flush_method flush_method;
+static u32 max_asid;
+
+/* TDP roots for the multi-root test, root 1 is a non-aliasing copy of root 0 */
+static gpa_t tdp_root_gpa[2];
+/* Value L2 expects at TEST_VADDR, 0 if L2 shouldn't access TEST_VADDR */
+static u64 l2_expected_val;
+
+static void svm_tlb_flush(struct svm_test_data *svm,
+			  enum guest_flush_method method)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	switch (method) {
+	case TLB_CHANGE_TAG:
+		vmcb->control.asid++;
+		vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+		if (vmcb->control.asid >= max_asid) {
+			vmcb->control.asid = 1;
+			vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
+		}
+		break;
+	case TLB_FLUSH_TAG:
+		vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ASID;
+		break;
+	case TLB_FLUSH_VADDR:
+		GUEST_ASSERT(!svm->ncr3_gpa);
+		vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+		invlpga(TEST_VADDR, vmcb->control.asid);
+		break;
+	case TLB_FLUSH_NONE:
+		vmcb->control.tlb_ctl = TLB_CONTROL_DO_NOTHING;
+		break;
+	}
+}
+
+static void vmx_tlb_flush(struct vmx_pages *vmx, enum guest_flush_method method)
+{
+	u16 vpid = vmread(VIRTUAL_PROCESSOR_ID);
+
+	switch (method) {
+	case TLB_CHANGE_TAG:
+		GUEST_ASSERT(!vmx->eptp_gpa);
+		vmwrite(VIRTUAL_PROCESSOR_ID, vpid + 1);
+		break;
+	case TLB_FLUSH_TAG:
+		if (vmx->eptp_gpa)
+			invept(1, vmread(EPT_POINTER));
+		else
+			invvpid(1, vpid, 0);
+		break;
+	case TLB_FLUSH_VADDR:
+		GUEST_ASSERT(!vmx->eptp_gpa);
+		invvpid(0, vpid, TEST_VADDR);
+		break;
+	case TLB_FLUSH_NONE:
+		break;
+	}
+}
+
+static void prepare_l2(void *nested_state, void *l2_guest_code)
+{
+	struct vmx_pages *vmx = nested_state;
+
+	if (this_cpu_has(X86_FEATURE_VMX)) {
+		u32 sec_exec_ctl;
+
+		prepare_for_vmx_operation(vmx);
+		load_vmcs(vmx);
+		prepare_vmcs(vmx, l2_guest_code);
+
+		/* Enable VPID */
+		sec_exec_ctl = vmread(SECONDARY_VM_EXEC_CONTROL);
+		sec_exec_ctl |= SECONDARY_EXEC_ENABLE_VPID;
+		vmwrite(SECONDARY_VM_EXEC_CONTROL, sec_exec_ctl);
+		vmwrite(VIRTUAL_PROCESSOR_ID, 1);
+	} else {
+		generic_svm_setup(nested_state, l2_guest_code);
+	}
+}
+
+static void __run_l2(void *nested_state, bool launch,
+		     enum guest_flush_method method)
+{
+	struct svm_test_data *svm;
+
+	if (this_cpu_has(X86_FEATURE_VMX)) {
+		vmx_tlb_flush(nested_state, method);
+		if (launch)
+			vmlaunch();
+		else
+			vmresume();
+		GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+		vmwrite(GUEST_RIP, vmread(GUEST_RIP) + 3); /* skip over VMCALL */
+	} else {
+		svm = nested_state;
+		svm_tlb_flush(svm, method);
+		run_guest(svm->vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+		svm->vmcb->save.rip += 3; /* skip over VMMCALL */
+	}
+}
+
+static void run_l2(void *nested_state, bool launch)
+{
+	__run_l2(nested_state, launch, flush_method);
+}
+
+static void l2_guest_code(void)
+{
+	u64 expected_val;
+
+	for (;;) {
+		expected_val = READ_ONCE(l2_expected_val);
+		if (expected_val)
+			GUEST_ASSERT_EQ(READ_ONCE(*(u64 *)TEST_VADDR), expected_val);
+		vmcall();
+	}
+}
+
+static void l1_guest_code(void *data)
+{
+	gpa_t gpa;
+	int i;
+
+	prepare_l2(data, l2_guest_code);
+
+	/*
+	 * Alternately switch the PTE (or TDP PTE) mapping TEST_VADDR between
+	 * two pages containing VAL1 and VAL2, flush TLBs, and verify that L2
+	 * reads the expected value.
+	 */
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		gpa = test_gpa[i % 2];
+
+		*pte_gva &= ~PHYSICAL_PAGE_MASK;
+		*pte_gva |= gpa & PHYSICAL_PAGE_MASK;
+
+		WRITE_ONCE(l2_expected_val, (i % 2 == 0) ? VAL1 : VAL2);
+		run_l2(data, i == 0);
+	}
+
+	GUEST_DONE();
+}
+
+/*
+ * Verify that flushing L2's ASID invalidates nested TDP translations for all
+ * TDP roots, not just the one in use at the time of the flush.  L1 updates the
+ * nested TDP PTE for TEST_VADDR in root 0, flushes L2's ASID while running L2
+ * with root 1, then runs L2 with root 0 *without* flushing.  L2 must observe
+ * the new mapping, as the flush invalidated all translations for the ASID.
+ *
+ * Root 1 is a full copy of root 0, such that none of the nested TDP pages are
+ * shared, i.e. KVM's shadow pages for root 0 are not reachable through the
+ * shadow root for root 1.
+ */
+static void l1_guest_code_multi_tdp_root(void *data)
+{
+	struct svm_test_data *svm = data;
+	struct vmcb *vmcb = svm->vmcb;
+	int i;
+
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_SVM));
+	GUEST_ASSERT_EQ(svm->ncr3_gpa, tdp_root_gpa[0]);
+
+	prepare_l2(data, l2_guest_code);
+
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		*pte_gva &= ~PHYSICAL_PAGE_MASK;
+		*pte_gva |= test_gpa[i % 2] & PHYSICAL_PAGE_MASK;
+
+		/* Flush L2's ASID (per flush_method) while using root 1 */
+		vmcb->control.nested_cr3 = tdp_root_gpa[1];
+		WRITE_ONCE(l2_expected_val, 0);
+		run_l2(data, i == 0);
+
+		/* Switch back to root 0 without flushing */
+		vmcb->control.nested_cr3 = tdp_root_gpa[0];
+		WRITE_ONCE(l2_expected_val, (i % 2 == 0) ? VAL1 : VAL2);
+		__run_l2(data, false, TLB_FLUSH_NONE);
+	}
+
+	GUEST_DONE();
+}
+
+static void prep_guest_flush_test(struct kvm_vm *vm, bool tdp_enabled,
+				  bool copy_tdp_root)
+{
+	gva_t page_gva[2], pte_map_gva;
+	gpa_t pte_gpa;
+	u64 *ptep;
+
+	/*
+	 * Allocate two pages in the VM and initialize them with different
+	 * values. L1 will update the mappings to switch between these pages and
+	 * L2 will verify that the accessed value indicates the right page.
+	 */
+	page_gva[0] = vm_alloc_page(vm);
+	page_gva[1] = vm_alloc_page(vm);
+
+	*(u64 *)addr_gva2hva(vm, page_gva[0]) = VAL1;
+	*(u64 *)addr_gva2hva(vm, page_gva[1]) = VAL2;
+
+	test_gpa[0] = addr_gva2gpa(vm, page_gva[0]);
+	test_gpa[1] = addr_gva2gpa(vm, page_gva[1]);
+
+	if (tdp_enabled) {
+		virt_pg_map(vm, TEST_VADDR, TEST_NESTED_GPA);
+		tdp_map(vm, TEST_NESTED_GPA, test_gpa[0], vm->page_size);
+		ptep = tdp_get_pte(vm, TEST_NESTED_GPA);
+	} else {
+		virt_pg_map(vm, TEST_VADDR, test_gpa[0]);
+		ptep = vm_get_pte(vm, TEST_VADDR);
+	}
+
+	/*
+	 * Map the PTE (or TDP PTE) for TEST_VADDR, such that L1 can read and
+	 * update the mapping. Pass the PTE GVA to L1 to directly use it (rather
+	 * than L1 walking the page tables.
+	 */
+	pte_gpa = addr_hva2gpa(vm, ptep);
+	pte_map_gva = vm_unused_gva_gap(vm, vm->page_size, KVM_UTIL_MIN_VADDR);
+	virt_pg_map(vm, pte_map_gva, pte_gpa & PAGE_MASK);
+	pte_gva = (u64 *)(pte_map_gva + (pte_gpa & ~PAGE_MASK));
+
+	sync_global_to_guest(vm, pte_gva);
+	sync_global_to_guest(vm, test_gpa);
+
+	if (!tdp_enabled)
+		return;
+
+	/*
+	 * Must be done after all pages accessed by L2 are allocated, including
+	 * nested state (e.g. L2's stack) and page tables for TEST_VADDR.
+	 */
+	tdp_identity_map_default_memslots(vm);
+
+	/* Must be done after all TDP mappings are created */
+	if (copy_tdp_root) {
+		tdp_root_gpa[0] = vm->stage2_mmu.pgd;
+		tdp_root_gpa[1] = tdp_copy_page_tables(vm);
+		sync_global_to_guest(vm, tdp_root_gpa);
+	}
+}
+
+static void l2_guest_code_memslot_move(void)
+{
+	int i;
+	u64 val;
+
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		val = READ_ONCE(*(u64 *)TEST_VADDR);
+		GUEST_ASSERT_EQ(val, VAL1);
+
+		vmcall();
+
+		val = READ_ONCE(*(u64 *)TEST_VADDR);
+		GUEST_ASSERT_EQ(val, VAL2);
+
+		GUEST_SYNC2(SYNC_MOVE_MEMSLOT, 1);
+
+		val = READ_ONCE(*(u64 *)TEST_VADDR);
+		GUEST_ASSERT_EQ(val, VAL1);
+
+		vmcall();
+	}
+}
+
+static void l1_guest_code_memslot_move(void *data)
+{
+	int i;
+	u64 val;
+
+	prepare_l2(data, l2_guest_code_memslot_move);
+
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		/* Verify that accessing VADDR reads from page 1 in both L1 & L2 */
+		val = READ_ONCE(*(u64 *)TEST_VADDR);
+		GUEST_ASSERT_EQ(val, VAL1);
+
+		run_l2(data, i == 0);
+
+		/*
+		 * Update VADDR to point at page 2. KVM should flush both L1 and
+		 * L2's TLB translations so that further accesses go to page 2.
+		 */
+		GUEST_SYNC2(SYNC_MOVE_MEMSLOT, 2);
+
+		/*
+		 * Verify that accessing VADDR reads from page 2. A stale TLB
+		 * entry would lead to reading from page 1. Enter L2 and check
+		 * access to page 2, to verify that a TLB flush from L1's
+		 * context flushes both L1 and L2.
+		 */
+		val = READ_ONCE(*(u64 *)TEST_VADDR);
+		GUEST_ASSERT_EQ(val, VAL2);
+
+		run_l2(data, false);
+
+		/*
+		 * L2 updated VADDR to point at page 1 again. Verify access to
+		 * page 1 again to verify that a TLB flush from L2's context
+		 * flushes both L1 and L2 TLB translations.
+		 */
+		val = READ_ONCE(*(u64 *)TEST_VADDR);
+		GUEST_ASSERT_EQ(val, VAL1);
+	}
+
+	GUEST_DONE();
+}
+
+static void prep_memslot_move_test(struct kvm_vm *vm, bool tdp_enabled)
+{
+	/*
+	 * Disable KVM_X86_QUIRK_SLOT_ZAP_ALL. By default, moving a memslot
+	 * invalidates all MMU roots, which implicitly flushes the guest TLB
+	 * and masks missing TLB flush bugs. Disabling it forces KVM to keep
+	 * the same roots, relying solely on explicit TLB flushes.
+	 */
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) & KVM_X86_QUIRK_SLOT_ZAP_ALL);
+	vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2, KVM_X86_QUIRK_SLOT_ZAP_ALL);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    TEST_GPA, TEST_MEMSLOT,
+				    /*npages=*/2, /*flags=*/0);
+
+	virt_pg_map(vm, TEST_VADDR, TEST_GPA);
+
+	if (tdp_enabled)
+		tdp_map(vm, TEST_GPA, TEST_GPA, vm->page_size);
+
+	*(u64 *)addr_gpa2hva(vm, TEST_GPA) = VAL1;
+	*(u64 *)addr_gpa2hva(vm, TEST_GPA + vm->page_size) = VAL2;
+
+	/*
+	 * Must be done after all pages accessed by L2 are allocated, including
+	 * nested state (e.g. L2's stack) and page tables for TEST_VADDR.
+	 */
+	if (tdp_enabled)
+		tdp_identity_map_default_memslots(vm);
+}
+
+static void calc_max_svm_asid(void)
+{
+	const struct kvm_cpuid_entry2 *entry;
+
+	if (!kvm_cpu_has(X86_FEATURE_SVM))
+		return;
+
+	entry = get_cpuid_entry(kvm_get_supported_cpuid(), 0x8000000A, 0);
+	max_asid = entry ? entry->ebx : 0;
+}
+
+static void run_test(void *guest_code, bool tdp_enabled)
+{
+	struct kvm_vcpu *vcpu;
+	gva_t nested_gva = 0;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	if (tdp_enabled)
+		vm_enable_tdp(vm);
+
+	if (kvm_cpu_has(X86_FEATURE_VMX))
+		vcpu_alloc_vmx(vm, &nested_gva);
+	else
+		vcpu_alloc_svm(vm, &nested_gva);
+
+	if (guest_code == l1_guest_code_memslot_move)
+		prep_memslot_move_test(vm, tdp_enabled);
+	else if (guest_code == l1_guest_code_multi_tdp_root)
+		prep_guest_flush_test(vm, tdp_enabled, true);
+	else
+		prep_guest_flush_test(vm, tdp_enabled, false);
+
+	vcpu_args_set(vcpu, 1, nested_gva);
+
+	sync_global_to_guest(vm, flush_method);
+	sync_global_to_guest(vm, max_asid);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_SYNC:
+			/*
+			 * Move the base GPA of the memslot between TEST_GPA and
+			 * TEST_GPA - PAGE_SIZE. This effectively moves
+			 * TEST_VADDR to point at page 1 or page 2 in the
+			 * memslot.
+			 */
+			if (uc.args[0] == SYNC_MOVE_MEMSLOT) {
+				gpa_t new_gpa = (uc.args[1] == 1) ?
+					TEST_GPA : (TEST_GPA - vm->page_size);
+
+				vm_mem_region_move(vm, TEST_MEMSLOT, new_gpa);
+			} else {
+				TEST_FAIL("Unknown sync code: %lu", uc.args[0]);
+			}
+			break;
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+done:
+	kvm_vm_free(vm);
+}
+
+#define tlb_test(test_name, guest_code, tdp_setting, flush_setting)		\
+do {										\
+	tdp_setting;								\
+	flush_setting;								\
+										\
+	if (tdp_enabled && !kvm_cpu_has_tdp()) {				\
+		pr_info("Skipping: " test_name " (no TDP support)\n");		\
+		break;								\
+	}									\
+										\
+	/*									\
+	 * VPIDs do not tag guest-physical translations, i.e. changing or	\
+	 * flushing VPIDs does not flush EPT translations, and single-context	\
+	 * INVEPT only flushes the target EPTP (not all TDP roots).		\
+	 */									\
+	if (tdp_enabled && kvm_cpu_has_ept() &&					\
+	    (flush_method == TLB_CHANGE_TAG ||					\
+	     guest_code == l1_guest_code_multi_tdp_root)) {			\
+		pr_info("Skipping: " test_name " (not applicable to EPTs)\n");	\
+		break;								\
+	}									\
+										\
+	pr_info("Testing " test_name "...\n");					\
+	run_test(guest_code, tdp_enabled);					\
+} while (0)
+
+int main(int argc, char *argv[])
+{
+	bool tdp_enabled;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
+
+	calc_max_svm_asid();
+
+	tlb_test("Guest-triggered TLB flush (flush entire tag), TDP disabled",
+		 l1_guest_code, tdp_enabled = false,
+		 flush_method = TLB_FLUSH_TAG);
+	tlb_test("Guest-triggered TLB flush (flush individual address), TDP disabled",
+		 l1_guest_code, tdp_enabled = false,
+		 flush_method = TLB_FLUSH_VADDR);
+	tlb_test("Guest-triggered TLB flush (change tag), TDP disabled",
+		 l1_guest_code, tdp_enabled = false,
+		 flush_method = TLB_CHANGE_TAG);
+
+	tlb_test("Guest-triggered TLB flush (flush entire tag), TDP enabled",
+		 l1_guest_code, tdp_enabled = true,
+		 flush_method = TLB_FLUSH_TAG);
+	tlb_test("Guest-triggered TLB flush (change tag), TDP enabled",
+		 l1_guest_code, tdp_enabled = true,
+		 flush_method = TLB_CHANGE_TAG);
+
+	tlb_test("Guest-triggered TLB flush with multiple TDP roots (flush entire tag), TDP enabled",
+		 l1_guest_code_multi_tdp_root, tdp_enabled = true,
+		 flush_method = TLB_FLUSH_TAG);
+	tlb_test("Guest-triggered TLB flush with multiple TDP roots (change tag), TDP enabled",
+		 l1_guest_code_multi_tdp_root, tdp_enabled = true,
+		 flush_method = TLB_CHANGE_TAG);
+
+
+	tlb_test("KVM-triggered TLB flush via memslot move, TDP disabled",
+		 l1_guest_code_memslot_move, tdp_enabled = false,
+		 flush_method = TLB_FLUSH_NONE);
+	tlb_test("KVM-triggered TLB flush via memslot move, TDP enabled",
+		 l1_guest_code_memslot_move, tdp_enabled = true,
+		 flush_method = TLB_FLUSH_NONE);
+
+	return 0;
+}
-- 
2.56.0.385.gd3acb90ef8-goog


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842932673AA;
	Tue, 28 Jul 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785198980; cv=none; b=q3Qtu/HAROPVLEgc9Q3GmknGLggZerPG7oEGscM95AWvY+3zDJ5FnsDca6StHIEhdR86zlhKbSH3ANaH5FOYmjpiOWaTIf10xdfEzJjCc1xv/1wDCWa3vYiF0ltaxhmzDJ6bjY7LFuB1y4Ria/6gROH6NR3/S/cj6xpPHF81zTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785198980; c=relaxed/simple;
	bh=JZ+kE9Dxzo/PBIlBzpZC0v5RVf9BPoD/NK4tmxOhT3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AN1cAnqc2ZuyL7DAd4EKfEaRtPIEZet85sqz2/mpG4qzH+G534E01aZxaeNnwpofSZcO+AFjthxAD7zpuxSZBaeUTFzNAxbMyGAkgV8ac3JdMKmMEb7KrpLnhcKq/GRfG1ICAmVDPzv1TSLlYd1eM6NWnSk3ca+LHK6f2dwiuJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn6XqOAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn6XqOAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAC61F00A3D;
	Tue, 28 Jul 2026 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785198977;
	bh=1oD7FP6hrvn2ukcZSaceQ861YdQp9eqSou8tjFQIezI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn6XqOAgdK/4z3+mF5i6wPEIfVm/qBM7Qg0nBvzLtBlJeNfJ98A40/eDULBTNbjQM
	 xpgynOPkYPv4TYV7BTYbUDnWeGSAOLUg3T3sLD+0jtPI+SUPR46ZNG6x0rm1UG98BH
	 iSUIT7mXVrrmFe7zLfSF+j7gQ2ZF3TNHp4onTlLh5ehZNNySZ2trO/Xgo8/4mdr4Nw
	 Ny+uMqo5r93OEkHgSoZYDBPz7qEtFA3erEH51lmi7PhSFTeICRj7pM58aL6CMG1k3i
	 5gkSDUcxKmV+belF8VYZECISxesQ1D+Vv5XZb8afj9Srrh7j9+F0yMseRPtlvo7VWV
	 WzBEkKtOcuskg==
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
Subject: [PATCH v1 28/28] KVM: selftests: Add a test for nested TLB flushes
Date: Tue, 28 Jul 2026 00:35:57 +0000
Message-ID: <20260728003557.1136583-29-yosry@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728003557.1136583-1-yosry@kernel.org>
References: <20260728003557.1136583-1-yosry@kernel.org>
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
accessing that address access the correct page. A missed TLB flush
causes L2 to access the wrong GPA through a stale TLB entry. The test
exercises multiple ways for L1 to flush the TLB, including changing L2's
ASID/VPID, flushing L2's entire ASID/VPID/EPTP, or flushing an
individual L2 GVA (using INVLPGA/INVVPID) when L1 does not enable TDP.

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

Assisted-by: Gemini:gemini-3.5-pro
Signed-off-by: Yosry Ahmed <yosry@kernel.org>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/include/x86/svm.h |   5 +
 tools/testing/selftests/kvm/include/x86/vmx.h |  21 +
 .../selftests/kvm/x86/nested_tlb_flush_test.c | 436 ++++++++++++++++++
 4 files changed, 463 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 88c6c8046ddec..8bea9fbaca961 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -120,6 +120,7 @@ TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
 TEST_GEN_PROGS_x86 += x86/svm_nested_pat_test
+TEST_GEN_PROGS_x86 += x86/nested_tlb_flush_test
 TEST_GEN_PROGS_x86 += x86/svm_lbr_nested_state
 TEST_GEN_PROGS_x86 += x86/svm_pmu_host_guest_test
 TEST_GEN_PROGS_x86 += x86/tsc_scaling_sync
diff --git a/tools/testing/selftests/kvm/include/x86/svm.h b/tools/testing/selftests/kvm/include/x86/svm.h
index c8539166270ea..7644e37c7042c 100644
--- a/tools/testing/selftests/kvm/include/x86/svm.h
+++ b/tools/testing/selftests/kvm/include/x86/svm.h
@@ -316,4 +316,9 @@ struct __attribute__ ((__packed__)) vmcb {
 
 #define SVM_CR0_SELECTIVE_MASK (X86_CR0_TS | X86_CR0_MP)
 
+static inline void invlpga(unsigned long addr, u32 asid)
+{
+	asm volatile("invlpga %0, %1" : : "a"(addr), "c"(asid));
+}
+
 #endif /* SELFTEST_KVM_SVM_H */
diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 4bcfd60e3aecb..dcd43dff4ad11 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -563,4 +563,25 @@ bool kvm_cpu_has_ept(void);
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
diff --git a/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
new file mode 100644
index 0000000000000..55c9909bb085f
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_tlb_flush_test.c
@@ -0,0 +1,436 @@
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
+static void svm_tlb_flush(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	switch (flush_method) {
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
+static void vmx_tlb_flush(struct vmx_pages *vmx)
+{
+	u16 vpid = vmreadz(VIRTUAL_PROCESSOR_ID);
+
+	switch (flush_method) {
+	case TLB_CHANGE_TAG:
+		GUEST_ASSERT(!vmx->eptp_gpa);
+		vmwrite(VIRTUAL_PROCESSOR_ID, vpid + 1);
+		break;
+	case TLB_FLUSH_TAG:
+		if (vmx->eptp_gpa)
+			invept(1, vmreadz(EPT_POINTER));
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
+		GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+		GUEST_ASSERT(load_vmcs(vmx));
+		prepare_vmcs(vmx, l2_guest_code);
+
+		/* Enable VPID */
+		sec_exec_ctl = vmreadz(SECONDARY_VM_EXEC_CONTROL);
+		sec_exec_ctl |= SECONDARY_EXEC_ENABLE_VPID;
+		GUEST_ASSERT_EQ(vmwrite(SECONDARY_VM_EXEC_CONTROL, sec_exec_ctl), 0);
+		GUEST_ASSERT_EQ(vmwrite(VIRTUAL_PROCESSOR_ID, 1), 0);
+	} else {
+		generic_svm_setup(nested_state, l2_guest_code);
+	}
+}
+
+static void run_l2(void *nested_state, bool launch)
+{
+	struct svm_test_data *svm;
+
+	if (this_cpu_has(X86_FEATURE_VMX)) {
+		vmx_tlb_flush(nested_state);
+		if (launch)
+			GUEST_ASSERT(!vmlaunch());
+		else
+			GUEST_ASSERT(!vmresume());
+		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+		vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + 3); /* skip over VMCALL */
+	} else {
+		svm = nested_state;
+		svm_tlb_flush(svm);
+		run_guest(svm->vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+		svm->vmcb->save.rip += 3; /* skip over VMMCALL */
+	}
+}
+
+static void l2_guest_code(void)
+{
+	int i;
+
+	for (i = 0; i < NR_ITERATIONS; i++) {
+		u64 expected_val = (i % 2 == 0) ? VAL1 : VAL2;
+
+		GUEST_ASSERT_EQ(READ_ONCE(*(u64 *)TEST_VADDR), expected_val);
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
+		run_l2(data, i == 0);
+	}
+
+	GUEST_DONE();
+}
+
+static void prep_guest_flush_test(struct kvm_vm *vm, bool tdp_enabled)
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
+	if (guest_code == l1_guest_code_memslot_move)
+		prep_memslot_move_test(vm, tdp_enabled);
+	else
+		prep_guest_flush_test(vm, tdp_enabled);
+
+	if (kvm_cpu_has(X86_FEATURE_VMX))
+		vcpu_alloc_vmx(vm, &nested_gva);
+	else
+		vcpu_alloc_svm(vm, &nested_gva);
+
+	if (tdp_enabled)
+		tdp_identity_map_default_memslots(vm);
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
+	if (tdp_enabled && kvm_cpu_has_ept() && flush_method == TLB_CHANGE_TAG) {\
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
2.55.0.229.g6434b31f56-goog


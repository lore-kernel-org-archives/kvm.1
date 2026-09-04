Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C80F3A7848;
	Fri,  4 Sep 2026 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489109; cv=none; b=tTrfcy9k9AepsRZp/eOjsRvLh7+ye/8vMg4NZy6IXLf3BpY1jZh1Htm6DI9WgwlverHZI5QHmDcT/7rFlLygk1WVkCZOgOOPasVnTzHzHRb5kb0ACEd59kmMEwkjMh+Ryzr18flcR9876pfkye79I2JJwwxuZr3R3zv1NBvzH4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489109; c=relaxed/simple;
	bh=oopmgu0AWR1HPnMv1Lm+slLchzVcGhuCGowevaxY80s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKLNUG0xzxb9h7fzT4t3VUkoSxseDuDIp/9fhweXLFI6z6zQ/fYckUzwEqcXbNC2Y3T9rcLSq7hUPZCJyAPBSWg5WLnhiHaMCUHbGbmJMFR4UKCXja5RJrVaSxzlUi9kJK+yTivh2yJ9/06UkeVwKAfW9lLht2qrI2i9aOruPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l/ZPiU8f; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l/ZPiU8f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489107; x=1820025107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oopmgu0AWR1HPnMv1Lm+slLchzVcGhuCGowevaxY80s=;
  b=l/ZPiU8fZViWJCYFdhoumndG9cOeCffuPjempj+ACpYQB+egVhX5//KQ
   1FEcg67SQSc6cjHcRY7pjxgnxqgr3VLjjtxf9kuMEZNyP5EQVPyMRiKpe
   uUY94yT2ePLxnilbDXzHBCPe/PqpwoQDAoPY63xYdA05ClKvpBcR1RGV0
   RQ9NINeRJT2hn+HFotPTKPGi5v+61YXRhp2skdRQIwK62jjmeOJuNDhh6
   Bv1+E3ku8ZNInUiDlrxLyK70lpQfF0mVrU2cHpJELMUL9uPrzhpZFH7ug
   eWZ6055QFQXQqoaL0rbxzEQQzxiYndqyGvpL9LzGUvr3Ex35dmwhrCPr5
   Q==;
X-CSE-ConnectionGUID: 2sDGjh4TTT+Ggpb23Twjqg==
X-CSE-MsgGUID: vt5T01ksTJ+ovkNDRuIfGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106506786"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106506786"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:31:46 -0700
X-CSE-ConnectionGUID: 6l3oIaAeQISWovLuaQ3gBA==
X-CSE-MsgGUID: SFX/s9O/THOFcS677tNQGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270433511"
Received: from zhaoliu1-desk.sh.intel.com ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2026 19:31:43 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Chao Gao <chao.gao@intel.com>,
	Xin Li <xin@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 4/4] KVM: selftests: Test VM-entry failure handling for nested VM
Date: Fri,  4 Sep 2026 10:31:05 +0800
Message-Id: <20260904023105.1167376-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904023105.1167376-1-zhao1.liu@intel.com>
References: <20260904023105.1167376-1-zhao1.liu@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for the CET state L1 sees after a nested VM-entry fails. What
L1 should see depends on two controls: the VM-entry "load CET state"
control, which tells whether L2's state was ever loaded, and the VM-exit
"load CET state" control, which tells whether L1's state is reloaded from
vmcs12's host-state area.

A failed VM-entry is a VM-exit, but it leaves nested mode in an unusual
way: vmcs12's guest state was never copied back from vmcs02. So when KVM
copies vmcs12->guest_* into vmcs01 while emulating the VM-exit, it
overwrites the CET state that L1 is really running with, using L2's
values.

Test all four combinations of the two controls, with both failure points,
and check L1's S_CET and INT_SSP_TAB:

  exit  entry  failure      what L1 should see
  ----  -----  -----------  -------------------------------------
   1     x     either       vmcs12's host state
   0     0     either       L1's own state, L2's was never loaded
   0     1     MSR-load     vmcs12's guest state
   0     1     guest-state  L1's own state, see below

The last row is the only case where KVM is more precise than the SDM
requires. The SDM vol. 3C, section 29.3, "Checking and Loading Guest
State" says guest state is checked and loaded at the same time, so a
guest-state failure may be found after some state is already loaded. In
other words, the CET state after such a failure is undefined, unless the
VM-exit control reloads the host state.

The VM-entry MSR-load list is different: it is handled only after guest
state is loaded, so a failure there always keeps whatever the VM-entry
loaded.

For that undefined case, KVM picks the simplest well-defined behavior: it
emulates every EXIT_REASON_INVALID_STATE VM-entry failure as if no guest
state was loaded at all, so L1 keeps its own state. Note, this holds even
though KVM does have guest-state checks that run after L2's CET state is
written into vmcs02, e.g. vmx_guest_state_valid() and
nested_vmx_load_cr3() in prepare_vmcs02(); the failed VM-entry throws
vmcs02 away, and L1's state never left vmcs01. Test KVM's behavior
here.

This test case uses the two failure points, that covers KVM's two exit
paths: a bad guest CR0 (PG set, PE clear) gives EXIT_REASON_INVALID_STATE,
and a read-only MSR in the VM-entry MSR-load list triggers
EXIT_REASON_MSR_LOAD_FAIL.

Only CET state is checked for now, and other state loaded by the
VM-entry/VM-exit controls can be added later.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../x86/vmx_nested_entry_fail_state_test.c    | 311 ++++++++++++++++++
 3 files changed, 313 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..352ae003183a 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -134,6 +134,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_apicv_updates_test
 TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
 TEST_GEN_PROGS_x86 += x86/vmx_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_invalid_nested_guest_state
+TEST_GEN_PROGS_x86 += x86/vmx_nested_entry_fail_state_test
 TEST_GEN_PROGS_x86 += x86/vmx_nested_la57_state_test
 TEST_GEN_PROGS_x86 += x86/apic_bus_clock_test
 TEST_GEN_PROGS_x86 += x86/xapic_ipi_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 6e6f70035508..870ef1bb1ba1 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -79,6 +79,7 @@ const char *ex_str(int vector);
 #define X86_CR4_SMEP		(1ul << 20)
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
+#define X86_CR4_CET		(1ul << 23)
 
 struct xstate_header {
 	u64				xstate_bv;
diff --git a/tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c b/tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c
new file mode 100644
index 000000000000..ed0cb045ed53
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_nested_entry_fail_state_test.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Nested VM-entry failure state test
+ *
+ * Copyright (C) 2026, Intel, Inc.
+ */
+#include <asm/msr-index.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "vmx.h"
+
+static gva_t entry_msr_load_list_gva;
+static gpa_t entry_msr_load_list_gpa;
+
+enum state_src {
+	STATE_SRC_L1,		/* L1's own state */
+	STATE_SRC_VMCS12_GUEST,	/* vmcs12->guest_*, i.e. L2's state */
+	STATE_SRC_VMCS12_HOST,	/* vmcs12->host_*, i.e. host state to load */
+	NR_STATE_SRCS,
+};
+
+static bool has_shstk;
+struct cet_state {
+	u64 s_cet;
+	u64 ssp;
+	u64 ssp_tbl;
+};
+
+struct test_state {
+	struct cet_state cet;
+};
+
+/*
+ * In practice, states of STATE_SRC_L1 and STATE_SRC_VMCS12_HOST should be
+ * same, i.e., the state of STATE_SRC_VMCS12_HOST is copied from host (L1).
+ *
+ * But in this test, to distinguish the "load (host) state" operation, make
+ * STATE_SRC_VMCS12_HOST different from STATE_SRC_L1.
+ */
+static const struct test_state states[NR_STATE_SRCS] = {
+	[STATE_SRC_L1] = {
+		.cet = {
+			.s_cet		= CET_SHSTK_EN,
+			/*
+			 * SSP is not an MSR; the L1 SSP must be configured
+			 * using the KVM_SET_ONE_REG ioctl. To simplify the
+			 * test logic, checking the other MSRs is enough to
+			 * identify the state source, so that there's no need
+			 * to configure different SSPs.
+			 */
+			.ssp		= 0x0000111111111000UL,
+			.ssp_tbl	= 0x0000123456789000UL,
+		}
+	},
+	[STATE_SRC_VMCS12_GUEST] = {
+		.cet = {
+			.s_cet		= CET_SHSTK_EN | CET_WRSS_EN,
+			.ssp		= 0x0000111111111000UL,
+			.ssp_tbl	= 0x00000abcabcab000UL,
+		}
+	},
+	[STATE_SRC_VMCS12_HOST] = {
+		.cet = {
+			.s_cet		= CET_WRSS_EN,
+			.ssp		= 0x0000111111111000UL,
+			.ssp_tbl	= 0x00007edcba987000UL,
+		}
+	},
+};
+
+/* VM-entry-load and VM-exit-load, each 0 or 1. There are 4 combinations in total. */
+#define NR_CTRL_COMBOS		4
+/* each load control combination includes 2 cases with different VM-exit reasons. */
+#define NR_CASES		(NR_CTRL_COMBOS * 2)
+
+/* Define what state the hardware should retain in different cases. */
+static enum state_src get_expected_state_src(bool entry_load, bool exit_load,
+					     uint32_t exit_reason)
+{
+	if (exit_load)
+		return STATE_SRC_VMCS12_HOST;
+
+	/* no entry load, no exit load - L1's own state is retained. */
+	if (!entry_load)
+		return STATE_SRC_L1;
+
+	/*
+	 * From the Intel SDM volume 3, chapter 29.3 "CHECKING AND LOADING
+	 * GUEST STATE":
+	 *   The following operations take place concurrently:
+	 *     (1) the guest-state area of the VMCS is checked to ensure that,
+	 *         after the VM entry completes, the state of the logical
+	 *         processor is consistent with IA-32 and Intel 64
+	 *         architectures;
+	 *     (2) processor state is loaded from the guest-state area or as
+	 *         specified by the VM-entry control fields;
+	 *     and (3) address-range monitoring is cleared.
+	 *   Because the checking and the loading occur concurrently, a failure
+	 *   may be discovered only after some state has been loaded.
+	 *
+	 * I.e. the state left behind by a guest-state failure is
+	 * architecturally undefined. KVM picks the simplest well-defined
+	 * behavior: an EXIT_REASON_INVALID_STATE VM-entry failure is emulated
+	 * as if no guest state was loaded at all, so L1 keeps its own state.
+	 * Note, that holds even for KVM's guest-state checks that run after
+	 * L2's CET state is written into vmcs02, e.g. vmx_guest_state_valid()
+	 * and nested_vmx_load_cr3() in prepare_vmcs02(); the failed VM-entry
+	 * throws vmcs02 away while L1's state never left vmcs01.
+	 */
+	if (exit_reason == EXIT_REASON_INVALID_STATE)
+		return STATE_SRC_L1;
+
+	return STATE_SRC_VMCS12_GUEST;
+}
+
+static void l1_load_own_state(void)
+{
+	if (has_shstk) {
+		const struct cet_state *cet = &states[STATE_SRC_L1].cet;
+
+		wrmsr(MSR_IA32_S_CET, cet->s_cet);
+		wrmsr(MSR_IA32_INT_SSP_TAB, cet->ssp_tbl);
+	}
+}
+
+static void l1_program_vmcs12_cet(bool entry_load, bool exit_load)
+{
+	const struct cet_state *guest = &states[STATE_SRC_VMCS12_GUEST].cet;
+	const struct cet_state *host = &states[STATE_SRC_VMCS12_HOST].cet;
+	u64 entry_ctrl = vmreadz(VM_ENTRY_CONTROLS) & ~VM_ENTRY_LOAD_CET_STATE;
+	u64 exit_ctrl = vmreadz(VM_EXIT_CONTROLS) & ~VM_EXIT_LOAD_CET_STATE;
+
+	GUEST_ASSERT(!vmwrite(GUEST_S_CET, guest->s_cet));
+	GUEST_ASSERT(!vmwrite(GUEST_SSP, guest->ssp));
+	GUEST_ASSERT(!vmwrite(GUEST_INTR_SSP_TABLE, guest->ssp_tbl));
+	GUEST_ASSERT(!vmwrite(HOST_S_CET, host->s_cet));
+	GUEST_ASSERT(!vmwrite(HOST_SSP, host->ssp));
+	GUEST_ASSERT(!vmwrite(HOST_INTR_SSP_TABLE, host->ssp_tbl));
+
+	if (entry_load) {
+		entry_ctrl |= VM_ENTRY_LOAD_CET_STATE;
+
+		/*
+		 * Enable CET for L2 -- although it's not required for this test,
+		 * since L2 never runs (VM-entry always fails), so these never
+		 * reach real hardware -- just trying to emulate a L2 guest running
+		 * CET.
+		 */
+		GUEST_ASSERT(!vmwrite(GUEST_CR0, vmreadz(GUEST_CR0) | X86_CR0_WP));
+		GUEST_ASSERT(!vmwrite(GUEST_CR4, vmreadz(GUEST_CR4) | X86_CR4_CET));
+	}
+	if (exit_load)
+		exit_ctrl |= VM_EXIT_LOAD_CET_STATE;
+
+	GUEST_ASSERT(!vmwrite(VM_ENTRY_CONTROLS, entry_ctrl));
+	GUEST_ASSERT(!vmwrite(VM_EXIT_CONTROLS, exit_ctrl));
+}
+
+static void l1_program_vmcs12_state(bool entry_load, bool exit_load)
+{
+	if (has_shstk)
+		l1_program_vmcs12_cet(entry_load, exit_load);
+}
+
+/*
+ * Set the invalid guest state to fail the VM-entry check
+ * -- triggering a VM-exit (EXIT_REASON_INVALID_STATE).
+ */
+static void l1_break_guest_state(void)
+{
+	u64 cr0 = vmreadz(GUEST_CR0);
+
+	GUEST_ASSERT(!vmwrite(GUEST_CR0, (cr0 | X86_CR0_PG) & ~X86_CR0_PE));
+}
+
+/*
+ * Set the invalid MSR load list to fail the VM-entry check
+ * -- triggering a VM-exit (EXIT_REASON_MSR_LOAD_FAIL).
+ */
+static void l1_break_msr_load_list(void)
+{
+	struct vmx_msr_entry *list = (void *)entry_msr_load_list_gva;
+
+	list[0] = (struct vmx_msr_entry){
+		.index = MSR_IA32_UCODE_REV,
+		.reserved = 0,
+		.value = 0,
+	};
+
+	GUEST_ASSERT(!vmwrite(VM_ENTRY_MSR_LOAD_ADDR, entry_msr_load_list_gpa));
+	GUEST_ASSERT(!vmwrite(VM_ENTRY_MSR_LOAD_COUNT, 1));
+}
+
+static void l1_check_observed_cet(bool entry_load, bool exit_load, uint32_t exit_reason)
+{
+	enum state_src src = get_expected_state_src(entry_load, exit_load, exit_reason);
+	const struct cet_state *expect = &states[src].cet;
+	u64 s_cet = rdmsr(MSR_IA32_S_CET);
+	u64 ssp_tbl = rdmsr(MSR_IA32_INT_SSP_TAB);
+
+	__GUEST_ASSERT(s_cet == expect->s_cet && ssp_tbl == expect->ssp_tbl,
+		       "entry_load=%d exit_load=%d exit_reason=%u: "
+		       "expect src %d S_CET=%#lx INT_SSP_TAB=%#lx, "
+		       "got S_CET=%#lx INT_SSP_TAB=%#lx",
+		       entry_load, exit_load, exit_reason, src, expect->s_cet,
+		       expect->ssp_tbl, s_cet, ssp_tbl);
+}
+
+static void l1_check_observed_state(bool entry_load, bool exit_load, uint32_t exit_reason)
+{
+	if (has_shstk)
+		l1_check_observed_cet(entry_load, exit_load, exit_reason);
+}
+
+static void l1_run_case(struct vmx_pages *vmx, bool entry_load, bool exit_load,
+			uint32_t exit_reason)
+{
+	l1_load_own_state();
+
+	GUEST_ASSERT(load_vmcs(vmx));
+	prepare_vmcs(vmx, NULL);
+
+	l1_program_vmcs12_state(entry_load, exit_load);
+
+	switch (exit_reason) {
+	case EXIT_REASON_INVALID_STATE:
+		l1_break_guest_state();
+		break;
+	case EXIT_REASON_MSR_LOAD_FAIL:
+		l1_break_msr_load_list();
+		break;
+	default:
+		GUEST_FAIL("unexpected exit reason %u", exit_reason);
+	}
+
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON),
+			EXIT_REASON_FAILED_VMENTRY | exit_reason);
+
+	l1_check_observed_state(entry_load, exit_load, exit_reason);
+
+	GUEST_SYNC(0);
+}
+
+static void l1_guest_code(struct vmx_pages *vmx)
+{
+	int ctrl;
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+
+	for (ctrl = 0; ctrl < NR_CTRL_COMBOS; ctrl++) {
+		bool entry_load = ctrl & BIT(0);
+		bool exit_load = ctrl & BIT(1);
+
+		/* 2 cases with different VM-exit reasons. */
+		l1_run_case(vmx, entry_load, exit_load, EXIT_REASON_INVALID_STATE);
+		l1_run_case(vmx, entry_load, exit_load, EXIT_REASON_MSR_LOAD_FAIL);
+	}
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	gva_t vmx_pages_gva;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int ncases = 0;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+
+	has_shstk = kvm_cpu_has(X86_FEATURE_SHSTK);
+	TEST_REQUIRE(has_shstk);
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	entry_msr_load_list_gva = vm_alloc_page(vm);
+	entry_msr_load_list_gpa = addr_gva2gpa(vm, entry_msr_load_list_gva);
+	sync_global_to_guest(vm, entry_msr_load_list_gva);
+	sync_global_to_guest(vm, entry_msr_load_list_gpa);
+
+	sync_global_to_guest(vm, has_shstk);
+
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+
+	for (;;) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			ncases++;
+			break;
+		case UCALL_DONE:
+			TEST_ASSERT(ncases == NR_CASES, "L1 ran %d cases, expected %d",
+				    ncases, NR_CASES);
+			goto done;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	}
+done:
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.34.1


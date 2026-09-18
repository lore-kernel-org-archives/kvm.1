Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3AF4B1D1C;
	Fri, 18 Sep 2026 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721808; cv=none; b=iCpGMLJYRSDml7nQlJtuQ7iQ57oSZQHri+M+OdZ02N+ArBjVguzKxjW7UohUMtY5BB/FDHtCOQtu9Q093Gjiiyi8KYKSBFqTEsu8ZzAH3gPyufy/0LlE28Vk9tUQZPMP9bDxTaLkOTWf5BQpdIGokiE8xnomaD+ePl1Uc+wD7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721808; c=relaxed/simple;
	bh=QfNhE8cGN9zMVRpqVtoG1lKNjid8MueZ41cYebiHt6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/eaVLgxVZP6ZKEYMPa1RsHfuhBMOl7qwT/iXbP1EqPa+r51UHAxxn/Ny6sBnc9TRs6F24aCdCP+ju+E/NSoMmb4JiIx7pLHhaHhV5I52QJB4XPkLfe2RVlTRWvd2RUCEtRVdf2A0SvNdweBaKM8DQ9J1Be6OKfy36OGCpwVA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00168881-1.14418e-05-0.9983;FP=10359238163687870377|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGgS5T2_1789721791;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGgS5T2_1789721791 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:56:31 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/8] KVM: selftests: Add nested SVM DecodeAssists test
Date: Fri, 18 Sep 2026 16:56:18 +0800
Message-ID: <1355f32599087e8f4d0740bb92ab5f0c9c329b6f.1789721173.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1789721173.git.zhang_wei@open-hieco.net>
References: <cover.1789721173.git.zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a focused nested SVM selftest for DecodeAssists.  Verify that KVM
exposes the feature to L1 and provides EXITINFO for representative
MOV CR/DR, CLTS, INTn, INVLPG, and INVLPGA intercepts, including a
MOV-to-CR0 selective intercept.  Check hardware and forced-emulation
paths against the same expected values.  Poison the instruction-byte
fields before each instruction-intercept test and verify that the byte
count is cleared on exit.

Exercise instruction bytes for hardware and synthesized #NPF/#PF exits.
Cover a synthesized #NPF that follows a hardware #NPF in the same emulated
instruction, an unreadable instruction tail that leaves only the cached
opcode, and the absence of bytes for an instruction-fetch #PF.  Modify the
MOVSB opcode while its MMIO read is pending to verify that the emulator's
cached bytes are preserved.

Inject a userspace #PF while an MMIO read is pending.  Verify that after
MMIO completion, L1 receives instruction bytes from the current RIP,
not the previous instruction's emulator cache.

The hardware instruction-intercept, synthesized OUTSB #NPF, and
userspace-injected #PF cases run by default.  The forced-emulation #PF
and instruction-intercept paths require kvm.force_emulation_prefix=1.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 590 ++++++++++++++++++
 3 files changed, 592 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..bb55a8c32c42 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -118,6 +118,7 @@ TEST_GEN_PROGS_x86 += x86/vmx_preemption_timer_test
 TEST_GEN_PROGS_x86 += x86/svm_vmcall_test
 TEST_GEN_PROGS_x86 += x86/svm_int_ctl_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_clear_efer_svme
+TEST_GEN_PROGS_x86 += x86/svm_nested_decode_assists_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_shutdown_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_soft_inject_test
 TEST_GEN_PROGS_x86 += x86/svm_nested_vmcb12_gpa
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7579e692bc2b..bd281f521eb1 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -222,6 +222,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_LBRV		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 1)
 #define	X86_FEATURE_NRIPS		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 3)
 #define X86_FEATURE_TSCRATEMSR          KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 4)
+#define X86_FEATURE_DECODEASSISTS       KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 7)
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_V_VMSAVE_VMLOAD	KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 15)
diff --git a/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
new file mode 100644
index 000000000000..aba91d8bb1a2
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM's virtualization of SVM DecodeAssists for nested guests.
+ */
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+
+#define TEST_INT_VECTOR 0x81
+
+/* Any canonical virtual address that is never mapped by the selftest VM. */
+#define PF_TEST_GVA BIT_ULL(40)
+#define PF_FETCH_TEST_GVA BIT_ULL(41)
+
+#define OUTSB_OPCODE 0x6e
+#define MOVSB_OPCODE 0xa4
+#define NOP_OPCODE 0x90
+#define BOUNDARY_OUTSB_CODE_SIZE 15
+#define TEST_IOPM_SIZE (3 * PAGE_SIZE)
+
+static u8 npf_target[PAGE_SIZE] __aligned(PAGE_SIZE);
+static u8 mmio_source[PAGE_SIZE] __aligned(PAGE_SIZE);
+static u8 boundary_outsb_code[2 * PAGE_SIZE] __aligned(PAGE_SIZE);
+
+static void l2_read_code(void)
+{
+	asm volatile("mov (%0), %%rax" : : "r"(&npf_target) : "rax", "memory");
+	GUEST_FAIL("L2 read did not cause a nested page fault");
+}
+
+static void l2_outsb_code(void)
+{
+	asm volatile("mov %0, %%rsi\n\t"
+		     "mov $0x80, %%dx\n\t"
+		     "outsb"
+		     : : "r"(&npf_target) : "rsi", "rdx", "memory");
+	GUEST_FAIL("L2 OUTSB did not cause a nested page fault");
+}
+
+extern u8 l2_movsb_insn[];
+
+static void l2_movsb_code(void)
+{
+	asm volatile("mov %0, %%rsi\n\t"
+		     "mov %1, %%rdi\n\t"
+		     "l2_movsb_insn:\n\t"
+		     "movsb"
+		     : : "r"(&mmio_source), "r"(&npf_target)
+		     : "rsi", "rdi", "memory");
+	GUEST_FAIL("L2 MOVSB did not cause a nested page fault");
+}
+
+extern u8 l2_userspace_pf_insn[];
+
+static void l2_userspace_pf_code(void)
+{
+	asm volatile("movzbl (%0), %%eax\n\t"
+		     "l2_userspace_pf_insn:\n\t"
+		     "nop"
+		     : : "r"(&mmio_source) : "rax", "memory");
+	GUEST_FAIL("Userspace-injected #PF was not intercepted by L1");
+}
+
+static void l2_pf_code(void)
+{
+	asm volatile("mov (%0), %%rax"
+		     : : "r"(PF_TEST_GVA) : "rax", "memory");
+	GUEST_FAIL("L2 access to an unmapped VA did not #PF");
+}
+
+static void l2_fep_pf_code(void)
+{
+	asm volatile(KVM_FEP "mov (%0), %%rax"
+		     : : "r"(PF_TEST_GVA) : "rax", "memory");
+	GUEST_FAIL("L2 forced-emulated access to an unmapped VA did not #PF");
+}
+
+static void l2_mov_from_cr4_code(bool fep)
+{
+	if (fep)
+		asm volatile(KVM_FEP "mov %%cr4, %%r10" : : : "r10");
+	else
+		asm volatile("mov %%cr4, %%r10" : : : "r10");
+	GUEST_FAIL("L2 MOV-from-CR4 was not intercepted");
+}
+
+static void l2_mov_to_cr0_code(bool fep)
+{
+	u64 cr0;
+
+	asm volatile("mov %%cr0, %0" : "=r"(cr0));
+	cr0 ^= X86_CR0_WP;
+	if (fep)
+		asm volatile(KVM_FEP "mov %0, %%cr0" : : "a"(cr0) : "memory");
+	else
+		asm volatile("mov %0, %%cr0" : : "a"(cr0) : "memory");
+	GUEST_FAIL("L2 MOV-to-CR0 was not intercepted");
+}
+
+static void l2_mov_to_dr7_code(bool fep)
+{
+	u64 dr7;
+
+	asm volatile("mov %%dr7, %0" : "=r"(dr7));
+	if (fep)
+		asm volatile(KVM_FEP "mov %0, %%dr7" : : "b"(dr7));
+	else
+		asm volatile("mov %0, %%dr7" : : "b"(dr7));
+	GUEST_FAIL("L2 MOV-to-DR7 was not intercepted");
+}
+
+static void l2_clts_code(bool fep)
+{
+	if (fep)
+		asm volatile(KVM_FEP "clts" : : : "memory");
+	else
+		asm volatile("clts" : : : "memory");
+	GUEST_FAIL("L2 CLTS was not intercepted");
+}
+
+static void l2_int_code(bool fep)
+{
+	if (fep)
+		asm volatile(KVM_FEP "int %0" : : "i"(TEST_INT_VECTOR));
+	else
+		asm volatile("int %0" : : "i"(TEST_INT_VECTOR));
+	GUEST_FAIL("L2 INTn was not intercepted");
+}
+
+static void l2_invlpg_code(bool fep)
+{
+	if (fep)
+		asm volatile(KVM_FEP "invlpg (%0)" : : "r"(&npf_target) : "memory");
+	else
+		asm volatile("invlpg (%0)" : : "r"(&npf_target) : "memory");
+	GUEST_FAIL("L2 INVLPG was not intercepted");
+}
+
+static void l2_invlpga_code(bool fep)
+{
+	if (fep)
+		asm volatile(KVM_FEP "invlpga"
+			     : : "a"(&npf_target), "c"(0) : "memory");
+	else
+		asm volatile("invlpga" : : "a"(&npf_target), "c"(0) : "memory");
+	GUEST_FAIL("L2 INVLPGA was not intercepted");
+}
+
+struct instruction_intercept_test {
+	const char *name;
+	void (*code)(bool fep);
+	u64 intercept;
+	u32 intercept_cr;
+	u32 intercept_dr;
+	u64 exit_code;
+	u64 exit_info_1;
+	u64 exit_info_1_mask;
+	bool check_rax;
+	u64 rax;
+};
+
+static const struct instruction_intercept_test instruction_intercept_tests[] = {
+	{
+		.name = "MOV-from-CR4",
+		.code = l2_mov_from_cr4_code,
+		.intercept_cr = BIT(INTERCEPT_CR4_READ),
+		.exit_code = SVM_EXIT_READ_CR4,
+		.exit_info_1 = BIT_ULL(63) | 10,
+		.exit_info_1_mask = ~0ULL,
+	}, {
+		.name = "MOV-to-CR0-selective",
+		.code = l2_mov_to_cr0_code,
+		.intercept = BIT_ULL(INTERCEPT_SELECTIVE_CR0),
+		.exit_code = SVM_EXIT_CR0_SEL_WRITE,
+		.exit_info_1 = BIT_ULL(63),
+		.exit_info_1_mask = ~0ULL,
+	}, {
+		.name = "MOV-to-DR7",
+		.code = l2_mov_to_dr7_code,
+		.intercept_dr = BIT(INTERCEPT_DR7_WRITE),
+		.exit_code = SVM_EXIT_WRITE_DR7,
+		.exit_info_1 = 3,
+		.exit_info_1_mask = ~0ULL,
+	}, {
+		.name = "CLTS",
+		.code = l2_clts_code,
+		.intercept_cr = BIT(INTERCEPT_CR0_WRITE),
+		.exit_code = SVM_EXIT_WRITE_CR0,
+		.exit_info_1_mask = BIT_ULL(63),
+	}, {
+		.name = "INTn",
+		.code = l2_int_code,
+		.intercept = BIT_ULL(INTERCEPT_INTn),
+		.exit_code = SVM_EXIT_SWINT,
+		.exit_info_1 = TEST_INT_VECTOR,
+		.exit_info_1_mask = ~0ULL,
+	}, {
+		.name = "INVLPG",
+		.code = l2_invlpg_code,
+		.intercept = BIT_ULL(INTERCEPT_INVLPG),
+		.exit_code = SVM_EXIT_INVLPG,
+		.exit_info_1 = (u64)&npf_target,
+		.exit_info_1_mask = ~0ULL,
+	}, {
+		.name = "INVLPGA",
+		.code = l2_invlpga_code,
+		.intercept = BIT_ULL(INTERCEPT_INVLPGA),
+		.exit_code = SVM_EXIT_INVLPGA,
+		.exit_info_1_mask = ~0ULL,
+		.check_rax = true,
+		.rax = (u64)&npf_target,
+	},
+};
+
+static void assert_decode_assist_insn_bytes(struct vmcb *vmcb)
+{
+	GUEST_ASSERT(vmcb->control.insn_len);
+	GUEST_ASSERT(vmcb->control.insn_len <=
+		     sizeof(vmcb->control.insn_bytes));
+	GUEST_ASSERT(!memcmp(vmcb->control.insn_bytes,
+			     (void *)vmcb->save.rip,
+			     vmcb->control.insn_len));
+}
+
+static void assert_full_decode_assist_insn_bytes(struct vmcb *vmcb)
+{
+	GUEST_ASSERT_EQ(vmcb->control.insn_len,
+			sizeof(vmcb->control.insn_bytes));
+	assert_decode_assist_insn_bytes(vmcb);
+}
+
+static void prepare_l2_for_vmrun(struct svm_test_data *svm, gva_t rip)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	vmcb->save.rip = rip;
+	vmcb->save.rsp = (u64)svm->stack;
+}
+
+static void run_intercept_test(struct svm_test_data *svm,
+			       const struct instruction_intercept_test *test, bool fep)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	struct vmcb_control_area *control = &vmcb->control;
+	u64 expected_exit_info_1 = test->exit_info_1 & test->exit_info_1_mask;
+	const char *mode = fep ? "emulated" : "hardware";
+
+	control->intercept |= test->intercept;
+	control->intercept_cr |= test->intercept_cr;
+	control->intercept_dr |= test->intercept_dr;
+
+	control->exit_info_1 = ~0ULL;
+	control->insn_len = sizeof(control->insn_bytes);
+	memset(control->insn_bytes, 0xa5, sizeof(control->insn_bytes));
+	prepare_l2_for_vmrun(svm, (u64)test->code);
+	guest_regs.rdi = fep;
+
+	run_guest(vmcb, svm->vmcb_gpa);
+
+	__GUEST_ASSERT(control->exit_code == test->exit_code,
+		       "%s (%s): expected exit code %#lx, got %#lx",
+		       test->name, mode, (unsigned long)test->exit_code,
+		       (unsigned long)control->exit_code);
+	__GUEST_ASSERT((control->exit_info_1 & test->exit_info_1_mask) ==
+		       expected_exit_info_1,
+		       "%s (%s): expected EXITINFO1 %#lx with mask %#lx, got %#lx",
+		       test->name, mode, (unsigned long)expected_exit_info_1,
+		       (unsigned long)test->exit_info_1_mask,
+		       (unsigned long)control->exit_info_1);
+	__GUEST_ASSERT(!control->insn_len,
+		       "%s (%s): expected no instruction bytes, got %u",
+		       test->name, mode, control->insn_len);
+
+	if (test->check_rax)
+		__GUEST_ASSERT(vmcb->save.rax == test->rax,
+			       "%s (%s): expected rAX %#lx, got %#lx",
+			       test->name, mode, (unsigned long)test->rax,
+			       (unsigned long)vmcb->save.rax);
+
+	control->intercept &= ~test->intercept;
+	control->intercept_cr &= ~test->intercept_cr;
+	control->intercept_dr &= ~test->intercept_dr;
+}
+
+static void test_instruction_intercepts(struct svm_test_data *svm)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(instruction_intercept_tests); i++) {
+		run_intercept_test(svm, &instruction_intercept_tests[i], false);
+		if (is_forced_emulation_enabled)
+			run_intercept_test(svm, &instruction_intercept_tests[i], true);
+	}
+}
+
+static void test_hardware_npf(struct svm_test_data *svm, gpa_t npf_gpa)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	prepare_l2_for_vmrun(svm, (u64)l2_read_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, npf_gpa);
+	assert_decode_assist_insn_bytes(vmcb);
+}
+
+/*
+ * The IOIO intercept causes L0 to emulate OUTSB before accessing its source
+ * operand.  The emulated read then faults on L1's NPT, resulting in a
+ * KVM-synthesized #NPF.
+ */
+static void test_synthesized_npf(struct svm_test_data *svm, gpa_t npf_gpa)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	prepare_l2_for_vmrun(svm, (u64)l2_outsb_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, npf_gpa);
+	assert_full_decode_assist_insn_bytes(vmcb);
+}
+
+/*
+ * MOVSB first reads from MMIO, causing a hardware #NPF that L0 emulates.
+ * After userspace completes the read, the emulated destination write faults
+ * on L1's NPT.  The new #NPF must not reuse the original hardware exit's GPA.
+ * Userspace replaces MOVSB with NOP while the read is pending.  DecodeAssist
+ * must retain the cached MOVSB bytes instead of re-reading the opcode.
+ */
+static void test_synthesized_npf_after_hardware_npf(struct svm_test_data *svm,
+						    gpa_t npf_gpa)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	u8 insn_bytes[sizeof(vmcb->control.insn_bytes)];
+
+	memcpy(insn_bytes, l2_movsb_insn, sizeof(insn_bytes));
+	GUEST_ASSERT_EQ(insn_bytes[0], MOVSB_OPCODE);
+	prepare_l2_for_vmrun(svm, (u64)l2_movsb_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, npf_gpa);
+	GUEST_ASSERT_EQ(vmcb->save.rip, (u64)l2_movsb_insn);
+	GUEST_ASSERT_EQ(l2_movsb_insn[0], NOP_OPCODE);
+	GUEST_ASSERT_EQ(vmcb->control.insn_len, sizeof(insn_bytes));
+	GUEST_ASSERT(!memcmp(vmcb->control.insn_bytes, insn_bytes,
+			     sizeof(insn_bytes)));
+}
+
+/*
+ * OUTSB is the final byte of a mapped code page, and the following page is
+ * not present in L2's page tables.  DecodeAssist byte fetching must stop at
+ * the page boundary and report only the OUTSB opcode.
+ */
+static void test_synthesized_npf_truncated(struct svm_test_data *svm,
+					   gpa_t npf_gpa)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	prepare_l2_for_vmrun(svm,
+			     (u64)&boundary_outsb_code[PAGE_SIZE -
+						       BOUNDARY_OUTSB_CODE_SIZE]);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, npf_gpa);
+	GUEST_ASSERT_EQ(vmcb->save.rip,
+			(u64)&boundary_outsb_code[PAGE_SIZE - 1]);
+	GUEST_ASSERT_EQ(vmcb->control.insn_len, 1);
+	GUEST_ASSERT_EQ(vmcb->control.insn_bytes[0], OUTSB_OPCODE);
+}
+
+static void test_hardware_intercepted_pf(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	prepare_l2_for_vmrun(svm, (u64)l2_pf_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_EXCP_BASE + PF_VECTOR);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, PF_TEST_GVA);
+	GUEST_ASSERT(!(vmcb->control.exit_info_1 & PFERR_PRESENT_MASK));
+	GUEST_ASSERT(!(vmcb->control.exit_info_1 & PFERR_FETCH_MASK));
+	assert_decode_assist_insn_bytes(vmcb);
+}
+
+static void test_hardware_intercepted_fetch_pf(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	prepare_l2_for_vmrun(svm, PF_FETCH_TEST_GVA);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_EXCP_BASE + PF_VECTOR);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, PF_FETCH_TEST_GVA);
+	GUEST_ASSERT(!(vmcb->control.exit_info_1 & PFERR_PRESENT_MASK));
+	GUEST_ASSERT(vmcb->control.exit_info_1 & PFERR_FETCH_MASK);
+	GUEST_ASSERT_EQ(vmcb->control.insn_len, 0);
+}
+
+static void test_synthesized_pf(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	if (!is_forced_emulation_enabled)
+		return;
+
+	prepare_l2_for_vmrun(svm, (u64)l2_fep_pf_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_EXCP_BASE + PF_VECTOR);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, PF_TEST_GVA);
+	GUEST_ASSERT(!(vmcb->control.exit_info_1 & PFERR_PRESENT_MASK));
+	GUEST_ASSERT(!(vmcb->control.exit_info_1 & PFERR_FETCH_MASK));
+	assert_full_decode_assist_insn_bytes(vmcb);
+}
+
+/* The pending MMIO instruction must complete before reflecting userspace #PF. */
+static void test_userspace_injected_pf_during_emulation(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	prepare_l2_for_vmrun(svm, (u64)l2_userspace_pf_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_EXCP_BASE + PF_VECTOR);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_1, 0);
+	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, PF_TEST_GVA);
+	GUEST_ASSERT_EQ(vmcb->save.rip, (u64)l2_userspace_pf_insn);
+	GUEST_ASSERT_EQ(vmcb->save.rax, 0x5a);
+	assert_full_decode_assist_insn_bytes(vmcb);
+	GUEST_ASSERT_EQ(vmcb->control.insn_bytes[0], NOP_OPCODE);
+}
+
+static void l1_guest_code(struct svm_test_data *svm, gpa_t npf_gpa,
+			  gpa_t iopm_gpa)
+{
+	struct vmcb *vmcb = svm->vmcb;
+
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_DECODEASSISTS));
+
+	generic_svm_setup(svm, l2_read_code);
+	vmcb->control.iopm_base_pa = iopm_gpa;
+
+	vmcb->control.intercept |= BIT_ULL(INTERCEPT_IOIO_PROT);
+	vmcb->control.intercept_exceptions |= 1U << PF_VECTOR;
+
+	test_hardware_npf(svm, npf_gpa);
+	test_synthesized_npf(svm, npf_gpa);
+	test_synthesized_npf_after_hardware_npf(svm, npf_gpa);
+	test_synthesized_npf_truncated(svm, npf_gpa);
+	test_hardware_intercepted_pf(svm);
+	test_hardware_intercepted_fetch_pf(svm);
+	test_synthesized_pf(svm);
+	test_userspace_injected_pf_during_emulation(svm);
+	test_instruction_intercepts(svm);
+
+	GUEST_DONE();
+}
+
+static void build_boundary_outsb_code(u8 *code)
+{
+	u64 source = (u64)&npf_target;
+
+	/* movabs $npf_target, %rsi */
+	code[0] = 0x48;
+	code[1] = 0xbe;
+	memcpy(&code[2], &source, sizeof(source));
+
+	/* mov $0x80, %dx; outsb */
+	code[10] = 0x66;
+	code[11] = 0xba;
+	code[12] = 0x80;
+	code[13] = 0x00;
+	code[14] = OUTSB_OPCODE;
+}
+
+static void prepare_boundary_outsb_code(struct kvm_vm *vm)
+{
+	gva_t code_gva = (gva_t)&boundary_outsb_code[PAGE_SIZE -
+						      BOUNDARY_OUTSB_CODE_SIZE];
+
+	build_boundary_outsb_code(addr_gva2hva(vm, code_gva));
+}
+
+static void queue_userspace_pf(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events;
+
+	vcpu_events_get(vcpu, &events);
+	TEST_ASSERT(!events.exception.pending && !events.exception.injected,
+		    "Unexpected exception before userspace #PF injection");
+	TEST_ASSERT(events.flags & KVM_VCPUEVENT_VALID_PAYLOAD,
+		    "KVM_CAP_EXCEPTION_PAYLOAD was not enabled");
+
+	events.exception.pending = true;
+	events.exception.nr = PF_VECTOR;
+	events.exception.has_error_code = true;
+	events.exception.error_code = 0;
+	events.exception_has_payload = true;
+	events.exception_payload = PF_TEST_GVA;
+	vcpu_events_set(vcpu, &events);
+}
+
+static void complete_mmio_read(struct kvm_vcpu *vcpu, gpa_t expected_gpa,
+			       u8 value)
+{
+	if (vcpu->run->exit_reason == KVM_EXIT_IO) {
+		struct ucall uc;
+
+		if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+			REPORT_GUEST_ASSERT(uc);
+	}
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MMIO);
+	TEST_ASSERT(!vcpu->run->mmio.is_write,
+		    "Expected an MMIO read, got a write");
+	TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, expected_gpa);
+	TEST_ASSERT_EQ(vcpu->run->mmio.len, 1);
+	vcpu->run->mmio.data[0] = value;
+}
+
+static void assert_ucall_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	u64 actual;
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	actual = get_ucall(vcpu, &uc);
+	if (actual == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+
+	TEST_ASSERT_EQ(actual, UCALL_DONE);
+}
+
+int main(int argc, char *argv[])
+{
+	gva_t svm_gva, npf_gva, boundary_page_gva, iopm_gva;
+	gpa_t npf_gpa, mmio_source_gpa, mmio_gpa, iopm_gpa;
+	struct userspace_mem_region *region;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u8 *movsb_insn;
+	u64 *pte;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
+	TEST_REQUIRE(this_cpu_has(X86_FEATURE_DECODEASSISTS));
+	TEST_ASSERT(kvm_cpu_has(X86_FEATURE_DECODEASSISTS),
+		    "KVM failed to expose DecodeAssists");
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, 1);
+	prepare_boundary_outsb_code(vm);
+	vm_enable_npt(vm);
+	vcpu_alloc_svm(vm, &svm_gva);
+	iopm_gva = vm_alloc_pages(vm, TEST_IOPM_SIZE / PAGE_SIZE);
+	iopm_gpa = addr_gva2gpa(vm, iopm_gva);
+	memset(addr_gva2hva(vm, iopm_gva), 0, TEST_IOPM_SIZE);
+	npf_gva = (gva_t)&npf_target;
+	npf_gpa = addr_gva2gpa(vm, npf_gva);
+
+	tdp_identity_map_default_memslots(vm);
+	pte = tdp_get_pte(vm, npf_gpa);
+	*pte &= ~PTE_PRESENT_MASK(&vm->stage2_mmu);
+	region = memslot2region(vm, 0);
+	mmio_gpa = region->region.guest_phys_addr +
+		   region->region.memory_size + PAGE_SIZE;
+	mmio_source_gpa = addr_gva2gpa(vm, (gva_t)&mmio_source);
+	pte = tdp_get_pte(vm, mmio_source_gpa);
+	*pte = (*pte & ~PHYSICAL_PAGE_MASK) | mmio_gpa;
+
+	boundary_page_gva = (gva_t)&boundary_outsb_code[PAGE_SIZE];
+	pte = vm_get_pte(vm, boundary_page_gva);
+	*pte &= ~PTE_PRESENT_MASK(&vm->mmu);
+
+	vcpu_args_set(vcpu, 3, svm_gva, npf_gpa, iopm_gpa);
+
+	/* Complete the MOVSB source read. */
+	vcpu_run(vcpu);
+	complete_mmio_read(vcpu, mmio_gpa, 0xa5);
+	movsb_insn = addr_gva2hva(vm, (gva_t)l2_movsb_insn);
+	TEST_ASSERT_EQ(movsb_insn[0], MOVSB_OPCODE);
+	movsb_insn[0] = NOP_OPCODE;
+	vcpu_run(vcpu);
+	complete_mmio_read(vcpu, mmio_gpa, 0x5a);
+	queue_userspace_pf(vcpu);
+	vcpu_run(vcpu);
+	assert_ucall_done(vcpu);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.7


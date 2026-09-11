Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5B499180;
	Fri, 11 Sep 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789163055; cv=none; b=E51LMIBN+jRdiTuudistMqro3M7VkEgGqqERHJLtA/vAxIeFbLxu4wzmqP7VJsL0BzZA+DwcJ6SOAeeRKzg88kEYTl7cicOQITihZMv9ayMhuJhmA/3TnB2YQiAOS1jldnYwZqILas6PsPdi10sd23eJo0Jwr9ZgnTXwKFmdkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789163055; c=relaxed/simple;
	bh=+1Jw4fuAgngN372/rAoxqz0Tgs9H4oIDq5miF7p/D5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+UbOJ8LiC6vK+iEn1sU++2Tjy6Oq9wslh1VsJ64C3OOg0O9Nw/Bp2UN+nlmZn2xO2aGM0UdWy26ZEjG8eiW/AXNKuRjjnq5RW6UfB/P/ThJbNE6gGluHvP8N/P5FfCCZFRBPuj6mmyFDNDZCtlklr1ToKtN7ho4REKVDQRsOlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9u3SKaE; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9u3SKaE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789163054; x=1820699054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+1Jw4fuAgngN372/rAoxqz0Tgs9H4oIDq5miF7p/D5I=;
  b=X9u3SKaEkSGo6gQNlmsOz/u7BP4VWLQf4nCzXNBcI0fiStx7SUaw9z77
   Ez49k/ZgeF7ZMr+qs68Rinp6cX5Pnj7LmZD+AhAwCJ5hBLf+5YXH80SMb
   SjDbn1Y1ciK96wm2VWecdc/UGzzVqjYXXb4vFadtArkE9BuBvamlK/9HY
   6hWfkg8hqKqHcDbRAQEB4f/r6RBUFJED2bLB8mmARP4jLLJ47+FPLEdyq
   bEZvjNb7u8S1qxPDKT3NjAzgYHhR2qbAzfcmKbqLF5H197eqbyr9dtYs2
   AIizzdQvPyvDKLEU1ml29IUE2Zajwba0IfAyzV7QC/x9Iqt4XBzL4WOHb
   w==;
X-CSE-ConnectionGUID: x9rtjajvQnigSshsvJVZdQ==
X-CSE-MsgGUID: 2/Xfyi9ERAOJayYrhKk9rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572965"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572965"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:44:13 -0700
X-CSE-ConnectionGUID: r2ywHAtgS5iYi8bKN5Xb2A==
X-CSE-MsgGUID: 9dB1DladTp2MmzWCr17SEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272004480"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:44:12 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 28/28] KVM: selftests: Add fred exception tests
Date: Fri, 11 Sep 2026 14:36:58 -0700
Message-ID: <20260911213659.2025974-29-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Add tests for FRED event data and VMX nested-exception.

FRED is designed to save a complete event context in its stack frame,
e.g., FRED saves the faulting linear address of a #PF into a 64-bit
event data field defined in FRED stack frame.  As such, FRED VMX adds
event data handling during VMX transitions.

Besides, FRED introduces event stack levels to dispatch an event handler
onto a stack based on current stack level and stack levels defined in
IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
support ensures a correct event stack level is chosen when a VM entry
injects a nested exception, which is regarded as occurred in ring 0.

To fully test the underlying FRED VMX code, this test should be run one
more round with EPT disabled to inject page faults as nested exceptions.

Originally-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Treat as new patch (last posted in v2).
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |  33 ++
 tools/testing/selftests/kvm/x86/fred_test.c   | 291 ++++++++++++++++++
 3 files changed, 325 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/fred_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 96bab7002d39..73aed018f4a3 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -78,6 +78,7 @@ TEST_GEN_PROGS_x86 += x86/feature_msrs_test
 TEST_GEN_PROGS_x86 += x86/evmcs_smm_controls_test
 TEST_GEN_PROGS_x86 += x86/exit_on_emulation_failure_test
 TEST_GEN_PROGS_x86 += x86/fastops_test
+TEST_GEN_PROGS_x86 += x86/fred_test
 TEST_GEN_PROGS_x86 += x86/fix_hypercall_test
 TEST_GEN_PROGS_x86 += x86/hwcr_msr_test
 TEST_GEN_PROGS_x86 += x86/hyperv_clock
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 916646cb4d89..988c45e32689 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -79,6 +79,7 @@ const char *ex_str(int vector);
 #define X86_CR4_SMEP		(1ul << 20)
 #define X86_CR4_SMAP		(1ul << 21)
 #define X86_CR4_PKE		(1ul << 22)
+#define X86_CR4_FRED		(1ul << 32)
 
 struct xstate_header {
 	u64				xstate_bv;
@@ -1646,4 +1647,36 @@ u64 *tdp_get_pte(struct kvm_vm *vm, u64 l2_gpa);
 
 bool sys_clocksource_is_based_on_tsc(void);
 
+/*
+ * FRED related data structures and functions
+ */
+
+#define FRED_SSX_NMI		BIT_ULL(18)
+
+struct fred_stack {
+	u64 r15;
+	u64 r14;
+	u64 r13;
+	u64 r12;
+	u64 bp;
+	u64 bx;
+	u64 r11;
+	u64 r10;
+	u64 r9;
+	u64 r8;
+	u64 ax;
+	u64 cx;
+	u64 dx;
+	u64 si;
+	u64 di;
+	u64 error_code;
+	u64 ip;
+	u64 csx;
+	u64 flags;
+	u64 sp;
+	u64 ssx;
+	u64 event_data;
+	u64 reserved;
+};
+
 #endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/x86/fred_test.c b/tools/testing/selftests/kvm/x86/fred_test.c
new file mode 100644
index 000000000000..c7d08e5253b9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/fred_test.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FRED nested exception tests
+ *
+ * Copyright (C) 2023, Intel, Inc.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <asm/msr-index.h>
+
+#include "apic.h"
+#include "kvm_util.h"
+#include "test_util.h"
+#include "guest_modes.h"
+#include "processor.h"
+
+#define IRQ_VECTOR 0xAA
+
+#define FRED_STKLVL(v,l)		(_AT(unsigned long, l) << (2 * (v)))
+#define FRED_CONFIG_ENTRYPOINT(p)	_AT(unsigned long, (p))
+
+/* This address is already mapped in guest page table. */
+#define FRED_VALID_RSP			0x8000
+
+/*
+ * The following addresses are not yet mapped in both EPT and guest page
+ * tables at the beginning.  As a result, it causes an EPT violation VM
+ * exit with an original guest #PF to access any of them for the first
+ * time.
+ *
+ * Use these addresses as guest FRED RSP0 to generate nested #PFs to test
+ * if event data are properly virtualized.
+ */
+static unsigned long fred_invalid_rsp[4] = {
+	0x0,
+	0xf0000000,
+	0xe0000000,
+	0xd0000000,
+};
+
+extern char asm_user_nop[];
+extern char asm_user_ud[];
+extern char asm_done_fault[];
+
+extern void asm_test_fault(int test);
+
+/*
+ * user level code for triggering faults.
+ */
+asm(".pushsection .text\n"
+    ".align 4096\n"
+
+    ".type asm_user_nop, @function\n"
+    "asm_user_nop:\n"
+    "1: .byte 0x90\n"
+    "jmp 1b\n"
+
+    ".org asm_user_nop + 16, 0xcc\n"
+    ".type asm_user_ud, @function\n"
+    "asm_user_ud:\n"
+    /* Trigger a #UD */
+    "ud2\n"
+
+    ".align 4096, 0xcc\n"
+    ".popsection");
+
+/* Send current stack level and #PF address */
+#define GUEST_SYNC_CSL_FA(__stage, __pf_address)		\
+	GUEST_SYNC_ARGS(__stage, __pf_address, 0, 0, 0)
+
+void fred_entry_from_user(struct fred_stack *stack)
+{
+	u32 current_stack_level = rdmsr(MSR_IA32_FRED_CONFIG) & 0x3;
+
+	GUEST_SYNC_CSL_FA(current_stack_level, stack->event_data);
+
+	/* Do NOT go back to user level, continue the next test instead */
+	stack->ssx = 0x18;
+	stack->csx = 0x10;
+	stack->ip = (u64)&asm_done_fault;
+}
+
+void fred_entry_from_kernel(struct fred_stack *stack)
+{
+	/*
+	 * Keep NMI blocked to delay the delivery of the next NMI until
+	 * returning to user level.
+	 * */
+	stack->ssx &= ~FRED_SSX_NMI;
+}
+
+#define PUSH_REGS	\
+	"push %rdi\n"	\
+	"push %rsi\n"	\
+	"push %rdx\n"	\
+	"push %rcx\n"	\
+	"push %rax\n"	\
+	"push %r8\n"	\
+	"push %r9\n"	\
+	"push %r10\n"	\
+	"push %r11\n"	\
+	"push %rbx\n"	\
+	"push %rbp\n"	\
+	"push %r12\n"	\
+	"push %r13\n"	\
+	"push %r14\n"	\
+	"push %r15\n"
+
+#define POP_REGS	\
+	"pop %r15\n"	\
+	"pop %r14\n"	\
+	"pop %r13\n"	\
+	"pop %r12\n"	\
+	"pop %rbp\n"	\
+	"pop %rbx\n"	\
+	"pop %r11\n"	\
+	"pop %r10\n"	\
+	"pop %r9\n"	\
+	"pop %r8\n"	\
+	"pop %rax\n"	\
+	"pop %rcx\n"	\
+	"pop %rdx\n"	\
+	"pop %rsi\n"	\
+	"pop %rdi\n"
+
+/*
+ * FRED entry points.
+ */
+asm(".pushsection .text\n"
+    ".type asm_fred_entrypoint_user, @function\n"
+    ".align 4096\n"
+    "asm_fred_entrypoint_user:\n"
+    PUSH_REGS
+    "movq %rsp, %rdi\n"
+    "call fred_entry_from_user\n"
+    POP_REGS
+    /* Do NOT go back to user level, continue the next test instead */
+    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
+
+    ".org asm_fred_entrypoint_user + 256, 0xcc\n"
+    ".type asm_fred_entrypoint_kernel, @function\n"
+    "asm_fred_entrypoint_kernel:\n"
+    PUSH_REGS
+    "movq %rsp, %rdi\n"
+    "call fred_entry_from_kernel\n"
+    POP_REGS
+    ".byte 0xf2,0x0f,0x01,0xca\n"	/* ERETS */
+    ".align 4096, 0xcc\n"
+    ".popsection");
+
+extern char asm_fred_entrypoint_user[];
+
+/*
+ * Prepare a FRED stack frame for ERETU to return to user level code,
+ * nop or ud2.
+ *
+ * Because FRED RSP0 is deliberately not mapped in guest page table,
+ * the delivery of interrupt/NMI or #UD from ring 3 causes a nested
+ * #PF, which is then delivered on FRED RSPx (x is 1, 2 or 3,
+ * determinated by MSR FRED_STKLVL[PF_VECTOR]).
+ */
+asm(".pushsection .text\n"
+    ".type asm_test_fault, @function\n"
+    ".align 4096\n"
+    "asm_test_fault:\n"
+    "endbr64\n"
+    "push %rbp\n"
+    "mov %rsp, %rbp\n"
+    "and $(~0x3f), %rsp\n"
+    "push $0\n"
+    "push $0\n"
+    "mov $0x2b, %rax\n"
+    /* Unblock NMI */
+    "bts $18, %rax\n"
+    /* Set long mode bit */
+    "bts $57, %rax\n"
+    "push %rax\n"
+    /* No stack required for the FRED user level test code */
+    "push $0\n"
+    "pushf\n"
+    "pop %rax\n"
+    /* Allow external interrupts */
+    "bts $9, %rax\n"
+    "push %rax\n"
+    "mov $0x33, %rax\n"
+    "push %rax\n"
+    "cmp $0, %edi\n"
+    "jne 1f\n"
+    "lea asm_user_nop(%rip), %rax\n"
+    "jmp 2f\n"
+    "1: lea asm_user_ud(%rip), %rax\n"
+    "2: push %rax\n"
+    "push $0\n"
+    /* ERETU to user level code to allow event delivery immediately */
+    ".byte 0xf3,0x0f,0x01,0xca\n"
+    "asm_done_fault:\n"
+    "mov %rbp, %rsp\n"
+    "pop %rbp\n"
+    "ret\n"
+    ".align 4096, 0xcc\n"
+    ".popsection");
+
+/*
+ * To fully test the underlying FRED VMX code, this test should be run one
+ * more round with EPT disabled to inject page faults as nested exceptions.
+ */
+static void guest_code(void)
+{
+	wrmsr(MSR_IA32_FRED_CONFIG,
+	      FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
+
+	wrmsr(MSR_IA32_FRED_RSP1, FRED_VALID_RSP);
+	wrmsr(MSR_IA32_FRED_RSP2, FRED_VALID_RSP);
+	wrmsr(MSR_IA32_FRED_RSP3, FRED_VALID_RSP);
+
+	/* Enable FRED */
+	set_cr4(get_cr4() | X86_CR4_FRED);
+
+	x2apic_enable();
+
+	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 1));
+	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[1]);
+	/* 1: ud2 to generate #UD */
+	asm_test_fault(1);
+
+	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 2));
+	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[2]);
+	asm volatile("cli");
+	/* Create a pending interrupt on current vCPU */
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
+			 APIC_DM_FIXED | IRQ_VECTOR);
+	/* Return to ring 3 */
+	asm_test_fault(0);
+	x2apic_write_reg(APIC_EOI, 0);
+
+	wrmsr(MSR_IA32_FRED_STKLVLS, FRED_STKLVL(PF_VECTOR, 3));
+	wrmsr(MSR_IA32_FRED_RSP0, fred_invalid_rsp[3]);
+	/*
+	 * The first NMI is just to have NMI blocked in ring 0, because
+	 * fred_entry_from_kernel() deliberately clears the NMI bit in
+	 * FRED stack frame.
+	 */
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
+			 APIC_DM_NMI | NMI_VECTOR);
+	/* The second NMI will be delivered after returning to ring 3 */
+	x2apic_write_reg(APIC_ICR, APIC_DEST_SELF | APIC_INT_ASSERT |
+			 APIC_DM_NMI | NMI_VECTOR);
+	/* Return to ring 3 */
+	asm_test_fault(0);
+
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	uint64_t expected_current_stack_level = 1;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_FRED));
+
+	vm = __vm_create_with_vcpus(VM_SHAPE(VM_MODE_PXXVYY_4K_USER), 1, 0,
+				    guest_code, &vcpu);
+
+	while (true) {
+		uint64_t r;
+
+		vcpu_run(vcpu);
+
+		r = get_ucall(vcpu, &uc);
+
+		if (r == UCALL_DONE)
+			break;
+
+		if (r == UCALL_SYNC) {
+			TEST_ASSERT((uc.args[1] == expected_current_stack_level) &&
+				    (uc.args[2] == fred_invalid_rsp[expected_current_stack_level] - 8),
+				    "Incorrect stack level %lx and #PF address %lx\n",
+				    uc.args[1], uc.args[2]);
+			expected_current_stack_level++;
+		}
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0


Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26A38AC65
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975057; cv=none; b=QKw5nKbHDod7hoe9Clg8wedi81hyyxgHHFVkz/8A+MSub7dY6yQa+fLLH9x+NpPlovED1sfKRPFibNxGJkuhzBqyxOBYzf4/IuOZysutIuC/8mF57nS8iNLD/aLhG2JBlvn2erXsOKh79sbjUarRLeZmF/BlTAbmVUL3vE9hiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975057; c=relaxed/simple;
	bh=VEQq8f1+yPg3UVCiwMi+stcFmUHJV9JPXAyDkWT2LDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3qh19hzznu9P/e594bbExllTbv+HLodoBk5kkOnY6wWP0PU4Xj4cB1dS/Jb8Cuy0w/o7Flu9KFBJCwnp9L+T6t65RUMaovOX79jGgabfbZHnwR0HD1QmTwwtbUGhMcestSo1ZypJkJtBjghmf0wLaqP1bXdTEotFRaAbtWPLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=zhZ2UX7X; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zhZ2UX7X"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6626odVk3434951
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Wed, 1 Jul 2026 23:50:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6626odVk3434951
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782975051;
	bh=A60ar5ntEf1fekF0kMG/0LpHQXgf4VEqsapt7/zO0cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhZ2UX7XZROEVh4JS66/MMIr/+/fFcsmH/E1Gm7n3F8qnFJFejJhPdaN4KH/54E+h
	 2GhWVDblaHDYSjMTI0O08q83MgOgqWxBwrXu6LAIwqlmVNkudBrVUpJ20Ih+2/FyV2
	 v41voR92ISrAnDVJkd5Jzh9KDjb1/wip7WPn24oRXtQkxoQwYg1ZDe+8TlN96wGEOc
	 5dxZhwMC1eSeL7jrcP5lgFRZIsDky2ZPqQ0JW9sEpgrotcAckch58E5PAxGe+kUg99
	 TYsZamYO8p+tKVPay6K5DBJ7YlQwdMhZ3qI+ERMDMZHx9eds7UQt4Pk/hqLb1QmKrM
	 K/bVcpUwWtQ0g==
From: Xin Li <xin@zytor.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, seanjc@google.com, chao.gao@intel.com, hpa@zytor.com,
        sohil.mehta@intel.com
Subject: [kvm-unit-tests PATCH v1 11/11] x86/vmx: Validate #GP injection for EFER.LME clear with FRED enabled
Date: Wed,  1 Jul 2026 23:50:39 -0700
Message-ID: <20260702065039.3434909-12-xin@zytor.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702065039.3434909-1-xin@zytor.com>
References: <20260702065039.3434909-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FRED specification mandates that FRED be disabled prior to leaving long
mode.  Add two test cases, one for L1 guest and the other for L2 guest, to
validate if KVM correctly injects #GP when a vCPU attempts to disable long
mode with FRED active.

Signed-off-by: Xin Li <xin@zytor.com>
---
 lib/x86/processor.h |   2 +
 x86/vmx.c           |  92 +++++++++++++++++++++++++++++++++++++
 x86/vmx.h           |  84 ++++++++++++++++++++++++++++++++++
 x86/vmx_tests.c     | 108 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 285 insertions(+), 1 deletion(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index b2726d93..5711c41f 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -139,6 +139,8 @@ static inline u64 get_non_canonical(u64 addr, u64 mask)
 #define X86_CR4_PKS		BIT(X86_CR4_PKS_BIT)
 #define X86_CR4_LAM_SUP_BIT	(28)
 #define X86_CR4_LAM_SUP		BIT(X86_CR4_LAM_SUP_BIT)
+#define X86_CR4_FRED_BIT	(32)
+#define X86_CR4_FRED		BIT(X86_CR4_FRED_BIT)
 
 #define X86_EFLAGS_CF_BIT	(0)
 #define X86_EFLAGS_CF		BIT(X86_EFLAGS_CF_BIT)
diff --git a/x86/vmx.c b/x86/vmx.c
index df212e19..4c8ee9d4 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -1892,6 +1892,98 @@ out:
 	return 0;
 }
 
+static fred_handler fred_user_handler;
+static fred_handler fred_kernel_handler;
+
+void fred_set_user_handler(fred_handler handler)
+{
+	fred_user_handler = handler;
+}
+
+void fred_set_kernel_handler(fred_handler handler)
+{
+	fred_kernel_handler = handler;
+}
+
+static void __attribute__((__used__)) fred_entry_from_user(struct fred_stack_frame *fred_stack_frame)
+{
+	if (fred_user_handler)
+		return fred_user_handler(fred_stack_frame);
+}
+
+static void __attribute__((__used__)) fred_entry_from_kernel(struct fred_stack_frame *fred_stack_frame)
+{
+	if (fred_kernel_handler)
+		return fred_kernel_handler(fred_stack_frame);
+}
+
+#define FRED_PUSH_AND_CLEAR_REGS				\
+	"	push   %rdi\n\t"				\
+	"	push   %rsi\n\t"				\
+	"	push   %rdx\n\t"				\
+	"	push   %rcx\n\t"				\
+	"	push   %rax\n\t"				\
+	"	push   %r8\n\t"					\
+	"	push   %r9\n\t"					\
+	"	push   %r10\n\t"				\
+	"	push   %r11\n\t"				\
+	"	push   %rbx\n\t"				\
+	"	push   %rbp\n\t"				\
+	"	push   %r12\n\t"				\
+	"	push   %r13\n\t"				\
+	"	push   %r14\n\t"				\
+	"	push   %r15\n\t"				\
+	"	xor    %esi,%esi\n\t"				\
+	"	xor    %edx,%edx\n\t"				\
+	"	xor    %ecx,%ecx\n\t"				\
+	"	xor    %r8d,%r8d\n\t"				\
+	"	xor    %r9d,%r9d\n\t"				\
+	"	xor    %r10d,%r10d\n\t"				\
+	"	xor    %r11d,%r11d\n\t"				\
+	"	xor    %ebx,%ebx\n\t"				\
+	"	xor    %ebp,%ebp\n\t"				\
+	"	xor    %r12d,%r12d\n\t"				\
+	"	xor    %r13d,%r13d\n\t"				\
+	"	xor    %r14d,%r14d\n\t"				\
+	"	xor    %r15d,%r15d\n\t"
+
+#define FRED_POP_REGS						\
+	"	pop    %r15\n\t"				\
+	"	pop    %r14\n\t"				\
+	"	pop    %r13\n\t"				\
+	"	pop    %r12\n\t"				\
+	"	pop    %rbp\n\t"				\
+	"	pop    %rbx\n\t"				\
+	"	pop    %r11\n\t"				\
+	"	pop    %r10\n\t"				\
+	"	pop    %r9\n\t"					\
+	"	pop    %r8\n\t"					\
+	"	pop    %rax\n\t"				\
+	"	pop    %rcx\n\t"				\
+	"	pop    %rdx\n\t"				\
+	"	pop    %rsi\n\t"				\
+	"	pop    %rdi\n\t"
+
+/* FRED entry points */
+asm(
+	".align 4096\n\t"
+	".globl asm_fred_entrypoint_user\n\t"
+	"asm_fred_entrypoint_user:\n\t"
+	FRED_PUSH_AND_CLEAR_REGS
+	"	mov    %rsp,%rdi\n\t"
+	"	call   fred_entry_from_user\n\t"
+	FRED_POP_REGS
+	"	eretu\n\t"
+	".org	asm_fred_entrypoint_user + 256, 0xcc\n\t"
+	".globl asm_fred_entrypoint_kernel\n\t"
+	"asm_fred_entrypoint_kernel:\n\t"
+	FRED_PUSH_AND_CLEAR_REGS
+	"	mov    %rsp,%rdi\n\t"
+	"	call   fred_entry_from_kernel\n\t"
+	FRED_POP_REGS
+	"	erets\n\t"
+);
+
 /*
  * Add a teardown step. Executed after the test's main function returns.
  * Teardown steps executed in reverse order.
diff --git a/x86/vmx.h b/x86/vmx.h
index e2e6df9c..c9c1abb6 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -59,6 +59,85 @@ struct invvpid_operand {
 	u64 gla;
 };
 
+struct regs {
+	u64 rax;
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	u64 cr2;
+	u64 rbp;
+	u64 rsi;
+	u64 rdi;
+	u64 r8;
+	u64 r9;
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+	u64 rflags;
+};
+
+struct fred_cs {
+        u64     cs      : 16,
+                sl      :  2,
+                wfe     :  1,
+                        : 45;
+};
+
+struct fred_ss {
+        u64     ss      : 16,
+                sti     :  1,
+                swevent :  1,
+                nmi     :  1,
+                        : 13,
+                vector  :  8,
+                        :  8,
+                type    :  4,
+                        :  4,
+                enclave :  1,
+                l       :  1,
+                nested  :  1,
+                        :  1,
+                insnlen :  4;
+};
+
+struct fred_stack_frame {
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
+
+	u64 orig_ax;
+	u64 ip;
+	union {
+		u16 cs;
+		u64 csx;
+		struct fred_cs fred_cs;
+	};
+	u64 flags;
+	u64 sp;
+	union {
+		u16 ss;
+		u64 ssx;
+		struct fred_ss fred_ss;
+	};
+	u64 edata;
+	u64 resv;
+};
+
 union exit_reason {
 	struct {
 		u32	basic			: 16;
@@ -1031,4 +1110,9 @@ void test_add_teardown(test_teardown_func func, void *data);
 void test_skip(const char *msg);
 void test_set_guest_finished(void);
 
+extern void *asm_fred_entrypoint_user;
+typedef void (*fred_handler)(struct fred_stack_frame *fred_stack_frame);
+void fred_set_user_handler(fred_handler handler);
+void fred_set_kernel_handler(fred_handler handler);
+
 #endif
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index aafcb465..6e2f8c4c 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -547,7 +547,8 @@ static int test_ctrl_efer_exit_handler(union exit_reason exit_reason)
 	return VMX_TEST_VMEXIT;
 }
 
-u32 guest_cr0, guest_cr4;
+u32 guest_cr0;
+u64 guest_cr4;
 
 static void cr_shadowing_main(void)
 {
@@ -12573,6 +12574,109 @@ static void vmx_entry_fred_test(void)
 	test_set_guest_finished();
 }
 
+static void vmx_fred_cr4_test_kernel_handler(struct fred_stack_frame *fred_stack_frame)
+{
+	report(((read_cr4() & X86_CR4_FRED) == X86_CR4_FRED) &&
+	       fred_stack_frame->fred_ss.type == 3 &&
+	       fred_stack_frame->fred_ss.vector == 13,
+	       "#GP on clearing EFER.LME when FRED enabled");
+	/* Skip the WRMSR instruction that caused the #GP */
+	fred_stack_frame->ip += 2;
+}
+
+static void vmx_fred_cr4_test(void)
+{
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_FRED)) {
+		report_skip("Load FRED state entry control is not available");
+		return;
+	}
+
+	ia32_efer = rdmsr(MSR_EFER);
+	report((ia32_efer & (EFER_LME | EFER_LMA)) == (EFER_LME | EFER_LMA),
+	       "Guest in long mode");
+
+	report((read_cr4() & X86_CR4_FRED) != X86_CR4_FRED, "Guest FRED is disabled");
+	write_cr4(read_cr4() | X86_CR4_FRED);
+	report((read_cr4() & X86_CR4_FRED) == X86_CR4_FRED, "Guest FRED is enabled");
+
+	fred_set_kernel_handler(vmx_fred_cr4_test_kernel_handler);
+
+	wrmsr(MSR_IA32_FRED_CONFIG, (unsigned long)&asm_fred_entrypoint_user);
+
+	wrmsr(MSR_EFER, ia32_efer & ~EFER_LME);
+
+	report((read_cr4() & X86_CR4_FRED) == X86_CR4_FRED, "Guest FRED is enabled");
+	report((rdmsr(MSR_EFER) & (EFER_LME | EFER_LMA)) == (EFER_LME | EFER_LMA),
+	       "Guest in long mode");
+
+	write_cr4(read_cr4() & ~X86_CR4_FRED);
+
+	test_set_guest_finished();
+}
+
+static void vmx_nested_fred_cr4_test_guest(void)
+{
+	ia32_efer = rdmsr(MSR_EFER);
+	report((ia32_efer & (EFER_LME | EFER_LMA)) == (EFER_LME | EFER_LMA),
+	       "Nested guest in long mode");
+
+	report((read_cr4() & X86_CR4_FRED) != X86_CR4_FRED, "Nested guest FRED is disabled");
+	write_cr4(read_cr4() | X86_CR4_FRED);
+	report((read_cr4() & X86_CR4_FRED) == X86_CR4_FRED, "Nested guest FRED is enabled");
+
+	fred_set_kernel_handler(vmx_fred_cr4_test_kernel_handler);
+
+	wrmsr(MSR_IA32_FRED_CONFIG, (unsigned long)&asm_fred_entrypoint_user);
+
+	wrmsr(MSR_EFER, ia32_efer & ~EFER_LME);
+
+	report((read_cr4() & X86_CR4_FRED) == X86_CR4_FRED, "Nested guest FRED is enabled");
+	report((rdmsr(MSR_EFER) & (EFER_LME | EFER_LMA)) == (EFER_LME | EFER_LMA),
+	       "Nested guest in long mode");
+
+	write_cr4(read_cr4() & ~X86_CR4_FRED);
+
+	vmcall();
+}
+
+static void vmx_nested_fred_cr4_test(void)
+{
+	unsigned long guest_fred_config;
+
+	if (!(ctrl_enter_rev.clr & ENT_LOAD_FRED)) {
+		report_skip("Load FRED state entry control is not available");
+		return;
+	}
+
+	report((read_cr4() & X86_CR4_FRED) != X86_CR4_FRED, "Guest FRED is disabled");
+	report((rdmsr(MSR_EFER) & (EFER_LME | EFER_LMA)) == (EFER_LME | EFER_LMA),
+	       "Guest in long mode");
+
+	/* Allow the guest to read FRED MSRs directly */
+	msr_bmp_init();
+
+	vmcs_set_bits(ENT_CONTROLS, ENT_LOAD_FRED);
+	vmcs_set_bits(EXI_CONTROLS, EXI_ACTIVATE_CTRL1);
+	vmcs_set_bits(EXI_CTRL1, EXI_SAVE_FRED | EXI_LOAD_FRED);
+
+	vmcs_write(GUEST_FRED_CONFIG, 0);
+
+	test_set_guest(vmx_nested_fred_cr4_test_guest);
+	enter_guest();
+
+	guest_fred_config = vmcs_read(GUEST_FRED_CONFIG);
+	report(guest_fred_config == (unsigned long)&asm_fred_entrypoint_user,
+	       "VMCS guest FRED config is %lx", guest_fred_config);
+
+	report((read_cr4() & X86_CR4_FRED) != X86_CR4_FRED, "Guest FRED is disabled");
+	report((rdmsr(MSR_EFER) & (EFER_LME | EFER_LMA)) == (EFER_LME | EFER_LMA),
+	       "Guest in long mode");
+
+	write_cr4(read_cr4() & ~X86_CR4_FRED);
+
+	test_set_guest_finished();
+}
+
 #define TEST(name) { #name, .v2 = name }
 
 /* name/init/guest_main/exit_handler/vmfail_handler */
@@ -12697,5 +12801,7 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_exit_control_rtit_test),
 	TEST(vmx_exit_control_cet_test),
 	TEST(vmx_entry_fred_test),
+	TEST(vmx_fred_cr4_test),
+	TEST(vmx_nested_fred_cr4_test),
 	{ NULL, NULL, NULL, NULL },
 };
-- 
2.54.0


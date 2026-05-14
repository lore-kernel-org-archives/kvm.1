Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB923914F0
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792712; cv=none; b=MbYxaBb+CnmlkReQGxOW8gQdYeMjISZ8F6PVL7Wy9dknlcuqlEl0MHr/eQ2IR5JYfU3a6U+N+ivQ3MKFf9J4YIsCdRY+XXgboQThRqX32b0snIVTuy2PBvyC+RxPN0SfyPY9wriHkrfyTznhRggi7zJoX/OS1qS9zoJKv8TCJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792712; c=relaxed/simple;
	bh=0/AzIoKwdaxAu1dlqquLlCBPMrEdALjgk9OrNv92gcw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hk1bXKgUw1uZ6vq89dfjZnY6SQtiqDmEVKXNPrNcjz0HhWyMDBIK5k6QZL1hOxPqsAy3AkDqrpvSZDwvo3TyrZ3F8YKCCvDkAoR44KfYowsn4EyncBEEQsMUO/OCmbnDhEnr67qcXxrhxA6x89O7hagmOVQ+W+u6i/LTlUEtWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pBVFanW3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pBVFanW3"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9bf4so8156752a91.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792704; x=1779397504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ouiuk+k6aMM7vGP5lNsDT4rde8F/5Gt6QMtZ2o/pwU=;
        b=pBVFanW3YcheGYkTKdfmK2iTrphcisKxJZMNaTy/QdkZ1FnatsF4eY3bbOHCyEvNly
         93KUU5ZAeOeCUrZQU1yEbAgPG6NHcBPxKdzE9B4n4P9ac7ZBCZmeyMfkbMSt8LSZrti+
         YpLBIATQmmvAYLGmfXYIo2Cp2KMIwL3oUbwHdoizWInCt5/dLl1SN6Nz7vn7HzBpHwjo
         9l3Vn77998yJNjYMgKdJPmsOMIVjhBGxA02uXberilMVcdmb9eM02y9FTvLuD/0yZXHN
         mJcQScgo4eOcS8Xrx3vv2we5xfR3Ap12Pi6HlP6xsiwkWh37B03+vloHODNZHXom4Qyh
         HVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792704; x=1779397504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Ouiuk+k6aMM7vGP5lNsDT4rde8F/5Gt6QMtZ2o/pwU=;
        b=BZnzGQ7y9T3H/yjmuUkA4OuvKlSK4q6HIZmfu/ySCbrogIfceEl4XINrYrXDas0CDD
         OF88UMV66r32vAZ8MDgQMysK9zT1N0WJjieaAPPY5/kVHSE3LAV5BOK7DnNhtrHtU4+6
         pC15ahmLenPlbzLIrkRmSciHefUs4AWr37eGhYiF6ZfK0PnyT45USs+zdwK035ui5kns
         wCfShQW1G3JBHJ5UA7zQJaeH7UV9LCl6kfAL+wed8zyZ0EZxba4rEcw5AqfFWa8Dgo5o
         63HGOB4Ye2sRmbYXHwdddGDNIenaox/XmRg9RQwWrPYHAbFDggOTj8sSav/cr51LhMCX
         WpXg==
X-Gm-Message-State: AOJu0YwGIEyNVkNJhygK//9+0bjAdBowFjQSvWAHZyCk47eZ0xuzndQ2
	Yk6RkziPpCuplUss4D7MmEfQeyHskEAyU3nfxL2lJlWCUUxUZCPV3/gX5NFYAitl7VfJdsmNJe0
	meDYKrA==
X-Received: from pjbqi11.prod.google.com ([2002:a17:90b:274b:b0:369:4256:dcf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4d:b0:369:224d:8bf8
 with SMTP id 98e67ed59e1d1-36951cacafbmr900080a91.25.1778792703551; Thu, 14
 May 2026 14:05:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:41 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-2-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 01/20] x86/vmx: Drop unused SYSENTER
 "support" in nested VMX infrastructure
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Drop the unused SYSTENTER "support" from the nested VMX infrastructure, in
quotes because the code is half-baked (and that's being generous) and
likely has never been used.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 x86/vmx.c       | 32 +++++---------------------------
 x86/vmx.h       | 20 --------------------
 x86/vmx_tests.c | 45 +++++++++++++++++++++------------------------
 3 files changed, 26 insertions(+), 71 deletions(-)

diff --git a/x86/vmx.c b/x86/vmx.c
index eb2965d8..2b85ef0b 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -42,7 +42,7 @@
 u64 *bsp_vmxon_region;
 struct vmcs *vmcs_root;
 u32 vpid_cnt;
-u64 guest_stack_top, guest_syscall_stack_top;
+u64 guest_stack_top;
 u32 ctrl_pin, ctrl_enter, ctrl_exit, ctrl_cpu[2];
 struct regs regs;
 
@@ -76,7 +76,6 @@ union vmx_ept_vpid  ept_vpid;
 extern struct descriptor_table_ptr gdt_descr;
 extern struct descriptor_table_ptr idt_descr;
 extern void *vmx_return;
-extern void *entry_sysenter;
 extern void *guest_entry;
 
 static volatile u32 stage;
@@ -561,25 +560,6 @@ void vmx_inc_test_stage(void)
 	barrier();
 }
 
-/* entry_sysenter */
-asm(
-	".align	4, 0x90\n\t"
-	".globl	entry_sysenter\n\t"
-	"entry_sysenter:\n\t"
-	SAVE_GPR
-	"	and	$0xf, %rax\n\t"
-	"	mov	%rax, %rdi\n\t"
-	"	call	syscall_handler\n\t"
-	LOAD_GPR
-	"	vmresume\n\t"
-);
-
-static void __attribute__((__used__)) syscall_handler(u64 syscall_no)
-{
-	if (current->syscall_handler)
-		current->syscall_handler(syscall_no);
-}
-
 static const char * const exit_reason_descriptions[] = {
 	[VMX_EXC_NMI]		= "VMX_EXC_NMI",
 	[VMX_EXTINT]		= "VMX_EXTINT",
@@ -1123,7 +1103,7 @@ static void init_vmcs_host(void)
 	vmcs_write(HOST_CR0, read_cr0());
 	vmcs_write(HOST_CR3, read_cr3());
 	vmcs_write(HOST_CR4, read_cr4());
-	vmcs_write(HOST_SYSENTER_EIP, (u64)(&entry_sysenter));
+	vmcs_write(HOST_SYSENTER_EIP, rdmsr(MSR_IA32_SYSENTER_EIP));
 	vmcs_write(HOST_SYSENTER_CS,  KERNEL_CS);
 	if (ctrl_exit_rev.clr & EXI_LOAD_PAT)
 		vmcs_write(HOST_PAT, rdmsr(MSR_IA32_CR_PAT));
@@ -1172,8 +1152,8 @@ static void init_vmcs_guest(void)
 	vmcs_write(GUEST_CR3, guest_cr3);
 	vmcs_write(GUEST_CR4, guest_cr4);
 	vmcs_write(GUEST_SYSENTER_CS,  KERNEL_CS);
-	vmcs_write(GUEST_SYSENTER_ESP, guest_syscall_stack_top);
-	vmcs_write(GUEST_SYSENTER_EIP, (u64)(&entry_sysenter));
+	vmcs_write(GUEST_SYSENTER_ESP, rdmsr(MSR_IA32_SYSENTER_ESP));
+	vmcs_write(GUEST_SYSENTER_EIP, rdmsr(MSR_IA32_SYSENTER_EIP));
 	vmcs_write(GUEST_DR7, 0);
 	vmcs_write(GUEST_EFER, rdmsr(MSR_EFER));
 
@@ -1319,7 +1299,6 @@ static void alloc_bsp_vmx_pages(void)
 {
 	bsp_vmxon_region = alloc_page();
 	guest_stack_top = (uintptr_t)alloc_page() + PAGE_SIZE;
-	guest_syscall_stack_top = (uintptr_t)alloc_page() + PAGE_SIZE;
 	vmcs_root = alloc_page();
 }
 
@@ -1840,8 +1819,7 @@ static int test_run(struct vmx_test *test)
 	/* Validate V2 interface. */
 	if (test->v2) {
 		int ret = 0;
-		if (test->init || test->guest_main || test->exit_handler ||
-		    test->syscall_handler) {
+		if (test->init || test->guest_main || test->exit_handler) {
 			report_fail("V2 test cannot specify V1 callbacks.");
 			ret = 1;
 		}
diff --git a/x86/vmx.h b/x86/vmx.h
index 7ad7672a..f4ed5339 100644
--- a/x86/vmx.h
+++ b/x86/vmx.h
@@ -121,7 +121,6 @@ struct vmx_test {
 	int (*init)(struct vmcs *vmcs);
 	void (*guest_main)(void);
 	int (*exit_handler)(union exit_reason exit_reason);
-	void (*syscall_handler)(u64 syscall_no);
 	struct regs guest_regs;
 	int (*entry_failure_handler)(struct vmentry_result *result);
 	struct vmcs *vmcs;
@@ -589,25 +588,6 @@ enum vm_entry_failure_code {
 	ENTRY_FAIL_VMCS_LINK_PTR	= 4,
 };
 
-#define SAVE_GPR				\
-	"xchg %rax, regs\n\t"			\
-	"xchg %rcx, regs+0x8\n\t"		\
-	"xchg %rdx, regs+0x10\n\t"		\
-	"xchg %rbx, regs+0x18\n\t"		\
-	"xchg %rbp, regs+0x28\n\t"		\
-	"xchg %rsi, regs+0x30\n\t"		\
-	"xchg %rdi, regs+0x38\n\t"		\
-	"xchg %r8, regs+0x40\n\t"		\
-	"xchg %r9, regs+0x48\n\t"		\
-	"xchg %r10, regs+0x50\n\t"		\
-	"xchg %r11, regs+0x58\n\t"		\
-	"xchg %r12, regs+0x60\n\t"		\
-	"xchg %r13, regs+0x68\n\t"		\
-	"xchg %r14, regs+0x70\n\t"		\
-	"xchg %r15, regs+0x78\n\t"
-
-#define LOAD_GPR	SAVE_GPR
-
 #define SAVE_GPR_C				\
 	"xchg %%rax, regs\n\t"			\
 	"xchg %%rcx, regs+0x8\n\t"		\
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index ff387ded..83d88480 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -11757,40 +11757,37 @@ static void vmx_cet_test(void)
 
 #define TEST(name) { #name, .v2 = name }
 
-/* name/init/guest_main/exit_handler/syscall_handler/guest_regs */
+/* name/init/guest_main/exit_handler/guest_regs */
 struct vmx_test vmx_tests[] = {
-	{ "null", NULL, basic_guest_main, basic_exit_handler, NULL, {0} },
-	{ "vmenter", NULL, vmenter_main, vmenter_exit_handler, NULL, {0} },
+	{ "null", NULL, basic_guest_main, basic_exit_handler, {0} },
+	{ "vmenter", NULL, vmenter_main, vmenter_exit_handler, {0} },
 	{ "preemption timer", preemption_timer_init, preemption_timer_main,
-		preemption_timer_exit_handler, NULL, {0} },
+		preemption_timer_exit_handler, {0} },
 	{ "control field PAT", test_ctrl_pat_init, test_ctrl_pat_main,
-		test_ctrl_pat_exit_handler, NULL, {0} },
+		test_ctrl_pat_exit_handler, {0} },
 	{ "control field EFER", test_ctrl_efer_init, test_ctrl_efer_main,
-		test_ctrl_efer_exit_handler, NULL, {0} },
+		test_ctrl_efer_exit_handler, {0} },
 	{ "CR shadowing", NULL, cr_shadowing_main,
-		cr_shadowing_exit_handler, NULL, {0} },
+		cr_shadowing_exit_handler, {0} },
 	{ "I/O bitmap", iobmp_init, iobmp_main, iobmp_exit_handler,
-		NULL, {0} },
+		{0} },
 	{ "instruction intercept", insn_intercept_init, insn_intercept_main,
-		insn_intercept_exit_handler, NULL, {0} },
-	{ "EPT A/D disabled", ept_init, ept_main, ept_exit_handler, NULL, {0} },
-	{ "EPT A/D enabled", eptad_init, eptad_main, eptad_exit_handler, NULL, {0} },
-	{ "PML", pml_init, pml_main, pml_exit_handler, NULL, {0} },
-	{ "interrupt", interrupt_init, interrupt_main,
-		interrupt_exit_handler, NULL, {0} },
-	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main,
-		nmi_hlt_exit_handler, NULL, {0} },
-	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler,
-		NULL, {0} },
+		insn_intercept_exit_handler, {0} },
+	{ "EPT A/D disabled", ept_init, ept_main, ept_exit_handler, {0} },
+	{ "EPT A/D enabled", eptad_init, eptad_main, eptad_exit_handler, {0} },
+	{ "PML", pml_init, pml_main, pml_exit_handler, {0} },
+	{ "interrupt", interrupt_init, interrupt_main, interrupt_exit_handler, {0} },
+	{ "nmi_hlt", nmi_hlt_init, nmi_hlt_main, nmi_hlt_exit_handler, {0} },
+	{ "debug controls", dbgctls_init, dbgctls_main, dbgctls_exit_handler, {0} },
 	{ "MSR switch", msr_switch_init, msr_switch_main,
-		msr_switch_exit_handler, NULL, {0}, msr_switch_entry_failure },
-	{ "vmmcall", vmmcall_init, vmmcall_main, vmmcall_exit_handler, NULL, {0} },
+		msr_switch_exit_handler, {0}, msr_switch_entry_failure },
+	{ "vmmcall", vmmcall_init, vmmcall_main, vmmcall_exit_handler, {0} },
 	{ "disable RDTSCP", disable_rdtscp_init, disable_rdtscp_main,
-		disable_rdtscp_exit_handler, NULL, {0} },
+		disable_rdtscp_exit_handler, {0} },
 	{ "exit_monitor_from_l2_test", NULL, exit_monitor_from_l2_main,
-		exit_monitor_from_l2_handler, NULL, {0} },
+		exit_monitor_from_l2_handler, {0} },
 	{ "invalid_msr", invalid_msr_init, invalid_msr_main,
-		invalid_msr_exit_handler, NULL, {0}, invalid_msr_entry_failure},
+		invalid_msr_exit_handler, {0}, invalid_msr_entry_failure},
 	/* Basic V2 tests. */
 	TEST(v2_null_test),
 	TEST(v2_multiple_entries_test),
@@ -11876,5 +11873,5 @@ struct vmx_test vmx_tests[] = {
 	TEST(vmx_canonical_test),
 	/* "Load CET" VM-entry/exit controls tests. */
 	TEST(vmx_cet_test),
-	{ NULL, NULL, NULL, NULL, NULL, {0} },
+	{ NULL, NULL, NULL, NULL, {0} },
 };
-- 
2.54.0.563.g4f69b47b94-goog


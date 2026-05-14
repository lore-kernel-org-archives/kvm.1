Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA443CC7CD
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792712; cv=none; b=KTGKLiYqVhuP3wjxIcYogN8755PtRB/3qnKh8ywwJbTyqsG3NYEyst4Sg7hMsT/a0FzbSQAxsvrsrT2K2pY+Y4kkxob+8njjSOo11r6B1NWdhmbDf6L6EDcD5j0EtbB6TCotB2pH4lIZXmeO08jvXLLjuvT1MivA2UNQ+JrlSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792712; c=relaxed/simple;
	bh=CMzuDwdpf/d7A78weuMfXxPpQ0dAocexlGK23LyKtHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oOw6M2mIPw6meyMsbhrFJzvb3nB2sH/d7hkKX5NWFhQjf42mKdUa7JDCmXiih2oGTcptvpfpb/7eJ8StJhrEKnKRWfIZAegPIDcAlg7HkMddIgGoimr+JcscSHC40IMeSDa0cW9wrCFnE+xNif/orvskVEcZiDxkv9fcSJNWf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bH/3Dg9Z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bH/3Dg9Z"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36865d109dcso5169565a91.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778792710; x=1779397510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XhzWUrl607HgkkDM0O/76Yfm3ZS6O+gl9+ydrutgNR4=;
        b=bH/3Dg9ZGhyEToXK8j+hLY7AC4NMd46iNXE+1u5t747QIL4paGUhxjtBcCmmU+Jum0
         vEdTs2b9G4VFS52bA2nWMncMdNTzOOny1fXcsj3RxpllDFRIbvXb6qjomrNa6AosqbGk
         iGUOvebpBPJEg5DtOrrFpH8Uy39tiJEQUbA8rfGhIO8Z56iYsmzoo/b4N993Nbm8NLKf
         65OjerIepRsJp1ijw80o5YZoso63kEYm2LUv3nXU1ukN+q+A1Gi726e5GdzCapv3jVwN
         hx/OZw5a6rZYHu4fLmEmqWeAgzRMh9pYtXtCsJstSCXwgtURBePfVVpyJUufDSf8EREF
         foFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778792710; x=1779397510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhzWUrl607HgkkDM0O/76Yfm3ZS6O+gl9+ydrutgNR4=;
        b=Vde3fPUTcOWPi5eiB9D+O9H65ELFwuqeAdoBGUf6g+b/FCUJuS/rPQSWFRMQAPjgAF
         q/ceM6u5HCLfG7TZcHl2IOEnFrPYIK+fQqi5d/K300ozO/OYgyA1ZTDg/6a7ypwQNaxp
         Rt7xCV8yafLlypAeZi4ziZnnwuu9vQOEQHcwnBnSe/wxz47h5tG21ruQEQlC5uUgmpnE
         3kgj9B6I8OtACBO2R4H+hvWQsgabisGGtLrF0L7cUJYpQF+wEOc+PbfzgKW/kR4+/iND
         XZ9RCD0aaOhNTTMGiniFHPqZXJWhLQmy0Xcs4oa8Qh5bnTNKk1FPytPe1VZJ/AMo0w4r
         PTuw==
X-Gm-Message-State: AOJu0YwoxwP/DmR3zk/vn4Vfjw5gfviOFZ2knq26fg4LPYejwxS4msn6
	oo0IniezADBke9/WWZOgerZehMtDon0od8ESQaATPuUCCjhY1LmMiynuLSQZmq24aqIyckx+IsO
	Z3K4Mrw==
X-Received: from pjbfw13.prod.google.com ([2002:a17:90b:128d:b0:368:5367:cd6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec1:b0:369:971:4888
 with SMTP id 98e67ed59e1d1-36951a6d3e8mr983329a91.15.1778792709363; Thu, 14
 May 2026 14:05:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:04:46 -0700
In-Reply-To: <20260514210500.1626871-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514210500.1626871-7-seanjc@google.com>
Subject: [kvm-unit-tests PATCH v3 06/20] x86/virt: Track "guest regs" using
 per-CPU variable
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Make the guest_regs structure used to context switch registers between
host and guest per-CPU to fix a bug where VMX tests that run multiple
vCPUs can fail due to register corruption, e.g. two CPUs enter the guest
in quick succession, only one of the CPU's registers will be preserved
across VM-Enter => VM-Exit.

Reported-by: Mathias Krause <minipli@grsecurity.net>
Closes: https://lore.kernel.org/all/3bac29b9-4c49-4e5d-997e-9e4019a2fceb@grsecurity.net
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 lib/x86/smp.h   | 25 +++++++++++++++++++++++++
 lib/x86/virt.h  | 35 ++++++++---------------------------
 x86/svm.c       | 14 +++++---------
 x86/svm.h       |  1 -
 x86/svm_tests.c |  5 +++--
 x86/vmx.c       | 19 +++++++++++--------
 x86/vmx_tests.c | 39 +++++++++++++++++++++++++--------------
 7 files changed, 77 insertions(+), 61 deletions(-)

diff --git a/lib/x86/smp.h b/lib/x86/smp.h
index 272aa5ee..e4dc0395 100644
--- a/lib/x86/smp.h
+++ b/lib/x86/smp.h
@@ -20,6 +20,30 @@
 #include "atomic.h"
 #include "apic-defs.h"
 
+struct guest_regs {
+	u64 rax;
+	u64 rcx;
+	u64 rdx;
+	u64 rbx;
+	/*
+	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
+	 * by software in any relevant flows.
+	 */
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
 /* Offsets into the per-cpu page. */
 struct percpu_data {
 	uint32_t  smp_id;
@@ -32,6 +56,7 @@ struct percpu_data {
 		uint32_t exception_data;
 	};
 	void *apic_ops;
+	struct guest_regs guest_regs;
 };
 
 #define typeof_percpu(name) typeof(((struct percpu_data *)0)->name)
diff --git a/lib/x86/virt.h b/lib/x86/virt.h
index 1066390d..d05d4fc6 100644
--- a/lib/x86/virt.h
+++ b/lib/x86/virt.h
@@ -2,35 +2,16 @@
 #define _x86_VIRT_H_
 
 #include "libcflat.h"
+#include "processor.h"
+#include "smp.h"
 
-struct guest_regs {
-	u64 rax;
-	u64 rcx;
-	u64 rdx;
-	u64 rbx;
-	/*
-	 * Use RSP's index to hold CR3, as RSP isn't manually context switched
-	 * by software in any relevant flows.
-	 */
-	u64 cr2;
-	u64 rbp;
-	u64 rsi;
-	u64 rdi;
-	u64 r8;
-	u64 r9;
-	u64 r10;
-	u64 r11;
-	u64 r12;
-	u64 r13;
-	u64 r14;
-	u64 r15;
-	u64 rflags;
-};
-
-extern struct guest_regs regs;
+static inline struct guest_regs *this_cpu_guest_regs(void)
+{
+	return (void *)rdmsr(MSR_GS_BASE) + offsetof_percpu(guest_regs);
+}
 
 #define GUEST_REG_OFFSET(name) \
-	[off_##name] "i" (offsetof(struct guest_regs, name))
+	[off_##name] "i" (offsetof_percpu(guest_regs) + offsetof(struct guest_regs, name))
 
 #define GUEST_REGS_OFFSETS	\
 	GUEST_REG_OFFSET(rax),	\
@@ -52,7 +33,7 @@ extern struct guest_regs regs;
 	GUEST_REG_OFFSET(rflags)
 
 #define GUEST_REG(name) \
-	xxstr(regs+%c[off_##name])
+	xxstr(%%gs:%c[off_##name])
 
 #define SWAP_REG(name) \
 	"xchg %%" xxstr(name) "," GUEST_REG(name) "\n\t"
diff --git a/x86/svm.c b/x86/svm.c
index 1762cadb..beb57f33 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -223,13 +223,6 @@ void vmcb_ident(struct vmcb *vmcb)
 	}
 }
 
-struct guest_regs regs;
-
-struct guest_regs get_regs(void)
-{
-	return regs;
-}
-
 // rax handled specially below
 
 
@@ -246,8 +239,10 @@ void svm_setup_vmrun(u64 rip)
 
 u64 __svm_vmrun(u64 rip)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	svm_setup_vmrun(rip);
-	regs.rdi = (ulong)v2_test;
+	regs->rdi = (ulong)v2_test;
 
 	asm volatile (
 		      ASM_PRE_VMRUN_CMD
@@ -269,6 +264,7 @@ extern u8 vmrun_rip;
 
 static noinline void test_run(struct svm_test *test)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	u64 vmcb_phys = virt_to_phys(vmcb);
 
 	cli();
@@ -278,7 +274,7 @@ static noinline void test_run(struct svm_test *test)
 	guest_main = test->guest_func;
 	vmcb->save.rip = (ulong)test_thunk;
 	vmcb->save.rsp = (ulong)(guest_stack + ARRAY_SIZE(guest_stack));
-	regs.rdi = (ulong)test;
+	regs->rdi = (ulong)test;
 	do {
 		struct svm_test *the_test = test;
 		u64 the_vmcb = vmcb_phys;
diff --git a/x86/svm.h b/x86/svm.h
index 67a1cddd..4e7e9e7a 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -416,7 +416,6 @@ int get_test_stage(struct svm_test *test);
 void set_test_stage(struct svm_test *test, int s);
 void inc_test_stage(struct svm_test *test);
 void vmcb_ident(struct vmcb *vmcb);
-struct guest_regs get_regs(void);
 void vmmcall(void);
 void svm_setup_vmrun(u64 rip);
 u64 __svm_vmrun(u64 rip);
diff --git a/x86/svm_tests.c b/x86/svm_tests.c
index 8ce3cc2e..8547e729 100644
--- a/x86/svm_tests.c
+++ b/x86/svm_tests.c
@@ -577,6 +577,7 @@ static void restore_msrpm_bit(int bit_nr, bool set)
 
 static bool msr_intercept_finished(struct svm_test *test)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	u32 exit_code = vmcb->control.exit_code;
 	bool all_set = false;
 	int bit_nr;
@@ -649,9 +650,9 @@ static bool msr_intercept_finished(struct svm_test *test)
 	 *      while RAX hold its lower 32 bits.
 	 */
 	if (vmcb->control.exit_info_1)
-		test->scratch = ((get_regs().rdx << 32) | (vmcb->save.rax & 0xffffffff));
+		test->scratch = ((regs->rdx << 32) | (vmcb->save.rax & 0xffffffff));
 	else
-		test->scratch = get_regs().rcx;
+		test->scratch = regs->rcx;
 
 	return false;
 }
diff --git a/x86/vmx.c b/x86/vmx.c
index 8a38ae8a..4cb8d66c 100644
--- a/x86/vmx.c
+++ b/x86/vmx.c
@@ -44,7 +44,6 @@ struct vmcs *vmcs_root;
 u32 vpid_cnt;
 u64 guest_stack_top;
 u32 ctrl_pin, ctrl_enter, ctrl_exit, ctrl_cpu[2];
-struct guest_regs regs;
 
 struct vmx_test *current;
 
@@ -632,6 +631,8 @@ const char *exit_reason_description(u64 reason)
 
 void print_vmexit_info(union exit_reason exit_reason)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
+
 	u64 guest_rip, guest_rsp;
 	ulong exit_qual = vmcs_read(EXI_QUALIFICATION);
 	guest_rip = vmcs_read(GUEST_RIP);
@@ -642,13 +643,13 @@ void print_vmexit_info(union exit_reason exit_reason)
 	printf("\texit qualification = %#lx\n", exit_qual);
 	printf("\tguest_rip = %#lx\n", guest_rip);
 	printf("\tRAX=%#lx    RBX=%#lx    RCX=%#lx    RDX=%#lx\n",
-		regs.rax, regs.rbx, regs.rcx, regs.rdx);
+		regs->rax, regs->rbx, regs->rcx, regs->rdx);
 	printf("\tRSP=%#lx    RBP=%#lx    RSI=%#lx    RDI=%#lx\n",
-		guest_rsp, regs.rbp, regs.rsi, regs.rdi);
+		guest_rsp, regs->rbp, regs->rsi, regs->rdi);
 	printf("\tR8 =%#lx    R9 =%#lx    R10=%#lx    R11=%#lx\n",
-		regs.r8, regs.r9, regs.r10, regs.r11);
+		regs->r8, regs->r9, regs->r10, regs->r11);
 	printf("\tR12=%#lx    R13=%#lx    R14=%#lx    R15=%#lx\n",
-		regs.r12, regs.r13, regs.r14, regs.r15);
+		regs->r12, regs->r13, regs->r14, regs->r15);
 }
 
 void print_vmentry_failure_info(struct vmentry_result *result)
@@ -1707,15 +1708,16 @@ void test_skip(const char *msg)
 
 static int exit_handler(union exit_reason exit_reason)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	int ret;
 
 	current->exits++;
-	regs.rflags = vmcs_read(GUEST_RFLAGS);
+	regs->rflags = vmcs_read(GUEST_RFLAGS);
 	if (is_hypercall(exit_reason))
 		ret = handle_hypercall();
 	else
 		ret = current->exit_handler(exit_reason);
-	vmcs_write(GUEST_RFLAGS, regs.rflags);
+	vmcs_write(GUEST_RFLAGS, regs->rflags);
 
 	return ret;
 }
@@ -1815,6 +1817,7 @@ static void run_teardown_step(struct test_teardown_step *step)
 
 static int test_run(struct vmx_test *test)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	int r;
 
 	/* Validate V2 interface. */
@@ -1835,7 +1838,7 @@ static int test_run(struct vmx_test *test)
 		return 1;
 	}
 
-	memset(&regs, 0, sizeof(regs));
+	memset(regs, 0, sizeof(regs));
 	init_vmcs(&(test->vmcs));
 	/* Directly call test->init is ok here, init_vmcs has done
 	   vmcs init, vmclear and vmptrld*/
diff --git a/x86/vmx_tests.c b/x86/vmx_tests.c
index e0d5e390..e2bf06ac 100644
--- a/x86/vmx_tests.c
+++ b/x86/vmx_tests.c
@@ -102,15 +102,16 @@ static void vmenter_main(void)
 
 static int vmenter_exit_handler(union exit_reason exit_reason)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	u64 guest_rip = vmcs_read(GUEST_RIP);
 
 	switch (exit_reason.basic) {
 	case VMX_VMCALL:
-		if (regs.rax != 0xABCD) {
+		if (regs->rax != 0xABCD) {
 			report_fail("test vmresume");
 			return VMX_TEST_VMEXIT;
 		}
-		regs.rax = 0xFFFF;
+		regs->rax = 0xFFFF;
 		vmcs_write(GUEST_RIP, guest_rip + 3);
 		return VMX_TEST_RESUME;
 	default:
@@ -10196,6 +10197,7 @@ static void vmx_sipi_test_guest(void)
 
 static void sipi_test_ap_thread(void *data)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	struct vmcs *ap_vmcs;
 	u64 *ap_vmxon_region;
 	void *ap_stack, *ap_syscall_stack;
@@ -10210,6 +10212,8 @@ static void sipi_test_ap_thread(void *data)
 	init_vmcs(&ap_vmcs);
 	make_vmcs_current(ap_vmcs);
 
+	memset(regs, 0, sizeof(regs));
+
 	/* Set stack for AP */
 	ap_stack = alloc_page();
 	ap_syscall_stack = alloc_page();
@@ -10652,10 +10656,11 @@ static unsigned long long host_time_to_guest_time(unsigned long long t)
 static unsigned long long rdtsc_vmexit_diff_test_iteration(void)
 {
 	unsigned long long guest_tsc, host_to_guest_tsc;
+	struct guest_regs *regs = this_cpu_guest_regs();
 
 	enter_guest();
 	skip_exit_vmcall();
-	guest_tsc = (u32) regs.rax + (regs.rdx << 32);
+	guest_tsc = (u32) regs->rax + (regs->rdx << 32);
 	host_to_guest_tsc = host_time_to_guest_time(exit_msr_store[0].value);
 
 	return host_to_guest_tsc - guest_tsc;
@@ -10881,6 +10886,7 @@ typedef void (*pf_exception_test_guest_t)(void);
 static void __vmx_pf_exception_test(invalidate_tlb_t inv_fn, void *data,
 				    pf_exception_test_guest_t guest_fn)
 {
+	struct guest_regs *regs = this_cpu_guest_regs();
 	u64 efer;
 	struct cpuid cpuid;
 
@@ -10897,23 +10903,23 @@ static void __vmx_pf_exception_test(invalidate_tlb_t inv_fn, void *data,
 	while (vmcs_read(EXI_REASON) != VMX_VMCALL) {
 		switch (vmcs_read(EXI_REASON)) {
 		case VMX_RDMSR:
-			assert(regs.rcx == MSR_EFER);
+			assert(regs->rcx == MSR_EFER);
 			efer = vmcs_read(GUEST_EFER);
-			regs.rdx = efer >> 32;
-			regs.rax = efer & 0xffffffff;
+			regs->rdx = efer >> 32;
+			regs->rax = efer & 0xffffffff;
 			break;
 		case VMX_WRMSR:
-			assert(regs.rcx == MSR_EFER);
-			efer = regs.rdx << 32 | (regs.rax & 0xffffffff);
+			assert(regs->rcx == MSR_EFER);
+			efer = regs->rdx << 32 | (regs->rax & 0xffffffff);
 			vmcs_write(GUEST_EFER, efer);
 			break;
 		case VMX_CPUID:
 			cpuid = (struct cpuid) {0, 0, 0, 0};
-			cpuid = raw_cpuid(regs.rax, regs.rcx);
-			regs.rax = cpuid.a;
-			regs.rbx = cpuid.b;
-			regs.rcx = cpuid.c;
-			regs.rdx = cpuid.d;
+			cpuid = raw_cpuid(regs->rax, regs->rcx);
+			regs->rax = cpuid.a;
+			regs->rbx = cpuid.b;
+			regs->rcx = cpuid.c;
+			regs->rdx = cpuid.d;
 			break;
 		case VMX_INVLPG:
 			inv_fn(data);
@@ -11250,7 +11256,12 @@ static void do_vmx_canonical_test_one_field(const char *field_name, u64 field)
 	field_org_value = vmcs_read(field);
 
 	test_host_value_direct(field_name, field);
-	test_host_value_vmcs(field_name, field);
+	/*
+	 * Skip the GS.base VMCS test, the VMX infrastructure accesses per-CPU
+	 * variables (referenced via GS) immediatedly after VM-Exit.
+	 */
+	if (field != HOST_BASE_GS)
+		test_host_value_vmcs(field_name, field);
 
 	/* Restore original values */
 	vmcs_write(field, field_org_value);
-- 
2.54.0.563.g4f69b47b94-goog


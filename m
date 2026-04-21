Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5736F41C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776804429; cv=none; b=ZAMTOA0ZYgwl6KbsRC4nOkD3qXfMSIHxSbIGRTMqvbUHO53yGszSdwI5twrz8xM5kANrRilgQsn7d8JHM2sjQfe1knQZp1fO0eesz+5JF9GCaLsbBQHYaSbYCdh6sxg+n4h+PQctE1Go/K8CMA6cR1Yb6JggGxC5DOiUSpOUxAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776804429; c=relaxed/simple;
	bh=d9t6Wu4dDhNwhaw/OJ+LDQheNxasppx8M5Z6jH7HdwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG7NX2lLJqL/GfBhNiAETGI+59Du1hwZv02N6aZZoa7i3sXabqlBNPx/o3s6d5L5NaLv177RwjocCnVVtR6HoIhdfr7D4BOgPO5zpxjLEk9iWnYeZec/C9zGm5p5gNiOsK4Tyi5ZafpWC0QY+G/OSPgRkrdRrEpW92UxX5YfgqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fQcw0fh/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQcw0fh/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ehAuFKbyuuB/W0yHmeXegjyGEiC9rpsFabqSElZlHVg=; b=fQcw0fh/KhdaUabEWIKO2ZX1qK
	IKlBtH+xRF3itcuUSpBtY6/I3lzjebR5zQ73LGk01sK74HNJKSF7GDWIxlpinfUnrSfFoglhVwObN
	tnkIW7qy4STOy5gzopsz5AIf5V/WWC32J98jb//LlAZcYBjOjoBxjRN9d5ApnEVHAcyVXq9SqcxVW
	dLO0AcVmn58VpgSlaNBi1+poYlaTM5Ae/gs/FaAhJSNsudF7hBvJnfzyZsQbymz3P5dceY8noInab
	JmrkizGaXdb4s6sS1qiNw7Idk3h3IHB3L3Sf4kNKmRaC5lIrTFKBbF1VhJugpX0Rc49Ok0HW9dEKb
	mzAzgA6A==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFHzo-0000000AhEC-0tqn;
	Tue, 21 Apr 2026 20:47:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7255D3008E2; Tue, 21 Apr 2026 22:46:58 +0200 (CEST)
Date: Tue, 21 Apr 2026 22:46:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260421204658.GG3102924@noisy.programming.kicks-ass.net>
References: <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
 <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421200620.GK3126523@noisy.programming.kicks-ass.net>

On Tue, Apr 21, 2026 at 10:06:20PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 11:55:33AM -0700, Sean Christopherson wrote:
> 
> > Pulling in an earlier idea:
> > 
> >  : Now for VMX, that hrtimer_rearm_deferred() call should really go into
> >  : handle_external_interrupt_irqoff(), which in turn requires to export
> >  : __hrtimer_rearm_deferred().
> > 
> 
> > Actually, even better would be to bury the FRED vs. not-FRED details in entry
> > code.  E.g. on the KVM invocation side, we could get to something like the below,
> > and I'm pretty sure _reduce_ the number of for-KVM exports in the process.
> 
> Something like so then?

And this one seems to build on ARCH=i386 too.

---
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 72cae8e0ce85..83b4762d6ecb 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -13,7 +13,7 @@ CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_syscall_32.o		+= -fno-stack-protector
 CFLAGS_syscall_64.o		+= -fno-stack-protector
 
-obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
new file mode 100644
index 000000000000..8de94a590b26
--- /dev/null
+++ b/arch/x86/entry/common.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/entry-common.h>
+#include <linux/kvm_types.h>
+#include <linux/hrtimer_rearm.h>
+#include <asm/fred.h>
+#include <asm/desc.h>
+
+noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
+{
+#ifdef CONFIG_X86_64
+	fred_entry_from_kvm(event_type, vector);
+#else
+	idt_entry_from_kvm(vector);
+#endif
+	if (event_type == EVENT_TYPE_EXTINT) {
+		instrumentation_begin();
+		hrtimer_rearm_deferred();
+		instrumentation_end();
+	}
+}
+EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 92c0b4a94e0a..9324e97d14cf 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1224,3 +1224,36 @@ SYM_CODE_START(rewind_stack_and_make_dead)
 1:	jmp 1b
 SYM_CODE_END(rewind_stack_and_make_dead)
 .popsection
+
+.pushsection .noinstr.text, "ax"
+.macro IDT_DO_EVENT_IRQOFF call_insn call_target
+	/*
+	 * Unconditionally create a stack frame, getting the correct RSP on the
+	 * stack (for x86-64) would take two instructions anyways, and RBP can
+	 * be used to restore RSP to make objtool happy (see below).
+	 */
+	push %ebp
+	mov %esp, %ebp
+
+	pushf
+	push $__KERNEL_CS
+	\call_insn \call_target
+
+	/*
+	 * "Restore" RSP from RBP, even though IRET has already unwound RSP to
+	 * the correct value.  objtool doesn't know the callee will IRET and,
+	 * without the explicit restore, thinks the stack is getting walloped.
+	 * Using an unwind hint is problematic due to x86-64's dynamic alignment.
+	 */
+	leave
+	RET
+.endm
+
+SYM_FUNC_START(idt_do_interrupt_irqoff)
+	IDT_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
+SYM_FUNC_END(idt_do_interrupt_irqoff)
+
+SYM_FUNC_START(idt_do_nmi_irqoff)
+	IDT_DO_EVENT_IRQOFF call asm_exc_nmi
+SYM_FUNC_END(idt_do_nmi_irqoff)
+.popsection
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 894f7f16eb80..0d2768ab836c 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -147,5 +147,4 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	RET
 
 SYM_FUNC_END(asm_fred_entry_from_kvm)
-EXPORT_SYMBOL_FOR_KVM(asm_fred_entry_from_kvm);
 #endif
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ec95fe44fa3a..f44d6a606b4c 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -438,6 +438,10 @@ extern void idt_setup_traps(void);
 extern void idt_setup_apic_and_irq_gates(void);
 extern bool idt_is_f00f_address(unsigned long address);
 
+extern void idt_do_interrupt_irqoff(unsigned int vector);
+extern void idt_do_nmi_irqoff(void);
+extern void idt_entry_from_kvm(unsigned int vector);
+
 #ifdef CONFIG_X86_64
 extern void idt_setup_early_pf(void);
 #else
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 7535131c711b..eca24b5e07f4 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -97,4 +97,6 @@ static __always_inline void arch_exit_to_user_mode(void)
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+extern void x86_entry_from_kvm(unsigned int entry_type, unsigned int vector);
+
 #endif
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 42bf6a58ec36..db4072875f5f 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -633,17 +633,6 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	xenpv_exc_machine_check);
 #endif
 
 /* NMI */
-
-#if IS_ENABLED(CONFIG_KVM_INTEL)
-/*
- * Special entry point for VMX which invokes this on the kernel stack, even for
- * 64-bit, i.e. without using an IST.  asm_exc_nmi() requires an IST to work
- * correctly vs. the NMI 'executing' marker.  Used for 32-bit kernels as well
- * to avoid more ifdeffery.
- */
-DECLARE_IDTENTRY(X86_TRAP_NMI,		exc_nmi_kvm_vmx);
-#endif
-
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
 #ifdef CONFIG_XEN_PV
 DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 260456588756..d95d8d196cd4 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -266,6 +266,14 @@ void __init idt_setup_early_pf(void)
 	idt_setup_from_table(idt_table, early_pf_idts,
 			     ARRAY_SIZE(early_pf_idts), true);
 }
+#else
+void idt_entry_from_kvm(unsigned int vector)
+{
+	if (vector == NMI_VECTOR)
+		idt_do_nmi_irqoff();
+	else
+		idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
+}
 #endif
 
 static void __init idt_map_in_cea(void)
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3d239ed12744..06fe225fb0a2 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -609,14 +609,6 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 		goto nmi_restart;
 }
 
-#if IS_ENABLED(CONFIG_KVM_INTEL)
-DEFINE_IDTENTRY_RAW(exc_nmi_kvm_vmx)
-{
-	exc_nmi(regs);
-}
-EXPORT_SYMBOL_FOR_KVM(asm_exc_nmi_kvm_vmx);
-#endif
-
 #ifdef CONFIG_NMI_CHECK_CPU
 
 static char *nmi_check_stall_msg[] = {
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 8a481dae9cae..ff1f254a0ef4 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -31,38 +31,6 @@
 #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
 #endif
 
-.macro VMX_DO_EVENT_IRQOFF call_insn call_target
-	/*
-	 * Unconditionally create a stack frame, getting the correct RSP on the
-	 * stack (for x86-64) would take two instructions anyways, and RBP can
-	 * be used to restore RSP to make objtool happy (see below).
-	 */
-	push %_ASM_BP
-	mov %_ASM_SP, %_ASM_BP
-
-#ifdef CONFIG_X86_64
-	/*
-	 * Align RSP to a 16-byte boundary (to emulate CPU behavior) before
-	 * creating the synthetic interrupt stack frame for the IRQ/NMI.
-	 */
-	and  $-16, %rsp
-	push $__KERNEL_DS
-	push %rbp
-#endif
-	pushf
-	push $__KERNEL_CS
-	\call_insn \call_target
-
-	/*
-	 * "Restore" RSP from RBP, even though IRET has already unwound RSP to
-	 * the correct value.  objtool doesn't know the callee will IRET and,
-	 * without the explicit restore, thinks the stack is getting walloped.
-	 * Using an unwind hint is problematic due to x86-64's dynamic alignment.
-	 */
-	leave
-	RET
-.endm
-
 .section .noinstr.text, "ax"
 
 /**
@@ -320,10 +288,6 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 
 SYM_FUNC_END(__vmx_vcpu_run)
 
-SYM_FUNC_START(vmx_do_nmi_irqoff)
-	VMX_DO_EVENT_IRQOFF call asm_exc_nmi_kvm_vmx
-SYM_FUNC_END(vmx_do_nmi_irqoff)
-
 #ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /**
@@ -375,13 +339,3 @@ SYM_FUNC_START(vmread_error_trampoline)
 	RET
 SYM_FUNC_END(vmread_error_trampoline)
 #endif
-
-.section .text, "ax"
-
-#ifndef CONFIG_X86_FRED
-
-SYM_FUNC_START(vmx_do_interrupt_irqoff)
-	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
-SYM_FUNC_END(vmx_do_interrupt_irqoff)
-
-#endif
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..f6f5c124ed3b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7127,17 +7127,9 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
 	    "unexpected VM-Exit interrupt info: 0x%x", intr_info))
 		return;
 
-	/*
-	 * Invoke the kernel's IRQ handler for the vector.  Use the FRED path
-	 * when it's available even if FRED isn't fully enabled, e.g. even if
-	 * FRED isn't supported in hardware, in order to avoid the indirect
-	 * CALL in the non-FRED path.
-	 */
+	/* For the IRQ to the core kernel for processing. */
 	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-	if (IS_ENABLED(CONFIG_X86_FRED))
-		fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
-	else
-		vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_base + vector));
+	x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
 	kvm_after_interrupt(vcpu);
 
 	vcpu->arch.at_instruction_boundary = true;
@@ -7447,10 +7439,7 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
-		fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
-	else
-		vmx_do_nmi_irqoff();
+	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
 	kvm_after_interrupt(vcpu);
 }
 

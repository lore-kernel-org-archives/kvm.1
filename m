Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D685B372EDE
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844020; cv=none; b=tRkssr4W0ipWMF2SFNHUTikyeMVbvR9H8uCv5CMDTs3z7S0jkkoF3lQTHexJsmck0Mh8I8CXolvuvbOPCQzzl/SoBzBNIzQgu6jm2hC3PEQp2gkUsJUdX409sKMKUIWh3lrd1652lwd5PnGR4uRgMErnBQxLfo9VcRVIt9yIe94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844020; c=relaxed/simple;
	bh=5OFWeDUCx5kJbjdkW451G/yWs5cdRME7dnngq7p24SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erzSwKEqoxzRQjn1kpwT5FpyyIJ+kk5CtRyiG75ZqlTSR99+38DboTJ6Shj9fccuoodIHbQT5g6Cx7KV1PdMesE64CYBwsfihdti93CxzDLgx0xpkpc1qJ1u4P/LRKXN5MzJYFJNoyb+r5gjv+LkAokHlJsxmCYjI3mNUUJez48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bxeI1pOu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bxeI1pOu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sV5KIoLeJ5G+Yc2lvQgNhD8OQMmSTDyTuSV8X7D/zYk=; b=bxeI1pOuhqxtS0IuWx0sj3VX7v
	PYyC7XCKoioc6XaU3W5ZVWmKJkjuvmHEdtsloCkAXNXMrudBvUoYP8nj/5m5LWHx8krzw65hJzYGO
	dc0dgUpRdwMtdFWBSkrri93cO6qbksomx3cgHAtHmTihPkTFXgeSMTCBQ38WjoNEKou/+X/2VBvFG
	5r8xs2wOAPDgbXf+Z1VwnzA4Qwr11+rVFeC1QCxIkiROtIIbhQXdeN2rBfhEm0qXlMIzh/9a6/GCD
	uVQIgABr3YBYwNcNMQto2Ip5k4ekZulI75si6QoAE5QwnajOVM7YKtwGxqlzDqCzdiYYUEw0TlDtF
	41ziuK1Q==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFSIK-0000000AwRc-1hdk;
	Wed, 22 Apr 2026 07:46:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E80EF3008E2; Wed, 22 Apr 2026 09:46:46 +0200 (CEST)
Date: Wed, 22 Apr 2026 09:46:46 +0200
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
Message-ID: <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
References: <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
 <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com>
 <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com>
 <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422065542.GN3126523@noisy.programming.kicks-ass.net>

On Wed, Apr 22, 2026 at 08:55:42AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 02:42:46PM -0700, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Peter Zijlstra wrote:
> > > On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:
> > > > This as delta? (I had typed this all up before Peter posted a new verison, so
> > > > dammit I'm sending it!)
> > > 
> > > :-)
> > > 
> > > I'll go stare at it in the morning, I'm about to go crash out.
> > 
> > New delta against your effective v2, builds all of my configs (which isn't _that_
> > many, but I think they cover most of the weirder ways to include KVM (or not)).
> > 
> > I'll start testing the full thing to try and get early signal on the health.
> 
> Oh, re-reading commit 28d11e4548b7, I think this wrecks NMIs. The patch
> will also use the FRED NMI path and that's not good when running IDT.
> 
> I'll go fix that and stick in a few more comments to clarify this magic.

This should probably we at least two patches, one moving the code into
the x86 core and one adding that hrtimer fix on top. But kept as one for
now.

Irrespective of the hrtimer fix, I think the initial move into x86 core
part is a sane move.

---
Subject: x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86

Move the VMX interrupt dispatch magic into the x86 core code. This
isolates KVM from the FRED/IDT decisions and reduces the amount of
EXPORT_SYMBOL_FOR_KVM().

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 000000000000..c8a9ddd3e809
--- /dev/null
+++ b/arch/x86/entry/common.c
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/entry-common.h>
+#include <linux/kvm_types.h>
+#include <linux/hrtimer_rearm.h>
+#include <asm/fred.h>
+#include <asm/desc.h>
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+/*
+ * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
+ * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
+ * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
+ * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
+ * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
+ * the VM-Exit is held pending until it's unblocked in the host.
+ */
+noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
+{
+	if (event_type == EVENT_TYPE_EXTINT) {
+#ifdef CONFIG_X86_64
+		/*
+		 * Use FRED dispatch, even when running IDT. The dispatch
+		 * tables are kept in sync between FRED and IDT, and the FRED
+		 * dispatch works well with CFI.
+		 */
+		fred_entry_from_kvm(event_type, vector);
+#else
+		idt_entry_from_kvm(vector);
+#endif
+		/*
+		 * Strictly speaking, only the NMI path requires noinstr.
+		 */
+		instrumentation_begin();
+		/*
+		 * KVM/VMX will dispatch from IRQ-disabled but for a context
+		 * that will have IRQs-enabled. This confuses the entry code
+		 * and it will not have reprogrammed the timer (or do
+		 * preemption). Minimal fixup for now.
+		 */
+		hrtimer_rearm_deferred();
+		instrumentation_end();
+
+		return;
+	}
+
+	WARN_ON_ONCE(event_type != EVENT_TYPE_NMI);
+
+#ifdef CONFIG_X86_64
+	if (cpu_feature_enabled(X86_FEATURE_FRED))
+		return fred_entry_from_kvm(event_type, vector);
+#endif
+
+	/*
+	 * Notably, we must use IDT dispatch for NMI when running in IDT mode.
+	 * The FRED NMI context is significantly different and will not work
+	 * right (speficially FRED fixed the NMI recursion issue).
+	 */
+	idt_entry_from_kvm(vector);
+}
+EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
+#endif
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index 6ba2b3adcef0..16f0a5b253e2 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -75,3 +75,49 @@ THUNK warn_thunk_thunk, __warn_thunk
 #if defined(CONFIG_STACKPROTECTOR) && defined(CONFIG_SMP)
 EXPORT_SYMBOL(__ref_stack_chk_guard);
 #endif
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+.macro IDT_DO_EVENT_IRQOFF call_insn call_target
+	/*
+	 * Unconditionally create a stack frame, getting the correct RSP on the
+	 * stack (for x86-64) would take two instructions anyways, and RBP can
+	 * be used to restore RSP to make objtool happy (see below).
+	 */
+	push %_ASM_BP
+	mov %_ASM_SP, %_ASM_BP
+
+#ifdef CONFIG_X86_64
+	/*
+	 * Align RSP to a 16-byte boundary (to emulate CPU behavior) before
+	 * creating the synthetic interrupt stack frame for the IRQ/NMI.
+	 */
+	and  $-16, %rsp
+	push $__KERNEL_DS
+	push %rbp
+#endif
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
+.pushsection .text, "ax"
+SYM_FUNC_START(idt_do_interrupt_irqoff)
+	IDT_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
+SYM_FUNC_END(idt_do_interrupt_irqoff)
+.popsection
+
+.pushsection .noinstr.text, "ax"
+SYM_FUNC_START(idt_do_nmi_irqoff)
+	IDT_DO_EVENT_IRQOFF call asm_exc_nmi
+SYM_FUNC_END(idt_do_nmi_irqoff)
+.popsection
+#endif
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
diff --git a/arch/x86/include/asm/desc_defs.h b/arch/x86/include/asm/desc_defs.h
index 7e6b9314758a..2f2ce8aadf07 100644
--- a/arch/x86/include/asm/desc_defs.h
+++ b/arch/x86/include/asm/desc_defs.h
@@ -145,7 +145,7 @@ struct gate_struct {
 typedef struct gate_struct gate_desc;
 
 #ifndef _SETUP
-static inline unsigned long gate_offset(const gate_desc *g)
+static __always_inline unsigned long gate_offset(const gate_desc *g)
 {
 #ifdef CONFIG_X86_64
 	return g->offset_low | ((unsigned long)g->offset_middle << 16) |
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
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 2bb65677c079..18a2f811c358 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -110,7 +110,6 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { ret
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
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
index 260456588756..0e8fb61f63ff 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -268,6 +268,19 @@ void __init idt_setup_early_pf(void)
 }
 #endif
 
+noinstr void idt_entry_from_kvm(unsigned int vector)
+{
+	if (vector == NMI_VECTOR)
+		return idt_do_nmi_irqoff();
+
+	/*
+	 * Only the NMI path requires noinstr.
+	 */
+	instrumentation_begin();
+	idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
+	instrumentation_end();
+}
+
 static void __init idt_map_in_cea(void)
 {
 	/*
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
index a29896a9ef14..753f0dbb9cf8 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7083,9 +7083,6 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap)
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-void vmx_do_interrupt_irqoff(unsigned long entry);
-void vmx_do_nmi_irqoff(void);
-
 static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -7127,17 +7124,9 @@ static void handle_external_interrupt_irqoff(struct kvm_vcpu *vcpu,
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
@@ -7447,10 +7436,7 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
-		fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
-	else
-		vmx_do_nmi_irqoff();
+	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
 	kvm_after_interrupt(vcpu);
 }
 

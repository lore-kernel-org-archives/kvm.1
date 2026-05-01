Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42671175A66;
	Fri,  1 May 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667851; cv=none; b=W1Sv2FrW1YS1gUnQM+A5m+IvmDHLHZ+CXKuTkw+C/edGfJIpTRaOPjRMoPs1KibblBQySTC/mqMRnlbr7ONN8wnL6XBUI8wOuqIHdgM9soIuu4Mn8Ql8AmlkHClauXdX48E4LTKV6ocwbmi7C2aLDatLILrRchyYmurt2KsZjKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667851; c=relaxed/simple;
	bh=gcKEBhG43jdDaUh7nReVBSrGxgk2XC2O5cbxfkavTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNW88EuicZQCojbs5KxJajvEs49bXgf//8MrBz7A5bCXJ3AW4tEW20IJg7l5F9QCnj4VOHVubHXFapqPokJUaygxHOoWCfCCVEm+/HAuda5AgoyMCAKAoWNgouew3g60Ww89sn02Irsv33hNuiXADfPREgUWeVjZ+6COOpkx3V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Auz2J4C6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Auz2J4C6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nNUJ8zhmXZ8YaWnvZyInsSAN9H+BPPtlINfBiLHsCH4=; b=Auz2J4C6noKB5n8kCIq1kZ9Jpg
	O2wVtD3BHd0wiSJZKNBWSdTcczeWGSBLJGiyUSCpsTaurWN/SQF/1sfokePhEG0P7Pz1Sx3A/CEG8
	FTM5Yc8mO60wTdMqqmz458PiTSnF1AaH4xTORGg3osX2lNisWzBmdY4ZkWGRqwftxpspPoqsYlr9p
	elLJiLHu0dygnenOSFdIYoGCwi6k6+LwRISVVEXuIyYtNOlz+rKUSI7s9d2n41eleTYgm2SDZK2xi
	igdbc/ITusombQXFefQea8gzw/hMRmd1c090TDLbb/IrJjN1iO0is4VJjxK6Yc0OA6qFXNEvv9DFK
	yN+4lXrw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIubt-00000009PKn-39vM;
	Fri, 01 May 2026 20:37:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 379D53008E2; Fri, 01 May 2026 22:37:17 +0200 (CEST)
Date: Fri, 1 May 2026 22:37:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@kernel.org
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>
Subject: [PATCH v2 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86
 core
Message-ID: <20260501203717.GH1026330@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423155936.843498069@infradead.org>


Move the VMX interrupt dispatch magic into the x86 core code. This
isolates KVM from the FRED/IDT decisions and reduces the amount of
EXPORT_SYMBOL_FOR_KVM().

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
---
 arch/x86/entry/Makefile             |    2 -
 arch/x86/entry/common.c             |   48 ++++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry.S              |   46 ++++++++++++++++++++++++++++++++++
 arch/x86/entry/entry_64_fred.S      |    1 
 arch/x86/include/asm/desc.h         |    4 +++
 arch/x86/include/asm/desc_defs.h    |    2 -
 arch/x86/include/asm/entry-common.h |    2 +
 arch/x86/include/asm/fred.h         |    1 
 arch/x86/kernel/idt.c               |   13 +++++++++
 arch/x86/kernel/nmi.c               |    1 
 arch/x86/kvm/vmx/vmenter.S          |   46 ----------------------------------
 arch/x86/kvm/vmx/vmx.c              |   20 ++-------------
 12 files changed, 118 insertions(+), 68 deletions(-)

--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -13,7 +13,7 @@ CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_
 CFLAGS_syscall_32.o		+= -fno-stack-protector
 CFLAGS_syscall_64.o		+= -fno-stack-protector
 
-obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
--- /dev/null
+++ b/arch/x86/entry/common.c
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/entry-common.h>
+#include <linux/kvm_types.h>
+#include <asm/fred.h>
+#include <asm/desc.h>
+
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+/*
+ * On VMX, NMIs and IRQs (as configured by KVM) are acknowledged by hardware as
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
+	IDT_DO_EVENT_IRQOFF call asm_exc_nmi_kvm_vmx
+SYM_FUNC_END(idt_do_nmi_irqoff)
+.popsection
+#endif
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -147,5 +147,4 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	RET
 
 SYM_FUNC_END(asm_fred_entry_from_kvm)
-EXPORT_SYMBOL_FOR_KVM(asm_fred_entry_from_kvm);
 #endif
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
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -97,4 +97,6 @@ static __always_inline void arch_exit_to
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+extern void x86_entry_from_kvm(unsigned int entry_type, unsigned int vector);
+
 #endif
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -110,7 +110,6 @@ static __always_inline unsigned long fre
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static inline void fred_entry_from_kvm(unsigned int type, unsigned int vector) { }
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
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
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -614,7 +614,6 @@ DEFINE_IDTENTRY_RAW(exc_nmi_kvm_vmx)
 {
 	exc_nmi(regs);
 }
-EXPORT_SYMBOL_FOR_KVM(asm_exc_nmi_kvm_vmx);
 #endif
 
 #ifdef CONFIG_NMI_CHECK_CPU
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
@@ -320,10 +288,6 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_
 
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
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7083,9 +7083,6 @@ void vmx_load_eoi_exitmap(struct kvm_vcp
 	vmcs_write64(EOI_EXIT_BITMAP3, eoi_exit_bitmap[3]);
 }
 
-void vmx_do_interrupt_irqoff(unsigned long entry);
-void vmx_do_nmi_irqoff(void);
-
 static void handle_nm_fault_irqoff(struct kvm_vcpu *vcpu)
 {
 	/*
@@ -7127,17 +7124,9 @@ static void handle_external_interrupt_ir
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
@@ -7447,10 +7436,7 @@ noinstr void vmx_handle_nmi(struct kvm_v
 		return;
 
 	kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-	if (cpu_feature_enabled(X86_FEATURE_FRED))
-		fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
-	else
-		vmx_do_nmi_irqoff();
+	x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
 	kvm_after_interrupt(vcpu);
 }
 

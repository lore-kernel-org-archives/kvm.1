Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0433F58C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776805048; cv=none; b=JtrKUFFp8xao2JDQbYfmzGKhKyInrwWlxZZVm4kC+NqtD4osQmPm/poWxwgsZNO+2dLmNlxGiylV7iOjtvPFJ25OAlGQOlTDsM+05KPdyjr5/LojO4rViLIkxYeY5hFxhvwV5rBWVHT78eYez0PNP0ZnbGJN3mnP8NBtObElHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776805048; c=relaxed/simple;
	bh=CaCgkBKkfHd3MrQon+79frF/Us7exnIjLpWAZRN9UNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oxq3s/HBbitiNn/PKoA4Gtp5x4PS5E3TUFMVRpevYrX/KAMhG7jWppWWW36KUq6tfymoW4nEYudJNjjs0UjiHaw10dE7MusESHYRxXXt89kvBJnDr5Rdi2MWIwGDV8v+cKQJWqsWs1oZ7woLeHlRb3bAl9ZrUxV3plN9knQAwrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJ52fYoj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJ52fYoj"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82d40278103so3164311b3a.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 13:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776805046; x=1777409846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ypdrNj/8V4hYYUuAtFwLfCyI67yjHqaoNK3Vo5TEA=;
        b=pJ52fYojQJFVPpUMsun7Oub/wbtfM9h7H4q2HrZxyn8HlnlhX8PK8eZtg9rwJWtNV7
         bsk3Yi5RFcdHCt9c483aVs7OtpQQau0cdp+/Y8iCVwU4cfY6/93hwtBZ8XChOnEPrLld
         O+vogsQCkFil05Xc+VFAOjuMysrc07CiDFf2nrrEdpKXPXfg344KIjZL2ZqSltEv3q28
         A7N3ripfNnK6/48evod2sdBnMf0iZH5EAON2Gg86spKupnGP8n9r/vZwS0s86BSqfxUP
         8v40qvP/wDBZ/9ofH0ebjvTzSiz5kXVNeXiKueyJlB+csJFtOENKCiJC4gfkPAdaa19P
         XMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776805046; x=1777409846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ypdrNj/8V4hYYUuAtFwLfCyI67yjHqaoNK3Vo5TEA=;
        b=pLwounhW4FlmSVMHG9OQhJXtmzXV2EJ3aDW5bp95Nqsr56nJvhVMez5brQAKeIebRd
         eoz0dz9M8td/yYE/TDEl4PiB1T+PEjq3uEwJOTK2PCOW8j+WwjDdkxgAQa4z5vFBfytu
         ru97abKZ4T6+Ulhwj62LvkkwO/6NzIC7TGv+kxYkgnUqIxgxF6OvKhKiIHX21ZlZzO1w
         bGWYpSdHXfrUhbGHwAHuso61+AmpCfIskFzOt6Qe6MI9YwgC+ACpRUsCuOrO18J4jxan
         F80vAnorZsklk/Nb0526euItDAKb+CIJQpbweAN2KpY3thzTT+2kpCMSCPxLEE3FFKgK
         x5zg==
X-Forwarded-Encrypted: i=1; AFNElJ+qhXRolDGHABH8EUL9lgYUuh563nUN+uStdTpgkFtfEqAKiZySe281BMSeaozAms0k4HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycGYvohJpk/pYUSgZxmDGMcN4eedoif8n4SOrZCHZd1gmtqoF7
	gGqa/bqYa4q+1+l6PaU8eCfraQ38EAVeK+oKb42J0s47GHW0AHViNosFpa1URHTU1p7On0CfQcI
	pN636rA==
X-Received: from pfbhc11.prod.google.com ([2002:a05:6a00:650b:b0:82f:c44b:5d15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3498:b0:82f:85c8:fc19
 with SMTP id d2e1a72fcca58-82f8c8502d9mr19483218b3a.11.1776805046030; Tue, 21
 Apr 2026 13:57:26 -0700 (PDT)
Date: Tue, 21 Apr 2026 20:57:24 +0000
In-Reply-To: <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
Message-ID: <aefktNLiS3ur10yD@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Peter Zijlstra wrote:
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

Yep!

> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> new file mode 100644
> index 000000000000..4b0171abb083
> --- /dev/null
> +++ b/arch/x86/entry/common.c
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/kvm_types.h>
> +#include <linux/hrtimer_rearm.h>

For CONFIG_X86_FRED=n, which is possible on x86-64 if CONFIG_KVM_INTEL=n, this

#include <linux/sched/task_stack.h>

is needed so that task_pt_regs() can find task_stack_page() (and including
task_stack.h in processor.h would create cyclical includes).

> +#include <asm/entry-common.h>
> +#include <asm/fred.h>
> +#include <asm/desc.h>
> +

Related to CONFIG_X86_FRED=n, I vote to wrap this API with #if IS_ENABLED(CONFIG_KVM_INTEL)
and then delete the fred_entry_from_kvm() stub so that a goof results in a build
failure.  That'd also be a good place for a comment to explain some of the usage.

> +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
> +{
> +#ifdef CONFIG_X86_64
> +	fred_entry_from_kvm(event_type, vector);
> +#else
> +	idt_entry_from_kvm(vector);
> +#endif

...

> +SYM_FUNC_START(idt_do_interrupt_irqoff)
> +	IDT_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
> +SYM_FUNC_END(idt_do_interrupt_irqoff)
> +
> +SYM_FUNC_START(idt_do_nmi_irqoff)
> +	IDT_DO_EVENT_IRQOFF call asm_exc_nmi_kvm_vmx
> +SYM_FUNC_END(idt_do_nmi_irqoff)

These need to be declared, and the KVM declarations can be deleted.

>  static void __init idt_map_in_cea(void)
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 8a481dae9cae..ff1f254a0ef4 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -31,38 +31,6 @@
>  #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
>  #endif
>  
> -.macro VMX_DO_EVENT_IRQOFF call_insn call_target
> -	/*
> -	 * Unconditionally create a stack frame, getting the correct RSP on the
> -	 * stack (for x86-64) would take two instructions anyways, and RBP can
> -	 * be used to restore RSP to make objtool happy (see below).
> -	 */
> -	push %_ASM_BP
> -	mov %_ASM_SP, %_ASM_BP
> -
> -#ifdef CONFIG_X86_64
> -	/*
> -	 * Align RSP to a 16-byte boundary (to emulate CPU behavior) before
> -	 * creating the synthetic interrupt stack frame for the IRQ/NMI.
> -	 */
> -	and  $-16, %rsp
> -	push $__KERNEL_DS
> -	push %rbp
> -#endif

For anyone else having an -ENOCOFFEE moment, this has been dead code since commit
28d11e4548b7 ("x86/fred: KVM: VMX: Always use FRED for IRQs when CONFIG_X86_FRED=y").

This as delta? (I had typed this all up before Peter posted a new verison, so
dammit I'm sending it!)


diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 4b0171abb083..b039276bede9 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -2,10 +2,20 @@
 
 #include <linux/kvm_types.h>
 #include <linux/hrtimer_rearm.h>
+#include <linux/sched/task_stack.h>
 #include <asm/entry-common.h>
 #include <asm/fred.h>
 #include <asm/desc.h>
 
+#if IS_ENABLED(CONFIG_KVM_INTEL)
+/*
+ * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
+ * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
+ * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
+ * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
+ * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
+ * the VM-Exit is held pending until it's unblocked in the host.
+ */
 noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
 {
 #ifdef CONFIG_X86_64
@@ -20,3 +30,4 @@ noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
        }
 }
 EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
+#endif
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index eca24b5e07f4..2421b1edf77e 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -98,5 +98,7 @@ static __always_inline void arch_exit_to_user_mode(void)
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
 extern void x86_entry_from_kvm(unsigned int entry_type, unsigned int vector);
+extern void idt_do_interrupt_irqoff(unsigned long entry);
+extern void idt_do_nmi_irqoff(void);
 
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
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3d239ed12744..52a3afb1b79e 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -614,7 +614,6 @@ DEFINE_IDTENTRY_RAW(exc_nmi_kvm_vmx)
 {
        exc_nmi(regs);
 }
-EXPORT_SYMBOL_FOR_KVM(asm_exc_nmi_kvm_vmx);
 #endif
 
 #ifdef CONFIG_NMI_CHECK_CPU
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6f5c124ed3b..753f0dbb9cf8 100644
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



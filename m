Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8771E376C
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777603; cv=none; b=f0xi9Tful98j6cZJ1xNzba1hIuc7SMzElIlZB7plZHB/AO6+J4oevuvKaLjJAjWpCbQ3DF3ACH18Bi5m5Lml4qcUSTO3GH9tVSoNud5nyk8lMSJsOM4N83o5pUaMHS36sBaBWsPzvXMsjySuHOsjcj9hp5zhDlZQPDwgAfOiLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777603; c=relaxed/simple;
	bh=ZT95mCKdj1r9aXCabqBK65ju45MMcPlr/DoVE3vZI8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs443hN84ZEo3euBwyHcN28xkfVkYgMNM494Xv6GVYWP/SUJ3DGcpux6Dwh715ize6t9qToTc/eUxqcLOMAR3rS4amj19iQVeRsrrjpqiVx44Z5n/XdDDPrEN0++E+PC2kF2TOq4kLl2s4SlYgk3Sux8ntps1Qu9qliw/b3i6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JBUmGQfI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBUmGQfI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0kN4BunEbeSm7du72HT3tJEgrYoeqRp3O8086ZDE5tY=; b=JBUmGQfImZFrgq2VSRBPIVa2mY
	i5fHeRg8v6WypM0x0kGBM+mhr9oUcnnJXYt/v/W/ztA5eDR1TByCy90XY6benZjY2BSjk/nMNTZun
	1OU8Hmxxd1HvL25HRfAoeVdx8rueSHpqN7dDGg2Z/OThthj0zAJRiXSTzBzOoWlN1siUPlgMWu6dm
	F1vxUI32ODXZFGqdT7YoMsGM3hxJVJalzyMRyUFM8spVu/8+UfsE6T70LukmL9ll8QE1PK+UPgAes
	JidfgYO7i4Slze94ml4raFsJftojwkfv7Ew49e6nWN3fJoTwE64HMrCuzVunDZuj/k7LR/qV9+sd5
	nQDKwh5Q==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFB19-0000000AAy5-2ExS;
	Tue, 21 Apr 2026 13:19:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EFF8E300708; Tue, 21 Apr 2026 15:19:53 +0200 (CEST)
Date: Tue, 21 Apr 2026 15:19:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Binbin Wu <binbin.wu@linux.intel.com>,
	"Verma, Vishal L" <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"Wu, Binbin" <binbin.wu@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
Message-ID: <20260421131953.GA1064669@noisy.programming.kicks-ass.net>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <20260421120531.GF3102924@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421120531.GF3102924@noisy.programming.kicks-ass.net>

On Tue, Apr 21, 2026 at 02:05:31PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 01:49:40PM +0200, Peter Zijlstra wrote:
> > On Tue, Apr 21, 2026 at 01:34:07PM +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 21, 2026 at 01:32:12PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Apr 21, 2026 at 01:18:58PM +0200, Peter Zijlstra wrote:
> > > > > On Tue, Apr 21, 2026 at 09:39:14AM +0200, Thomas Gleixner wrote:
> > > > > 
> > > > > > ---
> > > > > > Subject: entry: Enforce hrtimer rearming in the irqentry_exit path
> > > > > > From: Thomas Gleixner <tglx@kernel.org>
> > > > > > Date: Tue, 21 Apr 2026 09:00:52 +0200
> > > > > > 
> > > > > > irqentry_exit_to_kernel_mode_after_preempt() invokes
> > > > > > hrtimer_rearm_deferred() only when the interrupted context had interrupts
> > > > > > enabled. That's a correct decision because the timer interrupt can only be
> > > > > > delivered in interrupt enabled contexts. The interrupt disabled path is
> > > > > > used by exceptions and traps which never touch the hrtimer mechanics.
> > > > > > 
> > > > > > So much for the theory, but then there is VIRT which ruins everything.
> > > > > > 
> > > > > > KVM invokes regular interrupts with pt_regs which have interrupts
> > > > > > disabled. That's correct from the KVM point of view, but completely
> > > > > > violates the obviously correct expectations of the interrupt entry/exit
> > > > > > code.
> > > > > 
> > > > > Mooo :-(
> > > 
> > > Also, is this a x86/KVM 'special' or is this true for all arch/KVM that
> > > use GENERIC_ENTRY?
> > 
> > Should we not make asm_fred_entry_from_kvm()/VMX_DO_EVENT_IRQOFF fix IF
> > on the fake frame instead? We know it will enable IRQs after doing
> > handle_exit_irqoff() in vcpu_enter_guest().
> 
> Moo, you can't do that either, because it will ERETS/IRET and fuck up
> the state :/

How insane is something like this?

---
diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
index 894f7f16eb80..f3e2a8fde1ab 100644
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -98,6 +98,7 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
 	push %rdi			/* fred_ss handed in by the caller */
 	push %rbp
 	pushf
+	or $X86_EFLAGS_KVM, (%rsp)
 	push $__KERNEL_CS
 
 	/*
diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 7535131c711b..aab93f07e768 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -97,4 +97,16 @@ static __always_inline void arch_exit_to_user_mode(void)
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+static __always_inline void arch_exit_to_kernel_mode(struct pt_regs *regs)
+{
+#ifdef CONFIG_KVM_INTEL
+	/*
+	 * KVM is a reserved bit and must always be 0. Hardware will #GP on
+	 * IRET/ERETS with this bit set.
+	 */
+	regs->flags &= ~X86_EFLAGS_KVM;
+#endif
+}
+#define arch_exit_to_kernel_mode arch_exit_to_kernel_mode
+
 #endif
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 7bb7bd90355d..c31f7bc2eba2 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -311,7 +311,15 @@ void user_stack_pointer_set(struct pt_regs *regs, unsigned long val)
 
 static __always_inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
-	return !(regs->flags & X86_EFLAGS_IF);
+	/*
+	 * return context | IF | KVM
+	 * ---------------+----+----
+	 * IRQ-off        |  0 |  0
+	 * IRQ-on         |  0 |  1
+	 * IRQ-on         |  1 |  0
+	 * invalid        |  1 |  1
+	 */
+	return (regs->flags & (X86_EFLAGS_IF | X86_EFLAGS_KVM)) == 0;
 }
 
 /* Query offset/name of register from its name/offset */
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index 81d0c8bf1137..d32edefde587 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -14,6 +14,8 @@
 #define X86_EFLAGS_FIXED	_BITUL(X86_EFLAGS_FIXED_BIT)
 #define X86_EFLAGS_PF_BIT	2 /* Parity Flag */
 #define X86_EFLAGS_PF		_BITUL(X86_EFLAGS_PF_BIT)
+#define X86_EFLAGS_KVM_BIT	3 /* KVM Flag -- must be 0 */
+#define X86_EFLAGS_KVM		_BITUL(X86_EFLAGS_PF_BIT)
 #define X86_EFLAGS_AF_BIT	4 /* Auxiliary carry Flag */
 #define X86_EFLAGS_AF		_BITUL(X86_EFLAGS_AF_BIT)
 #define X86_EFLAGS_ZF_BIT	6 /* Zero Flag */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 8a481dae9cae..3d0d0fb8de79 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -50,6 +50,7 @@
 	push %rbp
 #endif
 	pushf
+	or $X86_EFLAGS_KVM, (%_ASM_SP)
 	push $__KERNEL_CS
 	\call_insn \call_target
 
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 167fba7dbf04..0acc20b63513 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -167,6 +167,10 @@ static __always_inline void arch_exit_to_user_mode(void);
 static __always_inline void arch_exit_to_user_mode(void) { }
 #endif
 
+#ifndef arch_exit_to_kernel_mode
+static __always_inline void arch_exit_to_kernel_mode(struct pt_regs *regs) { }
+#endif
+
 /**
  * arch_do_signal_or_restart -  Architecture specific signal delivery function
  * @regs:	Pointer to currents pt_regs
@@ -548,6 +552,7 @@ static __always_inline void irqentry_exit_to_kernel_mode(struct pt_regs *regs,
 	instrumentation_end();
 
 	irqentry_exit_to_kernel_mode_after_preempt(regs, state);
+	arch_exit_to_kernel_mode(regs);
 }
 
 /**

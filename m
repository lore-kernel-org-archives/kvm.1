Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00333D090A;
	Tue, 26 May 2026 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779786411; cv=none; b=ZpxGHTs3fM4+7bWkeflO2wO1Echpx6IHUFlBSa8tXgjBVvAVw5LhczIPXZg4x37H2Ohn2GmE33GUAEeTVXVeozG7qKqDlou02EvwSJdf0er1VmYhCYp34WNTHbfbOyfGVs+UijHN8xrlPYwrx4onjeBuQ/J90EG1ZOd7fNNGT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779786411; c=relaxed/simple;
	bh=Pk4Zxh/6GCSqphJXtb254nlpOPtp0kqaGEAD8QhIDyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yoqpw4YyQNamQi+M3poMG+1fri9/dk7SC1RvfF+ul8vLiKB8SLw5lQPOv3IsdqMyXmbfWfuFyK4v7IjHADxHEwMFYT8BEs1zAmunoeuPSs61D4slVIeFkJPKoQLINDVlJcZYBjS5DRFuIQyn6ddijrLpWr1AqEIxVLCsQBPXmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kWQD2xCp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kWQD2xCp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MX0LDly+iHV21u5rfDPy9bGX7A4OJVsxZo83l2WOrA8=; b=kWQD2xCpso1cr187mV8GrUcLw0
	yZv9J07kCP1ir+I8IXnCUzNbRdaC7DRRMEuPGRxH385NwF7kIBl+WnnRu8YMAgP1iY/VP2ytVk4J6
	XFy01b9RX+w5w3mRlj3nbFmcEA/C0L9DpTI1f7PdDVgDHcJoHdiClpRrqcZkZVCnnFHcqXJS4GEnh
	PmrEJzXrKmtqhpA04kJJhtNcJC9eYiucH4l6kpT0Ak+ilCRNPcDbqAYvxt7BfDev1Pzy1zmQHt0EF
	4gmShClYA737DY8CHZIj0C8zsZKjhs2oR+ztDyt/KXIpDkF9wsvkS8Hq8XD2opQy+Vq9PavFcJYQn
	aFvmNa7A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRnk9-0000000AnYX-1D59;
	Tue, 26 May 2026 09:06:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9685300673; Tue, 26 May 2026 11:06:31 +0200 (CEST)
Date: Tue, 26 May 2026 11:06:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: tglx@kernel.org, linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Rick P Edgecombe <rick.p.edgecombe@intel.com>,
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	Paolo Bonzini <bonzini@redhat.com>,
	Calvin Owens <calvin@wbinvd.org>
Subject: Re: [PATCH v3 1/2] x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into
 x86 core
Message-ID: <20260526090631.GA4149641@noisy.programming.kicks-ass.net>
References: <20260423155611.216805954@infradead.org>
 <20260423155936.843498069@infradead.org>
 <20260508091829.GO3126523@noisy.programming.kicks-ass.net>
 <20260520230621.GA706311@ax162>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520230621.GA706311@ax162>


Sorry, I missed this :/

On Wed, May 20, 2026 at 04:06:21PM -0700, Nathan Chancellor wrote:
> On Fri, May 08, 2026 at 11:18:29AM +0200, Peter Zijlstra wrote:
> > 
> > Move the VMX interrupt dispatch magic into the x86 core code. This
> > isolates KVM from the FRED/IDT decisions and reduces the amount of
> > EXPORT_SYMBOL_FOR_KVM().
> > 
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> 
> I am seeing
> 
>   vmlinux.o: warning: objtool: idt_do_interrupt_irqoff+0xe: no-cfi indirect call!
> 
> after this landed in -next.
> 
>   $ cat arch/x86/configs/repro.config
>   CONFIG_CFI=y
>   CONFIG_KVM=y
>   CONFIG_KVM_INTEL=y
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 mrproper defconfig repro.config vmlinux
>   vmlinux.o: warning: objtool: idt_do_interrupt_irqoff+0xe: no-cfi indirect call!
> 

Durr.

---
Subject: x86/kvm/vmx: Fix x86_64 CFI build

I missed that idt_do_interrupt_irqoff() gets compiled on x84_64; this is
a problem for CFI builds because it includes an unadorned indirect call.
It is however completely dead code.

Rework things to not emit this function at all.

Fixes: 0701c9e17bd9 ("x86/kvm/vmx: Move IRQ/NMI dispatch from KVM into x86 core")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: Calvin Owens <calvin@wbinvd.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 06c7c6ebd6f9..14cd43d4da6c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -55,7 +55,7 @@ noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
 	 * The FRED NMI context is significantly different and will not work
 	 * right (specifically FRED fixed the NMI recursion issue).
 	 */
-	idt_entry_from_kvm(vector);
+	idt_do_nmi_irqoff();
 }
 EXPORT_SYMBOL_FOR_KVM(x86_entry_from_kvm);
 #endif
diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index a56e043b266d..2bc217bb5475 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -109,11 +109,13 @@ EXPORT_SYMBOL(__ref_stack_chk_guard);
 	RET
 .endm
 
+#ifndef CONFIG_X86_64
 .pushsection .text, "ax"
 SYM_FUNC_START(idt_do_interrupt_irqoff)
 	IDT_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
 SYM_FUNC_END(idt_do_interrupt_irqoff)
 .popsection
+#endif
 
 .pushsection .noinstr.text, "ax"
 SYM_FUNC_START(idt_do_nmi_irqoff)
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 7bcf1decc034..90a22e24a9eb 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -268,18 +268,10 @@ void __init idt_setup_early_pf(void)
 }
 #endif
 
-#if IS_ENABLED(CONFIG_KVM_INTEL)
-noinstr void idt_entry_from_kvm(unsigned int vector)
+#if IS_ENABLED(CONFIG_KVM_INTEL) && !defined(CONFIG_X86_64)
+void idt_entry_from_kvm(unsigned int vector)
 {
-	if (vector == NMI_VECTOR)
-		return idt_do_nmi_irqoff();
-
-	/*
-	 * Only the NMI path requires noinstr.
-	 */
-	instrumentation_begin();
 	idt_do_interrupt_irqoff(gate_offset(idt_table + vector));
-	instrumentation_end();
 }
 #endif
 

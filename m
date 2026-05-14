Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17296280318
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778787035; cv=none; b=qmECpupE+zWSW7clPU/pT9/cqchiNODXbC7rMpldIwt1cQUgTd2FNlNrQ11Jfh9mzBcSNOjg0zgQ2eqNnV4MDBa70i9KQyvTVEL4qtWhXZ2TkBRYxL4S1X9oXMwZIxa8I3XXhJbAdUx15EnzhVpHq5SPHvyac2x/pVAM+gW4U84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778787035; c=relaxed/simple;
	bh=9yF09b7LcY0TiPQkIPWwtLz9rZG4Tu7Gb1w1ve4c4zs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GdAoXHAf+knbdtyfMNBjZWMDoRMXfAj5BWq3KwPTOjkxxN79PEJ03kwIOBavRjgPI9wJdRconDhEzhQ0oaG8G8+OkwJrXr67gFhahBwBIndhtbaP2OeYepYCY/2pdDN0bWiLs7BdAj00HcfBKIvFyDwnFjjGFIg7cujZ8wThiTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuRtxDGF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuRtxDGF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso5725040b3a.3
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778787033; x=1779391833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXMdzfvZxaEa+q7ZcopfqfWaP5mxvUvoozrtDr7DS8w=;
        b=BuRtxDGF2OPEzs7L5bWYnZ8UPXfq+U4oxpgC/j9Yu6iwPKgbKwY3POQ4E6tfKcI/Ll
         8/XkX+8eu8MeJxDG1wTE5WqlNLIlj72PpRI5orVXnDi8T7/F7PidkSL4KM6qgIacNo9o
         sVP/blo9ntgLaz6KuztqF4IzRbzg8smd5J6uPHHxt5Br71JciNO/TTrBM7Y/lGUlbt29
         nStNd+Lije61UoBubZN0hZKwsfOY8sCkvq8wo/t8O45RHmi0LCkHKQdPHlR31XWodx93
         KPNbnOLOkiA8SrouFvv1VW8DVdkQgOz5u1Fqje56BDJa0EA3yTlLu0S5fA/mW+17HhcM
         BZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778787033; x=1779391833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXMdzfvZxaEa+q7ZcopfqfWaP5mxvUvoozrtDr7DS8w=;
        b=rVrjqMbu0x3tpLecUzMJlCYKlWvDkiyhQe3u51PRy1f/Vv/nb5ncr88zk9ozwfRksE
         dYxqgx9fGZiiMXewY5MHJVPv1OgZyxGfkFuTZgP2hTiqbmQFtw1JPkAkddnww/rcesng
         XUFrh2r6F69tZCkr9v9DjGRGTM4vcsDppYsOvSH+fDfndFw+O1ew9wtjRDbF+0yLzhY9
         lx0wCz8dth1EcDLOLW2J3YXBjdhVjCMQoeDPU3bX8DsubtXmPp+LUuHA+k8c5+ez7/ol
         HVBIKY4fpY6IlVAnn86HIgYZ2O1rK3c4a3iO/PsKjKSOaFMmmwdhRuAk5s45LkBqJIoC
         EqKw==
X-Forwarded-Encrypted: i=1; AFNElJ/UKayJmd4Mij4pbNxTnRrh4TNZzC6O9/ddnObn+NfORMkiO9b1uJ3SKRe1TjYOisM8ZeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsVskybt88z+h2gHDbf3iywTICzaaciHU9+Z/NXuBpCtIBZin
	NbZ0b8AV8qf03Il37OUKjUc5r2tAX3bxgsz8e9IwCwERBiYfNnAmbUfAL98Lsw2UJfxz4jp5kUf
	0hkwJoA==
X-Received: from pfob3.prod.google.com ([2002:aa7:8703:0:b0:836:903d:9aa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ac01:b0:837:acd7:a78
 with SMTP id d2e1a72fcca58-83f33b2b844mr1003011b3a.16.1778787033159; Thu, 14
 May 2026 12:30:33 -0700 (PDT)
Date: Thu, 14 May 2026 12:30:32 -0700
In-Reply-To: <20260513174948.726812-2-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513174948.726812-1-pbonzini@redhat.com> <20260513174948.726812-2-pbonzini@redhat.com>
Message-ID: <agYi2Lc7UbGiw_zL@google.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	chang.seok.bae@intel.com, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, May 13, 2026, Paolo Bonzini wrote:
> From: "Chang S. Bae" <chang.seok.bae@intel.com>
> 
> Convert the repeated register save/restore sequences into macros to
> simplify the VM entry code. 

This is not simpler.  Maybe it ends up being less verbose, but I don't see how
anyone can claim this is simpler.  E.g. for people like me that aren't already
familiar with the .ifc directive, the R32_NUM macro is inscrutable.  I can at
least suss out what e.g. LOAD_REGS and friends are doing, but claiming the code
is "simpler" is rather ridiculous.

> This can also make it easier to extend for additional registers.

For me, this needs to be the focal point of the changelog, and it needs to be
written with --verbose, because the impact of APX on the VM-Entry/VM-Exit code
isn't so obvious that a one-line "this makes future life easier" sufficiently
justifies the macro magic.  And that's coming from someone that generally loves
macro magic :-)
 
> diff --git a/arch/x86/include/asm/kvm_vcpu_regs.h b/arch/x86/include/asm/kvm_vcpu_regs.h
> index 1af2cb59233b..7c12a1fd1ffc 100644
> --- a/arch/x86/include/asm/kvm_vcpu_regs.h
> +++ b/arch/x86/include/asm/kvm_vcpu_regs.h
> @@ -22,4 +22,126 @@
>  #define __VCPU_REGS_R15 15
>  #endif
>  
> +#ifdef __ASSEMBLER__
> +
> +#define REG_NUM_INVALID		100
> +
> +	.macro R32_NUM opd r32
> +	\opd = REG_NUM_INVALID
> +	.ifc \r32,%eax
> +	\opd = __VCPU_REGS_EAX
> +	.endif
> +	.ifc \r32,%ecx
> +	\opd = __VCPU_REGS_ECX
> +	.endif
> +	.ifc \r32,%edx
> +	\opd = __VCPU_REGS_EDX
> +	.endif
> +	.ifc \r32,%ebx
> +	\opd = __VCPU_REGS_EBX
> +	.endif
> +	.ifc \r32,%esp
> +	\opd = __VCPU_REGS_ESP
> +	.endif
> +	.ifc \r32,%ebp
> +	\opd = __VCPU_REGS_EBP
> +	.endif
> +	.ifc \r32,%esi
> +	\opd = __VCPU_REGS_ESI
> +	.endif
> +	.ifc \r32,%edi
> +	\opd = __VCPU_REGS_EDI
> +	.endif
> +#ifdef CONFIG_X86_64
> +	.ifc \r32,%r8d
> +	\opd = 8
> +	.endif
> +	.ifc \r32,%r9d
> +	\opd = 9
> +	.endif
> +	.ifc \r32,%r10d
> +	\opd = 10
> +	.endif
> +	.ifc \r32,%r11d
> +	\opd = 11
> +	.endif
> +	.ifc \r32,%r12d
> +	\opd = 12
> +	.endif
> +	.ifc \r32,%r13d
> +	\opd = 13
> +	.endif
> +	.ifc \r32,%r14d
> +	\opd = 14
> +	.endif
> +	.ifc \r32,%r15d
> +	\opd = 15
> +	.endif
> +#endif
> +	.endm
> +
> +	.macro R64_NUM opd r64
> +	\opd = REG_NUM_INVALID
> +#ifdef CONFIG_X86_64
> +	.ifc \r64,%rax
> +	\opd = __VCPU_REGS_RAX
> +	.endif
> +	.ifc \r64,%rcx
> +	\opd = __VCPU_REGS_RCX
> +	.endif
> +	.ifc \r64,%rdx
> +	\opd = __VCPU_REGS_RDX
> +	.endif
> +	.ifc \r64,%rbx
> +	\opd = __VCPU_REGS_RBX
> +	.endif
> +	.ifc \r64,%rsp
> +	\opd = __VCPU_REGS_RSP
> +	.endif
> +	.ifc \r64,%rbp
> +	\opd = __VCPU_REGS_RBP
> +	.endif
> +	.ifc \r64,%rsi
> +	\opd = __VCPU_REGS_RSI
> +	.endif
> +	.ifc \r64,%rdi
> +	\opd = __VCPU_REGS_RDI
> +	.endif
> +	.ifc \r64,%r8
> +	\opd = 8
> +	.endif
> +	.ifc \r64,%r9
> +	\opd = 9
> +	.endif
> +	.ifc \r64,%r10
> +	\opd = 10
> +	.endif
> +	.ifc \r64,%r11
> +	\opd = 11
> +	.endif
> +	.ifc \r64,%r12
> +	\opd = 12
> +	.endif
> +	.ifc \r64,%r13
> +	\opd = 13
> +	.endif
> +	.ifc \r64,%r14
> +	\opd = 14
> +	.endif
> +	.ifc \r64,%r15
> +	\opd = 15
> +	.endif
> +#endif
> +	.endm
> +
> +.macro REG_NUM reg_num reg
> +#ifdef CONFIG_X86_64
> +	R64_NUM \reg_num \reg
> +#else
> +	R32_NUM \reg_num \reg
> +#endif
> +.endm
> +
> +#endif
> +
>  #endif /* _ASM_X86_KVM_VCPU_REGS_H */
> diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
> index f523d9e49839..6a91e1383e8f 100644
> --- a/arch/x86/kvm/svm/vmenter.S
> +++ b/arch/x86/kvm/svm/vmenter.S
> @@ -4,13 +4,10 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/bitsperlong.h>
>  #include <asm/frame.h>
> -#include <asm/kvm_vcpu_regs.h>
>  #include <asm/nospec-branch.h>
>  #include "kvm-asm-offsets.h"
>  #include "vmenter.h"
>  
> -#define WORD_SIZE (BITS_PER_LONG / 8)
> -
>  /* Intentionally omit RAX as it's context switched by hardware */
>  #define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
>  #define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
> diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
> index ba3f71449c62..44574806cb02 100644
> --- a/arch/x86/kvm/vmenter.h
> +++ b/arch/x86/kvm/vmenter.h
> @@ -2,6 +2,8 @@
>  #ifndef __KVM_X86_VMENTER_H
>  #define __KVM_X86_VMENTER_H
>  
> +#include <asm/kvm_vcpu_regs.h>
> +
>  #define KVM_ENTER_VMRESUME			BIT(0)
>  #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
>  #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
> @@ -76,5 +78,46 @@
>  	wrmsr
>  .endm
>  
> +#define WORD_SIZE (BITS_PER_LONG / 8)
> +
> +.macro LOAD_REGS src:req, regs_ofs:req, regs:vararg
> +.irp reg, \regs
> +	REG_NUM reg_num \reg
> +	.if reg_num <> REG_NUM_INVALID
> +	mov (\regs_ofs + reg_num * WORD_SIZE)(\src), \reg
> +	.else
> +	.err invalid register \reg
> +	.endif
> +.endr
> +.endm
> +
> +.macro STORE_REGS dst:req, regs_ofs:req, regs:vararg
> +.irp reg, \regs
> +	REG_NUM reg_num \reg
> +	.if reg_num <> REG_NUM_INVALID
> +	mov \reg, (\regs_ofs + reg_num * WORD_SIZE)(\dst)
> +	.else
> +	.err invalid register \reg
> +	.endif
> +.endr
> +.endm
> +
> +.macro POP_REGS dst:req, regs_ofs:req, regs:vararg
> +.irp reg, \regs
> +	REG_NUM reg_num \reg
> +	.if reg_num <> REG_NUM_INVALID
> +	pop (\regs_ofs + reg_num * WORD_SIZE)(\dst)
> +	.else
> +	.err invalid register \reg
> +	.endif
> +.endr
> +.endm
> +
> +.macro CLEAR_REGS regs:vararg
> +.irp reg, \regs
> +	xorl \reg, \reg
> +.endr
> +.endm
> +
>  #endif /* __ASSEMBLER__ */
>  #endif /* __KVM_X86_VMENTER_H */
> diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> index 7e4dc17fc0b8..4b7aaa7430fb 100644
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -2,35 +2,12 @@
>  #include <linux/linkage.h>
>  #include <asm/asm.h>
>  #include <asm/bitsperlong.h>
> -#include <asm/kvm_vcpu_regs.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/percpu.h>
>  #include <asm/segment.h>
>  #include "kvm-asm-offsets.h"
>  #include "vmenter.h"
>  
> -#define WORD_SIZE (BITS_PER_LONG / 8)
> -
> -#define VCPU_RAX	(VMX_vcpu_arch_regs + __VCPU_REGS_RAX * WORD_SIZE)
> -#define VCPU_RCX	(VMX_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
> -#define VCPU_RDX	(VMX_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
> -#define VCPU_RBX	(VMX_vcpu_arch_regs + __VCPU_REGS_RBX * WORD_SIZE)
> -/* Intentionally omit RSP as it's context switched by hardware */
> -#define VCPU_RBP	(VMX_vcpu_arch_regs + __VCPU_REGS_RBP * WORD_SIZE)
> -#define VCPU_RSI	(VMX_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
> -#define VCPU_RDI	(VMX_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
> -
> -#ifdef CONFIG_X86_64
> -#define VCPU_R8		(VMX_vcpu_arch_regs + __VCPU_REGS_R8  * WORD_SIZE)
> -#define VCPU_R9		(VMX_vcpu_arch_regs + __VCPU_REGS_R9  * WORD_SIZE)
> -#define VCPU_R10	(VMX_vcpu_arch_regs + __VCPU_REGS_R10 * WORD_SIZE)
> -#define VCPU_R11	(VMX_vcpu_arch_regs + __VCPU_REGS_R11 * WORD_SIZE)
> -#define VCPU_R12	(VMX_vcpu_arch_regs + __VCPU_REGS_R12 * WORD_SIZE)
> -#define VCPU_R13	(VMX_vcpu_arch_regs + __VCPU_REGS_R13 * WORD_SIZE)
> -#define VCPU_R14	(VMX_vcpu_arch_regs + __VCPU_REGS_R14 * WORD_SIZE)
> -#define VCPU_R15	(VMX_vcpu_arch_regs + __VCPU_REGS_R15 * WORD_SIZE)
> -#endif
> -
>  .macro VMX_DO_EVENT_IRQOFF call_insn call_target
>  	/*
>  	 * Unconditionally create a stack frame, getting the correct RSP on the
> @@ -114,25 +91,18 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	 * an LFENCE to stop speculation from skipping the wrmsr.
>  	 */
>  
> -	/* Load guest registers.  Don't clobber flags. */
> -	mov VCPU_RAX(%_ASM_DI), %_ASM_AX
> -	mov VCPU_RCX(%_ASM_DI), %_ASM_CX
> -	mov VCPU_RDX(%_ASM_DI), %_ASM_DX
> -	mov VCPU_RBX(%_ASM_DI), %_ASM_BX
> -	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
> -	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
> +	/*
> +	 * Load guest registers.  Don't clobber flags. Intentionally omit
> +	 * %_ASM_SP as it's context switched by hardware
> +	 */
> +	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		  %_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
>  #ifdef CONFIG_X86_64
> -	mov VCPU_R8 (%_ASM_DI),  %r8
> -	mov VCPU_R9 (%_ASM_DI),  %r9
> -	mov VCPU_R10(%_ASM_DI), %r10
> -	mov VCPU_R11(%_ASM_DI), %r11
> -	mov VCPU_R12(%_ASM_DI), %r12
> -	mov VCPU_R13(%_ASM_DI), %r13
> -	mov VCPU_R14(%_ASM_DI), %r14
> -	mov VCPU_R15(%_ASM_DI), %r15
> +	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
>  #endif
>  	/* Load guest RDI.  This kills the @vmx pointer! */
> -	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
> +	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI
>  
>  	/*
>  	 * Note, ALTERNATIVE_2 works in reverse order.  If CLEAR_CPU_BUF_VM is
> @@ -187,23 +157,16 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
>  	/* Reload @vmx to RDI. */
>  	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_DI
>  
> -	/* Save all guest registers, including RDI from the stack */
> -	mov %_ASM_AX, VCPU_RAX(%_ASM_DI)
> -	mov %_ASM_CX, VCPU_RCX(%_ASM_DI)
> -	mov %_ASM_DX, VCPU_RDX(%_ASM_DI)
> -	mov %_ASM_BX, VCPU_RBX(%_ASM_DI)
> -	mov %_ASM_BP, VCPU_RBP(%_ASM_DI)
> -	mov %_ASM_SI, VCPU_RSI(%_ASM_DI)
> -	pop           VCPU_RDI(%_ASM_DI)
> +	/*
> +	 * Save all guest registers, including RDI from the stack. Intentionally
> +	 * omit %_ASM_SP as it's context switched by hardware
> +	 */
> +	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		   %_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
> +	POP_REGS   %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI
>  #ifdef CONFIG_X86_64
> -	mov %r8,  VCPU_R8 (%_ASM_DI)
> -	mov %r9,  VCPU_R9 (%_ASM_DI)
> -	mov %r10, VCPU_R10(%_ASM_DI)
> -	mov %r11, VCPU_R11(%_ASM_DI)
> -	mov %r12, VCPU_R12(%_ASM_DI)
> -	mov %r13, VCPU_R13(%_ASM_DI)
> -	mov %r14, VCPU_R14(%_ASM_DI)
> -	mov %r15, VCPU_R15(%_ASM_DI)
> +	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
> +		   %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
>  #endif
>  
>  	/* Clear return value to indicate VM-Exit (as opposed to VM-Fail). */
> @@ -220,21 +183,9 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
>  	 * VM-Exit and RBX is explicitly loaded with 0 or 1 to hold the return
>  	 * value.
>  	 */
> -	xor %eax, %eax
> -	xor %ecx, %ecx
> -	xor %edx, %edx
> -	xor %ebp, %ebp
> -	xor %esi, %esi
> -	xor %edi, %edi
> +	CLEAR_REGS %eax, %ecx, %edx, %ebp, %esi, %edi
>  #ifdef CONFIG_X86_64
> -	xor %r8d,  %r8d
> -	xor %r9d,  %r9d
> -	xor %r10d, %r10d
> -	xor %r11d, %r11d
> -	xor %r12d, %r12d
> -	xor %r13d, %r13d
> -	xor %r14d, %r14d
> -	xor %r15d, %r15d
> +	CLEAR_REGS %r8d, %r9d, %r10d, %r11d, %r12d, %r13d, %r14d, %r15d
>  #endif
>  
>  	/*
> -- 
> 2.52.0
> 
> 

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576843DA7EE
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866064; cv=none; b=W0oChLkc9pbfwm5vopaNFg6BZ99lzHR78Fgkvo6ZYJ+/qqgWU+HD6jPGt2cl+WyAoKwYAGU4o0Zjiptm6eY5y1cDkZpKCQqb2MzEcXdsTKVUrc2GMir2o4nMQlSfvG1N77XVBePMvjyd8QwWGqbcpsJBOc9yXCR23b24cD0n4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866064; c=relaxed/simple;
	bh=1aCqDFaaLqU7KY1d5xbzXVr/5IMz34bVsLUq6r9Xzkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsxS8DcTi4YH4cjnOIgU947GFUFyXlTS5a5okMATEp+dh0h2YAGBmLC5i8ktjqglrgNuWceuMBSfsqLR7pBthm9IpIqxTHvgB2ZzS3Uza53PPhklnSy0YfFjii/5car6Osmwj0FA3UxmAcAHNsuCnNA+BgF4ugRkFAIiqKXg/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djDi45se; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djDi45se"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778866061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X10BkSSFpxquyQ9sZDtYJJU3NakNbq92pVVA3v8aN0=;
	b=djDi45se/VTp28Gsyp2Ko0DIR44R8+9KUiFImmlLCux27q8U1tMMRKpIe3tt1VWlu92JNL
	pldyapQymVPSdp6skC0d+4d/yLRNtsU7KaPU/vUYIyf7ioKHYjjX/j9yUKwiW2+JlmSdPA
	hun/F86XgOu4eT5ID7Nl+8T4eg091ng=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-ia5LfJ2YP9yZKJ_gaUyQcw-1; Fri,
 15 May 2026 13:27:37 -0400
X-MC-Unique: ia5LfJ2YP9yZKJ_gaUyQcw-1
X-Mimecast-MFC-AGG-ID: ia5LfJ2YP9yZKJ_gaUyQcw_1778866056
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 976F918005B8;
	Fri, 15 May 2026 17:27:36 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F8D230001A2;
	Fri, 15 May 2026 17:27:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	chang.seok.bae@intel.com
Subject: [PATCH 1/3] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
Date: Fri, 15 May 2026 13:27:32 -0400
Message-ID: <20260515172734.745763-2-pbonzini@redhat.com>
In-Reply-To: <20260515172734.745763-1-pbonzini@redhat.com>
References: <20260515172734.745763-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: "Chang S. Bae" <chang.seok.bae@intel.com>

Convert the repeated register save/restore sequences into macros,
trading some level of implementation trickiness for conciseness (more
than one register can be saved/restored with one invocation) and a
smaller chance of cut and paste errors.

This is particularly useful in preparation for extended GPR support;
upcoming support for APX would need to add 32 lines to the VM entry/exit
paths.

No functional change intended.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com
Link: https://patch.msgid.link/20260512011502.53072-2-chang.seok.bae@intel.com/
[Keep kvm_vcpu_regs.h and put the macros in there. -Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_vcpu_regs.h | 104 +++++++++++++++++++++++++++
 arch/x86/kvm/svm/vmenter.S           |   3 -
 arch/x86/kvm/vmenter.h               |  31 ++++++++
 arch/x86/kvm/vmx/vmenter.S           |  89 ++++++-----------------
 4 files changed, 155 insertions(+), 72 deletions(-)

diff --git a/arch/x86/include/asm/kvm_vcpu_regs.h b/arch/x86/include/asm/kvm_vcpu_regs.h
index 1af2cb59233b..650fabf5871d 100644
--- a/arch/x86/include/asm/kvm_vcpu_regs.h
+++ b/arch/x86/include/asm/kvm_vcpu_regs.h
@@ -22,4 +22,108 @@
 #define __VCPU_REGS_R15 15
 #endif
 
+#ifdef __ASSEMBLER__
+
+#define REG_NUM_INVALID		100
+
+	# convert the 32-bit register operand \r32 into a register number;
+	# store it in the value whose name is in \opd.
+	# only for !CONFIG_X86_64 (does not support r8d-r15d)
+	.macro R32_NUM opd r32
+	\opd = REG_NUM_INVALID
+	.ifc \r32,%eax
+	\opd = __VCPU_REGS_RAX
+	.endif
+	.ifc \r32,%ecx
+	\opd = __VCPU_REGS_RCX
+	.endif
+	.ifc \r32,%edx
+	\opd = __VCPU_REGS_RDX
+	.endif
+	.ifc \r32,%ebx
+	\opd = __VCPU_REGS_RBX
+	.endif
+	.ifc \r32,%esp
+	\opd = __VCPU_REGS_RSP
+	.endif
+	.ifc \r32,%ebp
+	\opd = __VCPU_REGS_RBP
+	.endif
+	.ifc \r32,%esi
+	\opd = __VCPU_REGS_RSI
+	.endif
+	.ifc \r32,%edi
+	\opd = __VCPU_REGS_RDI
+	.endif
+	.endm
+
+	# convert the 64-bit register operand \r64 into a register number;
+	# store it in the value whose name is in \opd.
+	.macro R64_NUM opd r64
+	\opd = REG_NUM_INVALID
+#ifdef CONFIG_X86_64
+	.ifc \r64,%rax
+	\opd = __VCPU_REGS_RAX
+	.endif
+	.ifc \r64,%rcx
+	\opd = __VCPU_REGS_RCX
+	.endif
+	.ifc \r64,%rdx
+	\opd = __VCPU_REGS_RDX
+	.endif
+	.ifc \r64,%rbx
+	\opd = __VCPU_REGS_RBX
+	.endif
+	.ifc \r64,%rsp
+	\opd = __VCPU_REGS_RSP
+	.endif
+	.ifc \r64,%rbp
+	\opd = __VCPU_REGS_RBP
+	.endif
+	.ifc \r64,%rsi
+	\opd = __VCPU_REGS_RSI
+	.endif
+	.ifc \r64,%rdi
+	\opd = __VCPU_REGS_RDI
+	.endif
+	.ifc \r64,%r8
+	\opd = 8
+	.endif
+	.ifc \r64,%r9
+	\opd = 9
+	.endif
+	.ifc \r64,%r10
+	\opd = 10
+	.endif
+	.ifc \r64,%r11
+	\opd = 11
+	.endif
+	.ifc \r64,%r12
+	\opd = 12
+	.endif
+	.ifc \r64,%r13
+	\opd = 13
+	.endif
+	.ifc \r64,%r14
+	\opd = 14
+	.endif
+	.ifc \r64,%r15
+	\opd = 15
+	.endif
+#endif
+	.endm
+
+.macro REG_NUM reg_num reg
+#ifdef CONFIG_X86_64
+	R64_NUM \reg_num \reg
+#else
+	R32_NUM \reg_num \reg
+#endif
+	.if \reg_num == REG_NUM_INVALID
+	.error "invalid register"
+	.endif
+.endm
+
+#endif
+
 #endif /* _ASM_X86_KVM_VCPU_REGS_H */
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index f523d9e49839..6a91e1383e8f 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -4,13 +4,10 @@
 #include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
 #include <asm/frame.h>
-#include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
 #include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-#define WORD_SIZE (BITS_PER_LONG / 8)
-
 /* Intentionally omit RAX as it's context switched by hardware */
 #define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
 #define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index ba3f71449c62..77376812c81b 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -2,6 +2,8 @@
 #ifndef __KVM_X86_VMENTER_H
 #define __KVM_X86_VMENTER_H
 
+#include <asm/kvm_vcpu_regs.h>
+
 #define KVM_ENTER_VMRESUME			BIT(0)
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
@@ -76,5 +78,34 @@
 	wrmsr
 .endm
 
+#define WORD_SIZE (BITS_PER_LONG / 8)
+
+.macro LOAD_REGS src:req, regs_ofs:req, regs:vararg
+.irp reg, \regs
+	REG_NUM reg_num \reg
+	mov (\regs_ofs + reg_num * WORD_SIZE)(\src), \reg
+.endr
+.endm
+
+.macro STORE_REGS dst:req, regs_ofs:req, regs:vararg
+.irp reg, \regs
+	REG_NUM reg_num \reg
+	mov \reg, (\regs_ofs + reg_num * WORD_SIZE)(\dst)
+.endr
+.endm
+
+.macro POP_REGS dst:req, regs_ofs:req, regs:vararg
+.irp reg, \regs
+	REG_NUM reg_num \reg
+	pop (\regs_ofs + reg_num * WORD_SIZE)(\dst)
+.endr
+.endm
+
+.macro CLEAR_REGS regs:vararg
+.irp reg, \regs
+	xorl \reg, \reg
+.endr
+.endm
+
 #endif /* __ASSEMBLER__ */
 #endif /* __KVM_X86_VMENTER_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 7e4dc17fc0b8..4b7aaa7430fb 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -2,35 +2,12 @@
 #include <linux/linkage.h>
 #include <asm/asm.h>
 #include <asm/bitsperlong.h>
-#include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
 #include <asm/percpu.h>
 #include <asm/segment.h>
 #include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-#define WORD_SIZE (BITS_PER_LONG / 8)
-
-#define VCPU_RAX	(VMX_vcpu_arch_regs + __VCPU_REGS_RAX * WORD_SIZE)
-#define VCPU_RCX	(VMX_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
-#define VCPU_RDX	(VMX_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
-#define VCPU_RBX	(VMX_vcpu_arch_regs + __VCPU_REGS_RBX * WORD_SIZE)
-/* Intentionally omit RSP as it's context switched by hardware */
-#define VCPU_RBP	(VMX_vcpu_arch_regs + __VCPU_REGS_RBP * WORD_SIZE)
-#define VCPU_RSI	(VMX_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
-#define VCPU_RDI	(VMX_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
-
-#ifdef CONFIG_X86_64
-#define VCPU_R8		(VMX_vcpu_arch_regs + __VCPU_REGS_R8  * WORD_SIZE)
-#define VCPU_R9		(VMX_vcpu_arch_regs + __VCPU_REGS_R9  * WORD_SIZE)
-#define VCPU_R10	(VMX_vcpu_arch_regs + __VCPU_REGS_R10 * WORD_SIZE)
-#define VCPU_R11	(VMX_vcpu_arch_regs + __VCPU_REGS_R11 * WORD_SIZE)
-#define VCPU_R12	(VMX_vcpu_arch_regs + __VCPU_REGS_R12 * WORD_SIZE)
-#define VCPU_R13	(VMX_vcpu_arch_regs + __VCPU_REGS_R13 * WORD_SIZE)
-#define VCPU_R14	(VMX_vcpu_arch_regs + __VCPU_REGS_R14 * WORD_SIZE)
-#define VCPU_R15	(VMX_vcpu_arch_regs + __VCPU_REGS_R15 * WORD_SIZE)
-#endif
-
 .macro VMX_DO_EVENT_IRQOFF call_insn call_target
 	/*
 	 * Unconditionally create a stack frame, getting the correct RSP on the
@@ -114,25 +91,18 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	 * an LFENCE to stop speculation from skipping the wrmsr.
 	 */
 
-	/* Load guest registers.  Don't clobber flags. */
-	mov VCPU_RAX(%_ASM_DI), %_ASM_AX
-	mov VCPU_RCX(%_ASM_DI), %_ASM_CX
-	mov VCPU_RDX(%_ASM_DI), %_ASM_DX
-	mov VCPU_RBX(%_ASM_DI), %_ASM_BX
-	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
-	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
+	/*
+	 * Load guest registers.  Don't clobber flags. Intentionally omit
+	 * %_ASM_SP as it's context switched by hardware
+	 */
+	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
+		  %_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
 #ifdef CONFIG_X86_64
-	mov VCPU_R8 (%_ASM_DI),  %r8
-	mov VCPU_R9 (%_ASM_DI),  %r9
-	mov VCPU_R10(%_ASM_DI), %r10
-	mov VCPU_R11(%_ASM_DI), %r11
-	mov VCPU_R12(%_ASM_DI), %r12
-	mov VCPU_R13(%_ASM_DI), %r13
-	mov VCPU_R14(%_ASM_DI), %r14
-	mov VCPU_R15(%_ASM_DI), %r15
+	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
+		  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
 #endif
 	/* Load guest RDI.  This kills the @vmx pointer! */
-	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
+	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI
 
 	/*
 	 * Note, ALTERNATIVE_2 works in reverse order.  If CLEAR_CPU_BUF_VM is
@@ -187,23 +157,16 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	/* Reload @vmx to RDI. */
 	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_DI
 
-	/* Save all guest registers, including RDI from the stack */
-	mov %_ASM_AX, VCPU_RAX(%_ASM_DI)
-	mov %_ASM_CX, VCPU_RCX(%_ASM_DI)
-	mov %_ASM_DX, VCPU_RDX(%_ASM_DI)
-	mov %_ASM_BX, VCPU_RBX(%_ASM_DI)
-	mov %_ASM_BP, VCPU_RBP(%_ASM_DI)
-	mov %_ASM_SI, VCPU_RSI(%_ASM_DI)
-	pop           VCPU_RDI(%_ASM_DI)
+	/*
+	 * Save all guest registers, including RDI from the stack. Intentionally
+	 * omit %_ASM_SP as it's context switched by hardware
+	 */
+	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
+		   %_ASM_AX, %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
+	POP_REGS   %_ASM_DI, VMX_vcpu_arch_regs, %_ASM_DI
 #ifdef CONFIG_X86_64
-	mov %r8,  VCPU_R8 (%_ASM_DI)
-	mov %r9,  VCPU_R9 (%_ASM_DI)
-	mov %r10, VCPU_R10(%_ASM_DI)
-	mov %r11, VCPU_R11(%_ASM_DI)
-	mov %r12, VCPU_R12(%_ASM_DI)
-	mov %r13, VCPU_R13(%_ASM_DI)
-	mov %r14, VCPU_R14(%_ASM_DI)
-	mov %r15, VCPU_R15(%_ASM_DI)
+	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
+		   %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
 #endif
 
 	/* Clear return value to indicate VM-Exit (as opposed to VM-Fail). */
@@ -220,21 +183,9 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	 * VM-Exit and RBX is explicitly loaded with 0 or 1 to hold the return
 	 * value.
 	 */
-	xor %eax, %eax
-	xor %ecx, %ecx
-	xor %edx, %edx
-	xor %ebp, %ebp
-	xor %esi, %esi
-	xor %edi, %edi
+	CLEAR_REGS %eax, %ecx, %edx, %ebp, %esi, %edi
 #ifdef CONFIG_X86_64
-	xor %r8d,  %r8d
-	xor %r9d,  %r9d
-	xor %r10d, %r10d
-	xor %r11d, %r11d
-	xor %r12d, %r12d
-	xor %r13d, %r13d
-	xor %r14d, %r14d
-	xor %r15d, %r15d
+	CLEAR_REGS %r8d, %r9d, %r10d, %r11d, %r12d, %r13d, %r14d, %r15d
 #endif
 
 	/*
-- 
2.52.0



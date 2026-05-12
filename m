Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895A25524C;
	Tue, 12 May 2026 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550023; cv=none; b=qG9N0uPFNIXIyGj8bvrl4+HA+1PFo8nrLW549UuHhY+6vilNO0gA1AexOggBinuJYmVQlw7LtTyYgM8fWo4pwmf4Xn851KXhXxD4h33n/TKbGZB6/CLf1ZUeZ8vgVcOsKfCNRJNBRzr8XFnPEtLGhMvAg8ZKKBDifa9GQLj3Ysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550023; c=relaxed/simple;
	bh=pABCKqelu9t82yLPP2W9f2r6BBfN6Gi3ZEUXzDSPH/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox1X7m5t49gKsHFfIAvALFLg9rvFZRQGTS0mQhnXXCbTXekImw55OnCrDv9l4C+T2QRapsaLh/D+NaISjjQSe/7p4jdKaAhgAf1X8b6vzROvTxmF3ciL3qG58/7zeMLhenCMLWaxFCGyqDR+fDkxrSRt7EWKjxeRlANZH9F0eZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT6VcpoH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT6VcpoH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550022; x=1810086022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pABCKqelu9t82yLPP2W9f2r6BBfN6Gi3ZEUXzDSPH/A=;
  b=YT6VcpoHTYsYUb+1Ncu+G3HpvorLOZwzJC4TpwjG+N2sppTZVnrw7ePQ
   EErpXhuICpagQnkuRC+g/zEtsx/mfRn5AU2pQCuft4wJNrCpa0YFInn5H
   /BE8OMJyFNDfUjLgFQFkA67L857ALAL0I/nd8tmgO0uNe1VP6YykLlYl3
   TOZCOYwJ8JYONDHeKtrFIh/biIatIT+vWbaKIyVwryrGYvRWiVOZ9qE1N
   zUOzekxS15OMVvIR6N6cg4f3ibRy1h5GPnmo07acb4cK5SfWKS9oelOwM
   zPJbk84PAChdS8aY309R3zqEWZ675N5SKRWOCrPbT+PW8WyKospuvtio1
   Q==;
X-CSE-ConnectionGUID: eWG8qhdVTTm6lUTENfD6XA==
X-CSE-MsgGUID: inRCNv7CSFG37R2rKItACA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322100"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322100"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:19 -0700
X-CSE-ConnectionGUID: c3VkMGh3QBWka8MSP0CU0w==
X-CSE-MsgGUID: zDDU+9PjSH2BMRnQlhd+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572740"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:16 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 01/21] KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
Date: Tue, 12 May 2026 01:14:42 +0000
Message-ID: <20260512011502.53072-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512011502.53072-1-chang.seok.bae@intel.com>
References: <20260512011502.53072-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the repeated register save/restore sequences into macros to
simplify the VM entry code. This can also make it easier to extend for
additional registers.

Reuse the previously deprecated macros in inst.h by moving them into KVM,
and remove unused ones there.

No functional change intended.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: x86@kernel.org
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/6e67df0e-e5f0-43f5-aa86-22e8b01b75d2@redhat.com
---
V3 -> V4:
* Move inst.h into KVM (Paolo)
* Generalize macros to cover all GPRs (Paolo)

Dependency: Based on Paolo's SPEC_CTRL rework, currently at
            https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
---
 arch/x86/{include/asm => kvm}/inst.h | 38 ++++--------
 arch/x86/kvm/svm/vmenter.S           |  2 -
 arch/x86/kvm/vmenter.h               | 43 ++++++++++++++
 arch/x86/kvm/vmx/vmenter.S           | 89 +++++++---------------------
 4 files changed, 74 insertions(+), 98 deletions(-)
 rename arch/x86/{include/asm => kvm}/inst.h (67%)

diff --git a/arch/x86/include/asm/inst.h b/arch/x86/kvm/inst.h
similarity index 67%
rename from arch/x86/include/asm/inst.h
rename to arch/x86/kvm/inst.h
index e48a00b3311d..3a878850ea20 100644
--- a/arch/x86/include/asm/inst.h
+++ b/arch/x86/kvm/inst.h
@@ -1,19 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Generate .byte code for some instructions not supported by old
- * binutils.
+ * Convert register names to their sizes and the indices used when
+ * encoding instructions.
  */
-#ifndef X86_ASM_INST_H
-#define X86_ASM_INST_H
+#ifndef X86_KVM_INST_H
+#define X86_KVM_INST_H
 
 #ifdef __ASSEMBLER__
 
 #define REG_NUM_INVALID		100
 
-#define REG_TYPE_R32		0
-#define REG_TYPE_R64		1
-#define REG_TYPE_INVALID	100
-
 	.macro R32_NUM opd r32
 	\opd = REG_NUM_INVALID
 	.ifc \r32,%eax
@@ -122,27 +118,15 @@
 #endif
 	.endm
 
-	.macro REG_TYPE type reg
-	R32_NUM reg_type_r32 \reg
-	R64_NUM reg_type_r64 \reg
-	.if reg_type_r64 <> REG_NUM_INVALID
-	\type = REG_TYPE_R64
-	.elseif reg_type_r32 <> REG_NUM_INVALID
-	\type = REG_TYPE_R32
-	.else
-	\type = REG_TYPE_INVALID
-	.endif
-	.endm
+.macro REG_NUM reg_num reg
+#ifdef CONFIG_X86_64
+	R64_NUM \reg_num \reg
+#else
+	R32_NUM \reg_num \reg
+#endif
+.endm
 
-	.macro PFX_REX opd1 opd2 W=0
-	.if ((\opd1 | \opd2) & 8) || \W
-	.byte 0x40 | ((\opd1 & 8) >> 3) | ((\opd2 & 8) >> 1) | (\W << 3)
-	.endif
-	.endm
 
-	.macro MODRM mod opd1 opd2
-	.byte \mod | (\opd1 & 7) | ((\opd2 & 7) << 3)
-	.endm
 #endif
 
 #endif
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index f523d9e49839..0bad9707d219 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -9,8 +9,6 @@
 #include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-#define WORD_SIZE (BITS_PER_LONG / 8)
-
 /* Intentionally omit RAX as it's context switched by hardware */
 #define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
 #define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index ba3f71449c62..a68020254a8d 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -2,6 +2,8 @@
 #ifndef __KVM_X86_VMENTER_H
 #define __KVM_X86_VMENTER_H
 
+#include "inst.h"
+
 #define KVM_ENTER_VMRESUME			BIT(0)
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
@@ -76,5 +78,46 @@
 	wrmsr
 .endm
 
+#define WORD_SIZE (BITS_PER_LONG / 8)
+
+.macro LOAD_REGS src:req, regs_ofs:req, regs:vararg
+.irp reg, \regs
+	REG_NUM reg_num \reg
+	.if reg_num <> REG_NUM_INVALID
+	mov (\regs_ofs + reg_num * WORD_SIZE)(\src), \reg
+	.else
+	.err invalid register \reg
+	.endif
+.endr
+.endm
+
+.macro STORE_REGS dst:req, regs_ofs:req, regs:vararg
+.irp reg, \regs
+	REG_NUM reg_num \reg
+	.if reg_num <> REG_NUM_INVALID
+	mov \reg, (\regs_ofs + reg_num * WORD_SIZE)(\dst)
+	.else
+	.err invalid register \reg
+	.endif
+.endr
+.endm
+
+.macro POP_REGS dst:req, regs_ofs:req, regs:vararg
+.irp reg, \regs
+	REG_NUM reg_num \reg
+	.if reg_num <> REG_NUM_INVALID
+	pop (\regs_ofs + reg_num * WORD_SIZE)(\dst)
+	.else
+	.err invalid register \reg
+	.endif
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
2.51.0


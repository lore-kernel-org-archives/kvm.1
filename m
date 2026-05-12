Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D052282F0B;
	Tue, 12 May 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550024; cv=none; b=PR7lsl6lU3163jlDOUCgimCIDi49iWXOIXO5GujM6BgK5y/tWszq6CmcJdi7sQrH1CmVo7G3/j9bx3uGV73zPGva1jT/g+2n82AACavauN3wNFGlrjtg9T0DVDMUwGgh2aYoLRpv/PLUxyCGkfonuW2nrEmjJ0lIg5JDtO4d8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550024; c=relaxed/simple;
	bh=CuNhR80TgKSoL7gKCP7RKKN445VjKhu1x3xRLOfFPeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRZ/iUUSVfXmASmvyNor927ECepqvDIATUm//7/QTRLIRz0Vxa74eTQftHeOqPBmC/dplDje0lTCRop9n7pwKR9HBKgOQ6U4eHQDBFjCuakfp9mL/4vWEOoqVQRVALzh1P+iSxDnaU8pLWSZIFSlYYOL+XRXbVIgb89z2W1cGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzxDXXgn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzxDXXgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550023; x=1810086023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CuNhR80TgKSoL7gKCP7RKKN445VjKhu1x3xRLOfFPeQ=;
  b=jzxDXXgn1LpLKlZk/w3w68ksUTOsenp/zFShNHBGMd7lt7zXAalPeA6E
   jOrkS65hWtIxeqQQCuhBkz8fgrtP/sL+ABhXgNWsa/Yz2ahHr5tnfibsB
   ILD4JpdaA8qN910nMJTNE3qlD2+BkiWLA8vT1Zapt1jyEZ6yAPnyL0U1M
   iQft56XMjvTmuUrFKB3np3/MOQITD0tcy0Bgr6+JhJnU0dbMB+qeh2Tab
   ImC5/osELjWRhBFFo10JFAtAXcAbtAouefDftcrNxchJY6ybXrIik1uEt
   HvTi3vMHBdE+MR2w+nss869HmyQ+a0yPMmWjIgVDyTZ/E8d/IOSfypzYO
   g==;
X-CSE-ConnectionGUID: aezIfkKVRPSeKLPYRmlLfQ==
X-CSE-MsgGUID: OsUEa2SCQGyi/4/a8FmoGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322104"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322104"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:19 -0700
X-CSE-ConnectionGUID: TVw0kgP4Rqqmyq0nODkF9w==
X-CSE-MsgGUID: ekAK8volRIyBbrf83s4Xiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572742"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:18 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 02/21] KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
Date: Tue, 12 May 2026 01:14:43 +0000
Message-ID: <20260512011502.53072-3-chang.seok.bae@intel.com>
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

Convert the register save/restore sequences in the SVM entry into macros,
following the VMX code. Drop the now-redundant register offset defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V3 -> V4: Cover all GPRs (Paolo)
---
 arch/x86/kvm/svm/vmenter.S | 83 +++++++++-----------------------------
 1 file changed, 19 insertions(+), 64 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 0bad9707d219..4b20aadbb741 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -9,26 +9,6 @@
 #include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-/* Intentionally omit RAX as it's context switched by hardware */
-#define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
-#define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
-#define VCPU_RBX	(SVM_vcpu_arch_regs + __VCPU_REGS_RBX * WORD_SIZE)
-/* Intentionally omit RSP as it's context switched by hardware */
-#define VCPU_RBP	(SVM_vcpu_arch_regs + __VCPU_REGS_RBP * WORD_SIZE)
-#define VCPU_RSI	(SVM_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
-#define VCPU_RDI	(SVM_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
-
-#ifdef CONFIG_X86_64
-#define VCPU_R8		(SVM_vcpu_arch_regs + __VCPU_REGS_R8  * WORD_SIZE)
-#define VCPU_R9		(SVM_vcpu_arch_regs + __VCPU_REGS_R9  * WORD_SIZE)
-#define VCPU_R10	(SVM_vcpu_arch_regs + __VCPU_REGS_R10 * WORD_SIZE)
-#define VCPU_R11	(SVM_vcpu_arch_regs + __VCPU_REGS_R11 * WORD_SIZE)
-#define VCPU_R12	(SVM_vcpu_arch_regs + __VCPU_REGS_R12 * WORD_SIZE)
-#define VCPU_R13	(SVM_vcpu_arch_regs + __VCPU_REGS_R13 * WORD_SIZE)
-#define VCPU_R14	(SVM_vcpu_arch_regs + __VCPU_REGS_R14 * WORD_SIZE)
-#define VCPU_R15	(SVM_vcpu_arch_regs + __VCPU_REGS_R15 * WORD_SIZE)
-#endif
-
 #define SVM_vmcb01_pa	(SVM_vmcb01 + KVM_VMCB_pa)
 
 .section .noinstr.text, "ax"
@@ -109,23 +89,17 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov SVM_current_vmcb(%_ASM_DI), %_ASM_AX
 	mov KVM_VMCB_pa(%_ASM_AX), %_ASM_AX
 
-	/* Load guest registers. */
-	mov VCPU_RCX(%_ASM_DI), %_ASM_CX
-	mov VCPU_RDX(%_ASM_DI), %_ASM_DX
-	mov VCPU_RBX(%_ASM_DI), %_ASM_BX
-	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
-	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
+	/*
+	 * Load guest registers. Intentionally omit %_ASM_AX and %_ASM_SP as
+	 * context switched by hardware
+	 */
+	LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, \
+		  %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI
 #ifdef CONFIG_X86_64
-	mov VCPU_R8 (%_ASM_DI),  %r8
-	mov VCPU_R9 (%_ASM_DI),  %r9
-	mov VCPU_R10(%_ASM_DI), %r10
-	mov VCPU_R11(%_ASM_DI), %r11
-	mov VCPU_R12(%_ASM_DI), %r12
-	mov VCPU_R13(%_ASM_DI), %r13
-	mov VCPU_R14(%_ASM_DI), %r14
-	mov VCPU_R15(%_ASM_DI), %r15
+	LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, \
+		  %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
 #endif
-	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
+	LOAD_REGS %_ASM_DI, SVM_vcpu_arch_regs, %_ASM_DI
 
 	/* Clobbers EFLAGS.ZF */
 	SVM_CLEAR_CPU_BUFFERS
@@ -136,22 +110,15 @@ SYM_FUNC_START(__svm_vcpu_run)
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
-	/* Save all guest registers.  */
-	mov %_ASM_CX,   VCPU_RCX(%_ASM_AX)
-	mov %_ASM_DX,   VCPU_RDX(%_ASM_AX)
-	mov %_ASM_BX,   VCPU_RBX(%_ASM_AX)
-	mov %_ASM_BP,   VCPU_RBP(%_ASM_AX)
-	mov %_ASM_SI,   VCPU_RSI(%_ASM_AX)
-	mov %_ASM_DI,   VCPU_RDI(%_ASM_AX)
+	/*
+	 * Save all guest registers. Intentionally omit %_ASM_AX and %_ASM_SP as
+	 * context switched by hardware
+	 */
+	STORE_REGS %_ASM_AX, SVM_vcpu_arch_regs, \
+		   %_ASM_CX, %_ASM_DX, %_ASM_BX, %_ASM_BP, %_ASM_SI, %_ASM_DI
 #ifdef CONFIG_X86_64
-	mov %r8,  VCPU_R8 (%_ASM_AX)
-	mov %r9,  VCPU_R9 (%_ASM_AX)
-	mov %r10, VCPU_R10(%_ASM_AX)
-	mov %r11, VCPU_R11(%_ASM_AX)
-	mov %r12, VCPU_R12(%_ASM_AX)
-	mov %r13, VCPU_R13(%_ASM_AX)
-	mov %r14, VCPU_R14(%_ASM_AX)
-	mov %r15, VCPU_R15(%_ASM_AX)
+	STORE_REGS %_ASM_AX, SVM_vcpu_arch_regs, \
+		   %r8, %r9, %r10, %r11, %r12, %r13, %r14, %r15
 #endif
 
 	/* @svm can stay in RDI from now on.  */
@@ -194,21 +161,9 @@ SYM_FUNC_START(__svm_vcpu_run)
 	 * free.  RSP and RAX are exempt as they are restored by hardware
 	 * during VM-Exit.
 	 */
-	xor %ecx, %ecx
-	xor %edx, %edx
-	xor %ebx, %ebx
-	xor %ebp, %ebp
-	xor %esi, %esi
-	xor %edi, %edi
+	CLEAR_REGS %ecx, %edx, %ebx, %ebp, %esi, %edi
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
 
 	/* "Pop" @enter_flags.  */
-- 
2.51.0


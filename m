Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCA31F992;
	Tue, 28 Apr 2026 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353979; cv=none; b=j9GO8muDBlFLECDjfaa0B9RgvUvuSF4gDnEA32ZhrMFl57Y85diy8BGObFB/Jt52K5q+YY906nOdhyf6xV4uO/om1ZFT25fL68ADZDAldB+QG6rgHRHgWAE/z6uvV6RXkXaK2CrRhmkjKjLEM+K7aig8/5QqjLWp2eXiRelEh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353979; c=relaxed/simple;
	bh=DMl2otPT2+Z328gvxdc9W+iqCQqa6JDrErlEier0KYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uwi+kP0Cw8xqofNnTAqCFg5m/XmXeiF7cvQNwEtz98KPrT+20u1kVoS4Y3MFIMsV22KPyCAySLmW52nc7rcrm5nnHNk8II3sSkBjyq5N7/QBkXY3U1wJDvVXfb4gQ83rnSGb6GDnTKINdCbVT4ExfdGwSJU8bl+FGgs5v+3tZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMJHTN/9; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMJHTN/9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353977; x=1808889977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DMl2otPT2+Z328gvxdc9W+iqCQqa6JDrErlEier0KYc=;
  b=JMJHTN/9Al+/5DdPq6MM40GKKGsJqkz5YEteB3GUZt5tJ8j/9nXqkXzt
   VLSHTuMQchfltvTWWJ/0BHIiA9FlUW7RGeoszITuR2ci0Gcg9UD6UN5mV
   DxC4w797TX7BQpSu5zTsEU/ri974J756Q3gSRBpg0UGJtq90Baqaea+oX
   1Ci28yjlqIMiCHwmYER0KI/UpB8lujILkuWf6FmfD60PVy7n3p3ovQz8w
   J9xxi2qVNRHoQQ/1GoFGB80Ee0+YZTHR+ar73ioNg+v9MEyu169hwOnkS
   qodZQJi0a61a/2mIZ3i82dcGt33J/dejZ9gIZVHYGLc5P9a6cgBXvCgCF
   Q==;
X-CSE-ConnectionGUID: O4XSJeU5QQSQSCdwrEMwjA==
X-CSE-MsgGUID: 5l4M8qi/SIaLAobHQ6DM0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131679"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131679"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:17 -0700
X-CSE-ConnectionGUID: pn0ZvnEcSbuwYkQK7yoo6g==
X-CSE-MsgGUID: G8PyAgwlQg+eAbSgwwHI4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130167"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:16 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 02/20] KVM: SVM: Macrofy 64-bit GPR swapping in __svm_vcpu_run()
Date: Tue, 28 Apr 2026 05:00:53 +0000
Message-ID: <20260428050111.39323-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the register save/restore sequences in SVM entry code to macros,
following VMX code. Drop the now-redundant register offset defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch
---
 arch/x86/kvm/svm/vmenter.S | 38 +++-----------------------------------
 arch/x86/kvm/vmenter.h     | 10 ++++++++++
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 358236557454..5f3d2400c60a 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -17,17 +17,6 @@
 #define VCPU_RSI	(SVM_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
 #define VCPU_RDI	(SVM_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
 
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
@@ -115,14 +104,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov VCPU_RBP(%_ASM_DI), %_ASM_BP
 	mov VCPU_RSI(%_ASM_DI), %_ASM_SI
 #ifdef CONFIG_X86_64
-	mov VCPU_R8 (%_ASM_DI),  %r8
-	mov VCPU_R9 (%_ASM_DI),  %r9
-	mov VCPU_R10(%_ASM_DI), %r10
-	mov VCPU_R11(%_ASM_DI), %r11
-	mov VCPU_R12(%_ASM_DI), %r12
-	mov VCPU_R13(%_ASM_DI), %r13
-	mov VCPU_R14(%_ASM_DI), %r14
-	mov VCPU_R15(%_ASM_DI), %r15
+	SVM_LOAD_REGS %_ASM_DI, 8,9,10,11,12,13,14,15
 #endif
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
@@ -143,14 +125,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov %_ASM_SI,   VCPU_RSI(%_ASM_AX)
 	mov %_ASM_DI,   VCPU_RDI(%_ASM_AX)
 #ifdef CONFIG_X86_64
-	mov %r8,  VCPU_R8 (%_ASM_AX)
-	mov %r9,  VCPU_R9 (%_ASM_AX)
-	mov %r10, VCPU_R10(%_ASM_AX)
-	mov %r11, VCPU_R11(%_ASM_AX)
-	mov %r12, VCPU_R12(%_ASM_AX)
-	mov %r13, VCPU_R13(%_ASM_AX)
-	mov %r14, VCPU_R14(%_ASM_AX)
-	mov %r15, VCPU_R15(%_ASM_AX)
+	SVM_STORE_REGS %_ASM_AX, 8,9,10,11,12,13,14,15
 #endif
 
 	/* @svm can stay in RDI from now on.  */
@@ -200,14 +175,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	xor %esi, %esi
 	xor %edi, %edi
 #ifdef CONFIG_X86_64
-	xor %r8d,  %r8d
-	xor %r9d,  %r9d
-	xor %r10d, %r10d
-	xor %r11d, %r11d
-	xor %r12d, %r12d
-	xor %r13d, %r13d
-	xor %r14d, %r14d
-	xor %r15d, %r15d
+	CLEAR_REGS 8d,9d,10d,11d,12d,13d,14d,15d
 #endif
 
 	/* "Pop" @enter_flags.  */
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 03e4067c188b..11bfc2729c68 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -96,6 +96,16 @@
 	mov %r\i, (VMX_vcpu_arch_regs + \i * WORD_SIZE)(\dst)
  .endr
 .endm
+.macro SVM_LOAD_REGS src:req, regs:vararg
+ .irp i, \regs
+	mov (SVM_vcpu_arch_regs + \i * WORD_SIZE)(\src), %r\i
+ .endr
+.endm
+.macro SVM_STORE_REGS dst:req, regs:vararg
+ .irp i, \regs
+	mov %r\i, (SVM_vcpu_arch_regs + \i * WORD_SIZE)(\dst)
+ .endr
+.endm
 #endif
 
 #endif /* __ASSEMBLER__ */
-- 
2.51.0


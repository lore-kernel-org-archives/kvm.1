Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571228F948;
	Tue, 12 May 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550024; cv=none; b=OsT88oQZ8TRPdz6+s7G/gKM//M6sBfGq8x2j3IeKs5QyufK6wx9GHHI+ucRVqNGiCnNhHLwgJmbvgH8QbbjqF+oECK8oB/CsojWwnQuLuZdY8+iv263RuGAq4YlJDw8YcPbmIWz/qr5/Q4DlVafwWyvJisQcOF9i5PPOV26DuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550024; c=relaxed/simple;
	bh=kAu4T49LD7VwdBtT0T7G0uDEz/d6M3rIZ/6tJcIopWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFJ+uCCu6rrD5SvmSmPRae9K2gexBevxlIBSizRU1OL0fkRzCSfeAy4S/kb3bJX9m+7lcx0iUGACVK8vIFDMmdkP6DIUtq1uwStayaogGE6WXo2J3S3TUedyjAZTxLAo7G8GKkSXxCroBYgb8Fws1sd1TyrXDHfI8BS6a84yQUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hm6XamUQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hm6XamUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550023; x=1810086023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kAu4T49LD7VwdBtT0T7G0uDEz/d6M3rIZ/6tJcIopWM=;
  b=hm6XamUQvS08Hm4qs3NgYpzNfqZ+pkwMuAizUNuBglcj5TVmdw8QzePo
   Ao37FPJh3cTKqSYGQDGxrb+NKOQGaeJoE/PFJJvAHC5k0S0oNy7yR+kcp
   JTycT8cq/CxX8JHbthDVNMMZO1aLDnXHf+X1nSVF51Ez2FyHY8+ZEIWZu
   xzU5iTosMAxjyTxxCsA58fpvRrwttt9UPVPw6TvlQ0nelY8cxkvmVWSMl
   UfziR1gfA4Pw8lzUkb/hbwLsTtufFYUu5NzUH1yuBjplxVEz7P4ZcU11e
   b85Q62W8KSuT0vSWwLxWMUFXtoI13kvs3JhrT+VtsPWIK/j/WUm09XceF
   Q==;
X-CSE-ConnectionGUID: BcqAJDDHRUa4KEaAxFDzWg==
X-CSE-MsgGUID: RrkjCMb7SXqw/NETJs2xWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322107"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322107"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:20 -0700
X-CSE-ConnectionGUID: k5sdgBHBRmaZ3J4X8bvmIg==
X-CSE-MsgGUID: gG6WdW6lRYCSssfZnxtFYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572748"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:19 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 03/21] KVM: SEV: Macrofy GPR swapping in __svm_sev_es_vcpu_run()
Date: Tue, 12 May 2026 01:14:44 +0000
Message-ID: <20260512011502.53072-4-chang.seok.bae@intel.com>
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

Convert the SEV-ES entry code to use macros for saving guest GPRs,
following VMX/SVM paths. Drop now-unused register offsets and
__VCPU_REGS_* defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V3 -> V4: Cover all GPRs (Paolo)
---
 arch/x86/include/asm/kvm_host.h      | 33 ++++++++++++++--------------
 arch/x86/include/asm/kvm_vcpu_regs.h | 25 ---------------------
 arch/x86/kvm/svm/vmenter.S           | 22 ++-----------------
 3 files changed, 18 insertions(+), 62 deletions(-)
 delete mode 100644 arch/x86/include/asm/kvm_vcpu_regs.h

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8a53ca619570..a70ed9a6a4fa 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -39,7 +39,6 @@
 #include <asm/asm.h>
 #include <asm/irq_remapping.h>
 #include <asm/kvm_page_track.h>
-#include <asm/kvm_vcpu_regs.h>
 #include <asm/virt.h>
 
 #include <hyperv/hvhdk.h>
@@ -173,23 +172,23 @@
 #define ASYNC_PF_PER_VCPU 64
 
 enum kvm_reg {
-	VCPU_REGS_RAX = __VCPU_REGS_RAX,
-	VCPU_REGS_RCX = __VCPU_REGS_RCX,
-	VCPU_REGS_RDX = __VCPU_REGS_RDX,
-	VCPU_REGS_RBX = __VCPU_REGS_RBX,
-	VCPU_REGS_RSP = __VCPU_REGS_RSP,
-	VCPU_REGS_RBP = __VCPU_REGS_RBP,
-	VCPU_REGS_RSI = __VCPU_REGS_RSI,
-	VCPU_REGS_RDI = __VCPU_REGS_RDI,
+	VCPU_REGS_RAX,
+	VCPU_REGS_RCX,
+	VCPU_REGS_RDX,
+	VCPU_REGS_RBX,
+	VCPU_REGS_RSP,
+	VCPU_REGS_RBP,
+	VCPU_REGS_RSI,
+	VCPU_REGS_RDI,
 #ifdef CONFIG_X86_64
-	VCPU_REGS_R8  = __VCPU_REGS_R8,
-	VCPU_REGS_R9  = __VCPU_REGS_R9,
-	VCPU_REGS_R10 = __VCPU_REGS_R10,
-	VCPU_REGS_R11 = __VCPU_REGS_R11,
-	VCPU_REGS_R12 = __VCPU_REGS_R12,
-	VCPU_REGS_R13 = __VCPU_REGS_R13,
-	VCPU_REGS_R14 = __VCPU_REGS_R14,
-	VCPU_REGS_R15 = __VCPU_REGS_R15,
+	VCPU_REGS_R8,
+	VCPU_REGS_R9,
+	VCPU_REGS_R10,
+	VCPU_REGS_R11,
+	VCPU_REGS_R12,
+	VCPU_REGS_R13,
+	VCPU_REGS_R14,
+	VCPU_REGS_R15,
 #endif
 	NR_VCPU_GENERAL_PURPOSE_REGS,
 
diff --git a/arch/x86/include/asm/kvm_vcpu_regs.h b/arch/x86/include/asm/kvm_vcpu_regs.h
deleted file mode 100644
index 1af2cb59233b..000000000000
--- a/arch/x86/include/asm/kvm_vcpu_regs.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KVM_VCPU_REGS_H
-#define _ASM_X86_KVM_VCPU_REGS_H
-
-#define __VCPU_REGS_RAX  0
-#define __VCPU_REGS_RCX  1
-#define __VCPU_REGS_RDX  2
-#define __VCPU_REGS_RBX  3
-#define __VCPU_REGS_RSP  4
-#define __VCPU_REGS_RBP  5
-#define __VCPU_REGS_RSI  6
-#define __VCPU_REGS_RDI  7
-
-#ifdef CONFIG_X86_64
-#define __VCPU_REGS_R8   8
-#define __VCPU_REGS_R9   9
-#define __VCPU_REGS_R10 10
-#define __VCPU_REGS_R11 11
-#define __VCPU_REGS_R12 12
-#define __VCPU_REGS_R13 13
-#define __VCPU_REGS_R14 14
-#define __VCPU_REGS_R15 15
-#endif
-
-#endif /* _ASM_X86_KVM_VCPU_REGS_H */
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 4b20aadbb741..99701892f8ec 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -4,7 +4,6 @@
 #include <asm/asm-offsets.h>
 #include <asm/bitsperlong.h>
 #include <asm/frame.h>
-#include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
 #include "kvm-asm-offsets.h"
 #include "vmenter.h"
@@ -212,18 +211,7 @@ SYM_FUNC_END(__svm_vcpu_run)
 
 #ifdef CONFIG_KVM_AMD_SEV
 
-
-#ifdef CONFIG_X86_64
 #define SEV_ES_GPRS_BASE 0x300
-#define SEV_ES_RBX	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBX * WORD_SIZE)
-#define SEV_ES_RBP	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBP * WORD_SIZE)
-#define SEV_ES_RSI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RSI * WORD_SIZE)
-#define SEV_ES_RDI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RDI * WORD_SIZE)
-#define SEV_ES_R12	(SEV_ES_GPRS_BASE + __VCPU_REGS_R12 * WORD_SIZE)
-#define SEV_ES_R13	(SEV_ES_GPRS_BASE + __VCPU_REGS_R13 * WORD_SIZE)
-#define SEV_ES_R14	(SEV_ES_GPRS_BASE + __VCPU_REGS_R14 * WORD_SIZE)
-#define SEV_ES_R15	(SEV_ES_GPRS_BASE + __VCPU_REGS_R15 * WORD_SIZE)
-#endif
 
 /**
  * __svm_sev_es_vcpu_run - Run a SEV-ES vCPU via a transition to SVM guest mode
@@ -238,19 +226,13 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 * Except for RAX and RSP, all GPRs are restored on #VMEXIT, but not
 	 * saved on VMRUN.
 	 */
-	mov %rbp, SEV_ES_RBP (%rdx)
-	mov %r15, SEV_ES_R15 (%rdx)
-	mov %r14, SEV_ES_R14 (%rdx)
-	mov %r13, SEV_ES_R13 (%rdx)
-	mov %r12, SEV_ES_R12 (%rdx)
-	mov %rbx, SEV_ES_RBX (%rdx)
+	STORE_REGS %rdx, SEV_ES_GPRS_BASE, %rbp, %r15, %r14, %r13, %r12, %rbx
 
 	/*
 	 * Save volatile registers that hold arguments that are needed after
 	 * #VMEXIT (RDI=@svm and RSI=@enter_flags).
 	 */
-	mov %rdi, SEV_ES_RDI (%rdx)
-	mov %rsi, SEV_ES_RSI (%rdx)
+	STORE_REGS %rdx, SEV_ES_GPRS_BASE, %rdi, %rsi
 
 	/* Clobbers RAX, RCX, and RDX (@hostsa), consumes RDI (@svm). */
 	RESTORE_GUEST_SPEC_CTRL
-- 
2.51.0


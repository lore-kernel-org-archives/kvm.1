Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FA33A00C;
	Tue, 28 Apr 2026 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353980; cv=none; b=UD57lPyXvAd/ou0STkk8zSK2r1GTKdSbkZW1pLYsLYqvIen0ynHPMjePBd5cWGYPac3ZPPkluJ86W62G/74mSFkQSNChdzL2Q7vSf5losGqrCA5wfVk/848Z8ubg7sVmqPxskn7DwkBJpOWm4lTzWNkITlLaA++u7Uz7X7gy9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353980; c=relaxed/simple;
	bh=/nstOpyGd9E2LThsDrJSOAYbQ176PpAtgE5f/RdQrUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SV2XBqhSigPA/3SFEIc43HuFtNrxv53rNt9WLZE/8GifAliFm4dQfzRJrbcdGll11HvW6xYQsSgFenTn2pw5bTZHsN/lFTcTiS+RNQ1oNDiZ2ENk/XfXNN2e8XTA8BfEaLu/oYdRa4A26KhgjkGRBzqdVVKy83aL3wpJyMFPkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IansYo2N; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IansYo2N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353978; x=1808889978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/nstOpyGd9E2LThsDrJSOAYbQ176PpAtgE5f/RdQrUI=;
  b=IansYo2NAuGd7oCPznaoCSMGerCA+n7dWIWOZj9D0b1yOSfAbizykonR
   LCGRj5FrHhEi4M51ue21los8noZ7vsSu70v6FVAdZrsegwh9QZuj8DKbH
   N5ZCV5SgAsXvZdFKCE68ma22XaUP9JB5ghTVnaXeLOl/WVAp/CgxDS/iI
   GUEfIDokLRyu6qCbQfqC8eiZdU3zKp3rzNDK5ogCSuOJmcs2HICGr+z/k
   WFbwBcRLpFnGWfnQ7EZwx2hk9rgrLrdPQMyt//AUkZ/XqPP23eAEFsbVe
   kIsZkouJtJ30sqRCR0SwbczsuVTjSc8EN11kVR6CkMM2FMhusOTyjyRgQ
   A==;
X-CSE-ConnectionGUID: aGNdc12wTMOpC6TXW5Thsw==
X-CSE-MsgGUID: CM5A0LJbT/6ZO4ZtOlV+Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131683"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131683"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:18 -0700
X-CSE-ConnectionGUID: WAvNmHwIRxOyxDwOu/z+Yg==
X-CSE-MsgGUID: +q4TTL2ZSbSNvfGfRw0wSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130170"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:17 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 03/20] KVM: SEV: Macrofy 64-bit GPR swapping in __svm_sev_es_vcpu_run()
Date: Tue, 28 Apr 2026 05:00:54 +0000
Message-ID: <20260428050111.39323-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the SEV-ES entry code to use macros for saving guest GPRs,
following VMX/SVM paths. Then, remove now-unused register offsets and
__VCPU_REGS_R8–R15 defines.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch
---
 arch/x86/include/asm/kvm_host.h      | 16 ++++++++--------
 arch/x86/include/asm/kvm_vcpu_regs.h | 11 -----------
 arch/x86/kvm/svm/vmenter.S           | 10 +---------
 arch/x86/kvm/vmenter.h               |  6 ++++++
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ef0c368676c5..2f575c8976b4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -182,14 +182,14 @@ enum kvm_reg {
 	VCPU_REGS_RSI = __VCPU_REGS_RSI,
 	VCPU_REGS_RDI = __VCPU_REGS_RDI,
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
index 1af2cb59233b..590df88cd96d 100644
--- a/arch/x86/include/asm/kvm_vcpu_regs.h
+++ b/arch/x86/include/asm/kvm_vcpu_regs.h
@@ -11,15 +11,4 @@
 #define __VCPU_REGS_RSI  6
 #define __VCPU_REGS_RDI  7
 
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
 #endif /* _ASM_X86_KVM_VCPU_REGS_H */
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 5f3d2400c60a..5a143ca518ad 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -226,15 +226,10 @@ SYM_FUNC_END(__svm_vcpu_run)
 
 
 #ifdef CONFIG_X86_64
-#define SEV_ES_GPRS_BASE 0x300
 #define SEV_ES_RBX	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBX * WORD_SIZE)
 #define SEV_ES_RBP	(SEV_ES_GPRS_BASE + __VCPU_REGS_RBP * WORD_SIZE)
 #define SEV_ES_RSI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RSI * WORD_SIZE)
 #define SEV_ES_RDI	(SEV_ES_GPRS_BASE + __VCPU_REGS_RDI * WORD_SIZE)
-#define SEV_ES_R12	(SEV_ES_GPRS_BASE + __VCPU_REGS_R12 * WORD_SIZE)
-#define SEV_ES_R13	(SEV_ES_GPRS_BASE + __VCPU_REGS_R13 * WORD_SIZE)
-#define SEV_ES_R14	(SEV_ES_GPRS_BASE + __VCPU_REGS_R14 * WORD_SIZE)
-#define SEV_ES_R15	(SEV_ES_GPRS_BASE + __VCPU_REGS_R15 * WORD_SIZE)
 #endif
 
 /**
@@ -251,10 +246,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	 * saved on VMRUN.
 	 */
 	mov %rbp, SEV_ES_RBP (%rdx)
-	mov %r15, SEV_ES_R15 (%rdx)
-	mov %r14, SEV_ES_R14 (%rdx)
-	mov %r13, SEV_ES_R13 (%rdx)
-	mov %r12, SEV_ES_R12 (%rdx)
+	SEV_STORE_REGS %rdx, 15,14,13,12
 	mov %rbx, SEV_ES_RBX (%rdx)
 
 	/*
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 11bfc2729c68..939d8a01b16d 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -79,6 +79,7 @@
 .endm
 
 #define WORD_SIZE (BITS_PER_LONG / 8)
+#define SEV_ES_GPRS_BASE 0x300
 
 #ifdef CONFIG_X86_64
 .macro CLEAR_REGS regs:vararg
@@ -106,6 +107,11 @@
 	mov %r\i, (SVM_vcpu_arch_regs + \i * WORD_SIZE)(\dst)
  .endr
 .endm
+.macro SEV_STORE_REGS dst:req, regs:vararg
+ .irp i, \regs
+	mov %r\i, (SEV_ES_GPRS_BASE + \i * WORD_SIZE)(\dst)
+ .endr
+.endm
 #endif
 
 #endif /* __ASSEMBLER__ */
-- 
2.51.0


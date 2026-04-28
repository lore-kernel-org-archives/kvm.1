Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DE31E820;
	Tue, 28 Apr 2026 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353978; cv=none; b=sNglo2MMPLDHXqujPNYUhchG2RFd4dPj3jqm6SVVhb2556A2FuHmUTacs1/6kyAzoi/b6rf5cQrin/59earxg7dp7d07RZTwzucB1Z15SoTa9ugXm0tF5e5PgufgqjbDcoNVsbfocqOEBRNx20a3ZhWkVnWiiQcT+GbJ6TJdA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353978; c=relaxed/simple;
	bh=6gXO0wNcVnzGKJv4Eg40yTFn6JPzeQ3O+8R3+89ZqLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCjTNY2cJZxxpN4rcW4jRxREbbByv+LhvKJkkkxrjmUMyKFe8hcbrxNbc0vRWvnImzQEKzZTW7h8t0rWlnUbIBBNJNdn5afQ3iFvUqdbExXCI0ugNCiNc1b3uUZJBCFdV9CWmtVIjWQnDcaLe7QZY4+YH6kc+9WRF4u2wPQM/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/1o2JNs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/1o2JNs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353977; x=1808889977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6gXO0wNcVnzGKJv4Eg40yTFn6JPzeQ3O+8R3+89ZqLs=;
  b=a/1o2JNsowJjVbJFGP6rBYlnSRimOSEqdwZnJhrm1njfnpWrZuOZkOQH
   NUt57T9A/WIISmul6GkVdRlRcC1SmIDdGDa9Ye07sUtc6JA6EVBW4+LSJ
   70dfbDYsVDqu11rzKoOm3CG56WF9I0gEiNYGgMH/4MAvOpBS9mNH7HRDN
   0K+PPtNTKzB3ZWawpQ67j8K/jvvYjDy0313o2l6cRZ6zS22B93AjwcP3J
   NDh/yuPgNhAJw3He0M9VF8CJ5u3QPzNtZ8uSNUWobIUavqkcLsMawqAqQ
   23usIWRtfo1zRFEOy6d2iVD/ZCRnSTRNLivnoZcIo94hVcUjd+9lDRSoK
   w==;
X-CSE-ConnectionGUID: cHn8aSB8RsqZYQyCRtNZRA==
X-CSE-MsgGUID: kEsW39xkQB6gqzBkvnuamA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131671"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131671"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:15 -0700
X-CSE-ConnectionGUID: +AJc/u3aSkmRHxY3zmu/7Q==
X-CSE-MsgGUID: WGUZ9EIcSxSa/PjXUl2hmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130163"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:15 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 01/20] KVM: VMX: Macrofy 64-bit GPR swapping in __vmx_vcpu_run()
Date: Tue, 28 Apr 2026 05:00:52 +0000
Message-ID: <20260428050111.39323-2-chang.seok.bae@intel.com>
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

Simplify repeated register saving/restoring sequences with macros to make
it easier to extend for additional registers.

On x86_64, R8-R15 register naming indicates each register ID, and the ID
itself can derive an offset in struct kvm_vcpu_arch. Leverage this fact
to generalize save/restore sequences in macros, removing the need for
defining offsets separately. Apply this approach to register clearing
sequences as well.

No functional change intended.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch

Dependency: Based on Paolo's SPEC_CTRL rework [1]

Test:
* Broad KVM testing should catch regressions.
* The following KVM unit test on top of this patch [2] can validate the
  changes more explicitly:

    TEST_MOV_GPRS(8, 15);
    TEST_MOV_GPRS(9, 14);
    ...

[1]: https://lore.kernel.org/20260427105848.44865-1-pbonzini@redhat.com/
[2]: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com/
---
 arch/x86/kvm/svm/vmenter.S |  3 ---
 arch/x86/kvm/vmenter.h     | 22 ++++++++++++++++++++
 arch/x86/kvm/vmx/vmenter.S | 41 +++-----------------------------------
 3 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index f523d9e49839..358236557454 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -6,11 +6,8 @@
 #include <asm/frame.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/nospec-branch.h>
-#include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-#define WORD_SIZE (BITS_PER_LONG / 8)
-
 /* Intentionally omit RAX as it's context switched by hardware */
 #define VCPU_RCX	(SVM_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
 #define VCPU_RDX	(SVM_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 93db912eef44..03e4067c188b 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -2,6 +2,8 @@
 #ifndef __KVM_X86_VMENTER_H
 #define __KVM_X86_VMENTER_H
 
+#include "kvm-asm-offsets.h"
+
 #define KVM_ENTER_VMRESUME			BIT(0)
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
@@ -76,5 +78,25 @@
 	wrmsr
 .endm
 
+#define WORD_SIZE (BITS_PER_LONG / 8)
+
+#ifdef CONFIG_X86_64
+.macro CLEAR_REGS regs:vararg
+ .irp i, \regs
+	xor %r\i, %r\i
+ .endr
+.endm
+.macro VMX_LOAD_REGS src:req, regs:vararg
+ .irp i, \regs
+	mov (VMX_vcpu_arch_regs + \i * WORD_SIZE)(\src), %r\i
+ .endr
+.endm
+.macro VMX_STORE_REGS dst:req, regs:vararg
+ .irp i, \regs
+	mov %r\i, (VMX_vcpu_arch_regs + \i * WORD_SIZE)(\dst)
+ .endr
+.endm
+#endif
+
 #endif /* __ASSEMBLER__ */
 #endif /* __KVM_X86_ENTER_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 294407dfc24f..f8420b3a2741 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -6,11 +6,8 @@
 #include <asm/nospec-branch.h>
 #include <asm/percpu.h>
 #include <asm/segment.h>
-#include "kvm-asm-offsets.h"
 #include "vmenter.h"
 
-#define WORD_SIZE (BITS_PER_LONG / 8)
-
 #define VCPU_RAX	(VMX_vcpu_arch_regs + __VCPU_REGS_RAX * WORD_SIZE)
 #define VCPU_RCX	(VMX_vcpu_arch_regs + __VCPU_REGS_RCX * WORD_SIZE)
 #define VCPU_RDX	(VMX_vcpu_arch_regs + __VCPU_REGS_RDX * WORD_SIZE)
@@ -20,17 +17,6 @@
 #define VCPU_RSI	(VMX_vcpu_arch_regs + __VCPU_REGS_RSI * WORD_SIZE)
 #define VCPU_RDI	(VMX_vcpu_arch_regs + __VCPU_REGS_RDI * WORD_SIZE)
 
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
@@ -122,14 +108,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
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
+	VMX_LOAD_REGS %_ASM_DI, 8,9,10,11,12,13,14,15
 #endif
 	/* Load guest RDI.  This kills the @vmx pointer! */
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
@@ -196,14 +175,7 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	mov %_ASM_SI, VCPU_RSI(%_ASM_DI)
 	pop           VCPU_RDI(%_ASM_DI)
 #ifdef CONFIG_X86_64
-	mov %r8,  VCPU_R8 (%_ASM_DI)
-	mov %r9,  VCPU_R9 (%_ASM_DI)
-	mov %r10, VCPU_R10(%_ASM_DI)
-	mov %r11, VCPU_R11(%_ASM_DI)
-	mov %r12, VCPU_R12(%_ASM_DI)
-	mov %r13, VCPU_R13(%_ASM_DI)
-	mov %r14, VCPU_R14(%_ASM_DI)
-	mov %r15, VCPU_R15(%_ASM_DI)
+	VMX_STORE_REGS %_ASM_DI, 8,9,10,11,12,13,14,15
 #endif
 
 	/* Clear return value to indicate VM-Exit (as opposed to VM-Fail). */
@@ -227,14 +199,7 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
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
 
 	/*
-- 
2.51.0


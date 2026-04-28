Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03303264D0;
	Tue, 28 Apr 2026 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353983; cv=none; b=iLAU3/yJj3ZB/hm2xVWwkhqeD7CmYulMim8nN+5zyp6PQwX9iFHbstipTnLbR1phJyzZd9ArnemfputTSjMoErD06YL/lioAlyBeTXutxKC2QwhTt+KvmEd0/k145Yp4UuV3KZh57hOsO5oaZAP3rJrzBJ7SPlFG1aheWRePDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353983; c=relaxed/simple;
	bh=iVnyZET3cNoWUdMMcOlAACYzkcwd2SGOmmCPfdwL0Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNWBfEK8eOLi80Jxx+Y6CgKpPIkl9GvxZWpc3HKMse9qEleuCs35e0Ko+UMre/1DEIutMulDhLc9r1MLlSgrJ2LAxDAOo9z1IZDhi3RDIQBmyjvvG4iOZV/39dEL5E1pFVTXHWff8fzVz3mZqN2eGx6DqPGGSm5vyLRWqiJNF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Abe4Sbwd; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Abe4Sbwd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353981; x=1808889981;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iVnyZET3cNoWUdMMcOlAACYzkcwd2SGOmmCPfdwL0Tg=;
  b=Abe4Sbwd0BYNMT6Halcr+M0JigSGNiLZ+4chrinWf4H2goR5VtaYFXL6
   NfrDqBm14Bdyl1hsl34DI1ssYETe4/bAra78pCQXkziCVNIKwRqWf2m2V
   4KcJitc6kBFUH3PIHKdaWZjFDUNnA+HbRKHkrzaOXdGLiIax8/fF5mvZm
   Yh6b9p9iPuIWMLnv2LniuSo8IEfNii+T36zIo7/rbbOb6U3gNdzkHZNho
   2A9Qiw0+8l9lOJcINSHY5FhfbrpaZQSCFVsnyM6bMFNIGR6wMA68y3SSf
   MlUTNsnoNu54ByeCoXrPT4PzgqsxYAAi7fbErF7u3QJ2Z+Pa1D+Vx5EPx
   Q==;
X-CSE-ConnectionGUID: a1D1aR5ETbC+me9UtOEUbw==
X-CSE-MsgGUID: 3H9st3DkR5SS/bhAcjcFZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131689"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:20 -0700
X-CSE-ConnectionGUID: b/QY2GgeTtGo0YrwCSpP/g==
X-CSE-MsgGUID: MiPCJQ1lTCiU9Ktg+nv+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130179"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:20 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 05/20] KVM: VMX: Save guest EGPRs in VCPU cache
Date: Tue, 28 Apr 2026 05:00:56 +0000
Message-ID: <20260428050111.39323-6-chang.seok.bae@intel.com>
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

Save and restore the guest EGPRs on VM exit/entry if the system supports
Advanced Performance Extensions (APX).

KVM switches XCR0 outside of the fastpath loop. As a result, there is a
window of still running with guest XCR0 where any EGPR access would
induce #UD. But fastpath handlers may access guest EGPRs, i.e. for exits
from an immediate form of WRMSR. So it is safe to handle them in
__vmx_vcpu_run().

KVM intercepts all XCR0 writes, allowing itself to track the guest XCR0
state. Pivot XCR0[APX] to conditionally handle them. This in turn makes
the VM behaves architecturally aligned. If XCR0[APX] is cleared, for
example, the EGPR state is preserved and will be restored when APX is
re-enabled.

Guard the switching path with speculation-safe control as well to avoid
any mis-speculation into EGPR accesses when APX is disabled.

Saving may be skipped on VM-Fail but leave it unconditional simply because
that's only for the slow path.

Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V2 -> V3: New patch

Note this change depends on Paolo's SPEC_CTRL rework [1]

[1] https://lore.kernel.org/20260427105848.44865-1-pbonzini@redhat.com/
---
 arch/x86/Kconfig.assembler |  5 +++++
 arch/x86/kvm/Kconfig       |  2 +-
 arch/x86/kvm/vmenter.h     | 13 +++++++++++++
 arch/x86/kvm/vmx/vmenter.S | 26 ++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.c     | 13 +++++++++++++
 5 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index b1c59fb0a4c9..3b41ec89468d 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -1,6 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2020 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
 
+config AS_APX
+	def_bool $(as-instr64,xor %r16$(comma)%r16)
+	help
+	  Supported by binutils >= 2.42 and LLVM integrated assembler >= V18
+
 config AS_WRUSS
 	def_bool $(as-instr64,wrussq %rax$(comma)(%rbx))
 	help
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index f27e3f2937f0..eb71cd7e5b37 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -100,7 +100,7 @@ config KVM_INTEL
 	tristate "KVM for Intel (and compatible) processors support"
 	depends on KVM && IA32_FEAT_CTL
 	select X86_FRED if X86_64
-	select KVM_APX if X86_64
+	select KVM_APX if X86_64 && AS_APX
 	help
 	  Provides support for KVM on processors equipped with Intel's VT
 	  extensions, a.k.a. Virtual Machine Extensions (VMX).
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index 939d8a01b16d..7a314ee29cda 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -7,6 +7,7 @@
 #define KVM_ENTER_VMRESUME			BIT(0)
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
+#define KVM_ENTER_EGPR_SWITCH			BIT(3)
 
 #ifdef __ASSEMBLER__
 .macro RESTORE_GUEST_SPEC_CTRL_BODY guest_spec_ctrl:req, label:req
@@ -114,5 +115,17 @@
 .endm
 #endif
 
+#ifdef CONFIG_KVM_APX
+.macro CLEAR_EGPRS
+	CLEAR_REGS 16d,17d,18d,19d,20d,21d,22d,23d,24d,25d,26d,27d,28d,29d,30d,31d
+.endm
+.macro VMX_LOAD_EGPRS src:req
+	VMX_LOAD_REGS \src, 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+.endm
+.macro VMX_STORE_EGPRS dst:req
+	VMX_STORE_REGS \dst, 16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+.endm
+#endif
+
 #endif /* __ASSEMBLER__ */
 #endif /* __KVM_X86_ENTER_FLAGS_H */
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index f8420b3a2741..f04efafbb7be 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -57,6 +57,7 @@
  * @flags:	KVM_ENTER_RUN_VMRESUME:	use VMRESUME instead of VMLAUNCH
  *		KVM_ENTER_RUN_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
  *		KVM_ENTER_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
+ *		KVM_ENTER_RUN_EGPRS_SWITCH:	load/store guest EGPRs
  *
  * Returns:
  *	0 on VM-Exit, 1 on VM-Fail
@@ -87,6 +88,14 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
 	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
 
+#ifdef CONFIG_KVM_APX
+	ALTERNATIVE "jmp .Lload_egprs_done", "", X86_FEATURE_APX
+	testl	$KVM_ENTER_EGPR_SWITCH, (%_ASM_SP)
+	jz	.Lload_egprs_done
+	VMX_LOAD_EGPRS %_ASM_DI
+.Lload_egprs_done:
+#endif
+
 	/*
 	 * Unlike AMD there's no V_SPEC_CTRL here, so do not leave the body
 	 * out of line.  Clobbers RAX, RCX, RDX, RSI.
@@ -229,8 +238,21 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	mov %_ASM_BX, %_ASM_AX
 
 	/* Pop our saved arguments from the stack */
-	pop %_ASM_BX
-	pop %_ASM_BX
+	pop %_ASM_BX	/* @flags */
+	pop %_ASM_DI	/* @vmx */
+
+#ifdef CONFIG_KVM_APX
+	ALTERNATIVE "jmp .Lclear_egprs_done", "", X86_FEATURE_APX
+	test	$KVM_ENTER_EGPR_SWITCH, %_ASM_BX
+	jz	.Lclear_egprs_done
+	/*
+	 * Unlike legacy GPRs, saving could be conditional here on VM-Fail,
+	 * which however isn't in fastpath. Instead, simply saving EGPRs always.
+	 */
+	VMX_STORE_EGPRS %_ASM_DI
+	CLEAR_EGPRS
+.Lclear_egprs_done:
+#endif
 
 	/* ... and then the callee-save registers */
 	pop %_ASM_BX
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 05bb9d693aff..05e5005b1524 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -984,6 +984,19 @@ unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx)
 	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
 		flags |= KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO;
 
+	/*
+	 * KVM intercepts XSETBV and thus always tracks the guest XCR0. EGPR
+	 * save/restore is gated by this flag. The resulting behavior is:
+	 *
+	 *  - When the guest enables APX, KVM restores EGPRs (initially zeroed).
+	 *  - When the guest disables APX, EGPRs are preserved in the VCPU cache
+	 *  - When APX is re-enabled, the saved state is restored, which matches
+	 *    with architectural expectations.
+	 */
+	if (IS_ENABLED(CONFIG_KVM_APX) && cpu_feature_enabled(X86_FEATURE_APX) &&
+	    vmx->vcpu.arch.xcr0 & XFEATURE_MASK_APX)
+		flags |= KVM_ENTER_EGPR_SWITCH;
+
 	return flags;
 }
 
-- 
2.51.0


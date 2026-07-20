Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6B44B662;
	Mon, 20 Jul 2026 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569569; cv=none; b=PC3Qa+lQeljmnFjhZxsJldtDbYqIZrSwg9m6z58TYDTR00u/GDmPBSigGRwKZUoNQwSIthZZFsKtQBYyguiCrqOhQVYWdhi14lUbvoVjRz3fN4keoPZwYODySJbfxnjkV0T80VJzo3SUTkF5h3MmS9FuAoQquusuZwdf+YLz34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569569; c=relaxed/simple;
	bh=NikDnVUX6VQnNXngTYOh4WTBmA9RIh6iowgiytdOB9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdcEz6NFPbEsd8ZGKfZnE/1kzz27dMHpkRZpyUsneNNTEce9SxHEPDq1Hgg0FypZwC/kVEf6DeddofXicinpsBavPsalh1pvszThHSprwxabzktTcyAgEZATUrgFXyEomLgPnz945t9Tk1vqgPMwzCJVh+gqbWk+H2lVsMf9xuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUNFe1NH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUNFe1NH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569563; x=1816105563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NikDnVUX6VQnNXngTYOh4WTBmA9RIh6iowgiytdOB9g=;
  b=ZUNFe1NHwJWTj+FvzmUHadBT6Y0biBowaFBfzNOBnPalIhT8/Zu7atm5
   TT7fp0Pwa/zZ45Uplsn4RH2IA27YDs6/LXg/DSi73nSf11U+a6/ErKBq9
   hgl2Uw8q8OaG6uB9W3yfZALT26QZJu+AyXBczEdB3iB1IrRAtXakLzb7v
   oMfcEEyOw26Meu8ferXglBVqDokFxLOitNcKk4PiP+oC1BQg6CNN9uBim
   HRqdN+dEeT5enjbCxbB2X2L7puZrwXCHH/wSylnxXyi0HPnKkZPrqGC7x
   JVTimfe96hmpQXYw8p5MU+WIFKSrFz9ZzCkt1Mh5dmqq7T9EoM+SyvO9d
   Q==;
X-CSE-ConnectionGUID: 8BF0b9ACRseYR0TvMvAhDw==
X-CSE-MsgGUID: Fq2H0G4ZTSiMOEARCKp7Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691630"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691630"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:45:58 -0700
X-CSE-ConnectionGUID: RSO9VCAJRJWLNnC3EwmXOg==
X-CSE-MsgGUID: LwChBOkvRcy+HpMA0FvxWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575338"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:45:57 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
Date: Mon, 20 Jul 2026 17:19:31 +0000
Message-ID: <20260720171949.498680-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260720171949.498680-1-chang.seok.bae@intel.com>
References: <20260720171949.498680-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save and restore the guest EGPRs on VM exit/entry if the system supports
Advanced Performance Extensions (APX).

There are two possible ways of handling EGPR accesses: reading them from
the processor lazily, or switching them in the vmentry/vmexit path and
accessing them via vcpu->arch.regs.  Prepare for the latter; it does not
pollute kvm_reg_read/write() with conditionals to treat GPRs vs. EGPRs
differently, and it allows for future usage of APX registers in the
kernel.

KVM intercepts all XCR0 writes, therefore XCR0 cannot change during the
execution of VMLAUNCH/VMRESUME. Thus, for a guest that does not set
XCR0[APX], the EGPR state does not have to be loaded/saved.

The register restore path is placed after SPEC_CTRL is restored, so as
to avoid any mis-speculation into EGPR accesses when APX is disabled.

While saving may be skipped on VM-Fail, it is not worth the added
complication for a slow path.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com
---
V4 -> V5:
 * Massage the chagnelog (Paolo [*])
 * Fix typo; use KVM_ENTER_EGPR_SWITCH consistently

[*]: Paolo's rewording appeared when it was once picked into his queue branch
---
 arch/x86/Kconfig.assembler           |  5 +++
 arch/x86/include/asm/kvm_vcpu_regs.h | 50 ++++++++++++++++++++++++++++
 arch/x86/kvm/Kconfig                 |  2 +-
 arch/x86/kvm/vmenter.h               |  1 +
 arch/x86/kvm/vmx/vmenter.S           | 31 +++++++++++++++--
 arch/x86/kvm/vmx/vmx.c               | 13 ++++++++
 6 files changed, 99 insertions(+), 3 deletions(-)

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
diff --git a/arch/x86/include/asm/kvm_vcpu_regs.h b/arch/x86/include/asm/kvm_vcpu_regs.h
index d9f1528fab2b..d6658c9909aa 100644
--- a/arch/x86/include/asm/kvm_vcpu_regs.h
+++ b/arch/x86/include/asm/kvm_vcpu_regs.h
@@ -99,6 +99,56 @@
 	.ifc \r64,%r15
 	\opd = 15
 	.endif
+#endif
+#ifdef CONFIG_KVM_APX
+	.ifc \r64,%r16
+	\opd = 16
+	.endif
+	.ifc \r64,%r17
+	\opd = 17
+	.endif
+	.ifc \r64,%r18
+	\opd = 18
+	.endif
+	.ifc \r64,%r19
+	\opd = 19
+	.endif
+	.ifc \r64,%r20
+	\opd = 20
+	.endif
+	.ifc \r64,%r21
+	\opd = 21
+	.endif
+	.ifc \r64,%r22
+	\opd = 22
+	.endif
+	.ifc \r64,%r23
+	\opd = 23
+	.endif
+	.ifc \r64,%r24
+	\opd = 24
+	.endif
+	.ifc \r64,%r25
+	\opd = 25
+	.endif
+	.ifc \r64,%r26
+	\opd = 26
+	.endif
+	.ifc \r64,%r27
+	\opd = 27
+	.endif
+	.ifc \r64,%r28
+	\opd = 28
+	.endif
+	.ifc \r64,%r29
+	\opd = 29
+	.endif
+	.ifc \r64,%r30
+	\opd = 30
+	.endif
+	.ifc \r64,%r31
+	\opd = 31
+	.endif
 #endif
 	.endm
 
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
index 77376812c81b..690c05696824 100644
--- a/arch/x86/kvm/vmenter.h
+++ b/arch/x86/kvm/vmenter.h
@@ -7,6 +7,7 @@
 #define KVM_ENTER_VMRESUME			BIT(0)
 #define KVM_ENTER_SAVE_SPEC_CTRL		BIT(1)
 #define KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO	BIT(2)
+#define KVM_ENTER_EGPR_SWITCH			BIT(3)
 
 #ifdef __ASSEMBLER__
 .macro RESTORE_GUEST_SPEC_CTRL_BODY guest_spec_ctrl:req, label:req
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 00d807505fc8..702d86ade6b1 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -16,6 +16,7 @@
  * @flags:	KVM_ENTER_VMRESUME:	use VMRESUME instead of VMLAUNCH
  *		KVM_ENTER_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
  *		KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
+ *		KVM_ENTER_EGPR_SWITCH:	load/store guest EGPRs
  *
  * Returns:
  *	0 on VM-Exit, 1 on VM-Fail
@@ -46,6 +47,16 @@ SYM_FUNC_START(__vmx_vcpu_run)
 	/* Reload @vmx, _ASM_ARG1 may be modified by vmx_update_host_rsp().  */
 	mov WORD_SIZE(%_ASM_SP), %_ASM_DI
 
+#ifdef CONFIG_KVM_APX
+	ALTERNATIVE "jmp .Lload_egprs_done", "", X86_FEATURE_APX
+	testl	$KVM_ENTER_EGPR_SWITCH, (%_ASM_SP)
+	jz	.Lload_egprs_done
+	LOAD_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
+		  %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
+		  %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
+.Lload_egprs_done:
+#endif
+
 	/*
 	 * Unlike AMD there's no V_SPEC_CTRL here, so do not leave the body
 	 * out of line.  Clobbers RAX, RCX, RDX, RSI.
@@ -193,8 +204,24 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
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
+	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
+		   %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
+		   %r24, %r25, %r26, %r27, %r28, %r29, %r30, %r31
+	CLEAR_REGS %r16d, %r17d, %r18d, %r19d, %r20d, %r21d, %r22d, %r23d, \
+		   %r24d, %r25d, %r26d, %r27d, %r28d, %r29d, %r30d, %r31d
+.Lclear_egprs_done:
+#endif
 
 	/* ... and then the callee-save registers */
 	pop %_ASM_BX
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3681d565f177..1c86919d14d4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -991,6 +991,19 @@ unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx)
 	    kvm_vcpu_can_access_host_mmio(&vmx->vcpu))
 		flags |= KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO;
 
+	/*
+	 * KVM intercepts XSETBV and thus always tracks the guest XCR0. EGPR
+	 * save/restore is gated by this flag. The resulting behavior is:
+	 *
+	 *  - When the guest enables APX, KVM restores EGPRs (initially zeroed).
+	 *  - When the guest disables APX, EGPRs are preserved in the VCPU cache.
+	 *  - When APX is re-enabled, the saved state is restored, which matches
+	 *    architectural expectations.
+	 */
+	if (IS_ENABLED(CONFIG_KVM_APX) && cpu_feature_enabled(X86_FEATURE_APX) &&
+	    vmx->vcpu.arch.xcr0 & XFEATURE_MASK_APX)
+		flags |= KVM_ENTER_EGPR_SWITCH;
+
 	return flags;
 }
 
-- 
2.53.0


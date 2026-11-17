Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940289;
	b=mWL/sW2FKDdHRene1p6kWv2UM1TsOidI2w+MfLhTwjt0S8B7UBDaKSWoXVVF9MkbGSJ+
	 s/RmCgj5G8sY+1md9LVbonuAECAZIjAY3dp+K5KOHYl7goV4tYju+Xs3+gg0on51HqG9z
	 OQ58cKyDHY/OEsC5x98CW+ibEJwbiw/lQ/SVowtAGTEyqIDrovwvolrKY4BMYfD2429zK
	 NetWDv9qabdBZJ7vldrHta5JbTdwY1isgF4FWqRUjgs3psIKk6VLMWexjrZeulnaMr6jS
	 oe3KPxG9RxRerRFYYXZOgs+1oauJFSByR20u0Awds6PlkaSyJbQkL6w8BfiZKpSWPhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940289;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Bq32T1NM4Xqk0bgOJlWR+0BNHoFzEjpWimUBLAJtcAU=;
	b=ujO9Oqc4TT++4xEeKh3HYcQ02EsogURGOTjynd+2HUxWA51jKfHbYPjk1/0Ee1twhM93
	 AMTuQNrAjJLE7DzsjLhcoI6P5oURyErnwXIFYDFVqoy3DnxILsWRTJVFz/mz2XEIyLk4q
	 LNi1MBbFdnwsks7V7PwYtKu+vAxShzbis4mQnTXg5ElmfMyO6BLUL7bW4+xlXeQL17PX7
	 hHaPRPp4WzauuJZ0XMtQpY9qK1Z+lJpromNcyX8Xwh+LBWafxAO4enRjH4mAlPWSxgI5N
	 xwuBi+SsMBz2O4XPyZt2QHHab38zcxL8AUPhwb4WE9lKDmHiv/OBEis/igwEpQbEtYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VwYfEIW7;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF3E606A337;
	Tue, 17 Nov 2026 18:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF3E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VwYfEIW7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940288; x=1826476288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tWBqMXH+5qZx0AERpFNBi5Z2JfKvMqk3wiym9qKCskI=;
  b=VwYfEIW7rFmMF8m8wQwnW/k9H6L0Dd9Ny3PW1PCwIihLAfYrExoJgsu0
   /+UHFFRFGCQ5vyB2uaPyihBSFwHhpN3pVs92cE2lhxCh5sTuS8O1ScLzt
   eiD/iHpcUMOAl+RgBLE41gXEtOKEvxBtCyHK4L88u1FL1LDdmaf9zl41W
   1rurIn1hsSn/XZLnuQu7kj1R5wi6lI8DEfTqCA1ABMC+cNb/vuy/OPzW3
   8O08nNubxYimdGQONFD1uR9FuIxxLwItJQfah61Npiw6fw/5MA4dEtsKo
   NQ9q8i28j7KoyRzOE0NqBmk9qlpnXOM1uBpNHiQF6QRfbCxe215E9S+Jg
   w==;
X-CSE-ConnectionGUID: kHCq0P8MRKmOC5JVp9grDA==
X-CSE-MsgGUID: q8AsEjAlR0CN/Vgdh1sruQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607173"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607173"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:40 -0800
X-CSE-ConnectionGUID: 3mke32H5Q3SsBq8yL10WaQ==
X-CSE-MsgGUID: Lm16kfsvT6CqEvb1f9vfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9774986"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:41 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 02/20] KVM: VMX: Save guest EGPRs in VCPU cache
Date: Tue, 17 Nov 2026 18:02:52 +0000
Message-ID: <20261117180310.921701-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save and restore the guest EGPRs on VM exit/entry if the system supports
Advanced Performance Extensions (APX).

There are two possible ways of handling EGPR accesses: reading them from
the processor lazily, or switching them in the vmentry/vmexit path and
accessing them via vcpu->arch.regs.  Prepare for the latter; it does not
pollute kvm_register_read/kvm_register_write() with conditionals to treat
GPRs vs. EGPRs differently, and it allows for future usage of APX
registers in the kernel.

KVM intercepts all XCR0 writes, therefore XCR0 cannot change during the
execution of VMLAUNCH/VMRESUME. Thus, for a guest that does not set
XCR0[APX], the EGPR state does not have to be loaded/saved.

The register saving path is placed after SPEC_CTRL is restored, so as
to avoid any mis-speculation into EGPR accesses when APX is disabled.

While saving may be skipped on VM-Fail, it is not worth the added
complication for a slow path.

Suggested-by: Sean Christopherson <seanjc@google.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com
---
 arch/x86/Kconfig.assembler           |  5 +++
 arch/x86/include/asm/kvm_vcpu_regs.h | 50 ++++++++++++++++++++++++++++
 arch/x86/kvm/Kconfig                 |  2 +-
 arch/x86/kvm/vmenter.h               |  1 +
 arch/x86/kvm/vmx/vmenter.S           | 31 +++++++++++++++--
 arch/x86/kvm/vmx/vmx.c               | 13 ++++++++
 6 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index b1c59fb0a4c9..1a86efb2a239 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -1,6 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2020 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
 
+config AS_APX
+	def_bool $(as-instr64,xor %r16$(comma)%r16)
+	help
+	  Supported by binutils >= 2.42 and LLVM integrated assembler >= 18
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
index 2bee4d4791d3..fa75fe1af25c 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -109,7 +109,7 @@ config KVM_INTEL
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
index 00d807505fc8..4c84842c3982 100644
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
+	 * Saving EGPRs could be skipped on VM-Fail, but that is a slow path, so
+	 * always save them.
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
index 68fa251dda60..dec480c46a1e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -994,6 +994,19 @@ unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx)
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


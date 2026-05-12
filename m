Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4242C21FD;
	Tue, 12 May 2026 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550026; cv=none; b=hRKkp90/Rolxej9MehcG+t6jFOIB2B8S3TDeIA9/fWF2lyNhSNhMTgKmv8XYJaDwpLH1gFzbFqBW+RTYWmXoTQhFodkY+LK62GWnvK+kzy8p4HWW7flaxB1svLFP5EIuzuHUx6puNss5LIbu17L+9R8ozowETb94ZhkX00kTPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550026; c=relaxed/simple;
	bh=tqLOlyU40BGh2J/817UFTtIxy7VEtWO968Fjv47Vt3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cy/24dadcuAPtXFINj5YscpSl+SRIVj5BXi1MLGN3jARjm375kV0uWcXbEz1l48gco6YFdYeYxio3tVHZ+KIC8wbjhjhnx8kx/UWypIXjNpcLH7Dhlpx/HUGZuKZor31k7RZyDfiC/WVaxzDWTFDFEJpQuffjKVC6lGqcXQEBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqR6Jwcf; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqR6Jwcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550025; x=1810086025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqLOlyU40BGh2J/817UFTtIxy7VEtWO968Fjv47Vt3k=;
  b=OqR6Jwcf645EiICo7Y69DD+NoV1guqSYHombiIDKoqSexEkG7PrXG4At
   enygfMPJoptl6iIqrT0BM9qYQTidUzZngpn3FA/DWoen2tzTGC1wUdsZ/
   4zat5wmrhjKXT+gitMAdz2eQh24jJaXTEfjw5m+tj2NgxcyOmbJLxC/Li
   u1biXOVknmUIFSeykN9tdUW0i68VNu+BQPALj86XFo6XLDDt09BLjc0vG
   9pWOh96FpYwQu+o1KCb0Nydct9IMD+r51E/IxuM7cHR34pHgoHd8NcT64
   9Jj0Ps8MpCXPRRW09LtREnrIJfm7SlZOU9eC4pHXxX8EPkH375rWax92z
   Q==;
X-CSE-ConnectionGUID: kvQgJ2QvSWihjSoboBLbKw==
X-CSE-MsgGUID: Ttv0/wHBS6yL42pKEZ/4bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322118"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:22 -0700
X-CSE-ConnectionGUID: aKnjo0YOQ5mskkEURvDrKA==
X-CSE-MsgGUID: 00fqAblhQlORCSQYcOdYtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572759"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:21 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 05/21] KVM: VMX: Save guest EGPRs in VCPU cache
Date: Tue, 12 May 2026 01:14:46 +0000
Message-ID: <20260512011502.53072-6-chang.seok.bae@intel.com>
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

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/adPRA4ZhnvbaXSn0@google.com
---
V3 -> V4: Rebase on macro updates (PATCH1) with adding EGPRs to R64_NUM in inst.h

Dependency: Based on Paolo's SPEC_CTRL rework, currently at
            https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=queue
---
 arch/x86/Kconfig.assembler |  5 ++++
 arch/x86/kvm/Kconfig       |  2 +-
 arch/x86/kvm/inst.h        | 50 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmenter.h     |  1 +
 arch/x86/kvm/vmx/vmenter.S | 31 +++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.c     | 13 ++++++++++
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
diff --git a/arch/x86/kvm/inst.h b/arch/x86/kvm/inst.h
index 3a878850ea20..059ea4ea56f3 100644
--- a/arch/x86/kvm/inst.h
+++ b/arch/x86/kvm/inst.h
@@ -115,6 +115,56 @@
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
 
diff --git a/arch/x86/kvm/vmenter.h b/arch/x86/kvm/vmenter.h
index a68020254a8d..81bf3ccf4da5 100644
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
index 4b7aaa7430fb..60e5669bdbab 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -48,6 +48,7 @@
  * @flags:	KVM_ENTER_VMRESUME:	use VMRESUME instead of VMLAUNCH
  *		KVM_ENTER_SAVE_SPEC_CTRL: save guest SPEC_CTRL into vmx->spec_ctrl
  *		KVM_ENTER_CLEAR_CPU_BUFFERS_FOR_MMIO: vCPU can access host MMIO
+ *		KVM_ENTER_EGPRS_SWITCH:	load/store guest EGPRs
  *
  * Returns:
  *	0 on VM-Exit, 1 on VM-Fail
@@ -78,6 +79,16 @@ SYM_FUNC_START(__vmx_vcpu_run)
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
@@ -225,8 +236,24 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
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
index 1701db1b2e18..e8dd5d5b33ad 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -987,6 +987,19 @@ unsigned int __vmx_vcpu_enter_flags(struct vcpu_vmx *vmx)
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


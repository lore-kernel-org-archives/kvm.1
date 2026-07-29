Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9D3C871B;
	Wed, 29 Jul 2026 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354210; cv=none; b=URNTHcv39RL9QGTklW4WN2h8N6MtkXmxqt49xpNSi9XOQhwS2Hn1sj+enLqKveBgBaIzelsMQgRpd6bBpmbEmUlc41YcNOt9bi7D01afMbXFny53HOSSOe08mcZaLBOd7dHVun4WHlUnDuhtfNSIMEhdQubp1PJLgpEvxM+FjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354210; c=relaxed/simple;
	bh=f64XoEdi97p1wuLv+H/o6Q7UZZsIMfkfdCWKtXvHdeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVgkghmBE6aMXwrL2dXJFx9MCd+Uhd5trCoiR7uO51gOCGNTyxhrGPG5lXnIFxiTIixRpTNytrFc1I49xkaP9JohImlCVieYi36O1sdwFsw2q3dIFO5sUK9UuXboYsyLQ3nNPL7PDl/mrehCIdUKRHUHmHafephYEDhTJcwq5oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kl+T4sfC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kl+T4sfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354205; x=1816890205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f64XoEdi97p1wuLv+H/o6Q7UZZsIMfkfdCWKtXvHdeQ=;
  b=kl+T4sfCv/wlDEzhCEEkGD17SjtbbmONqq1V9y7ojKi+yUFfXVZ1IrlE
   lcb2H1kBCjhjnEidErHAslv7rNkKikN/Ycd1H5sK3lHMR0tEN1w+7Tdlu
   8+cl3U5Nqja5wue2xB6woIV5EgJdAXx58TiXWds+sc5lGnNE8uLYV5mGT
   3viUS/VQ/KspJ+M8QqOegx0RoJ53Ei88afPysDI33kBgVXeqQd+s/Z/ls
   z6M/kBicGFtx+rf48B5lvkxPCUpPy0Pn3AZtcEt+xHRAN2DcZ0uYRszYu
   LCjfkUEeHNJnwgvIwSPpp3vtb49V7ow7YdqO+6PFHpvXdS5RSBIPaTxe6
   w==;
X-CSE-ConnectionGUID: nRa8bggiS6iULAbF4Ajhxg==
X-CSE-MsgGUID: +LwkK1w3SRC+6Ko80OQQNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508248"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508248"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:19 -0700
X-CSE-ConnectionGUID: H1URDNCHSKuK26OYpZ7f0g==
X-CSE-MsgGUID: j4PGztQJSEe0KQPV+rBpsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769225"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:18 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 03/20] KVM: x86: Support APX state for XSAVE ABI
Date: Wed, 29 Jul 2026 19:16:39 +0000
Message-ID: <20260729191656.598771-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260729191656.598771-1-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a facility to copy APX state between the VCPU cache and the
userspace buffer as the VCPU cache is the single source of truth.

The existing fpstate copy functions historically sync all XSTATEs in
between userspace and kernel buffers [1]. In this regard, any additional
state handling logic should be consistent with them -- i.e. validation of
XSTATE_BV against the supported XCR0 mask.

Now with the two copy paths, their invocations require to take care of
these facts:

  * When exporting to userspace, the fpstate function should run first
    since it zeros out the area of components either not present or
    inactive. Then the VCPU cache function ensures copying APX state.

  * On the opposite way, both will copy the state to both storages. This
    duplication is avoidable by tweaking either the generic function or
    XSTATE_BV/XCR0. But the optimization while at a slow path looks to
    rather add complication. So keep the implementation simple.

[1] Except for PKRU state, as stored in struct thread_struct.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V4 -> V5: Copy to both storages

The optimization bit had been reconsidered a little. V4 was attempting to
introduce the one-off exception into the generic copy function. Before
that, V3 had the tweak at the KVM site under the APX copy function.

But unless either approach could reach some agreeable shape, the tweak
appears to remain mere optimization. Here the third option would be
simply absorbing the duplication, which isn't significant in this slow
path in practice. Making simple looks to be a overall win, otherwise.
---
 arch/x86/kvm/cpuid.c       | 10 +++++++
 arch/x86/kvm/cpuid.h       |  2 ++
 arch/x86/kvm/vmx/vmenter.S |  2 +-
 arch/x86/kvm/x86.c         | 61 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2698fa42cd97..122e46db9a15 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -60,6 +60,16 @@ void __init kvm_init_xstate_sizes(void)
 	}
 }
 
+u32 xstate_size(unsigned int xfeature)
+{
+	return xstate_sizes[xfeature].eax;
+}
+
+u32 xstate_offset(unsigned int xfeature)
+{
+	return xstate_sizes[xfeature].ebx;
+}
+
 u32 xstate_required_size(u64 xstate_bv, bool compacted)
 {
 	u32 ret = XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET;
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 8d863f45585d..1716f3b6b885 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -66,6 +66,8 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 
 void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
+u32 xstate_size(unsigned int xfeature);
+u32 xstate_offset(unsigned int xfeature);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
 int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 702d86ade6b1..02308fb36f0f 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -213,7 +213,7 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
 	jz	.Lclear_egprs_done
 	/*
 	 * Unlike legacy GPRs, saving could be conditional here on VM-Fail,
-	 * which however isn't in fastpath. Instead, simply saving EGPRs always.
+	 * which however isn't in fastpath. Instead, always save EGPRs.
 	 */
 	STORE_REGS %_ASM_DI, VMX_vcpu_arch_regs, \
 		   %r16, %r17, %r18, %r19, %r20, %r21, %r22, %r23, \
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0626e835e9eb..5578df10179a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3124,6 +3124,49 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+#ifdef CONFIG_KVM_APX
+static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
+{
+	union fpregs_state *xstate = (union fpregs_state *)buf;
+
+	BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <= VCPU_REGS_R31);
+
+	if (!(supported_xcr0 & XFEATURE_MASK_APX))
+		return;
+
+	memcpy(buf + xstate_offset(XFEATURE_APX),
+	       &vcpu->arch.regs[VCPU_REGS_R16],
+	       xstate_size(XFEATURE_APX));
+
+	xstate->xsave.header.xfeatures |= XFEATURE_MASK_APX;
+}
+
+static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
+{
+	union fpregs_state *xstate = (union fpregs_state *)buf;
+
+	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX))
+		return 0;
+
+	if (!(supported_xcr0 & XFEATURE_MASK_APX))
+		return -EINVAL;
+
+	BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <= VCPU_REGS_R31);
+
+	memcpy(&vcpu->arch.regs[VCPU_REGS_R16],
+	       buf + xstate_offset(XFEATURE_APX),
+	       xstate_size(XFEATURE_APX));
+
+	return 0;
+}
+#else
+static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0) { }
+static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
+{
+	return 0;
+}
+#endif
+
 static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 					 u8 *state, unsigned int size)
 {
@@ -3145,8 +3188,15 @@ static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
 
+	/*
+	 * This copy function zeros out userspace memory for any gap from the
+	 * guest fpstate. So invoke before copying any other state, i.e. APX,
+	 * that is not saved in fpstate.
+	 */
 	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu, state, size,
 				       supported_xcr0, vcpu->arch.pkru);
+	kvm_copy_vcpu_regs_to_uabi(vcpu, state, supported_xcr0);
+
 	return 0;
 }
 
@@ -3161,6 +3211,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
 	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
+	int err;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
@@ -3172,6 +3223,16 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 	 */
 	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
 
+	/*
+	 * This and the following copy functions copy APX state into each
+	 * storage. The VCPU cache is the single source of truth but avoiding
+	 * this redundant copy tends to introduce special-case handling. Since
+	 * this lies in a slow path, keep the implementation simple.
+	 */
+	err = kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.supported_xcr0);
+	if (err)
+		return err;
+
 	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
 					      guest_xsave->region,
 					      kvm_caps.supported_xcr0,
-- 
2.53.0


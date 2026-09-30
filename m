Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBA5208D8;
	Wed, 30 Sep 2026 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804097; cv=none; b=q39BTxIRBLNABlamHzVGOSv5CkzGxdbdnGAD6ILWiDfcs66jtMpWWqSr+slTHt4fC2q+g/jT+ibziHhC1Im9nqDWwEkO4WpCC3WPWe95QrhhjalGR3R4X8xAgzkMhxV94IF9zlGDgcDOzktN8xqQgBtdq6UO1qeIv+mjv8i3oDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804097; c=relaxed/simple;
	bh=2LyuxFWn8cLA2R1eEGpuZlCvOfwWaH+mKf09EK/pvRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DF0DsbSGMbauyZ36DjFZJiAdrkkxH+WjqEUC93hiOa5UhLkc1/taA1Vwp4E+wV9YtnFP6ISUdj45f2CL9Y2/8qraA/HnNrrSmJY/VhseTAKQDHIUTzRWfRUPcdlicO6L4J3i26Zrnc5DgRIs4/J0a29+7x9nqxE39E6H6oWE2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOiNIpc1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOiNIpc1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804095; x=1822340095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2LyuxFWn8cLA2R1eEGpuZlCvOfwWaH+mKf09EK/pvRQ=;
  b=dOiNIpc12qHwLy4n280LSE9p66We09nFrkgIcPFlYomzcjFm3gL8KqQ4
   dhCRCRiUg11wgUDZ8AFBnFOMyfMlr6jHmjHasLShdmCghO+VhxYejZ3q/
   XsvgpEpa1zF4rSjM/SEnHT+QK2lLM7RvRzhbg1vfMsDRomkK993sjG4Vy
   I7XbAapPwS6YYhTst26zZrF0eSw6G2lKunVBOLuWFyuX2MRBsZZ4Qx3Wk
   n5dp272u1Q4rg9PM3Ng8M2eZBCJVYtLtw1kNL70QxroCZa9IuRNej4X6o
   02IZj/5zb8TxgcvA+yVEzaL7+mEUI8pm3iyZsGUEQXArb4s9QyEstZ+og
   w==;
X-CSE-ConnectionGUID: vNrebGk2SNCUHf5WyfK8oQ==
X-CSE-MsgGUID: 8H3XM3yBQ3CAg7MXG9UO4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432654"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432654"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:34:54 -0700
X-CSE-ConnectionGUID: jVbT8p6pTP6jQWj6Nl8fDQ==
X-CSE-MsgGUID: WdSbcAVUSISXo+p46yWjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867200"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:34:54 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 03/20] KVM: x86: Support APX state for XSAVE ABI
Date: Wed, 30 Sep 2026 21:07:33 +0000
Message-ID: <20260930210750.1487547-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930210750.1487547-1-chang.seok.bae@intel.com>
References: <20260930210750.1487547-1-chang.seok.bae@intel.com>
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

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kvm/cpuid.c | 10 ++++++++
 arch/x86/kvm/cpuid.h |  2 ++
 arch/x86/kvm/x86.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 851f151efb35..a3f583a376ab 100644
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 79468ddfe473..0df74422759f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3141,6 +3141,49 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
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
@@ -3162,8 +3205,15 @@ static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
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
 
@@ -3178,6 +3228,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
 	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
+	int err;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
@@ -3189,6 +3240,16 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
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


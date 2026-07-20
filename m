Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E2444CAEA;
	Mon, 20 Jul 2026 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569571; cv=none; b=RdGozQ7UvvcjLBhWr0me/d5fu5TNJeXAdfswwlbZQPEyeH6fI0gf43TJH3LBBoUMX3R2S+ccPpmCGjuxy4gawEVrEfIkBM5T8NDKMkgRZWSrAVQHdApNpdC1KWEe5z+YCkehX0/aKeonHz0F5hWIQJtGB42MB2Ya7hSb/7Fz/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569571; c=relaxed/simple;
	bh=kG+Cg7KjUxJiD/cDFeug4X+aUCKAq0WWuRVOa/dS818=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUa+CewePsUUT2NFeWdnzeOaarJV/THCDoHBce4f/bKrdE6IYg9jLgrF39qrNGyI8EJ5Y2w5D6QGHV4EG9wFbMNwPQj9BTT9a1yxFVeVsskzibYSfW9JuhObBUoFEh4jbeFGaSO5kSi7C+kJV/NfiFHaRdbJsqukFAc1y0vW710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jR4n2er9; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jR4n2er9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569568; x=1816105568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kG+Cg7KjUxJiD/cDFeug4X+aUCKAq0WWuRVOa/dS818=;
  b=jR4n2er9xm7xFucTQRvHdisJpgOWH8v8YKY2aBjUAHff4k0DrtxT5bEY
   nwhIEtjsLGaLnrkO6zqC4/FAv1MY5JVeSOXtUIxwGQgGyOg3Lq+id7LBP
   184Mmzovc+5rJjAvWEJsMkEnwBJrqVA2/P0KCz7+s1G2ufsO37CmPK5BQ
   Hw8fRNupuW24rghc96vyu78ryjl9TghYKDAxNYRLwsmgud1NmuN0nK1PL
   sz4XqCCnBK9fSWKtgo25vA4d/uWWoqCVckisEmrY6VVE4Et6SD/KBX+dB
   ncoT0jpopfMGPKNYx5cKM96jrlCEHSrduFT5eu5DGvbw7qBWD6D8Y+cOO
   w==;
X-CSE-ConnectionGUID: zt0UgwZVRrGb+gNBc1zCnQ==
X-CSE-MsgGUID: LDaixkPNQSmGErzMQBX9Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691638"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691638"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:45:59 -0700
X-CSE-ConnectionGUID: bkW6Ut0QRtafXVsA3jSzKQ==
X-CSE-MsgGUID: dLF3RPmTTYin4zppmGpgTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575342"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:45:59 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 03/20] KVM: x86: Support APX state for XSAVE ABI
Date: Mon, 20 Jul 2026 17:19:32 +0000
Message-ID: <20260720171949.498680-4-chang.seok.bae@intel.com>
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

Introduce a facility to copy APX state between the VCPU cache and the
userspace buffer as VCPU cache is the single source of truth.

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
    rather add complication. So keep it simple although sub-optimal.

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
 arch/x86/kvm/cpuid.c | 10 ++++++++
 arch/x86/kvm/cpuid.h |  2 ++
 arch/x86/kvm/x86.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

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


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0C3542F8;
	Wed,  2 Sep 2026 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317087; cv=none; b=dPQIkaJdqUoC0Wk5v4afnfZM5hh3oEGrAEYtzrHaTb0SwpxBqNj6aG3rszstsyBP8kbBE00eB+CDGE+837zByIIJB1o8Hzm2KKXWg1BBk10ldsxB+yw2XTt9BvSHk2AIlwtiPwUrhVWhmxzfCvP2F1HhkfwSt3rRsq18OFSVnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317087; c=relaxed/simple;
	bh=+yew5lwmVSE9qAQk2NlHKG8xPGORJfOWUqofT+Za9o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqOX68Ve1Umfoq6rbwGFlt3mFrWzPt8F8WHGFsyx8MtSCmJioDyPdEa24VbEyjsSxzjC4gtS8vL9dIzE0n0nQu1as1dUl1R40SCGLKpcVTCE0qAPa3bi1IiCo9akfwc9iNK9XbLshaB85gruuH7AZ0lVebbPHvBIuF7aEM/u1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mTnPwy+U; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mTnPwy+U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317084; x=1819853084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+yew5lwmVSE9qAQk2NlHKG8xPGORJfOWUqofT+Za9o4=;
  b=mTnPwy+U0fQl6pLGZngu82cO7ovn9snyoQiHt95NYX/I6rVYvQOz8sjp
   dhkL0vCmBs2UQ23q/xIN1KbTcVf9xr34wDHI1VAs0AAxZ0hkZgu+8EvOg
   DHaNWWp/M+3hBkWLKxgDSeZgObAsi6lqp9CNXoulNnxwmcRA/hkhkKU57
   wFtKXuINTkB8azX8B6uXRkyX5UBhHNTVpq7yPo9jrnVWxKzpnZRgu0w8J
   O+bd/ku9jZtlqDBN+rekbnviHlTp+5k2JHiEU5Bp+HaLmM33BBrv2wZv0
   6Fz+TkVbsPKLqGbT59Le0pNkjo7hQ1hQUvaJxO/TppXYOcChKojVy/4ue
   Q==;
X-CSE-ConnectionGUID: OtBzKUr4R5y+vxqs3gPxKQ==
X-CSE-MsgGUID: pXL/Os4XS+SGiqlqNFuf6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282892"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282892"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:44 -0700
X-CSE-ConnectionGUID: vmuNMcrsRjK4KXkc0jZRmA==
X-CSE-MsgGUID: RV9XsHIQS8GoU8iIoZKELQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775492"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:44 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 03/20] KVM: x86: Support APX state for XSAVE ABI
Date: Wed,  2 Sep 2026 02:17:47 +0000
Message-ID: <20260902021804.718676-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902021804.718676-1-chang.seok.bae@intel.com>
References: <20260902021804.718676-1-chang.seok.bae@intel.com>
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


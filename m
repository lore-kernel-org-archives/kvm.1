Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24B2DA76F;
	Tue, 12 May 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550027; cv=none; b=oG95rg0BLgZvZpXbggST7YMvuSr14I5wpunEuZP/ZbHos7LrdtpXw1qjaXYC7owYmKn59fRbicPwNe65QNYSZrPfQYqL5nIvfMnY36WKdzk5ZF14UJ0qMcAGVcbiyvZ6j9z2mx2mVCjAq496tC0eGsH07Ah0eybG3fKI3Kf8+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550027; c=relaxed/simple;
	bh=Kkh2WSjqSDJKNMeGmSp6Tqv/mRakjmsf5Igfh4Fczgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJJx7CO+JwUg+4Kmh8ATHtIxoOY9GR8cfZv1YWYq/B/z/tZIIELJYwk42cyVyyOALzWWwI+TJAxOOTBV9tYZ52ZXkH6jjipcCDuPGhij9ZLmVDbOHhOokueJcOXIXIMuudqm6pwUwh4SQfadBvVp2l85q8I8+pgRy3PaYz7nu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TePPQAPA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TePPQAPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550026; x=1810086026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kkh2WSjqSDJKNMeGmSp6Tqv/mRakjmsf5Igfh4Fczgg=;
  b=TePPQAPAQ+V3KvpnWZ5seDhbeAREFvJlttL6X1IoiVNdB335LBMu9uQ5
   J19uHfh4IQdyx5nnrTA9u8uhuQirzPXfig9+MZn/sC0ZtUTr8SjxZWdZS
   SaCKU6+43hA56V95+pcEl5AHYZjUMPpyIJ3TT7pkenrVHO0bmhUd1n8kO
   GXET0/g+aRV54E9OKl1v+TXVQgkN7hNvBxI/vDBEGKHCB/Zm2SRIXIE97
   c72Rm0xDxfWBYHcTg5HeRIETGHoXKZhX7sT51ZofqRpPGwPlXx/YK2+8W
   q3Z06QoOAtPEtkVQUTA4PgxGgW5jZO7THgh8NgcitcGViyehwqP92zSNn
   Q==;
X-CSE-ConnectionGUID: wYfZK+t2Sged1erRgGO+NA==
X-CSE-MsgGUID: NW4cgd6JQwWfq974DCqzFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322129"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322129"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:23 -0700
X-CSE-ConnectionGUID: fHIrze4NTU6fQfguInKCNA==
X-CSE-MsgGUID: upaeYl8fRL+tzv8hYg9e5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572773"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:23 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 07/21] KVM: x86: Support APX state for XSAVE ABI
Date: Tue, 12 May 2026 01:14:48 +0000
Message-ID: <20260512011502.53072-8-chang.seok.bae@intel.com>
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

Introduce a facility to copy APX state between the VCPU cache and the
userspace buffer since APX state is stored there.

The existing fpstate copy functions historically sync all XSTATEs in
between userspace and kernel buffers [1]. In this regard, any additional
state handling logic should be consistent with them -- i.e. validation of
XSTATE_BV against the supported XCR0 mask.

Now with the two copy paths, their invocations require to take care of
orderings:

  * When exporting to userspace, the fpstate function should runs first
    since it zeros out the area of components either not present or
    inactive. Then the VCPU cache function ensures its state copy.

  * When importing from userspace, the VCPU cache function should run
    first as the fpstate function always clears XSTATE_BV[APX] for not
    saving in the storage.

[1] Except for PKRU state, as stored in struct thread_struct.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V3 -> V4: Do not reset XSTATE_BV[APX], now with PATCH6 (Paolo)
---
 arch/x86/kvm/cpuid.c | 10 ++++++++
 arch/x86/kvm/cpuid.h |  2 ++
 arch/x86/kvm/x86.c   | 58 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e69156b54cff..82cb7c8fbc07 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -59,6 +59,16 @@ void __init kvm_init_xstate_sizes(void)
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
index 039b8e6f40ba..5ace99dd152b 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -64,6 +64,8 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 
 void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
+u32 xstate_size(unsigned int xfeature);
+u32 xstate_offset(unsigned int xfeature);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
 int cpuid_query_maxguestphyaddr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 48f259015ce4..3f029f9272a2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5805,6 +5805,48 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
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
+static void kvm_copy_vcpu_regs_to_uabi(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0) { };
+static int kvm_copy_uabi_to_vcpu_regs(struct kvm_vcpu *vcpu, void *buf, u64 supported_xcr0)
+{
+	return 0;
+}
+#endif
 
 static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 					 u8 *state, unsigned int size)
@@ -5827,8 +5869,15 @@ static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
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
 
@@ -5843,6 +5892,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
 	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
+	int err;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
@@ -5854,6 +5904,14 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 	 */
 	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
 
+	/*
+	 * Copy APX state to VCPU cache before the following copy function
+	 * which always unsets XSTATE_BV[APX] to avoid savings in its storage.
+	 */
+	err = kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.supported_xcr0);
+	if (err)
+		return err;
+
 	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
 					      guest_xsave->region,
 					      kvm_caps.supported_xcr0,
-- 
2.51.0


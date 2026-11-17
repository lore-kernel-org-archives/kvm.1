Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940307;
	b=1WFKCoY5NqrrHAx4P0HLzkz0jukHb5IoWvGbRXm7W1rs10HErIzAlbgnsA6aWt1427Ks
	 fzIuaCXrJOsMxieDs6f9wgW5Q12LBKYXiTDVGL7OvcGg8GAAQwB4EYHx1zDmXQZnkxh2C
	 ipqQinPrTqWnTeZkNZrA7K6cG/sGElPFKdeZaes/MgqXFlmM/LHfO2qaeTNnEudoMbLWh
	 f26wXYd+uy0gO7YXzkRC+B8cfXWwp0dl73OZfUzBUakWfpNixYH1tN6SqJzCs3Thd2Svj
	 BgYQ8zj7mBskUsgt7fVprfOpbHkbVz7CenZoapYHmlTfo4JLVqZQ4taSNvr/qa06CEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940307;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SLCYJJJZxNdFY23BSUyytPreDqQ3AKsuql7VgyliaLk=;
	b=juJrnYmxHIUKt59La4h66l6mAcc0m8z406gt1b/XSiZQ3SbVmvwDu52+Q/YV0S8xm804
	 /CV+wWVfxfg0rXidMDz/0+/m04N81TEPO0eJfhd3bU8LAvjc6bhS144ptjQOiBaLvSTOW
	 P3SHhfJCbhsIBfy4Q5a5PY7CE71g22F+/+Vkkzy/pPiJ76XP+nSWI6LAdjREL4a1yRm5s
	 ta+xHkFbyOb/QeduqxOPtPUY8b06hOKidhuAYcgk2Ocv/mIFkvQCKJCaGPx+uZuElZ8HX
	 SoH3FIKLdlm5kNypavNKB5Qev7gGuJTWzaAdHqLfeuCYL/jutdahMTHIZtmVUxoJzDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AXwW9ecP;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C03606A88D;
	Tue, 17 Nov 2026 18:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C03606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AXwW9ecP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940307; x=1826476307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=au057zZNUXUwwVx17AOJxoL/BOhmwtbE4AWvH7sViFE=;
  b=AXwW9ecPfvr7U2kKpnxbVl+R1T0DJNr+rcmiIYwa48tF9Sc/b1M6Hu3L
   VGQ1+1NzpZWrCFM/5jXrlEXBHOfw3MUCmQ6tL+8v5/anmJY+7491EqzrE
   cZ61Mi+rnclzYCZ1R1q6bT/d/FAoLEgNKOQyjDAiG8fe5nYpn3dHDx17g
   n8/Zj+QSI7XEamu/fXA5hJf+jHZ1FGwKSm5/3i3UKva/5xuaQWsbTDroR
   lozpaGjjnudHJtJbGX55eb2HvqZauq854Tm3p+zF1Iohr+vujZBP2m2X+
   eiYVClVybAmRKKHBrs7hXESpoGhibXovaeUEqAiS+WH33TQphfjWpjsh6
   g==;
X-CSE-ConnectionGUID: dZhWxHPcR5+phXOhZupvZw==
X-CSE-MsgGUID: HDDdRx9NRTWlOpYl2XwuWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607222"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607222"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:44 -0800
X-CSE-ConnectionGUID: 6pXtmftGQZiAnCsO6gxtbw==
X-CSE-MsgGUID: zVidgbi+R+OLciB16yoQOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775008"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:45 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 04/20] KVM: x86: Support APX state for XSAVE ABI
Date: Tue, 17 Nov 2026 18:02:54 +0000
Message-ID: <20261117180310.921701-5-chang.seok.bae@intel.com>
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

Introduce a facility to copy APX state between the VCPU cache and the
userspace buffer as the VCPU cache is the single source of truth.

The existing fpstate copy functions historically sync all XSTATEs in
between userspace and kernel buffers [1]. In this regard, any additional
state handling logic should be consistent with them -- i.e. validation of
XSTATE_BV against the supported XCR0 mask.

Now the two copy paths requires to take care of these facts:

  * When exporting to userspace, copy fpstate first, since it zeros the
    area of any component that is absent or inactive. Then copy the APX
    state from the VCPU cache.

  * When importing from userspace, the APX state is copied to both
    fpstate and the VCPU cache. Avoiding the duplicate copy would need
    special care in the common code or in XSTATE_BV/XCR0 which isn't
    worth that much for a slow path, so keep it simple.

[1] Except for PKRU state, as stored in struct thread_struct.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
V8 -> V9:
 * Fix XSTATE_BV[APX]=0 behavior (Jim Mattson)
 * On the way to the kernel buffer, switch the copy ordering (Jim Mattson)
---
 arch/x86/kvm/cpuid.c | 10 ++++++
 arch/x86/kvm/cpuid.h |  2 ++
 arch/x86/kvm/x86.c   | 73 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adafd6fa2c54..7c6825000928 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -61,6 +61,16 @@ void __init kvm_init_xstate_sizes(void)
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
index 46bfe8699e67..444faaf33307 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -66,6 +66,8 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 
 void __init kvm_init_xstate_sizes(void);
 u32 xstate_required_size(u64 xstate_bv, bool compacted);
+u32 xstate_size(unsigned int xfeature);
+u32 xstate_offset(unsigned int xfeature);
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu);
 u64 kvm_vcpu_reserved_gpa_bits_raw(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 73bb1d25931c..f251631a63de 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3165,6 +3165,53 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
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
+	BUILD_BUG_ON(NR_VCPU_GENERAL_PURPOSE_REGS <= VCPU_REGS_R31);
+
+	/* If XSTATE_BV[APX] is unset, the state should be initialized: */
+	if (!(xstate->xsave.header.xfeatures & XFEATURE_MASK_APX)) {
+		if (supported_xcr0 & XFEATURE_MASK_APX)
+			memset(&vcpu->arch.regs[VCPU_REGS_R16], 0, xstate_size(XFEATURE_APX));
+		return 0;
+	}
+
+	if (!(supported_xcr0 & XFEATURE_MASK_APX))
+		return -EINVAL;
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
@@ -3186,8 +3233,15 @@ static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
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
 
@@ -3202,6 +3256,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
 	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
+	int err;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
@@ -3213,10 +3268,20 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 	 */
 	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
 
-	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
-					      guest_xsave->region,
-					      kvm_caps.supported_xcr0,
-					      &vcpu->arch.pkru);
+	err = fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
+					     guest_xsave->region,
+					     kvm_caps.supported_xcr0,
+					     &vcpu->arch.pkru);
+	if (err)
+		return err;
+
+	/*
+	 * The APX state was also copied into fpstate above, but the VCPU cache
+	 * is the single source of truth. Skipping the redundant copy tends to
+	 * introduce special-case handling. Since this lies in a slow path, keep
+	 * the implementation simple.
+	 */
+	return kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.supported_xcr0);
 }
 
 static int kvm_vcpu_ioctl_x86_get_xcrs(struct kvm_vcpu *vcpu,
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457881;
	b=K05Mp7IliISxAKWD3cxypcCmml4PqQM8xL3WIHkKVhZjPDS51gd4dTxbzHx0BlbUIZKl
	 F1FTBycaln6pfVLK3y87gtlE4EiQSPjZaKnyn284mDekIyTaE6tC84kIshIH+uMU11qkx
	 fQSKw+rlJuDqaxPZw7zV5P1GxJ4qbABFqpakJ8ASEujGIOjWah7AL00gwmkD+CYq3tqIO
	 ubDPr1VG4GqWXp1s7vEZ15MnsPqUB14NvAH+uv6ykQjkoS4a5eS1rFNWkJAA5zP+1A+B8
	 s7lH8mLXZWFoBjIsne8nzpwgQmM/PoSVAlDLnxva5rL2renVHcCsQQP2BpMZLdSTFPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457881;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OnzrAqjr8y5ubXP4/IMOWauDif7gaQ5idwluCoZpnSo=;
	b=UJrJQ6uc1tVudNWKOpF1vGZLNJoz4b7Q348xGH1FIIypGwhTpVsmxpGeBK7Rl50OAPeX
	 reZOUKjbSNnrh8NeD0/CJG7n9FGdA9XnByOiIPBJBzJg2xZfMjxvTUHWQuIXzIrVwjhqv
	 6UYpwyuy363v0Gi2ZtU3BMmyZbNRcBFMSamXCPmShpzXwmiIx4j8XBhYsy4QXgcMBXRhn
	 Zte1DiBYsepyq+qWDaZfysCbvM0P7DvhRjVic2ZMUItOSYUV2U0BgGeCdeyq5wrZBXddG
	 2/2K8ySSgZCTms5eVlo0nqTeAO23x0kNl/EGnr7Rg1X9D92+TCfJwHmtNhZGmYzn+GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A3SoDFuq;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D440606A690;
	Mon, 23 Nov 2026 18:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D440606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A3SoDFuq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457881; x=1826993881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=11RPjVH7PCUyOTWaFyg70rHB+8XH9RPGg1qKT9uw4q0=;
  b=A3SoDFuqI8WAc5w7GpvPMhR+3luT+YRP9YPC8nIbm4ZRMp30VPwFpqDi
   pdaY7VVN4fQcnOyDN8RFSva5+l4sNbM9eVGhX0qx4bxlRaG9BnR6FZOs1
   ocOZSHt01Eul6qzySE3Y8JEJlC5wJZTmSaWu+HOFu7c+x9azBPOuotE/i
   LiUgxEdRW8yr9BOGQNKDaclFMsom9odUJ4nmHZSAejMmat3XXiHeDhkF7
   fqZ4afnO2baHXpn4A36+xNtU+gkxMTGTItGu+nB4U2IqPOVfCifcF0F+k
   MSAAPuGU3mA1YB3BjYM1TuTxTl7nNGzvdqgc9gjZCLGgDFu6uMSgKLwHe
   w==;
X-CSE-ConnectionGUID: Q1/HmY8lTG2vCHivo27rwQ==
X-CSE-MsgGUID: FGz2kMMXTP6GiXFx6u7Oug==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288785"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288785"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:09 -0800
X-CSE-ConnectionGUID: ZGbGpi3+QSS9MwYvWXBODw==
X-CSE-MsgGUID: QQK/+5srQnG+zerzcBx1JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241073"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:09 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 04/20] KVM: x86: Support APX state for XSAVE ABI
Date: Mon, 23 Nov 2026 17:37:16 +0000
Message-ID: <20261123173732.1072124-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
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

Introduce a facility to copy APX state between the vCPU cache and the
userspace buffer as the vCPU cache is the single source of truth.

The existing fpstate copy functions historically sync all XSTATEs in
between userspace and kernel buffers [1]. In this regard, any additional
state handling logic should be consistent with them -- i.e. validation of
XSTATE_BV against the supported XCR0 mask.

Now the two copy paths must account for these facts:

  * When exporting to userspace, copy fpstate first, since it zeros the
    area of any component that is absent or inactive. Then copy the APX
    state from the vCPU cache.

  * When importing from userspace, the APX state is copied to both
    fpstate and the vCPU cache. Avoiding the duplicate copy would need
    special care in the common code or in XSTATE_BV/XCR0 which isn't
    worth that much for a slow path, so keep it simple.

[1] Except for PKRU state, as stored in struct thread_struct.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
---
V9 -> V10: Skip the redundant sanity check (Jim Mattson)
---
 arch/x86/kvm/cpuid.c | 10 ++++++
 arch/x86/kvm/cpuid.h |  2 ++
 arch/x86/kvm/x86.c   | 74 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 82 insertions(+), 4 deletions(-)

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
index c2ce1bc8c77f..b2d44c2f70e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3165,6 +3165,54 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
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
+/*
+ * Must call this after successful fpu_copy_uabi_to_guest_fpstate(),
+ * which means APX is XCR0-supported if XSTATE_BV[APX] is set.
+ */
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
@@ -3186,8 +3234,15 @@ static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
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
 
@@ -3202,6 +3257,7 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
 	union fpregs_state *xstate = (union fpregs_state *)guest_xsave->region;
+	int err;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
 		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
@@ -3213,10 +3269,20 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
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
+	 * The APX state was also copied into fpstate above, but the vCPU cache
+	 * is the single source of truth. Skipping the redundant copy tends to
+	 * introduce special-case handling. Since this lies in a slow path, keep
+	 * the implementation simple.
+	 */
+	return kvm_copy_uabi_to_vcpu_regs(vcpu, guest_xsave->region, kvm_caps.supported_xcr0);
 }
 
 static int kvm_vcpu_ioctl_x86_get_xcrs(struct kvm_vcpu *vcpu,
-- 
2.53.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D582236E8
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051810; cv=none; b=q4tj1GSU5c9naiYsf6+9ZiszoebZBfFvIIkd17oCk3S6Du6lrChSTLMwewnbOYQzfI1d5ks64KojFVdp0b9B2L8J+igjNvsGYQ/6deZmQvP7Cos3T0LvIZfra3ctJjqMXKqm2cuDm9QRUoJJP8F/+B6F15/XAFKwMVu30l5F9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051810; c=relaxed/simple;
	bh=6hAYeH1jg734OzEy9t2zHNEGzLF64Xen0G6aA0tUh0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVYyJuSfJkV3zBBjJdVb+x5mQuqfvumiSXLEsJfj7vyYbEvEuRsRj7D3i21nZIll0xxfC4YWZJO+OqgDWD7eAgIzUgLkPgNcU3orbEDMCoPqzb3hscF0EA0qFSZ3bdtH4pHXPK5gkFLFp8aWkjVJxByQeaxqlxHWFQIueQvzrPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8lXpFKM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmdY9CuA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8lXpFKM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmdY9CuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19ie81EeW2ptRkJG9krhvX9JhFD1zD6U9sRVAVS7sWE=;
	b=Z8lXpFKMLyo9AltIYsvTpPAoSS2fhwVE2T4Pm+dbdXU1vZh2U6s/Tdfzn6q+y/z0RjjPtk
	CCEauAp49sZYBDy6JeqOcCFPCjhVLZZtx5ibVYpKS1YMPztyA8MZ1EtlIUSGiuFPoua9UR
	4T13Fe6a3ep6KHom/L1+/dT/n3VvDfs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-fb5FnG6lPrqwNF3HgrwX0Q-1; Fri, 20 Mar 2026 20:10:05 -0400
X-MC-Unique: fb5FnG6lPrqwNF3HgrwX0Q-1
X-Mimecast-MFC-AGG-ID: fb5FnG6lPrqwNF3HgrwX0Q_1774051805
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48539bda3dcso22102825e9.2
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051804; x=1774656604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19ie81EeW2ptRkJG9krhvX9JhFD1zD6U9sRVAVS7sWE=;
        b=YmdY9CuAiReLEveh3SWStOU39FEbqHeIJugDgmwh+tFb8sAwMCS8xZfXiyKw0UeUym
         t5Sif+Ez45BFOknSxQvTdqdESNKDEwPiJN1Fw5JArBBH9NoiXPeSP6gwfYbUreRIg4OA
         gHwL4OBFZsR0arKACuAwoVtm97NIB/WOctRawLdfVxfU/gnikQf6PA5WAwXxZhbLERQq
         hgNPWkTEjemE2C7MLTVfPL/FnnB7ImL4ejLPutqprDtrWzvVJABTeeYKgPpkH75KRNUT
         goPQ1l5QtAqhqGa2mFLtuDzdh/lzK9Y81xO0lqYdfOO7pxFm+Gg3b0/DNqT19zwEKDur
         zHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051804; x=1774656604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19ie81EeW2ptRkJG9krhvX9JhFD1zD6U9sRVAVS7sWE=;
        b=CoKtwJxKjSmIOccm6e9a8oDTsapA+PfQQfILuNukue4YGLIl5VwEZfgeJXX/E5IEHr
         JJLELWzTMvBqKYwoEaiDwF1ZO09D9+V0ZZRC86UMHKcah5riLmQpdp4maig02Tu7993B
         GV4J1uSVWlfoT1NwoUxCr6j9ylzqKz8gBQnrqktHi9IVnbgSIEQsxRhY1OyY+9YKgKDu
         UyYQw2wkhB0JAtNpP2CFFXyBI/+r7dxtVYmc5damiqE8TylS0fDS4C9n3I97HRPeGdrc
         oDM2j0aqYUHQoCoBHZqkUeAcDSQfQrezdu93dCYHcffVyHg6pL44OkJhe+ZMtMKbrP0G
         IDag==
X-Forwarded-Encrypted: i=1; AJvYcCX9Is6HY/h5FzU0gaNusSiBCa9TiWcy+elE5fNOpTcz842Pzc/28PAscCQJy4+Lg4ID6RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXH3Y6d3RDX8nyI0PGNvcilbJ5kFYVlxQX0Ahmy30DhXUA5fVb
	bezg974dM1BgwhHhAukwF1DFhjLlADFuozoTO3FAtsX/VkMjBSsSYaZVWN9HMiGBiSeDe2u0U2U
	k73BpndMs0geZzdoQt2Zx/zgLbj3FrO53M4fO4XnaltIqRsq1JGl02A==
X-Gm-Gg: ATEYQzyYX+ZNilsw7p4cDylsmaGZISS3pNIVTGsYNGFJjmCR/AGG3nuc4eSHQpvF0pu
	oDV2atNLbBGF6ZpoUXg9i2iVFIasPyr0885Bhf22A6fbD7jrqKMBuLg1MB3NOpeQONRChCoD1lF
	MACvSBAx0qEmKh/nyZhB0bXowvkh8WrUyq1GEpGLNsQmrE315Q+eeHRJcOQmC4EgSczixfrnJ7J
	9ZbVimDsHwmHMRB5Q2n9IH8bWRke+NhXYXcE94xL9wJBjVPUaP+kvXXW/nEivBdKfTjaA9mNhqS
	EJxF+/xeyRRw+QUfSIWJdXP1LLsz3snx0jm57gn4uN+mtWRbJxyDJpEXX9ly/FpoSHBj8Sy+H2x
	oF+0g7UoMgNryyaqjmSyxSja9VWNOTpX7vL01ZAgGV99DQXR4dvTLdQOJsvGRhrPc7G5dLy7bbP
	MOI6PuLm1P7iWWWQevT90A87xl
X-Received: by 2002:a05:600c:c8a:b0:485:4453:401d with SMTP id 5b1f17b1804b1-486fede7336mr71303835e9.2.1774051804314;
        Fri, 20 Mar 2026 17:10:04 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:485:4453:401d with SMTP id 5b1f17b1804b1-486fede7336mr71303425e9.2.1774051803859;
        Fri, 20 Mar 2026 17:10:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1d3befsm25877895e9.32.2026.03.20.17.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 12/22] KVM: VMX: enable use of MBEC
Date: Sat, 21 Mar 2026 01:09:21 +0100
Message-ID: <20260321000931.1947084-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Add SECONDARY_EXEC_MODE_BASED_EPT_EXEC as optional secondary execution
control bit.  If enabled, configure XS and XU separately (even if they
are always used together).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h      |  3 +++
 arch/x86/kvm/mmu.h              |  7 ++++++-
 arch/x86/kvm/mmu/spte.c         |  4 ++--
 arch/x86/kvm/mmu/spte.h         |  5 +++--
 arch/x86/kvm/vmx/capabilities.h |  6 ++++++
 arch/x86/kvm/vmx/common.h       | 17 ++++++++++++-----
 arch/x86/kvm/vmx/main.c         | 11 ++++++++++-
 arch/x86/kvm/vmx/vmx.c          | 16 +++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/vmx/x86_ops.h      |  1 +
 10 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 0041f8a77447..5fef7a531cb7 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -597,9 +597,12 @@ enum vm_entry_failure_code {
 #define EPT_VIOLATION_GVA_TRANSLATED	BIT(8)
 
 #define EPT_VIOLATION_RWX_TO_PROT(__epte) (((__epte) & VMX_EPT_RWX_MASK) << 3)
+#define EPT_VIOLATION_USER_EXEC_TO_PROT(__epte) (((__epte) & VMX_EPT_USER_EXECUTABLE_MASK) >> 4)
 
 static_assert(EPT_VIOLATION_RWX_TO_PROT(VMX_EPT_RWX_MASK) ==
 	      (EPT_VIOLATION_PROT_READ | EPT_VIOLATION_PROT_WRITE | EPT_VIOLATION_PROT_EXEC));
+static_assert(EPT_VIOLATION_USER_EXEC_TO_PROT(VMX_EPT_USER_EXECUTABLE_MASK) ==
+	      (EPT_VIOLATION_PROT_USER_EXEC));
 
 /*
  * Exit Qualifications for NOTIFY VM EXIT
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index f5d35f66750b..2a6caac39d40 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -76,12 +76,17 @@ static inline gfn_t kvm_mmu_max_gfn(void)
 	return (1ULL << (max_gpa_bits - PAGE_SHIFT)) - 1;
 }
 
+static inline bool mmu_has_mbec(struct kvm_mmu *mmu)
+{
+	return mmu->root_role.cr4_smep;
+}
+
 u8 kvm_mmu_get_max_tdp_level(void);
 
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
 void kvm_mmu_set_mmio_spte_value(struct kvm *kvm, u64 mmio_value);
 void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask);
-void kvm_mmu_set_ept_masks(bool has_ad_bits);
+void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 0b3e2b97afbf..f51e74e7202d 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -499,7 +499,7 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask)
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_me_spte_mask);
 
-void kvm_mmu_set_ept_masks(bool has_ad_bits)
+void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec)
 {
 	kvm_ad_enabled		= has_ad_bits;
 
@@ -508,7 +508,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
 	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
-	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xu_mask		= has_mbec ? VMX_EPT_USER_EXECUTABLE_MASK : VMX_EPT_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
 	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 7323ff19056b..61414f8deaa2 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -24,7 +24,7 @@
  * - bits 55 (EPT only): MMU-writable
  * - bits 56-59: unused
  * - bits 60-61: type of A/D tracking
- * - bits 62: unused
+ * - bits 62 (EPT only): saved XU bit for disabled AD
  */
 
 /*
@@ -72,7 +72,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
  * must not overlap the A/D type mask.
  */
 #define SHADOW_ACC_TRACK_SAVED_BITS_MASK (VMX_EPT_READABLE_MASK | \
-					  VMX_EPT_EXECUTABLE_MASK)
+					  VMX_EPT_EXECUTABLE_MASK | \
+					  VMX_EPT_USER_EXECUTABLE_MASK)
 #define SHADOW_ACC_TRACK_SAVED_BITS_SHIFT 52
 #define SHADOW_ACC_TRACK_SAVED_MASK	(SHADOW_ACC_TRACK_SAVED_BITS_MASK << \
 					 SHADOW_ACC_TRACK_SAVED_BITS_SHIFT)
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 3bda6a621d8a..02037e559410 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -393,4 +393,10 @@ static inline bool cpu_has_notify_vmexit(void)
 		SECONDARY_EXEC_NOTIFY_VM_EXITING;
 }
 
+static inline bool cpu_has_ept_mbec(void)
+{
+	return vmcs_config.cpu_based_2nd_exec_ctrl &
+		SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+}
+
 #endif /* __KVM_X86_VMX_CAPS_H */
diff --git a/arch/x86/kvm/vmx/common.h b/arch/x86/kvm/vmx/common.h
index 1afbf272efae..eff0b51bfda5 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -74,6 +74,8 @@ static __always_inline bool is_td_vcpu(struct kvm_vcpu *vcpu) { return false; }
 
 #endif
 
+extern int vt_get_cpl(struct kvm_vcpu *vcpu);
+
 static inline bool vt_is_tdx_private_gpa(struct kvm *kvm, gpa_t gpa)
 {
 	/* For TDX the direct mask is the shared mask. */
@@ -91,15 +93,20 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	/* Is it a fetch fault? */
 	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
 		      ? PFERR_FETCH_MASK : 0;
-	/*
-	 * ept page table entry is present?
-	 * note: unconditionally clear USER_EXEC until mode-based
-	 * execute control is implemented
-	 */
+	/* Is it a fetch fault? */
+	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
+		      ? PFERR_FETCH_MASK : 0;
+	/* ept page table entry is present?  */
 	error_code |= (exit_qualification &
 		       (EPT_VIOLATION_PROT_MASK & ~EPT_VIOLATION_PROT_USER_EXEC))
 		      ? PFERR_PRESENT_MASK : 0;
 
+	if (mmu_has_mbec(vcpu->arch.mmu)) {
+		error_code |= vt_get_cpl(vcpu) > 0 ? PFERR_USER_MASK : 0;
+		error_code |= (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
+	                      ? PFERR_PRESENT_MASK : 0;
+	}
+
 	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index dbab1c15b0cd..601d1b7437a8 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -354,7 +354,7 @@ static void vt_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var,
 	vmx_set_segment(vcpu, var, seg);
 }
 
-static int vt_get_cpl(struct kvm_vcpu *vcpu)
+int vt_get_cpl(struct kvm_vcpu *vcpu)
 {
 	if (is_td_vcpu(vcpu))
 		return 0;
@@ -750,6 +750,14 @@ static int vt_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
 	return vmx_set_identity_map_addr(kvm, ident_addr);
 }
 
+static bool vt_tdp_has_smep(struct kvm *kvm)
+{
+	if (is_td(kvm))
+		return false;
+
+	return vmx_tdp_has_smep(kvm);
+}
+
 static u64 vt_get_l2_tsc_offset(struct kvm_vcpu *vcpu)
 {
 	/* TDX doesn't support L2 guest at the moment. */
@@ -952,6 +960,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_tss_addr = vt_op(set_tss_addr),
 	.set_identity_map_addr = vt_op(set_identity_map_addr),
 	.get_mt_mask = vmx_get_mt_mask,
+	.tdp_has_smep = vt_op(tdp_has_smep),
 
 	.get_exit_info = vt_op(get_exit_info),
 	.get_entry_info = vt_op(get_entry_info),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 98801c408b8c..350d26f792c4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -112,6 +112,9 @@ module_param(emulate_invalid_guest_state, bool, 0444);
 static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
+static bool __read_mostly enable_mbec = 1;
+module_param_named(mbec, enable_mbec, bool, 0444);
+
 module_param(enable_apicv, bool, 0444);
 module_param(enable_ipiv, bool, 0444);
 
@@ -2625,6 +2628,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 			return -EIO;
 
 		vmx_cap->ept = 0;
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;
 	}
 	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
@@ -4520,6 +4524,9 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	 */
 	exec_control &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
 
+	if (!enable_mbec)
+		exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+
 	/* SECONDARY_EXEC_DESC is enabled/disabled on writes to CR4.UMIP,
 	 * in vmx_set_cr4.  */
 	exec_control &= ~SECONDARY_EXEC_DESC;
@@ -7580,6 +7587,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
 	return (MTRR_TYPE_WRBACK << VMX_EPT_MT_EPTE_SHIFT);
 }
 
+bool vmx_tdp_has_smep(struct kvm *kvm)
+{
+	return enable_mbec;
+}
+
 static void vmcs_set_secondary_exec_control(struct vcpu_vmx *vmx, u32 new_ctl)
 {
 	/*
@@ -8406,6 +8418,8 @@ __init int vmx_hardware_setup(void)
 		ple_window_shrink = 0;
 	}
 
+	if (!cpu_has_ept_mbec())
+		enable_mbec = 0;
 	if (!cpu_has_vmx_apicv())
 		enable_apicv = 0;
 	if (!enable_apicv)
@@ -8425,7 +8439,7 @@ __init int vmx_hardware_setup(void)
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	if (enable_ept)
-		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
+		kvm_mmu_set_ept_masks(enable_ept_ad_bits, enable_mbec);
 	else
 		vt_x86_ops.get_mt_mask = NULL;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index d3389baf3ab3..743fa33b349e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -576,6 +576,7 @@ static inline u8 vmx_get_rvi(void)
 	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
 	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
 	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
+	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
 	 SECONDARY_EXEC_ENCLS_EXITING |					\
 	 SECONDARY_EXEC_EPT_VIOLATION_VE)
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 2b3424f638db..1fb1128b1eb7 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -104,6 +104,7 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
 int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
 u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+bool vmx_tdp_has_smep(struct kvm *kvm);
 
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
-- 
2.52.0


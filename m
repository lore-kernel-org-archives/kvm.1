Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A836A3DBD61
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662963; cv=none; b=b8mNzNrYoM4sVygvHoSPnzRyODvUJUMuydIiWHeKcJJJmWKQX+hG82MYgflzEyNRoNoEn8Lh6jh0b85k+AZYbyMAPCmOzX6yPYDcwJGViqqaK9DyoiCSE2+/ANys3+PqLcHJDGkay2YkIgl2qNPkDbvsj4qoW1+Fdy0MQ9bcYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662963; c=relaxed/simple;
	bh=jbTy/Li7PFdTAMbw3OzhrtT5zoFqsPNm0zcGo71lNzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H99pBNXr3vzpNAI+hMceChtpKZ+xrwVNkjYrvMFp9iSeezqVMUZome2fN0A+5ljfJ0RUAKjntcO3lp5gJO5N7RN4EqzgPmNTVcuRwJ56EHJn2L3cBAN4RqvrWpLY0g7Hh7iT4zrN0mp4kRjZteeuyOgprmncp0qBQHwoHMb9Zp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpDtOOpc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpDtOOpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CeB6uVbhuSF7QBj63geywsNYZuaqFMdV23JyMmc+n8I=;
	b=FpDtOOpcM13tRNiDvsXaqN4lB7XyHqQc2wdhOzTRTRz9V2EPD3Cp2J4WTla3gemrXQY6Jv
	AiuLI9NLRiclwzstMgQgy9piAuG0syl9KQlw2rOrEV5b+xkmo/Dax9MZa3pdWAWbS71CSa
	U9QWk9aDViG3msOYdplHj1VEsNf9fNA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-_M1iKQglNqO1MbGQHPXwtQ-1; Wed,
 08 Apr 2026 11:42:36 -0400
X-MC-Unique: _M1iKQglNqO1MbGQHPXwtQ-1
X-Mimecast-MFC-AGG-ID: _M1iKQglNqO1MbGQHPXwtQ_1775662954
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ED2C180059C;
	Wed,  8 Apr 2026 15:42:34 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A3871955D6B;
	Wed,  8 Apr 2026 15:42:33 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 15/27] KVM: VMX: enable use of MBEC
Date: Wed,  8 Apr 2026 11:42:05 -0400
Message-ID: <20260408154217.458420-16-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If available, set SECONDARY_EXEC_MODE_BASED_EPT_EXEC in the secondary
execution controls and configure XS and XU separately (even if they
are always used together).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h      |  3 +++
 arch/x86/kvm/mmu.h              |  7 ++++++-
 arch/x86/kvm/mmu/spte.c         |  6 +++---
 arch/x86/kvm/mmu/spte.h         |  5 +++--
 arch/x86/kvm/vmx/capabilities.h |  7 +++++++
 arch/x86/kvm/vmx/common.h       | 10 +++++-----
 arch/x86/kvm/vmx/main.c         |  9 +++++++++
 arch/x86/kvm/vmx/nested.c       |  1 +
 arch/x86/kvm/vmx/vmx.c          | 16 +++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/vmx/x86_ops.h      |  1 +
 11 files changed, 54 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 59e3b095a315..2b449a3948d3 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -608,9 +608,12 @@ enum vm_entry_failure_code {
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
index d8c13e43c2d7..d15f908d048f 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -83,12 +83,17 @@ static inline gfn_t kvm_mmu_max_gfn(void)
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
index 779ee44893b0..6da5c73d1004 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -497,7 +497,7 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_set_me_spte_mask);
 
-void kvm_mmu_set_ept_masks(bool has_ad_bits)
+void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec)
 {
 	kvm_ad_enabled		= has_ad_bits;
 
@@ -506,10 +506,10 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
 	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
-	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xu_mask		= has_mbec ? VMX_EPT_USER_EXECUTABLE_MASK : VMX_EPT_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
-	shadow_acc_track_mask	= VMX_EPT_RWX_MASK;
+	shadow_acc_track_mask	= VMX_EPT_RWX_MASK | shadow_xu_mask;
 	shadow_host_writable_mask = EPT_SPTE_HOST_WRITABLE;
 	shadow_mmu_writable_mask  = EPT_SPTE_MMU_WRITABLE;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 0ed690f78e17..f5261d993eac 100644
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
@@ -65,7 +65,8 @@ static_assert(SPTE_TDP_AD_ENABLED == 0);
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
index 609477f190e8..83d68028d414 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -15,6 +15,7 @@ extern bool __read_mostly enable_ept;
 extern bool __read_mostly enable_unrestricted_guest;
 extern bool __read_mostly enable_ept_ad_bits;
 extern bool __read_mostly enable_pml;
+extern bool __read_mostly enable_mbec;
 extern int __read_mostly pt_mode;
 
 #define PT_MODE_SYSTEM		0
@@ -406,4 +407,10 @@ static inline bool cpu_has_notify_vmexit(void)
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
index 1afbf272efae..40fa72f31fc7 100644
--- a/arch/x86/kvm/vmx/common.h
+++ b/arch/x86/kvm/vmx/common.h
@@ -91,15 +91,15 @@ static inline int __vmx_handle_ept_violation(struct kvm_vcpu *vcpu, gpa_t gpa,
 	/* Is it a fetch fault? */
 	error_code |= (exit_qualification & EPT_VIOLATION_ACC_INSTR)
 		      ? PFERR_FETCH_MASK : 0;
-	/*
-	 * ept page table entry is present?
-	 * note: unconditionally clear USER_EXEC until mode-based
-	 * execute control is implemented
-	 */
+	/* ept page table entry is present?  */
 	error_code |= (exit_qualification &
 		       (EPT_VIOLATION_PROT_MASK & ~EPT_VIOLATION_PROT_USER_EXEC))
 		      ? PFERR_PRESENT_MASK : 0;
 
+	if (mmu_has_mbec(vcpu->arch.mmu))
+		error_code |= (exit_qualification & EPT_VIOLATION_PROT_USER_EXEC)
+			      ? PFERR_PRESENT_MASK : 0;
+
 	if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID)
 		error_code |= (exit_qualification & EPT_VIOLATION_GVA_TRANSLATED) ?
 			      PFERR_GUEST_FINAL_MASK : PFERR_GUEST_PAGE_MASK;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index a46ccd670785..c0dd506bed64 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
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
@@ -961,6 +969,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_tss_addr = vt_op(set_tss_addr),
 	.set_identity_map_addr = vt_op(set_identity_map_addr),
 	.get_mt_mask = vmx_get_mt_mask,
+	.tdp_has_smep = vt_op(tdp_has_smep),
 
 	.get_exit_info = vt_op(get_exit_info),
 	.get_entry_info = vt_op(get_entry_info),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index e4cb317807ab..cdc35a2728d9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2440,6 +2440,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 				  SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
 				  SECONDARY_EXEC_APIC_REGISTER_VIRT |
 				  SECONDARY_EXEC_ENABLE_VMFUNC |
+				  SECONDARY_EXEC_MODE_BASED_EPT_EXEC |
 				  SECONDARY_EXEC_DESC);
 
 		if (nested_cpu_has(vmcs12,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e27868fa4eb7..3905bc85a46c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -113,6 +113,9 @@ module_param(emulate_invalid_guest_state, bool, 0444);
 static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
+bool __read_mostly enable_mbec = 1;
+module_param_named(mbec, enable_mbec, bool, 0444);
+
 module_param(enable_apicv, bool, 0444);
 module_param(enable_ipiv, bool, 0444);
 
@@ -2809,6 +2812,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 			return -EIO;
 
 		vmx_cap->ept = 0;
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;
 	}
 	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
@@ -4844,6 +4848,9 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	 */
 	exec_control &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
 
+	if (!enable_mbec)
+		exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+
 	/* SECONDARY_EXEC_DESC is enabled/disabled on writes to CR4.UMIP,
 	 * in vmx_set_cr4.  */
 	exec_control &= ~SECONDARY_EXEC_DESC;
@@ -7932,6 +7939,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
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
@@ -8779,6 +8791,8 @@ __init int vmx_hardware_setup(void)
 		ple_window_shrink = 0;
 	}
 
+	if (!cpu_has_ept_mbec())
+		enable_mbec = 0;
 	if (!cpu_has_vmx_apicv())
 		enable_apicv = 0;
 	if (!enable_apicv)
@@ -8798,7 +8812,7 @@ __init int vmx_hardware_setup(void)
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	if (enable_ept)
-		kvm_mmu_set_ept_masks(enable_ept_ad_bits);
+		kvm_mmu_set_ept_masks(enable_ept_ad_bits, enable_mbec);
 	else
 		vt_x86_ops.get_mt_mask = NULL;
 
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 70bfe81dea54..594717e619d9 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -570,6 +570,7 @@ static inline u8 vmx_get_rvi(void)
 	 SECONDARY_EXEC_ENABLE_VMFUNC |					\
 	 SECONDARY_EXEC_BUS_LOCK_DETECTION |				\
 	 SECONDARY_EXEC_NOTIFY_VM_EXITING |				\
+	 SECONDARY_EXEC_MODE_BASED_EPT_EXEC |				\
 	 SECONDARY_EXEC_ENCLS_EXITING |					\
 	 SECONDARY_EXEC_EPT_VIOLATION_VE)
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index d09abeac2b56..69cf276be88e 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -103,6 +103,7 @@ void vmx_load_eoi_exitmap(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr);
 int vmx_set_identity_map_addr(struct kvm *kvm, u64 ident_addr);
 u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
+bool vmx_tdp_has_smep(struct kvm *kvm);
 
 void vmx_get_exit_info(struct kvm_vcpu *vcpu, u32 *reason,
 		       u64 *info1, u64 *info2, u32 *intr_info, u32 *error_code);
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3BD421A03
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549087; cv=none; b=knkG2pESRT5LhLpY48tjTSp69aTljEYGRsZid+qh6iSe22mcLChKzOjgulBlJgpyw+hshPYoYII3okN5wQwsfkZAakwssvbrHrdE3R9qfut61DkARsOChKE9W7mkpFXO3dWZ+fwGqRTcXCIpo6hGt2zLrS1i7goUhky5dnYbxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549087; c=relaxed/simple;
	bh=rmmDTWNI2csLB7Fsm+M8YXbjAe4qJjlzII/1MO7+SpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/qCwgPaE66Tsb+8D5NbujJAwxY/nMmbsBaacBXNvZ9s80nuCAO3f7Z8GRQK+ckQR4Owx2usiMcratIJVfhAxBkaY9CRnPx6b3lw2lWW7Y8tp4bXgED1cAxAI/E0Ii9cEPfiu8S8H9c731HceQwLp+JWYX23t5tIY8V/T9ssHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRv+SuS+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ql+yIMOK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRv+SuS+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ql+yIMOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774549080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vn07vXd3BZeS5TPNHyl5bqg59EBGf9mb+7OUrd5QUvI=;
	b=dRv+SuS+Ji/Vw3d0lL9HWJi5beB1Yh8NPMGaDk0w0bsHH2UpzkBWXjaTtHhXRCu1M4ARaR
	HZ7sU/5hgwTIH7tSc1OidAbyuT33Z2pARIJLOL38burLawCsYsA35roU5A9j+uCm4PM/5m
	tXgNgsLhKxKiMkRtIsqfks7PCFkvS4Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-gjOtRxlANbKTka284hIK7Q-1; Thu, 26 Mar 2026 14:17:59 -0400
X-MC-Unique: gjOtRxlANbKTka284hIK7Q-1
X-Mimecast-MFC-AGG-ID: gjOtRxlANbKTka284hIK7Q_1774549078
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b86de58d9so1042464f8f.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774549078; x=1775153878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn07vXd3BZeS5TPNHyl5bqg59EBGf9mb+7OUrd5QUvI=;
        b=Ql+yIMOKOwc2KmIxXjBfu7cXcThjtBrIjSYKCIN5k9OLaJZvw3wSuqtjHjVPBF3Ilt
         RTK88taf1/lEmar035n+MJBxPcTqckV2VOnWp4ulp9hyHW0AXsETnrvtDIV33UgM01ZF
         51Oc/m6LoaHEhVDNbLL2gfAloGbPWM9nKEEJ8uw77wn80liJSg5JxCPP7NkNT3gPzSMr
         Mkeiuzhb36HqP0qVTsfZGIOC6QFWqiSqZOqV5OjQiA7KQ+ianvaR+hLsc7S7QFdLglkT
         HurEXD09IeHtFCgZrrzhcMqqsn5rCZ0mIVkY4+Ms+zVJHUoWNnrHwv8G1M3BU3WzD//d
         kAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774549078; x=1775153878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vn07vXd3BZeS5TPNHyl5bqg59EBGf9mb+7OUrd5QUvI=;
        b=mGAM3T+1e1nEVCGKvDB6Mjf579PDgbmbH5qso+J6QD7INKdf2zTFlu7RgmyRhMnGtS
         NWOUNb3Q3eqL46rLGkRGdD87BNLWNu0JdNALXj4B2HaBgsWKU5V7/eniwV8hODJqeCsk
         GhO1oog9sY05Oaex2wHSo/jIxAgRzoy+33+BedCdf/pSsv6pQXZ5rVyHp1z9jLdk/+qd
         YH4f5s8yGVQtt5zcVHxnu88GPNGrxD4pGs7jRc4TQSbW1cvfmpLZyNsCEOD73ZvVrUT5
         U1TE0zd7wDIo+mOPHAmWmfusLsQp+wIptrjYl2+zA2A4AC1Lo9Dk9etP/0prwAi75YUR
         6duA==
X-Forwarded-Encrypted: i=1; AJvYcCWvkql2etQhN/hvxgXbFGfm9IFlHXKjXZ+MiQ4n3CzT+267yvNm3yXfgB0gAsHmgMMScjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRRuJBLIOUwDIDX8QKlMaN0I4RSqisFJBKMpp7Lv5I57+lmcp
	74sHqZw4FFGYxcfJ8upxTSdiBeoBV/wc1HiVoP3jw8Yi5Uc+z31kZ552D1qRGZPRZQgx1R4J5Is
	ieCg4ZxTedk6ewuGH0eVVwDBdfl7yELHzwT899Ypd6+L5JT6zaqS79zdiHLPWyQ==
X-Gm-Gg: ATEYQzzWP5Aa41+qBhqqgjalv7IV5ZuWdwfc23BnNp8OeIPuBQ3D9A57h/QpgdwGsqE
	4obkaemB4bK0TkR84w9HfF0/2pugoHbh6epL0iE39MHhzI8rGDIp1PcxRDo/7IUCt6uGIrb4XtB
	sYB2cS3KUbJukg7naA4GObznFUXbB4ov1KracFKRrMdkIX1ANZ/8E8OE8l+3D3bcDhTbxHuqU+T
	1LDaOeKCtIaSFVtV8NuWMK1IbcMKOR6pcvz3K05KZd2VpxNGikkVCsfGxJJmA3EBG9Ruuy0ru5T
	JHtkf0tw221bMaFRhzYD/4ghMNgKCGc7QCR2OkIFhpkVSU/0rsstQFzTFmta5ozYTXJ+Ww8UPx6
	dOyUhOVaU5FWg8MYIxZj+1HSp9mQauCnDGmBzgwyS714Q99ERsgblkMwUioeOAwhN8S6Q34pd3n
	BhSuT5CyAnVNIABjksjDvp53R6
X-Received: by 2002:a05:600c:5296:b0:487:13d:4e77 with SMTP id 5b1f17b1804b1-48716067315mr130193485e9.27.1774549077656;
        Thu, 26 Mar 2026 11:17:57 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:487:13d:4e77 with SMTP id 5b1f17b1804b1-48716067315mr130192935e9.27.1774549077151;
        Thu, 26 Mar 2026 11:17:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be47a4sm65099425e9.0.2026.03.26.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:17:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 12/24] KVM: VMX: enable use of MBEC
Date: Thu, 26 Mar 2026 19:17:10 +0100
Message-ID: <20260326181723.218115-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326181723.218115-1-pbonzini@redhat.com>
References: <20260326181723.218115-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If available, set SECONDARY_EXEC_MODE_BASED_EPT_EXEC in the secondary
execution controls and configure XS and XU separately (even if they
are always used together).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h      |  3 +++
 arch/x86/kvm/mmu.h              |  7 ++++++-
 arch/x86/kvm/mmu/spte.c         |  4 ++--
 arch/x86/kvm/mmu/spte.h         |  5 +++--
 arch/x86/kvm/vmx/capabilities.h |  6 ++++++
 arch/x86/kvm/vmx/common.h       | 10 +++++-----
 arch/x86/kvm/vmx/main.c         |  9 +++++++++
 arch/x86/kvm/vmx/nested.c       |  1 +
 arch/x86/kvm/vmx/vmx.c          | 16 +++++++++++++++-
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/vmx/x86_ops.h      |  1 +
 11 files changed, 52 insertions(+), 11 deletions(-)

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
index 23f37535c0ce..678ce021991f 100644
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
index fc7eb73476f6..800312e46d0a 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -500,7 +500,7 @@ void kvm_mmu_set_me_spte_mask(u64 me_value, u64 me_mask)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_set_me_spte_mask);
 
-void kvm_mmu_set_ept_masks(bool has_ad_bits)
+void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec)
 {
 	kvm_ad_enabled		= has_ad_bits;
 
@@ -509,7 +509,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	shadow_dirty_mask	= VMX_EPT_DIRTY_BIT;
 	shadow_nx_mask		= 0ull;
 	shadow_xs_mask		= VMX_EPT_EXECUTABLE_MASK;
-	shadow_xu_mask		= VMX_EPT_EXECUTABLE_MASK;
+	shadow_xu_mask		= has_mbec ? VMX_EPT_USER_EXECUTABLE_MASK : VMX_EPT_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
 
 	shadow_acc_track_mask	= VMX_EPT_RWX_MASK | VMX_EPT_USER_EXECUTABLE_MASK;
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 204f16aaf4e5..6c514194a513 100644
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
index 609477f190e8..90c0bb4b7216 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -406,4 +406,10 @@ static inline bool cpu_has_notify_vmexit(void)
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
index 937aeb474af7..adeb5a29169f 100644
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
index e27868fa4eb7..0c25c6865f91 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -113,6 +113,9 @@ module_param(emulate_invalid_guest_state, bool, 0444);
 static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
+static bool __read_mostly enable_mbec = 1;
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
2.53.0


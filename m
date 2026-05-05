Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1D4C0411
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010791; cv=none; b=FVuorDdaBaGP3IUA9/UovQ0BPrFoo3TNIbOhR/xtxoSxcj8PX8r2YxEjuoSMYQ07xapTFkiaL386WNrr9fk1f8Hn5Fv//kufXRYsuSyvOpjJSPJHqW77vjET/Ge+AUKwaMfL+PIAPt6S8vQDgufDznTio9pJz+MEes0PWvR5UE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010791; c=relaxed/simple;
	bh=TbWOKH9rsA2QopJiYcgdcC9I173I1FHyrxHi/xCJ3OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gul7ddWpAfcnWTumYE6Arhg8LQ4bl32/sCe/P3TUI1KDCWAxgoLDdp29K3HG5JTA9Og/exsNTSPeuvkzPHPqmJ/zOeghXG5rCU6Iry3pDnq+/iXUlhqBFo+pjwjkoBOKrY7k76x+TYMLDOFo/LXJrN5aoHWWY6EuH4uZus4FszY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJAeoMG5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K6F4c5IP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJAeoMG5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6F4c5IP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbCyP56X600gyFpe4+hPwzpQtiHTgestu4OLkKSb6HU=;
	b=TJAeoMG5S4n+01QMjZzdebDovv2Ci76B3adZdbgub0CBh2Xqh9zABqpndbiA/RvXzfUQ2P
	knagi/fYwyMG7smUDXahbXZLOhhGbSlP1/hUBbrtSuBOCdwWGmBVTWwcZGQGqdhv+kYp3a
	1CCMjC79qpFTgcqryw/Vi1M9GVIv6gQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-8XHo87YMOIilM-pNsvZ0ng-1; Tue, 05 May 2026 15:53:07 -0400
X-MC-Unique: 8XHo87YMOIilM-pNsvZ0ng-1
X-Mimecast-MFC-AGG-ID: 8XHo87YMOIilM-pNsvZ0ng_1778010786
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43ff19e54beso3891343f8f.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010786; x=1778615586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbCyP56X600gyFpe4+hPwzpQtiHTgestu4OLkKSb6HU=;
        b=K6F4c5IPGnW5pVrFDOzLa/7I+XAPst8/DZq8uv6lk59RENJgv9MWa0OJIuyNAcHa/d
         MzvtZoT3OLpcWQYhwnFs9KUhrwI9Xbqs1NJnpwGdxu8CtetrqAPbGN8p6zJ6wwiiiNCX
         rjseueIjUgIGdRzXTK42opK5jlQGlN9v1CDFt3OR98ii6ubzqbTyTPDtvB0iv1SfMdem
         spz1jsebtQJCunV6MjfsjB5kujNc38rG7xEKAV86j8JkcenZGLjGS7qd2eSo0kr4GMCa
         iAuey3HXyBStuL+FmTJxfrmr/lwmGd4G2mbq2hpI4trmH2yKqArG+pWRgv30Nz9tFl6u
         W70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010786; x=1778615586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbCyP56X600gyFpe4+hPwzpQtiHTgestu4OLkKSb6HU=;
        b=rIhK/Z9ZtO7GKlSY4ptobMhd95kqKf7rhaisyDaMkYq6NFxQwW8dByu7eMxpw+Qbty
         HMzs+GM6ohs/YO/LM5n1+TbQpgrSFDt6g87JeIln3WcY6Iuu+ecqhzhUijYjjpH46OHI
         wwQKfWDWo03BeDiYRxg5/nSruC0MBbF3TpQvYGB5282A9FawIjp9OcdWHFmiaDxthudV
         5dMGqR6kYNzHuYEij1N1wltJ65ybi8fJ9eFBj4PXWX03QDoUUdDtk/p871yz1mlyt3Uj
         TRSWpXQqijCT9uCulUGWFyMIJ2iX2DqbjmsPX40ys0qT2FBbwp9LFLcpmozTC0MJpf5V
         B6sg==
X-Forwarded-Encrypted: i=1; AFNElJ94stdab7KNAg/KP+ryWAVjp/UBGHyU/GuHkOvT/4ScOkSj7O6kN4/+g4D6t4lCHW2fZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFfwPNgZWsxkmYaAC6ylGj9dpna16syC7Z+ajokRolZw2py0/
	2FXWRjMABy0rydP/lqBR/IcIX2x6lUX/2ZOolwivUjKUR7G86OVsk1E1pzMFVYRZn6pHuGQVHul
	vavJb6avM1ULNFuFiO+jnM2X6GJsrVO1VeYwdG37UxnFBpp4yzs7IJw==
X-Gm-Gg: AeBDieupIoIbwK8oonFftPM5Gl5w6gedRoURbnsvrIb4pVRX07fSIwOS7blYFYxc+8n
	aAr/NIj6jg5rGgVqkxhhpPtMAca1JHv5ianGHwLrRWE9FSL0N8S7aMqP7XwDLclBO6yEz9hCwgj
	ig4QXQP/n1r9LoCJeGP6eiztuTIllxUZDdn2Cfj5lVpsEoRc7mtKUlFiqkRY8Fom4FqOXqmRPnh
	x4LvURKRpzAyO9l+mnx92943hhG5vwxpyiJg+GVWBSX1FXAot0MPZnQtagaH7Lvjt+M7P1C5CCe
	HuEVaFTbqUhdzpzJQYzxHPhsxqszsZFKF8UW2Mvbv/S2V2KGeCHS6ec9Npjs/Efav1xHedTS2jj
	GImlAyyNRU3OqZ6Lmj3oOgUOnG4sEk40ObJljQWOv+NYExt12pIUWYH3Htfg/IjlEO7cS89AFJa
	gUcAELmYrmtfnn1yOK2+T0y+uAuZpK3GTADH2ZqS4=
X-Received: by 2002:a05:6000:4203:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-4515b61b7f5mr833170f8f.13.1778010785870;
        Tue, 05 May 2026 12:53:05 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-4515b61b7f5mr833128f8f.13.1778010785393;
        Tue, 05 May 2026 12:53:05 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505558e213sm7082295f8f.25.2026.05.05.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 15/28] KVM: VMX: enable use of MBEC
Date: Tue,  5 May 2026 21:52:13 +0200
Message-ID: <20260505195226.563317-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If available, set SECONDARY_EXEC_MODE_BASED_EPT_EXEC in the secondary
execution controls.

The changes are limited because the MMU is designed to create the same
sPTEs independent of the MBEC setting.  On hosts lacking support for
MBEC, and in nested guests which cannot enable it as of this commit,
the XU bit is ignored by the processor.

Note that, as of this patch, MBEC is not available to L1 hypervisors
for their guests.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/vmx.h      |  3 +++
 arch/x86/kvm/mmu.h              |  5 +++++
 arch/x86/kvm/vmx/capabilities.h |  7 +++++++
 arch/x86/kvm/vmx/common.h       | 10 +++++-----
 arch/x86/kvm/vmx/main.c         |  9 +++++++++
 arch/x86/kvm/vmx/nested.c       |  1 +
 arch/x86/kvm/vmx/vmx.c          | 14 ++++++++++++++
 arch/x86/kvm/vmx/vmx.h          |  1 +
 arch/x86/kvm/vmx/x86_ops.h      |  1 +
 9 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 2b30b921b375..54aa5be50df9 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -619,9 +619,12 @@ enum vm_entry_failure_code {
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
index d8c13e43c2d7..23bc5b18efd0 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -83,6 +83,11 @@ static inline gfn_t kvm_mmu_max_gfn(void)
 	return (1ULL << (max_gpa_bits - PAGE_SHIFT)) - 1;
 }
 
+static inline bool mmu_has_mbec(struct kvm_mmu *mmu)
+{
+	return mmu->root_role.cr4_smep;
+}
+
 u8 kvm_mmu_get_max_tdp_level(void);
 
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 7e59eb0f41bb..07469d1cfe74 100644
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
index dbebddf648be..83d9921277ea 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -755,6 +755,14 @@ static int vt_set_identity_map_addr(struct kvm *kvm, u64 ident_addr)
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
@@ -966,6 +974,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_tss_addr = vt_op(set_tss_addr),
 	.set_identity_map_addr = vt_op(set_identity_map_addr),
 	.get_mt_mask = vmx_get_mt_mask,
+	.tdp_has_smep = vt_op(tdp_has_smep),
 
 	.get_exit_info = vt_op(get_exit_info),
 	.get_entry_info = vt_op(get_entry_info),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index cd1924c6e075..299d4ca60fb3 100644
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
index 337bbfecc021..f1d616f928a1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -114,6 +114,9 @@ module_param(emulate_invalid_guest_state, bool, 0444);
 static bool __read_mostly fasteoi = 1;
 module_param(fasteoi, bool, 0444);
 
+bool __read_mostly enable_mbec = 1;
+module_param_named(mbec, enable_mbec, bool, 0444);
+
 module_param(enable_apicv, bool, 0444);
 module_param(enable_ipiv, bool, 0444);
 
@@ -2773,6 +2776,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 			return -EIO;
 
 		vmx_cap->ept = 0;
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_EPT_VIOLATION_VE;
 	}
 	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
@@ -4735,6 +4739,9 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	 */
 	exec_control &= ~SECONDARY_EXEC_ENABLE_VMFUNC;
 
+	if (!enable_mbec)
+		exec_control &= ~SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
+
 	/* SECONDARY_EXEC_DESC is enabled/disabled on writes to CR4.UMIP,
 	 * in vmx_set_cr4.  */
 	exec_control &= ~SECONDARY_EXEC_DESC;
@@ -7823,6 +7830,11 @@ u8 vmx_get_mt_mask(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio)
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
@@ -8622,6 +8634,8 @@ __init int vmx_hardware_setup(void)
 
 	if (!cpu_has_vmx_ept_ad_bits() || !enable_ept)
 		enable_ept_ad_bits = 0;
+	if (!cpu_has_ept_mbec() || !enable_ept)
+		enable_mbec = 0;
 
 	if (!cpu_has_vmx_unrestricted_guest() || !enable_ept)
 		enable_unrestricted_guest = 0;
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index db84e8001da5..0a4e263c4095 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -567,6 +567,7 @@ static inline u8 vmx_get_rvi(void)
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
2.54.0


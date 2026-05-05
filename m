Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE04C77B5
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010802; cv=none; b=uNaL4SPz8OH9zLAkurGQ4Nxrh5YsKzsfJwk3VxRh05nC76SCSQGS5+rQOzTNlhJ+eGkBpaBN0st4/w/M9Z4RNTuf+tC5p5c0EHjMXFdi2V7+CJ0VYUhVjexQ5e20lGy6xGw81JbyWICx2KnQNndJJn9Kg9F5S+Aquz2GGzLXpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010802; c=relaxed/simple;
	bh=hlFbZLuDctOr5fRl9zPu6wXHpmzUeN74wXoDTN0J3eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzJvZJCa+xy7TMkvSrniwuHnnATtFcnP0iW8E73Dx/XfyZq417TX3MP7KwMQ1dYMTtLNXl8VkCzc27vTu/hvBlIkiRNUrCp8aJVy10tuJw+TeVZRHojZ1NbOvaHGU0ot/fe0ZPXtBXriUSF60yw2lx93JCdo5gCOwgoUz0Yn9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzVTyR6Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GgolTBct; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzVTyR6Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GgolTBct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otDQpVDmvckURKbD5WKZEO96KuUH2bQ7UgJHC9+Btxk=;
	b=MzVTyR6Y+L9ZxJJDx6mfGNrHW/Xd8E2fW8bvM13gdxnM5mXbWWhCvdyc8nrBwS7MQQVqnM
	JkXTHXNIRt6A/eI+/N4RHWBGvTAP7kz8/efMsWPIrm5J7rOSYL4baWt6cjhJ53O1MUHGPo
	GNLG+ymI15grlewb7SBEY1DNACW+kS8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-QAsy-kjZM1uJZBl_ZTh4Qg-1; Tue, 05 May 2026 15:53:16 -0400
X-MC-Unique: QAsy-kjZM1uJZBl_ZTh4Qg-1
X-Mimecast-MFC-AGG-ID: QAsy-kjZM1uJZBl_ZTh4Qg_1778010795
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48e51dc35a3so1319155e9.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010795; x=1778615595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otDQpVDmvckURKbD5WKZEO96KuUH2bQ7UgJHC9+Btxk=;
        b=GgolTBctObFHFGxFEwVyCZmVy0A7b2S2fFV2mg3mhkbW3ruJQrbSztot6pqS9+e4g5
         7LSrH5ElJefiAYy99kjsY3wnal1PCJvlNVbNV8NDhr4Pk3gZumu7p8hOqekEzDcpUIyy
         TSCHmLfr6Hh17V0g2fgNiN2x094QBBM2d5FQz2Iqe64ZwtiI7vHM80/GXzEeAK0+ct8m
         VuImQx+cPJBwxZDZuboxfQ7OLT/miF56E9aCCM/12E6Tb7y6FP8MpKjJIm2Zs7cJr5l/
         /FRUpORKS0UPLyEHACYBPEmEvViV21J8Dg3lYeu/gDT/iRtgy7Wqq51j5sf5+gPaE/FY
         nlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010795; x=1778615595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otDQpVDmvckURKbD5WKZEO96KuUH2bQ7UgJHC9+Btxk=;
        b=q+2rECwdcHlUfdmlSK9AGV3bvkdAiqWyVHYJFcGYF6wV2w8G/JoYI9Ocrmn/t/VrHZ
         3frXQlbEpd9b9AwmS1VYmSlSeJvcYh4AqFDM3/Tzfm9pgf1bjk17BGCHKeNua3la2osE
         jzDvVG+a4feM50p00+WBPoiWma6/CmiIla49PbcsKBZZVTqE1NK5vQE+FKjHW+Tq1Y1z
         qWLtL/p1mIuI5EFgen7I5DpI+cFmgzsu5L0sFj60BGQu+tkDT1yFrsfSHvUu8FPOMv/r
         i561NAiq2u1ouGzs+E21/2PwuitAANfjqmm9z07Ztvimkd/2KaAmT0QnBc6uvcdOGY98
         Z6+w==
X-Forwarded-Encrypted: i=1; AFNElJ+q1bAKffUVVOP1Dok3Q3jVkYrxe372VkQmVKQnDzVr6hRPMDYKDkBvslL52fruHkvuMrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8lFFX/lNJrJzZEev/fpsg86l/thbCEPP1ZyJb5WaV5bMaXr7
	9bd2oPD+EgeT+UH1ErTcpWDryiPd3vO+DVzykVwIkHYAhEJPPGREWuAbUDDYhVNKjwShUM7fOup
	RIytA9rW6p6XApz/fQtQ5NVws7Whi0C4l9qPXTJdh1OxFHheRb2jo7g==
X-Gm-Gg: AeBDieuhP8R7c11K7XTqS40ypF8Ed/g37vq6EvhQUIkZTSlKBOlnwBaUm4u6/MRmYNC
	pdOwYTDRlGShmP/6Bs4Ye7CY2KtoQ89UywjnKgEUuFPnr/ISfVL3dc7yHqTYXNV8Wd6epg453HN
	7GzeCHdW0+prIdjntKbY6StJWvrt+L97D4LJ2uDrtCZhHqXzVwizFCaG5OgyJt5kncZoFjRkQ2S
	vhqdw/7n5v9+3M6QlC5zyxQwkPGNVSvAVvGknxv6tvAwCl+LJlJvOskIVZ97YPx0O4ux0W/8K+F
	ohT5AJ4Pq7ZqpVWiNwuYdFWYsE6u0w3JbrqYGh0pfAV28U+LyCauMhOFH/LFVATHIUmsoJpG0cz
	T1pXHREaxeihkOFMikeVRvVKHkWg7DdTBxmNi88g4iKOigltpJ5mGLXjYc3jfRFO6wW8RmCW8SV
	Rh37BRRMrrxC7GtBf6x8TQZONHASh9lzn+RJH2WxM=
X-Received: by 2002:a05:600c:2d16:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48e52be1069mr574815e9.17.1778010795299;
        Tue, 05 May 2026 12:53:15 -0700 (PDT)
X-Received: by 2002:a05:600c:2d16:b0:48a:72ab:f88c with SMTP id 5b1f17b1804b1-48e52be1069mr574525e9.17.1778010794893;
        Tue, 05 May 2026 12:53:14 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a824f9f0dsm405542435e9.15.2026.05.05.12.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 19/28] KVM: nVMX: advertise MBEC to nested guests
Date: Tue,  5 May 2026 21:52:17 +0200
Message-ID: <20260505195226.563317-20-pbonzini@redhat.com>
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

From: Jon Kohler <jon@nutanix.com>

Advertise SECONDARY_EXEC_MODE_BASED_EPT_EXEC (MBEC) to userspace, which
allows userspace to expose and advertise the feature to the guest.

When MBEC is enabled by the guest, it is passed to the MMU via cr4_smep,
and to the processor by the merging of vmcs12->secondary_vm_exec_control
into the VMCS02's secondary VM execution controls.

Signed-off-by: Jon Kohler <jon@nutanix.com>
Message-ID: <20251223054806.1611168-9-jon@nutanix.com>
Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu.h        |  2 +-
 arch/x86/kvm/mmu/mmu.c    |  7 ++++---
 arch/x86/kvm/mmu/spte.c   | 10 ++++++----
 arch/x86/kvm/vmx/nested.c | 11 +++++++++++
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 23bc5b18efd0..e1e3869f568b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -100,7 +100,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
-			     gpa_t new_eptp);
+			     bool mbec, gpa_t new_eptp);
 bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5b68f18b220..ededc26c6675 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5959,7 +5959,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_npt_mmu);
 
 static union kvm_cpu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
-				   bool execonly, u8 level)
+				   bool execonly, u8 level, bool mbec)
 {
 	union kvm_cpu_role role = {0};
 
@@ -5969,6 +5969,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	 */
 	WARN_ON_ONCE(is_smm(vcpu));
 	role.base.level = level;
+	role.base.cr4_smep = mbec;
 	role.base.has_4_byte_gpte = false;
 	role.base.direct = false;
 	role.base.ad_disabled = !accessed_dirty;
@@ -5984,13 +5985,13 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
-			     gpa_t new_eptp)
+			     bool mbec, gpa_t new_eptp)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	u8 level = vmx_eptp_page_walk_level(new_eptp);
 	union kvm_cpu_role new_mode =
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
-						   execonly, level);
+						   execonly, level, mbec);
 
 	if (new_mode.as_u64 != context->cpu_role.as_u64) {
 		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index f41573b0ccfa..d2f5f7dd8fe1 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -517,10 +517,12 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits)
 	 * host's MBEC setting does not matter.  On hardware without MBEC
 	 * the XU bit is reserved-as-ignored, and setting it does no harm.
 	 *
-	 * For nested EPT MBEC is not supported, but bit 10 of the gPTE has
-	 * no effect because (a) is_present_gpte() does not treat it as a
-	 * present bit, and (b) permission_fault() uses an mmu->permissions[]
-	 * array that effectively ignores ACC_USER_EXEC_MASK.
+	 * For nested EPT, when MBEC is disabled by L1, correctness relies
+	 * on (a) ignoring bit 10 of the gPTE in is_present_gpte(), rather
+	 * than treating it as a present bit, and (b) permission_fault()
+	 * using an mmu->permissions[] array that effectively ignores
+	 * ACC_USER_EXEC_MASK.  Bit 10 of the gPTE does end up mirrored
+	 * in the sPTEs but is ignored because L2 runs with MBEC disabled.
 	 */
 	shadow_xu_mask		= VMX_EPT_USER_EXECUTABLE_MASK;
 	shadow_present_mask	= VMX_EPT_SUPPRESS_VE_BIT;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 84f5c25a1f12..bc1046f32ebc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -469,6 +469,13 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
 	vmcs12->guest_physical_address = fault->address;
 }
 
+static inline bool nested_ept_mbec_enabled(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+
+	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_MODE_BASED_EPT_EXEC);
+}
+
 static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -477,6 +484,7 @@ static void nested_ept_new_eptp(struct kvm_vcpu *vcpu)
 
 	kvm_init_shadow_ept_mmu(vcpu, execonly, ept_lpage_level,
 				nested_ept_ad_enabled(vcpu),
+				nested_ept_mbec_enabled(vcpu),
 				nested_ept_get_eptp(vcpu));
 }
 
@@ -7257,6 +7265,9 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 			msrs->ept_caps |= VMX_EPT_AD_BIT;
 		}
 
+		if (enable_mbec)
+			msrs->secondary_ctls_high |=
+				SECONDARY_EXEC_MODE_BASED_EPT_EXEC;
 		/*
 		 * Advertise EPTP switching irrespective of hardware support,
 		 * KVM emulates it in software so long as VMFUNC is supported.
-- 
2.54.0


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03B14C955D
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010814; cv=none; b=oba3r1a0C9yP7UmtGtPAbciyQY5MznTA+TZLWzU5BknZ/NLVpaZEhaUYphv0+PMMAtZz6K7NbMK9f8H3odnR2XCIsejEqfhltNMlvZEOaNAu1DSM60853ks46pKwpyd9vEQa5+W4JweAUNsL6TDxU6cj6Gu18oeQNDRqTbuaQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010814; c=relaxed/simple;
	bh=687k/EDplpKqFKa/kv5Vp5Y4JVat2Nx14m/BSP+93uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgLxIGXajeisdCY5WD4Cu2TeKXt2xj6DiUntxA0vdwpwKTo2W67vmdxDFpc+5qPH5o3HSu5QXWn8xsqYi9DOA3jjr5fdzz889m90udVmV9cxGJkMCf5S0a2TpMpHK/jFHD0XhlIbHMiebCfkRlnwHuZdf3r9oyjjNDiS5TOJBr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0K9ehdk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxtyzOC1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0K9ehdk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxtyzOC1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ho2jr9zKlR+QkoP4McsUsUCSq4YWgUGFwkRFtm4gWTk=;
	b=I0K9ehdkQtc5wpNoxogh03GsuvlwTdCCYm+y6zNnO0Qcr25fxcOsRcWKWc3VwB4Kg05qpu
	T5ZUW7vQnOz6RGAs5sA0c50S833N87PkQ4kb0KNtbohMvwlwwSmj9GUOzbshs/f8HT02O0
	c+cS8eRJOemZ2zx2jD9zumI6ivGgSE8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-z8tLAz_FMfyCULKhbuVTPw-1; Tue, 05 May 2026 15:53:30 -0400
X-MC-Unique: z8tLAz_FMfyCULKhbuVTPw-1
X-Mimecast-MFC-AGG-ID: z8tLAz_FMfyCULKhbuVTPw_1778010810
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so29665275e9.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010808; x=1778615608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho2jr9zKlR+QkoP4McsUsUCSq4YWgUGFwkRFtm4gWTk=;
        b=gxtyzOC1S4r23LAqFsNScDAJBw2Wn+CWScSxLdULnNZZi7RIB5igGHjxfZUsIJnEMd
         /e3pbU11vqFMXyVmtbjxbDcuP3sBjpTVylVwnslYhFTqe03XwObXxwWC32rdFt92JEln
         yzfuz/g0fmD3P39k7PvCQwep1HAdQlgmg45gPEIc6TMq40s05ZEAmRrEeSTjC9okAmWK
         mifsNGaVHuHn29z0Tvw3vkkVvvkYJedEWdZakMYM4cjaEmxfIkHSvom9KcZVRyK1IFMy
         fsdbGZEt3g8ISp9liijcOGJUy3vIepGAeU2oqGYxsjCHL20aE9C9NEIgq1QyASVhUMxl
         kHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010808; x=1778615608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ho2jr9zKlR+QkoP4McsUsUCSq4YWgUGFwkRFtm4gWTk=;
        b=m7w0/k65jLnY9TLXwTkmGN5Do/oKwunucpjxjctlrJI3ehKxvr83ETyBGtmMxuTdfb
         FLP3RGQuCo1ZGo+sJfGzWNj1iPxbB+qzEHypURMePnsH2U28UrhBLuxCpR/Qjc3Fb3Jr
         ZtIINFrF7zCNFCv6+G/TeYx2sPvfE0tJZzc4Jse/s3ShYwdar3GA0JYFG10Tgmyf8RqI
         0Ba4WkRKN+l8NdXShahbBgFqw13UXFP0gmFjCznV6ES/C9h2+U9ENj9A3os2i5GzBFzW
         uLfmAhQfll2OjvN7QC52zb7xnmNwNFWWsD7DDcMqSBDCoe3HIfazy0QxTt1N4IIlTPFl
         NqAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rG2/1sGHbwHW6SNOBVu/lpe1J/2S8syI4LzZ29Qb0jGBVHw1CadTOqMgSO1mbNz4PeHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9MjYQLpOG7XvUHaTdmTYfgH/8t9YNx28XGOGZANsruXcaazg
	KZIj7UkZfAsqf1JIlNWV3U+KD1Qi4NrmalyQ0RpNCA3UOrQP5aqN+6hEbzLzdK5c8WcseEu5hRD
	ByiIWvMvhhqc0GbPk37Zzz4qXBJdkZ/wQvUTRpbyuPNUSDhczBuOQ92X+E2Yvfw==
X-Gm-Gg: AeBDieu1yoXbfHTN182E55Gm1tG98gO+cNtwVDMydAsdbNg0yOKljBXMflHRQWTHIlj
	iCDHtWu8cNVhx+NnnzSHAC3c9/z73XuLTZBJwck7xq2yMEcYI5D/DjcWeDPvdDpdJ3/V6rDG8PN
	9gzBirfL8A7Cal/Yz/spQgnUV4WmQh43D1n/ocxLqfMW0OEgvxioitYre8uAA3xFXKftFRW4hCf
	RVFpuVw+ccWf/zHPlt9CAGd3pndVfiMWFHU6zURTDgVNEouuIQaFke0EC59PzMxt6GquLGxFGT/
	yLrEigf+EwH8Zi2QSQHRl/fzoH2gEKdkhfkuAxkYA7Lgmal/ESLzE7IlHafo7WMLp95XX8q2XcU
	UC0uglSfSYcbRwrcEw3wPS+DSK/9Cl0jckLqqwe91SfMmqENKOU3hOWch+ZrF6mBvlgQcx/7LAv
	M49E6FPPlTXWIAe7XAGpxqQKhBYHgsH/qEFQJt8/s=
X-Received: by 2002:a05:600c:4f53:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e51f4456cmr9974165e9.20.1778010808324;
        Tue, 05 May 2026 12:53:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4f53:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48e51f4456cmr9973765e9.20.1778010807901;
        Tue, 05 May 2026 12:53:27 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5288f929sm594605e9.18.2026.05.05.12.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:53:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 25/28] KVM: x86/mmu: add support for GMET to NPT page table walks
Date: Tue,  5 May 2026 21:52:23 +0200
Message-ID: <20260505195226.563317-26-pbonzini@redhat.com>
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

GMET allows page table entries to be created with U=0 in NPT.
However, when GMET=1 U=0 only affects execution, not reads or
writes.  Ignore user faults on non-fetch accesses for NPT GMET.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu.h              |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 18 ++++++++++++------
 arch/x86/kvm/svm/nested.c       | 10 +++++++---
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7dde4ca87752..1da3d5c59e15 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -370,6 +370,8 @@ union kvm_mmu_page_role {
 		 * cr4_smep is also set for EPT MBEC.  Because it affects
 		 * which pages are considered non-present (bit 10 additionally
 		 * must be zero if MBEC is on) it has to be in the base role.
+		 * It also has to be in the base role for AMD GMET because
+		 * kernel-executable pages need to have U=0 with GMET enabled.
 		 */
 		unsigned cr4_smep:1;
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 1b354e1f2d81..ddf4e467c071 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -97,7 +97,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
-			     u64 efer, gpa_t nested_cr3);
+			     u64 efer, gpa_t nested_cr3, u64 misc_ctl);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5a796ae8c396..a283b5078c61 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -55,6 +55,7 @@
 #include <asm/io.h>
 #include <asm/set_memory.h>
 #include <asm/spec-ctrl.h>
+#include <asm/svm.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
@@ -5572,7 +5573,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
+static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 {
 	unsigned index;
 
@@ -5633,7 +5634,12 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 			/* Faults from kernel mode accesses to user pages */
 			u16 kf = (pfec & PFERR_USER_MASK) ? 0 : u;
 
-			uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
+			/*
+			 * For NPT GMET, U=0 does not affect reads and writes.  Fetches
+			 * are handled below via cr4_smep.
+			 */
+			if (!(tdp && cr4_smep))
+				uf = (pfec & PFERR_USER_MASK) ? (u16)~u : 0;
 
 			if (efer_nx)
 				ff = (pfec & PFERR_FETCH_MASK) ? (u16)~x : 0;
@@ -5744,7 +5750,7 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
-	update_permission_bitmask(mmu, false);
+	update_permission_bitmask(mmu, mmu == &vcpu->arch.guest_mmu, false);
 	update_pkru_bitmask(mmu);
 }
 
@@ -5940,7 +5946,7 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 }
 
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
-			     u64 efer, gpa_t nested_cr3)
+			     u64 efer, gpa_t nested_cr3, u64 misc_ctl)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
@@ -5953,7 +5959,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
-	cpu_role.base.cr4_smep = false;
+	cpu_role.base.cr4_smep = (misc_ctl & SVM_MISC_ENABLE_GMET) != 0;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
@@ -6011,7 +6017,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(context, true);
+		update_permission_bitmask(context, true, true);
 		context->pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a1cffd274000..7adfa7da210d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -95,7 +95,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	 */
 	kvm_init_shadow_npt_mmu(vcpu, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
-				svm->nested.ctl.nested_cr3);
+				svm->nested.ctl.nested_cr3,
+				svm->nested.ctl.misc_ctl);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
@@ -2076,12 +2077,15 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	BUG_ON(!mmu_is_nested(vcpu));
 
-	/* NPT walks are always user-walks */
-	access |= PFERR_USER_MASK;
+	/* Non-GMET walks are always user-walks */
+	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
+		access |= PFERR_USER_MASK;
+
 	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
 }
 
-- 
2.54.0


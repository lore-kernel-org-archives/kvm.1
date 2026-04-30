Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63D643DA5A
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561698; cv=none; b=Jj76B4uyQCBOTPNUkCoWugWN+kHcSMJ8RFUcG73WePhwDeYS2Wby1p0LnHGikoeYD0Fbxxl/WqNynQWDroblXbqX+GRJsK+/sMlBWjobWkzfoKH2iS+p4qo2Ddmpe+OcGdo1BY1eCLsNmz2k4wJ8XCK4wMNUp54MrtdDen4FNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561698; c=relaxed/simple;
	bh=JuQ5ifpSezq9RPetdtgiaNYLdjC6VLx7Jds/OSAOh30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oY0u88rJG/S3Ue1I5t+QvIu8ZGxJtCNw9GE4elRDySZDLtFN5lcitd0hk6PAYHjAAP8ITuXHtLALHQG8/wA7P6bJGVpoxFzIb05qRyiZP1/7GOmgyWu0mzkix51Km4zf6m1qFPozj0nj48QEQBZ64/rm58m42i0VlPx3oWzyrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CrAneewK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrAneewK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1YGIFeSK9cmskuSDD+3fm+A3buUMN10rubEx5F9QP0=;
	b=CrAneewK3ezS+7DmIEmJxZ4+HMQpumhWwxi3M7jxtS+mnycTZjDlkb5nT2gI0qo8Xylw4D
	uMp+j/RG8kz6hj1AQxAbeSzU8zh9xSTKTvwrCFvrO/xabSe307KOjmtuqu4ezY9imtfByG
	deVdFiqt545LtRWJ4HsD0aWSZ0rJMJU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-kh3IWg7oPT-O4hkP7f2kjA-1; Thu,
 30 Apr 2026 11:08:10 -0400
X-MC-Unique: kh3IWg7oPT-O4hkP7f2kjA-1
X-Mimecast-MFC-AGG-ID: kh3IWg7oPT-O4hkP7f2kjA_1777561689
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 97A4918004A9;
	Thu, 30 Apr 2026 15:08:09 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 114A3180045E;
	Thu, 30 Apr 2026 15:08:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 25/28] KVM: x86/mmu: add support for GMET to NPT page table walks
Date: Thu, 30 Apr 2026 11:07:44 -0400
Message-ID: <20260430150747.76749-26-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
index 32845edd14fa..015085ef6e46 100644
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
 	unsigned byte;
 
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
2.52.0



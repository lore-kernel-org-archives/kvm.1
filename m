Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EB4401A1A
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374623; cv=none; b=EK3KaU+TwKnwAoZ+7bu4XaJUBRBfBYUJa5Q/Aim3JFE9QTo1sxpyWA5Z/hTuvV0udToSjTuvwYEgehpPTe35Y+DUJ1nHQyJ7hL1ZqBatm+LlV9cdzwBMBUTUVBRqBv6nZO3XxJBR8igP6FxiEA4w8TTqhH1RVLrcZY3IkkWIk5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374623; c=relaxed/simple;
	bh=3RDSRsqKIiXzCKqJTZM0Wa0waf9XJs5AZ9g+uxeM/GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxysDhN1OpuK0TJm7PaqkZEMx/260KYzp3/tOKcxe1cZVm2vEaF6Cbz2bCB3niO/MhXRwANMLLVVbA9nHKvM4bsRX2f0AODy+aQXMBpfxRy1fC2EgiDrCTdg+J8fJiGXlXmoiXtj6ohRYUjzgcvOqkjsaQW6ftUwCtT4Jw1PWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M80QyKQF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M80QyKQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KG0c/pWf1iTcb4uBQ0RsG3mVRz8LJHqFdc81qjcAOpU=;
	b=M80QyKQFf5FTnkRuq/pd9VN0skTcQaKVDDm83xRu3QPPRte5Jt4HULP3J662uYuSik3UUu
	/ARzHUxkbSizerGaaWr99JatHLdoboMccuuB/eHRisEYZovGa7L6vQ775ISAEoMiRHsyZ0
	CtE4YHhvVooiq0baudYbJ6OFskdCh8M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-30mnfmLsM-O9or55t9C0iw-1; Tue,
 28 Apr 2026 07:10:14 -0400
X-MC-Unique: 30mnfmLsM-O9or55t9C0iw-1
X-Mimecast-MFC-AGG-ID: 30mnfmLsM-O9or55t9C0iw_1777374612
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D25AE19560AB;
	Tue, 28 Apr 2026 11:10:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4ACA019560B1;
	Tue, 28 Apr 2026 11:10:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 25/28] KVM: x86/mmu: add support for GMET to NPT page table walks
Date: Tue, 28 Apr 2026 07:09:43 -0400
Message-ID: <20260428110946.11466-26-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 29aa3994a8c2..9a8040e09d92 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -97,7 +97,7 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
-			     u64 efer, gpa_t nested_cr3);
+			     u64 efer, gpa_t nested_cr3, u64 misc_ctl);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 432f0d3ce632..6cf0e5f28ba5 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -55,6 +55,7 @@
 #include <asm/io.h>
 #include <asm/set_memory.h>
 #include <asm/spec-ctrl.h>
+#include <asm/svm.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
@@ -5566,7 +5567,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
+static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 {
 	unsigned byte;
 
@@ -5627,7 +5628,12 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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
@@ -5738,7 +5744,7 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
-	update_permission_bitmask(mmu, false);
+	update_permission_bitmask(mmu, mmu == &vcpu->arch.guest_mmu, false);
 	update_pkru_bitmask(mmu);
 }
 
@@ -5934,7 +5940,7 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 }
 
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
-			     u64 efer, gpa_t nested_cr3)
+			     u64 efer, gpa_t nested_cr3, u64 misc_ctl)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
@@ -5947,7 +5953,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
-	cpu_role.base.cr4_smep = false;
+	cpu_role.base.cr4_smep = (misc_ctl & SVM_MISC_ENABLE_GMET) != 0;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
@@ -6005,7 +6011,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
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



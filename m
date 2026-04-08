Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863983E0C53
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662975; cv=none; b=LkBfBC+o0BxNhIRcf2o3StKCQ/anCaInqI2kxrxiEPDAzMaWw9YEIi549qyXMfoEjgs7jKpdIrH/YLaqpCEmPLZ8+IykRvhbZmXlc3lpLW077TGrspyD1lhnu5VTo7+PRpNm3m9VD9cOxvcJEf7PUtgPSyuL62w4lXTa/fVNcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662975; c=relaxed/simple;
	bh=GdkdUmN2SZOgqFPse1j8klG3cXf2CgXMerkjHlHAHl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJTd6bPmOz+gg0fvKvhXSNHDybhakaQXjy6QCCn3xKm1UJVW6/UukwucGj3GtmNf8eIMI9AqeuV0dNe3nxg+fRdS+248qKyD6ldxNP5TYq0KrtNhiheDM5CZ3XKXMQE9aF9H5M3DJNCXynAhbuNRKB1xKUo5FcH1Q7zT8VzQy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJESF66c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJESF66c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=63vtfR1XnXTmtYcQt+S7PbSdNk24tkQ2sDonVo3agFg=;
	b=OJESF66cL7Xv1aBefZIfzadKt9rStdvbsoTQET/fv+DtOsGPwMPeBn89bPeFvOcRX/skXi
	9YFETtFSooJuEHpwDM0IaUQH9sqO5xoOoAFCOQDYRn5aKyU9M14pNpmyHWDdfwkpavR36E
	9Xu0ZGnFm1Z9ZpzspoqVhAI5QHTVvUc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-dmYgJcZON4WAIfnXo2nokw-1; Wed,
 08 Apr 2026 11:42:47 -0400
X-MC-Unique: dmYgJcZON4WAIfnXo2nokw-1
X-Mimecast-MFC-AGG-ID: dmYgJcZON4WAIfnXo2nokw_1775662965
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF8F918002CB;
	Wed,  8 Apr 2026 15:42:44 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7AD77300019F;
	Wed,  8 Apr 2026 15:42:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 24/27] KVM: x86/mmu: add support for GMET to NPT page table walks
Date: Wed,  8 Apr 2026 11:42:14 -0400
Message-ID: <20260408154217.458420-25-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

GMET allows page table entries to be created with U=0 in NPT.
However, when GMET=1 U=0 only affects execution, not reads or
writes.  Ignore user faults on non-fetch accesses for NPT GMET.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/mmu.h              |  3 ++-
 arch/x86/kvm/mmu/mmu.c          | 19 +++++++++++++------
 arch/x86/kvm/svm/nested.c       | 10 +++++++---
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e20f729f6eb2..99f37fc132ab 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -369,6 +369,8 @@ union kvm_mmu_page_role {
 		 * cr4_smep is also set for EPT MBEC.  Because it affects
 		 * which pages are considered non-present (bit 10 additionally
 		 * must be zero if MBEC is on) it has to be in the base role.
+		 * It also has to be in the base role for AMD GMET because
+		 * kernel-executable pages need to have U=0 with GMET enabled.
 		 */
 		unsigned cr4_smep:1;
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9031f7ef8e4e..1677eb0b5588 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -97,7 +97,8 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_mbec);
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu);
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3);
+			     unsigned long cr4, u64 efer, gpa_t nested_cr3,
+			     u64 nested_ctl);
 void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 			     int huge_page_level, bool accessed_dirty,
 			     bool mbec, gpa_t new_eptp);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 290537b0f36c..354f8af5d90a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -55,6 +55,7 @@
 #include <asm/io.h>
 #include <asm/set_memory.h>
 #include <asm/spec-ctrl.h>
+#include <asm/svm.h>
 #include <asm/vmx.h>
 
 #include "trace.h"
@@ -5557,7 +5558,7 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
+static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 {
 	unsigned byte;
 
@@ -5618,7 +5619,12 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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
@@ -5729,7 +5735,7 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
-	update_permission_bitmask(mmu, false);
+	update_permission_bitmask(mmu, mmu == &vcpu->arch.guest_mmu, false);
 	update_pkru_bitmask(mmu);
 }
 
@@ -5925,7 +5931,8 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 }
 
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
-			     unsigned long cr4, u64 efer, gpa_t nested_cr3)
+			     unsigned long cr4, u64 efer, gpa_t nested_cr3,
+			     u64 nested_ctl)
 {
 	struct kvm_mmu *context = &vcpu->arch.guest_mmu;
 	struct kvm_mmu_role_regs regs = {
@@ -5938,7 +5945,7 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr0,
 
 	/* NPT requires CR0.PG=1. */
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
-	cpu_role.base.cr4_smep = false;
+	cpu_role.base.cr4_smep = (nested_ctl & SVM_NESTED_CTL_GMET_ENABLE) != 0;
 
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
@@ -5996,7 +6003,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(context, true);
+		update_permission_bitmask(context, true, true);
 		context->pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 3b670ee4eb26..a76f2b8cbef9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -95,7 +95,8 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	 */
 	kvm_init_shadow_npt_mmu(vcpu, X86_CR0_PG, svm->vmcb01.ptr->save.cr4,
 				svm->vmcb01.ptr->save.efer,
-				svm->nested.ctl.nested_cr3);
+				svm->nested.ctl.nested_cr3,
+				svm->nested.ctl.nested_ctl);
 	vcpu->arch.mmu->get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.mmu->get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.mmu->inject_page_fault = nested_svm_inject_npf_exit;
@@ -1973,12 +1974,15 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
+	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	BUG_ON(!mmu_is_nested(vcpu));
 
-	/* NPT walks are always user-walks */
-	access |= PFERR_USER_MASK;
+	/* Non-GMET walks are always user-walks */
+	if (!(svm->nested.ctl.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE))
+		access |= PFERR_USER_MASK;
+
 	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
 }
 
-- 
2.52.0



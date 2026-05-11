Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CF2DF13F
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512017; cv=none; b=NzsFhdUyoQwaInXf4ckQ9nevv5hF7Z/YD3bvqrfS3WgDN3sLSsn6PzSamwmieFznEJEDbHMK8XuKRI0MVt2XFXc4Lftxr3MdEnqXVEHVnB6EW8c/CO9BbVXajDiwlxE2eRuRbfWawlNjAY1mP5d7ZAoomAK30BMHXSwLXlWzKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512017; c=relaxed/simple;
	bh=MGYLdxOjVCA9STyceG8RxrTO6SVItWsLaNj3H9s3gFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlsKvrm7EoBgiC5OLtA6fs59qWx14RkYxad3UwblwPVwKcJjSy78m7Qw8QXGO8IaZfMOySS29vbE0ylAez08eoyhXnnVM27918hIWIbodF+Nb+ZevNnktBAPyc+H5gFkoIIz1n/PnmwV8OtdHGyYv5wyxuCHmf/8fj5GEWacOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OThqVkWr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OThqVkWr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02w8BkAdzdlUN2wyghioQj7BB29mZW/JzlfzfeQoiYs=;
	b=OThqVkWr4mtY8khytvpgMYjL2yppFg6RnXtJJZwVUlpHI7J3kJXJsMVT2Pm0G+wcx/6LTl
	WdzNUDgnqfkA7yPSYc0jVhtSxCSFsLwEdJbRms+Z1dFGO8/wPGNw0iBc0qZi8i0JI+zPMp
	rooYnijMMYtcRN6vvoM77BHgv3tfmXo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-Sex3tK0mMRG6AkPaUtyS2g-1; Mon,
 11 May 2026 11:06:52 -0400
X-MC-Unique: Sex3tK0mMRG6AkPaUtyS2g-1
X-Mimecast-MFC-AGG-ID: Sex3tK0mMRG6AkPaUtyS2g_1778512011
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F7DD19560BD;
	Mon, 11 May 2026 15:06:51 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD5DB180034E;
	Mon, 11 May 2026 15:06:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 02/22] KVM: x86: move pdptrs out of the MMU
Date: Mon, 11 May 2026 11:06:28 -0400
Message-ID: <20260511150648.685374-3-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-1-pbonzini@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

PDPTRs are part of the CPU state.  A bit unconventionally, they are
reached via vcpu->arch.walk_mmu instead of being stored in vcpu->arch
directly.  That is nice in principle---it would allow TDP shadow paging
to have its own PDPTRs---but it is not necessary, because EPT has no
PDPTRs and NPT does not cache them.

Since kvm_pdptr_read does not otherwise need the MMU, drop the pdptrs
from the MMU altogether.  There is however a negative effect, in that
they are now not stored separately in root_mmu and nested_mmu for L1
and L2 guests.  This means that they are overwritten by nested VM entry
and exit, and need to be manually marked dirty.

Note that page table PDPTRs are not affected, since they are stored
in pae_root.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  5 ++---
 arch/x86/kvm/kvm_cache_regs.h   |  4 ++--
 arch/x86/kvm/svm/nested.c       |  9 ++++++---
 arch/x86/kvm/svm/svm.c          |  2 +-
 arch/x86/kvm/vmx/nested.c       | 14 +++++++++-----
 arch/x86/kvm/vmx/vmx.c          | 20 ++++++++------------
 arch/x86/kvm/x86.c              |  6 +++---
 7 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1da3d5c59e15..2c8096ceb072 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -519,10 +519,7 @@ struct kvm_mmu {
 	 * the bits spte never used.
 	 */
 	struct rsvd_bits_validate shadow_zero_check;
-
 	struct rsvd_bits_validate guest_rsvd_check;
-
-	u64 pdptrs[4]; /* pae */
 };
 
 enum pmc_type {
@@ -879,6 +876,8 @@ struct kvm_vcpu_arch {
 	 */
 	struct kvm_mmu *walk_mmu;
 
+	u64 pdptrs[4]; /* pae */
+
 	struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
 	struct kvm_mmu_memory_cache mmu_shadow_page_cache;
 	struct kvm_mmu_memory_cache mmu_shadowed_info_cache;
diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 8ddb01191d6f..a02abc4000ee 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -158,12 +158,12 @@ static inline u64 kvm_pdptr_read(struct kvm_vcpu *vcpu, int index)
 	if (!kvm_register_is_available(vcpu, VCPU_EXREG_PDPTR))
 		kvm_x86_call(cache_reg)(vcpu, VCPU_EXREG_PDPTR);
 
-	return vcpu->arch.walk_mmu->pdptrs[index];
+	return vcpu->arch.pdptrs[index];
 }
 
 static inline void kvm_pdptr_write(struct kvm_vcpu *vcpu, int index, u64 value)
 {
-	vcpu->arch.walk_mmu->pdptrs[index] = value;
+	vcpu->arch.pdptrs[index] = value;
 }
 
 static inline ulong kvm_read_cr0_bits(struct kvm_vcpu *vcpu, ulong mask)
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 3d1fd1776e19..593f5856c530 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -680,9 +680,12 @@ static int nested_svm_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 	if (CC(!kvm_vcpu_is_legal_cr3(vcpu, cr3)))
 		return -EINVAL;
 
-	if (reload_pdptrs && !nested_npt && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, cr3)))
-		return -EINVAL;
+	if (reload_pdptrs && is_pae_paging(vcpu)) {
+		if (nested_npt)
+			kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
+		else if (CC(!load_pdptrs(vcpu, cr3)))
+			return -EINVAL;
+	}
 
 	vcpu->arch.cr3 = cr3;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4519a1f92584..a31e0625863b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1526,7 +1526,7 @@ static void svm_cache_reg(struct kvm_vcpu *vcpu, enum kvm_reg reg)
 	switch (reg) {
 	case VCPU_EXREG_PDPTR:
 		/*
-		 * When !npt_enabled, mmu->pdptrs[] is already available since
+		 * When !npt_enabled, vcpu->pdptrs[] is already available since
 		 * it is always updated per SDM when moving to CRs.
 		 */
 		if (npt_enabled)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bc1046f32ebc..679fe0c2894a 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1192,12 +1192,16 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3,
 
 	/*
 	 * If PAE paging and EPT are both on, CR3 is not used by the CPU and
-	 * must not be dereferenced.
+	 * must not be dereferenced.  Marking the PDPTRs dirty is enough,
+	 * if ever needed they will be fished out of VMCS02's GUEST_PDPTRx.
 	 */
-	if (reload_pdptrs && !nested_ept && is_pae_paging(vcpu) &&
-	    CC(!load_pdptrs(vcpu, cr3))) {
-		*entry_failure_code = ENTRY_FAIL_PDPTE;
-		return -EINVAL;
+	if (reload_pdptrs && is_pae_paging(vcpu)) {
+		if (nested_ept) {
+			kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
+		} else if (CC(!load_pdptrs(vcpu, cr3))) {
+			*entry_failure_code = ENTRY_FAIL_PDPTE;
+			return -EINVAL;
+		}
 	}
 
 	vcpu->arch.cr3 = cr3;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cc14a6b96681..0717dcd2d37d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3363,30 +3363,26 @@ void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu)
 
 void vmx_ept_load_pdptrs(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
-
 	if (!kvm_register_is_dirty(vcpu, VCPU_EXREG_PDPTR))
 		return;
 
 	if (is_pae_paging(vcpu)) {
-		vmcs_write64(GUEST_PDPTR0, mmu->pdptrs[0]);
-		vmcs_write64(GUEST_PDPTR1, mmu->pdptrs[1]);
-		vmcs_write64(GUEST_PDPTR2, mmu->pdptrs[2]);
-		vmcs_write64(GUEST_PDPTR3, mmu->pdptrs[3]);
+		vmcs_write64(GUEST_PDPTR0, vcpu->arch.pdptrs[0]);
+		vmcs_write64(GUEST_PDPTR1, vcpu->arch.pdptrs[1]);
+		vmcs_write64(GUEST_PDPTR2, vcpu->arch.pdptrs[2]);
+		vmcs_write64(GUEST_PDPTR3, vcpu->arch.pdptrs[3]);
 	}
 }
 
 void ept_save_pdptrs(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
-
 	if (WARN_ON_ONCE(!is_pae_paging(vcpu)))
 		return;
 
-	mmu->pdptrs[0] = vmcs_read64(GUEST_PDPTR0);
-	mmu->pdptrs[1] = vmcs_read64(GUEST_PDPTR1);
-	mmu->pdptrs[2] = vmcs_read64(GUEST_PDPTR2);
-	mmu->pdptrs[3] = vmcs_read64(GUEST_PDPTR3);
+	vcpu->arch.pdptrs[0] = vmcs_read64(GUEST_PDPTR0);
+	vcpu->arch.pdptrs[1] = vmcs_read64(GUEST_PDPTR1);
+	vcpu->arch.pdptrs[2] = vmcs_read64(GUEST_PDPTR2);
+	vcpu->arch.pdptrs[3] = vmcs_read64(GUEST_PDPTR3);
 
 	kvm_register_mark_available(vcpu, VCPU_EXREG_PDPTR);
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7c6942afae81..4a2c977a542f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1065,7 +1065,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	gpa_t real_gpa;
 	int i;
 	int ret;
-	u64 pdpte[ARRAY_SIZE(mmu->pdptrs)];
+	u64 pdpte[ARRAY_SIZE(vcpu->arch.pdptrs)];
 
 	/*
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
@@ -1094,10 +1094,10 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * Marking VCPU_EXREG_PDPTR dirty doesn't work for !tdp_enabled.
 	 * Shadow page roots need to be reconstructed instead.
 	 */
-	if (!tdp_enabled && memcmp(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs)))
+	if (!tdp_enabled && memcmp(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs)))
 		kvm_mmu_free_roots(vcpu->kvm, mmu, KVM_MMU_ROOT_CURRENT);
 
-	memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
+	memcpy(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs));
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
 	kvm_make_request(KVM_REQ_LOAD_MMU_PGD, vcpu);
 	vcpu->arch.pdptrs_from_userspace = false;
-- 
2.52.0



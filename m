Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641305;
	b=HmVNuBF96/WaEbdtZfdXC3BVDPsdJG6Jr0y2YgsTAEn9G3dXKd+0PTUYvChR+vc5CfuU
	 t/nSYIJg9xFgpL/x4Lc6fols4NkMui08hLyROBJNotVKp9VETpkRDHgWoFAtH0ZWnsqYf
	 4frzlPAox8Iq3yFAeKXM4/UrQmoiUi9bYz+Th+XuC1lv2BCJyyWb6x/MGRclbh8V+S+vR
	 MemUfiCIHteQXi8pulwgZv0oXhuOht8PqW+n1TR4FZZaMBFezYokG0XiMvj9APTzx2S3F
	 BpjoEGG0/PeqjNjjS3EVnjMLFNScOA0h2iXRnUC/Oq9qK4nQ68hCOM3kr4fDbI/2dZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641305;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Spkg4Vz9Q+tApQJlAkmEi5cbID5JtcHMAEdgXATqvSQ=;
	b=oRoANcnt35r7QRh7RuucuMu6xIrF6BxnwSqGjsBKFDwZCaqwbdfXsWRtBAmEmNKBYfVQ
	 VNR+/cuqSqYb73yAoeQGXVwI/I66BS+ZMLyt4YPP8kDJ8ZhslOPUvij+8RHauGHVsc+7c
	 0LObfyr8kI/QYCRNc1eaOWcZ7f4WzmJCpdVbyuElt9g3MTdAtCPyRcEaJO6vDW8MJemQQ
	 mF16mZ2dixRRYQNZajXa3D33AjRXS0oBM3s8kDGrwaXFt/JE0IQSjALOfWrwdvRrXkhnG
	 YWEFHMtUGGTBAXvcSO/Jgyw8h3lGf02cMHwF5romvQcvur/m3479ttYaVujQyARSfrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GHkgw2QJ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3380D6082BC7
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3380D6082BC7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GHkgw2QJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Spkg4Vz9Q+tApQJlAkmEi5cbID5JtcHMAEdgXATqvSQ=;
	b=GHkgw2QJpzq+rFxtuIbnMj0eSGJPD3sqagrdkVBp9xweCH7/8sZpbF79VKu4R4FngcGISL
	j8Cxg3NF1NoLyOizBE6kO7ViVvS/iwrFQw38xqGEtmN8nbiSjsBGz/xhHbeuKqo0iYNDts
	QRuOH/7VFoqiNgb4Voz7G4ljF/sOwg0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-J21z4_KnP4-lITpRUnebKA-1; Mon,
 02 Nov 2026 12:41:40 -0500
X-MC-Unique: J21z4_KnP4-lITpRUnebKA-1
X-Mimecast-MFC-AGG-ID: J21z4_KnP4-lITpRUnebKA_1793641299
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B3E51955E89;
	Mon,  2 Nov 2026 17:41:39 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D22761800347;
	Mon,  2 Nov 2026 17:41:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 13/45] KVM: x86/mmu: Extend map_writable to a full ACC_* mask
Date: Mon,  2 Nov 2026 12:40:57 -0500
Message-ID: <20261102174130.8779-14-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Support for memory protection attributes opens the door to installing
non-executable mappings. Instead of introducing yet another member in
struct kvm_page_fault and another argument to make_spte(), make the
existing member map_writable a mask of ACC_* bits.  This also avoids the
need for make_spte() to map a single bool to either the NX bit or
the XS/XU bits together.

Unlike for mappings that are not writable because the fault did
not request write premission, it is not not necessary to track
executability for these SPTEs; the gfn is always available and it will
be possible to access the attributes directly in FNAME(sync_spte).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://patch.msgid.link/20260918135030.171564-10-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c          | 21 ++++++++++++---------
 arch/x86/kvm/mmu/mmu_internal.h |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  8 +++++---
 arch/x86/kvm/mmu/spte.c         | 12 ++++++------
 arch/x86/kvm/mmu/spte.h         |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
 6 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 38a4583d1ec2..5be24b67f212 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3158,7 +3158,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	u64 spte;
 
 	/* Prefetching always gets a writable pfn.  */
-	bool host_writable = !fault || fault->map_writable;
+	unsigned host_access = fault ? fault->host_access : ACC_ALL;
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
@@ -3195,7 +3195,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	}
 
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
-			   false, host_writable, &spte);
+			   false, host_access, &spte);
 
 	if (*sptep == spte) {
 		ret = RET_PF_SPURIOUS;
@@ -3643,7 +3643,7 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu *vcpu,
 
 	fault->slot = NULL;
 	fault->pfn = KVM_PFN_NOSLOT;
-	fault->map_writable = false;
+	fault->host_access = 0;
 
 	/*
 	 * If MMIO caching is disabled, emulate immediately without
@@ -4668,7 +4668,8 @@ static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 				      struct kvm_page_fault *fault, int r)
 {
 	kvm_release_faultin_page(vcpu->kvm, fault->refcounted_page,
-				 r == RET_PF_RETRY, fault->map_writable);
+				 r == RET_PF_RETRY,
+				 !!(fault->host_access & ACC_WRITE_MASK));
 }
 
 static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
@@ -4688,9 +4689,10 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return r;
 	}
 
-	fault->map_writable &= !(fault->slot->flags & KVM_MEM_READONLY);
-	fault->max_level = kvm_max_level_for_order(max_order);
+	if (fault->slot->flags & KVM_MEM_READONLY)
+		fault->host_access &= ~ACC_WRITE_MASK;
 
+	fault->max_level = kvm_max_level_for_order(max_order);
 	return RET_PF_CONTINUE;
 }
 
@@ -4738,7 +4740,8 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				       &writable, &fault->refcounted_page);
 
 out_pf_continue:
-	fault->map_writable &= writable;
+	if (!writable)
+		fault->host_access &= ~ACC_WRITE_MASK;
 	return RET_PF_CONTINUE;
 }
 
@@ -5057,7 +5060,7 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
 
 		.pfn = KVM_PFN_ERR_FAULT,
-		.map_writable = true,
+		.host_access = ACC_ALL,
 	};
 	int r;
 
@@ -5252,7 +5255,7 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
 		.gfn = gfn,
 		.slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn),
 		.pfn = pfn,
-		.map_writable = true,
+		.host_access = ACC_ALL,
 	};
 	struct kvm *kvm = vcpu->kvm;
 	int r;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index c29002c60126..00215b9f309f 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -280,7 +280,7 @@ struct kvm_page_fault {
 	unsigned long mmu_seq;
 	kvm_pfn_t pfn;
 	struct page *refcounted_page;
-	bool map_writable;
+	u8 host_access;
 
 	/*
 	 * Indicates the guest is trying to write a gfn that contains one or
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 8e350095508c..533ad280accc 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -938,7 +938,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
  */
 static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int i)
 {
-	bool host_writable;
+	u8 host_access;
 	gpa_t first_pte_gpa;
 	u64 *sptep, spte;
 	struct kvm_memory_slot *slot;
@@ -995,11 +995,13 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 
 	sptep = &sp->spt[i];
 	spte = *sptep;
-	host_writable = spte & shadow_host_writable_mask;
+	host_access = ACC_ALL;
+	if (!(spte & shadow_host_writable_mask))
+		host_access &= ~ACC_WRITE_MASK;
 	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	make_spte(vcpu, sp, slot, pte_access, gfn,
 		  spte_to_pfn(spte), spte, true, true,
-		  host_writable, &spte);
+		  host_access, &spte);
 
 	/*
 	 * There is no need to mark the pfn dirty, as the new protections must
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 5fc27e9733b3..1434164fa372 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -189,7 +189,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       const struct kvm_memory_slot *slot,
 	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
 	       u64 old_spte, bool prefetch, bool synchronizing,
-	       bool host_writable, u64 *new_spte)
+	       unsigned int host_access, u64 *new_spte)
 {
 	int level = sp->role.level;
 	u64 spte = SPTE_MMU_PRESENT_MASK;
@@ -207,6 +207,11 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (!prefetch || synchronizing)
 		spte |= shadow_accessed_mask;
 
+	if (host_access & ACC_WRITE_MASK)
+		spte |= shadow_host_writable_mask;
+
+	pte_access &= host_access;
+
 	/*
 	 * For simplicity, enforce the NX huge page mitigation even if not
 	 * strictly necessary.  KVM could ignore the mitigation if paging is
@@ -246,11 +251,6 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (kvm_x86_ops.get_mt_mask)
 		spte |= kvm_x86_call(get_mt_mask)(vcpu, gfn,
 						  kvm_is_mmio_pfn(pfn, &is_host_mmio));
-	if (host_writable)
-		spte |= shadow_host_writable_mask;
-	else
-		pte_access &= ~ACC_WRITE_MASK;
-
 	if (shadow_me_value && !kvm_is_mmio_pfn(pfn, &is_host_mmio))
 		spte |= shadow_me_value;
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index e730717824b3..589f3954633e 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -563,7 +563,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       const struct kvm_memory_slot *slot,
 	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
 	       u64 old_spte, bool prefetch, bool synchronizing,
-	       bool host_writable, u64 *new_spte);
+	       unsigned int host_access, u64 *new_spte);
 u64 make_small_spte(struct kvm *kvm, u64 huge_spte,
 		    union kvm_mmu_page_role role, int index);
 u64 make_huge_spte(struct kvm *kvm, u64 small_spte, int level);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad1..dce44b9ce73a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1143,7 +1143,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	else
 		wrprot = make_spte(vcpu, sp, fault->slot, sp->role.access, iter->gfn,
 				   fault->pfn, iter->old_spte, fault->prefetch,
-				   false, fault->map_writable, &new_spte);
+				   false, fault->host_access, &new_spte);
 
 	if (new_spte == iter->old_spte)
 		ret = RET_PF_SPURIOUS;
-- 
2.52.0



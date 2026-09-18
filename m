Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC233DD85E
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719365; cv=none; b=BWibebw4aeZLGve2ArFM9FEOmLP9QIgRstdcMEcTcVbZrvAz0xSeL3+W5xvs3nhosnNkp5MZvGwMG0KroyezQZT4VJbwb2Re3avQw21fEVs1z9ZePBqhFokbqlcPq0/r65EGimghUXxAr7RTRih/SkjqYHYdf3ed/1ozvkWpc9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719365; c=relaxed/simple;
	bh=lcJN8vLjIwK4WDPsjbRdO6X3eIhgV3xUE56pBLYgXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sHF5QMCXj1JeQSzpBbSKc5x/CJKkqBtQHkn1v4ydEfV/6UIusDEBD98PnoDJFiVTLLopX5dq8/8TXwflHIrvpfitj/I9I7Nj2eJfvTdQk2AEAJPhmYnsIg2Y/hrrzVQZHxBK43/8U1yWZI19KfTwUSzAT6PTDBUVGk7NpNkSuqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8XT6R4h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8XT6R4h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789719356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34U/H3bFnFyk6+Y+T6dy301GKxXjP7tSD65G/7DySy4=;
	b=c8XT6R4hEKzL24zcLfXMwfusPFPhVAoHYjb3ZUzKXC7XARKIL1Mpkt5ds+umMmfGbA6q4/
	/LXf5E/s4Lez/5rmYm/7fDk5G0CKNDHYCHQWU4n5/UeBHlavUu7UZrtivI/uFbq/0xnNTT
	ZtGmUXoIgmf5MFkW2+00Cq7JbRegqFI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-Tj-Gm__fPu2b0mP5B-cC3w-1; Fri,
 18 Sep 2026 04:15:52 -0400
X-MC-Unique: Tj-Gm__fPu2b0mP5B-cC3w-1
X-Mimecast-MFC-AGG-ID: Tj-Gm__fPu2b0mP5B-cC3w_1789719351
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29F8418011E9;
	Fri, 18 Sep 2026 08:15:51 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 82D091800370;
	Fri, 18 Sep 2026 08:15:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: nsaenz@amazon.com,
	vkuznets@redhat.com,
	snambakam@linux.microsoft.com
Subject: [PATCH v2 08/28] KVM: x86/mmu: Extend map_writable to a full ACC_* mask
Date: Fri, 18 Sep 2026 04:15:23 -0400
Message-ID: <20260918081543.139871-9-pbonzini@redhat.com>
In-Reply-To: <20260918081543.139871-1-pbonzini@redhat.com>
References: <20260918081543.139871-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
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
---
 arch/x86/kvm/mmu/mmu.c          | 21 ++++++++++++---------
 arch/x86/kvm/mmu/mmu_internal.h |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  |  8 +++++---
 arch/x86/kvm/mmu/spte.c         | 12 ++++++------
 arch/x86/kvm/mmu/spte.h         |  2 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  2 +-
 6 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 5996468b7120..b72ccbee0d86 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3105,7 +3105,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	u64 spte;
 
 	/* Prefetching always gets a writable pfn.  */
-	bool host_writable = !fault || fault->map_writable;
+	unsigned host_access = fault ? fault->host_access : ACC_ALL;
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
 
@@ -3142,7 +3142,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	}
 
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
-			   false, host_writable, &spte);
+			   false, host_access, &spte);
 
 	if (*sptep == spte) {
 		ret = RET_PF_SPURIOUS;
@@ -3589,7 +3589,7 @@ static int kvm_handle_noslot_fault(struct kvm_vcpu *vcpu,
 
 	fault->slot = NULL;
 	fault->pfn = KVM_PFN_NOSLOT;
-	fault->map_writable = false;
+	fault->host_access = 0;
 
 	/*
 	 * If MMIO caching is disabled, emulate immediately without
@@ -4614,7 +4614,8 @@ static void kvm_mmu_finish_page_fault(struct kvm_vcpu *vcpu,
 				      struct kvm_page_fault *fault, int r)
 {
 	kvm_release_faultin_page(vcpu->kvm, fault->refcounted_page,
-				 r == RET_PF_RETRY, fault->map_writable);
+				 r == RET_PF_RETRY,
+				 !!(fault->host_access & ACC_WRITE_MASK));
 }
 
 static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
@@ -4634,9 +4635,10 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return r;
 	}
 
-	fault->map_writable &= !(fault->slot->flags & KVM_MEM_READONLY);
-	fault->max_level = kvm_max_level_for_order(max_order);
+	if (fault->slot->flags & KVM_MEM_READONLY)
+		fault->host_access &= ~ACC_WRITE_MASK;
 
+	fault->max_level = kvm_max_level_for_order(max_order);
 	return RET_PF_CONTINUE;
 }
 
@@ -4684,7 +4686,8 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				       &writable, &fault->refcounted_page);
 
 out_pf_continue:
-	fault->map_writable &= writable;
+	if (!writable)
+		fault->host_access &= ~ACC_WRITE_MASK;
 	return RET_PF_CONTINUE;
 }
 
@@ -5003,7 +5006,7 @@ static int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.is_private = err & PFERR_PRIVATE_ACCESS,
 
 		.pfn = KVM_PFN_ERR_FAULT,
-		.map_writable = true,
+		.host_access = ACC_ALL,
 	};
 	int r;
 
@@ -5197,7 +5200,7 @@ int kvm_tdp_mmu_map_private_pfn(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
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
index 27427e7f22fa..e6ec14165f40 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -935,7 +935,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
  */
 static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int i)
 {
-	bool host_writable;
+	u8 host_access;
 	gpa_t first_pte_gpa;
 	u64 *sptep, spte;
 	struct kvm_memory_slot *slot;
@@ -992,11 +992,13 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 
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



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFEF43E483
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484305; cv=none; b=BSE2wV1nb9vEK1cHmInaumL1KGexjcQAwh8eAM+935FIJN7DSBMhOpE3QiEldBotVJtQ+KzcB/KZ6WYdivZkkDDYFRltxu5t5xb89Iy1fDtLFX4uvqr9tobd5BabEfCY49V83bqPI8BtcwsaV3zXFL8R4ibsHn4lJoXqjc0zeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484305; c=relaxed/simple;
	bh=MnAnkLEPTiEeKbRC5W/Q/IaOYm9pXUfwlKtxe7d3cwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIi6UgF1msrPE55vUQAPBq23VbLDWhPNqt6tsh4YIrwUB2rNIvXAi2GTbTiAIJHcwIA7Ch69jireLOH7IKqpCSK1YLctmymqjGVkR+deLEeosV6XR3YHWbys+ETTlm8x04cxh7EhbpkF4clr8ew7dv+s6intZKJgjBzGWEp9Qbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtyoLYs0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtyoLYs0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQ7X8iEem6j80DsOxKfYdvT2DBlswjfsLpCR4g+WkE0=;
	b=FtyoLYs0j3MPDqjtQDnvjnedJeusH0u4PbfCsB2EOnnWw5OckiB+DKaPa1eiyFbLT2STJy
	i4eVaZWugyEmlfsk4ViC1JBhdi2Q0zv3Hs+M/LCXY2ywnAQ858XJpIF/pqVSiCuUTRg/LF
	OCeT2k6WEQAbG7Dht+vSB6GLdwQbp8I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-ROkwBrGjNEO4p64_IEul2g-1; Wed,
 03 Jun 2026 06:58:20 -0400
X-MC-Unique: ROkwBrGjNEO4p64_IEul2g-1
X-Mimecast-MFC-AGG-ID: ROkwBrGjNEO4p64_IEul2g_1780484299
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 742791956089;
	Wed,  3 Jun 2026 10:58:19 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 18EEE404;
	Wed,  3 Jun 2026 10:58:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 07/24] KVM: x86/mmu: introduce struct kvm_pagewalk
Date: Wed,  3 Jun 2026 06:57:57 -0400
Message-ID: <20260603105814.10236-8-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

In preparation for separating walking and building of page tables,
introduce a dummy struct kvm_pagewalk and pass it around instead of
its containing kvm_mmu to functions that do not build the page tables.

Outermost functions retrieve the mmu via container_of, while internal
functions can pass around the struct kvm_pagewalk pointer.  x86.c is
still (mostly) oblivious to the existence of struct kvm_pagewalk.  There
are only a couple exceptions for now, which were done already here
for simplicity, but the plan is for the KVM code to use struct
kvm_pagewalk whenever dealing with guest page tables.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  7 +++++-
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/mmu.h              | 19 +++++++++------
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h  | 43 +++++++++++++++++++--------------
 arch/x86/kvm/x86.c              |  4 +--
 6 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c7c1c2e2a7c2..f72af337330b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -476,10 +476,15 @@ struct kvm_page_fault;
 
 /*
  * x86 supports 4 paging modes (5-level 64-bit, 4-level 64-bit, 3-level 32-bit,
- * and 2-level 32-bit).  The kvm_mmu structure abstracts the details of the
+ * and 2-level 32-bit).  The kvm_pagewalk structure abstracts the details of the
  * current mmu mode.
  */
+struct kvm_pagewalk {
+};
+
 struct kvm_mmu {
+	struct kvm_pagewalk w;
+
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a374fd64a76a..a6e7d6f85409 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2041,7 +2041,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, vcpu->arch.walk_mmu, hc->ingpa,
+		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.walk_mmu->w, hc->ingpa,
 					      PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index ddf4e467c071..3f8ac193a1e6 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -169,21 +169,22 @@ static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
 }
 
 static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
-						    struct kvm_mmu *mmu)
+						    struct kvm_pagewalk *w)
 {
 	/*
 	 * When EPT is enabled, KVM may passthrough CR0.WP to the guest, i.e.
-	 * @mmu's snapshot of CR0.WP and thus all related paging metadata may
+	 * @w's snapshot of CR0.WP and thus all related paging metadata may
 	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
 	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
 	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
 	 * need to refresh nested_mmu, a.k.a. the walker used to translate L2
 	 * GVAs to GPAs, as that "MMU" needs to honor L2's CR0.WP.
 	 */
-	if (!tdp_enabled || mmu == &vcpu->arch.guest_mmu)
+	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
 		return;
 
-	__kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
+	__kvm_mmu_refresh_passthrough_bits(vcpu,
+					   container_of(w, struct kvm_mmu, w));
 }
 
 /*
@@ -194,10 +195,12 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
  * Return zero if the access does not fault; return the page fault error code
  * if the access faults.
  */
-static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
+	struct kvm_mmu *mmu = container_of(w, struct kvm_mmu, w);
+
 	/* strip nested paging fault error codes */
 	unsigned int pfec = access;
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
@@ -220,7 +223,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	u32 errcode = PFERR_PRESENT_MASK;
 	bool fault;
 
-	kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
+	kvm_mmu_refresh_passthrough_bits(vcpu, w);
 
 	fault = (mmu->permissions[index] >> pte_access) & 1;
 
@@ -301,12 +304,12 @@ static inline void kvm_update_page_stats(struct kvm *kvm, int level, int count)
 }
 
 static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
-				      struct kvm_mmu *mmu,
+				      struct kvm_pagewalk *w,
 				      gpa_t gpa, u64 access,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	if (mmu != &vcpu->arch.nested_mmu)
+	if (w != &vcpu->arch.nested_mmu.w)
 		return gpa;
 	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
 							    exception,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f8aa7eda661e..42b7397a1845 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4354,7 +4354,7 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	 * user-mode address if CR0.PG=0.  Therefore *include* ACC_USER_MASK in
 	 * the last argument to kvm_translate_gpa (which NPT does not use).
 	 */
-	return kvm_translate_gpa(vcpu, mmu, vaddr, access | PFERR_GUEST_FINAL_MASK,
+	return kvm_translate_gpa(vcpu, &mmu->w, vaddr, access | PFERR_GUEST_FINAL_MASK,
 				 exception, ACC_ALL);
 }
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 07100bbfc270..ab1aebf2f73c 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -106,9 +106,10 @@ static gfn_t gpte_to_gfn_lvl(pt_element_t gpte, int lvl)
 	return (gpte & PT_LVL_ADDR_MASK(lvl)) >> PAGE_SHIFT;
 }
 
-static inline void FNAME(protect_clean_gpte)(struct kvm_mmu *mmu, unsigned *access,
+static inline void FNAME(protect_clean_gpte)(struct kvm_pagewalk *w, unsigned *access,
 					     unsigned gpte)
 {
+	struct kvm_mmu __maybe_unused *mmu = container_of(w, struct kvm_mmu, w);
 	unsigned mask;
 
 	/* dirty bit is not supported, so no need to track it */
@@ -147,8 +148,10 @@ static bool FNAME(is_bad_mt_xwr)(struct rsvd_bits_validate *rsvd_check, u64 gpte
 #endif
 }
 
-static bool FNAME(is_rsvd_bits_set)(struct kvm_mmu *mmu, u64 gpte, int level)
+static bool FNAME(is_rsvd_bits_set)(struct kvm_pagewalk *w, u64 gpte, int level)
 {
+	struct kvm_mmu *mmu = container_of(w, struct kvm_mmu, w);
+
 	return __is_rsvd_bits_set(&mmu->guest_rsvd_check, gpte, level) ||
 	       FNAME(is_bad_mt_xwr)(&mmu->guest_rsvd_check, gpte);
 }
@@ -165,7 +168,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 	    !(gpte & PT_GUEST_ACCESSED_MASK))
 		goto no_present;
 
-	if (FNAME(is_rsvd_bits_set)(vcpu->arch.mmu, gpte, PG_LEVEL_4K))
+	if (FNAME(is_rsvd_bits_set)(&vcpu->arch.mmu->w, gpte, PG_LEVEL_4K))
 		goto no_present;
 
 	return false;
@@ -206,10 +209,11 @@ static inline unsigned FNAME(gpte_access)(u64 gpte)
 }
 
 static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
-					     struct kvm_mmu *mmu,
+					     struct kvm_pagewalk *w,
 					     struct guest_walker *walker,
 					     gpa_t addr, int write_fault)
 {
+	struct kvm_mmu __maybe_unused *mmu = container_of(w, struct kvm_mmu, w);
 	unsigned level, index;
 	pt_element_t pte, orig_pte;
 	pt_element_t __user *ptep_user;
@@ -278,9 +282,11 @@ static inline unsigned FNAME(gpte_pkeys)(struct kvm_vcpu *vcpu, u64 gpte)
 	return pkeys;
 }
 
-static inline bool FNAME(is_last_gpte)(struct kvm_mmu *mmu,
+static inline bool FNAME(is_last_gpte)(struct kvm_pagewalk *w,
 				       unsigned int level, unsigned int gpte)
 {
+	struct kvm_mmu __maybe_unused *mmu = container_of(w, struct kvm_mmu, w);
+
 	/*
 	 * For EPT and PAE paging (both variants), bit 7 is either reserved at
 	 * all level or indicates a huge page (ignoring CR3/EPTP).  In either
@@ -311,9 +317,10 @@ static inline bool FNAME(is_last_gpte)(struct kvm_mmu *mmu,
  * Fetch a guest pte for a guest virtual address, or for an L2's GPA.
  */
 static int FNAME(walk_addr_generic)(struct guest_walker *walker,
-				    struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+				    struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				    gpa_t addr, u64 access)
 {
+	struct kvm_mmu *mmu = container_of(w, struct kvm_mmu, w);
 	int ret;
 	pt_element_t pte;
 	pt_element_t __user *ptep_user;
@@ -387,7 +394,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		walker->table_gfn[walker->level - 1] = table_gfn;
 		walker->pte_gpa[walker->level - 1] = pte_gpa;
 
-		real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(table_gfn),
+		real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(table_gfn),
 					     nested_access | PFERR_GUEST_PAGE_MASK,
 					     &walker->fault, 0);
 
@@ -429,7 +436,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(!FNAME(is_present_gpte)(mmu, pte)))
 			goto error;
 
-		if (unlikely(FNAME(is_rsvd_bits_set)(mmu, pte, walker->level))) {
+		if (unlikely(FNAME(is_rsvd_bits_set)(w, pte, walker->level))) {
 			errcode = PFERR_RSVD_MASK | PFERR_PRESENT_MASK;
 			goto error;
 		}
@@ -438,14 +445,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 		/* Convert to ACC_*_MASK flags for struct guest_walker.  */
 		walker->pt_access[walker->level - 1] = FNAME(gpte_access)(pt_access ^ walk_nx_mask);
-	} while (!FNAME(is_last_gpte)(mmu, walker->level, pte));
+	} while (!FNAME(is_last_gpte)(w, walker->level, pte));
 
 	pte_pkey = FNAME(gpte_pkeys)(vcpu, pte);
 	accessed_dirty = have_ad ? pte_access & PT_GUEST_ACCESSED_MASK : 0;
 
 	/* Convert to ACC_*_MASK flags for struct guest_walker.  */
 	walker->pte_access = FNAME(gpte_access)(pte_access ^ walk_nx_mask);
-	errcode = permission_fault(vcpu, mmu, walker->pte_access, pte_pkey, access);
+	errcode = permission_fault(vcpu, w, walker->pte_access, pte_pkey, access);
 	if (unlikely(errcode))
 		goto error;
 
@@ -457,7 +464,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		gfn += pse36_gfn_delta(pte);
 #endif
 
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(gfn),
+	real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(gfn),
 				     access | PFERR_GUEST_FINAL_MASK,
 				     &walker->fault, walker->pte_access);
 	if (real_gpa == INVALID_GPA)
@@ -466,7 +473,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	walker->gfn = real_gpa >> PAGE_SHIFT;
 
 	if (!write_fault)
-		FNAME(protect_clean_gpte)(mmu, &walker->pte_access, pte);
+		FNAME(protect_clean_gpte)(w, &walker->pte_access, pte);
 	else
 		/*
 		 * On a write fault, fold the dirty bit into accessed_dirty.
@@ -477,7 +484,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			(PT_GUEST_DIRTY_SHIFT - PT_GUEST_ACCESSED_SHIFT);
 
 	if (unlikely(!accessed_dirty)) {
-		ret = FNAME(update_accessed_dirty_bits)(vcpu, mmu, walker,
+		ret = FNAME(update_accessed_dirty_bits)(vcpu, w, walker,
 							addr, write_fault);
 		if (unlikely(ret < 0))
 			goto error;
@@ -539,7 +546,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->fault.address = addr;
-	walker->fault.nested_page_fault = mmu != vcpu->arch.walk_mmu;
+	walker->fault.nested_page_fault = w != &vcpu->arch.walk_mmu->w;
 	walker->fault.async_page_fault = false;
 
 	trace_kvm_mmu_walker_error(walker->fault.error_code);
@@ -549,7 +556,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 static int FNAME(walk_addr)(struct guest_walker *walker,
 			    struct kvm_vcpu *vcpu, gpa_t addr, u64 access)
 {
-	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu, addr,
+	return FNAME(walk_addr_generic)(walker, vcpu, &vcpu->arch.mmu->w, addr,
 					access);
 }
 
@@ -565,7 +572,7 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access & FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(&vcpu->arch.mmu->w, &pte_access, gpte);
 
 	return kvm_mmu_prefetch_sptes(vcpu, gfn, spte, 1, pte_access);
 }
@@ -895,7 +902,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	WARN_ON_ONCE((addr >> 32) && mmu == vcpu->arch.walk_mmu);
 #endif
 
-	r = FNAME(walk_addr_generic)(&walker, vcpu, mmu, addr, access);
+	r = FNAME(walk_addr_generic)(&walker, vcpu, &mmu->w, addr, access);
 
 	if (r) {
 		gpa = gfn_to_gpa(walker.gfn);
@@ -945,7 +952,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access;
 	pte_access &= FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(&vcpu->arch.mmu->w, &pte_access, gpte);
 
 	if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access))
 		return 0;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5e55597533b..0f44482d4be0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1071,7 +1071,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
 	 * to an L1 GPA.
 	 */
-	real_gpa = kvm_translate_gpa(vcpu, mmu, gfn_to_gpa(pdpt_gfn),
+	real_gpa = kvm_translate_gpa(vcpu, &mmu->w, gfn_to_gpa(pdpt_gfn),
 				     PFERR_USER_MASK | PFERR_WRITE_MASK |
 				     PFERR_GUEST_PAGE_MASK, NULL, 0);
 	if (real_gpa == INVALID_GPA)
@@ -8090,7 +8090,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 	 * shadow page table for L2 guest.
 	 */
 	if (vcpu_match_mmio_gva(vcpu, gva) && (!is_paging(vcpu) ||
-	    !permission_fault(vcpu, vcpu->arch.walk_mmu,
+	    !permission_fault(vcpu, &vcpu->arch.walk_mmu->w,
 			      vcpu->arch.mmio_access, 0, access))) {
 		*gpa = vcpu->arch.mmio_gfn << PAGE_SHIFT |
 					(gva & (PAGE_SIZE - 1));
-- 
2.52.0



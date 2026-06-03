Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03B46AED3
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484310; cv=none; b=jJF95lYenIbWMDiWGOMSZ9dzD56WClhNgHlYFLDRBqHlPQf+F3BVgyhpHB+aaOpTRZ9yY185Ti9wbtCRrfaY1TSIZrndLtezhwvQwWl+1igKLSQC3/zLchn4XmASx3ACJ1dvtzNSCEf5JqUFTC4JFFCVgD3Xz/IOlqfkX26VBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484310; c=relaxed/simple;
	bh=djN/hm4AwRtZ8NpedWcbswFxmPcIEC7F0wVM19V4Rg8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRbmS/avvdg3dkYTge6ei0knfjZUDSkjtSBQ/q2efTA0OQENRtm+nUYcL7hMS9bk+VPhhPE3pelTwWg9NjJyFK2GZASsjy1uXivL3UxaPNpGV8U3gjQ23N5UG6DnPrUOhu14Oh3uouagOkPhW/YCa+o0gViTEDbxxLDCk0ByAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hh01+lzS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh01+lzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luLcusphFBiPBFQio41n1QYGFXq6KpOLVjHhKcLgS8s=;
	b=hh01+lzSrfa03kwT6yC0eqGJrpVSGXKuOgGz5N9CKMlTwp3nRsfBRbsq6ei3uzKajeCRGM
	FrDpMXRD+qHqDcH17o7Cuwn2Kzf7CP/rOKSlhYxmFB2zeZMFvMP4lfDfk5/z33BOe5Aezv
	JP1O3CG9I8cu28wlRfDARPeSiKImrhI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-54Qgg9weMCOLbrTcK8J2Ag-1; Wed,
 03 Jun 2026 06:58:23 -0400
X-MC-Unique: 54Qgg9weMCOLbrTcK8J2Ag-1
X-Mimecast-MFC-AGG-ID: 54Qgg9weMCOLbrTcK8J2Ag_1780484302
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DE4C180044D;
	Wed,  3 Jun 2026 10:58:22 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3203830001A1;
	Wed,  3 Jun 2026 10:58:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 12/24] KVM: x86/mmu: move CPU-related fields to struct kvm_pagewalk
Date: Wed,  3 Jun 2026 06:58:02 -0400
Message-ID: <20260603105814.10236-13-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

struct kvm_pagewalk's behavior depends on the CPU state and its
page format.  Move related fields so that walk_mmu remains
self contained.

Note that for now, some of the accessors still use kvm_mmu
to split the churn.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  4 +--
 arch/x86/kvm/mmu/mmu.c          | 52 ++++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h  | 40 ++++++++++++-------------
 3 files changed, 46 insertions(+), 50 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fb468e234b37..33c505a15015 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -487,6 +487,8 @@ struct kvm_pagewalk {
 	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			    gpa_t gva_or_gpa, u64 access,
 			    struct x86_exception *exception);
+	union kvm_cpu_role cpu_role;
+	struct rsvd_bits_validate guest_rsvd_check;
 };
 
 struct kvm_mmu {
@@ -497,7 +499,6 @@ struct kvm_mmu {
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
 	hpa_t mirror_root_hpa;
-	union kvm_cpu_role cpu_role;
 	union kvm_mmu_page_role root_role;
 
 	/*
@@ -527,7 +528,6 @@ struct kvm_mmu {
 	 * the bits spte never used.
 	 */
 	struct rsvd_bits_validate shadow_zero_check;
-	struct rsvd_bits_validate guest_rsvd_check;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4fbb7508e241..e2bfecf655d9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -226,7 +226,7 @@ BUILD_MMU_ROLE_REGS_ACCESSOR(efer, lma, EFER_LMA);
 #define BUILD_MMU_ROLE_ACCESSOR(base_or_ext, reg, name)		\
 static inline bool __maybe_unused is_##reg##_##name(struct kvm_mmu *mmu)	\
 {								\
-	return !!(mmu->cpu_role. base_or_ext . reg##_##name);	\
+	return !!(mmu->w.cpu_role. base_or_ext . reg##_##name);	\
 }
 BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
@@ -239,17 +239,17 @@ BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);
 
 static inline bool has_pferr_fetch(struct kvm_mmu *mmu)
 {
-	return mmu->cpu_role.ext.has_pferr_fetch;
+	return mmu->w.cpu_role.ext.has_pferr_fetch;
 }
 
 static inline bool is_cr0_pg(struct kvm_mmu *mmu)
 {
-        return mmu->cpu_role.base.level > 0;
+        return mmu->w.cpu_role.base.level > 0;
 }
 
 static inline bool is_cr4_pae(struct kvm_mmu *mmu)
 {
-        return !mmu->cpu_role.base.has_4_byte_gpte;
+        return !mmu->w.cpu_role.base.has_4_byte_gpte;
 }
 
 static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)
@@ -2478,7 +2478,7 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 	iterator->level = vcpu->arch.mmu->root_role.level;
 
 	if (iterator->level >= PT64_ROOT_4LEVEL &&
-	    vcpu->arch.mmu->cpu_role.base.level < PT64_ROOT_4LEVEL &&
+	    vcpu->arch.mmu->w.cpu_role.base.level < PT64_ROOT_4LEVEL &&
 	    !vcpu->arch.mmu->root_role.direct)
 		iterator->level = PT32E_ROOT_LEVEL;
 
@@ -4083,7 +4083,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * On SVM, reading PDPTRs might access guest memory, which might fault
 	 * and thus might sleep.  Grab the PDPTRs before acquiring mmu_lock.
 	 */
-	if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
+	if (mmu->w.cpu_role.base.level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
 			pdptrs[i] = mmu->w.get_pdptr(vcpu, i);
 			if (!(pdptrs[i] & PT_PRESENT_MASK))
@@ -4107,7 +4107,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
 	 */
-	if (mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+	if (mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
 				      mmu->root_role.level);
 		mmu->root.hpa = root;
@@ -4146,7 +4146,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	for (i = 0; i < 4; ++i) {
 		WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-		if (mmu->cpu_role.base.level == PT32E_ROOT_LEVEL) {
+		if (mmu->w.cpu_role.base.level == PT32E_ROOT_LEVEL) {
 			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
 				mmu->pae_root[i] = INVALID_PAE_ROOT;
 				continue;
@@ -4160,7 +4160,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		 * directory. Othwerise each PAE page direct shadows one guest
 		 * PAE page directory so that quadrant should be 0.
 		 */
-		quadrant = (mmu->cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
+		quadrant = (mmu->w.cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
 
 		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
@@ -4196,7 +4196,7 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
 	 */
 	if (mmu->root_role.direct ||
-	    mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL ||
+	    mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL ||
 	    mmu->root_role.level < PT64_ROOT_4LEVEL)
 		return 0;
 
@@ -4301,7 +4301,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	if (vcpu->arch.mmu->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+	if (vcpu->arch.mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL) {
 		hpa_t root = vcpu->arch.mmu->root.hpa;
 
 		if (!is_unsync_root(root))
@@ -5387,9 +5387,9 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 					struct kvm_mmu *context)
 {
-	__reset_rsvds_bits_mask(&context->guest_rsvd_check,
+	__reset_rsvds_bits_mask(&context->w.guest_rsvd_check,
 				vcpu->arch.reserved_gpa_bits,
-				context->cpu_role.base.level, is_efer_nx(context),
+				context->w.cpu_role.base.level, is_efer_nx(context),
 				guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES),
 				is_cr4_pse(context),
 				guest_cpuid_is_amd_compatible(vcpu));
@@ -5436,7 +5436,7 @@ static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
 static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
 		struct kvm_mmu *context, bool execonly, int huge_page_level)
 {
-	__reset_rsvds_bits_mask_ept(&context->guest_rsvd_check,
+	__reset_rsvds_bits_mask_ept(&context->w.guest_rsvd_check,
 				    vcpu->arch.reserved_gpa_bits, execonly,
 				    huge_page_level);
 }
@@ -5813,7 +5813,7 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	if (is_cr0_wp(mmu) == cr0_wp)
 		return;
 
-	mmu->cpu_role.base.cr0_wp = cr0_wp;
+	mmu->w.cpu_role.base.cr0_wp = cr0_wp;
 	reset_guest_paging_metadata(vcpu, mmu);
 }
 
@@ -5872,11 +5872,11 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 	union kvm_mmu_page_role root_role = kvm_calc_tdp_mmu_root_page_role(vcpu, cpu_role);
 
-	if (cpu_role.as_u64 == context->cpu_role.as_u64 &&
+	if (cpu_role.as_u64 == context->w.cpu_role.as_u64 &&
 	    root_role.word == context->root_role.word)
 		return;
 
-	context->cpu_role.as_u64 = cpu_role.as_u64;
+	context->w.cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
@@ -5900,11 +5900,11 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 				    union kvm_cpu_role cpu_role,
 				    union kvm_mmu_page_role root_role)
 {
-	if (cpu_role.as_u64 == context->cpu_role.as_u64 &&
+	if (cpu_role.as_u64 == context->w.cpu_role.as_u64 &&
 	    root_role.word == context->root_role.word)
 		return;
 
-	context->cpu_role.as_u64 = cpu_role.as_u64;
+	context->w.cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 
 	if (!is_cr0_pg(context))
@@ -6006,9 +6006,9 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
 						   execonly, level, mbec);
 
-	if (new_mode.as_u64 != context->cpu_role.as_u64) {
+	if (new_mode.as_u64 != context->w.cpu_role.as_u64) {
 		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
-		context->cpu_role.as_u64 = new_mode.as_u64;
+		context->w.cpu_role.as_u64 = new_mode.as_u64;
 		context->root_role.word = new_mode.base.word;
 
 		context->page_fault = ept_page_fault;
@@ -6042,10 +6042,10 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 {
 	struct kvm_mmu *g_context = &vcpu->arch.nested_mmu;
 
-	if (new_mode.as_u64 == g_context->cpu_role.as_u64)
+	if (new_mode.as_u64 == g_context->w.cpu_role.as_u64)
 		return;
 
-	g_context->cpu_role.as_u64   = new_mode.as_u64;
+	g_context->w.cpu_role.as_u64   = new_mode.as_u64;
 	g_context->w.inject_page_fault = kvm_inject_page_fault;
 	g_context->w.get_pdptr         = kvm_pdptr_read;
 	g_context->w.get_guest_pgd     = get_guest_cr3;
@@ -6107,9 +6107,9 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.root_mmu.root_role.invalid = 1;
 	vcpu->arch.guest_mmu.root_role.invalid = 1;
 	vcpu->arch.nested_mmu.root_role.invalid = 1;
-	vcpu->arch.root_mmu.cpu_role.ext.valid = 0;
-	vcpu->arch.guest_mmu.cpu_role.ext.valid = 0;
-	vcpu->arch.nested_mmu.cpu_role.ext.valid = 0;
+	vcpu->arch.root_mmu.w.cpu_role.ext.valid = 0;
+	vcpu->arch.guest_mmu.w.cpu_role.ext.valid = 0;
+	vcpu->arch.nested_mmu.w.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
 	KVM_BUG_ON(!kvm_can_set_cpuid_and_feature_msrs(vcpu), vcpu->kvm);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ef112ca1e405..10b1e7a08e90 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -55,7 +55,7 @@
 	#define PT_LEVEL_BITS 9
 	#define PT_GUEST_DIRTY_SHIFT 9
 	#define PT_GUEST_ACCESSED_SHIFT 8
-	#define PT_HAVE_ACCESSED_DIRTY(mmu) (!(mmu)->cpu_role.base.ad_disabled)
+	#define PT_HAVE_ACCESSED_DIRTY(w) (!(w)->cpu_role.base.ad_disabled)
 	#define PT_MAX_FULL_LEVELS PT64_ROOT_MAX_LEVEL
 #else
 	#error Invalid PTTYPE value
@@ -109,11 +109,10 @@ static gfn_t gpte_to_gfn_lvl(pt_element_t gpte, int lvl)
 static inline void FNAME(protect_clean_gpte)(struct kvm_pagewalk *w, unsigned *access,
 					     unsigned gpte)
 {
-	struct kvm_mmu __maybe_unused *mmu = container_of(w, struct kvm_mmu, w);
 	unsigned mask;
 
 	/* dirty bit is not supported, so no need to track it */
-	if (!PT_HAVE_ACCESSED_DIRTY(mmu))
+	if (!PT_HAVE_ACCESSED_DIRTY(w))
 		return;
 
 	BUILD_BUG_ON(PT_WRITABLE_MASK != ACC_WRITE_MASK);
@@ -125,7 +124,7 @@ static inline void FNAME(protect_clean_gpte)(struct kvm_pagewalk *w, unsigned *a
 	*access &= mask;
 }
 
-static inline int FNAME(is_present_gpte)(struct kvm_mmu *mmu,
+static inline int FNAME(is_present_gpte)(struct kvm_pagewalk *w,
 					 unsigned long pte)
 {
 #if PTTYPE != PTTYPE_EPT
@@ -135,7 +134,7 @@ static inline int FNAME(is_present_gpte)(struct kvm_mmu *mmu,
 	 * For EPT, an entry is present if any of bits 2:0 are set.
 	 * With mode-based execute control, bit 10 also indicates presence.
 	 */
-	return pte & (7 | (mmu_has_mbec(mmu) ? VMX_EPT_USER_EXECUTABLE_MASK : 0));
+	return pte & (7 | (w->cpu_role.base.cr4_smep ? VMX_EPT_USER_EXECUTABLE_MASK : 0));
 #endif
 }
 
@@ -150,25 +149,25 @@ static bool FNAME(is_bad_mt_xwr)(struct rsvd_bits_validate *rsvd_check, u64 gpte
 
 static bool FNAME(is_rsvd_bits_set)(struct kvm_pagewalk *w, u64 gpte, int level)
 {
-	struct kvm_mmu *mmu = container_of(w, struct kvm_mmu, w);
-
-	return __is_rsvd_bits_set(&mmu->guest_rsvd_check, gpte, level) ||
-	       FNAME(is_bad_mt_xwr)(&mmu->guest_rsvd_check, gpte);
+	return __is_rsvd_bits_set(&w->guest_rsvd_check, gpte, level) ||
+	       FNAME(is_bad_mt_xwr)(&w->guest_rsvd_check, gpte);
 }
 
 static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu_page *sp, u64 *spte,
 				  u64 gpte)
 {
-	if (!FNAME(is_present_gpte)(vcpu->arch.mmu, gpte))
+	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
+
+	if (!FNAME(is_present_gpte)(w, gpte))
 		goto no_present;
 
 	/* Prefetch only accessed entries (unless A/D bits are disabled). */
-	if (PT_HAVE_ACCESSED_DIRTY(vcpu->arch.mmu) &&
+	if (PT_HAVE_ACCESSED_DIRTY(w) &&
 	    !(gpte & PT_GUEST_ACCESSED_MASK))
 		goto no_present;
 
-	if (FNAME(is_rsvd_bits_set)(&vcpu->arch.mmu->w, gpte, PG_LEVEL_4K))
+	if (FNAME(is_rsvd_bits_set)(w, gpte, PG_LEVEL_4K))
 		goto no_present;
 
 	return false;
@@ -213,7 +212,6 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 					     struct guest_walker *walker,
 					     gpa_t addr, int write_fault)
 {
-	struct kvm_mmu __maybe_unused *mmu = container_of(w, struct kvm_mmu, w);
 	unsigned level, index;
 	pt_element_t pte, orig_pte;
 	pt_element_t __user *ptep_user;
@@ -221,7 +219,7 @@ static int FNAME(update_accessed_dirty_bits)(struct kvm_vcpu *vcpu,
 	int ret;
 
 	/* dirty/accessed bits are not supported, so no need to update them */
-	if (!PT_HAVE_ACCESSED_DIRTY(mmu))
+	if (!PT_HAVE_ACCESSED_DIRTY(w))
 		return 0;
 
 	for (level = walker->max_level; level >= walker->level; --level) {
@@ -285,8 +283,6 @@ static inline unsigned FNAME(gpte_pkeys)(struct kvm_vcpu *vcpu, u64 gpte)
 static inline bool FNAME(is_last_gpte)(struct kvm_pagewalk *w,
 				       unsigned int level, unsigned int gpte)
 {
-	struct kvm_mmu __maybe_unused *mmu = container_of(w, struct kvm_mmu, w);
-
 	/*
 	 * For EPT and PAE paging (both variants), bit 7 is either reserved at
 	 * all level or indicates a huge page (ignoring CR3/EPTP).  In either
@@ -302,7 +298,7 @@ static inline bool FNAME(is_last_gpte)(struct kvm_pagewalk *w,
 	 * is not reserved and does not indicate a large page at this level,
 	 * so clear PT_PAGE_SIZE_MASK in gpte if that is the case.
 	 */
-	gpte &= level - (PT32_ROOT_LEVEL + mmu->cpu_role.ext.cr4_pse);
+	gpte &= level - (PT32_ROOT_LEVEL + w->cpu_role.ext.cr4_pse);
 #endif
 	/*
 	 * PG_LEVEL_4K always terminates.  The RHS has bit 7 set
@@ -341,16 +337,16 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 	trace_kvm_mmu_pagetable_walk(addr, access);
 retry_walk:
-	walker->level = mmu->cpu_role.base.level;
+	walker->level = w->cpu_role.base.level;
 	pte           = kvm_mmu_get_guest_pgd(vcpu, w);
-	have_ad       = PT_HAVE_ACCESSED_DIRTY(mmu);
+	have_ad       = PT_HAVE_ACCESSED_DIRTY(w);
 
 #if PTTYPE == 64
 	walk_nx_mask = 1ULL << PT64_NX_SHIFT;
 	if (walker->level == PT32E_ROOT_LEVEL) {
 		pte = w->get_pdptr(vcpu, (addr >> 30) & 3);
 		trace_kvm_mmu_paging_element(pte, walker->level);
-		if (!FNAME(is_present_gpte)(mmu, pte))
+		if (!FNAME(is_present_gpte)(w, pte))
 			goto error;
 		--walker->level;
 	}
@@ -433,7 +429,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 */
 		pte_access = pt_access & (pte ^ walk_nx_mask);
 
-		if (unlikely(!FNAME(is_present_gpte)(mmu, pte)))
+		if (unlikely(!FNAME(is_present_gpte)(w, pte)))
 			goto error;
 
 		if (unlikely(FNAME(is_rsvd_bits_set)(w, pte, walker->level))) {
@@ -655,7 +651,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	WARN_ON_ONCE(gw->gfn != base_gfn);
 	direct_access = gw->pte_access;
 
-	top_level = vcpu->arch.mmu->cpu_role.base.level;
+	top_level = vcpu->arch.mmu->w.cpu_role.base.level;
 	if (top_level == PT32E_ROOT_LEVEL)
 		top_level = PT32_ROOT_LEVEL;
 	/*
-- 
2.52.0



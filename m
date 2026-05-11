Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775940627B
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512032; cv=none; b=Dskp2xQ3VJhXsZUMJp1lES7WTKC2L+3pC2pWD01HWs6C6nd1J6PtJ4Hj2mEPUXMHI0Kla4VuKOf7coF3X6a8h+a4HfzIDwlkI9Auf1gT5L61Y0JCSDvwoBY4UnscHcwgKKDrwytLFV+xbtumpwFOmgjqF/SE9Jl5vKBgU0h0RGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512032; c=relaxed/simple;
	bh=EvYEnPVUwoIBmAL3+z9eRXlsWnfjGkgPrfqsS71C5vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dggg8C/oCvaFBJIkPI3+Tj9CkvWQYQWM1jEIYZqYURakuj6GJ0YBICGEexjjqNaD03S/Wp44NgFzkoUvjCFVz0chUE1FTsEMkf0evwAzP+6XjB7i1nOJJoUR8czSIXE2J6X8vwM3NlK+kWXfCmBvi+jp3j13x0sz+Z1KmfhaOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RWi+/u8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWi+/u8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feWyV9Wph6RQL/aBtfjnR07jc9nfjrLDyzgRe5NNMgk=;
	b=RWi+/u8QzMQcnPpsWC5pgqbHDJL9l3H9dxHmMfURvB5kglDNfovYSr2b0RpktfVB861L34
	15aSKevps3VPxhhQbkCMm8LOfkISJBfJlys/e9+aycVVZBOIdrdl/cov7YGI58UKPjGwaR
	0IFSlxl9IqltaB6ZWwK/1B1Kwtl9+Tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-esmdMtUlND2BxGoG9ldz-w-1; Mon,
 11 May 2026 11:07:04 -0400
X-MC-Unique: esmdMtUlND2BxGoG9ldz-w-1
X-Mimecast-MFC-AGG-ID: esmdMtUlND2BxGoG9ldz-w_1778512023
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28AC418007FE;
	Mon, 11 May 2026 15:07:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 786AA1800906;
	Mon, 11 May 2026 15:07:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 17/22] KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_mmu
Date: Mon, 11 May 2026 11:06:43 -0400
Message-ID: <20260511150648.685374-18-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Now that root_mmu.w always has the same content as cpu_walk, replace
it with just a pointer to cpu_walk.  For guest_mmu, introduce a second
struct kvm_pagewalk and point to it.  It is now clear that non-MMU code
does cares about page walks, but it funnels (almost) all interactions
with the TLB to mmu.c.

It is left as an exercise to the reader to split kvm_pagewalk to its own
file...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  7 ++-
 arch/x86/kvm/mmu.h              |  4 +-
 arch/x86/kvm/mmu/mmu.c          | 97 +++++++++++++--------------------
 arch/x86/kvm/mmu/paging_tmpl.h  | 14 ++---
 arch/x86/kvm/svm/nested.c       |  9 ++-
 arch/x86/kvm/vmx/nested.c       | 11 ++--
 arch/x86/kvm/x86.c              |  2 +-
 7 files changed, 63 insertions(+), 81 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2feb05475867..3e7c2e1920c9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -504,11 +504,11 @@ struct kvm_pagewalk {
 };
 
 struct kvm_mmu {
-	struct kvm_pagewalk w;
-
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
+	struct kvm_pagewalk *w;
+
 	struct kvm_mmu_root_info root;
 	hpa_t mirror_root_hpa;
 	union kvm_mmu_page_role root_role;
@@ -862,8 +862,9 @@ struct kvm_vcpu_arch {
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
 
-	/* L1 MMU when running nested */
+	/* L1 TDP when running nested */
 	struct kvm_mmu guest_mmu;
+	struct kvm_pagewalk tdp_walk;
 
 	/*
 	 * Pagewalk context used for gva_to_gpa translations.
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 0f4320ef9767..021ca26a9995 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -180,7 +180,7 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	 * still refresh cpu_walk, so as to honor L2's CR0.WP when translating
 	 * L2 GVAs to GPAs.
 	 */
-	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
+	if (!tdp_enabled || w == &vcpu->arch.tdp_walk)
 		return;
 
 	__kvm_mmu_refresh_passthrough_bits(vcpu, w);
@@ -306,7 +306,7 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.guest_mmu.w)
+	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.tdp_walk)
 		return gpa;
 	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
 							    exception,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 75c8d7992d8b..6a14e6764eb7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2473,12 +2473,14 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
 					struct kvm_vcpu *vcpu, hpa_t root,
 					u64 addr)
 {
+	struct kvm_pagewalk *w = vcpu->arch.mmu->w;
+
 	iterator->addr = addr;
 	iterator->shadow_addr = root;
 	iterator->level = vcpu->arch.mmu->root_role.level;
 
 	if (iterator->level >= PT64_ROOT_4LEVEL &&
-	    vcpu->arch.mmu->w.cpu_role.base.level < PT64_ROOT_4LEVEL &&
+	    w->cpu_role.base.level < PT64_ROOT_4LEVEL &&
 	    !vcpu->arch.mmu->root_role.direct)
 		iterator->level = PT32E_ROOT_LEVEL;
 
@@ -4066,12 +4068,13 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = mmu->w;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
 	int quadrant, i, r;
 	hpa_t root;
 
-	root_pgd = kvm_mmu_get_guest_pgd(vcpu, &mmu->w);
+	root_pgd = kvm_mmu_get_guest_pgd(vcpu, mmu->w);
 	root_gfn = (root_pgd & __PT_BASE_ADDR_MASK) >> PAGE_SHIFT;
 
 	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
@@ -4083,9 +4086,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * On SVM, reading PDPTRs might access guest memory, which might fault
 	 * and thus might sleep.  Grab the PDPTRs before acquiring mmu_lock.
 	 */
-	if (mmu->w.cpu_role.base.level == PT32E_ROOT_LEVEL) {
+	if (w->cpu_role.base.level == PT32E_ROOT_LEVEL) {
 		for (i = 0; i < 4; ++i) {
-			pdptrs[i] = mmu->w.get_pdptr(vcpu, i);
+			pdptrs[i] = w->get_pdptr(vcpu, i);
 			if (!(pdptrs[i] & PT_PRESENT_MASK))
 				continue;
 
@@ -4107,7 +4110,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
 	 */
-	if (mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+	if (w->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
 				      mmu->root_role.level);
 		mmu->root.hpa = root;
@@ -4146,7 +4149,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	for (i = 0; i < 4; ++i) {
 		WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-		if (mmu->w.cpu_role.base.level == PT32E_ROOT_LEVEL) {
+		if (w->cpu_role.base.level == PT32E_ROOT_LEVEL) {
 			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
 				mmu->pae_root[i] = INVALID_PAE_ROOT;
 				continue;
@@ -4160,7 +4163,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		 * directory. Othwerise each PAE page direct shadows one guest
 		 * PAE page directory so that quadrant should be 0.
 		 */
-		quadrant = (mmu->w.cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
+		quadrant = (w->cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
 
 		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
@@ -4184,6 +4187,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = mmu->w;
 	bool need_pml5 = mmu->root_role.level > PT64_ROOT_4LEVEL;
 	u64 *pml5_root = NULL;
 	u64 *pml4_root = NULL;
@@ -4196,7 +4200,7 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
 	 */
 	if (mmu->root_role.direct ||
-	    mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL ||
+	    w->cpu_role.base.level >= PT64_ROOT_4LEVEL ||
 	    mmu->root_role.level < PT64_ROOT_4LEVEL)
 		return 0;
 
@@ -4301,7 +4305,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	if (vcpu->arch.mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+	if (vcpu->arch.mmu->w->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
 		hpa_t root = vcpu->arch.mmu->root.hpa;
 
 		if (!is_unsync_root(root))
@@ -4543,7 +4547,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
 	if (arch.direct_map)
 		arch.cr3 = (unsigned long)INVALID_GPA;
 	else
-		arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, &vcpu->arch.mmu->w);
+		arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu->w);
 
 	return kvm_setup_async_pf(vcpu, fault->addr,
 				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
@@ -4565,7 +4569,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, &vcpu->arch.mmu->w))
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu->w))
 		return;
 
 	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
@@ -5119,7 +5123,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_map_private_pfn);
 static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
-	context->w.gva_to_gpa = nonpaging_gva_to_gpa;
 	context->sync_spte = NULL;
 }
 
@@ -5434,9 +5437,9 @@ static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
 }
 
 static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
-		struct kvm_mmu *context, bool execonly, int huge_page_level)
+		bool execonly, int huge_page_level)
 {
-	__reset_rsvds_bits_mask_ept(&context->w.guest_rsvd_check,
+	__reset_rsvds_bits_mask_ept(&vcpu->arch.tdp_walk.guest_rsvd_check,
 				    vcpu->arch.reserved_gpa_bits, execonly,
 				    huge_page_level);
 }
@@ -5743,21 +5746,19 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, w);
-	update_permission_bitmask(w, w == &vcpu->arch.guest_mmu.w, false);
+	update_permission_bitmask(w, w == &vcpu->arch.tdp_walk, false);
 	update_pkru_bitmask(w);
 }
 
 static void paging64_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging64_page_fault;
-	context->w.gva_to_gpa = paging64_gva_to_gpa;
 	context->sync_spte = paging64_sync_spte;
 }
 
 static void paging32_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging32_page_fault;
-	context->w.gva_to_gpa = paging32_gva_to_gpa;
 	context->sync_spte = paging32_sync_spte;
 }
 
@@ -5872,49 +5873,31 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 	union kvm_mmu_page_role root_role = kvm_calc_tdp_mmu_root_page_role(vcpu, cpu_role);
 
-	if (cpu_role.as_u64 == context->w.cpu_role.as_u64 &&
-	    root_role.word == context->root_role.word)
+	if (root_role.word == context->root_role.word)
 		return;
 
-	context->w.cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
 
-	context->w.inject_page_fault = kvm_inject_page_fault;
-	context->w.get_pdptr = kvm_pdptr_read;
-	context->w.get_guest_pgd = get_guest_cr3;
-
-	if (!is_cr0_pg(&context->w))
-		context->w.gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_cr4_pae(&context->w))
-		context->w.gva_to_gpa = paging64_gva_to_gpa;
-	else
-		context->w.gva_to_gpa = paging32_gva_to_gpa;
-
-	reset_guest_paging_metadata(vcpu, &context->w);
 	reset_tdp_shadow_zero_bits_mask(context);
 }
 
 static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *context,
-				    union kvm_cpu_role cpu_role,
 				    union kvm_mmu_page_role root_role)
 {
-	if (cpu_role.as_u64 == context->w.cpu_role.as_u64 &&
-	    root_role.word == context->root_role.word)
+	if (root_role.word == context->root_role.word)
 		return;
 
-	context->w.cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 
-	if (!is_cr0_pg(&context->w))
+	if (!is_cr0_pg(context->w))
 		nonpaging_init_context(context);
-	else if (is_cr4_pae(&context->w))
+	else if (is_cr4_pae(context->w))
 		paging64_init_context(context);
 	else
 		paging32_init_context(context);
 
-	reset_guest_paging_metadata(vcpu, &context->w);
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -5940,7 +5923,7 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 	 */
 	root_role.efer_nx = true;
 
-	shadow_mmu_init_context(vcpu, context, cpu_role, root_role);
+	shadow_mmu_init_context(vcpu, context, root_role);
 }
 
 static void init_kvm_page_walk(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
@@ -5980,13 +5963,15 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
 	cpu_role.base.cr4_smep = (misc_ctl & SVM_MISC_ENABLE_GMET) != 0;
 
+	init_kvm_page_walk(vcpu, &vcpu->arch.tdp_walk, cpu_role);
+
 	root_role = cpu_role.base;
 	root_role.level = kvm_mmu_get_tdp_level(vcpu);
 	if (root_role.level == PT64_ROOT_5LEVEL &&
 	    cpu_role.base.level == PT64_ROOT_4LEVEL)
 		root_role.passthrough = 1;
 
-	shadow_mmu_init_context(vcpu, context, cpu_role, root_role);
+	shadow_mmu_init_context(vcpu, context, root_role);
 	kvm_mmu_new_pgd(vcpu, nested_cr3);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_npt_mmu);
@@ -6027,18 +6012,20 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
 						   execonly, level, mbec);
 
-	if (new_mode.as_u64 != context->w.cpu_role.as_u64) {
+	struct kvm_pagewalk *tdp_walk = &vcpu->arch.tdp_walk;
+
+	if (new_mode.as_u64 != tdp_walk->cpu_role.as_u64) {
 		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
-		context->w.cpu_role.as_u64 = new_mode.as_u64;
+		tdp_walk->cpu_role.as_u64 = new_mode.as_u64;
 		context->root_role.word = new_mode.base.word;
 
 		context->page_fault = ept_page_fault;
-		context->w.gva_to_gpa = ept_gva_to_gpa;
+		tdp_walk->gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(&context->w, true, true);
-		context->w.pkru_mask = 0;
-		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
+		update_permission_bitmask(tdp_walk, true, true);
+		tdp_walk->pkru_mask = 0;
+		reset_rsvds_bits_mask_ept(vcpu, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
 	}
 
@@ -6049,13 +6036,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_ept_mmu);
 static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 			     union kvm_cpu_role cpu_role)
 {
-	struct kvm_mmu *context = &vcpu->arch.root_mmu;
-
 	kvm_init_shadow_mmu(vcpu, cpu_role);
-
-	context->w.inject_page_fault = kvm_inject_page_fault;
-	context->w.get_pdptr         = kvm_pdptr_read;
-	context->w.get_guest_pgd     = get_guest_cr3;
 }
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
@@ -6090,8 +6071,7 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.root_mmu.root_role.invalid = 1;
 	vcpu->arch.guest_mmu.root_role.invalid = 1;
-	vcpu->arch.root_mmu.w.cpu_role.ext.valid = 0;
-	vcpu->arch.guest_mmu.w.cpu_role.ext.valid = 0;
+	vcpu->arch.tdp_walk.cpu_role.ext.valid = 0;
 	vcpu->arch.cpu_walk.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
@@ -6696,11 +6676,12 @@ static void free_mmu_pages(struct kvm_mmu *mmu)
 	free_page((unsigned long)mmu->pml5_root);
 }
 
-static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
+static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, struct kvm_pagewalk *w)
 {
 	struct page *page;
 	int i;
 
+	mmu->w = w;
 	mmu->root.hpa = INVALID_PAGE;
 	mmu->root.pgd = 0;
 	mmu->mirror_root_hpa = INVALID_PAGE;
@@ -6767,11 +6748,11 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu, &vcpu->arch.tdp_walk);
 	if (ret)
 		return ret;
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->arch.cpu_walk);
 	if (ret)
 		goto fail_allocate_root;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e7d68606bb64..e3b064fc2aff 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -157,7 +157,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 				  struct kvm_mmu_page *sp, u64 *spte,
 				  u64 gpte)
 {
-	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
+	struct kvm_pagewalk *w = vcpu->arch.mmu->w;
 
 	if (!FNAME(is_present_gpte)(w, gpte))
 		goto no_present;
@@ -551,7 +551,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 static int FNAME(walk_addr)(struct guest_walker *walker,
 			    struct kvm_vcpu *vcpu, gpa_t addr, u64 access)
 {
-	return FNAME(walk_addr_generic)(walker, vcpu, &vcpu->arch.mmu->w, addr,
+	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu->w, addr,
 					access);
 }
 
@@ -567,7 +567,7 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access & FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(&vcpu->arch.mmu->w, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(vcpu->arch.mmu->w, &pte_access, gpte);
 
 	return kvm_mmu_prefetch_sptes(vcpu, gfn, spte, 1, pte_access);
 }
@@ -650,7 +650,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	WARN_ON_ONCE(gw->gfn != base_gfn);
 	direct_access = gw->pte_access;
 
-	top_level = vcpu->arch.mmu->w.cpu_role.base.level;
+	top_level = vcpu->arch.mmu->w->cpu_role.base.level;
 	if (top_level == PT32E_ROOT_LEVEL)
 		top_level = PT32_ROOT_LEVEL;
 	/*
@@ -839,7 +839,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * otherwise KVM will cache incorrect access information in the SPTE.
 	 */
 	if (fault->write && !(walker.pte_access & ACC_WRITE_MASK) &&
-	    !is_cr0_wp(&vcpu->arch.mmu->w) && !fault->user && fault->slot) {
+	    !is_cr0_wp(vcpu->arch.mmu->w) && !fault->user && fault->slot) {
 		walker.pte_access |= ACC_WRITE_MASK;
 		walker.pte_access &= ~ACC_USER_MASK;
 
@@ -849,7 +849,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		 * then we should prevent the kernel from executing it
 		 * if SMEP is enabled.
 		 */
-		if (is_cr4_smep(&vcpu->arch.mmu->w))
+		if (is_cr4_smep(vcpu->arch.mmu->w))
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 #endif
@@ -947,7 +947,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access;
 	pte_access &= FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(&vcpu->arch.mmu->w, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(vcpu->arch.mmu->w, &pte_access, gpte);
 
 	if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access))
 		return 0;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 2c42064111ab..0cb00f44fc5f 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -98,10 +98,9 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 				svm->nested.ctl.nested_cr3,
 				svm->nested.ctl.misc_ctl);
 
-	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
-	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
-
-	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.tdp_walk.get_guest_pgd     = nested_svm_get_tdp_cr3;
+	vcpu->arch.tdp_walk.get_pdptr         = nested_svm_get_tdp_pdptr;
+	vcpu->arch.tdp_walk.inject_page_fault = nested_svm_inject_npf_exit;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
@@ -2088,7 +2087,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 pte_access)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
+	struct kvm_pagewalk *w = &vcpu->arch.tdp_walk;
 
 	BUG_ON(!mmu_is_nested(vcpu));
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bbb9f9b4a58b..715283a133d9 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -407,7 +407,7 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 			roots |= KVM_MMU_ROOT_PREVIOUS(i);
 	}
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.guest_mmu.w, addr, roots);
+		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.tdp_walk, addr, roots);
 }
 
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
@@ -494,10 +494,10 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	nested_ept_new_eptp(vcpu);
-	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
-	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
+	vcpu->arch.tdp_walk.get_guest_pgd     = nested_ept_get_eptp;
+	vcpu->arch.tdp_walk.get_pdptr       = kvm_pdptr_read;
 
-	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.tdp_walk.inject_page_fault = nested_ept_inject_page_fault;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
@@ -7457,12 +7457,13 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 	return 0;
 }
 
+
 static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 access,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
+	struct kvm_pagewalk *w = &vcpu->arch.tdp_walk;
 
 	BUG_ON(!mmu_is_nested(vcpu));
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 21850893f99c..9300265fcaef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -994,7 +994,7 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
-	fault_walk = fault->nested_page_fault ? &vcpu->arch.mmu->w :
+	fault_walk = fault->nested_page_fault ? &vcpu->arch.tdp_walk :
 						&vcpu->arch.cpu_walk;
 
 	/*
-- 
2.52.0



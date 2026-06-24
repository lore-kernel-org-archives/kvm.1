Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9839B4A1
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336678; cv=none; b=p7X729jxLipglerAEk+ltpUQ0CSN3k2gJqHKs9xue9q+IBy0CGjGNhgcyvfRItdPU7ajkR+D3QJS+QFMWIxT1OOJ33P6UCpqUv9MkvxuLTrgO+oUgCgQD52zOnsP4cXYtlDviHD0tMoxemkBqFKQfIQpec7KwRMah9mbOAY/rfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336678; c=relaxed/simple;
	bh=NgUN/+DO+eghn01KUTstGrA3916V/0i7cQ87g3FbilA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fu3kJlGMG3kqCaqkrYIkyOTiOIQ3at8wOdn+twdCichj+k3PWrv9by69dQ7hy/XDygd2BzaMj6h/WO6hvIYPVqSeXbc/NmrHmgMZOXH1fguwWNjl3QreCHxH08rGAd4mMOzxLfQHAguF//7AD8P2EQbsw8QrNzUOpO+W4HaH7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aRmxGwhi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRmxGwhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0PfK95VdjmQzxepuohSHnDCkmqhOCabU4PoI9pKy70=;
	b=aRmxGwhiei4EbZpkntBKpP/ByeXTk9XWpEmjBjxVH6gIKich7EwC2nZlzPXGg5X5tc7MfF
	90wFOwEUmgmuyiACQDWtooOYUYMTAQdW9SWE+yidf/CUGnGnxfOnPFCLy0TtV3jh2c6m86
	4WbTO7cQbBKuwua6/1q8C+PPlOS5bmo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-LSJXCXBYO5apsoym-VI7aw-1; Wed,
 24 Jun 2026 17:31:13 -0400
X-MC-Unique: LSJXCXBYO5apsoym-VI7aw-1
X-Mimecast-MFC-AGG-ID: LSJXCXBYO5apsoym-VI7aw_1782336672
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EDEB1955F72;
	Wed, 24 Jun 2026 21:31:12 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FB61195608D;
	Wed, 24 Jun 2026 21:31:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 13/19] KVM: x86/mmu: pull struct kvm_pagewalk out of struct kvm_mmu
Date: Wed, 24 Jun 2026 17:30:56 -0400
Message-ID: <20260624213102.71082-14-pbonzini@redhat.com>
In-Reply-To: <20260624213102.71082-1-pbonzini@redhat.com>
References: <20260624213102.71082-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Replace kvm_mmu's w field with a pointer to an external instance of
struct kvm_pagewalk.  This is the first step towards using a single
kvm_pagewalk struct for all GVA walks, whether nested or not.

With this patch, non-MMU code basically does not use kvm_mmu anymore:
it does care about page walks, but it funnels (almost) all interactions
with the TLB to mmu.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |   8 ++-
 arch/x86/kvm/mmu.h              |   2 +-
 arch/x86/kvm/mmu/mmu.c          | 113 ++++++++++++++++++--------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  14 ++--
 arch/x86/kvm/svm/nested.c       |  11 ++--
 arch/x86/kvm/vmx/nested.c       |  13 ++--
 arch/x86/kvm/x86.c              |   2 +-
 7 files changed, 88 insertions(+), 75 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 25288d73cce7..8b9cf364c9f6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -545,11 +545,11 @@ struct kvm_pagewalk {
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
@@ -905,9 +905,11 @@ struct kvm_vcpu_arch {
 
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
+	struct kvm_pagewalk root_gva_walk;
 
-	/* L1 MMU when running nested */
+	/* L1 TDP when running nested */
 	struct kvm_mmu guest_mmu;
+	struct kvm_pagewalk ngpa_walk;
 
 	/*
 	 * Paging state of an L2 guest (used for nested npt)
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2610b996e144..1631fd43c9a1 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -257,7 +257,7 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	 * need to refresh ngva_walk, a.k.a. the walker used to translate L2
 	 * GVAs to GPAs, so as to honor L2's CR0.WP.
 	 */
-	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
+	if (!tdp_enabled || w == &vcpu->arch.ngpa_walk)
 		return;
 
 	__kvm_mmu_refresh_passthrough_bits(vcpu, w);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8b5ffd78565b..3ffaa48b566e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2478,12 +2478,14 @@ static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterato
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
 
@@ -4090,12 +4092,13 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = mmu->w;
 	u64 pdptrs[4], pm_mask;
 	gfn_t root_gfn, root_pgd;
 	int quadrant, i, r;
 	hpa_t root;
 
-	root_pgd = kvm_mmu_get_guest_pgd(vcpu, &mmu->w);
+	root_pgd = kvm_mmu_get_guest_pgd(vcpu, w);
 	root_gfn = (root_pgd & __PT_BASE_ADDR_MASK) >> PAGE_SHIFT;
 
 	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
@@ -4107,9 +4110,9 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
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
 
@@ -4131,7 +4134,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	 * Do we shadow a long mode page table? If so we need to
 	 * write-protect the guests page table root.
 	 */
-	if (mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+	if (w->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, root_gfn, 0,
 				      mmu->root_role.level);
 		mmu->root.hpa = root;
@@ -4170,7 +4173,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 	for (i = 0; i < 4; ++i) {
 		WARN_ON_ONCE(IS_VALID_PAE_ROOT(mmu->pae_root[i]));
 
-		if (mmu->w.cpu_role.base.level == PT32E_ROOT_LEVEL) {
+		if (w->cpu_role.base.level == PT32E_ROOT_LEVEL) {
 			if (!(pdptrs[i] & PT_PRESENT_MASK)) {
 				mmu->pae_root[i] = INVALID_PAE_ROOT;
 				continue;
@@ -4184,7 +4187,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 		 * directory. Othwerise each PAE page direct shadows one guest
 		 * PAE page directory so that quadrant should be 0.
 		 */
-		quadrant = (mmu->w.cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
+		quadrant = (w->cpu_role.base.level == PT32_ROOT_LEVEL) ? i : 0;
 
 		root = mmu_alloc_root(vcpu, root_gfn, quadrant, PT32_ROOT_LEVEL);
 		mmu->pae_root[i] = root | pm_mask;
@@ -4208,6 +4211,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = mmu->w;
 	bool need_pml5 = mmu->root_role.level > PT64_ROOT_4LEVEL;
 	u64 *pml5_root = NULL;
 	u64 *pml4_root = NULL;
@@ -4220,7 +4224,7 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 	 * on demand, as running a 32-bit L1 VMM on 64-bit KVM is very rare.
 	 */
 	if (mmu->root_role.direct ||
-	    mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL ||
+	    w->cpu_role.base.level >= PT64_ROOT_4LEVEL ||
 	    mmu->root_role.level < PT64_ROOT_4LEVEL)
 		return 0;
 
@@ -4325,7 +4329,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 
-	if (vcpu->arch.mmu->w.cpu_role.base.level >= PT64_ROOT_4LEVEL) {
+	if (vcpu->arch.mmu->w->cpu_role.base.level >= PT64_ROOT_4LEVEL) {
 		hpa_t root = vcpu->arch.mmu->root.hpa;
 
 		if (!is_unsync_root(root))
@@ -4567,7 +4571,7 @@ static bool kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu,
 	if (arch.direct_map)
 		arch.cr3 = (unsigned long)INVALID_GPA;
 	else
-		arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, &vcpu->arch.mmu->w);
+		arch.cr3 = kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu->w);
 
 	return kvm_setup_async_pf(vcpu, fault->addr,
 				  kvm_vcpu_gfn_to_hva(vcpu, fault->gfn), &arch);
@@ -5110,7 +5114,7 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 		return;
 
 	if (!vcpu->arch.mmu->root_role.direct &&
-	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, &vcpu->arch.mmu->w))
+	      work->arch.cr3 != kvm_mmu_get_guest_pgd(vcpu, vcpu->arch.mmu->w))
 		return;
 
 	r = kvm_mmu_do_page_fault(vcpu, work->cr2_or_gpa, work->arch.error_code,
@@ -5208,7 +5212,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_map_private_pfn);
 static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
-	context->w.gva_to_gpa = nonpaging_gva_to_gpa;
+	context->w->gva_to_gpa = nonpaging_gva_to_gpa;
 	context->sync_spte = NULL;
 }
 
@@ -5523,9 +5527,9 @@ static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
 }
 
 static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
-		struct kvm_mmu *context, bool execonly, int huge_page_level)
+		bool execonly, int huge_page_level)
 {
-	__reset_rsvds_bits_mask_ept(&context->w.guest_rsvd_check,
+	__reset_rsvds_bits_mask_ept(&vcpu->arch.ngpa_walk.guest_rsvd_check,
 				    vcpu->arch.reserved_gpa_bits, execonly,
 				    huge_page_level);
 }
@@ -5832,21 +5836,21 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, w);
-	update_permission_bitmask(w, w == &vcpu->arch.guest_mmu.w, false);
+	update_permission_bitmask(w, w == &vcpu->arch.ngpa_walk, false);
 	update_pkru_bitmask(w);
 }
 
 static void paging64_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging64_page_fault;
-	context->w.gva_to_gpa = paging64_gva_to_gpa;
+	context->w->gva_to_gpa = paging64_gva_to_gpa;
 	context->sync_spte = paging64_sync_spte;
 }
 
 static void paging32_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging32_page_fault;
-	context->w.gva_to_gpa = paging32_gva_to_gpa;
+	context->w->gva_to_gpa = paging32_gva_to_gpa;
 	context->sync_spte = paging32_sync_spte;
 }
 
@@ -5961,27 +5965,27 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 	union kvm_mmu_page_role root_role = kvm_calc_tdp_mmu_root_page_role(vcpu, cpu_role);
 
-	if (cpu_role.as_u64 == context->w.cpu_role.as_u64 &&
+	if (cpu_role.as_u64 == context->w->cpu_role.as_u64 &&
 	    root_role.word == context->root_role.word)
 		return;
 
-	context->w.cpu_role.as_u64 = cpu_role.as_u64;
+	context->w->cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
 
-	context->w.inject_page_fault = kvm_inject_page_fault;
-	context->w.get_pdptr = kvm_pdptr_read;
-	context->w.get_guest_pgd = get_guest_cr3;
+	context->w->inject_page_fault = kvm_inject_page_fault;
+	context->w->get_pdptr = kvm_pdptr_read;
+	context->w->get_guest_pgd = get_guest_cr3;
 
-	if (!is_cr0_pg(&context->w))
-		context->w.gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_cr4_pae(&context->w))
-		context->w.gva_to_gpa = paging64_gva_to_gpa;
+	if (!is_cr0_pg(context->w))
+		context->w->gva_to_gpa = nonpaging_gva_to_gpa;
+	else if (is_cr4_pae(context->w))
+		context->w->gva_to_gpa = paging64_gva_to_gpa;
 	else
-		context->w.gva_to_gpa = paging32_gva_to_gpa;
+		context->w->gva_to_gpa = paging32_gva_to_gpa;
 
-	reset_guest_paging_metadata(vcpu, &context->w);
+	reset_guest_paging_metadata(vcpu, context->w);
 	reset_tdp_shadow_zero_bits_mask(context);
 }
 
@@ -5989,21 +5993,21 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 				    union kvm_cpu_role cpu_role,
 				    union kvm_mmu_page_role root_role)
 {
-	if (cpu_role.as_u64 == context->w.cpu_role.as_u64 &&
+	if (cpu_role.as_u64 == context->w->cpu_role.as_u64 &&
 	    root_role.word == context->root_role.word)
 		return;
 
-	context->w.cpu_role.as_u64 = cpu_role.as_u64;
+	context->w->cpu_role.as_u64 = cpu_role.as_u64;
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
+	reset_guest_paging_metadata(vcpu, context->w);
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -6095,18 +6099,20 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
 						   execonly, level, mbec);
 
-	if (new_mode.as_u64 != context->w.cpu_role.as_u64) {
+	struct kvm_pagewalk *ngpa_walk = &vcpu->arch.ngpa_walk;
+
+	if (new_mode.as_u64 != ngpa_walk->cpu_role.as_u64) {
 		/* EPT, and thus nested EPT, does not consume CR0, CR4, nor EFER. */
-		context->w.cpu_role.as_u64 = new_mode.as_u64;
+		ngpa_walk->cpu_role.as_u64 = new_mode.as_u64;
 		context->root_role.word = new_mode.base.word;
 
 		context->page_fault = ept_page_fault;
-		context->w.gva_to_gpa = ept_gva_to_gpa;
+		ngpa_walk->gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(&context->w, true, true);
-		context->w.pkru_mask = 0;
-		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
+		update_permission_bitmask(ngpa_walk, true, true);
+		ngpa_walk->pkru_mask = 0;
+		reset_rsvds_bits_mask_ept(vcpu, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
 	}
 
@@ -6121,9 +6127,9 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 
 	kvm_init_shadow_mmu(vcpu, cpu_role);
 
-	context->w.inject_page_fault = kvm_inject_page_fault;
-	context->w.get_pdptr         = kvm_pdptr_read;
-	context->w.get_guest_pgd     = get_guest_cr3;
+	context->w->inject_page_fault = kvm_inject_page_fault;
+	context->w->get_pdptr         = kvm_pdptr_read;
+	context->w->get_guest_pgd     = get_guest_cr3;
 }
 
 static void init_kvm_ngva_walk(struct kvm_vcpu *vcpu,
@@ -6189,8 +6195,8 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.root_mmu.root_role.invalid = 1;
 	vcpu->arch.guest_mmu.root_role.invalid = 1;
-	vcpu->arch.root_mmu.w.cpu_role.ext.valid = 0;
-	vcpu->arch.guest_mmu.w.cpu_role.ext.valid = 0;
+	vcpu->arch.root_gva_walk.cpu_role.ext.valid = 0;
+	vcpu->arch.ngpa_walk.cpu_role.ext.valid = 0;
 	vcpu->arch.ngva_walk.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
@@ -6687,7 +6693,7 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
 
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (w != &vcpu->arch.guest_mmu.w) {
+	if (w == vcpu->arch.gva_walk) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
@@ -6695,9 +6701,13 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
 		if (w == &vcpu->arch.ngva_walk)
 			return;
+
+		mmu = &vcpu->arch.root_mmu;
+	} else {
+		mmu = &vcpu->arch.guest_mmu;
 	}
 
-	mmu = container_of(w, struct kvm_mmu, w);
+	/* Invalidate shadow pages, whether GPA->GVA or nGPA->GPA.  */
 	if (!mmu->sync_spte)
 		return;
 
@@ -6745,7 +6755,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 	}
 
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, &mmu->w, gva, roots);
+		kvm_mmu_invalidate_addr(vcpu, mmu->w, gva, roots);
 	++vcpu->stat.invlpg;
 
 	/*
@@ -6790,11 +6800,12 @@ static void free_mmu_pages(struct kvm_mmu *mmu)
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
@@ -6860,13 +6871,13 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.gva_walk = &vcpu->arch.root_mmu.w;
+	vcpu->arch.gva_walk = &vcpu->arch.root_gva_walk;
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu, &vcpu->arch.ngpa_walk);
 	if (ret)
 		return ret;
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->arch.root_gva_walk);
 	if (ret)
 		goto fail_allocate_root;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9cfae71cd3e6..115f0fd2d4ba 100644
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
@@ -563,7 +563,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 static int FNAME(walk_addr)(struct guest_walker *walker,
 			    struct kvm_vcpu *vcpu, gpa_t addr, u64 access)
 {
-	return FNAME(walk_addr_generic)(walker, vcpu, &vcpu->arch.mmu->w, addr,
+	return FNAME(walk_addr_generic)(walker, vcpu, vcpu->arch.mmu->w, addr,
 					access);
 }
 
@@ -579,7 +579,7 @@ FNAME(prefetch_gpte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access & FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(&vcpu->arch.mmu->w, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(vcpu->arch.mmu->w, &pte_access, gpte);
 
 	return kvm_mmu_prefetch_sptes(vcpu, gfn, spte, 1, pte_access);
 }
@@ -662,7 +662,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	WARN_ON_ONCE(gw->gfn != base_gfn);
 	direct_access = gw->pte_access;
 
-	top_level = vcpu->arch.mmu->w.cpu_role.base.level;
+	top_level = vcpu->arch.mmu->w->cpu_role.base.level;
 	if (top_level == PT32E_ROOT_LEVEL)
 		top_level = PT32_ROOT_LEVEL;
 	/*
@@ -851,7 +851,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * otherwise KVM will cache incorrect access information in the SPTE.
 	 */
 	if (fault->write && !(walker.pte_access & ACC_WRITE_MASK) &&
-	    !is_cr0_wp(&vcpu->arch.mmu->w) && !fault->user && fault->slot) {
+	    !is_cr0_wp(vcpu->arch.mmu->w) && !fault->user && fault->slot) {
 		walker.pte_access |= ACC_WRITE_MASK;
 		walker.pte_access &= ~ACC_USER_MASK;
 
@@ -861,7 +861,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		 * then we should prevent the kernel from executing it
 		 * if SMEP is enabled.
 		 */
-		if (is_cr4_smep(&vcpu->arch.mmu->w))
+		if (is_cr4_smep(vcpu->arch.mmu->w))
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 #endif
@@ -959,7 +959,7 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 	gfn = gpte_to_gfn(gpte);
 	pte_access = sp->role.access;
 	pte_access &= FNAME(gpte_access)(gpte);
-	FNAME(protect_clean_gpte)(&vcpu->arch.mmu->w, &pte_access, gpte);
+	FNAME(protect_clean_gpte)(vcpu->arch.mmu->w, &pte_access, gpte);
 
 	if (sync_mmio_spte(vcpu, &sp->spt[i], gfn, pte_access))
 		return 0;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 713b2508b8ca..97d3fabb8c0d 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -114,17 +114,16 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 				svm->nested.ctl.nested_cr3,
 				svm->nested.ctl.misc_ctl);
 
-	vcpu->arch.mmu->w.get_guest_pgd     = nested_svm_get_tdp_cr3;
-	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
-
-	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
+	vcpu->arch.ngpa_walk.get_guest_pgd     = nested_svm_get_tdp_cr3;
+	vcpu->arch.ngpa_walk.get_pdptr         = nested_svm_get_tdp_pdptr;
+	vcpu->arch.ngpa_walk.inject_page_fault = nested_svm_inject_npf_exit;
 	vcpu->arch.gva_walk              = &vcpu->arch.ngva_walk;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.gva_walk = &vcpu->arch.root_mmu.w;
+	vcpu->arch.gva_walk = vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
@@ -2153,7 +2152,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 pte_access)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
+	struct kvm_pagewalk *w = &vcpu->arch.ngpa_walk;
 
 	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
 		return gpa;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 345ee3323a93..3596d15ae405 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -408,7 +408,7 @@ static void nested_ept_invalidate_addr(struct kvm_vcpu *vcpu, gpa_t eptp,
 			roots |= KVM_MMU_ROOT_PREVIOUS(i);
 	}
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.guest_mmu.w, addr, roots);
+		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.ngpa_walk, addr, roots);
 }
 
 static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
@@ -512,10 +512,10 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	nested_ept_new_eptp(vcpu);
-	vcpu->arch.mmu->w.get_guest_pgd     = nested_ept_get_eptp;
-	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
+	vcpu->arch.ngpa_walk.get_guest_pgd     = nested_ept_get_eptp;
+	vcpu->arch.ngpa_walk.get_pdptr       = kvm_pdptr_read;
 
-	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
+	vcpu->arch.ngpa_walk.inject_page_fault = nested_ept_inject_page_fault;
 
 	vcpu->arch.gva_walk              = &vcpu->arch.ngva_walk;
 }
@@ -523,7 +523,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.gva_walk = &vcpu->arch.root_mmu.w;
+	vcpu->arch.gva_walk = vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
@@ -7465,12 +7465,13 @@ __init int nested_vmx_hardware_setup(int (*exit_handlers[])(struct kvm_vcpu *))
 	return 0;
 }
 
+
 static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 access,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
+	struct kvm_pagewalk *w = &vcpu->arch.ngpa_walk;
 
 	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
 		return gpa;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 43625cc9e934..d6ab17f17d69 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -586,7 +586,7 @@ void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
-	fault_walk = fault->nested_page_fault ? &vcpu->arch.mmu->w :
+	fault_walk = fault->nested_page_fault ? &vcpu->arch.ngpa_walk :
 						vcpu->arch.gva_walk;
 
 	/*
-- 
2.52.0



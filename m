Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653D3E8337
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337361; cv=none; b=QRo1LnBRf9BWJbew04Ev8+5+xebwb1ezUaCy+E15pyKgEdK525akIKBlCzbTkv/l8uneiRiTSSEmQKrpC/mu/G+Mb6R4t0mvIQO+me0tiNQZoEkXpSdfWjV66iPXLjPqi/7yNJQGkt7LTPz0yyugaqe0j0QIAqCUd6+y5uotM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337361; c=relaxed/simple;
	bh=6zkTlBkbEJwn+eqS3isXpj6WpuRCqE3XNugivMqIXYo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTswYDB62b02I3LWHeIf/V4/moBWaf/rWLPPPMAHfF38WGk1JU5Rskm6r55bRovmkFLOXzPztUZsWB05KqmyS/Zjkz/6/H1/G9+LAwOnODC6gVPe6E1uqsnNLjyBc69SDSvFqyADoSri6zu4jTmEsrhjA42ZBD0gfx5Uot5pvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T99tamhV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T99tamhV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D7zq9UOOn6kDJ++32emKcl56WVcxUYluKpZXcgm/kVo=;
	b=T99tamhV+mB/4aMPrpnAGkQYY8IOd15gauAx0actGjLVPVIi8JdOeb1LLlHXD3zToLYymf
	6vOtWpieIcNR6+j4uK7LWxS75T539/1mpHSGLfTOIOyjjdmY7Wsk1sb5ElcKI8r4pwnc+M
	taN+YmVgpHHUEEHTLhJv9AzJBne1kKU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-i5svNFdiNhiQ9jqlYE1bmQ-1; Wed,
 24 Jun 2026 17:42:29 -0400
X-MC-Unique: i5svNFdiNhiQ9jqlYE1bmQ-1
X-Mimecast-MFC-AGG-ID: i5svNFdiNhiQ9jqlYE1bmQ_1782337348
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7523C1955F30;
	Wed, 24 Jun 2026 21:42:28 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0CE10195608D;
	Wed, 24 Jun 2026 21:42:27 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 14/19] KVM: x86/mmu: unify root_gva_walk and ngva_walk
Date: Wed, 24 Jun 2026 17:42:13 -0400
Message-ID: <20260624214218.73796-15-pbonzini@redhat.com>
In-Reply-To: <20260624214218.73796-1-pbonzini@redhat.com>
References: <20260624214218.73796-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

At this point, vcpu->arch.gva_walk and vcpu->arch.root_mmu.w contain
the same information (at least when KVM is not running a nested guest,
i.e. when root_mmu is actually in use); compare init_kvm_page_walk()
on one side with init_kvm_softmmu() + shadow_mmu_init_context() on
the other.  root_mmu.w is still used by shadow paging, via
FNAME(walk_addr) and its callers.

Always use the same instance of kvm_pagewalk to do GVA->GPA translations,
instead of flipping the gva_walk pointer back and forth.  After all the
page walking does behave the same no matter if you are in guest mode or
not; the difference lies in the behavior of kvm_translate_gpa and thus
in vcpu->arch.mmu, not in the page walker itself.

vcpu->arch.guest_mmu.w instead is used for both guest emulation
(kvm_translate_gpa) and shadow paging.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  13 +---
 arch/x86/kvm/hyperv.c           |   2 +-
 arch/x86/kvm/mmu.h              |   8 +--
 arch/x86/kvm/mmu/mmu.c          | 120 +++++++++++---------------------
 arch/x86/kvm/mmu/paging_tmpl.h  |   4 +-
 arch/x86/kvm/svm/nested.c       |   2 -
 arch/x86/kvm/vmx/nested.c       |   3 -
 arch/x86/kvm/x86.c              |  20 +++---
 8 files changed, 60 insertions(+), 112 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f9223c243ffa..835e2a1afa76 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -870,26 +870,15 @@ struct kvm_vcpu_arch {
 
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
-	struct kvm_pagewalk root_gva_walk;
 
 	/* L1 TDP when running nested */
 	struct kvm_mmu guest_mmu;
 	struct kvm_pagewalk ngpa_walk;
 
-	/*
-	 * Paging state of an L2 guest (used for nested npt)
-	 *
-	 * This context will save all necessary information to walk page tables
-	 * of an L2 guest. This context is only initialized for page table
-	 * walking and not for faulting since we never handle l2 page faults on
-	 * the host.
-	 */
-	struct kvm_pagewalk ngva_walk;
-
 	/*
 	 * Pagewalk context used for gva_to_gpa translations.
 	 */
-	struct kvm_pagewalk *gva_walk;
+	struct kvm_pagewalk gva_walk;
 
 	u64 pdptrs[4]; /* pae */
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 51d812babe73..1ee0d23f8949 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2046,7 +2046,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, vcpu->arch.gva_walk, hc->ingpa,
+		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.gva_walk, hc->ingpa,
 					      PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 15c45e01a511..88a41fa5d5d2 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -176,9 +176,9 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	 * @w's snapshot of CR0.WP and thus all related paging metadata may
 	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
 	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
-	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
-	 * need to refresh ngva_walk, a.k.a. the walker used to translate L2
-	 * GVAs to GPAs, so as to honor L2's CR0.WP.
+	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM will
+	 * still refresh gva_walk, so as to honor L2's CR0.WP when translating
+	 * L2 GVAs to GPAs.
 	 */
 	if (!tdp_enabled || w == &vcpu->arch.ngpa_walk)
 		return;
@@ -306,7 +306,7 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	if (w != &vcpu->arch.ngva_walk)
+	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.ngpa_walk)
 		return gpa;
 	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
 							    exception,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 526490d86850..13025bf653be 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5144,7 +5144,6 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_map_private_pfn);
 static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
-	context->w->gva_to_gpa = nonpaging_gva_to_gpa;
 	context->sync_spte = NULL;
 }
 
@@ -5775,14 +5774,12 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 static void paging64_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging64_page_fault;
-	context->w->gva_to_gpa = paging64_gva_to_gpa;
 	context->sync_spte = paging64_sync_spte;
 }
 
 static void paging32_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging32_page_fault;
-	context->w->gva_to_gpa = paging32_gva_to_gpa;
 	context->sync_spte = paging32_sync_spte;
 }
 
@@ -5897,39 +5894,22 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
 	union kvm_mmu_page_role root_role = kvm_calc_tdp_mmu_root_page_role(vcpu, cpu_role);
 
-	if (cpu_role.as_u64 == context->w->cpu_role.as_u64 &&
-	    root_role.word == context->root_role.word)
+	if (root_role.word == context->root_role.word)
 		return;
 
-	context->w->cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
 
-	context->w->inject_page_fault = kvm_inject_page_fault;
-	context->w->get_pdptr = kvm_pdptr_read;
-	context->w->get_guest_pgd = get_guest_cr3;
-
-	if (!is_cr0_pg(context->w))
-		context->w->gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_cr4_pae(context->w))
-		context->w->gva_to_gpa = paging64_gva_to_gpa;
-	else
-		context->w->gva_to_gpa = paging32_gva_to_gpa;
-
-	reset_guest_paging_metadata(vcpu, context->w);
 	reset_tdp_shadow_zero_bits_mask(context);
 }
 
 static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *context,
-				    union kvm_cpu_role cpu_role,
 				    union kvm_mmu_page_role root_role)
 {
-	if (cpu_role.as_u64 == context->w->cpu_role.as_u64 &&
-	    root_role.word == context->root_role.word)
+	if (root_role.word == context->root_role.word)
 		return;
 
-	context->w->cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 
 	if (!is_cr0_pg(context->w))
@@ -5939,7 +5919,6 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	else
 		paging32_init_context(context);
 
-	reset_guest_paging_metadata(vcpu, context->w);
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -5965,7 +5944,28 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 	 */
 	root_role.efer_nx = true;
 
-	shadow_mmu_init_context(vcpu, context, cpu_role, root_role);
+	shadow_mmu_init_context(vcpu, context, root_role);
+}
+
+static void init_kvm_page_walk(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			       union kvm_cpu_role cpu_role)
+{
+	if (cpu_role.as_u64 == w->cpu_role.as_u64)
+		return;
+
+	w->cpu_role.as_u64   = cpu_role.as_u64;
+	w->inject_page_fault = kvm_inject_page_fault;
+	w->get_pdptr         = kvm_pdptr_read;
+	w->get_guest_pgd     = get_guest_cr3;
+
+	if (!is_cr0_pg(w))
+		w->gva_to_gpa = nonpaging_gva_to_gpa;
+	else if (is_cr4_pae(w))
+		w->gva_to_gpa = paging64_gva_to_gpa;
+	else
+		w->gva_to_gpa = paging32_gva_to_gpa;
+
+	reset_guest_paging_metadata(vcpu, w);
 }
 
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
@@ -5984,13 +5984,15 @@ void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
 	WARN_ON_ONCE(cpu_role.base.direct || !cpu_role.base.guest_mode);
 	cpu_role.base.cr4_smep = (misc_ctl & SVM_MISC_ENABLE_GMET) != 0;
 
+	init_kvm_page_walk(vcpu, &vcpu->arch.ngpa_walk, cpu_role);
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
@@ -6055,46 +6057,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_ept_mmu);
 static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 			     union kvm_cpu_role cpu_role)
 {
-	struct kvm_mmu *context = &vcpu->arch.root_mmu;
-
 	kvm_init_shadow_mmu(vcpu, cpu_role);
-
-	context->w->inject_page_fault = kvm_inject_page_fault;
-	context->w->get_pdptr         = kvm_pdptr_read;
-	context->w->get_guest_pgd     = get_guest_cr3;
-}
-
-static void init_kvm_ngva_walk(struct kvm_vcpu *vcpu,
-				union kvm_cpu_role new_mode)
-{
-	struct kvm_pagewalk *g_context = &vcpu->arch.ngva_walk;
-
-	if (new_mode.as_u64 == g_context->cpu_role.as_u64)
-		return;
-
-	g_context->cpu_role.as_u64   = new_mode.as_u64;
-	g_context->inject_page_fault = kvm_inject_page_fault;
-	g_context->get_pdptr         = kvm_pdptr_read;
-	g_context->get_guest_pgd     = get_guest_cr3;
-
-	/*
-	 * Note that arch.mmu->gva_to_gpa translates l2_gpa to l1_gpa using
-	 * L1's nested page tables (e.g. EPT12). The nested translation
-	 * of l2_gva to l1_gpa is done by arch.ngva_walk.gva_to_gpa using
-	 * L2's page tables as the first level of translation and L1's
-	 * nested page tables as the second level of translation. Basically
-	 * the gva_to_gpa functions between mmu and ngva_walk are swapped.
-	 */
-	if (!is_paging(vcpu))
-		g_context->gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_long_mode(vcpu))
-		g_context->gva_to_gpa = paging64_gva_to_gpa;
-	else if (is_pae(vcpu))
-		g_context->gva_to_gpa = paging64_gva_to_gpa;
-	else
-		g_context->gva_to_gpa = paging32_gva_to_gpa;
-
-	reset_guest_paging_metadata(vcpu, g_context);
 }
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
@@ -6102,12 +6065,14 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu)
 	struct kvm_mmu_role_regs regs = vcpu_to_role_regs(vcpu);
 	union kvm_cpu_role cpu_role = kvm_calc_cpu_role(vcpu, &regs);
 
-	if (mmu_is_nested(vcpu))
-		init_kvm_ngva_walk(vcpu, cpu_role);
-	else if (tdp_enabled)
-		init_kvm_tdp_mmu(vcpu, cpu_role);
-	else
-		init_kvm_softmmu(vcpu, cpu_role);
+	init_kvm_page_walk(vcpu, &vcpu->arch.gva_walk, cpu_role);
+
+	if (!mmu_is_nested(vcpu)) {
+		if (tdp_enabled)
+			init_kvm_tdp_mmu(vcpu, cpu_role);
+		else
+			init_kvm_softmmu(vcpu, cpu_role);
+	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_mmu);
 
@@ -6127,9 +6092,8 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->arch.root_mmu.root_role.invalid = 1;
 	vcpu->arch.guest_mmu.root_role.invalid = 1;
-	vcpu->arch.root_gva_walk.cpu_role.ext.valid = 0;
 	vcpu->arch.ngpa_walk.cpu_role.ext.valid = 0;
-	vcpu->arch.ngva_walk.cpu_role.ext.valid = 0;
+	vcpu->arch.gva_walk.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
 	KVM_BUG_ON(!kvm_can_set_cpuid_and_feature_msrs(vcpu), vcpu->kvm);
@@ -6625,13 +6589,14 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
 
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (w == vcpu->arch.gva_walk) {
+	if (w == &vcpu->arch.gva_walk) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
-		if (w == &vcpu->arch.ngva_walk)
+
+		if (tdp_enabled)
 			return;
 
 		mmu = &vcpu->arch.root_mmu;
@@ -6665,7 +6630,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.gva_walk, gva, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.gva_walk, gva, KVM_MMU_ROOTS_ALL);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
@@ -6687,7 +6652,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 	}
 
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, mmu->w, gva, roots);
+		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.gva_walk, gva, roots);
 	++vcpu->stat.invlpg;
 
 	/*
@@ -6803,13 +6768,12 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.gva_walk = &vcpu->arch.root_gva_walk;
 
 	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu, &vcpu->arch.ngpa_walk);
 	if (ret)
 		return ret;
 
-	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->arch.root_gva_walk);
+	ret = __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu, &vcpu->arch.gva_walk);
 	if (ret)
 		goto fail_allocate_root;
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 115f0fd2d4ba..a46384b7080f 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -548,7 +548,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->fault.address = addr;
-	walker->fault.nested_page_fault = w != vcpu->arch.gva_walk;
+	walker->fault.nested_page_fault = w != &vcpu->arch.gva_walk;
 	walker->fault.async_page_fault = false;
 
 #if PTTYPE != PTTYPE_EPT
@@ -906,7 +906,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 
 #ifndef CONFIG_X86_64
 	/* A 64-bit GVA should be impossible on 32-bit KVM. */
-	WARN_ON_ONCE((addr >> 32) && w == vcpu->arch.gva_walk);
+	WARN_ON_ONCE((addr >> 32) && w == &vcpu->arch.gva_walk);
 #endif
 
 	r = FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index ddc9a749bcf6..3d5ba0f74814 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -116,13 +116,11 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.ngpa_walk.get_guest_pgd     = nested_svm_get_tdp_cr3;
 	vcpu->arch.ngpa_walk.get_pdptr         = nested_svm_get_tdp_pdptr;
 	vcpu->arch.ngpa_walk.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.gva_walk              = &vcpu->arch.ngva_walk;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.gva_walk = vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 11387b4ce451..fdff345c6614 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -515,14 +515,11 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.ngpa_walk.get_pdptr       = kvm_pdptr_read;
 
 	vcpu->arch.ngpa_walk.inject_page_fault = nested_ept_inject_page_fault;
-
-	vcpu->arch.gva_walk              = &vcpu->arch.ngva_walk;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.gva_walk = vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index afdf080cd801..06f9882ce9ea 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -981,7 +981,7 @@ void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
 	fault_walk = fault->nested_page_fault ? &vcpu->arch.ngpa_walk :
-						vcpu->arch.gva_walk;
+						&vcpu->arch.gva_walk;
 
 	/*
 	 * Invalidate the TLB entry for the faulting address, if it exists,
@@ -1028,7 +1028,7 @@ static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
  */
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
-	struct kvm_pagewalk *w = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *w = &vcpu->arch.gva_walk;
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
 	gpa_t real_gpa;
 	int i;
@@ -7838,7 +7838,7 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
@@ -7848,7 +7848,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
@@ -7860,7 +7860,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 
 	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, 0, exception);
 }
@@ -7869,7 +7869,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -7902,7 +7902,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
@@ -7961,7 +7961,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -8067,7 +8067,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				gpa_t *gpa, struct x86_exception *exception,
 				bool write)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	u64 access = ((kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0)
 		     | (write ? PFERR_WRITE_MASK : 0);
 
@@ -14169,7 +14169,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_spec_ctrl_test_value);
 
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
 {
-	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.gva_walk;
 	struct x86_exception fault;
 	u64 access = error_code &
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A32F8BF0
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512028; cv=none; b=R3Os7m6hOxCmkGMz7PLkr37slXN1gXGcsTS6lwBE/hR3RnfrglTTYCh6D1nIvDO1zAIIL9U8rmmJubMfTU9ZaULAgoIc+PLwwpIxpIJ55S7ZKGik80BlZvy+wUgmzq86f4Q2pD3nc5EvqNGWHO+TsIiOqp/jqVTqw5OyHiSLRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512028; c=relaxed/simple;
	bh=XXWvKU+xb035dpmwPaXOyxu3O71ZybGI/aKshQdIU+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qE/kxyAlzbc84BZOc6C5J5LcbPSPTQnzzsHZQBtAEQgmRR5ZTR1n1AF/whpZiLsARnGj0TsTNU0iSS5C2/7JOhmxIhiSPNnEN+H1Dehza+Z7TsAbgAPTBxjAbB63a7glQMrUXPD6RZ5XNaDZTqOPL4Rfb/Taf4ILmNB80Ag16hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUkplqHD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUkplqHD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+6Mbn6QgIFcrwDbdW3qLK8v6j/3DVamjsjLTE3ypNI=;
	b=TUkplqHDU9/YsJQ70TnTX+Y6xbb7rG+MiIWPY+1izGrEPF1t7ImLxA9qdDpJ7PyDPSMQJZ
	mMIQGyysreEYSs47paGiOeJvmI1ELDl32W2ulP8zYIiDhMbKEPYzWJdNV+vRzk8HRmq68E
	FvtsFeMVXerq9ctKb05f6LR/edmU0GQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-VFQc5bTTO2y8I6732vYuzw-1; Mon,
 11 May 2026 11:07:03 -0400
X-MC-Unique: VFQc5bTTO2y8I6732vYuzw-1
X-Mimecast-MFC-AGG-ID: VFQc5bTTO2y8I6732vYuzw_1778512022
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F2D81955EA7;
	Mon, 11 May 2026 15:07:02 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD09A1800764;
	Mon, 11 May 2026 15:07:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 16/22] KVM: x86/mmu: make cpu_walk a value
Date: Mon, 11 May 2026 11:06:42 -0400
Message-ID: <20260511150648.685374-17-pbonzini@redhat.com>
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

Always use the same instance of kvm_pagewalk to do GVA->GPA translations,
instead of flipping the cpu_walk pointer back and forth.  After all the
page walking does behave the same no matter if you are in guest mode or
not; the difference lies in the behavior of kvm_translate_gpa and thus
in vcpu->arch.mmu, not in the page walker itself.

At this point, vcpu->arch.cpu_walk and vcpu->arch.root_mmu.w contain
the same information (at least when KVM is not running a nested guest,
i.e. when root_mmu is actually in use); compare init_kvm_page_walk()
on one side with init_kvm_softmmu() + shadow_mmu_init_context() on
the other.  root_mmu.w is still used by shadow paging, via
FNAME(walk_addr) and its callers.

vcpu->arch.guest_mmu.w instead is used for both guest emulation
(kvm_translate_gpa) and shadow paging.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 12 +----
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/mmu.h              |  8 +--
 arch/x86/kvm/mmu/mmu.c          | 86 +++++++++++++++------------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  4 +-
 arch/x86/kvm/svm/nested.c       |  2 -
 arch/x86/kvm/vmx/nested.c       |  3 --
 arch/x86/kvm/x86.c              | 20 ++++----
 8 files changed, 58 insertions(+), 79 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8af8016e9364..2feb05475867 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -865,20 +865,10 @@ struct kvm_vcpu_arch {
 	/* L1 MMU when running nested */
 	struct kvm_mmu guest_mmu;
 
-	/*
-	 * Paging state of an L2 guest (used for nested npt)
-	 *
-	 * This context will save all necessary information to walk page tables
-	 * of an L2 guest. This context is only initialized for page table
-	 * walking and not for faulting since we never handle l2 page faults on
-	 * the host.
-	 */
-	struct kvm_pagewalk nested_cpu_walk;
-
 	/*
 	 * Pagewalk context used for gva_to_gpa translations.
 	 */
-	struct kvm_pagewalk *cpu_walk;
+	struct kvm_pagewalk cpu_walk;
 
 	u64 pdptrs[4]; /* pae */
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 36e416eb92d1..4a4916d96a56 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2041,7 +2041,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, vcpu->arch.cpu_walk, hc->ingpa,
+		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.cpu_walk, hc->ingpa,
 					      PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 652803cb36c8..0f4320ef9767 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -176,9 +176,9 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	 * @w's snapshot of CR0.WP and thus all related paging metadata may
 	 * be stale.  Refresh CR0.WP and the metadata on-demand when checking
 	 * for permission faults.  Exempt nested MMUs, i.e. MMUs for shadowing
-	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM does
-	 * need to refresh nested_cpu_walk, a.k.a. the walker used to translate L2
-	 * GVAs to GPAs, so as to honor L2's CR0.WP.
+	 * nEPT and nNPT, as CR0.WP is ignored in both cases.  Note, KVM will
+	 * still refresh cpu_walk, so as to honor L2's CR0.WP when translating
+	 * L2 GVAs to GPAs.
 	 */
 	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
 		return;
@@ -306,7 +306,7 @@ static inline gpa_t kvm_translate_gpa(struct kvm_vcpu *vcpu,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	if (w != &vcpu->arch.nested_cpu_walk)
+	if (!mmu_is_nested(vcpu) || w == &vcpu->arch.guest_mmu.w)
 		return gpa;
 	return kvm_x86_ops.nested_ops->translate_nested_gpa(vcpu, gpa, access,
 							    exception,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bb76835a2e06..75c8d7992d8b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5943,6 +5943,27 @@ static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
 	shadow_mmu_init_context(vcpu, context, cpu_role, root_role);
 }
 
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
+}
+
 void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, unsigned long cr4,
 			     u64 efer, gpa_t nested_cr3, u64 misc_ctl)
 {
@@ -6037,50 +6058,19 @@ static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
 	context->w.get_guest_pgd     = get_guest_cr3;
 }
 
-static void init_kvm_nested_cpu_walk(struct kvm_vcpu *vcpu,
-				union kvm_cpu_role new_mode)
-{
-	struct kvm_pagewalk *g_context = &vcpu->arch.nested_cpu_walk;
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
-	 * of l2_gva to l1_gpa is done by arch.nested_cpu_walk.gva_to_gpa using
-	 * L2's page tables as the first level of translation and L1's
-	 * nested page tables as the second level of translation. Basically
-	 * the gva_to_gpa functions between mmu and nested_cpu_walk are swapped.
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
-}
-
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu_role_regs regs = vcpu_to_role_regs(vcpu);
 	union kvm_cpu_role cpu_role = kvm_calc_cpu_role(vcpu, &regs);
 
-	if (mmu_is_nested(vcpu))
-		init_kvm_nested_cpu_walk(vcpu, cpu_role);
-	else if (tdp_enabled)
-		init_kvm_tdp_mmu(vcpu, cpu_role);
-	else
-		init_kvm_softmmu(vcpu, cpu_role);
+	init_kvm_page_walk(vcpu, &vcpu->arch.cpu_walk, cpu_role);
+
+	if (!mmu_is_nested(vcpu)) {
+		if (tdp_enabled)
+			init_kvm_tdp_mmu(vcpu, cpu_role);
+		else
+			init_kvm_softmmu(vcpu, cpu_role);
+	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_mmu);
 
@@ -6102,7 +6092,7 @@ void kvm_mmu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_mmu.root_role.invalid = 1;
 	vcpu->arch.root_mmu.w.cpu_role.ext.valid = 0;
 	vcpu->arch.guest_mmu.w.cpu_role.ext.valid = 0;
-	vcpu->arch.nested_cpu_walk.cpu_role.ext.valid = 0;
+	vcpu->arch.cpu_walk.cpu_role.ext.valid = 0;
 	kvm_mmu_reset_context(vcpu);
 
 	KVM_BUG_ON(!kvm_can_set_cpuid_and_feature_msrs(vcpu), vcpu->kvm);
@@ -6598,17 +6588,22 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
 
 	/* It's actually a GPA for vcpu->arch.guest_mmu.  */
-	if (w != &vcpu->arch.guest_mmu.w) {
+	if (w == &vcpu->arch.cpu_walk) {
 		/* INVLPG on a non-canonical address is a NOP according to the SDM.  */
 		if (is_noncanonical_invlpg_address(addr, vcpu))
 			return;
 
 		kvm_x86_call(flush_tlb_gva)(vcpu, addr);
-		if (w == &vcpu->arch.nested_cpu_walk)
+
+		if (tdp_enabled)
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
 
@@ -6634,7 +6629,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.cpu_walk, gva, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.cpu_walk, gva, KVM_MMU_ROOTS_ALL);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
@@ -6656,7 +6651,7 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
 	}
 
 	if (roots)
-		kvm_mmu_invalidate_addr(vcpu, &mmu->w, gva, roots);
+		kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.cpu_walk, gva, roots);
 	++vcpu->stat.invlpg;
 
 	/*
@@ -6771,7 +6766,6 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.cpu_walk = &vcpu->arch.root_mmu.w;
 
 	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
 	if (ret)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index c7690f4929ae..e7d68606bb64 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -541,7 +541,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->fault.address = addr;
-	walker->fault.nested_page_fault = w != vcpu->arch.cpu_walk;
+	walker->fault.nested_page_fault = w != &vcpu->arch.cpu_walk;
 	walker->fault.async_page_fault = false;
 
 	trace_kvm_mmu_walker_error(walker->fault.error_code);
@@ -894,7 +894,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 
 #ifndef CONFIG_X86_64
 	/* A 64-bit GVA should be impossible on 32-bit KVM. */
-	WARN_ON_ONCE((addr >> 32) && w == vcpu->arch.cpu_walk);
+	WARN_ON_ONCE((addr >> 32) && w == &vcpu->arch.cpu_walk);
 #endif
 
 	r = FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 676a49c55f8d..2c42064111ab 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -102,13 +102,11 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.cpu_walk              = &vcpu->arch.nested_cpu_walk;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.cpu_walk = &vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b23900f2f6b4..bbb9f9b4a58b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -498,14 +498,11 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_pdptr       = kvm_pdptr_read;
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
-
-	vcpu->arch.cpu_walk              = &vcpu->arch.nested_cpu_walk;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.cpu_walk = &vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 03ee584986ac..21850893f99c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -995,7 +995,7 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
 	fault_walk = fault->nested_page_fault ? &vcpu->arch.mmu->w :
-						vcpu->arch.cpu_walk;
+						&vcpu->arch.cpu_walk;
 
 	/*
 	 * Invalidate the TLB entry for the faulting address, if it exists,
@@ -1061,7 +1061,7 @@ static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
  */
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
-	struct kvm_pagewalk *w = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *w = &vcpu->arch.cpu_walk;
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
 	gpa_t real_gpa;
 	int i;
@@ -7853,7 +7853,7 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, access, exception);
@@ -7863,7 +7863,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
@@ -7875,7 +7875,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 
 	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, 0, exception);
 }
@@ -7884,7 +7884,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -7917,7 +7917,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
@@ -7976,7 +7976,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -8082,7 +8082,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				gpa_t *gpa, struct x86_exception *exception,
 				bool write)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 	u64 access = ((kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0)
 		     | (write ? PFERR_WRITE_MASK : 0);
 
@@ -14213,7 +14213,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_spec_ctrl_test_value);
 
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
 {
-	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.cpu_walk;
 	struct x86_exception fault;
 	u64 access = error_code &
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
-- 
2.52.0



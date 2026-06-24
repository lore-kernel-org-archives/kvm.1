Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC7E39D3EC
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336680; cv=none; b=Z62Tk7G6KghWWiYeLusULbggqo7m1G5D+xFv7tvCWx9HYQ5H/E9QP17WjH4IqaHrpL9WQ1HjLXp0MNIJCV17OcOZ5/7yrHMFxhe/mpBW+NkwER84f7PTKt51hRg6wt5ICA3D25YZQH3DRnBSOeGLdZGmiQn+BC6GB4X1YIt+NWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336680; c=relaxed/simple;
	bh=Uc/RuopCcsUo360B12wlMQ/sWaajI1DePnVtx9ilPPw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXxVTyFarM2DN+2NfIXmF1TgOo9k4sJgI49QOD7QHmg8cAe0H8seupXBA2YgjLL9oGP5qmAUxeh8EObLF2mrgFEWzON4tS9mS/xcZc2Y4/YKjG2x87cpH1LzJexJmsZgzuIjulU05sU+j9POlhCJw6FuIsSzJq+74xAJCAVvUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIGmtKjU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIGmtKjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omXRxkXEF+NcFzRvxdQEHihKhtSTtam5alknmeRhYLo=;
	b=DIGmtKjUSHgFUEOB5oKx4HAdDvmvdQFXntIKEOzKuq5oRKz5A/QM4KbBiK+5kLXfjELI9z
	5WKEgPoCoI10+iGoRhp1wtCYZaftP9E+rL29kAPGCAuTMam8xHDh8saqXAzCopa9pPXNRU
	fVvAZgUyKMU9KIAsj+NWlq4+oegPxXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-qn8eMHrXMTSeqKUomy1qng-1; Wed,
 24 Jun 2026 17:31:12 -0400
X-MC-Unique: qn8eMHrXMTSeqKUomy1qng-1
X-Mimecast-MFC-AGG-ID: qn8eMHrXMTSeqKUomy1qng_1782336671
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70C6A19560A2;
	Wed, 24 Jun 2026 21:31:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E74DC195608D;
	Wed, 24 Jun 2026 21:31:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 11/19] KVM: x86/mmu: change walk_mmu to struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:30:54 -0400
Message-ID: <20260624213102.71082-12-pbonzini@redhat.com>
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

Now that walk_mmu is only accessed for its "w" member, store
directly the pointer to it.  This also means that nested_mmu
is only accessed for its "w" member.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  4 ++--
 arch/x86/kvm/mmu/paging_tmpl.h  |  4 ++--
 arch/x86/kvm/regs.c             |  7 ++++---
 arch/x86/kvm/svm/nested.c       |  4 ++--
 arch/x86/kvm/vmx/nested.c       |  4 ++--
 arch/x86/kvm/x86.c              | 37 +++++++++++++++++----------------
 8 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index bf1151c91372..a64deb5c05eb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -923,7 +923,7 @@ struct kvm_vcpu_arch {
 	 * Pointer to the mmu context currently used for
 	 * gva_to_gpa translations.
 	 */
-	struct kvm_mmu *walk_mmu;
+	struct kvm_pagewalk *gva_walk;
 
 	u64 pdptrs[4]; /* pae */
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e4a0ca0f9fd4..51d812babe73 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2046,7 +2046,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.walk_mmu->w, hc->ingpa,
+		hc->ingpa = kvm_translate_gpa(vcpu, vcpu->arch.gva_walk, hc->ingpa,
 					      PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 30774b562fa1..8ed9876cf3b8 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6730,7 +6730,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.walk_mmu->w, gva, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.gva_walk, gva, KVM_MMU_ROOTS_ALL);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
@@ -6867,7 +6867,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.gva_walk = &vcpu->arch.root_mmu.w;
 
 	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
 	if (ret)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e04b646f00d2..9cfae71cd3e6 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -548,7 +548,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->fault.address = addr;
-	walker->fault.nested_page_fault = w != &vcpu->arch.walk_mmu->w;
+	walker->fault.nested_page_fault = w != vcpu->arch.gva_walk;
 	walker->fault.async_page_fault = false;
 
 #if PTTYPE != PTTYPE_EPT
@@ -906,7 +906,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 
 #ifndef CONFIG_X86_64
 	/* A 64-bit GVA should be impossible on 32-bit KVM. */
-	WARN_ON_ONCE((addr >> 32) && w == &vcpu->arch.walk_mmu->w);
+	WARN_ON_ONCE((addr >> 32) && w == vcpu->arch.gva_walk);
 #endif
 
 	r = FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);
diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 3b3515fd77e6..02adaa4ef64e 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -154,7 +154,7 @@ static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
  */
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *w = vcpu->arch.gva_walk;
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
 	gpa_t real_gpa;
 	int i;
@@ -165,7 +165,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
 	 * to an L1 GPA.
 	 */
-	real_gpa = kvm_translate_gpa(vcpu, &mmu->w, gfn_to_gpa(pdpt_gfn),
+	real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(pdpt_gfn),
 				     PFERR_USER_MASK | PFERR_WRITE_MASK |
 				     PFERR_GUEST_PAGE_MASK, NULL, 0);
 	if (real_gpa == INVALID_GPA)
@@ -189,7 +189,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * Shadow page roots need to be reconstructed instead.
 	 */
 	if (!tdp_enabled && memcmp(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs)))
-		kvm_mmu_free_roots(vcpu->kvm, mmu, KVM_MMU_ROOT_CURRENT);
+		kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.root_mmu,
+				   KVM_MMU_ROOT_CURRENT);
 
 	memcpy(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs));
 	kvm_register_mark_dirty(vcpu, VCPU_REG_PDPTR);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 55eace8aa2c8..188e4b06a279 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -118,13 +118,13 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
+	vcpu->arch.gva_walk              = &vcpu->arch.nested_mmu.w;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.gva_walk = &vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6c4f38cc9896..5adc6a7c6af4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -517,13 +517,13 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
-	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
+	vcpu->arch.gva_walk              = &vcpu->arch.nested_mmu.w;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.gva_walk = &vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0f76e52e2695..43625cc9e934 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -582,11 +582,12 @@ void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				      struct x86_exception *fault,
 				      bool from_hardware)
 {
-	struct kvm_mmu *fault_mmu;
+	struct kvm_pagewalk *fault_walk;
+
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
-	fault_mmu = fault->nested_page_fault ? vcpu->arch.mmu :
-					       vcpu->arch.walk_mmu;
+	fault_walk = fault->nested_page_fault ? &vcpu->arch.mmu->w :
+						vcpu->arch.gva_walk;
 
 	/*
 	 * Invalidate the TLB entry for the faulting address, if it exists,
@@ -594,10 +595,10 @@ void __kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 	 */
 	if ((fault->error_code & PFERR_PRESENT_MASK) &&
 	    !(fault->error_code & PFERR_RSVD_MASK))
-		kvm_mmu_invalidate_addr(vcpu, &fault_mmu->w, fault->address,
+		kvm_mmu_invalidate_addr(vcpu, fault_walk, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->w.inject_page_fault(vcpu, fault, from_hardware);
+	fault_walk->inject_page_fault(vcpu, fault, from_hardware);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_inject_emulated_page_fault);
 
@@ -4768,7 +4769,7 @@ static int vcpu_mmio_read(struct kvm_vcpu *vcpu, gpa_t addr, int len, void *v)
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
@@ -4778,7 +4779,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
@@ -4790,7 +4791,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 
 	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, 0, exception);
 }
@@ -4799,7 +4800,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -4832,7 +4833,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
@@ -4891,7 +4892,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -4997,7 +4998,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				gpa_t *gpa, struct x86_exception *exception,
 				bool write)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 	u64 access = ((kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0)
 		     | (write ? PFERR_WRITE_MASK : 0);
 
@@ -5007,7 +5008,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 	 * shadow page table for L2 guest.
 	 */
 	if (vcpu_match_mmio_gva(vcpu, gva) && (!is_paging(vcpu) ||
-	    !permission_fault(vcpu, &vcpu->arch.walk_mmu->w,
+	    !permission_fault(vcpu, gva_walk,
 			      vcpu->arch.mmio_access, 0, access))) {
 		*gpa = vcpu->arch.mmio_gfn << PAGE_SHIFT |
 					(gva & (PAGE_SIZE - 1));
@@ -5015,7 +5016,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, exception);
+	*gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -10600,15 +10601,15 @@ void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = vcpu->arch.gva_walk;
 	struct x86_exception fault;
 	u64 access = error_code &
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, &fault) != INVALID_GPA) {
+	    gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, &fault) != INVALID_GPA) {
 		/*
-		 * If vcpu->arch.walk_mmu->gva_to_gpa succeeded, the page
+		 * If gva_walk->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
 		 * with the error code that the processor gave.
 		 */
@@ -10619,7 +10620,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->w.inject_page_fault(vcpu, &fault, true);
+	gva_walk->inject_page_fault(vcpu, &fault, true);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.52.0



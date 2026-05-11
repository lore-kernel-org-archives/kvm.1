Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68D2FE582
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512030; cv=none; b=YeQnDVby7YiV+3r1FrDaIkETscN78WK0jo2oJd12v7wpgw7YStNu84W+453x9PGDFChlcB5Jzzbex5ncWo0ZZgmOgQzSNKuc797oZgwKVhBK9pgc3/XYScEsaOuqk5Lp5IVaNrpUa7d1kErOnvCsw8KT3MPY86ly3elPLKOumxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512030; c=relaxed/simple;
	bh=435QXfliwOfpwf3NCo5fD+UTo9HldTY3ye9wKuq0YQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p0A2Pw0gupoOnNzBXbVhJA2SdEkEUU6ljYvn3Tq+OR5urKI5MkMYJUBzFbKjSRaVdVh4R8wQyUzZw1WOpbVnClGmwonW/EViKgtA+3RaPJX10ReiYCsdx9TmccCQfWkaObUBUE6uztFfnRuDNJ/oHNaSfjb/w/F/GSNvoCtoqys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZlgBXpxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZlgBXpxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxYxPj9zvIfYaAmV5OCVBPPWO3WmuQ4lzzI86ksxP2Y=;
	b=ZlgBXpxuHx8yK6vV7t0vG8+T1tDtDf+0KQeoUDx+Ci4CvqNdtjM5LhJPPzMBLmaLQmxSSL
	GRHnZAsfqVDvA1yeulu2VOaGolCJ53zgi0ycXQTeUmlufiUSq58bYEk53JYpvsnhGetPW6
	6vIa2QqAbTJpDJ1bkDpnQzbIsDe5124=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-WFg8LmOkO8-LLruihjQAzA-1; Mon,
 11 May 2026 11:07:02 -0400
X-MC-Unique: WFg8LmOkO8-LLruihjQAzA-1
X-Mimecast-MFC-AGG-ID: WFg8LmOkO8-LLruihjQAzA_1778512021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE17319560B2;
	Mon, 11 May 2026 15:07:00 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5812B1800370;
	Mon, 11 May 2026 15:07:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 14/22] KVM: x86/mmu: change walk_mmu to struct kvm_pagewalk
Date: Mon, 11 May 2026 11:06:40 -0400
Message-ID: <20260511150648.685374-15-pbonzini@redhat.com>
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

Now that walk_mmu is only accessed for its "w" member, store
directly the pointer to it.  This also means that nested_mmu
is only accessed for its "w" member.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/hyperv.c           |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  4 +--
 arch/x86/kvm/mmu/paging_tmpl.h  |  4 +--
 arch/x86/kvm/svm/nested.c       |  4 +--
 arch/x86/kvm/vmx/nested.c       |  4 +--
 arch/x86/kvm/x86.c              | 44 +++++++++++++++++----------------
 7 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a1a09b59ac0b..6c5c59b9cfe3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -879,7 +879,7 @@ struct kvm_vcpu_arch {
 	 * Pointer to the mmu context currently used for
 	 * gva_to_gpa translations.
 	 */
-	struct kvm_mmu *walk_mmu;
+	struct kvm_pagewalk *cpu_walk;
 
 	u64 pdptrs[4]; /* pae */
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index a6e7d6f85409..36e416eb92d1 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2041,7 +2041,7 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * read with kvm_read_guest().
 	 */
 	if (!hc->fast) {
-		hc->ingpa = kvm_translate_gpa(vcpu, &vcpu->arch.walk_mmu->w, hc->ingpa,
+		hc->ingpa = kvm_translate_gpa(vcpu, vcpu->arch.cpu_walk, hc->ingpa,
 					      PFERR_GUEST_FINAL_MASK, NULL, 0);
 		if (unlikely(hc->ingpa == INVALID_GPA))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 967c2226cba0..d6a011b2d36e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6641,7 +6641,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva)
 	 * be synced when switching to that new cr3, so nothing needs to be
 	 * done here for them.
 	 */
-	kvm_mmu_invalidate_addr(vcpu, &vcpu->arch.walk_mmu->w, gva, KVM_MMU_ROOTS_ALL);
+	kvm_mmu_invalidate_addr(vcpu, vcpu->arch.cpu_walk, gva, KVM_MMU_ROOTS_ALL);
 	++vcpu->stat.invlpg;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_invlpg);
@@ -6778,7 +6778,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 		vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.cpu_walk = &vcpu->arch.root_mmu.w;
 
 	ret = __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
 	if (ret)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 99a0e1c95223..c7690f4929ae 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -541,7 +541,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	}
 #endif
 	walker->fault.address = addr;
-	walker->fault.nested_page_fault = w != &vcpu->arch.walk_mmu->w;
+	walker->fault.nested_page_fault = w != vcpu->arch.cpu_walk;
 	walker->fault.async_page_fault = false;
 
 	trace_kvm_mmu_walker_error(walker->fault.error_code);
@@ -894,7 +894,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 
 #ifndef CONFIG_X86_64
 	/* A 64-bit GVA should be impossible on 32-bit KVM. */
-	WARN_ON_ONCE((addr >> 32) && w == &vcpu->arch.walk_mmu->w);
+	WARN_ON_ONCE((addr >> 32) && w == vcpu->arch.cpu_walk);
 #endif
 
 	r = FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index f7168fc8046b..4781145faa14 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -102,13 +102,13 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmu->w.get_pdptr       = nested_svm_get_tdp_pdptr;
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_svm_inject_npf_exit;
-	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
+	vcpu->arch.cpu_walk              = &vcpu->arch.nested_mmu.w;
 }
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.cpu_walk = &vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmcb_needs_vls_intercept(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index af773b4e008b..ed72625005fc 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -499,13 +499,13 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu->w.inject_page_fault = nested_ept_inject_page_fault;
 
-	vcpu->arch.walk_mmu              = &vcpu->arch.nested_mmu;
+	vcpu->arch.cpu_walk              = &vcpu->arch.nested_mmu.w;
 }
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
-	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+	vcpu->arch.cpu_walk = &vcpu->arch.root_mmu.w;
 }
 
 static bool nested_vmx_is_page_fault_vmexit(struct vmcs12 *vmcs12,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c2de39ad7595..03ee584986ac 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -990,11 +990,12 @@ void kvm_inject_page_fault(struct kvm_vcpu *vcpu, struct x86_exception *fault)
 void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 				    struct x86_exception *fault)
 {
-	struct kvm_mmu *fault_mmu;
+	struct kvm_pagewalk *fault_walk;
+
 	WARN_ON_ONCE(fault->vector != PF_VECTOR);
 
-	fault_mmu = fault->nested_page_fault ? vcpu->arch.mmu :
-					       vcpu->arch.walk_mmu;
+	fault_walk = fault->nested_page_fault ? &vcpu->arch.mmu->w :
+						vcpu->arch.cpu_walk;
 
 	/*
 	 * Invalidate the TLB entry for the faulting address, if it exists,
@@ -1002,10 +1003,10 @@ void kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
 	 */
 	if ((fault->error_code & PFERR_PRESENT_MASK) &&
 	    !(fault->error_code & PFERR_RSVD_MASK))
-		kvm_mmu_invalidate_addr(vcpu, &fault_mmu->w, fault->address,
+		kvm_mmu_invalidate_addr(vcpu, fault_walk, fault->address,
 					KVM_MMU_ROOT_CURRENT);
 
-	fault_mmu->w.inject_page_fault(vcpu, fault);
+	fault_walk->inject_page_fault(vcpu, fault);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_inject_emulated_page_fault);
 
@@ -1060,7 +1061,7 @@ static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
  */
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *w = vcpu->arch.cpu_walk;
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
 	gpa_t real_gpa;
 	int i;
@@ -1071,7 +1072,7 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * If the MMU is nested, CR3 holds an L2 GPA and needs to be translated
 	 * to an L1 GPA.
 	 */
-	real_gpa = kvm_translate_gpa(vcpu, &mmu->w, gfn_to_gpa(pdpt_gfn),
+	real_gpa = kvm_translate_gpa(vcpu, w, gfn_to_gpa(pdpt_gfn),
 				     PFERR_USER_MASK | PFERR_WRITE_MASK |
 				     PFERR_GUEST_PAGE_MASK, NULL, 0);
 	if (real_gpa == INVALID_GPA)
@@ -1095,7 +1096,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 	 * Shadow page roots need to be reconstructed instead.
 	 */
 	if (!tdp_enabled && memcmp(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs)))
-		kvm_mmu_free_roots(vcpu->kvm, mmu, KVM_MMU_ROOT_CURRENT);
+		kvm_mmu_free_roots(vcpu->kvm, &vcpu->arch.root_mmu,
+				   KVM_MMU_ROOT_CURRENT);
 
 	memcpy(vcpu->arch.pdptrs, pdpte, sizeof(vcpu->arch.pdptrs));
 	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
@@ -7851,7 +7853,7 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, access, exception);
@@ -7861,7 +7863,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
@@ -7873,7 +7875,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 
 	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, 0, exception);
 }
@@ -7882,7 +7884,7 @@ static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -7915,7 +7917,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
@@ -7974,7 +7976,7 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
@@ -8080,7 +8082,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 				gpa_t *gpa, struct x86_exception *exception,
 				bool write)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 	u64 access = ((kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0)
 		     | (write ? PFERR_WRITE_MASK : 0);
 
@@ -8090,7 +8092,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 	 * shadow page table for L2 guest.
 	 */
 	if (vcpu_match_mmio_gva(vcpu, gva) && (!is_paging(vcpu) ||
-	    !permission_fault(vcpu, &vcpu->arch.walk_mmu->w,
+	    !permission_fault(vcpu, cpu_walk,
 			      vcpu->arch.mmio_access, 0, access))) {
 		*gpa = vcpu->arch.mmio_gfn << PAGE_SHIFT |
 					(gva & (PAGE_SIZE - 1));
@@ -8098,7 +8100,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, exception);
+	*gpa = cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, access, exception);
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -14211,15 +14213,15 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_spec_ctrl_test_value);
 
 void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_code)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = vcpu->arch.cpu_walk;
 	struct x86_exception fault;
 	u64 access = error_code &
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, &fault) != INVALID_GPA) {
+	    cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, access, &fault) != INVALID_GPA) {
 		/*
-		 * If vcpu->arch.walk_mmu->gva_to_gpa succeeded, the page
+		 * If cpu_walk->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
 		 * with the error code that the processor gave.
 		 */
@@ -14230,7 +14232,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		fault.address = gva;
 		fault.async_page_fault = false;
 	}
-	vcpu->arch.walk_mmu->w.inject_page_fault(vcpu, &fault);
+	cpu_walk->inject_page_fault(vcpu, &fault);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_fixup_and_inject_pf_error);
 
-- 
2.52.0



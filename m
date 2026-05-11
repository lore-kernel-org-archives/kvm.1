Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAF233F8A2
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512023; cv=none; b=DLpZLJVJp0ZoIhxEfhBSUHX+cMnRZi1NL5v93PeaIKF6R6Yt+sX/KOa2YOcbp+Gef9hlDvOcicbkLGbJ4/IXVNrV4Ic30CYiQppCZ3O0FFU8MkwrAmMsLAwhrfV9yL0xq6TIhHT7uAh3JKh0FNWx/JJdgZwrwQW6pkTNRL8DncQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512023; c=relaxed/simple;
	bh=c5qzpImS6kjS8FWkX4bCTRHFoqvs+PNWJ0qXE51iQB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tg89/ErEJR/PC2gkZRRuz7jUvIT4Ftuv28IYb9MPfLvQl0aY/PwEVP590k8Z9KR0sjmzSAPByl2o3i6QrSIJdL9uvKN0ae/HXIA2/bv2CRQjbafcgN4+diFcnFrDMXoasU48WTIcCr0b/rHWkk1VF+ruWrev8Zy32iCsOEBk4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnV+DVHx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnV+DVHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4hGYKi97K4fJUBSrqyc2OYdYyBbzTJAPuvxn0N2V4U=;
	b=JnV+DVHxPlQhhMot1ibi/Xf0q50Aw7Zyu87MteHOye2XeZJL7Lw8sudcVC4WNnV+Lph6za
	MVCLhBwLvSPjwvc1FoRAKKREVgxCS5nbfvqGbWa95iFQnK4rGhrzgK+zOmVOrVJHRnOsiE
	GitSnS+klUmZFe9zu465Ie26SFGnEuU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-1QYH6cwoPLalJsgzHmiWuA-1; Mon,
 11 May 2026 11:06:56 -0400
X-MC-Unique: 1QYH6cwoPLalJsgzHmiWuA-1
X-Mimecast-MFC-AGG-ID: 1QYH6cwoPLalJsgzHmiWuA_1778512015
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33EAE1955D85;
	Mon, 11 May 2026 15:06:55 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AA2C1803A8E;
	Mon, 11 May 2026 15:06:54 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 07/22] KVM: x86/mmu: move gva_to_gpa to struct kvm_pagewalk
Date: Mon, 11 May 2026 11:06:33 -0400
Message-ID: <20260511150648.685374-8-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

gva_to_gpa is the main entry point into walk_mmu, which
is only used for guest page table walking (as opposed to building
the page tables).  Moving gva_to_gpa to struct kvm_pagewalk
is a steps towards making walk_mmu a struct kvm_pagewalk.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  6 +++---
 arch/x86/kvm/mmu/mmu.c          | 26 +++++++++++++-------------
 arch/x86/kvm/mmu/paging_tmpl.h  |  6 +++---
 arch/x86/kvm/svm/nested.c       |  4 ++--
 arch/x86/kvm/vmx/nested.c       |  4 ++--
 arch/x86/kvm/x86.c              | 30 +++++++++++++++---------------
 6 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 22e681d351b4..631ef6397e4e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -478,6 +478,9 @@ struct kvm_page_fault;
  */
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
+	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			    gpa_t gva_or_gpa, u64 access,
+			    struct x86_exception *exception);
 };
 
 struct kvm_mmu {
@@ -487,9 +490,6 @@ struct kvm_mmu {
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault);
-	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			    gpa_t gva_or_gpa, u64 access,
-			    struct x86_exception *exception);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8981e5526ba1..552a104e9496 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4342,7 +4342,7 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_roots(vcpu->kvm, vcpu->arch.mmu, roots_to_free);
 }
 
-static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  gpa_t vaddr, u64 access,
 				  struct x86_exception *exception)
 {
@@ -4354,7 +4354,7 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	 * user-mode address if CR0.PG=0.  Therefore *include* ACC_USER_MASK in
 	 * the last argument to kvm_translate_gpa (which NPT does not use).
 	 */
-	return kvm_translate_gpa(vcpu, &mmu->w, vaddr, access | PFERR_GUEST_FINAL_MASK,
+	return kvm_translate_gpa(vcpu, w, vaddr, access | PFERR_GUEST_FINAL_MASK,
 				 exception, ACC_ALL);
 }
 
@@ -5119,7 +5119,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_map_private_pfn);
 static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
-	context->gva_to_gpa = nonpaging_gva_to_gpa;
+	context->w.gva_to_gpa = nonpaging_gva_to_gpa;
 	context->sync_spte = NULL;
 }
 
@@ -5750,14 +5750,14 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 static void paging64_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging64_page_fault;
-	context->gva_to_gpa = paging64_gva_to_gpa;
+	context->w.gva_to_gpa = paging64_gva_to_gpa;
 	context->sync_spte = paging64_sync_spte;
 }
 
 static void paging32_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = paging32_page_fault;
-	context->gva_to_gpa = paging32_gva_to_gpa;
+	context->w.gva_to_gpa = paging32_gva_to_gpa;
 	context->sync_spte = paging32_sync_spte;
 }
 
@@ -5886,11 +5886,11 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->w.get_guest_pgd = get_guest_cr3;
 
 	if (!is_cr0_pg(context))
-		context->gva_to_gpa = nonpaging_gva_to_gpa;
+		context->w.gva_to_gpa = nonpaging_gva_to_gpa;
 	else if (is_cr4_pae(context))
-		context->gva_to_gpa = paging64_gva_to_gpa;
+		context->w.gva_to_gpa = paging64_gva_to_gpa;
 	else
-		context->gva_to_gpa = paging32_gva_to_gpa;
+		context->w.gva_to_gpa = paging32_gva_to_gpa;
 
 	reset_guest_paging_metadata(vcpu, context);
 	reset_tdp_shadow_zero_bits_mask(context);
@@ -6012,7 +6012,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->root_role.word = new_mode.base.word;
 
 		context->page_fault = ept_page_fault;
-		context->gva_to_gpa = ept_gva_to_gpa;
+		context->w.gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
 		update_permission_bitmask(context, true, true);
@@ -6067,13 +6067,13 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 	 * the gva_to_gpa functions between mmu and nested_mmu are swapped.
 	 */
 	if (!is_paging(vcpu))
-		g_context->gva_to_gpa = nonpaging_gva_to_gpa;
+		g_context->w.gva_to_gpa = nonpaging_gva_to_gpa;
 	else if (is_long_mode(vcpu))
-		g_context->gva_to_gpa = paging64_gva_to_gpa;
+		g_context->w.gva_to_gpa = paging64_gva_to_gpa;
 	else if (is_pae(vcpu))
-		g_context->gva_to_gpa = paging64_gva_to_gpa;
+		g_context->w.gva_to_gpa = paging64_gva_to_gpa;
 	else
-		g_context->gva_to_gpa = paging32_gva_to_gpa;
+		g_context->w.gva_to_gpa = paging32_gva_to_gpa;
 
 	reset_guest_paging_metadata(vcpu, g_context);
 }
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 9c3ccea6cd6b..6fcce1d9b787 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -889,7 +889,7 @@ static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
 }
 
 /* Note, @addr is a GPA when gva_to_gpa() translates an L2 GPA to an L1 GPA. */
-static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			       gpa_t addr, u64 access,
 			       struct x86_exception *exception)
 {
@@ -899,10 +899,10 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 
 #ifndef CONFIG_X86_64
 	/* A 64-bit GVA should be impossible on 32-bit KVM. */
-	WARN_ON_ONCE((addr >> 32) && mmu == vcpu->arch.walk_mmu);
+	WARN_ON_ONCE((addr >> 32) && w == &vcpu->arch.walk_mmu->w);
 #endif
 
-	r = FNAME(walk_addr_generic)(&walker, vcpu, &mmu->w, addr, access);
+	r = FNAME(walk_addr_generic)(&walker, vcpu, w, addr, access);
 
 	if (r) {
 		gpa = gfn_to_gpa(walker.gfn);
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b29cc7863646..b09972424392 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2090,7 +2090,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 pte_access)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
 
 	BUG_ON(!mmu_is_nested(vcpu));
 
@@ -2098,7 +2098,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
 		access |= PFERR_USER_MASK;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
 struct kvm_x86_nested_ops svm_nested_ops = {
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a16f37094071..f4ee7f3d3fed 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7465,7 +7465,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
 
 	BUG_ON(!mmu_is_nested(vcpu));
 
@@ -7477,7 +7477,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
 		access |= PFERR_USER_MASK;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
 struct kvm_x86_nested_ops vmx_nested_ops = {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fca4c4adaa43..89fc8fe75704 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7851,21 +7851,21 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
-	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, access, exception);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
-	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, access, exception);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 
@@ -7873,21 +7873,21 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gva, 0, exception);
+	return cpu_walk->gva_to_gpa(vcpu, cpu_walk, gva, 0, exception);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access, exception);
+		gpa_t gpa = cpu_walk->gva_to_gpa(vcpu, cpu_walk, addr, access, exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -7915,14 +7915,14 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
 
 	/* Inline kvm_read_guest_virt_helper for speed.  */
-	gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access|PFERR_FETCH_MASK,
-				    exception);
+	gpa_t gpa = cpu_walk->gva_to_gpa(vcpu, cpu_walk, addr, access|PFERR_FETCH_MASK,
+					  exception);
 	if (unlikely(gpa == INVALID_GPA))
 		return X86EMUL_PROPAGATE_FAULT;
 
@@ -7974,12 +7974,12 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *cpu_walk = &vcpu->arch.walk_mmu->w;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access, exception);
+		gpa_t gpa = cpu_walk->gva_to_gpa(vcpu, cpu_walk, addr, access, exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned towrite = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -8098,7 +8098,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	*gpa = mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, exception);
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -14217,7 +14217,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    mmu->gva_to_gpa(vcpu, mmu, gva, access, &fault) != INVALID_GPA) {
+	    mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, &fault) != INVALID_GPA) {
 		/*
 		 * If vcpu->arch.walk_mmu->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC723DDDAB
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337350; cv=none; b=nO2xyXTlI+eZIuE+F3T0FNWqCTZuSdsMQYzYiUdxb3fv9LnY0YqUaWgTj6v4cTHR/4eSU0EspJAK103wD50dmTj/lMRnFtsVNJG0SMEGnwH0OvEBPhKYuPuU61/5TAHJS9OZbBuOSCbrQu6AjaR/WPu/VZMOinvm37XuOvRgH1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337350; c=relaxed/simple;
	bh=YHR3vAI8y2g5wvvyXH+VXcMHHjHd+GYeL5gSfd5y8b0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcpWhWANKKbIgX3gDgNkb+CIQHGq3WsOFFKdeww584R21L3fZFOVlZiR8fdCQ8H9DG77f0savNLsXedLCWN6EuAJH58PnxDlV6ocfLsPFxLW+mYyL6CWubv3gU4yFZZ0Wyd/wcSVNc1lCy9f/Xj3VgssMXyAqgUkn+AJminsY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRj1FPB4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRj1FPB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJeqbbGKJViaDqvwLceV8ZrppvSmZfcyc4L3sUKYYp8=;
	b=WRj1FPB4e/nh3IUakGNPT+zNappkDSXZVd8fYMko+xUE+oIgKdz/rnsS+nNAikLlkkXnV5
	0IxpuBd/BBJogNdy9W79G5NwteSGZ9OToUTRgb7r17srSGSf99vgrMKHiLBM4kDTe50upP
	uZ0xKHNKGibJjtq2TnEDKTVMy0pnL+w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-tI5xRa9CNsm7Zs8J1UWQqw-1; Wed,
 24 Jun 2026 17:42:22 -0400
X-MC-Unique: tI5xRa9CNsm7Zs8J1UWQqw-1
X-Mimecast-MFC-AGG-ID: tI5xRa9CNsm7Zs8J1UWQqw_1782337341
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C906919560A2;
	Wed, 24 Jun 2026 21:42:21 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64BC030A8;
	Wed, 24 Jun 2026 21:42:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 04/19] KVM: x86/mmu: move gva_to_gpa to struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:42:03 -0400
Message-ID: <20260624214218.73796-5-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

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
index 4659b708657b..45195961969e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -483,6 +483,9 @@ struct kvm_page_fault;
  */
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
+	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			    gpa_t gva_or_gpa, u64 access,
+			    struct x86_exception *exception);
 };
 
 struct kvm_mmu {
@@ -493,9 +496,6 @@ struct kvm_mmu {
 	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
 				  struct x86_exception *fault,
 				  bool from_hardware);
-	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
-			    gpa_t gva_or_gpa, u64 access,
-			    struct x86_exception *exception);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
 			 struct kvm_mmu_page *sp, int i);
 	struct kvm_mmu_root_info root;
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2e8adad16ecc..7ef28599fc19 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4363,7 +4363,7 @@ void kvm_mmu_sync_prev_roots(struct kvm_vcpu *vcpu)
 	kvm_mmu_free_roots(vcpu->kvm, vcpu->arch.mmu, roots_to_free);
 }
 
-static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  gpa_t vaddr, u64 access,
 				  struct x86_exception *exception)
 {
@@ -4375,7 +4375,7 @@ static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	 * user-mode address if CR0.PG=0.  Therefore *include* ACC_USER_MASK in
 	 * the last argument to kvm_translate_gpa (which NPT does not use).
 	 */
-	return kvm_translate_gpa(vcpu, &mmu->w, vaddr, access | PFERR_GUEST_FINAL_MASK,
+	return kvm_translate_gpa(vcpu, w, vaddr, access | PFERR_GUEST_FINAL_MASK,
 				 exception, ACC_ALL);
 }
 
@@ -5140,7 +5140,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_map_private_pfn);
 static void nonpaging_init_context(struct kvm_mmu *context)
 {
 	context->page_fault = nonpaging_page_fault;
-	context->gva_to_gpa = nonpaging_gva_to_gpa;
+	context->w.gva_to_gpa = nonpaging_gva_to_gpa;
 	context->sync_spte = NULL;
 }
 
@@ -5771,14 +5771,14 @@ static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
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
 
@@ -5907,11 +5907,11 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
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
@@ -6033,7 +6033,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->root_role.word = new_mode.base.word;
 
 		context->page_fault = ept_page_fault;
-		context->gva_to_gpa = ept_gva_to_gpa;
+		context->w.gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
 		update_permission_bitmask(context, true, true);
@@ -6088,13 +6088,13 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
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
index 14794026f9bf..49c4feed7cd2 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -901,7 +901,7 @@ static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
 }
 
 /* Note, @addr is a GPA when gva_to_gpa() translates an L2 GPA to an L1 GPA. */
-static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
+static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 			       gpa_t addr, u64 access,
 			       struct x86_exception *exception)
 {
@@ -911,10 +911,10 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 
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
index 67a206554b3d..f21f1b9de55e 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -2152,7 +2152,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      u64 pte_access)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
 
 	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
 		return gpa;
@@ -2161,7 +2161,7 @@ static gpa_t svm_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if (!(svm->nested.ctl.misc_ctl & SVM_MISC_ENABLE_GMET))
 		access |= PFERR_USER_MASK;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
 struct kvm_x86_nested_ops svm_nested_ops = {
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1bc216dded45..569dcc03d5f7 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7469,7 +7469,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 				      struct x86_exception *exception,
 				      u64 pte_access)
 {
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	struct kvm_pagewalk *w = &vcpu->arch.mmu->w;
 
 	if (WARN_ON_ONCE(!mmu_is_nested(vcpu)))
 		return gpa;
@@ -7482,7 +7482,7 @@ static gpa_t vmx_translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa,
 	if ((pte_access & ACC_USER_MASK) && (access & PFERR_GUEST_FINAL_MASK))
 		access |= PFERR_USER_MASK;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gpa, access, exception);
+	return w->gva_to_gpa(vcpu, w, gpa, access, exception);
 }
 
 struct kvm_x86_nested_ops vmx_nested_ops = {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ec37c5a4a5f0..432532aff5c6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7836,21 +7836,21 @@ void kvm_get_segment(struct kvm_vcpu *vcpu,
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
 			      struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
-	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_read);
 
 gpa_t kvm_mmu_gva_to_gpa_write(struct kvm_vcpu *vcpu, gva_t gva,
 			       struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
 
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	access |= PFERR_WRITE_MASK;
-	return mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, access, exception);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 
@@ -7858,21 +7858,21 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_gva_to_gpa_write);
 gpa_t kvm_mmu_gva_to_gpa_system(struct kvm_vcpu *vcpu, gva_t gva,
 				struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
 
-	return mmu->gva_to_gpa(vcpu, mmu, gva, 0, exception);
+	return gva_walk->gva_to_gpa(vcpu, gva_walk, gva, 0, exception);
 }
 
 static int kvm_read_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access, exception);
+		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned toread = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -7900,14 +7900,14 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 				struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
 	u64 access = (kvm_x86_call(get_cpl)(vcpu) == 3) ? PFERR_USER_MASK : 0;
 	unsigned offset;
 	int ret;
 
 	/* Inline kvm_read_guest_virt_helper for speed.  */
-	gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access|PFERR_FETCH_MASK,
-				    exception);
+	gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access|PFERR_FETCH_MASK,
+					  exception);
 	if (unlikely(gpa == INVALID_GPA))
 		return X86EMUL_PROPAGATE_FAULT;
 
@@ -7959,12 +7959,12 @@ static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes
 				      struct kvm_vcpu *vcpu, u64 access,
 				      struct x86_exception *exception)
 {
-	struct kvm_mmu *mmu = vcpu->arch.walk_mmu;
+	struct kvm_pagewalk *gva_walk = &vcpu->arch.walk_mmu->w;
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
-		gpa_t gpa = mmu->gva_to_gpa(vcpu, mmu, addr, access, exception);
+		gpa_t gpa = gva_walk->gva_to_gpa(vcpu, gva_walk, addr, access, exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned towrite = min(bytes, (unsigned)PAGE_SIZE - offset);
 		int ret;
@@ -8083,7 +8083,7 @@ static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 		return 1;
 	}
 
-	*gpa = mmu->gva_to_gpa(vcpu, mmu, gva, access, exception);
+	*gpa = mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, exception);
 
 	if (*gpa == INVALID_GPA)
 		return -1;
@@ -14173,7 +14173,7 @@ void kvm_fixup_and_inject_pf_error(struct kvm_vcpu *vcpu, gva_t gva, u16 error_c
 		(PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
 
 	if (!(error_code & PFERR_PRESENT_MASK) ||
-	    mmu->gva_to_gpa(vcpu, mmu, gva, access, &fault) != INVALID_GPA) {
+	    mmu->w.gva_to_gpa(vcpu, &mmu->w, gva, access, &fault) != INVALID_GPA) {
 		/*
 		 * If vcpu->arch.walk_mmu->gva_to_gpa succeeded, the page
 		 * tables probably do not match the TLB.  Just proceed
-- 
2.52.0



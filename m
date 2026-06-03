Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD0F43E4B2
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484310; cv=none; b=LngEdqoe0y0qiym5CJEmUyRnJOwK/H13FcAMPcbHSwkp5yfQzd75KAwRkfeqLkUpIlT5T6dGV2ZSPwAH9X5hu/Qlls3ijEsTf+auUfpqsvZ9XKDCMAttJqbNagbWr8H8cUQv9fKB/tzSe5t+MdtLkfc+X0dcdlMWbDPSEfmG+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484310; c=relaxed/simple;
	bh=rbA4BCpxgGIsjxB95BpebFtdscfxFM+181bgADt/2gw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/Rn3aI07bp3gix6sD25LlyImevQCLIlxG+41JCNh8rP8q1Auil5n6hOiTwt+sOaNuMSrfLqNvJfk0+vH6P5utPP1/RPnB4ryb8mmJOTq/GJOzeG5e04BJcImgMCaoCeNf5Y9HWm6YnW8SDsFYmWHaS4KbhB+tb8djlBoX3B4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUkVBvPN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUkVBvPN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HoRgVZ/kapo97NlGfnz9p/Dwj+dMEeOUU5QCO8nQoSY=;
	b=TUkVBvPNhzH9zNsxPIroN1NwaQdxMa6KuOW0H3VdyRKOZztsvk828VlfAhzqSV79kR2lay
	CJu//n5obv6xf6ZOaMiejycvOp6uvW+O1RZo9ugvEywz6CvkY42aYy9NrrVgcHnnsrwWLz
	Qqs8gjdixYR8uMAvUYavXKmMucxC/9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-6R4ukf6tPJ-iOG-0SVutsg-1; Wed,
 03 Jun 2026 06:58:24 -0400
X-MC-Unique: 6R4ukf6tPJ-iOG-0SVutsg-1
X-Mimecast-MFC-AGG-ID: 6R4ukf6tPJ-iOG-0SVutsg_1780484303
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE8B195608B;
	Wed,  3 Jun 2026 10:58:23 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B373130001A1;
	Wed,  3 Jun 2026 10:58:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 13/24] KVM: x86/mmu: change CPU-role accessor fields to take struct kvm_pagewalk
Date: Wed,  3 Jun 2026 06:58:03 -0400
Message-ID: <20260603105814.10236-14-pbonzini@redhat.com>
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

With this change, walk_addr_generic and its callees do not need to use
container_of() anymore.

The next step is removing it from permission_fault() and
kvm_mmu_refresh_passthrough_bits().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 44 +++++++++++++++++-----------------
 arch/x86/kvm/mmu/paging_tmpl.h | 11 ++++-----
 2 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e2bfecf655d9..2ef04d8c6f95 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -224,9 +224,9 @@ BUILD_MMU_ROLE_REGS_ACCESSOR(efer, lma, EFER_LMA);
  * and the vCPU may be incorrect/irrelevant.
  */
 #define BUILD_MMU_ROLE_ACCESSOR(base_or_ext, reg, name)		\
-static inline bool __maybe_unused is_##reg##_##name(struct kvm_mmu *mmu)	\
+static inline bool __maybe_unused is_##reg##_##name(struct kvm_pagewalk *w)	\
 {								\
-	return !!(mmu->w.cpu_role. base_or_ext . reg##_##name);	\
+	return !!(w->cpu_role. base_or_ext . reg##_##name);	\
 }
 BUILD_MMU_ROLE_ACCESSOR(base, cr0, wp);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pse);
@@ -237,19 +237,19 @@ BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
 BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
 BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);
 
-static inline bool has_pferr_fetch(struct kvm_mmu *mmu)
+static inline bool has_pferr_fetch(struct kvm_pagewalk *w)
 {
-	return mmu->w.cpu_role.ext.has_pferr_fetch;
+	return w->cpu_role.ext.has_pferr_fetch;
 }
 
-static inline bool is_cr0_pg(struct kvm_mmu *mmu)
+static inline bool is_cr0_pg(struct kvm_pagewalk *w)
 {
-        return mmu->w.cpu_role.base.level > 0;
+        return w->cpu_role.base.level > 0;
 }
 
-static inline bool is_cr4_pae(struct kvm_mmu *mmu)
+static inline bool is_cr4_pae(struct kvm_pagewalk *w)
 {
-        return !mmu->w.cpu_role.base.has_4_byte_gpte;
+        return !w->cpu_role.base.has_4_byte_gpte;
 }
 
 static struct kvm_mmu_role_regs vcpu_to_role_regs(struct kvm_vcpu *vcpu)
@@ -5389,9 +5389,9 @@ static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 {
 	__reset_rsvds_bits_mask(&context->w.guest_rsvd_check,
 				vcpu->arch.reserved_gpa_bits,
-				context->w.cpu_role.base.level, is_efer_nx(context),
+				context->w.cpu_role.base.level, is_efer_nx(&context->w),
 				guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES),
-				is_cr4_pse(context),
+				is_cr4_pse(&context->w),
 				guest_cpuid_is_amd_compatible(vcpu));
 }
 
@@ -5573,10 +5573,10 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
-	bool cr4_smep = is_cr4_smep(mmu);
-	bool cr4_smap = is_cr4_smap(mmu);
-	bool cr0_wp = is_cr0_wp(mmu);
-	bool efer_nx = is_efer_nx(mmu);
+	bool cr4_smep = is_cr4_smep(&mmu->w);
+	bool cr4_smap = is_cr4_smap(&mmu->w);
+	bool cr0_wp = is_cr0_wp(&mmu->w);
+	bool efer_nx = is_efer_nx(&mmu->w);
 
 	/*
 	 * In hardware, page fault error codes are generated (as the name
@@ -5699,10 +5699,10 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
 
 	mmu->pkru_mask = 0;
 
-	if (!is_cr4_pke(mmu))
+	if (!is_cr4_pke(&mmu->w))
 		return;
 
-	wp = is_cr0_wp(mmu);
+	wp = is_cr0_wp(&mmu->w);
 
 	for (bit = 0; bit < ARRAY_SIZE(mmu->permissions); ++bit) {
 		unsigned pfec, pkey_bits;
@@ -5739,7 +5739,7 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
 static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 					struct kvm_mmu *mmu)
 {
-	if (!is_cr0_pg(mmu))
+	if (!is_cr0_pg(&mmu->w))
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
@@ -5810,7 +5810,7 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) != X86_CR0_WP);
 	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
 
-	if (is_cr0_wp(mmu) == cr0_wp)
+	if (is_cr0_wp(&mmu->w) == cr0_wp)
 		return;
 
 	mmu->w.cpu_role.base.cr0_wp = cr0_wp;
@@ -5885,9 +5885,9 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->w.get_pdptr = kvm_pdptr_read;
 	context->w.get_guest_pgd = get_guest_cr3;
 
-	if (!is_cr0_pg(context))
+	if (!is_cr0_pg(&context->w))
 		context->w.gva_to_gpa = nonpaging_gva_to_gpa;
-	else if (is_cr4_pae(context))
+	else if (is_cr4_pae(&context->w))
 		context->w.gva_to_gpa = paging64_gva_to_gpa;
 	else
 		context->w.gva_to_gpa = paging32_gva_to_gpa;
@@ -5907,9 +5907,9 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	context->w.cpu_role.as_u64 = cpu_role.as_u64;
 	context->root_role.word = root_role.word;
 
-	if (!is_cr0_pg(context))
+	if (!is_cr0_pg(&context->w))
 		nonpaging_init_context(context);
-	else if (is_cr4_pae(context))
+	else if (is_cr4_pae(&context->w))
 		paging64_init_context(context);
 	else
 		paging32_init_context(context);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 10b1e7a08e90..99a0e1c95223 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -134,7 +134,7 @@ static inline int FNAME(is_present_gpte)(struct kvm_pagewalk *w,
 	 * For EPT, an entry is present if any of bits 2:0 are set.
 	 * With mode-based execute control, bit 10 also indicates presence.
 	 */
-	return pte & (7 | (w->cpu_role.base.cr4_smep ? VMX_EPT_USER_EXECUTABLE_MASK : 0));
+	return pte & (7 | (is_cr4_smep(w) ? VMX_EPT_USER_EXECUTABLE_MASK : 0));
 #endif
 }
 
@@ -316,7 +316,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 				    struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				    gpa_t addr, u64 access)
 {
-	struct kvm_mmu *mmu = container_of(w, struct kvm_mmu, w);
 	int ret;
 	pt_element_t pte;
 	pt_element_t __user *ptep_user;
@@ -492,7 +491,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && has_pferr_fetch(mmu))
+	if (fetch_fault && has_pferr_fetch(w))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
@@ -536,7 +535,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 * ACC_*_MASK flags!
 		 */
 		walker->fault.exit_qualification |= EPT_VIOLATION_RWX_TO_PROT(pte_access);
-		if (mmu_has_mbec(mmu))
+		if (is_cr4_smep(w))
 			walker->fault.exit_qualification |=
 				EPT_VIOLATION_USER_EXEC_TO_PROT(pte_access);
 	}
@@ -840,7 +839,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * otherwise KVM will cache incorrect access information in the SPTE.
 	 */
 	if (fault->write && !(walker.pte_access & ACC_WRITE_MASK) &&
-	    !is_cr0_wp(vcpu->arch.mmu) && !fault->user && fault->slot) {
+	    !is_cr0_wp(&vcpu->arch.mmu->w) && !fault->user && fault->slot) {
 		walker.pte_access |= ACC_WRITE_MASK;
 		walker.pte_access &= ~ACC_USER_MASK;
 
@@ -850,7 +849,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		 * then we should prevent the kernel from executing it
 		 * if SMEP is enabled.
 		 */
-		if (is_cr4_smep(vcpu->arch.mmu))
+		if (is_cr4_smep(&vcpu->arch.mmu->w))
 			walker.pte_access &= ~ACC_EXEC_MASK;
 	}
 #endif
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E113E715E
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337355; cv=none; b=iwe8JSMQxMstZZ39Wqs6DgKgEEoO6LlPZBnSjOHbFc5er8QeqQXWPfwfckNo0claYOhVxeBjlUOfC9xLHxJUdSdz6UHq5mmF2TqBSBsk9CT4yIA1+yECEvhajhtZzZlimi51+YBUCCYQk8kdu7z0Cl2w9duEB6cDum8kS8LNYqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337355; c=relaxed/simple;
	bh=xP7tRg98WI4bHwg8XnX/b0ZgP9VHrk7NGurBA1zEGaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EE0mmklaLw8DmIltvbd3ZKNrn5H1mk/n0wXsF0B/tFpJ+vxJeD2CveC8k2yQ4TPQsvdq7GfqMMBlLncZd31xGJxzkf1rwCjvjR5NMgGnE7aFe4BRkAjwVDnKHgokGAZai8figx59einSVPNr7j1S/cSQLY3SB/eTo5rYEhGQ3l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RXwvfdyo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXwvfdyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMJjEVTd6IgnK1cQRPsq+g4VkukS7LBotnXNnGgsdJk=;
	b=RXwvfdyoIYWEv6nN2oea34aevzg/HG17C+HEgQbu9e0ITyO13imCnd/2jd1Ip891oj9lIa
	/KWHUJyFsObWye04qd09dtDPG8NCrd/w6fYRVvQt8YktzlfEPeO6LlSvUbC6I2OK1uBeyO
	GGgGV8GPx88+Oe0EqalZ4eyx23LEybs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-C13oyHM_P1mxIzPdyqrtEg-1; Wed,
 24 Jun 2026 17:42:25 -0400
X-MC-Unique: C13oyHM_P1mxIzPdyqrtEg-1
X-Mimecast-MFC-AGG-ID: C13oyHM_P1mxIzPdyqrtEg_1782337344
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E0B31800659;
	Wed, 24 Jun 2026 21:42:24 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDB2D1686;
	Wed, 24 Jun 2026 21:42:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 08/19] KVM: x86/mmu: change CPU-role accessor fields to take struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:42:07 -0400
Message-ID: <20260624214218.73796-9-pbonzini@redhat.com>
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
index 23803725639e..26903774149f 100644
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
@@ -5410,9 +5410,9 @@ static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
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
 
@@ -5594,10 +5594,10 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
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
@@ -5720,10 +5720,10 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
 
 	mmu->pkru_mask = 0;
 
-	if (!is_cr4_pke(mmu))
+	if (!is_cr4_pke(&mmu->w))
 		return;
 
-	wp = is_cr0_wp(mmu);
+	wp = is_cr0_wp(&mmu->w);
 
 	for (bit = 0; bit < ARRAY_SIZE(mmu->permissions); ++bit) {
 		unsigned pfec, pkey_bits;
@@ -5760,7 +5760,7 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
 static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
 					struct kvm_mmu *mmu)
 {
-	if (!is_cr0_pg(mmu))
+	if (!is_cr0_pg(&mmu->w))
 		return;
 
 	reset_guest_rsvds_bits_mask(vcpu, mmu);
@@ -5831,7 +5831,7 @@ void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) != X86_CR0_WP);
 	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
 
-	if (is_cr0_wp(mmu) == cr0_wp)
+	if (is_cr0_wp(&mmu->w) == cr0_wp)
 		return;
 
 	mmu->w.cpu_role.base.cr0_wp = cr0_wp;
@@ -5906,9 +5906,9 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
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
@@ -5928,9 +5928,9 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
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
index 3ea1ce11b025..e04b646f00d2 100644
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
@@ -488,7 +487,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 
 error:
 	errcode |= write_fault | user_fault;
-	if (fetch_fault && has_pferr_fetch(mmu))
+	if (fetch_fault && has_pferr_fetch(w))
 		errcode |= PFERR_FETCH_MASK;
 
 	walker->fault.vector = PF_VECTOR;
@@ -543,7 +542,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		 * ACC_*_MASK flags!
 		 */
 		walker->fault.exit_qualification |= EPT_VIOLATION_RWX_TO_PROT(pte_access);
-		if (mmu_has_mbec(mmu))
+		if (is_cr4_smep(w))
 			walker->fault.exit_qualification |=
 				EPT_VIOLATION_USER_EXEC_TO_PROT(pte_access);
 	}
@@ -852,7 +851,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * otherwise KVM will cache incorrect access information in the SPTE.
 	 */
 	if (fault->write && !(walker.pte_access & ACC_WRITE_MASK) &&
-	    !is_cr0_wp(vcpu->arch.mmu) && !fault->user && fault->slot) {
+	    !is_cr0_wp(&vcpu->arch.mmu->w) && !fault->user && fault->slot) {
 		walker.pte_access |= ACC_WRITE_MASK;
 		walker.pte_access &= ~ACC_USER_MASK;
 
@@ -862,7 +861,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
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



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306423EB0E8
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336683; cv=none; b=WzbpxMNsf5I4BHW3R2QzjKXhUIisxci8KkojV5QsXFaGUeGOIv8SIX9mCH0hKtnBUgXNBIUk1iiU43s3JdF5Wvvl6IZE2Do5xNB9QAKKy8jQG2SGXqRCPDjpST2dCuqjJaFiZ2/LfhghZFbX2ZgDCGgjLznqqgnEoMIM3VUc5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336683; c=relaxed/simple;
	bh=mk8v3NaS+2eqXnAZXUJh5tyjEg12w1DohM843uSjjMQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJkPLsnDOvo7AAY9ehzqwsyF5hNTAGsl9dHXrcHH0Z4t6KYYXuEpJrZ3AnaPHxa+XSbbLAYlb1bmya88wh9ddkJ87sJaKcLG9sXW8EoFkEfFwKZw4mWOQgX3KLclKxxydmCQudpu0wSN3rxn7FM4CF39jUAePqHcJZ8SXg24rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DAVC+z6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DAVC+z6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bg2O7h24W1yzuoq/Tn4tMD/JG9pk95Stgu5DYOakAkA=;
	b=DAVC+z6a+19P48PZwCs7ZxnIjKZfsIwhPvbUP/Hua6S4/E7UlMA8w/ly6EvAvH5xyOFPa0
	/EwrdG5CEyVOrUmTESblUcZKanHx0sgsVti3/rBCnL1hT9PcxklNxAsJTiUpqH2rxVhzY0
	af2J7rul1RxwnLFjjylePVkh6aJWVk4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-bymeQwH_MEWg_1dVup3Oqg-1; Wed,
 24 Jun 2026 17:31:17 -0400
X-MC-Unique: bymeQwH_MEWg_1dVup3Oqg-1
X-Mimecast-MFC-AGG-ID: bymeQwH_MEWg_1dVup3Oqg_1782336676
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F5C41805A21;
	Wed, 24 Jun 2026 21:31:16 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BDEC4195608D;
	Wed, 24 Jun 2026 21:31:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 19/19] KVM: x86/mmu: use kvm_page_format to test SPTEs
Date: Wed, 24 Jun 2026 17:31:02 -0400
Message-ID: <20260624213102.71082-20-pbonzini@redhat.com>
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

is_access_allowed(), and is_executable_pte() within it, are effectively
a special version of permission_fault() that only supports a subset
of roles.  In particular it does not allow SMEP, SMAP and PKE.

Replace its implementation with a modified version of permission_fault();
the new version will support SMEP (and hence AMD GMET) for free as soon
as update_spte_permission_bitmask() stops hardcoding cr4_smep == false.

This prepares for a possible future where TDP entries could have XS!=XU,
for example as part of implementing Hyper-V VSM natively inside KVM.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c     | 18 +++++++++++---
 arch/x86/kvm/mmu/spte.h    | 51 ++++++++++++++++++++++----------------
 arch/x86/kvm/mmu/tdp_mmu.c |  3 ++-
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 11d86e34acf4..6c13da942bfc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3694,6 +3694,7 @@ static u64 *fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, gpa_t gpa, u64 *spte)
  */
 static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
+	struct kvm_mmu *mmu;
 	struct kvm_mmu_page *sp;
 	int ret = RET_PF_INVALID;
 	u64 spte;
@@ -3703,6 +3704,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	if (!page_fault_can_be_fast(vcpu->kvm, fault))
 		return ret;
 
+	mmu = vcpu->arch.mmu;
 	walk_shadow_page_lockless_begin(vcpu);
 
 	do {
@@ -3738,7 +3740,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * Need not check the access of upper level table entries since
 		 * they are always ACC_ALL.
 		 */
-		if (is_access_allowed(fault, spte)) {
+		if (!spte_permission_fault(mmu, spte, fault)) {
 			ret = RET_PF_SPURIOUS;
 			break;
 		}
@@ -3761,7 +3763,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * that were write-protected for dirty-logging or access
 		 * tracking are handled here.  Don't bother checking if the
 		 * SPTE is writable to prioritize running with A/D bits enabled.
-		 * The is_access_allowed() check above handles the common case
+		 * The spte_permission_fault() check above handles the common case
 		 * of the fault being spurious, and the SPTE is known to be
 		 * shadow-present, i.e. except for access tracking restoration
 		 * making the new SPTE writable, the check is wasteful.
@@ -3786,7 +3788,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 
 		/* Verify that the fault can be handled in the fast path */
 		if (new_spte == spte ||
-		    !is_access_allowed(fault, new_spte))
+		    spte_permission_fault(mmu, new_spte, fault))
 			break;
 
 		/*
@@ -5764,6 +5766,12 @@ static void update_permission_bitmask(struct kvm_pagewalk *w, bool tdp, bool ept
 				    is_cr0_wp(w), is_efer_nx(w));
 }
 
+static void update_spte_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
+{
+	__update_permission_bitmask(&mmu->fmt, tdp, ept,
+				    mmu->root_role.cr4_smep, false, true, true);
+}
+
 /*
 * PKU is an additional mechanism by which the paging controls access to
 * user-mode addresses based on the value in the PKRU register.  Protection
@@ -5973,6 +5981,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	context->page_fault = kvm_tdp_page_fault;
 	context->sync_spte = NULL;
 
+	update_spte_permission_bitmask(context, true, shadow_xs_mask);
 	reset_tdp_shadow_zero_bits_mask(context);
 }
 
@@ -5991,6 +6000,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	else
 		paging32_init_context(context);
 
+	update_spte_permission_bitmask(context, context == &vcpu->arch.guest_mmu, false);
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -6119,6 +6129,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		update_permission_bitmask(ngpa_walk, true, true);
 		ngpa_walk->fmt.pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, execonly, huge_page_level);
+
+		update_spte_permission_bitmask(context, true, true);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
 	}
 
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 918533e61b98..e730717824b3 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -357,17 +357,6 @@ static inline bool is_last_spte(u64 pte, int level)
 	return (level == PG_LEVEL_4K) || is_large_pte(pte);
 }
 
-static inline bool is_executable_pte(u64 spte)
-{
-	/*
-	 * For now, return true if either the XS or XU bit is set
-	 * This function is only used for fast_page_fault,
-	 * which never processes shadow EPT, and regular page
-	 * tables always have XS==XU.
-	 */
-	return (spte & (shadow_xs_mask | shadow_xu_mask | shadow_nx_mask)) != shadow_nx_mask;
-}
-
 static inline kvm_pfn_t spte_to_pfn(u64 pte)
 {
 	return (pte & SPTE_BASE_ADDR_MASK) >> PAGE_SHIFT;
@@ -496,20 +485,40 @@ static inline bool is_mmu_writable_spte(u64 spte)
 }
 
 /*
- * Returns true if the access indicated by @fault is allowed by the existing
- * SPTE protections.  Note, the caller is responsible for checking that the
- * SPTE is a shadow-present, leaf SPTE (either before or after).
+ * Returns true if the access indicated by @fault is forbidden by the existing
+ * SPTE protections.
  */
-static inline bool is_access_allowed(struct kvm_page_fault *fault, u64 spte)
+static inline bool spte_permission_fault(struct kvm_mmu *mmu, u64 spte,
+					 struct kvm_page_fault *fault)
 {
-	if (fault->exec)
-		return is_executable_pte(spte);
+	unsigned pfec, pte_access;
 
-	if (fault->write)
-		return is_writable_pte(spte);
+	if (!is_shadow_present_pte(spte))
+		return true;
 
-	/* Fault was on Read access */
-	return spte & PT_PRESENT_MASK;
+	BUILD_BUG_ON(PT_PRESENT_MASK != ACC_READ_MASK);
+	BUILD_BUG_ON(PT_WRITABLE_MASK != ACC_WRITE_MASK);
+	BUILD_BUG_ON(VMX_EPT_READABLE_MASK != ACC_READ_MASK);
+	BUILD_BUG_ON(VMX_EPT_WRITABLE_MASK != ACC_WRITE_MASK);
+
+	/* strip nested paging fault error codes */
+	pte_access = spte & (PT_PRESENT_MASK | PT_WRITABLE_MASK);
+	if (shadow_nx_mask) {
+		pte_access |= spte & shadow_user_mask ? ACC_USER_MASK : 0;
+		pte_access |= spte & shadow_nx_mask ? 0 : ACC_EXEC_MASK;
+	} else {
+		pte_access |= spte & shadow_xs_mask ? ACC_EXEC_MASK : 0;
+		pte_access |= spte & shadow_xu_mask ? ACC_USER_EXEC_MASK : 0;
+	}
+
+	/*
+	 * RSVD is handled elsewhere, and is used for SMAP in the context
+	 * of accessing fmt.permissions[].  SPTEs never use PK or SS, as
+	 * they are not supported for shadow paging and irrelevant for TDP.
+	 */
+	pfec = fault->error_code & (
+		PFERR_WRITE_MASK | PFERR_USER_MASK | PFERR_FETCH_MASK);
+	return (mmu->fmt.permissions[pfec >> 1] >> pte_access) & 1;
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c1cbae65d239..ce3f2efadb05 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1122,6 +1122,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 					  struct kvm_page_fault *fault,
 					  struct tdp_iter *iter)
 {
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
 	u64 new_spte;
 	int ret = RET_PF_FIXED;
@@ -1131,7 +1132,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 		return RET_PF_RETRY;
 
 	if (is_shadow_present_pte(iter->old_spte) &&
-	    (fault->prefetch || is_access_allowed(fault, iter->old_spte)) &&
+	    (fault->prefetch || !spte_permission_fault(mmu, iter->old_spte, fault)) &&
 	    is_last_spte(iter->old_spte, iter->level)) {
 		WARN_ON_ONCE(fault->pfn != spte_to_pfn(iter->old_spte));
 		return RET_PF_SPURIOUS;
-- 
2.52.0


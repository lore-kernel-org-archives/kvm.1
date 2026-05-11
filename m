Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98A3FE667
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512028; cv=none; b=eUeLk/jqEKB8M6Ey20UkQPL88RuhvWHSw8/jZdrptWy21UcTfncW/GOVT6ETIkIL5J3ne4bbP585jhi6ihvQeMdflZeKWoqXo1m0QQ5m6sz9rQlO+Z9QFRDUOia0fhYOXAsaV7LI0X02eUtAG4IXfDwUmDxj5E5Njoczrd5/AbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512028; c=relaxed/simple;
	bh=2um0liGiF93ZoU74UGKmN1dzqWpejTRoS2+v8hLTs+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQ6fWT8Jlqwcrd8WONs4C8PnTpR0BeDtvCT4oRn4hC7FmYStvF2NMlvJZvULJcrY41+QgwGTIA9M1sRmyk4EcGWBpRGVS3ybN2JGaPy8pCs0q1LH/GqKAV5EvXcIC8wd5db/UI3sW/IoipT61RO/RHdONBZa3MUWD7XTCP+bAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCrRLHHv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCrRLHHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0NC9sMZ9Wt1ouYjWZFE59ItuS8pIgLt4qfLiO0mXRI=;
	b=MCrRLHHvSCqT3eDZcxwoiOdi63YOUKW0JDwr6TzNUpWBsGkTqW28R9pl4BCaDTGa98AWAq
	1n8j0ENiWh3lr7scXORtNmoJEGNEacZ0gg/ebNun+2eY8PcRjlzsSm1DmkNTtJqjymq9IT
	7y6GXmAWWCcI4avkngFi1Mc7idPGkcE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-whiX6p5pN329slC3Zcahvg-1; Mon,
 11 May 2026 11:07:01 -0400
X-MC-Unique: whiX6p5pN329slC3Zcahvg-1
X-Mimecast-MFC-AGG-ID: whiX6p5pN329slC3Zcahvg_1778512020
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49D67195609D;
	Mon, 11 May 2026 15:06:59 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFE4C1800370;
	Mon, 11 May 2026 15:06:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 12/22] KVM: x86/mmu: move remaining permission fields to struct kvm_pagewalk
Date: Mon, 11 May 2026 11:06:38 -0400
Message-ID: <20260511150648.685374-13-pbonzini@redhat.com>
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

As promised, this removes the remaining instances of
container_of(w, struct kvm_mmu, w).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 30 ++++++++--------
 arch/x86/kvm/mmu.h              | 13 +++----
 arch/x86/kvm/mmu/mmu.c          | 62 ++++++++++++++++-----------------
 3 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f39e11757774..3172aaff6744 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -486,6 +486,21 @@ struct kvm_pagewalk {
 			    struct x86_exception *exception);
 	union kvm_cpu_role cpu_role;
 	struct rsvd_bits_validate guest_rsvd_check;
+
+	/*
+	* The pkru_mask indicates if protection key checks are needed.  It
+	* consists of 16 domains indexed by page fault error code bits [4:1],
+	* with PFEC.RSVD replaced by ACC_USER_MASK from the page tables.
+	* Each domain has 2 bits which are ANDed with AD and WD from PKRU.
+	*/
+	u32 pkru_mask;
+
+	/*
+	 * Bitmap; bit set = permission fault
+	 * Array index: page fault error code [4:1]
+	 * Bit index: pte permissions in ACC_* format
+	 */
+	u16 permissions[16];
 };
 
 struct kvm_mmu {
@@ -498,23 +513,8 @@ struct kvm_mmu {
 	hpa_t mirror_root_hpa;
 	union kvm_mmu_page_role root_role;
 
-	/*
-	* The pkru_mask indicates if protection key checks are needed.  It
-	* consists of 16 domains indexed by page fault error code bits [4:1],
-	* with PFEC.RSVD replaced by ACC_USER_MASK from the page tables.
-	* Each domain has 2 bits which are ANDed with AD and WD from PKRU.
-	*/
-	u32 pkru_mask;
-
 	struct kvm_mmu_root_info prev_roots[KVM_MMU_NUM_PREV_ROOTS];
 
-	/*
-	 * Bitmap; bit set = permission fault
-	 * Byte index: page fault error code [4:1]
-	 * Bit index: pte permissions in ACC_* format
-	 */
-	u16 permissions[16];
-
 	u64 *pae_root;
 	u64 *pml4_root;
 	u64 *pml5_root;
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 3f8ac193a1e6..d1b5d9b0c6ad 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -105,7 +105,7 @@ bool kvm_can_do_async_pf(struct kvm_vcpu *vcpu);
 int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 				u64 fault_address, char *insn, int insn_len);
 void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
-					struct kvm_mmu *mmu);
+					struct kvm_pagewalk *pw);
 
 int kvm_mmu_load(struct kvm_vcpu *vcpu);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu);
@@ -183,8 +183,7 @@ static inline void kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
 	if (!tdp_enabled || w == &vcpu->arch.guest_mmu.w)
 		return;
 
-	__kvm_mmu_refresh_passthrough_bits(vcpu,
-					   container_of(w, struct kvm_mmu, w));
+	__kvm_mmu_refresh_passthrough_bits(vcpu, w);
 }
 
 /*
@@ -199,8 +198,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
-	struct kvm_mmu *mmu = container_of(w, struct kvm_mmu, w);
-
 	/* strip nested paging fault error codes */
 	unsigned int pfec = access;
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
@@ -225,10 +222,10 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 
 	kvm_mmu_refresh_passthrough_bits(vcpu, w);
 
-	fault = (mmu->permissions[index] >> pte_access) & 1;
+	fault = (w->permissions[index] >> pte_access) & 1;
 
 	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
-	if (unlikely(mmu->pkru_mask)) {
+	if (unlikely(w->pkru_mask)) {
 		u32 pkru_bits, offset;
 
 		/*
@@ -242,7 +239,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		/* clear present bit, replace PFEC.RSVD with ACC_USER_MASK. */
 		offset = (pfec & ~1) | ((pte_access & PT_USER_MASK) ? PFERR_RSVD_MASK : 0);
 
-		pkru_bits &= mmu->pkru_mask >> offset;
+		pkru_bits &= w->pkru_mask >> offset;
 		errcode |= -pkru_bits & PFERR_PK_MASK;
 		fault |= (pkru_bits != 0);
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2ef04d8c6f95..cc58b6157118 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5385,13 +5385,13 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 }
 
 static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
-					struct kvm_mmu *context)
+					struct kvm_pagewalk *w)
 {
-	__reset_rsvds_bits_mask(&context->w.guest_rsvd_check,
+	__reset_rsvds_bits_mask(&w->guest_rsvd_check,
 				vcpu->arch.reserved_gpa_bits,
-				context->w.cpu_role.base.level, is_efer_nx(&context->w),
+				w->cpu_role.base.level, is_efer_nx(w),
 				guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES),
-				is_cr4_pse(&context->w),
+				is_cr4_pse(w),
 				guest_cpuid_is_amd_compatible(vcpu));
 }
 
@@ -5566,17 +5566,17 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 	 (14 & (access) ? 1 << 14 : 0) | \
 	 (15 & (access) ? 1 << 15 : 0))
 
-static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
+static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ept)
 {
 	unsigned index;
 
 	const u16 w = ACC_BITS_MASK(ACC_WRITE_MASK);
 	const u16 r = ACC_BITS_MASK(ACC_READ_MASK);
 
-	bool cr4_smep = is_cr4_smep(&mmu->w);
-	bool cr4_smap = is_cr4_smap(&mmu->w);
-	bool cr0_wp = is_cr0_wp(&mmu->w);
-	bool efer_nx = is_efer_nx(&mmu->w);
+	bool cr4_smep = is_cr4_smep(pw);
+	bool cr4_smap = is_cr4_smap(pw);
+	bool cr0_wp = is_cr0_wp(pw);
+	bool efer_nx = is_efer_nx(pw);
 
 	/*
 	 * In hardware, page fault error codes are generated (as the name
@@ -5590,7 +5590,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 	 * permission_fault() to indicate accesses that are *not* subject to
 	 * SMAP restrictions.
 	 */
-	for (index = 0; index < ARRAY_SIZE(mmu->permissions); ++index) {
+	for (index = 0; index < ARRAY_SIZE(pw->permissions); ++index) {
 		unsigned pfec = index << 1;
 
 		/*
@@ -5664,7 +5664,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[index] = ff | uf | wf | rf | smapf;
+		pw->permissions[index] = ff | uf | wf | rf | smapf;
 	}
 }
 
@@ -5692,19 +5692,19 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 * away both AD and WD.  For all reads or if the last condition holds, WD
 * only will be masked away.
 */
-static void update_pkru_bitmask(struct kvm_mmu *mmu)
+static void update_pkru_bitmask(struct kvm_pagewalk *w)
 {
 	unsigned bit;
 	bool wp;
 
-	mmu->pkru_mask = 0;
+	w->pkru_mask = 0;
 
-	if (!is_cr4_pke(&mmu->w))
+	if (!is_cr4_pke(w))
 		return;
 
-	wp = is_cr0_wp(&mmu->w);
+	wp = is_cr0_wp(w);
 
-	for (bit = 0; bit < ARRAY_SIZE(mmu->permissions); ++bit) {
+	for (bit = 0; bit < ARRAY_SIZE(w->permissions); ++bit) {
 		unsigned pfec, pkey_bits;
 		bool check_pkey, check_write, ff, uf, wf, pte_user;
 
@@ -5732,19 +5732,19 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
 		/* PKRU.WD stops write access. */
 		pkey_bits |= (!!check_write) << 1;
 
-		mmu->pkru_mask |= (pkey_bits & 3) << pfec;
+		w->pkru_mask |= (pkey_bits & 3) << pfec;
 	}
 }
 
 static void reset_guest_paging_metadata(struct kvm_vcpu *vcpu,
-					struct kvm_mmu *mmu)
+					struct kvm_pagewalk *w)
 {
-	if (!is_cr0_pg(&mmu->w))
+	if (!is_cr0_pg(w))
 		return;
 
-	reset_guest_rsvds_bits_mask(vcpu, mmu);
-	update_permission_bitmask(mmu, mmu == &vcpu->arch.guest_mmu, false);
-	update_pkru_bitmask(mmu);
+	reset_guest_rsvds_bits_mask(vcpu, w);
+	update_permission_bitmask(w, w == &vcpu->arch.guest_mmu.w, false);
+	update_pkru_bitmask(w);
 }
 
 static void paging64_init_context(struct kvm_mmu *context)
@@ -5803,18 +5803,18 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 }
 
 void __kvm_mmu_refresh_passthrough_bits(struct kvm_vcpu *vcpu,
-					struct kvm_mmu *mmu)
+					struct kvm_pagewalk *w)
 {
 	const bool cr0_wp = kvm_is_cr0_bit_set(vcpu, X86_CR0_WP);
 
 	BUILD_BUG_ON((KVM_MMU_CR0_ROLE_BITS & KVM_POSSIBLE_CR0_GUEST_BITS) != X86_CR0_WP);
 	BUILD_BUG_ON((KVM_MMU_CR4_ROLE_BITS & KVM_POSSIBLE_CR4_GUEST_BITS));
 
-	if (is_cr0_wp(&mmu->w) == cr0_wp)
+	if (is_cr0_wp(w) == cr0_wp)
 		return;
 
-	mmu->w.cpu_role.base.cr0_wp = cr0_wp;
-	reset_guest_paging_metadata(vcpu, mmu);
+	w->cpu_role.base.cr0_wp = cr0_wp;
+	reset_guest_paging_metadata(vcpu, w);
 }
 
 static inline int kvm_mmu_get_tdp_level(struct kvm_vcpu *vcpu)
@@ -5892,7 +5892,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	else
 		context->w.gva_to_gpa = paging32_gva_to_gpa;
 
-	reset_guest_paging_metadata(vcpu, context);
+	reset_guest_paging_metadata(vcpu, &context->w);
 	reset_tdp_shadow_zero_bits_mask(context);
 }
 
@@ -5914,7 +5914,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	else
 		paging32_init_context(context);
 
-	reset_guest_paging_metadata(vcpu, context);
+	reset_guest_paging_metadata(vcpu, &context->w);
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -6015,8 +6015,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->w.gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(context, true, true);
-		context->pkru_mask = 0;
+		update_permission_bitmask(&context->w, true, true);
+		context->w.pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
 	}
@@ -6073,7 +6073,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 	else
 		g_context->w.gva_to_gpa = paging32_gva_to_gpa;
 
-	reset_guest_paging_metadata(vcpu, g_context);
+	reset_guest_paging_metadata(vcpu, &g_context->w);
 }
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
-- 
2.52.0



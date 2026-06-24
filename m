Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8C3E6DD9
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337354; cv=none; b=p5Wjh1KfAC6RT8E4624TnrnRs6d5a1wwx/HE77ODBqKUMy5zgeVSfezjvqtA+KfDSZptb28fifRq/ahHKQzY1tYE1kvf+EARtiJ9ASsv+Xhl5ihYxEP4tXUNOSFeuPFFtyMTKmV6j9ksv7LShXGJPhxA4hondRyJ8o3eF95ymTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337354; c=relaxed/simple;
	bh=Kbny6PnHHlerwBeV1ch7GCrboc4wex1hh+BbjmwKS/M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+5yHvW8g/esIHRNOjiLcKUwTrcllfz+jYhTb2vkQ7oe01nTFXdvtarzTu/3YzhMKfP6sZX+TIN3WNHsfIp7Q0GfEIe8jwcwBk5kFuwPs0JV8fNOa9Fpalfq7AMbGtV9S1PxWVI+2q4btdYTat7EkiK2lh4mQGUfKkJA/mEu+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnJI9H58; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnJI9H58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBIr189HOlbuklnHsHBm8EyT8FQLCEZ+3U94WSLRdM4=;
	b=hnJI9H58/DzR1bMwI+JUJ7xSaFmpyOZN72aQlWBsYEdpTcyXkWsAbrK7vz0HLOhBAZ87Eg
	/wZSsq2sQ6VdQjzs8ORoyANYbmksB2DW0uGs1MxXWFsQ1aZVuEaU6uplDL04TtUE4z56+S
	Y7JbfQJOawikniRQ40qAl57Li0UdVmo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-_QZCy-hSN0-2F9frawaSEw-1; Wed,
 24 Jun 2026 17:42:25 -0400
X-MC-Unique: _QZCy-hSN0-2F9frawaSEw-1
X-Mimecast-MFC-AGG-ID: _QZCy-hSN0-2F9frawaSEw_1782337344
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF00B1802662;
	Wed, 24 Jun 2026 21:42:24 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 59F3930A8;
	Wed, 24 Jun 2026 21:42:24 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 09/19] KVM: x86/mmu: move remaining permission fields to struct kvm_pagewalk
Date: Wed, 24 Jun 2026 17:42:08 -0400
Message-ID: <20260624214218.73796-10-pbonzini@redhat.com>
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

As promised, this removes the remaining instances of
container_of(w, struct kvm_mmu, w).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 30 ++++++++--------
 arch/x86/kvm/mmu.h              | 13 +++----
 arch/x86/kvm/mmu/mmu.c          | 62 ++++++++++++++++-----------------
 3 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a1a6d1400a24..1f48f760bea9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -492,6 +492,21 @@ struct kvm_pagewalk {
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
@@ -504,23 +519,8 @@ struct kvm_mmu {
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
index 18ff5f97e6b7..160614293f5b 100644
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
index 26903774149f..0aff263e3461 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5406,13 +5406,13 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
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
 
@@ -5587,17 +5587,17 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
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
@@ -5611,7 +5611,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 	 * permission_fault() to indicate accesses that are *not* subject to
 	 * SMAP restrictions.
 	 */
-	for (index = 0; index < ARRAY_SIZE(mmu->permissions); ++index) {
+	for (index = 0; index < ARRAY_SIZE(pw->permissions); ++index) {
 		unsigned pfec = index << 1;
 
 		/*
@@ -5685,7 +5685,7 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[index] = ff | uf | wf | rf | smapf;
+		pw->permissions[index] = ff | uf | wf | rf | smapf;
 	}
 }
 
@@ -5713,19 +5713,19 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool tdp, bool ept)
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
 
@@ -5753,19 +5753,19 @@ static void update_pkru_bitmask(struct kvm_mmu *mmu)
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
@@ -5824,18 +5824,18 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
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
@@ -5913,7 +5913,7 @@ static void init_kvm_tdp_mmu(struct kvm_vcpu *vcpu,
 	else
 		context->w.gva_to_gpa = paging32_gva_to_gpa;
 
-	reset_guest_paging_metadata(vcpu, context);
+	reset_guest_paging_metadata(vcpu, &context->w);
 	reset_tdp_shadow_zero_bits_mask(context);
 }
 
@@ -5935,7 +5935,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	else
 		paging32_init_context(context);
 
-	reset_guest_paging_metadata(vcpu, context);
+	reset_guest_paging_metadata(vcpu, &context->w);
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
@@ -6036,8 +6036,8 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->w.gva_to_gpa = ept_gva_to_gpa;
 		context->sync_spte = ept_sync_spte;
 
-		update_permission_bitmask(context, true, true);
-		context->pkru_mask = 0;
+		update_permission_bitmask(&context->w, true, true);
+		context->w.pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, context, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
 	}
@@ -6094,7 +6094,7 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu,
 	else
 		g_context->w.gva_to_gpa = paging32_gva_to_gpa;
 
-	reset_guest_paging_metadata(vcpu, g_context);
+	reset_guest_paging_metadata(vcpu, &g_context->w);
 }
 
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
-- 
2.52.0



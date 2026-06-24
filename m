Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EA3E8C75
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336681; cv=none; b=kX7m7nsFOBSPj23axkNLXp3tH18Jv/Q6pv57UIpLiK3pedQAScI5kCBwRqXoxMdPIRXfjOE4L6X/IVUi0FZj9K1gPHOoFcWTCKm4aLBuDuh3ctFF+7fPgweTgXWMTU0uoGKt20V9FeWmIg70lPnT7U18Z+xDce+bfXt/D+5xZE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336681; c=relaxed/simple;
	bh=/f3Lbpuxm3Xq+dmARtlv0e6DHSyKzverSgVRBD5Qi7Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRtUCy67wk483EUtiz5CoKM76vRrZVw7TUlj0ARt567RAqnRmfWlotVfhfKGugFbI+BsQGV+c5aszkuuKlZbFRsCsPS7Ya3KEqAznr8Mos9s+MubhGKWvdwgvexvKyU6vBVD85R0r2wOrASbRgWmIAcTiLdgohRTWC0iWt1ZUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3NappzT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3NappzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0rx8hXn6dmaTpUDMpunMfBU8YKK3tkSJLM9+nkeYcg=;
	b=A3NappzTebrx2sZ0rbL+QY9eN1oMLGwKec64/rbzR9CbnyzfrbZn47flm4mkFozNXqRRZS
	lIbMRE/g7qs1NHfeNuWaL27sbfVeVpk1CTaV90NExD+5CbTUP8eiJU0p3Vei4E49TZTIEW
	yfa0HzSSjJkfVqnQE/4B0ND/3x3ZSME=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504--QCvKvoAMESK2QLaMUOIfQ-1; Wed,
 24 Jun 2026 17:31:15 -0400
X-MC-Unique: -QCvKvoAMESK2QLaMUOIfQ-1
X-Mimecast-MFC-AGG-ID: -QCvKvoAMESK2QLaMUOIfQ_1782336674
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6705018052CE;
	Wed, 24 Jun 2026 21:31:14 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0099C195608D;
	Wed, 24 Jun 2026 21:31:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 16/19] KVM: x86/mmu: pull page format to a new struct
Date: Wed, 24 Jun 2026 17:30:59 -0400
Message-ID: <20260624213102.71082-17-pbonzini@redhat.com>
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

KVM is doing reserved bits checks on both guest and host page tables,
though the latter are only for consistency.  Create a new struct
for this common code as well as for all data that is extracted from
the CPU role.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 25 +++++++++++++++----------
 arch/x86/kvm/mmu.h              |  7 ++++---
 arch/x86/kvm/mmu/mmu.c          | 16 ++++++++--------
 arch/x86/kvm/mmu/paging_tmpl.h  | 10 +++++-----
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8a2126ca49c4..08aa1e2da582 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -516,16 +516,7 @@ struct kvm_page_fault;
  * and 2-level 32-bit).  The kvm_pagewalk structure abstracts the details of the
  * current mmu mode.
  */
-struct kvm_pagewalk {
-	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
-	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
-	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
-				  struct x86_exception *fault,
-				  bool from_hardware);
-	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
-			    gpa_t gva_or_gpa, u64 access,
-			    struct x86_exception *exception);
-	union kvm_cpu_role cpu_role;
+struct kvm_page_format {
 	struct rsvd_bits_validate guest_rsvd_check;
 
 	/*
@@ -544,6 +535,20 @@ struct kvm_pagewalk {
 	u16 permissions[16];
 };
 
+struct kvm_pagewalk {
+	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
+	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
+	void (*inject_page_fault)(struct kvm_vcpu *vcpu,
+				  struct x86_exception *fault,
+				  bool from_hardware);
+	gpa_t (*gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
+			    gpa_t gva_or_gpa, u64 access,
+			    struct x86_exception *exception);
+
+	union kvm_cpu_role cpu_role;
+	struct kvm_page_format fmt;
+};
+
 struct kvm_mmu {
 	int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault);
 	int (*sync_spte)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 9d00d0eb230b..c9f628b97dae 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -294,15 +294,16 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 	u64 implicit_access = access & PFERR_IMPLICIT_ACCESS;
 	bool not_smap = ((rflags & X86_EFLAGS_AC) | implicit_access) == X86_EFLAGS_AC;
 	int index = (pfec | (not_smap ? PFERR_RSVD_MASK : 0)) >> 1;
+	struct kvm_page_format *fmt = &w->fmt;
 	u32 errcode = PFERR_PRESENT_MASK;
 	bool fault;
 
 	kvm_mmu_refresh_passthrough_bits(vcpu, w);
 
-	fault = (w->permissions[index] >> pte_access) & 1;
+	fault = (fmt->permissions[index] >> pte_access) & 1;
 
 	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
-	if (unlikely(w->pkru_mask)) {
+	if (unlikely(fmt->pkru_mask)) {
 		u32 pkru_bits, offset;
 
 		/*
@@ -316,7 +317,7 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_pagewalk *w,
 		/* clear present bit, replace PFEC.RSVD with ACC_USER_MASK. */
 		offset = (pfec & ~1) | ((pte_access & PT_USER_MASK) ? PFERR_RSVD_MASK : 0);
 
-		pkru_bits &= w->pkru_mask >> offset;
+		pkru_bits &= fmt->pkru_mask >> offset;
 		errcode |= -pkru_bits & PFERR_PK_MASK;
 		fault |= (pkru_bits != 0);
 	}
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 71ad933d34c9..f70892b15680 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5479,7 +5479,7 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 					struct kvm_pagewalk *w)
 {
-	__reset_rsvds_bits_mask(&w->guest_rsvd_check,
+	__reset_rsvds_bits_mask(&w->fmt.guest_rsvd_check,
 				vcpu->arch.reserved_gpa_bits,
 				w->cpu_role.base.level, is_efer_nx(w),
 				guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES),
@@ -5528,7 +5528,7 @@ static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
 static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
 		bool execonly, int huge_page_level)
 {
-	__reset_rsvds_bits_mask_ept(&vcpu->arch.ngpa_walk.guest_rsvd_check,
+	__reset_rsvds_bits_mask_ept(&vcpu->arch.ngpa_walk.fmt.guest_rsvd_check,
 				    vcpu->arch.reserved_gpa_bits, execonly,
 				    huge_page_level);
 }
@@ -5682,7 +5682,7 @@ static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ep
 	 * permission_fault() to indicate accesses that are *not* subject to
 	 * SMAP restrictions.
 	 */
-	for (index = 0; index < ARRAY_SIZE(pw->permissions); ++index) {
+	for (index = 0; index < ARRAY_SIZE(pw->fmt.permissions); ++index) {
 		unsigned pfec = index << 1;
 
 		/*
@@ -5756,7 +5756,7 @@ static void update_permission_bitmask(struct kvm_pagewalk *pw, bool tdp, bool ep
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		pw->permissions[index] = ff | uf | wf | rf | smapf;
+		pw->fmt.permissions[index] = ff | uf | wf | rf | smapf;
 	}
 }
 
@@ -5789,14 +5789,14 @@ static void update_pkru_bitmask(struct kvm_pagewalk *w)
 	unsigned bit;
 	bool wp;
 
-	w->pkru_mask = 0;
+	w->fmt.pkru_mask = 0;
 
 	if (!is_cr4_pke(w))
 		return;
 
 	wp = is_cr0_wp(w);
 
-	for (bit = 0; bit < ARRAY_SIZE(w->permissions); ++bit) {
+	for (bit = 0; bit < ARRAY_SIZE(w->fmt.permissions); ++bit) {
 		unsigned pfec, pkey_bits;
 		bool check_pkey, check_write, ff, uf, wf, pte_user;
 
@@ -5824,7 +5824,7 @@ static void update_pkru_bitmask(struct kvm_pagewalk *w)
 		/* PKRU.WD stops write access. */
 		pkey_bits |= (!!check_write) << 1;
 
-		w->pkru_mask |= (pkey_bits & 3) << pfec;
+		w->fmt.pkru_mask |= (pkey_bits & 3) << pfec;
 	}
 }
 
@@ -6113,7 +6113,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 		context->sync_spte = ept_sync_spte;
 
 		update_permission_bitmask(ngpa_walk, true, true);
-		ngpa_walk->pkru_mask = 0;
+		ngpa_walk->fmt.pkru_mask = 0;
 		reset_rsvds_bits_mask_ept(vcpu, execonly, huge_page_level);
 		reset_ept_shadow_zero_bits_mask(context, execonly);
 	}
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index a46384b7080f..58397f58320f 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -147,10 +147,10 @@ static bool FNAME(is_bad_mt_xwr)(struct rsvd_bits_validate *rsvd_check, u64 gpte
 #endif
 }
 
-static bool FNAME(is_rsvd_bits_set)(struct kvm_pagewalk *w, u64 gpte, int level)
+static bool FNAME(is_rsvd_bits_set)(struct kvm_page_format *fmt, u64 gpte, int level)
 {
-	return __is_rsvd_bits_set(&w->guest_rsvd_check, gpte, level) ||
-	       FNAME(is_bad_mt_xwr)(&w->guest_rsvd_check, gpte);
+	return __is_rsvd_bits_set(&fmt->guest_rsvd_check, gpte, level) ||
+	       FNAME(is_bad_mt_xwr)(&fmt->guest_rsvd_check, gpte);
 }
 
 static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
@@ -167,7 +167,7 @@ static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
 	    !(gpte & PT_GUEST_ACCESSED_MASK))
 		goto no_present;
 
-	if (FNAME(is_rsvd_bits_set)(w, gpte, PG_LEVEL_4K))
+	if (FNAME(is_rsvd_bits_set)(&w->fmt, gpte, PG_LEVEL_4K))
 		goto no_present;
 
 	return false;
@@ -427,7 +427,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(!FNAME(is_present_gpte)(w, pte)))
 			goto error;
 
-		if (unlikely(FNAME(is_rsvd_bits_set)(w, pte, walker->level))) {
+		if (unlikely(FNAME(is_rsvd_bits_set)(&w->fmt, pte, walker->level))) {
 			errcode = PFERR_RSVD_MASK | PFERR_PRESENT_MASK;
 			goto error;
 		}
-- 
2.52.0



Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA647A0D4
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484316; cv=none; b=QjKWFIOBjWTeMR5SkdmDrkV1idQkwgv93xWon8qeWtNf2pRMC/iCfJutmpIoCoTG5N8lbypOoe3g3xoPXElZcXlbQFVyOZqVJ83Sh5ypJJaSnHaoukHB6+KDlJisZT+zlM6JzkKG9ahShsff+jm1l+fOpJGjMr55vyWc0UvsX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484316; c=relaxed/simple;
	bh=A9sREkDluf2c1wkFWS2AA0Sn2AJNtLHjZZI6WxZfROA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDNtISfQDH9y8D5t+1RJmB3yyyDtwv37dI6sZW5UWGKEslzNY4yrl0vE31+PR9xIGUGQA+Xy12ZA6t/xwzFvTwG8v8aAhVnYBrSirMEPQ8E2cfcmbMQc3Sentt4Fjh/4jy0u/gdMUJSv4l0gVrlrVvvpeLwWZ8kcaT4etTZ1Ouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PW3DV+ib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PW3DV+ib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VBDBOAA68Z2RLXsNaERQBzOZuXSc467HItqKkZUXZo=;
	b=PW3DV+ibfvHIFBo6Cevu9FZSRT6acosaqtXjA4FV2l5viJjCimsFdwhUTFz2YrOJK6FOCc
	Gja/dqjPUYNCib4dpXPqHyX/FX1TJKUAEKRtK/LwArcgpDkhCLww9qN7KOyzIJWXJLAyGS
	MRxb0uqFMXQZbnzMzQTFDnbjyLcTk24=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-2MeMkBXOMzO7ewrmPewCPw-1; Wed,
 03 Jun 2026 06:58:29 -0400
X-MC-Unique: 2MeMkBXOMzO7ewrmPewCPw-1
X-Mimecast-MFC-AGG-ID: 2MeMkBXOMzO7ewrmPewCPw_1780484308
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BB3A18004D4;
	Wed,  3 Jun 2026 10:58:28 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20098195E483;
	Wed,  3 Jun 2026 10:58:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 22/24] KVM: x86/mmu: merge struct rsvd_bits_validate into struct kvm_page_format
Date: Wed,  3 Jun 2026 06:58:12 -0400
Message-ID: <20260603105814.10236-23-pbonzini@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Remove one level of indirection, and prepare for using the permission bitmask
machinery for shadow pages as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  38 +++++------
 arch/x86/kvm/mmu/mmu.c          | 116 ++++++++++++++++----------------
 arch/x86/kvm/mmu/paging_tmpl.h  |   8 +--
 arch/x86/kvm/mmu/spte.c         |   4 +-
 arch/x86/kvm/mmu/spte.h         |  18 ++---
 arch/x86/kvm/vmx/vmx.c          |   2 +-
 6 files changed, 91 insertions(+), 95 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 08fb47f2b7fc..7c6ac551a2d9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -450,9 +450,24 @@ struct kvm_pio_request {
 
 #define PT64_ROOT_MAX_LEVEL 5
 
-struct rsvd_bits_validate {
+struct kvm_page_format {
 	u64 rsvd_bits_mask[2][PT64_ROOT_MAX_LEVEL];
 	u64 bad_mt_xwr;
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
 
 struct kvm_mmu_root_info {
@@ -479,25 +494,6 @@ struct kvm_page_fault;
  * and 2-level 32-bit).  The kvm_pagewalk structure abstracts the details of the
  * current mmu mode.
  */
-struct kvm_page_format {
-	struct rsvd_bits_validate guest_rsvd_check;
-
-	/*
-	* The pkru_mask indicates if protection key checks are needed.  It
-	* consists of 16 domains indexed by page fault error code bits [4:1],
-	* with PFEC.RSVD replaced by ACC_USER_MASK from the page tables.
-	* Each domain has 2 bits which are ANDed with AD and WD from PKRU.
-	*/
-	u32 pkru_mask;
-
-	/*
-	 * Bitmap; bit set = permission fault
-	 * Array index: page fault error code [4:1]
-	 * Bit index: pte permissions in ACC_* format
-	 */
-	u16 permissions[16];
-};
-
 struct kvm_pagewalk {
 	unsigned long (*get_guest_pgd)(struct kvm_vcpu *vcpu);
 	u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
@@ -532,7 +528,7 @@ struct kvm_mmu {
 	 * bits include not only hardware reserved bits but also
 	 * the bits spte never used.
 	 */
-	struct rsvd_bits_validate shadow_zero_check;
+	struct kvm_page_format fmt;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 420bd70fb54a..29755afe5b46 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4422,7 +4422,7 @@ static int get_sptes_lockless(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 {
 	u64 sptes[PT64_ROOT_MAX_LEVEL + 1];
-	struct rsvd_bits_validate *rsvd_check;
+	struct kvm_page_format *rsvd_check;
 	int root, leaf, level;
 	bool reserved = false;
 
@@ -4443,7 +4443,7 @@ static bool get_mmio_spte(struct kvm_vcpu *vcpu, u64 addr, u64 *sptep)
 	if (!is_shadow_present_pte(sptes[leaf]))
 		leaf++;
 
-	rsvd_check = &vcpu->arch.mmu->shadow_zero_check;
+	rsvd_check = &vcpu->arch.mmu->fmt;
 
 	for (level = root; level >= leaf; level--)
 		reserved |= is_rsvd_spte(rsvd_check, sptes[level], level);
@@ -5298,7 +5298,7 @@ static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
 #include "paging_tmpl.h"
 #undef PTTYPE
 
-static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
+static void __reset_rsvds_bits_mask(struct kvm_page_format *fmt,
 				    u64 pa_bits_rsvd, int level, bool nx,
 				    bool gbpages, bool pse, bool amd)
 {
@@ -5306,7 +5306,7 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 	u64 nonleaf_bit8_rsvd = 0;
 	u64 high_bits_rsvd;
 
-	rsvd_check->bad_mt_xwr = 0;
+	fmt->bad_mt_xwr = 0;
 
 	if (!gbpages)
 		gbpages_bit_rsvd = rsvd_bits(7, 7);
@@ -5330,59 +5330,59 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 	switch (level) {
 	case PT32_ROOT_LEVEL:
 		/* no rsvd bits for 2 level 4K page table entries */
-		rsvd_check->rsvd_bits_mask[0][1] = 0;
-		rsvd_check->rsvd_bits_mask[0][0] = 0;
-		rsvd_check->rsvd_bits_mask[1][0] =
-			rsvd_check->rsvd_bits_mask[0][0];
+		fmt->rsvd_bits_mask[0][1] = 0;
+		fmt->rsvd_bits_mask[0][0] = 0;
+		fmt->rsvd_bits_mask[1][0] =
+			fmt->rsvd_bits_mask[0][0];
 
 		if (!pse) {
-			rsvd_check->rsvd_bits_mask[1][1] = 0;
+			fmt->rsvd_bits_mask[1][1] = 0;
 			break;
 		}
 
 		if (is_cpuid_PSE36())
 			/* 36bits PSE 4MB page */
-			rsvd_check->rsvd_bits_mask[1][1] = rsvd_bits(17, 21);
+			fmt->rsvd_bits_mask[1][1] = rsvd_bits(17, 21);
 		else
 			/* 32 bits PSE 4MB page */
-			rsvd_check->rsvd_bits_mask[1][1] = rsvd_bits(13, 21);
+			fmt->rsvd_bits_mask[1][1] = rsvd_bits(13, 21);
 		break;
 	case PT32E_ROOT_LEVEL:
-		rsvd_check->rsvd_bits_mask[0][2] = rsvd_bits(63, 63) |
+		fmt->rsvd_bits_mask[0][2] = rsvd_bits(63, 63) |
 						   high_bits_rsvd |
 						   rsvd_bits(5, 8) |
 						   rsvd_bits(1, 2);	/* PDPTE */
-		rsvd_check->rsvd_bits_mask[0][1] = high_bits_rsvd;	/* PDE */
-		rsvd_check->rsvd_bits_mask[0][0] = high_bits_rsvd;	/* PTE */
-		rsvd_check->rsvd_bits_mask[1][1] = high_bits_rsvd |
+		fmt->rsvd_bits_mask[0][1] = high_bits_rsvd;	/* PDE */
+		fmt->rsvd_bits_mask[0][0] = high_bits_rsvd;	/* PTE */
+		fmt->rsvd_bits_mask[1][1] = high_bits_rsvd |
 						   rsvd_bits(13, 20);	/* large page */
-		rsvd_check->rsvd_bits_mask[1][0] =
-			rsvd_check->rsvd_bits_mask[0][0];
+		fmt->rsvd_bits_mask[1][0] =
+			fmt->rsvd_bits_mask[0][0];
 		break;
 	case PT64_ROOT_5LEVEL:
-		rsvd_check->rsvd_bits_mask[0][4] = high_bits_rsvd |
+		fmt->rsvd_bits_mask[0][4] = high_bits_rsvd |
 						   nonleaf_bit8_rsvd |
 						   rsvd_bits(7, 7);
-		rsvd_check->rsvd_bits_mask[1][4] =
-			rsvd_check->rsvd_bits_mask[0][4];
+		fmt->rsvd_bits_mask[1][4] =
+			fmt->rsvd_bits_mask[0][4];
 		fallthrough;
 	case PT64_ROOT_4LEVEL:
-		rsvd_check->rsvd_bits_mask[0][3] = high_bits_rsvd |
+		fmt->rsvd_bits_mask[0][3] = high_bits_rsvd |
 						   nonleaf_bit8_rsvd |
 						   rsvd_bits(7, 7);
-		rsvd_check->rsvd_bits_mask[0][2] = high_bits_rsvd |
+		fmt->rsvd_bits_mask[0][2] = high_bits_rsvd |
 						   gbpages_bit_rsvd;
-		rsvd_check->rsvd_bits_mask[0][1] = high_bits_rsvd;
-		rsvd_check->rsvd_bits_mask[0][0] = high_bits_rsvd;
-		rsvd_check->rsvd_bits_mask[1][3] =
-			rsvd_check->rsvd_bits_mask[0][3];
-		rsvd_check->rsvd_bits_mask[1][2] = high_bits_rsvd |
+		fmt->rsvd_bits_mask[0][1] = high_bits_rsvd;
+		fmt->rsvd_bits_mask[0][0] = high_bits_rsvd;
+		fmt->rsvd_bits_mask[1][3] =
+			fmt->rsvd_bits_mask[0][3];
+		fmt->rsvd_bits_mask[1][2] = high_bits_rsvd |
 						   gbpages_bit_rsvd |
 						   rsvd_bits(13, 29);
-		rsvd_check->rsvd_bits_mask[1][1] = high_bits_rsvd |
+		fmt->rsvd_bits_mask[1][1] = high_bits_rsvd |
 						   rsvd_bits(13, 20); /* large page */
-		rsvd_check->rsvd_bits_mask[1][0] =
-			rsvd_check->rsvd_bits_mask[0][0];
+		fmt->rsvd_bits_mask[1][0] =
+			fmt->rsvd_bits_mask[0][0];
 		break;
 	}
 }
@@ -5390,7 +5390,7 @@ static void __reset_rsvds_bits_mask(struct rsvd_bits_validate *rsvd_check,
 static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 					struct kvm_pagewalk *w)
 {
-	__reset_rsvds_bits_mask(&w->fmt.guest_rsvd_check,
+	__reset_rsvds_bits_mask(&w->fmt,
 				vcpu->arch.reserved_gpa_bits,
 				w->cpu_role.base.level, is_efer_nx(w),
 				guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES),
@@ -5398,7 +5398,7 @@ static void reset_guest_rsvds_bits_mask(struct kvm_vcpu *vcpu,
 				guest_cpuid_is_amd_compatible(vcpu));
 }
 
-static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
+static void __reset_rsvds_bits_mask_ept(struct kvm_page_format *fmt,
 					u64 pa_bits_rsvd, bool execonly,
 					int huge_page_level)
 {
@@ -5411,18 +5411,18 @@ static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
 	if (huge_page_level < PG_LEVEL_2M)
 		large_2m_rsvd = rsvd_bits(7, 7);
 
-	rsvd_check->rsvd_bits_mask[0][4] = high_bits_rsvd | rsvd_bits(3, 7);
-	rsvd_check->rsvd_bits_mask[0][3] = high_bits_rsvd | rsvd_bits(3, 7);
-	rsvd_check->rsvd_bits_mask[0][2] = high_bits_rsvd | rsvd_bits(3, 6) | large_1g_rsvd;
-	rsvd_check->rsvd_bits_mask[0][1] = high_bits_rsvd | rsvd_bits(3, 6) | large_2m_rsvd;
-	rsvd_check->rsvd_bits_mask[0][0] = high_bits_rsvd;
+	fmt->rsvd_bits_mask[0][4] = high_bits_rsvd | rsvd_bits(3, 7);
+	fmt->rsvd_bits_mask[0][3] = high_bits_rsvd | rsvd_bits(3, 7);
+	fmt->rsvd_bits_mask[0][2] = high_bits_rsvd | rsvd_bits(3, 6) | large_1g_rsvd;
+	fmt->rsvd_bits_mask[0][1] = high_bits_rsvd | rsvd_bits(3, 6) | large_2m_rsvd;
+	fmt->rsvd_bits_mask[0][0] = high_bits_rsvd;
 
 	/* large page */
-	rsvd_check->rsvd_bits_mask[1][4] = rsvd_check->rsvd_bits_mask[0][4];
-	rsvd_check->rsvd_bits_mask[1][3] = rsvd_check->rsvd_bits_mask[0][3];
-	rsvd_check->rsvd_bits_mask[1][2] = high_bits_rsvd | rsvd_bits(12, 29) | large_1g_rsvd;
-	rsvd_check->rsvd_bits_mask[1][1] = high_bits_rsvd | rsvd_bits(12, 20) | large_2m_rsvd;
-	rsvd_check->rsvd_bits_mask[1][0] = rsvd_check->rsvd_bits_mask[0][0];
+	fmt->rsvd_bits_mask[1][4] = fmt->rsvd_bits_mask[0][4];
+	fmt->rsvd_bits_mask[1][3] = fmt->rsvd_bits_mask[0][3];
+	fmt->rsvd_bits_mask[1][2] = high_bits_rsvd | rsvd_bits(12, 29) | large_1g_rsvd;
+	fmt->rsvd_bits_mask[1][1] = high_bits_rsvd | rsvd_bits(12, 20) | large_2m_rsvd;
+	fmt->rsvd_bits_mask[1][0] = fmt->rsvd_bits_mask[0][0];
 
 	bad_mt_xwr = 0xFFull << (2 * 8);	/* bits 3..5 must not be 2 */
 	bad_mt_xwr |= 0xFFull << (3 * 8);	/* bits 3..5 must not be 3 */
@@ -5433,13 +5433,13 @@ static void __reset_rsvds_bits_mask_ept(struct rsvd_bits_validate *rsvd_check,
 		/* bits 0..2 must not be 100 unless VMX capabilities allow it */
 		bad_mt_xwr |= REPEAT_BYTE(1ull << 4);
 	}
-	rsvd_check->bad_mt_xwr = bad_mt_xwr;
+	fmt->bad_mt_xwr = bad_mt_xwr;
 }
 
 static void reset_rsvds_bits_mask_ept(struct kvm_vcpu *vcpu,
 		bool execonly, int huge_page_level)
 {
-	__reset_rsvds_bits_mask_ept(&vcpu->arch.ngpa_walk.fmt.guest_rsvd_check,
+	__reset_rsvds_bits_mask_ept(&vcpu->arch.ngpa_walk.fmt,
 				    vcpu->arch.reserved_gpa_bits, execonly,
 				    huge_page_level);
 }
@@ -5461,13 +5461,13 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 	bool is_amd = true;
 	/* KVM doesn't use 2-level page tables for the shadow MMU. */
 	bool is_pse = false;
-	struct rsvd_bits_validate *shadow_zero_check;
+	struct kvm_page_format *fmt;
 	int i;
 
 	WARN_ON_ONCE(context->root_role.level < PT32E_ROOT_LEVEL);
 
-	shadow_zero_check = &context->shadow_zero_check;
-	__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
+	fmt = &context->fmt;
+	__reset_rsvds_bits_mask(fmt, reserved_hpa_bits(),
 				context->root_role.level,
 				context->root_role.efer_nx,
 				guest_cpu_cap_has(vcpu, X86_FEATURE_GBPAGES),
@@ -5483,10 +5483,10 @@ static void reset_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
 		 * Bits in shadow_me_mask but not in shadow_me_value are
 		 * not allowed to be set.
 		 */
-		shadow_zero_check->rsvd_bits_mask[0][i] |= shadow_me_mask;
-		shadow_zero_check->rsvd_bits_mask[1][i] |= shadow_me_mask;
-		shadow_zero_check->rsvd_bits_mask[0][i] &= ~shadow_me_value;
-		shadow_zero_check->rsvd_bits_mask[1][i] &= ~shadow_me_value;
+		fmt->rsvd_bits_mask[0][i] |= shadow_me_mask;
+		fmt->rsvd_bits_mask[1][i] |= shadow_me_mask;
+		fmt->rsvd_bits_mask[0][i] &= ~shadow_me_value;
+		fmt->rsvd_bits_mask[1][i] &= ~shadow_me_value;
 	}
 
 }
@@ -5503,18 +5503,18 @@ static inline bool boot_cpu_is_amd(void)
  */
 static void reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
 {
-	struct rsvd_bits_validate *shadow_zero_check;
+	struct kvm_page_format *fmt;
 	int i;
 
-	shadow_zero_check = &context->shadow_zero_check;
+	fmt = &context->fmt;
 
 	if (boot_cpu_is_amd())
-		__reset_rsvds_bits_mask(shadow_zero_check, reserved_hpa_bits(),
+		__reset_rsvds_bits_mask(fmt, reserved_hpa_bits(),
 					context->root_role.level, true,
 					boot_cpu_has(X86_FEATURE_GBPAGES),
 					false, true);
 	else
-		__reset_rsvds_bits_mask_ept(shadow_zero_check,
+		__reset_rsvds_bits_mask_ept(fmt,
 					    reserved_hpa_bits(), false,
 					    max_huge_page_level);
 
@@ -5522,8 +5522,8 @@ static void reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
 		return;
 
 	for (i = context->root_role.level; --i >= 0;) {
-		shadow_zero_check->rsvd_bits_mask[0][i] &= ~shadow_me_mask;
-		shadow_zero_check->rsvd_bits_mask[1][i] &= ~shadow_me_mask;
+		fmt->rsvd_bits_mask[0][i] &= ~shadow_me_mask;
+		fmt->rsvd_bits_mask[1][i] &= ~shadow_me_mask;
 	}
 }
 
@@ -5534,7 +5534,7 @@ static void reset_tdp_shadow_zero_bits_mask(struct kvm_mmu *context)
 static void
 reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 {
-	__reset_rsvds_bits_mask_ept(&context->shadow_zero_check,
+	__reset_rsvds_bits_mask_ept(&context->fmt,
 				    reserved_hpa_bits(), execonly,
 				    max_huge_page_level);
 }
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index fe12e9d17b0e..625fe35a1911 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -138,19 +138,19 @@ static inline int FNAME(is_present_gpte)(struct kvm_pagewalk *w,
 #endif
 }
 
-static bool FNAME(is_bad_mt_xwr)(struct rsvd_bits_validate *rsvd_check, u64 gpte)
+static bool FNAME(is_bad_mt_xwr)(struct kvm_page_format *fmt, u64 gpte)
 {
 #if PTTYPE != PTTYPE_EPT
 	return false;
 #else
-	return __is_bad_mt_xwr(rsvd_check, gpte);
+	return __is_bad_mt_xwr(fmt, gpte);
 #endif
 }
 
 static bool FNAME(is_rsvd_bits_set)(struct kvm_page_format *fmt, u64 gpte, int level)
 {
-	return __is_rsvd_bits_set(&fmt->guest_rsvd_check, gpte, level) ||
-	       FNAME(is_bad_mt_xwr)(&fmt->guest_rsvd_check, gpte);
+	return __is_rsvd_bits_set(fmt, gpte, level) ||
+	       FNAME(is_bad_mt_xwr)(fmt, gpte);
 }
 
 static bool FNAME(prefetch_invalid_gpte)(struct kvm_vcpu *vcpu,
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index d2f5f7dd8fe1..bdf72a98c19c 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -280,9 +280,9 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	if (prefetch && !synchronizing)
 		spte = mark_spte_for_access_track(spte);
 
-	WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->shadow_zero_check, spte, level),
+	WARN_ONCE(is_rsvd_spte(&vcpu->arch.mmu->fmt, spte, level),
 		  "spte = 0x%llx, level = %d, rsvd bits = 0x%llx", spte, level,
-		  get_rsvd_bits(&vcpu->arch.mmu->shadow_zero_check, spte, level));
+		  get_rsvd_bits(&vcpu->arch.mmu->fmt, spte, level));
 
 	/*
 	 * Mark the memslot dirty *after* modifying it for access tracking.
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 13eea94dd212..918533e61b98 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -378,33 +378,33 @@ static inline bool is_accessed_spte(u64 spte)
 	return spte & shadow_accessed_mask;
 }
 
-static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
+static inline u64 get_rsvd_bits(struct kvm_page_format *fmt, u64 pte,
 				int level)
 {
 	int bit7 = (pte >> 7) & 1;
 
-	return rsvd_check->rsvd_bits_mask[bit7][level-1];
+	return fmt->rsvd_bits_mask[bit7][level-1];
 }
 
-static inline bool __is_rsvd_bits_set(struct rsvd_bits_validate *rsvd_check,
+static inline bool __is_rsvd_bits_set(struct kvm_page_format *fmt,
 				      u64 pte, int level)
 {
-	return pte & get_rsvd_bits(rsvd_check, pte, level);
+	return pte & get_rsvd_bits(fmt, pte, level);
 }
 
-static inline bool __is_bad_mt_xwr(struct rsvd_bits_validate *rsvd_check,
+static inline bool __is_bad_mt_xwr(struct kvm_page_format *fmt,
 				   u64 pte)
 {
 	if (pte & VMX_EPT_USER_EXECUTABLE_MASK)
 		pte |= VMX_EPT_EXECUTABLE_MASK;
-	return rsvd_check->bad_mt_xwr & BIT_ULL(pte & 0x3f);
+	return fmt->bad_mt_xwr & BIT_ULL(pte & 0x3f);
 }
 
-static __always_inline bool is_rsvd_spte(struct rsvd_bits_validate *rsvd_check,
+static __always_inline bool is_rsvd_spte(struct kvm_page_format *fmt,
 					 u64 spte, int level)
 {
-	return __is_bad_mt_xwr(rsvd_check, spte) ||
-	       __is_rsvd_bits_set(rsvd_check, spte, level);
+	return __is_bad_mt_xwr(fmt, spte) ||
+	       __is_rsvd_bits_set(fmt, spte, level);
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5b74315f7e95..6565072760f1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -8703,7 +8703,7 @@ __init int vmx_hardware_setup(void)
 
 	/*
 	 * Setup shadow_me_value/shadow_me_mask to include MKTME KeyID
-	 * bits to shadow_zero_check.
+	 * bits into the MMU's struct kvm_page_format.
 	 */
 	vmx_setup_me_spte_mask();
 
-- 
2.52.0



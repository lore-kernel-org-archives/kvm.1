Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241838AC9A;
	Thu, 28 May 2026 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958342; cv=none; b=f9md9Ew5MZB4xMV581KMvD8Al3yoqzlnVTpWdlbLYPR0f1fnVEH1Ls0kvcUq5eYM4CyW/3dzygfMgmGZ/3ZiPCjStbjidheDfDZI4cByPxnSyn0nDjWPhowk0C3pyGYi7Vuc71WfRSSG7N7YWUev4uZhuzXziA8rh5PJ6Y1gxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958342; c=relaxed/simple;
	bh=Vi33lAduXmB8DG9hDNu1NCuCE3ah6p8mFdsGeLHyWKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW+nNpMOFDCbvmU3EdF/s7FSgShW73mWAoC7u/w3m5CGqLwGP72zRhnXiFnQwhrO4fgnyvCEF+41e8WHCQPixGJ1wJFOWBfELdx6v766WYDytmRjmAQZ2k7evaDhq2FDJ+TJ2lQfXJeOfZ1katBe9HBL2Z8psnSN8dN4LhNZq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETbqbFn4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETbqbFn4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958341; x=1811494341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vi33lAduXmB8DG9hDNu1NCuCE3ah6p8mFdsGeLHyWKs=;
  b=ETbqbFn4fCkSrDlEr8vJIYdmAqQxyk/HOSQVTmkorNJ6kpYbW7llVDVo
   UCcajjntgafwhyzfni7+MtStbZYGexpd9M/OGvxzE7Qn3hOGXNDfJDm7d
   0B3D8hO95OSn74rPSgF/zMHroy0cj0CYIF1kagHTJdI0OmsRIy/b+BWqT
   e7koUesdEHh9csf1AHPJwQAIlF3tSJD+E4winWhUB6qr/uo3AIqgy6ZJJ
   sveZZ/PM8aFwSK9C1Nm5hbxCG3AU6BGHZAqqm1J4Ns7SxisDU+xholUAs
   tGKfY/FNiRiKhLTlTOtDwMN5O1Svk8To6hojgFbc5MOszW81TfimCPMI1
   g==;
X-CSE-ConnectionGUID: CZrtAjynTyWw0RYNyYhPqQ==
X-CSE-MsgGUID: HHFZw6jPSeWofVPGBNqj2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80857188"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80857188"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:21 -0700
X-CSE-ConnectionGUID: q+GuSvCLQjGYxea0DiW/VA==
X-CSE-MsgGUID: xYjWeyWdR0qa/VO88okizw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244322378"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:17 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v3 08/15] KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's handle_changed_spte()
Date: Thu, 28 May 2026 16:12:13 +0800
Message-ID: <20260528081213.10332-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260528080856.10141-1-yan.y.zhao@intel.com>
References: <20260528080856.10141-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Plumb the "sp" pointer into handle_changed_spte() to allow checking of
is_mirror_sp(sp) in handle_changed_spte() in the next patch. This is a
preparation to consolidate all S-EPT updates into a single kvm_x86_ops
hook.

[Yan: Remove unused "as_id" param in tdp_mmu_set_spte() ]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
-Split out and added back this patch.
 (The patch was in Sean's original series, and had "SPTE" instead of "sp"
 in title). (Yan)
- Remove unused "as_id" param in tdp_mmu_set_spte(). (Yan).
---
 arch/x86/kvm/mmu/tdp_mmu.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b30e33dea265..4c68d5e03346 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -320,9 +320,9 @@ void kvm_tdp_mmu_alloc_root(struct kvm_vcpu *vcpu, bool mirror)
 	}
 }
 
-static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				u64 old_spte, u64 new_spte, int level,
-				bool shared);
+static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
+				gfn_t gfn, u64 old_spte, u64 new_spte,
+				int level, bool shared);
 
 static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
@@ -471,8 +471,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 			old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte,
 							  FROZEN_SPTE, level);
 		}
-		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), gfn,
-				    old_spte, FROZEN_SPTE, level, shared);
+		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
 
 		if (is_mirror_sp(sp)) {
 			KVM_BUG_ON(shared, kvm);
@@ -498,7 +497,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 /**
  * handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
- * @as_id: the address space of the paging structure the SPTE was a part of
+ * @sp: the page table in which the SPTE resides
  * @gfn: the base GFN that was mapped by the SPTE
  * @old_spte: The value of the SPTE before the change
  * @new_spte: The value of the SPTE after the change
@@ -511,15 +510,16 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  * dirty logging updates are handled in common code, not here (see make_spte()
  * and fast_pf_fix_direct_spte()).
  */
-static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				u64 old_spte, u64 new_spte, int level,
-				bool shared)
+static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
+				gfn_t gfn, u64 old_spte, u64 new_spte,
+				int level, bool shared)
 {
 	bool was_present = is_shadow_present_pte(old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
 	bool was_leaf = was_present && is_last_spte(old_spte, level);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
+	int as_id = kvm_mmu_page_as_id(sp);
 
 	WARN_ON_ONCE(level > PT64_ROOT_MAX_LEVEL);
 	WARN_ON_ONCE(level < PG_LEVEL_4K);
@@ -668,6 +668,7 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 						       struct tdp_iter *iter,
 						       u64 new_spte)
 {
+	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
 	int ret;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
@@ -676,7 +677,7 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	if (ret)
 		return ret;
 
-	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
+	handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
 			    new_spte, iter->level, true);
 
 	return 0;
@@ -685,7 +686,6 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 /*
  * tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
  * @kvm:	      KVM instance
- * @as_id:	      Address space ID, i.e. regular vs. SMM
  * @sptep:	      Pointer to the SPTE
  * @old_spte:	      The current value of the SPTE
  * @new_spte:	      The new value that will be set for the SPTE
@@ -695,9 +695,11 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
  * Returns the old SPTE value, which _may_ be different than @old_spte if the
  * SPTE had voldatile bits.
  */
-static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
-			    u64 old_spte, u64 new_spte, gfn_t gfn, int level)
+static u64 tdp_mmu_set_spte(struct kvm *kvm, tdp_ptep_t sptep, u64 old_spte,
+			    u64 new_spte, gfn_t gfn, int level)
 {
+	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(sptep));
+
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
@@ -711,7 +713,7 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
-	handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
+	handle_changed_spte(kvm, sp, gfn, old_spte, new_spte, level, false);
 
 	/*
 	 * Users that do non-atomic setting of PTEs don't operate on mirror
@@ -729,9 +731,8 @@ static inline void tdp_mmu_iter_set_spte(struct kvm *kvm, struct tdp_iter *iter,
 					 u64 new_spte)
 {
 	WARN_ON_ONCE(iter->yielded);
-	iter->old_spte = tdp_mmu_set_spte(kvm, iter->as_id, iter->sptep,
-					  iter->old_spte, new_spte,
-					  iter->gfn, iter->level);
+	iter->old_spte = tdp_mmu_set_spte(kvm, iter->sptep, iter->old_spte,
+					  new_spte, iter->gfn, iter->level);
 }
 
 #define tdp_root_for_each_pte(_iter, _kvm, _root, _start, _end)	\
-- 
2.43.2


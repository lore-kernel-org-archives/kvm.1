Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D4379980;
	Thu, 28 May 2026 08:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958354; cv=none; b=CsceGuX7RI/vYzy0mh3wtFUhzMN3NMzlJWKJukEesQXPDcrYFDHr4UlbN/D0yWy9B0jYLJdT6hAwpISz+2J4T+i20ELP7MZZiJfSPHdBJLEcU49c/bgAZvYkmD9ctB9MLbvwVnO10CA4H3WmVrMbeAbfJzFgeLXxv5f2Rl45sls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958354; c=relaxed/simple;
	bh=XYh7FQsVSQ1HfKQO3xOEqXgqIuZM2HV8z2V13DzF9Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UEzpdOc64Bh5pFsl15N2i1yLO6hIepv7ebxfXOgATFtBgPNbntAsYRMRYW9KukoFmKILZROQvZuUrTDZ7DEhbxk1V4yVlU7fKk+TvZPjzmGvzMFB07u+yJqF/IHcZ6d9It9ZdTlK7r2mfn/c861yPvbwKC5Wtvnid5o/gFEdEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhRmJPHK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhRmJPHK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958353; x=1811494353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XYh7FQsVSQ1HfKQO3xOEqXgqIuZM2HV8z2V13DzF9Rc=;
  b=QhRmJPHK2q3JoEbtbE3FYRetcGWi9mkh72xuKw0XIjqH60jNYmdCCFIh
   +hpX+yLRmInTVczBuECEzG6LiYT8Z9H6RzDYPeeKehUUQayf60FCsHjZb
   eth8PVkmMpQ/drfDoFHf44nZ8WamGP2BRar4zLjbnf4SDWPyszJZ6ptit
   NAORrEFDdSJo+Vc0BWFmZ9as83yLZDrWQnXZkVYHgh+nCVQhYkjqyp4vb
   2TE9fvd+eJwuMN9ytghhsgF1vpa/Dq+NdLjxBTQXEMh7vr3inSm3M8bMw
   fJ/ZeCEWoTdhNVsQiolDZgn6JnWL+XicPvpe1xxXvnebV3u14oEfWimcs
   Q==;
X-CSE-ConnectionGUID: ueO7S5ZbTv6JhXY9hXJfxQ==
X-CSE-MsgGUID: 2O9VJkoOT2uJ/Nq7QsKUiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80857204"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80857204"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:33 -0700
X-CSE-ConnectionGUID: EGY3PwQDQWyvMrki+qMI4Q==
X-CSE-MsgGUID: SRDLyOkcREKGWfLGQVMEzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244322410"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:29 -0700
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
Subject: [PATCH v3 09/15] KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to external PTEs
Date: Thu, 28 May 2026 16:12:25 +0800
Message-ID: <20260528081225.10348-1-yan.y.zhao@intel.com>
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

Move propagation of to-present changes and atomic zap changes to external
PTEs from __tdp_mmu_set_spte_atomic() to __handle_changed_spte(), which
centrally handles SPTE changes.

When setting a PTE to present in the mirror page tables, the update needs
to be propagated to the external page tables (in TDX parlance the S-EPT).
Today this is handled by special mirror page tables branching in
__tdp_mmu_set_spte_atomic(), which is the only place where present PTEs are
set for TDX.

This keeps things running, but is a bit hacked on. The hook for setting
present leaf PTEs is added only where TDX happens to need it. For example,
TDX does not support any of the operations that use the non-atomic variant,
tdp_mmu_set_spte() to set present PTEs. Since the hook is missing there, it
is very hard to understand the code from a non-TDX lens. If the reader
doesn't know the TDX specifics it could look like the external update is
missing.

In addition to being confusing, it also litters the TDP MMU with "external"
update callbacks. This is especially unfortunate because there is already a
central place to react to TDP updates, handle_changed_spte().

Begin the process of moving toward a model where all mirror page table
updates are forwarded to TDX code where the TDX-specific logic can live
with a more proper separation of concerns. Do this by adding a helper
__handle_changed_spte() and teaching it to return error codes so it can
propagate failures that may come from TDX external page table updates. Make
the original handle_changed_spte() a no-fail version of
__handle_changed_spte() that handles no-fail changes under exclusive
mmu_lock or under the no-fail path handle_removed_pt(). (Note: as discussed
in [2], teaching __handle_changed_spte() to return errors causes a "wrong"
trace order when removing a non-mirror page table, which should be benign.)

Instead of having __tdp_mmu_set_spte_atomic() do the frozen mirror SPTE
dance and trigger propagation to external PTEs, make
__tdp_mmu_set_spte_atomic() a simple helper of try_cmpxchg64() and hoist
the frozen mirror SPTE dance up a level to tdp_mmu_set_spte_atomic(). Then,
the propagation of changes to present to the external PTEs can be
centralized to __handle_changed_spte(). Note that before
tdp_mmu_set_spte_atomic() actually sets a mirror SPTE to new_spte (i.e.,
while it freezes the mirror SPTE),
(1) the external PTEs, mirror SPTE statistics/trace,
(2) child mirror SPTEs, child external PTEs and child mirror SPTE
    statistics/trace,
are updated by tdp_mmu_set_spte_atomic() to new_spte.

(1) is ok. If updating the external PTE is successful, the mirror SPTE will
    be set to new_spte soon; if updating the external PTE fails, the mirror
    SPTE will be restored to its original value.
    (A minor issue in the successful path is that the statistics/trace are
    updated slightly earlier before the actual change occurs, which should
    be ok, similar to the reasoning in [2]: "I doubt that'll be a problem
    in practice, so I'm inclined to take the simpler code").
(2) is also ok since handle_removed_pt() is no-fail.

Aging external SPTEs is not yet supported for the mirror page table, so
just warn on mirror usage in kvm_tdp_mmu_age_spte() and invoke
__tdp_mmu_set_spte_atomic() directly without the frozen dance. No need to
warn on installing FROZEN_SPTE as a long-term value in
kvm_tdp_mmu_age_spte() since removing the accessed bit is mutually
exclusive with installing FROZEN_SPTE (FROZEN_SPTE has the accessed bit set
on all x86 platforms).

Since tdp_mmu_set_spte_atomic() can also atomically zap SPTEs (though
there's no path to trigger atomic zap on the mirror page table currently),
also leverage the set_external_spte() op to propagate the atomic zaps while
having the TDX code reject this condition.

Link: https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com [1]
Link: https://lore.kernel.org/kvm/aY_Dq3riRLUNFZfr@google.com [2]
Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rick: Based on a diff by Sean Chrisopherson]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
[Yan: added atomic zap case ]
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.
- Fixed a missing trace issue reported by sashiko.
  https://lore.kernel.org/kvm/agu+UsizlbUYsjp6@yzhao56-desk.sh.intel.com

MMU_refactors v2:
- Updated comments and patch log (Yan, Binbin).
- Split the "KVM: x86/mmu: Plumb "sp" _pointer_ into the TDP MMU's
  handle_changed_spte()" out (which was in Sean's original series but
  had SPTE instead of "sp" in patch title). (Yan)
- Also invoke set_external_spte() op to propagate changes for atomic zap of
  leaf SPTEs. (Yan).
- Kept the "Not-yet-Signed-off-by" in v1
  https://lore.kernel.org/all/20260327201421.2824383-8-rick.p.edgecombe@intel.com.
---
 arch/x86/kvm/mmu/tdp_mmu.c | 126 ++++++++++++++++++++++++-------------
 1 file changed, 81 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 4c68d5e03346..3c3e73ce8da9 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -495,7 +495,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 }
 
 /**
- * handle_changed_spte - handle bookkeeping associated with an SPTE change
+ * __handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
  * @sp: the page table in which the SPTE resides
  * @gfn: the base GFN that was mapped by the SPTE
@@ -510,9 +510,9 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  * dirty logging updates are handled in common code, not here (see make_spte()
  * and fast_pf_fix_direct_spte()).
  */
-static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
-				gfn_t gfn, u64 old_spte, u64 new_spte,
-				int level, bool shared)
+static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
+				 gfn_t gfn, u64 old_spte, u64 new_spte,
+				 int level, bool shared)
 {
 	bool was_present = is_shadow_present_pte(old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
@@ -549,9 +549,7 @@ static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	}
 
 	if (old_spte == new_spte)
-		return;
-
-	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+		return 0;
 
 	if (is_leaf)
 		check_spte_writable_invariants(new_spte);
@@ -578,29 +576,51 @@ static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			       "a temporary frozen SPTE.\n"
 			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
 			       as_id, gfn, old_spte, new_spte, level);
-		return;
-	}
 
-	if (is_leaf != was_leaf)
-		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
+		trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+		return 0;
+	}
 
 	/*
 	 * Recursively handle child PTs if the change removed a subtree from
 	 * the paging structure.  Note the WARN on the PFN changing without the
 	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
 	 * pages are kernel allocations and should never be migrated.
+	 *
+	 * For the mirror page table, propagate changes to present or changes of
+	 * leaf SPTEs to !present under shared mmu_lock to the external SPTE via
+	 * set_external_spte() op.
 	 */
 	if (was_present && !was_leaf &&
-	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
+	} else if (is_mirror_sp(sp) && (is_present || shared)) {
+		int r;
+
+		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte, new_spte, level);
+		if (r)
+			return r;
+	}
+	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+
+	if (is_leaf != was_leaf)
+		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
+
+	return 0;
+}
+
+static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
+				gfn_t gfn, u64 old_spte, u64 new_spte,
+				int level, bool shared)
+{
+	KVM_BUG_ON(__handle_changed_spte(kvm, sp, gfn, old_spte, new_spte,
+					 level, shared), kvm);
 }
 
 static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 							 struct tdp_iter *iter,
 							 u64 new_spte)
 {
-	u64 *raw_sptep = rcu_dereference(iter->sptep);
-
 	/*
 	 * The caller is responsible for ensuring the old SPTE is not a FROZEN
 	 * SPTE.  KVM should never attempt to zap or manipulate a FROZEN SPTE,
@@ -609,31 +629,6 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 */
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
-	/* Should not set FROZEN_SPTE as a long-term value. */
-	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
-
-	if (is_mirror_sptep(iter->sptep)) {
-		int ret;
-
-		/*
-		 * We need to lock out other updates to the SPTE until the external
-		 * page table has been modified. Use FROZEN_SPTE similar to
-		 * the zapping case.
-		 */
-		if (!try_cmpxchg64(raw_sptep, &iter->old_spte, FROZEN_SPTE))
-			return -EBUSY;
-
-		ret = kvm_x86_call(set_external_spte)(kvm, iter->gfn, iter->old_spte,
-						      new_spte, iter->level);
-
-		if (ret)
-			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
-		else
-			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
-
-		return ret;
-	}
-
 	/*
 	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
 	 * does not hold the mmu_lock.  On failure, i.e. if a different logical
@@ -641,7 +636,7 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 * the current value, so the caller operates on fresh data, e.g. if it
 	 * retries tdp_mmu_set_spte_atomic().
 	 */
-	if (!try_cmpxchg64(raw_sptep, &iter->old_spte, new_spte))
+	if (!try_cmpxchg64(rcu_dereference(iter->sptep), &iter->old_spte, new_spte))
 		return -EBUSY;
 
 	return 0;
@@ -673,14 +668,51 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
 
-	ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
+	/* Should not set FROZEN_SPTE as a long-term value. */
+	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
+
+	/*
+	 * Temporarily freeze the SPTE until the external PTE operation has
+	 * completed, e.g. so that concurrent faults don't attempt to install a
+	 * child PTE in the external page table before the parent PTE has been
+	 * written.
+	 */
+	if (is_mirror_sptep(iter->sptep))
+		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
+	else
+		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
+
 	if (ret)
 		return ret;
 
-	handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
-			    new_spte, iter->level, true);
-
-	return 0;
+	/*
+	 * Handle the change from iter->old_spte to new_spte.
+	 *
+	 * Note: for mirror page table, this means the updates of the external
+	 * PTE, statistics, or updates of child SPTEs, child external PTEs and
+	 * corresponding statistics are performed while the mirror SPTE is in
+	 * frozen state (i.e., before the mirror SPTE is set to new_spte).
+	 */
+	ret = __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
+				    new_spte, iter->level, true);
+	/*
+	 * Unfreeze the mirror SPTE.  If updating the external SPTE failed,
+	 * restore the old value so that the mirror SPTE isn't frozen in
+	 * perpetuity, otherwise set the mirror SPTE to the new desired value.
+	 */
+	if (is_mirror_sptep(iter->sptep)) {
+		if (ret)
+			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
+		else
+			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
+	} else {
+		/*
+		 * Bug the VM if handling the change failed, as failure is only
+		 * allowed if KVM couldn't update the external SPTE.
+		 */
+		KVM_BUG_ON(ret, kvm);
+	}
+	return ret;
 }
 
 /*
@@ -1334,6 +1366,10 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm, struct tdp_iter *iter)
 {
 	u64 new_spte;
 
+	/* TODO: Add support for aging external SPTEs, if necessary. */
+	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
+		return;
+
 	if (spte_ad_enabled(iter->old_spte)) {
 		iter->old_spte = tdp_mmu_clear_spte_bits_atomic(iter->sptep,
 								shadow_accessed_mask);
-- 
2.43.2


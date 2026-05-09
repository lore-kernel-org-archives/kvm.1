Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B038239B;
	Sat,  9 May 2026 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315792; cv=none; b=kswqdHS6nmAnSiKxYxuVfQXsJp8fQ90lrC9hVLeqTvlm0YRAnvUgoLYCv8WD/0Bxzc/1eBs8zqRyMYWRbUr1Fo0q4/qLAygMVd+SFe0vk9SEPy0uVxQmitP+a08j1KfRG0DI+KlebuvDWwIh4+hN+mNX7nUa+uvq75Wgjnyzg80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315792; c=relaxed/simple;
	bh=zJHgnqDY2cnepeWOchbc58PuzD5UV/UhEseRwV5yyn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAbcIML+a859WfxOuYLRa5TptCy87m46JLijvfwlXdDc+y19icxo72wMAmErNkj8i3T20dMChtHV8PePXZ63maqcdXNAdc0NfWN6J7qTj2TkOb1p5XfQhMtZwMxVfI46X0pmPEPllSk/7aAJADwZD2F9JsYkibqMyoRBzbLW0Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoTC63DI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoTC63DI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315791; x=1809851791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zJHgnqDY2cnepeWOchbc58PuzD5UV/UhEseRwV5yyn8=;
  b=LoTC63DIWvpEMgcR45+uAOME9ZFWNOF3pEhDIQlNQYHfSkGcYLsokIAf
   tcQ1bWneaOcqgx1OAxg0+aOzU9YGgHk212bBho4jBtmKZYcu/cdyuj+nn
   vriU5951odZBhNJDyzKdN6a3F4sourdH1arMW2I6BpzXLI3/zFMKxet7G
   calInNtG6HiR5IjYTfcZsuUXNw6vxXE6M30MVSGwRxVFlbE4VazzaT/+r
   UG9zL1mSRMXw4xyEUmFiGwJJlrHRCOxfiwlz3hlS5x/SaCs9WNeIGy0CR
   vJCMCemz+/NF199eplg9LLod114GMl5YjRtm4RUUhZks1FajcRMQO/B1K
   g==;
X-CSE-ConnectionGUID: VbNSRQq8TcKaZhfTadmM/Q==
X-CSE-MsgGUID: 4pzkpYy+SKGFreEcc1Wgxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90388075"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90388075"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:30 -0700
X-CSE-ConnectionGUID: fwy/BzxdSqKTVg2gdYrPGQ==
X-CSE-MsgGUID: DvV9twN+QvK7TDtO81sjnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="236153032"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:26 -0700
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
Subject: [PATCH v2 09/15] KVM: x86/tdp_mmu: Centrally propagate to-present/atomic zap updates to external PTEs
Date: Sat,  9 May 2026 15:56:34 +0800
Message-ID: <20260509075634.4274-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260509075201.4077-1-yan.y.zhao@intel.com>
References: <20260509075201.4077-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Move propagation of to-present changes and atomic zap changes to external
PTEs from function __tdp_mmu_set_spte_atomic() to function
__handle_changed_spte(), which centrally handles changes of SPTEs.

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

Begin the process of moving towards a model where all mirror page table
updates are forwarded to TDX code where the TDX-specific logic can live
with a more proper separation of concerns. Do this by adding a helper
__handle_changed_spte() and teaching it how to return error codes, such
that it can propagate the failures that may come from TDX external page
table updates. Make the original handle_changed_spte() a no-fail version of
__handle_changed_spte(), so it handles no-fail changes which are under
exclusive mmu_lock or under the no-fail path handle_removed_pt(),
triggering KVM_BUG_ON() on error returns.

Instead of having __tdp_mmu_set_spte_atomic() do the frozen mirror SPTE
dance and trigger propagation to external PTEs, make
__tdp_mmu_set_spte_atomic() a simple helper of try_cmpxchg64() and hoist
the frozen mirror SPTE dance up a level to tdp_mmu_set_spte_atomic(). Then,
the propagation of changes to present to the external PTEs can be
centralized to __handle_changed_spte(). Aging external SPTEs is not yet
supported for the mirror page table, so just warn on mirror usage in
kvm_tdp_mmu_age_spte() and invoke __tdp_mmu_set_spte_atomic() directly
without frozen dance. No need to warn on installing FROZEN_SPTE as a
long-term value in kvm_tdp_mmu_age_spte() since removing accessed bit is
mutually exclusive with installing FROZEN_SPTE (FROZEN_SPTE is with
accessed bit in all x86 platforms).

Since tdp_mmu_set_spte_atomic() can also be invoked to atomically zap SPTEs
(though there's no path to trigger atomic zap on the mirror page table up
to now), also leverage set_external_spte() op to propagate the atomic zaps
when tdp_mmu_set_spte_atomic() zaps leaf SPTEs directly. (When
tdp_mmu_set_spte_atomic() zaps a non-leaf SPTE, zaps of the child leaf
SPTEs are propagated via the remove_external_spte() op).

Note: tdp_mmu_set_spte_atomic() invokes __handle_changed_spte() to handle
changes to new_spte while the mirror SPTE is frozen, so
(1) the update of the external PTEs and statistics, or
(2) the update of child mirror SPTEs, child external PTEs and corresponding
    statistics,
now occur before the mirror SPTE is actually set to new_spte.
(1) is ok since if it fails, the mirror SPTE will be restored to its
original value. (2) is also ok since handle_removed_pt() is no-fail.

Link: https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rick: Based on a diff by Sean Chrisopherson]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
[Yan: added atomic zap case ]
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
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
 arch/x86/kvm/mmu/tdp_mmu.c | 124 +++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 05dc8bdc1ea5..ada4a0837298 100644
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
@@ -578,29 +576,49 @@ static void handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			       "a temporary frozen SPTE.\n"
 			       "as_id: %d gfn: %llx old_spte: %llx new_spte: %llx level: %d",
 			       as_id, gfn, old_spte, new_spte, level);
-		return;
+		return 0;
 	}
 
-	if (is_leaf != was_leaf)
-		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
-
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
@@ -609,31 +627,6 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
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
@@ -641,7 +634,7 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 * the current value, so the caller operates on fresh data, e.g. if it
 	 * retries tdp_mmu_set_spte_atomic().
 	 */
-	if (!try_cmpxchg64(raw_sptep, &iter->old_spte, new_spte))
+	if (!try_cmpxchg64(rcu_dereference(iter->sptep), &iter->old_spte, new_spte))
 		return -EBUSY;
 
 	return 0;
@@ -673,14 +666,51 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 
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
@@ -1334,6 +1364,10 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm, struct tdp_iter *iter)
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


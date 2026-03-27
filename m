Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5973947AC;
	Fri, 27 Mar 2026 20:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642474; cv=none; b=qiFxXi7Ps8k0EJ4crzZIKWOkRBGt8QScrT1NjTBK82jfVijqzgxYdUO8uMU+B40zNQmrIZOvP0JLsTUCDVrKR+oJHfRuDVFdYOPkoEdDvBTOwOXQOS/dtDxW1B+bmXHJ5wcVCrKijJgL4C2FaVCoWjV8DhiFdLoXwuzPGVsWaIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642474; c=relaxed/simple;
	bh=Z8h2Ml+ce0Uce4RP3iqBjRYcOMplx5MQTLmP28OMjNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmJWPMelqPvKkrboN5gwHXVOxf13bZFEcAHnBu3zXdnqWJ5c1/xUXG0sJBzgnZVgHHgkoWbqPTIhG17S2mC7p1vuupi1Aa6mpjsDIwkLxudrFzSLoBKQlOP1jmrb20D6SPXj9WMcadbGjmMuHoVO/2c+QNpbIOvZorjkGin/uSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hn5p7XU1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hn5p7XU1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642472; x=1806178472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z8h2Ml+ce0Uce4RP3iqBjRYcOMplx5MQTLmP28OMjNE=;
  b=Hn5p7XU14u3OJttc6iVS8ZF4GWNI+07iEGQKwu/qvH831JLDXkiYJohc
   rfDsHfV6ObCLroEmU5qYMBBi2JirH0QiwcNNn+1/hXNW6f63JWjtGVsaP
   moxACdny57LU5quFupT7LHsa59dk0NHppUD0f+V9jttWDjJEV+y0D8Pdb
   yOyGuTlo6a9YbiockczBh3I7zjMqvFmF+i/8aASJxpiuZZt/0AG5Gezgh
   ml+mTJSp16aM5O008ixMGKzwI/d88iQOQXyXVgIDdulby5JdgkQGwWHNc
   Naf2OtfasyFkVvKdqHkA3VMbKM1TO7ur4Awe/bj52BC3W3dSMRULjWEDY
   Q==;
X-CSE-ConnectionGUID: WYJEZF3BTFW11jMQmmdZqg==
X-CSE-MsgGUID: LUhnV/TURfCMkKqWl1SiXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182737"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182737"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: /DSS+e2qR4+jVyEzgqTLWw==
X-CSE-MsgGUID: HA1A4b4vQSebUTPaD/4+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922907"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 07/17] KVM: x86/tdp_mmu: Centralize updates to present external PTEs
Date: Fri, 27 Mar 2026 13:14:11 -0700
Message-ID: <20260327201421.2824383-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Centralize the updates to present external PTEs to the
handle_changed_spte() function.

When setting a PTE to present in the mirror page tables, the update needs
to propagate to the external page tables (in TDX parlance the S-EPT).
Today this is handled by special mirror page tables branching in
__tdp_mmu_set_spte_atomic(), which is the only place where present PTEs
are set for TDX.

This keeps things running, but is a bit hacked on. The hook for setting
present leaf PTEs are added only where TDX happens to need them. For
example, TDX does not support any of the operations that use the
non-atomic variant, tdp_mmu_set_spte() to set present PTEs. Since the hook
is missing there, it is very hard to understand the code from a non-TDX
lens. If the reader doesn’t know the TDX specifics it could look like the
external update is missing.

In addition to being confusing, it also litters the TDP MMU with
"external" update callbacks. This is especially unfortunate because there
is already a central place to react to TDP updates, handle_changed_spte().

Begin the process of moving towards a model where all mirror page table
updates are forwarded to TDX code where the TDX specific logic can live
with a more proper separation of concerns. Do this by teaching
handle_changed_spte() how to return error codes, such that it can
propagate the failures that may come from TDX external page table updates.

Atomic mirror page table updates need to be done in a special way to
prevent concurrent updates to the mirror page table while the external
page table is updated. The mirror page table is set to the frozen PTE
value while the external version is updates. This frozen PTE dance is
currently done in __tdp_mmu_set_spte_atomic(). Hoist it up a level so that
the external update in handle_changed_spte() can be done while the PTE is
frozen.

Link: https://lore.kernel.org/lkml/aYYn0nf2cayYu8e7@google.com/
Not-yet-Signed-off-by: Sean Christopherson <seanjc@google.com>
[Based on a diff by Sean Chrisopherson]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 150 ++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 338957bc5109..db16e81b9701 100644
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
@@ -508,22 +507,15 @@ static void *get_external_spt(gfn_t gfn, u64 new_spte, int level)
 	return NULL;
 }
 
-static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sptep,
-						 gfn_t gfn, u64 *old_spte,
-						 u64 new_spte, int level)
+static int __must_check set_external_spte_present(struct kvm *kvm,
+						  gfn_t gfn, u64 old_spte,
+						  u64 new_spte, int level)
 {
 	bool is_present = is_shadow_present_pte(new_spte);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	int ret = 0;
 
 	lockdep_assert_held(&kvm->mmu_lock);
-	/*
-	 * We need to lock out other updates to the SPTE until the external
-	 * page table has been modified. Use FROZEN_SPTE similar to
-	 * the zapping case.
-	 */
-	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
-		return -EBUSY;
 
 	/*
 	 * Use different call to either set up middle level
@@ -537,17 +529,13 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
 		KVM_BUG_ON(!external_spt, kvm);
 		ret = kvm_x86_call(link_external_spt)(kvm, gfn, level, external_spt);
 	}
-	if (ret)
-		__kvm_tdp_mmu_write_spte(sptep, *old_spte);
-	else
-		__kvm_tdp_mmu_write_spte(sptep, new_spte);
 	return ret;
 }
 
 /**
- * handle_changed_spte - handle bookkeeping associated with an SPTE change
+ * __handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
- * @as_id: the address space of the paging structure the SPTE was a part of
+ * @sp: the page table in which the SPTE resides
  * @gfn: the base GFN that was mapped by the SPTE
  * @old_spte: The value of the SPTE before the change
  * @new_spte: The value of the SPTE after the change
@@ -560,15 +548,17 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
  * dirty logging updates are handled in common code, not here (see make_spte()
  * and fast_pf_fix_direct_spte()).
  */
-static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				u64 old_spte, u64 new_spte, int level,
-				bool shared)
+static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
+				 gfn_t gfn, u64 old_spte, u64 new_spte,
+				 int level, bool shared)
 {
 	bool was_present = is_shadow_present_pte(old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
 	bool was_leaf = was_present && is_last_spte(old_spte, level);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
+	int as_id = kvm_mmu_page_as_id(sp);
+	int r;
 
 	WARN_ON_ONCE(level > PT64_ROOT_MAX_LEVEL);
 	WARN_ON_ONCE(level < PG_LEVEL_4K);
@@ -598,9 +588,7 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	}
 
 	if (old_spte == new_spte)
-		return;
-
-	trace_kvm_tdp_mmu_spte_changed(as_id, gfn, level, old_spte, new_spte);
+		return 0;
 
 	if (is_leaf)
 		check_spte_writable_invariants(new_spte);
@@ -627,21 +615,41 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
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
+	 * When modifying leaf entries in mirrored page tables, propagate all
+	 * changes to the external SPTE.
 	 */
 	if (was_present && !was_leaf &&
-	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
+	} else if (is_mirror_sp(sp) && is_present) {
+		r = set_external_spte_present(kvm, gfn, old_spte, new_spte, level);
+		if (r)
+			return r;
+	}
+
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
@@ -657,32 +665,14 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
 	/*
-	 * FROZEN_SPTE is a temporary state and should never be set via higher
-	 * level helpers.
+	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
+	 * does not hold the mmu_lock.  On failure, i.e. if a different logical
+	 * CPU modified the SPTE, try_cmpxchg64() updates iter->old_spte with
+	 * the current value, so the caller operates on fresh data, e.g. if it
+	 * retries tdp_mmu_set_spte_atomic()
 	 */
-	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
-
-	if (is_mirror_sptep(iter->sptep)) {
-		int ret;
-
-		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
-						&iter->old_spte, new_spte, iter->level);
-		if (ret)
-			return ret;
-	} else {
-		u64 *sptep = rcu_dereference(iter->sptep);
-
-		/*
-		 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs
-		 * and does not hold the mmu_lock.  On failure, i.e. if a
-		 * different logical CPU modified the SPTE, try_cmpxchg64()
-		 * updates iter->old_spte with the current value, so the caller
-		 * operates on fresh data, e.g. if it retries
-		 * tdp_mmu_set_spte_atomic()
-		 */
-		if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
-			return -EBUSY;
-	}
+	if (!try_cmpxchg64(rcu_dereference(iter->sptep), &iter->old_spte, new_spte))
+		return -EBUSY;
 
 	return 0;
 }
@@ -708,18 +698,49 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 						       struct tdp_iter *iter,
 						       u64 new_spte)
 {
+	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(iter->sptep));
 	int ret;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
 
-	ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
+	/* KVM should never freeze SPTEs using higher level APIs. */
+	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
+
+	/*
+	 * Temporarily freeze the SPTE until the external PTE operation has
+	 * completed (unless the new SPTE itself will be frozen), e.g. so that
+	 * concurrent faults don't attempt to install a child PTE in the
+	 * external page table before the parent PTE has been written, or try
+	 * to re-install a page table before the old one was removed.
+	 */
+	if (is_mirror_sptep(iter->sptep))
+		ret = __tdp_mmu_set_spte_atomic(kvm, iter, FROZEN_SPTE);
+	else
+		ret = __tdp_mmu_set_spte_atomic(kvm, iter, new_spte);
 	if (ret)
 		return ret;
 
-	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
-			    new_spte, iter->level, true);
+	ret = __handle_changed_spte(kvm, sp, iter->gfn, iter->old_spte,
+				    new_spte, iter->level, true);
 
-	return 0;
+	/*
+	 * Unfreeze the mirror SPTE.  If updating the external SPTE failed,
+	 * restore the old SPTE so that the SPTE isn't frozen in perpetuity,
+	 * otherwise set the mirror SPTE to the new desired value.
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
@@ -738,6 +759,8 @@ static inline int __must_check tdp_mmu_set_spte_atomic(struct kvm *kvm,
 static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 			    u64 old_spte, u64 new_spte, gfn_t gfn, int level)
 {
+	struct kvm_mmu_page *sp = sptep_to_sp(rcu_dereference(sptep));
+
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
@@ -751,7 +774,7 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
-	handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
+	handle_changed_spte(kvm, sp, gfn, old_spte, new_spte, level, false);
 
 	/*
 	 * Users that do non-atomic setting of PTEs don't operate on mirror
@@ -1373,6 +1396,9 @@ static void kvm_tdp_mmu_age_spte(struct kvm *kvm, struct tdp_iter *iter)
 {
 	u64 new_spte;
 
+	if (WARN_ON_ONCE(is_mirror_sptep(iter->sptep)))
+		return;
+
 	if (spte_ad_enabled(iter->old_spte)) {
 		iter->old_spte = tdp_mmu_clear_spte_bits_atomic(iter->sptep,
 								shadow_accessed_mask);
-- 
2.53.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1C3FF1;
	Thu, 28 May 2026 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958287; cv=none; b=ajAhrYxkET0N1qa1rc3jU7u42wMAHN7tueXsctQCKU5ydao4nxU6izkTsbs6Qvcd787uCveKxAUPAC9BiPni7tIxjMuB1MN6Nz/Bv6ptuClV4xPZcSpYVfxiWLesd2iulm72BQ6SeGxDo58JllLUKafWyaGw9HOm9mOsZCAPIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958287; c=relaxed/simple;
	bh=PZ3M6CddHvhNU8pALO7JEmoJ39JQW3w+/EYF1FVILYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/9zUREsr1C4tFV+DRQ1Usl37Vsbhz77wJKJBq/JqntjNh9wWapoeRGwxWNn8turXEQv+K0mAby9yQjdgEzjnvWd3g/EgPhi2koLz6WOrfvFJZ7V4HhK1oUYaSEr1h8Bd7Rx2sffT8oJM2HXERQmtIcBEsDE7nKmtp0pyu2OmjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gC0xhoe9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gC0xhoe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958286; x=1811494286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZ3M6CddHvhNU8pALO7JEmoJ39JQW3w+/EYF1FVILYA=;
  b=gC0xhoe9DWXndjLCmVm2Mnwjyd7UyugBal0jYDUXpEGAqOWGNTS+4VKy
   IJqdohSwtSk+8TzJbMEfolD9jw0BfQRw/wPuAyPxx7Lys95yh5CLuqVu2
   IgetlkwEthgmvPGJQHGOGkqtJUxUaa/Vqs/ZsdZN+1dgKJPhlaG8DzV4y
   QZ8eV9T3hDL15kAVKTrH2nBDX8qpfGIfHeJGVe65Wid+q83+zgV0ho/fm
   m2oXPUCcZQS75DzbjHJQePSS/eh+vYb5Bz6z6qUbJ3mcMSz3gmRD7s6I1
   VyiUKCFYqTE0b5lXwkft8NElQ3NtrXmBAs0zN+r44Ovn2RvK8XjL/dG6U
   w==;
X-CSE-ConnectionGUID: M8yoIZg3TKq6+mckaJiMbA==
X-CSE-MsgGUID: iw0NKZnwSD+lrOHKqigyaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103469631"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="103469631"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:26 -0700
X-CSE-ConnectionGUID: KDkkU1E3S4+HeQJG8VwTmQ==
X-CSE-MsgGUID: h7he8ZovTZOnfHTDlpIu/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="247442045"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:23 -0700
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
Subject: [PATCH v3 03/15] KVM: x86/mmu: Fold set_external_spte_present() into its sole caller
Date: Thu, 28 May 2026 16:11:17 +0800
Message-ID: <20260528081117.10252-1-yan.y.zhao@intel.com>
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

Fold set_external_spte_present() into __tdp_mmu_set_spte_atomic() in
anticipation of propagating all changes (like atomic zap) triggered by
tdp_mmu_set_spte_atomic() to the external PTEs.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- Moved to the front of the series and updated the patch log to indicate
  the propagation of changes for atomic zap. (Yan)
---
 arch/x86/kvm/mmu/tdp_mmu.c | 72 ++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 0dc1b0597f8a..128089571e34 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -495,33 +495,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
-static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sptep,
-						 gfn_t gfn, u64 *old_spte,
-						 u64 new_spte, int level)
-{
-	bool was_present = is_shadow_present_pte(*old_spte);
-	int ret;
-
-	KVM_BUG_ON(was_present, kvm);
-
-	lockdep_assert_held(&kvm->mmu_lock);
-	/*
-	 * We need to lock out other updates to the SPTE until the external
-	 * page table has been modified. Use FROZEN_SPTE similar to
-	 * the zapping case.
-	 */
-	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
-		return -EBUSY;
-
-	ret = kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
-
-	if (ret)
-		__kvm_tdp_mmu_write_spte(sptep, *old_spte);
-	else
-		__kvm_tdp_mmu_write_spte(sptep, new_spte);
-	return ret;
-}
-
 /**
  * handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
@@ -626,6 +599,8 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 							 struct tdp_iter *iter,
 							 u64 new_spte)
 {
+	u64 *raw_sptep = rcu_dereference(iter->sptep);
+
 	/*
 	 * The caller is responsible for ensuring the old SPTE is not a FROZEN
 	 * SPTE.  KVM should never attempt to zap or manipulate a FROZEN SPTE,
@@ -635,8 +610,13 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
 	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
+		bool was_present = is_shadow_present_pte(iter->old_spte);
 		int ret;
 
+		KVM_BUG_ON(was_present, kvm);
+
+		lockdep_assert_held(&kvm->mmu_lock);
+
 		/*
 		 * Users of atomic zapping don't operate on mirror roots,
 		 * so don't handle it and bug the VM if it's seen.
@@ -644,25 +624,35 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 		if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 			return -EBUSY;
 
-		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
-						&iter->old_spte, new_spte, iter->level);
-		if (ret)
-			return ret;
-	} else {
-		u64 *sptep = rcu_dereference(iter->sptep);
-
 		/*
-		 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs
-		 * and does not hold the mmu_lock.  On failure, i.e. if a
-		 * different logical CPU modified the SPTE, try_cmpxchg64()
-		 * updates iter->old_spte with the current value, so the caller
-		 * operates on fresh data, e.g. if it retries
-		 * tdp_mmu_set_spte_atomic()
+		 * We need to lock out other updates to the SPTE until the external
+		 * page table has been modified. Use FROZEN_SPTE similar to
+		 * the zapping case.
 		 */
-		if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
+		if (!try_cmpxchg64(raw_sptep, &iter->old_spte, FROZEN_SPTE))
 			return -EBUSY;
+
+		ret = kvm_x86_call(set_external_spte)(kvm, iter->gfn, iter->level,
+						      new_spte);
+
+		if (ret)
+			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
+		else
+			__kvm_tdp_mmu_write_spte(iter->sptep, new_spte);
+
+		return ret;
 	}
 
+	/*
+	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
+	 * does not hold the mmu_lock.  On failure, i.e. if a different logical
+	 * CPU modified the SPTE, try_cmpxchg64() updates iter->old_spte with
+	 * the current value, so the caller operates on fresh data, e.g. if it
+	 * retries tdp_mmu_set_spte_atomic().
+	 */
+	if (!try_cmpxchg64(raw_sptep, &iter->old_spte, new_spte))
+		return -EBUSY;
+
 	return 0;
 }
 
-- 
2.43.2


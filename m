Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4038D3FB;
	Thu, 28 May 2026 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958387; cv=none; b=j28qU6sgSdDxsBljsg29mP6t2uIpWsopCpeIdSOGtS+dGMarNsSzHOCeo+DEeY91fIJSIzneUWEPdVAVVT5buVNdqI87aOhtAY8ltIQsmieecYidGqPnJu4XS14pElvdD4NBt+n3X3hnynUFLC+Xl6wfPVk/DluN17cqLIZHrik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958387; c=relaxed/simple;
	bh=BIYh6lg8Ns/HksV+mzeMIAA6ksi9/hK5K4qrhsoRB9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa4oaapSYMEhvFU7ebnzygoZOMyInJgrdTm33wXcCk9KnzfxOMI8yZU00qljKwAMTtQzk5fvM+x195t8NbOHaErXhyq5ldVpI5HcZbjK7gV7BZtcD+qujp2AwbaI0v4+xub/AxtcXQC5g636xd6xkuZGNJeyx5IauH8xkv6Ac2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aidouCvs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aidouCvs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958386; x=1811494386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BIYh6lg8Ns/HksV+mzeMIAA6ksi9/hK5K4qrhsoRB9k=;
  b=aidouCvsRuS4tILSkmvwUIZkJdsChUHR39k0QHJauYiB4DWaBXgYL16r
   rmSjKcIN3YpJwtXkUu+l3iT5Idqk/eMwBzS/DsHTD0VinvNiFQEM7aEe8
   kcfmRVQJV4frO1Io1JkHXWO4pKu4tQIfpg417qwJmPpoUs3dobZwwADzq
   ZlJdrpvK9vyzh/VVD4jgvUIQCnZ5qDV+eCgK3Wi+B6mWgzNWUAQxoxt3+
   LhrS9SbOGGtrTnGByzlIOWON9FeDnDLyVBgKkgWR8fUQ6zOQ0Io8ZE7sE
   m0UuIIFKuf04kUkQoIrDvsmuSdoP8grsXO0YGIv0KAApqQFsxjhmUGxGx
   Q==;
X-CSE-ConnectionGUID: hpcaA78TRTSXqKD06dibCQ==
X-CSE-MsgGUID: dw4/6A4WTYCQH2wWRNyl0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80857264"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80857264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:06 -0700
X-CSE-ConnectionGUID: BcH3uVrzSPyFm+1p/o9Aqg==
X-CSE-MsgGUID: ciuo0tJdSAqKtd6c8XaYmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244322579"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:02 -0700
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
Subject: [PATCH v3 12/15] KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
Date: Thu, 28 May 2026 16:12:58 +0800
Message-ID: <20260528081258.10396-1-yan.y.zhao@intel.com>
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

Drop kvm_x86_ops.remove_external_spte(), and instead handle the removal of
leaf SPTEs in the S-EPT (a.k.a. external page table) in
kvm_x86_ops.set_external_spte(). This will also allow extending
tdx_sept_set_private_spte() to support splitting a huge S-EPT entry without
needing yet another kvm_x86_ops hook.

Now all changes for removing leaf mirror SPTEs are propagated through
kvm_x86_ops.set_external_spte().
- When removing leaf mirror SPTEs under shared mmu_lock (though currently
  no path can trigger this scenario and TDX does not support this
  scenario), tdx_sept_remove_private_spte() may produce a warning due to
  lockdep_assert_held_write() or may return -EIO and trigger TDX_BUG_ON()
  due to concurrent BLOCK, TRACK, REMOVE.
- When removing leaf mirror SPTEs under exclusive mmu_lock, all errors are
  unexpected. If any error occurs in this scenario,
  tdx_sept_remove_private_spte() will return -EIO and trigger KVM_BUG_ON().
  A redundant KVM_BUG_ON() call will also be triggered in TDP MMU core in
  handle_changed_spte(), which is benign (the WARN will fire if and only if
  the VM isn't already bugged).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- Added expected lock and valid scenarios in function comment of
  tdx_sept_set_private_spte(). (Yan/Rick)
- Updated patch title (was "Handle removal of leaf SPTEs in
  .set_private_spte()"), since atomic zaps of leaf SPTEs are already
  handled in kvm_x86_ops.set_external_spte() before this patch. (Yan).
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 ---
 arch/x86/kvm/mmu/tdp_mmu.c         | 37 +++-------------------------
 arch/x86/kvm/vmx/tdx.c             | 39 +++++++++++++++++++++---------
 4 files changed, 31 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 2cb393000ee9..771d991562ca 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -98,7 +98,6 @@ KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
-KVM_X86_OP_OPTIONAL(remove_external_spte)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
 KVM_X86_OP(get_l2_tsc_multiplier)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7710471a1c49..987e005f08eb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1922,9 +1922,6 @@ struct kvm_x86_ops {
 	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 void *external_spt);
 
-	/* Update external page table from spte getting removed, and flush TLB. */
-	void (*remove_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				     u64 mirror_spte);
 
 	bool (*has_wbinvd_exit)(void);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3ba7556a8d2f..72d323f2d0dc 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -359,25 +359,6 @@ static void tdp_mmu_unlink_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
 }
 
-static void remove_external_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
-				 int level)
-{
-	/*
-	 * External (TDX) SPTEs are limited to PG_LEVEL_4K, and external
-	 * PTs are removed in a special order, involving free_external_spt().
-	 * But remove_external_spte() will be called on non-leaf PTEs via
-	 * __tdp_mmu_zap_root(), so avoid the error the former would return
-	 * in this case.
-	 */
-	if (!is_last_spte(old_spte, level))
-		return;
-
-	/* Zapping leaf spte is allowed only when write lock is held. */
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	kvm_x86_call(remove_external_spte)(kvm, gfn, level, old_spte);
-}
-
 /**
  * handle_removed_pt() - handle a page table removed from the TDP structure
  *
@@ -472,9 +453,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 							  FROZEN_SPTE, level);
 		}
 		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
-
-		if (is_mirror_sp(sp))
-			remove_external_spte(kvm, gfn, old_spte, level);
 	}
 
 	if (is_mirror_sp(sp) &&
@@ -585,14 +563,14 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
 	 * pages are kernel allocations and should never be migrated.
 	 *
-	 * For the mirror page table, propagate changes to present or changes of
-	 * leaf SPTEs to !present under shared mmu_lock to the external SPTE via
+	 * For the mirror page table, propagate all changes to the external SPTE
+	 * (except zapping/promotion of non-leaf SPTEs) via the
 	 * set_external_spte() op.
 	 */
 	if (was_present && !was_leaf &&
 	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
-	} else if (is_mirror_sp(sp) && (is_present || shared)) {
+	} else if (is_mirror_sp(sp)) {
 		int r;
 
 		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte, new_spte, level);
@@ -745,15 +723,6 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, tdp_ptep_t sptep, u64 old_spte,
 
 	handle_changed_spte(kvm, sp, gfn, old_spte, new_spte, level, false);
 
-	/*
-	 * Users that do non-atomic setting of PTEs don't operate on mirror
-	 * roots, so don't handle it and bug the VM if it's seen.
-	 */
-	if (is_mirror_sptep(sptep)) {
-		KVM_BUG_ON(is_shadow_present_pte(new_spte), kvm);
-		remove_external_spte(kvm, gfn, old_spte, level);
-	}
-
 	return old_spte;
 }
 
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 47bd9e0f0135..68d9deae3a2d 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1770,11 +1770,11 @@ static void tdx_track(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
 }
 
-static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
-					 enum pg_level level, u64 mirror_spte)
+static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
+					enum pg_level level, u64 old_spte)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
+	kvm_pfn_t pfn = spte_to_pfn(old_spte);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 
@@ -1786,16 +1786,16 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	 * there can't be anything populated in the private EPT.
 	 */
 	if (KVM_BUG_ON(!is_hkid_assigned(to_kvm_tdx(kvm)), kvm))
-		return;
+		return -EIO;
 
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
-		return;
+		return -EIO;
 
 	err = tdh_do_no_vcpus(tdh_mem_range_block, kvm, &kvm_tdx->td, gpa,
 			      level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_RANGE_BLOCK, entry, level_state, kvm))
-		return;
+		return -EIO;
 
 	/*
 	 * TDX requires TLB tracking before dropping private page.  Do
@@ -1811,22 +1811,40 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	err = tdh_do_no_vcpus(tdh_mem_page_remove, kvm, &kvm_tdx->td, gpa,
 			      level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
-		return;
+		return -EIO;
 
 	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
 	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
-		return;
+		return -EIO;
 
 	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
+	return 0;
 }
 
+/*
+ * Handle changes for
+ * (1) leaf SPTEs from non-present to present
+ * (2) non-leaf SPTEs from non-present to present
+ * (3) leaf SPTEs from present to non-present
+ *
+ * - (1) and (2) must be under shared mmu_lock. If (1) and (2) are under
+ *   exclusive mmu_lock (currently impossible), contention errors may lead to
+ *   KVM_BUG_ON() in handle_changed_spte(), e.g., due to tdx_mem_page_aug(),
+ *   tdx_mem_page_add(), or tdh_mem_sept_add() contending with tdh_vp_enter()
+ *   due to zero-step mitigation or contending with TDCALLs.
+ * - (3) must be under write mmu_lock. If (3) is under shared mmu_lock
+ *   (currently impossible), warnings will be generated due to
+ *   lockdep_assert_held_write() or TDX_BUG_ON() caused by concurrent BLOCK,
+ *   TRACK, REMOVE.
+ * - Promotion/demotion is not yet supported.
+ */
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
 	lockdep_assert_held(&kvm->mmu_lock);
 
-	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
-		return -EIO;
+	if (is_shadow_present_pte(old_spte))
+		return tdx_sept_remove_private_spte(kvm, gfn, level, old_spte);
 
 	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
@@ -3459,7 +3477,6 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
-	vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
 	vt_x86_ops.protected_apic_has_interrupt = tdx_protected_apic_has_interrupt;
 	return 0;
 
-- 
2.43.2


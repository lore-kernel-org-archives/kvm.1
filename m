Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD238C421;
	Sat,  9 May 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315829; cv=none; b=EhcvMa61eQYre95hJErxXB0R6Hd2e5mTSZEN4lavYWV0hDjpBNx23lXd/a8Hr99ckjmoRT/Fj8/7epTQ4ZSTwqykgfxL3n+CRaRNUBJ1bLaLdShJgtfjRl5iS37W1nBTgcOkYrELCA37zUxXPgC9D0ZVOPi6GmBmLNwGdLZfWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315829; c=relaxed/simple;
	bh=tfPeTIyWIaphWywq6hpaQtZdrVqTcipgosfK2WhF+mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btxEzX8UZ9jlLDoyfc/5IEmO6oedr/gvLWdY+o9seFviBbIYZuJS5LyKo4J8U/1ssG+Kkt1MN/BNYZYP3aET0larm3GLNzv9xKvI0yRWxqhB3svDQOoyRCM9AO2e0AU8AExczPMDBynx7VvQ+tq/966jlMjMAYeY3+BLu2DIQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rp8/Ma2g; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rp8/Ma2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315826; x=1809851826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tfPeTIyWIaphWywq6hpaQtZdrVqTcipgosfK2WhF+mc=;
  b=Rp8/Ma2gZ4eqglcIPknfRjsAkSErei0iIpJUgvcFWW7wwEwY9IJRMNHD
   Adwh36r0wVpc3Hs7+eymvPuhU49X/Nes+C++O5qLJbl/XZ7rP4V4eQOgL
   J9XALXxMDiobZ1OdkKelKbtJ+M/m5O71PHQewhVT040VI7EupF3eXNB2D
   BSt3Xe4bCssVhSHN9noIIJn8FBb6U3zctFxUYrtqbrQ+euClNBhMEcqe6
   uypKMWIolriaVZdLz0+iOc8bVFOqW3LDZPhnwB5w4e4FoQNzLamyGvY5+
   9XEUuga2vZFsHOMexEZqvU7kRjmZUYFQMWM0C/11WAckYe4vtj+IIuuta
   w==;
X-CSE-ConnectionGUID: mtLVjCYgQECCksVK5VMDAA==
X-CSE-MsgGUID: hcYDo4fZRy6lzhNIsHatzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79306602"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79306602"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:37:05 -0700
X-CSE-ConnectionGUID: 20NNMm0aQ6Svr8OzexSNew==
X-CSE-MsgGUID: Y9HKrJpJS+iXwlF9l+iU+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="230584777"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:37:01 -0700
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
Subject: [PATCH v2 12/15] KVM: TDX: Drop kvm_x86_ops.remove_external_spte()
Date: Sat,  9 May 2026 15:57:09 +0800
Message-ID: <20260509075709.4322-1-yan.y.zhao@intel.com>
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
index bced6d938702..ed348c6dd445 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -97,7 +97,6 @@ KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
-KVM_X86_OP_OPTIONAL(remove_external_spte)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
 KVM_X86_OP(get_l2_tsc_multiplier)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 9b55973f194c..c62a14623dcc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1899,9 +1899,6 @@ struct kvm_x86_ops {
 	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 void *external_spt);
 
-	/* Update external page table from spte getting removed, and flush TLB. */
-	void (*remove_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				     u64 mirror_spte);
 
 	bool (*has_wbinvd_exit)(void);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 553a30628960..5cc2e948610b 100644
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
@@ -583,14 +561,14 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
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
@@ -743,15 +721,6 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, tdp_ptep_t sptep, u64 old_spte,
 
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
index e40a999b0fb8..749883fb8f11 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1764,11 +1764,11 @@ static void tdx_track(struct kvm *kvm)
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
 
@@ -1780,16 +1780,16 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
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
@@ -1805,22 +1805,40 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
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
@@ -3448,7 +3466,6 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
-	vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
 	vt_x86_ops.protected_apic_has_interrupt = tdx_protected_apic_has_interrupt;
 	return 0;
 
-- 
2.43.2


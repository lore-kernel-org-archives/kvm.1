Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3923A545E;
	Fri, 27 Mar 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642479; cv=none; b=GgHL2BuUOa3pcQIYLEMReobHcAdWkFTJxYdrJ60KdoqVOb24unL22uPwEynPH11mJUfPtQF4rqmvCKtRJHmYmK8L8Usp38Pu78dk5cikGmvoUH0nij6kOBm4XLjAJAFgulIFXO0GfM8raKc3AxTWE5Zr8QPtcUU1TsHvvobGtgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642479; c=relaxed/simple;
	bh=FOTP5cb4XF1vyg42+XwyX9ktm52KRzI1tMI+n0u/22w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3bol/2oNmDL4+l1+EgkuYZpye/O4f76djye2Ulwr9zP1/DckVdmsDX3ud3D9tuxKsqhyznCJpbk2DdY9JyI7mGUCDHcsGx1vmJ/+NMXQOpyvv0XDhShL/HzXQ6xvarSHTL2fsWRcH2cWqDFZvhWbpJ9IJYSQ0wvmivznfiGh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVPUIONb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVPUIONb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642478; x=1806178478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FOTP5cb4XF1vyg42+XwyX9ktm52KRzI1tMI+n0u/22w=;
  b=UVPUIONbYVwWIGInMW4rQnKho7Vq6QCcUduZ6HXFdqZpbLBUhVXTZ/Gf
   2GJNgt0/OEKEz/FnNOrIC4gDMvNAkz8sYIE/+FjtvW+VP1SUetTVOuZ5G
   gM4eOuEc82gRq9je7jz9vymBELeiKBSGzw013eiNF5ZXlxwXwmqiOQbSv
   7bVuEzjAshgz9Vx4oOz/69Ipeen5GqVtwES+Ejl3EY3iFFBMiEtiZR0kK
   daHyHJb6hz/QMvIqJiOWI4RqWaYNnvsgIgBWSm3/jWkipM1bnl7W9Iwm9
   MGPy7C1ANTyaq8iBF6RBOEjbqmPh6Xqp2LjGAv8Q8TOpjujKjk1/c88/f
   A==;
X-CSE-ConnectionGUID: voTHr3OxR7OtSbpDGvYTYw==
X-CSE-MsgGUID: sx5FnQXMTwm+X0jDOABeFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182761"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182761"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: C2UW1X9vREGx3M6I1wpKMQ==
X-CSE-MsgGUID: 164pRbArSh2aamESPCKqbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922932"
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
Subject: [PATCH 15/17] KVM: TDX: Handle removal of leaf SPTEs in .set_private_spte()
Date: Fri, 27 Mar 2026 13:14:19 -0700
Message-ID: <20260327201421.2824383-16-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Drop kvm_x86_ops.remove_external_spte(), and instead handling the removal
of leaf SPTEs in the S-EPT (a.k.a. external root) in .set_private_spte().
This will allow extending tdx_sept_set_private_spte() to support splitting
a huge S-EPT entry without needing yet another kvm_x86_ops hook.

Bug the VM if the callback fails, as redundant KVM_BUG_ON() calls are
benign (the WARN will fire if and only if the VM isn't already bugged) and
handle_changed_spte() is most definitely not prepared to handle failure.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 ---
 arch/x86/kvm/mmu/tdp_mmu.c         | 33 +-----------------------------
 arch/x86/kvm/vmx/tdx.c             | 22 ++++++++++++--------
 4 files changed, 14 insertions(+), 45 deletions(-)

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
index 808d2c7ea546..09588e797e4b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1884,9 +1884,6 @@ struct kvm_x86_ops {
 	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 void *external_spt);
 
-	/* Update external page table from spte getting removed, and flush TLB. */
-	void (*remove_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				     u64 mirror_spte);
 
 	bool (*has_wbinvd_exit)(void);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 5dc9633c866e..806788bdecce 100644
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
@@ -590,7 +568,7 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	if (was_present && !was_leaf &&
 	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
-	} else if (is_mirror_sp(sp) && is_present) {
+	} else if (is_mirror_sp(sp)) {
 		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
 						    new_spte, level);
 		if (r)
@@ -737,15 +715,6 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
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
index 5a1a6610a98f..bfbadba8bc08 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1788,10 +1788,10 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
 	return tdx_reclaim_page(virt_to_page(private_spt));
 }
 
-static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
-					 enum pg_level level, u64 mirror_spte)
+static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
+					enum pg_level level, u64 old_spte)
 {
-	struct page *page = pfn_to_page(spte_to_pfn(mirror_spte));
+	struct page *page = pfn_to_page(spte_to_pfn(old_spte));
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
@@ -1804,16 +1804,16 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
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
@@ -1829,18 +1829,22 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	err = tdh_do_no_vcpus(tdh_mem_page_remove, kvm, &kvm_tdx->td, gpa,
 			      level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
-		return;
+		return -EIO;
 
 	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
 	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
-		return;
+		return -EIO;
 
 	tdx_quirk_reset_page(page);
+	return 0;
 }
 
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
+	if (is_shadow_present_pte(old_spte))
+		return tdx_sept_remove_private_spte(kvm, gfn, level, old_spte);
+
 	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
 
@@ -3445,7 +3449,7 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
-	vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
+
 	vt_x86_ops.protected_apic_has_interrupt = tdx_protected_apic_has_interrupt;
 	return 0;
 
-- 
2.53.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D4838AC99;
	Sat,  9 May 2026 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315636; cv=none; b=Gxn0IfqJFuThqS5ODynQAcPt4q+9g21QuqtIEOIx3PObY8CQ5DJOLA4FXr3tTGJ6BR8igkeaWasUmiJ0tAi+29jLIHBMUyp73mveU+X42jAsovTpJlbLyoPf1uua2MvXr6Jno3vYxItufwrVM+cMaNlxEP1rI+8zpIWnemTYGcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315636; c=relaxed/simple;
	bh=pDBc2cJVxgasJ9ZkgKIDUz6fzf30X1yogw69VA3BjVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGSD7p99mMyDrw38VNmxtfPvAVJp+ReKEtPf+duMURJIk7Gw+EBxfy6L1jaCgVDv4ASY3/QMid5XjK6C3ZW5Qhz0qc2NgoUxlSrc8EvMOWWZ7xnfZDEKv6TzTNZmT41dAR5frSHfIMakwBprkpdHVEJeUQUSKWkB4jXjDdpNwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5tLKwwe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5tLKwwe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315635; x=1809851635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDBc2cJVxgasJ9ZkgKIDUz6fzf30X1yogw69VA3BjVY=;
  b=e5tLKwwerv0X918SW9lCapyRLKnuctyTZyREnNyUXEgqshp+bHE/UDqR
   LQWCxT+YWCoNcDDKZB26dvBm/kkQF6uagQPGu8YW34Y25q9nqGGS6CtkG
   oUDfEOa1LoFar03NeJ/+fEblEhQrWZFMTuBMqPzSgHzm2QxtCwNwEc/Es
   rIF60JnaYtfhiM2jOzYnPyvXhXS4izE1nWRKXCHAfPbZGLVrmW2gqQ/0c
   d2jTNHV2Ge6QpS1ncKiRmKOi5IIIOMU+W0j9NDvv15qBnsN8XjHLubQgd
   Z8BzK4fHHG0z9i20mX2z/J59TAyDE9n7k/qh9dP39IfKnCUquMgE5YAbO
   w==;
X-CSE-ConnectionGUID: zsEdw2cmTTie20T+/ol4+A==
X-CSE-MsgGUID: P7uQYjZFQaOQDIfs9myyiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79306381"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79306381"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:33:55 -0700
X-CSE-ConnectionGUID: 1J6rt6JTR4m9dKYlIjLNpA==
X-CSE-MsgGUID: 0czzThtKTyCqrOuaiLDGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="230584258"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:33:51 -0700
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
Subject: [PATCH v2 01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
Date: Sat,  9 May 2026 15:53:57 +0800
Message-ID: <20260509075357.4113-1-yan.y.zhao@intel.com>
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

Drop the dedicated .link_external_spt() for linking S-EPT pages, and
instead funnel everything through .set_external_spte() for mapping S-EPT
entries. Using separate hooks doesn't help prevent TDP MMU details from
bleeding into TDX, and vice versa; to the contrary, dedicated callbacks
will result in _more_ pollution when hugepage support is added, e.g. will
require the TDP MMU to know details about the splitting rules for TDX that
aren't all that relevant to the TDP MMU.

Ideally, KVM would provide a single pair of hooks to set S-EPT entries,
one hook for setting SPTEs under write-lock and another for setting SPTEs
under read-lock (e.g. to ensure the entire operation is "atomic", to allow
for failure, etc.).  Sadly, TDX's requirement that all child S-EPT entries
are removed before the parent makes that impractical: the TDP MMU
deliberately prunes non-leaf SPTEs and _then_ processes its children, thus
making it quite important for the TDP MMU to differentiate between zapping
leaf and non-leaf S-EPT entries.

However, that's the _only_ case that's truly special, and even that case
could be shoehorned into a single hook; it just wouldn't be a net positive.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rick: add in trivial feedback]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Moved this patch to the very beginning of the series so that when
  warnings like "KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm)" are
  removed from __tdp_mmu_set_spte_atomic() in TDP MMU in a later patch, the
  atomic zap change can be propagated via the .set_external_spte() op.
  (Yan).

MMU_refactors v1:
 - rename external_spt->sept_pt (Rick, Yan)
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 --
 arch/x86/kvm/mmu/tdp_mmu.c         | 29 +-------------
 arch/x86/kvm/vmx/tdx.c             | 63 ++++++++++++++++++++----------
 4 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 31d5c5d58ae6..bced6d938702 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -95,7 +95,6 @@ KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
-KVM_X86_OP_OPTIONAL_RET0(link_external_spt)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
 KVM_X86_OP_OPTIONAL(remove_external_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c470e40a00aa..832323c4bc27 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1891,9 +1891,6 @@ struct kvm_x86_ops {
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
 
-	/* Update external mapping with page table link. */
-	int (*link_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				void *external_spt);
 	/* Update the external page table from spte getting set. */
 	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 u64 mirror_spte);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index dbaeb80f2b64..e6c3b739d1fe 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -495,27 +495,12 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
-static void *get_external_spt(gfn_t gfn, u64 new_spte, int level)
-{
-	if (is_shadow_present_pte(new_spte) && !is_last_spte(new_spte, level)) {
-		struct kvm_mmu_page *sp = spte_to_child_sp(new_spte);
-
-		WARN_ON_ONCE(sp->role.level + 1 != level);
-		WARN_ON_ONCE(sp->gfn != gfn);
-		return sp->external_spt;
-	}
-
-	return NULL;
-}
-
 static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sptep,
 						 gfn_t gfn, u64 *old_spte,
 						 u64 new_spte, int level)
 {
 	bool was_present = is_shadow_present_pte(*old_spte);
-	bool is_present = is_shadow_present_pte(new_spte);
-	bool is_leaf = is_present && is_last_spte(new_spte, level);
-	int ret = 0;
+	int ret;
 
 	KVM_BUG_ON(was_present, kvm);
 
@@ -528,18 +513,8 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
 	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
 		return -EBUSY;
 
-	/*
-	 * Use different call to either set up middle level
-	 * external page table, or leaf.
-	 */
-	if (is_leaf) {
-		ret = kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
-	} else {
-		void *external_spt = get_external_spt(gfn, new_spte, level);
+	ret = kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
 
-		KVM_BUG_ON(!external_spt, kvm);
-		ret = kvm_x86_call(link_external_spt)(kvm, gfn, level, external_spt);
-	}
 	if (ret)
 		__kvm_tdp_mmu_write_spte(sptep, *old_spte);
 	else
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 9bd4fd748e2a..48c836ec6063 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1653,18 +1653,58 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
+static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
+					u64 new_spte, enum pg_level level)
+{
+	struct kvm_mmu_page *sp = spte_to_child_sp(new_spte);
+
+	if (KVM_BUG_ON(!sp->external_spt, kvm) ||
+	    KVM_BUG_ON(sp->role.level + 1 != level, kvm) ||
+	    KVM_BUG_ON(sp->gfn != gfn, kvm))
+		return NULL;
+
+	return virt_to_page(sp->external_spt);
+}
+
+static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, u64 mirror_spte)
+{
+	gpa_t gpa = gfn_to_gpa(gfn);
+	u64 err, entry, level_state;
+	struct page *sept_pt;
+
+	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, mirror_spte, level);
+	if (!sept_pt)
+		return -EIO;
+
+	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
+			       &entry, &level_state);
+	if (unlikely(tdx_operand_busy(err)))
+		return -EBUSY;
+
+	if (TDX_BUG_ON_2(err, TDH_MEM_SEPT_ADD, entry, level_state, kvm))
+		return -EIO;
+
+	return 0;
+}
+
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, u64 mirror_spte)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
 
+	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
+		return -EIO;
+
+	if (!is_last_spte(mirror_spte, level))
+		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
+
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
 		return -EIO;
 
-	WARN_ON_ONCE(!is_shadow_present_pte(mirror_spte) ||
-		     (mirror_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
+	WARN_ON_ONCE((mirror_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
 
 	/*
 	 * Ensure pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory()
@@ -1684,24 +1724,6 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
-static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, void *private_spt)
-{
-	gpa_t gpa = gfn_to_gpa(gfn);
-	struct page *page = virt_to_page(private_spt);
-	u64 err, entry, level_state;
-
-	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, page, &entry,
-			       &level_state);
-	if (unlikely(tdx_operand_busy(err)))
-		return -EBUSY;
-
-	if (TDX_BUG_ON_2(err, TDH_MEM_SEPT_ADD, entry, level_state, kvm))
-		return -EIO;
-
-	return 0;
-}
-
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
  * tdh_mem_track() is the only caller that increases TD epoch. An increase in
@@ -3413,7 +3435,6 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
 
-	vt_x86_ops.link_external_spt = tdx_sept_link_private_spt;
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
 	vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
-- 
2.43.2


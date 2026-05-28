Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA53815C5;
	Thu, 28 May 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958239; cv=none; b=CBAfA9quJQLUQ1RbKyus1dj3FT1x/FHbJuliNV7dh6/O41Umhm1ikl2+rrcgS96yryo3RmmoJv5TkcIjwnjlmGHM8Oc5FE1D7fkXN/jNDmmAzr9ohXvlOzPm4MIePyMJOlMHQpU4m42tDK+mgC7pECGg5kVfe02sBt6aKoKG7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958239; c=relaxed/simple;
	bh=QBjT4H/o5E0+CDJoBDAHY3pH9otmbxSdU9SWWy32WA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKKi7nC0PThQ2pm/41G6IQLCG7Ey/P/8d+DxDwIGzBpbmxfllsBJEqySPk6I37otfKfyFOj/4RIQDbNZRj5xmfE/m8b0Kw6jbsMV982R9WDavZeBbDEk2mffb5UY4oEHG6LRVsh4W/pXN0GnoMYX9serEm7q/FwtxzRxcQrCKI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxhO+rfl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxhO+rfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958238; x=1811494238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QBjT4H/o5E0+CDJoBDAHY3pH9otmbxSdU9SWWy32WA0=;
  b=nxhO+rflvYjfd1tbsN4zpmrA1+SssOl+2icRpns7Ld8c20XVF6K4JGyq
   taQW8Yh0hq+9Tz3RPxyL8Zki3B0ociqBdSzSPxCNcUCXK2yhbwTWhDmLE
   kJ9Up0QKv3EWwPEwcl5YFxBjJnPFYDdmIiMbu1hxZj1w0aP4EXW1kYBsN
   5vg8sptvv5AI7vjo363YbhbmL4Li/XhPMDOzWA7stQaCY+6rqSi1n88Z3
   s58fVfh9TsA37TlPyvcxJe5xDHTq4nvCio46CstgOL3XpqRFH7lplUB4i
   PmmJLjR/+creVititGeGd0/aTQnrPvRwR3owm1PWt7Q+LCKiRAShSwwxq
   g==;
X-CSE-ConnectionGUID: 80W8dtutSeCPSBHcyRDsmw==
X-CSE-MsgGUID: 1v25EvxCSayNUswQPBkcJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91105722"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="91105722"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:50:37 -0700
X-CSE-ConnectionGUID: px5UrW9nRSKjLS5CYlSVsA==
X-CSE-MsgGUID: +bqs9Xs6TwS4PCVwEeKlEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241460893"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:50:34 -0700
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
Subject: [PATCH v3 01/15] KVM: TDX: Drop kvm_x86_ops.link_external_spt()
Date: Thu, 28 May 2026 16:10:29 +0800
Message-ID: <20260528081029.10220-1-yan.y.zhao@intel.com>
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
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

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
index b0269325646c..2cb393000ee9 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -96,7 +96,6 @@ KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
 KVM_X86_OP(load_mmu_pgd)
-KVM_X86_OP_OPTIONAL_RET0(link_external_spt)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
 KVM_X86_OP_OPTIONAL(remove_external_spte)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d72051150bac..55ec998cc861 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1914,9 +1914,6 @@ struct kvm_x86_ops {
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
 
-	/* Update external mapping with page table link. */
-	int (*link_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				void *external_spt);
 	/* Update the external page table from spte getting set. */
 	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 u64 mirror_spte);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f98afc3422ce..0dc1b0597f8a 100644
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
index d43948a3bb11..34e7e4833871 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1659,18 +1659,58 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
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
@@ -1690,24 +1730,6 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
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
@@ -3424,7 +3446,6 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
 
-	vt_x86_ops.link_external_spt = tdx_sept_link_private_spt;
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
 	vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
-- 
2.43.2


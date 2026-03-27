Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBDB39B96C;
	Fri, 27 Mar 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642475; cv=none; b=NQE9wUWHH7xloCXx9NPzcWmza/LLGnF1kFBF9rbayvjMx3wzP5xbmMISqDdBmv34u1fHj4xPTSIgS0zOMXPxO8inEAS/ykMxbuHbI9gQehvqjdN8JCdd/pPvRmVzQRQ22n441eIpc2IkGF4xjkQ6JeV3uMlCWRV5xUlRvsx5ezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642475; c=relaxed/simple;
	bh=SaEqeTeiEhkjJCLNtXb3zqlM6LFcp8nKgBSVYHkQYV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlbfdoLsXvZ7AlL2LDcICBEvhzj71/JJaW6+Nvtar9sKoRXcectEKd3lA5fHGKtjA4vdFhRD9wn/5WX6MQLPofNO6b6lhgTyJ/cY3utJQvYYE8cGeOB3AwNb7ePc180PxtpAwuGzMx3KK5VE67XeXrXwgZjoWNyBdvyCOVyKK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJifDqKD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJifDqKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642473; x=1806178473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SaEqeTeiEhkjJCLNtXb3zqlM6LFcp8nKgBSVYHkQYV8=;
  b=mJifDqKDdfjyLe3nWWyoq/gJAZnQ5EMBbnKcQhJWlo3Blht9jklpfG15
   fkx6ItpJ83lB4GPnQfUoPGfne5hiB6UcdDvnlNbCUH2IQBnpKrptsGJ9X
   v7W4iiVLu1YLMPz8gF02mjumOt05YaPsJNbKJaLrDh+rGsrZulnzt+6s9
   gXA2t29aJsQaFqxwycCb69gy6shJ91WkVbRXehG5TN1UKjiN4PM0RIS9m
   tU0l9mgLfNchP0EBQn19MLHLlCGpBPIulEGrdG3MFss2Gxzqpqye/M5ZZ
   7RE5HI1XaFwFpY06ujO34jvD2RsZ8HvdQFl8zy1vxeII36Tkzk+G9qPm9
   g==;
X-CSE-ConnectionGUID: o8Dur5v7SX20/quCFf/vvw==
X-CSE-MsgGUID: FZ+yUiaUT4S6gPYSBxOj7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182743"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: Yz0ChCC7QxaPlcmXkFZvTg==
X-CSE-MsgGUID: S6dbAdZITzi9I5jMFZ5Zmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922910"
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
Subject: [PATCH 08/17] KVM: TDX: Drop kvm_x86_ops.link_external_spt(), use .set_external_spte() for all
Date: Fri, 27 Mar 2026 13:14:12 -0700
Message-ID: <20260327201421.2824383-9-rick.p.edgecombe@intel.com>
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

Drop the dedicated .link_external_spt() for linking non-leaf S-EPT pages,
and instead funnel everything through .set_external_spte().  Using separate
hooks doesn't help prevent TDP MMU details from bleeding into TDX, and vice
versa; to the contrary, dedicated callbacks will result in _more_ pollution
when hugepage support is added, e.g. will require the TDP MMU to know
details about the splitting rules for TDX that aren't all that relevant to
the TDP MMU.

Ideally, KVM would provide a single pair of hooks to set S-EPT entries,
one hook for setting SPTEs under write-lock and another for settings SPTEs
under read-lock (e.g. to ensure the entire operation is "atomic", to allow
for failure, etc.).  Sadly, TDX's requirement that all child S-EPT entries
are removed before the parent makes that impractical: the TDP MMU
deliberately prunes non-leaf SPTEs and _then_ processes its children, thus
making it quite important for the TDP MMU to differentiate between zapping
leaf and non-leaf S-EPT entries.

However, that's the _only_ case that's truly special, and even that case
could be shoehorned into a single hook; it's just wouldn't be a net
positive.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[add in trivial feedback]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v6:
 - rename external_spt->sept_pt (Rick, Yan)
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 -
 arch/x86/include/asm/kvm_host.h    |  3 --
 arch/x86/kvm/mmu/tdp_mmu.c         | 31 +--------------
 arch/x86/kvm/vmx/tdx.c             | 61 ++++++++++++++++++++----------
 4 files changed, 43 insertions(+), 53 deletions(-)

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
index d3bdc9828133..1139bd89f0cf 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1876,9 +1876,6 @@ struct kvm_x86_ops {
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
 
-	/* Update external mapping with page table link. */
-	int (*link_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				void *external_spt);
 	/* Update the external page table from spte getting set. */
 	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				 u64 mirror_spte);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index db16e81b9701..6dc08fe22841 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -494,42 +494,13 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
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
 static int __must_check set_external_spte_present(struct kvm *kvm,
 						  gfn_t gfn, u64 old_spte,
 						  u64 new_spte, int level)
 {
-	bool is_present = is_shadow_present_pte(new_spte);
-	bool is_leaf = is_present && is_last_spte(new_spte, level);
-	int ret = 0;
-
 	lockdep_assert_held(&kvm->mmu_lock);
 
-	/*
-	 * Use different call to either set up middle level
-	 * external page table, or leaf.
-	 */
-	if (is_leaf) {
-		ret = kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
-	} else {
-		void *external_spt = get_external_spt(gfn, new_spte, level);
-
-		KVM_BUG_ON(!external_spt, kvm);
-		ret = kvm_x86_call(link_external_spt)(kvm, gfn, level, external_spt);
-	}
-	return ret;
+	return kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
 }
 
 /**
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 01e070ec10fd..92a846b91bac 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1654,18 +1654,58 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
+static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
+					     u64 new_spte, enum pg_level level)
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
@@ -1685,23 +1725,7 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
-static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, void *private_spt)
-{
-	gpa_t gpa = gfn_to_gpa(gfn);
-	struct page *page = virt_to_page(private_spt);
-	u64 err, entry, level_state;
 
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
 
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
@@ -3413,7 +3437,6 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.vm_size = max_t(unsigned int, vt_x86_ops.vm_size, sizeof(struct kvm_tdx));
 
-	vt_x86_ops.link_external_spt = tdx_sept_link_private_spt;
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
 	vt_x86_ops.remove_external_spte = tdx_sept_remove_private_spte;
-- 
2.53.0


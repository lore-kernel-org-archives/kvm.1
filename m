Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B15315D40;
	Tue, 26 May 2026 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762938; cv=none; b=FvA+tOyarspoJkqmU55Ozy2oUSyYAyFqvIWNtedrTBFIYaM3x1CcO6ojGmjAQDYhnO2nuKMsDbbCUCRK7sqe5hwWZn0n7hf2SE+sPuK0jJXzmhtrbfiw58vyJudtApdQRnkPaQiPHGDmZTOiEe8lh1bvSxwsSmMOtBH9M3QasyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762938; c=relaxed/simple;
	bh=x4M3BHIRpF+bPtXgd/Cy9C6LdFBaMDPFDLmTYYjTwHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDnGP3LZPUD8PQLqwFVzVqeNiHKauvwl8k+SeuTZfsaIJoPgeWQWAJcgn4Ucq2Tl3qPyCtYnIRpQkwTZq/3j+l5Id/Sf+3jQp2xUqA9JWpRHzmrwkR4TzN3PpA5iE2Qqc8f7UIFaeTp7h8/tJ5PvmxD3eHH3CgJP3oi2YGz0bP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9JPz4Bz; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9JPz4Bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762936; x=1811298936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x4M3BHIRpF+bPtXgd/Cy9C6LdFBaMDPFDLmTYYjTwHI=;
  b=F9JPz4BzWIK/WTANwhybIEvUjsI8Dd3aTwSsawfKEslBX0bukrqMO0Np
   pmgQb0Maq6p7AR65mwHG0Fw63t9j105O4JglrNFFjgEuBSAqw7bRuPykP
   IMS1Hnq1QAUuTttjCNSipD40HsJ5qLGySPL6GBwahhvlNa06yCGA9DaMy
   tT2pgv0ZHwLYL64w+eVhLyqjcofCNxustgGPXJLmJylBQbjCYsWdhm/sA
   ncsHmheVYlKVrJKVeItBZP9ktznpUyzBNN+COohTQLS//hANGLdBq2jcr
   zwyoxMbBKhAKYkolx9ulcN/MT3SZp06U/J+nVnuvHUJ/gtNkWChJnfOw5
   Q==;
X-CSE-ConnectionGUID: ExdPvukfTJSI1uKWjMY2Dg==
X-CSE-MsgGUID: ksfsbpUWQNu5CzJYffTaJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677846"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677846"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: Oxd/nPBVQXqBWHIJDRbqDA==
X-CSE-MsgGUID: YLmp9nw3Swegidwv5nab4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878323"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com
Cc: rick.p.edgecombe@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 09/11] KVM: TDX: Get/put PAMT pages when (un)mapping private memory
Date: Mon, 25 May 2026 19:35:13 -0700
Message-ID: <20260526023515.288829-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
removing guest memory (PAGE.REMOVE).

To access the per-vCPU PAMT caches without plumbing @vcpu throughout the
TDP MMU, begrudgingly use kvm_get_running_vcpu() to get the vCPU, and bug
the VM if KVM attempts to set an S-EPT leaf without an active vCPU.  KVM
only supports creating _new_ mappings in page (pre)fault paths, all of
which require an active vCPU.

The PAMT memory holds metadata for TDX-protected memory. With Dynamic
PAMT, PAMT_4K is allocated on demand. The kernel supplies the TDX module
with a few pages that cover 2M of host physical memory.

Releases are balanced via tdx_pamt_put(): every control-page free goes
through tdx_free_control_page(), and guest data pages are put directly on
the successful tdh_mem_page_remove() path and in the
tdx_mem_page_add/aug() error path.

Assisted-by: Sashiko:claude-opus-4-6 GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v6:
 - Don't have topup op take a min param (Yan, Sean)
 - Make log match style of the rest of the series
 - Adjustments from dropping error helper patches
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  2 +
 arch/x86/kvm/mmu/mmu.c             |  4 ++
 arch/x86/kvm/vmx/tdx.c             | 65 ++++++++++++++++++++++++++----
 arch/x86/kvm/vmx/tdx.h             |  2 +
 5 files changed, 66 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 10ccf6ea9d9a2..320f1d30edacc 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -97,6 +97,7 @@ KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
 KVM_X86_OP_OPTIONAL(free_external_spt)
+KVM_X86_OP_OPTIONAL_RET0(topup_external_cache)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
 KVM_X86_OP(get_l2_tsc_multiplier)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6b28dd387bc61..bfe92e993a212 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1898,6 +1898,8 @@ struct kvm_x86_ops {
 	/* Update external page tables for page table about to be freed. */
 	void (*free_external_spt)(struct kvm *kvm, struct kvm_mmu_page *sp);
 
+	int (*topup_external_cache)(struct kvm_vcpu *vcpu, int min_nr_spts);
+
 
 	bool (*has_wbinvd_exit)(void);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 892246204435c..2a48fc7fccc11 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -607,6 +607,10 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 					       PT64_ROOT_MAX_LEVEL);
 		if (r)
 			return r;
+
+		r = kvm_x86_call(topup_external_cache)(vcpu, PT64_ROOT_MAX_LEVEL);
+		if (r)
+			return r;
 	}
 	r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_shadow_page_cache,
 				       PT64_ROOT_MAX_LEVEL);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 3e67e2471ffe3..ee073cacafbec 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -685,6 +685,8 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
 	if (!irqchip_split(vcpu->kvm))
 		return -EINVAL;
 
+	tdx_init_pamt_cache(&tdx->pamt_cache);
+
 	fpstate_set_confidential(&vcpu->arch.guest_fpu);
 	vcpu->arch.apic->guest_apic_protected = true;
 	INIT_LIST_HEAD(&tdx->vt.pi_wakeup_list);
@@ -870,6 +872,8 @@ void tdx_vcpu_free(struct kvm_vcpu *vcpu)
 	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	int i;
 
+	tdx_free_pamt_cache(&tdx->pamt_cache);
+
 	if (vcpu->cpu != -1) {
 		KVM_BUG_ON(tdx->state == VCPU_TD_STATE_INITIALIZED, vcpu->kvm);
 		tdx_flush_vp_on_cpu(vcpu);
@@ -1611,6 +1615,16 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
 }
 
+static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
+{
+	/*
+	 * Don't cover the root SPT, but cover a possible 4KB private
+	 * page in addition to the SPTs. So -1 to exclude the root
+	 * SPT, and +1 for the guest page cancel out.
+	 */
+	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
+}
+
 static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 			    kvm_pfn_t pfn)
 {
@@ -1669,16 +1683,29 @@ static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
 static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, u64 new_spte)
 {
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 	struct page *sept_pt;
+	int ret;
+
+	if (KVM_BUG_ON(!vcpu, kvm))
+		return -EIO;
 
 	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
 	if (!sept_pt)
 		return -EIO;
 
+	ret = tdx_pamt_get(page_to_pfn(sept_pt), &tdx->pamt_cache);
+	if (ret)
+		return ret;
+
 	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
 			       &entry, &level_state);
+	if (err)
+		tdx_pamt_put(page_to_pfn(sept_pt));
+
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
 
@@ -1691,8 +1718,14 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
 static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 				  u64 new_spte)
 {
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	kvm_pfn_t pfn = spte_to_pfn(new_spte);
+	struct vcpu_tdx *tdx = to_tdx(vcpu);
+	int ret;
+
+	if (KVM_BUG_ON(!vcpu, kvm))
+		return -EIO;
 
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
@@ -1700,6 +1733,10 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 
 	WARN_ON_ONCE((new_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
 
+	ret = tdx_pamt_get(pfn, &tdx->pamt_cache);
+	if (ret)
+		return ret;
+
 	/*
 	 * Ensure pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory()
 	 * before kvm_tdx->state.  Userspace must not be allowed to pre-fault
@@ -1712,10 +1749,15 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 	 * If the TD isn't finalized/runnable, then userspace is initializing
 	 * the VM image via KVM_TDX_INIT_MEM_REGION; ADD the page to the TD.
 	 */
-	if (unlikely(kvm_tdx->state != TD_STATE_RUNNABLE))
-		return tdx_mem_page_add(kvm, gfn, level, pfn);
+	if (likely(kvm_tdx->state == TD_STATE_RUNNABLE))
+		ret = tdx_mem_page_aug(kvm, gfn, level, pfn);
+	else
+		ret = tdx_mem_page_add(kvm, gfn, level, pfn);
 
-	return tdx_mem_page_aug(kvm, gfn, level, pfn);
+	if (ret)
+		tdx_pamt_put(pfn);
+
+	return ret;
 }
 
 /*
@@ -1812,6 +1854,7 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 		return -EIO;
 
 	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
+	tdx_pamt_put(pfn);
 	return 0;
 }
 
@@ -1855,6 +1898,8 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
  */
 static void tdx_sept_free_private_spt(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
+	struct page *sept_pt = virt_to_page(sp->external_spt);
+
 	/*
 	 * KVM doesn't (yet) zap page table pages in mirror page table while
 	 * TD is active, though guest pages mapped in mirror page table could be
@@ -1868,15 +1913,15 @@ static void tdx_sept_free_private_spt(struct kvm *kvm, struct kvm_mmu_page *sp)
 	 * the page to prevent the kernel from accessing the encrypted page.
 	 */
 	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
-	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
+	    tdx_reclaim_page(sept_pt))
 		goto out;
 
 	/*
-	 * Immediately free the S-EPT page because RCU-time free is unnecessary
-	 * after TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding
-	 * readers.
+	 * Immediately free the S-EPT page as the TDX subsystem doesn't support
+	 * freeing pages from RCU callbacks, and more importantly because
+	 * TDH.PHYMEM.PAGE.RECLAIM ensures there are no outstanding readers.
 	 */
-	free_page((unsigned long)sp->external_spt);
+	tdx_free_control_page(sept_pt);
 out:
 	sp->external_spt = NULL;
 }
@@ -3468,6 +3513,10 @@ int __init tdx_hardware_setup(void)
 
 	vt_x86_ops.set_external_spte = tdx_sept_set_private_spte;
 	vt_x86_ops.free_external_spt = tdx_sept_free_private_spt;
+
+	if (tdx_supports_dynamic_pamt(tdx_sysinfo))
+		vt_x86_ops.topup_external_cache = tdx_topup_external_pamt_cache;
+
 	vt_x86_ops.protected_apic_has_interrupt = tdx_protected_apic_has_interrupt;
 	return 0;
 
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index b5cd2ffb303e5..47334a5a74eab 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -73,6 +73,8 @@ struct vcpu_tdx {
 
 	u64 map_gpa_next;
 	u64 map_gpa_end;
+
+	struct tdx_pamt_cache pamt_cache;
 };
 
 void tdh_vp_rd_failed(struct vcpu_tdx *tdx, char *uclass, u32 field, u64 err);
-- 
2.54.0


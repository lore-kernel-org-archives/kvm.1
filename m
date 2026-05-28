Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27B389E13;
	Thu, 28 May 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958409; cv=none; b=Ac55PgtWNRusEFfDwg3QTaAUIvB6KMIeXP9igIwCBmlRVq1FJu/jVfI3NHQ13CBJJRtJ0XBbkHMBTWFUjabz21EjSXr/x3gJNscPUECsVJx5KOZ9zvoMQZdwdO3G3u+inm84kkrYIsfEnuR0VcQ19SOOhw1OFKUdK5fQPdMovG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958409; c=relaxed/simple;
	bh=Ra7s6JRuRGiQ+O+rP5LogtfQDOt1r2HJRbwGx4MjqA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+pZ2pEPIadTCtg8TJf2XmO1cViHyjDVp6I3bE+iF+p0L11k3E04UjRNWPmTREB4D96ZdnV2PLm25z37At4ts6LrjSCA3j7pYora9rWp3SBqBC0QlPwFv0BpxwoQrfVtEGqRuH3diSY8hi8TulaQ9KoMyznGQk7rbK4hcP5FhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SAfJwit6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SAfJwit6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958408; x=1811494408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ra7s6JRuRGiQ+O+rP5LogtfQDOt1r2HJRbwGx4MjqA8=;
  b=SAfJwit6t7zol07mHNmDgQMrMVIvcoAS6DZSH5wTK1k5j0XoQ826cRdA
   P/ziJHiGsBdrW5PF0SKkgqW0v/4nZ7dn9v7R9V+UFD8lkjHEWTo2/8WmT
   WC9ChegPtyjlbYKVYu6ZIpSsccOKkrEDLTeT6/2viyGm2IIw3v7WOmluP
   9aiXUokaFCsjWvGTlVa4HlyQnRdOnYwIh+J/Qi2hBg9OuwPi9AV/Lb5jl
   qPaYXJ8W5Xzt/gebDoKDK/lX+qEYOepWaCmJW2Qga+/v/sxbk7BlbfhEB
   hWufAIm6SK+KB+KfIJTANsa1zyVNG49lCh7fu1AWqTvya3natt6Yf/t0R
   Q==;
X-CSE-ConnectionGUID: hHl+S2UMTRWeAbmT2aE0tw==
X-CSE-MsgGUID: ELJIdlVvQuiv1b8BawGDcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103469731"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="103469731"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:27 -0700
X-CSE-ConnectionGUID: KZAox/aZSBenSF9KCrSfWA==
X-CSE-MsgGUID: NS+SJ9GTSJ+SMrvqGob6Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="238312169"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:24 -0700
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
Subject: [PATCH v3 14/15] KVM: x86: Move error handling inside free_external_spt()
Date: Thu, 28 May 2026 16:13:20 +0800
Message-ID: <20260528081320.10428-1-yan.y.zhao@intel.com>
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

Move the logic for TDX's specific need to leak pages when reclaim
fails inside the free_external_spt() op, so this can be done in TDX
specific code and not the generic MMU.

Do this by passing the "sp" in instead of the external page table pointer.
This way TDX code can set sp->external_spt to NULL. Since the error is now
handled internally in TDX code (by triggering KVM_BUG_ON() or
TDX_BUG_ON_3(), which warn and stop the VM on any error), change the op to
return void. This way it also operates like a normal free in that success
is guaranteed from the caller's perspective.

Opportunistically, drop the unused level and gfn args while adjusting the
sp arg.

[ Rick: Re-wrote log and massaged op name ]
[ Yan: Updated patch log/function comment, dropped unused param in op ]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- Fixed typo in the patch log. (Binbin)
- Dropped unused param gfn. (Binbin)
- Mentioned that failure is not handled silently in the patch log. (Binbin)
- Added expected lock and valid scenarios in function comment of
  tdx_sept_free_private_spt(). (Yan/Rick)
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  3 +--
 arch/x86/kvm/mmu/tdp_mmu.c         | 13 ++-----------
 arch/x86/kvm/vmx/tdx.c             | 28 ++++++++++++++--------------
 4 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 771d991562ca..83dc5086138b 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -97,7 +97,7 @@ KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
-KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
+KVM_X86_OP_OPTIONAL(free_external_spt)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
 KVM_X86_OP(get_l2_tsc_multiplier)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 987e005f08eb..e67d0df51843 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1919,8 +1919,7 @@ struct kvm_x86_ops {
 				 u64 new_spte, enum pg_level level);
 
 	/* Update external page tables for page table about to be freed. */
-	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				 void *external_spt);
+	void (*free_external_spt)(struct kvm *kvm, struct kvm_mmu_page *sp);
 
 
 	bool (*has_wbinvd_exit)(void);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 72d323f2d0dc..74531e4bbee6 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -455,17 +455,8 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
 	}
 
-	if (is_mirror_sp(sp) &&
-	    WARN_ON(kvm_x86_call(free_external_spt)(kvm, base_gfn, sp->role.level,
-						    sp->external_spt))) {
-		/*
-		 * Failed to free page table page in mirror page table and
-		 * there is nothing to do further.
-		 * Intentionally leak the page to prevent the kernel from
-		 * accessing the encrypted page.
-		 */
-		sp->external_spt = NULL;
-	}
+	if (is_mirror_sp(sp))
+		kvm_x86_call(free_external_spt)(kvm, sp);
 
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a385cfa56e4c..aa0d16b71e00 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1855,27 +1855,27 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
 }
 
-static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, void *private_spt)
+/*
+ * Handle changes for non-leaf SPTEs from present to non-present.
+ * Must be under exclusive mmu_lock and cannot fail.
+ */
+static void tdx_sept_free_private_spt(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-
 	/*
-	 * free_external_spt() is only called after hkid is freed when TD is
-	 * tearing down.
 	 * KVM doesn't (yet) zap page table pages in mirror page table while
 	 * TD is active, though guest pages mapped in mirror page table could be
 	 * zapped during TD is active, e.g. for shared <-> private conversion
 	 * and slot move/deletion.
+	 *
+	 * In other words, KVM should only free mirror page tables after the
+	 * TD's hkid is freed, when the TD is being torn down.
+	 *
+	 * If the S-EPT PTE can't be removed for any reason, intentionally leak
+	 * the page to prevent the kernel from accessing the encrypted page.
 	 */
-	if (KVM_BUG_ON(is_hkid_assigned(kvm_tdx), kvm))
-		return -EIO;
-
-	/*
-	 * The HKID assigned to this TD was already freed and cache was
-	 * already flushed. We don't have to flush again.
-	 */
-	return tdx_reclaim_page(virt_to_page(private_spt));
+	if (KVM_BUG_ON(is_hkid_assigned(to_kvm_tdx(kvm)), kvm) ||
+	    tdx_reclaim_page(virt_to_page(sp->external_spt)))
+		sp->external_spt = NULL;
 }
 
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
-- 
2.43.2


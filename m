Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A922E3932E5;
	Fri, 27 Mar 2026 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642481; cv=none; b=f3g7fTPMXc0ooXPMxsYyjSxrR30hPS3t1fMZoAE6cT34r150nbirz6fY40IaupDqdza6LFr3mwLda11t79C+z5+TCCMdFyGKvtaemhFPfMLwPhEZwucU24Tk7t6hYVxRHI56p/aSUjEkBUhO/RUPPP42TS66qh7SDV910j7ZLYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642481; c=relaxed/simple;
	bh=NzbvF1Knz7BqCBLTC5aW6ttylV9MJisv4hKu20gBQJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gH0S4L619Blx5sIUv5lN+95j9IZiYPeRkhHQ5cosrnx5OJFt+1B7EbK/H1+Xd5nvzhcBKlRCZ5gi1SymWIRoLQ3sM7kFbop5Kzk8qVTc74HkC1f8DnQxNWXyd8dvsKR7Cfwp+8BU6wTZNbx97yQEBcaaXYIc40XoF8QaOBKQvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fzjaa3cX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fzjaa3cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642480; x=1806178480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzbvF1Knz7BqCBLTC5aW6ttylV9MJisv4hKu20gBQJk=;
  b=Fzjaa3cXgDxz62aVESc1atfR17j1MjwBjsZYtd3bzTRSLHms3oOEOkl4
   KgEY2hh3YblHp6oKuNJvR8IyJygm4KfRCyr92FIPWo/nAh9n0ZAsC0EXG
   YnS86AEeQ4RRDHgswkYSZktyhKFxJoQTk/yquNS21u/S38KarmsOfyuJ+
   NhmQYveYaAni1Jc18SBOn3IYHiBybk9nR6Tz55OnYmdv8D6dtG1pnYFsM
   a7kQZnRJGAuUrxoI9ocRQYDbDmB5bjKljOMBn1gXl7MBJAPpjRofrVmeB
   sy5xYgvSkJEzMKFowNNkOtCrciXX0kTa7q8QWAaRnfrZqJ2VU5Cu0v7WH
   A==;
X-CSE-ConnectionGUID: HiTtSTm5T8yfDU6wBHN5lg==
X-CSE-MsgGUID: dYvYCw+WQBOSUwmshs3jdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182763"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182763"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: W3om/jnjS/u2a0Ve/e2boA==
X-CSE-MsgGUID: onxnZjAXSP+yBJP5MYOxAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922935"
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
Subject: [PATCH 16/17] KVM: x86: Move error handling inside free_external_spt()
Date: Fri, 27 Mar 2026 13:14:20 -0700
Message-ID: <20260327201421.2824383-17-rick.p.edgecombe@intel.com>
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

Move the logic for TDX’s specific need to leak pages when reclaim
fails inside the free_external_spt() op, so this can be done in TDX
specific code and not the generic MMU.

Do this by passing the SP in instead of the external page table
pointer. This way TDX code can set sp->external_spt to NULL. Since the
error is now handled internally, change the op to return void. This way
it also operated like a normal free in that success is guaranteed from
the callers perspective.

Opportunistically, drop the unused level arg while adjusting the sp arg.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[re-wrote log and massaged op name]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
Notable changes since last discussion
 - Since free_external_sp() is dropped in the latter DPAMT patches, don't
   bother renaming free_external_spt().
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 +-
 arch/x86/include/asm/kvm_host.h    |  3 +--
 arch/x86/kvm/mmu/tdp_mmu.c         | 13 ++-----------
 arch/x86/kvm/vmx/tdx.c             | 25 +++++++++++--------------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index ed348c6dd445..10ccf6ea9d9a 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -96,7 +96,7 @@ KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
 KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
-KVM_X86_OP_OPTIONAL_RET0(free_external_spt)
+KVM_X86_OP_OPTIONAL(free_external_spt)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
 KVM_X86_OP(get_l2_tsc_multiplier)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 09588e797e4b..fbc39f0bb491 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1881,8 +1881,7 @@ struct kvm_x86_ops {
 				 u64 new_spte, enum pg_level level);
 
 	/* Update external page tables for page table about to be freed. */
-	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				 void *external_spt);
+	void (*free_external_spt)(struct kvm *kvm, gfn_t gfn, struct kvm_mmu_page *sp);
 
 
 	bool (*has_wbinvd_exit)(void);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 806788bdecce..575033cc7fe4 100644
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
+		kvm_x86_call(free_external_spt)(kvm, base_gfn, sp);
 
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index bfbadba8bc08..d064b40a6b31 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1765,27 +1765,24 @@ static void tdx_track(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
 }
 
-static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, void *private_spt)
+static void tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
+					struct kvm_mmu_page *sp)
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
 
 static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
-- 
2.53.0


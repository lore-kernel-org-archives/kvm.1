Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE3D379980;
	Thu, 28 May 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958376; cv=none; b=RhpCk85uKqBZO1JL5SA0Ec6Ar2zKmLENl3FcH6+aoRxAVQS7k8po0qYFkAR7LceoqR0gaxL9AmwaBz67yhQIgbIDPxSJ5ZYiq0DrxZXiYCeFT0JHqXP9OOxis5Gv533jiHlKG/c1JHE1iROIJpnnvkS8MZsoWGKfT/S+hOdFp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958376; c=relaxed/simple;
	bh=C4Hcg8eqtOzlbXPE2qDTzUfxxDPuBgJdEsENfF/+vU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6xG1JE74s6HEJYGgmqvJOi4IVxQ9QxoyzdccbuLVXAfi7clzuY6H5/Wkckf5Yw8PeboD1oGoBLcY0CnrAzRN1POrVsnFD79iEu/9mHS8jfdTmP7izF6TbKI5rn3B0YLVh7ga7Xmm3KAjp+HLazQw2EeR7gXygJPOHbMS9iRHGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkViJdyT; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkViJdyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958376; x=1811494376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C4Hcg8eqtOzlbXPE2qDTzUfxxDPuBgJdEsENfF/+vU0=;
  b=QkViJdyTMHcQlOaIa2wozzMoEAFFeSvGFO3mgKxNN2Vh7YB6VrkkIh0K
   6PJ+9hak19YUPTFyriDQCTPe97Ptj/MuMcxHmg90C99+PJqRi7GjUJ9JZ
   Gr4s1HHd5bABQovXlXhfyubn6GV+khQGun6QYehhCzhhTVlm7BO+ohJz1
   t7ycwQ3hlTJhRa3QBDYfXSd+2c069YWImWBZ9zQ33xay76evHX5KA2ym2
   swHZbbUroO4BvVYxR4El5lmjYyxNHBr4zfLIKmgVkkf7saDDA7pJOHRk7
   HL7N3L7blNMR4Onq7Eu7dM/ufbe4a2EvMKNWrbMQJD9fYagK24L7RYiOO
   w==;
X-CSE-ConnectionGUID: jHohmHFcQ16Jjqi/huF/iw==
X-CSE-MsgGUID: WsIwlk6aQqmv4MIHIlSOEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80857253"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80857253"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:55 -0700
X-CSE-ConnectionGUID: cebmKMPiTN6hIvm/Jdl5ew==
X-CSE-MsgGUID: eB3Huer5Q5SQ4WwVHYXaJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244322510"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:51 -0700
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
Subject: [PATCH v3 11/15] KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_spte()
Date: Thu, 28 May 2026 16:12:47 +0800
Message-ID: <20260528081247.10380-1-yan.y.zhao@intel.com>
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

Arrange tdx_sept_remove_private_spte() (and its tdx_track() helper) to be
above tdx_sept_set_private_spte() in anticipation of routing all S-EPT
writes (with the exception of reclaiming non-leaf pages) through the "set"
API.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
-Made the patch log description more generic to match the diff. (Kai, Rick)
-Kept tdx_sept_free_private_spt() below tdx_sept_set_private_spte(). (Yan)
---
 arch/x86/kvm/vmx/tdx.c | 80 +++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 4ff5ae31eb66..47bd9e0f0135 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1724,23 +1724,6 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
-static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
-				     u64 new_spte, enum pg_level level)
-{
-	lockdep_assert_held(&kvm->mmu_lock);
-
-	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
-		return -EIO;
-
-	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
-		return -EIO;
-
-	if (!is_last_spte(new_spte, level))
-		return tdx_sept_map_nonleaf_spte(kvm, gfn, level, new_spte);
-
-	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
-}
-
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
  * tdh_mem_track() is the only caller that increases TD epoch. An increase in
@@ -1787,29 +1770,6 @@ static void tdx_track(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
 }
 
-static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, void *private_spt)
-{
-	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-
-	/*
-	 * free_external_spt() is only called after hkid is freed when TD is
-	 * tearing down.
-	 * KVM doesn't (yet) zap page table pages in mirror page table while
-	 * TD is active, though guest pages mapped in mirror page table could be
-	 * zapped during TD is active, e.g. for shared <-> private conversion
-	 * and slot move/deletion.
-	 */
-	if (KVM_BUG_ON(is_hkid_assigned(kvm_tdx), kvm))
-		return -EIO;
-
-	/*
-	 * The HKID assigned to this TD was already freed and cache was
-	 * already flushed. We don't have to flush again.
-	 */
-	return tdx_reclaim_page(virt_to_page(private_spt));
-}
-
 static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 					 enum pg_level level, u64 mirror_spte)
 {
@@ -1860,6 +1820,46 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
 }
 
+static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				     u64 new_spte, enum pg_level level)
+{
+	lockdep_assert_held(&kvm->mmu_lock);
+
+	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
+		return -EIO;
+
+	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
+		return -EIO;
+
+	if (!is_last_spte(new_spte, level))
+		return tdx_sept_map_nonleaf_spte(kvm, gfn, level, new_spte);
+
+	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
+}
+
+static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, void *private_spt)
+{
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+
+	/*
+	 * free_external_spt() is only called after hkid is freed when TD is
+	 * tearing down.
+	 * KVM doesn't (yet) zap page table pages in mirror page table while
+	 * TD is active, though guest pages mapped in mirror page table could be
+	 * zapped during TD is active, e.g. for shared <-> private conversion
+	 * and slot move/deletion.
+	 */
+	if (KVM_BUG_ON(is_hkid_assigned(kvm_tdx), kvm))
+		return -EIO;
+
+	/*
+	 * The HKID assigned to this TD was already freed and cache was
+	 * already flushed. We don't have to flush again.
+	 */
+	return tdx_reclaim_page(virt_to_page(private_spt));
+}
+
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector)
 {
-- 
2.43.2


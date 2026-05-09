Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18083355813;
	Sat,  9 May 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315815; cv=none; b=iRYEIrOwakd0P/v13Sj0KIx9DmGFZ91ZjpG+vPNHzBJUkN7D9u+8oOb3Btk5LaVCnjGh+hjbdESjOg1Afuy1MEbxyUyAe9n6bF7r5F0cb3XSTgKklu3UeJN19EYK9xKEnxL13kRr9vck2V9y7JQ7h+HP9Ra+kqvHVVyScLiZUyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315815; c=relaxed/simple;
	bh=2xIa4NP3fin8NYMgYIyqbZxBEs78HwYv0RuAhvdeaxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3LrUkId87MAhOx7a1fY9wJJ/ZyWAleHuN8hWmIKfkur8NUKS5wm6yhnT88w44SuVv6u0kZaiJjxhiu+mpNVDCHDUOTaovNzytiwlp7ce9OGDFl24sdVd1TD8QfqbiL76bC02GsbUkC1N94ByapHl0FKn1UsougBLFw9pinbkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LD6E1XUQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LD6E1XUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315814; x=1809851814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2xIa4NP3fin8NYMgYIyqbZxBEs78HwYv0RuAhvdeaxw=;
  b=LD6E1XUQNu95NVaQW1dNNLAy1oCY9L69pr4FDxeHDADWi6iqbfXCksEg
   8OaN3FlOZthoyJlCBfjqrvxeD6BXF53Ns2Y5Iyp4SwzvrS5va4wKNB/z6
   LqTeWAdNoEUVFsAFQmDrB5C2QzYULIySUs4mbrzjvhvJh6Uyu9tuQVnK4
   I5gEsI7lgljz96ZCr7dFcliEl3jmbtkDTsvmFwdtH/yY4Veh60Coy1dpE
   vzAoII/4RMDgo26mtNLagMph28OgXhrbG5acHxBm6uRP43W+3TJmxmY/v
   ptqQJVz5KenDpXo4oH2gFhDILH14CmJbKX5SP77UMfLOwOs6Fe898C0cP
   w==;
X-CSE-ConnectionGUID: pc/+IUL/T3S8AvPDuzLWgw==
X-CSE-MsgGUID: JduBUUwwSie1wCMXOBkwuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79306595"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79306595"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:54 -0700
X-CSE-ConnectionGUID: pDwcHvluSNesprpnTBJ50A==
X-CSE-MsgGUID: 0ykWu+d5Q/aJwhDx9QpMrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="230584771"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:36:50 -0700
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
Subject: [PATCH v2 11/15] KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_spte()
Date: Sat,  9 May 2026 15:56:58 +0800
Message-ID: <20260509075658.4306-1-yan.y.zhao@intel.com>
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

Arrange tdx_sept_remove_private_spte() (and its tdx_track() helper) to be
above tdx_sept_set_private_spte() in anticipation of routing all S-EPT
writes (with the exception of reclaiming non-leaf pages) through the "set"
API.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
-Made the patch log description more generic to match the diff. (Kai, Rick)
-Kept tdx_sept_free_private_spt() below tdx_sept_set_private_spte(). (Yan)
---
 arch/x86/kvm/vmx/tdx.c | 80 +++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 48aa7936a7f7..e40a999b0fb8 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1718,23 +1718,6 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
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
@@ -1781,29 +1764,6 @@ static void tdx_track(struct kvm *kvm)
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
@@ -1854,6 +1814,46 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
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


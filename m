Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17E13A1CFE;
	Fri, 27 Mar 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642481; cv=none; b=o6Ewgl0pppROnvgSuonAwxp2/ZVg5scM+aMWzJayFViPMBiT1N/pvxjzCgjny/LyU7+Y9S92ZSHYeGZq0rAhhxZ5ku2UApDnx8HTD0kKUqmp8850UpqqL128zv8gTHNL8e0lnzeoiPZXVLgTAevMseJ76VpsVNYrdh8+kTAuEoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642481; c=relaxed/simple;
	bh=y5zhtChgwlv3eiH5J0O5wuswIcXFvqqm2S9/NTTnENA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdTUdSYK8FSQnNvXJ0G0XJfXpJfqYfsChGpo8TcaCABxRTtN/9XZq8V9NZj1ra+OfJLOqD8CVoOIw5U323NR4CEfpkCpHPmKF4dKHJ2SW4LJUfT4YRJ1vtALAyiR7KKbLcokWA+koL0jhqQyKnI/plM2jSnKMPLX04llQXjsFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPiW9fBN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPiW9fBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642476; x=1806178476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y5zhtChgwlv3eiH5J0O5wuswIcXFvqqm2S9/NTTnENA=;
  b=BPiW9fBNBwglwZfkh0GHLXFJMhd/97Mb2a6iDhyni12U6tIt3RuQnWcE
   iD/ABrDsEi1wgUlwMzsCy4cU0adoamy2GggzCj7iu8qaKcIt5UxL2AN2p
   xH5YVlCkiM5CmP25IPSoQsASYAP1kOPVuzPA/a82CFXsXyln8KTlkAOGE
   yg8YxRtsauZoZQdcF+yWuw7uWj4YcHg6+oJfUlUNy6X0GMOz2YvfZhjvS
   Q9XGQAodgkT0wtQuk+5NTGU2basL55Lvkv1OBAnrG2u4e855NETa4//Af
   aOYO2P9z0FnTffJ+4jhUsF15PWgR+KshrDYRk23zp2WK3D7/dV9CcfeoW
   Q==;
X-CSE-ConnectionGUID: bG1I7xbbTRqFxk1BMe7l/w==
X-CSE-MsgGUID: TY1H2r5PSieZ/WV8dzb/Zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182754"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182754"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: 8Y0vP5NxSuWYDR6YBLX8VA==
X-CSE-MsgGUID: +8F0RnYCQxKNlfuiECAJ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922923"
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
Subject: [PATCH 12/17] KVM: x86/mmu: Plumb the old_spte into kvm_x86_ops.set_external_spte()
Date: Fri, 27 Mar 2026 13:14:16 -0700
Message-ID: <20260327201421.2824383-13-rick.p.edgecombe@intel.com>
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

Plumb the old SPTE into .set_external_spte() so that the callback can be
used to handle removal and splitting of leaf SPTEs.  Rename mirror_spte to
new_spte to follow the TDP MMU's naming, and to make it more obvious what
value the parameter holds.

Opportunistically tweak the ordering of parameters to match the pattern of
most TDP MMU functions, which do "old, new, level".

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/mmu/tdp_mmu.c      |  3 ++-
 arch/x86/kvm/vmx/tdx.c          | 18 +++++++++---------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1139bd89f0cf..808d2c7ea546 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1877,8 +1877,8 @@ struct kvm_x86_ops {
 			     int root_level);
 
 	/* Update the external page table from spte getting set. */
-	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				 u64 mirror_spte);
+	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				 u64 new_spte, enum pg_level level);
 
 	/* Update external page tables for page table about to be freed. */
 	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 85c92aec868f..991870789863 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -593,7 +593,8 @@ static int __handle_changed_spte(struct kvm *kvm, struct kvm_mmu_page *sp,
 	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
 	} else if (is_mirror_sp(sp) && is_present) {
-		r = kvm_x86_call(set_external_spte)(kvm, gfn, level, new_spte);
+		r = kvm_x86_call(set_external_spte)(kvm, gfn, old_spte,
+						    new_spte, level);
 		if (r)
 			return r;
 	}
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b44a9c96c89e..569a0576e7c9 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1690,16 +1690,16 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
 }
 
 static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				  u64 mirror_spte)
+				  u64 new_spte)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
+	kvm_pfn_t pfn = spte_to_pfn(new_spte);
 
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
 		return -EIO;
 
-	WARN_ON_ONCE((mirror_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
+	WARN_ON_ONCE((new_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
 
 	/*
 	 * Ensure pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory()
@@ -1719,18 +1719,18 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
-static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, u64 mirror_spte)
+static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				     u64 new_spte, enum pg_level level)
 {
-	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
+	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
 
 	lockdep_assert_held(&kvm->mmu_lock);
 
-	if (!is_last_spte(mirror_spte, level))
-		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
+	if (!is_last_spte(new_spte, level))
+		return tdx_sept_link_private_spt(kvm, gfn, level, new_spte);
 
-	return tdx_sept_map_leaf_spte(kvm, gfn, level, mirror_spte);
+	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
 }
 
 /*
-- 
2.53.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1522038C421;
	Sat,  9 May 2026 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315730; cv=none; b=a0ew/yezUlYHZCHRaDEfjVT6LrPINmwAbk7UDdWI3G8CkL4OhXZEXjltBSssgd5RzBod5O6TVHPNzh9ysxk8qjVW+9P1OK1yUl+GbGUvjq+EDBNeEdqf5KKp/fpdsUMBfR93BJ2/dxrvLkAQ4sK/C0wFT14Mx0RgQDmO5CPn2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315730; c=relaxed/simple;
	bh=vlTgTATwZiM8fcEvYsPleSFsO07nYNfjfqChI0OT0MU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtQCvhQaC+FjntntjTHTw7zo4EHbL1ZeY+KxLXUNZp9AUopr+3ZyAMvBZun42alNMoIIveA1gubYML4lc27lnySjOgRydWVlj1POo2kyjj0Fr4T9Xfp52szSs9XyWi7DtCegJ7r3wpxGkuwgY7LIV4v3aF9iYerynIHAVmtogVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7syGuDH; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7syGuDH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315729; x=1809851729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vlTgTATwZiM8fcEvYsPleSFsO07nYNfjfqChI0OT0MU=;
  b=a7syGuDHAUtV+Kd4TNpr/vZj2NqeIQUCT55o+cdpQTXf6AZknD3PbPtt
   REXtMZbIo83pMykNMk4m/ZY16tCo7M6v8BKaEZJkrmvXMljdhbEXtutbK
   QfYw6+Cz9tVL/U5h6S5gRiZb7vSAqgVEIIZrOSvaeZU9fDgDhPBS/aw0H
   yAU/Fub3p84HF8ATLM/yvXZpV9Mlw6a9oMg2EkQvZK2g4x8WWu50usUPD
   FJVGjrjhc42/M2xjKa9b9cbaJwU9LT05Ff+O8lRLz/xKsSA6p3D7oOllk
   KKTXUyrEG2zmfdXbgBlmweis+SGNXbG9T7GwfqVag+GFd1eTeDuBSeaIM
   Q==;
X-CSE-ConnectionGUID: BSox26yzRo6Jr0pVQ5lwRQ==
X-CSE-MsgGUID: RVe6ZJYDTqKqUMkRV0FlTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748327"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748327"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:35:29 -0700
X-CSE-ConnectionGUID: 9Nz6ykkKSOmTIz+1KomI+w==
X-CSE-MsgGUID: HBKpJHAdRzeCkWei+00LsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237086887"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:35:26 -0700
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
Subject: [PATCH v2 04/15] KVM: x86/mmu: Plumb param "old_spte" into kvm_x86_ops.set_external_spte()
Date: Sat,  9 May 2026 15:55:33 +0800
Message-ID: <20260509075533.4193-1-yan.y.zhao@intel.com>
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

If tdp_mmu_set_spte_atomic() triggers an atomic zap on a mirror SPTE
(though currently no paths trigger it), the change is propagated via the
set_external_spte() op. Plumb the old SPTE into the set_external_spte() op,
so TDX code rather than TDP MMU core can warn if the atomic zap isn't
allowed.

Rename mirror_spte to new_spte to follow the TDP MMU's naming, and to make
it more obvious what value the parameter holds.

Opportunistically tweak the ordering of parameters to match the pattern of
most TDP MMU functions, which do "old, new, level".

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Moved this patch to before dropping the warning of
  "KVM_BUG_ON(was_present, kvm)" in __tdp_mmu_set_spte_atomic(). So TDX's
  tdx_sept_set_private_spte() can later warn instead if atomic zap is
  propagated via the set_external_spte() op (as allowed by
  tdp_mmu_set_spte_atomic() if it occurs).  (Yan)
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/mmu/tdp_mmu.c      |  4 ++--
 arch/x86/kvm/vmx/tdx.c          | 22 +++++++++++-----------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 832323c4bc27..9b55973f194c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1892,8 +1892,8 @@ struct kvm_x86_ops {
 			     int root_level);
 
 	/* Update the external page table from spte getting set. */
-	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				 u64 mirror_spte);
+	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				 u64 new_spte, enum pg_level level);
 
 	/* Update external page tables for page table about to be freed. */
 	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index aa6b629a9799..ceb27769bcf6 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -632,8 +632,8 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 		if (!try_cmpxchg64(raw_sptep, &iter->old_spte, FROZEN_SPTE))
 			return -EBUSY;
 
-		ret = kvm_x86_call(set_external_spte)(kvm, iter->gfn, iter->level,
-						      new_spte);
+		ret = kvm_x86_call(set_external_spte)(kvm, iter->gfn, iter->old_spte,
+						      new_spte, iter->level);
 
 		if (ret)
 			__kvm_tdp_mmu_write_spte(iter->sptep, iter->old_spte);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 886e1eac23fa..219da92fe8ea 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1667,13 +1667,13 @@ static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
 }
 
 static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, u64 mirror_spte)
+				     enum pg_level level, u64 new_spte)
 {
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 	struct page *sept_pt;
 
-	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, mirror_spte, level);
+	sept_pt = tdx_spte_to_sept_pt(kvm, gfn, new_spte, level);
 	if (!sept_pt)
 		return -EIO;
 
@@ -1689,16 +1689,16 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
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
@@ -1718,16 +1718,16 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
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
 
-	if (!is_last_spte(mirror_spte, level))
-		return tdx_sept_map_nonleaf_spte(kvm, gfn, level, mirror_spte);
+	if (!is_last_spte(new_spte, level))
+		return tdx_sept_map_nonleaf_spte(kvm, gfn, level, new_spte);
 
-	return tdx_sept_map_leaf_spte(kvm, gfn, level, mirror_spte);
+	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
 }
 
 /*
-- 
2.43.2


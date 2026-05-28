Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01751388386;
	Thu, 28 May 2026 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958303; cv=none; b=VXCPOb2qERk6m+O+znqGC7jdvdWWGXfVjgwZBWjbb8HphM+Kme8x2CouA2/omIZyvzeuXRYly3ILsNTHON0MuwPd4n2KhMBRl5u0v/edt1nWeDxpR9Lz4bH+kidb+E8Q8fjaVk61PSV5BHByaoQQCfV3Lkbhr9lFwOsimjjs+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958303; c=relaxed/simple;
	bh=63SKONVqBiu7P5HylKFMiBVzYGqnH5AwvFZJ6uDYUYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GosdEf1KTAcyQEGjehrxjCriy2hnzueNaQQt1oUYOXvN+5RMOfOc7nO3hUCj/qJWuLkZLBAYF8N7IgpJ8pmUD/fosoS/HpNNDd/E2TTq6tMGXIzYnD3TQ70h/aFk/3XJ/UlX4b3yY60Iuq3AJs+hmnoCEkh7fm1xQ2QZHyvfHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NrqeIjmW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NrqeIjmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958302; x=1811494302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63SKONVqBiu7P5HylKFMiBVzYGqnH5AwvFZJ6uDYUYs=;
  b=NrqeIjmWDZklLpt3rGFNxV5cD2iJT+i++c0FkbK/U0wR2fLoDdD7vSxd
   vn8IEd9iMiBKnG+Z/vEyqxM0Ciau6zIkm57sbLhMD7Apx8OA4CNJqOrJs
   JV4lMAMSfey45S0WLGe1+bt3RQNGC8c7txEaeHwZKa+RVVAKFdC8uHWeD
   7yv/dC2/c2lugKZX/LdrjEB7Zdw5FSpf5RxCK0jYmdLwzOAjG0mao+bq8
   cVc4U5OfSTtergBUvIgh2Ll4ygOapvNMYKlNp9Tz/2CQkXZ/4p4smsLm8
   uyQGKlSuZCBD39v8PYAHiAkLd9AdTuD5gFe0Cbg6dPQcaGz233GKOLk9g
   g==;
X-CSE-ConnectionGUID: Rd8JnvQ9RmG2hz0acwWfnA==
X-CSE-MsgGUID: BguWuvmdQYK75dkzKVXrUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80765325"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80765325"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:42 -0700
X-CSE-ConnectionGUID: tvZ2y43KTtqKK31r7ptUiA==
X-CSE-MsgGUID: 30EYNkYUSKWsIc67S12vfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="280605195"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:33 -0700
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
Subject: [PATCH v3 04/15] KVM: x86/mmu: Plumb param "old_spte" into kvm_x86_ops.set_external_spte()
Date: Thu, 28 May 2026 16:11:29 +0800
Message-ID: <20260528081129.10268-1-yan.y.zhao@intel.com>
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
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

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
index 55ec998cc861..7710471a1c49 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1915,8 +1915,8 @@ struct kvm_x86_ops {
 			     int root_level);
 
 	/* Update the external page table from spte getting set. */
-	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
-				 u64 mirror_spte);
+	int (*set_external_spte)(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				 u64 new_spte, enum pg_level level);
 
 	/* Update external page tables for page table about to be freed. */
 	int (*free_external_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 128089571e34..4e961b331780 100644
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
index 9279f938987b..1da637204807 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1673,13 +1673,13 @@ static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
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
 
@@ -1695,16 +1695,16 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
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
@@ -1724,16 +1724,16 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
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


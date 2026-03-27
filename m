Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53FB38F920;
	Fri, 27 Mar 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642471; cv=none; b=rixgUGpBJPy+EeaCrpivuUcueK8HwUWSpDNWDnkk0zaPAQ7BtCvSAjzy2/llzCPXVnLZthDRTmGmnoHQ6wcpUoPgtY+0PPwEIu7NKGRamHKCfPh5N4eofwA2cIqgEyDfo0Kkn0jhrqzsZPqCTB+BHB2diwRosyb6NeYm2NGabo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642471; c=relaxed/simple;
	bh=KZ29c+Xij5yE1To66xjc1dFL0PHNiCMisEfZHw5vQ8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUO/ZT8F4/4sEFla0qqpoXgj9EJq0zncSGX1BN/66SJ+rPXGFrarcfdHDmA06jPn8DQeMK45psdwAfHnRh/G6DlBB8y3qJKCwCScvQYxlYRznYeWEnCsRPhIoTYiSXovlU9UHPI2u3haRGzxiyAdjz+rbyFFSnrJbszSU1LxkXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNMTH1FS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNMTH1FS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642470; x=1806178470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KZ29c+Xij5yE1To66xjc1dFL0PHNiCMisEfZHw5vQ8E=;
  b=JNMTH1FSZ2wQWdjfSZ/jiqndLQ8A9yyb0if6sy5x14wqPYbSjR4DVGTx
   jXkLMaJR5og7MM3ghjXv2boa38WuxUzZZ3acmlVfVm+CmDaHKFKRhnfbk
   c6n+4kjyldyP2hdlbnrJVPszFc14DDktP3RSjp/SKLSYTHRx0i9pbcqfS
   9gLaxwJf5pqZ/01wOgiP9islRQPm8YNy4EMYoAIiQK0slOxMojelQdB8Y
   2a3P+gCkamRkGRQQTl8ed58dZFF9/xApTGB/ZdWJz32jL09AWvvwNqaKA
   OsmeGqEp1JAn2InH6aaJMojdCQa8dT/7Kd8u3KmYCWdmaPY+1vlBGNfKx
   A==;
X-CSE-ConnectionGUID: dhvXJfOLQxOa8cASLXL9PA==
X-CSE-MsgGUID: sf9m6lKGTFSFYjaZy4TZKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182712"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182712"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:27 -0700
X-CSE-ConnectionGUID: 215oYJdZR/6lUS3+TVr3ww==
X-CSE-MsgGUID: hbI4H9p1StyYFS+ztpxWLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922892"
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
Subject: [PATCH 02/17] KVM: x86/mmu: Update iter->old_spte if cmpxchg64 on mirror SPTE "fails"
Date: Fri, 27 Mar 2026 13:14:06 -0700
Message-ID: <20260327201421.2824383-3-rick.p.edgecombe@intel.com>
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

Pass a pointer to iter->old_spte, not simply its value, when setting an
external SPTE in __tdp_mmu_set_spte_atomic(), so that the iterator's value
will be updated if the cmpxchg64 to freeze the mirror SPTE fails.  The bug
is currently benign as TDX is mutualy exclusive with all paths that do
"local" retry", e.g. clear_dirty_gfn_range() and wrprot_gfn_range().

Fixes: 77ac7079e66d ("KVM: x86/tdp_mmu: Propagate building mirror page tables")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7b1102d26f9c..dbaeb80f2b64 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -509,10 +509,10 @@ static void *get_external_spt(gfn_t gfn, u64 new_spte, int level)
 }
 
 static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sptep,
-						 gfn_t gfn, u64 old_spte,
+						 gfn_t gfn, u64 *old_spte,
 						 u64 new_spte, int level)
 {
-	bool was_present = is_shadow_present_pte(old_spte);
+	bool was_present = is_shadow_present_pte(*old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	int ret = 0;
@@ -525,7 +525,7 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
 	 * page table has been modified. Use FROZEN_SPTE similar to
 	 * the zapping case.
 	 */
-	if (!try_cmpxchg64(rcu_dereference(sptep), &old_spte, FROZEN_SPTE))
+	if (!try_cmpxchg64(rcu_dereference(sptep), old_spte, FROZEN_SPTE))
 		return -EBUSY;
 
 	/*
@@ -541,7 +541,7 @@ static int __must_check set_external_spte_present(struct kvm *kvm, tdp_ptep_t sp
 		ret = kvm_x86_call(link_external_spt)(kvm, gfn, level, external_spt);
 	}
 	if (ret)
-		__kvm_tdp_mmu_write_spte(sptep, old_spte);
+		__kvm_tdp_mmu_write_spte(sptep, *old_spte);
 	else
 		__kvm_tdp_mmu_write_spte(sptep, new_spte);
 	return ret;
@@ -670,7 +670,7 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 			return -EBUSY;
 
 		ret = set_external_spte_present(kvm, iter->sptep, iter->gfn,
-						iter->old_spte, new_spte, iter->level);
+						&iter->old_spte, new_spte, iter->level);
 		if (ret)
 			return ret;
 	} else {
-- 
2.53.0


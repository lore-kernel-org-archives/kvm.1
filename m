Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392738BF62;
	Thu, 28 May 2026 08:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958399; cv=none; b=SEZ9xYz3Y8jbUhAclUfX2C3SMuOBWCopIR2esHUebLdu4AfOT2HFEnBctCjMEJGwzmMl87IE1E8bHjKSryXJBjZAqU3ZqYAisCNYYi2CxIgJntSjO7n20kGWVdSOqfyHiGkjGJETOeS7T7pzpUfnkQDI+xwsDGkJZNjFp4ycoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958399; c=relaxed/simple;
	bh=f+wBwykfBdKW+Bz4u5OUYmH9iwXQcglhyZuxElXSYvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8Q7XUGYUO09kh+jK8vUMYNfZWY9N2Ob0IemYekgMUU6ZjjYWb9uRQFdyCqrlIy7raBCcsDl1rcf1YIWHFFlxuEVp0yMVFeLdrksclqiMzK5iFHQUG/9gGR6BwMaeUxx9tRaZQWlPGPT8DmYIOqJTRvFqnDJp/CLrmOImpc1DDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuHr+l/i; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuHr+l/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958397; x=1811494397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f+wBwykfBdKW+Bz4u5OUYmH9iwXQcglhyZuxElXSYvU=;
  b=PuHr+l/iZkTpNFA8h3fmIWNZRulKn9EF3FEFpIKY+yyOhuxh/BLK9Ath
   eLviP5wMRwUR4GmOV0xlA0TPHNbl/4wOCaoEgNmitq32/vw6dGP3W/U2i
   eQ70uWGCfS2CgNBUhFJbdrvptM/Sxe0jjRwTiPfqyqrgdiNWeQkOR/N9n
   voHgm0sjuMa8bUGpjrc3zO6BeiaZWYTRVsvkxF8XTUNAdOVzyIsr/GQh/
   5YD6pybJo6NL13qdrt/UU9T7oNz5ouAvK5Yfnk9lChZrC03IOEe5zRUUb
   qYDtv5BGCWJbAeLFpU54Rf97frbObj2QQ6AqouwoSXE6NpTRSh1Rc0rqy
   A==;
X-CSE-ConnectionGUID: K8gCZkMlQx2v0uHu6ki2Zg==
X-CSE-MsgGUID: eo162IlJRzeij58QcjelCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103469716"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="103469716"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:17 -0700
X-CSE-ConnectionGUID: Cl5KX5k/TcOo5nNRJ2xsvg==
X-CSE-MsgGUID: Dg4R5X/QRV6F/+bS7dtBdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="238312160"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:53:13 -0700
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
Subject: [PATCH v3 13/15] KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for leaf SPTEs
Date: Thu, 28 May 2026 16:13:09 +0800
Message-ID: <20260528081309.10412-1-yan.y.zhao@intel.com>
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

Rename tdx_sept_remove_private_spte() to tdx_sept_remove_leaf_spte() to
clearly show that this function is for removal of leaf SPTEs.

No functional change intended.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- New patch.
---
 arch/x86/kvm/vmx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 68d9deae3a2d..a385cfa56e4c 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1770,8 +1770,8 @@ static void tdx_track(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
 }
 
-static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
-					enum pg_level level, u64 old_spte)
+static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, u64 old_spte)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	kvm_pfn_t pfn = spte_to_pfn(old_spte);
@@ -1844,7 +1844,7 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 	lockdep_assert_held(&kvm->mmu_lock);
 
 	if (is_shadow_present_pte(old_spte))
-		return tdx_sept_remove_private_spte(kvm, gfn, level, old_spte);
+		return tdx_sept_remove_leaf_spte(kvm, gfn, level, old_spte);
 
 	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
@@ -2845,7 +2845,7 @@ void tdx_flush_tlb_current(struct kvm_vcpu *vcpu)
 void tdx_flush_tlb_all(struct kvm_vcpu *vcpu)
 {
 	/*
-	 * TDX has called tdx_track() in tdx_sept_remove_private_spte() to
+	 * TDX has called tdx_track() in tdx_sept_remove_leaf_spte() to
 	 * ensure that private EPT will be flushed on the next TD enter. No need
 	 * to call tdx_track() here again even when this callback is a result of
 	 * zapping private EPT.
-- 
2.43.2


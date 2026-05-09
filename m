Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8091345CAB;
	Sat,  9 May 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315741; cv=none; b=Wr8z3UFdv65bMJpGNgYfvfyDmO10+Anf4GYqqdVzgPotkxHdYdwPlkNbSnOnwaDXKnMfSAk79y/a49LsClfwNj5csSviYEFev3bdlhzpo0sQVGjb8AHM58xP3kq0Gqn3v+7JeKr4nBZMLLs7Sl9TRq4tRSqXQZAa39U1iWl9Ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315741; c=relaxed/simple;
	bh=1vfdBKn7/QQ7AqLbsv1Df8yInVJjjwRjwAhZQBF6wak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYG3Aw0tg9kH1x6o6sk4N/19Y9Cq4PE3rJcW40KS7HcaOHDF0PS8RM/PNHBq9imfA67VZCW0prTI+DusLQFqQfrg9XYXZ20jOsHkFbxaWt+3VUv+kMHmxWBZ7CAEMhH+peTOwYzWHbZzQJC7wJUDShzOmI3+VwHcPereOpvkNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIDEldud; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIDEldud"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315740; x=1809851740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1vfdBKn7/QQ7AqLbsv1Df8yInVJjjwRjwAhZQBF6wak=;
  b=NIDEldudww5jldJsleEEAm+S0jqjBh2vfoqdVTYt0P8vpoFKzAudYcwF
   RpoJAMrnI7FXzOSr43SuHbDErGQkjiFZq6zyZavPLl1fKgycLqV6OEZ04
   JwhPS0TJTlwoe/rw6AV1C60YShQYjW0A6rWf77MeVEe3Czr7Aq0HYFG2I
   YXeALWgT91VVvLsdUrtaWbkoUbK9IGLzqiOQ57FR2bsqyih9mTg9A1h6D
   hdhrW7tQ/SpisrbXI2VER+9E6ShZgSV82YbxMa+Ow7YjvZ6w1c0uEPjKi
   oHG7rVqrHpIOQDNNi4obSdif1M/jDT8KYy75MeKghdGC3S7ZYII0xi4H8
   Q==;
X-CSE-ConnectionGUID: RQ4TnyzxSbuDDGmcJXsrVg==
X-CSE-MsgGUID: cNoNqPK1RquKfYANlZfPcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="90748334"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="90748334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:35:40 -0700
X-CSE-ConnectionGUID: o5cKGYFkT3mn83IrRBPCoA==
X-CSE-MsgGUID: K6sCxxJERzyzNCzhkBh+4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="237086905"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:35:37 -0700
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
Subject: [PATCH v2 05/15] KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX code
Date: Sat,  9 May 2026 15:55:44 +0800
Message-ID: <20260509075544.4210-1-yan.y.zhao@intel.com>
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

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

Drop some KVM_BUG_ON()s that are guarding against TDP MMU attempting to
propagate unsupported changes to the external page table through
__tdp_mmu_set_spte_atomic(). Have TDX code trigger them instead.

Now that TDP MMU logically allows propagating atomic zapping operation to
the external page table through the set_external_spte() op in
__tdp_mmu_set_spte_atomic(). TDX code will trigger the KVM_BUG_ON() on the
atomic zapping request instead. (Note: non-atomic zapping is not propagated
via the set_external_spte() op yet).

Despite the generic naming, external page table ops are designed completely
around TDX. They hook the bare minimum of what is needed, and exclude the
operations that are not supported by TDX. To help wrangle which operations
are handleable by various operations, warnings and KVM_BUG_ON()s exist in
the code. These warnings and KVM_BUG_ON()s put the burden of understanding
which operations should be forwarded to TDX code on TDP MMU developers, who
often read the code without TDX context.

Future changes will transition the encapsulation of this domain knowledge
to TDX code by funneling the external page table updates through a central
update mechanism. In this paradigm, the central update mechanism can
encapsulate the special knowledge, but will not have as much knowledge
about what operation is in progress.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Moved this patch after "KVM: TDX: Drop kvm_x86_ops.link_external_spt()"
  and "KVM: x86/mmu: Plumb param "old_spte" into
  kvm_x86_ops.set_external_spte()".  (Yan)
- Added a replacement KVM_BUG_ON() in TDX for the dropped
  KVM_BUG_ON(was_present, kvm) in __tdp_mmu_set_spte_atomic(). (Yan).
---
 arch/x86/kvm/mmu/tdp_mmu.c | 10 ----------
 arch/x86/kvm/vmx/tdx.c     |  3 +++
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index ceb27769bcf6..f55967f8d74a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -610,20 +610,10 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
 	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
-		bool was_present = is_shadow_present_pte(iter->old_spte);
 		int ret;
 
-		KVM_BUG_ON(was_present, kvm);
-
 		lockdep_assert_held(&kvm->mmu_lock);
 
-		/*
-		 * Users of atomic zapping don't operate on mirror roots,
-		 * so don't handle it and bug the VM if it's seen.
-		 */
-		if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
-			return -EBUSY;
-
 		/*
 		 * We need to lock out other updates to the SPTE until the external
 		 * page table has been modified. Use FROZEN_SPTE similar to
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 219da92fe8ea..0ded336fbf70 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1721,6 +1721,9 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 				     u64 new_spte, enum pg_level level)
 {
+	if (KVM_BUG_ON(is_shadow_present_pte(old_spte), kvm))
+		return -EIO;
+
 	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
 
-- 
2.43.2


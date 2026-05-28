Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CC38B157;
	Thu, 28 May 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958307; cv=none; b=SjI0QconOm2z4QR4PY2SkJLOHxh2imdD0xbp1g1mP5/J3x8UBXr5Qt/adJaX96dSYDh9gQgz4OjwyiM8mChwwURW9yXJ3oqE+sGwpMTY+aes5/QoKa+VqHk988U061MFyCoOrXbyxQzThbHuKHOq1++MaqvrO4un+nxwNjkcok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958307; c=relaxed/simple;
	bh=fvjGwyJiJciHSi8GUWc6P9JcR4Q4R2mZ1lNLtK1XAVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OF9ojWRGpLPvH0byx87HXfrAb6BPUhW+BKN0ZiuEA7w2rIINSxfdko8RmLoFSTkgkw5DGzOT55XY86Ea7ChbBAV8/WMvBLs55omOwHzG6tdVYO3kNuPyvLbEwmTwXh1uHIQM9jG3ZOOYZLGSijC9qNQ+LexF2ZG7B29xV1nPdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9wijnmw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9wijnmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958307; x=1811494307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvjGwyJiJciHSi8GUWc6P9JcR4Q4R2mZ1lNLtK1XAVg=;
  b=R9wijnmwu9gVkpTCDlGVLq5JDapEYKrIn/TSG2vufA26E7wZkKOhGxaO
   SgvkTfe3GhAT9hIKKsLESKOLeNf8R8Tl4Yu5chWcG330XAB2NUsbPvntd
   svWxpR+bwqfEaGQMv5X9VVXMGuTY2BtyiBbte2Erf/27biZNTpS6gx0op
   eId1cmL0XfN5zB++Qwsxco8J8CShiD9ixh0BMBqyUD3wzAEi1AmjXVHpx
   Bk48PTbcdcqyOKnc0rSR0rYhqYhhOK8lNP9uG3VMwnsBZ2SDdOKqKroDR
   jKfSehquKeat7exxmnGLHEp7rbA+TWYsjxHIl83APqweJ8XRch8WYTgur
   w==;
X-CSE-ConnectionGUID: CIfpGif7Sp+bq8jBZFGMkw==
X-CSE-MsgGUID: rhUcXiruSa+/F5Crh9H+hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80765338"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80765338"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:47 -0700
X-CSE-ConnectionGUID: 30+y9CNCToSOzhWJcSexIQ==
X-CSE-MsgGUID: kYQks4b9RPCjfuGoMRb/MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="280605209"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:43 -0700
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
Subject: [PATCH v3 05/15] KVM: TDX: Move KVM_BUG_ON()s in __tdp_mmu_set_spte_atomic() to TDX code
Date: Thu, 28 May 2026 16:11:39 +0800
Message-ID: <20260528081139.10284-1-yan.y.zhao@intel.com>
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
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

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
index 4e961b331780..ed806a4768c2 100644
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
index 1da637204807..e8eab25f3159 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1727,6 +1727,9 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
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


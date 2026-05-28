Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D142379980;
	Thu, 28 May 2026 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958366; cv=none; b=jReYmFf2OljREBdNeC/m6x8Pa+azMWWe0TNNV3EN4ZuPQOi03/7fQuG0LBZUVksCsZzpebJHHQw/Tv0ES1RZcnFEVjQJrNTVpNXZIRIn/uO76LuprjNE7PhMY1u9dJgfJ16QJiR1BxvCfqveHKMWP5IdKUdPDu9L+wEVLCkgLyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958366; c=relaxed/simple;
	bh=jFOSGnttzw3tQKJ6J5u97lLWf7eG7FMLgh8tBvTHJNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlkXI9ElThb9xIkJ5eaFTKbp9vG5x8tKcjw3p5J6IIIOt7jby1g6215pSN/m0HnVDqclFqk6uluZuulOGvjHSelNx4K+IilUsSiJV/Tv5806aXMv9UGYRIKvIH5lZFkTvzzxzwpCEU042TNMx2JolTKFsZdVexPlLK2ffk7SI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dz41IEWJ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dz41IEWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958365; x=1811494365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jFOSGnttzw3tQKJ6J5u97lLWf7eG7FMLgh8tBvTHJNU=;
  b=dz41IEWJlFgG6TJCCpXk04mSLd+leSwdcuSnQ2mnFdDab0oTUD9oRJwS
   nQGubfNhsLRvo3DRhypNLGsqIEycthjMvZc6Cqkpf1bdX7Xj8446fOTOU
   ZfuGR01U3LEBhL2Qn/D0sqeJUVlLBf8YfKeN+FfUgkTaN0N8hT+G2K45H
   SUXVR/a4jX3BWSfa5dg50EM2SklU5u1ZPz5fQsycz/g+LDlunfn2RRJMI
   eko2/vNUqLB+1/VapL9OmeZtBVOns0R/HwmYTx1tfRxZKeeLYME9xA07c
   pSUNJE9BJq45pDUtss6/bekgVJ9M9W2n3y5OOlOjCfPb0SJv9qvULy9gC
   w==;
X-CSE-ConnectionGUID: oUqFkDX2S8qOQ6byTsd9NA==
X-CSE-MsgGUID: zTQRaJusSQGNzh/zrEsZDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80857227"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80857227"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:44 -0700
X-CSE-ConnectionGUID: aXRXvZkSQWSHy+cVtsDzEw==
X-CSE-MsgGUID: nazX+xMPQFmJD7zl8Lp73g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244322456"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:40 -0700
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
Subject: [PATCH v3 10/15] KVM: x86/mmu: Drop KVM_BUG_ON() on shared lock to zap child external PTEs
Date: Thu, 28 May 2026 16:12:37 +0800
Message-ID: <20260528081237.10364-1-yan.y.zhao@intel.com>
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

Drop the KVM_BUG_ON() in the KVM MMU core before zapping child external
PTEs, since requiring zapping PTEs to be protected by exclusive mmu_lock is
TDX's specific requirement.

No need to plumb the shared/exclusive info into the remove_external_spte()
op or move the KVM_BUG_ON() to TDX, because
- There's already an assertion of exclusive mmu_lock protection in TDX.
- The KVM_BUG_ON() is a bit redundant given that if there's any bug causing
  zapping of leaf PTEs in S-EPT under shared mmu_lock, SEAMCALL failures
  due to contention would result in TDX_BUG_ON() in TDX.

Link: https://lore.kernel.org/kvm/aYUarHf3KEwHGuJe@google.com
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- Updated commit log and title. (Yan)
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3c3e73ce8da9..3ba7556a8d2f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -473,10 +473,8 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 		}
 		handle_changed_spte(kvm, sp, gfn, old_spte, FROZEN_SPTE, level, shared);
 
-		if (is_mirror_sp(sp)) {
-			KVM_BUG_ON(shared, kvm);
+		if (is_mirror_sp(sp))
 			remove_external_spte(kvm, gfn, old_spte, level);
-		}
 	}
 
 	if (is_mirror_sp(sp) &&
-- 
2.43.2


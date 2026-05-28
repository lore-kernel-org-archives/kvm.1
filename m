Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3A37F015;
	Thu, 28 May 2026 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958331; cv=none; b=e3qA749w9F2W7PLeAZsXMtR/xwhymm5iMmIytsbWLNi+ALq2/YhbDv+tCF/87RQrOUb3cmSkrl705XNEJRTIq6QXznqxG2kS6fnE3XldC3xxJ0dkcFkeuCbbgWNLmac5zemoKRugftbuRSOZ5DsvOuY8rAl2oYv7fzRk1oHfA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958331; c=relaxed/simple;
	bh=9ibY6C45q3jxud6+X63hzk2/wcxR9JuzN7Qnh/MaQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aIo4x1TLC+5RL/e25/8NiBlEnen9R1DsEyydXGLu52WrNaff2TLscOz2AGZBTfHVlR6L7WMlw7kJrv2QJSFEU1APoE7s2UsgoxWLjfYdT7JDTOp/nvCoKImTFYvgL2k4v1K+s+1qacoyN1PxLxHAdoUnQmddYjcrh3dKykpmofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n778P+Le; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n778P+Le"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958330; x=1811494330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ibY6C45q3jxud6+X63hzk2/wcxR9JuzN7Qnh/MaQ5Y=;
  b=n778P+LeiZprpyTk+Q3Kdo43QIE+MuIzzSwXqmJwORQxLof1TIX6Pbn7
   5ND7q2dptrftlBoHkIxJvIlj6vmCfswwX4OI8fcUljIAxN1++q8GIPQtW
   Y3o43ENhP2NT8KlpuNOCuGLWs+XZzY/Dc4uFDweRoQfOLuuoxitwY33Wo
   VkTYzsOxa8wH2YqdkTiwTNnF8ftSmKdq4ulof334+1u+GumSjdCc/Vakq
   9/PkdYtBAi4TH1Ez4EG4L249gBDcuehyLEfFm4yigySdUaA6F2SAq0CpO
   68bG22o0hr/nqxs4otswSr99Jt9LqHz32ehPtYMnEZBKTNHZdmEQ4U7/c
   Q==;
X-CSE-ConnectionGUID: QNm6nYEGR/uNXfK+ao24EQ==
X-CSE-MsgGUID: bvQe8qngRqONiEm25V0daw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80857162"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80857162"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:10 -0700
X-CSE-ConnectionGUID: dcHZ1ZH5SQyBjmwCG9lCCQ==
X-CSE-MsgGUID: FsmmdFJkSYmgXvNT9/wqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244322356"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:52:06 -0700
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
Subject: [PATCH v3 07/15] KVM: x86/tdp_mmu: Morph !is_frozen_spte() check into a KVM_MMU_WARN_ON()
Date: Thu, 28 May 2026 16:12:02 +0800
Message-ID: <20260528081202.10316-1-yan.y.zhao@intel.com>
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

Remove the conditional logic for handling the setting of mirror page table
to frozen in __tdp_mmu_set_spte_atomic() and add it as a warning for both
mirror and direct cases.

The mirror page table needs to propagate PTE changes to the external page
table. This presents a problem for atomic updates which can't update both
page tables at once. So a special value, FROZEN_SPTE, is used as a
temporary state during these updates to prevent concurrent operations on
the PTE. If the TDP MMU tried to install FROZEN_SPTE as a long-term value,
it would confuse these updates.

On the other hand, it would also confuse other threads if FROZEN_SPTE is
installed as a long-term value for direct page tables (e.g., causing
another thread working on atomic zap to wait for a !FROZEN_SPTE value
endlessly).

Therefore, add the warning for installing FROZEN_SPTE as a long-term value
in __tdp_mmu_set_spte_atomic() without differentiating whether it's a
mirror or direct page table.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- Updated the comment for "KVM_MMU_WARN_ON(is_frozen_spte(new_spte))".
  (Yan)
- Explained why the warning also applies to direct page tables. (Yan)
---
 arch/x86/kvm/mmu/tdp_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index dc455e6e7dc7..b30e33dea265 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -609,7 +609,10 @@ static inline int __must_check __tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 */
 	WARN_ON_ONCE(iter->yielded || is_frozen_spte(iter->old_spte));
 
-	if (is_mirror_sptep(iter->sptep) && !is_frozen_spte(new_spte)) {
+	/* Should not set FROZEN_SPTE as a long-term value. */
+	KVM_MMU_WARN_ON(is_frozen_spte(new_spte));
+
+	if (is_mirror_sptep(iter->sptep)) {
 		int ret;
 
 		/*
-- 
2.43.2


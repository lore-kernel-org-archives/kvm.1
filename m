Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D039C638;
	Fri, 27 Mar 2026 20:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642475; cv=none; b=S3cxEEU6kXmMVEXxmnii4MGGOSNdqWYgb2Z+PFWfWk8oFlVfhLVjOKP7rof96MFbJt6SCowb8ZWzUhPNlZtKFhEDxZM1k5J/JzFeMZFI1pocYLkrEpnFH13ZXU9TxDOUA52srHUB70qsPhfGuJ1/m3eYLbRV5snZB4pkLlkj674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642475; c=relaxed/simple;
	bh=o1Q8ttR2x41qOPRYX1OHKMYlMC04w5fXUFCmeYTDCcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzUQbE4QwHO5w55s98u8oIrkXDgagATqrmsUhKDcjHCX1K4vOpU2nedhRxFdK/nDPqbg3JmV46PwOCfhz7yBz8+ug83vvuWI32wEfGnMHI6pkd4B6upHnkIK1K/A3O3/Ku1l4RgTQc5pJTSP1HEQWYChCoObHNUEVStmdw1huUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQnGKb4x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQnGKb4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642473; x=1806178473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o1Q8ttR2x41qOPRYX1OHKMYlMC04w5fXUFCmeYTDCcU=;
  b=RQnGKb4x/ktjhktIUz8HGh0bJcqoJ+rgjHyYASqsZ0L+kznBuiMjv/7l
   sZDTrl84HIFirtdnBCRvOCf+VQIPS7z7BEiytbX8MeiRtYnXXd3W1JGA3
   Liqc3EOSqQHsmP5FH+PmMU7eFpOUseCGfMCTL6seNCMr0uTVRucApk2s0
   gFWqZQLuvcfB9EbsbbCum0TwF6oelQPifUtC74fX39Z0tEp1EEBVFukl6
   jJSSpnbagtPSmRHWwTUtF9iKU+KPChwLNA0hXtgbRzau7OLFGJT4ZZivd
   VdhWDvbuVYTWn2Td4a/uBE/+Jiuqil0bmLtyIrkXPbvhD8qsnkFpBZzQi
   A==;
X-CSE-ConnectionGUID: P/8tceXDS/CNg7aXvIeeCA==
X-CSE-MsgGUID: L/4W5+LITuWCEwKgM/efWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182747"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182747"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: LmECI2IrT02QNWD8ZA7SbA==
X-CSE-MsgGUID: RnLEZ4oWTASK2BdYFw8gEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922913"
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
Subject: [PATCH 09/17] KVM: TDX: Add helper to handle mapping leaf SPTE into S-EPT
Date: Fri, 27 Mar 2026 13:14:13 -0700
Message-ID: <20260327201421.2824383-10-rick.p.edgecombe@intel.com>
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

Add a helper, tdx_sept_map_leaf_spte(), to wrap and isolate PAGE.ADD and
PAGE.AUG operations, and thus complete tdx_sept_set_private_spte()'s
transition into a "dispatch" routine for setting/writing S-EPT entries.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 92a846b91bac..361a75b42ae7 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1689,18 +1689,12 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
 	return 0;
 }
 
-static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
-				     enum pg_level level, u64 mirror_spte)
+static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level level,
+				  u64 mirror_spte)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
 
-	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
-		return -EIO;
-
-	if (!is_last_spte(mirror_spte, level))
-		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
-
 	/* TODO: handle large pages. */
 	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
 		return -EIO;
@@ -1725,7 +1719,18 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
+static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, u64 mirror_spte)
+{
 
+	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
+		return -EIO;
+
+	if (!is_last_spte(mirror_spte, level))
+		return tdx_sept_link_private_spt(kvm, gfn, level, mirror_spte);
+
+	return tdx_sept_map_leaf_spte(kvm, gfn, level, mirror_spte);
+}
 
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
-- 
2.53.0


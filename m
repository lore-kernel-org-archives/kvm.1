Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE238B7D8;
	Sat,  9 May 2026 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315698; cv=none; b=BbUlNF3Cd6yEx+ahV82Jhk1TK3knxyMih1B4amWd8sncYsyJmAcMpv2/nvumpaNM3IdIE0dCCNRKt7NrLbpkMdJdvxb2Co/D/uofMjFZhlpltaWSpOPnRqkUyam2297ewlTIyDHG31YfA0jW7mtFBQZmrTrvjA6f/ZHvwtDMBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315698; c=relaxed/simple;
	bh=948v69K4cg1s0/25JUAvNhe+5Im4e7PMOuDEKHNB4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vC4WrwyYEnOES7yy1QVadB/O4wMscl927rtVlXgvvbC51M1IzoCI5zOBXrjq/2u9omU+dhPluzVHC5zuGSZnUh3XdOMHJL0Y+xbE5qwjgqaJwEhotKWxSNx34h6YPa2k1lydUYAGxXN/EdbQdCFwmOHgYbk8J1SY5jVwKD+hevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmKrQPB/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmKrQPB/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315697; x=1809851697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=948v69K4cg1s0/25JUAvNhe+5Im4e7PMOuDEKHNB4+A=;
  b=KmKrQPB/nHGdST7S7e0CxmlNQqnoTv7C6g9lbKAqBBbl9nKzB1doSQd5
   5wJ+ym4WwxbiP9a0ycHPt8wagKc3L0z6SGMJxcOgAGYzG8C8vvaEyQQCw
   M+zcshengvlSoj9+CstQUVarjA6TxrPJ9AQex/C7J9Cu0zk2nLqvb/oWq
   VDw5EVvvq9CpVRqCu8U99HVsM0a5v8KN9Tqhz9lCp5hSqF8cq/vqVuKJP
   tFy60l8t8Zh2VEpDCYkg9n0XP3q1tLeIEROqCnkqc71iDfkt/QoCvZnQX
   btsYvgLO7NQvCDU700XzR2zwfQhv1ekZJQs5sp2pe6SEiNbqclj66fwxw
   Q==;
X-CSE-ConnectionGUID: a5z25lNZQKmm4qK1KaH5ow==
X-CSE-MsgGUID: YTQ6VvFZSBGxB2lZXViXXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79464319"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79464319"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:34:56 -0700
X-CSE-ConnectionGUID: zuFfFuxHRgWqVNl+3LHXYw==
X-CSE-MsgGUID: CYTiLoIRS7GR7OGQKp8nwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="260706066"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:34:53 -0700
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
Subject: [PATCH v2 02/15] KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into helpers
Date: Sat,  9 May 2026 15:55:00 +0800
Message-ID: <20260509075500.4157-1-yan.y.zhao@intel.com>
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

Add a helper, tdx_sept_map_leaf_spte(), to wrap and isolate PAGE.ADD and
PAGE.AUG operations. Rename tdx_sept_link_private_spt() to
tdx_sept_map_nonleaf_spte() to wrap SEPT.ADD for symmetry.

Thus, transition tdx_sept_set_private_spte() into a "dispatch" routine for
setting/writing S-EPT entries.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- Renamed tdx_sept_link_private_spt() to tdx_sept_map_nonleaf_spte(). (Yan)
---
 arch/x86/kvm/vmx/tdx.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 48c836ec6063..886e1eac23fa 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1666,7 +1666,7 @@ static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
 	return virt_to_page(sp->external_spt);
 }
 
-static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
+static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, u64 mirror_spte)
 {
 	gpa_t gpa = gfn_to_gpa(gfn);
@@ -1688,18 +1688,12 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
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
@@ -1724,6 +1718,18 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
+static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, u64 mirror_spte)
+{
+	if (KVM_BUG_ON(!is_shadow_present_pte(mirror_spte), kvm))
+		return -EIO;
+
+	if (!is_last_spte(mirror_spte, level))
+		return tdx_sept_map_nonleaf_spte(kvm, gfn, level, mirror_spte);
+
+	return tdx_sept_map_leaf_spte(kvm, gfn, level, mirror_spte);
+}
+
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
  * tdh_mem_track() is the only caller that increases TD epoch. An increase in
-- 
2.43.2


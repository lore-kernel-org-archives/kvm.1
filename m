Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81B3ACF1B;
	Mon, 28 Sep 2026 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586702; cv=none; b=gt9Oqbua/hUA93frtwk37X93/2zxrDAEKfBrGVU07t8x9Sk94nTYc6C0pdl0vJ2OrvPGPHbXbZzdSYvnKxB5MU1QJRZtlQCPA06P9IVm2sAQuDrLKrsTPgjwAS4Sb/4L5YNhxr7W3fPwAzmfPxawapXP4f0HTbL9a4nxeLUBkJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586702; c=relaxed/simple;
	bh=GvJMxRCWJr2M3aM5fGBhG2o17KvUmU40LnQl6XvWZjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2ujSGCDd3sNHjQjo/vlJX5q8i7JNMUBb1HW9/7JSGFxPUEsg/tfP/WCkUiYUv1qbCJd9vGihcD6FB++8LPr8yHyeo6YQh369S2r/Gbs90WpO3d92uFr94shPo41A8oFnHG1+l2dMAXfEN5GmaVhLB7ea8SramAXBL7NXMpmSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz3TWDvX; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz3TWDvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586701; x=1822122701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GvJMxRCWJr2M3aM5fGBhG2o17KvUmU40LnQl6XvWZjk=;
  b=Vz3TWDvXSZS42isrA86XqoPHCqVL1eW/Q+baf3epxwgGrBMkMOJHYSOE
   YO0Efp5T9rXB/GaH/uEHpV0s9TtEQXIt9AfA7kFmbX1PIlA+AssKmuw53
   E0zjPo5V6Pd8ktErvxg5d2GXxn50KeecbllNjA+Rqrckt4ZCpaDN6rX2U
   2HdFBmhnQ38hiDv/zroG33ArGG23OD5PBLBuP12fYUqIEDTA9mwUP8CVA
   POMVbzYuLKYAdwnfdhW+2A8Mw3KNt5z69nv5EWQFGPQ8TyL8UlIZUck2x
   4l7HctGXrIvmhIgf0zLbgEpiPrkn2kZ8A0pbUjH5pcpoGtfFQkuDBQDg3
   g==;
X-CSE-ConnectionGUID: sZWUVyzsTJuqX8Ab5E/mHg==
X-CSE-MsgGUID: sBIc1CsfR5ONLvrrbOdCUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90323417"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90323417"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:41 -0700
X-CSE-ConnectionGUID: uFCqSsJPSSmGll/JFDjRzA==
X-CSE-MsgGUID: vbYbCR9ERey02FV51wAg9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="278819313"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:11:35 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@intel.com
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kas@kernel.org,
	tabba@google.com,
	ackerleytng@google.com,
	michael.roth@amd.com,
	david@kernel.org,
	vannapurve@google.com,
	sagis@google.com,
	vbabka@suse.cz,
	thomas.lendacky@amd.com,
	nik.borisov@suse.com,
	pgonda@google.com,
	fan.du@intel.com,
	jun.miao@intel.com,
	francescolavra.fl@gmail.com,
	jgross@suse.com,
	xiaoyao.li@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com,
	chao.p.peng@intel.com,
	chao.gao@intel.com,
	farrah.chen@intel.com,
	yan.y.zhao@intel.com
Subject: [PATCH v4 10/17] KVM: x86/mmu: Add a TDP MMU API to split huge pages for mirror roots
Date: Mon, 28 Sep 2026 17:11:03 +0800
Message-ID: <20260928091103.15631-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260928090729.15468-1-yan.y.zhao@intel.com>
References: <20260928090729.15468-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Add an exported API to split huge pages in mirror roots for a given gfn
range.  TDX will use the API to split huge pages in preparation for
partially zapping a private huge page, e.g., for converting a huge page
from private to shared, or for splitting a huge page to match the guest's
ACCEPT level.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
v4:
- new patch.
---
 arch/x86/kvm/mmu/tdp_mmu.c | 40 ++++++++++++++++++++++++++++----------
 arch/x86/kvm/mmu/tdp_mmu.h |  2 ++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 472419963a19..9c783accb9ed 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1616,6 +1616,26 @@ static int tdp_mmu_split_huge_pages_root(struct kvm *kvm,
 	return 0;
 }
 
+static int tdp_mmu_split_huge_pages(struct kvm *kvm, int as_id,
+				    enum kvm_tdp_mmu_root_types type,
+				    gfn_t start, gfn_t end,
+				    int target_level, bool shared)
+{
+	struct kvm_mmu_page *root;
+	int r;
+
+	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
+
+	__for_each_tdp_mmu_root_yield_safe(kvm, root, as_id, type) {
+		r = tdp_mmu_split_huge_pages_root(kvm, root, start, end,
+						  target_level, shared);
+		if (r) {
+			kvm_tdp_mmu_put_root(kvm, root);
+			return r;
+		}
+	}
+	return 0;
+}
 
 /*
  * Try to split all huge pages mapped by the TDP MMU down to the target level.
@@ -1625,18 +1645,18 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 				      gfn_t start, gfn_t end,
 				      int target_level, bool shared)
 {
-	struct kvm_mmu_page *root;
-	int r = 0;
+	tdp_mmu_split_huge_pages(kvm, slot->as_id, KVM_VALID_ROOTS, start, end,
+				 target_level, shared);
+}
 
-	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id) {
-		r = tdp_mmu_split_huge_pages_root(kvm, root, start, end, target_level, shared);
-		if (r) {
-			kvm_tdp_mmu_put_root(kvm, root);
-			break;
-		}
-	}
+int kvm_tdp_mmu_mirrors_split_huge_pages(struct kvm *kvm, gfn_t start,
+					 gfn_t end, int target_level)
+{
+	/* The as_id for mirror roots can only be 0 */
+	return tdp_mmu_split_huge_pages(kvm, 0, KVM_MIRROR_ROOTS, start, end,
+					target_level, false);
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_tdp_mmu_mirrors_split_huge_pages);
 
 static bool tdp_mmu_need_write_protect(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index bd62977c9199..a6919de10ca2 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -97,6 +97,8 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 				      const struct kvm_memory_slot *slot,
 				      gfn_t start, gfn_t end,
 				      int target_level, bool shared);
+int kvm_tdp_mmu_mirrors_split_huge_pages(struct kvm *kvm, gfn_t start,
+					 gfn_t end, int target_level);
 
 static inline void kvm_tdp_mmu_walk_lockless_begin(void)
 {
-- 
2.43.2


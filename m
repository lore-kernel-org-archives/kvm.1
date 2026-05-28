Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15E38A707;
	Thu, 28 May 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958276; cv=none; b=hyfaL2dj6quch4vFfDed3ng5kUJwo+vc2nlMEy6cqhwKk6LNrUuqhUfPUzCtMYTUU+1RfNmsueS+P/iF/FyxtxCHOTwuAIXm1P16Iy3cZ3HQjAyTx84WVXV1BLF10HUnz3ocATytAEW7CfNamRjrdNZdNTLeqABUsAAmYd9W4vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958276; c=relaxed/simple;
	bh=OVf/dowr3Zhd4b80Ku3pHctRCBG5qFP1Ep1ToePlpp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/v4TqNIgKdwwdrefZqf2jgsV0XzGLMFag7ApWriPCAHCRfjbzbR9gqgTZTqgAijSPq8fpYeiM5OYjtA66uO6RIFwVdQOMqh90GmKpbXyIKP22Kacb8etcjn/37FsgdFdTpJUbvK1cWPJj5KtoNgK4qUEu520PlNmGZPEfXw7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hJU/UD58; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hJU/UD58"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779958275; x=1811494275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OVf/dowr3Zhd4b80Ku3pHctRCBG5qFP1Ep1ToePlpp8=;
  b=hJU/UD58H1QdZ6ozAXkROaf4RhtYEth9oKBfbAAGgK7vzd2NoidW3wR+
   6vM7ypeUiLS4XWjZK4Gc1cvrtxz5zPBaChlNZ+/JnADBoId+MCyz3qqZa
   qsHECAS4kiY/I7Cp9MGK4zoaDrbOfI4HsW7FwlcVtLy8NXny4w6DyTzGm
   XgPEafotCEibF5uCEzUF8ywDJVZG37MvyZOW0owtpZ9OeK+CiUy0qvQbn
   rvPaU/APjTB12YNob3UoHpy4ml8XhK4uruOi7ico8Qr7n1HDwgURuWhhk
   zctBoVtSI6T7zFNmZSso5VJ0jUZ7EFFFty0eqn8ydgILR/KphoTG6pRZh
   Q==;
X-CSE-ConnectionGUID: mBDjG8rTTaGF1OyU4+5n4A==
X-CSE-MsgGUID: 8Lbb7BmrRDuxuBLH5zlGHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103469608"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="103469608"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:14 -0700
X-CSE-ConnectionGUID: H3SIFul6QOiWvQr7VLxTRA==
X-CSE-MsgGUID: K3921SkiSjCKPb3TybGo8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="247442038"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 01:51:11 -0700
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
Subject: [PATCH v3 02/15] KVM: TDX: Wrap mapping of leaf and non-leaf S-EPT entries into helpers
Date: Thu, 28 May 2026 16:11:06 +0800
Message-ID: <20260528081106.10236-1-yan.y.zhao@intel.com>
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
MMU_refactors v3:
- Rebased to kvm-x86-next-2026.05.26.

MMU_refactors v2:
- Renamed tdx_sept_link_private_spt() to tdx_sept_map_nonleaf_spte(). (Yan)
---
 arch/x86/kvm/vmx/tdx.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 34e7e4833871..9279f938987b 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1672,7 +1672,7 @@ static struct page *tdx_spte_to_sept_pt(struct kvm *kvm, gfn_t gfn,
 	return virt_to_page(sp->external_spt);
 }
 
-static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
+static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, u64 mirror_spte)
 {
 	gpa_t gpa = gfn_to_gpa(gfn);
@@ -1694,18 +1694,12 @@ static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
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
@@ -1730,6 +1724,18 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
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


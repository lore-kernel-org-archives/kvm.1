Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82133A1E9E;
	Fri, 27 Mar 2026 20:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642477; cv=none; b=ZuO/JyhzGS2nZziAC1omQl9IfSEMAvh9CB7T06mo2kH4s+xQj9/AMd1ZVkPTfWQp/dim30NbWFOlIMs3KLHzxygn6a/Gj9o7pxBmori9ctkXZrZCVaT1KS2Lb6qLPc++kpz4SaE/COmDfCHf6aDnlFg1C9ZeBb6O8qYxJ/MHEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642477; c=relaxed/simple;
	bh=OcHkDR+vPE1bKPvOvL80lq/RfRhipAkhZil7/7o2E3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PW3eoxSVyKjrgIpDHnZkhtIam37Ex/gFy4wVVbKs+h6MPOMpFzZfsoMHVdgO8EEhMApDHc3FTW2iCavB+5ygf2Hv/H6bmr4S5HfNfR/0cLTE/m0qmH/VrKO7zp1X/hWxHA6L9D+ugzTQBt0sHdPt5TbkV/C/mqjT85hhQa+dV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDGdg5aO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDGdg5aO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642476; x=1806178476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcHkDR+vPE1bKPvOvL80lq/RfRhipAkhZil7/7o2E3Y=;
  b=bDGdg5aOAnw9brm/ffOOhZcJCNExCR13LXYZ7asl/2en2ayvcvU0Ib5+
   +flR8AxOyd+5cvTcpolhXYDu8M8MXTuy5S2xxeAxTgiLbKr0nPjlZOWK8
   GFf3HZ/HGYFo2J0tVmckjJB2ilpVf7+7ONuxAvPwx9GH0mWIjlerCs82B
   3JbvhJxSrgvY0PwX2dRlGwlewI3YTGsoYd/WKG0JNP4QhPjFsG0jvmKL+
   Bm0cXA9hYx75ZSF9lbkHqLixQG6j2h78S0bFV+ZTSgysitYNF7HnynHOz
   U1mhvSNyLIX5DaoiuGEgn08Zb70ATsa7U0HyJoStb3bL5IfxYn58gXVRZ
   g==;
X-CSE-ConnectionGUID: 4Wo7xh21QT2LzHvfdUFTQA==
X-CSE-MsgGUID: y24EDLmwS3urQsi5oSzFMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182758"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182758"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:28 -0700
X-CSE-ConnectionGUID: BLuFWd/JS4iS8WKTITjkEw==
X-CSE-MsgGUID: VqmEpWd/TWWvEWcEOqqynQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922926"
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
Subject: [PATCH 13/17] KVM: TDX: Hoist tdx_sept_remove_private_spte() above set_private_spte()
Date: Fri, 27 Mar 2026 13:14:17 -0700
Message-ID: <20260327201421.2824383-14-rick.p.edgecombe@intel.com>
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

Move tdx_sept_remove_private_spte() (and its tdx_track() helper) above
tdx_sept_set_private_spte() in anticipation of routing all non-atomic
S-EPT writes (with the exception of reclaiming non-leaf pages) through
the "set" API.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 569a0576e7c9..5a1a6610a98f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1719,20 +1719,6 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 	return tdx_mem_page_aug(kvm, gfn, level, pfn);
 }
 
-static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
-				     u64 new_spte, enum pg_level level)
-{
-	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
-		return -EIO;
-
-	lockdep_assert_held(&kvm->mmu_lock);
-
-	if (!is_last_spte(new_spte, level))
-		return tdx_sept_link_private_spt(kvm, gfn, level, new_spte);
-
-	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
-}
-
 /*
  * Ensure shared and private EPTs to be flushed on all vCPUs.
  * tdh_mem_track() is the only caller that increases TD epoch. An increase in
@@ -1852,6 +1838,20 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	tdx_quirk_reset_page(page);
 }
 
+static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
+				     u64 new_spte, enum pg_level level)
+{
+	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
+		return -EIO;
+
+	lockdep_assert_held(&kvm->mmu_lock);
+
+	if (!is_last_spte(new_spte, level))
+		return tdx_sept_link_private_spt(kvm, gfn, level, new_spte);
+
+	return tdx_sept_map_leaf_spte(kvm, gfn, level, new_spte);
+}
+
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector)
 {
-- 
2.53.0


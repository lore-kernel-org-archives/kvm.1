Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5F938239B;
	Sat,  9 May 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315837; cv=none; b=D7/mGaEiKt7Ni6vJxu3bH0hYbnTOQNNiOXOM3cTjRMq7j4K/s0tcoy7aX52XOC44ztzLaiiLdC8HtfXMrBuqgG9u1mjRk+5AZSp67t6j8K/KkSG8SrFuOCStNFGIN8aI2+jDZB2FIfGtzqHDTTR7kQWhIP/RKKLPQHsQer/O3NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315837; c=relaxed/simple;
	bh=PuP4wTw1gXLowAtx3WjUawqXh+u2rSJ5YEAUiyfAcPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm7H2v616Ze84Dv75erfV7ZNnaEgCdbaVdclKyU3Fbq0zRiXiGf3Rb2AUBAbG+NJKv58VTNXKCFWM3si4xNn2hIVLOYpAohomwuif/nGK0LhBDjn7/b9SkjcY/zR8kzsfYq+Usva64JOVeiTYVpNHTaxDoW5wDZafhOnpqpzSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AP+S5hPq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AP+S5hPq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778315835; x=1809851835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PuP4wTw1gXLowAtx3WjUawqXh+u2rSJ5YEAUiyfAcPo=;
  b=AP+S5hPq+QbZ3J3S7Z9BzFPLZHoj5QjIVCSl6O+GNNSeLPq86+Uxh/KI
   2cRQ66IPhTOrPSx/leGHXzJY8DjxnpR4z54WuOOmZJGLM2vASF34dEMLP
   lFsBmha4L9Tn9uC0XMfgR71ug42KTRBxnTdbra4R0BeSJZ+IrPPPVg6KO
   bJKtSrG+9dxbTBR+5k8hFZgYjksfYuB/MUf/FmU4fy+ps34uitcnCzFtq
   3L0AcZUxbD0v3MjfTI7HWAEyMW3/MFvUD7k15+Mu28BA3eTjZHTwkWP6/
   LyB7xgTLbrQ1bYxUDNOELwWcpKcMi6fQVI1IX9MiBlR17HHlptYzxqdSR
   g==;
X-CSE-ConnectionGUID: aCvdPP0sSCmIY31ke8DhBQ==
X-CSE-MsgGUID: uiZ6sgm7QVmuVTdEfn2FyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="79005338"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79005338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:37:15 -0700
X-CSE-ConnectionGUID: /XN2E2RORLimCAYo9OAjOA==
X-CSE-MsgGUID: +ogWKdmwQpmhs9Z0zh2rDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="238784786"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 01:37:11 -0700
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
Subject: [PATCH v2 13/15] KVM: TDX: Rename tdx_sept_remove_private_spte() to show it's for leaf SPTEs
Date: Sat,  9 May 2026 15:57:19 +0800
Message-ID: <20260509075719.4338-1-yan.y.zhao@intel.com>
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

Rename tdx_sept_remove_private_spte() to tdx_sept_remove_leaf_spte() to
clearly show that this function is for removal of leaf SPTEs.

No functional change intended.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
MMU_refactors v2:
- New patch.
---
 arch/x86/kvm/vmx/tdx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 749883fb8f11..5a7f304e14af 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1764,8 +1764,8 @@ static void tdx_track(struct kvm *kvm)
 	kvm_make_all_cpus_request(kvm, KVM_REQ_OUTSIDE_GUEST_MODE);
 }
 
-static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
-					enum pg_level level, u64 old_spte)
+static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, u64 old_spte)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	kvm_pfn_t pfn = spte_to_pfn(old_spte);
@@ -1838,7 +1838,7 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn, u64 old_spte,
 	lockdep_assert_held(&kvm->mmu_lock);
 
 	if (is_shadow_present_pte(old_spte))
-		return tdx_sept_remove_private_spte(kvm, gfn, level, old_spte);
+		return tdx_sept_remove_leaf_spte(kvm, gfn, level, old_spte);
 
 	if (KVM_BUG_ON(!is_shadow_present_pte(new_spte), kvm))
 		return -EIO;
@@ -2834,7 +2834,7 @@ void tdx_flush_tlb_current(struct kvm_vcpu *vcpu)
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


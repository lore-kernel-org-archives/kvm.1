Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121B03921F6;
	Fri, 27 Mar 2026 20:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642471; cv=none; b=gZzLfTGeQ1LgsAWZH1CVpXDuCp12lunbTDLi6iwBrlFSWVE3upnX375WNmmbcEg78wvN0UJb2+bdHrEt72APDzB3/Q3Yw5j+VnRJwkqkIVHHrzPChYd6mLpWIWOqdivE0BiwSRVHGBZTOpPQ78vwhPcWjuOozxedowgHNgPNOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642471; c=relaxed/simple;
	bh=1isAVXq6RldAGaJfpOEXaGLNSTFnOTTvj0rcbVDxYKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFoTmcaeN1UfTgskrHLecPPxeOpecukXjCAF1pGC8o3+oUiEW+nbBLvdKw+rjmoKiX2pjQYFlU3TLboSE//gSP5wfyGlhEOta7J6ohCiGaCkt3uJVY92CLCQgnmi7y0sPtVtgEMyqokWO87Gy9JREUj/hlbzK+vo+gNuNilyPX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SoOZkK/R; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SoOZkK/R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642470; x=1806178470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1isAVXq6RldAGaJfpOEXaGLNSTFnOTTvj0rcbVDxYKA=;
  b=SoOZkK/RgmWsESAkyHcajGG6NCHPGqlTO29Xgrp76Ts/lfvCjDwEX4se
   JCQEezv6HJlAqjiyUE6f1LLxqxqWk+tibH31JUn5WWYWDUOd2+G5jAx1H
   4vVJbS/4yQp5ItixFaK7YvGlBb7Xd65Er0euXU/cT5+nThVX98vVxjI2c
   kUhLcnJMOxo7fu2rzkN8kWK0JJSF1VAsvwXhTzNiLLMgP3X9AgpEIrbdV
   e7BR5pVaTUBuXlLTCayyDULycdgUbbpOLyCKHhjWU43V599G5njIZV4vR
   DST+vz2ssAaParfI6rVEDcMkvTEKndZrOWPDe4Z9jiLOsa6CUgZrRq0SB
   g==;
X-CSE-ConnectionGUID: DVq6llWER3iM1gbXaKB5Ew==
X-CSE-MsgGUID: 3CMIXxQxQ9WkrNSPbT9PJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182722"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182722"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:27 -0700
X-CSE-ConnectionGUID: 66h6j2OKTvu26OQPFg66GA==
X-CSE-MsgGUID: ep7Txl5DRPmUR92+zz0sDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922894"
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
Subject: [PATCH 03/17] KVM: TDX: Account all non-transient page allocations for per-TD structures
Date: Fri, 27 Mar 2026 13:14:07 -0700
Message-ID: <20260327201421.2824383-4-rick.p.edgecombe@intel.com>
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

Account all non-transient allocations associated with a single TD (or its
vCPUs), as KVM's ABI is that allocations that are active for the lifetime
of a VM are accounted.  Leave temporary allocations, i.e. allocations that
are freed within a single function/ioctl, unaccounted, to again align with
KVM's existing behavior, e.g. see commit dd103407ca31 ("KVM: X86: Remove
unnecessary GFP_KERNEL_ACCOUNT for temporary variables").

Fixes: 8d032b683c29 ("KVM: TDX: create/destroy VM structure")
Fixes: a50f673f25e0 ("KVM: TDX: Do TDX specific vcpu initialization")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 38e7b6fa8664..01e070ec10fd 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2384,7 +2384,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
-	tdr_page = alloc_page(GFP_KERNEL);
+	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!tdr_page)
 		goto free_hkid;
 
@@ -2392,12 +2392,13 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 	/* TDVPS = TDVPR(4K page) + TDCX(multiple 4K pages), -1 for TDVPR. */
 	kvm_tdx->td.tdcx_nr_pages = tdx_sysinfo->td_ctrl.tdvps_base_size / PAGE_SIZE - 1;
 	tdcs_pages = kzalloc_objs(*kvm_tdx->td.tdcs_pages,
-				  kvm_tdx->td.tdcs_nr_pages);
+				  kvm_tdx->td.tdcs_nr_pages,
+				  GFP_KERNEL_ACCOUNT);
 	if (!tdcs_pages)
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL);
+		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2872,7 +2873,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL);
+	page = alloc_page(GFP_KERNEL_ACCOUNT);
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2885,14 +2886,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	tdx->vp.tdvpr_pa = page_to_phys(tdx->vp.tdvpr_page);
 
 	tdx->vp.tdcx_pages = kcalloc(kvm_tdx->td.tdcx_nr_pages, sizeof(*tdx->vp.tdcx_pages),
-			       	     GFP_KERNEL);
+				     GFP_KERNEL_ACCOUNT);
 	if (!tdx->vp.tdcx_pages) {
 		ret = -ENOMEM;
 		goto free_tdvpr;
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL);
+		page = alloc_page(GFP_KERNEL_ACCOUNT);
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;
-- 
2.53.0


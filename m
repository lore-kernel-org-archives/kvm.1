Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145040DB23;
	Tue, 22 Sep 2026 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110396; cv=none; b=ugdI55JlUJpAJhSSZ94criO4hM/Ws3IKrLvsCkWKdSJ9szUE3LVNe9FXzqfORwptey0yKFdEACR4xLysQG+HATI9wKmbdTGwea3Pezicy0HR4KCtgUE6Jg/gFxh/dnEEbP8xtvlRzXyTG7zQklKg9r200ofB0EqcHwex/CDn84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110396; c=relaxed/simple;
	bh=HhqVSv8+4bvZqOPzzwBmt/JaAZPSUwsMYA0Y1/kMnP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGYLGYyflSIQytkIYOt8ebsmZ7DeamEtkKwEMcwAaM9aRCriIZW5VAJNRBDhDTiWUrB1BpsJ9xo1t3lc90D1cvMLfZt5qM5oPsluy1bLlPIrgs12+E7Hx/TYbvqaj1n+nI8NKfoXT7NofcMoMuNI00sxn7L6ES+LRzA2fizgAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIzieJMY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIzieJMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790110387; x=1821646387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HhqVSv8+4bvZqOPzzwBmt/JaAZPSUwsMYA0Y1/kMnP8=;
  b=gIzieJMYRA9qfWn/HayXcCckg7uRtbZIa3JrZxbH8ohiM0YYhtN6l383
   +LJNVYieni4Q4JVzP0/Yd71FPVbEd8XGPTHq2MlPs+YaRtMsqLa74xXZ1
   CpJb9Y38jVNm8A3poKzb3F8/uH4XllkAH0DHMPL9r7Q2rvPCh22Efww9y
   E6uzK4FjuHFShk5Q4lk+JRUoA4GtyvpZYaP/Ia7qlM1bkfBkEMhx1ROj8
   X2q6AMDElO+xGuVLV8/uEO6MxHFmfGTtV4mf13uSs/JiZRuAaRPQxs1d/
   Umh4I3jvYhpTMMvKET9gNini5LpboDxSngcIv9xvrXcmdzQvpABriBCps
   Q==;
X-CSE-ConnectionGUID: +jCVZuNlR1y0MzsoRfWcrA==
X-CSE-MsgGUID: YH1HG6jzSX2xRtzsolto9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101343606"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101343606"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:52:43 -0700
X-CSE-ConnectionGUID: h8B8LU/FRbaydQuNQgFgiw==
X-CSE-MsgGUID: YjLwlUqqQfWWq5Ywrpj2tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="271877318"
Received: from rpedgeco-desk.jf.intel.com ([10.24.81.149])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:52:43 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: pbonzini@redhat.com,
	dave.hansen@intel.com,
	seanjc@google.com,
	x86@kernel.org,
	kas@kernel.org,
	adrian.hunter@intel.com,
	yan.y.zhao@intel.com,
	binbin.wu@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Date: Tue, 22 Sep 2026 13:52:14 -0700
Message-ID: <20260922205215.870563-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module exposes a bit (CLFLUSH_BEFORE_ALLOC) to say whether it
requires some memory to be flushed from the cache before being handed
to the TDX module.

During the initial TDX upstreaming, it was decided it would be simplest
to just always flush in these cases, rather than checking for the bit and
having conditional logic. So currently the kernel flushes in several
places when handing memory to the TDX module.

In practice this bit has never been set by any TDX module, so flushing
is unneeded. Going forward the TDX docs will be updated to clarify that
CLFLUSH_BEFORE_ALLOC will never be set in any future TDX module either.

So make code even simpler by just deleting all the CLFLUSH_BEFORE_ALLOC
handling.

AI was used to review the change.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1b9ff749dd8e0..8f9d3588f200f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1619,22 +1619,6 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
-/*
- * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
- * a CLFLUSH of pages is required before handing them to the TDX module.
- * Be conservative and make the code simpler by doing the CLFLUSH
- * unconditionally.
- */
-static void tdx_clflush_page(struct page *page)
-{
-	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
-}
-
-static void tdx_clflush_pfn(kvm_pfn_t pfn)
-{
-	clflush_cache_range(__va(PFN_PHYS(pfn)), PAGE_SIZE);
-}
-
 static int pg_level_to_tdx_sept_level(enum pg_level level)
 {
 	WARN_ON_ONCE(level == PG_LEVEL_NONE);
@@ -1656,7 +1640,6 @@ u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page)
 		.rdx = tdx_tdr_pa(td),
 	};
 
-	tdx_clflush_page(tdcs_page);
 	return seamcall(TDH_MNG_ADDCX, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mng_addcx);
@@ -1672,7 +1655,6 @@ u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *sou
 	};
 	u64 ret;
 
-	tdx_clflush_pfn(pfn);
 	ret = seamcall_ret(TDH_MEM_PAGE_ADD, &args);
 
 	*ext_err1 = args.rcx;
@@ -1692,7 +1674,6 @@ u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, enum pg_level level,
 	};
 	u64 ret;
 
-	tdx_clflush_page(page);
 	ret = seamcall_ret(TDH_MEM_SEPT_ADD, &args);
 
 	*ext_err1 = args.rcx;
@@ -1709,7 +1690,6 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
 		.rdx = vp->tdvpr_pa,
 	};
 
-	tdx_clflush_page(tdcx_page);
 	return seamcall(TDH_VP_ADDCX, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
@@ -1724,7 +1704,6 @@ u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level,
 	};
 	u64 ret;
 
-	tdx_clflush_pfn(pfn);
 	ret = seamcall_ret(TDH_MEM_PAGE_AUG, &args);
 
 	*ext_err1 = args.rcx;
@@ -1769,7 +1748,6 @@ u64 tdh_mng_create(struct tdx_td *td, u16 hkid)
 		.rdx = hkid,
 	};
 
-	tdx_clflush_page(td->tdr_page);
 	return seamcall(TDH_MNG_CREATE, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mng_create);
@@ -1781,7 +1759,6 @@ u64 tdh_vp_create(struct tdx_td *td, struct tdx_vp *vp)
 		.rdx = tdx_tdr_pa(td),
 	};
 
-	tdx_clflush_page(vp->tdvpr_page);
 	return seamcall(TDH_VP_CREATE, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_create);
-- 
2.55.0


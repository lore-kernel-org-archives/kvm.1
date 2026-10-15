Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BBD5293E7;
	Thu, 15 Oct 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092242; cv=none; b=KcMBjObi8ySspaAJmI2GwIIZ8zMdEklCPEAFW1teiH6tilBHlpGg0BE6OmcxoBPFPsZAdMqzTd4dEiI5fzMNTO/WdrHClrtU5t/hhbgCw/NE0RqaaMxZWoTupegalvbK0SedOaXNv3kDNbrRRvi/VT7iKdAIdsC6erxiIipC3so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092242; c=relaxed/simple;
	bh=xi3oUxjHN6pE1Vs1NjxJG9OYu8VNWF2CL9fI21oI804=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUpmsiHgGMJ4WMHTCz5J4cCUFoO+/4WnP7xQuQqG5WZudeNBumGUul4SQklYua++jSTjCmrR7i6lS17kn1d2F5RSmk5DcNfI4DAn/lRH97MPFPxEJ0AHXF7ZpqYpY2IBdrjd/TpQnyn8wY2pRpqvTvZDMNFVqt5tiEKkMllbL4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSFXZlE7; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSFXZlE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792092241; x=1823628241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xi3oUxjHN6pE1Vs1NjxJG9OYu8VNWF2CL9fI21oI804=;
  b=PSFXZlE7qxo8B52469DMOVcAStixKxmMPKWD4/wWU01NOBTj9qSt9BSl
   O58OajgasSyXFSj59NIq+82KaDV3Pu9vZSOvjKYME8oHpe+tdx5LXx4td
   aZwTBnONg0H4NcYvKh+ooM+SXVtKitFalVCXdqGBZBVRu1dy9YzCu85AV
   3yHIkitmPYnpBMl2nhuUD/HFzxTXgMCCUSaR8d7+9jTK/sHVLUtwaOWUd
   a4C3NoB9FQqUwmxZeZKSxv/pZIq4KogaBSxEcGIowNukOVzMSkT/yrTjy
   oOpvUg8m8XOujbd5qXNyewYrSG53cQzmQjDOjdrgPus4dQB97OxmKBhsG
   g==;
X-CSE-ConnectionGUID: h16n83zDSDiHgRl1P5qZxQ==
X-CSE-MsgGUID: 6Wt3VEhtTOKHpOsw5G8ngw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="764813"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="764813"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:17:19 -0700
X-CSE-ConnectionGUID: KjXOJ5bFQVWrvLHkNMG0zw==
X-CSE-MsgGUID: jqvB3lNRRRevmF0s7O3Npg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1836895"
Received: from rpedgeco-desk.jf.intel.com ([10.24.81.149])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:17:17 -0700
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
	kvm@vger.kernel.org,
	nik.borisov@suse.com,
	yilun.xu@linux.intel.com,
	tony.lindgren@linux.intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v2 1/2] x86/virt/tdx: Drop tdx_clflush_*()
Date: Thu, 15 Oct 2026 12:17:09 -0700
Message-ID: <20261015191710.3632302-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
References: <20261015191710.3632302-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX module exposes a bit (CLFLUSH_BEFORE_ALLOC) to say whether it
requires certain types of memory to be flushed from the cache before being
handed to the TDX module.

During the initial TDX upstreaming, it was decided it would be simplest
to just always flush rather than checking for the bit and having
conditional logic. So based on the TDX docs:
  When allocating a memory page to be used as TD private memory or TD
  control structure page, the host VMM is required to ensure that none of
  the cache lines associated with the page is in a MODIFIED state.

...currently the kernel flushes before handing over private memory and TD
control structure pages.

The CLFLUSH_BEFORE_ALLOC bit has never been set by any TDX module, so this
flushing has yet to be needed in practice. Going forward, the TDX docs will
be updated to clarify that actually CLFLUSH_BEFORE_ALLOC will *never* be
set in any future TDX module either.

So make code even simpler by just deleting all the CLFLUSH_BEFORE_ALLOC
handling.

AI was used to review the change.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
---
v2:
 - Log verbiage (Yan)
 - Verbiage around "in practice" (Tony)
 - Clarify what flows require CLFLUSH_BEFORE_ALLOC (Nikolay)
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


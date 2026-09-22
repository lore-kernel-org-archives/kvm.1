Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97051D533;
	Tue, 22 Sep 2026 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110404; cv=none; b=M+BYdXJgvKo9uZRvlfZL665EM/4HFyLMf625ZEF2a2BSBF8HhTdYxUyztJeMU0WbppTKEeUec+df+AXLNZrq8Z8ZLGnTTpILpgEYkueD6Wv5ECMQrWU3IYf//AzC77liO9Nq2w4QMah3o3Aaea+zA0efAVef3YWdpSdKHcFtE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110404; c=relaxed/simple;
	bh=9E7cJUlrZTjwtnhlYT4677//ROkpbR2RS78FyVNC6M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crCoBH1dW6HBQDs0WGCyH6SB4fq3WA9hf9gaYBvPbbbP7VlyB/+fehpSEDXMsha8IYINKyEaOLOXcieWNmC0vlPTTTkxnof6nC+24spbbyUCYzqGaqvncCN7xxWcMtXZM9vNHuULYz3FJdYK2wA8shV6BLifyYVhQA5q5K6oqyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmbVH4sB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmbVH4sB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790110394; x=1821646394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9E7cJUlrZTjwtnhlYT4677//ROkpbR2RS78FyVNC6M4=;
  b=mmbVH4sBJCwozlgJRiC74bbpf0licJok28Fs6mP+WM3BxQJbeTj2+5Zo
   aTE6o0CDJS9TBjnhrpaQg4RVaQLzjCYb4YDGtGOae0/+2S7Mq11Vj6omX
   4EG0OxS/7jvZ+3hjeqy0wxxXOon4M4FI0U+bcvTngh3mULp/rKfKm/f1b
   AtwXqrGrhs8EWMhboi44HMEPhxKDKY+GVjsKbeHerDCDyFaLyR9cDri6p
   f3sYFyMDLB/9Byi45qZXaHWedsvkSemY56PXnghJiQytZhIjNzxKROag4
   IffenMpJS9hCJ1xFCs2Y9Qix/8GEzmSvjmqlSudTa0yb1u01RhDUyHgMV
   A==;
X-CSE-ConnectionGUID: fyp3MqAFR2CEv3EyqfsNGw==
X-CSE-MsgGUID: gGz7wXt3SamL6eWoAaD86g==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="101343610"
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="101343610"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 13:52:44 -0700
X-CSE-ConnectionGUID: vUG/eQdeQ+iTCZ81NfBh4Q==
X-CSE-MsgGUID: iuYOFL2AQ8OBWKAQgDpylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,117,1787036400"; 
   d="scan'208";a="271877330"
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
Subject: [PATCH 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Date: Tue, 22 Sep 2026 13:52:15 -0700
Message-ID: <20260922205215.870563-3-rick.p.edgecombe@intel.com>
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

In the early days of TDX it was expected that pages being reclaimed from 
the TDX module would need any cacheline from their private KeyID alias 
flushed. The TDX docs describe doing this in a couple cases, for example 
reclaiming the TDR memory:
  Flush MODIFIED cache lines: this is required to avoid corruption due to
  cache line aliasing. Note that all cache lines for all other TD pages
  must have been flushed before the TDR page was reclaimed.

For a similar reasons as why the CLFLUSH_BEFORE_ALLOC features0 bit was
never actually set in any TDX module, this flush of the private KeyID
cachelines turned out to not be needed by the final TDX solution. However,
the TDX docs were never updated to reflect that.

Since private KeyID virtual mappings are reserved for TDX use, the TDX
module has to do the clflush itself. The TDH.PHYMEM.PAGE.WBINVD SEAMCALL
leaf was created for this purpose.

So drop the kernel code that calls this SEAMCALL and the two helpers that
facilitate it. With the removal of tdh_phymem_page_wbinvd_tdr(),
tdx_global_keyid no longer needs to be kept around as a global variable.
It just needs to be selected and provided to the TDX module during initial
setup. However, don't churn the code to remove the global variable because
it fits neatly with the other KeyID partitioning global data. It is also
foreseeable that this would be used in the future for other SEAMCALLs that
require the passing the global KeyID.

AI was used to review the change.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 --
 arch/x86/kvm/vmx/tdx.c      | 14 --------------
 arch/x86/virt/vmx/tdx/tdx.c | 26 --------------------------
 arch/x86/virt/vmx/tdx/tdx.h |  1 -
 4 files changed, 43 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d89..39e3c1f8a48e1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -174,8 +174,6 @@ u64 tdh_phymem_page_reclaim(struct page *page, u64 *tdx_pt, u64 *tdx_owner, u64
 u64 tdh_mem_track(struct tdx_td *tdr);
 u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_phymem_cache_wb(bool resume);
-u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
-u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
 #else
 static inline void tdx_init(void) { }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a74..51327b5d5784a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -550,7 +550,6 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
 static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	u64 err;
 	int i;
 
 	/*
@@ -578,15 +577,6 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 	if (__tdx_reclaim_page(kvm_tdx->td.tdr_page))
 		return;
 
-	/*
-	 * Use a SEAMCALL to ask the TDX module to flush the cache based on the
-	 * KeyID. TDX module may access TDR while operating on TD (Especially
-	 * when it is reclaiming TDCS).
-	 */
-	err = tdh_phymem_page_wbinvd_tdr(&kvm_tdx->td);
-	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
-		return;
-
 	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
 
 	__free_page(kvm_tdx->td.tdr_page);
@@ -1814,10 +1804,6 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
 		return -EIO;
 
-	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
-	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
-		return -EIO;
-
 	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
 	return 0;
 }
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 8f9d3588f200f..21f7fce38aa46 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1956,32 +1956,6 @@ u64 tdh_phymem_cache_wb(bool resume)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_cache_wb);
 
-static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
-{
-	/* KeyID bits are just above the physical address bits. */
-	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
-}
-
-u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
-{
-	struct tdx_module_args args = {};
-
-	args.rcx = mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_page));
-
-	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
-}
-EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_tdr);
-
-u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
-{
-	struct tdx_module_args args = {};
-
-	args.rcx = mk_keyed_paddr(hkid, pfn);
-
-	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
-}
-EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
-
 void tdx_sys_disable(void)
 {
 	struct tdx_module_args args = {};
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index bdfd0e1e337ac..3289be59d14fc 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -43,7 +43,6 @@
 #define TDH_SYS_TDMR_INIT		36
 #define TDH_MEM_TRACK			38
 #define TDH_PHYMEM_CACHE_WB		40
-#define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
-- 
2.55.0


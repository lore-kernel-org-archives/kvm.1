Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8BF53E2E6;
	Thu, 15 Oct 2026 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092243; cv=none; b=XFC3mRsGwCdHkFb0J5YtaOKQloxGxYEWMKMhtmsn0t64oCOiJ/hHkB8gxU5uFgn+xGMSZ5q2czspu0JZJlc2Hovb6Fn+wW+RxR+wZAH8caqvhidVzvFBKsmV5yXPP7h0wkxI3abvzgygEdQFzUO+kYLWjaeUcMgSH8QRrg5qrcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092243; c=relaxed/simple;
	bh=rTzMipX3pUBTumObf4JpFhE4XbMqCnpKISixRhCTdD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbdETGmfon4EJfPy+6Dt32FzWG1W2XqzkuVpk2OJ67+FFuOalgh9BZjDV5BpnixpH+594b42MqkrbBVBkekgXVxsnxQgcsigiSOejufD9ZIkWflBMVtsZC4hqBRoq6LeSWRJiWDFyD97J80o/4sn5QYSF4VXC8LTMtj3ho4+Mqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JyFiVabh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JyFiVabh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792092242; x=1823628242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rTzMipX3pUBTumObf4JpFhE4XbMqCnpKISixRhCTdD4=;
  b=JyFiVabhrAayLcQrYKKZSVybIOSG7qs2Lk/XMc9+EJyr/hXKNKyvY+JM
   3gsyngPlLGY1q+hAYaIxrZdewYwIQizs9Mdh6F2k6Sz1/zx7MEyp6Wh0S
   cqZCuUlvvVL1kaNOzWEYl6Zag1DZz0gW/lAjUeeWqOdMABG9layYkmnAf
   fqTheN+1BJMtuWgIbzOpHRVF8iyvlaR2xdPchygsURURKvqcVZazGznBU
   so5UxdrHA9rze/0RR5If4eYm6d2EX9FqeNqZVmhNrg3qne3CyzhVu81tA
   3DIZKLQHM4B9Bzgqqdpq2YRxkdrXEsvB4s5oS8z/Et70a751PUMU5b3gy
   g==;
X-CSE-ConnectionGUID: /DlMcMR7S/+zOCS0vG7QdA==
X-CSE-MsgGUID: FUIBgi+MRLK0n+HWBsnmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="764818"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="764818"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:17:20 -0700
X-CSE-ConnectionGUID: pOkU8tYoTKCuOjgVU8OUqg==
X-CSE-MsgGUID: /HhP0v/TToiDVkP4sMomTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1836898"
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
Subject: [PATCH v2 2/2] x86/virt/tdx: Drop tdh_phymem_page_wbinvd_*()
Date: Thu, 15 Oct 2026 12:17:10 -0700
Message-ID: <20261015191710.3632302-3-rick.p.edgecombe@intel.com>
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

In the early days of TDX it was expected that pages being reclaimed from
the TDX module would need any cacheline from their private KeyID alias
flushed. The TDX docs describe doing this in a couple narrow cases, for
example reclaiming the TDR memory or guest private memory.

Similar to how the CLFLUSH_BEFORE_ALLOC features0 bit was never actually
set in any TDX module, the flush of the private KeyID cachelines turned
out to not be needed by the final TDX HW either. However, the TDX docs
were never updated to reflect that.

CLFLUSH_BEFORE_ALLOC handles flushing when giving memory to the TDX
module, where the alias that needs flushing is the default, normal KeyID
0. This was done with a clflush of the kernel's KeyID 0 mapping of the
memory. For the reclaim path, instead it is the TDX KeyID aliases that
need to be flushed. Since virtual mappings for these aliases are
restricted to the TDX module, the module is the only thing that can map
the page to do the clflush. The TDH.PHYMEM.PAGE.WBINVD SEAMCALL leaf was
created to facilitate this.

The docs are being updated to clarify that calling TDH.PHYMEM.PAGE.WBINVD
is not needed. So drop the kernel code that calls this SEAMCALL and the
helpers that facilitate it. With the removal of
tdh_phymem_page_wbinvd_tdr(), tdx_global_keyid no longer needs to be kept
around as a global variable. It just needs to be selected and provided to
the TDX module during initial setup.

However, don't churn the code to remove the global variable because
it fits neatly with the other KeyID partitioning global data. It is also
foreseeable that this would be used in the future for other SEAMCALLs that
require passing the global KeyID.

KVM previously needed to call different types of tdh_phymem_page_wbinvd_*()
helpers for different types of reclaim. So it had a stack of helpers and
some open coded logic to use them in the rarer TDR reclaim case. Now that
the wbinvd is gone, the steps for each operation are logically equivalent.
So collapse the helpers and just call tdx_reclaim_control_page() from the
TDR reclaim path.

This unification brings TDR reclaim in line with the behavior of the other
reclaim paths, by handling TDH.PHYMEM.PAGE.RECLAIM failure by leaking the
page and setting the TDR page pointer to NULL. This results in reclaim not
being tried a second time, which is reasonable because the first reclaim
failing suggests a problem with the TDX module.

AI was used to review the change.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v2:
 - Clean up open coding of TDR reclaim now that it doesn't need to be.
   (Yilun)
 - Logs stuff (Yilun, Yan, Chao)
 - [omit Yan RB due to code change]
---
 arch/x86/include/asm/tdx.h  |  2 --
 arch/x86/kvm/vmx/tdx.c      | 40 ++++++-------------------------------
 arch/x86/virt/vmx/tdx/tdx.c | 26 ------------------------
 arch/x86/virt/vmx/tdx/tdx.h |  1 -
 4 files changed, 6 insertions(+), 63 deletions(-)

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
index 00850a3a77d66..ed1db8023c6ec 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -320,7 +320,7 @@ static inline void tdx_disassociate_vp(struct kvm_vcpu *vcpu)
 })
 
 /* TDH.PHYMEM.PAGE.RECLAIM is allowed only when destroying the TD. */
-static int __tdx_reclaim_page(struct page *page)
+static int tdx_reclaim_page(struct page *page)
 {
 	u64 err, rcx, rdx, r8;
 
@@ -334,24 +334,15 @@ static int __tdx_reclaim_page(struct page *page)
 	if (TDX_BUG_ON_3(err, TDH_PHYMEM_PAGE_RECLAIM, rcx, rdx, r8, NULL))
 		return -EIO;
 
+	tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
+
 	return 0;
 }
 
-static int tdx_reclaim_page(struct page *page)
-{
-	int r;
-
-	r = __tdx_reclaim_page(page);
-	if (!r)
-		tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
-	return r;
-}
-
 
 /*
- * Reclaim the TD control page(s) which are crypto-protected by TDX guest's
- * private KeyID.  Assume the cache associated with the TDX private KeyID has
- * been flushed.
+ * Reclaim the TD control page(s) which are crypto-protected by private
+ * KeyIDs.
  */
 static void tdx_reclaim_control_page(struct page *ctrl_page)
 {
@@ -550,7 +541,6 @@ void tdx_mmu_release_hkid(struct kvm *kvm)
 static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	u64 err;
 	int i;
 
 	/*
@@ -575,21 +565,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 	if (!kvm_tdx->td.tdr_page)
 		return;
 
-	if (__tdx_reclaim_page(kvm_tdx->td.tdr_page))
-		return;
-
-	/*
-	 * Use a SEAMCALL to ask the TDX module to flush the cache based on the
-	 * KeyID. TDX module may access TDR while operating on TD (Especially
-	 * when it is reclaiming TDCS).
-	 */
-	err = tdh_phymem_page_wbinvd_tdr(&kvm_tdx->td);
-	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
-		return;
-
-	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
-
-	__free_page(kvm_tdx->td.tdr_page);
+	tdx_reclaim_control_page(kvm_tdx->td.tdr_page);
 	kvm_tdx->td.tdr_page = NULL;
 }
 
@@ -1814,10 +1790,6 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
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


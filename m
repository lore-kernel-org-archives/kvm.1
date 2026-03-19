Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313743112BC;
	Thu, 19 Mar 2026 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884264; cv=none; b=J8Wsuh8uCCvwWQ7AW0odvxKkwWCyA6e9Ckg4RgRRoqQn5K3V9gag1jov6tTTHKhNFj6RwNGgTVxK0wFSbnL0490xtRZ+EUifC1gSRxOFz5AlO12XaEVK5Wc50/1HUhkm8syay3TqIVlROpqZDEU1gmEnAv1pGeuPxfqPBd7Yk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884264; c=relaxed/simple;
	bh=7Ko2/68sFmhdmTw5twBrknA4E8EBmOVStQOriTBS1No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lazv8TrE238COa7xr6R4F5uHYlLHVCBjulrBES1mVZDduzLCdGCOjxU2fvXyqt7/fz5aVG74EkbZRVmtSFnUribcKgUka/kEFzMNm1Pgx2ntAOYHRQzoPbTbxbyJLLU98H6pnfQQPE9+04N35hO6Qru6EYGyHRE97gPTVYlmQBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yq9YHy3D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yq9YHy3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773884255; x=1805420255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Ko2/68sFmhdmTw5twBrknA4E8EBmOVStQOriTBS1No=;
  b=Yq9YHy3D03mB7EnudFiYPl7bVmJw7JiNE5JqCkJVg2jiMsJI0b2vddDE
   9QVyShCyipce/ABT06rQil5kSJ24tc8YdYfwEgP4nIX+bs7PDm5Br8zuj
   J1BFg966/+CGrQ6/Ud57LAtOnS9yOZ8pIsmGppLS2i6mt/b+x9eeDuIXS
   t9P1wfbcApHtXCILVgLFXGlndvU1o2SqKjTxc/lXDLNFDjhWb/fv34EuX
   FeLbDzGRZcAERlCTMpuAAO+rPq7ZCfuLkVYQe41DD0IuJALrXwLM/AgQa
   l0nV3pQRLqIo0jjjakc53ha/tciqLUy/7BuAKSCxfk85RsLn2s3HbzB7N
   Q==;
X-CSE-ConnectionGUID: pA73L0nuTpmp18/SPl75ww==
X-CSE-MsgGUID: zqkMj3K2QmaawXaFOtOzaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="62522964"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="62522964"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:37:34 -0700
X-CSE-ConnectionGUID: wFcw+muPS3WmYPbVGIDYeA==
X-CSE-MsgGUID: hJ5xcdDbS3GIQYhT4GojZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="226948320"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:37:29 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	kas@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kai.huang@intel.com,
	rick.p.edgecombe@intel.com,
	yan.y.zhao@intel.com,
	yilun.xu@linux.intel.com,
	vannapurve@google.com,
	ackerleytng@google.com,
	sagis@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	isaku.yamahata@intel.com
Subject: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest private memory
Date: Thu, 19 Mar 2026 08:58:08 +0800
Message-ID: <20260319005808.9013-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260319005605.8965-1-yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Remove the completely unnecessary assumptions that memory unmapped from a
TDX guest is backed by refcounted struct page memory.

APIs tdh_phymem_page_wbinvd_hkid(), tdx_quirk_reset_page() are used when
unmapping guest private memory from S-EPT. Since mapping of guest private
memory places no requirements on how KVM and guest_memfd manage memory,
neither does guest private memory unmapping.

Rip out the misguided struct page assumptions/constraints by having the two
APIs take PFN directly. This ensures that for future huge page support in
S-EPT, the kernel doesn't pick up even worse assumptions like "a hugepage
must be contained in a single folio".

Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
since APIs tdh_phymem_page_wbinvd_hkid() and tdx_quirk_reset_page() are
exported to KVM only.

Update mk_keyed_paddr(), which is invoked by tdh_phymem_page_wbinvd_hkid(),
to take PFN as parameter accordingly. Opportunistically, move
mk_keyed_paddr() from tdx.h to tdx.c since there are no external users.

Have tdx_reclaim_page() remain using struct page as parameter since it's
currently not used for removing guest private memory yet.

[Yan: Use kvm_pfn_t, drop reclaim API param update, move mk_keyed_paddr()]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/include/asm/tdx.h  | 15 ++-------------
 arch/x86/kvm/vmx/tdx.c      | 10 +++++-----
 arch/x86/virt/vmx/tdx/tdx.c | 16 +++++++++++-----
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f3f0b1872176..6ceb4cd9ff21 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -153,7 +153,7 @@ int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
 
-void tdx_quirk_reset_page(struct page *page);
+void tdx_quirk_reset_page(kvm_pfn_t pfn);
 
 struct tdx_td {
 	/* TD root structure: */
@@ -177,17 +177,6 @@ struct tdx_vp {
 	struct page **tdcx_pages;
 };
 
-static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
-{
-	u64 ret;
-
-	ret = page_to_phys(page);
-	/* KeyID bits are just above the physical address bits: */
-	ret |= (u64)hkid << boot_cpu_data.x86_phys_bits;
-
-	return ret;
-}
-
 static inline int pg_level_to_tdx_sept_level(enum pg_level level)
 {
         WARN_ON_ONCE(level == PG_LEVEL_NONE);
@@ -219,7 +208,7 @@ u64 tdh_mem_track(struct tdx_td *tdr);
 u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, u64 level, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_phymem_cache_wb(bool resume);
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
-u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
+u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
 #else
 static inline void tdx_init(void) { }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1f1abc5b5655..75ad3debcd84 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -343,7 +343,7 @@ static int tdx_reclaim_page(struct page *page)
 
 	r = __tdx_reclaim_page(page);
 	if (!r)
-		tdx_quirk_reset_page(page);
+		tdx_quirk_reset_page(page_to_pfn(page));
 	return r;
 }
 
@@ -597,7 +597,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
 		return;
 
-	tdx_quirk_reset_page(kvm_tdx->td.tdr_page);
+	tdx_quirk_reset_page(page_to_pfn(kvm_tdx->td.tdr_page));
 
 	__free_page(kvm_tdx->td.tdr_page);
 	kvm_tdx->td.tdr_page = NULL;
@@ -1776,9 +1776,9 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
 static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 					 enum pg_level level, u64 mirror_spte)
 {
-	struct page *page = pfn_to_page(spte_to_pfn(mirror_spte));
 	int tdx_level = pg_level_to_tdx_sept_level(level);
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 
@@ -1817,11 +1817,11 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
 		return;
 
-	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
+	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
 	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
 		return;
 
-	tdx_quirk_reset_page(page);
+	tdx_quirk_reset_page(pfn);
 }
 
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a9dd75190c67..2f9d07ad1a9a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -730,9 +730,9 @@ static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
 	mb();
 }
 
-void tdx_quirk_reset_page(struct page *page)
+void tdx_quirk_reset_page(kvm_pfn_t pfn)
 {
-	tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
+	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_page);
 
@@ -1907,21 +1907,27 @@ u64 tdh_phymem_cache_wb(bool resume)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_cache_wb);
 
+static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
+{
+	/* KeyID bits are just above the physical address bits. */
+	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
+}
+
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
 {
 	struct tdx_module_args args = {};
 
-	args.rcx = mk_keyed_paddr(tdx_global_keyid, td->tdr_page);
+	args.rcx = mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_page));
 
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_tdr);
 
-u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
+u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
 {
 	struct tdx_module_args args = {};
 
-	args.rcx = mk_keyed_paddr(hkid, page);
+	args.rcx = mk_keyed_paddr(hkid, pfn);
 
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
-- 
2.43.2


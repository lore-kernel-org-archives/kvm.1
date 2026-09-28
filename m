Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5B486BB2;
	Mon, 28 Sep 2026 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586537; cv=none; b=pVkOb4efe/3GfPc9TFDEANn/YvvXx8njwjdWoVfU8i8bU+zp8iej/H4jOOjOnEqbLRVQj918nGOVfhPOw1VX+wpU/isHDdz2IJP36lZ8+FkwtNZw9vCYgll+zopGm6WHqBkkBFnxOnyGgJQAAqbJLIau/eBWyGO8vccMGpLMYv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586537; c=relaxed/simple;
	bh=rrBM2my4gpP3XexCMlX2KUuX5BJ7lv5uqFGfHxy0R5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpEVR3Ea8Y6BbrBO1u93WrB8TFPa6MZFdBJxhXRiUpafdSvcEuQRHpNifoCcqmI5eF8CcHN2tX+yqGE2lbxEkBiQn3/s3FHtr13evoxBrSpc7vXzsxwUO+HeYVBJU9mwz4CXxH5LVRSvAZ8GXzttKQfO3EsuyE6Wbr1A7SaW/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMyW5RvF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMyW5RvF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790586535; x=1822122535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrBM2my4gpP3XexCMlX2KUuX5BJ7lv5uqFGfHxy0R5w=;
  b=VMyW5RvFnO9BlGREbXaAjnHMzWpQ4K4RmW/4e0ab1Dka5sZzyKr62NTi
   ylsOQJS+pam7NkVQ/PKep1wsOsPGaF3YxPUj5pb3Mkd3PLosC6MiaZsOz
   ivPKFzoJZFeaFBAOJL+wvdsnGRymQXA13iSiagzk7WTE5KXWcCIi1sHL1
   Q965vnM1PdToMVNLAeuc9W6fiuEfb701zn6zwIW1EVE5g962ABZO9iTCa
   liuEEwpQQNlmaO1nN+M40e/wzVmUoZ/mlKcKnMiHbnc9Vq/L73xidteCo
   iqo2DQTveQgMYtD9bzP527KsrQdZtP30XxPOc/439w2AfI2IXKBJQ2kwT
   A==;
X-CSE-ConnectionGUID: 2bNOWcjtSTe2pD4XgBGHAQ==
X-CSE-MsgGUID: UV1pVFdBTnWN/vXoMmmpuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90047042"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90047042"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:08:55 -0700
X-CSE-ConnectionGUID: b8A9UppnRxiNBXDkG3ngvw==
X-CSE-MsgGUID: UztXR8iITGilYGM2bCX2Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="271488167"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:08:48 -0700
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
Subject: [PATCH v4 01/17] x86/virt/tdx: Enhance tdx_pamt_get/put() to support huge pages
Date: Mon, 28 Sep 2026 17:08:08 +0800
Message-ID: <20260928090808.15484-1-yan.y.zhao@intel.com>
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

The TDX module uses PAMT to track metadata for every physical page (within
TDMR) across three levels: 1GB, 2MB, and 4KB. The VMM is responsible for
providing backing pages for the PAMT. Without Dynamic PAMT (DPAMT), all
PAMT backing pages are allocated statically at system boot time. With DPAMT
enabled, PAMT backing pages tracking physical pages at the 4KB level
(referred to as DPAMT pages) are dynamically installed and uninstalled at
runtime.

Currently, the VMM invokes tdx_pamt_get()/tdx_pamt_put() to install and
uninstall DPAMT pages under the assumption that all physical pages are
tracked at 4KB level.  However, when a guest page is mapped as a huge page
in the S-EPT, the TDX module tracks it directly at the huge page level,
meaning installation and uninstallation of DPAMT pages for huge pages is
neither needed nor applicable.

Add a "level" parameter to tdx_pamt_get()/tdx_pamt_put() so the helpers
can skip DPAMT page installation and uninstallation for huge pages.

TD control pages (including S-EPT page table pages) are managed by the TDX
module at the 4KB level. Therefore, pass PG_LEVEL_4K to
tdx_pamt_get()/tdx_pamt_put() for those pages.

This patch is based on earlier work from Kiryl Shutsemau.
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/include/asm/tdx.h  |  4 ++--
 arch/x86/kvm/vmx/tdx.c      | 14 +++++++++-----
 arch/x86/virt/vmx/tdx/tdx.c | 12 ++++++------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 48efd3eac375..e2790ac2c521 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -135,8 +135,8 @@ static inline void tdx_init_pamt_cache(struct tdx_pamt_cache *cache)
 
 void tdx_free_pamt_cache(struct tdx_pamt_cache *cache);
 int tdx_topup_pamt_cache(struct tdx_pamt_cache *cache, unsigned long npages);
-int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache);
-void tdx_pamt_put(kvm_pfn_t pfn);
+int tdx_pamt_get(kvm_pfn_t pfn, enum pg_level level, struct tdx_pamt_cache *cache);
+void tdx_pamt_put(kvm_pfn_t pfn, enum pg_level level);
 
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1f0dba322640..410c149bf776 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1710,14 +1710,18 @@ static int tdx_sept_map_nonleaf_spte(struct kvm *kvm, gfn_t gfn,
 	if (!sept_pt)
 		return -EIO;
 
-	ret = tdx_pamt_get(page_to_pfn(sept_pt), &to_tdx(vcpu)->pamt_cache);
+	/*
+	 * An S-EPT page table page is tracked by the TDX module at 4KB level,
+	 * so pass 4KB instead of the target S-EPT level.
+	 */
+	ret = tdx_pamt_get(page_to_pfn(sept_pt), PG_LEVEL_4K, &to_tdx(vcpu)->pamt_cache);
 	if (KVM_BUG_ON(ret, kvm))
 		return ret;
 
 	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, sept_pt,
 			       &entry, &level_state);
 	if (err)
-		tdx_pamt_put(page_to_pfn(sept_pt));
+		tdx_pamt_put(page_to_pfn(sept_pt), PG_LEVEL_4K);
 
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
@@ -1745,7 +1749,7 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 
 	WARN_ON_ONCE((new_spte & VMX_EPT_RWX_MASK) != VMX_EPT_RWX_MASK);
 
-	ret = tdx_pamt_get(pfn, &to_tdx(vcpu)->pamt_cache);
+	ret = tdx_pamt_get(pfn, level, &to_tdx(vcpu)->pamt_cache);
 	if (KVM_BUG_ON(ret, kvm))
 		return ret;
 
@@ -1767,7 +1771,7 @@ static int tdx_sept_map_leaf_spte(struct kvm *kvm, gfn_t gfn, enum pg_level leve
 		ret = tdx_mem_page_add(kvm, gfn, level, pfn);
 
 	if (ret)
-		tdx_pamt_put(pfn);
+		tdx_pamt_put(pfn, level);
 
 	return ret;
 }
@@ -1862,7 +1866,7 @@ static int tdx_sept_remove_leaf_spte(struct kvm *kvm, gfn_t gfn,
 		return -EIO;
 
 	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
-	tdx_pamt_put(pfn);
+	tdx_pamt_put(pfn, level);
 	return 0;
 }
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 33253869e2fd..43f813afc5b1 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2112,14 +2112,14 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 static DEFINE_SPINLOCK(dpamt_lock);
 
 /* Bump DPAMT refcount for the given pfn and allocate DPAMT backing if needed. */
-int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
+int tdx_pamt_get(kvm_pfn_t pfn, enum pg_level level, struct tdx_pamt_cache *cache)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
 	atomic_t *dpamt_refcount;
 	u64 tdx_status;
 	int ret;
 
-	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo) || level != PG_LEVEL_4K)
 		return 0;
 
 	ret = alloc_pamt_array(pamt_pages, cache);
@@ -2157,13 +2157,13 @@ int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 EXPORT_SYMBOL_FOR_KVM(tdx_pamt_get);
 
 /* Drop DPAMT refcount for the given pfn and free DPAMT backing if needed. */
-void tdx_pamt_put(kvm_pfn_t pfn)
+void tdx_pamt_put(kvm_pfn_t pfn, enum pg_level level)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
 	atomic_t *dpamt_refcount;
 	u64 tdx_status;
 
-	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo) || level != PG_LEVEL_4K)
 		return;
 
 	dpamt_refcount = tdx_find_dpamt_refcount(pfn);
@@ -2243,7 +2243,7 @@ struct page *tdx_alloc_control_page(void)
 	if (!page)
 		return NULL;
 
-	if (tdx_pamt_get(page_to_pfn(page), NULL)) {
+	if (tdx_pamt_get(page_to_pfn(page), PG_LEVEL_4K, NULL)) {
 		__free_page(page);
 		return NULL;
 	}
@@ -2261,7 +2261,7 @@ void tdx_free_control_page(struct page *page)
 	if (!page)
 		return;
 
-	tdx_pamt_put(page_to_pfn(page));
+	tdx_pamt_put(page_to_pfn(page), PG_LEVEL_4K);
 	__free_page(page);
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
-- 
2.43.2


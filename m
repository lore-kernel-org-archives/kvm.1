Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ADC30FC26;
	Tue, 26 May 2026 02:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762936; cv=none; b=SxskdDG6myH21JKYfCJQ8wQ5+7K+f0KiaghrJRJ0QIOTUlLu4j/5RyrnmCiy/vB1TzvoNKYd/0oO7mLrHslhfuJrZikDPbFNPoIRSG41x+xCE/A9j3f2wchwosTwIlUZlBO5BwgyGhJEtqYl95shxCmHDYSAPVydjxY4li/nV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762936; c=relaxed/simple;
	bh=OmHDCZZupE7O81xE8LbEYOSeBHx149NCgEwlWGXPDCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPLZrv1NGiv6ulXQZi+5EMLzo35MBTBy3slI9v4TVZp9PoLWF3/WY2dLsv3BnLUJIfYJR/5pSD1cb3+9SyjcsPUbQnWRM7SedAfblsEXhYkmB78frLUWE6exs60rkD1GceW0Ta3ppNOW/G4bMvXceGfmkKixM3wIj8iBMAX3Hug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUxd3se5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUxd3se5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762934; x=1811298934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmHDCZZupE7O81xE8LbEYOSeBHx149NCgEwlWGXPDCU=;
  b=LUxd3se5g8DF1ijQzUFHzYbIn/Cy4Dk53nBEm59m/euMlL2/uf8bx54Z
   v5GDVUY5nRDQQrj+WjjP90kctb4dQYQ+T8WuAEYbHKyJyaDe47llz6TJu
   BIkmIHkcAbbbbc9uz9IbQ0tdvBT4ejUFiCynFtNv67XY+knIs8G5hqnGE
   0ujkNrrAiRQ7jN7I5d2MBA+M/6v8PJMQIol71qrWW6bAHWyVWJNm8XHCB
   262qdGWFlHptt5LlomuVNVAnGmBx8WdVBRi+BmcM+gC8gFPFCBUvkb4zQ
   BrBTlSapwX8GKBxGDl2mQ107xBI5EXtk5RP5e09IgnRbI67XAj54MWweQ
   A==;
X-CSE-ConnectionGUID: VbDuzsO9R/CAjf+GeAWeBA==
X-CSE-MsgGUID: EAF88qP8Tn69TG0mAz5Mxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677838"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677838"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: UbKHeqCuQhWpAr/y+92E7A==
X-CSE-MsgGUID: SMYgsFmETsyv3TV3QFMXVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878317"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v6 08/11] x86/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path
Date: Mon, 25 May 2026 19:35:12 -0700
Message-ID: <20260526023515.288829-9-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When handling an EPT violation, KVM holds a spinlock while manipulating
the EPT. Before entering the spinlock it doesn't know how many EPT page
tables will need to be installed or whether a huge page will be used. For
this reason it allocates a worst case number of page tables that it might
need as part of servicing the EPT violation.

Under Dynamic PAMT these pre-allocated pages will potentially need to have
Dynamic PAMT backing pages installed for them. KVM already has helpers to
manage topping up page caches before taking the MMU lock, but they cannot be
passed from KVM to arch/x86 code.

The problem of how and when to install the DPAMT backing pages for the
pages given to the TDX module during the fault path has had a lot of
design attempts.
 - Extracting KVM's MMU caches requires too much inlined code added to
   headers.
 - A few varieties of installing Dynamic PAMT backing when allocating the
   S-EPT page tables. [0][1]
 - Using mempool_t to transfer the pages between KVM and arch/x86 doesn't
   work because it is the component is designed more around maintaining a
   pool of pages, rather than topping up a continually drained cache.

So don't do these as they all had various problems. Instead just create a
small simple data structure to use for handing a pre-allocated list of
pages between KVM and arch/x86 code. Model this on KVM's existing MMU
memory caches.

Add a tdx_pamt_cache arg to tdx_pamt_get() so it can draw pages from a
cache when needed. Not all DPAMT page installations will happen under
spinlock, for example control pages. So have tdx_pamt_get() maintain the
existing behavior of allocating from the page allocator when NULL is
passed for the struct tdx_pamt_cache arg. This prevents excess allocations
for cases where it can be avoided.

Export the new helpers for KVM.

Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/kvm/de05853257e9cc66998101943f78a4b7e6e3d741.camel@intel.com/ [0]
Link: https://lore.kernel.org/kvm/aYprxnSHKHUtk7pt@google.com/ [1]
---
v6:
 - Filled out log from Sean's series
---
 arch/x86/include/asm/tdx.h  | 17 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 65 +++++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 74e75db5728c7..191da84bbf2a1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -155,6 +155,23 @@ static inline bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 	return false; /* To be enabled when kernel is ready */
 }
 
+/* Simple structure for pre-allocating Dynamic PAMT pages outside of locks. */
+struct tdx_pamt_cache {
+	struct list_head page_list;
+	int cnt;
+};
+
+static inline void tdx_init_pamt_cache(struct tdx_pamt_cache *cache)
+{
+	INIT_LIST_HEAD(&cache->page_list);
+	cache->cnt = 0;
+}
+
+void tdx_free_pamt_cache(struct tdx_pamt_cache *cache);
+int tdx_topup_pamt_cache(struct tdx_pamt_cache *cache, unsigned long npages);
+int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache);
+void tdx_pamt_put(kvm_pfn_t pfn);
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c41c632a4cdf2..3544794fb092a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1971,12 +1971,33 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
 
-static int alloc_pamt_array(struct page **pamt_pages)
+static struct page *tdx_alloc_page_pamt_cache(struct tdx_pamt_cache *cache)
+{
+	struct page *page;
+
+	page = list_first_entry_or_null(&cache->page_list, struct page, lru);
+	if (page) {
+		list_del(&page->lru);
+		cache->cnt--;
+	}
+
+	return page;
+}
+
+static struct page *alloc_dpamt_page(struct tdx_pamt_cache *cache)
+{
+	if (cache)
+		return tdx_alloc_page_pamt_cache(cache);
+
+	return alloc_page(GFP_KERNEL_ACCOUNT);
+}
+
+static int alloc_pamt_array(struct page **pamt_pages, struct tdx_pamt_cache *cache)
 {
 	int i, j;
 
 	for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
-		pamt_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
+		pamt_pages[i] = alloc_dpamt_page(cache);
 		if (!pamt_pages[i])
 			goto err;
 	}
@@ -2047,7 +2068,7 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 static DEFINE_SPINLOCK(pamt_lock);
 
 /* Bump PAMT refcount for the given page and allocate PAMT memory if needed */
-static int tdx_pamt_get(kvm_pfn_t pfn)
+int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
 	atomic_t *pamt_refcount;
@@ -2066,7 +2087,7 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	if (atomic_inc_not_zero(pamt_refcount))
 		return 0;
 
-	ret = alloc_pamt_array(pamt_pages);
+	ret = alloc_pamt_array(pamt_pages, cache);
 	if (ret)
 		return ret;
 
@@ -2106,12 +2127,13 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	free_pamt_array(pamt_pages);
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_pamt_get);
 
 /*
  * Drop PAMT refcount for the given page and free PAMT memory if it is no
  * longer needed.
  */
-static void tdx_pamt_put(kvm_pfn_t pfn)
+void tdx_pamt_put(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
 	atomic_t *pamt_refcount;
@@ -2152,6 +2174,37 @@ static void tdx_pamt_put(kvm_pfn_t pfn)
 
 	free_pamt_array(pamt_pages);
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_pamt_put);
+
+void tdx_free_pamt_cache(struct tdx_pamt_cache *cache)
+{
+	struct page *page;
+
+	while ((page = tdx_alloc_page_pamt_cache(cache)))
+		__free_page(page);
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_free_pamt_cache);
+
+int tdx_topup_pamt_cache(struct tdx_pamt_cache *cache, unsigned long npages)
+{
+	if (WARN_ON_ONCE(!tdx_supports_dynamic_pamt(&tdx_sysinfo)))
+		return 0;
+
+	npages *= TDX_DPAMT_ENTRY_PAGE_CNT;
+
+	while (cache->cnt < npages) {
+		struct page *page = alloc_page(GFP_KERNEL_ACCOUNT);
+
+		if (!page)
+			return -ENOMEM;
+
+		list_add(&page->lru, &cache->page_list);
+		cache->cnt++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_topup_pamt_cache);
 
 /*
  * Return a page that can be gifted to the TDX-Module for use as a "control"
@@ -2167,7 +2220,7 @@ struct page *tdx_alloc_control_page(void)
 	if (!page)
 		return NULL;
 
-	if (tdx_pamt_get(page_to_pfn(page))) {
+	if (tdx_pamt_get(page_to_pfn(page), NULL)) {
 		__free_page(page);
 		return NULL;
 	}
-- 
2.54.0


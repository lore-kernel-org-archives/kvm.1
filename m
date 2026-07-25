Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6EC313545;
	Sat, 25 Jul 2026 00:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939009; cv=none; b=SBjYNxjuiyxFsBz0l51q7Rq/NPoRv8AvbfGDiuBHJu6XlbyFQWe7R926kbf1L6XsDlA7eorb9oMyEKkfr3aZrjKm+cSHodSn5qcyzqDjqlgybM0VdcDX36tcuDIkvhnKO16aKbaoHI9bv2hxiGs94j5XK5A7ObmpRUbMK7opgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939009; c=relaxed/simple;
	bh=0NOePxtZ8NdiR/zvl/vVWPFzsE8oyQ+7OT9lHpAzT48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/GTNwc3KNf0K8RYzgV9ECWO5w9qUXZYhfKguNwP6S55p80G+QAoTmXLrNEFEyJthX/jkmeOiavhWC8pZAQ90qXE+NKutxk/6oK49+CULf0/G1CN+SDmso5LNbXy75R6zgl3UVbxIsNw5mM9A1D2q+RjypkY3GoEqgSjkERYWvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MvAPqkKJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MvAPqkKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784938999; x=1816474999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0NOePxtZ8NdiR/zvl/vVWPFzsE8oyQ+7OT9lHpAzT48=;
  b=MvAPqkKJhKImj5dM/Ht45SO9X68/4exeUBnHyPLjGHLZx9JbW9e0TF0Y
   1PPLaRXzZrj63+3R6AgFarMy5kRUe3tO/WeRXnn7p8Rlt7t1v6zryJ49x
   a6PLSt0o3CYF0gC3CdYRpgfUnbotUx+jdtPiVKm9Kdt7KpJVmBiFl4qkX
   iyBnC6REKWIN+07oeKIyB2Z/F7FRW2JakF735Ck/Jn0wp/t86gDHyJcef
   wRQ41oythkpe1saD9oqE9vHVEo3vaDv1XZOQns+OhKV9MD+DrBFYAUlKd
   LXXd0+rkrgvMblzacDCiZYJYE1KDawC2Wzd4D1r6Gj8P50oLj1+LnXNtG
   g==;
X-CSE-ConnectionGUID: /00Q2HgDS86ih6e+QCZBlA==
X-CSE-MsgGUID: Jzyy7Q7hSoaIBmaJ6Fn4IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726162"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726162"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
X-CSE-ConnectionGUID: DAS50OYFTj6TspEnclsGzg==
X-CSE-MsgGUID: bfRdYF0SRsyq17qHbjFpaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359268"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
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
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v8 07/11] x86/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path
Date: Fri, 24 Jul 2026 17:22:57 -0700
Message-ID: <20260725002302.3337017-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
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
manage topping up page caches before taking the MMU lock, but they cannot
be passed from KVM to arch/x86 code.

The problem of how and when to install the Dynamic PAMT backing pages for
the pages given to the TDX module during the fault path has had a lot of
design attempts.
 - Extracting KVM's MMU caches requires too much inlined code added to
   headers.
 - A few varieties of installing Dynamic PAMT backing when allocating the
   S-EPT page tables. (see links)
 - Using mempool_t to transfer the pages between KVM and arch/x86 doesn't
   work because the component is designed more around maintaining a pool
   of pages, rather than topping up a continually drained cache.

So don't do these as they all had various problems. Instead just create a
small simple data structure to use for handing a pre-allocated list of
pages between KVM and arch/x86 code. Model this on KVM's existing MMU
memory caches.

Add a tdx_pamt_cache arg to tdx_pamt_get() so it can draw pages from a
cache when needed. Not all Dynamic PAMT page installations will happen
under spinlock, for example TD and vCPU scoped control pages. So have
tdx_pamt_get() maintain the existing behavior of allocating from the page
allocator when NULL is passed for the struct tdx_pamt_cache arg. This
prevents excess allocations for cases where it can be avoided.

Export the new helpers for KVM.

AI was used under supervision to review code and workshop logs.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/kvm/aXENNKjAKTM9UJNH@google.com/
Link: https://lore.kernel.org/kvm/20260129011517.3545883-20-seanjc@google.com/
Link: https://lore.kernel.org/kvm/aYW5CbUvZrLogsWF@yzhao56-desk.sh.intel.com/
---
v7:
 - Log/comment tweaks (Yan)
 - Drop Assisted-by tag and cover AI use in log (Dave)

v6:
 - Filled out log from Sean's series
---
 arch/x86/include/asm/tdx.h  | 17 ++++++++++
 arch/x86/virt/vmx/tdx/tdx.c | 65 +++++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 86bf37b15c705..9cbd250bbd39b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -120,6 +120,23 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo);
 
+/* Simple structure for pre-allocating Dynamic PAMT pages outside of spinlocks. */
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
index 0e6063c1405bc..4d90d1a555135 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2045,12 +2045,33 @@ bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 	return false;
 }
 
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
@@ -2124,7 +2145,7 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 static DEFINE_SPINLOCK(pamt_lock);
 
 /* Bump PAMT refcount for the given pfn and allocate PAMT backing if needed. */
-static int tdx_pamt_get(kvm_pfn_t pfn)
+int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
 	atomic_t *pamt_refcount;
@@ -2134,7 +2155,7 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return 0;
 
-	ret = alloc_pamt_array(pamt_pages);
+	ret = alloc_pamt_array(pamt_pages, cache);
 	if (ret)
 		return ret;
 
@@ -2166,9 +2187,10 @@ static int tdx_pamt_get(kvm_pfn_t pfn)
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_pamt_get);
 
 /* Drop PAMT refcount for the given pfn and free PAMT backing if needed. */
-static void tdx_pamt_put(kvm_pfn_t pfn)
+void tdx_pamt_put(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
 	atomic_t *pamt_refcount;
@@ -2209,6 +2231,37 @@ static void tdx_pamt_put(kvm_pfn_t pfn)
 out_unlock:
 	spin_unlock(&pamt_lock);
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
@@ -2223,7 +2276,7 @@ struct page *tdx_alloc_control_page(void)
 	if (!page)
 		return NULL;
 
-	if (tdx_pamt_get(page_to_pfn(page))) {
+	if (tdx_pamt_get(page_to_pfn(page), NULL)) {
 		__free_page(page);
 		return NULL;
 	}
-- 
2.54.0


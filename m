Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AD256C70;
	Sat, 18 Jul 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339127; cv=none; b=iOdoJjdPh6MVMAF4iWX3tpwLM/yyiQE98d0l8ElTXTIiYCuPl+LAsgBdezs79AmT2yy5gMbqSXyTwSHWOfkDFo50/x31tD3SCsnHgv0cSBbPOloVRQM8iErGMrnYIqJNcNnh2Z8tdg7VLFBDK4SIWFGxdi0MX5NkY0itdPhiI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339127; c=relaxed/simple;
	bh=/ajGMImpY2ZjUqHutJCj2FAmYE7evsIR4gQJ80vgUhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aqavk9n+idcjESOPmbJ5u0N5FfLF+aHimHVdm+r2FSK1tb+P4g2u917MPkgXymlQqNZCKHq8b0r3ms7UJcTvy2xZL3Ly3397+N4wdL9ZuW0op9FzNe58t/HIw7Na+6ZXMrHg+gQLBpF9mYgj5kczq6ui7nEiqWcYcQ+14HyVcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8Y6OthY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8Y6OthY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784339122; x=1815875122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/ajGMImpY2ZjUqHutJCj2FAmYE7evsIR4gQJ80vgUhQ=;
  b=G8Y6OthYaST1G5pi0dW52ixpiMjpC2Woql590KsaZ7Y/w7uBvUHfJw5m
   DOzgoV+iDDWm6qUR3VLJiZdAIaa4FbTW3UpjI074p93JBoPfjdRbjcCqk
   o7rYgTlbfyp+3JLVqsDy4JM8AUl/tTb//vLgiD2eKI+b8TCFtM2Cr58oK
   nsuEoz50BG6wobpR3z2r9rHnWlsZbV5tpZA5bUfBDWRwv5b8B2O8GjO36
   AsCkGt12C2Zux29CrpnhzXWGqGlBhbjm0i5BitmLlDOGmOJjL2d/AaIbM
   Gp22nlleyqRpHYqDD8LnOoq5DKUxCfgOxfLe9CptQsNrS/8zfjW+ZuK/w
   g==;
X-CSE-ConnectionGUID: OSimKaVZTwWYQGJE2N6/Ig==
X-CSE-MsgGUID: zbstQeKXRhap6PHIpGyBiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96377134"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="96377134"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:16 -0700
X-CSE-ConnectionGUID: oVpC3y3BRUaa1/3gez7pNw==
X-CSE-MsgGUID: Iwhigj6GRgurQoHE5bxcMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="254296278"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:09 -0700
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
	binbin.wu@intel.com
Cc: rick.p.edgecombe@intel.com,
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v7 07/11] x86/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path
Date: Fri, 17 Jul 2026 18:44:56 -0700
Message-ID: <20260718014500.2231262-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
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
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
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
index 343d0cccc9874..e2f11b0ba46ce 100644
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


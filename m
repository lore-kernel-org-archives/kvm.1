Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFA33A71A;
	Thu,  3 Sep 2026 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400298; cv=none; b=gwJnZt/77ZcUW4hhnumDK4P7QBYApcccKzoQHQ7qnGcTrgJXhzXPcPh0RruxRQUXyxxI/RpHahd3x6QXPv21i5H3MeP0cEZUu8l7ERzSM8wxwyjC12fahMsY/+bWUjC0I/WYWwd38pvphNlig9Gve/fS2nrwpc++reiVsfRTVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400298; c=relaxed/simple;
	bh=iA901QX0ICW3/nK/d5Wp8EzNVv2A6U90sa7YtRVw97w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vsrvzm30uDb9bIo8snuwNJHCTahcgMuEtdf7GW0pebAcqU2CDX0fK9TmLlx9nF4lvFrbw2wJGjTN+D45VDLQ9/O/uEHpRYZOTozw3hJu68MCYJmbFeqknpsFCnFULY3x/TjqJOBLF+9FiFI8BGbsQ7B8lYRYx/9Cz3sngsEYZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nGOPTdPa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nGOPTdPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400296; x=1819936296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iA901QX0ICW3/nK/d5Wp8EzNVv2A6U90sa7YtRVw97w=;
  b=nGOPTdPaKOxHVXAFq1u35HqWN5UYHd9QQVxanGxeuKY7Lgi1wQwu1GwB
   EWAnacVx3lConqc/m6Y23ilSApD22bB5uJh9I4wvlyh7Gw9aU8j8q91xM
   jNeHYZnqLkBw5uAqnVXyuSvh7LtJdONgLcqNZ+DokZRjqlxwFoJ9w9A3L
   x1ifWcKefncFx9w5qovt0/jxemJMMMEQGR10jSQqXHxxEg4XgLW3ClLix
   Wz07feV1IFxZ0MjPh6M1WAHOx/aHf2mOqIEKiFIWIBKjLkEBrzPmUFX0M
   7bMxEi/Gta7BW2l/y/CzlCYmOb7Tq5U09idBl8xSZkQRdDnRcep9fEXfA
   w==;
X-CSE-ConnectionGUID: zdYN8dmUQTumo75BDsyJ1Q==
X-CSE-MsgGUID: ElnYxqMOSzexYlnhxPiiXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469176"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469176"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:23 -0700
X-CSE-ConnectionGUID: XYjQ4mRLRxeK8xyNUJi1Vg==
X-CSE-MsgGUID: uuAKoUD8Trqhy2WPZdifyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770232"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:22 -0700
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
	Binbin Wu <binbin.wu@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v10 07/11] x86/virt/tdx: Add APIs to support Dynamic PAMT ops from KVM's fault path
Date: Wed,  2 Sep 2026 18:51:09 -0700
Message-ID: <20260903015113.93343-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
References: <20260903015113.93343-1-rick.p.edgecombe@intel.com>
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

Under Dynamic PAMT (DPAMT) these pre-allocated pages will potentially need
to have DPAMT backing pages installed for them. KVM already has helpers to
manage topping up page caches before taking the MMU lock, but they cannot
be passed from KVM to arch/x86 code.

The problem of how and when to install the DPAMT backing pages for the
pages given to the TDX module during the fault path has had a lot of
design attempts.
 - Extracting KVM's MMU caches requires too much inlined code added to
   headers.
 - A few varieties of installing DPAMT backing when allocating the
   S-EPT page tables. (see links)
 - Using mempool_t to transfer the pages between KVM and arch/x86 doesn't
   work because the component is designed more around maintaining a pool
   of pages, rather than topping up a continually drained cache.

So don't do these as they all had various problems. Instead just create a
small simple data structure to use for handing a pre-allocated list of
pages between KVM and arch/x86 code. Model this on KVM's existing MMU
memory caches.

Add a tdx_pamt_cache arg to tdx_pamt_get() so it can draw pages from a
cache when needed. Not all DPAMT page installations will happen under
spinlock, for example TD and vCPU scoped control pages. So have
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
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/kvm/aXENNKjAKTM9UJNH@google.com/
Link: https://lore.kernel.org/kvm/20260129011517.3545883-20-seanjc@google.com/
Link: https://lore.kernel.org/kvm/aYW5CbUvZrLogsWF@yzhao56-desk.sh.intel.com/
---
v10:
 - Change "Dynamic PAMT" to "DPAMT" in comments, and in the second
   reference in the logs. (Dave)
 - x86/tdx -> x86/virt/tdx in title to match the others (AI nit checker)

v7:
 - Log/comment tweaks (Yan)
 - Drop Assisted-by tag and cover AI use in log (Dave)

v6:
 - Filled out log from Sean's series
---
 arch/x86/include/asm/tdx.h  | 16 +++++++++-
 arch/x86/virt/vmx/tdx/tdx.c | 61 ++++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index f7442ad20e46d..8c7839d61296d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -120,7 +120,21 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo);
 
-int tdx_pamt_get(kvm_pfn_t pfn);
+/* Simple structure for pre-allocating DPAMT pages outside of spinlocks. */
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
 void tdx_pamt_put(kvm_pfn_t pfn);
 
 int tdx_guest_keyid_alloc(void);
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c347600a0aabb..39865a2da5822 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -2050,12 +2050,33 @@ bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
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
@@ -2132,7 +2153,7 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 static DEFINE_SPINLOCK(dpamt_lock);
 
 /* Bump DPAMT refcount for the given pfn and allocate DPAMT backing if needed. */
-int tdx_pamt_get(kvm_pfn_t pfn)
+int tdx_pamt_get(kvm_pfn_t pfn, struct tdx_pamt_cache *cache)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
 	atomic_t *dpamt_refcount;
@@ -2142,7 +2163,7 @@ int tdx_pamt_get(kvm_pfn_t pfn)
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return 0;
 
-	ret = alloc_pamt_array(pamt_pages);
+	ret = alloc_pamt_array(pamt_pages, cache);
 	if (ret)
 		return ret;
 
@@ -2220,6 +2241,36 @@ void tdx_pamt_put(kvm_pfn_t pfn)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_pamt_put);
 
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
+
 /*
  * Return a page that can be gifted to the TDX module for use as a "control"
  * page, i.e. pages that are used for control structures for a given TDX
@@ -2233,7 +2284,7 @@ struct page *tdx_alloc_control_page(void)
 	if (!page)
 		return NULL;
 
-	if (tdx_pamt_get(page_to_pfn(page))) {
+	if (tdx_pamt_get(page_to_pfn(page), NULL)) {
 		__free_page(page);
 		return NULL;
 	}
-- 
2.55.0


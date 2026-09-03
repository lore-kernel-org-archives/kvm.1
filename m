Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D03264D5;
	Thu,  3 Sep 2026 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400294; cv=none; b=S+H9GWeWUapiYDY3Hr91bfjcMHw+nVb26hvmbECwPzN78+zTtP4IAL4OJCndWX1pdyw0AsJcu2jSPGhxwlnvWC03O/5LNmMXF5pQfRrA6GCg73z31ACJ1E7DyTIP6XRpPo5NgfGPrm6RYnyjgkajzhYzvxOfAq9tUA0VjMJcWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400294; c=relaxed/simple;
	bh=0ATsA5a4UXrVPY7m3QHhBQ8gRb0cejBmI6g7gF/r/xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nP/n5WaqsADLGVSa4rxNQdI9hYAyAmi9mmE22zNifySLaFXzWxwrUTVXXDZ+vGJFVfW3nHc6uOctZdZLujf9W8A/D7PRxBLw7gg1iyXIklwcBAEcb9Megmi0Mq0iMznaTcU/39js2DPWj/Rvlcl8vL8yq8TsRL8M157ax7NXqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXzxTgsO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXzxTgsO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400291; x=1819936291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ATsA5a4UXrVPY7m3QHhBQ8gRb0cejBmI6g7gF/r/xY=;
  b=NXzxTgsOc1Vgaxyee3varqn05WZ42Cv2J3yloywKgi7D6efbPVZiMEbM
   zTOx4qbmubb+tXZ2R7jsCH6PVpRj9w7DFCOkTqzX+cG9PtDG1Y9Hy/yZX
   ArlgzqPuls64zo62zhzKA6O0RH1Aa+2R5/wbnCfCXoLFLorCetQwZVpHg
   oI1Ub3elITxXvageubEUik38W6YkXINPmTV/4kMLunxSiY7vdmxL/GnIQ
   UweSlaEeexxIOuFY3GU1tBaVOUN63TPXMrfTGXnC8CkXsE4quCW95ZO8J
   Cb1HZWMZwuVToY+YzaNPxlRRZJqL0f37yugpk8nKsz8fB0p7023kEnsvu
   A==;
X-CSE-ConnectionGUID: 9xxsW+VlR6OsRAc0hJ3kHQ==
X-CSE-MsgGUID: IkUiffTnRXOh27GENfPxsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469161"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469161"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:23 -0700
X-CSE-ConnectionGUID: wgbZty8sS7WcBud055nXVQ==
X-CSE-MsgGUID: 8KLNpbu9TYiT5opgk4abCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770226"
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
Subject: [PATCH v10 05/11] x86/virt/tdx: Handle multiple callers in tdx_pamt_get/put()
Date: Wed,  2 Sep 2026 18:51:07 -0700
Message-ID: <20260903015113.93343-6-rick.p.edgecombe@intel.com>
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

__tdx_pamt_get()/__tdx_pamt_put() unconditionally add or remove Dynamic
PAMT (DPAMT) backing for the 2MB region covering the passed page. However,
multiple callers can add or remove 4KB pages that fall within the same 2MB
region and in that scenario only a single PAMT entry is required.

Make the helpers handle only adding/removing DPAMT backing when required,
by refcounting each 2MB range. Gate the actual DPAMT add and remove on
refcount transitions (0->1 and 1->0). Serialize the refcount check and
SEAMCALL with a global spinlock so the read-decide-act sequence is atomic.
This also avoids TDX module BUSY errors, as the DPAMT add and remove
SEAMCALLs take internal TDX module locks for the 2MB ranges of the
specified PFN and the PAMT page pair PFNs. So simultaneous attempts on
the same 2MB ranges of the PFNs would otherwise encounter an error, which
would not be handleable in the put case.

The lock is global and heavyweight. Use simple conditional logic to keep
correctness obvious. This will be optimized in a later change.

The dpamt_refcounts[] are atomic_t's. They do not strictly need to be
because all access is protected by pamt_lock. The overhead of an atomic_t
in this situation is minuscule compared to the global lock. Leave the
atomic_t in place to enable future optimization with minimal churn.

Since the DPAMT helpers are broadly functional now, drop the "__"
to rename them tdx_pamt_get/put() and tdx_alloc/free_control_page().
Export them for use in KVM in subsequent changes.

AI was used under supervision to collect/apply feedback, split patches,
review code and workshop logs.

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Rename the helper functions in this patch after changes to patch
   "x86/virt/tdx: Add tdx_alloc/free_control_page() helpers".
 - Remove the comments around helper limitations, leaving to be as they
   were in v9, except for the "TDX module" wording fix.
 - Export tdx_alloc/free_control_page() in this patch as a result of
   changes in "x86/virt/tdx: Add tdx_alloc/free_control_page()
   helpers" to make them private functions initially. Since they now become
   more broadly functional here, do the export in this patch.
 - For consistency, also move the tdx_pamt_get/put() export here too.
 - Change "Dynamic PAMT" to "DPAMT" in comments, and in the second
   reference in the logs. (Dave)
 - Rename "pamt" gunk to "dpamt". (Dave)

v8:
 - Fix PAMT capitalization in comment (Sohil)

v7:
 - Convert scoped_guard() blocks to use normal spin_un/lock() for the
   sake of making next patches diff cleaner
 - Drop __maybe_unused from tdx_find_pamt_refcount() (Binbin)
 - Switch to atomic_inc_not_zero() (Dave)
 - Justify use of atomic_t in log (Sohil)
 - Log/comments (Yan)
 - Drop Assisted-by tag and cover AI use in log (Dave)
---
 arch/x86/include/asm/tdx.h  |   6 +++
 arch/x86/virt/vmx/tdx/tdx.c | 102 ++++++++++++++++++++----------------
 2 files changed, 63 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d414064436221..f7442ad20e46d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -120,12 +120,18 @@ static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinf
 
 bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo);
 
+int tdx_pamt_get(kvm_pfn_t pfn);
+void tdx_pamt_put(kvm_pfn_t pfn);
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
 
 void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
 
+struct page *tdx_alloc_control_page(void);
+void tdx_free_control_page(struct page *page);
+
 struct tdx_td {
 	/* TD root structure: */
 	struct page *tdr_page;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 305289bd673be..c347600a0aabb 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -292,7 +292,7 @@ static __init void free_dpamt_refcounts(void)
 	dpamt_refcounts = NULL;
 }
 
-static __maybe_unused atomic_t *tdx_find_dpamt_refcount(unsigned long pfn)
+static atomic_t *tdx_find_dpamt_refcount(unsigned long pfn)
 {
 	/* Find which PMD a PFN is in. */
 	unsigned long index = pfn >> (PMD_SHIFT - PAGE_SHIFT);
@@ -2097,7 +2097,7 @@ static u64 pamt_2mb_arg(kvm_pfn_t pfn)
 	return hpa_2mb | TDX_PS_2M;
 }
 
-/* Add PAMT backing for the 2MB region surrounding the given pfn. */
+/* Add DPAMT backing for the 2MB region surrounding the given pfn. */
 static u64 tdh_phymem_pamt_add(kvm_pfn_t pfn, struct page **pamt_pages)
 {
 	struct tdx_module_args args = {
@@ -2109,7 +2109,7 @@ static u64 tdh_phymem_pamt_add(kvm_pfn_t pfn, struct page **pamt_pages)
 	return seamcall(TDH_PHYMEM_PAMT_ADD, &args);
 }
 
-/* Remove PAMT backing for the 2MB region surrounding the given pfn. */
+/* Remove DPAMT backing for the 2MB region surrounding the given pfn. */
 static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 {
 	struct tdx_module_args args = {
@@ -2128,20 +2128,14 @@ static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
 	return 0;
 }
 
-/*
- * Allocate DPAMT memory for the 2MB aligned region  surrounding
- * the given page.
- *
- * Only call this when the pfn is known not to already have Dynamic
- * PAMT pages in the TDX module for it.
- *
- * Effectively it is not (yet) like a get, and more like a manual
- * manipulation of the DPAMT backing for the 2MB aligned range
- * covered by the pfn.
- */
-static int __tdx_pamt_get(kvm_pfn_t pfn)
+/* Serializes adding/removing DPAMT memory */
+static DEFINE_SPINLOCK(dpamt_lock);
+
+/* Bump DPAMT refcount for the given pfn and allocate DPAMT backing if needed. */
+int tdx_pamt_get(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
+	atomic_t *dpamt_refcount;
 	u64 tdx_status;
 	int ret;
 
@@ -2152,41 +2146,59 @@ static int __tdx_pamt_get(kvm_pfn_t pfn)
 	if (ret)
 		return ret;
 
+	dpamt_refcount = tdx_find_dpamt_refcount(pfn);
+
+	spin_lock(&dpamt_lock);
+
+	/*
+	 * If the DPAMT entry is already added (i.e. refcount >= 1),
+	 * then just increment the refcount.
+	 */
+	if (atomic_inc_not_zero(dpamt_refcount))
+		goto out_free;
+
+	/* Try to add the PAMT page and take the refcount 0->1. */
 	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
-	if (tdx_status != TDX_SUCCESS) {
+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS)) {
 		ret = -EIO;
 		goto out_free;
 	}
 
+	atomic_set(dpamt_refcount, 1);
+	spin_unlock(&dpamt_lock);
 	return 0;
 
 out_free:
+	spin_unlock(&dpamt_lock);
 	free_pamt_array(pamt_pages);
 
 	return ret;
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_pamt_get);
 
-/*
- * Free DPAMT memory for the 2MB aligned region surrounding the
- * given page. Only call this when the pfn is known to already
- * have DPAMT pages in the TDX module for it, and no other pfns
- * in the aligned 2MB physical region still need it.
- *
- * Don't make multiple calls concurrently of __tdx_pamt_get/put(),
- * as there is no protections from races.
- *
- * Effectively it is not (yet) like a refcounted put, and more like a
- * manual manipulation of the DPAMT backing for the 2MB aligned
- * range covered by the pfn.
- */
-static void __tdx_pamt_put(kvm_pfn_t pfn)
+/* Drop DPAMT refcount for the given pfn and free DPAMT backing if needed. */
+void tdx_pamt_put(kvm_pfn_t pfn)
 {
 	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
+	atomic_t *dpamt_refcount;
 	u64 tdx_status;
 
 	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
 		return;
 
+	dpamt_refcount = tdx_find_dpamt_refcount(pfn);
+
+	spin_lock(&dpamt_lock);
+	/*
+	 * If there is more than 1 reference on the DPAMT entry, don't
+	 * remove it yet. Just decrement the refcount.
+	 */
+	if (atomic_read(dpamt_refcount) > 1) {
+		atomic_dec(dpamt_refcount);
+		goto out_unlock;
+	}
+
+	/* Try to remove the pamt page and take the refcount 1->0. */
 	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
 
 	/*
@@ -2194,23 +2206,26 @@ static void __tdx_pamt_put(kvm_pfn_t pfn)
 	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
 	 * there is no risk of data corruption, but do yell loudly as
 	 * failure indicates a kernel bug, memory is being leaked, and
-	 * the dangling PAMT entry may cause future operations to fail.
+	 * the dangling DPAMT entry may cause future operations to fail.
 	 */
 	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
-		return;
+		goto out_unlock;
 
+	atomic_set(dpamt_refcount, 0);
+	spin_unlock(&dpamt_lock);
 	free_pamt_array(pamt_pages);
+	return;
+out_unlock:
+	spin_unlock(&dpamt_lock);
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_pamt_put);
 
 /*
  * Return a page that can be gifted to the TDX module for use as a "control"
  * page, i.e. pages that are used for control structures for a given TDX
- * guest, and thus obtain TDX protections, including PAMT tracking.
- *
- * This function is currently only safe to call once. And not safe to call
- * if __tdx_pamt_get() is called before or after.
+ * guest, and thus obtain TDX protections, including DPAMT tracking.
  */
-static __maybe_unused struct page *__tdx_alloc_control_page(void)
+struct page *tdx_alloc_control_page(void)
 {
 	struct page *page;
 
@@ -2218,31 +2233,28 @@ static __maybe_unused struct page *__tdx_alloc_control_page(void)
 	if (!page)
 		return NULL;
 
-	if (__tdx_pamt_get(page_to_pfn(page))) {
+	if (tdx_pamt_get(page_to_pfn(page))) {
 		__free_page(page);
 		return NULL;
 	}
 
 	return page;
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_alloc_control_page);
 
 /*
  * Free a page that was gifted to the TDX module for use as a control
  * page. After this, the page is no longer protected by TDX.
- *
- * Like __tdx_pamt_put(), this is currently only safe to call this when
- * a page is already known to have DPAMT pages in the TDX module for
- * it, and no other pages in the aligned 2MB physical region will
- * still need the backing.
  */
-static __maybe_unused void __tdx_free_control_page(struct page *page)
+void tdx_free_control_page(struct page *page)
 {
 	if (!page)
 		return;
 
-	__tdx_pamt_put(page_to_pfn(page));
+	tdx_pamt_put(page_to_pfn(page));
 	__free_page(page);
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
 
 void tdx_sys_disable(void)
 {
-- 
2.55.0


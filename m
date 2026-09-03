Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372232142B;
	Thu,  3 Sep 2026 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400290; cv=none; b=eeS+1CHUk80+d/J9Gr2FX9JiSWOPKtav9eyCDx3gHgsNew+EBXTwWcW8Qj11URib56DcGXpP3wk0nUY/A8n5lEaKoz/9vf2DcHFxbPCt4UfbiVYnP+qZTPnKz5/1nQhed6gpsi2ucsZBmPJyhhvX4gRi/9vtMs04Sf6WKCvNefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400290; c=relaxed/simple;
	bh=TY8J5Ch3wZ2pp/ME9tYfTBbVh4Ftdl+nu8+TiOsTr4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwilrMKT348dlQOXuBQqE4hel0wbmQur6AY34bcW3Odt3ADHUcjT927s4H5gCw2Lze03THQEb3qF4nMAGp1jAVIlMMtSZd33rrAeq5FMGo+L9KxvWOYCWd0kpqDxQJpfiGI2Ms/4JrN0Nxzl+Rsv1S0bZnobWtq/+xZQDY59ShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNxMmgaS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNxMmgaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400287; x=1819936287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TY8J5Ch3wZ2pp/ME9tYfTBbVh4Ftdl+nu8+TiOsTr4Q=;
  b=iNxMmgaSMXa0jV4sL89aKQtE17KMgmcmIFG1LRP/u4d2LPysJhpBRG4t
   uELXmE6zOOHgSOJJU6E1KkRAsLgGcfk0mXdtgnjHJbdWkTkQN0q5IECny
   anq0BX/y2G48WRxToqj9i9auecHfzq8bWozfYEbMoUTp5HzTh9FQB7ePy
   NijvK0ancV34vEP7ZVGx9KNf150BWdTmax1H1A7wFNfYr17LFO58RM9UO
   ClRsLFwbefCA7f8wP/IbcUDGwblcVLRzTaw44Z6JeKN2CIjvPmzPTIbTd
   krIFXdaHIsQC600HsOK/6cc0bFN77Txss0hfhU+NZNvd7lzOmF2B/cYy+
   w==;
X-CSE-ConnectionGUID: ASQWjAnCSAaYOYmIsH8mgg==
X-CSE-MsgGUID: 3e+T2aBxSHKUPgphw02sfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469134"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469134"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:22 -0700
X-CSE-ConnectionGUID: no+LsAO8R3imMWpUY1Z10A==
X-CSE-MsgGUID: Lpc8+a84RE2jCUNJacou3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770219"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:21 -0700
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
Subject: [PATCH v10 03/11] x86/virt/tdx: Add __tdx_pamt_get/put() helpers
Date: Wed,  2 Sep 2026 18:51:05 -0700
Message-ID: <20260903015113.93343-4-rick.p.edgecombe@intel.com>
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

Add helpers to use when allocating or preparing pages that are handed to
the TDX module for use as control/S-EPT pages, and thus need Dynamic PAMT
(DPAMT) adjustments.

The TDX module tracks some state for each page of physical memory that it
might use. It calls this state the PAMT. It includes separate state for
each page size a physical page could be utilized at within the TDX module
(1GB, 2MB, 4KB). In DPAMT, only the 4KB page size state is
allocated dynamically.

KVM will need to hand pages to the TDX module that it will use at 4KB
granularity. So these pages will need DPAMT backing added before they are
used by the TDX module, and removed afterwards.

Create __tdx_pamt_get/put() to handle installing DPAMT 4KB backing for
pages that are already allocated (such as KVM's use of S-EPT page tables
or guest private memory). Have them take a pfn instead of a struct page,
as future changes will want to use these helpers for guest pages which are
tracked by PFN.

Also add __tdx_alloc_control_page() and __tdx_free_control_page() to handle
both page allocation and DPAMT installation. Make them behave like
normal alloc/free functions where allocation can fail in the case of no
memory, but free (with any necessary DPAMT release) always
succeeds. Do this so they can eventually support the existing TDX flows
that require teardowns to succeed.

Don't CLFLUSH the DPAMT pages handed to the TDX module, as is done
for some other SEAMCALLs, as the TDX docs specify that this is only
needed on "TD private memory or TD control structure page".

Since these allocations will be easily user triggerable, account the
memory.

Only one pair of DPAMT pages is required for each 2MB-aligned physical
region, so multiple callers could trip over each other if they try to
manage the shared backing for two separate 4KB pages contained in one.
To build the logic up iteratively, don't do anything to handle pages
from the same 2MB region yet. Functionality to handle this will be added
before DPAMT can be enabled.

AI was used under supervision to collect/apply feedback, split patches,
review code and workshop logs.

Based on a patch originally by Kiryl Shutsemau.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Clarify in comments about the limitations of the helpers added. (Dave)
 - Add comments in pamt_2mb_arg() about what is going on (Dave)
 - Prepend helpers with __ (Dave)
 - Align tdx_module_args args (Dave)
 - Standardize "TDX Module" (Dave)
 - Remove exports for newly private __ functions.
 - Move TDX_DPAMT_ENTRY_PAGE_CNT out of header to sole file that uses it.
   (AI nit checker)
 - Standardize for loop iterators declaration. (Nit checker)
 - Change "Dynamic PAMT" to "DPAMT" in comments, and in the second
   reference in the logs. (Dave)

v9:
 - Address about how the log doesn't fully cover the limitations at this
   stage. (Sashiko)

v7:
 - Comment improvements (Chao)
 - Drop unneeded addition of mm.h header include (Binbin)
 - Log clarity, code style nits (Sohil)
 - Drop Assisted-by tag and cover AI use in log (Dave)
---
 arch/x86/virt/vmx/tdx/tdx.c | 197 ++++++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |   2 +
 2 files changed, 199 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 54074ddcce858..9caaa5de28817 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -46,6 +46,9 @@
 #include "seamcall_internal.h"
 #include "tdx.h"
 
+/* Number of DPAMT pages to be provided to TDX module per 2MB region of PA */
+#define TDX_DPAMT_ENTRY_PAGE_CNT 2
+
 struct tdx_module_state {
 	bool initialized;
 	bool sysinit_done;
@@ -1996,6 +1999,200 @@ bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
 	return false;
 }
 
+static int alloc_pamt_array(struct page **pamt_pages)
+{
+	int i, j;
+
+	for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
+		pamt_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
+		if (!pamt_pages[i])
+			goto err;
+	}
+
+	return 0;
+
+err:
+	for (j = 0; j < i; j++)
+		__free_page(pamt_pages[j]);
+
+	return -ENOMEM;
+}
+
+static void free_pamt_array(struct page **pamt_pages)
+{
+	int i;
+
+	for (i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
+		/*
+		 * Reset pages unconditionally to cover cases
+		 * where they were passed to the TDX module.
+		 */
+		tdx_quirk_reset_paddr(page_to_phys(pamt_pages[i]), PAGE_SIZE);
+
+		__free_page(pamt_pages[i]);
+	}
+}
+
+/* Helper for building DPAMT seamcall() arguments. */
+static u64 pamt_2mb_arg(kvm_pfn_t pfn)
+{
+	/* Find the 2MB-wide DPAMT region for 'pfn': */
+	unsigned long hpa_2mb = ALIGN_DOWN(pfn << PAGE_SHIFT, PMD_SIZE);
+
+	/*
+	 * TDX ABI requires specifying the page level the installed DPAMT
+	 * backing will cover, even though today only 2MB is supported.
+	 */
+	return hpa_2mb | TDX_PS_2M;
+}
+
+/* Add PAMT backing for the 2MB region surrounding the given pfn. */
+static u64 tdh_phymem_pamt_add(kvm_pfn_t pfn, struct page **pamt_pages)
+{
+	struct tdx_module_args args = {
+		.rcx = pamt_2mb_arg(pfn),
+		.rdx = page_to_phys(pamt_pages[0]),
+		.r8  = page_to_phys(pamt_pages[1]),
+	};
+
+	return seamcall(TDH_PHYMEM_PAMT_ADD, &args);
+}
+
+/* Remove PAMT backing for the 2MB region surrounding the given pfn. */
+static u64 tdh_phymem_pamt_remove(kvm_pfn_t pfn, struct page **pamt_pages)
+{
+	struct tdx_module_args args = {
+		.rcx = pamt_2mb_arg(pfn),
+	};
+	u64 ret;
+
+	ret = seamcall_ret(TDH_PHYMEM_PAMT_REMOVE, &args);
+	if (ret)
+		return ret;
+
+	/* Copy PAMT pages out of the struct per the TDX ABI */
+	pamt_pages[0] = phys_to_page(args.rdx);
+	pamt_pages[1] = phys_to_page(args.r8);
+
+	return 0;
+}
+
+/*
+ * Allocate DPAMT memory for the 2MB aligned region  surrounding
+ * the given page.
+ *
+ * Only call this when the pfn is known not to already have Dynamic
+ * PAMT pages in the TDX module for it.
+ *
+ * Effectively it is not (yet) like a get, and more like a manual
+ * manipulation of the DPAMT backing for the 2MB aligned range
+ * covered by the pfn.
+ */
+static int __tdx_pamt_get(kvm_pfn_t pfn)
+{
+	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT];
+	u64 tdx_status;
+	int ret;
+
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return 0;
+
+	ret = alloc_pamt_array(pamt_pages);
+	if (ret)
+		return ret;
+
+	tdx_status = tdh_phymem_pamt_add(pfn, pamt_pages);
+	if (tdx_status != TDX_SUCCESS) {
+		ret = -EIO;
+		goto out_free;
+	}
+
+	return 0;
+
+out_free:
+	free_pamt_array(pamt_pages);
+
+	return ret;
+}
+
+/*
+ * Free DPAMT memory for the 2MB aligned region surrounding the
+ * given page. Only call this when the pfn is known to already
+ * have DPAMT pages in the TDX module for it, and no other pfns
+ * in the aligned 2MB physical region still need it.
+ *
+ * Don't make multiple calls concurrently of __tdx_pamt_get/put(),
+ * as there is no protections from races.
+ *
+ * Effectively it is not (yet) like a refcounted put, and more like a
+ * manual manipulation of the DPAMT backing for the 2MB aligned
+ * range covered by the pfn.
+ */
+static void __tdx_pamt_put(kvm_pfn_t pfn)
+{
+	struct page *pamt_pages[TDX_DPAMT_ENTRY_PAGE_CNT] = {};
+	u64 tdx_status;
+
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return;
+
+	tdx_status = tdh_phymem_pamt_remove(pfn, pamt_pages);
+
+	/*
+	 * Don't free pamt_pages as it could hold garbage when
+	 * tdh_phymem_pamt_remove() fails.  Don't panic/BUG_ON(), as
+	 * there is no risk of data corruption, but do yell loudly as
+	 * failure indicates a kernel bug, memory is being leaked, and
+	 * the dangling PAMT entry may cause future operations to fail.
+	 */
+	if (WARN_ON_ONCE(tdx_status != TDX_SUCCESS))
+		return;
+
+	free_pamt_array(pamt_pages);
+}
+
+/*
+ * Return a page that can be gifted to the TDX module for use as a "control"
+ * page, i.e. pages that are used for control structures for a given TDX
+ * guest, and thus obtain TDX protections, including PAMT tracking.
+ *
+ * This function is currently only safe to call once. And not safe to call
+ * if __tdx_pamt_get() is called before or after.
+ */
+static struct page * __maybe_unused __tdx_alloc_control_page(void)
+{
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL_ACCOUNT);
+	if (!page)
+		return NULL;
+
+	if (__tdx_pamt_get(page_to_pfn(page))) {
+		__free_page(page);
+		return NULL;
+	}
+
+	return page;
+}
+
+/*
+ * Free a page that was gifted to the TDX module for use as a control
+ * page. After this, the page is no longer protected by TDX.
+ *
+ * Like __tdx_pamt_put(), this is currently only safe to call this when
+ * a page is already known to have DPAMT pages in the TDX module for
+ * it, and no other pages in the aligned 2MB physical region will
+ * still need the backing.
+ */
+static void __maybe_unused __tdx_free_control_page(struct page *page)
+{
+	if (!page)
+		return;
+
+	__tdx_pamt_put(page_to_pfn(page));
+	__free_page(page);
+}
+
 void tdx_sys_disable(void)
 {
 	struct tdx_module_args args = {};
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index bdfd0e1e337ac..a886c54decaad 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -48,6 +48,8 @@
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE			53
+#define TDH_PHYMEM_PAMT_ADD		58
+#define TDH_PHYMEM_PAMT_REMOVE		59
 #define TDH_SYS_DISABLE			69
 
 /*
-- 
2.55.0


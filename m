Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104230E0F8;
	Sat, 25 Jul 2026 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938995; cv=none; b=QyQve4zl826Ym/d9P7URGWsIfeXsIzEbBdb/6ukiGGbITYjpO1h0gg07ua73sjaRYDmmkV+gB/adVtRvkR4biPmd/iRknO5BrOyeWfTPV1YDYctRzHnEUGrRf8DGT7lCY1oAYeywD46dV2McLOUXrd2ZJnZxBv0ER/Fb10PCTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938995; c=relaxed/simple;
	bh=vBO097akwbLm8o2cZJLEHjCtAv5SUrqmQGANNGhzjjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioVFRdH6UGT76xO3cmjcDqqsVF+rRmQE3hI5FD81Z7vhY0qqLnSJQI0Gtvok7V3A0NnkZmZBCBC1dUtQB1LYdmWmnFeGx+5jCTORvspnv1xSe4bXhBkyjVxp2EdOAcUf3oGzEQZ1Gdd43SGTGXdWFvVbz3jnErXKu5MASK6jSaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpobpnFw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpobpnFw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784938993; x=1816474993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vBO097akwbLm8o2cZJLEHjCtAv5SUrqmQGANNGhzjjM=;
  b=kpobpnFwcPLRtx5Ukncpyz98qydSs8lB+IOgMT+h8deocj3lKQtvysq5
   TkBRUj8bVd/pq5VBxzETQyylBN3uQngvI/dsl/qjJtbLtUXNBwwb0BBpH
   LnJgKiUPfau9WHKXWcDJ98ln2WT5Xd/KyUih1AqBzz4mtrI4n66tDW08Y
   nIUQBzkDkkz/2Ga3sNCqoFyfFFlG6yCBC5jq+2MgvTVyQ+1Tfnj6VhysG
   8d84gQAFthFTCbd+koDwNrbqwdtVnawpgpjmw4RcU5mXwG7MmvF2EdRsl
   wwtjCPZVuJju3+n9wwtrfi8EJaUAsMam9H3IiLSEb124iZdP6+tDs4vFC
   Q==;
X-CSE-ConnectionGUID: 7ZIuXNlTRk6qlMAmMhp0iQ==
X-CSE-MsgGUID: YIxCHcLMS/y/cOAhqOnHaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726125"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726125"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 -0700
X-CSE-ConnectionGUID: M4Ylmo2pTymzxA+h9shy2w==
X-CSE-MsgGUID: dbJ80gBJQqayouTIwgB2IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359256"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:10 -0700
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
Subject: [PATCH v8 03/11] x86/virt/tdx: Add tdx_alloc/free_control_page() helpers
Date: Fri, 24 Jul 2026 17:22:53 -0700
Message-ID: <20260725002302.3337017-4-rick.p.edgecombe@intel.com>
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Add helpers to use when allocating or preparing pages that are handed to
the TDX module for use as control/S-EPT pages, and thus need Dynamic PAMT
adjustments.

The TDX module tracks some state for each page of physical memory that it
might use. It calls this state the PAMT. It includes separate state for
each page size a physical page could be utilized at within the TDX module
(1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
allocated dynamically.

KVM will need to hand pages to the TDX module that it will use at 4KB
granularity. So these pages will need Dynamic PAMT backing added before
they are used by the TDX module, and removed afterwards.

Add tdx_alloc_control_page() and tdx_free_control_page() to handle both
page allocation and Dynamic PAMT installation. Make them behave like
normal alloc/free functions where allocation can fail in the case of no
memory, but free (with any necessary Dynamic PAMT release) always
succeeds. Do this so they can support the existing TDX flows that require
teardowns to succeed.

Also create tdx_pamt_get/put() to handle installing Dynamic PAMT 4KB
backing for pages that are already allocated (such as KVM's use of S-EPT
page tables or guest private memory). Have them take a pfn instead of a
struct page, as future changes will want to use these helpers for guest
pages which are tracked by PFN.

Don't CLFLUSH the Dynamic PAMT pages handed to the TDX module, as is done
for some other SEAMCALLs, as the TDX docs specify that this is only
needed on "TD private memory or TD control structure page".

Since these allocations will be easily user triggerable, account the
memory.

Leave logic to handle concurrency issues for future changes.

AI was used under supervision to collect/apply feedback, split patches,
review code and workshop logs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v7:
 - Comment improvements (Chao)
 - Drop unneeded addition of mm.h header include (Binbin)
 - Log clarity, code style nits (Sohil)
 - Drop Assisted-by tag and cover AI use in log (Dave)

v6:
The major change was to split out the concurrency stuff into a future
patch. It makes it easier to explain in the log. This one is the basic
functionality. Then the simple version of the concurrency and why in the
next patch. Also, to get rid of the dynamically sized DPAMT backing
support which was not based on a formal spec.

Details:
 - Split out concurrency stuff into next patch because the log was too long
 - Switch to fixed size pamt page arrays (Nikolay)
 - Rename tdx_alloc_page()/tdx_free_page() to tdx_alloc_control_page()/
   tdx_free_control_page() to reflect control/S-EPT purpose (Sean)
 - Take gfp from the caller in tdx_alloc_control_page() (Sean)
 - Narrow external API: make tdx_pamt_get()/tdx_pamt_put() static and
   export only tdx_alloc_control_page()/tdx_free_control_page() (note:
   dropped inline helpers since the discussion on Sean's series resulted
   in them not being needed)
 - Switch EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM (Sean)
 - Use WARN_ON_ONCE() instead of pr_err() for TDX module failures (Sean)
 - Fold alloc_pamt_array()/free_pamt_array() helpers back in and fix the
   error-unwind index bug (dpamt_pages[i] -> [j])
 - Adjustments after struct page->pfn
 - Adjustments from dropping error helper patches
 - Make the free error paths more normal
 - Drop gfp_t arg in tdx_alloc_control_page(). In the Sean mega v5, it
   was really needed because the kvm_mmu_memory_cache had a gfp_t it
   needed something to do with. But this was still weird because that
   version didn't handle allocating the DPAMT pages as the gfp_t. And in
   the end all the callers pass GFP_KERNEL_ACCOUNT. So just drop the arg.
 - Log tweaks
---
 arch/x86/include/asm/tdx.h  |   6 ++
 arch/x86/virt/vmx/tdx/tdx.c | 163 ++++++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |   2 +
 3 files changed, 171 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index d414064436221..86bf37b15c705 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -126,6 +126,12 @@ void tdx_guest_keyid_free(unsigned int keyid);
 
 void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
 
+/* Number of PAMT pages to be provided to TDX module per 2MB region of PA */
+#define TDX_DPAMT_ENTRY_PAGE_CNT 2
+
+struct page *tdx_alloc_control_page(void);
+void tdx_free_control_page(struct page *page);
+
 struct tdx_td {
 	/* TD root structure: */
 	struct page *tdr_page;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9edad6440080e..4d3427b8a5b71 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1994,6 +1994,169 @@ bool tdx_supports_dynamic_pamt(const struct tdx_sys_info *sysinfo)
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
+	for (int i = 0; i < TDX_DPAMT_ENTRY_PAGE_CNT; i++) {
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
+/*
+ * Calculate the arg needed for operating on the DPAMT backing for
+ * a given 4KB page.
+ */
+static u64 pamt_2mb_arg(kvm_pfn_t pfn)
+{
+	/* Arg value will specify a 2MB region of physical address space. */
+	unsigned long hpa_2mb = ALIGN_DOWN(pfn << PAGE_SHIFT, PMD_SIZE);
+
+	return hpa_2mb | TDX_PS_2M;
+}
+
+/* Add PAMT backing for the 2MB region surrounding the given pfn. */
+static u64 tdh_phymem_pamt_add(kvm_pfn_t pfn, struct page **pamt_pages)
+{
+	struct tdx_module_args args = {
+		.rcx = pamt_2mb_arg(pfn),
+		.rdx = page_to_phys(pamt_pages[0]),
+		.r8 = page_to_phys(pamt_pages[1]),
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
+/* Allocate PAMT memory for the given page */
+static int tdx_pamt_get(kvm_pfn_t pfn)
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
+/* Free PAMT memory for the given page */
+static void tdx_pamt_put(kvm_pfn_t pfn)
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
+ * Return a page that can be gifted to the TDX-Module for use as a "control"
+ * page, i.e. pages that are used for control structures for a given TDX
+ * guest, and thus obtain TDX protections, including PAMT tracking.
+ */
+struct page *tdx_alloc_control_page(void)
+{
+	struct page *page;
+
+	page = alloc_page(GFP_KERNEL_ACCOUNT);
+	if (!page)
+		return NULL;
+
+	if (tdx_pamt_get(page_to_pfn(page))) {
+		__free_page(page);
+		return NULL;
+	}
+
+	return page;
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_alloc_control_page);
+
+/*
+ * Free a page that was gifted to the TDX-Module for use as a control
+ * page. After this, the page is no longer protected by TDX.
+ */
+void tdx_free_control_page(struct page *page)
+{
+	if (!page)
+		return;
+
+	tdx_pamt_put(page_to_pfn(page));
+	__free_page(page);
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_free_control_page);
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
2.54.0


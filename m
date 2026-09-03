Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF632AADE;
	Thu,  3 Sep 2026 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400292; cv=none; b=PKdpDyvOcDpGSZFXjjv+JuofCyjSAp7LdxQoXfgRCzaGv/LsV1rrM9t0tGZa2Z3IW59/qZ0I03hLJ1/mi1vyfcd9AVKIAWwBcBzquZeKrQBCO3yecvqAdUqf8QdVM5exysSPgAt9ZarEXGNZjtaT8ykN7vBJPaRPj6ajRjdaS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400292; c=relaxed/simple;
	bh=LFKsaTmvbX23e6XFggv+Jg60B/YJjMdQfJhm7MlXoH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icyG145fheOEIJeq32UMiuwkIFXkjWkBQDFGJHjH+Vj+6KPXQ/5/fVuDXkVM+y6bzahDenmDHy4S8q78wviHds4tHUKBfpcv/Qkph2q10PY6tRWUlJPi3U95feo08MbOrKkXH4M7G6RoaKTrVbF89iPrlcdgFeRJoHD1rrIUDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ll5Sg71E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ll5Sg71E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788400290; x=1819936290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFKsaTmvbX23e6XFggv+Jg60B/YJjMdQfJhm7MlXoH8=;
  b=ll5Sg71E96d1fYLkM4Zm92/rtOVLS+IU0Qfk+hwXUts8k9AZdmB0TKLw
   PXnwy9Tfzf1bLDaONhVMt4R9jv0Z713DSRSErHF5WKPXuejTD+xGbL5Nq
   oN/6+biwKS0kN7q/aJ5EGmGhOao8WRKxE3c0CeMkmFQObAbUnEku8zYWT
   5ONnyF6CZOhLlZAWAYvr/xi7crPY6B19mDB3/Zy4GsSJ/KsNTEAi8PFlv
   X9Gjnoc16sSZH/83fv8hBMEsEpRXsvvQ83alzCiqU62Q5wMOPj59pFJut
   UGqcnqrWmhHvkrxhbhb6NoMM0TlumXTpfw6PFAFGgLv9kbgLqI/Ciaa/G
   g==;
X-CSE-ConnectionGUID: Go5ZLVt/Qjq6SVAY0A8gTg==
X-CSE-MsgGUID: nDtDIloFR/61SwB+EYG01Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99469146"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="99469146"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:51:23 -0700
X-CSE-ConnectionGUID: yPaKBYjNQr6k2eJGCU+VZQ==
X-CSE-MsgGUID: BQkGR8I4R4mq8mxOadprKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307770222"
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
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v10 04/11] x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
Date: Wed,  2 Sep 2026 18:51:06 -0700
Message-ID: <20260903015113.93343-5-rick.p.edgecombe@intel.com>
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

The PAMT memory holds metadata for all possible TDX protected memory. Each
physical address range is covered by PAMT entries at three levels (1GB,
2MB, 4KB). With Dynamic PAMT (DPAMT), the 4KB level of PAMT is allocated
on demand. The kernel supplies the TDX module with page pairs to store the
4KB level entries, which cover 2MB of host physical memory. The kernel must
provide this page pair before using pages from the range for TDX. If this
is not done, SEAMCALLs that give the pages to be protected by the TDX
module will fail.

Allocate reference counters for every 2MB range to track TDX memory usage.
This can be used to handle concurrent get/put callers, in order to
accurately determine when the dynamic 4KB level of DPAMT needs to be
allocated and when it can be freed.

This allocation will currently consume 2MB for every 1TB of address
space from 0 to max_pfn. The allocation size will depend on how the RAM is
physically laid out. In a worst case scenario where the entire 52 bit
address space is covered this would be 8GB. Then the DPAMT refcount
allocations could hypothetically cause the savings from DPAMT to go
negative on exotic platforms with sparse, small amounts of memory.

Future changes could reduce this refcount overhead to be only allocating
refcounts for physical ranges that contain memory that TDX can use.
However, this is left for future work.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Based on a patch originally by Kiryl Shutsemau.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
---
v10:
 - Change "Dynamic PAMT" to "DPAMT" in comments, and in the second
   reference in the logs. (Dave)
 - Rename some other pamt gunk to dpamt (Dave)

v7:
 - Annotate functions __init. (Chao)
 - Log tweaks. (Yan)
 - Standardize on memory units in the text. (Sohil)
 - Delete unneeded comment. (Sohil)
 - Use vzalloc(). (Sohil)
 - Drop Assisted-by tag and cover AI use in log. (Dave)

v6:
 - Remove confusing reference to allocating PAMT memory in
   pamt_refcounts comment. (Yan)
 - Rename "metadata" function names that really deal with refcounts, as
   metadata already has a different meaning in TDX.
 - Move tdx_find_pamt_refcount() to this patch to aid in reviewability.
---
 arch/x86/virt/vmx/tdx/tdx.c | 57 +++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9caaa5de28817..305289bd673be 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -30,6 +30,7 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/idr.h>
+#include <linux/vmalloc.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -66,6 +67,14 @@ static DEFINE_PER_CPU(bool, tdx_lp_initialized);
 
 static struct tdmr_info_list tdx_tdmr_list;
 
+/*
+ * On a machine with DPAMT, the kernel maintains a reference counter
+ * for every 2MB range. The counter indicates how many users there are for
+ * the DPAMT at the 2MB range. The kernel allocates DPAMT refcounts at
+ * initialization.
+ */
+static atomic_t *dpamt_refcounts;
+
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
@@ -255,6 +264,42 @@ static struct syscore tdx_syscore = {
 	.ops = &tdx_syscore_ops,
 };
 
+/*
+ * Allocate DPAMT reference counters for all physical memory.
+ *
+ * It consumes 2MB for every 1TB of physical memory.
+ */
+static __init int init_dpamt_refcounts(void)
+{
+	size_t size = DIV_ROUND_UP(max_pfn, PTRS_PER_PTE) * sizeof(*dpamt_refcounts);
+
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return 0;
+
+	dpamt_refcounts = vzalloc(size);
+	if (!dpamt_refcounts)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static __init void free_dpamt_refcounts(void)
+{
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return;
+
+	vfree(dpamt_refcounts);
+	dpamt_refcounts = NULL;
+}
+
+static __maybe_unused atomic_t *tdx_find_dpamt_refcount(unsigned long pfn)
+{
+	/* Find which PMD a PFN is in. */
+	unsigned long index = pfn >> (PMD_SHIFT - PAGE_SHIFT);
+
+	return &dpamt_refcounts[index];
+}
+
 /*
  * Add a memory region as a TDX memory block.  The caller must make sure
  * all memory regions are added in address ascending order and don't
@@ -1155,10 +1200,14 @@ static __init int init_tdx_module(void)
 	 */
 	get_online_mems();
 
-	ret = build_tdx_memlist(&tdx_memlist);
+	ret = init_dpamt_refcounts();
 	if (ret)
 		goto out_put_tdxmem;
 
+	ret = build_tdx_memlist(&tdx_memlist);
+	if (ret)
+		goto err_free_dpamt_refcounts;
+
 	/* Allocate enough space for constructing TDMRs */
 	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdx_sysinfo.tdmr);
 	if (ret)
@@ -1208,6 +1257,8 @@ static __init int init_tdx_module(void)
 	free_tdmr_list(&tdx_tdmr_list);
 err_free_tdxmem:
 	free_tdx_memlist(&tdx_memlist);
+err_free_dpamt_refcounts:
+	free_dpamt_refcounts();
 	goto out_put_tdxmem;
 }
 
@@ -2159,7 +2210,7 @@ static void __tdx_pamt_put(kvm_pfn_t pfn)
  * This function is currently only safe to call once. And not safe to call
  * if __tdx_pamt_get() is called before or after.
  */
-static struct page * __maybe_unused __tdx_alloc_control_page(void)
+static __maybe_unused struct page *__tdx_alloc_control_page(void)
 {
 	struct page *page;
 
@@ -2184,7 +2235,7 @@ static struct page * __maybe_unused __tdx_alloc_control_page(void)
  * it, and no other pages in the aligned 2MB physical region will
  * still need the backing.
  */
-static void __maybe_unused __tdx_free_control_page(struct page *page)
+static __maybe_unused void __tdx_free_control_page(struct page *page)
 {
 	if (!page)
 		return;
-- 
2.55.0


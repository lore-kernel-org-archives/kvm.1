Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152C25A2A2;
	Sat, 18 Jul 2026 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339126; cv=none; b=HjpLPZXkrA0DEXVtjAuzKNAfVfEJfnGcHSHlYcGId7v6rUt4Ov6TMhBuM+fjVZ+24kFYLrw53i0SyV70/JtLCQ8p0wxYvjz1kDGN4SSiIEXLcxGT5eMlygoklKby4ATYzMQ+ihG93mv5npQdIakqvFcIwn2tjA/ehNr/39CFNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339126; c=relaxed/simple;
	bh=2/PFvR+1Ho7cowhHo5Xn94JMiCMP1fK3rRGLmjd8Inw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciHBYx8NEsSRLaP3yJUz7pKSfp8j42EaSQL1wR4n3hFaghCmQA8A0HY/vMwbSYrgoAH9XooebG1+Sswn0Wrb6Y3CFqf97qwp/lEvRTOEsljuXwCry/muF8RLs9vCTS5ODAGTxhjujVUT0Zd1WQUCnyuGtHqUZ3r4An+Sukl1fvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCc9gqSX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCc9gqSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784339123; x=1815875123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2/PFvR+1Ho7cowhHo5Xn94JMiCMP1fK3rRGLmjd8Inw=;
  b=oCc9gqSXENRZbEHXmELNf4IrcaXhFaTlfHeTsVd7qaNNdZtDGL+X0apC
   TnjR7A9luz4lIOH9kT8ex5ofCoqyy5wyoFWGtMSDC7GQM6MIjfyfJMIir
   MO9dUyMyMo1K1aKCsaR9L+gC6ZcZkW8RXvWgwvjsbGz/llfvRdIGr6/6H
   nl53f9N0m3ssgBMGB/AI85pnXcdLP/qSreH2sngyoszLKdS62rldezh62
   aMGKMiwDrDlUU3Sb1Q0G5wwckPbZJ/t6xshKJiuPOqW4u2XUSivk9GfMf
   JXOjQImIp041k4+/nhs4EwojfvWqZoT5c+zkBv/bMNrGqQLJ2VYHfhRFu
   A==;
X-CSE-ConnectionGUID: jVzkX/9YRrmm3Ml+z8NzXw==
X-CSE-MsgGUID: HFnkvtDEQlqoQWRIlscCqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="96377148"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="96377148"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:16 -0700
X-CSE-ConnectionGUID: DYccGylFQBiBrF9z2ZL/8g==
X-CSE-MsgGUID: pOfC1LOBQCOqVtFLx2AOKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="254296265"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 18:45:08 -0700
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
Subject: [PATCH v7 04/11] x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
Date: Fri, 17 Jul 2026 18:44:53 -0700
Message-ID: <20260718014500.2231262-5-rick.p.edgecombe@intel.com>
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The PAMT memory holds metadata for all possible TDX protected memory. Each
physical address range is covered by PAMT entries at three levels (1GB,
2MB, 4KB). With Dynamic PAMT, the 4KB level of PAMT is allocated on
demand. The kernel supplies the TDX module with page pairs to store the
4KB level entries, which cover 2MB of host physical memory. The kernel must
provide this page pair before using pages from the range for TDX. If this
is not done, SEAMCALLs that give the pages to be protected by the TDX
module will fail.

Allocate reference counters for every 2MB range to track TDX memory usage.
This can be used to handle concurrent get/put callers, in order to
accurately determine when the dynamic 4KB level of Dynamic PAMT needs to
be allocated and when it can be freed.

This allocation will currently consume 2MB for every 1TB of address
space from 0 to max_pfn. The allocation size will depend on how the RAM is
physically laid out. In a worst case scenario where the entire 52 bit
address space is covered this would be 8GB. Then the Dynamic PAMT refcount
allocations could hypothetically cause the savings from Dynamic PAMT to go
negative on exotic platforms with sparse, small amounts of memory.

Future changes could reduce this refcount overhead to be only allocating
refcounts for physical ranges that contain memory that TDX can use.
However, this is left for future work.

AI was used under supervision to collect/apply feedback, review code and
workshop logs.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v7:
 - Annote functions __init (Chao)
 - Log tweaks (Yan)
 - Stanardize on memory units in the text (Sohil)
 - Delete unneeded comment (Sohil)
 - Use vzalloc() (Sohil)
 - Drop Assisted-by tag and cover AI use in log (Dave)

v6:
 - Remove confusing reference to allocating PAMT memory in
   pamt_refcounts comment. (Yan)
 - Rename "metadata" function names that really deal with refcounts, as
   metadata already has a different meaning in TDX.
 - Move tdx_find_pamt_refcount() to this patch to aid in reviewability
---
 arch/x86/virt/vmx/tdx/tdx.c | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index bfd9928c10249..b2ddd3c192645 100644
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
@@ -63,6 +64,14 @@ static DEFINE_PER_CPU(bool, tdx_lp_initialized);
 
 static struct tdmr_info_list tdx_tdmr_list;
 
+/*
+ * On a machine with Dynamic PAMT, the kernel maintains a reference counter
+ * for every 2MB range. The counter indicates how many users there are for
+ * the PAMT memory of the 2MB range. The kernel allocates PAMT refcounts at
+ * initialization.
+ */
+static atomic_t *pamt_refcounts;
+
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
@@ -252,6 +261,42 @@ static struct syscore tdx_syscore = {
 	.ops = &tdx_syscore_ops,
 };
 
+/*
+ * Allocate PAMT reference counters for all physical memory.
+ *
+ * It consumes 2MB for every 1TB of physical memory.
+ */
+static __init int init_pamt_refcounts(void)
+{
+	size_t size = DIV_ROUND_UP(max_pfn, PTRS_PER_PTE) * sizeof(*pamt_refcounts);
+
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return 0;
+
+	pamt_refcounts = vzalloc(size);
+	if (!pamt_refcounts)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static __init void free_pamt_refcounts(void)
+{
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return;
+
+	vfree(pamt_refcounts);
+	pamt_refcounts = NULL;
+}
+
+static atomic_t * __maybe_unused tdx_find_pamt_refcount(unsigned long pfn)
+{
+	/* Find which PMD a PFN is in. */
+	unsigned long index = pfn >> (PMD_SHIFT - PAGE_SHIFT);
+
+	return &pamt_refcounts[index];
+}
+
 /*
  * Add a memory region as a TDX memory block.  The caller must make sure
  * all memory regions are added in address ascending order and don't
@@ -1152,10 +1197,14 @@ static __init int init_tdx_module(void)
 	 */
 	get_online_mems();
 
-	ret = build_tdx_memlist(&tdx_memlist);
+	ret = init_pamt_refcounts();
 	if (ret)
 		goto out_put_tdxmem;
 
+	ret = build_tdx_memlist(&tdx_memlist);
+	if (ret)
+		goto err_free_pamt_refcounts;
+
 	/* Allocate enough space for constructing TDMRs */
 	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdx_sysinfo.tdmr);
 	if (ret)
@@ -1205,6 +1254,8 @@ static __init int init_tdx_module(void)
 	free_tdmr_list(&tdx_tdmr_list);
 err_free_tdxmem:
 	free_tdx_memlist(&tdx_memlist);
+err_free_pamt_refcounts:
+	free_pamt_refcounts();
 	goto out_put_tdxmem;
 }
 
-- 
2.54.0


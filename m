Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4EB30C151;
	Tue, 26 May 2026 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762931; cv=none; b=rONF7nETeqOS4FFGMkr1gQF53kJGBHyGObY34xOR5/VWVsKlF2OXZKNjsduoNY0OuLIiVNnqB2Dda4kz1EWDxITfZF34CxpWQc6aIe2qK+XUw0gnRrfSzdLXjZNMIVmUqer95JJyJQxQ7OaGAUfeM6bfa8nRemv4aDnrr3jJmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762931; c=relaxed/simple;
	bh=UNpc8w7zvAFucwvtcKFcJLYzSYmUAsEKDwnfDUz3AMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QKQv8xNOc7m+WYwAm0HirC/UbvG0sCBUr5COHoTaFiZcBR6r8yRBAaibDRBFXO+NuP/3fpieq++wJrbEKlq29982Rmh3ihFFGDNGtMFEdDNXTxG1Rls1xIaQ/LjwLqlx2CA5NywCZRaB21nB67MrwgxquF/rRW8nQs2KCOAN8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpVA0SGN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpVA0SGN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762927; x=1811298927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNpc8w7zvAFucwvtcKFcJLYzSYmUAsEKDwnfDUz3AMg=;
  b=VpVA0SGNTAoSeoF4ey//07pHXhXCZ56L/32zdipABCN7u8jmiPa2cVLI
   /LE7/+9gB4ku9yYkDzBJjOh4wAz+6vzJ60IOzs9VCzwaTIcLbAafwRtb2
   s5kQg+bJan0SFbQgdAgBWV4HBLZuaxnk+781XpOzXY3O01OJRXlZls7Xj
   cb3EA9XRsbE0rPn6rAt+S62USglpaZ1M5zkGo2bOgDViwW5xgkhOVp8wy
   +FRn6bTf2KvgS6dtRAXEnCcIqKKzK4ELSx6y47vjch4k2cLUTVfiaJaYL
   VJSh4mujUJNnFdIwYvwsDAIdd5Cc0jxsySDQh2CeCtVlPoaR5IqrRLhnq
   A==;
X-CSE-ConnectionGUID: ai8ScbH0RZ2zi7MfTu9bAw==
X-CSE-MsgGUID: YK8EXVqORJ6t+ZiB/R9EIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677802"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677802"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: FzS/pyoeR7WIjAooc/5Jew==
X-CSE-MsgGUID: pwcThJ61QCaTFzB3exMhpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878298"
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
Cc: rick.p.edgecombe@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 04/11] x86/virt/tdx: Allocate ref counts for Dynamic PAMT memory
Date: Mon, 25 May 2026 19:35:08 -0700
Message-ID: <20260526023515.288829-5-rick.p.edgecombe@intel.com>
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

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The PAMT memory holds metadata for all possible TDX protected memory. Each
physical address range is covered by PAMT entries at three levels (1GB,
2MB, 4KB). With Dynamic PAMT, the 4KB range of PAMT is allocated on
demand. The kernel supplies the TDX module with page pairs to store the
4KB entries, which cover 2MB of host physical memory. The kernel must
provide this page pair before using pages from the range for TDX. If this
is not done, SEAMCALLs that give the pages to be protected by the TDX module
will fail.

Allocate reference counters for every 2MB range to track TDX memory usage.
This can be used to handle concurrent get/put callers, in order to
accurately determine when the dynamic 4KB level of Dynamic PAMT needs to
be allocated and when it can be freed.

This allocation will currently consume 2 MB for every 1 TB of address
space from 0 to max_pfn. The allocation size will depend on how the RAM is
physically laid out. In a worst case scenario where the entire 52-bit
address space is covered this would be 8GB. Then the DPAMT refcount
allocations could hypothetically cause the savings from Dynamic PAMT to go
negative on exotic platforms with sparse, small amounts of memory.

Future changes could reduce this refcount overhead to be only allocating
refcounts for physical ranges that contain memory that TDX can use.
However, this is left for future work.

Assisted-by: Sashiko:claude-opus-4-6 GitHub Copilot:claude-opus-4-6 Sashiko:claude-opus-4-6
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v6:
 - Remove confusing reference to allocating PAMT memory in
   pamt_refcounts comment. (Yan)
 - Rename "metadata" function names that really deal with refcounts, as
   metadata already has a different meaning in TDX.
 - Move tdx_find_pamt_refcount() to this patch to aid in reviewability

v4:
 - Log typo (Binbin)
 - round correctly when computing PAMT refcount size (Binbin)
 - Zero refcount vmalloc allocation (Note: This got replaced in
   optimization patch with a zero-ed allocation, but this showed up in
   testing with the optimization patches removed. Since it's fixed
   before this code is exercised, it's not a bisectability issue, but fix
   it anyway.)

v3:
 - Split out lazily populate optimization to next patch (Dave)
 - Add comment around pamt_refcounts (Dave)
 - Improve log
---
 arch/x86/virt/vmx/tdx/tdx.c | 54 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9e0812d87ab06..6658a6be6697c 100644
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
@@ -52,6 +53,14 @@ static DEFINE_PER_CPU(bool, tdx_lp_initialized);
 
 static struct tdmr_info_list tdx_tdmr_list;
 
+/*
+ * On a machine with Dynamic PAMT, the kernel maintains a reference counter
+ * for every 2M range. The counter indicates how many users there are for
+ * the PAMT memory of the 2M range. The kernel allocates PAMT refcounts at
+ * initialization.
+ */
+static atomic_t *pamt_refcounts;
+
 /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
 static LIST_HEAD(tdx_memlist);
 
@@ -254,6 +263,43 @@ static struct syscore tdx_syscore = {
 	.ops = &tdx_syscore_ops,
 };
 
+/*
+ * Allocate PAMT reference counters for all physical memory.
+ *
+ * It consumes 2MiB for every 1TiB of physical memory.
+ */
+static int init_pamt_refcounts(void)
+{
+	size_t size = DIV_ROUND_UP(max_pfn, PTRS_PER_PTE) * sizeof(*pamt_refcounts);
+
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return 0;
+
+	pamt_refcounts = __vmalloc(size, GFP_KERNEL | __GFP_ZERO);
+	if (!pamt_refcounts)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void free_pamt_refcounts(void)
+{
+	if (!tdx_supports_dynamic_pamt(&tdx_sysinfo))
+		return;
+
+	vfree(pamt_refcounts);
+	pamt_refcounts = NULL;
+}
+
+/* Find PAMT refcount for a given physical address */
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
@@ -1151,10 +1197,14 @@ static __init int init_tdx_module(void)
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
@@ -1204,6 +1254,8 @@ static __init int init_tdx_module(void)
 	free_tdmr_list(&tdx_tdmr_list);
 err_free_tdxmem:
 	free_tdx_memlist(&tdx_memlist);
+err_free_pamt_refcounts:
+	free_pamt_refcounts();
 	goto out_put_tdxmem;
 }
 
-- 
2.54.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFDF3B6371;
	Thu,  6 Aug 2026 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982146; cv=none; b=Uz0EqBnXksUbSnwft2R9+aXQ9cbCFIxXGNXo6mgk7rJ42878N0rHQRLoXqJJ1ZAoG6z461p2bx0uE/UThblJnEYfWIHqc/LIICl9QFGA3MJUGNXZziXV3cTWW6M4QLlN154pPhUntzZes15+aUg9uNkFmO+h+a7NEn4e27k+vvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982146; c=relaxed/simple;
	bh=GIqC13Rr1fY7H+XIW+DHOetW9uFiNMKgyOltqOP8aoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHsAkrXaCpHG0V0gko20KEaVM4oU06M45JjHZFqc24tiedhi4EH58DDhsLqp8WHv731ZijSc0k3GCMq7Bgk01dATiwYR5EpTgPlmrpW48MOa54DWIYGuoOHF9Tyge4lIPOyxcicAcDBYT/y1ppwZqRKJQ4L3gORuobsPbhxDg1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m+Cny+pj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m+Cny+pj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785982144; x=1817518144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GIqC13Rr1fY7H+XIW+DHOetW9uFiNMKgyOltqOP8aoo=;
  b=m+Cny+pjhduRo+JH8N6SadmyZDlC5uWMc+p5vl9cNfTPNvuP7k6RoKIu
   7Wr6zwrqtx/ZUHk/9W7uIkXJtZqhp8vvypIDBrxRG3/GOUP+izb5dSfXO
   6hEouC/rdCSDfAteDGrByIOEj7jv7ym7U1uy8XM0yTWuL/wF4NXffo+jb
   uBWCr1zX02OU0l4uOFLWzick7KE2Yn5Kep+UmKPWhzGp14HXsRkbV0dQX
   Ec387tbgYls8OR9ncOsl5Yr2d+KBCmggyRsSKXss6H6qzJ6VhnudhgfTb
   WUZWZfJ1gQhIUXNqEzxtWVsxiYUm2Nsoda5ELew8n2mI4LRQshITI54u6
   g==;
X-CSE-ConnectionGUID: uWCbyLBbQBWcB3FXneftcg==
X-CSE-MsgGUID: FVTcOBU0TDSiwS91juK7FA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86422859"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86422859"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:02 -0700
X-CSE-ConnectionGUID: /6GoO1PpSEWd3fOJAk2zAw==
X-CSE-MsgGUID: ybjVuDG3SYq74F51tpyZMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="258639870"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 19:09:02 -0700
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
Subject: [PATCH v9 04/11] x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
Date: Wed,  5 Aug 2026 19:08:43 -0700
Message-ID: <20260806020850.1221381-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
References: <20260806020850.1221381-1-rick.p.edgecombe@intel.com>
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
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
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
index 4d3427b8a5b71..b0ebd74a69fe2 100644
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


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DE3EAC8F;
	Fri,  4 Sep 2026 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559185; cv=none; b=cpq5JytmDMoXq/KCiPFNNAaOTfKnDxFiW7YwSRmrL/P1O2t+a9f7y8NCcusdaB85BDw8nXBAiK9b/GihJ/KpAH6FlkezeL2JEpr3ZvYGLlO8bvcBWiAijN21OuFUTK+ojqHqpfuxcg+uv/vqfKUjMrvDGEv8I4k5ZPgx2IGgDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559185; c=relaxed/simple;
	bh=lfHR1JpwNh+m43z1ipO43cNtKEAHXrY28AlsD6O7tSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPAFl90PeAez9eyKfoTL+IDbArwGIvnMlWjbxF2cG0gBEllPyu+qGDi10kiGs8Fh1blBQlwmWKnaH/SEvrQGANCc/DkptcOmLl2Rz/jbrXLxiaNJxsEtPbwCGT6rsxD0GRX4bL0bS4dZFSkFYov+ER+87AaMY4ZdS+YdKQ0Fu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7xMop6p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7xMop6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559179; x=1820095179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lfHR1JpwNh+m43z1ipO43cNtKEAHXrY28AlsD6O7tSo=;
  b=Z7xMop6pSeklyvRI7pofAGyK5MY+7uR0/vGol1xIrC1jf3SAY9rc1pVu
   Q4QjU0U6XcqZNCF7gWrIg7HDrexG4iZnVsmCg0PiYW8NtYQe3YX2H+SeF
   t0ZLRLzWaSoO9UNe/yF1VFyiVw7TpMmbCbuq11Hd2ROy54DxnUQqGK7+0
   RLf+Q2nR83eWXUeL8haIrGb0XokPls9oP9v5PS3ctNY+KZ3dot96FIWFY
   HlDZtnN5Zfdx1WvaEeitn6N5Sw22flf6SbN09C+U0ilBjJO50y9EtFI9B
   JQQlLMx1h00w1m3qJN50QieXZQ0h8AANGMuBJ8an1vLSspfRzQu5ylZcz
   Q==;
X-CSE-ConnectionGUID: fJbCBDv9SXmqfTmWqQLaLw==
X-CSE-MsgGUID: +bpfiIPeTQODErxD6DUF3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224833"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
X-CSE-ConnectionGUID: QyyjBRs3TOCVyV10s3kfXw==
X-CSE-MsgGUID: 6nYq5UIxRG2LAvfLMuzk3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675034"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:23 -0700
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
Subject: [PATCH v11 04/11] x86/virt/tdx: Allocate refcounts for Dynamic PAMT memory
Date: Fri,  4 Sep 2026 14:58:34 -0700
Message-ID: <20260904215841.303070-5-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
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
 arch/x86/virt/vmx/tdx/tdx.c | 53 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a9c5b6f5384ea..305289bd673be 100644
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
 
-- 
2.55.0


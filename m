Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD12E889C;
	Fri, 22 May 2026 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422721; cv=none; b=ouRhxva4OP9tIMMVumVVQrMcVcIIwGR3bwv/AmpNh6YgziChOdPGFlZejal8NM5U++vrbmM9yPjh/mNNsXa5amPkTDC3zMVWAbtL+uZ/bJiDj4aVHWEh/6EFoTSa97m9ZiU8z/eHLLke5vK1ICTinXL0xnLtaVzGiyW1hXLAg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422721; c=relaxed/simple;
	bh=Z9LfZytGFU8HHah5jjQIDtWRjApWhxh39luI5rijAsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVRM9vh8FMPMYIeAj+egOOils5FS26ac9ZG8E5j3c7KL2n20HPob4RUlPW9UPZuZ+VVmkXRt3/XFtHE3DB5BYTsCEOQnyyqGJRBXVPmE2cGDDnjFkO4z2caM9w6GaNOJ+gRFN6u7q/9c/V0rOB65Cfvb2CNnOsmSIla44c6M+cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1Wrz7O/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1Wrz7O/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422720; x=1810958720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z9LfZytGFU8HHah5jjQIDtWRjApWhxh39luI5rijAsw=;
  b=N1Wrz7O/kSpkVfn+dojkP2FRqa4OxoWBBbGchR4vuCQipsFiIYRLWYRn
   4liKk0iFz/x0XnruKyDCyyGUtNKD3aMrZMIlV//3k8hFtS160BZYbjnQL
   gimmB0I5l5BOUS8TFXAodp3fMfIbXelMqhRzsYQae6PV+igqYwb99lD+X
   R29K0WtnxTtX8Nauh0+Xenh2MFt4eZo45m93Vnk6SIg2SMc88v01KpUVS
   QO9q81SGHJAuehG/0p5FztNVJhsT5Fvvu6lo/23RY4r4END0gL5FVPaHp
   kx3ZJlFnRbPIlsjxVEfWbJ8dJ6MWiBVMY6xZjzVqF98yinLzME9JtAe9U
   Q==;
X-CSE-ConnectionGUID: yecnJreSTgWqyfP7ac6eZA==
X-CSE-MsgGUID: FMQtRk0kTn6oE49f311myQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528854"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528854"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:20 -0700
X-CSE-ConnectionGUID: rDdMOBRZRUOdQPzi8XeMdQ==
X-CSE-MsgGUID: ZEgei0xGTmW+CucwiSgGgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757797"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:15 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kas@kernel.org,
	djbw@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	peter.fang@intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com
Subject: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for Extensions
Date: Fri, 22 May 2026 11:41:15 +0800
Message-Id: <20260522034128.3144354-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX Module introduces a new concept called "TDX Module Extensions" to
support long running / hard-irq preemptible flows inside. This makes TDX
Module capable of handling complex tasks through "Extension SEAMCALLs".
Adding more memory to TDX Module is the first step to enable Extensions.

Currently, TDX Module memory use is relatively static. But, the
Extensions need to use memory more dynamically. While 'static' here
means the kernel provides necessary amount of memory to TDX Module for
its basic functionalities, 'dynamic' means extra memory is needed only
if new add-on features are to be enabled. So add a new memory feeding
process backed by a new SEAMCALL TDH.EXT.MEM.ADD.

The process is mostly the same as adding PAMT. The kernel queries TDX
Module how much memory needed, allocates it, hands it over, and never
gets it back.

TDH.EXT.MEM.ADD uses a new parameter type HPA_LIST_INFO to provide
control (private) pages to TDX Module. This type represents a list of
pages for TDX Module to access. It needs a 'root page' which contains
the list of HPAs of the pages. It collapses the HPA of the root page
and the number of valid HPAs into a 64 bit raw value for SEAMCALL
parameters. The root page is always a medium, TDX Module never keeps
the root page.

Introduce a tdx_clflush_hpa_list() helper to flush shared cache before
SEAMCALL, to avoid shared cache writeback damaging these private pages.

For now, TDX Module Extensions consumes relatively large amount of
memory (~50MB). Use contiguous page allocation to avoid permanently
fragment too much memory. Print the allocation amount on TDX Module
Extensions initialization for visibility.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |   1 +
 arch/x86/virt/vmx/tdx/tdx.c | 118 ++++++++++++++++++++++++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index a5eec8e3cc71..2335f88bbb10 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -46,6 +46,7 @@
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
+#define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index c0c6281b08a5..622399d8da68 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -31,6 +31,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/idr.h>
 #include <linux/kvm_types.h>
+#include <linux/bitfield.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -1179,6 +1180,123 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
+{
+	u64 *entries = page_to_virt(root);
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
+}
+
+#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
+#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
+#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
+
+static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
+{
+	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
+	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
+	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
+}
+
+static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
+{
+	struct tdx_module_args args = {
+		.rcx = to_hpa_list_info(root, nr_pages),
+	};
+	u64 r;
+
+	tdx_clflush_hpa_list(root, nr_pages);
+
+	do {
+		/*
+		 * TDH_EXT_MEM_ADD is designed to use output parameter RCX to
+		 * override/update input parameter RCX, so the caller doesn't
+		 * have to do manual parameter update on retry call.
+		 */
+		r = seamcall_ret(TDH_EXT_MEM_ADD, &args);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int tdx_ext_mem_setup(void)
+{
+	unsigned int nr_pages;
+	struct page *page;
+	u64 *root;
+	unsigned int i;
+	int ret;
+
+	nr_pages = tdx_sysinfo.ext.memory_pool_required_pages;
+	/*
+	 * memory_pool_required_pages == 0 means no need to add pages,
+	 * skip the memory setup.
+	 */
+	if (!nr_pages)
+		return 0;
+
+	root = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!root)
+		return -ENOMEM;
+
+	page = alloc_contig_pages(nr_pages, GFP_KERNEL, numa_mem_id(),
+				  &node_online_map);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out_free_root;
+	}
+
+	for (i = 0; i < nr_pages;) {
+		unsigned int nents = min(nr_pages - i,
+					 PAGE_SIZE / sizeof(*root));
+		int j;
+
+		for (j = 0; j < nents; j++)
+			root[j] = page_to_phys(page + i + j);
+
+		ret = tdx_ext_mem_add(virt_to_page(root), nents);
+		/*
+		 * No SEAMCALLs to reclaim the added pages. For simple error
+		 * handling, leak all pages.
+		 */
+		WARN_ON_ONCE(ret);
+		if (ret)
+			break;
+
+		i += nents;
+	}
+
+	/*
+	 * Extensions memory can't be reclaimed once added, print out the
+	 * amount, stop tracking it and free the root page, no matter success
+	 * or failure.
+	 */
+	pr_info("%lu KB allocated for TDX Module Extensions\n",
+		nr_pages * PAGE_SIZE / 1024);
+
+out_free_root:
+	kfree(root);
+
+	return ret;
+}
+
+static int __maybe_unused init_tdx_ext(void)
+{
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	/* No feature requires TDX Module Extensions. */
+	if (!tdx_sysinfo.ext.ext_required)
+		return 0;
+
+	return tdx_ext_mem_setup();
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
-- 
2.25.1


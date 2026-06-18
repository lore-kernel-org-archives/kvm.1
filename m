Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117C3B42FF;
	Thu, 18 Jun 2026 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771981; cv=none; b=FdV2LXnd/8/5ldmk+N9ESaXtQizUNatGbJfn0zblShwrHusxgtNUT9hAa5a0hAXhlxwyaiR7xbfPnxA+8WcSdvs02URYCyoEvBZNYZTP9+W1E0ER6+12Giz2Cb0bECUUbkLXl3+SohK596MnZM89wQn/0WL70Qsw09Cw9qBy6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771981; c=relaxed/simple;
	bh=BV6GQR8KpN1xoUHI/UptEiPWnaTqMkeONb/Xwm0wlmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T4BpYtfEDvhTlHrBM0nLYNet4MlfkwRJ/ayiqOzIA55lCx4iXFxqMis23/h4iH/UL4z/xoy2qpzgq1mXxkC4B56ws6RoZ96aAIzid40jltf/p6+Tkn3sBiu4gTIVFIaCCZ49ab1KqFTLuFBFDoS+kxEhB1s4j9YAYT3pYD2g9QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBXyivXv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBXyivXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771978; x=1813307978;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BV6GQR8KpN1xoUHI/UptEiPWnaTqMkeONb/Xwm0wlmc=;
  b=gBXyivXvKiBa8bpBJftPm8jqmaCXbyzZ1AbCsDF27n5ijxGsDMrKL5sk
   N7O2qtfpxcSTrIYuAbqKnDlLt6jJ08AKs4UvBv/WgNKBw72MK/GpWkHih
   ZU3rl3eQyxJHIVC2IhhdqyPMQ8Sdepns+ySwXvG9nTUW6eVjGPNRC47Pl
   NeyMrg8c1JKa6SuQTSlUGzW+KA92VLhe1aT8F0THnU9TmM9JzFsBEaTXp
   f6tIzd86e3repwGRkDQTxY6XRnrRF4yL+yE0pttTEDbdNtTnty+jE28Cq
   mWsHRlCuIosdWSgXd9r4zr2KQG1qoXmXg57FcpIeCkK30CKegBKd0hq1n
   w==;
X-CSE-ConnectionGUID: xjiGYlysSLCbOz1ufuq5Ig==
X-CSE-MsgGUID: dZXW9HqcSu+ZXv74OzKSSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584740"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584740"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:38 -0700
X-CSE-ConnectionGUID: RERUDtSYQE2O0xllXNt7lA==
X-CSE-MsgGUID: saw7gZW9TSudLW7dXzEg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392296"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:33 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 08/17] x86/virt/tdx: Prepare Quote buffer during extension bringup
Date: Thu, 18 Jun 2026 16:13:46 +0800
Message-Id: <20260618081355.3253581-9-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

During TDX attestation, the TDX guest asks the host to generate a
signed, verifiable structure (a "Quote"). With the Quoting extension,
the TDX module returns the Quote in pages that the host shares via an
Extension-SEAMCALL.

The SEAMCALL accepts the host buffer pages as a linked list of 4KB
"HPA_LINKED_LIST" nodes. Each entry holds the physical address of a 4KB
data page, except for the last entry, which points to the next node. The
TDX module reports the required Quote buffer size through a global
metadata field. See [1] for details.

For simplicity, let all guests share a global buffer. Build the buffer's
HPA_LINKED_LIST at Quoting extension bringup. This saves a bunch of
va-to-pa conversions at runtime.

[1] Intel TDX Module ABI specification, Section "Physical Memory
    Management Types"

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |   4 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 115 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  14 +++
 3 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index b3442b7c88bb..17cb13a1bb40 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -57,4 +57,8 @@ struct tdx_sys_info_ext {
 	bool ext_required;
 };
 
+struct tdx_sys_info_quote {
+	u32 max_quote_size;
+};
+
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 06c42b86b05e..9716424a301f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -32,6 +32,7 @@
 #include <linux/idr.h>
 #include <linux/kvm_types.h>
 #include <linux/bitfield.h>
+#include <linux/vmalloc.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -71,6 +72,24 @@ static LIST_HEAD(tdx_memlist);
 
 static struct tdx_sys_info tdx_sysinfo;
 
+/*
+ * Quote buffer shared with the TDX module for quote generation, in HPA linked
+ * list format.
+ *
+ * @buf: Virtual address of the quote buffer.
+ * @buf_len: Size of @buf in bytes.
+ * @hpa_entries: HPA entries, starting at the first list node.
+ * @hpa_entries_pa: Physical address for @hpa_entries.
+ */
+struct tdx_quote_data {
+	void		*buf;
+	u64		buf_len;
+	u64		*hpa_entries;
+	phys_addr_t	hpa_entries_pa;
+};
+
+static struct tdx_quote_data tdx_quote;
+
 static DEFINE_RAW_SPINLOCK(sysinit_lock);
 
 /*
@@ -1167,6 +1186,81 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static inline phys_addr_t tdx_vmalloc_to_pa(const void *addr)
+{
+	unsigned long pfn = vmalloc_to_pfn(addr);
+
+	return PFN_PHYS(pfn);
+}
+
+#define HPAS_PER_NODE			(PAGE_SIZE / sizeof(u64))
+
+/*
+ * Pass the quote buffer to the TDX module as an HPA linked list, where each
+ * node holds 4KB page HPAs and the last entry points to the next node.
+ */
+static __init int tdx_quote_create_buf(unsigned int npages,
+				       struct tdx_quote_data *qdata)
+{
+	unsigned int nnodes;
+	u64 *hpas;
+	void *qbuf;
+	int i, j;
+
+	if (!npages)
+		return -EINVAL;
+
+	/*
+	 * Each node holds up to (HPAS_PER_NODE - 1) 4KB page HPAs.
+	 * The last entry of the node points to the next node.
+	 */
+	nnodes = DIV_ROUND_UP(npages, HPAS_PER_NODE - 1);
+
+	hpas = vmalloc_array(nnodes, PAGE_SIZE);
+	if (!hpas)
+		return -ENOMEM;
+
+	/*
+	 * ~0ULL is the list terminator for HPA_LINKED_LIST.
+	 *
+	 * Pre-fill the last node with 0xff bytes so that unused entries are
+	 * terminators. Overwrite populated entries later.
+	 */
+	memset((u8 *)hpas + (nnodes - 1) * PAGE_SIZE, 0xff, PAGE_SIZE);
+
+	qbuf = vcalloc(npages, PAGE_SIZE);
+	if (!qbuf)
+		goto out_nomem;
+
+	/* Populate the linked list */
+	for (i = 0, j = 0; j < npages; i++) {
+		if ((i % HPAS_PER_NODE) == HPAS_PER_NODE - 1) {
+			/*
+			 * The last node entry always points to the next node.
+			 * The address of the following entry must be on next
+			 * node's page boundary.
+			 */
+			hpas[i] = tdx_vmalloc_to_pa(&hpas[i + 1]);
+			continue;
+		}
+
+		hpas[i] = tdx_vmalloc_to_pa((u8 *)qbuf + j * PAGE_SIZE);
+		j++;
+	}
+
+	qdata->buf = qbuf;
+	qdata->buf_len = (u64)npages * PAGE_SIZE;
+	qdata->hpa_entries = hpas;
+	qdata->hpa_entries_pa = tdx_vmalloc_to_pa(hpas);
+
+	return 0;
+
+out_nomem:
+	vfree(hpas);
+
+	return -ENOMEM;
+}
+
 /* Initialize quoting extension */
 static __init int tdx_quote_init(void)
 {
@@ -1185,12 +1279,25 @@ static __init int tdx_quote_init(void)
 
 static __init void init_tdx_quoting_extension(void)
 {
-	int ret;
+	struct tdx_sys_info_quote sysinfo_quote;
+	unsigned int nr_quote_pages;
+
+	if (!(tdx_addon_feature0 & TDX_FEATURES0_QUOTE))
+		return;
 
-	if (tdx_addon_feature0 & TDX_FEATURES0_QUOTE) {
-		ret = tdx_quote_init();
-		WARN_ON_ONCE(ret);
+	if (tdx_quote_init()) {
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	/* Quoting metadata is valid only after initialization */
+	if (get_tdx_sys_info_quote(&sysinfo_quote))
+		return;
+
+	nr_quote_pages = PAGE_ALIGN(sysinfo_quote.max_quote_size) /
+			 PAGE_SIZE;
+	if (tdx_quote_create_buf(nr_quote_pages, &tdx_quote))
+		pr_err("Failed to create quote buffer\n");
 }
 
 /* Initialize TDX module extensions for extension SEAMCALLs */
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 84364da89649..1eb2985307c6 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -151,3 +151,17 @@ static int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
 
 	return 0;
 }
+
+static __init int get_tdx_sys_info_quote(struct tdx_sys_info_quote *sysinfo_quote)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x2300000200000002, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_quote->max_quote_size = val;
+
+	return 0;
+}
-- 
2.25.1


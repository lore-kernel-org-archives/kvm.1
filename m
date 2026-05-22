Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053436729C;
	Fri, 22 May 2026 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422739; cv=none; b=eT4ieKcCZGIuI/hzsW+cj9cY3TpHZOInFzR7Xo1r7fB43ymucPHzXTd3PIJvCYEjk25+8l1iKpc5FeGDVt0WO1fWuJkPCRh1OGwe5uUKx4Ps7K/I24SkaM8ATaSy9/khC2grhc2wFXBz8la2FDs3eB0XOSGW0jr0c9NsOlvr5HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422739; c=relaxed/simple;
	bh=spf+Km48xzDG5tK9OpIps9/r40MhH5eskXnq/W+lg+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niFrQEKjKEibi+tREBkEd5muwwdDxxP8qGWN07XJLILfsl5PvuspJzEXOFXXEcbwV/REP8As1h9zjkIAf3mD6YBgdT2Tdn1jDMKhMcJVOJ2BEoeaYuuNSU90camzgpqB0ipWWnQhdNjGVQPsGeNlxvumpNSDx5xCSfccvedtM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBBaRobg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBBaRobg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422738; x=1810958738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spf+Km48xzDG5tK9OpIps9/r40MhH5eskXnq/W+lg+s=;
  b=gBBaRobgOiPwVTth5ebJFMq9r8ApuEiAhDKSYvWGUW2SdPikARWeCJaC
   B3Dg7ZiWKxgVRHmvI1DYOdejqb3jEv5seYutsrCjtLYAbcx6iB5uBQ83Z
   XLQx9rKmSYaELIq2mzfUak9blx8vtirLOssvcHn2MblSCtABfbjdVqb6a
   LhVxfjfnVQ3FrRg+ArdrMulAHFKMidiFWUCQAjoqRaLuIpCvK5W3hSfrF
   EiNgIw7O2bV5kzUUMprExPFUR4uMCsXfmjRcliako0uaOdgEZkv6srUhu
   obFAulK5zgP9d2u6Dg7NVIi1ijScxpj2R1weAgNe+0ZRsg4TM/qUo7pwS
   Q==;
X-CSE-ConnectionGUID: dRCclvsoQfqyggdoA9BFlQ==
X-CSE-MsgGUID: Blvqzmn3TwCqb5o73l4YYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528890"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:38 -0700
X-CSE-ConnectionGUID: nbPlj1cHQ36SgE2NwgvTFw==
X-CSE-MsgGUID: x33uhmIkTe6xiU5rybc1yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757842"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:33 -0700
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
Subject: [RFC PATCH 07/15] x86/virt/tdx: Prepare Quote buffer during extension bringup
Date: Fri, 22 May 2026 11:41:20 +0800
Message-Id: <20260522034128.3144354-8-yilun.xu@linux.intel.com>
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

From: Peter Fang <peter.fang@intel.com>

The host uses a Quote buffer to communicate with the TDX module when
generating Quotes. Because the Quote buffer is shared with TDX guests,
prepare the required metadata during Quoting extension bringup.

This mostly involves determining the physical addresses of the Quote
buffer pages and arranging them in the HPA_LINKED_LIST format defined by
the Intel TDX Module ABI specification.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 85 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index fb84fb6d952b..9d04293394d7 100644
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
@@ -61,6 +62,13 @@ static LIST_HEAD(tdx_memlist);
 static struct tdx_sys_info tdx_sysinfo __ro_after_init;
 static bool tdx_module_initialized __ro_after_init;
 
+static struct quote_data {
+	void *buf;
+	u64 buf_len;
+	u64 *hpa_list;
+	phys_addr_t hpa_list_pa;
+} quote_data;
+
 typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
 
 static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
@@ -1205,9 +1213,78 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
+#define HPAS_PER_PAGE			(PAGE_SIZE / sizeof(u64))
+
+static int tdx_quote_create_buf(unsigned int nr_pages, struct quote_data *qdata)
+{
+	unsigned long pfn;
+	u64 qlist_npages;
+	int err, i, j;
+	u64 *qlist;
+	void *qbuf;
+
+	if (!nr_pages)
+		return -EINVAL;
+
+	/* The last entry of a linked list page points to the next page	*/
+	qlist_npages = (u64)DIV_ROUND_UP(nr_pages, HPAS_PER_PAGE - 1);
+
+	qlist = vmalloc_array(qlist_npages, PAGE_SIZE);
+	if (!qlist) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	/*
+	 * Make sure unfilled entries are always -1, which means NULL in TDX.
+	 * Only the last page needs to be filled. All the other pages will be
+	 * fully populated.
+	 */
+	memset((u8 *)qlist + (qlist_npages - 1) * PAGE_SIZE, 0xff, PAGE_SIZE);
+
+	qbuf = vcalloc(nr_pages, PAGE_SIZE);
+	if (!qbuf) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	/* Populate HPA_LINKED_LIST as per TDX ABI spec */
+	for (i = 0, j = 0; j < nr_pages; i++) {
+		if ((i % HPAS_PER_PAGE) == HPAS_PER_PAGE - 1) {
+			/*
+			 * The last entry always points to the next page. The
+			 * address of the following entry must be on next page's
+			 * boundary.
+			 */
+			pfn = vmalloc_to_pfn(&qlist[i + 1]);
+			qlist[i] = PFN_PHYS(pfn);
+			continue;
+		}
+
+		pfn = vmalloc_to_pfn((u8 *)qbuf + j * PAGE_SIZE);
+		qlist[i] = PFN_PHYS(pfn);
+		j++;
+	}
+
+	qdata->buf = qbuf;
+	qdata->buf_len = (u64)nr_pages * PAGE_SIZE;
+	qdata->hpa_list = qlist;
+
+	pfn = vmalloc_to_pfn(qlist);
+	qdata->hpa_list_pa = PFN_PHYS(pfn);
+
+	return 0;
+
+out_err:
+	vfree(qlist);
+
+	return err;
+}
+
 static void tdx_quote_init(void)
 {
 	struct tdx_module_args args = {};
+	unsigned int nr_quote_pages;
 	u64 r;
 
 	do {
@@ -1218,7 +1295,13 @@ static void tdx_quote_init(void)
 		return;
 
 	/* Quoting metadata is valid only after initialization */
-	get_tdx_sys_info_quote(&tdx_sysinfo.quote);
+	if (get_tdx_sys_info_quote(&tdx_sysinfo.quote))
+		return;
+
+	nr_quote_pages = PAGE_ALIGN(tdx_sysinfo.quote.max_quote_size) /
+			 PAGE_SIZE;
+	if (tdx_quote_create_buf(nr_quote_pages, &quote_data))
+		pr_err("Failed to create quote buffer\n");
 }
 
 /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
-- 
2.25.1


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FAA3B3895;
	Thu, 18 Jun 2026 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771966; cv=none; b=Bv4pZgVgwvVrOXwdso4kyhhkQP4/YXc4xaHu2alnQ99uS+NITr06dOLGcwGxxi1Mklq3tq9s/nQcvf2CkrboeLaoBsVU4idq6D3Jcv3gwAvtEeqKQ6JsE0BExeJ8AmjzXhkFSJieluJ0n0xpZd0Kqvr/QEEmLfcdkuCHuwbfKJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771966; c=relaxed/simple;
	bh=xG2WoiGKpMKNQJUfc5k9QfzgF1eAxZIZ/ZPQbkoJKCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FfnokMbGI9rbeOPvJONCVG3TXPozmyTL1mqxpTUBbVHMuUV7+9AEij3SQ0GqsDkgLCdpwy+6ZGH5N+xtKTC23DRUXrq/lC8l0WV8UWqA6dzTfEi8n5gYa+4PK21XtMIKRkLPzatDIkFDWqhbIoOKXMNKyRLGkdunL23JqadioMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBuEh2mP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBuEh2mP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771959; x=1813307959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xG2WoiGKpMKNQJUfc5k9QfzgF1eAxZIZ/ZPQbkoJKCM=;
  b=dBuEh2mPm9sR/Gbpz6RCOcIQR+4wnydB9Cbk3O+hFz8ROu8G+h8Nyv2w
   m1i+Ihrn77sUxyPESrCMhRjYSJoNcQPzfw0Z/jSUrUn8YVEmKgykmDyKA
   bnXwPsv84GdGCOkS44S2k444bSte2xiNCALnrMBZP/ZmfGPNKgqt3GzMX
   zxi4o4ujA75cT1c3L6VxA3BRKRO3LXY1YCUreBw6em8i1BWKbWH3y0oK9
   aMbScMgqqMBD2+Pc94XA8qYaUmnvhyelmI5KaW8SMZSBOqvuXY19MUh5c
   E1nTn2IqtK9IvgUej0+jIytqRg+ceUJ7vdd1urW2XgAlsgqAI1bOQxMWy
   w==;
X-CSE-ConnectionGUID: PVSbFslcQLaplAFmwPzqPw==
X-CSE-MsgGUID: 4FEBMvw1THeUw4ktBmnINw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584639"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584639"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:19 -0700
X-CSE-ConnectionGUID: 5oOVmeZnR5+B9/UpzOrOew==
X-CSE-MsgGUID: 1qwhiI5cS3qOnJccCiUx1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392209"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:14 -0700
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
Subject: [PATCH v2 04/17] x86/virt/tdx: Add extra memory to TDX module for the extensions
Date: Thu, 18 Jun 2026 16:13:42 +0800
Message-Id: <20260618081355.3253581-5-yilun.xu@linux.intel.com>
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

TDX module extensions receive a one-time memory allocation at
initialization time. The extensions use this memory as the baseline for
their internal states and data required by the service APIs they offer.

Add a new memory feeding process backed by a new SEAMCALL
TDH.EXT.MEM.ADD. The process is mostly the same as adding PAMT. The
kernel queries TDX module how much memory needed by reading the
memory_pool_required_pages, allocates it, hands it over to the module,
and never gets it back.

TDH.EXT.MEM.ADD uses a new parameter type, HPA_LIST_INFO, to provide
this memory. This type represents a list of pages for TDX module to
access. It references an 'hpa_list page' which contains the list of
target HPAs. It collapses the HPA of the hpa_list page and the number
of valid target HPAs into a 64 bit raw value for SEAMCALL parameters.
The hpa_list page is always a medium, TDX module never keeps the
hpa_list page.

Don't CLFLUSH the pages handed to the TDX module, as is done for some
other SEAMCALLs. The flushing operation is not expected to be needed for
current and known future architectures. As more and more page feeding
interfaces to come, the conservative flushing operation becomes a
maintenance burden.

For now, TDX module extensions consume tens of megabytes memory that
will never be returned to host. Use contiguous page allocation to
isolate these large blocks entirely, avoiding permanent memory
fragmentation and reducing buddy allocator efficiency. Print the
allocation amount on TDX module extensions initialization for
visibility.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |   1 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   1 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 107 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |   6 ++
 4 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 83fc657a438e..b3442b7c88bb 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -53,6 +53,7 @@ struct tdx_sys_info {
 };
 
 struct tdx_sys_info_ext {
+	u32 memory_pool_required_pages;
 	bool ext_required;
 };
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index a47e872480c7..a100634087e7 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -63,6 +63,7 @@
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE_V0		53
 #define TDH_SYS_UPDATE			SEAMCALL_LEAF_VER(TDH_SYS_UPDATE_V0, 1)
+#define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
 /* TDX page types */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 6f3596f11d25..dab17822c1c6 100644
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
@@ -1166,6 +1167,108 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
+#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
+#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
+
+static __init u64 to_hpa_list_info(struct page *hpa_list_page,
+				   unsigned int nr_pages)
+{
+	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
+	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(hpa_list_page)) |
+	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
+}
+
+static __init int tdx_ext_mem_add(struct page *hpa_list_page,
+				  unsigned int nr_pages)
+{
+	struct tdx_module_args args = {
+		.rcx = to_hpa_list_info(hpa_list_page, nr_pages),
+	};
+	u64 r;
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
+struct tdx_hpa_list {
+	u64 phys[PAGE_SIZE / sizeof(u64)];
+};
+
+static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);
+
+static __init int tdx_ext_mem_setup(unsigned int required_pages)
+{
+	struct tdx_hpa_list *hpa_list;
+	struct page *page;
+	unsigned int i;
+	int ret;
+
+	/*
+	 * memory_pool_required_pages == 0 means no need to add pages,
+	 * skip the memory setup.
+	 */
+	if (!required_pages)
+		return 0;
+
+	hpa_list = kzalloc_obj(*hpa_list);
+	if (!hpa_list)
+		return -ENOMEM;
+
+	page = alloc_contig_pages(required_pages, GFP_KERNEL, numa_mem_id(),
+				  &node_online_map);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out_free_hpa_list;
+	}
+
+	i = 0;
+	while (i < required_pages) {
+		unsigned int nents = min(required_pages - i,
+					 ARRAY_SIZE(hpa_list->phys));
+		unsigned int j;
+
+		for (j = 0; j < nents; j++)
+			hpa_list->phys[j] = page_to_phys(page + i + j);
+
+		ret = tdx_ext_mem_add(virt_to_page(hpa_list), nents);
+		/*
+		 * No SEAMCALLs to reclaim the added pages. For simple error
+		 * handling, leak all pages.
+		 */
+		WARN(ret, "Fatal: TDX module rejected (%d) memory for extensions, stranded all pages\n",
+		     ret);
+		if (ret)
+			break;
+
+		i += nents;
+	}
+
+	/*
+	 * Memory for extensions can't be reclaimed once added, print out the
+	 * amount, stop tracking it and free the hpa_list page, no matter
+	 * success or failure.
+	 */
+	pr_info("%lu KB consumed for TDX module extensions\n",
+		required_pages * PAGE_SIZE / 1024);
+
+out_free_hpa_list:
+	kfree(hpa_list);
+
+	return ret;
+}
+
 static __init int init_tdx_module_extensions(void)
 {
 	struct tdx_sys_info_ext sysinfo_ext;
@@ -1182,9 +1285,7 @@ static __init int init_tdx_module_extensions(void)
 	if (!sysinfo_ext.ext_required)
 		return 0;
 
-	/* TODO: add the extensions enabling steps here */
-
-	return 0;
+	return tdx_ext_mem_setup(sysinfo_ext.memory_pool_required_pages);
 }
 
 static __init int init_tdx_module(void)
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index b9e1c011a990..720cdaf76492 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -137,6 +137,12 @@ static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
 	int ret;
 	u64 val;
 
+	ret = read_sys_metadata_field(0x3100000200000000, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_ext->memory_pool_required_pages = val;
+
 	ret = read_sys_metadata_field(0x3100000000000001, &val);
 	if (ret)
 		return ret;
-- 
2.25.1


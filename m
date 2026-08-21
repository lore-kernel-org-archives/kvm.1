Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68895379C5A;
	Fri, 21 Aug 2026 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282982; cv=none; b=sLk8SS8synyt8oqdeRAB+KohnNeko8TAYK3Q7BJtHuTUMtNhABIytNcGA85wDJT6aDLzzqM0pqyYLLc/kseZVElaE15juUQFUG23Ie+KVe1ZaIUF9SKiDvUFVWX4c7ac7gyI4uzv22AtAACAlOa2oXOv1YAgr6SYEVBhMD+PHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282982; c=relaxed/simple;
	bh=p6kkjag7sbnyDiWJWN/yPpqzbtkf9ykV8qQAUhwAJd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uif7TuyeV18d8n8nYUYYOhdLn2CrXQQq0jdqgCszqCNaltIq/xHzEpQjJjvoqVwzlVNm3K+siu9fgHsQE7lXN1rJ9ArFZFdxnRlz0j5Egx5aDZNpF+C3vIBjZgU7g9kS+daoHonVO+1S7aWNmzG8a9gb4Nxto2Vkppp9idPohEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcm0yxAj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcm0yxAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282980; x=1818818980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p6kkjag7sbnyDiWJWN/yPpqzbtkf9ykV8qQAUhwAJd0=;
  b=mcm0yxAjcjqWwqiJaZSGMoCe72geTmb4lVS0QlS9bLEJoRIzVw82VHG1
   J8Yzm57c4YyCwJv/2vWYtDEON6ZWp0aKXna7hkr0nvZZ961Dqcd3o1N7/
   r/JRzAcYFY/C+0lVvxI3+ZrqaWwQiIjXjn7BiueUCOCo0Tmf5WnP3ec4W
   jjhwC0czPfEPkcSxdJ5g3lxdcpejFXTGtl01XdKdRtKIrz8kceWnNGTdp
   nZWWswEvijiKMeMy/roL1q+Ucs0s7VOXIp12ILfLF/pcZRfh6vNikoCrI
   8O3Rk6uhi9FspyOl92kMWNWLAL5+VU5HlfDazYLvBUMbxNCgAXEforzu8
   w==;
X-CSE-ConnectionGUID: XN/djrIvQ+ucnuOthJTaZQ==
X-CSE-MsgGUID: RozNxvmNREWLnHpmM6v5AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640238"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640238"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:40 -0700
X-CSE-ConnectionGUID: E+bUqs3hTbWu2DzFHGdsKQ==
X-CSE-MsgGUID: E0ZNPXfFQbWI0IHSBLkr1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451605"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:36 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
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
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: [PATCH 4/6] x86/virt/tdx: Add extra memory to TDX module for the extensions
Date: Fri, 21 Aug 2026 11:29:18 +0800
Message-Id: <20260821032920.256225-5-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821032920.256225-1-yilun.xu@linux.intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX module extensions need memory for their own internal state and data
to serve SEAMCALL leaves. The TDX architecture implements the extensions
in such a way that they use the memory outside of SEAM range, so the
kernel should add the memory upfront at initialization time.

Introduce a new memory adding process backed by a new SEAMCALL leaf
TDH.EXT.MEM.ADD. The kernel queries TDX module how much memory needed,
allocates it, add it to the module, and never gets it back.

The TDX module accepts the memory in the form of a PFN array. This array
is passed via a single 64-bit SEAMCALL leaf parameter, which encodes two
values: the PFN of the container page holding the array, and the number
of entries in the array. Create a helper to encode this format and name
it after the TDX module term: HPA_LIST_INFO.

TDX module extensions consume tens of megabytes memory that will never
be returned to host. Use contiguous page allocation to isolate these
large blocks entirely, avoiding permanent memory fragmentation and buddy
allocator efficiency loss. Print the allocation amount on TDX module
extensions initialization for visibility.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
v1:
 - Fix return value for SEAMCALL helpers (Chao)
 - Print SEAMCALL error code for SEAMCALL helpers (Xiaoyao)
 - Rename local vars to make the ext memory adding loop clear (Rick)
 - Remove input parameters for tdx_ext_mem_setup() (Kevin)
 - Add a Macro for tdh_hpa_list size.
 - Change the SEAMALL helper parameter type,
   struct page *hpa_list => struct tdx_hpa_list *hpa_list
 - changelog & code comments
---
 arch/x86/include/asm/tdx_global_metadata.h  |   1 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   1 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 118 +++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |   6 +
 4 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index fe3fe91de71f..43b8761c0854 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -45,6 +45,7 @@ struct tdx_sys_info_handoff {
 };
 
 struct tdx_sys_info_ext {
+	u32 memory_pool_required_pages;
 	bool ext_required;
 };
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 63e3acfb5d0c..52888424fe7d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -48,6 +48,7 @@
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE			53
+#define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
 /* TDX page types */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a0c370894c0b..8c2fdaf0b8c0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1175,6 +1175,120 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+#define TDX_HPA_LIST_MAX_NR_PAGES	(PAGE_SIZE / sizeof(u64))
+
+struct tdx_hpa_list {
+	u64 phys[TDX_HPA_LIST_MAX_NR_PAGES];
+};
+
+static_assert(sizeof(struct tdx_hpa_list) == PAGE_SIZE);
+
+#define HPA_LIST_INFO_FIRST_ENTRY	GENMASK_U64(11, 3)
+#define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
+#define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
+
+static __init u64 to_hpa_list_info(struct tdx_hpa_list *hpa_list,
+				   unsigned int nr_pages)
+{
+	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
+	       FIELD_PREP(HPA_LIST_INFO_PFN, PFN_DOWN(__pa(hpa_list))) |
+	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
+}
+
+static __init int tdx_ext_mem_add(struct tdx_hpa_list *hpa_list,
+				  unsigned int nr_pages)
+{
+	struct tdx_module_args args = {
+		.rcx = to_hpa_list_info(hpa_list, nr_pages),
+	};
+	u64 ret;
+
+	do {
+		/*
+		 * The TDX module overwrites RCX to track progress when this
+		 * SEAMCALL leaf is interrupted. Use seamcall_ret() to save and
+		 * pass the updated value back on retry.
+		 */
+		ret = seamcall_ret(TDH_EXT_MEM_ADD, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE);
+
+	if (ret != TDX_SUCCESS) {
+		pr_err("TDH.EXT.MEM.ADD failed: 0x%016llx\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static __init int tdx_ext_mem_setup(void)
+{
+	unsigned int required_pages = tdx_sysinfo.ext.memory_pool_required_pages;
+	struct tdx_hpa_list *hpa_list;
+	unsigned int added_pages;
+	struct page *page;
+	int ret;
+
+	/*
+	 * TDX module uses the metadata memory_pool_required_pages to indicate
+	 * how much memory is still needed. This value decreases each time
+	 * memory is added via TDH.EXT.MEM.ADD.
+	 *
+	 * On first time initialization, a value of 0 before any memory is
+	 * added is unusual. But host makes no assumptions. Skip the memory
+	 * setup and let subsequent steps catch any actual errors.
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
+	added_pages = 0;
+	while (added_pages < required_pages) {
+		unsigned int chunk_pages = min(required_pages - added_pages,
+					       TDX_HPA_LIST_MAX_NR_PAGES);
+		struct page *chunk = page + added_pages;
+		unsigned int i;
+
+		for (i = 0; i < chunk_pages; i++)
+			hpa_list->phys[i] = page_to_phys(chunk + i);
+
+		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
+		if (ret) {
+			/*
+			 * This SEAMCALL leaf shouldn't fail, and if it does,
+			 * things are broken enough that complex error handling
+			 * isn't worth it. Intentionally leak all pages,
+			 * including un-added pages.
+			 */
+			WARN(1, "Fatal: TDX module rejected memory for extensions, stranded all pages\n");
+			break;
+		}
+
+		added_pages += chunk_pages;
+	}
+
+	/*
+	 * Memory for TDX module extensions is never reclaimed and can be tens
+	 * of megabytes. Print the amount so users know the cost.
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
 	int ret;
@@ -1194,9 +1308,7 @@ static __init int init_tdx_module_extensions(void)
 	if (!tdx_sysinfo.ext.ext_required)
 		return 0;
 
-	/* TODO: add the extensions enabling steps here */
-
-	return 0;
+	return tdx_ext_mem_setup();
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369432;
	b=w3vsyFPYC9+o3Rj7ysnJuetdYIMsQwgH3AZF7VEYzX2uORxOZpXjj2HJy/tz4nb2fQ+c
	 6WhcnuqOpaClg9R9HCt5rQ1Q5SSJJyLXEFA+QACPvpvTvSipzBXETSsFXenKRHoo1fcs9
	 OMrH/u+hyekIY6xRq3oz2v9OU2An/V+4S2S3AhmRIhw7A8zM+ZJsXgozrjPTiRHoBFmU0
	 rNtru3reHjWnGUwQMhDTnCNcln0TnwFGNDXS26P2dLNelLiNfSXc8HGsXiF9fuGP+w2b8
	 q1/lwLSYjfmxCZVOMYnm7w/jKywHbOFKxULuvEWFUFSPIDZ4oFVdGxBaVwsUIXw7cPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369432;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TOhnZX/2jyiWof2jXlo1AdLWLb6/xoEJMxSuJd1TCYs=;
	b=abD2bSGUeeogIGmlGoEs3OmYIqxQEbvg9ZlVLbJdx4+hpJ6ekPunkTv2JHwBujBxuuSE
	 yAGUnIfLN4Wdwm/HarG6pgFWqM3zlrGomOXhV5N8fdMM/ib/CXT4H6UvSC5eYR9YdHV7t
	 kN9Wxh8uWj11kFQYwexY7BE+jBi3Un8vYtHpFzj55O7u8dLaChWyN8qZxCoOcGeT5hek0
	 bLhHfto5r8keP9NoDhstV9Vf+3+pTcrVe99c2lYT9pStgHq2oQpX92AGwgIQqAr+VrWPv
	 JOsbyPoYvDrwCNQ5I5l7uwD9Pst7ZUH8X7pHicNWThTewgM1hLIZkkFXGrNVI3NecuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ta7rp3Jr;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7D6606A320;
	Wed, 11 Nov 2026 03:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7D6606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ta7rp3Jr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369432; x=1825905432;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=gpXOkkb/lgtLOoj2Ivi6YYmRD0KDgIjxdElljwWDq2w=;
  b=Ta7rp3JrJGcC0pMVqF5zPHCUMy+IIqF0DjovQX4iuMMgYjPDy+jwjMEA
   G3U+BIYp4McKT1GqlgPx6bz/qwBqdEBGcz5NYQuy7cximf5r1TdrFs8Ys
   ei5STQw/HYxwMrQOfQ3uJPpOhhzG6S+PDED+oyQuDbRfHwM49CmFYMeqm
   J6YjhlDk6wYv9j34RO7DsmyV4RkKfMJ/lSIuf8tnu7sEBs3a7YkgDxwVt
   WiSBIJ31HncMYvUWi+Ihg6q5peqoCLLWahBA+ETESCBUz0aG5DbTG/4KC
   kHIZl7lONykhZeT0TJD6IQm3hVgUCGyE9+GqAUxGGVXLF6a4RE0W66FJD
   A==;
X-CSE-ConnectionGUID: 1kuuzajbSieqQFbaLozEsQ==
X-CSE-MsgGUID: mrhpmOuZQZ6eZMOt8pHIYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220289"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220289"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:57:12 -0800
X-CSE-ConnectionGUID: 4fMNYsljS2mpOqlly1cPWQ==
X-CSE-MsgGUID: DeYtddvYQSmolJolUEadFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199252"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:57:07 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Wed, 11 Nov 2026 11:48:44 +0800
Subject: [PATCH v5 3/6] x86/virt/tdx: Add extra memory to TDX module for
 the extensions
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-tdx-module-ext-v5-3-c74f764abc3d@linux.intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11198;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=gpXOkkb/lgtLOoj2Ivi6YYmRD0KDgIjxdElljwWDq2w=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frr8yK7ZJxcuaJu84QS7iLhR8aFbEhwOX44s5bI8l
 Tl3kuuxTR2dLAxiHAyGYoosCzxmOU1pn8W09dPOazBzWJlAhgjLVGbmlObpVZQ6ZOaVpOboJefn
 MnBxCsBUpZ1i+J/396iWWp1/mcOO+bL1Tg9m/Yh5lNJcVrHC214qteF74RFGht35C1Qj9864/v3
 6k5f8BQHleS1N1bLvn+zkXPQrb6ngbTYA
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

TDX module extensions need memory for their execution environment to
serve SEAMCALL leafs. The TDX architecture implements the extensions
in such a way that they use the memory outside of SEAM range, so the
kernel should add the memory upfront at initialization time.

Introduce a new memory adding process backed by a new SEAMCALL leaf
TDH.EXT.MEM.ADD. The kernel queries TDX module how much memory needed,
allocates it, adds it to the module, and never gets it back. Note that
the process requires Dynamic PAMT backing. A subsequent patch adds the
support. This doesn't break bisectability cause the extensions can't be
enabled yet without a feature that uses them.

The TDX module accepts the memory in the form of an HPA array. This
array is passed via a single 64-bit SEAMCALL leaf parameter, which
encodes two values: the PFN of the container page holding the array, and
the number of entries in the array. Create a helper to encode this
format and name it after the TDX module term: HPA_LIST_INFO.

TDX module extensions consume tens of megabytes memory that will never
be returned to the host. Use contiguous page allocation to isolate these
large blocks entirely. This is a simple way to avoid permanent memory
fragmentation: requiring the full size to be contiguous is more
expensive than needed but should be good during the boot time. Print the
allocation amount on TDX module extensions initialization for
visibility.

The TDX module provides a metadata field "required_pages" to indicate
the required memory size. This metadata is meaningful only after the
add-on feature configuration. Don't read and cache the metadata in
tdx_sysinfo. Instead read it right before allocating memory for the
extensions, when it is guaranteed to be valid.

The original changelog was written by hand. AI was used to help correct
grammatical errors and polish individual sentences for better
readability.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
An alternative solution is to use a loop that gives memory on a memory
error code - TDX_EXT_MEMORY_POOL_REQUIRED, add one page per iteration
until TDH.EXT.INIT succeeds. Something like:

	do {
		ret = tdh_sys_init();
		if (ret == TDX_EXT_MEMORY_POOL_REQUIRED)
			tdh_ext_mem_add(); //single page
	} while (ret == TDX_EXT_MEMORY_POOL_REQUIRED);

This approach is slightly simpler as we don't have to query the module
for the total memory, no memory pre-allocation or segmentation math.
But allocating a single 4K page per iteration may cause permanent memory
fragmentation.

v5:
 - Add the DPAMT & bisectability note
 - Shorten the "required_pages field" paragraph a little bit
 - Collect Reviewed-by tags
 - Better clarify the AI usage

v4:
 - Rename memory_pool_required_pages to required_pages (Rick)
 - Rename local var sysinfo_ext to ext
 - Collect Reviewed-by tags

v3:
 - Merge remaining pre-check operations from the previous patch (Rick)
 - Don't save the metadata in tdx_sysinfo (Rick)
 - Tweak the code comment for memory_pool_required_pages == 0 (Chao)
 - Re-phrase the code comment for struct tdx_hpa_list (Tony)
 - Put the error handling comments on top of memory add loop, to avoid
   moving them around when DPAMT support is added in the following
   patch.
 - Print memory size before adding memory; it won't be freed afterward,
   whether the operation succeeds or fails.
 - Collect Reviewed-by tags

v2:
 - Add code comments for container page allocation (Kiryl)
 - Adjust comments/changelog for contiguous allocation of extensions
   memory (Kiryl)
 - s/PFN array/HPA array in commit log (Kiryl)
 - State the alternative solution (Rick)
 - Add code comment for struct tdx_hpa_list

v1:
 - Fix return value for SEAMCALL wrappers (Chao)
 - Print SEAMCALL error code for SEAMCALL wrappers (Xiaoyao)
 - Rename local vars to make the ext memory adding loop clear (Rick)
 - Remove input parameters for tdx_ext_mem_setup() (Kevin)
 - Add a Macro for tdh_hpa_list size.
 - Change the SEAMALL wrapper parameter type,
   struct page *hpa_list => struct tdx_hpa_list *hpa_list
 - changelog & code comments
---
 arch/x86/include/asm/tdx.h                  |   1 +
 arch/x86/include/asm/tdx_global_metadata.h  |   4 +
 arch/x86/virt/vmx/tdx/tdx.h                 |   1 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 138 ++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c |  14 +++
 5 files changed, 158 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1fcfaed515fe..89e7628796b0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -37,6 +37,7 @@
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
 #define TDX_FEATURES0_DYNAMIC_PAMT	BIT_ULL(36)
+#define TDX_FEATURES0_EXT		BIT_ULL(39)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 8a3cc1a2a41e..f18e63b671c2 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -47,6 +47,10 @@ struct tdx_sys_info_handoff {
 	u16 module_hv;
 };
 
+struct tdx_sys_info_ext {
+	u32 required_pages;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index db209541d3cd..2adc5d31d258 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -50,6 +50,7 @@
 #define TDH_SYS_UPDATE			53
 #define TDH_PHYMEM_PAMT_ADD		58
 #define TDH_PHYMEM_PAMT_REMOVE		59
+#define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
 /* TDX page types */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 3bfe78b4b538..865d8089d343 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1210,6 +1210,140 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+#define TDX_HPA_LIST_MAX_NR_PAGES	(PAGE_SIZE / sizeof(u64))
+
+/*
+ * TDX module in-memory ABI to specify the memory being added to the TDX
+ * module. An array of HPAs, each element points to a 4K page.
+ */
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
+	struct tdx_hpa_list *hpa_list;
+	struct tdx_sys_info_ext ext;
+	unsigned int added_pages;
+	struct page *page;
+	int ret;
+
+	ret = get_tdx_sys_info_ext(&ext);
+	if (ret)
+		return ret;
+
+	/*
+	 * Skip the memory setup if no memory is required. This may happen when
+	 * no add-on features requiring TDX module extensions are configured
+	 * via TDH.SYS.CONFIG.
+	 */
+	if (!ext.required_pages)
+		return 0;
+
+	/*
+	 * Allocate the container page for the HPA_LIST. tdx_hpa_list is
+	 * guaranteed to be page-sized by static_assert(), so kzalloc()
+	 * guarantees the page alignment.
+	 */
+	hpa_list = kzalloc_obj(*hpa_list);
+	if (!hpa_list)
+		return -ENOMEM;
+
+	/*
+	 * Memory for TDX module extensions is never reclaimed and can be tens
+	 * of megabytes. Allocating a physically contiguous chunk is a simple
+	 * way to avoid permanent memory fragmentation: requiring the full size
+	 * to be contiguous is more expensive than needed but should be good
+	 * during the boot time.
+	 */
+	page = alloc_contig_pages(ext.required_pages, GFP_KERNEL,
+				  numa_mem_id(), &node_online_map);
+	if (!page) {
+		ret = -ENOMEM;
+		goto out_free_hpa_list;
+	}
+
+	/* Print the amount so users know the cost. */
+	pr_info("%lu KB allocated for TDX module extensions\n",
+		ext.required_pages * PAGE_SIZE / 1024);
+
+	/*
+	 * Following TDX operations shouldn't fail, and if they do, things are
+	 * broken enough that complex error handling isn't worth it.
+	 * Intentionally leak all pages on failure, including un-added pages.
+	 */
+	added_pages = 0;
+	while (added_pages < ext.required_pages) {
+		unsigned int chunk_pages = min(ext.required_pages - added_pages,
+					       TDX_HPA_LIST_MAX_NR_PAGES);
+		struct page *chunk = page + added_pages;
+		unsigned int i;
+
+		for (i = 0; i < chunk_pages; i++)
+			hpa_list->phys[i] = page_to_phys(chunk + i);
+
+		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
+		if (ret) {
+			WARN(1, "TDX module rejected memory for extensions, stranded all pages\n");
+			break;
+		}
+
+		added_pages += chunk_pages;
+	}
+
+out_free_hpa_list:
+	kfree(hpa_list);
+
+	return ret;
+}
+
+static __init int init_tdx_module_extensions(void)
+{
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	return tdx_ext_mem_setup();
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1268,6 +1402,10 @@ static __init int init_tdx_module(void)
 	if (ret)
 		goto err_reset_pamts;
 
+	ret = init_tdx_module_extensions();
+	if (ret)
+		goto err_reset_pamts;
+
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
 out_put_tdxmem:
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 98ebf17aab1c..9ab4d021017f 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -125,6 +125,20 @@ static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff
 	return 0;
 }
 
+static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x3100000200000000, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_ext->required_pages = val;
+
+	return 0;
+}
+
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;

-- 
2.25.1


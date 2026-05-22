Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5243655CA;
	Fri, 22 May 2026 04:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422727; cv=none; b=e7ERGEbXFkhw7UVpq5bS6eZz8OulSYYNO4pFxt4OhYZVkm+7G+fhtzH/BqxZIXLjNbNo6dmXG4LLCkWvc5Ii7GZy62mEuaE/lnFloegW4Gh4J3NAVuI147WLuj8rUW7HxbSLKLxuGwYicKoj/MEX0NZkd720d7p+syW7KRmLIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422727; c=relaxed/simple;
	bh=r8SogMtHXz09azwHyewtwTuMb9ge/6Z5Uv2/j6U6Lrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IAly1aQRx2eFdjQ8VJmOLP4PQvy+vGmJPLgo9Ff9OC8Oy3yudULzP61+LOdgWwqtyZbSwPhX1rJUUVxrZjkhj5tWWy+gct3fxRL7M6VC29FnE5rgDfn20N2fZkEa49CLlyeR31G13OgUBGDmAO49nQU9D/QOwtVmthkObtSwuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOPiHIRC; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOPiHIRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422727; x=1810958727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r8SogMtHXz09azwHyewtwTuMb9ge/6Z5Uv2/j6U6Lrg=;
  b=eOPiHIRC3xmwcTTl6YXLoGH03dnJnFV30Sqbyn55tWkgb84CzLfOVPG4
   yDdHb6MUb7wam9fphXUruJNXs3XMDpDYvCqtzGlpEF9RfL2hE30qwDPLn
   VAZXKU0Lnq8nbVjTg/drZHyYH1VmimKOp6UXWPgYPZgIcif6qWvyUBJ0d
   m/CsLBHWNePPWxbjHdqgkLyVu8tc0deA1rieH6ax8nhr8Rk0DatdVMe/2
   MMr49S3/fNEmhB5oID7WAZzW3zWEaNQJikPENcZOmk4uaqLFF8t0N3nnU
   rnb+XsgtD9NC2WxfPbkT7721fxQEMFabjjKBgEfEUyPttHOfxDLXmNDDU
   A==;
X-CSE-ConnectionGUID: T0XQsiV7THiSezRzeGQNUA==
X-CSE-MsgGUID: Lz4ENZruSu6w+LrJbhIDVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528864"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:27 -0700
X-CSE-ConnectionGUID: LRXeAl1oQ12KVKgyhg9u2g==
X-CSE-MsgGUID: I2GjLKa5TLiInNtnNAbUFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757816"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:23 -0700
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
Subject: [PATCH 04/15] x86/virt/tdx: Enable the Extensions right after basic TDX Module init
Date: Fri, 22 May 2026 11:41:17 +0800
Message-Id: <20260522034128.3144354-5-yilun.xu@linux.intel.com>
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

The detailed initialization flow for TDX Module Extensions has been
fully implemented. Enable the flow after basic TDX Module
initialization.

Theoretically, the Extensions doesn't need to be enabled right after
basic TDX initialization. It could be enabled right before the first
Extension SEAMCALL is issued. That would save or postpone memory usage.
But it isn't worth the complexity, the needs for the Extensions are vast
but the savings are little for a typical TDX capable system (about
0.001% of memory). So the Linux decision is to just enable it along with
the basic TDX.

Note that the Extensions initialization flow will still not start if no
add-on features require Extensions. The enabling of add-on features will
be in later patches. Until then, the system hasn't consumed extra memory.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index ff2b96c20d2b..dad5ec642723 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1180,7 +1180,7 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
-static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
+static __init void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
 {
 	u64 *entries = page_to_virt(root);
 	int i;
@@ -1193,7 +1193,7 @@ static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
 #define HPA_LIST_INFO_PFN		GENMASK_U64(51, 12)
 #define HPA_LIST_INFO_LAST_ENTRY	GENMASK_U64(63, 55)
 
-static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
+static __init u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
 {
 	return FIELD_PREP(HPA_LIST_INFO_FIRST_ENTRY, 0) |
 	       FIELD_PREP(HPA_LIST_INFO_PFN, page_to_pfn(root)) |
@@ -1201,7 +1201,7 @@ static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
 }
 
 /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
-static int tdx_ext_init(void)
+static __init int tdx_ext_init(void)
 {
 	struct tdx_module_args args = {};
 	u64 r;
@@ -1216,7 +1216,7 @@ static int tdx_ext_init(void)
 	return 0;
 }
 
-static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
+static __init int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
 {
 	struct tdx_module_args args = {
 		.rcx = to_hpa_list_info(root, nr_pages),
@@ -1240,7 +1240,7 @@ static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
 	return 0;
 }
 
-static int tdx_ext_mem_setup(void)
+static __init int tdx_ext_mem_setup(void)
 {
 	unsigned int nr_pages;
 	struct page *page;
@@ -1301,7 +1301,7 @@ static int tdx_ext_mem_setup(void)
 	return ret;
 }
 
-static int __maybe_unused init_tdx_ext(void)
+static __init int init_tdx_ext(void)
 {
 	int ret;
 
@@ -1373,6 +1373,10 @@ static __init int init_tdx_module(void)
 	if (ret)
 		goto err_reset_pamts;
 
+	ret = init_tdx_ext();
+	if (ret)
+		goto err_reset_pamts;
+
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
 out_put_tdxmem:
-- 
2.25.1


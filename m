Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3931836165F;
	Fri, 22 May 2026 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422724; cv=none; b=dk4HsXDWpUaLfbfEiUQpUX6CREs3Di5txOrLoWKrSPgESxZ4jglhgAVIvqc/Qjj8K83/YIjBjsZ8c/46n4lFMmVecLo+zCczyNhb0gtpzS3bud2mBRkzQYzuL6FD98gfHc8flf5KuOiNhy6OJxu6UdHqhTw/FuL0sSyZggO4m3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422724; c=relaxed/simple;
	bh=wVKDvoTMGTGAvIOqU7aOFVQoOMeivgNMcW6+rZyjDVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TxEZ+NcZkYsQWC7Iu29vi8yDUv2DT8a9rxQg7CR268vWsgExeeEUqxI95ubcu3c7kLT1DYZ0ItDtiCnwQm7zoFZcYpqKVVgGLGleAl4xlfZmk3yWZLSi9X0T+TEoUGjnV6wFkxTN/gAnQ+lF7hAYsnSV8ngFgjLSZ5AuvrngD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LS9T9FA1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LS9T9FA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422724; x=1810958724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wVKDvoTMGTGAvIOqU7aOFVQoOMeivgNMcW6+rZyjDVU=;
  b=LS9T9FA14xaPmq4VNDpf6NVAG9vkrF1RPGKoa0mqFLHHscA2uXXBkFan
   XwzP73JbBfmODm+QF/0kFlSAsweB64YirygGq5wL4QVRFGnstt7d0EZ7v
   SOYBajgC8jS94l3/xxyDxvxsEj6eakvNMmNDLNkNp44eF+NlELCFc52FR
   LQzdf2XQPOUwWK7B4RAu1QRjHFByRDiCIAKfxkd/bbEfe8KdrjQIp7nfr
   BCT2cMDBo3NcxNJT/VFE+IUaXBeBBEyCSZqWfRdYOhhNbxiZMNX6CozPs
   5UogYCa+asPX2SxnsGuY4vShNGgg7ABaCQHYfL40zk6SRJAupJ4HBsGEP
   w==;
X-CSE-ConnectionGUID: 5eNuNs3TQmCy9KDbzKsaiQ==
X-CSE-MsgGUID: klwrPW7ZSp2HnFYL8RAuYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528859"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528859"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:23 -0700
X-CSE-ConnectionGUID: fDJ6HtUjR8WSbjAuigccfg==
X-CSE-MsgGUID: Tw0iwhzZTOWFsroHtWz0IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757808"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:19 -0700
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
Subject: [PATCH 03/15] x86/virt/tdx: Make TDX Module initialize Extensions
Date: Fri, 22 May 2026 11:41:16 +0800
Message-Id: <20260522034128.3144354-4-yilun.xu@linux.intel.com>
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

After providing all required memory to TDX Module, initialize TDX
Module Extensions via TDH.EXT.INIT, so Extension-SEAMCALLs can be used.

Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 2335f88bbb10..c5bffd118145 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -46,6 +46,7 @@
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
+#define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 622399d8da68..ff2b96c20d2b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1200,6 +1200,22 @@ static u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
 	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
 }
 
+/* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
+static int tdx_ext_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 r;
+
+	do {
+		r = seamcall(TDH_EXT_INIT, &args);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r != TDX_SUCCESS)
+		return -EFAULT;
+
+	return 0;
+}
+
 static int tdx_ext_mem_add(struct page *root, unsigned int nr_pages)
 {
 	struct tdx_module_args args = {
@@ -1287,6 +1303,8 @@ static int tdx_ext_mem_setup(void)
 
 static int __maybe_unused init_tdx_ext(void)
 {
+	int ret;
+
 	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
 		return 0;
 
@@ -1294,7 +1312,11 @@ static int __maybe_unused init_tdx_ext(void)
 	if (!tdx_sysinfo.ext.ext_required)
 		return 0;
 
-	return tdx_ext_mem_setup();
+	ret = tdx_ext_mem_setup();
+	if (ret)
+		return ret;
+
+	return tdx_ext_init();
 }
 
 static __init int init_tdx_module(void)
-- 
2.25.1


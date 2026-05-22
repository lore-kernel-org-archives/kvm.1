Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776E136A36D;
	Fri, 22 May 2026 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422749; cv=none; b=YnvwhQnizzk6AB8XQeryTWoE75ztiRwG9U8kX2LC556tXim0eb38sKEMS6nSy9vZw0ceVo/crdufytyuMpVMJFFWebz7sLUSJZtrTFD2rSHNIWJqkAl+JgiqnQUiiRRkR9Y136WTIH3w2pCKE46GPat86PxnnTvf4NCM5hmAY8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422749; c=relaxed/simple;
	bh=ayILJB26GsLv0UIRr6dMv36Ehz2Pd3llJF0H2eLreiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgbSferVcX4oCpAbIyGXx8A9gQve9RZ6Ze6C8Cyzy1vJztpaT+FUygxzWlke0TSHX+wX/AmmumEYoWAQ1qGxNSLQD4U5ChWT77JADH02B9y/CIjgyEZy5exJIahSdmDUGBcvsKEazM5xVLJrtIX6Tf0sT9dsvHokqftRBC7kSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YicjNAjZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YicjNAjZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422749; x=1810958749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayILJB26GsLv0UIRr6dMv36Ehz2Pd3llJF0H2eLreiM=;
  b=YicjNAjZ9mCrs6tSlVKJpva+sNArylta2U2HPlaINpxBIwfIOgk1HlWy
   B4igYcqetb2ytXt+Jlx+RmRrAIV9LwONk2tcmAhfgPbA+cGkuoNgou48/
   8x6ySU7YD451FgDfar0YE0TGc+bLPobkeKzfHkzsR+FpFRzvexcCTFJHN
   WRlGCIlKd1IDi2bkfXsru9shl4X66ToLjAfo3kP2N/KaHmy1IHUDgFYfl
   X0GNxTxGfwxwTSUXR9pi203OtRyCCcKt4fFlOOH2C9D60s5i2kUqkV8f6
   bDn37DiBA2FcKczUJt4pNSUZkB5G4UwbXzf8JXTsNWvdc73S1M+exqlbb
   g==;
X-CSE-ConnectionGUID: z8Gy7DvLQqyhZW0z29vVMw==
X-CSE-MsgGUID: hgtgdrUZSv+cRZgwbdWrLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528908"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528908"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:49 -0700
X-CSE-ConnectionGUID: 3eAKhtlCRpOtc5Gsvzp4uw==
X-CSE-MsgGUID: aZiwCtXSQXOT7UrNCWlJNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757886"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:44 -0700
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
Subject: [RFC PATCH 10/15] x86/tdx: Move and rename Quote request structure
Date: Fri, 22 May 2026 11:41:23 +0800
Message-Id: <20260522034128.3144354-11-yilun.xu@linux.intel.com>
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

struct tdx_quote_buf is currently used only by the guest, but the Quote
buffer format will also be needed by the host for in-kernel Quote
generation. Move the definition to tdx.h so it can be shared by both.

Rename the struct to tdx_quote_req to better reflect its purpose.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h              | 21 +++++++++++++++++++++
 drivers/virt/coco/tdx-guest/tdx-guest.c | 25 +++----------------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index bc512a00a0d0..945e6817abb2 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -96,6 +96,27 @@ static inline long tdx_kvm_hypercall(unsigned int nr, unsigned long p1,
 }
 #endif /* CONFIG_INTEL_TDX_GUEST && CONFIG_KVM_GUEST */
 
+#if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_KVM_INTEL_TDX)
+/* struct tdx_quote_req: Format of Quote request message.
+ * @version: Quote format version, filled by TD.
+ * @status: Status code of Quote request, filled by VMM.
+ * @in_len: Length of TDREPORT, filled by TD.
+ * @out_len: Length of Quote data, filled by VMM.
+ * @data: Quote data on output or TDREPORT on input.
+ *
+ * More details of Quote request message can be found in TDX
+ * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
+ * section titled "TDG.VP.VMCALL<GetQuote>"
+ */
+struct tdx_quote_req {
+	u64 version;
+	u64 status;
+	u32 in_len;
+	u32 out_len;
+	u8 data[];
+};
+#endif /* CONFIG_INTEL_TDX_GUEST || CONFIG_KVM_INTEL_TDX */
+
 #ifdef CONFIG_INTEL_TDX_HOST
 u64 __seamcall(u64 fn, struct tdx_module_args *args);
 u64 __seamcall_ret(u64 fn, struct tdx_module_args *args);
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a9ecc46df187..d0ddbbc98fb8 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -171,26 +171,7 @@ static void tdx_mr_deinit(const struct attribute_group *mr_grp)
 #define GET_QUOTE_SUCCESS		0
 #define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
 
-#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_buf))
-
-/* struct tdx_quote_buf: Format of Quote request buffer.
- * @version: Quote format version, filled by TD.
- * @status: Status code of Quote request, filled by VMM.
- * @in_len: Length of TDREPORT, filled by TD.
- * @out_len: Length of Quote data, filled by VMM.
- * @data: Quote data on output or TDREPORT on input.
- *
- * More details of Quote request buffer can be found in TDX
- * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
- * section titled "TDG.VP.VMCALL<GetQuote>"
- */
-struct tdx_quote_buf {
-	u64 version;
-	u64 status;
-	u32 in_len;
-	u32 out_len;
-	u8 data[];
-};
+#define TDX_QUOTE_MAX_LEN		(GET_QUOTE_BUF_SIZE - sizeof(struct tdx_quote_req))
 
 /* Quote data buffer */
 static void *quote_data;
@@ -250,7 +231,7 @@ static void *alloc_quote_buf(void)
  * or error code after processing is complete. So wait till the status
  * changes from GET_QUOTE_IN_FLIGHT or the request being timed out.
  */
-static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
+static int wait_for_quote_completion(struct tdx_quote_req *quote_buf, u32 timeout)
 {
 	int i = 0;
 
@@ -269,7 +250,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 static int tdx_report_new_locked(struct tsm_report *report, void *data)
 {
 	u8 *buf;
-	struct tdx_quote_buf *quote_buf = quote_data;
+	struct tdx_quote_req *quote_buf = quote_data;
 	struct tsm_report_desc *desc = &report->desc;
 	u32 out_len;
 	int ret;
-- 
2.25.1


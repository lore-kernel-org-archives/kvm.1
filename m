Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AC03B52E3;
	Thu, 18 Jun 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772008; cv=none; b=UO4h02FuDDkqQwitP7Sjo9IVrRNR5LSoU39lDoqVpVGN3IWs/iANCYIuiBD1RYRLsLagmYc3ylQNK0eQSbv8AHhA4+aiPcV9ZL9YUJUQObtEmA8PhJOE/6mL9Vj5lBMIGzIPNGw2D2zeZCHXoNxJ4FFO2iJuP3P6iarICd602To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772008; c=relaxed/simple;
	bh=kKmbqPC5uQKuniNFRCFeXtgY/YhQC4ekPf6qX9Q2BnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cy8YmVHbjS5xB2Dt/I6Fp/V/JzofLT9XmYQVMxAfE5bxRy9lA7LftUn6kjug1diJ4w/+zoobasiYMZIgNQRArAWu5dHwaFP6C3mwdjCf+oAZXC7Bzw+OKJGORFjjofLwNm/tLTnx8Qxgw+1wRkagpVA0TIgIs7+icC/8PZ2L/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORAvcdtl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORAvcdtl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772007; x=1813308007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kKmbqPC5uQKuniNFRCFeXtgY/YhQC4ekPf6qX9Q2BnU=;
  b=ORAvcdtlZpvoY2Zw180zDXdDrPXmNmroJQeaYtQx9hfyic/5+fACWza/
   S4gSQ1ZeHLUnfNf8zB9P9kyRIbbDD7iJy5tl3DeQB30towy6Gqlx+kSvs
   NUmoPrj1R3KQ60G5gvGB4bKQ1EB0vsIEUJgKqNO1LKfjp2h1zaU7LZNLW
   cNQqLHZkZ8blRG5qwQLz/T6r9S9WeiwZb+UGqYHfj+oZ4YEABfeYcRhTF
   k9VLsUxvxdvy2fbFJfTNdAiBpPyrod6ruXIy/WPGOGXLSz6X8PKH8Au9g
   IZEw82/rj72RXmsDC1MFg6HWB/GYw3N4ti0l8VivVz/cpo81Retoq3uJs
   w==;
X-CSE-ConnectionGUID: +CDhh53NSduej66Lb46CIA==
X-CSE-MsgGUID: 3Ta8qAt2Qyqx60EUfMVihg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584828"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584828"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:40:07 -0700
X-CSE-ConnectionGUID: q7PB8mYORNCpaKc/gWI4Lg==
X-CSE-MsgGUID: MSypPEG2T9OjF3KEFLgHMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392471"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:40:02 -0700
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
Subject: [PATCH v2 14/17] x86/tdx: Move and rename Quote request structure
Date: Thu, 18 Jun 2026 16:13:52 +0800
Message-Id: <20260618081355.3253581-15-yilun.xu@linux.intel.com>
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

Move struct tdx_quote_buf to tdx.h so it can be shared by the guest
driver and core TDX code, as the host will also need the Quote buffer
format for in-kernel Quote generation.

Rename the struct to tdx_quote_req to better reflect its purpose, and
replace "quote_buf" with "quote_req" in tdx-guest.c.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Dan Williams <djbw@kernel.org>
---
 arch/x86/include/asm/tdx.h              | 20 +++++++++++
 drivers/virt/coco/tdx-guest/tdx-guest.c | 47 ++++++++-----------------
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 34764838f132..24bce7512de3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -66,6 +66,26 @@ struct ve_info {
 	u32 instr_info;
 };
 
+/**
+ * struct tdx_quote_req - Format of Quote request message
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
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index a9ecc46df187..c84ace1cbe99 100644
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
@@ -241,7 +222,7 @@ static void *alloc_quote_buf(void)
 
 /*
  * wait_for_quote_completion() - Wait for Quote request completion
- * @quote_buf: Address of Quote buffer.
+ * @quote_req: Address of Quote buffer.
  * @timeout: Timeout in seconds to wait for the Quote generation.
  *
  * As per TDX GHCI v1.0 specification, sec titled "TDG.VP.VMCALL<GetQuote>",
@@ -250,7 +231,7 @@ static void *alloc_quote_buf(void)
  * or error code after processing is complete. So wait till the status
  * changes from GET_QUOTE_IN_FLIGHT or the request being timed out.
  */
-static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeout)
+static int wait_for_quote_completion(struct tdx_quote_req *quote_req, u32 timeout)
 {
 	int i = 0;
 
@@ -258,7 +239,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 	 * Quote requests usually take a few seconds to complete, so waking up
 	 * once per second to recheck the status is fine for this use case.
 	 */
-	while (quote_buf->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
+	while (quote_req->status == GET_QUOTE_IN_FLIGHT && i++ < timeout) {
 		if (msleep_interruptible(MSEC_PER_SEC))
 			return -EINTR;
 	}
@@ -269,7 +250,7 @@ static int wait_for_quote_completion(struct tdx_quote_buf *quote_buf, u32 timeou
 static int tdx_report_new_locked(struct tsm_report *report, void *data)
 {
 	u8 *buf;
-	struct tdx_quote_buf *quote_buf = quote_data;
+	struct tdx_quote_req *quote_req = quote_data;
 	struct tsm_report_desc *desc = &report->desc;
 	u32 out_len;
 	int ret;
@@ -280,7 +261,7 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	 * Quote buf status is still in GET_QUOTE_IN_FLIGHT (owned by
 	 * VMM), don't permit any new request.
 	 */
-	if (quote_buf->status == GET_QUOTE_IN_FLIGHT)
+	if (quote_req->status == GET_QUOTE_IN_FLIGHT)
 		return -EBUSY;
 
 	if (desc->inblob_len != TDX_REPORTDATA_LEN)
@@ -289,11 +270,11 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 	memset(quote_data, 0, GET_QUOTE_BUF_SIZE);
 
 	/* Update Quote buffer header */
-	quote_buf->version = GET_QUOTE_CMD_VER;
-	quote_buf->in_len = TDX_REPORT_LEN;
+	quote_req->version = GET_QUOTE_CMD_VER;
+	quote_req->in_len = TDX_REPORT_LEN;
 
 	ret = tdx_do_report(KERNEL_SOCKPTR(desc->inblob),
-			    KERNEL_SOCKPTR(quote_buf->data));
+			    KERNEL_SOCKPTR(quote_req->data));
 	if (ret)
 		return ret;
 
@@ -303,23 +284,23 @@ static int tdx_report_new_locked(struct tsm_report *report, void *data)
 		return -EIO;
 	}
 
-	ret = wait_for_quote_completion(quote_buf, getquote_timeout);
+	ret = wait_for_quote_completion(quote_req, getquote_timeout);
 	if (ret) {
 		pr_err("GetQuote request timedout\n");
 		return ret;
 	}
 
-	if (quote_buf->status != GET_QUOTE_SUCCESS) {
-		pr_debug("GetQuote request failed, status:%llx\n", quote_buf->status);
+	if (quote_req->status != GET_QUOTE_SUCCESS) {
+		pr_debug("GetQuote request failed, status:%llx\n", quote_req->status);
 		return -EIO;
 	}
 
-	out_len = READ_ONCE(quote_buf->out_len);
+	out_len = READ_ONCE(quote_req->out_len);
 
 	if (out_len > TDX_QUOTE_MAX_LEN)
 		return -EFBIG;
 
-	buf = kvmemdup(quote_buf->data, out_len, GFP_KERNEL);
+	buf = kvmemdup(quote_req->data, out_len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-- 
2.25.1


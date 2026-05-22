Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD69368D7E;
	Fri, 22 May 2026 04:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422746; cv=none; b=D9+xNQ2rr44oeC20N80WO0XIsMrnGsOPWjrSb7hSLy7U5Y4anvx3Kd10fYEXX2hQkZFyggVMdrOm0Yyte3t4X+zWfIK22kDYRlxi1TAQctv58borOL9DT/6NryrfkkHy+YIdch0oF9JIBsqMgbhQaJ6ex63PG3sNnB5PaU5sAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422746; c=relaxed/simple;
	bh=lQIjaplD7AjyPfmiPear7uZRcXEEq3JOJ/gaDQHmDFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gj96jX/KXKHrUg8agy6kDfws6SDBQHYSbyHi3staHwj9YU/3m4+FLTc5VW4+Q8C34CWK8MCYloJUIre8dlDXpadYBGty9lNdzxBhtHS1udaL+395GTfQmn4gpCUij5xxHIqZZeXqJVTnngWQFJj8t1f6u+qH847+nWh3UN8b2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bT2cfjqU; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bT2cfjqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422745; x=1810958745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQIjaplD7AjyPfmiPear7uZRcXEEq3JOJ/gaDQHmDFI=;
  b=bT2cfjqUP3A3S/SHW/60pqxaDBMdHvT0F5449JqSEw8YlRdNyuyw7sn1
   CKSW4jO5JhwDjbyq1J8nwULpbGhN+paadgzBsTsIbrT4JkJSil+VaDjbv
   QPmnAh2hs1btfF2Cs9yarUVHbTVVG4LNQ2t0JXvbSK0SBjVORf9K0xg13
   PxsIgGEcd/lfkI2O93JkstzO5jd7C4G+av6qbVfzPCBrbmWSeS9hXIY6j
   u0CASRq20TYIFdyr8KP0aPtkXr2FII6zE5T4yCm5JCjkXtbo6RT0hfoFp
   vp71YcCU4tL68lyecFc3oABU6bLk2wXXLiEurjIwSnQyuhR5Ob4w7kr/p
   g==;
X-CSE-ConnectionGUID: UtyZROrDTJWPEkureNP9Jg==
X-CSE-MsgGUID: 4eOtEfWgQxeaV5jG87P0PA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528901"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528901"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:45 -0700
X-CSE-ConnectionGUID: JNHyvX8VTnyNB0HuqFw4zw==
X-CSE-MsgGUID: oJIeWRLxTvuFxyyRUQXRhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757876"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:41 -0700
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
Subject: [RFC PATCH 09/15] x86/virt/tdx: Add interface to generate a Quote
Date: Fri, 22 May 2026 11:41:22 +0800
Message-Id: <20260522034128.3144354-10-yilun.xu@linux.intel.com>
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

Use the TDX Quoting extension's TDH.QUOTE.GET SEAMCALL to generate a
Quote. Since the interface is shared across all KVM instances,
serialize access to the SEAMCALL buffer with a mutex.

Allocate and return a per-call buffer containing the generated Quote so
callers don't need to size the Quote buffer themselves. The caller is
responsible for freeing the returned buffer.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 +
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 82 +++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 7b257088aa1e..bc512a00a0d0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -177,6 +177,8 @@ struct tdx_vp {
 };
 
 bool tdx_quote_enabled(void);
+void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
+			 u32 *quote_len);
 
 static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 3849f4f9cc78..01a7d7d8ada9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -49,6 +49,7 @@
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
+#define TDH_QUOTE_GET			98
 #define TDH_QUOTE_INIT			100
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index b305fa5aab5c..821f677e9a86 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -62,6 +62,8 @@ static LIST_HEAD(tdx_memlist);
 static struct tdx_sys_info tdx_sysinfo __ro_after_init;
 static bool tdx_module_initialized __ro_after_init;
 
+static DEFINE_MUTEX(tdx_quote_lock);
+
 static struct quote_data {
 	void *buf;
 	u64 buf_len;
@@ -1228,6 +1230,86 @@ bool tdx_quote_enabled(void)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
 
+#define QUOTE_ID_MASK		GENMASK_U64(47, 32)
+
+static u64 tdx_quote_get(struct tdx_td *td, u64 in_data_pa, u64 in_data_len,
+			 u64 hpa_list_pa, u64 total_len, u64 *quote_len)
+{
+	struct tdx_module_args args = {
+		.rcx = tdx_tdr_pa(td),
+		/* Don't bother specifying the quote id */
+		.rdx = QUOTE_ID_MASK & (u64)-1,
+		.r8 = in_data_pa,
+		.r9 = in_data_len,
+		.r10 = hpa_list_pa,
+		.r11 = total_len,
+	};
+	u64 r;
+
+	do {
+		r = seamcall_ret(TDH_QUOTE_GET, &args);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	*quote_len = args.rcx;
+
+	return r;
+}
+
+/**
+ * tdx_quote_generate() - Generate a quote for a TD
+ * @td: The TD to generate the quote for.
+ * @in_data: Input data for the quote request.
+ * @in_data_len: Size of the input data in bytes.
+ * @quote_len: Returned size of the generated quote in bytes.
+ *
+ * Use the TDX Quoting extension to generate a TD quote. Pass the input data
+ * through the shared quote buffer and return the quote.
+ *
+ * Return: Newly allocated quote buffer or %NULL on failure.
+ * The caller must free the returned buffer with kvfree().
+ */
+void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
+			 u32 *quote_len)
+{
+	void *quote_dup = NULL;
+	u64 r, out_len;
+
+	if (!tdx_quote_enabled())
+		return NULL;
+
+	/* TDH.QUOTE.GET expects the input data to fit in a page */
+	if (in_data_len > PAGE_SIZE)
+		return NULL;
+
+	mutex_lock(&tdx_quote_lock);
+
+	/*
+	 * Use the first page of the quote buffer for input data. The buffer
+	 * must be at least one page in size. @in_data may not be page-aligned,
+	 * but TDH.QUOTE.GET expects page-aligned addresses.
+	 */
+	memcpy(quote_data.buf, in_data, (size_t)in_data_len);
+
+	r = tdx_quote_get(td, quote_data.hpa_list[0], (u64)in_data_len,
+			  quote_data.hpa_list_pa, quote_data.buf_len, &out_len);
+	if (r || !out_len || out_len > quote_data.buf_len)
+		goto out;
+
+	/*
+	 * The quote buffer is a shared resource, so use it only for the
+	 * SEAMCALL and copy the data out as soon as possible.
+	 */
+	quote_dup = kvmemdup(quote_data.buf, out_len, GFP_KERNEL);
+
+out:
+	mutex_unlock(&tdx_quote_lock);
+
+	*quote_len = (u32)out_len;
+
+	return quote_dup;
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_quote_generate);
+
 #define HPAS_PER_PAGE			(PAGE_SIZE / sizeof(u64))
 
 static int tdx_quote_create_buf(unsigned int nr_pages, struct quote_data *qdata)
-- 
2.25.1


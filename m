Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BC83B95E3;
	Thu, 18 Jun 2026 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771994; cv=none; b=saJ8f+8GbZuMDJKtw7gcQ6z3jaV6XCnA/5/t5da5w13iOx4EHx6LspYhXhTASeznIsEpVsMg+o8hnaFy5LfbKQEYI/pDeVmyn0mKOTFNRgOSXw7v6pvxNXRBrzoBQnih42VwU/JC1e5iQCOXhTb4063vrOU6ntIZoJqy2zq1mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771994; c=relaxed/simple;
	bh=bApBCZGLJINMJAhFWqe+D+cb8G5o9UIDb0DTrmy/y/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFMkdQfmTNRZrh51oIa3lynoVo98tSXvbrVYdc2NjTSH0prPBnmltuRSV6C0tCXRuMzksbWx6rYfQzzu71CGMoXdFd12IGkAL9q9Kdp0IssWUJJ/bimwyzSYtGDgYkl7IyDWkwhUt9ARfixzROjhAUBRzj+HITfAOcPo2lN0Fyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSJq46k2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSJq46k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771993; x=1813307993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bApBCZGLJINMJAhFWqe+D+cb8G5o9UIDb0DTrmy/y/g=;
  b=HSJq46k2ruxpMdYlyxEBcj1ojHMbqgprwcpLfWSr2sCinMw/RRFRdi6V
   Ef+jhbtjuNc/bVMDID59XrXlNITTRATYAbdyf2dfG5MvCXVrpbswzseK+
   kkMuJiazCYfs9kan0ktjcrPNMOnu3Fd2GRR7OPYXo0alRhoUrii9Pk1Va
   8/GDWs7SEk5T8ilalTkSTf6v6Kg+irD6mgI4dBQKg3uMhZyBPe5qdrmIV
   Q1dNBK2hQ2DZ4XElkC9WT/87Wan8wxfi6E72mj11b8H6IKjPY/bUK+9CF
   wGJXcIpQcKVNg+CsOkAuNGNZ01+qvG6iST4kNIIKv+NKyj+MAwwwAJKL2
   A==;
X-CSE-ConnectionGUID: WzT8UQnFQSW/yGYlJce5HA==
X-CSE-MsgGUID: SHKI8dumSZKF+tugpl6pxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584796"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:53 -0700
X-CSE-ConnectionGUID: kCekTg9+QmavQKRfsTEzpA==
X-CSE-MsgGUID: 2LhaAd+SRpC6H5/7BmNdUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392379"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:48 -0700
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
Subject: [PATCH v2 11/17] x86/virt/tdx: Add interface to generate a Quote
Date: Thu, 18 Jun 2026 16:13:49 +0800
Message-Id: <20260618081355.3253581-12-yilun.xu@linux.intel.com>
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

Provide an interface to generate a Quote via the TDH.QUOTE.GET
Extension-SEAMCALL. Although the TDX module may support concurrent Quote
generation, use a single shared buffer for simplicity and serialize
access with a mutex. TDX bringup code already prepares the buffer in the
format required by the TDX module.

Return a per-call buffer containing the Quote so callers don't need to
size the buffer themselves. The caller is responsible for freeing the
returned buffer.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 +
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 77 +++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 9432a736855e..34764838f132 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -148,6 +148,8 @@ struct tdx_vp {
 };
 
 bool tdx_quote_enabled(void);
+void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
+			 u32 *quote_len);
 
 static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 1afa0b10dfc9..32b13b0c85f9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -66,6 +66,7 @@
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
+#define TDH_QUOTE_GET			98
 #define TDH_QUOTE_INIT			100
 
 /* TDX page types */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1e2c7a33c7a9..ac0da4966697 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -72,6 +72,8 @@ static LIST_HEAD(tdx_memlist);
 
 static struct tdx_sys_info tdx_sysinfo;
 
+static DEFINE_MUTEX(tdx_quote_lock);
+
 /*
  * Quote buffer shared with the TDX module for quote generation, in HPA linked
  * list format.
@@ -1208,6 +1210,81 @@ bool tdx_quote_enabled(void)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
 
+static u64 tdx_quote_get(struct tdx_td *td, u64 in_data_pa, u64 in_data_len,
+			 u64 hpa_entries_pa, u64 total_len, u64 *quote_len)
+{
+	struct tdx_module_args args = {
+		.rcx = tdx_tdr_pa(td),
+		/* [47:32] QUOTE_ID: All-1s selects the default quote format */
+		.rdx = GENMASK_U64(47, 32),
+		.r8 = in_data_pa,
+		.r9 = in_data_len,
+		.r10 = hpa_entries_pa,
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
+ * @in_data_len: Size of @in_data in bytes. Must not exceed one page.
+ * @quote_len: Returned size of the generated quote in bytes.
+ *
+ * Generate a quote using the TDX module. Pass the input data through the quote
+ * buffer and return the quote.
+ *
+ * Return: Newly allocated quote buffer or %NULL on failure.
+ * The caller must free the returned buffer with kvfree().
+ */
+void *tdx_quote_generate(struct tdx_td *td, void *in_data, u32 in_data_len,
+			 u32 *quote_len)
+{
+	struct tdx_quote_data *qdata = &tdx_quote;
+	void *quote_dup = NULL;
+	u64 r, out_len;
+
+	if (!tdx_quote_enabled())
+		return NULL;
+
+	mutex_lock(&tdx_quote_lock);
+
+	/*
+	 * Use the first page of the quote buffer for input data. The buffer
+	 * must be at least one page in size. @in_data may not be page-aligned,
+	 * but TDH.QUOTE.GET expects page-aligned addresses.
+	 */
+	memcpy(qdata->buf, in_data, in_data_len);
+
+	r = tdx_quote_get(td, qdata->hpa_entries[0], in_data_len,
+			  qdata->hpa_entries_pa, qdata->buf_len, &out_len);
+	if (r != TDX_SUCCESS || !out_len || out_len > qdata->buf_len)
+		goto out;
+
+	/*
+	 * The quote buffer is a shared resource, so use it only for the
+	 * SEAMCALL and copy the data out as soon as possible.
+	 */
+	quote_dup = kvmemdup(qdata->buf, out_len, GFP_KERNEL);
+
+	*quote_len = (u32)out_len;
+
+out:
+	mutex_unlock(&tdx_quote_lock);
+
+	return quote_dup;
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_quote_generate);
+
 #define HPAS_PER_NODE			(PAGE_SIZE / sizeof(u64))
 
 /*
-- 
2.25.1


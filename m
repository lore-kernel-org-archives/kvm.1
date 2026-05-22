Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AF368970;
	Fri, 22 May 2026 04:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422742; cv=none; b=iy8j5eUOtNsznuaqiiiVc0N8Og7UIz1PPiwqtb5trJZv2zXYdj7PE3Bmn9Fz2c24OiobvPDWG3k5K4L15mSaDxvjivVs+n7Hts8CO4lg5kDVV0i4M5gNOXrNhzoe6gzYQq86NmmLXZGjzmm51IyCimn3SRdR5fr7XagLdeIUKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422742; c=relaxed/simple;
	bh=31ha/xXzWg2Cp2e443o9F/TFSMDVUgUGwpgtyY6pwr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RsnOqRjByWtF6NLT+5zTxaECs2F5tHV75/ie6fgYY5miMy81Hkluv6VAMkTiVFLmbQjX+hb9NuuXBFChgrgCf6NYOXaFrGfX7R1i5koMmycpj/erOkd6sf+VgXrpJ6TYpuZneZ53mfE1DRZL9rrD3jSmJRhH7OCesMicEFP+GAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EgHK/HOK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EgHK/HOK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422742; x=1810958742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31ha/xXzWg2Cp2e443o9F/TFSMDVUgUGwpgtyY6pwr8=;
  b=EgHK/HOKPxC926a078qBtE+NUs2G1GXASX2Zq8uCFXSQXKSRCNmHW+VB
   vcZDOELfLclA8rhBQZ+iqnNXofYedRUX5ExPsjRAzPHVhx4QwGr/SOMhG
   4xy48GN0sjpcWVC+sACtCHhxkt1HY8uFajGeHGOjflKFLNodfqTzk7EGM
   bpqO5aIXlDDhDHTHhYOtAY1krnsSECqveB3eKtdv9tuYW/3XDsGovMhqA
   neouH8BDI+vs+OQlVSg2WNVuHb33YwgH8v6AWZ2QPP8xsfAmHmH95ofrq
   XuV1RUKVsYhaxR66mL+sbR7g3i83F8C7pUQ16jdXwg1kWQJ2+aMqKI2ft
   w==;
X-CSE-ConnectionGUID: BY42SDdIS8SUfr9d6E7vmw==
X-CSE-MsgGUID: ki/k7OGeSmG2ndvcoVle5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528895"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528895"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:42 -0700
X-CSE-ConnectionGUID: Fr6Uol6YRiyi6yQ5S0pRhg==
X-CSE-MsgGUID: PxoOMIpoQ+GXPTK8MPPh7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757859"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:37 -0700
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
Subject: [RFC PATCH 08/15] x86/virt/tdx: Add interface to check Quoting availability
Date: Fri, 22 May 2026 11:41:21 +0800
Message-Id: <20260522034128.3144354-9-yilun.xu@linux.intel.com>
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

KVM needs to know if the Quoting extension is available to determine
whether userspace must be involved in Quote generation.

Since the Quote buffer is always created during Quoting extension
bringup, checking whether the buffer exists is sufficient.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx.h  |  2 ++
 arch/x86/virt/vmx/tdx/tdx.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 15eac89b0afb..7b257088aa1e 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -176,6 +176,8 @@ struct tdx_vp {
 	struct page **tdcx_pages;
 };
 
+bool tdx_quote_enabled(void);
+
 static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
 {
 	u64 ret;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9d04293394d7..b305fa5aab5c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1213,6 +1213,21 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
+/**
+ * tdx_quote_enabled() - Check whether TDX Quoting extension is available
+ *
+ * Return: %true if the Quoting extension is available, otherwise %false.
+ */
+bool tdx_quote_enabled(void)
+{
+	/*
+	 * No need for locking here. The quote buffer is initialized as part of
+	 * core TDX bringup, which comes before KVM is ready for userspace.
+	 */
+	return !!quote_data.buf;
+}
+EXPORT_SYMBOL_FOR_KVM(tdx_quote_enabled);
+
 #define HPAS_PER_PAGE			(PAGE_SIZE / sizeof(u64))
 
 static int tdx_quote_create_buf(unsigned int nr_pages, struct quote_data *qdata)
-- 
2.25.1


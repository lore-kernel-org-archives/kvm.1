Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1B36728B;
	Fri, 22 May 2026 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422736; cv=none; b=bic/4H/A+gqiY79v4eQxJhdF7QqH0MT6nWxoBs1mAHK40tahT2eYTTGrxU6EqjLSdpZULWnutmnj2UGvprTZC4b+I/vBFaoRAcSC8leh76Bo0x1kymizKmTGvZfu8jE9Ns+1N/zE41P94sR0vPJxGCLItbZ+2cO+wlrcXtb5lgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422736; c=relaxed/simple;
	bh=q+2JEprIlQ5R8t6RRxPJMKafyGuH3bMWylgYmO6diGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpHiiAlU3m1rBqDjLbbCU1LLdZHx7vrpQHYgLUhp5aSfYE+8rr5Gj7GJ6q5UDeNc2w5P6guZ80ujUi+g555f6S/VgsDndv9q2O0UviNz7tmY7G//JPPmMXLP9hvW3gTz0K4a4hKz/unprJIQUKYyhQeZDlAPsrHTekV59YjGzKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG9oqWb5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG9oqWb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422734; x=1810958734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q+2JEprIlQ5R8t6RRxPJMKafyGuH3bMWylgYmO6diGc=;
  b=SG9oqWb5/Z00CVjXAK9jW330Jh8EoC0sZO0ZZNCZwJEQE7v/M2SQ+jrT
   RnNmC+/9fP1LoL2LsNXBuDgNo6SuDSDaKjZFKzBzHzcQdR6Ksedr6Rzzt
   FQ60enz7Pyeq1YFYUwkgpS7lRkgqTAIK9K7Kk+iZdIVJKmjZJgdE6sqE/
   SWC+Rj4UPB8zO74hbg//wbw4aNlqoEsEIbtzg5m9fEYjOxsYUMzNmAgHv
   Q84NmZjzwsmXtGqhZK9DC3qcdhBAqo8ozcHXTnVqurfl7yRb+YExMY6Fz
   7WlKVSKUK9K8K5aMoyoqLJ3ALvF1kjdf3Q4J0X+/bghc2NKCZRD0FeE75
   g==;
X-CSE-ConnectionGUID: FXFfuhObT32VirW+4VnI8A==
X-CSE-MsgGUID: bj3anAKSQomSEGfz1d7PiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528882"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528882"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:34 -0700
X-CSE-ConnectionGUID: QSLVibgETN6SC3yUt4Z8dg==
X-CSE-MsgGUID: XALUMBIXSVKMsFMrjGVFVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757836"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:30 -0700
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
Subject: [RFC PATCH 06/15] x86/virt/tdx: Initialize Quoting extension during bringup
Date: Fri, 22 May 2026 11:41:19 +0800
Message-Id: <20260522034128.3144354-7-yilun.xu@linux.intel.com>
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

Initialize the Quoting extension and fetch its metadata during TDX
bringup.

Because Quoting is an optional TDX feature, do not let its
initialization failures cause TDX bringup to fail.

This patch does not include the opt-in portion of the initialization.
It mainly lays the groundwork for TDX Quoting support. Opt-in will be
added in a follow-up patch once the feature can be properly used by the
system.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/include/asm/tdx_global_metadata.h  |  5 ++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  1 +
 arch/x86/virt/vmx/tdx/tdx.c                 | 29 ++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 11 ++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 533afe50a3f1..04f515cd4c1d 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -45,6 +45,10 @@ struct tdx_sys_info_ext {
 	u8 ext_required;
 };
 
+struct tdx_sys_info_quote {
+	u32 max_quote_size;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
@@ -52,6 +56,7 @@ struct tdx_sys_info {
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
 	struct tdx_sys_info_ext ext;
+	struct tdx_sys_info_quote quote;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index c5bffd118145..3849f4f9cc78 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -49,6 +49,7 @@
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
+#define TDH_QUOTE_INIT			100
 
 /*
  * SEAMCALL leaf:
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 67758adefb4a..fb84fb6d952b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1205,6 +1205,22 @@ static inline u64 tdx_tdr_pa(struct tdx_td *td)
 	return page_to_phys(td->tdr_page);
 }
 
+static void tdx_quote_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 r;
+
+	do {
+		r = seamcall(TDH_QUOTE_INIT, &args);
+	} while (r == TDX_INTERRUPTED_RESUMABLE);
+
+	if (r)
+		return;
+
+	/* Quoting metadata is valid only after initialization */
+	get_tdx_sys_info_quote(&tdx_sysinfo.quote);
+}
+
 /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
 static __init int tdx_ext_init(void)
 {
@@ -1306,6 +1322,13 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
+static int init_tdx_ext_features(void)
+{
+	tdx_quote_init();
+
+	return 0;
+}
+
 static __init int init_tdx_ext(void)
 {
 	int ret;
@@ -1321,7 +1344,11 @@ static __init int init_tdx_ext(void)
 	if (ret)
 		return ret;
 
-	return tdx_ext_init();
+	ret = tdx_ext_init();
+	if (ret)
+		return ret;
+
+	return init_tdx_ext_features();
 }
 
 static __init int init_tdx_module(void)
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 3d3b56ef3d2f..f9cc2dd02caf 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -113,6 +113,17 @@ static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
 	return ret;
 }
 
+static int get_tdx_sys_info_quote(struct tdx_sys_info_quote *sysinfo_quote)
+{
+	int ret = 0;
+	u64 val;
+
+	if (!ret && !(ret = read_sys_metadata_field(0x2300000200000002, &val)))
+		sysinfo_quote->max_quote_size = val;
+
+	return ret;
+}
+
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
-- 
2.25.1


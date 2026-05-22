Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6B377007;
	Fri, 22 May 2026 04:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422768; cv=none; b=JSlIx+aRKoqSGfslgAa+cWOeSzFbNCkpz7d7QvN8F/NawCSrqMMufoVAXuGKABRi/s2W4I5u+cEvhay+dE4jP9ZMCTPJZJ4kNUjOlxn9Ds0XYwz92BEX7HOek3bXeyEw+2ffw/4K1y2j4t4De5xPVGPKpZeA1/0+PkzZSjN1SEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422768; c=relaxed/simple;
	bh=4Stvo2XFlVxPfHj+dM/JOUHcILSlwmXS/k3FEGF2pm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+nHWkdBbuH9g6vVRYIkolr/OjcFeUDaRD2ahYyZhUcibGeUdacBzkvK4zJAB7dvmkqGQcB3nNcVyocxgfRE8poVSZtshhW2yJbNlRBJrka/6MGjXGg289QcEoTHIQmBJULtN9wrntiz/ZTFE66QvsePXjCxZWg/eQH4jCjMHCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=guvOn5v8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guvOn5v8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422767; x=1810958767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Stvo2XFlVxPfHj+dM/JOUHcILSlwmXS/k3FEGF2pm8=;
  b=guvOn5v89sf7M6AeFjoVjFk2otvx6Wj+bXsBkOci69v3EuzZS/NDpo6u
   StOIyAK8ZGaskELiSDe5Z/Tn3Fur7T8YeSOOEStJ0bjgv9vk47Jl58zvX
   1SiLClevEUDBzaDp4DzfV87coguOCLjRZy4i7S3Bj17SD4/TuSvA+5HFy
   CECZrxF5TUzkKW0/GY0JYSoRTB8oG9EdW41SzduAVRANBIPKTO3s445Yk
   qy5Sa/E6SJEgQVHOJ/NTmPkiRMbffyVG7y9eHADaUCcx5JGY9T+kNb6wB
   jCCVxNYyGl9KybymFfqxUeC0QhfUIk8NQQ62yU+ioO5QtGbyZQzoqOnep
   w==;
X-CSE-ConnectionGUID: OMak20nqSyqYGStRAUaSrA==
X-CSE-MsgGUID: JiVAAdwsRcioseUdg+w/Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528936"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528936"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:06:07 -0700
X-CSE-ConnectionGUID: vdnPNLHdQyyext91gtCB5g==
X-CSE-MsgGUID: msPiaawYRy+msVJ7kQJ89Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757961"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:06:03 -0700
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
Subject: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
Date: Fri, 22 May 2026 11:41:28 +0800
Message-Id: <20260522034128.3144354-16-yilun.xu@linux.intel.com>
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

Enable the TDX Quoting feature via TDH.SYS.CONFIG when supported by the
TDX module.

The TDX Quoting extension generates TDX attestation Quotes via a
SEAMCALL, without using a discrete Quoting engine.

TDX Module supports add-on TDX features (e.g. TDX Quoting & TDX Module
Extensions) that should be manually enabled by host. It extends
TDH.SYS.CONFIG for host to choose to enable them on bootup.

Call TDH.SYS.CONFIG with a new bitmap input parameter to specify which
features to enable. The bitmap uses the same definitions as
TDX_FEATURES0. But note not all bits in TDX_FEATURES0 are valid for
configuration, e.g. TDX Module Extensions is a service that supports TDX
Quoting, it is implicitly enabled when TDX Quoting is enabled. Setting
TDX_FEATURES0_EXT in the bitmap has no effect.

TDX Module advances the version of TDH.SYS.CONFIG for the change, so
use the latest version (v1) for add-on feature enabling. But supporting
existing Modules which only support v0 is still necessary until they are
deprecated. In fact, it is unlikely that TDH.SYS.CONFIG ever needs to
change again and the code would stay in v1. So there is little value
in worrying about deprecating v0 to save a couple lines of code in 5-7
years when these original TDX platforms sunset.

TDX Module updates global metadata when add-on features are enabled.
Host should update the cached tdx_sysinfo to reflect these changes.

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Peter Fang <peter.fang@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h |  4 +++-
 arch/x86/virt/vmx/tdx/tdx.c | 24 ++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 10aff23cd01f..524a14c01aa6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -58,7 +58,8 @@
 #define TDH_PHYMEM_CACHE_WB		40
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
-#define TDH_SYS_CONFIG			45
+#define TDH_SYS_CONFIG_V0		45
+#define TDH_SYS_CONFIG			SEAMCALL_LEAF_VER(TDH_SYS_CONFIG_V0, 1)
 #define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
@@ -97,6 +98,7 @@ struct tdmr_info {
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
 #define TDX_FEATURES0_EXT		BIT_ULL(39)
+#define TDX_FEATURES0_QUOTE		BIT_ULL(50)
 
 /*
  * Do not put any hardware-defined TDX structure representations below
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index f7600f930c6e..86e5b7ad19b3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1049,6 +1049,7 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
+	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
 	struct tdx_module_args args = {};
 	u64 *tdmr_pa_array;
 	size_t array_sz;
@@ -1074,8 +1075,22 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	args.rcx = __pa(tdmr_pa_array);
 	args.rdx = tdmr_list->nr_consumed_tdmrs;
 	args.r8 = global_keyid;
-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
 
+	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE) {
+		args.r9 |= TDX_FEATURES0_QUOTE;
+		/* These parameters require version >= 1 */
+		seamcall_fn = TDH_SYS_CONFIG;
+	}
+
+	ret = seamcall_prerr(seamcall_fn, &args);
+	if (ret)
+		goto free_tdmr;
+
+	/* enabling TDX Quoting may change tdx_sysinfo, update it */
+	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE)
+		ret = get_tdx_sys_info(&tdx_sysinfo);
+
+free_tdmr:
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);
 
@@ -1384,12 +1399,17 @@ static void tdx_quote_init(void)
 	unsigned int nr_quote_pages;
 	u64 r;
 
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE))
+		return;
+
 	do {
 		r = seamcall(TDH_QUOTE_INIT, &args);
 	} while (r == TDX_INTERRUPTED_RESUMABLE);
 
-	if (r)
+	if (r) {
+		pr_err("Failed to enable quoting extension: 0x%llx\n", r);
 		return;
+	}
 
 	/* Quoting metadata is valid only after initialization */
 	if (get_tdx_sys_info_quote(&tdx_sysinfo.quote))
-- 
2.25.1


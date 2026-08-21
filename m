Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B54375ABE;
	Fri, 21 Aug 2026 03:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282975; cv=none; b=Wr+tM2H06GR9pP1jPz+bGSh9EXRctN2H0D408Za/WULF5G7U5SdfgFxuG31jqZq37HpAN4eteJs8YjyWOnJjp0FSljPw4K4DA1R9JuA5wpwOxcrca6GcN9tHdlS0RiljrZ3xkRyQiTH3x0ZT0Hg4wwOLtMdbdR5SvhVU72zGtLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282975; c=relaxed/simple;
	bh=6rvVFKxEnernaSvmYoh25XXuJSQ+q6hKX3xaltJL/Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlyeffI8P6cttXc7TdkGkL9ALS4CO+V9UZuCFQYhroCCsvGPGaflwnRfXuEgMyrmqVeNWbZRkyuTA3z25X7HXREM3tbUstLUA+AOrYPluLV8F7GLWaMpn7ErT0wqtcBTSl3RYRJi/Pw6PUCV2tMO7rOminfXbinb91IVfNUyz60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyltVBrG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyltVBrG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282972; x=1818818972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6rvVFKxEnernaSvmYoh25XXuJSQ+q6hKX3xaltJL/Wk=;
  b=kyltVBrGSDbUSDsVy+uu+xS0mMvWW6YKgM613TbMDgAPYxpEhEBCMU8q
   74/khRBqvwlJyzLOgP+cBUqga0iWuSlCK8+GuQs82hkY+2YTtBZNxQiV4
   5oDgiu++jNejQwAEhtKiL8X59Q1fiO+6T1eNAi2OgiLcKdcmpXXTLTWLM
   UZg7/gAGrjTU32OHhCpJ5QDCoXSXEJyYHJR3PW7H+a4vpMVuGsWCveEbj
   rxXcUKkDPXuXu/j+oqpdl9pj8DJzUX+odjafWlccEm12iMV2C4eMJghBG
   sL57ycFxiHp5CF1YxOBXNbmGWRDuvOc5k5bJrhgPGpc95AUVVMVC1AUNZ
   Q==;
X-CSE-ConnectionGUID: 2sVdjlvyQNqTZuzjtgKqUw==
X-CSE-MsgGUID: ezbatukYQvCnUULJBYUlZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640230"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:32 -0700
X-CSE-ConnectionGUID: ej9bZVR0QWKoAcw3GavhhQ==
X-CSE-MsgGUID: jargdX2nSzS+DkYr60TYLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451594"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:29 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
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
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org
Subject: [PATCH 2/6] x86/virt/tdx: Configure add-on features on TDX module init and update
Date: Fri, 21 Aug 2026 11:29:16 +0800
Message-Id: <20260821032920.256225-3-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821032920.256225-1-yilun.xu@linux.intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX architecture identifies some features that must be explicitly
enabled when the kernel supports them. These add-on features affect
existing TDX systems: they may change existing feature behavior, reserve
more memory, or impact TDX initialization performance. The kernel must
enable these add-on features at boot or post-update time.

TDISP, DICE-based quoting and TD migration are among those add-on
features, as their SEAMCALL leaves depend on a SEAMCALL execution
context built by the TDX module extensions. On the other hand, the TDX
architecture doesn't allow the extensions to be initialized if none of
these features are enabled. Add support for configuring add-on features,
as the prerequisite for enabling the extensions.

The TDX module extends TDH.SYS.CONFIG and TDH.SYS.UPDATE with new bitmap
parameters to specify which add-on features to enable. The bitmap
uses the same feature bits as TDX_FEATURES0. Add a
get_tdx_addon_features0() helper to return the bitmap of the add-on
features that the module & kernel both support. Initially, this helper
returns 0. It will be updated to return specific feature bits as full
kernel support lands. Pass this extra bitmap to TDH.SYS.CONFIG helper.

The TDX module requires SEAMCALL leaf version 1 for TDH.SYS.CONFIG and
TDH.SYS.UPDATE when passing the new bitmap parameter. A previous
change [1] supports the versioned SEAMCALL leaves by adding a "version"
field in struct tdx_module_args. Set the version field to 1 if any bit
is set in this bitmap.

Compatible updates keep the reported features unchanged across updates,
so that existing TDX users can continue to operate without disruption.
To adhere to this, provide TDH.SYS.UPDATE with the same bitmap returned
by get_tdx_addon_features0(). This works because the module supported
feature bits are cached at boot and never refreshed after updates, so
the returned bitmap always matches the initial TDH.SYS.CONFIG input.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Link: https://lore.kernel.org/all/20260722084634.131020-1-yilun.xu@linux.intel.com/ # [1]
---
v1:
 - Use tdx_module_args.version to assign SEAMCALL leaf versions (Dave)
 - Remove DICE specific descriptions (Rick)
 - Remove the global var tdx_addon_features0 (Chao)
 - Add a Macro to collect kernel supported add-on feature bits (Rick)
 - Changelog & code comments change
---
 arch/x86/virt/vmx/tdx/tdx.c | 38 +++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e6b664b76141..66b43350c6c3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -998,12 +998,22 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+/* List all kernel supported add-on features0 bits here */
+#define TDX_KERNEL_SUPPORTED_ADDON_FEATURES0	(0)
+
+static u64 get_tdx_addon_features0(void)
+{
+	return tdx_sysinfo.features.tdx_features0 &
+		TDX_KERNEL_SUPPORTED_ADDON_FEATURES0;
+}
+
 struct tdmr_info_pa_array {
 	DECLARE_FLEX_ARRAY(u64, phys);
 };
 
 static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
-				 u64 nr_tdmr_pa, u64 global_keyid)
+				 u64 nr_tdmr_pa, u64 global_keyid,
+				 u64 addon_features0)
 {
 	struct tdx_module_args args = {
 		.rcx = __pa(tdmr_pa_array),
@@ -1011,12 +1021,22 @@ static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
 		.r8 = global_keyid,
 	};
 
+	/*
+	 * Use SEAMCALL version 1 that supports add-on features if any are
+	 * requested. Use version 0 if none for backward compatibility.
+	 */
+	if (addon_features0) {
+		args.r9 = addon_features0;
+		args.version = 1;
+	}
+
 	return seamcall_prerr(TDH_SYS_CONFIG, &args);
 }
 
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
+	u64 addon_features0 = get_tdx_addon_features0();
 	struct tdmr_info_pa_array *tdmr_pa_array;
 	size_t array_sz;
 	int i, ret;
@@ -1039,7 +1059,7 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 		tdmr_pa_array->phys[i] = __pa(tdmr_entry(tdmr_list, i));
 
 	ret = tdx_sys_config(tdmr_pa_array, tdmr_list->nr_consumed_tdmrs,
-			     global_keyid);
+			     global_keyid, addon_features0);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);
@@ -1319,18 +1339,28 @@ int tdx_module_shutdown(void)
 	return 0;
 }
 
-static int tdx_sys_update(void)
+static int tdx_sys_update(u64 addon_features0)
 {
 	struct tdx_module_args args = {};
 
+	/*
+	 * Use SEAMCALL version 1 that supports add-on features if any are
+	 * requested. Use version 0 if none for backward compatibility.
+	 */
+	if (addon_features0) {
+		args.r9 = addon_features0;
+		args.version = 1;
+	}
+
 	return seamcall_prerr(TDH_SYS_UPDATE, &args);
 }
 
 int tdx_module_run_update(void)
 {
+	u64 addon_features0 = get_tdx_addon_features0();
 	int ret;
 
-	ret = tdx_sys_update();
+	ret = tdx_sys_update(addon_features0);
 	if (ret)
 		return ret;
 
-- 
2.25.1


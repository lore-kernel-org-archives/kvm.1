Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF6376481;
	Fri, 21 Aug 2026 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282970; cv=none; b=gsZFxv/CISK3pZBcMcB1BrqIa7rt34EWg42bUSa1oUtaAhGgP7/5Iq8AH1uJKx4+7AvRDz3jINNk/aRJU+ozI7y6PkW0g/OMOflhhADNDAAqMewvNppQhX1QPiFDLFq9poizccF0flBxVA1rFgX+glMIbZ24JQJlfLp5vh1H8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282970; c=relaxed/simple;
	bh=jQ/6jTsL7xHFq0CUQFu2tng7jbSNUzKL86CMcOyZm+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnmm3Q6II3T/3wDIj/R0XBa80fJSwAI42GfeOhQfgbMa52TbsafgHJqX3C1OBZ+EWHeBOEjPzcGS6lYcIV1O8JGDTHx8Cv3Y9bTHhmKlH+8F8CbS+J1CkPgJGOuO8DnfNErRoS2o6vuePL4H611M3Zut1ZrzKG0gIjMBW3W1xlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgD3qO8w; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgD3qO8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282969; x=1818818969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQ/6jTsL7xHFq0CUQFu2tng7jbSNUzKL86CMcOyZm+U=;
  b=VgD3qO8w5fo/UgB2hI1IBm7jiMu3c3XJo16tUDslCb6MLprFqhFZaxME
   885KAP9Sr2ZkbAQW6fk9oP+FZe3qBvHu3JjjNUAuH21kN6nsWOQz9H8cX
   UaXQh4gNInb4Sp8PmR6rnxCSXfTOftxT7BsWj2sf/tPC2ysy4IdYLxS71
   dpP4zOPoqv30mKk1GEWP4KoTDy6mHnOiFZZG+vld7+1g4rTqm5p8TLJYF
   /yaiBOpODBaCmy+Lnk/97oBeCfxPBVGtKifrNhMkWKEuh7/5bo4Y97Cau
   6aRVni9whvpdIyuT17wWLAtmJHbwH2exuWYRfu1y6lZ/m0segCrHve2qK
   g==;
X-CSE-ConnectionGUID: DxNF1m13Qgiw3uNmQC9IAw==
X-CSE-MsgGUID: f8BmwCoLSyqVzR1zCmbh9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640226"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640226"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:28 -0700
X-CSE-ConnectionGUID: 3k0a7FsUS0CVVHP2rfb5Dw==
X-CSE-MsgGUID: 9evOJi/nSJSWDEJ02DEWyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451590"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:25 -0700
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
Subject: [PATCH 1/6] x86/virt/tdx: Wrap TDH.SYS.CONFIG/UPDATE operations in helpers
Date: Fri, 21 Aug 2026 11:29:15 +0800
Message-Id: <20260821032920.256225-2-yilun.xu@linux.intel.com>
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

As part of the TDX module initialization, the kernel configures the TDX
module with several information, such as TDX-usable memory regions
(TDMRs) and the global KeyID for protecting TDX metadata. During the
configuration, the kernel does 2 operations: constructing kernel data
types for the SEAMCALL leaf arguments and turning these data types into
u64's according to TDX ABI.

Both operations are implemented in one function - config_tdx_module().
This blurs the boundary between kernel managed structures and TDX ABI
definitions. Moreover, future kernel change will need to add more
nuances mandated by TDX ABI, such as setting the TDH.SYS.CONFIG leaf
version to allow configuring add-on features. Keeping these operations
tangled would further clutter the code.

Just like other SEAMCALL leaf helpers, wrap the invocation of
TDH.SYS.CONFIG in a helper. Introduce a more descriptive kernel data
type for the physical address array of TDMR information. This data type
is similar to struct seamldr_params in that it is the container of the
PA array layout which is an in-memory ABI. So the previous u64 * type
for the array is not wrong, but a named structure provides better type
safety and self-documentation. Use the data type as the argument of the
TDH.SYS.CONFIG helper.

Future kernel change will also need to set the TDH.SYS.UPDATE leaf
version for the same purpose. Add a similar helper to prepare for the
change.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
v1:
 - This patch is split out from the last series (Rick)
---
 arch/x86/virt/vmx/tdx/tdx.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7a89e29b118c..e6b664b76141 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -998,11 +998,26 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+struct tdmr_info_pa_array {
+	DECLARE_FLEX_ARRAY(u64, phys);
+};
+
+static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
+				 u64 nr_tdmr_pa, u64 global_keyid)
+{
+	struct tdx_module_args args = {
+		.rcx = __pa(tdmr_pa_array),
+		.rdx = nr_tdmr_pa,
+		.r8 = global_keyid,
+	};
+
+	return seamcall_prerr(TDH_SYS_CONFIG, &args);
+}
+
 static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 				    u64 global_keyid)
 {
-	struct tdx_module_args args = {};
-	u64 *tdmr_pa_array;
+	struct tdmr_info_pa_array *tdmr_pa_array;
 	size_t array_sz;
 	int i, ret;
 
@@ -1021,12 +1036,10 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 		return -ENOMEM;
 
 	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
-		tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));
+		tdmr_pa_array->phys[i] = __pa(tdmr_entry(tdmr_list, i));
 
-	args.rcx = __pa(tdmr_pa_array);
-	args.rdx = tdmr_list->nr_consumed_tdmrs;
-	args.r8 = global_keyid;
-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
+	ret = tdx_sys_config(tdmr_pa_array, tdmr_list->nr_consumed_tdmrs,
+			     global_keyid);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);
@@ -1306,12 +1319,18 @@ int tdx_module_shutdown(void)
 	return 0;
 }
 
-int tdx_module_run_update(void)
+static int tdx_sys_update(void)
 {
 	struct tdx_module_args args = {};
+
+	return seamcall_prerr(TDH_SYS_UPDATE, &args);
+}
+
+int tdx_module_run_update(void)
+{
 	int ret;
 
-	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
+	ret = tdx_sys_update();
 	if (ret)
 		return ret;
 
-- 
2.25.1


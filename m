Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6094D6C4F;
	Mon,  5 Oct 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222350; cv=none; b=rKbN4bFJi/RRaxjboAtFgZ5sJbe3m8S0zszPeHKiIXTyuMxjuPB1CvyzYXY7vVXJ5gR9R+YUn84VFXdMLK5WbWaNk3I2Cykcx38ARNRwBayzHr0ZQilraMG+lpAL5/mqTygdfbAtGqfWI+dl04p6LkIVpcaj6w+eCvBSrqizjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222350; c=relaxed/simple;
	bh=VoBdfpvY+pyJ1C5KZvELGMwDDYl7WKx7crn14bonFNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u4sUD3yaOXODI4TDt9iEQtGsnXG3uLfApu4rV8HXDqEwqLqZC2Xw7CpEv0kBRfi8NuB47vhY5D3DZx9Ggi/RTmrEIbK6Ieza5Bzj5NgX7j08z/Lsp+Av5G1NWhgdkiuQGOJzA1EUNcMZrAqEc+M1hJcYShJA3WpJFKiznRQNIhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFo5N97u; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFo5N97u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222349; x=1822758349;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VoBdfpvY+pyJ1C5KZvELGMwDDYl7WKx7crn14bonFNA=;
  b=JFo5N97un2X6YvM+Fg3yms+suVLS1cNede+Qr1Ar5GzdcCFyhebAa2pg
   iYUFQ8/2CcVx8LnGivKnCifoGRpiJEUa921Ni1rcp+/H6llnKSh1DD93r
   W8NgzYuB+Gt6rZ6YB2vJnAfLzjok5HXktMTR2ry7u5opk5IhRnkeOR3aP
   S2CwJP692ryz6lDeu4HH6BsCqjhxF0BiWjugsoDFN0hvcUkD/rNvQjj3D
   GYNbJKVeb4uFuiyO0Qg3c1g9dxc+9bGLKf7At6D7bZKzQVlXo3lHD0N6Z
   31XIBU5Mlu8UiIvt13B6Q8S9eBoahgYdUkromAKULNBrSp0ZbL9p8l/BT
   A==;
X-CSE-ConnectionGUID: G7UHHQSBT+mV1ew0ZHhGNA==
X-CSE-MsgGUID: 8vgC8rlTTpy4eq6M2xLFtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102419772"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102419772"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:45:49 -0700
X-CSE-ConnectionGUID: IAETLm9BTpuP0jzNpVxtLw==
X-CSE-MsgGUID: kJdBWu5MSHC3zHRZFaA36A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276002271"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 10:45:44 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 06 Oct 2026 01:41:45 +0800
Subject: [PATCH v3 1/6] x86/virt/tdx: Move TDH.SYS.CONFIG operations into a
 wrapper
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-tdx-module-ext-v3-1-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5493;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=VoBdfpvY+pyJ1C5KZvELGMwDDYl7WKx7crn14bonFNA=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWQdfjgraVvJwsJNwSuKv0oLTJkq3jlp3oGts3lu+E0Su
 qj+q1mptaOThUGMg8FQTJFlgccspynts5i2ftp5DWYOKxPIEGGZysyc0jy9ilKHzLyS1By95Pxc
 Bi5OAZgqkXqGfzZJqx76PXQstJDT8n7Qoia5tzSvfsLuJeKTctfFaXQ/bWZkmBllKmr09Vt4lWL
 ExPv8AsrXGK+9uhEVn23l+27v918zeQA=
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

In Linux, SEAMCALL wrappers are introduced to avoid broad SEAMCALL
access by exposing only a selection of SEAMCALL leafs, but also to
abstract the SEAMCALL register ABIs. The abstraction improves
readability and reuse for SEAMCALL leafs that are called multiple times.

Some SEAMCALL leafs are not explicitly wrapped because the level of TDX
ABI details needed to perform the call is low enough to flow well with
the calling code.

For some of the currently unwrapped SEAMCALL leafs, the TDX architecture
has evolved the ABI to introduce new leaf versions. The host can select
the version to call based on what is supported by the loaded TDX module.
When future kernel implements this version selection, more ABI details
will leak into the surrounding caller code, which decreases the
readability of the caller logic. To keep the ABI details contained, move
the SEAMCALL leaf that will need version selection into a wrapper.

When defining the wrapper, the cleanest separation would be to have
kernel data types for the SEAMCALL wrapper arguments, and have them
marshaled into SEAMCALL leaf ABI types (often u64s) inside the wrapper.
This works for many SEAMCALL leafs but becomes cumbersome when the
register ABI type is a physical address which points to a buffer for an
in-memory ABI. If the SEAMCALL wrapper only accepts kernel data types,
it may need duplicate buffer allocation and copies to match the
in-memory ABI. Another solution is to define a named helper structure
that mirrors the in-memory ABI, populate it in a separate flow, then
pass it to the SEAMCALL wrapper. struct seamldr_params is an existing
example of this pattern.

TDH.SYS.CONFIG requires a list of TDMR information in the form of a PA
array. The PA array is the in-memory ABI. Create a structure for the PA
array, use it as the argument when creating the wrapper for
TDH.SYS.CONFIG.

For readability, adjust a bit of the existing PA array size calculation:
use the new PA array structure's element type instead of hardcoding u64.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v3:
 - sizeof(tdmr_pa_array->phys[0]) instead of sizeof(u64) (Rick)
 - Re-phrase the code comments for struct tdmr_info_pa_array (Tony)
 - Refactor the changelog
 - Collect Reviewed-by tags
v2:
 - Remove TDH.SYS.UPDATE wrapper (Dave & Rick)
 - Talk about the handling of in-memory ABIs for SEAMCALL wrappers
   (Rick)
 - Refactor the entire changelog according to Rick's suggestion (Rick)
 - Add code comment for struct tdmr_info_pa_array (AI nitpicker)
 - Use kernel data type for nr_tdmr_pa parameter (AI nitpicker)

v1:
 - This patch is split out from the last series (Rick)
---
 arch/x86/virt/vmx/tdx/tdx.c | 46 +++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 96ced0494b68..b099aa4056f5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1033,11 +1033,36 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 
 #define TDX_SYS_CONFIG_DYNAMIC_PAMT	BIT(16)
 
+/*
+ * TDX module in-memory ABI to specify the TD Memory Regions (TDMRs) and their
+ * associated PAMT memory. An array of HPAs, each element points to a
+ * TDMR_INFO, see struct tdmr_info.
+ */
+struct tdmr_info_pa_array {
+	DECLARE_FLEX_ARRAY(u64, phys);
+};
+
+static __init int tdx_sys_config(struct tdmr_info_pa_array *tdmr_pa_array,
+				 unsigned int nr_tdmr_pa, u64 global_keyid)
+{
+	struct tdx_module_args args = {
+		.rcx = __pa(tdmr_pa_array),
+		.rdx = nr_tdmr_pa,
+		.r8 = global_keyid,
+	};
+
+	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
+		pr_info("Enable Dynamic PAMT\n");
+		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
+	}
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
 
@@ -1046,7 +1071,8 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 	 * addresses of each TDMR.  The array itself also has certain
 	 * alignment requirement.
 	 */
-	array_sz = tdmr_list->nr_consumed_tdmrs * sizeof(u64);
+	array_sz = tdmr_list->nr_consumed_tdmrs *
+		sizeof(tdmr_pa_array->phys[0]);
 	array_sz = roundup_pow_of_two(array_sz);
 	if (array_sz < TDMR_INFO_PA_ARRAY_ALIGNMENT)
 		array_sz = TDMR_INFO_PA_ARRAY_ALIGNMENT;
@@ -1056,18 +1082,10 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
 		return -ENOMEM;
 
 	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++)
-		tdmr_pa_array[i] = __pa(tdmr_entry(tdmr_list, i));
-
-	args.rcx = __pa(tdmr_pa_array);
-	args.rdx = tdmr_list->nr_consumed_tdmrs;
-	args.r8 = global_keyid;
-
-	if (tdx_supports_dynamic_pamt(&tdx_sysinfo)) {
-		pr_info("Enable Dynamic PAMT\n");
-		args.r8 |= TDX_SYS_CONFIG_DYNAMIC_PAMT;
-	}
+		tdmr_pa_array->phys[i] = __pa(tdmr_entry(tdmr_list, i));
 
-	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
+	ret = tdx_sys_config(tdmr_pa_array, tdmr_list->nr_consumed_tdmrs,
+			     global_keyid);
 
 	/* Free the array as it is not required anymore. */
 	kfree(tdmr_pa_array);

-- 
2.25.1


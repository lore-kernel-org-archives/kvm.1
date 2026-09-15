Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC09E47F3B2;
	Tue, 15 Sep 2026 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468029; cv=none; b=pYy7qO3d41mjo0FqFjwzc+ewgHfEgz2Uaz6jKwSj7/UMUwBY/10uJTOmIX/W0M6MpbidtHzYmeEf1XUXRFJYBOYra5lAeltI61UxLZ57LuBu5ebcMZVxhgXR1i/DpK8cX/7BjYAupX5tlioe+c4dalGwucnS8Ti14PDb+09awrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468029; c=relaxed/simple;
	bh=RVBh2IvuMYYeMSffuMEUJG/Elo1pXdYmWihhIAlmmnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TsZaTB0LExCvdZMhbUPFlw00CkNqFaIY2HJTmrgdhMuJt3a0NoiW5qYIjR4ROV7rVtLQuuX07b7egwUZFw3LFBlhdvNwgP+4n+lxaSt5JDCJas2c6sGAnrYVtinLKUHRPsaFydWegOCd0VBrXbIgf2W69aMzgIHhellgrEVo/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buI2Q1zA; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buI2Q1zA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789468028; x=1821004028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RVBh2IvuMYYeMSffuMEUJG/Elo1pXdYmWihhIAlmmnM=;
  b=buI2Q1zANrFdP9EPEJRf/hOOCBSyS2f/zq8xwAptpR4evO8DTu3EIrEP
   Rh5ByPFMAAfpuS6i0LNBejBOlsHj2aP1tJbRaqjHJqV4Pto3FAN7DXmye
   TNbAUaCVziZglZShUp0yBjg46X+wePh2bo+IWvnyJ/0PC//Lx1tJIoO/C
   0ZQ0NxYktfzCE6r6dLodd5EyHWD1CPMkc/IR8FFRf2/Ufl8ak532vsMAh
   w8zaFkyYfkyLrFGhz5DasUmF3B4LTDo9ZSxiyDYPT3hNUudzzxcR+udyO
   P/wijFx/Vcik1HeMndSc0lAvVnTYpgRdj4+Sy/4CU/SMmIfadNjAMYxbc
   A==;
X-CSE-ConnectionGUID: kVBAg31JSmqxN4c6T6Twgg==
X-CSE-MsgGUID: rntDAirHRreP3njNXZwVrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115362194"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115362194"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:27:08 -0700
X-CSE-ConnectionGUID: 1XYfA3p6TIC1VsFfIUG7mA==
X-CSE-MsgGUID: BDG/SmmTRvap5Qad5mNAfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277083976"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2026 03:27:03 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
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
	kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 1/5] x86/virt/tdx: Move TDH.SYS.CONFIG operations into a wrapper
Date: Tue, 15 Sep 2026 18:26:54 +0800
Message-Id: <20260915102658.713079-2-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915102658.713079-1-yilun.xu@linux.intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Linux, SEAMCALL wrappers are introduced to avoid broad SEAMCALL
access by exposing only a selection of SEAMCALL leafs, but also to
abstract the SEAMCALL register ABIs. The latter improves readability and
reuse for SEAMCALL leafs that are called multiple times.

Some SEAMCALL leafs are not explicitly wrapped because the level of TDX
ABI details needed to perform the call is low enough to flow well with
the calling code.

For some of the currently unwrapped SEAMCALL leafs, TDX architecture
adjusts the ABI and adds SEAMCALL version selection for backward
compatibility. Future kernel will need to support the changes. This will
leak more ABI details into the surrounding caller code and decrease
readability of the other logic. To keep the ABI details contained, move
the SEAMCALL leafs that will need version selection into wrappers.

The cleanest separation would be to have kernel data types for the
SEAMCALL wrapper arguments, and have them marshaled into SEAMCALL leaf
ABI types (often u64s) inside the wrapper. This works for many SEAMCALL
leafs but becomes cumbersome when the register ABI type is a physical
address which points to a buffer for an in-memory ABI. If the SEAMCALL
wrapper only accepts kernel data types, it may need duplicate buffer
allocation and copies to match the in-memory ABI. Another solution is
to define a named helper structure that mirrors the in-memory ABI,
populate it in a separate flow, then pass it to the SEAMCALL wrapper.
struct seamldr_params is an existing example of this pattern.

TDH.SYS.CONFIG requires a list of TDMR information in the form of a PA
array. The PA array is the in-memory ABI. Create a structure for the PA
array, use it as the argument when creating the wrapper for
TDH.SYS.CONFIG.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
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
 arch/x86/virt/vmx/tdx/tdx.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1668f8615607..e06932f80395 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -998,11 +998,33 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
 	return ret;
 }
 
+/*
+ * This is an array of HPAs, each points to a TDMR_INFO data structure (see
+ * struct tdmr_info).
+ *
+ * It is the in-memory ABI that the kernel passes to the TDX module to specify
+ * the ranges of TD Memory Regions (TDMRs) and their associated PAMT memory.
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
 
@@ -1021,12 +1043,10 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
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
-- 
2.25.1


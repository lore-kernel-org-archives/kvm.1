Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3CF450404;
	Mon, 12 Oct 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798652; cv=none; b=nZt6ou9zrsi6qLACgfRBIgHXWzOerGpwEwY7ZHCHP37aw7hlUQZB8VbZ9Jdua2pPy+YKp3zjkkdiopsOfl3B5DjAbQ6z1YpJ/3noXXw1WdoW0aQHtqtWKx+8ZMjExYH/N7yUr3ppoSk9PH2HFr9n6FAxMJwK8HqypLPn9anj4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798652; c=relaxed/simple;
	bh=M+AMXBnauGSHuc9f/yVE6H3XrxnqpnEGmGgfCqJF/Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBPit4u/wuxTVWgrDWy/Xys6YKgo2nT8fT28om8kbhP4gE3JtoAC/Sx8ip4nla2+sHXhzc8m9VKpEj3YQMjm5dSNJgdaa3L3b7Xuu2ycrxxSABHIwXKpPKeAsxtjqvSWm7+qdxnaCIK6sv3k/uOBAFRG3eMlPup4M99Yk6c/ZsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtWQHIQC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtWQHIQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798644; x=1823334644;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M+AMXBnauGSHuc9f/yVE6H3XrxnqpnEGmGgfCqJF/Xk=;
  b=OtWQHIQCwPM9dSRbWCPoRnc2Hl8GoOBwIsLT4lTafdnHPP/jTewmJfgh
   1Zu+0LfKB7/6TBMh+V6qjy2bJHgULs3CMuq6cdf9Jpwr5mCREFhT/z6DX
   vUa2VifTBa6YOpRt2VRSMLFO+RJnNu/ATJ1FN0HQqoeQ8f66hkTTJqBFw
   CgKqp0QlsufI84wlbt6P4daejVx9EX+dIURlX1k/6Fsomh5L64KnW8O0K
   4W6baYpV4GegGBJ8YNV3/ehzAW/xUHf85EEELIroWapAb/RAYRyYLRC/B
   6ADnE6uk0hO0m8QYoPcQAT4jm1XZObzVZuimELiy+Mx4B22niVIFTx3/M
   g==;
X-CSE-ConnectionGUID: AmX0WAiASMeJXsq1uLwM7Q==
X-CSE-MsgGUID: St+wawvhTaiBeAi3M6VJrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="388044"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="388044"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:25 -0700
X-CSE-ConnectionGUID: lLXIHkfMRSyzqStoZ3HFmA==
X-CSE-MsgGUID: VwvrgDHzS9mMTpkmDC+AIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776870"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:25 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	rick.p.edgecombe@intel.com,
	nik.borisov@suse.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH v4 08/10] x86/virt/tdx: Remove tdx_global_metadata.c
Date: Mon, 12 Oct 2026 02:47:35 -0700
Message-ID: <20261012094754.27702-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012094754.27702-1-chao.gao@intel.com>
References: <20261012094754.27702-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tdx_global_metadata.c held the script-generated metadata readers,
deliberately kept in their own file so that generated code stayed separate
from hand-written code. It cannot be compiled on its own because it lacks
the low-level SEAMCALL wrappers, so tdx.c #includes it directly.

Including one C file into another is unusual, and now that the readers are
maintained by hand there is nothing left to isolate. get_tdx_sys_info() is
the only function still in the file.

Move get_tdx_sys_info() verbatim into tdx.c and delete
tdx_global_metadata.c along with its #include.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 28 +++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 36 ---------------------
 2 files changed, 27 insertions(+), 37 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 26cfa3b51647..d9f2ace9993a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -527,7 +527,33 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
 	return 0;
 }
 
-#include "tdx_global_metadata.c"
+static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	int ret = 0;
+
+	ret = ret ?: read_sys_metadata_table(version_mappings, &sysinfo->version);
+
+	pr_info("Module version: " TDX_VERSION_FMT "\n",
+		sysinfo->version.major_version,
+		sysinfo->version.minor_version,
+		sysinfo->version.update_version);
+
+	ret = ret ?: read_sys_metadata_table(features_mappings, &sysinfo->features);
+	ret = ret ?: read_sys_metadata_table(tdmr_mappings, &sysinfo->tdmr);
+	ret = ret ?: read_sys_metadata_table(td_ctrl_mappings, &sysinfo->td_ctrl);
+	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
+
+	/*
+	 * The kernel supports using TDX without DPAMT, so
+	 * avoid reporting failure if it's not supported. Don't
+	 * try to support buggy TDX modules that advertise
+	 * DPAMT but don't expose the metadata.
+	 */
+	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
+		ret = read_sys_metadata_table(dpamt_mappings, &sysinfo->tdmr);
+
+	return ret;
+}
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
deleted file mode 100644
index ef7f5a5d74ae..000000000000
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ /dev/null
@@ -1,36 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Functions to read TDX global metadata.
- *
- * This file doesn't compile on its own as it lacks of inclusion
- * of SEAMCALL wrapper primitive which reads global metadata.
- * Include this file to other C file instead.
- */
-
-static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
-{
-	int ret = 0;
-
-	ret = ret ?: read_sys_metadata_table(version_mappings, &sysinfo->version);
-
-	pr_info("Module version: " TDX_VERSION_FMT "\n",
-		sysinfo->version.major_version,
-		sysinfo->version.minor_version,
-		sysinfo->version.update_version);
-
-	ret = ret ?: read_sys_metadata_table(features_mappings, &sysinfo->features);
-	ret = ret ?: read_sys_metadata_table(tdmr_mappings, &sysinfo->tdmr);
-	ret = ret ?: read_sys_metadata_table(td_ctrl_mappings, &sysinfo->td_ctrl);
-	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
-
-	/*
-	 * The kernel supports using TDX without DPAMT, so
-	 * avoid reporting failure if it's not supported. Don't
-	 * try to support buggy TDX modules that advertise
-	 * DPAMT but don't expose the metadata.
-	 */
-	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
-		ret = read_sys_metadata_table(dpamt_mappings, &sysinfo->tdmr);
-
-	return ret;
-}
-- 
2.52.0


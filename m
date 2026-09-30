Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE243B42D7;
	Wed, 30 Sep 2026 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746884; cv=none; b=pIhxfVAr0I+JY7uB9uJRHtx07iD8ash0sLkFi/lBofTzxOcPthtG/dOFL7cHnXSszlnP5aB9mVn+Eoowob9MQYTSyiWHcGGMWHH0AS9v648F2bJP3DPEu78u5sJxUy7vplFvBBtA23m2UkeY7cD3inEhr7Spk0o4JUgmCp9IIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746884; c=relaxed/simple;
	bh=cwDtfRYsdH3jMKIPH+Tp4JIlHXZp7wg/7Z6hCNh+7Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqrvxVgR+Wi5f+O7L68u4UPaa3CPqL7k4AhKMqVQThlA49XJKNXH2QEAQ1iobolMtN0MYiZvUVCygfVxhiTPZkh3n4bM+WhlrbrkpfbA4cin2DqfP2shARMZbWzT/6d4a8RV3iazGmewWbOgZ/GbxG8j6sK9AFkHUjW4Z6KOTT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyuXyGOd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyuXyGOd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746880; x=1822282880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwDtfRYsdH3jMKIPH+Tp4JIlHXZp7wg/7Z6hCNh+7Kc=;
  b=NyuXyGOd8dh3CzsH4P42dMMsV9grmKeiV8KON38TX30a8mSIHO+/NbqK
   Wlx4LV9jzNlZe3AUqkqC95kJDBUIwDKBAqS1tkBSRS4jbV+VbUZOZW1L7
   PbvcTXKkaeuH+E4xmfvhvRzkT9dOIy58NAtHh/imd2jt4v/UQZ7sTKSZd
   VkkaLAAOi20XAxsYrAFlE3+8W/CGsV8Ix2PfV3g8LnZ4UzXBdMkicQCDZ
   6PXss4JuIYa3W2QjcfTWZtUKx6UBbBVLK+RORDe3bSxs+hPKH6A66bsdI
   u6nwcQFFRQpM50x+z7gcCfJwN9G01nru9z9q1Mar+8khW6VEVDYeBSlR7
   w==;
X-CSE-ConnectionGUID: Q6SM1KuQQ8C/yo8YxA6zaA==
X-CSE-MsgGUID: 6mwpZCzNTneR9VajHedwUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149126"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149126"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:04 -0700
X-CSE-ConnectionGUID: sTTmDoFFSFm3PXWEnU4rgg==
X-CSE-MsgGUID: cmN4yuJITgKcc2C4nAizeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936430"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:03 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH v3 08/10] x86/virt/tdx: Remove tdx_global_metadata.c
Date: Tue, 29 Sep 2026 22:38:42 -0700
Message-ID: <20260930053901.22528-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260930053901.22528-1-chao.gao@intel.com>
References: <20260930053901.22528-1-chao.gao@intel.com>
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
index e821ab76a140..1a69beb62ec2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -535,7 +535,33 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
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
+	ret = ret ?: read_sys_metadata_table(feature_mappings, &sysinfo->features);
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
index f248c962fd5d..000000000000
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
-	ret = ret ?: read_sys_metadata_table(feature_mappings, &sysinfo->features);
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


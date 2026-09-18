Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893954FC8F8;
	Fri, 18 Sep 2026 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738315; cv=none; b=W+BZX1RWtVBpsIswOmYp29AWi5scTogKwE6ZEJTHmpzcjODFimhmcLj30+0oxXKOfZVYRNh7p1yj5Qjb1Y4T2dROKBQmmuf56/YFHxpwcQh5U8xqg62UJgZQjcJHGm/jfLvG7jTgjBUZbco1XB0dZU8Vb8LL8yxMsygbS4ywwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738315; c=relaxed/simple;
	bh=mMGCeH//SNrx1fHXEwq75XhJmx2UaZvdS2pGuD3H8lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5CvPc9wKjKOIVAP+H0bRkA6VudOUQ7zQZmpG6njwQ/kaVnxvefN73C1aMKpHsBgZEpyiwGOzlrZkw6m8xpdhEPjbppwDEFgI+Y1bDLOsYBtVmoKXwEKR9ZfhaYAssa5GUyEnD3/0hmuRkGfj5t34rOMZIO+YQbViKS9DpzOjVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4vpbGSM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4vpbGSM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738313; x=1821274313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mMGCeH//SNrx1fHXEwq75XhJmx2UaZvdS2pGuD3H8lE=;
  b=N4vpbGSM0OLcXe/ZnKYOIw8aVG5gFyJH1VesV8DOc6x3N5SWbtv1RpCn
   YQSRmbhcjWbUJTbCXukE8kcXm5RWFbY2E4p12IwMbtTX2DmAMD0HMvsom
   GyLM+52xoMVkX8wn53serAw2CDAaHZlpDBuF+LBRtg8kpkayX3rfUf/a2
   TqBnk6nRBAZWAtQnnNRfOOk0stiM7UTQOtS6q0uxrI3N9hHdQ2LuSVLla
   Kx4ncWbBcS2fFcf7LRitqEse8E+ZGh5/5Gfe58CPjrHgsQcO8wVrJthPm
   2lUKokckrbGOFw1Zi8og3PDndfjyApqjFJbQELk9+eIZKlc0993vqcRSe
   g==;
X-CSE-ConnectionGUID: TLHdbFvuQt+3kIyh+oA7oQ==
X-CSE-MsgGUID: g5vvXq0fRH+YqjDXCfQgnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776164"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776164"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:46 -0700
X-CSE-ConnectionGUID: wmHZ6n1BSwCgsVw9Xgnkbw==
X-CSE-MsgGUID: Sqcab6TgQ6+L/aSRxQVnXQ==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:45 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC PATCH v2 08/10] x86/virt/tdx: Remove tdx_global_metadata.c
Date: Fri, 18 Sep 2026 06:29:27 -0700
Message-ID: <20260918132946.76533-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260918132946.76533-1-chao.gao@intel.com>
References: <20260918132946.76533-1-chao.gao@intel.com>
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
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 28 +++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 36 ---------------------
 2 files changed, 27 insertions(+), 37 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 571c3bb50532..9f9f2ef80f55 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -562,7 +562,33 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
 	return 0;
 }
 
-#include "tdx_global_metadata.c"
+static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	int ret = 0;
+
+	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
+
+	pr_info("Module version: " TDX_VERSION_FMT "\n",
+		sysinfo->version.major_version,
+		sysinfo->version.minor_version,
+		sysinfo->version.update_version);
+
+	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
+	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
+	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
+
+	/*
+	 * The kernel supports using TDX without DPAMT, so
+	 * avoid reporting failure if it's not supported. Don't
+	 * try to support buggy TDX modules that advertise
+	 * DPAMT but don't expose the metadata.
+	 */
+	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
+		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
+
+	return ret;
+}
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
deleted file mode 100644
index 779c26e68f02..000000000000
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
-	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
-
-	pr_info("Module version: " TDX_VERSION_FMT "\n",
-		sysinfo->version.major_version,
-		sysinfo->version.minor_version,
-		sysinfo->version.update_version);
-
-	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
-	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
-	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
-	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
-
-	/*
-	 * The kernel supports using TDX without DPAMT, so
-	 * avoid reporting failure if it's not supported. Don't
-	 * try to support buggy TDX modules that advertise
-	 * DPAMT but don't expose the metadata.
-	 */
-	if (!ret && tdx_supports_dynamic_pamt(sysinfo))
-		ret = get_tdx_sys_info_tdmr_dpamt(&sysinfo->tdmr);
-
-	return ret;
-}
-- 
2.52.0


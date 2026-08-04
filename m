Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190735C6A1;
	Tue,  4 Aug 2026 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843073; cv=none; b=BKkA6S7huWbNUuWSJ4FNW0TwHTs4t9WmBHrZMTgpIlrAtdL4fblE7kdyR0m71L2zarIvdk8XjbpDunSkv6YY8g9tMki87Dh1kRVMdik6jT5pbd7jqasYGMuFGh3GKP9CcSRsLQKOFx1KoQN8SkyRknMTNBMRu/6bhwGEHq+2qzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843073; c=relaxed/simple;
	bh=HqIsEUmWY18ptGel6idwJk4Clpr2GS3PBY7r0EKYLqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfgLaVSjGFIQiGBFewRE7s/UDjiRwKjTHrkXiodP1c2RW54ONtOmv0zH3Sc7dvx/aAjLOzDHaPAmR+rAUzaKQqNVniuPFJ2sqshqi/ys4YgM1xGO0GhZUNwhXPgs+cNRihQjW/vf8bR91d2z0HaoQKuZ+p5RHCFS9BlfhgX2eyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFYicmXj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFYicmXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843071; x=1817379071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HqIsEUmWY18ptGel6idwJk4Clpr2GS3PBY7r0EKYLqI=;
  b=PFYicmXj0gMI4JU2Gcj4c+NskMWyPpzgJ+KCojXZ8uhyoxoXFZS3sZV/
   KSYV6BtlGVUm0+O1sBt4RUNWzX52Qvknz3SQFAqjehCS51zjm0IR7GHn6
   vxJiATNYEpCJoi00LLeNMNEMjMIFzEMtV7mMwTHhVhdd8tWRtzw8EiwNk
   M4svQhQTdVBb+8p8AHrKGzbZlONzP6v3zP+odwHfGfR6MC1OgmI6F+h30
   YwbkoZneAcftDy2Qs3ekgMuUSubDniuxvphVI+BUKUAYwCReeoHJb4FKN
   c0ys2aNOi9q5GSzIzXXGrPsRHuQ3xlZ/1DUApKIsjkDFbeNSEiHiiFsD8
   w==;
X-CSE-ConnectionGUID: ncDyduHVQw2du3tCkDoYyQ==
X-CSE-MsgGUID: CYJqdGkHQWWweZwT5whckg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244251"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244251"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:08 -0700
X-CSE-ConnectionGUID: RDzO+XVkQeab3Cr0G5YJHQ==
X-CSE-MsgGUID: GRcZlCUfQNeH+L8yDcth2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323112"
Received: from jf.jf.intel.com (HELO 984fee019967.jf.intel.com) ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:08 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: [PATCH v1 6/8] x86/virt/tdx: Remove the auto-generated tdx_global_metadata.c
Date: Tue,  4 Aug 2026 04:29:34 -0700
Message-ID: <20260804112941.19894-7-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260804112941.19894-1-chao.gao@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave@sr71.net>

With all metadata classes converted, the only thing left in the
auto-generated tdx_global_metadata.c is get_tdx_sys_info().

Move it into tdx.c so that the auto-generated file can be deleted, along
with the unusual `#include "tdx_global_metadata.c"`.

No functional change intended.

Assisted-by: Claude:claude-opus-5
Not-yet-signed-off-by: Dave Hansen <dave@sr71.net>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 19 ++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 27 ---------------------
 2 files changed, 18 insertions(+), 28 deletions(-)
 delete mode 100644 arch/x86/virt/vmx/tdx/tdx_global_metadata.c

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 98534e702144..1b8cd7656f36 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -527,7 +527,24 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
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
+	return ret;
+}
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
deleted file mode 100644
index 4d673cac0976..000000000000
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Automatically generated functions to read TDX global metadata.
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
-	return ret;
-}
-- 
2.52.0


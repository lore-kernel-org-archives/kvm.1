Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045C735F610;
	Tue,  4 Aug 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843073; cv=none; b=US7eQsBlSRxsKT+WrzJEN5IN5nI/D5uZO2lNUQiP3xqMrTgyr9s1YtIFLvnqi+jrsjkWAtQQ8VZHHA1AgJDKTnwgBXCBU4GdTMjSFlPXd+4+9Ia8yZgfL2v/PHtJ/wrxONWYc8YgeZAGd4u22BpIIYH+uDQM+HGo5PqxWPpkT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843073; c=relaxed/simple;
	bh=Y6lxi0uxHnn0/lNIpZP0YyNVdKosqCsqHIC38cmFdfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVrUYamevx887SsP9uJ1gPpXzQGv4kCSdPSjwkTqLDYn21K9lypXNpJs06MF86XgbDRY5K8ORHgUqAjB7B2ycQqkU2U7g4e1fgQze7eHaN1gg0TqtzYG+9hmNjX2hYLT+6UzvMy2g/Cl9RjDym7J5tixr87yIZAZy9zXuYn3fpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5zPP8Em; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5zPP8Em"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843072; x=1817379072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y6lxi0uxHnn0/lNIpZP0YyNVdKosqCsqHIC38cmFdfg=;
  b=B5zPP8EmH97KJke1mzRt0Spm6I1eXgYk5J7Ttai7Ke+HYugLXDObIRXv
   uHALe8uWR1/CEL54GHOJC699MOvWs2siLW06A6NVZWdDQXAIxPskf/laD
   9aROe+bWZ78hrVIEVrhqg5f3rTxv1lRyBQYPt4TsECmr7ZCsddxTqcPjp
   RnVEaHi1ltKQo0/qsrXmvsjJLJttzcFcjSNbB3yLYfaScKTRZSX2nOqKh
   ygxou6iG0tie0d2dsFWfrfX+wfc6aWf8PXRmmL9mBpNQrc52m4PmtElQJ
   w6wbMPX1aT5qSKBsXiG+poMtcw4gTp02EU9IHDKtm3IiB7NXbmjfsRnDq
   g==;
X-CSE-ConnectionGUID: fnkrtBovTi6ND6RlOy76oA==
X-CSE-MsgGUID: MmyAsl43RPGZ+GRbsIKEYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244254"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244254"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:08 -0700
X-CSE-ConnectionGUID: 120NWI3+TlCdShOngetPWQ==
X-CSE-MsgGUID: BMUg4Q48S1eOUk+SOo3gJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323115"
Received: from jf.jf.intel.com (HELO 984fee019967.jf.intel.com) ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:09 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: [PATCH v1 7/8] x86/virt/tdx: Clean up error handling in get_tdx_sys_info()
Date: Tue,  4 Aug 2026 04:29:35 -0700
Message-ID: <20260804112941.19894-8-chao.gao@intel.com>
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

get_tdx_sys_info() chains its calls with

	ret = ret ?: get_tdx_sys_info_foo(...);

so that the remaining reads are skipped once one fails. That is an artifact
of the code generator rather than the usual kernel idiom. Use plain early
returns instead.

The version is still printed before the error from reading it is checked,
so a failed read is reported with whatever the print shows.

No functional change intended.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 1b8cd7656f36..4bf21848df62 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -529,21 +529,31 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
 
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
-	int ret = 0;
+	int ret;
 
-	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
+	ret = get_tdx_sys_info_version(&sysinfo->version);
 
 	pr_info("Module version: " TDX_VERSION_FMT "\n",
 		sysinfo->version.major_version,
 		sysinfo->version.minor_version,
 		sysinfo->version.update_version);
 
-	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
-	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
-	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
-	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
+	if (ret)
+		return ret;
 
-	return ret;
+	ret = get_tdx_sys_info_features(&sysinfo->features);
+	if (ret)
+		return ret;
+
+	ret = get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+	if (ret)
+		return ret;
+
+	ret = get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
+	if (ret)
+		return ret;
+
+	return get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 }
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
-- 
2.52.0


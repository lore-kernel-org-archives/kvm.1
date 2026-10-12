Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F147ACED;
	Mon, 12 Oct 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798648; cv=none; b=qFBz6Q9uknXAeLUwGi3v7Un+s1Vp/UineJSVlt9CgCV3sN/Ri5aUd3eKYRR1Xer1KyLzd85Wbk6dBQbR0rAXEFQkoCnP5rzHpX58u4WHSsMY6Oo7kidJ6CaZgreFrZv34W+u4LL2ipr5psQ7P+DOwC3mp3ZuxYfFFdFcGUcmsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798648; c=relaxed/simple;
	bh=Du4a/1wEKRh4jX5nYMvYrge7s6dIxnigtge2cRzPIUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4XFxylCLbD0d5m6ALgTrTzOhNFpKnQc63Nh5S4EW2dsJiij6YQm6L3MEhfsSzISGRynyLE9ktbwCxLf/xdOQCnRI4vTrcZOGIJTpG5hIo1hOc7SaCzSzOUcMUlRedZpqsTLfqqJIgb+0hgti8tNwtTYeEPIi/pDBsn5G0f39Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgVTYRuK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgVTYRuK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798636; x=1823334636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Du4a/1wEKRh4jX5nYMvYrge7s6dIxnigtge2cRzPIUk=;
  b=dgVTYRuK3TsFGysCupmah/VOVw0/tdyJv0mTlkD9Gy87x6ZH5uDrIPfs
   lZ3MnLp04C0x/Bwhv5IsFTCx2lK2KFu7iVAGilx0cdR51dLsmfeDMYqP2
   rvVotRP2qUX2DZr4yAZ94sBIClhZKbwOKz135j6hCz9pxUGK8ItVcclXj
   PVHE3wQL5cRSyvcfEvSinTHueaptcMEeH9dD+0k0BOWMGMrATZrvlXUHd
   F+LkR+mMh3gofq6+ZE/C2cvrGtROWup0bDktZ/V4RnDa7eDPo2aXboNqG
   r/lZc5IHswfCBMDnPCjUtxxUGeaH0NCDPlBeGVlRJ7PeAznUejtQPXxuu
   g==;
X-CSE-ConnectionGUID: LHoc8nC3TKOEw/BQrrh/tA==
X-CSE-MsgGUID: kF1drYyWQAifi7w4kHQxgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="388028"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="388028"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:23 -0700
X-CSE-ConnectionGUID: luV174TpQNCZpGgjxsSGrg==
X-CSE-MsgGUID: TwX8WCSZRYeZQJQvb1c05g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776857"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:24 -0700
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
Subject: [PATCH v4 06/10] x86/virt/tdx: Convert the handoff metadata reader
Date: Mon, 12 Oct 2026 02:47:33 -0700
Message-ID: <20261012094754.27702-7-chao.gao@intel.com>
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

Continue converting the metadata readers to the table-driven helper.

Add a table that pairs each field ID with the 'struct
tdx_sys_info_handoff' member that holds its value, and read all fields by
walking that table.

AI was used under supervision to review code and workshop logs

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - Collect tags [Rick]
 - Drop per-class macros [Nikolay, Dave]
---
 arch/x86/virt/vmx/tdx/tdx.c                 |  6 +++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 -------------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index bd0c8359eb55..ebf9d4d721e1 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -467,6 +467,10 @@ static const struct field_mapping td_ctrl_mappings[] __initconst = {
 	FIELD_MAP(TDX_FIELD_TDVPS_BASE_SIZE,	td_ctrl, tdvps_base_size),
 };
 
+static const struct field_mapping handoff_mappings[] = {
+	FIELD_MAP(TDX_FIELD_MODULE_HV, handoff, module_hv),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
@@ -1394,7 +1398,7 @@ int tdx_module_shutdown(void)
 	int ret;
 	int cpu;
 
-	ret = get_tdx_sys_info_handoff(&handoff);
+	ret = read_sys_metadata_table(handoff_mappings, &handoff);
 	/*
 	 * Handoff information is required for proper
 	 * shutdown. Refuse to shut down without it.
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 8bd8928c1802..720e301f599e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -78,6 +78,9 @@
 #define TDX_FIELD_TDCS_BASE_SIZE		0x9800000100000100ULL
 #define TDX_FIELD_TDVPS_BASE_SIZE		0x9800000100000200ULL
 
+/* Class "TDX Module Handoff" */
+#define TDX_FIELD_MODULE_HV			0x8900000100000000ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 6025421874cd..f1aeccd08027 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -40,19 +40,6 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_
 	return ret;
 }
 
-static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
-{
-	int ret;
-	u64 val;
-
-	ret = read_sys_metadata_field(0x8900000100000000, &val);
-	if (ret)
-		return ret;
-
-	sysinfo_handoff->module_hv = val;
-	return 0;
-}
-
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
-- 
2.52.0


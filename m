Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215BA349AE0;
	Tue,  4 Aug 2026 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843071; cv=none; b=WZrI9vvvf7DF4jKv/xep66Nwlg7Itj75Jm4znuTXe3+6fOk+2T/DC9zVyNrl+pV607jS+iv3atiZmISvgNBVgeRxpKERPKxPWdouRNlWHrMGZW27Nvfv9AQ7+hPZUDiBgT8DFc2gLXH+LpoJo+hBjVv58Ygp/9gTwD9bXf4uLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843071; c=relaxed/simple;
	bh=LgnX2KJf0mUKvP9LsvBnNrUpGm3a83MdRRrXS4RG+MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxmW3JvWmTX/2kfr1NqfnkI+vVXqpfDB74VS5nz7Z2WDRYQzOUD3A+Bhkdcw0TxomZT2jjnIFLa/Heui3G3VsdzbUnZMETVTUPtMxrE1LP6Rp1ROYvSJN12hXi6lufO6eBM3fv8aeCrKimiUDM1FMe4iJGacp/4Erxjsq+QN0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6AZabgL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6AZabgL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843070; x=1817379070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LgnX2KJf0mUKvP9LsvBnNrUpGm3a83MdRRrXS4RG+MY=;
  b=C6AZabgL2TajG5It9ap3agY/lvO7s2gPmPUg3uJ0wv2LOh19jJQVOaIi
   fi5x4NlTP3lNUDsSqW3nNIkizPFMhzamVVWOz37rvF6ElGtStw3ZhBmkf
   LJy3NSMIIUAanPtTiJLxPFcKfVzS7WMIEPMb/gq/IuQDu2Noh+9/Ci1+P
   bAEgkn69qRNMOkYvdYlpcObdDpgLwSOw2D47spfWrSpEaPlH+2SVDj2dz
   2lTSkZqUJybHZ3mJPUFlG0PlnnuoniCqAtuW916+4el3bWKL8PpAk/eso
   NrP5aq3tNsXaEKp5YL1BtBBsd/GI2kYstslmdLM1Gu0ziNbStUAqfNvHn
   g==;
X-CSE-ConnectionGUID: bma69mE4QPSTs2sqDbQcyA==
X-CSE-MsgGUID: nFU3vnSHRcOvZqXl+PW2Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244245"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244245"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:08 -0700
X-CSE-ConnectionGUID: Lcj0NfC5ST2uHxMM4SX5mA==
X-CSE-MsgGUID: h1Zt4MCpQHKnrXw4DkzMhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323106"
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
Subject: [PATCH v1 4/8] x86/virt/tdx: Convert version/tdmr/td_ctrl/handoff readers
Date: Tue,  4 Aug 2026 04:29:32 -0700
Message-ID: <20260804112941.19894-5-chao.gao@intel.com>
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

Convert the simple-scalar global-metadata classes to the table-driven
reader.

Drop the corresponding functions from the auto-generated file.

Note that the version and handoff tables are not tagged __initconst,
as their readers run at runtime.

Assisted-by: Claude:claude-opus-5
Not-yet-signed-off-by: Dave Hansen <dave@sr71.net>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 64 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 62 --------------------
 2 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index fb21433e7851..89055afeef68 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -393,6 +393,22 @@ static int read_sys_metadata_table(const struct tdx_sys_field *fields,
 	return 0;
 }
 
+#define MAP_VERSION(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, tdx_sys_info_version, _member)
+
+static const struct tdx_sys_field version_fields[] = {
+	MAP_VERSION(MINOR_VERSION,	minor_version),
+	MAP_VERSION(MAJOR_VERSION,	major_version),
+	MAP_VERSION(UPDATE_VERSION,	update_version),
+};
+
+static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
+{
+	return read_sys_metadata_table(version_fields,
+				       ARRAY_SIZE(version_fields),
+				       sysinfo_version);
+}
+
 #define MAP_FEATURES(_field_id, _member)	\
 	TD_SYSINFO_MAP(_field_id, tdx_sys_info_features, _member)
 
@@ -407,6 +423,54 @@ static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinf
 				       sysinfo_features);
 }
 
+#define MAP_TDMR(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, tdx_sys_info_tdmr, _member)
+
+static const struct tdx_sys_field tdmr_fields[] __initconst = {
+	MAP_TDMR(MAX_TDMRS,		max_tdmrs),
+	MAP_TDMR(MAX_RESERVED_PER_TDMR,	max_reserved_per_tdmr),
+	MAP_TDMR(PAMT_4K_ENTRY_SIZE,	pamt_4k_entry_size),
+	MAP_TDMR(PAMT_2M_ENTRY_SIZE,	pamt_2m_entry_size),
+	MAP_TDMR(PAMT_1G_ENTRY_SIZE,	pamt_1g_entry_size),
+};
+
+static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
+{
+	return read_sys_metadata_table(tdmr_fields,
+				       ARRAY_SIZE(tdmr_fields),
+				       sysinfo_tdmr);
+}
+
+#define MAP_TD_CTRL(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, tdx_sys_info_td_ctrl, _member)
+
+static const struct tdx_sys_field td_ctrl_fields[] __initconst = {
+	MAP_TD_CTRL(TDR_BASE_SIZE,	tdr_base_size),
+	MAP_TD_CTRL(TDCS_BASE_SIZE,	tdcs_base_size),
+	MAP_TD_CTRL(TDVPS_BASE_SIZE,	tdvps_base_size),
+};
+
+static __init int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *sysinfo_td_ctrl)
+{
+	return read_sys_metadata_table(td_ctrl_fields,
+				       ARRAY_SIZE(td_ctrl_fields),
+				       sysinfo_td_ctrl);
+}
+
+#define MAP_HANDOFF(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, tdx_sys_info_handoff, _member)
+
+static const struct tdx_sys_field handoff_fields[] = {
+	MAP_HANDOFF(MODULE_HV,	module_hv),
+};
+
+static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
+{
+	return read_sys_metadata_table(handoff_fields,
+				       ARRAY_SIZE(handoff_fields),
+				       sysinfo_handoff);
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e69c655a91a0..0c2cc99f1af1 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,55 +7,6 @@
  * Include this file to other C file instead.
  */
 
-static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000003, &val)))
-		sysinfo_version->minor_version = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000004, &val)))
-		sysinfo_version->major_version = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x0800000100000005, &val)))
-		sysinfo_version->update_version = val;
-
-	return ret;
-}
-
-static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
-		sysinfo_tdmr->max_tdmrs = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000009, &val)))
-		sysinfo_tdmr->max_reserved_per_tdmr = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000010, &val)))
-		sysinfo_tdmr->pamt_4k_entry_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000011, &val)))
-		sysinfo_tdmr->pamt_2m_entry_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000012, &val)))
-		sysinfo_tdmr->pamt_1g_entry_size = val;
-
-	return ret;
-}
-
-static __init int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *sysinfo_td_ctrl)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000000, &val)))
-		sysinfo_td_ctrl->tdr_base_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000100, &val)))
-		sysinfo_td_ctrl->tdcs_base_size = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9800000100000200, &val)))
-		sysinfo_td_ctrl->tdvps_base_size = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf)
 {
 	int ret = 0;
@@ -89,19 +40,6 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_
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


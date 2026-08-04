Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E275535AC11;
	Tue,  4 Aug 2026 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843073; cv=none; b=lCUOp9ZKjYoe4uSCk4NF/I7LSwB8YO3x8Rj3I4uC8sNU1rmfTF/dGcA9q7BdqU8gSTNl97gMk+7uX9JdkFZ8nhf2niV8s4iKoy6BAiAzwd4JWP3vExBGZ7doE+yqiWWrAnCen9hxa+nyF4wiprO8IInjpdAWuHkGymBkWJoj8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843073; c=relaxed/simple;
	bh=aw+dZKDsHumz+KUWQ9LezSpTNhLooOFpZP+UtO3hMpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTWTMbO6yWIEVe9nVu9LZEBnLpliqwlnNp/LGberNYKX3xAqrLGshEpldydBBiKUqD/+VCIeGUNltjpLPIAsYZORtznIqWKbpC4ejgCaylmlnP9MmTsnNBi6Og/uHYxAWQWnEfezfI5gj0To9c7YBz1TS870jCZ02duRu7Fd0RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7LT65pb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7LT65pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843071; x=1817379071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aw+dZKDsHumz+KUWQ9LezSpTNhLooOFpZP+UtO3hMpI=;
  b=Q7LT65pbLiJyFVm47Ch5h+jB6cWb6A2mg8DSMS7uQQ2r1eG1NlB9jO5h
   saxamP2rJityMwOjDtGpXw3Akj/4VkrWrwodbzkx0LwCwyFX7z4bnvQ78
   UCniieH0oTcX0in7lZEjuMliZWicEu8y2SkOwiWAEjGMDEWlyFB5X8ul8
   1iD8QgK8yeTe68xvZazIEz8hD3JKRQQHLTpVNbhHUbq6yAKYDznFB0W9c
   CMgnCCoBdDZ0OgwdY8UwRy+t0WjKiAsVScD6DFSKWKFYCQjBWG7Nf85rI
   A8jAAfNYk0usvLs8UfKpAkpcKQe5gmqJ4YiOkZbtfvQ993ugxZGiMX7bD
   w==;
X-CSE-ConnectionGUID: soiqDVEHQ1SF5+rquJTXig==
X-CSE-MsgGUID: lFj/SyoYTmS2JNFacNlqiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244248"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244248"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:08 -0700
X-CSE-ConnectionGUID: jfd+BNZQRgqnFiGyMucR5A==
X-CSE-MsgGUID: RxbNvbE4StC65NrvVy5r2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323109"
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
Subject: [PATCH v1 5/8] x86/virt/tdx: Convert td_conf reader
Date: Tue,  4 Aug 2026 04:29:33 -0700
Message-ID: <20260804112941.19894-6-chao.gao@intel.com>
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

Convert the "TD Configuration" class to the table-driven reader.

This class has two parts:

  - Six scalar fields (attributes_fixed{0,1}, xfam_fixed{0,1},
    num_cpuid_config, max_vcpus_per_td) that fit straight into a
    TD_SYSINFO_MAP table.

  - Two arrays (cpuid_config_leaves[] and cpuid_config_values[][])
    whose lengths come from num_cpuid_config and whose field IDs
    are computed from a base announced by the spec:

	field_id(leaves[i])     = MD_FIELD_ID_CPUID_CONFIG_LEAVES + i
	field_id(values[i][j])  = MD_FIELD_ID_CPUID_CONFIG_VALUES + i*2 + j

    The arrays can't be expressed as a static table, so read them
    explicitly after the scalar block has populated num_cpuid_config.

Bounds-check num_cpuid_config against the C array sizes before
indexing, matching the prior generated code.

Drop the corresponding function from the auto-generated file.

Assisted-by: Claude:claude-opus-5
Not-yet-signed-off-by: Dave Hansen <dave@sr71.net>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 56 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 33 ------------
 2 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 89055afeef68..98534e702144 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -471,6 +471,62 @@ static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff
 				       sysinfo_handoff);
 }
 
+#define MAP_TD_CONF(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, tdx_sys_info_td_conf, _member)
+
+/*
+ * Scalar fields of the "TD Configuration" class.  num_cpuid_config
+ * must be present here (and must be read before the CPUID arrays
+ * below) because it sizes them.
+ */
+static const struct tdx_sys_field td_conf_fields[] __initconst = {
+	MAP_TD_CONF(ATTRIBUTES_FIXED0,	attributes_fixed0),
+	MAP_TD_CONF(ATTRIBUTES_FIXED1,	attributes_fixed1),
+	MAP_TD_CONF(XFAM_FIXED0,	xfam_fixed0),
+	MAP_TD_CONF(XFAM_FIXED1,	xfam_fixed1),
+	MAP_TD_CONF(NUM_CPUID_CONFIG,	num_cpuid_config),
+	MAP_TD_CONF(MAX_VCPUS_PER_TD,	max_vcpus_per_td),
+};
+
+static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
+{
+	int ret, i, j;
+
+	ret = read_sys_metadata_table(td_conf_fields,
+				      ARRAY_SIZE(td_conf_fields),
+				      td_conf);
+	if (ret)
+		return ret;
+
+	/*
+	 * The configurable-CPUID arrays are sized at runtime by
+	 * num_cpuid_config, so they can't be expressed in a static
+	 * TD_SYSINFO_MAP table.  Their field IDs are contiguous from
+	 * the bases announced by the spec.
+	 */
+	if (td_conf->num_cpuid_config > ARRAY_SIZE(td_conf->cpuid_config_leaves) ||
+	    td_conf->num_cpuid_config > ARRAY_SIZE(td_conf->cpuid_config_values))
+		return -EINVAL;
+
+	for (i = 0; i < td_conf->num_cpuid_config; i++) {
+		ret = read_sys_metadata_field(MD_FIELD_ID_CPUID_CONFIG_LEAVES + i,
+					      &td_conf->cpuid_config_leaves[i]);
+		if (ret)
+			return ret;
+
+		for (j = 0; j < 2; j++) {
+			u64 fid = MD_FIELD_ID_CPUID_CONFIG_VALUES + i * 2 + j;
+
+			ret = read_sys_metadata_field(fid,
+						      &td_conf->cpuid_config_values[i][j]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 0c2cc99f1af1..4d673cac0976 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,39 +7,6 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_td_conf)
-{
-	int ret = 0;
-	u64 val;
-	int i, j;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000000, &val)))
-		sysinfo_td_conf->attributes_fixed0 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000001, &val)))
-		sysinfo_td_conf->attributes_fixed1 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000002, &val)))
-		sysinfo_td_conf->xfam_fixed0 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x1900000300000003, &val)))
-		sysinfo_td_conf->xfam_fixed1 = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9900000100000004, &val)))
-		sysinfo_td_conf->num_cpuid_config = val;
-	if (!ret && !(ret = read_sys_metadata_field(0x9900000100000008, &val)))
-		sysinfo_td_conf->max_vcpus_per_td = val;
-	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_leaves))
-		return -EINVAL;
-	for (i = 0; i < sysinfo_td_conf->num_cpuid_config; i++)
-		if (!ret && !(ret = read_sys_metadata_field(0x9900000300000400 + i, &val)))
-			sysinfo_td_conf->cpuid_config_leaves[i] = val;
-	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_values))
-		return -EINVAL;
-	for (i = 0; i < sysinfo_td_conf->num_cpuid_config; i++)
-		for (j = 0; j < 2; j++)
-			if (!ret && !(ret = read_sys_metadata_field(0x9900000300000500 + i * 2 + j, &val)))
-				sysinfo_td_conf->cpuid_config_values[i][j] = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
-- 
2.52.0


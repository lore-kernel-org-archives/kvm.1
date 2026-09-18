Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA004FC346;
	Fri, 18 Sep 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738314; cv=none; b=dBEYnNF0WUKxPb5EOoylwb4gYWcOa6RAQtCeB1vwQGTu2S5FCoRr8eIsh2tzclsJkJvVSl1+Dp0sLqLH0eduwc0IUL2OAh5Pk+V9P9ANkCUina8KupaYE3sKkZE3jmxLZQZU5Wd/tPl48pSxUc0ZU9clgMZvaEHxw2Gk1qNbBp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738314; c=relaxed/simple;
	bh=pZvjqoF+nZH/LY0DumeSYv6a5C7rzqey4Y4CNxlYuDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXFmJMM8Lby41KToWWszpxkGsjZwxpZNBjVQg9epk4lnnhx9cbbJp53IcLKUgyzwaMVhfy9TmINCE/Rks8lQyp0rHQH4IDq2aokQoA47GGnByWepGyV5pbW3dhhL7YgpVJEEvxgSX45G0gBf/eCOc6YmJkWYd7lj3Mxc5/5lGLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LdnOUYaU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdnOUYaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738311; x=1821274311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pZvjqoF+nZH/LY0DumeSYv6a5C7rzqey4Y4CNxlYuDw=;
  b=LdnOUYaUeKRtYyJMd7P8/E+6UZl6IkD0jfEThGNCeJTrLY2hUo0msA63
   q4aLAY7uWkP9yJofEd94411Jp9ljmJB2bjs9bwpZly8uZHwGmkGGyKZWe
   C/pQyG58b75OmRsgEH4j+cpPMj1I7kEktPR9563ITva7SNjKqzlRCe+Ej
   I902ctrgbJZubXxnQjPdAMc3VzNuW8QMlewlOqtB9z8z/vVtwvBeCu0T4
   MAoDBTU20jahXpqrKXFPaGhikzqv+Ce4w+blrO6FIXr88tnjqejOMkO38
   gFPkycFjbSu2HZeB7UNv4U7oZaB+Yr0GJ175ox4fH+ziTC9PIL+4YYYwS
   w==;
X-CSE-ConnectionGUID: 1h6hrqhFRrWvgijeuVy5Aw==
X-CSE-MsgGUID: SVZQCkHXQUW/JCmHra2Bvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776156"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776156"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:45 -0700
X-CSE-ConnectionGUID: rvj0ysnXTZqLOnaW3AhpVg==
X-CSE-MsgGUID: BRfPrKs0Ta+AtQS0Re0jFg==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:44 -0700
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
Subject: [RFC PATCH v2 07/10] x86/virt/tdx: Convert the td_conf metadata reader
Date: Fri, 18 Sep 2026 06:29:26 -0700
Message-ID: <20260918132946.76533-8-chao.gao@intel.com>
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

Continue converting the metadata readers to the table-driven helper.

The "TD Configurability" class holds several scalar fields plus two CPUID
arrays. The arrays have a fixed capacity, but the number of entries to
read is variable and reported by the num_cpuid_config scalar field.

Add a table that pairs each scalar field ID with the 'struct
tdx_sys_info_td_conf' member that holds its value, and read those fields
by walking that table.

Annotate the table as __initconst as it is referenced only during init.

Leave the two arrays open coded. 'struct field_mapping' pairs one field ID
with one structure member, so describing an array would require a field ID
per element plus an entry count that is unknown until num_cpuid_config has
been read. That is not worth building for the only two arrays the kernel
reads.

Read the arrays with explicit loops as the generated code did, but store
each value directly into its array member instead of into a temporary u64
first. The members are u64 already, so the extra copies serve no purpose.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 51 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 | 10 ++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 33 -------------
 3 files changed, 61 insertions(+), 33 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2bd7a2c9432b..571c3bb50532 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -511,6 +511,57 @@ static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *handoff)
 	return read_sys_metadata_table(handoff_mappings, handoff);
 }
 
+#define TDX_SYSINFO_MAP_TD_CONF(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_td_conf, _member)
+
+static const struct field_mapping td_conf_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_TD_CONF(ATTRIBUTES_FIXED0,	attributes_fixed0),
+	TDX_SYSINFO_MAP_TD_CONF(ATTRIBUTES_FIXED1,	attributes_fixed1),
+	TDX_SYSINFO_MAP_TD_CONF(XFAM_FIXED0,		xfam_fixed0),
+	TDX_SYSINFO_MAP_TD_CONF(XFAM_FIXED1,		xfam_fixed1),
+	TDX_SYSINFO_MAP_TD_CONF(NUM_CPUID_CONFIG,	num_cpuid_config),
+	TDX_SYSINFO_MAP_TD_CONF(MAX_VCPUS_PER_TD,	max_vcpus_per_td),
+};
+
+static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *td_conf)
+{
+	int ret, i, j;
+
+	ret = read_sys_metadata_table(td_conf_mappings, td_conf);
+	if (ret)
+		return ret;
+
+	/*
+	 * The number of CPUID config entries must not exceed the array
+	 * sizes.
+	 */
+	if (td_conf->num_cpuid_config > ARRAY_SIZE(td_conf->cpuid_config_leaves) ||
+	    td_conf->num_cpuid_config > ARRAY_SIZE(td_conf->cpuid_config_values))
+		return -EINVAL;
+
+	/*
+	 * TDX_MD_FIELD_ID_CPUID_CONFIG_* give the field ID of each array's
+	 * first element. The remaining elements follow consecutively, in
+	 * the order they appear in the structure.
+	 */
+	for (i = 0; i < td_conf->num_cpuid_config; i++) {
+		ret = read_sys_metadata_field(TDX_MD_FIELD_ID_CPUID_CONFIG_LEAVES + i,
+					      &td_conf->cpuid_config_leaves[i]);
+		if (ret)
+			return ret;
+
+		for (j = 0; j < 2; j++) {
+			ret = read_sys_metadata_field(
+				TDX_MD_FIELD_ID_CPUID_CONFIG_VALUES + i * 2 + j,
+				&td_conf->cpuid_config_values[i][j]);
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
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 6f99e4cdcc19..407aded3137a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -86,6 +86,16 @@
 #define TDX_MD_FIELD_ID_TDCS_BASE_SIZE			0x9800000100000100ULL
 #define TDX_MD_FIELD_ID_TDVPS_BASE_SIZE			0x9800000100000200ULL
 
+/* Class "TD Configurability" */
+#define TDX_MD_FIELD_ID_ATTRIBUTES_FIXED0		0x1900000300000000ULL
+#define TDX_MD_FIELD_ID_ATTRIBUTES_FIXED1		0x1900000300000001ULL
+#define TDX_MD_FIELD_ID_XFAM_FIXED0			0x1900000300000002ULL
+#define TDX_MD_FIELD_ID_XFAM_FIXED1			0x1900000300000003ULL
+#define TDX_MD_FIELD_ID_NUM_CPUID_CONFIG		0x9900000100000004ULL
+#define TDX_MD_FIELD_ID_MAX_VCPUS_PER_TD		0x9900000100000008ULL
+#define TDX_MD_FIELD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400ULL
+#define TDX_MD_FIELD_ID_CPUID_CONFIG_VALUES		0x9900000300000500ULL
+
 /* Class "TDX Module Handoff" */
 #define TDX_MD_FIELD_ID_MODULE_HV			0x8900000100000000ULL
 
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 36bbf42dead9..779c26e68f02 100644
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


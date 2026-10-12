Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5C1475356;
	Mon, 12 Oct 2026 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798635; cv=none; b=Q44ebGadKZWniGZC6wVEFG4DpF1riTJdoLkcLzFn/Z3TmcgIBO4u/J+WqJPF9mdxTziB7MPYbO0V/zFpCaxy5qsaN0HMym3dk6yUvs+HOgraeIdDqw0GTH98hGsc/5SUxLNO9peaHxjvw9uFXh/LM0OAzQvhRMy1+GJUL2mM6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798635; c=relaxed/simple;
	bh=LqDCTOZZDfsrSnUcDj4rZwu8FSgEik8ZhbEY7Dpe7g8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWE0WzvPR1EZv3Q0zMSsbPJSytpY0bk52j6pTlvkqseCUfvBUSC8JehbdirT69QvJQX//ubPlB7+IDJG/GmBY+NwrQzuKstMvlat7mBwJnUolmQgOANzL2jtj/aa/M8iP4zie2T0x/QtZVKiUwtLxbY6ar2orJiknEs09jb/SIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR36j0a/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR36j0a/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798623; x=1823334623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqDCTOZZDfsrSnUcDj4rZwu8FSgEik8ZhbEY7Dpe7g8=;
  b=OR36j0a/gJhLWIihDVgsgqFpCrGaOeZRfXOb4d4kEWzYaxdbxrGbp4Me
   bo6UI5n+rAoE9zAMAMnXNWFm7c/sLXeOV/DjlWDnswF7kFexapPBOUIMM
   l+oJc2jb4ZS5pQtb1qsBJGh6hHCsnv0pZn1fTb7AAASeXIluPdPmrWVda
   mXqCKaBKRkLsQW0W4eF7qOqRwfnu+ifN4JeCQ6E7BsR/zgdmB4qoRj2U0
   qi/1aL8WZF3aPrXkwAcCJzKxaH69ruy7lMMaBTiiMad1aCF9Cvv8vxHmh
   C/Pc1HIZ7tuAlISntjZ4LB96V9OHa1Fa8ijFKeOshrhiPCaT1cT5tNUv9
   w==;
X-CSE-ConnectionGUID: +JBAHQWFSYq1ZlA7FRMaUQ==
X-CSE-MsgGUID: 7r8p8AaXSsOLSjZzSBS79Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="387995"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="387995"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:21 -0700
X-CSE-ConnectionGUID: FowlmGKQRrGIX4YPvoftBw==
X-CSE-MsgGUID: 9WGmSr4xRui8UmJjVCLAIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776826"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:21 -0700
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
Subject: [PATCH v4 02/10] x86/virt/tdx: Convert the version metadata reader
Date: Mon, 12 Oct 2026 02:47:29 -0700
Message-ID: <20261012094754.27702-3-chao.gao@intel.com>
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

With the helper to read a table of metadata fields in place, the
existing metadata readers can be standardized on it.

Convert the version metadata reader: add a table that pairs each field ID
with the 'struct tdx_sys_info_version' member that holds its value, and
read all version fields by walking that table.

Name the field IDs for readability, so the table entries don't carry raw
hex literals.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - Collect tags [Rick]
 - Drop per-class macros [Nikolay, Dave]

v3:
 - Drop the get_tdx_sys_info_*() wrappers to remove an unnecessary layer
   of abstraction. [Rick, Dave]
 - Shorten the field ID defines from TDX_MD_FIELD_ID_* to TDX_FIELD_*
   [Rick]
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 12 +++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                 | 10 ++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 17 +----------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 65a6aae6fab0..3b7d13a1aa32 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -408,8 +408,8 @@ struct field_mapping {
 };
 
 /* Read each metadata field listed in @mappings[] into @data. */
-static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *mappings,
-						    int num_mappings, void *data)
+static int __read_sys_metadata_table(const struct field_mapping *mappings,
+				     int num_mappings, void *data)
 {
 	int i, ret;
 	u64 val;
@@ -437,6 +437,12 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
 #define FIELD_MAP(_field, _type, _member)	\
 	__FIELD_MAP(_field, struct tdx_sys_info_##_type, _member)
 
+static const struct field_mapping version_mappings[] = {
+	FIELD_MAP(TDX_FIELD_MINOR_VERSION,	version, minor_version),
+	FIELD_MAP(TDX_FIELD_MAJOR_VERSION,	version, major_version),
+	FIELD_MAP(TDX_FIELD_UPDATE_VERSION,	version, update_version),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
@@ -1404,7 +1410,7 @@ int tdx_module_run_update(void)
 	if (ret)
 		return ret;
 
-	ret = get_tdx_sys_info_version(&tdx_sysinfo.version);
+	ret = read_sys_metadata_table(version_mappings, &tdx_sysinfo.version);
 	/*
 	 * Only fails if there is something unexpected
 	 * and severely wrong with the module.
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index db209541d3cd..10cbc2d77a5a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -52,6 +52,16 @@
 #define TDH_PHYMEM_PAMT_REMOVE		59
 #define TDH_SYS_DISABLE			69
 
+/*
+ * TDX global metadata field IDs.
+ *
+ * See "global_metadata.pdf" in Intel TDX Module ABI Definitions.
+ */
+/* Class "TDX Module Version" */
+#define TDX_FIELD_MINOR_VERSION			0x0800000100000003ULL
+#define TDX_FIELD_MAJOR_VERSION			0x0800000100000004ULL
+#define TDX_FIELD_UPDATE_VERSION		0x0800000100000005ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 98ebf17aab1c..c55674cd4ce6 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,21 +7,6 @@
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
 static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
 {
 	int ret = 0;
@@ -129,7 +114,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
 
-	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
+	ret = ret ?: read_sys_metadata_table(version_mappings, &sysinfo->version);
 
 	pr_info("Module version: " TDX_VERSION_FMT "\n",
 		sysinfo->version.major_version,
-- 
2.52.0


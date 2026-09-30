Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704563B3894;
	Wed, 30 Sep 2026 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746868; cv=none; b=fvM/od+aSan5uRsuCean+ET/Unpo6KMD29sK1a9pHyk1Mq4GK+1Ye762PnJUsim3Y64lTLAP1O4qL8HfLTd8Vhd7CpM2K2MljDxCceo9ZY+vytchcwfQNgz+EruCkXSj9QAYqYx4YKHvTgUuRKyNV8G8+JtAJAu12PpRP34mLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746868; c=relaxed/simple;
	bh=Cm6dmU1l4xfttZ2AVXjfsIAw6ZUJD5tOA2TKKdoTZR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz2oLkpiNmvMienov0qIwph1Yg7QypIiSfLTzfJ0APaXQBfiq5HA9XG2dW/ASnZXX40nywP56HGUEtV/uPG+ofaXDoKatkBy3zes+WB90Eky7OdO79GgaqNmi3lwJUw+wTAvrODjRaBtfaCZ2VjYq91EMob56hrYuHawibafr10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/IHOfBr; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/IHOfBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746867; x=1822282867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cm6dmU1l4xfttZ2AVXjfsIAw6ZUJD5tOA2TKKdoTZR4=;
  b=g/IHOfBr4GNqri28YSPN2tWSqrN1HQYLyg/FMpeY4Q4tp+nGy2BdC448
   V3wTiv0xZdU57IrFV4aw2dCOs+HdseWqB7/7/MvLa1t2YLkgfKrUT7yEn
   vJRPHypf1CSIsmKmVVlARIzizpWnY6SmKCCvNMs5bRg5+8ZW49B2rg4fI
   y+y0ZiyqmLxyHL5ZS6ydb/K4RNCpvuP5/alg93DLH9cJCTDH15/pWRjlI
   YmuoHAq0ChLvGOFzkjHJbynVPmtWJNWQBty6EpFjFNf0NPkfikoMTpjPO
   dpJGEv0Lzvn8HW3JWM8UCZobllbvepWR8CCyhOa1ggVeNzpFBvV10F3kX
   A==;
X-CSE-ConnectionGUID: V0mXDnuQTGaZMa3PvKlYrA==
X-CSE-MsgGUID: AS1wzP3fTHuPFlX5fENpqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149081"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149081"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:40:59 -0700
X-CSE-ConnectionGUID: XFmdSlsEThWP9/RdlMPKyQ==
X-CSE-MsgGUID: S+UXnwdtSG+Y7rxZvJuCkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936396"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:40:59 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@linux.intel.com,
	chao.gao@intel.com,
	binbin.wu@linux.intel.com,
	tony.lindgren@linux.intel.com,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 02/10] x86/virt/tdx: Convert the version metadata reader
Date: Tue, 29 Sep 2026 22:38:36 -0700
Message-ID: <20260930053901.22528-3-chao.gao@intel.com>
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

With the helper to read a table of metadata fields in place, the
existing metadata readers can be standardized on it.

Convert the version metadata reader: add a table that pairs each field ID
with the 'struct tdx_sys_info_version' member that holds its value, and
read all version fields by walking that table.

Name the field IDs for readability, so the table entries don't carry raw
hex literals.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v3:
 - Drop the get_tdx_sys_info_*() wrappers to remove an unnecessary layer
   of abstraction. [Rick, Dave]
 - Shorten the field ID defines from TDX_MD_FIELD_ID_* to TDX_FIELD_*
   [Rick]
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 15 ++++++++++++---
 arch/x86/virt/vmx/tdx/tdx.h                 | 10 ++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 17 +----------------
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 67a80ed86bd3..9d8a55a5da31 100644
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
@@ -434,6 +434,15 @@ static int __maybe_unused __read_sys_metadata_table(const struct field_mapping *
 	.size		= sizeof_field(_type, _member),		\
 }
 
+#define TDX_SYSINFO_MAP_VERSION(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_version, _member)
+
+static const struct field_mapping version_mappings[] = {
+	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MINOR_VERSION,  minor_version),
+	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_MAJOR_VERSION,  major_version),
+	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
@@ -1401,7 +1410,7 @@ int tdx_module_run_update(void)
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


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7C3B42C4;
	Wed, 30 Sep 2026 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746876; cv=none; b=aUQhZLqW0OIAobz6WMBBAHNji1zRRVhbmr/y7+0TFpgHrCMvPo9KwI/1AMbs/+hvFQKIQQ2NezInzb6H2NKofc/A2jwtq+T9P+N4KFeY0ix1yYZShsNfluTR06aC36RGHpAtfQ5YkFmdozpRemLm533RrhkLGiEM1iaOgua9Va8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746876; c=relaxed/simple;
	bh=pbFuUbGzpIZoG5uC6Tm5ggE5txSjxZHHrdMa2QBn85c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMQ5Jt+jKoUNT1+seCFaZ7lbZPDGBTamYkvCFCWZoofCtpGhU9/54pOwlAPsmO27IzrBil5wftR8DMUJq3i/+tkHqFWJDaCZ1VgYG23tNMY3GoN7lsKVvsADb5ckEbFJbU282uG+wZTtlwoW/wvO4TwgWAmZVAhrrzyVJBT3s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inNDimNn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inNDimNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746867; x=1822282867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pbFuUbGzpIZoG5uC6Tm5ggE5txSjxZHHrdMa2QBn85c=;
  b=inNDimNnPrWwEv8swZ03nw4TWAJHyLlQO7uq/FOGlVEOpwMmJo+rLoGK
   ZYyH/0UT0stWg+o2sVXnlxiIlshmKU3MBvL/exCdR25TfLfwYcYb6SB1J
   zpbAIFCXWcY5GsGKB4uqyA4wJ/r7avWs5rt3nvG37GrjX52eoGysmc5ZO
   pLjBE2MMZ4Ng03FlSNRb+zWM/HYsnAf6aDT09U0z5H/4rgWsHliQlzyYE
   QjudRQGeSfhmjVcz14UZz1cE9qjQgo8w6vQnY6pGyYhdGneOxfaizcXhM
   mkXPbKZFTXDHkuGw1ChYaOI07XnX383c3kTp3mqf/07y2GbxtP95+g8W/
   A==;
X-CSE-ConnectionGUID: V09lzrVrRIOBfN6QMnAoaA==
X-CSE-MsgGUID: Vd1L2g1sSsexfsMPnpoeUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149089"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149089"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:00 -0700
X-CSE-ConnectionGUID: Cov5FLUhSaSj+fs3XhCVxw==
X-CSE-MsgGUID: 7yb5u6H+QRmCbIVyX7M8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936399"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:00 -0700
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
Subject: [PATCH v3 03/10] x86/virt/tdx: Convert the features metadata reader
Date: Tue, 29 Sep 2026 22:38:37 -0700
Message-ID: <20260930053901.22528-4-chao.gao@intel.com>
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

Continue converting the metadata readers to the table-driven helper.

Add a table that pairs each field ID with the 'struct
tdx_sys_info_features' member that holds its value, and read all fields by
walking that table.

Even though the structure has only one field, add a table anyway for
symmetry with the other classes. Adding a field later then becomes a
one-line change.

Annotate the table as __initconst as it is referenced only during init.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 |  7 +++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 +------------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 9d8a55a5da31..c78bb3be6303 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -443,6 +443,13 @@ static const struct field_mapping version_mappings[] = {
 	TDX_SYSINFO_MAP_VERSION(TDX_FIELD_UPDATE_VERSION, update_version),
 };
 
+#define TDX_SYSINFO_MAP_FEATURES(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_features, _member)
+
+static const struct field_mapping feature_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_FEATURES(TDX_FIELD_TDX_FEATURES0, tdx_features0),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 10cbc2d77a5a..87e055a2546c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -62,6 +62,9 @@
 #define TDX_FIELD_MAJOR_VERSION			0x0800000100000004ULL
 #define TDX_FIELD_UPDATE_VERSION		0x0800000100000005ULL
 
+/* Class "TDX Module Info" */
+#define TDX_FIELD_TDX_FEATURES0			0x0A00000300000008ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index c55674cd4ce6..3996af787ff8 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,17 +7,6 @@
  * Include this file to other C file instead.
  */
 
-static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
-		sysinfo_features->tdx_features0 = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret;
@@ -121,7 +110,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 		sysinfo->version.minor_version,
 		sysinfo->version.update_version);
 
-	ret = ret ?: get_tdx_sys_info_features(&sysinfo->features);
+	ret = ret ?: read_sys_metadata_table(feature_mappings, &sysinfo->features);
 	ret = ret ?: get_tdx_sys_info_tdmr(&sysinfo->tdmr);
 	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
-- 
2.52.0


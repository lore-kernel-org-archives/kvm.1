Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CB3B4417;
	Wed, 30 Sep 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746885; cv=none; b=u9slOcLxKjf0R5MQGpMIZjTA4yuG80Xi9W0TcaZmk+gKOK+N2Fn7MRcTbmTdDKpTC4NsafXhveMZ6UPhYFz/elNnG14H7qkz1plcfPK6fi+yefhe2y15WXohwIueCNkY0HI9xMd6IbIWDO5sZjdo6Jt4G4+C1Fi5aQryzfQ1iCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746885; c=relaxed/simple;
	bh=6OfOeZTYIqTvp1O/Xj2Yc9QGbBOJ8BpQDtW4XYGACoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuMHutcCgj6h8B9Ko5HYAp/QOlRGf/bA2NR5uVt5h9dSCqU+rjC1McHRMAEWBddsdKxeDYfV0De9zyWig3peaH3DQjINgjMyiiK/bDA3gY1+0/AWN4IvbSdYf9/h4AqewELFQxkmeWBz9oNB+2iTgjx+jfkc5W3GnMv5cCGHGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/UZXIl/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/UZXIl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746883; x=1822282883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6OfOeZTYIqTvp1O/Xj2Yc9QGbBOJ8BpQDtW4XYGACoA=;
  b=h/UZXIl/LE2sh0QAPlWr7MMtYT07TPA9+KFV+z5b4wcia6/WuRB21oTY
   QqMgEOjbL5meyZcnx/vZ8bC2bF4eOr1HNwD6z1dxv7XlGFvsr4CgNBfCo
   EOUit8OPMWGHHuRWD+tCXWfauPgnk9jr5fOz26Ol8F5xAvSCD0TAci3Bx
   xaiZ+fPn+t+NOUzziu7KKAxHjfecFxhYRvGCdwGLI58asUfXHGP7MkDUc
   aRgFUqjAESXDOUpyOFaPS6pEWlcFejwT717BgF6sm2/zNVyJJE2zhD4mv
   J02pfeZHvmk3pPDd+b8SSOKrMJ2H12+ZZ+FdGI2aBjrJzBXT8NrQhDgoZ
   w==;
X-CSE-ConnectionGUID: aYl+iaJDRUeche0oW4YFVA==
X-CSE-MsgGUID: TJfEujflSWCJ2bS/Dwoufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149103"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149103"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:02 -0700
X-CSE-ConnectionGUID: 8PdCllWvRyegD2kOQEghdQ==
X-CSE-MsgGUID: UWfrV5aVTNiAQJiYt4bB5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936412"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:01 -0700
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
Subject: [PATCH v3 05/10] x86/virt/tdx: Convert the td_ctrl metadata reader
Date: Tue, 29 Sep 2026 22:38:39 -0700
Message-ID: <20260930053901.22528-6-chao.gao@intel.com>
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
tdx_sys_info_td_ctrl' member that holds its value, and read all fields by
walking that table.

Annotate the table as __initconst as it is referenced only during init.

AI was used under supervision to review code and workshop logs

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 |  9 +++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  5 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 17 +----------------
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 24d22d8a2016..af4cafdd4c4e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -466,6 +466,15 @@ static const struct field_mapping dpamt_mappings[] __initconst = {
 			     pamt_page_bitmap_entry_bits),
 };
 
+#define TDX_SYSINFO_MAP_TD_CTRL(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_td_ctrl, _member)
+
+static const struct field_mapping td_ctrl_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_TD_CTRL(TDX_FIELD_TDR_BASE_SIZE,	tdr_base_size),
+	TDX_SYSINFO_MAP_TD_CTRL(TDX_FIELD_TDCS_BASE_SIZE,	tdcs_base_size),
+	TDX_SYSINFO_MAP_TD_CTRL(TDX_FIELD_TDVPS_BASE_SIZE,	tdvps_base_size),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 4faf07925dc0..8bd8928c1802 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -73,6 +73,11 @@
 #define TDX_FIELD_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
 #define TDX_FIELD_PAMT_PAGE_BITMAP_ENTRY_BITS	0x9100000000000013ULL
 
+/* Class "TD Control Structures" */
+#define TDX_FIELD_TDR_BASE_SIZE			0x9800000100000000ULL
+#define TDX_FIELD_TDCS_BASE_SIZE		0x9800000100000100ULL
+#define TDX_FIELD_TDVPS_BASE_SIZE		0x9800000100000200ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 870caac6a585..30834ecdccab 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -7,21 +7,6 @@
  * Include this file to other C file instead.
  */
 
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
@@ -81,7 +66,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 
 	ret = ret ?: read_sys_metadata_table(feature_mappings, &sysinfo->features);
 	ret = ret ?: read_sys_metadata_table(tdmr_mappings, &sysinfo->tdmr);
-	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
+	ret = ret ?: read_sys_metadata_table(td_ctrl_mappings, &sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
 	/*
-- 
2.52.0


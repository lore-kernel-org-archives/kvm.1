Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FB4E780B;
	Fri, 18 Sep 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738310; cv=none; b=tD09Mpz4RAiPMkQ9FAkbFwr1pW4TjuTpUB5AiWOJ9wdg6r9bR8slVFf264wYebVUaAs8E630E/jkEqGNMLjqWMUiGhyFlW4JhQuoORphRn1XmcqLquu6YU/mQY2JORbXkmFXkActRrxblP6tJY6GZk4Zj/TVjrXyMKVrim7FsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738310; c=relaxed/simple;
	bh=lwNcoRlEiSRlNsPcBxB0DPO2KA+mLDpPqz3kB+WRv7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZcS/ZL6GRtHZr+DQpt/XZoDqpK0ryOrXUyWHclGZWTkAeD3BL0jsc2XoErHktH5QfwWLJVqAQ+jZG0b1Y70oFweWl4GL091bi2ygUkKr0PETBX8SEf+kSWUhPWH8C2WiYTBTNtmcyHbcZyGwGim3TeScS6P0FtW4jb17sWa25O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDhQCyv+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDhQCyv+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738307; x=1821274307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lwNcoRlEiSRlNsPcBxB0DPO2KA+mLDpPqz3kB+WRv7I=;
  b=GDhQCyv+/HeqsTymMQL/qN8zPQqWt8hbXIB6yOzB+a3KIoueAdyWHLhz
   7kU5OAwNwp1/KobYxIyiNd+Iz3wgcd5kAkeXEqlPY8ItMGUHeyAae9YQj
   p3ck1fVOLto7C6SW4vuat4lpAA4yndVuqOpT+eo2nTnsU784jSkAhHv7m
   B6VPK2lFjXy1L/lvWpNhcPQWQxApcnH3Iwtmam/WC70bl4Kcr/HWUext/
   DMsZXlSY2RE5kIhmnGjyskxDxAlU4n45gN2HOuL0GPHJbGkcjLZwRSWlb
   +kkzn+u/bKTWOHzB6ZZDD+w/spGzTQlMhfSv2JNfp0fL3NASyQD28cSRO
   Q==;
X-CSE-ConnectionGUID: 8FajEZATQHaEPMJtEu65pA==
X-CSE-MsgGUID: GZA74DNtQ2uJQ7chLqlNHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776140"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776140"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:43 -0700
X-CSE-ConnectionGUID: sfycbZzARhWTe1VZjUe4Bg==
X-CSE-MsgGUID: UMVOYPXpQDuNoTdPl7JQng==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:42 -0700
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
Subject: [RFC PATCH v2 05/10] x86/virt/tdx: Convert the td_ctrl metadata reader
Date: Fri, 18 Sep 2026 06:29:24 -0700
Message-ID: <20260918132946.76533-6-chao.gao@intel.com>
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

Add a table that pairs each field ID with the 'struct
tdx_sys_info_td_ctrl' member that holds its value, and read all fields by
walking that table.

Annotate the table as __initconst as it is referenced only during init.

AI was used under supervision to review code and workshop logs

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 14 ++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  5 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 15 ---------------
 3 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 72aed3fc2b25..7b6b1ee075a3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -485,6 +485,20 @@ static __init int get_tdx_sys_info_tdmr_dpamt(struct tdx_sys_info_tdmr *tdmr)
 	return read_sys_metadata_table(dpamt_mappings, tdmr);
 }
 
+#define TDX_SYSINFO_MAP_TD_CTRL(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_td_ctrl, _member)
+
+static const struct field_mapping td_ctrl_mappings[] __initconst = {
+	TDX_SYSINFO_MAP_TD_CTRL(TDR_BASE_SIZE,		tdr_base_size),
+	TDX_SYSINFO_MAP_TD_CTRL(TDCS_BASE_SIZE,		tdcs_base_size),
+	TDX_SYSINFO_MAP_TD_CTRL(TDVPS_BASE_SIZE,	tdvps_base_size),
+};
+
+static __init int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *td_ctrl)
+{
+	return read_sys_metadata_table(td_ctrl_mappings, td_ctrl);
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 9a8c32b180e1..f33eb7dc7b45 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -81,6 +81,11 @@
 #define TDX_MD_FIELD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
 #define TDX_MD_FIELD_ID_PAMT_PAGE_BITMAP_ENTRY_BITS	0x9100000000000013ULL
 
+/* Class "TD Control Structures" */
+#define TDX_MD_FIELD_ID_TDR_BASE_SIZE			0x9800000100000000ULL
+#define TDX_MD_FIELD_ID_TDCS_BASE_SIZE			0x9800000100000100ULL
+#define TDX_MD_FIELD_ID_TDVPS_BASE_SIZE			0x9800000100000200ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index f0673dc28cb9..c6b375771265 100644
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
-- 
2.52.0


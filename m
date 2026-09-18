Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7794C4F85A2;
	Fri, 18 Sep 2026 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738312; cv=none; b=HiTI+7RrsqV/RStbwhbKon8fwkYwnmyI818JM7cYSBB1nixD1G5gxTivrBiUrIM4JcMvbvkneT3ruMuH88L4uDFbo4MiWGynfSpHhLOSI30vu+xkr20SyYyZZV92IgfayAjP4VCw3l18nIeibXsYeRUGuOoTiWi7Mn530qlmVrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738312; c=relaxed/simple;
	bh=PdZL1Zy8dZu9x5LoWVtoq9Gzh9/cpI1qgHt6JEDiWX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRkxz2lE2fuiRglaoQT/CcDAC4oIK28OuWxjJ6NuiIKXnJSd9/prIqjcQy41x/W/Oocepps4eaNY2ejWqECVtvjynTH9FytvFm0zJdqaQgNvxn4dt9DOHYc+ps+rtYKp/EAjJM7mkf3b69SozqsWAxEd1zz8yEEBQqKQFZ/tYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaMrzRQ8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaMrzRQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789738310; x=1821274310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PdZL1Zy8dZu9x5LoWVtoq9Gzh9/cpI1qgHt6JEDiWX8=;
  b=SaMrzRQ8A9Utmm9x6l39i1G6UG6OJ5o2arlVReNVFjMO7CcQbtOMImgh
   F9uSahP66VQHxmkUkVZAeECTforApAdhkBkJ43TzUFyRuy6Z3bH6DaaSP
   Mu0w+YuRBwITvqyIE6yHLWEUiCW32oIsBz8ffbsZPIHUZ7DHnQLIY4QwI
   t+OQLvhtJna9sgYprqpzdaWApKKO3/cTV51mQofZjp2Yey07ejGQjQ7Ji
   k9Vclg/UnJRx6kywKYy4g0gXILVUwoGbXYWDylp29YDKEYH5Qk1Y8Wa2m
   b1guBirWOKn+ojZZsr9aGruSmfuXuShrqmLFMTmGouiVTNREdV+/YXETC
   w==;
X-CSE-ConnectionGUID: 61z2BhTpS9++JPxox1vxgQ==
X-CSE-MsgGUID: HzyJ3Xc7Q72hjKO+G+VIXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="115776149"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="115776149"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:44 -0700
X-CSE-ConnectionGUID: 8YcLB14GQi+GMgSN+e1+Qg==
X-CSE-MsgGUID: yw9jYRpyTHqrJYqWr+Ghdg==
X-ExtLoop1: 1
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:31:43 -0700
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
Subject: [RFC PATCH v2 06/10] x86/virt/tdx: Convert the handoff metadata reader
Date: Fri, 18 Sep 2026 06:29:25 -0700
Message-ID: <20260918132946.76533-7-chao.gao@intel.com>
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
tdx_sys_info_handoff' member that holds its value, and read all fields by
walking that table.

AI was used under supervision to review code and workshop logs

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 12 ++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 -------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7b6b1ee075a3..2bd7a2c9432b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -499,6 +499,18 @@ static __init int get_tdx_sys_info_td_ctrl(struct tdx_sys_info_td_ctrl *td_ctrl)
 	return read_sys_metadata_table(td_ctrl_mappings, td_ctrl);
 }
 
+#define TDX_SYSINFO_MAP_HANDOFF(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_handoff, _member)
+
+static const struct field_mapping handoff_mappings[] = {
+	TDX_SYSINFO_MAP_HANDOFF(MODULE_HV, module_hv),
+};
+
+static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *handoff)
+{
+	return read_sys_metadata_table(handoff_mappings, handoff);
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index f33eb7dc7b45..6f99e4cdcc19 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -86,6 +86,9 @@
 #define TDX_MD_FIELD_ID_TDCS_BASE_SIZE			0x9800000100000100ULL
 #define TDX_MD_FIELD_ID_TDVPS_BASE_SIZE			0x9800000100000200ULL
 
+/* Class "TDX Module Handoff" */
+#define TDX_MD_FIELD_ID_MODULE_HV			0x8900000100000000ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index c6b375771265..36bbf42dead9 100644
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


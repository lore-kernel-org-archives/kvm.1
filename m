Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B347A0B4;
	Mon, 12 Oct 2026 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791798643; cv=none; b=iwrKlDCnECYA6hUW2qULdS8wWb734XBNWOS3uqtrRi7BhUSKOQCLjpn5W9T7Kaqps91qaIW0yX2mLeuSyqv2toW9EHkaMRI42acV8mdsNqqOD7RnmFsINaFYa54Gb5pSY0C8I0/0ks5lrdaJllBGH7XsV3rfLEXw0gFGvfXE/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791798643; c=relaxed/simple;
	bh=AH5Cz67aP06c7TXXn3b6GDiO+yXdUN7fpo8/F44sEj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cF9cqPHWYqIrLMMOVQIIhdIyt71vNH63XFspNGhKEVcVoGNYe++r+5Ww6CE0mGEuDmKbP/7hixVVQRNXqrQwCset3fDNALUexMXsCSgonvlyR9IFw4Qwh9II9QhkTOsNvdcmMm4Q/gt8VUCYBypnxmkCzNkMYdOpu0w4Me2c0QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbOx3PFD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbOx3PFD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791798632; x=1823334632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AH5Cz67aP06c7TXXn3b6GDiO+yXdUN7fpo8/F44sEj0=;
  b=YbOx3PFDUgu1LaJa3dkf/Ytxvqa/ki0kJxkOOmto0JGCZ9nWbTrSRTZj
   D159Wu0QaUDdogcTyLh9Z/iNkovXkkcJ75tcog1MTsw9kFyFuoBCwFY5z
   1V47sP2TA2Ud/P/mSQC/3qsXBA+lqkJV/LysRA+NYH7bFNJJhIPXGHg/Q
   gOuFC0QrPHo+UaQo/lHeK8i4kDfKV5JXqZyxKNHUWYtPhpJPasDNH3DOc
   zjQM8VzAcGUgeNqpdCuiKvEIhhG5HadKiN5APk9Ty8fsapqtm7Z/x+AhQ
   K0p5OfDyp88P74dK8QcY1Zm0fNbDm40Loht0r9PLVQfgiyo5F2UZ8KC0r
   Q==;
X-CSE-ConnectionGUID: I/xzDXU9QHi+Yjh3Iugaqw==
X-CSE-MsgGUID: MByWkcLVQp24teRxYj2WyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="388021"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="388021"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:23 -0700
X-CSE-ConnectionGUID: iLHm1itbQwGR2ygGlDRQkA==
X-CSE-MsgGUID: S0M93ycoQX60RnecMl9ILg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="776850"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 02:50:23 -0700
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
Subject: [PATCH v4 05/10] x86/virt/tdx: Convert the td_ctrl metadata reader
Date: Mon, 12 Oct 2026 02:47:32 -0700
Message-ID: <20261012094754.27702-6-chao.gao@intel.com>
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
tdx_sys_info_td_ctrl' member that holds its value, and read all fields by
walking that table.

Annotate the table as __initconst as it is referenced only during init.

AI was used under supervision to review code and workshop logs

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v4:
 - Collect tags [Rick]
 - Drop per-class macros [Nikolay, Dave]
---
 arch/x86/virt/vmx/tdx/tdx.c                 |  6 ++++++
 arch/x86/virt/vmx/tdx/tdx.h                 |  5 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 17 +----------------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 8dcd8b6ca3a2..bd0c8359eb55 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -461,6 +461,12 @@ static const struct field_mapping dpamt_mappings[] __initconst = {
 		  tdmr, pamt_page_bitmap_entry_bits),
 };
 
+static const struct field_mapping td_ctrl_mappings[] __initconst = {
+	FIELD_MAP(TDX_FIELD_TDR_BASE_SIZE,	td_ctrl, tdr_base_size),
+	FIELD_MAP(TDX_FIELD_TDCS_BASE_SIZE,	td_ctrl, tdcs_base_size),
+	FIELD_MAP(TDX_FIELD_TDVPS_BASE_SIZE,	td_ctrl, tdvps_base_size),
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
index 0d47ac3335f7..6025421874cd 100644
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
 
 	ret = ret ?: read_sys_metadata_table(features_mappings, &sysinfo->features);
 	ret = ret ?: read_sys_metadata_table(tdmr_mappings, &sysinfo->tdmr);
-	ret = ret ?: get_tdx_sys_info_td_ctrl(&sysinfo->td_ctrl);
+	ret = ret ?: read_sys_metadata_table(td_ctrl_mappings, &sysinfo->td_ctrl);
 	ret = ret ?: get_tdx_sys_info_td_conf(&sysinfo->td_conf);
 
 	/*
-- 
2.52.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692447F2EC;
	Tue, 15 Sep 2026 10:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468038; cv=none; b=nQGtwi42UkbYmPmubU1PP0LeVn2HqaIEcI/aywOLEISTZw9bWSX46eaCShjvt91dXfeHkktjJpPXHKHHuq0QFydlRMjAlsSc6E+jKSPo0083qu8IuwLO0n9K4cXgoz3K6Y5/Zp99c8AZMtY7an4fmSlnV2upLd60sKIzRK3zSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468038; c=relaxed/simple;
	bh=nP8BZ9AatjsrdEHIZquzeLObCgAhMe7SGqN8po4FtVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UX3jLmXKcgFlhQrCq9qTm7iuRxH16/3mVVNxxn6PAJVoR3uMtWNgrdKi784aSiWG3+RjuyqTPmVILOA6FTWTYNHRl6/TeljBsAzGNE8nUzDYKHh+VaaAeYgyRGKS0mHcb+hSCKwbKdHjcUuV026dWK3Ym+8hGnOg0EDkpKhCsMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANKt3W25; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANKt3W25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789468037; x=1821004037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nP8BZ9AatjsrdEHIZquzeLObCgAhMe7SGqN8po4FtVk=;
  b=ANKt3W25vhIWVGRt89Up1S55fgGhZWwCVsDamJinqS5EOf1MoJ+ElErb
   3z6UaD/UbXa2l7WOLbgb1sD2smHVX4V7EhZwvZ2NbKzkrd8lA7pgjHpqL
   Rjj1a8BftLSCTpG3pKxqIvRBBuMQn/gSXQMR4w3hNuMLQRBZTqlIMWiow
   H2oNSrBMhL7vUrcQasGvrRS7hm+MogX1/X/ZLtUdmN1GKwHjtX4YhVlau
   gWLQ4xJuFIrf+EniimFOYdXj+Hsdkf5o6SvoHGZ08bx3iCjwj5fIRU9v3
   N+N3wNtzOe+DgVxcw4gVyWThbyz1Ssyx1unyTxmtsE4ZFdMYCbSmAf2Oe
   w==;
X-CSE-ConnectionGUID: +dRr+b9rT8C+Y/P/c3bhQw==
X-CSE-MsgGUID: z85sJshuTxeR29yYqbTOxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115362208"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115362208"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:27:17 -0700
X-CSE-ConnectionGUID: 4aNstXjRTHaHYaUpGyb5ng==
X-CSE-MsgGUID: DC7Th9CkRUSGZnZj2Q6Qaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277084649"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2026 03:27:12 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	chao.gao@intel.com,
	artem.bityutskiy@linux.intel.com,
	kvm@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 3/5] x86/virt/tdx: Detect if the extensions initialization is required
Date: Tue, 15 Sep 2026 18:26:56 +0800
Message-Id: <20260915102658.713079-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260915102658.713079-1-yilun.xu@linux.intel.com>
References: <20260915102658.713079-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some add-on features require TDX module extensions. The TDX module
provides a metadata field "ext_required" to indicate this requirement.

Add the first step of TDX module extensions initialization by detecting
if the extensions are required:

  1. Check if the extensions are supported via TDX_FEATURES0_EXT. If
     not, ext_required is not readable.
  2. Check if any TDX feature needs the extensions via ext_required.

Skip the extensions initialization when it is not required.

Currently all metadata fields are read at the very beginning of TDX
module initialization. However, ext_required is only valid after the
add-on feature configuration, so it cannot use the existing metadata
reading method.

Add a dedicated metadata reading interface for the extensions, call it
after add-on feature configuration.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v1:
 - Include struct tdx_sys_info_ext in struct tdx_sys_info.
---
 arch/x86/include/asm/tdx.h                  |  1 +
 arch/x86/include/asm/tdx_global_metadata.h  |  5 ++++
 arch/x86/virt/vmx/tdx/tdx.c                 | 28 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 14 +++++++++++
 4 files changed, 48 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..6657f2db0330 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -36,6 +36,7 @@
 /* Bit definitions of TDX_FEATURES0 metadata field */
 #define TDX_FEATURES0_TD_PRESERVING	BIT_ULL(1)
 #define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_EXT		BIT_ULL(39)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 41150d546589..fe3fe91de71f 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -44,12 +44,17 @@ struct tdx_sys_info_handoff {
 	u16 module_hv;
 };
 
+struct tdx_sys_info_ext {
+	bool ext_required;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
 	struct tdx_sys_info_tdmr tdmr;
 	struct tdx_sys_info_td_ctrl td_ctrl;
 	struct tdx_sys_info_td_conf td_conf;
+	struct tdx_sys_info_ext ext;
 };
 
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 763c2d1b25d0..916a8906da10 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1181,6 +1181,30 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static __init int init_tdx_module_extensions(void)
+{
+	int ret;
+
+	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
+		return 0;
+
+	ret = get_tdx_sys_info_ext(&tdx_sysinfo.ext);
+	if (ret)
+		return ret;
+
+	/*
+	 * ext_required indicates if any add-on features requiring TDX module
+	 * extensions are configured via TDH.SYS.CONFIG. If none, skip the
+	 * initialization.
+	 */
+	if (!tdx_sysinfo.ext.ext_required)
+		return 0;
+
+	/* TODO: add the extensions enabling steps here */
+
+	return 0;
+}
+
 static __init int init_tdx_module(void)
 {
 	int ret;
@@ -1235,6 +1259,10 @@ static __init int init_tdx_module(void)
 	if (ret)
 		goto err_reset_pamts;
 
+	ret = init_tdx_module_extensions();
+	if (ret)
+		goto err_reset_pamts;
+
 	pr_info("%lu KB allocated for PAMT\n", tdmrs_count_pamt_kb(&tdx_tdmr_list));
 
 out_put_tdxmem:
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e49c300f23d4..b9e1c011a990 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -131,3 +131,17 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 
 	return ret;
 }
+
+static __init int get_tdx_sys_info_ext(struct tdx_sys_info_ext *sysinfo_ext)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x3100000000000001, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_ext->ext_required = val;
+
+	return 0;
+}
-- 
2.25.1


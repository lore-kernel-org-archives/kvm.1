Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7F73793DE;
	Fri, 21 Aug 2026 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282978; cv=none; b=CM/fiL0jKMB53rKgeSxAXsYHAFBBi5SED+K9taplvHh9/gdb9JabEjAkH/jnigy+NsRj/KCwSkpTBOgfL8f9k4qrw9hE1tblAfVKfmKmrx90XrcZ3EVdM4PYdmDq758P+Bt/GPYlmb8o91EQVDu6bUGsMNWmgTf0Wjy9xzu+DXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282978; c=relaxed/simple;
	bh=znetrghf6ys/CPFLpyjpzXAtsRZnYs4HpIExNFpBIac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B7k6fjBOnxcACzOD7kh8qdpHqTbIMF80M+mpSpeDubnYfcyEoIX149Xb3MD7u6tsX1VrMMJPPfGecwdmga0tSyGwTbUuSvbd9pReOmdxSiia1jU3KJN6ch4mEDjB06yMVVagBTsYrbk3JqQqgRG3uxWfd/i6gLENgjnzCKPvVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2EH4pHS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2EH4pHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787282976; x=1818818976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=znetrghf6ys/CPFLpyjpzXAtsRZnYs4HpIExNFpBIac=;
  b=N2EH4pHSqJXiRH4M6vWGVwyYG8Rs3Fmcx5JkZ7vbfIK3T35g5qUTfLAK
   BdgSHy9zvcgIoH/7y5Jdd2TOwIvFqkaq+7mwYB3eC9I8IbgcThs965O6a
   SFxrvuUox9sOIrFUYwlJEqs5eVbzYJMR4xMV0MwcFuqxn8BUi9pPD9aJw
   5VivL+ishBAIOHKZgz/25/Kf5OD8rRaPH854oKXaE/CTTtlhNF66zDFCx
   hWRDo9Es3N+0hufWuc10QSxHAFWLBG4XIqSiu2QpaROsbbEjQywTznByJ
   LZEGVGAEdggbYbJdm1E9UsQk0ufVTo9FyeZkmfI+hpRyWUgJ+k5ZzPnKs
   A==;
X-CSE-ConnectionGUID: lmllmSy/SfShkistCrH8wQ==
X-CSE-MsgGUID: uLQXwdo0SPqXJjPIwdx/vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91640234"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="91640234"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 20:29:36 -0700
X-CSE-ConnectionGUID: auoBD2X3S5OW0iH1anPlaA==
X-CSE-MsgGUID: otBEypIySkqAjkcRsgUWTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="264451600"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa006.jf.intel.com with ESMTP; 20 Aug 2026 20:29:33 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
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
	kvm@vger.kernel.org
Subject: [PATCH 3/6] x86/virt/tdx: Detect if the extensions initialization is required
Date: Fri, 21 Aug 2026 11:29:17 +0800
Message-Id: <20260821032920.256225-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821032920.256225-1-yilun.xu@linux.intel.com>
References: <20260821032920.256225-1-yilun.xu@linux.intel.com>
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
index 66b43350c6c3..a0c370894c0b 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1175,6 +1175,30 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
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
@@ -1229,6 +1253,10 @@ static __init int init_tdx_module(void)
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


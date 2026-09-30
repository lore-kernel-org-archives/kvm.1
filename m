Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318A3B6BEB;
	Wed, 30 Sep 2026 05:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790746876; cv=none; b=HLDMQFJF/34+cv/yej9CtcIOqFnpxDfpKDZyDHiSmQXvJsKpqi3z7nwzLi2f9sidbQ5pUEGypT+GeGpUvCkcXaOoXUlLSRzdkH7HBWFhGdRoZpTyz2EaMRawEq++u9tEoBfd0yrvxoZmm6Tzzxa7KSWDgZAknoVEfAf951RikKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790746876; c=relaxed/simple;
	bh=akLzHqg0jwPSwxruy5P8AaBz/uOKDnUCRgnL9ASsJjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoAEvTqFFahYKSe53Oi2lMUn4AXfHST/i2VSbZodCJUYmahaBPhz6yC+iYsA8xQ3A5i01ymklr6rPx7L4ZAJrErNbM6so614db1HINe8MkqfDBEK1yEz2MmnEFy03H75zTsneEFPqa7Drlw0dr+VxEOLc5urQ7iXs51bnYUOMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McnGAMa2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McnGAMa2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790746868; x=1822282868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=akLzHqg0jwPSwxruy5P8AaBz/uOKDnUCRgnL9ASsJjU=;
  b=McnGAMa2Jh10ZwAy46LN523F+Jc7kXheViecMuQWQ42MeA9/HJbKyxiv
   EYrl0EbuCFauEVGIHAPM3949xMEM+6A6sR80mVN2DYz5l2B3Nm6//Dqdh
   4qGDOyXDOkC07lhug6U0oGl89Gn9XXVNdI1R6kszzAjvkpY3y78LkAgiH
   f+7EUILnUeJqHcIHwiMEYJYeLu4Whx/O1JjO0TqtUFUuzDWEeIDUjP/h7
   cRx7bMiGA3OksHBP3t7IysgZYYV22VZf6oOwA3ylXYuFOvhdzTqnZWwgZ
   AU/U3NpW2vMlKP9Uha0c4LEtU0/eUK4JfPRiZH5JYmJkeiGNv1MmJglJ9
   A==;
X-CSE-ConnectionGUID: Hkcqr4TgSV+PrXXZvFZTNQ==
X-CSE-MsgGUID: vgtbu7eMRfai8rEV3DuZbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102149109"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102149109"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:02 -0700
X-CSE-ConnectionGUID: BY9cx4ewRamOo4z9w9TGug==
X-CSE-MsgGUID: BYtNGbj3TM2eAQxG4Wk3qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="278936416"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 22:41:02 -0700
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
Subject: [PATCH v3 06/10] x86/virt/tdx: Convert the handoff metadata reader
Date: Tue, 29 Sep 2026 22:38:40 -0700
Message-ID: <20260930053901.22528-7-chao.gao@intel.com>
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
tdx_sys_info_handoff' member that holds its value, and read all fields by
walking that table.

AI was used under supervision to review code and workshop logs

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 |  9 ++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 -------------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index af4cafdd4c4e..79561312ebfd 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -475,6 +475,13 @@ static const struct field_mapping td_ctrl_mappings[] __initconst = {
 	TDX_SYSINFO_MAP_TD_CTRL(TDX_FIELD_TDVPS_BASE_SIZE,	tdvps_base_size),
 };
 
+#define TDX_SYSINFO_MAP_HANDOFF(_field_id, _member) \
+	TDX_SYSINFO_MAP(_field_id, struct tdx_sys_info_handoff, _member)
+
+static const struct field_mapping handoff_mappings[] = {
+	TDX_SYSINFO_MAP_HANDOFF(TDX_FIELD_MODULE_HV, module_hv),
+};
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
@@ -1402,7 +1409,7 @@ int tdx_module_shutdown(void)
 	int ret;
 	int cpu;
 
-	ret = get_tdx_sys_info_handoff(&handoff);
+	ret = read_sys_metadata_table(handoff_mappings, &handoff);
 	/*
 	 * Handoff information is required for proper
 	 * shutdown. Refuse to shut down without it.
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 8bd8928c1802..720e301f599e 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -78,6 +78,9 @@
 #define TDX_FIELD_TDCS_BASE_SIZE		0x9800000100000100ULL
 #define TDX_FIELD_TDVPS_BASE_SIZE		0x9800000100000200ULL
 
+/* Class "TDX Module Handoff" */
+#define TDX_FIELD_MODULE_HV			0x8900000100000000ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index 30834ecdccab..8ca1cdcf55fe 100644
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


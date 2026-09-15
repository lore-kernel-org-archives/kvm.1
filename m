Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5E47FAF7;
	Tue, 15 Sep 2026 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468048; cv=none; b=pejueU3S2s3Yq4Sq1sNuS8BvQK3k9PEz7xOTMh7r3AdmgG8eMYVdtYsyn9WR00fG+yfn1Tb9KcW0D7XrzOo+0ZbQTv77gGN0gg8f3p4eg/CWJ0a9uoCvshqYC+KEX/t5yxZeHMDJXXDVSzq/xfLFM0yeRKvy9XkiG/U9Eo+jTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468048; c=relaxed/simple;
	bh=Q5oJx8j/BEat4lOv1uqOd7HBNDZ++onw3m/mth5NeSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/fHVhEDCzWWgCVy3Iw3c7q3kSeo+3BBB3xwmTQ3hsHJMJG6IOvDURk1AZ4lJCFNQbK4KCAqs9IAYWKpsClFdS3KH425rssMm4XAGuBOMxUBMDtRAKYRXTg6WWFXF4SsYGP4rOo59fRkhNSzV4tCi2VakBh45IQUQ7KPMDnEXeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYNfKx92; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYNfKx92"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789468047; x=1821004047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q5oJx8j/BEat4lOv1uqOd7HBNDZ++onw3m/mth5NeSM=;
  b=VYNfKx92ZQRE7whIhl0HIXlbrCXMsJRCW1mvlv5Wkd8iYsQmSy7qCGRk
   DKrKS9TaXdgkagsv7qh/Vl/Y6XN7tlpAAxt7eeN56gt+mRowk9TSNOupB
   QtfA1m9T9BJegRcx0nhsso+wOsItY42jEMW49xTaXTQshjmBiQMuWNgnK
   0fv4uwOofnais+oPfozZzsikhWxAd4w4H533a+4UG3fMPQGCjmmkN1cuj
   qaotYVG5aLkm6jyFYH5muIyzUPJWD2RqHSXQLjJHAiMxOqO2rcUoFO24J
   LzHNANXe4zy9B2LC+i6tz+7TdnhZWOO8sdC6IQ5x8V3okOnp3dOhcUceW
   A==;
X-CSE-ConnectionGUID: +IWhsaMHSUamn5RBXaD2ng==
X-CSE-MsgGUID: VKMknzP9QdGnAR4+35xDiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="115362218"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="115362218"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 03:27:26 -0700
X-CSE-ConnectionGUID: lZT+1WUeR0K9tasPjvW2eQ==
X-CSE-MsgGUID: OpDH6L2ZQCWzeH2RVThocg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="277085341"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.47.46])
  by orviesa005.jf.intel.com with ESMTP; 15 Sep 2026 03:27:22 -0700
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
Subject: [PATCH v2 5/5] x86/virt/tdx: Make TDX module initialize the extensions
Date: Tue, 15 Sep 2026 18:26:58 +0800
Message-Id: <20260915102658.713079-6-yilun.xu@linux.intel.com>
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

TDX module extensions need memory for their execution environment
to serve SEAMCALL leafs. Several add-on features depend on the
extensions to execute their SEAMCALL leafs.

After providing all required memory to the TDX module, initialize TDX
module extensions via TDH.EXT.INIT, then those add-on features can use
their SEAMCALL leafs normally.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
v1:
 - Fix return value for SEAMCALL wrappers (Chao)
 - Print SEAMCALL error code for SEAMCALL wrappers (Xiaoyao)
 - Changelog & code comments
---
 arch/x86/virt/vmx/tdx/tdx.h |  1 +
 arch/x86/virt/vmx/tdx/tdx.c | 23 ++++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 52888424fe7d..1f43d2eb2345 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -48,6 +48,7 @@
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_UPDATE			53
+#define TDH_EXT_INIT			60
 #define TDH_EXT_MEM_ADD			61
 #define TDH_SYS_DISABLE			69
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 3cdc5ba8e2ad..2d42191a56e6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1311,6 +1311,23 @@ static __init int tdx_ext_mem_setup(void)
 	return ret;
 }
 
+static __init int tdx_ext_init(void)
+{
+	struct tdx_module_args args = {};
+	u64 ret;
+
+	do {
+		ret = seamcall(TDH_EXT_INIT, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE);
+
+	if (ret != TDX_SUCCESS) {
+		pr_err("TDH.EXT.INIT failed: 0x%016llx\n", ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static __init int init_tdx_module_extensions(void)
 {
 	int ret;
@@ -1330,7 +1347,11 @@ static __init int init_tdx_module_extensions(void)
 	if (!tdx_sysinfo.ext.ext_required)
 		return 0;
 
-	return tdx_ext_mem_setup();
+	ret = tdx_ext_mem_setup();
+	if (ret)
+		return ret;
+
+	return tdx_ext_init();
 }
 
 static __init int init_tdx_module(void)
-- 
2.25.1


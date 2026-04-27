Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21735B137;
	Mon, 27 Apr 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303809; cv=none; b=gaM0VbCbRf37e90q+jz8VKOLEI6Sx7E+hBvrpjT0xROtwuR2sQoW2mV3xFaHaQ4Pm1P9c3bjkFJrVJH+3Z123TilUPWdp06ATIhZ+TewEZ6+15P1C1HeTUDlE53XrwNV52hgoHI1/F1pOQsLYniIXrUGwPgNXNtx2pJUZTWh8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303809; c=relaxed/simple;
	bh=MkTby7MAGYp6SKIMZJtG4/M9cL+AH9h4ywlrCOuBmmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7RK2ZkXht3pmDuxrH5HHIO6GifFQirml/qEkTCyh4MwTUHa9VNuaanpzH9+o5HEy/JZifMmGEnGyi/fZAuegRyiBbA0HlCoZBfnjpEIZYAKwbK4WD/h5qSIMmyNctYjoGxvEesBz8nSDZPxPWkD/p/7LV0BwlbAo9RTlYtcQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1KPLgH/; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1KPLgH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303808; x=1808839808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MkTby7MAGYp6SKIMZJtG4/M9cL+AH9h4ywlrCOuBmmA=;
  b=Y1KPLgH/cXhF39KhxjXI8O4KRnJxnqAwz+5/MdmMH+SFYp6ry6PxbfPK
   gbpksyqx2oisQfzkz9jYBRRliilLYK8eu3aPJIa8luDTbDiYF+QY6k1j6
   w/qCcS+iP/3U69uiSfvKdoHxBaPoNgI3+tn1k6lwyNK13dJ9hQZC90K0T
   iE80L3egOi9QYUakYLW4rWll3vVL3UBf1fgK+UGEvubM7IdrcXEYe6nCh
   AEScpAXoMwN5ZwGSnaeyp74dNNEV4b05VSO2FpjorU/RFDrEHf5CMcZ2y
   o44CeOhWa5pBXegjG8P+c/vpaD3N68eT4QI/Q50Ku1CWn0vNg7Q1E0IVc
   A==;
X-CSE-ConnectionGUID: +qAXeFTXTGCKQGhrETEnaQ==
X-CSE-MsgGUID: hDTFvKNXSjqXHmwzGE+vsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900760"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900760"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:03 -0700
X-CSE-ConnectionGUID: FDyS1Dm+QkCWCi264f1Ydw==
X-CSE-MsgGUID: UNXKPTXWS5eW0H/gkBR3mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673300"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:30:03 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v8 14/21] x86/virt/tdx: Restore TDX module state
Date: Mon, 27 Apr 2026 08:28:08 -0700
Message-ID: <20260427152854.101171-15-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427152854.101171-1-chao.gao@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TDX module state was packed as handoff data during module shutdown. After
per-CPU initialization, the new module can restore TDX module state from
handoff data to preserve running TDs.

Once the restoration is done, the TDX module update is complete, which
means the new module is ready to handle requests from the host and guests.

Implement the new TDH.SYS.UPDATE SEAMCALL to restore TDX module state
and invoke it on one CPU since it only needs to be called once.

For error handling, Intel® Trust Domain Extensions (Intel® TDX)
Module Base Architecture Specification, Chapter "Restore TDX Module
State after a TD-Preserving Update" states

  If TDH.SYS.UPDATE returns an error, then the host VMM can continue
  with the non-update sequence (TDH.SYS.CONFIG, TDH.SYS.KEY.CONFIG
  etc.). In this case all existing TDs are lost. Alternatively, the host
  VMM can request the P-SEAMLDR to update to another TDX module. If that
  update is successful, existing TDs are preserved.

Given the complexity and uncertain value of above recovery paths, simply
propagate errors.

Also note that the location and the format of handoff data is defined by
the TDX module. The new module knows where to get handoff data and how
to parse it. The kernel doesn't need to provide its location, format etc.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v8:
 - don't add a duplicate error code as seamcal_prerr() will do that
 - don't reset tdx module status to ERORR on error
---
 arch/x86/virt/vmx/tdx/seamldr.c |  5 +++++
 arch/x86/virt/vmx/tdx/tdx.c     | 13 +++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 04c7a87ac7df..98a8d9d3ae25 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -213,6 +213,7 @@ enum module_update_state {
 	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_CPU_INSTALL,
 	MODULE_UPDATE_CPU_INIT,
+	MODULE_UPDATE_RUN_UPDATE,
 	MODULE_UPDATE_DONE,
 };
 
@@ -275,6 +276,10 @@ static int do_seamldr_install_module(void *seamldr_params)
 			case MODULE_UPDATE_CPU_INIT:
 				ret = tdx_cpu_enable();
 				break;
+			case MODULE_UPDATE_RUN_UPDATE:
+				if (primary)
+					ret = tdx_module_run_update();
+				break;
 			default:
 				break;
 			}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 3bbb12aefb4b..9e4085a1e683 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1266,6 +1266,19 @@ int tdx_module_shutdown(void)
 	return 0;
 }
 
+int tdx_module_run_update(void)
+{
+	struct tdx_module_args args = {};
+	int ret;
+
+	ret = seamcall_prerr(TDH_SYS_UPDATE, &args);
+	if (ret)
+		return ret;
+
+	tdx_module_initialized = true;
+	return 0;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 36afebf0e04b..5fef813002c2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -47,6 +47,7 @@
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
 #define TDH_SYS_SHUTDOWN		52
+#define TDH_SYS_UPDATE			53
 
 /*
  * SEAMCALL leaf:
@@ -112,5 +113,6 @@ struct tdmr_info_list {
 };
 
 int tdx_module_shutdown(void);
+int tdx_module_run_update(void);
 
 #endif
-- 
2.47.1


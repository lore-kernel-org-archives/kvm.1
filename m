Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088413DD518;
	Wed, 20 May 2026 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284430; cv=none; b=NeN9MhFlA3SK8QNt1/yUdzSMnJcS/uVnlF6XaQaR2oCKHvxZoxhxC3MgdUW329rH+1mRzFJr2bZcYK4tIE+mobmsMPZPGDrLIFUub5hqZAlGUouRIRNQ5uVMHqFCiwX9gl69EWJ+eF4I4LmF30ocMiLWBgkNpqOobwHPD+cyLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284430; c=relaxed/simple;
	bh=rL4SsUZOmcccWMsTgDnBY03K7sLgLIBYfmhJw2Db6OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQHiX9M+Bqp2ovJ0F/pgN3QUpZeAfo593Yn0JWqA2rX9vN9IYWyE/w41anGuovE29sd2jmlBdBLPa8PNIALX6VB/8impPFXbPyt1PbfSCnhAYzejmnAAJd7Ya84yiFsrvkpid29qjRFtL9yiqaOVOxtWlRlbWKWFDLzviZLIiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LoKA4pfY; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LoKA4pfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284426; x=1810820426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rL4SsUZOmcccWMsTgDnBY03K7sLgLIBYfmhJw2Db6OI=;
  b=LoKA4pfYR8T5bWnmjxvQCqyX2qASi/06hLqruoxT3Vi2NQKvKBzracKD
   pcukqjt+kqGsQUAUSsBmpRmE9xaBLooEo4r8oCxIamu09wHVfrg26QBv+
   XcO927QYdl+Cb5LfdB9R5i4pH5iyODm/xoudJY7dB37qK3/Tve6JMFqOU
   ZoOu4IXdV9rFe6JvVgaAAr8ie3XlbeBIDdXk6WSKGqZROw1wqvzt08OC1
   CTsF+xegp6mPdBcL2/4AnuiZU5s5XH79swSMWEaiMrSGxXkuUxu+HsSrh
   +U/662FPe6f+gmXbpF/XgpQxHeGbd6UZ5g2/PXAd3PX1N/N0Ji13UTR5E
   A==;
X-CSE-ConnectionGUID: 8ZyHsss6SbWQb64OVSpJPA==
X-CSE-MsgGUID: 1bT8GTGfSyaBg2n/17nAaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146545"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146545"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:22 -0700
X-CSE-ConnectionGUID: SM3T7PGtSWejdrWTId3p9w==
X-CSE-MsgGUID: HP4Urmy1TA6QhkaRiVwrrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923917"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:20 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
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
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v10 16/25] x86/virt/seamldr: Shut down the current TDX module
Date: Wed, 20 May 2026 06:38:19 -0700
Message-ID: <20260520133909.409394-17-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first step of TDX module updates is shutting down the current TDX
module. This step also packs state information that needs to be
preserved across updates, called "handoff data". This handoff data is
consumed by the updated module and stored internally in the SEAM range and
hidden from the kernel.

Since handoff data layout may change between modules, the handoff data is
versioned. Each module has a native handoff version and provides backward
support for several older versions.

The complete handoff versioning protocol is complex as it supports both
module upgrades and downgrades. See details in Intel® Trust Domain
Extensions (Intel® TDX) Module Base Architecture Specification, Chapter
"Handoff Versioning".

Ideally, the kernel needs to retrieve the handoff versions supported by
the current module and the new module and select a version supported by
both. But since this implementation only supports module upgrades, simply
request handoff data from the current module using its highest supported
version. That is sufficient for this upgrade-only implementation.

Retrieve the module's handoff version from TDX global metadata and add an
update step to shut down the module. Module shutdown only needs to run on
one CPU.

Don't cache the handoff information in tdx_sysinfo. It is used only for
module shutdown, and is present only when the TDX module supports updates.
Caching it in get_tdx_sys_info() would require extra update-support guards
and refreshing the cached value across module updates.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v10:
 - Polish the changelog [Rick]
 - Rename "primary" to "is_lead_cpu" and polish the comment above it [Rick]
---
 arch/x86/include/asm/tdx_global_metadata.h  |  4 ++++
 arch/x86/virt/vmx/tdx/seamldr.c             | 15 ++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.c                 | 19 ++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h                 |  3 +++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 13 +++++++++++++
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/tdx_global_metadata.h b/arch/x86/include/asm/tdx_global_metadata.h
index 40689c8dc67e..41150d546589 100644
--- a/arch/x86/include/asm/tdx_global_metadata.h
+++ b/arch/x86/include/asm/tdx_global_metadata.h
@@ -40,6 +40,10 @@ struct tdx_sys_info_td_conf {
 	u64 cpuid_config_values[128][2];
 };
 
+struct tdx_sys_info_handoff {
+	u16 module_hv;
+};
+
 struct tdx_sys_info {
 	struct tdx_sys_info_version version;
 	struct tdx_sys_info_features features;
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 002cdae3b1ff..217b3c962aff 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -15,6 +15,7 @@
 #include <asm/seamldr.h>
 
 #include "seamcall_internal.h"
+#include "tdx.h"
 
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
@@ -175,6 +176,7 @@ static int init_seamldr_params(struct seamldr_params *params,
  */
 enum module_update_state {
 	MODULE_UPDATE_START,
+	MODULE_UPDATE_SHUTDOWN,
 	MODULE_UPDATE_DONE,
 };
 
@@ -225,8 +227,16 @@ static void init_state(struct update_ctrl *ctrl)
 static int do_seamldr_install_module(void *seamldr_params)
 {
 	enum module_update_state newstate, curstate = MODULE_UPDATE_START;
+	int cpu = smp_processor_id();
+	bool is_lead_cpu;
 	int ret = 0;
 
+	/*
+	 * Some steps must be run on exactly one CPU. Pick a "lead" CPU to
+	 * execute those steps. Use CPU 0 because it is always online.
+	 */
+	is_lead_cpu = cpu == 0;
+
 	do {
 		newstate = READ_ONCE(update_ctrl.state);
 
@@ -237,7 +247,10 @@ static int do_seamldr_install_module(void *seamldr_params)
 
 		curstate = newstate;
 		switch (curstate) {
-		/* TODO: add the update steps. */
+		case MODULE_UPDATE_SHUTDOWN:
+			if (is_lead_cpu)
+				ret = tdx_module_shutdown();
+			break;
 		default:
 			break;
 		}
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 53cf99c41dbb..84d5df70a250 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -328,7 +328,7 @@ static __init int build_tdx_memlist(struct list_head *tmb_list)
 	return ret;
 }
 
-static __init int read_sys_metadata_field(u64 field_id, u64 *data)
+static int read_sys_metadata_field(u64 field_id, u64 *data)
 {
 	struct tdx_module_args args = {};
 	int ret;
@@ -1274,6 +1274,23 @@ static __init int tdx_enable(void)
 }
 subsys_initcall(tdx_enable);
 
+int tdx_module_shutdown(void)
+{
+	struct tdx_sys_info_handoff handoff = {};
+	struct tdx_module_args args = {};
+	int ret;
+
+	ret = get_tdx_sys_info_handoff(&handoff);
+	WARN_ON_ONCE(ret);
+
+	/*
+	 * Use the module's handoff version as it is the highest the
+	 * module can produce and most likely supported by newer modules.
+	 */
+	args.rcx = handoff.module_hv;
+	return seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 76c5fb1e1ffe..f0c20dea0388 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -46,6 +46,7 @@
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
+#define TDH_SYS_SHUTDOWN		52
 #define TDH_SYS_DISABLE			69
 
 /*
@@ -108,4 +109,6 @@ struct tdmr_info_list {
 	int max_tdmrs;	/* How many 'tdmr_info's are allocated */
 };
 
+int tdx_module_shutdown(void);
+
 #endif
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index d54d4227990c..e793dec688ab 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -100,6 +100,19 @@ static __init int get_tdx_sys_info_td_conf(struct tdx_sys_info_td_conf *sysinfo_
 	return ret;
 }
 
+static int get_tdx_sys_info_handoff(struct tdx_sys_info_handoff *sysinfo_handoff)
+{
+	int ret;
+	u64 val;
+
+	ret = read_sys_metadata_field(0x8900000100000000, &val);
+	if (ret)
+		return ret;
+
+	sysinfo_handoff->module_hv = val;
+	return 0;
+}
+
 static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 {
 	int ret = 0;
-- 
2.52.0


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2169374169;
	Thu, 26 Mar 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514745; cv=none; b=MfGsiYdTjmFyPfYV3q7OaBM75JyFLtzLqcHuwslT8UiXdHwKTCLXrz/6DLG+Wqkjg75kv7lB1w6BOKJqF2WcxtWOsyPidAzfIOcyeMQzEMG/Uos5au0GzbcwS0W8T9hgo2efs5YesGQ+tsY2gN05p9BgQ6613f6wd8U98NmzYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514745; c=relaxed/simple;
	bh=xvaNJTfVPQw1urCsOAJz1lE9ABKHlHI7ev1QUlnuhmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7zy9pM9MEue8IzTUag+sArd0vIcjBflKpisSKrfFPgkIXWmYQdhPJFCq+1nLha17rnGeQiub5HqgvTS6XFnJz28u/si8isZXVqeA16hPoUYYpyZtK1znavhEKjjbR3LfOsdvRa5RdMLLb9kcYfvOYT46GKbcr65W0E7fCUEMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGv34o77; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGv34o77"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514744; x=1806050744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xvaNJTfVPQw1urCsOAJz1lE9ABKHlHI7ev1QUlnuhmQ=;
  b=NGv34o77JLKHR0apNmd1Dwa2yX2SL2faDAQd6z6eLy3JP3Ha5HmK7NJT
   Me8qbxdY0jf7tvSwmGJuBLPqazr2HAwBzPBrD9Sj+/Cu2iDfl21DBfKuT
   eg3o6f7HqufaDD+gzbBmQ5EMGiBrq6x86iY3WAdJW8i5DEpvo+4DFYdbM
   CKpnngH+AC41HN8u2x2g9M/l/OnLHA0+3qPv4CuS7i6qZr2vBZ7jsleU7
   SmBwBKgdwMviVmyzr3CfDC49m/+WqY3AjuOO+uqfMUoyZDHu/UxXOEzQm
   JgivAvID/0PPRWNThclku2km2zjQPGDsWPnBBNcuDEbRMwg7ieHjetHYJ
   w==;
X-CSE-ConnectionGUID: lJNGoQ45Q9e7KemfIsjSZw==
X-CSE-MsgGUID: WN/M+t8ATfqSwV3xCOttHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644736"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644736"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:25 -0700
X-CSE-ConnectionGUID: pULqjt9ARv6HsQbPU998yw==
X-CSE-MsgGUID: F+r/oZIXRVOUgu9NWhKdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967235"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:24 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
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
Subject: [PATCH v6 16/22] x86/virt/tdx: Update tdx_sysinfo and check features post-update
Date: Thu, 26 Mar 2026 01:44:07 -0700
Message-ID: <20260326084448.29947-17-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tdx_sysinfo contains all metadata of the active TDX module, including
versions, supported features, and TDMR/TDCS/TDVPS information etc. These
values may change over updates. Blindly refreshing the entire tdx_sysinfo
could disrupt running software, as it may subtly rely on the previous state
unless proven otherwise.

Adopt a conservative approach, like microcode updates, by only refreshing
version information that does not affect functionality, while ignoring
all other changes. This is acceptable as new modules are required to
maintain backward compatibility.

Any updates to metadata beyond versions should be justified and reviewed on
a case-by-case basis.

Note that preallocating a tdx_sys_info buffer before updates is to avoid
having to handle -ENOMEM when updating tdx_sysinfo after a successful
update.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
v5:
 - Drop the comment above tdx_module_post_update() [Kai]

v3:
 - use 'old' instead of 'cur' as the local variable to represent the
   sysinfo of the previous module [Binbin]
 - combine if(ret) and WARN_ONCE(1, ...) to WARN_ONCE(ret, ...) [Binbin]
 - Improve the print log messages after detecting new features from updates.
   [Binbin]

v2:
 - don't add a separate function for version and feature checks. Do them
   directly in tdx_module_post_update()
 - add a comment about preallocating a tdx_sys_info buffer in
   seamldr_install_module().
---
 arch/x86/virt/vmx/tdx/seamldr.c | 18 ++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.c     | 39 +++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  3 +++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 6d3ea6d36f36..0ab2413e3754 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -299,6 +299,18 @@ DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
  */
 int seamldr_install_module(const u8 *data, u32 size)
 {
+	int ret;
+
+	/*
+	 * Preallocating a tdx_sys_info buffer before an update is to avoid
+	 * having to handle -ENOMEM when updating tdx_sysinfo after a
+	 * successful update.
+	 */
+	struct tdx_sys_info *sysinfo __free(kfree) = kzalloc(sizeof(*sysinfo),
+							     GFP_KERNEL);
+	if (!sysinfo)
+		return -ENOMEM;
+
 	struct seamldr_params *params __free(free_seamldr_params) =
 						init_seamldr_params(data, size);
 	if (IS_ERR(params))
@@ -306,6 +318,10 @@ int seamldr_install_module(const u8 *data, u32 size)
 
 	update_data.failed = false;
 	set_target_state(MODULE_UPDATE_START + 1);
-	return stop_machine(do_seamldr_install_module, params, cpu_online_mask);
+	ret = stop_machine(do_seamldr_install_module, params, cpu_online_mask);
+	if (ret)
+		return ret;
+
+	return tdx_module_post_update(sysinfo);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7592cba58c19..69c97b73e243 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1224,6 +1224,45 @@ int tdx_module_run_update(void)
 	return 0;
 }
 
+int tdx_module_post_update(struct tdx_sys_info *info)
+{
+	struct tdx_sys_info_version *old, *new;
+	int ret;
+
+	/* Shouldn't fail as the update has succeeded. */
+	ret = get_tdx_sys_info(info);
+	if (WARN_ONCE(ret, "version retrieval failed after update, replace the TDX module\n"))
+		return ret;
+
+	old = &tdx_sysinfo.version;
+	new = &info->version;
+	pr_info("version %u.%u.%02u -> %u.%u.%02u\n", old->major_version,
+						      old->minor_version,
+						      old->update_version,
+						      new->major_version,
+						      new->minor_version,
+						      new->update_version);
+
+	/*
+	 * Blindly refreshing the entire tdx_sysinfo could disrupt running
+	 * software, as it may subtly rely on the previous state unless
+	 * proven otherwise.
+	 *
+	 * Only refresh version information (including handoff version)
+	 * that does not affect functionality, and ignore all other
+	 * changes.
+	 */
+	tdx_sysinfo.version	= info->version;
+	tdx_sysinfo.handoff	= info->handoff;
+
+	if (!memcmp(&tdx_sysinfo, info, sizeof(*info)))
+		return 0;
+
+	pr_info("TDX module features have changed after updates, but might not take effect.\n");
+	pr_info("Please consider updating your BIOS to install the TDX module.\n");
+	return 0;
+}
+
 static bool is_pamt_page(unsigned long phys)
 {
 	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index c62874b87d7a..f8686247c660 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -4,6 +4,8 @@
 
 #include <linux/bits.h>
 
+#include <asm/tdx_global_metadata.h>
+
 /*
  * This file contains both macros and data structures defined by the TDX
  * architecture and Linux defined software data structures and functions.
@@ -122,5 +124,6 @@ struct tdmr_info_list {
 
 int tdx_module_shutdown(void);
 int tdx_module_run_update(void);
+int tdx_module_post_update(struct tdx_sys_info *info);
 
 #endif
-- 
2.47.3


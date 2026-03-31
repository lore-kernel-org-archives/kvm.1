Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0AC3F0A9E;
	Tue, 31 Mar 2026 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961020; cv=none; b=b8ywIj9deizwn6I1aRS8XUdriGdXcaI2bSuVOy3VG7UNjJAn8SCUsSoHjfHo3fZFVaC3wzkQn+AqBVIT7Vobzck/cFMlsNGCtJuR5icFYkL0UxEIzcTqBqfWrRqsWeyzsy2WWBs4XImYxTF4QKyG9TyY+dcZCZNU81biRiOtl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961020; c=relaxed/simple;
	bh=QOqHnG8rJQ9rPntcpaLiarWTXFTZNPMcoiZDLiGM6nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAimN22eeCtc0u7jPdhG5whkaeCI57YF7HhBxVpliL1KXUKlP/fsqPc+7nVizO2fEBz5+h+D49e1bgD8v1KpbvqstHzp4IsWVkxcu6oC5tA2u5ZQOec14cHyrh+/bn8sx7Wou4AE70yRXIOrdhly8/tQIRBRH8AcFwexGuSCweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LU7F61As; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LU7F61As"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961019; x=1806497019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOqHnG8rJQ9rPntcpaLiarWTXFTZNPMcoiZDLiGM6nM=;
  b=LU7F61AsvPaMBpEq/b8FHy/Yqt80QT9JfVxFb2Q2X2wm2MKiwYEACVLZ
   eYbeJDgr82MdQM+S1uKnjm+0ZACtaXF4NHnjVBYtN2wf37bgrZ3sIOeBl
   AKPrOxifp5hsceqB0Y6pyVawG098KqAa/UONFEiRZ7Es4rnyl2OGe8yk3
   zMwL3wN4cUms29z5Fyx8h1ls9MRg7x2sK2h+FZeWXq8vYiU35bgFL0zoh
   FjS2fBqcS5mrFWPQzeV08BjWJ5gZsQ1inD5hd/3GV0en1aF5NGh6SMHVX
   LlEyufvw8GSPHYSUSYui4vOS3f0WPkf+lkTNVWRhaFkpZjTHdLpnU5uQ9
   g==;
X-CSE-ConnectionGUID: 2gK8EjB6TqmD3d96fyGr0A==
X-CSE-MsgGUID: /0G6ssMmQsORU4lD5wOGkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084564"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084564"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:38 -0700
X-CSE-ConnectionGUID: AKTxwKKZQ1eqP/bJErKHdQ==
X-CSE-MsgGUID: zBIQjgTtTjams0eK+0Os9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492172"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:37 -0700
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
Subject: [PATCH v7 16/22] x86/virt/tdx: Update tdx_sysinfo and check features post-update
Date: Tue, 31 Mar 2026 05:41:29 -0700
Message-ID: <20260331124214.117808-17-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
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

Also note that TDX module updates are supported only between releases
with different update versions but identical major and minor versions.
So, major and minor versions are not refreshed.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
Sashiko flagged a potential torn-read concern: update_version is read
via sysfs while it is refreshed post-update. But, update_version is a
naturally-aligned u16, and on x86, the compiler won't split aligned u16
accesses. So READ_ONCE/WRITE_ONCE() aren't needed for update_version.

v7:
 - use TDX_VERSION_FMT
 - only update update_version and add a comment to explain why

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
 arch/x86/virt/vmx/tdx/seamldr.c | 18 ++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.c     | 36 +++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h     |  3 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index a907b34d40c5..b3f3b40627c3 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -316,6 +316,18 @@ DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
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
@@ -330,6 +342,10 @@ int seamldr_install_module(const u8 *data, u32 size)
 	guard(cpus_read_lock)();
 	update_data.failed = false;
 	set_target_state(MODULE_UPDATE_START + 1);
-	return stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
+	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
+	if (ret)
+		return ret;
+
+	return tdx_module_post_update(sysinfo);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 60caceb1baa7..08d9f4cb32f9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1232,6 +1232,42 @@ int tdx_module_run_update(void)
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
+	pr_info("version " TDX_VERSION_FMT " -> " TDX_VERSION_FMT "\n",
+		old->major_version, old->minor_version, old->update_version,
+		new->major_version, new->minor_version, new->update_version);
+
+	/*
+	 * Blindly refreshing the entire tdx_sysinfo could disrupt running
+	 * software, as it may subtly rely on the previous state unless
+	 * proven otherwise.
+	 *
+	 * Only refresh update_version and handoff version. They don't
+	 * affect TDX functionality. Major/minor versions do not change
+	 * across updates, so no refresh is needed.
+	 */
+	tdx_sysinfo.version.update_version	= info->version.update_version;
+	tdx_sysinfo.handoff			= info->handoff;
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


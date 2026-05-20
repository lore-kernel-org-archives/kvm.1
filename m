Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AEE2D94B5;
	Wed, 20 May 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284424; cv=none; b=WYYxkFDOYpC8CG1KiwWjgrpumUU8yprJvPGbWzrUG5Z1YilxfDD/HBwlkv3/wP8G4UtXyw5nTXPJyk7jg2RPSxGzqr6gpAdOqGW2b2E6P4GZrNBH/K/Gce0hA4/O4HBwz2RHbF7hvgY74UmJvFgnAZ6+GNxcNDfCbcObuxsJH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284424; c=relaxed/simple;
	bh=xFq7z+yD2KnqYhp+RfH6uPtT6cIpAo/nQxQdNfO6F/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUpY/rJRV4uRMPWDJPrOcq0pJH1JMDToaEsYYUpGegSdIZZlaa8WUHKfh2i8f3+zifKPeLOHkF1PTHHeF6fVe+ZxWhHM4uT5BP76BcuqAzbTIm1iZTLrnKT8zmSuDCI2YHJVK6DPpT6DCs40qfPLOC80X32C8x59+FWxc5wm4ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eGbtvzW4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eGbtvzW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284422; x=1810820422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xFq7z+yD2KnqYhp+RfH6uPtT6cIpAo/nQxQdNfO6F/k=;
  b=eGbtvzW4OK2AjITcY4yHXHX/QVkM6gi7j4IzQlT09Qdmu4v8DAo6kdbT
   upZIn+ymIMByg9XsjS+AZBpoI0lSjxdYFLhIib/1FpYKOin+dB+p7LzJ7
   tQQyFRqtfPWcqpr/CHsJMIPlrxFEqPr0R1Foy6HxILvBrec/KJgTpwWL1
   0df/GDfTK8FK/EDs6XbmKHZtxztMlCxkNJneMNJl0SQ/cHyj55HYmp5jj
   sl/78JWwny68YFBfn/ZIZsevOp7sfhUHTmyXbsKCSqfhD+Fgx9kzOPMZn
   bbJWUv7eReooJuSxQVAOEGv/ryQ4Tjz8IbVUPKSOQHQ4WNgDIzekte1Ft
   w==;
X-CSE-ConnectionGUID: moYAMCbsTmuBgjrUZ2gXuw==
X-CSE-MsgGUID: vvUDv8ylQ+a6H9EH0fFXZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146502"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146502"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:17 -0700
X-CSE-ConnectionGUID: EkeuaMvTRnO8AAgKEktmhA==
X-CSE-MsgGUID: 9sCDtDfARBulxk0X8X6kGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923863"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:16 -0700
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
Subject: [PATCH v10 12/25] coco/tdx-host: Implement firmware upload sysfs ABI for TDX module updates
Date: Wed, 20 May 2026 06:38:15 -0700
Message-ID: <20260520133909.409394-13-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl;dr: Select fw_upload for doing TDX module updates. The process of
selecting among available update images is complicated and nuanced. Punt
the selection process out to userspace. One existing userspace
implementation today is the script in the Intel TDX Module Binaries
repository.

Long Version:

The kernel supports two primary firmware update mechanisms:
 1. request_firmware() - used by microcode, SEV firmware, hundreds of
			 other drivers
 2. 'struct fw_upload' - used by CXL, FPGA updates, dozens of others

The key difference between is that request_firmware() loads a named file
from the filesystem where the filename is kernel-controlled, while
fw_upload accepts firmware data directly from userspace.

TDX module firmware update selection policy is too complex for the kernel.
Leave it to userspace and use fw_upload.

Why fw_upload instead of request_firmware()?
============================================

Selecting a TDX module update image is not a simple "load the latest"
decision. Userspace needs to choose an image that is compatible with both
the platform and the currently running module.

Some constraints are hard requirements:

a. Module version series are platform-specific. For example, the 1.5.x
   series runs on Sapphire Rapids but not Granite Rapids, which needs
   2.0.x.

b. Updates are also constrained by version distance. A 1.5.6 module
   might permit updates to 1.5.7 but not to 1.5.50.

There may also be userspace policy choices:

c. Decide the update direction: upgrade or downgrade

d. Choose whether to optimize for fewer updates or smaller version
   steps, for example, 1.2.3=>1.2.5 versus 1.2.3=>1.2.4=>1.2.5.

Given that complexity, leave module selection to userspace and use
fw_upload.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/kvm/01fc8946-eb84-46fa-9458-f345dd3f6033@intel.com/
---
Future patches add more cases to the switch in tdx_fw_write(). With only two
cases, the switch looks a bit awkward right now.

v10:
 - Polish the changelog [Dave]
 - Point to one existing userspace implementation [Dave]
 - Separate hard compatibility requirements from userspace policy choices
 - Use true/false rather than 0/1 for bool return values.
 - s/size/data_len
---
 arch/x86/include/asm/seamldr.h        |  1 +
 arch/x86/virt/vmx/tdx/seamldr.c       | 14 ++++
 drivers/virt/coco/tdx-host/Kconfig    |  2 +
 drivers/virt/coco/tdx-host/tdx-host.c | 92 +++++++++++++++++++++++++--
 4 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
index a74151b75599..43084e2daa2d 100644
--- a/arch/x86/include/asm/seamldr.h
+++ b/arch/x86/include/asm/seamldr.h
@@ -31,5 +31,6 @@ struct seamldr_info {
 static_assert(sizeof(struct seamldr_info) == 256);
 
 int seamldr_get_info(struct seamldr_info *seamldr_info);
+int seamldr_install_module(const u8 *data, u32 data_len);
 
 #endif /* _ASM_X86_SEAMLDR_H */
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 7269a239bc22..d3880b0f93aa 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -41,3 +41,17 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 	return seamldr_call(P_SEAMLDR_INFO, &args);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
+
+/**
+ * seamldr_install_module - Install a new TDX module.
+ * @data: Pointer to the TDX module image.
+ * @data_len: Size of the TDX module image.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int seamldr_install_module(const u8 *data, u32 data_len)
+{
+	/* TODO: Update TDX module here */
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index cfe81b9c0364..57d0c01a4357 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -1,4 +1,6 @@
 config TDX_HOST_SERVICES
 	tristate
 	depends on INTEL_TDX_HOST
+	select FW_LOADER
+	select FW_UPLOAD
 	default m
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 2cd7be7bb404..b32ab595047f 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device/faux.h>
+#include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/sysfs.h>
@@ -88,15 +89,15 @@ static struct attribute *seamldr_attrs[] = {
 	NULL,
 };
 
-static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
+static bool supports_runtime_update(void)
 {
 	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
 
 	if (!sysinfo)
-		return 0;
+		return false;
 
 	if (!tdx_supports_runtime_update(sysinfo))
-		return 0;
+		return false;
 
 	/*
 	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
@@ -104,6 +105,14 @@ static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *att
 	 * present before exposing P-SEAMLDR features.
 	 */
 	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
+		return false;
+
+	return true;
+}
+
+static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	if (!supports_runtime_update())
 		return 0;
 
 	return attr->mode;
@@ -120,6 +129,81 @@ static const struct attribute_group *tdx_host_groups[] = {
 	NULL,
 };
 
+static enum fw_upload_err tdx_fw_prepare(struct fw_upload *fwl,
+					 const u8 *data, u32 data_len)
+{
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
+				       u32 offset, u32 data_len, u32 *written)
+{
+	int ret;
+
+	ret = seamldr_install_module(data, data_len);
+	switch (ret) {
+	case 0:
+		*written = data_len;
+		return FW_UPLOAD_ERR_NONE;
+	default:
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+}
+
+static enum fw_upload_err tdx_fw_poll_complete(struct fw_upload *fwl)
+{
+	/*
+	 * The upload completed during tdx_fw_write().
+	 * Never poll for completion.
+	 */
+	return FW_UPLOAD_ERR_NONE;
+}
+
+
+static void tdx_fw_cancel(struct fw_upload *fwl)
+{
+	/*
+	 * TDX module updates are not cancellable.
+	 * Provide a no-op callback to satisfy fw_upload_ops.
+	 */
+}
+
+static const struct fw_upload_ops tdx_fw_ops = {
+	.prepare	= tdx_fw_prepare,
+	.write		= tdx_fw_write,
+	.poll_complete	= tdx_fw_poll_complete,
+	.cancel		= tdx_fw_cancel,
+};
+
+static void seamldr_deinit(void *tdx_fwl)
+{
+	firmware_upload_unregister(tdx_fwl);
+}
+
+static int seamldr_init(struct device *dev)
+{
+	struct fw_upload *tdx_fwl;
+
+	if (!supports_runtime_update())
+		return 0;
+
+	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
+					   &tdx_fw_ops, NULL);
+	if (IS_ERR(tdx_fwl))
+		return PTR_ERR(tdx_fwl);
+
+	return devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
+}
+
+static int tdx_host_probe(struct faux_device *fdev)
+{
+	return seamldr_init(&fdev->dev);
+}
+
+static const struct faux_device_ops tdx_host_ops = {
+	.probe		= tdx_host_probe,
+};
+
 static struct faux_device *fdev;
 
 static int __init tdx_host_init(void)
@@ -127,7 +211,7 @@ static int __init tdx_host_init(void)
 	if (!x86_match_cpu(tdx_host_ids) || !tdx_get_sysinfo())
 		return -ENODEV;
 
-	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, NULL, tdx_host_groups);
+	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, &tdx_host_ops, tdx_host_groups);
 	if (!fdev)
 		return -ENODEV;
 
-- 
2.52.0


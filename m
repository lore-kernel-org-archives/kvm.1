Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6165147D95C;
	Wed, 13 May 2026 15:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685111; cv=none; b=t7o44iBQF8USC+hbvWfwOeEtjefT95vErqA/tPs9VZQyLXQoZ1cqWagVD6ESKEv9CDOSxIZLddhzXJAXs278h3FAe/bjaLzFzzmOLW6AQAGdGX2RMGw0+U/So2IcJgtDgfP2SfQ2N72OKVlbhVLOAAbWzsH9Oc6ZwMIKNa7w7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685111; c=relaxed/simple;
	bh=beV9EOdjFCy/ljpfkkUCekXBiTBe08yzb9VkAqkB1v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK257wz/LwDGEV4AnBlusjG4eRGb44M5lCVOmAG4RjhRI8kHrSBzsSs/rnem179XJQxeU38FlEeBxtxR9oqjfWtKLcdF9EZCm+yhbSlbZPH6M9V60jPjQRFjYN1kwSv927GwVH1dAPrAe0SMeomh3TmGS1ETA1Ji1n1psGslNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5wMqOZV; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5wMqOZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685108; x=1810221108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=beV9EOdjFCy/ljpfkkUCekXBiTBe08yzb9VkAqkB1v4=;
  b=A5wMqOZVSd9ZSZbCczwQBs2v44dDARPM9FfpMxiSJBwn0agJg7ZPyzjF
   PpWhRbrTYBxT8ai5aiUzWe1w6RaTD7lbHNiitDlcG7hJBJZ+3eo8pYHqX
   YlD8Awb1AHjxrhcuFGcj/j0hLN/NxWRRb0iqnsugF7lTJuQu5fOrXKGU/
   4S5e3nga/XkKxtt4CkUr3TiZ/Hv4N/Vy1QzHK1IpQpbsY4j3Gmv2zBuj8
   wzH4sfzd7HYETrP6akrrEkb1klrOhBEATlsaGmmdvN1R9BdZDzxDmhU8C
   ihbKilntlFAMJTtpqZIVHz7j+fAv/M+1B95vQpVZdYJf5X03gLn2quQ+F
   Q==;
X-CSE-ConnectionGUID: zmxyV9iERMOf7c3N53D4xA==
X-CSE-MsgGUID: LqLoxKNXTa6Pa/4eD2VZ5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921687"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921687"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:48 -0700
X-CSE-ConnectionGUID: AwjR5SDaRm28LCE+vHlnLA==
X-CSE-MsgGUID: jHch+/iqTRyq9OpUqdtXwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716818"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:47 -0700
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
Subject: [PATCH v9 10/23] coco/tdx-host: Implement firmware upload sysfs ABI for TDX module updates
Date: Wed, 13 May 2026 08:09:53 -0700
Message-ID: <20260513151045.1420990-11-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl;dr: Select fw_upload for doing TDX module updates. The process of
selecting among available update images is complicated and nuanced. Punt
the selection policy out to userspace.

Long Version:

Linux kernel supports two primary firmware update mechanisms:
  - request_firmware()
  - firmware upload (or fw_upload)

The former is used by microcode updates, SEV firmware updates, etc. The
latter is used by CXL and FPGA firmware updates.

One key difference between them is: request_firmware() loads a named
file from the filesystem where the filename is kernel-controlled, while
fw_upload accepts firmware data directly from userspace.

Use fw_upload for TDX module updates as loading a named file isn't
suitable for TDX (see below for more reasons). Specifically, register
TDX faux device with fw_upload framework to expose sysfs interfaces
and implement operations to process data blobs supplied by userspace.

Why fw_upload instead of request_firmware()?
============================================
The explicit file selection capabilities of fw_upload is preferred over
the implicit file selection of request_firmware() for the following
reasons:

a. Intel distributes all versions of the TDX module, allowing admins to
load any version rather than always defaulting to the latest. This
flexibility is necessary because future extensions may require reverting to
a previous version to clear fatal errors.

b. Some module version series are platform-specific. For example, the 1.5.x
series is for certain platform generations, while the 2.0.x series is
intended for others.

c. The update policy for TDX module updates is non-linear at times. The
latest TDX module may not be compatible. For example, TDX module 1.5.x
may be updated to 1.5.y but not to 1.5.y+1. This policy is documented
separately in a file released along with each TDX module release.

So, the default policy of "request_firmware()" of "always load latest", is
not suitable for TDX. Userspace needs to deploy a more sophisticated policy
check (e.g., latest may not be compatible), and there is potential
operator choice to consider.

Just have userspace pick rather than add kernel mechanism to change the
default policy of request_firmware().

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/kvm/01fc8946-eb84-46fa-9458-f345dd3f6033@intel.com/
---
Dave also suggested making .poll_complete() optional in fw_upload_ops.
That will be handled in a separate series.

v9:
 - add a TL;DR to state the implementation choice up front [Dave]
 - s/can_expose_seamldr()/supports_runtime_update()/ [Dave]
---
 arch/x86/include/asm/seamldr.h        |  1 +
 arch/x86/virt/vmx/tdx/seamldr.c       | 15 +++++
 drivers/virt/coco/tdx-host/Kconfig    |  2 +
 drivers/virt/coco/tdx-host/tdx-host.c | 87 ++++++++++++++++++++++++++-
 4 files changed, 102 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
index c67e5bc910a9..ac6f80f7208b 100644
--- a/arch/x86/include/asm/seamldr.h
+++ b/arch/x86/include/asm/seamldr.h
@@ -32,5 +32,6 @@ struct seamldr_info {
 static_assert(sizeof(struct seamldr_info) == 256);
 
 int seamldr_get_info(struct seamldr_info *seamldr_info);
+int seamldr_install_module(const u8 *data, u32 size);
 
 #endif /* _ASM_X86_SEAMLDR_H */
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 7269a239bc22..7b345000d7c3 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"seamldr: " fmt
 
+#include <linux/mm.h>
 #include <linux/spinlock.h>
 
 #include <asm/seamldr.h>
@@ -41,3 +42,17 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 	return seamldr_call(P_SEAMLDR_INFO, &args);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
+
+/**
+ * seamldr_install_module - Install a new TDX module.
+ * @data: Pointer to the TDX module image.
+ * @size: Size of the TDX module image.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int seamldr_install_module(const u8 *data, u32 size)
+{
+	/* TODO: Update TDX module here */
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
index d35d85ef91c0..ca600a39d97b 100644
--- a/drivers/virt/coco/tdx-host/Kconfig
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -1,6 +1,8 @@
 config TDX_HOST_SERVICES
 	tristate "TDX Host Services Driver"
 	depends on INTEL_TDX_HOST
+	select FW_LOADER
+	select FW_UPLOAD
 	default m
 	help
 	  Enable access to TDX host services like module update and
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index a540d658757b..c4c099cf3de1 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device/faux.h>
+#include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/sysfs.h>
@@ -84,7 +85,7 @@ static struct attribute *seamldr_attrs[] = {
 	NULL,
 };
 
-static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
+static bool supports_runtime_update(void)
 {
 	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
 
@@ -99,7 +100,12 @@ static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *att
 	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
 		return 0;
 
-	return tdx_supports_runtime_update(sysinfo) ? attr->mode : 0;
+	return tdx_supports_runtime_update(sysinfo);
+}
+
+static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	return supports_runtime_update() ? attr->mode : 0;
 }
 
 static const struct attribute_group seamldr_group = {
@@ -113,6 +119,81 @@ static const struct attribute_group *tdx_host_groups[] = {
 	NULL,
 };
 
+static enum fw_upload_err tdx_fw_prepare(struct fw_upload *fwl,
+					 const u8 *data, u32 size)
+{
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err tdx_fw_write(struct fw_upload *fwl, const u8 *data,
+				       u32 offset, u32 size, u32 *written)
+{
+	int ret;
+
+	ret = seamldr_install_module(data, size);
+	switch (ret) {
+	case 0:
+		*written = size;
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
@@ -120,7 +201,7 @@ static int __init tdx_host_init(void)
 	if (!x86_match_cpu(tdx_host_ids) || !tdx_get_sysinfo())
 		return -ENODEV;
 
-	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, NULL, tdx_host_groups);
+	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, &tdx_host_ops, tdx_host_groups);
 	if (!fdev)
 		return -ENODEV;
 
-- 
2.52.0


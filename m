Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006D936404B;
	Sun, 15 Mar 2026 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583182; cv=none; b=iGyYZPGnWrJUwvC3H7DLiP2x84KZ38eCutS5CLUMBIqNxGCE16OZ7rvGffcd4aunC7uKQA8zqth4uVQkIcu/SYlhqE9a9uE4PJwt4XABF+2ybkaFUc6FIuqFNwYcyOiZ+y2G6UhvINL1gh7qgLTtuJaKvCxQo5enzfyaH8JOc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583182; c=relaxed/simple;
	bh=PD5wUbG77MdVhZ9aCKXvn8YsXd9OGzPo08bHmQoFilw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWSBmheCkhcnvBvbC0VW35qunWTx+g7fhxrnJyWODU8pnyQhUxipf0nEwpBjvdMuUQLEGirw3rSrFnabG8jQCPJMYPqRqzsMk0rdGWJuLvZMnjj7vv/Tv3iS0WcRePUGeiS8bCYTtPbona/Rtd1vX6SUG4Vv6iS4+unTAXMWMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsGdALy0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsGdALy0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583180; x=1805119180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PD5wUbG77MdVhZ9aCKXvn8YsXd9OGzPo08bHmQoFilw=;
  b=GsGdALy03U92fWTRLnoqY/iFm5PWMq3+BpfO4A4enA4WGom9S+kUnU8O
   pC0UOGVEvG0dQfNyEx9FLBsPMW6emqJD+62rJIJDr40ceEGTJrD3eBE4O
   G0yhtinVyjVJEHAw72xFEM7avQcPma5/3TzLw5LD/xs1ApXPhXXhJJovH
   jtadCeP0/x6EKeqJgAH+aYSBSCqdToDF91vh7MHC21jJGE/140vJIevVf
   GeMzNaSHh/g5waRQpHgXENZOTG8BHMwEVe0jTECf7wQ68BT0wWx9q2amS
   vBdBznNvZlRTBWbLuz8MpH2v9sEyAFy/mLsY5Vr2ZLePx03vNguuACzQe
   Q==;
X-CSE-ConnectionGUID: TNyshcbJQaicVId/dqMBjg==
X-CSE-MsgGUID: y6NtPL47QT+4Vvh+VQ966A==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732460"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732460"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:39 -0700
X-CSE-ConnectionGUID: MyJ/PqDJQyikSeAyPvsBYg==
X-CSE-MsgGUID: 8YO5Oo2lQa+XhQDm9LO/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123032"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:39 -0700
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
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 07/22] coco/tdx-host: Implement firmware upload sysfs ABI for TDX module updates
Date: Sun, 15 Mar 2026 06:58:27 -0700
Message-ID: <20260315135920.354657-8-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Implementation notes:
1. P-SEAMLDR processes the entire update at once rather than
   chunk-by-chunk, so .write() is called only once per update; so the
   offset should be always 0.
2. An update completes synchronously within .write(), meaning
   .poll_complete() is only called after the update succeeds and so always
   returns success

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
---
v5:
 - remove a tail comment [Yan]
 - remove is_vmalloc_addr() check [Dave]
 - use devm_add_action_or_reset() for deinit [Yilun]
 - remove global tdx_fwl [Yilun]
 - clarify request_firmware() doesn't take filename from userspace
   [Rick]

v4:
 - make tdx_fwl static [Kai]
 - don't support update canceling [Yilun]
 - explain why seamldr_init() doesn't return an error [Kai]
 - bail out if TDX module updates are not supported [Kai]
 - name the firmware "tdx_module" instead of "seamldr_upload" [Cedric]

v3:
 - clear "cancel_request" in the "prepare" phase [Binbin]
 - Don't fail the whole tdx-host device if seamldr_init() met an error
 [Yilun]
 - Add kdoc for seamldr_install_module() and verify that the input
   buffer is vmalloc'd. [Yilun]
---
 arch/x86/include/asm/seamldr.h        |  1 +
 arch/x86/include/asm/tdx.h            |  6 ++
 arch/x86/virt/vmx/tdx/seamldr.c       | 15 +++++
 drivers/virt/coco/tdx-host/Kconfig    |  2 +
 drivers/virt/coco/tdx-host/tdx-host.c | 87 +++++++++++++++++++++++++++
 5 files changed, 111 insertions(+)

diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
index c67e5bc910a9..ac6f80f7208b 100644
--- a/arch/x86/include/asm/seamldr.h
+++ b/arch/x86/include/asm/seamldr.h
@@ -32,5 +32,6 @@ struct seamldr_info {
 static_assert(sizeof(struct seamldr_info) == 256);
 
 int seamldr_get_info(struct seamldr_info *seamldr_info);
+int seamldr_install_module(const u8 *data, u32 size);
 
 #endif /* _ASM_X86_SEAMLDR_H */
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index cb2219302dfc..b3a7301e77c6 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -103,6 +103,12 @@ int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
+static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
+{
+	 /* To be enabled when kernel is ready. */
+	return false;
+}
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 7c0cbab2c4c0..7114326d7569 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -6,6 +6,7 @@
  */
 #define pr_fmt(fmt)	"seamldr: " fmt
 
+#include <linux/mm.h>
 #include <linux/spinlock.h>
 
 #include <asm/seamldr.h>
@@ -39,3 +40,17 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 	return seamldr_call(P_SEAMLDR_INFO, &args);
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
+
+/**
+ * seamldr_install_module - Install a new TDX module.
+ * @data: Pointer to the TDX module update blob.
+ * @size: Size of the TDX module update blob.
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
index 8d46e3c039ba..1b93d20406c1 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/device/faux.h>
+#include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/sysfs.h>
@@ -94,8 +95,94 @@ static const struct attribute_group seamldr_group = {
 	.attrs = seamldr_attrs,
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
+	/*
+	 * tdx_fw_write() always processes all data on the first call with
+	 * offset == 0. Since it never returns partial success (it either
+	 * succeeds completely or fails), there is no subsequent call with
+	 * non-zero offsets.
+	 */
+	WARN_ON_ONCE(offset);
+	ret = seamldr_install_module(data, size);
+	switch (ret) {
+	case 0:
+		*written = size;
+		return FW_UPLOAD_ERR_NONE;
+	case -EBUSY:
+		return FW_UPLOAD_ERR_BUSY;
+	case -EIO:
+		return FW_UPLOAD_ERR_HW_ERROR;
+	case -ENOSPC:
+		return FW_UPLOAD_ERR_WEAROUT;
+	case -ENOMEM:
+		return FW_UPLOAD_ERR_RW_ERROR;
+	default:
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+}
+
+static enum fw_upload_err tdx_fw_poll_complete(struct fw_upload *fwl)
+{
+	/*
+	 * TDX module updates are completed in the previous phase
+	 * (tdx_fw_write()). If any error occurred, the previous phase
+	 * would return an error code to abort the update process. In
+	 * other words, reaching this point means the update succeeded.
+	 */
+	return FW_UPLOAD_ERR_NONE;
+}
+
+/*
+ * TDX module updates cannot be cancelled. Provide a stub function since
+ * the firmware upload framework requires a .cancel operation.
+ */
+static void tdx_fw_cancel(struct fw_upload *fwl)
+{
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
 static int seamldr_init(struct device *dev)
 {
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+	struct fw_upload *tdx_fwl;
+	int ret;
+
+	if (WARN_ON_ONCE(!tdx_sysinfo))
+		return -EIO;
+
+	if (!tdx_supports_runtime_update(tdx_sysinfo))
+		return 0;
+
+	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
+					   &tdx_fw_ops, NULL);
+	if (IS_ERR(tdx_fwl))
+		return PTR_ERR(tdx_fwl);
+
+	ret = devm_add_action_or_reset(dev, seamldr_deinit, tdx_fwl);
+	if (ret)
+		return ret;
+
 	return devm_device_add_group(dev, &seamldr_group);
 }
 
-- 
2.47.3


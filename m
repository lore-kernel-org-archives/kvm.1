Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106C3E314D;
	Wed, 20 May 2026 13:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284416; cv=none; b=CS4tW9pX47pwOZ87fXP9U8Xl2wQYwxVbWru3ZEHeQ4mHFZ/Jfx3EPvKXIRhSVYz1w0xvtj/CDgPesMdNEGpjzNVFdJ+KDU4mFYg4wO3rgKFQ0hPL1vG8TAQxwQGjfLuQIiBXPKbAhlKSqmrhzHd0hON8hKPt0HXg03XiIz12rJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284416; c=relaxed/simple;
	bh=dA16JSqyzi8Y3F9p4zAe6XahvJgF+2JG7ZGRrhvbrHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1IObv6AAe4y56O7d1mI/+6DfcS/ENdTPsFYjh9dBdBKSjfhOa9H12yMOQ0fziKugt6fZTldshbu+jE2zQidscHxEnvoh7FumJZA0W7OXtZqdb/oliMqy7+9fVxixEzdEHUHrUPMn59TwNh/IKMYQa0A8EUTQ6lWiBLcvVIqW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kS4ZtGjN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kS4ZtGjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284414; x=1810820414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dA16JSqyzi8Y3F9p4zAe6XahvJgF+2JG7ZGRrhvbrHE=;
  b=kS4ZtGjNvj9bjilGtEYsdMLARbjlBec8TrkNobaUO0AcoGVk4e5Bwfji
   rkNhCesGxfWAjGjJipooaI35FDVTIIROZoB+sK71EQ+yDV4ck/eLoT5Ds
   2GOoyM9Opmul1NzUpOff66J+Yso/+0PXv34B8NcKOG1gJX/agyyH1vynZ
   Cc3XYu3F8DerqsTmdynPbgBBbIE2qD4L87e6klHKBESaw3m5mSuYFaLs3
   H1cbCYG846pauVRAksSulE3xpps8BLwriAbe8+TUC+5Qi74conoqXPCSL
   1bRjY40GluSUqH1IGr4+SyA3x0ns7QlyM4uVnW9JE62WzxR2GzRyCRKDb
   w==;
X-CSE-ConnectionGUID: 4O3nxEuqTcKWmuafFY+1eA==
X-CSE-MsgGUID: 3UwKeuuAT6Kj+1RrWAlRZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146451"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146451"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:11 -0700
X-CSE-ConnectionGUID: /XedE3xVQIyHaBC5xRvxgQ==
X-CSE-MsgGUID: opAeuO8DSNyF9CMI0mnf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923775"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:08 -0700
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
Subject: [PATCH v10 07/25] coco/tdx-host: Expose TDX module version
Date: Wed, 20 May 2026 06:38:10 -0700
Message-ID: <20260520133909.409394-8-chao.gao@intel.com>
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

For TDX module updates, userspace needs to select compatible update
versions based on the current module version. This design delegates
module selection complexity to userspace because compatibility must
satisfy constraints from both the CPU and the running TDX module
version.

For example, the 1.5.x series runs on Sapphire Rapids but not Granite
Rapids, which needs 2.0.x. Updates are also constrained by version
distance, so a 1.5.6 module might permit updates to 1.5.7 but not to
1.5.20.

Expose the TDX module version to userspace via sysfs to aid module
selection. Since the TDX faux device will drive module updates, expose
the version as its attribute.

Define TDX_VERSION_FMT macro for the TDX version format since it will be
used multiple times. Also convert an existing print statement to use it.

== Background ==

The "faux device + device attribute" approach compares to other update
mechanisms as follows:

1. AMD SEV leverages an existing PCI device for the PSP to expose
   metadata. TDX uses a faux device as it doesn't have PCI device
   in its architecture.

2. Microcode uses per-CPU virtual devices to report microcode revisions
   because CPUs can have different revisions. But, there is only a
   single TDX module, so exposing the TDX module version through a global
   TDX faux device is appropriate

3. ARM's CCA implementation isn't in-tree yet, but will likely follow a
   similar faux device approach, though it's unclear whether they need
   to expose firmware version information

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]
---
v10:
 - Improve clarity of the changelog and ABI documentation [Dave]
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   |  5 ++++
 arch/x86/include/asm/tdx.h                    |  6 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  2 +-
 drivers/virt/coco/tdx-host/tdx-host.c         | 26 ++++++++++++++++++-
 4 files changed, 37 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-faux-tdx-host

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
new file mode 100644
index 000000000000..47d73cb89f1e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -0,0 +1,5 @@
+What:		/sys/devices/faux/tdx_host/version
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the version of the loaded TDX module.
+		Formatted as "major.minor.update". Used by TDX module
+		update tooling. Example: "1.2.03".
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 8b739ac01479..b7f4396b5cc5 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -41,6 +41,12 @@
 #include <asm/tdx_global_metadata.h>
 #include <linux/pgtable.h>
 
+/*
+ * TDX module and P-SEAMLDR version convention: "major.minor.update"
+ * (e.g., "1.5.08") with zero-padded two-digit update field.
+ */
+#define TDX_VERSION_FMT "%u.%u.%02u"
+
 /*
  * Used by the #VE exception handler to gather the #VE exception
  * info from the TDX module. This is a software only structure
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index c7db393a9cfb..d54d4227990c 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -106,7 +106,7 @@ static __init int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 
 	ret = ret ?: get_tdx_sys_info_version(&sysinfo->version);
 
-	pr_info("Module version: %u.%u.%02u\n",
+	pr_info("Module version: " TDX_VERSION_FMT "\n",
 		sysinfo->version.major_version,
 		sysinfo->version.minor_version,
 		sysinfo->version.update_version);
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index c77885392b09..ef117a836b3a 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -8,6 +8,7 @@
 #include <linux/device/faux.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/tdx.h>
@@ -18,6 +19,29 @@ static const struct x86_cpu_id tdx_host_ids[] = {
 };
 MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
 
+static ssize_t version_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	const struct tdx_sys_info *tdx_sysinfo = tdx_get_sysinfo();
+	const struct tdx_sys_info_version *ver;
+
+	if (!tdx_sysinfo)
+		return -ENXIO;
+
+	ver = &tdx_sysinfo->version;
+
+	return sysfs_emit(buf, TDX_VERSION_FMT "\n", ver->major_version,
+						     ver->minor_version,
+						     ver->update_version);
+}
+static DEVICE_ATTR_RO(version);
+
+static struct attribute *tdx_host_attrs[] = {
+	&dev_attr_version.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(tdx_host);
+
 static struct faux_device *fdev;
 
 static int __init tdx_host_init(void)
@@ -25,7 +49,7 @@ static int __init tdx_host_init(void)
 	if (!x86_match_cpu(tdx_host_ids) || !tdx_get_sysinfo())
 		return -ENODEV;
 
-	fdev = faux_device_create(KBUILD_MODNAME, NULL, NULL);
+	fdev = faux_device_create_with_groups(KBUILD_MODNAME, NULL, NULL, tdx_host_groups);
 	if (!fdev)
 		return -ENODEV;
 
-- 
2.52.0


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0543E3147;
	Tue, 31 Mar 2026 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961009; cv=none; b=u9vNGW+9hJdJ1KdxwA4eThea7ucBEQF4wCqrZpZulbpKLH87wgg++WZOVKgpdzpzRQU4CWeg1n7AtnF/+4eavpyy3X3Jg5pES7I0eAbnWH7Sg6u0ur7U+6cVj2Lv3rZi/vohrMRfMkXc4vOkGu3Hqv1vPCYwxrVjTY3ILXMFtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961009; c=relaxed/simple;
	bh=Vl2jzQCB3DCCcPWs0TySC69ylB3RYT6QTUddnYQbuUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D19Tc+LuV6BHcX9UdXqwsgyi2nqN4ryTmwjfHQYllnxiNsmF617HTuCIooFUYsl+c77Y5vT1vQ8rC+iDFHBuNVGzlTvPKnhRT0v6QnqrceHmiWWYNZiX++41ICGIgTdkRsYEAUbuIW+vTL9Fkr7TIz+ajT89CRnTTT1FVudssYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFsLcyK8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFsLcyK8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961007; x=1806497007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Vl2jzQCB3DCCcPWs0TySC69ylB3RYT6QTUddnYQbuUY=;
  b=RFsLcyK8ZneZTPNvSnDDlsDroWUFfWl9YOOIEJkM78w2vR0H6c/n+Ld8
   JYWfFSiH6p6WOlhmaw7WdHPFw75eboqWvuPW2dolLlv9RLlt37CRBlfqp
   SmvutTE/3yTNyv1O+bqMJIWTZRaohzqY4PdH6x+ZdZdfGjzaBmJZlIpDn
   ZBmXiFAD1lgjcNJz8cuZ8kkmNavQuuO/VFonUDuoae3/BNxSvGx7D4Z9K
   rhe/e/4ad6/bkscqDQlN+w49fyeky/8YR7qHgy9b7QfZDpFQVTJq5gpZC
   dzKmx7Rn9EXIK5ilHec9snKbvpSn82TE6IIZrHzU28zGKaDXCDS4pLDoz
   A==;
X-CSE-ConnectionGUID: nV520lNbS6GOyyb1heiVJw==
X-CSE-MsgGUID: eNGmur3QTFagAdvnBr4UBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084439"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084439"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:21 -0700
X-CSE-ConnectionGUID: vv4Rf3kYQdCis/lr9wLTCA==
X-CSE-MsgGUID: Ly32Tk3QQ8qm/SINOKmXWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492095"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:20 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
Subject: [PATCH v7 03/22] coco/tdx-host: Expose TDX module version
Date: Tue, 31 Mar 2026 05:41:16 -0700
Message-ID: <20260331124214.117808-4-chao.gao@intel.com>
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

For TDX module updates, userspace needs to select compatible update
versions based on the current module version. This design delegates
module selection complexity to userspace because TDX module update
policies are complex and version series are platform-specific.

For example, the 1.5.x series is for certain platform generations, while
the 2.0.x series is intended for others. And TDX module 1.5.x may be
updated to 1.5.y but not to 1.5.y+1.

Expose the TDX module version to userspace via sysfs to aid module
selection. Since the TDX faux device will drive module updates, expose
the version as its attribute.

One bonus of exposing TDX module version via sysfs is: TDX module
version information remains available even after dmesg logs are cleared.

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
Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]
---
v7:
 - use TDX_VERSION_FMT and convert an existing case

v4:
 - collect reviews
 - Explain other version exposure implementations and why tdx's approach differs
   from them
v3:
 - Justify the sysfs ABI choice and expand background on other CoCo
   implementations.
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   |  6 +++++
 arch/x86/include/asm/tdx.h                    |  6 +++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c   |  2 +-
 drivers/virt/coco/tdx-host/tdx-host.c         | 26 ++++++++++++++++++-
 4 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-faux-tdx-host

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
new file mode 100644
index 000000000000..2cf682b65acf
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -0,0 +1,6 @@
+What:		/sys/devices/faux/tdx_host/version
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the version of the loaded TDX module. The TDX module
+		version is formatted as x.y.z, where "x" is the major version,
+		"y" is the minor version and "z" is the update version. Versions
+		are used for bug reporting, TDX module updates etc.
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index cb2219302dfc..85efc17e7660 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -38,6 +38,12 @@
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
index 4c9917a9c2c3..34c050d74b56 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -106,7 +106,7 @@ static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
 
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
2.47.3


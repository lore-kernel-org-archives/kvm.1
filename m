Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2196361DD0;
	Sun, 15 Mar 2026 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583179; cv=none; b=HhCJhvJBxN2TYHwj3n1zJg3blTHV4O6YSAOsJbOyUazph6zTVL1suPdzLdvXnRZuvl/08KJ0TkCL9qnnWAkdX4pWMuNXEERbN+Gj5kpp74Difho/m0nI6N57Xg5GWXW+VB/GHuvNjnCTD7FT24MUKos46na4INbT2x5I+1yaOyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583179; c=relaxed/simple;
	bh=LUE4ocdZr4LezTYGq/PF+tVpCay1hQyAV2KBKDwVKQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=efNNp/3nU/gYTkin1oM0Z2iRBIurwSAgLkXJvMhZo/4rPz00ndh0XRmZNHryFzR8zwOXyvn+E40+ZiK/f3CrGWzcr1YI4lAY8bnhpQ8eSFISbJ3bQ1vLKtqabFLuH1p8j1DlsXNwqnuFC+VyjMdIKJuqC1jHM96UIETzUovHQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ieSalY1u; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ieSalY1u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583177; x=1805119177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LUE4ocdZr4LezTYGq/PF+tVpCay1hQyAV2KBKDwVKQA=;
  b=ieSalY1ujLl7P33zX1qgTEySVbYkfxQYPFgmqfrp7pViRdjVZQ5SHNdw
   zte9mAAtIo8Z/COQj1ylx68PnFj8d8sQge8Nmk5NOnGJwn5IeRSnwkH9G
   2uYkUnbHdicYwIJHG/ZlcB9pbFm/VMQx+8vPo/w0p65zTikaeStiOsamd
   VvRxYj+sOYLEYQm24uc3DfqZorOymaHMDLrUwMGlvPBJ5yvmfh/XdmjYK
   9o6P2x8f4SKpCV8uSJ2YW9LBaT/9yhw8b/vftLts1oerPaJJMO7f4XVK2
   fgR2WDp9DqMqxm10vYYCNTflJfC012ER+80MGDFnEf0JuUlhIMAzQedlv
   Q==;
X-CSE-ConnectionGUID: rtL4KYjxTQWPZf7O1e21lA==
X-CSE-MsgGUID: 8VsAOGhqQxW71DbtbMPwpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732431"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732431"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:36 -0700
X-CSE-ConnectionGUID: JB39p1KuTCeE/bOaZwJNFQ==
X-CSE-MsgGUID: NhfyT3GLTia05UAm6lCY6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123013"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:36 -0700
From: Chao Gao <chao.gao@intel.com>
To: x86@kernel.org,
	linux-coco@lists.linux.dev,
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
	Chao Gao <chao.gao@intel.com>
Subject: [PATCH v5 03/22] coco/tdx-host: Expose TDX module version
Date: Sun, 15 Mar 2026 06:58:23 -0700
Message-ID: <20260315135920.354657-4-chao.gao@intel.com>
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
Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]
---
v4:
 - collect reviews
 - Explain other version exposure implementations and why tdx's approach differs
   from them
v3:
 - Justify the sysfs ABI choice and expand background on other CoCo
   implementations.
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   |  6 +++++
 drivers/virt/coco/tdx-host/tdx-host.c         | 26 ++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)
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
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index c77885392b09..0424933b2560 100644
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
+	return sysfs_emit(buf, "%u.%u.%02u\n", ver->major_version,
+					       ver->minor_version,
+					       ver->update_version);
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


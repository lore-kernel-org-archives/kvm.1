Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06037646C;
	Thu, 26 Mar 2026 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514737; cv=none; b=GvPp1HlScOJ1MFLA5meDrqNHqInhvvE+cuhWDxETuSrJZoYkutQPMngYPMw/p5z/1WEZHJCIEORuovgR97RE4gIQ+b4zfMpfuKo9fEzQbLB5eclFTtHoxjBwKOfQFDYkyL1te+l96RukWsjMbnPZbyQrZrO2LxUWOR5GJkg/xc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514737; c=relaxed/simple;
	bh=VBd8WdSmb2YsqkQkUNmlRwozCWDFWYXpSHN8UfROpDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKbJOMv1xvO0KMyECA2VeqPVsmm5812Zde+eWp00VuLere/2uk0eZV+SBzhJ5R4DfsPfGbVOSd/ujbGYxmWcvs59abADp316krvkUgFzb+fyJNAj3q3bDCJDJ96BqvDsQYsNW+NR51ige349cwBb5rqzgJI3nznE+Vd/yUAY7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+cqe3rM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+cqe3rM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514736; x=1806050736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBd8WdSmb2YsqkQkUNmlRwozCWDFWYXpSHN8UfROpDQ=;
  b=H+cqe3rMrjmjLUTEimtXfNYpY4kj1pBmdgTSb6j7ibwf5G0j9rEhhDOh
   nHCOOiHhJ6LV6KQfMH+FwpDjvxNswPG311rt7VeK3XUAICnBPxl/4boId
   IsUhLLCsiM1WgJHEYiNx31gXsCuMzAe3Ide0K5QvG0VhYcMin9g8N3JoT
   V5Q02FXtS3rQIN7j0Vcis7IVzwUAieiRo3HhHebIT8dF05yt9SBIyufuh
   +Y4yDBFkxm5SRCAGn8gLr6fARWTKqH/3xwuFVIu9Ml+Oj1gshr7ecNVpO
   iaokLu368KmSeDteDMBo5G6VY9JJ+EzU2kSBsYInKwayjnLwa+DhF9ByT
   w==;
X-CSE-ConnectionGUID: ez/apaVxQaarlB2SFjsCbg==
X-CSE-MsgGUID: iQR2oir8QTqHLUayNXLwmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644643"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644643"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:20 -0700
X-CSE-ConnectionGUID: kOFGkcH9T961sPNC96bEpg==
X-CSE-MsgGUID: W8QCBDTmQTKEyYaXtxPb3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967150"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:19 -0700
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
Subject: [PATCH v6 06/22] coco/tdx-host: Expose P-SEAMLDR information via sysfs
Date: Thu, 26 Mar 2026 01:43:57 -0700
Message-ID: <20260326084448.29947-7-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TDX module updates require userspace to select the appropriate module
to load. Expose necessary information to facilitate this decision. Two
values are needed:

- P-SEAMLDR version: for compatibility checks between TDX module and
		     P-SEAMLDR
- num_remaining_updates: indicates how many updates can be performed

Expose them as tdx-host device attributes. Make seamldr attributes
visible only when the update feature is supported, as that's their sole
purpose. Unconditional exposure is also problematic because reading them
triggers P-SEAMLDR calls that break KVM on CPUs with a specific erratum
(to be enumerated and handled in a later patch).

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v6:
 - use TDX_VERSION_FMT macro [Dave]
 - drop revision/chapter numbers [Kiryl/Xiaoyao]
 - use is_visible to control seamldr attribute visibility
   rather than do that manually during device probe. Due
   to this change, drop all RBs.
v5:
 - fix typos [Binbin]
 - register seamldr_group during device probe
v4:
 - Make seamldr attribute permission "0400" [Dave]
 - Don't include implementation details in OS ABI docs [Dave]
 - Tag tdx_host_group as static [Kai]

v3:
 - use #ifdef rather than .is_visible() to control P-SEAMLDR sysfs
   visibility [Yilun]
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   | 22 ++++++
 arch/x86/include/asm/tdx.h                    |  6 ++
 drivers/virt/coco/tdx-host/tdx-host.c         | 76 ++++++++++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index 2cf682b65acf..f7221f2e5fec 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -4,3 +4,25 @@ Description:	(RO) Report the version of the loaded TDX module. The TDX module
 		version is formatted as x.y.z, where "x" is the major version,
 		"y" is the minor version and "z" is the update version. Versions
 		are used for bug reporting, TDX module updates etc.
+
+What:		/sys/devices/faux/tdx_host/seamldr/version
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the version of the loaded SEAM loader. The SEAM
+		loader version is formatted as x.y.z, where "x" is the major
+		version, "y" is the minor version and "z" is the update version.
+		Versions are used for bug reporting and compatibility checks.
+
+What:		/sys/devices/faux/tdx_host/seamldr/num_remaining_updates
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the number of remaining updates. TDX maintains a
+		log about each TDX module that has been loaded. This log has
+		a finite size, which limits the number of TDX module updates
+		that can be performed.
+
+		After each successful update, the number reduces by one. Once it
+		reaches zero, further updates will fail until next reboot. The
+		number is always zero if the P-SEAMLDR doesn't support updates.
+
+		See Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
+		Interface Specification, Chapter "SEAMLDR_INFO" and Chapter
+		"SEAMLDR.INSTALL" for more information.
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index cb2219302dfc..1fb2a3f6b9e1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -103,6 +103,12 @@ int tdx_enable(void);
 const char *tdx_dump_mce_info(struct mce *m);
 const struct tdx_sys_info *tdx_get_sysinfo(void);
 
+static inline bool tdx_supports_runtime_update(const struct tdx_sys_info *sysinfo)
+{
+	/* To be enabled when kernel is ready. */
+	return false;
+}
+
 int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index f9b1168d0900..01f68c390a49 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/seamldr.h>
 #include <asm/tdx.h>
 
 static const struct x86_cpu_id tdx_host_ids[] = {
@@ -46,7 +47,80 @@ static struct attribute *tdx_host_attrs[] = {
 	&dev_attr_version.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(tdx_host);
+
+static const struct attribute_group tdx_host_group = {
+	.attrs = tdx_host_attrs,
+};
+
+static ssize_t seamldr_version_show(struct device *dev, struct device_attribute *attr,
+				    char *buf)
+{
+	struct seamldr_info info;
+	int ret;
+
+	ret = seamldr_get_info(&info);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, TDX_VERSION_FMT"\n", info.major_version,
+						    info.minor_version,
+						    info.update_version);
+}
+
+static ssize_t num_remaining_updates_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct seamldr_info info;
+	int ret;
+
+	ret = seamldr_get_info(&info);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", info.num_remaining_updates);
+}
+
+/*
+ * Open-code DEVICE_ATTR_ADMIN_RO to specify a different 'show' function
+ * for P-SEAMLDR version as version_show() is used for TDX module version.
+ *
+ * Admin-only readable as reading these attributes calls into P-SEAMLDR,
+ * which may have potential performance and system impact.
+ */
+static struct device_attribute dev_attr_seamldr_version =
+	__ATTR(version, 0400, seamldr_version_show, NULL);
+static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
+
+static struct attribute *seamldr_attrs[] = {
+	&dev_attr_seamldr_version.attr,
+	&dev_attr_num_remaining_updates.attr,
+	NULL,
+};
+
+static bool seamldr_group_visible(struct kobject *kobj)
+{
+	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
+
+	if (!sysinfo)
+		return false;
+
+	return tdx_supports_runtime_update(sysinfo);
+}
+
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(seamldr);
+
+static const struct attribute_group seamldr_group = {
+	.name = "seamldr",
+	.attrs = seamldr_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(seamldr),
+};
+
+static const struct attribute_group *tdx_host_groups[] = {
+	&tdx_host_group,
+	&seamldr_group,
+	NULL,
+};
 
 static struct faux_device *fdev;
 
-- 
2.47.3


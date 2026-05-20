Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D512D877B;
	Wed, 20 May 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284420; cv=none; b=J6jYZeVrzHbDwCszDfCAoWglhdrj7L2B74RpMNd5HtiFjXWPSPJMU4ovuLTYivRH4bNRawGJoUDYaTiZ9Cx6Wy/tOjD5+14LE5nu081o+MaAm9Bsshl4KJjyqGe/bKBIlPiM/ciXR8vWgDBmC0TGRPuwpU0mI9/Hcg//Xkkc10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284420; c=relaxed/simple;
	bh=VF7FSnYcGZCTJLXLTw+t3jMigL1zziwUMIDb97mj+ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbuITJB9IxB8x57RBNxm79coD9Dx8+a726uJ1qrSa9eB62I36Tzscezj9yUVnkIbLI3U+YKXs1l3/1i27gKPK2RfQ0Woezuz23rrZGnEJWXJwnDFf6hJP6EczzJCi+3lq5cCnM600w6ikg0mpEv2JFDsH3QiMykWYzlqr+7ZxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LQnZ2bbi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQnZ2bbi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284417; x=1810820417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VF7FSnYcGZCTJLXLTw+t3jMigL1zziwUMIDb97mj+ZU=;
  b=LQnZ2bbiSYZR9tRV/T57+t/8pFdbBziPxw5j9FrXBbyZH8pWxdAvDJ4B
   s834JaclkOLrstiW+k1S6nySVyuAcXm7XPppkehIw4tYYcs0mUGLJAPQk
   b0n1uXfPUvB20O/i0+qiXcXpRChrAiHSammh5tK5Q/V6XoLHEqUdyfoNv
   VJHl2AM2dDH4hD/HjZyaU8kT3ltCVxOxoaZgFJrmriTLVeITti+2yJvul
   Qpzqz5uAMuNY+dAjinr2xeu2oa0ao8atzbAKf21dNZ3CD8a2JOai1mLsl
   k1iWnwtylV9DbhUGgIZQQp/t9u+Exx5FGocDEHZWoosEUGkeVboPX3bx9
   Q==;
X-CSE-ConnectionGUID: ke+oyjPxR7a7M73VpaJwGA==
X-CSE-MsgGUID: NLx6ct8ETw+rXAdqr9739Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146481"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146481"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:14 -0700
X-CSE-ConnectionGUID: Mp4xl6IwRs23kQ8y4NoxsA==
X-CSE-MsgGUID: CcMBLJYsSTqjuS41AQVd9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923826"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:12 -0700
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
Subject: [PATCH v10 10/25] coco/tdx-host: Expose P-SEAMLDR information via sysfs
Date: Wed, 20 May 2026 06:38:13 -0700
Message-ID: <20260520133909.409394-11-chao.gao@intel.com>
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

TDX module updates require userspace to select the appropriate module
to load. Expose necessary information to facilitate this decision. Two
values are needed:

- P-SEAMLDR version: for compatibility checks between TDX module and
		     P-SEAMLDR
- num_remaining_updates: indicates how many updates can be performed

Expose them as tdx-host device attributes. Make seamldr attributes
visible only when the update feature is supported, as that's their sole
purpose.

Note that the underlying P-SEAMLDR attributes are available regardless of
update support; this only restricts their visibility in Linux.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v10:
 - Describe the P-SEAMLDR version by referring to the TDX module
   version instead of copying the text [Dave]
 - add a comment for DEVICE_ATTR_ADMIN_RO() [Dave]
 - Avoid the tertiary operator [Dave]
---
 .../ABI/testing/sysfs-devices-faux-tdx-host   | 21 ++++++
 arch/x86/include/asm/tdx.h                    |  6 ++
 drivers/virt/coco/tdx-host/tdx-host.c         | 72 ++++++++++++++++++-
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
index 47d73cb89f1e..69b4cfc99d87 100644
--- a/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
+++ b/Documentation/ABI/testing/sysfs-devices-faux-tdx-host
@@ -3,3 +3,24 @@ Contact:	linux-coco@lists.linux.dev
 Description:	(RO) Report the version of the loaded TDX module.
 		Formatted as "major.minor.update". Used by TDX module
 		update tooling. Example: "1.2.03".
+
+What:		/sys/devices/faux/tdx_host/seamldr_version
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the version of the loaded P-SEAMLDR.
+		Formatted as a TDX module version. Used by TDX module
+		update tooling.
+
+What:		/sys/devices/faux/tdx_host/num_remaining_updates
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
index b7f4396b5cc5..27376db7ddac 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -110,6 +110,12 @@ void tdx_init(void);
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
index ef117a836b3a..2997311f72fa 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -11,6 +11,7 @@
 #include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
+#include <asm/seamldr.h>
 #include <asm/tdx.h>
 
 static const struct x86_cpu_id tdx_host_ids[] = {
@@ -40,7 +41,76 @@ static struct attribute *tdx_host_attrs[] = {
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
+	return sysfs_emit(buf, TDX_VERSION_FMT "\n", info.major_version,
+						     info.minor_version,
+						     info.update_version);
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
+ * These attributes are intended for managing TDX module updates. Reading
+ * them issues a slow, serialized P-SEAMLDR query, so keep them admin-only.
+ */
+static DEVICE_ATTR_ADMIN_RO(seamldr_version);
+static DEVICE_ATTR_ADMIN_RO(num_remaining_updates);
+
+static struct attribute *seamldr_attrs[] = {
+	&dev_attr_seamldr_version.attr,
+	&dev_attr_num_remaining_updates.attr,
+	NULL,
+};
+
+static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *attr, int idx)
+{
+	const struct tdx_sys_info *sysinfo = tdx_get_sysinfo();
+
+	if (!sysinfo)
+		return 0;
+
+	if (!tdx_supports_runtime_update(sysinfo))
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group seamldr_group = {
+	.attrs = seamldr_attrs,
+	.is_visible = seamldr_group_visible,
+};
+
+static const struct attribute_group *tdx_host_groups[] = {
+	&tdx_host_group,
+	&seamldr_group,
+	NULL,
+};
 
 static struct faux_device *fdev;
 
-- 
2.52.0


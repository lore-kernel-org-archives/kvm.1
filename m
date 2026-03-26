Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED013093BB;
	Thu, 26 Mar 2026 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514733; cv=none; b=NZnSiC6bGz4FejyGvEHLfLdhbYvdntJ6XVY1GOxxQVu30r0CNJoFfgnOET86KKrXtgmRNPBSNYSmRBOrp16L8LpH5N/dzzBwz2sP9YYj8T/MSNum2ljj3iUohkYjhyDXBV1/fgF3akKe7tHZCxFfHUHPBV42ozLdfXKcQZ2CYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514733; c=relaxed/simple;
	bh=XxIgQcAcyMd5H7690pXjhaIqBzApFZIsZ/yE8oe9azU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVquLPVuvL5jxRhGpW6kmYY5xiwxGl+clYVUlfko1KtW+cZu6a2ogndLCX9NFm7xwVc1u5T7HInbAbMOjqs3Tg4RTtxNUYFXO9fV6Q/pZSq4gTSrfkWNxRADh2iU01w+Pnu6Nn1HaqNO1dli9GijtteOU5pcUicEhVfoJONpBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W35HCP/1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W35HCP/1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514730; x=1806050730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxIgQcAcyMd5H7690pXjhaIqBzApFZIsZ/yE8oe9azU=;
  b=W35HCP/1O2fC5rcXSABsDdMyk6de+h/RboTprWTG2totvAgzujfK/+SJ
   1LbxmIIrhvfJ/KKZCU1ZHze6o/IBNAbq3PRjc01Ftyuet8pZYp5PKRceq
   UzonwR9JRMfov7sp/d5LAtS0QSk7euZlYHCQVpd9CLVI7mUoYT6LhRFUk
   wNUJREkbKV5Ib/0VMXH6pRcGNOgBmWHSWxuM01pm+ui70n9r0jNC9yJlG
   lHZkNbhZlAVHPOit5+WQ3jJbgUURtCnxf2/bsmrbo6qvoICidmkiR1PC2
   uqsQv5EtC70rCO/vaIBeErk57cFG1MYJ5aJmMTUi459oP6whAMOIgnVP/
   Q==;
X-CSE-ConnectionGUID: wpdn7ag2T2mSL/TpTk9Wqg==
X-CSE-MsgGUID: eHBAa3cKS/KcSWcsya/EPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644608"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644608"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:19 -0700
X-CSE-ConnectionGUID: IUyU8K3sS0GWyIr6CRRENw==
X-CSE-MsgGUID: aseyin/7Sjmay0lkLRkD0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967108"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:16 -0700
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
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 02/22] coco/tdx-host: Introduce a "tdx_host" device
Date: Thu, 26 Mar 2026 01:43:53 -0700
Message-ID: <20260326084448.29947-3-chao.gao@intel.com>
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

TDX depends on a platform firmware module that is invoked via instructions
similar to vmenter (i.e. enter into a new privileged "root-mode" context to
manage private memory and private device mechanisms). It is a software
construct that depends on the CPU vmxon state to enable invocation of
TDX module ABIs. Unlike other Trusted Execution Environment (TEE) platform
implementations that employ a firmware module running on a PCI device with
an MMIO mailbox for communication, TDX has no hardware device to point to
as the TEE Secure Manager (TSM).

Create a virtual device not only to align with other implementations but
also to make it easier to

 - expose metadata (e.g., TDX module version, seamldr version etc) to
   the userspace as device attributes

 - implement firmware uploader APIs which are tied to a device. This is
   needed to support TDX module runtime updates

 - enable TDX Connect which will share a common infrastructure with other
   platform implementations. In the TDX Connect context, every
   architecture has a TSM, represented by a PCIe or virtual device. The
   new "tdx_host" device will serve the TSM role.

A faux device is used for TDX because the TDX module is singular within
the system and lacks associated platform resources. Using a faux device
eliminates the need to create a stub bus.

The call to tdx_get_sysinfo() ensures that the TDX module is ready to
provide services.

Note that AMD has a PCI device for the PSP for SEV and ARM CCA will
likely have a faux device [1].

Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/all/2025073035-bulginess-rematch-b92e@gregkh/ # [1]
---
v3:
 - add Jonathan's reviewed-by
 - add tdx_get_sysinfo() in module_init() to ensure the TDX module is up
   and running.
 - note in the changelog that both AMD and ARM have devices for coco
---
 arch/x86/virt/vmx/tdx/tdx.c           |  2 +-
 drivers/virt/coco/Kconfig             |  2 ++
 drivers/virt/coco/Makefile            |  1 +
 drivers/virt/coco/tdx-host/Kconfig    | 10 +++++++
 drivers/virt/coco/tdx-host/Makefile   |  1 +
 drivers/virt/coco/tdx-host/tdx-host.c | 43 +++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virt/coco/tdx-host/Kconfig
 create mode 100644 drivers/virt/coco/tdx-host/Makefile
 create mode 100644 drivers/virt/coco/tdx-host/tdx-host.c

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 06d9709ade85..172f6d4133b5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1435,7 +1435,7 @@ const struct tdx_sys_info *tdx_get_sysinfo(void)
 
 	return p;
 }
-EXPORT_SYMBOL_FOR_KVM(tdx_get_sysinfo);
+EXPORT_SYMBOL_FOR_MODULES(tdx_get_sysinfo, "kvm-intel,tdx-host");
 
 u32 tdx_get_nr_guest_keyids(void)
 {
diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
index df1cfaf26c65..f7691f64fbe3 100644
--- a/drivers/virt/coco/Kconfig
+++ b/drivers/virt/coco/Kconfig
@@ -17,5 +17,7 @@ source "drivers/virt/coco/arm-cca-guest/Kconfig"
 source "drivers/virt/coco/guest/Kconfig"
 endif
 
+source "drivers/virt/coco/tdx-host/Kconfig"
+
 config TSM
 	bool
diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
index cb52021912b3..b323b0ae4f82 100644
--- a/drivers/virt/coco/Makefile
+++ b/drivers/virt/coco/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
 obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
 obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
+obj-$(CONFIG_INTEL_TDX_HOST)	+= tdx-host/
 obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
 obj-$(CONFIG_TSM) 		+= tsm-core.o
 obj-$(CONFIG_TSM_GUEST)		+= guest/
diff --git a/drivers/virt/coco/tdx-host/Kconfig b/drivers/virt/coco/tdx-host/Kconfig
new file mode 100644
index 000000000000..d35d85ef91c0
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/Kconfig
@@ -0,0 +1,10 @@
+config TDX_HOST_SERVICES
+	tristate "TDX Host Services Driver"
+	depends on INTEL_TDX_HOST
+	default m
+	help
+	  Enable access to TDX host services like module update and
+	  extensions (e.g. TDX Connect).
+
+	  Say y or m if enabling support for confidential virtual machine
+	  support (CONFIG_INTEL_TDX_HOST). The module is called tdx_host.ko.
diff --git a/drivers/virt/coco/tdx-host/Makefile b/drivers/virt/coco/tdx-host/Makefile
new file mode 100644
index 000000000000..e61e749a8dff
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_TDX_HOST_SERVICES) += tdx-host.o
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
new file mode 100644
index 000000000000..c77885392b09
--- /dev/null
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX host user interface driver
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+
+#include <linux/device/faux.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/tdx.h>
+
+static const struct x86_cpu_id tdx_host_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
+
+static struct faux_device *fdev;
+
+static int __init tdx_host_init(void)
+{
+	if (!x86_match_cpu(tdx_host_ids) || !tdx_get_sysinfo())
+		return -ENODEV;
+
+	fdev = faux_device_create(KBUILD_MODNAME, NULL, NULL);
+	if (!fdev)
+		return -ENODEV;
+
+	return 0;
+}
+module_init(tdx_host_init);
+
+static void __exit tdx_host_exit(void)
+{
+	faux_device_destroy(fdev);
+}
+module_exit(tdx_host_exit);
+
+MODULE_DESCRIPTION("TDX Host Services");
+MODULE_LICENSE("GPL");
-- 
2.47.3


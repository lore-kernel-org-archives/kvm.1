Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F03822B1
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480258; cv=none; b=OZpd7nM51iFfBuN7lUQsu4nDLn+Un8ltR1eFUHL16iQtjorpC9rTA23439IEekJ/uUNs9r4oev3vHxcJlQPNz0vIRypz5p5SiYbHR8tB9sFPN2Skwpz3YliGEhkAnvPTukoYkXShOT6IPyOBD0623CH18hkOrdRH6iS8VuEA/qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480258; c=relaxed/simple;
	bh=bFjcw61o1QaDZFM6KCaRMSYJbnwJZBt2FcOXVAXbetE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlAir+q7kNA62P8v9muZGbW+lxuCO8zY6hRteOFkm7gRkpF9iDtSB79zw1V/2KLwxYYWI3nE3x3e/ohZPrQCsItnNym4IZWzomjNuwQ2NL/7HgfgEDILKBiyFnqLYX7wTseEfScqYvysWlRQpVIm5djgN9M1MTnuPuDEwivtdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StNh0+0a; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StNh0+0a"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0b35fa876so31027295ad.1
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480255; x=1782085055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2zD42MEIyPzhlie6kyqIqTWjNLWf40NMmxrY2LE4+4=;
        b=StNh0+0as59l6JTV749kXHOvNrFTySYmCYOxARkv8vRg0jC0g4jjuP3cESOlJUFA6d
         im7dp5v0J7TpIdYd8hy7x7yQH2EobDFXNr5W9i75UqR1j/khx0mkKhx+Z0fHhjCedrum
         Xnx2sANtN4fxa8fDcqkmjQh28R1KJrkzMMTVumcFCt6v6oOCEugSzRM5AcEF+33Kwptu
         mLCbvlExDPxixf26lKD+O81RIIbbqYMHPado6nHnvCjI+L54dZM+4r37OWu+RqOq6LPj
         DDd+qejPo/uPpAUdck2YPVvYrFEBFOM1WRagFkq863gzIB4V+h4idTsGKjGuVFfqymgi
         UFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480255; x=1782085055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2zD42MEIyPzhlie6kyqIqTWjNLWf40NMmxrY2LE4+4=;
        b=YAYBwDUqh1w8eylggOYtkW5QRaU1HGYtW9lbzTqCr5L94Z3Lp2hl1tKz3zmFE2HHiE
         PlSlOqxLzTbby3FqyoF4dW/YLF2DnS3PFJ/iRK6F/4fmWWTI/205NVp67Lfqj5DHKyDR
         +a3ah7szFGzPtVYgKAJVBtRo+JS2VaOupcB8X95Ow8DyHTD46Vycsg5uq01kdde4mv2U
         TWxXCCxq0QYvAf5nso5AYsS6mKDMf82UyOjsw0j0yF6maz3WXZMIFQPD3/EHc8DiK9lC
         dTdhTDgtXCY4AzM1AatTP/oNZ5aqN3msCFKtLs3U0F8zkAa99v93TTjMEDRfjKfT1kQ8
         K8xA==
X-Forwarded-Encrypted: i=1; AFNElJ8wYt5IU0g0QLTt6XhfkxSt+vnt1OzHeX6YwrGyi7Fsd3ydAW0Q0iZdz05mfMdxZlYewuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+l3YWJutUZU5PKfqPn/tCPnltg7uUXzMr2k8hlj7/Z25x+sZ
	2yJYeurrYaBwsOGsfeLcQ259nNFm/yXZw5FtsH28EwJ+uyScWkhvz+6ns8MeHSCJLjPGKCkkGIF
	6+ttgM5nTZO/XeQ==
X-Received: from plzv4.prod.google.com ([2002:a17:902:b7c4:b0:2bd:40d4:e407])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:198b:b0:2c0:a3dd:4e76 with SMTP id d9443c01a7336-2c4137e55f0mr125796005ad.28.1781480255149;
 Sun, 14 Jun 2026 16:37:35 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:17 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-8-skhawaja@google.com>
Subject: [PATCH v3 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add implementation of the device and iommu presevation in a separate
file. Also set the device and iommu preserve/unpreserve ops in the
struct iommu_ops.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 MAINTAINERS                      |   8 ++
 drivers/iommu/intel/Makefile     |   1 +
 drivers/iommu/intel/iommu.c      |   8 +-
 drivers/iommu/intel/iommu.h      |  28 +++++
 drivers/iommu/intel/liveupdate.c | 175 +++++++++++++++++++++++++++++++
 include/linux/kho/abi/iommu.h    |  21 ++++
 6 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/intel/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cef90bb50781..4dfb56962426 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13002,6 +13002,14 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	drivers/iommu/intel/
 
+INTEL IOMMU LIVEUPDATE (VT-d)
+M:	Samiullah Khawaja <skhawaja@google.com>
+M:	Lu Baolu <baolu.lu@linux.intel.com>
+L:	iommu@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
+F:	drivers/iommu/intel/liveupdate.c
+
 INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ada651c4a01b..d38fc101bc35 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
 obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
+obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c3d18cd77d2f..715b538e7efe 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
 #include <linux/dmi.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
@@ -60,8 +61,6 @@ static int force_on = 0;
 static int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
-#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-
 /*
  * Take a root_entry and return the Lower Context Table Pointer (LCTP)
  * if marked present.
@@ -3926,6 +3925,11 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.page_response		= intel_iommu_page_response,
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve_device	= intel_iommu_preserve_device,
+	.preserve		= intel_iommu_preserve,
+	.unpreserve		= intel_iommu_unpreserve,
+#endif
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ef145560aa98..5e0bc17e76bf 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -552,6 +552,8 @@ struct root_entry {
 	u64     hi;
 };
 
+#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
+
 /*
  * low 64 bits:
  * 0: present
@@ -1284,6 +1286,32 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
 	return 0;
 }
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser);
+int intel_iommu_preserve(struct iommu_device *iommu,
+			 struct iommu_hw_ser *iommu_ser);
+void intel_iommu_unpreserve(struct iommu_device *iommu,
+			    struct iommu_hw_ser *iommu_ser);
+#else
+static inline int intel_iommu_preserve_device(struct device *dev,
+					      struct iommu_device_ser *device_ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int intel_iommu_preserve(struct iommu_device *iommu,
+				       struct iommu_hw_ser *iommu_ser)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
+					  struct iommu_hw_ser *iommu_ser)
+{
+}
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
new file mode 100644
index 000000000000..b5613e4ad43a
--- /dev/null
+++ b/drivers/iommu/intel/liveupdate.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#define pr_fmt(fmt)    "DMAR: liveupdate: " fmt
+
+#include <linux/kexec_handover.h>
+#include <linux/liveupdate.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+
+/* 2 tables per bus in scalable mode with upper table at odd bit */
+#define CONTEXT_TABLE_PRESERVED_BIT(bus, devfn) ((bus << 1) + (devfn >> 7))
+static bool is_context_table_preserved(struct intel_iommu *iommu,
+				       struct iommu_hw_ser *ser,
+				       u8 bus, u8 devfn)
+{
+	return test_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
+}
+
+static void unpreserve_context_table(struct intel_iommu *iommu,
+				     struct iommu_hw_ser *ser,
+				     u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	spin_unlock(&iommu->lock);
+	if (context && is_context_table_preserved(iommu, ser, bus, devfn)) {
+		iommu_unpreserve_pages(context);
+		clear_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			  (unsigned long *)&ser->intel.context_tables_bitmap[0]);
+	}
+}
+
+static int preserve_context_table(struct intel_iommu *iommu,
+				  struct iommu_hw_ser *ser,
+				  u8 bus, u8 devfn)
+{
+	struct context_entry *context;
+	int ret;
+
+	spin_lock(&iommu->lock);
+	context = iommu_context_addr(iommu, bus, devfn, 0);
+	spin_unlock(&iommu->lock);
+	if (context && !is_context_table_preserved(iommu, ser, bus, devfn)) {
+		ret = iommu_preserve_pages(context);
+		if (ret)
+			return ret;
+
+		set_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
+			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
+	}
+
+	return 0;
+}
+
+static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
+					    struct iommu_hw_ser *ser)
+{
+	int i;
+
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		unpreserve_context_table(iommu, ser, i, 0);
+
+		if (!sm_supported(iommu))
+			continue;
+
+		unpreserve_context_table(iommu, ser, i, 0x80);
+	}
+}
+
+static int preserve_iommu_context_tables(struct device_domain_info *info)
+{
+	struct iommu_hw_ser *iommu_ser;
+	struct intel_iommu *iommu;
+	int ret;
+	int i;
+
+	/* IOMMU for this device should already preserved.*/
+	iommu = info->iommu;
+	iommu_ser = iommu_preserved_state(&iommu->iommu);
+	if (!iommu_ser)
+		return -EINVAL;
+
+	/*
+	 * We could do preservation of context tables only for the bus of this
+	 * device, but these devices can have PCI aliases, so context tables for
+	 * those will also require preservation. Also unpreserve would require
+	 * some kind of refcounting where the context table will only be
+	 * unpreserved when the last device associated with it is unpreserved.
+	 *
+	 * This introduces unnecessary complication with minimum benefits as the
+	 * unpreserved context tables will probably be recreated by the next
+	 * kernel as these are all active devices. We follow simpler approach by
+	 * just preserving the currently active context tables.
+	 */
+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
+		ret = preserve_context_table(iommu, iommu_ser, i, 0);
+		if (ret)
+			return ret;
+
+		if (!sm_supported(iommu))
+			continue;
+
+		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int intel_iommu_preserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	int ret;
+
+	if (!dev_is_pci(dev)) {
+		dev_err(dev, "Cannot preserve non-PCI device\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!info || !info->domain)
+		return -EINVAL;
+
+	ret = preserve_iommu_context_tables(info);
+	if (ret)
+		return ret;
+
+	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
+								     info->iommu);
+	return 0;
+}
+
+int intel_iommu_preserve(struct iommu_device *iommu_dev,
+			 struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+	int ret;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	ret = iommu_preserve_pages(iommu->root_entry);
+	if (ret)
+		return ret;
+
+	ser->intel.phys_addr = iommu->reg_phys;
+	ser->intel.root_table = __pa(iommu->root_entry);
+	ser->type = IOMMU_INTEL;
+	ser->token = ser->intel.phys_addr;
+
+	return 0;
+}
+
+void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
+			    struct iommu_hw_ser *ser)
+{
+	struct intel_iommu *iommu;
+
+	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
+
+	unpreserve_iommu_context_tables(iommu, ser);
+	iommu_unpreserve_pages(iommu->root_entry);
+}
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index d06f251a2df4..ad760c497e13 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -80,6 +80,7 @@
  */
 enum iommu_type_ser {
 	IOMMU_INVALID,
+	IOMMU_INTEL,
 };
 
 #define IOMMU_SER_FLAG_DELETED	(1 << 0)
@@ -140,16 +141,36 @@ struct iommu_device_ser {
 	struct iommu_dev_map_ser domain_iommu_ser;
 } __packed;
 
+/**
+ * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
+ * @restored: Whether IOMMU state is restored
+ * @phys_addr: Physical address of the IOMMU register base
+ * @root_table: Physical address of the root entry table
+ * @context_tables_bitmap: Bitmap representing the context tables that are
+ * preserved.
+ */
+struct iommu_intel_ser {
+	u8 restored;
+	u8 padding[7];
+	u64 phys_addr;
+	u64 root_table;
+	u64 context_tables_bitmap[8]; /* Tracks upto 512 context tables */
+};
+
 /**
  * struct iommu_hw_ser - Serialized state of an IOMMU instance
  * @hdr: Common object header
  * @token: Unique token for the IOMMU
  * @type: IOMMU type serialized state belongs to
+ * @intel: Intel specific serialization data
  */
 struct iommu_hw_ser {
 	struct iommu_hdr_ser hdr;
 	u64 token;
 	u64 type;
+	union {
+		struct iommu_intel_ser intel;
+	};
 } __packed;
 
 /**
-- 
2.54.0.1136.gdb2ca164c4-goog


Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B364356759
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156059; cv=none; b=a1ZnQPsGjG3+pc8o6tqeKZq4qUMfxOO4Z7LV/ERxq69GXF1SJEJoB6896akJ10pJYAbfUtEdfkCYhuxU+i79vTySu3l9RDmnRhiA/YksSUyXXJHaLTcSf/7y5x2BOj4mkHleXYIMd3St3vAfR8vph/tCYqdbm0Qydx1fCxXpwTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156059; c=relaxed/simple;
	bh=f3foMOWQBD0GGxP1v4PM/nkwVIDqxoGFeY4kjpNBJ2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nyw/314xvtkO4Jj0/xl+COKPM/f82UVpXTrCGjKh92zUZqUIQdz9MvGfdUOXoxCf1N6Q20iaxtaBvjGYtNXxrf7iuMfDpuTOzrgY0SIv4S2THyEmgfidcOn0zXfg8w4hI7H6kscZjjkuXgn06yTrqjUHUGHhKtSQSFA6rO4SMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2IvEAoN; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2IvEAoN"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38fa7b09921so273845a91.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156055; x=1786760855; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=27BFLg3oEuOAZuPc7hu/IE7RvyGzQK/B1iWoWZdEL9s=;
        b=o2IvEAoNTQpSHG2LOx396DO3GXyInYtwAOPzryxodwsgEr59a7mEmalr4UzDSWLbXu
         U0rGHa1rf3BH665ptZrjUskeRKcLKKEDyOGem1nuLxMW5Fg9W1Lz68ZIMcCnXJf3lnpq
         jesqH+0AhOuAr3ilkrTjxZ55Je4WGlyBXPbEiNVKEVpCiJSoQ4R7HCPCNyN9W1wkGDST
         /YdMG+cJfbaDMOOhGXV1Bv84/ovyH6pAcgKfalv2ldfxZ1hSd/EjcsGiaJig2kRp7De4
         EnZ66DtmM+ZABw5atUiRhRoBI76Rt53ioXVJwZ8bKRBpvPJOMS6Ql5XEhNjitnYlFJy/
         6EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156055; x=1786760855;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=27BFLg3oEuOAZuPc7hu/IE7RvyGzQK/B1iWoWZdEL9s=;
        b=GkH9qTfdAyofs8ez3p16q67dGvBwPH/IY7RTSoMMmA94eaHaEywUIYtjtjE7jJubPV
         eN9r02ozbajaaqMXgxnl9MJL/4ozmMEp6D/QhoBujOidWqUz2+Hl/opiTgDCTeUeI34+
         yXaBo38pce0i/MV5IQnSklXQ3rFsbV9gaAYdTDVrRegkjyIrgcJ+Hmdqqsu1dMdiSckc
         gz6UbOcSlSySjcNOMg9g0mvvInpn9m7YxJcrVe5WGVND9pDNSD38mD4WbQDF/V8fRUOc
         N3SRviRNn5FxoXzSFamb4HPEWpg4FeyucU9uiD8cLvqpPWE2yBzkuXfnOaXdRRCUab08
         yyNw==
X-Forwarded-Encrypted: i=1; AHgh+RoIH0vcafDVDOL6GurTGqyxuGERh1yo9YMjQr8ptdl8KA0Zh01GeK4qrO7SsMiwOCRK1qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPOnxspsfN5wAgDGtawYRJ9ZukV5pGs1SuskD386vdvbVWCp4
	g2CucXyx7hNu/Kx8tnHH5POqyD0tv+Cp99PyBfo0dUCdpjXiE88TuOVowbQuXT/Z58CF5Rv/E6A
	rp49U+utIAvrNNw==
X-Received: from pjblj19.prod.google.com ([2002:a17:90b:3453:b0:384:caf7:a184])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f91:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-3903c542f55mr22542006a91.1.1786156054949;
 Fri, 07 Aug 2026 19:27:34 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:18 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-14-skhawaja@google.com>
Subject: [PATCH v4 13/18] iommu/vt-d: Preserve PASID table of preserved device
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

In scalable mode the PASID table is used to fetch the io page tables.
Preserve and restore the PASID table of the preserved devices.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/liveupdate.c | 130 +++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.c      |  10 ++-
 drivers/iommu/intel/pasid.h      |   8 ++
 include/linux/kho/abi/iommu.h    |  13 ++++
 4 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
index 05dea3893399..b324697aac92 100644
--- a/drivers/iommu/intel/liveupdate.c
+++ b/drivers/iommu/intel/liveupdate.c
@@ -15,6 +15,7 @@
 #include <linux/pci-ats.h>
 
 #include "iommu.h"
+#include "pasid.h"
 #include "../iommu-pages.h"
 
 /* 2 tables per bus in scalable mode with upper table at odd bit */
@@ -462,6 +463,69 @@ int intel_iommu_restore_device(struct iommu_domain *domain,
 	return ret;
 }
 
+enum pasid_lu_op {
+	PASID_LU_OP_PRESERVE = 1,
+	PASID_LU_OP_UNPRESERVE,
+	PASID_LU_OP_RESTORE,
+};
+
+static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
+{
+	int ret = 0;
+
+	switch (op) {
+	case PASID_LU_OP_PRESERVE:
+		ret = iommu_preserve_pages(table);
+		break;
+	case PASID_LU_OP_UNPRESERVE:
+		iommu_unpreserve_pages(table);
+		break;
+	case PASID_LU_OP_RESTORE:
+		iommu_restore_pages(virt_to_phys(table));
+		break;
+	}
+
+	return ret;
+}
+
+static int pasid_lu_handle_pd(struct pasid_dir_entry *dir,
+			      u32 max_pasid, enum pasid_lu_op op)
+{
+	int max_pde = max_pasid >> PASID_PDE_SHIFT;
+	struct pasid_entry *table;
+	int i, ret;
+
+	for (i = 0; i < max_pde; i++) {
+		table = get_pasid_table_from_pde(&dir[i]);
+		if (!table)
+			continue;
+
+		ret = pasid_lu_do_op(table, op);
+		if (ret)
+			goto err;
+	}
+
+	ret = pasid_lu_do_op(dir, op);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	if (op != PASID_LU_OP_PRESERVE)
+		return ret;
+
+	while (i > 0) {
+		table = get_pasid_table_from_pde(&dir[--i]);
+		if (!table)
+			continue;
+
+		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
+	}
+
+	return ret;
+}
+
 /**
  * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
  * @dev: Target device
@@ -473,6 +537,7 @@ int intel_iommu_preserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
 	int ret;
 
 	if (!dev_is_pci(dev)) {
@@ -492,6 +557,22 @@ int intel_iommu_preserve_device(struct device *dev,
 
 	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
 								     info->iommu);
+
+	if (!sm_supported(info->iommu))
+		return 0;
+
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return -EINVAL;
+
+	ret = pasid_lu_handle_pd(pasid_table->table,
+				 pasid_table->max_pasid,
+				 PASID_LU_OP_PRESERVE);
+	if (ret)
+		return ret;
+
+	device_ser->intel.pasid_table = virt_to_phys(pasid_table->table);
+	device_ser->intel.max_pasid = pasid_table->max_pasid;
 	return 0;
 }
 
@@ -503,6 +584,28 @@ int intel_iommu_preserve_device(struct device *dev,
 void intel_iommu_unpreserve_device(struct device *dev,
 				   struct iommu_device_ser *device_ser)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct pasid_table *pasid_table;
+
+	if (!dev_is_pci(dev))
+		return;
+
+	if (!info)
+		return;
+
+	if (!sm_supported(info->iommu))
+		return;
+
+	if (!device_ser->intel.pasid_table)
+		return;
+
+	pasid_table = intel_pasid_get_table(dev);
+	if (!pasid_table)
+		return;
+
+	pasid_lu_handle_pd(pasid_table->table,
+			   pasid_table->max_pasid,
+			   PASID_LU_OP_UNPRESERVE);
 }
 
 /**
@@ -547,3 +650,30 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
 	unpreserve_iommu_context_tables(iommu, ser);
 	iommu_unpreserve_pages(iommu->root_entry);
 }
+
+/**
+ * intel_pasid_restore_table() - Restore preserved PASID table for a device
+ * @dev: Restored device
+ * @max_pasid: Maximum supported PASID
+ *
+ * Return: Pointer to restored PASID table directory, or NULL if not preserved.
+ */
+void *intel_pasid_restore_table(struct device *dev, u64 max_pasid)
+{
+	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
+
+	if (!ser || !ser->intel.pasid_table)
+		return NULL;
+
+	/*
+	 * MAX PASID of a device should not change as it is read from
+	 * capabilities.
+	 */
+	BUG_ON(ser->intel.max_pasid != max_pasid);
+
+	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
+				  ser->intel.max_pasid,
+				  PASID_LU_OP_RESTORE));
+
+	return phys_to_virt(ser->intel.pasid_table);
+}
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 81353fd46b37..ae09d47ca8a6 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -13,6 +13,7 @@
 #include <linux/cpufeature.h>
 #include <linux/dmar.h>
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/memory.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
@@ -60,8 +61,13 @@ int intel_pasid_alloc_table(struct device *dev)
 
 	size = max_pasid >> (PASID_PDE_SHIFT - 3);
 	order = size ? get_order(size) : 0;
-	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
-					1 << (order + PAGE_SHIFT));
+
+	max_pasid = 1 << (order + PAGE_SHIFT + 3);
+	if (dev_iommu_restored_state(dev))
+		dir = intel_pasid_restore_table(dev, max_pasid);
+	else
+		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
+						1 << (order + PAGE_SHIFT));
 	if (!dir) {
 		kfree(pasid_table);
 		return -ENOMEM;
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 48d3bb6b68de..801768cdea16 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -301,6 +301,14 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
 
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+void *intel_pasid_restore_table(struct device *dev, u64 max_pasid);
+#else
+static inline void *intel_pasid_restore_table(struct device *dev, u64 max_pasid)
+{
+	return NULL;
+}
+#endif
 void intel_pasid_free_table(struct device *dev);
 struct pasid_table *intel_pasid_get_table(struct device *dev);
 int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 430c42bf9561..f87a92ff6a38 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -129,6 +129,16 @@ struct iommu_dev_map_ser {
 	u64 iommu_phys;
 } __packed;
 
+/**
+ * struct iommu_device_intel_ser - Intel specific state of serialized device
+ * @pasid_table: Physical address of pasid table
+ * @max_pasid: Maximum supported pasid
+ */
+struct iommu_device_intel_ser {
+	u64 pasid_table;
+	u64 max_pasid;
+} __packed;
+
 /**
  * struct iommu_device_ser - Serialized state of a device
  * @hdr: Common object header
@@ -141,6 +151,9 @@ struct iommu_device_ser {
 	u32 devid;
 	u32 pci_domain_nr;
 	struct iommu_dev_map_ser domain_iommu_ser;
+	union {
+		struct iommu_device_intel_ser intel;
+	};
 } __packed;
 
 
-- 
2.55.0.679.g6767b8d81c-goog


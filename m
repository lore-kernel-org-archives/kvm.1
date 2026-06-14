Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C69390987
	for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781480266; cv=none; b=CM0GmwM7tLWdXHW7krL3mMBzpsbanfDk6eRT80cO0ua7UEItZKFT6AQjr6jc4WFVPp2ds4V7lfUdYN14JxszOIX+eGtTalzYZjT2I5fskxgEsdagS1ZHCmBQF+7W9tSUsb7JoNIb50MMZFCEUh5Aa2klBgAMbPQvXrHIZ6MIXDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781480266; c=relaxed/simple;
	bh=sHmdBPgUy64h0nomxRMYZgtzGsV7LcN1Y2jthOewPfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fNIBNu4f/Jvq1Y/f0Bor3RhYMYxO+yGhgpSBjxXvKP2AZl956OiFPU3+tLCKEgdODKJ1w1j8BIo+YM/q7DTc9OO7kQx/C9YT1x6Be5cvBjkkMKFOSZMmzg60JVVWQnovTqu8t7ccBfdk5OfVSdc9tqmTrJ5NGFwUG8rT3cjbITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=atCqeRik; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="atCqeRik"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f1fe39eso3412457b3a.1
        for <kvm@vger.kernel.org>; Sun, 14 Jun 2026 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781480264; x=1782085064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4W8djzLKUJavR0ZWbxIExIzqg4vveKv4bLWIrwQxGcQ=;
        b=atCqeRikhx7DpDmvH+++xBrAOcokvPNwFdv2ujGoJfKJ2ClYwTm+af1Gg6sxwSOD/R
         z61vPz8nh++iCrNZQ1em5UFKB2OUtYhkfOGAAw8EeAW3co35FdHvDqUDRpVTdCzQHa8+
         kavO75ccqXvEYVHm/gBmE3tM8NyZpgJ58Zdf8v3kU/NRVK19bfK1K1VqHmfplXioDUwX
         Eg+Vn6cV+Lz9AHfY6p/XulrfZzgGXhElxMusF2vwiSNn+mYREOojzfo/ymYl+Oshy6C1
         lV4PIDi+eEfmtlHSj+ZagnSMC4ZYN5t9b/FvtXqxjF7YeG+p/rZsq2QraPSE3yfu/zx4
         UXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781480264; x=1782085064;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4W8djzLKUJavR0ZWbxIExIzqg4vveKv4bLWIrwQxGcQ=;
        b=ezaNY1tI1eJ38urVQTL32vvgOVpLrYLfMm1h6FOoQtLmawvMCIs9lqK1fqZ6f4v9sD
         2X5P8QrqZ1vBjPeZq8MxwbHaaEmfyNTd8LfAJuNwMLutMDq1IWRf52c9F8bI2bRjkrXM
         0uuU14L03xApL3NwbzGp63rFKokK5qhfOL1f58sXgCPbwW50BmWzlJy10jF/hxFMVR1i
         BtUCqKWcTx7phIvl09pl+s9B8yTaNq5aR1jrhvNd+OptXgK5OtSb9GBPaCaIzk/VQnk0
         xRJO3wrczBXxo+qiXZggCqsud4B6KPojCFZPxi8ZkAR/SBv3VxwV7WIHGFsUMK+26eka
         FWAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5eKzRtq56HKsVQRCzl+dZyL++KKhbpgXq/TUj/QOscTh2O5kkDrvVKt3a5r1BJkG9bnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7YdcLp31s+r21QtNREpotqpHBkDf8gFO8kw4hIy4WgsGI4zYe
	jLDMH3awKGOvy+VzAXitqsOPOUg+/OKwgZm+gwBPUXWFhhblOPtVHDNuoAqpjwkzTm+yKuFa+1c
	cBOMG3eiSZzcKiA==
X-Received: from pfbfm11.prod.google.com ([2002:a05:6a00:2f8b:b0:83e:b5cc:11c3])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d17:b0:842:6004:3fce with SMTP id d2e1a72fcca58-8434cdeeedbmr12308751b3a.26.1781480263617;
 Sun, 14 Jun 2026 16:37:43 -0700 (PDT)
Date: Sun, 14 Jun 2026 23:37:27 +0000
In-Reply-To: <20260614233728.2212104-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260614233728.2212104-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260614233728.2212104-18-skhawaja@google.com>
Subject: [PATCH v3 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
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

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/device_cdev.c             | 10 +++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 37 +++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 0050f0fe456b..844f1473d875 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -275,6 +275,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
 	}
 
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
 		ret = device->ops->pasid_attach_ioas(device,
 						     attach.pasid,
@@ -333,6 +338,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
 	}
 
 	mutex_lock(&device->dev_set->lock);
+	if (iommufd_device_is_preserved(device->iommufd_device)) {
+		mutex_unlock(&device->dev_set->lock);
+		return -EBUSY;
+	}
+
 	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
 		device->ops->pasid_detach_ioas(device, detach.pasid);
 	else
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 7b841a1e7fcc..37d327f82d5a 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -106,6 +106,7 @@
 
 #include <linux/errno.h>
 #include <linux/file.h>
+#include <linux/iommufd.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -114,6 +115,8 @@
 
 #include "vfio_pci_priv.h"
 
+MODULE_IMPORT_NS("IOMMUFD");
+
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
@@ -155,9 +158,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	/* If iommufd is attached, preserve the underlying domain */
+	mutex_lock(&device->dev_set->lock);
+	if (device->iommufd_attached) {
+		u64 token, preserved_state;
+
+		ret = iommufd_device_preserve(args->session,
+					      device->iommufd_device,
+					      &token, &preserved_state);
+		if (ret) {
+			mutex_unlock(&device->dev_set->lock);
+			return ret;
+		}
+	}
+	mutex_unlock(&device->dev_set->lock);
+#endif
+
 	ret = pci_liveupdate_preserve(pdev);
 	if (ret)
-		return ret;
+		goto err_iommufd_unpreserve;
 
 	ser = kho_alloc_preserve(sizeof(*ser));
 	if (IS_ERR(ser)) {
@@ -173,12 +193,27 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 err_unpreserve:
 	pci_liveupdate_unpreserve(pdev);
+
+err_iommufd_unpreserve:
+	mutex_lock(&device->dev_set->lock);
+	if (device->iommufd_attached)
+		iommufd_device_unpreserve(args->session,
+					  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
 	return ret;
 }
 
 static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_device *device = vfio_device_from_file(args->file);
+	struct vfio_pci_core_device_ser *ser;
+
+	ser = phys_to_virt(args->serialized_data);
+	mutex_lock(&device->dev_set->lock);
+	if (device->iommufd_attached)
+		iommufd_device_unpreserve(args->session,
+					  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
 
 	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
-- 
2.54.0.1136.gdb2ca164c4-goog


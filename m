Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EDF3EF0AC
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312628; cv=none; b=hgeFEfHfIxMlj3qwPZ06vUV74KPD2vP0eXvSXA1EHadlCbIqCOdoLqqnG0tqV56uj9GAjb/S1JGLPcXrXIv2KsecD+EMNcPb10K4aOE6q7kPosNeuSsdBXay/A150Altai3GpEZ6qjR3SNwMzZQdwIin10obSpU7WlYV4SqeFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312628; c=relaxed/simple;
	bh=534PXqsRH0ZNWtMk7TNPuiF5gAIRjYEwUzbP3uo7gV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CUS3/DV0L/EyWMvAaplPCChmipcoNpbVlVdp2ud6LJ6mUMSnCUXpdMl0seVULay9wfgk8F6zUlnuzP28341Hxal91h1/R93xce5ulyuxfttL7w1hyP8p2uC33WhiOgtkNTzQibDoHqcmBwIyLidtbgivZP/6O0NnHCcNaQ3p08U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dw2ZW84A; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dw2ZW84A"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b458add85aso10064685ad.2
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777312621; x=1777917421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4OVoEgV8q2yYCFvxS4iHEMfYA31+l0LuQw3fH3C5DI=;
        b=dw2ZW84AqbCqKWdwwdJ1xyRjb3tfDaWpErezjyAFL/T0QsmuVL//WLO3XL1NLDlHv8
         Z/pD/U43DTLtV2/gFp6AivdZh1v4zVPRQtiZYS6myeqaRsI/GDiHPRe0LB7+W0Bp08/F
         BBSOS86NblzzRa/hTAP8Yo9APiYyL7jLn0iTRN/NDq++kLWxDZNkNex4temFAtbqFq/d
         bg0iG3KYC/rNL83cHuLZd3SH4ugllTFaC1JqLkdLaxJjaaINHtA6uw6/mApU+BvvyB5H
         mTCTRALmBDgR7zZW7ayZpspYP6J7rlZ8UeOGRwAQnvkK9C0LFeZsJ/l9vfT3p5iR+vdp
         xn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777312621; x=1777917421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4OVoEgV8q2yYCFvxS4iHEMfYA31+l0LuQw3fH3C5DI=;
        b=lKSCIxsriB/WCZhfLBciD8P8k4I1/LckmhK9loU7XQ/x6Y18ueclHobrXuIREBLKF/
         QBui+uaykCVRoLO8NH4eIn3GGIUEE6UqDFRahI26X2iYH37AbLiXVZLvzAsb1+lhldT4
         ZEZwJ33xDrOVaKq4x+853PBCNA+JooglSZ0HnXIlnfkz5/EZe4L9Hi01HxfW7Kf4SEdL
         JTZpDHaFPuSaQ7avacsw89rLW2s2i2+h2BzAocH4oBIg95Mebai2vhFrbl9EOM7RLsZJ
         kDW2XP9DHocgdcYsDQWpUyKSey+2ieA39TMsTHZlG2roKNLZ/YkkKsxQETFmrYVDfudS
         aYuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TVNK0Dcr0SMVDPTHLFEevXT8po8ae7pK0K8X3rykzG0X/VA3mUkLpNI0kMQsET+drYF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj70LX4ifPflQyQlBUBuQveHji0tGFvzs3ucoSf1HX8kPueASH
	wNiqFj7f0rk7CUQvEvZecdIVVJyIFKnCqV0WmnLmovupzgeqMpWD2u5YW7nY1HfBcZkfqPPTSpe
	xt2jpiIJRRb1dIQ==
X-Received: from plgr6.prod.google.com ([2002:a17:902:ea46:b0:2b2:a704:94d8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce0b:b0:2b2:65db:8c51 with SMTP id d9443c01a7336-2b97a7aaa57mr2542145ad.8.1777312620699;
 Mon, 27 Apr 2026 10:57:00 -0700 (PDT)
Date: Mon, 27 Apr 2026 17:56:32 +0000
In-Reply-To: <20260427175633.1978233-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260427175633.1978233-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427175633.1978233-16-skhawaja@google.com>
Subject: [PATCH v2 15/16] vfio/pci: Preserve the iommufd state of the vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/device_cdev.c             | 10 ++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 33 +++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 6844684a3d8e..23f083c0891a 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -271,6 +271,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
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
@@ -329,6 +334,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
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
index 976ef17e6103..b56d80379ffc 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -108,10 +108,13 @@
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
 #include <linux/errno.h>
+#include <linux/iommufd.h>
 #include <linux/vfio.h>
 
 #include "vfio_pci_priv.h"
 
+MODULE_IMPORT_NS("IOMMUFD");
+
 static bool vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler *handler,
 					     struct file *file)
 {
@@ -153,9 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
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
@@ -170,6 +190,9 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	args->serialized_data = virt_to_phys(ser);
 	return 0;
 
+err_iommufd_unpreserve:
+	iommufd_device_unpreserve(args->session, device->iommufd_device);
+
 err_unpreserve:
 	pci_liveupdate_unpreserve(pdev);
 	return ret;
@@ -178,6 +201,14 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
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
2.54.0.545.g6539524ca2-goog


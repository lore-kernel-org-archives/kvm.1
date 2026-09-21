Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C883286D5E
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951740; cv=none; b=T3nWsHoVlv1Nv+JT68WgUOWTBDAWC3qBqv8+CwuZqNMuVqmFlyjUKA10GtKfVNXeEJbqsVbUf06XfmwQd0YzGYdryyt5wUwjcv+J7iGCu5H9qWzpN/KLRr3DKy/W9ZMAx3We8Wl68X8r6Y6zEo7DdniKDDsxRGla+v6TUImaULY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951740; c=relaxed/simple;
	bh=dNP3ug4zy6sMOnrcTiQ4lvN1PGyKC36bSNyoIpacE1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jhWsVNyrIWpHuOTxvHJ/M/tcklD3JuoGv01UFzCQ4POEdf9U8sWYA691+JdD+qWlN9k2/yhgRsFo0nKI9HD+wRR+7cmfJuLKc8sNPwWr91brWt2v/5b9YwyA8PDGDqaGZhlb9mB4yaYNBdkg4pCwONoDaN7PArO4RlOl/dc+OZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FYgMLSf/; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FYgMLSf/"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbedbd182f5so2166761a12.1
        for <kvm@vger.kernel.org>; Sun, 20 Sep 2026 17:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951735; x=1790556535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SnkGcHTtOCYviBMPyvl5P9OipihIRIFDETRmg21FMBU=;
        b=FYgMLSf/Stn94vSjB8j1YXTjXmiHtFUiFQl8BMww4hR4XevpEr6XGdekbdusE9GCMU
         WZu/MfEYnSscapdjv2O736hzY0VZQeVoWLh7g0T7M/IoSc1IyG4FFso18TMwmfj5gxcZ
         jLQejbI2FjYMwYO4fEHswRhb1o+YzwoBOtC5LrmO2eDkjVAmmNlN4ePZdx8UOoNnb2nP
         bbGtZa4VfXnB42tf/UJudjUJkKE+d2RlEPv51tx+Ds7wE0nN5R+FjihZ+8zGY6m+zb25
         cUT94AUrr3Ke/w1L038WhVcjrbycRb/Z2yEZ/qKtjypVxX3bPCBONsp4a4RCth8T1ngn
         x/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951735; x=1790556535;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SnkGcHTtOCYviBMPyvl5P9OipihIRIFDETRmg21FMBU=;
        b=h2pssfgilrA8mFh9wnBoNF3rZ7Njbc/iot2/5D2NtcIDtI9e473vvDjwelIvKtUmFt
         7MxuRLl8vxIA/T/VzSghTA/zD9++83hHKiRqcZCHnOuVlqqIhy2esWKFWcjS0IrxcK34
         xmodPbPWZdelimWrRRWScSXABZk/v4P6o1HNbaGBASZa8snc/NVr5NOR7VlD3fsfJ3w9
         Zj6N7iE7H3+Zz6YKySQpwaiu+/ZpLxep5B04a0WXsEMwIwoCnqk+iMWx2FBN2A/3SseQ
         /bFaMbXS8xSG/bhMrGGimz83cdwhQvoBoyzymNAeXM4fNsgdD/w3yN2Py0m6Y2hzbPvN
         o4LQ==
X-Forwarded-Encrypted: i=1; AKwUvBzA1dWiMMlw1abaJcLnrW3G7+/BxQ4Z3O4wEAmPglVIm3lBQvQK8GO+uy4t4hxOENFTbJ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lhryWbasCgM4w2ni7EtZnzw7Xtbi0ktPAeH/nlA3abPpEM+JxG
	UNrWMfIKHDBxCSLnQs/56KCQgrpdM6dJnT+PcGQ6K3xgMY3iPFT5+gxrSQ0TqPbw0QSIOBhyDg2
	gEbenuTVDBMPb7Q==
X-Received: from plpp18.prod.google.com ([2002:a17:902:c712:b0:2df:474d:a5c7])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d487:b0:2dd:c053:b9c9 with SMTP id d9443c01a7336-2ddc053bab9mr64172125ad.26.1789951734758;
 Sun, 20 Sep 2026 17:48:54 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:33 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-18-skhawaja@google.com>
Subject: [PATCH v5 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

If the vfio cdev is attached to an iommufd, preserve the state of the
attached iommufd also. Basically preserve the iommu specific state of
the device and also the attach iommu HW unit.

Once the device and its iommufd attachment is preserved, it cannot be
detached or attached to another IOAS until it is unpreserved.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/vfio/device_cdev.c             | 10 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index b818aab92f76..4eb7ffd489bd 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -284,6 +284,11 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
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
@@ -342,6 +347,11 @@ int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
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
index f0ea37d98696..fb2141ee8942 100644
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
@@ -154,15 +157,25 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
 	struct pci_dev *pdev;
-	int ret;
+	u64 iommufd_token;
+	int ret = 0;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
-	ret = pci_liveupdate_preserve(pdev);
+	mutex_lock(&device->dev_set->lock);
+	ret = iommufd_device_preserve(args->session,
+				      device->iommufd_device,
+				      &iommufd_token);
+	mutex_unlock(&device->dev_set->lock);
+
 	if (ret)
 		return ret;
 
+	ret = pci_liveupdate_preserve(pdev);
+	if (ret)
+		goto err_iommufd_unpreserve;
+
 	ser = kho_alloc_preserve(sizeof(*ser));
 	if (IS_ERR(ser)) {
 		ret = PTR_ERR(ser);
@@ -177,6 +190,12 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 
 err_unpreserve:
 	pci_liveupdate_unpreserve(pdev);
+
+err_iommufd_unpreserve:
+	mutex_lock(&device->dev_set->lock);
+	iommufd_device_unpreserve(args->session,
+				  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
 	return ret;
 }
 
@@ -184,6 +203,11 @@ static void vfio_pci_liveupdate_unpreserve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_device *device = vfio_device_from_file(args->file);
 
+	mutex_lock(&device->dev_set->lock);
+	iommufd_device_unpreserve(args->session,
+				  device->iommufd_device);
+	mutex_unlock(&device->dev_set->lock);
+
 	pci_liveupdate_unpreserve(to_pci_dev(device->dev));
 	kho_unpreserve_free(phys_to_virt(args->serialized_data));
 }
-- 
2.55.0.1082.g2b9226bbc0-goog


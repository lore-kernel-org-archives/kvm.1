Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B8334374
	for <kvm@vger.kernel.org>; Sat,  8 Aug 2026 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156061; cv=none; b=ET46VxgJALJ9vPH3w0u2SVCKHb8gPmerOkqcvTCnptQMsnZgiPiON/Ax5ANIe0BNOIR4rf21CEWZfiLoeAnS0zNBHFgQgm6t0LP1ikj1e0++0aacIfte+C+IaX40srC5vrlQAOLyzqBDfYaXEqccKC+SZCFsE65zaWcn5bVRZwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156061; c=relaxed/simple;
	bh=cjb+KxxfnUre3rq1ZzGRqVg0XNjyswwdezXvJdlIrCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SEY1lOH+5TJ5fekCwmcIVLiapv7o2ODwup0EKbBx2Gf3IowlbEm/WC7TlT9QLyoq/9G6A05gYy7zr27jaRK2qXa/UqXuX3q3/47cNDPkYSimP6F7D2iz64xER5EOBbg7EqdT8XB+f67SEiw9BmmtJyfMeqmg31BhnCq6jfxdhDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBpabYKD; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBpabYKD"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e024d2129so298636b3a.2
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786156059; x=1786760859; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RfGmA9TtDvPF7O3ZhIsAfcKwGiJZMacmSEbtMpPIaMY=;
        b=qBpabYKDEpi5jQ81/N93Fz9Hm07U8ysXJ1+EBC0v9KqanaYkbZVXkor6Q9OtNGy2V1
         OLBIQ8tDOx7CKvx2BA9zm1vgyw4RvY8mWngLqRFyaqMxhg+WJAliLKkm1sYQYJas9ukK
         5X9qDIUPSqmEJcZnS+zzLZpKxlGAqJqVpLjLAGq28LheLICp58C33HjoPufqntJupK4F
         PNtpJpZi9KuBQEkPs2xz0I5fOeRmcCtVSuw/U8YWEZ20WFIz+hRcNCnkGVn53hNqAWE/
         nDZOasggly2VvXEBb9u1YCPpjMJF6NpHsCKtkQqfmoPMg/GKaf4N6jGtL6G5kQJU/bU5
         SJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786156059; x=1786760859;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RfGmA9TtDvPF7O3ZhIsAfcKwGiJZMacmSEbtMpPIaMY=;
        b=Q7DmtJbIpAjxzkg1ZjePlHXhih0bVIYl4dyEQ0jWNtfuHc37FASQAWfEBNME5VjREn
         u21pC3zKOtucN0Wf+pmCsu9JBQ1OS+u8N8Axs4oPgkdGAgfM3R/Uw2cK8tCDCr/6lCYt
         T5vKVNBbQPDgkCfLQaVNM7VInyuTA3ummWMAwOAXk8C7W9rygFRWUrx6NpcswsNe97Kt
         CipWnqgcaC6pJ/fd9jFz+boByWFq+hhOCiNJmowCepuKVluKu5fbAnFzuktY9LGYp4Nc
         fmPZjEaGQm3o6L0BHYbtslgwRkpzB70DisNTYwftHRo926wGNtlVgE73V5AVnUAIyFF/
         brNA==
X-Forwarded-Encrypted: i=1; AHgh+RoEG8f9GHIo3sO04/Es9PmN3vTVXJOwiAENzGLr55+Mz1UQluvlLuMY0y5EKzeDY+ZtAvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOcYcEvB/hrVGjokd9Vp+tgVXxpJqF6/D0UTrLLqgPhb9ksIs
	gxdpGOm3CI37aoOsg5AeYF3yOmGLDvYVUZa+nGsUYFBVvYuTybBEQaBlTWI+lAP6WWTanTzyPVf
	O93RdaGx1BrCKHQ==
X-Received: from pfx36.prod.google.com ([2002:a05:6a00:a464:b0:84b:44f4:2d62])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1150:b0:845:c5d5:3745 with SMTP id d2e1a72fcca58-84f5e10f964mr8390267b3a.34.1786156058324;
 Fri, 07 Aug 2026 19:27:38 -0700 (PDT)
Date: Sat,  8 Aug 2026 02:27:22 +0000
In-Reply-To: <20260808022723.3893618-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260808022723.3893618-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808022723.3893618-18-skhawaja@google.com>
Subject: [PATCH v4 17/18] vfio/pci: Preserve the iommufd state of the vfio cdev
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
 drivers/vfio/device_cdev.c             | 10 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c | 28 ++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 2 deletions(-)

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
index f0ea37d98696..43d4c56f13ab 100644
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
@@ -153,16 +156,26 @@ static int vfio_pci_liveupdate_preserve(struct liveupdate_file_op_args *args)
 	struct vfio_device *device = vfio_device_from_file(args->file);
 	struct vfio_pci_core_device_ser *ser;
 	struct vfio_pci_core_device *vdev;
+	u64 token, preserved_state;
 	struct pci_dev *pdev;
-	int ret;
+	int ret = 0;
 
 	vdev = container_of(device, struct vfio_pci_core_device, vdev);
 	pdev = vdev->pdev;
 
-	ret = pci_liveupdate_preserve(pdev);
+	mutex_lock(&device->dev_set->lock);
+	ret = iommufd_device_preserve(args->session,
+				      device->iommufd_device,
+				      &token, &preserved_state);
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
2.55.0.679.g6767b8d81c-goog


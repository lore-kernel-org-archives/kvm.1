Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE564302ED
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786133655; cv=none; b=IVylZc3SAwRwCL6BblNB1b7+BO/JyhUspQeztv0VvWWuaLumX2EczTai8EqvN7xtLTZjGilCLdNwp/kRfuGLDcPdpJDPgPNpkBRMbUypiwIRgMYVl7kMGNcInT60tCXxJI34cPX+YHsoqXBM9rK+cvhVoge8QKjIPks1054oGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786133655; c=relaxed/simple;
	bh=kMsjKTuynsefErNGeZmjiRN7tCs/gh5HJ2AkefnEDZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e19yWM+57Q4loyTBGotiMqMyFVtkAQrislib5u9BQUJ7Je0ysy3cm4nU9xy9J5bQ2+ymvcaKyqxQ+enOD3kgVBGy1Fp6Q0jyGPKoWNkGxUNUxE/vJGHwRnDVLEDznIwd3A/B47Y4Nb3/Fa1+K/yuLfzJDSgJpJRC7D2B9O7TbFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DesxP+Bh; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DesxP+Bh"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so4032957a91.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786133653; x=1786738453; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dON27PQrVxxUgN5VlWr9eHnk4JPXmLFtOTAy8o6jncI=;
        b=DesxP+Bhzu+aDfbYNHkFuRJc0/562oZTRrPzkcZGNbZUEsuu629YPt0c5fX0MIkO4t
         AQBLQbddtm4Bt5fQK1Ady5mtzEqm65RdMxAh6+egZX9FScyGYS2988XT4uk4esCtXXJy
         9huCTclRaE567Faf4Z981btjN1JU4xCi+L5zlYoWH/39FiWt6pbsqBJeA2JikHSCPrzx
         EG37RPcqxivyPcV5iwLboXlFrBhxzmoJkg1C0wjFbLbpZio4+Zgkruim/A2SRjmEXkrz
         A21VSmTlZ2DgrsgXAp+S0Yc1eVIlNbRJDx5rdURiBQ42mlqZWaxZM8Yp+poJFhoIIZ97
         0vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786133653; x=1786738453;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dON27PQrVxxUgN5VlWr9eHnk4JPXmLFtOTAy8o6jncI=;
        b=m+rl3fsqHyQSZaQjOHQ8Zj49wTYgej8K8EheFNsTexplNnvTJRbt0TasB9IlFB5CtY
         fjb7/9Hwb4Knx3hlLgcSBcfoZcTKDXgKydKZPfJ8zVBpqusQyj51msuI/Vi3lSTDZE6n
         tS3PHyG9X0tnWgFIHBzlb4IdrJbmwNEsflWyVy8XEU6Pze4kKd2emWP9q2pQnaTn3Mho
         ZmemYBBPv0s+MlKT1jh85X/p6VHpkuUHz2MGzeBEM70QFBuHifMeUGbrnJO734N8ZLSl
         XelLUsZcCpwAsmhCNngpNm7KkLoHGD41FcnKFeqvKWUV8deGv3oxZLQmoF9euXA5tzUk
         oSuw==
X-Forwarded-Encrypted: i=1; AHgh+Ro2ztuj/qnr0bIaJveHk/uA2QD2fEfCpdk+n3dD6G39TLv/f16awNymX7r4OmkAvGorZNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVZoy7NtrO6/cub9E5yPpaNJdDZH31tPHt6I4e4L9Mt3ApgMT
	6KCjRjWlCccfjlWHpONYB6fF8akGxsBTjpVX53Amka+nR0TwKXdyki1FDcfcaVUyiIIFEeQklZj
	7Lw==
X-Received: from pjrq19.prod.google.com ([2002:a17:90a:b993:b0:38e:fefe:3b03])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3841:b0:37f:e1b6:4c7d
 with SMTP id 98e67ed59e1d1-3928225dd9emr2119373a91.6.1786133653087; Fri, 07
 Aug 2026 13:14:13 -0700 (PDT)
Date: Fri,  7 Aug 2026 20:14:05 +0000
In-Reply-To: <20260807201405.3717430-1-praan@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807201405.3717430-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260807201405.3717430-2-praan@google.com>
Subject: [RFC PATCH v1 1/1] vfio/pci: Revoke BARs and DMABUFs during
 sysfs-triggered PCI reset
From: Pranjal Shrivastava <praan@google.com>
To: Alex Williamson <alex@shazbot.org>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Leon Romanovsky <leon@kernel.org>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	Jacob Moroni <jmoroni@google.com>, David Hu <xuehaohu@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, vfio-pci does not implement the .reset_prepare and .reset_done
ops in its struct pci_error_handlers. During a sysfs-triggered PCI reset
(echo 1 > /sys/bus/pci/.../reset), the PCI core resets the device using
Function Level Reset (FLR) or Secondary Bus Reset (SBR), which isn't
propagated to the vfio-pci driver. Due to this, the exported DMABUFs and
BARs aren't zapped or revoked and the importer continues to use them.

Implement reset_prepare and reset_done hooks for the vfio-pci driver
that zap the BARs and revoke the exported DMABUFs while holding the
memory_lock.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 88 ++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a113c55845e1..e46b0b1d8a59 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1334,12 +1334,14 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
 	 */
 	vfio_pci_set_power_state(vdev, PCI_D0);
 
-	vfio_pci_dma_buf_move(vdev, true);
-	ret = pci_try_reset_function(vdev->pdev);
-	if (__vfio_pci_memory_enabled(vdev))
-		vfio_pci_dma_buf_move(vdev, false);
+	/*
+	 * Drop the lock before entering the PCI core.
+	 * The PCI core will re-acquire it via our .reset_prepare hook.
+	 */
 	up_write(&vdev->memory_lock);
 
+	ret = pci_try_reset_function(vdev->pdev);
+
 	return ret;
 }
 
@@ -2418,8 +2420,33 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
+static void vfio_pci_core_reset_prepare(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (vdev) {
+		down_write(&vdev->memory_lock);
+		vfio_pci_set_power_state(vdev, PCI_D0);
+		vfio_pci_zap_bars(vdev);
+		vfio_pci_dma_buf_move(vdev, true);
+	}
+}
+
+static void vfio_pci_core_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (vdev) {
+		if (__vfio_pci_memory_enabled(vdev))
+			vfio_pci_dma_buf_move(vdev, false);
+		up_write(&vdev->memory_lock);
+	}
+}
+
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_prepare = vfio_pci_core_reset_prepare,
+	.reset_done = vfio_pci_core_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
@@ -2561,55 +2588,52 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 
 		if (!owned) {
 			ret = -EINVAL;
-			break;
+			goto err_out;
 		}
+	}
 
+	/* Zap, and set power state */
+	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list) {
 		/*
-		 * Take the memory write lock for each device and zap BAR
-		 * mappings to prevent the user accessing the device while in
-		 * reset.  Locking multiple devices is prone to deadlock,
+		 * Take the memory write lock for each device, zap BAR
+		 * mappings, and restore power state before reset.
+		 * Locking multiple devices is prone to deadlock,
 		 * runaway and unwind if we hit contention.
 		 */
 		if (!down_write_trylock(&vdev->memory_lock)) {
 			ret = -EBUSY;
-			break;
+
+			/*
+			 * We failed to lock THIS device. We must step back one
+			 * device so err_undo only unlocks devices that succeeded.
+			 */
+			if (!list_entry_is_head(vdev, &dev_set->device_list, vdev.dev_set_list)) {
+				vdev = list_prev_entry(vdev, vdev.dev_set_list);
+				goto err_undo;
+			}
+			goto err_out;
 		}
 
-		vfio_pci_dma_buf_move(vdev, true);
 		vfio_pci_zap_bars(vdev);
+		vfio_pci_set_power_state(vdev, PCI_D0);
 	}
 
-	if (!list_entry_is_head(vdev,
-				&dev_set->device_list, vdev.dev_set_list)) {
-		vdev = list_prev_entry(vdev, vdev.dev_set_list);
-		goto err_undo;
-	}
-
-	/*
-	 * The pci_reset_bus() will reset all the devices in the bus.
-	 * The power state can be non-D0 for some of the devices in the bus.
-	 * For these devices, the pci_reset_bus() will internally set
-	 * the power state to D0 without vfio driver involvement.
-	 * For the devices which have NoSoftRst-, the reset function can
-	 * cause the PCI config space reset without restoring the original
-	 * state (saved locally in 'vdev->pm_save').
-	 */
+	/* Drop locks before crossing into PCI core */
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
-		vfio_pci_set_power_state(vdev, PCI_D0);
+		up_write(&vdev->memory_lock);
 
+	/* PCI core handles the reset and calls .reset hooks */
 	ret = pci_reset_bus(pdev);
 
-	vdev = list_last_entry(&dev_set->device_list,
-			       struct vfio_pci_core_device, vdev.dev_set_list);
+	goto err_out;
 
 err_undo:
+	/* Unwind locks cleanly for devices we successfully locked */
 	list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
-					 vdev.dev_set_list) {
-		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
-			vfio_pci_dma_buf_move(vdev, false);
+					 vdev.dev_set_list)
 		up_write(&vdev->memory_lock);
-	}
 
+err_out:
 	list_for_each_entry(vdev, &dev_set->device_list, vdev.dev_set_list)
 		pm_runtime_put(&vdev->pdev->dev);
 
-- 
2.55.0.679.g6767b8d81c-goog


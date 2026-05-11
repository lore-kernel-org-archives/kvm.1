Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56216374E66
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543316; cv=none; b=Lnq8+EBOsu/i8urA+o4zOu1ocszG7ofwwGp0zbFw7sdCWow4y70lxLEgGH1Qqp8abGqjaDai3ON5qyHLHxlyONJYAUydInCP92hBRwtcBvrNKJRFGxGDGNaYHPXzS1/fBHhiRj4PEh98vQ5R8tY4Do8fsi2dCHXJfsXsfOIBCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543316; c=relaxed/simple;
	bh=oJsSrCLnq/hUpbpSIJ6e+j3j3wj1WKuepVreB9B1P5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hNc+JaTNx+TDOir/NVLNJgTrvsy/HXKLHnEWgsljf6JhhnzXFEAjdCxLcboTwcbfjdYo8/i5yZWH+l9+W2MT040Be+28qEggivUZkEZpigzJqoBDTKwxXrlS6SZJ03rBjwece/Hk55JSxIyTToA2Ha/o4F0y1cxKD0X6RkALOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gNPFx521; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gNPFx521"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354c44bf176so5879220a91.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543313; x=1779148113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8YUOBD+7hHFjPbisS9Y2OJf58q41fidHTUfr1qnzIcU=;
        b=gNPFx521k01jOskE0cga4AZKOwtlb89Dg56pihW8BKgtLyJ52v0ol0oDoIftZyqYWS
         gW/6Dabc2lYNfD5nFJk7Fawr1I2VIr6YqKQaPw5nY/Za5/RyfMJEZAeweffclxcSGjEu
         9bZVSQPORMDttNiwPXN1FGtHjfiUzpjHK3SaaqTGXBYH7BCS0gOQVolmdxBLrj8J0xZy
         VJrCq3z/PkQLxUkMy2gtPTUVszZvsmxNbTYML6NNOglyIPqQRuFBDBE0lvpnvlHhz2Nz
         eL1Ja1zreFiifTniEXlOverCWpbfgHTiCiqGbTpcAVNwJ/VMTtof0Hplu9qmiN9gyJWW
         +Xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543313; x=1779148113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YUOBD+7hHFjPbisS9Y2OJf58q41fidHTUfr1qnzIcU=;
        b=UhBLFDLnLS4bFdPOwbg5clCfnNwkRzTriAjAPXH0ZgG2ubK3Iqh9PFnt57L+DtVmen
         t8ECC4NMp6HfcJfI1pBVZ29X6u3LKWpu0O6LoVO7wThTPvYI6Xn2bVKaxRCtiJFnTN7e
         C4FDskJW8YM0pKboAS7jxNyFbCNrt/dOvU2DxpanKccCOs6GEHpArBJTEjzVbH8/Azkr
         ZFM2LvvlJpX6H4OgdaliJ7IBILNga1l+SiYNg5PI6uW9d/eTJUOFfy0W3DMalr0W+MrJ
         xOV71arQZegTV6sC1cL0dpovYkPUV0RRADJErml3w/4ocx9cMh0AoOlG8/fXoYTaxg1R
         2GaQ==
X-Gm-Message-State: AOJu0YxvoqTnOJpXaEfDA8c9vfB+V26/l2BK2HZfZX2HkBxgINzj4yOI
	i2huvpJzuStiL0e/yEMa24VDFqnD7sUra47VTl8xb0blPc+8kBSK2gtQlLVF+GgpE6V06iMPmAq
	TvP29t+xWXzRGjbTVhjP+4YNKUAeGODE631g4OEq2Lln/6GUacw1jGiY2zkZdHrLfnoNozDPLuS
	6l+oJahTBf/6dsapmfqArsTwdSeaZlPfe0wJ0kPQ==
X-Received: from pgdh5.prod.google.com ([2002:a05:6a02:5185:b0:c79:7107:a67a])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a15:b0:398:7d4a:c2c4
 with SMTP id adf61e73a8af0-3ad9a95b960mr640565637.48.1778543312073; Mon, 11
 May 2026 16:48:32 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:49 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-4-vipinsh@google.com>
Subject: [PATCH v4 03/16] vfio/pci: Retrieve preserved device files after Live Update
From: Vipin Sharma <vipinsh@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, chrisl@kernel.org, corbet@lwn.net, 
	dmatlack@google.com, graf@amazon.com, jacob.pan@linux.microsoft.com, 
	jgg@nvidia.com, jgg@ziepe.ca, jrhilke@google.com, julianr@linux.ibm.com, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, 
	praan@google.com, pratyush@kernel.org, rananta@google.com, 
	rientjes@google.com, rodrigo.vivi@intel.com, rppt@kernel.org, 
	saeedm@nvidia.com, skhan@linuxfoundation.org, skhawaja@google.com, 
	vipinsh@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"

Enable userspace to retrieve preserved VFIO device files from VFIO after
a Live Update by implementing the retrieve() and finish() file handler
callbacks.

Use an anonymous inode when creating the file, since the retrieved
device file is not opened through any particular cdev inode, and the
cdev inode does not matter in practice.

For now the retrieved file is functionally equivalent a opening the
corresponding VFIO cdev file. Subsequent commits will leverage the
preserved state associated with the retrieved file to preserve bits of
the device across Live Update.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c             | 59 ++++++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_liveupdate.c | 52 ++++++++++++++++++++++-
 drivers/vfio/vfio_main.c               | 13 ++++++
 include/linux/vfio.h                   | 11 +++++
 4 files changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 8ceca24ac136..1ab07ccaf3ab 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2023 Intel Corporation.
  */
+#include <linux/anon_inodes.h>
 #include <linux/vfio.h>
 #include <linux/iommufd.h>
 
@@ -16,15 +17,10 @@ void vfio_init_device_cdev(struct vfio_device *device)
 	device->cdev.owner = THIS_MODULE;
 }
 
-/*
- * device access via the fd opened by this function is blocked until
- * .open_device() is called successfully during BIND_IOMMUFD.
- */
-int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
+static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep)
 {
-	struct vfio_device *device = container_of(inode->i_cdev,
-						  struct vfio_device, cdev);
 	struct vfio_device_file *df;
+	struct file *file = *filep;
 	int ret;
 
 	/* Paired with the put in vfio_device_fops_release() */
@@ -37,22 +33,67 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	/*
+	 * Simulate opening the character device using an anonymous inode. The
+	 * returned file has the same properties as a cdev file (e.g. operations
+	 * are blocked until BIND_IOMMUFD is called).
+	 */
+	if (!file) {
+		file = anon_inode_getfile_fmode("[vfio-device-liveupdate]",
+						&vfio_device_fops, NULL,
+						O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+
+		if (IS_ERR(file)) {
+			ret = PTR_ERR(file);
+			goto err_free_device_file;
+		}
+
+		*filep = file;
+	}
+
+	file->private_data = df;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
 	 * to the same address space, allowing us to unmap all vmas
 	 * associated to this device using unmap_mapping_range().
 	 */
-	filep->f_mapping = device->inode->i_mapping;
+	file->f_mapping = device->inode->i_mapping;
 
 	return 0;
 
+err_free_device_file:
+	kfree(df);
 err_put_registration:
 	vfio_device_put_registration(device);
 	return ret;
 }
 
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	struct file *file = NULL;
+	int ret;
+
+	ret = vfio_device_cdev_open(device, &file);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return file;
+}
+EXPORT_SYMBOL_GPL(vfio_device_liveupdate_cdev_open);
+
+/*
+ * device access via the fd opened by this function is blocked until
+ * .open_device() is called successfully during BIND_IOMMUFD.
+ */
+int vfio_device_fops_cdev_open(struct inode *inode, struct file *file)
+{
+	struct vfio_device *device = container_of(inode->i_cdev,
+						  struct vfio_device, cdev);
+
+	return vfio_device_cdev_open(device, &file);
+}
+
 static void vfio_df_get_kvm_safe(struct vfio_device_file *df)
 {
 	spin_lock(&df->kvm_ref_lock);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 5cc57bf39dbe..9142aaea94f2 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -39,7 +39,13 @@
  *    preserved, so there is no way for the file to be destroyed or the device
  *    to be unbound from the vfio-pci driver while it is preserved.
  *
- * Retrieving the file after kexec is not yet supported.
+ * After kexec, the preserved VFIO device file can be retrieved from the session
+ * just like any other preserved file::
+ *
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg);
+ *   device_fd = arg.fd;
+ *   ...
+ *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
  * Restrictions
  * ============
@@ -90,6 +96,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
+#include <linux/file.h>
 #include <linux/kexec_handover.h>
 #include <linux/kho/abi/vfio_pci.h>
 #include <linux/liveupdate.h>
@@ -203,13 +210,53 @@ static int vfio_pci_liveupdate_freeze(struct liveupdate_file_op_args *args)
 	return 0;
 }
 
+static int match_device(struct device *dev, const void *arg)
+{
+	struct vfio_device *device = container_of(dev, struct vfio_device, device);
+	const struct vfio_pci_core_device_ser *ser = arg;
+	struct pci_dev *pdev;
+
+	pdev = dev_is_pci(device->dev) ? to_pci_dev(device->dev) : NULL;
+	if (!pdev)
+		return false;
+
+	return ser->bdf == pci_dev_id(pdev) && ser->domain == pci_domain_nr(pdev->bus);
+}
+
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
-	return -EOPNOTSUPP;
+	struct vfio_pci_core_device_ser *ser;
+	struct vfio_device *device;
+	struct file *file;
+	int ret = 0;
+
+	ser = phys_to_virt(args->serialized_data);
+
+	device = vfio_find_device(ser, match_device);
+	if (!device)
+		return -ENODEV;
+
+	file = vfio_device_liveupdate_cdev_open(device);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out;
+	}
+
+	args->file = file;
+out:
+	/* Drop the reference from vfio_find_device() */
+	put_device(&device->device);
+	return ret;
+}
+
+static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
+{
+	return args->retrieve_status > 0;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
 {
+	kho_restore_free(phys_to_virt(args->serialized_data));
 }
 
 static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
@@ -218,6 +265,7 @@ static const struct liveupdate_file_ops vfio_pci_liveupdate_file_ops = {
 	.unpreserve = vfio_pci_liveupdate_unpreserve,
 	.freeze = vfio_pci_liveupdate_freeze,
 	.retrieve = vfio_pci_liveupdate_retrieve,
+	.can_finish = vfio_pci_liveupdate_can_finish,
 	.finish = vfio_pci_liveupdate_finish,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 2148b00491e4..33e082af9a08 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -13,6 +13,7 @@
 #include <linux/cdev.h>
 #include <linux/compat.h>
 #include <linux/device.h>
+#include <linux/device/class.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/iommu.h>
@@ -1787,6 +1788,18 @@ int vfio_dma_rw(struct vfio_device *device, dma_addr_t iova, void *data,
 }
 EXPORT_SYMBOL(vfio_dma_rw);
 
+struct vfio_device *vfio_find_device(const void *data, device_match_t match)
+{
+	struct device *device;
+
+	device = class_find_device(vfio.device_class, NULL, data, match);
+	if (!device)
+		return NULL;
+
+	return container_of(device, struct vfio_device, device);
+}
+EXPORT_SYMBOL_GPL(vfio_find_device);
+
 /*
  * Module/class support
  */
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index f5f7ece51f8f..0b61aeff8216 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -431,4 +431,15 @@ int vfio_virqfd_enable(void *opaque, int (*handler)(void *, void *),
 void vfio_virqfd_disable(struct virqfd **pvirqfd);
 void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
 
+#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)
+struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device);
+#else
+static inline struct file *vfio_device_liveupdate_cdev_open(struct vfio_device *device)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+#endif /* IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) */
+
+struct vfio_device *vfio_find_device(const void *data, device_match_t match);
+
 #endif /* VFIO_H */
-- 
2.54.0.563.g4f69b47b94-goog


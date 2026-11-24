Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524033;
	b=4QrTW78LkPtOoQOjAg40gl0hgz2jQGXN2NV+ZulJSgjzjEPjDaq5g9UHys0LZWgH1bui
	 WIuDMREclWzKR7mhQpxur4mo8osofolmWswRpQJs3jOuTCkj7KSklnK/wsv31FZ/IwXpm
	 9G1YOrQpgS9oeCKIQ2ZjkY7tH0AUo2oDLm6dwe5SP+/ZBSgXLh5dzYoBc8OWVBhWBYL3g
	 VXLDiIDvCY4AfpmDGdZ770T0hhZdNyhk1IblSC4Xlb8VLUlcW4waGJt0ZvwIpgaXBDFvT
	 n/E13tPUoAz81IvWKRj3UgDeHZwFy2bXBYHFG8AediAi2lqC9DhQdMk2bwn0QOQrM0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524033;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FUtlIPoksxhaEfSCf9BWdDtY6/jrrPPqHFcq/5SBjwc=;
	b=tYO7OYFsPdKaPTRMGAUi5Xzd9lpMdLKBEA7OXDwJICA3q9/oR92D3kSC/od41Vhf7uv0
	 y7KTQFLOlajZJE1o0u1Mc3+Y9dHdg+X4/BK/pmv272BqLTR5l0r41iWwDAgrP7GGnunz4
	 XCQx+H9g/Dnv5pC3RBTkTVYNdgn+TqlUsFLYMAl44EZX3i+Ft8Y94YcrO8w/cI8Gj/m7f
	 KR7Plt0xliZs9Mn7OOfnNKmfJd5wyGER0OqxkrTMfMAvH80EvrgEdaHmPk62cVKejvYzY
	 QJ5HSecLlMsCcH9bHf8RXhU39/a9yQXExVv23i4E/zwEW4jNE/sjlIdQ4Or/uZB+GUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O2pplg2I;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D55606A326;
	Tue, 24 Nov 2026 12:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54D55606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O2pplg2I
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795524028; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FUtlIPoksxhaEfSCf9BWdDtY6/jrrPPqHFcq/5SBjwc=;
	b=O2pplg2IjV/qPfsrT2s1e8xv1wYoZq5x+oqPK2+myCsK0AHUa3imewxtnRJ5ZRoBdNhjWwnKpGZigcHYfd6srlEEyRCrujU+/7O37QYsC8v6X0I5A9VSSsvLSXnbrfL/ZtFsxjuierHjSeNkQNp0gSVCMc6HLc4I86aQ2jWjcDI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XFOSkmu_1795524027;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XFOSkmu_1795524027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 20:40:27 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: guanghuifeng@linux.alibaba.com
Cc: alex@shazbot.org,
	alifm@linux.ibm.com,
	ankita@nvidia.com,
	dakr@kernel.org,
	fengchengwen@huawei.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mattev@meta.com,
	ritesh.list@gmail.com,
	xinmengs@nvidia.com
Subject: [PATCH v2 1/2] vfio: Add get_unmapped_area callback to vfio_device_ops
Date: Tue, 24 Nov 2026 20:40:03 +0800
Message-ID: <20261124124004.457441-2-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
References: <20261124073048.268988-1-guanghuifeng@linux.alibaba.com>
 <20261124124004.457441-1-guanghuifeng@linux.alibaba.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfio exposes device regions through the device file descriptor and a
bus driver backs a region with pfnmaps over the device MMIO space when
the user calls mmap(2) on it.  Unless the user asks for a specific
address, the virtual address of the resulting VMA is picked by the
generic address selection in mm_get_unmapped_area(), which only
guarantees PAGE_SIZE alignment.

That is enough for the base mapping, but it keeps a driver from ever
backing a region with huge pfnmaps.  huge_fault() only installs a PMD
or PUD sized pfnmap when both the fault address and the pfn are aligned
to that page size, see is_aligned_for_order().  A driver can only
influence the first of those, and it cannot do so from its mmap()
callback because the address has already been fixed up by then.

Add a get_unmapped_area() callback to vfio_device_ops along with a
dispatcher in vfio_device_fops, so a bus driver can ask for an address
that is aligned to the largest page size its region can be mapped with
before the VMA is created.  Drivers that do not provide the callback,
and configurations without huge pfnmap support, fall back to
mm_get_unmapped_area() and keep the existing behaviour.

The hook is only consulted when the kernel has to choose the address:
a MAP_FIXED mapping never reaches it, and an explicit address hint is
passed through to the driver, which is expected to honour it.  The
callback therefore serves the userspace consumers that call
mmap(fd, offset) with addr=0 and rely on the kernel to pick a suitable
address for them, rather than trying to second guess userspace that
already arranges the alignment itself.

This mirrors what drivers/dax/device.c does with
dax_get_unmapped_area(), which has to satisfy the same alignment
requirement for its PMD sized pfnmaps.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/vfio/vfio_main.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/vfio.h     | 12 ++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 4e5d738ccf4b..edf9eb4cd477 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -28,6 +28,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
@@ -1431,6 +1432,36 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 	return device->ops->mmap(device, vma);
 }
 
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+/*
+ * Give the bus driver a chance to request a virtual address that allows the
+ * mapping to be backed by huge pages, fex. a PCI BAR mapping that could be
+ * faulted in with PMD or PUD sized pfnmaps.  Anything the driver cannot
+ * handle, including devices without huge mapping support, falls back to the
+ * generic address selection, which is also what happens without this
+ * callback.
+ */
+static unsigned long vfio_device_fops_get_unmapped_area(struct file *filep,
+							unsigned long addr,
+							unsigned long len,
+							unsigned long pgoff,
+							unsigned long flags)
+{
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
+
+	/* Paired with smp_store_release() following vfio_df_open() */
+	if (!smp_load_acquire(&df->access_granted))
+		goto out;
+
+	if (device->ops->get_unmapped_area)
+		return device->ops->get_unmapped_area(device, filep, addr, len,
+						      pgoff, flags);
+out:
+	return mm_get_unmapped_area(filep, addr, len, pgoff, flags);
+}
+#endif
+
 #ifdef CONFIG_PROC_FS
 static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
 {
@@ -1456,6 +1487,9 @@ const struct file_operations vfio_device_fops = {
 	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.mmap		= vfio_device_fops_mmap,
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	.get_unmapped_area = vfio_device_fops_get_unmapped_area,
+#endif
 #ifdef CONFIG_PROC_FS
 	.show_fdinfo	= vfio_device_show_fdinfo,
 #endif
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0cc91c6f96d2..68a84a1fd3fd 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -102,6 +102,12 @@ struct vfio_device {
  * @ioctl: Perform ioctl(2) on device file descriptor, supporting VFIO_DEVICE_*
  *         operations documented below
  * @mmap: Perform mmap(2) on a region of the device file descriptor
+ * @get_unmapped_area: Optional, suggest a virtual address for mmap(2) of a
+ *         device region such that the mapping can be backed by huge pages,
+ *         ie. the address is aligned to the largest page size the region can
+ *         be mapped with.  Drivers that don't support huge mappings, and
+ *         configurations without huge pfnmap support, leave this unset and
+ *         the generic address selection is used.
  * @request: Request for the bus driver to release the device
  * @match: Optional device name match callback (return: 0 for no-match, >0 for
  *         match, -errno for abort (ex. match with insufficient or incorrect
@@ -143,6 +149,12 @@ struct vfio_device_ops {
 	void	(*dma_unmap)(struct vfio_device *vdev, u64 iova, u64 length);
 	int	(*device_feature)(struct vfio_device *device, u32 flags,
 				  void __user *arg, size_t argsz);
+	unsigned long (*get_unmapped_area)(struct vfio_device *vdev,
+					   struct file *filp,
+					   unsigned long addr,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)
-- 
2.43.7


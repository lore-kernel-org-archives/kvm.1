Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AB3BA225
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543318; cv=none; b=dYv5WlCPbxN7o8yJ4h1OQVuNAlV+H+I4wM3ivIvWxqrxvYbM3ClzOhVAPaFHjRkpqOrtTfDL3faXB2Sih/Xj0s5K7uRjUIxQTsqPv7nBSJGfpC6He6Vnj9sO92ro7wbnt9hcRPHTEReSVsMjkehUKbxQSqspkcgyt68sWDMwirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543318; c=relaxed/simple;
	bh=3ytzMoApkUjmFhiyRDC37NlP+bK8f+8Zi9rhfzytfEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q3AwbtLYVYzPLCuqVk1Ujts2XfzDGaCgWkHDwiF3RX+fc6hPkzm/Hxb0+LyWhiTNkNJbpXONPXDKlRCoQV8PEIdXvts9oRktTL1kmOa9SneeIl6O6spmpnrm765vxaGVBGaczhSupITRU/2YBI21qGmv8R/DWA+qHZU1dK8ntRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUAGvJYQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUAGvJYQ"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-366344513a3so8865201a91.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543315; x=1779148115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsypqsh627xWDj14lndk3F1iTuQ4MYPrH0UMeFATjE8=;
        b=XUAGvJYQ8Tfrpf073ilcEYbRyiPMXrScNEZY2MjqOmmVKNcHeCIFhoDgdIuhQObH3e
         1Y2X4+KSnwUg15JQiCbewy9WZ0lJ0Mm+NZS65AnNxxEpHBl0K/1OH6qRVg43//Xscr/M
         f1Qo0QEQAVH2fsIQ2ImKkldjbCdqf5COeLepE7yOvKT3o1DFK9wdCUNOu6nsIzdefbTw
         ghY6bqIMP8QOGSuZXLrpXwxdtaLwuhV7hM+XbI81+SdgbTlUkY8rySCCiXOygQTQGC55
         ajIicHcKqiTwcLfXzsdSCntEz3ZC3ufdf9S178jLg6vx01XrQ4fl6SoDtHq70GlY69Gq
         1e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543315; x=1779148115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lsypqsh627xWDj14lndk3F1iTuQ4MYPrH0UMeFATjE8=;
        b=oG8Bx78EKiiP0x2Bj8e2r+xgvf9SlOw7nDZeFSlyr9tZRuwfZAPzxYq9W3Eznso6Zh
         W4qIwjdiXx12X76KAsgu8TQjWuWxOc1jzzag4yHgI4tqH+sOwAsOcDgsqwcrNsDItCFD
         qSSTWh04iqyNBi0vwV3BFVl7Fd7K5V7hfCBxGjYNBc9juT9lyX1PUXzxUgqkWmEZyvTx
         gUGsCzEmRaGKngZO4LdATcU1FuITcspwrpu7X2i14ElaYZkyKkmfVK6ulUgK5BCGVU+8
         SDPbFr1oGGPqQiI+hWAvbbjoeWK+W1WSgEC8IHKhl3GL4LeDlk4bGIWY6rQ/Ft2krMFi
         fx0g==
X-Gm-Message-State: AOJu0YxVsS3JcZC62xJ2PmX/0pz4h5wNJaf02gNKOx8pgfMqcfCx09RE
	AlAw2hZaNngAKY7Ck//Oo4GFcQnymMhAeOGE3KztSadsE1pZcHug0LxPYnMcjm1brdQqolGraGV
	2BYHWZtBsusieBaZgKVhzPDLO+AfjUqW1FL/GVV0Hn4rcW6Pz6Su4BReJ4I6Q0LASlSkU/6qQlD
	VSRFVs6EV3EFz97wRi0wBMOwEKFXDKf1wPeY2E2A==
X-Received: from pjbkl7.prod.google.com ([2002:a17:90b:4987:b0:366:29cd:da0d])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b0c:b0:35f:b5df:463
 with SMTP id 98e67ed59e1d1-367d484654amr11616671a91.14.1778543315098; Mon, 11
 May 2026 16:48:35 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:52 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-7-vipinsh@google.com>
Subject: [PATCH v4 06/16] vfio/pci: Store incoming Live Update state in struct vfio_pci_core_device
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

From: David Matlack <dmatlack@google.com>

Stash a pointer to a device's incoming Live Updated state in struct
vfio_pci_core_device. This will enable subsequent commits to use the
preserved state when initializing the device.

To enable VFIO to safely access this pointer during device enablement,
require that the device is fully enabled before returning true from
can_finish(). This is synchronized by vfio_pci_core.c setting
vdev->liveupdate_incoming_state to NULL under dev_set lock once it's
done using it.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/pci/vfio_pci_core.c       |  2 +-
 drivers/vfio/pci/vfio_pci_liveupdate.c | 17 ++++++++++++++++-
 include/linux/vfio_pci_core.h          |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 1726d4d41b57..da013b4b1e94 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -568,7 +568,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
 		vdev->has_vga = true;
 
-
+	vdev->liveupdate_incoming_state = NULL;
 	return 0;
 
 out_free_zdev:
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 731a3e34085f..7b841a1e7fcc 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -249,6 +249,7 @@ static int match_device(struct device *dev, const void *arg)
 static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 {
 	struct vfio_pci_core_device_ser *ser;
+	struct vfio_pci_core_device *vdev;
 	struct vfio_device *device;
 	struct file *file;
 	int ret = 0;
@@ -265,6 +266,9 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 		goto out;
 	}
 
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+	vdev->liveupdate_incoming_state = ser;
+
 	args->file = file;
 out:
 	/* Drop the reference from vfio_find_device() */
@@ -274,7 +278,18 @@ static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args *args)
 
 static bool vfio_pci_liveupdate_can_finish(struct liveupdate_file_op_args *args)
 {
-	return args->retrieve_status > 0;
+	struct vfio_pci_core_device *vdev;
+	struct vfio_device *device;
+
+	if (args->retrieve_status <= 0)
+		return false;
+
+	device = vfio_device_from_file(args->file);
+	vdev = container_of(device, struct vfio_pci_core_device, vdev);
+
+	/* Check that vdev->liveupdate_incoming_state is no longer in use. */
+	guard(mutex)(&device->dev_set->lock);
+	return !vdev->liveupdate_incoming_state;
 }
 
 static void vfio_pci_liveupdate_finish(struct liveupdate_file_op_args *args)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f..0c508dd8d1ac 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -26,6 +26,7 @@
 #define VFIO_PCI_OFFSET_MASK	(((u64)(1) << VFIO_PCI_OFFSET_SHIFT) - 1)
 
 struct vfio_pci_core_device;
+struct vfio_pci_core_device_ser;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_attachment;
@@ -142,6 +143,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct vfio_pci_core_device_ser *liveupdate_incoming_state;
 };
 
 enum vfio_pci_io_width {
-- 
2.54.0.563.g4f69b47b94-goog


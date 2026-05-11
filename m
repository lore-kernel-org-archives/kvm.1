Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503383A75A1
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543318; cv=none; b=g7OczvRoPuQ56tyDfSXHcWnzO9aIt3Tn7/fUp0Z7fipzrau+zpwuGJNCeY4QChwqgbDKB1dyhDmmYM+XAsqvrgHlnRAgUpRsQP8OAwvApnCSukdiV5jor8yhs7ps89akEw3SSNx0asKaNKJeEoeazFc1fR8TFAuoM6Lch+hDT3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543318; c=relaxed/simple;
	bh=Ddf0Lby4MdD14pq6niokXK/rA0eJRVzLYmia/RpI6xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H8BSSka1wGXO63KjqL0twXhAHP7mr//iGIpazXNBwknKEDkPqgINYKyD6qaGanSuwM+6buR6+6KDlarSO0VDeavAqWcRFH+/LXtg0yeZgve/FXeyOJqxXJkHlzW2tMd2xy5Sy7qgQcxaxOsMFRaBcnH1rqUCRNiaz4a98hqv/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paOEj/na; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paOEj/na"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82751074c8so2978185a12.0
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543314; x=1779148114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5EUY3ZlaySk7yEluRmGCiDPZ2d7y5O8uLlUW0QQA8U=;
        b=paOEj/naC9KSIGYgnctDtpeloG9k7E8iViHgX7L4b7CkWdQCFPj1Ly8qhwAKuIQaPp
         xtuNhQmFjZBPwG4huIH3lsU5U6XGdz1nyHckWCkGZCBNJG4JiGOcnag6bWtg8CD2BB4x
         tN+Xqh6/C7ng/7iLwr/h+nt57WHEu7yd9h+2fZnf5+FNC90WqaIZrdHoMzYdttO6ROx3
         wDzu1ulbvJUgKA33t/LnKA8CvL37uTkdBZA82e4fN96ES1sJju26QjHl37kMGH/MAgVd
         tin00xL9tagafhNlbu1hFz7ffWH9Lp26wsoRgEcXKPY52wuDjHO8GBcX/SMSM+AZcICA
         Z2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543314; x=1779148114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5EUY3ZlaySk7yEluRmGCiDPZ2d7y5O8uLlUW0QQA8U=;
        b=mK1esr6XWrvq8LC3bC67Jdr65AzRc5NKxrnUrrU/EyfJSbfpBSz1uV4prwxT872LU7
         mNtT43Su045p1NO92nXhm9lTviwdfHmiL4X46xJ+9xxbEX4Ze2+ZR03qEGpgj87DQcgm
         rIRcJwZPBizevnMpnd5CBRaYqZmm0V3lhtQoGCXR6W/O29WQif1V1jljkZo3F39jUS3z
         DmyCwwnn1aFTlhtf8JcgKatR0OzrHcyvHIxzxUPCRZ6NRxfsYi2v2H1orHn6pONZzyki
         eV8jsK4Msm92Aeu8SVEpdGRu7ut66RFEb4rqHzJeNJJvIGLWfMHWNEJZLe368IQi/ToA
         fqyw==
X-Gm-Message-State: AOJu0Yw6W8QQEWJ+7vTN6ZGAdJOJQ0w/FCTc5R2KuXhVcSQGeTaniNgi
	zp/xu82nUaXKFl11urU5JxxnzWpZC+/or4H56xPT6llVn9M2WKvvNfD/ZG4140uwYtpp/bQ6v5k
	HnUGnCBQXe4SEg2mR/pquNFovSjCPiCooBS5lLP6qAfWyKGGOV5mudFqkJlgp96UbDI34kibO5c
	p0DkgFI4Scw6vNuodUGzwV2sQEOjp5xixY9+vjug==
X-Received: from pgbcq5.prod.google.com ([2002:a05:6a02:4085:b0:c79:8a8e:b046])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a1:b0:39b:9644:6e94
 with SMTP id adf61e73a8af0-3aad425fdf0mr13009821637.9.1778543314037; Mon, 11
 May 2026 16:48:34 -0700 (PDT)
Date: Mon, 11 May 2026 16:47:51 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-6-vipinsh@google.com>
Subject: [PATCH v4 05/16] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
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

Enforce that files for incoming (preserved by previous kernel) VFIO
devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD rather than by
opening the corresponding VFIO character device or via
VFIO_GROUP_GET_DEVICE_FD.

Both of these methods would result in VFIO initializing the device
without access to the preserved state of the device passed by the
previous kernel.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Co-developed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 drivers/vfio/device_cdev.c             |  8 ++++++++
 drivers/vfio/group.c                   |  9 +++++++++
 drivers/vfio/pci/vfio_pci_liveupdate.c |  6 ++++++
 drivers/vfio/vfio.h                    | 18 ++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 1ab07ccaf3ab..4df0495941c6 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -49,6 +49,14 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep
 		}
 
 		*filep = file;
+	} else if (vfio_liveupdate_incoming_is_preserved(device)) {
+		/*
+		 * Since it is live update preserved device, it must be
+		 * retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD instead of
+		 * opening /dev/vfio/devices/vfioX.
+		 */
+		ret = -EBUSY;
+		goto err_free_device_file;
 	}
 
 	file->private_data = df;
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..62b4eaabc829 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -316,6 +316,15 @@ static int vfio_group_ioctl_get_device_fd(struct vfio_group *group,
 	if (IS_ERR(device))
 		return PTR_ERR(device);
 
+	/*
+	 * This device was preserved across a Live Update. Accessing it via
+	 * VFIO_GROUP_GET_DEVICE_FD is not allowed.
+	 */
+	if (vfio_liveupdate_incoming_is_preserved(device)) {
+		vfio_device_put_registration(device);
+		return -EBUSY;
+	}
+
 	fd = FD_ADD(O_CLOEXEC, vfio_device_open_file(device));
 	if (fd < 0)
 		vfio_device_put_registration(device);
diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c b/drivers/vfio/pci/vfio_pci_liveupdate.c
index 11c3bc8a8dcd..731a3e34085f 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -47,6 +47,12 @@
  *   ...
  *   ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, ...);
  *
+ * .. note::
+ *    After kexec, if a device was preserved by the previous kernel, attempting
+ *    to open a new file for the device via its character device
+ *    (``/dev/vfio/devices/X``) or via ``VFIO_GROUP_GET_DEVICE_FD`` will fail
+ *    with ``-EBUSY``.
+ *
  * Restrictions
  * ============
  *
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 0854f3fa1a22..5269fe021ee3 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -461,4 +462,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return to_pci_dev(d)->liveupdate_incoming;
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_PCI_LIVEUPDATE */
+
 #endif
-- 
2.54.0.563.g4f69b47b94-goog


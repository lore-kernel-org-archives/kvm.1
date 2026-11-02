Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633833;
	b=OLygw0hDt3eM8Q9YnXI9/xmN+HQK9NxnI/nfoL1rJ7mJEMxrGAqNfwoA4K4Z5GDYllFr
	 JD5+fUDF+6nizCUsLiRnPHkwseD0khk6FsAAInzszX4hfhhdzMhoebIG1z7scKaPpTKpx
	 dtH7V8SWpCA7bSpsoefs6wjsSgsup3ewhOhDfeCFSv7p5/tXgUEYcBWZI0NoJpclNImTC
	 D2KjddciYnnAvAI/Ka4dlDmC9ryFZ4PGE3kDtZM+oXYRmH6ePzAy7BeRdhnjh0w4RH+4L
	 uYN89lRJySjFjU01Wzor2f3OcNcQevBo+o0wSFpNxFU+mvHQBTerfLwy1IiGfs/tDeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
	b=Fx0d/ydWZs4YlRDu9+H3yUE8056SoSgvf2gnksV6OcqIx1YFIhI6AmCnSU7P5uLWSn6/
	 zsKZkRThI9QX9bCZvCx4yITOCYuS/MAaxVwKNjkZlG+LmgkFtSIHO5rQU3KjpvEuUGnwK
	 r7aOUFi+gDOw5MMhtZaY3mr6ZuMrdl0mOpXL+BMdL3P6ox151a1oY+h0fZLJ3zmIGFBDA
	 dZqsOSFxPA5mn8d0F9QDmF1ZvbfDn0qMgNkr5riuI4e58ad6avPRu0Lb6a6w4EylUleNR
	 Irkz6SbLAtnhhkiQtcQ3v5XAmo+lHHkfQUWjrqGfeg2UbyW52nUmrdTaQef8m6VKDzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OOoLULKt;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D160E6E51
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 724D160E6E51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OOoLULKt
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd3b9e70f88so3414245a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633833; x=1794238633; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
        b=OOoLULKtlquOo1hW/AmHaG5FsQeivEQrZb86orM8Uwr5rOr6omi+/3iadCq7mNqOO1
         XljI7RfadAnR5LvZE8sdlhGrGm7ovH1YZchOD+n2oEdVDwI1s4iPidqSm7AnqLNneX1J
         +19jmKdtOW/0IT9T+eUJSqR4B1jrAI1gc0IPi7/hiW+AFxh7LkF8GjPdKXH6YhhCWNtV
         Z/lr5wNh2KLIgibplLjpCnHFotSkYKRjnxsu3uTadvcsHqt+h9j1nYYXy0V8Ayodtieh
         GBaa8eAzMECdepVHl0ZN+7QCof8/aDsVoHEN/NF7jgv/oIWJ/c4wL25TQC+PNWSJZLhV
         bCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633833; x=1794238633;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ym/wrmWFSlmP/Qd42BcsAsFY9ji592OmGMgA89zOpEo=;
        b=Se5XXRqyOCd9Imtsfm+4g7U5XUSLQlXobWn/hS3AW1OR7M5OPP8HpW07cUlXqYGGpv
         OjynefVKYnaXzU6fjQfqIcPs37H8XCRu5Cy6lZAO+9DzrjVetY+06p57iT24CQwHVxee
         yDuoMVTjzcEM/xEc2nOFus5iY+Pccda0W578+FDuWYrYFo8vcOiuUpbYUCFxIKLkx3Eo
         husJaaCgDoXUndFSyVCazD0Dqle1xgGJmInLOS/jmeKD57/WjlIevyFLwJdncI3qUJYW
         N8U2nlgtKrrzCfIc9dRTeJlzR7ntdVz/WoJwxjJf8CEVpxOxs9GLz2Q4AnheX3hnU0Wy
         1mKg==
X-Forwarded-Encrypted: i=1; AKwUvBxe3NJe42va6KGyztROpwEjV6SOqzoLcLbzfLgtSK+oRUkem2nCPTz+Fs0sEaEUq23tT4E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6u+DJkX2aZQXcMNooCjFPd/R4YHtrcIEkywoMalILczgu2pgg
	nP6sueCupPq4tsRt57jBMTFpBCnBymMii1HsYB7aWJp7IueY6mLsYXc3ZUIqjD6WFradkvTmkBC
	DVbfOyQxz2Q==
X-Received: from plhb8.prod.google.com ([2002:a17:903:2288:b0:2e9:84f0:65ba])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b47:b0:3ac:9f00:3bc7
 with SMTP id 98e67ed59e1d1-3ae8980dccamr9246672a91.33.1793633832641; Mon, 02
 Nov 2026 07:37:12 -0800 (PST)
Date: Mon,  2 Nov 2026 07:36:41 -0800
In-Reply-To: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102153656.1431701-1-vipinsh@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102153656.1431701-13-vipinsh@google.com>
Subject: [PATCH v6 12/27] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, 
	schnelle@linux.ibm.com, skhan@linuxfoundation.org, skhawaja@google.com, 
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
index 38e691eceab5..f0018eae3c4d 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -58,6 +58,14 @@ static int vfio_device_cdev_open(struct vfio_device *device, struct file **filep
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
index f13c757b4567..64810010f983 100644
--- a/drivers/vfio/pci/vfio_pci_liveupdate.c
+++ b/drivers/vfio/pci/vfio_pci_liveupdate.c
@@ -43,6 +43,12 @@
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
index 12557d45dfee..e6ca4c3fda06 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -11,6 +11,7 @@
 #include <linux/cdev.h>
 #include <linux/module.h>
 #include <linux/vfio.h>
+#include <linux/pci.h>
 
 struct iommufd_ctx;
 struct iommu_group;
@@ -446,4 +447,21 @@ static inline void vfio_device_debugfs_init(struct vfio_device *vdev) { }
 static inline void vfio_device_debugfs_exit(struct vfio_device *vdev) { }
 #endif /* CONFIG_VFIO_DEBUGFS */
 
+#ifdef CONFIG_VFIO_PCI_LIVEUPDATE
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	struct device *d = device->dev;
+
+	if (dev_is_pci(d))
+		return pci_liveupdate_is_incoming(to_pci_dev(d));
+
+	return false;
+}
+#else
+static inline bool vfio_liveupdate_incoming_is_preserved(struct vfio_device *device)
+{
+	return false;
+}
+#endif /* CONFIG_VFIO_PCI_LIVEUPDATE */
+
 #endif
-- 
2.56.0.317.g454f8302e1-goog


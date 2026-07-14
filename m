Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AA14A2E35
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042124; cv=none; b=WgObkNdF0VLPcxLo+kT3637jr4SrdKmaEVow/tTjPsC+Z5g02LDxRle99PVksp05EmZj7kWtyy3rnkRiSJrdSpJnnM0nSF7IdQnaCBbyYXMedKT+abvIjIv0rGwvtfIJ/UCWP316H0VEaZN7A7Ozwf0N2co5z4GgCKHgNCvhmEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042124; c=relaxed/simple;
	bh=7r/bDrW/3tccMnKG0Sox3jGGc6LraNqsuBFxlk3AlCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3ZJBNyOA+ZZDAdkmWigCQqREfTz8cIewcGoXxmbpe3IPMEhlreweKyPrQcJwKOzvmSwMuF082O3ZR9iiv1nhVVihqoP+jq7tw7HZd+rs4CLVz4x4lTbLi6xfngn25N6x4t5lfemrGFc3Yt39o33ky1ucDZ4tBv69V6POj1p3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=omkuNMDG; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="omkuNMDG"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so7807890b3a.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 08:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784042121; x=1784646921; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHOmohYTYSD8/2ryEq7eNVyF04S9VyCIkpjOIEDjYJc=;
        b=omkuNMDG56nX5cYtruAlP06g4Dz3SQcY195KR+vy2exrp2lg0UHZkis1JYBFzK9YSY
         i0bcAXBPV+WcKYtGo8aPsO4qcrNdj76isdvHHagy4tWg47MlR01B6KOLiUB8cKzCmnyK
         OX7dwnb789/1O+y9iQjgJOUDXMaOpXDw+a5DUBmDkfNoKZ+GfXs3GBAu1NinlplSqBwX
         wFhOth0IqjWQcgmSrf2DS6UWl1KODeI0czSDWI+c/bzwBtnNGBLxy3jcr2zbSwgEoFMk
         wVgghz7Z1rLmYASz0TE0dEUMbG2h+EM2rccIBJKOLwvQO2TEAlNjcN8K84mitYkY/MD1
         KvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042121; x=1784646921;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DHOmohYTYSD8/2ryEq7eNVyF04S9VyCIkpjOIEDjYJc=;
        b=WjXzShQnRoFUxKBURaBU1TmbP4UDiw82LgepFF5uotachT9kA0I6Nuvmad9UlB230F
         BsDrMERZ72GiJJc4rXLE0XwGStQkimQlh2CfEYPJcVjxPjzUnuYeMG2mlv6frjMvc/qq
         dHmplxu3uB58EevXLUXZOjsDWcaFRQjqUh6Mx8pyDQ4i5SveOsm92TFrH+dbC6jgn7oh
         hpTH6qvFITPz4vQoBjhcVc0XarGar2oYSHJF0z3/X43gXOnyWoMJBP5JuTHF2zin4B+h
         CHDGJaXTQCeixh3OUXnob57KWKf5n/qNKD3Q/cKgOfVAlrG84+crCxB1N12iqoBRkk8s
         FIzw==
X-Forwarded-Encrypted: i=1; AHgh+RoVpiTUb8Y4BnKdpBHjE04bOxSlbBoXLtgKenV0W90j9t9pyrv7vEaY4GZP9ihfCD4Sitg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSJQ9mtVRb5GuN6W/90dQSVYeXEMcYTq6Q6PFqGfk/WmlqX3pT
	NTGCsvS7VvsOIGkNXakWk/L9er0pX2Rhe1Rp4Rkld/58NVqbh4lwRuE+BCutuQ3LcmxGKnY+lu8
	5QzhXFPwIKA==
X-Received: from pfux16.prod.google.com ([2002:a05:6a00:bd0:b0:848:8b16:23d6])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d19:b0:848:76af:db37
 with SMTP id d2e1a72fcca58-84889611b82mr12946882b3a.7.1784042120956; Tue, 14
 Jul 2026 08:15:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:14:56 -0700
In-Reply-To: <20260714151505.3466855-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260714151505.3466855-1-vipinsh@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260714151505.3466855-12-vipinsh@google.com>
Subject: [PATCH v5 11/20] vfio: Enforce preserved devices are retrieved via LIVEUPDATE_SESSION_RETRIEVE_FD
From: Vipin Sharma <vipinsh@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Cc: ajayachandra@nvidia.com, alex@shazbot.org, amastro@fb.com, 
	ankita@nvidia.com, apopple@nvidia.com, bhelgaas@google.com, chrisl@kernel.org, 
	christian.koenig@amd.com, corbet@lwn.net, dmatlack@google.com, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, 
	kevin.tian@intel.com, leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, 
	mattev@meta.com, michal.winiarski@intel.com, parav@nvidia.com, 
	pasha.tatashin@soleen.com, praan@google.com, pratyush@kernel.org, 
	rananta@google.com, rientjes@google.com, rodrigo.vivi@intel.com, 
	rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vipinsh@google.com, 
	vivek.kasireddy@intel.com, witu@nvidia.com, yanjun.zhu@linux.dev, 
	yi.l.liu@intel.com
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
index 970932f22ecb..0050f0fe456b 100644
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
index 4baac80d03f0..f0ea37d98696 100644
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
index e4b72e79b7e3..496180950eb6 100644
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
2.55.0.795.g602f6c329a-goog


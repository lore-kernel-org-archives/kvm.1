Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E14963BD
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016529; cv=none; b=Hf8f/BSXrRQJzpP2nGq+erndZUSvTSzpGlZBJKsoFZr1AZL6FH2qFK0q81ZW3IBGUYfwBONEaRXUGQs4P57Par1Hz1t0KXjtAg+44IW7yFfaR9jy/0c1fBWs9PRf4EZU/vNF067x2EsBsZqcsURMp1F0Zl2fyE6Q5u10AgX0rx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016529; c=relaxed/simple;
	bh=vYDCQu3hcomQSugSfAjIukmGYxxUvvzFcXYHkbRSEB8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BB5wgDsg18lpaJ6cxwoTtpbWU3FyrVDWJ8kC8VFgknXGDoT90Z6jpIbp6rMjZY3k1HxRHqTwbkfrHMESHyUxHpJEvf0KJdrsaOaEq7z3tIF6JEXh3TU/FFWohLJXn0xGAXp3CwtddKPtUA5F+938DnK56OeTyrZ+cOP80p0DJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENUOZS4G; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENUOZS4G"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-68e924f632bso11267994eaf.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016525; x=1778621325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91qp2yf2pBn59DztCHuRcXM+/bOVP8MbUY5pGcMns7Y=;
        b=ENUOZS4Gk+pHsLfuY+Rt4SphrFECI0+h7f9EYX5v5UWPa2Z8i4ZKaJ9Jy1+Rbu1DV4
         e++hxVSWzeeaNN/FyZ6vsh+0xTjvH1sgnJ64Pyo6negrUC5q+glZk0SzQMPhjLHCo4iF
         d6UjM5Iz/SVZcP9ZBMZQAdJY49BDwZcSNFEsJC2nreZbYI+252zvtP2KvAle9W98HZ2r
         yPws/fYRHwWT1PBTfSGA71WHutdd8Y/cFpzXy42iZp1ehrOP/zTxUcBev9PXRdgENU+B
         xDsn33C1tt5jeczSVMIIwArpjHLmfqtTM7995nBuK3lv3rE5j0LS+H0JIDbMNG08Yr3d
         kmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016525; x=1778621325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91qp2yf2pBn59DztCHuRcXM+/bOVP8MbUY5pGcMns7Y=;
        b=OZhCGaEuv4u3y7Ka3YN+BB9+SD4Q2XDRSPPgu8/2Zi7Yke7uasChw/0scLx5y09fzz
         m2QJLyGskmDf9bStoiS5OpWkpr59rbfQXorJv+MOISzuwj5b/lfjwIRqhEkLqCZrxpGk
         YSiE8guBVzbWU17rlv/ts6/JnX51z2zoYCaWF/TbW9qt9kL98xKoJFI0SNzU1fj5orDV
         vVj/Q2Ndn0JIjigpcbiyBarWB1OsqFHFjZZldUucVrsZq2KiWNJ+uL2xsvsiFDVz7Bph
         XdprJup0ywaH/2M/3M0e/kT65VAiAPTeXVVt1nDzeNJFwPsk0WuLNsSCFHOcLWBUmb9Q
         KfMg==
X-Forwarded-Encrypted: i=1; AFNElJ/WC4mTUhfvOrZ9TgiagAcmBs8iH2Vy2XJxqXA/6/1ju6UFcVEzgWLxfhgV744qTZauNhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOxXpL/i/oXz1RVG0FAFmCvRFXEGj4bGOnkxlqSGgWz+Vdl0V
	TyHaWaKmsZ8snUICmjncKEoRt/ao7PfGvnOjAUo84ZvMVFjfFI2LScv1ALm1s3373nT5Xxla5VM
	3fdIc1LuRAQ==
X-Received: from ilto2.prod.google.com ([2002:a05:6e02:922:b0:4fa:21bf:973b])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1789:b0:695:a638:c6ba
 with SMTP id 006d021491bc7-69998c8c89cmr395270eaf.7.1778016524970; Tue, 05
 May 2026 14:28:44 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:35 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-6-rananta@google.com>
Subject: [PATCH v8 5/8] vfio: selftests: Expose more vfio_pci_device functions
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor and make the functions called under device initialization
public. A later patch adds a test that calls these functions to validate
the UAPI of SR-IOV devices. Opportunistically, to test the success
and failure cases of the UAPI, split the functions dealing with
VFIO_GROUP_GET_DEVICE_FD and VFIO_DEVICE_BIND_IOMMUFD into a core
function and another one that asserts the ioctl. The former will be
used for testing the SR-IOV UAPI, hence only export these.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  7 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 47 ++++++++++++++-----
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bbb..898de032fed5a 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -122,4 +122,11 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
+void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
+void __vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
+				    const char *bdf, const char *vf_token);
+void vfio_container_set_iommu(struct vfio_pci_device *device);
+void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf);
+int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index e59b6689f4576..53e01cdb2b4e5 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -204,7 +204,7 @@ void vfio_pci_device_reset(struct vfio_pci_device *device)
 	ioctl_assert(device->fd, VFIO_DEVICE_RESET, NULL);
 }
 
-static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
@@ -224,8 +224,8 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
 }
 
-static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
-					 const char *bdf, const char *vf_token)
+void __vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
+				    const char *bdf, const char *vf_token)
 {
 	char arg[64];
 
@@ -240,18 +240,21 @@ static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
 		snprintf_assert(arg, ARRAY_SIZE(arg), "%s", bdf);
 
 	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, arg);
+}
+
+static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
+					 const char *bdf, const char *vf_token)
+{
+	__vfio_pci_group_get_device_fd(device, bdf, vf_token);
 	VFIO_ASSERT_GE(device->fd, 0);
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device,
-				     const char *bdf, const char *vf_token)
+void vfio_container_set_iommu(struct vfio_pci_device *device)
 {
 	struct iommu *iommu = device->iommu;
 	unsigned long iommu_type = iommu->mode->iommu_type;
 	int ret;
 
-	vfio_pci_group_setup(device, bdf);
-
 	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
@@ -261,7 +264,13 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device,
 	 * because the IOMMU type is already set.
 	 */
 	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+}
 
+static void vfio_pci_container_setup(struct vfio_pci_device *device,
+				     const char *bdf, const char *vf_token)
+{
+	vfio_pci_group_setup(device, bdf);
+	vfio_container_set_iommu(device);
 	vfio_pci_group_get_device_fd(device, bdf, vf_token);
 }
 
@@ -323,8 +332,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-static void vfio_device_bind_iommufd(int device_fd, int iommufd,
-				     const char *vf_token)
+int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token)
 {
 	struct vfio_device_bind_iommufd args = {
 		.argsz = sizeof(args),
@@ -338,7 +346,18 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd,
 		args.token_uuid_ptr = (u64)token_uuid;
 	}
 
-	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
+	if (ioctl(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args))
+		return -errno;
+
+	return 0;
+}
+
+static void vfio_device_bind_iommufd(int device_fd, int iommufd,
+				     const char *vf_token)
+{
+	int ret = __vfio_device_bind_iommufd(device_fd, iommufd, vf_token);
+
+	VFIO_ASSERT_EQ(ret, 0, "Failed VFIO_DEVICE_BIND_IOMMUFD ioctl\n");
 }
 
 static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
@@ -351,15 +370,19 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
-				   const char *bdf, const char *vf_token)
+void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf)
 {
 	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
 
 	device->fd = open(cdev_path, O_RDWR);
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
+}
 
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, const char *vf_token)
+{
+	vfio_pci_cdev_open(device, bdf);
 	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
-- 
2.54.0.545.g6539524ca2-goog


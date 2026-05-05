Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59720494A1D
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016527; cv=none; b=ceZKCbQKwxwRxgiA3HTh8pTK0qCSIObsCvGm5rWuL4Ut+8KsPaxYCRjNRHcLshzX5LfWudPpOnwYpWyeKD1fxRI1GGy9yWdvBmXhh/pVXCwh5dlXKeKXUtEjQlAIRBZvAOQY/luLJ0XPS833Vh1Fr46duv5GNjHbDvrqqP4qEuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016527; c=relaxed/simple;
	bh=GB4ku3pK7qy2Q3fNgcaU7TIQGx6FeyMOCfJZAay7Ke4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yf/bX7C5/ACqCKcgmB67xeagbNiq0UUbf4mWh0shLQ4sF0Po/k+n81YlT3/VNaApnAdGGKrD5e10DBpTmik67dKQYcHRMfSzZZNVvc/btjXi+z5PhWweubRYuXu9HssIs2kPLsKZtLFtdDyfcnAtBSfSwucSc5FjZ8ylvGhGRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2FJwQ/f; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2FJwQ/f"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-695391d14acso6675961eaf.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016524; x=1778621324; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XN1YjqFohZ0l8R/PyhFFwsCbsJd+viLRi9YWcXkC5ec=;
        b=e2FJwQ/fYkgPmo+VyNiSVPePRFaenEQVgvTBRqGZiWF2EHzFX5yfqlQQBFpvRIjyl9
         qZX4SD+cUQB3x3xZ7L8KBfOeBuxi86I2N5OITD5j23I/43l/IY2oqWasfVr9IOa7Ibet
         IL8Z2UmIIAAmPZJFi3S5VrA8Y3sBcEWGZWO69bImBvtv6W3ElCnUMj8uge/6QSq+ublV
         LY+m/HZruGkHFZwLpd/QNGJE/tvyj6Kf7z0z6zkDYJI12kK3ZjIcI/XrYLeKPGlitQy4
         UX2q2kE1yQaLzpleJk+Bnq6uU3/EpY1DlSBaKS1sV/CmbXaVIARse95JApa98XeUv9cD
         jBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016524; x=1778621324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN1YjqFohZ0l8R/PyhFFwsCbsJd+viLRi9YWcXkC5ec=;
        b=h7NGVjewTNu537lEEw5oIdZMlG/xqVTe/Su5AMQ9gL0j85wd5gl3ePQk3uHk6GFBmH
         IXS6fiXhhUNv+NXTURYmYBALyNKXPhIBhq3jh8KOkhh4jC/GlrHeERQq35ffJyQvtAZN
         f0lE2gpxVjU04lFwZvJH04/U2n/NAuf0DnYIWqNjYiAoiDhWwuHyacnaH1Inl535USZP
         SAlIzv7UxKAiGSdutenQ2niUfIIF+exeGKSxxsmSv48tplAkCWRveVZ+AeU6eVg0h435
         /gHiu65R3vVzkYo4+C2+ksKHauUPNgThWJc5dGIyS6XwNt9m0abmOJWnuR+ALfdY1PHH
         cYQA==
X-Forwarded-Encrypted: i=1; AFNElJ+Rfb0J8RNLOSd3ayj21u8ldq3B/aaC2x/Tjrz/ZoUEXfbjTeCtIcMZhA876QOUVuk5CVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQ8jtPIBOj+cn2UFU36E9fr78yi7LAu3bk13IUfs17+gQoQR3
	XZ1jpvVICPd/D/ndrrHGHKF+mdGB0Z5U/7vFNSwDFYMZaOAM4/m42BP3y9mn8j1aOy+5t1S/UQS
	72yzU5j89xA==
X-Received: from ilmx7.prod.google.com ([2002:a92:de07:0:b0:4fe:76d8:c6ad])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:4c06:b0:694:a1d1:f363
 with SMTP id 006d021491bc7-69998cbc264mr348924eaf.15.1778016524166; Tue, 05
 May 2026 14:28:44 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:34 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-5-rananta@google.com>
Subject: [PATCH v8 4/8] vfio: selftests: Extend container/iommufd setup for
 passing vf_token
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

A UUID is normally set as a vf_token to correspond the VFs with the
PFs, if they are both bound by the vfio-pci driver. This is true for
iommufd-based approach and container-based approach. The token can be
set either during device creation (VFIO_GROUP_GET_DEVICE_FD) in
container-based approach or during iommu bind (VFIO_DEVICE_BIND_IOMMUFD)
in the iommu-fd case. Hence extend the functions,
vfio_pci_iommufd_setup() and vfio_pci_container_setup(), to accept
vf_token as an (optional) argument and handle the necessary setup.

No functional changes are expected.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  2 +
 .../selftests/vfio/lib/vfio_pci_device.c      | 46 +++++++++++++++----
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e26917ee169c5..4437f04660089 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -28,6 +28,8 @@ CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
 
+LDLIBS += -luuid
+
 $(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 80e8e5bebd7ca..e59b6689f4576 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -22,6 +22,8 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 
+#include <uuid/uuid.h>
+
 #include "kselftest.h"
 #include <libvfio.h>
 
@@ -222,7 +224,27 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_group_get_device_fd(struct vfio_pci_device *device,
+					 const char *bdf, const char *vf_token)
+{
+	char arg[64];
+
+	/*
+	 * If a vf_token exists, argument to VFIO_GROUP_GET_DEVICE_FD
+	 * will be in the form of the following example:
+	 * "0000:04:10.0 vf_token=bd8d9d2b-5a5f-4f5a-a211-f591514ba1f3"
+	 */
+	if (vf_token)
+		snprintf_assert(arg, ARRAY_SIZE(arg), "%s vf_token=%s", bdf, vf_token);
+	else
+		snprintf_assert(arg, ARRAY_SIZE(arg), "%s", bdf);
+
+	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, arg);
+	VFIO_ASSERT_GE(device->fd, 0);
+}
+
+static void vfio_pci_container_setup(struct vfio_pci_device *device,
+				     const char *bdf, const char *vf_token)
 {
 	struct iommu *iommu = device->iommu;
 	unsigned long iommu_type = iommu->mode->iommu_type;
@@ -240,8 +262,7 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
 	 */
 	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
 
-	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
-	VFIO_ASSERT_GE(device->fd, 0);
+	vfio_pci_group_get_device_fd(device, bdf, vf_token);
 }
 
 static void vfio_pci_device_setup(struct vfio_pci_device *device)
@@ -302,12 +323,20 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-static void vfio_device_bind_iommufd(int device_fd, int iommufd)
+static void vfio_device_bind_iommufd(int device_fd, int iommufd,
+				     const char *vf_token)
 {
 	struct vfio_device_bind_iommufd args = {
 		.argsz = sizeof(args),
 		.iommufd = iommufd,
 	};
+	uuid_t token_uuid;
+
+	if (vf_token) {
+		VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
+		args.flags |= VFIO_DEVICE_BIND_FLAG_TOKEN;
+		args.token_uuid_ptr = (u64)token_uuid;
+	}
 
 	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
 }
@@ -322,7 +351,8 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, const char *vf_token)
 {
 	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
 
@@ -330,7 +360,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
 
-	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
+	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
@@ -346,9 +376,9 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
 	device->bdf = bdf;
 
 	if (iommu->mode->container_path)
-		vfio_pci_container_setup(device, bdf);
+		vfio_pci_container_setup(device, bdf, NULL);
 	else
-		vfio_pci_iommufd_setup(device, bdf);
+		vfio_pci_iommufd_setup(device, bdf, NULL);
 
 	vfio_pci_device_setup(device);
 	vfio_pci_driver_probe(device);
-- 
2.54.0.545.g6539524ca2-goog


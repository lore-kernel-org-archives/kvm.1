Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEE3F0AA3
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151069; cv=none; b=Q9hmIPWOTZoOGdy8jEWeJnZR3Rwjbl4dgw5wz6Co1hua/8mD/i+UQ8KszFU/zSh7zUhwW590HNlFP793a5wbf43k661GuCE+pB1pg03Pwzz4NLDogBwQfJyadDhaxUG1aaGfvXvzhehr+9xJrKrgQi/oK79tFvnG6AFORR/5fhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151069; c=relaxed/simple;
	bh=aioNoLlDzw5Q8eJ+PJale07yZdVO/sraFRI5eymlHV0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZEFSlutQ0ihY17bNt3wVNEmpNJ7jUCkva8+z2MZtVzqTpz49kyZ7Y3gWopbvvdSkxlqh3lW4AnoYQ/cLYW3eXnLHEuCOT/qHkkRpKUZlcODGiYtMIPbtJLIaFlqAzI63PaDkIOZJEtHawr/77vx34pq3MXCAGLQ0YFJjRrogElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFJh5Hjs; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFJh5Hjs"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-67e07123bb5so2064472eaf.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151067; x=1775755867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LjG0Gd3MypaxsBilbokFGxAV+Zt5lu/q3yDnocf8EBM=;
        b=pFJh5HjsTimr1bWreO1wTldCTRrcdYbOd9pD1xzhINYvkcXcaVmMLD9EMUP1iOdsy2
         UuzAKV1bBnP1QEjxwKN1SSkDncjg4iinBPPm5I/5YBqvG2gvDjkytjPtPmBmzHXwMXCJ
         hFVdTKdMHTqhf2DaFdk34aPmdIViK0ywshOx7nf5A9fvSOt5GY5FZVfbV+j2JeyIgUoi
         k5QbZ1X5/2rar7vpNTe6puNGmy5VdZiIvUKcZl0SgjxhvsSEb/WH8rIi+RSYiHLDkuxW
         +m5LbJhUTADuE/Ec3ej5woRsFMBMzoOJp29J5WuF/LkbCiPCl7VH7afmS509gONp7++5
         7+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151067; x=1775755867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LjG0Gd3MypaxsBilbokFGxAV+Zt5lu/q3yDnocf8EBM=;
        b=I0BYBwEv8P2Gey8EhXebJ7iqf6rzcyHLTpim9np/5x+ozBZXePBqp6X5hYY0JyTsue
         YE+YA6OqTm+YIFtn5Opdk2kApA5fceB/iUuSInoWXMBRb6Wm6y7AlIRpaRGowh69C7iq
         W8cbEIa8R5/9VvWrBAbiGdy5c1DbIS8CJmBbPkon192V8cJxIItNd9r36/OHaDbzrVcq
         RYG2rDDLmX8ZBC6leEnOf/o7SEXyBzVtdw8wb1/IvUXqBXkNIzny9Se4x4VIvMZ0Rc/4
         fbEiYSCJ0fBW6xTacJjToL0ntLpQGpdZXJ0mGxjrbrjaOAdh3W8f/rT1P7myJtMILI3i
         UirA==
X-Forwarded-Encrypted: i=1; AJvYcCVNyQ3c67v5iTr+zk/OfTJr7/TkVfncJWs0V0ffng0NTh5x0uAxwEla0KIOTviZhlSOfyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHm35Heik8GB6HMefF0kG5dJ+9+xRjCWUISfJ+E6EaRWVPCbs8
	ekk1JP94AgObkGyftlSkdxBZnQx3B5amYRrn34QOHQY24z9/5rFQqfxo9cweB592unrZ8hADXPM
	cuh/dbXBO8A==
X-Received: from jakz8.prod.google.com ([2002:a05:6638:3188:b0:5d6:5cd9:76c7])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1614:b0:67e:2c8:c0c0
 with SMTP id 006d021491bc7-680a8548985mr2283825eaf.58.1775151067129; Thu, 02
 Apr 2026 10:31:07 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:55 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-5-rananta@google.com>
Subject: [PATCH v7 4/8] vfio: selftests: Extend container/iommufd setup for
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
index 6a9ac6dd32cb6..f27ed18070f14 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -28,6 +28,8 @@ CFLAGS += $(EXTRA_CFLAGS)
 
 LDFLAGS += -pthread
 
+LDLIBS += -luuid
+
 $(TEST_GEN_PROGS): %: %.o $(LIBVFIO_O)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LIBVFIO_O) $(LDLIBS) -o $@
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 82f255f0486dc..dc8b37df8d1f1 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -22,6 +22,8 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 
+#include <uuid/uuid.h>
+
 #include "kselftest.h"
 #include <libvfio.h>
 
@@ -220,7 +222,27 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
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
@@ -238,8 +260,7 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
 	 */
 	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
 
-	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
-	VFIO_ASSERT_GE(device->fd, 0);
+	vfio_pci_group_get_device_fd(device, bdf, vf_token);
 }
 
 static void vfio_pci_device_setup(struct vfio_pci_device *device)
@@ -300,12 +321,20 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
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
@@ -320,7 +349,8 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
-static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
+static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
+				   const char *bdf, const char *vf_token)
 {
 	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
 
@@ -328,7 +358,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
 
-	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
+	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd, vf_token);
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
@@ -344,9 +374,9 @@ struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iomm
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
2.53.0.1213.gd9a14994de-goog


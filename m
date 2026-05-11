Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6D3D1CD2
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778543327; cv=none; b=V7S7oMPICxysxFLGtfjmkpBGTjykAv1PO0xOYITtDjfypkpB5d9QLqvT52Wygx5nJYHvqw5A074CY63ZvcN6VJvRJ7Q+iOjeKMXQNIOOW4KD4076JeVQ7cwPXfZg4UesjXGBn2qVglSvkjc3pmq5Ha3EqzvD3/riM/oGyQqN+G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778543327; c=relaxed/simple;
	bh=K2g0rDAceRP3rk+ss2Z6d44PvotU5vQgbAUUB2teEOg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A14apJcCZRwZOLHnRkJGcxN2yjNMZiCu412Kh2eyhSJumbvIdUzVpBm/rr3TmrbqaLbufvLxsaLiv7pi4Q7zPhmYnyUp1jw5kUL+eXeZ0kq5ZVVh70AT6fpx/785ycWlNByoPxmmBwIVW5wLCvd6DZHbbDTjR8X9tXAGx7xJdjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwJnxVsk; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vipinsh.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwJnxVsk"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso3036446b3a.3
        for <kvm@vger.kernel.org>; Mon, 11 May 2026 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778543324; x=1779148124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W808toPe+T7JqWu8fRVTH+oiRJhlVase5UG9iYYX56M=;
        b=NwJnxVskMtEFGiaL9mSWZY/695stgAoF68wDpqA3guBfcx86d1ukS1+W48bdRRjT/Z
         EeuUyPqzojgP5A+ZKYqTxDCGgH2mSaqtDPpjW43fnqn+kjCf2nb5IpeNODP1/Z4eQXE8
         ZKDjgjOCEjeS4daBgg0jSroSmacWelA9Kw0LawS5Pvq9SJoIDoMmYbWgOBhgnGa/kbs+
         NCVQTwrdfVLMUTzwDPAsVZSQqiG9KjsunAhbgwi6kS77IzvZx3DOBFRpYxkKmoOJwjyg
         8TvN4v1RA5IF/tpraXypjtLqvWDtsPYPeuqQ4IfWqSW8RavxtndX4sLVWwUy1Ni5HnTk
         Lpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778543324; x=1779148124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W808toPe+T7JqWu8fRVTH+oiRJhlVase5UG9iYYX56M=;
        b=HRsygoDV0X2/6nzc76m+r7mOFdRGQ6Un7//YvHpKh1qhFZOeb0QxPWWw1Spv1+3gYN
         p2pUIg3L3dF2YfUvYQqSGNJzZLK0z0GOmmY4rDPHczGqYzQx3/JkLM63hN27bV8ZqjKW
         rGBvuLnilXneL7/gIm/DYwWROf4RiLKz7B6/8yAf4EocmUteQiwBsDDHkdNevaQwE+Os
         1lH40FMROacVFw3XfSqW6vj57DHwWRvcaokwuAX2yJGiot5210+4/Yc2CG7F5FBcqwJv
         dfK7Tbyz3t2EvTks/XH+RcIx3wXHu9hlLj8IXXDHD4cFY/7LUTJqHcgBUTVKotFGfubW
         hQxQ==
X-Gm-Message-State: AOJu0Yw7EujQDiwrmg0mIaGDej70d+wabXOwLFA8mekqsRZ/cyAXTAdU
	UQyHuVJKqoyjgrSVCJFTjiJtFHsMmAMmZAZeehmrvsQZbLs3uYeGL9Na2MhHM2sWdngv5t1BRDB
	8c9tAL51aHOhwDOcVOAyEYj1hEckT/l31AhGkGznABXZFGbNrwCtG5trkN0Bxh6QtVyP1HgfHRY
	QtfUawbmTUsHN+yvQ9CLGcEqq5MsWqjPguq3aDNA==
X-Received: from pfoc11.prod.google.com ([2002:aa7:880b:0:b0:838:5125:b5e4])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a203:b0:835:4447:69d8
 with SMTP id d2e1a72fcca58-83cf6a3a65emr15561909b3a.30.1778543323193; Mon, 11
 May 2026 16:48:43 -0700 (PDT)
Date: Mon, 11 May 2026 16:48:00 -0700
In-Reply-To: <20260511234802.2280368-1-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511234802.2280368-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511234802.2280368-15-vipinsh@google.com>
Subject: [PATCH v4 14/16] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
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

Expose a few low-level helper routings for setting up vfio_pci_device
structs. These routines will be used in a subsequent commit to assert
that VFIO_GROUP_GET_DEVICE_FD fails under certain conditions.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  5 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++------
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 896dfde88118..2389c7698335 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -125,4 +125,9 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
+/* Low-level routines for setting up a struct vfio_pci_device */
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu);
+void vfio_pci_group_setup(struct vfio_pci_device *device);
+void vfio_pci_iommu_setup(struct vfio_pci_device *device);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 7a81edb3245e..3152196261a2 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -222,7 +222,7 @@ static unsigned int vfio_pci_get_group_from_dev(const char *bdf)
 	return group;
 }
 
-static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_group_setup(struct vfio_pci_device *device)
 {
 	struct vfio_group_status group_status = {
 		.argsz = sizeof(group_status),
@@ -230,7 +230,7 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	char group_path[32];
 	int group;
 
-	group = vfio_pci_get_group_from_dev(bdf);
+	group = vfio_pci_get_group_from_dev(device->bdf);
 	snprintf(group_path, sizeof(group_path), "/dev/vfio/%d", group);
 
 	device->group_fd = open(group_path, O_RDWR);
@@ -242,14 +242,12 @@ static void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf
 	ioctl_assert(device->group_fd, VFIO_GROUP_SET_CONTAINER, &device->iommu->container_fd);
 }
 
-static void vfio_pci_container_setup(struct vfio_pci_device *device, const char *bdf)
+void vfio_pci_iommu_setup(struct vfio_pci_device *device)
 {
 	struct iommu *iommu = device->iommu;
 	unsigned long iommu_type = iommu->mode->iommu_type;
 	int ret;
 
-	vfio_pci_group_setup(device, bdf);
-
 	ret = ioctl(iommu->container_fd, VFIO_CHECK_EXTENSION, iommu_type);
 	VFIO_ASSERT_GT(ret, 0, "VFIO IOMMU type %lu not supported\n", iommu_type);
 
@@ -259,8 +257,14 @@ static void vfio_pci_container_setup(struct vfio_pci_device *device, const char
 	 * because the IOMMU type is already set.
 	 */
 	(void)ioctl(iommu->container_fd, VFIO_SET_IOMMU, (void *)iommu_type);
+}
 
-	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, bdf);
+static void vfio_pci_container_setup(struct vfio_pci_device *device)
+{
+	vfio_pci_group_setup(device);
+	vfio_pci_iommu_setup(device);
+
+	device->fd = ioctl(device->group_fd, VFIO_GROUP_GET_DEVICE_FD, device->bdf);
 	VFIO_ASSERT_GE(device->fd, 0);
 }
 
@@ -360,9 +364,7 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device,
 	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
 }
 
-struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
-					       struct iommu *iommu,
-					       int device_fd)
+struct vfio_pci_device *vfio_pci_device_alloc(const char *bdf, struct iommu *iommu)
 {
 	struct vfio_pci_device *device;
 
@@ -373,9 +375,20 @@ struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
 	device->iommu = iommu;
 	device->bdf = bdf;
 
+	return device;
+}
+
+struct vfio_pci_device *__vfio_pci_device_init(const char *bdf,
+					       struct iommu *iommu,
+					       int device_fd)
+{
+	struct vfio_pci_device *device;
+
+	device = vfio_pci_device_alloc(bdf, iommu);
+
 	if (iommu->mode->container_path) {
 		VFIO_ASSERT_EQ(device_fd, -1);
-		vfio_pci_container_setup(device, bdf);
+		vfio_pci_container_setup(device);
 	} else {
 		vfio_pci_iommufd_setup(device, bdf, device_fd);
 	}
-- 
2.54.0.563.g4f69b47b94-goog


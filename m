Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE5223DEA
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019348; cv=none; b=Bn0NKvoD1k15C5fJLdCIhjRbWuXNnp3XIXK3nDw0s4rg4QVYcAuuo8uA8ENgNjABDOHiI290qcft4uNeyJ8j7HJHXVllvRE3DdZiyntGNj0hphEvdQ2rBQtuXpGAv3IijnIi7UVZ98EH2OuBLgbJ0B0KXlrNDakTaXz7KrlMoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019348; c=relaxed/simple;
	bh=M6sqpJW0xvMdEYGbV5sZ5uTFofuz5exwIar0To56mu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8odScgtN5MAV0RmHGkt6l+EKR9sVWSptcBt6HNiZXUxs/2n1MTQ4Nso0CxzR5q059RNUdWEYZAyaZ8Wqn+dkaJQ1kU4rtYlmgi4C93NxTAQ3kemaaLqChFVjoBxfrc/vg56iB5Fsh62t0JbMWW8c5X0UtYZeinbDPqIbyh2xiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4f8ovFI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4f8ovFI"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa2165c3eso3772705b3a.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 15:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778019345; x=1778624145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2nOvlk7tLe7Q+77TqRRJEoyFcx+9Lc6salUKy253Io=;
        b=q4f8ovFIWRtSaRAEdVK6nyDZ8106vR0QOoUCFeqMDQnoto8gG/74PTzEOf06qdC191
         ZKgCjb1tn80u9vExNV+sCnqXX9vc1h0dCRJ5BPZ1BNt0kn4eBi/UT1/EwcpGLUhE/gZ2
         HryrbThpaa6FnJxtvlWsynEHlwOOGBQXUOBTvtrsmbMfiM+aghOHRmwDisJLzIjzcwn7
         qcWsxx5smq1G3EbaQEV3kc+3ZoyQeu0rPGd7gHf9EI8/0n/7tzr0kDPF+iCYPM2c/b7y
         rA4GwdjY5meEyWe8K6mKdldQxC1gzJwVPS5zBSD6LZYLKKVsnDv7R15cLYREr/UcwuKh
         WW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778019345; x=1778624145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2nOvlk7tLe7Q+77TqRRJEoyFcx+9Lc6salUKy253Io=;
        b=T1hbjSPZzgezHB46p1Kyb5DNaCjmfGHiZf7VP24BYqPwC2ipt4GJS8zKLN4d5g6Gcz
         StzlFTFzuh8nbN0/iRjMR3by9WRfNnknJfWFPKLKptFbFSgFjMOnpQI/e9QM4JgDQIjL
         sVENE8z0tmrma0QeQxS/cS1/G1kZ04ZCDyKXRVWRdtsbK0+MvrZyvhGrTioh90sRbnGa
         Evbt+dH0ia4gWig1XLtXdUs+/WXfxrtWADg5WcoJI99i1912KDmbX+xkAz03lAOmWV16
         c4/YcHFtyorM2ONL9SS759PuXjn/aSJPeaUvqbjvkl/xP3X9U4rTXBYhz+jIDIAZRXxH
         VNvA==
X-Forwarded-Encrypted: i=1; AFNElJ/bAGvY0FaE94SRnX6oCUzoG+CVgx804HnIuYYGNUgroykrkIWe0si20gfu9RpkwAXiIR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkA81sjR6Z+UFcMtfo2kT2200KKsUGenyi3/vj6LdPF8/cuf6g
	dQ8cp9L4UCLSQBYU8LyTAIsHQDp1PiPvTriH1U/KhvosTZopP8GpQM20z8LFvCwwNanhWpyLNzl
	yoCint9YsIixi2w==
X-Received: from pfoo26.prod.google.com ([2002:a05:6a00:1a1a:b0:82f:b388:7a9e])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d84:b0:837:7e7d:3d9 with SMTP id d2e1a72fcca58-83a5e137d1dmr577850b3a.44.1778019345245;
 Tue, 05 May 2026 15:15:45 -0700 (PDT)
Date: Tue,  5 May 2026 22:14:35 +0000
In-Reply-To: <20260505221518.619123-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505221518.619123-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505221518.619123-2-skhawaja@google.com>
Subject: [PATCH 1/2] vfio: selftests: Add support of creating multiple iommus
 from iommufd
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>, Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, Alex Mastro <amastro@fb.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

IOMMUFD allows creating multiple IOAS and HWPTs under one iommufd, Add
API to init a struct iommu using an already opened iommufd. The API
internally creates a new IOAS and also a new HWPT as an option based on
the flags passed to the function.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  5 ++
 .../lib/include/libvfio/vfio_pci_device.h     |  2 +
 tools/testing/selftests/vfio/lib/iommu.c      | 62 +++++++++++++++++--
 .../selftests/vfio/lib/vfio_pci_device.c      | 22 ++++++-
 4 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..89249a294920 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -9,6 +9,9 @@
 
 typedef u64 iova_t;
 
+/* Create IOMMU with page tables */
+#define IOMMUFD_IOMMU_INIT_CREATE_PT 1
+
 struct iommu_mode {
 	const char *name;
 	const char *container_path;
@@ -29,10 +32,12 @@ struct iommu {
 	int container_fd;
 	int iommufd;
 	u32 ioas_id;
+	u32 hwpt_id;
 	struct list_head dma_regions;
 };
 
 struct iommu *iommu_init(const char *iommu_mode);
+struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id, u32 flags);
 void iommu_cleanup(struct iommu *iommu);
 
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2858885a89bb..1143ceb6a9b8 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -19,6 +19,7 @@ struct vfio_pci_device {
 	const char *bdf;
 	int fd;
 	int group_fd;
+	u32 dev_id;
 
 	struct iommu *iommu;
 
@@ -65,6 +66,7 @@ void vfio_pci_config_access(struct vfio_pci_device *device, bool write,
 #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u16)
 #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _o, _v, u32)
 
+void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu);
 void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
 			 u32 vector, int count);
 void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..644c049cf9f0 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -408,6 +408,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges)
 	return ranges;
 }
 
+static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
+{
+	struct iommu_hwpt_alloc args = {
+		.size = sizeof(args),
+		.pt_id = iommu->ioas_id,
+		.dev_id = dev_id,
+	};
+
+	ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);
+	return args.out_hwpt_id;
+}
+
 static u32 iommufd_ioas_alloc(int iommufd)
 {
 	struct iommu_ioas_alloc args = {
@@ -418,11 +430,9 @@ static u32 iommufd_ioas_alloc(int iommufd)
 	return args.out_ioas_id;
 }
 
-struct iommu *iommu_init(const char *iommu_mode)
+static struct iommu *iommu_alloc(const char *iommu_mode)
 {
-	const char *container_path;
 	struct iommu *iommu;
-	int version;
 
 	iommu = calloc(1, sizeof(*iommu));
 	VFIO_ASSERT_NOT_NULL(iommu);
@@ -430,6 +440,16 @@ struct iommu *iommu_init(const char *iommu_mode)
 	INIT_LIST_HEAD(&iommu->dma_regions);
 
 	iommu->mode = lookup_iommu_mode(iommu_mode);
+	return iommu;
+}
+
+struct iommu *iommu_init(const char *iommu_mode)
+{
+	const char *container_path;
+	struct iommu *iommu;
+	int version;
+
+	iommu = iommu_alloc(iommu_mode);
 
 	container_path = iommu->mode->container_path;
 	if (container_path) {
@@ -453,10 +473,44 @@ struct iommu *iommu_init(const char *iommu_mode)
 	return iommu;
 }
 
+struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id, u32 flags)
+{
+	struct iommu *iommu;
+
+	iommu = iommu_alloc("iommufd");
+
+	iommu->iommufd = dup(iommufd);
+	VFIO_ASSERT_GT(iommu->iommufd, 0);
+
+	iommu->ioas_id = iommufd_ioas_alloc(iommu->iommufd);
+
+	if (flags & IOMMUFD_IOMMU_INIT_CREATE_PT)
+		iommu->hwpt_id = iommufd_hwpt_alloc(iommu, dev_id);
+
+	return iommu;
+}
+
+static void iommufd_cleanup(struct iommu *iommu)
+{
+	struct iommu_destroy args = {
+		.size = sizeof(args),
+	};
+
+	if (iommu->hwpt_id) {
+		args.id = iommu->hwpt_id;
+		ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
+	}
+
+	args.id = iommu->ioas_id;
+	ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
+
+	VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
+}
+
 void iommu_cleanup(struct iommu *iommu)
 {
 	if (iommu->iommufd)
-		VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
+		iommufd_cleanup(iommu);
 	else
 		VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
 
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index fc75e04ef010..e2b71fe63cae 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -322,7 +322,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
 	return cdev_path;
 }
 
-static void vfio_device_bind_iommufd(int device_fd, int iommufd)
+static int vfio_device_bind_iommufd(int device_fd, int iommufd)
 {
 	struct vfio_device_bind_iommufd args = {
 		.argsz = sizeof(args),
@@ -330,6 +330,7 @@ static void vfio_device_bind_iommufd(int device_fd, int iommufd)
 	};
 
 	ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
+	return args.out_devid;
 }
 
 static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
@@ -342,6 +343,21 @@ static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
 	ioctl_assert(device_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &args);
 }
 
+void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, struct iommu *iommu)
+{
+	u32 pt_id = iommu->ioas_id;
+
+	/* Only iommufd supports changing struct iommu attachments */
+	VFIO_ASSERT_TRUE(iommu->iommufd);
+
+	if (iommu->hwpt_id)
+		pt_id = iommu->hwpt_id;
+
+	VFIO_ASSERT_NE(pt_id, 0);
+	vfio_device_attach_iommufd_pt(device->fd, pt_id);
+	device->iommu = iommu;
+}
+
 static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *bdf)
 {
 	const char *cdev_path = vfio_pci_get_cdev_path(bdf);
@@ -350,8 +366,8 @@ static void vfio_pci_iommufd_setup(struct vfio_pci_device *device, const char *b
 	VFIO_ASSERT_GE(device->fd, 0);
 	free((void *)cdev_path);
 
-	vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
-	vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id);
+	device->dev_id = vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
+	vfio_pci_device_attach_iommu(device, device->iommu);
 }
 
 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu)
-- 
2.54.0.545.g6539524ca2-goog


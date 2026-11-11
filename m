Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425063;
	b=i/mZC2fc7U03w0iT6g6fjv3YnVirMZQqzFoIZ7JmFcW0H3aAcYlIBvR1hOHNPZQ0cDJz
	 lnDLbMABP0HgL6r0iUqtrVgWpRw8RH16Wj/pkcp9Re8koEB+w6NxWf6I+MIivqSOG8zdw
	 WyiRpvHEinaut5zz4tWbC/+gxkLrQnDEY2L2o0U5flOhDY0d/GIsB97hzf4/ZhhDzQHal
	 k38bT5hrRkJ5tfG2pRERnwrucCMwDfz4OqqnMnG8m39kJG1tMTJE6OVqncPjIYpvd5kzY
	 1AHxNNUUNzZan0xPQxhBcwfp9RtIciDRD+38AoQWbB3LfP/jT4gOO4ZgKl6blRW/cRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=9sL5fqWbHi6g8R+z+W0YnlVdwW61K08vu/pGLyPlBpM=;
	b=46Kwvwlc+kSMsAQQt4j33e9i1eK0ATgPOubxliR3aWFXEOXioqDT5l+aND3ZavjsQQcP
	 GdHL925qhD8mRXEq4q1f9NXELT3d6G2UD607+3saIHaHOfUNL134sx+4umxbgmKQyr71z
	 29uDxxT1MNRNvlxYJYtGaGjXVlMI8LCUMmigP8UyW1xSO5LvcSmxDW78TV05ku0D6XThC
	 nMhIqeG8VDTofBHyZuw2gi1tE0A1bnUSO2PrKD6ZBxoA1T+DYfZbf11lgF8Qs5bK5NLGx
	 DpDrAQaUsc1R83gB8Wt8vf13XY+ed4PFOBbxSAvao59hKVHm/vKm6J0KaU71lfbiYeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZTOcxAM;
	arc=none smtp.remote-ip=209.85.160.71
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FED60A3804
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 19:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FED60A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pZTOcxAM
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-46509ab0149so3411168fac.2
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 11:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794425061; x=1795029861; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sL5fqWbHi6g8R+z+W0YnlVdwW61K08vu/pGLyPlBpM=;
        b=pZTOcxAMe2HFmz+bPshkgOR+7KO8iHxJ+wj3Rb1mEHykp8ygXHT1yX/VZuKQEzNyFZ
         OxzCcEtd8wsygn6pbQtVKusfgOYUdMPixogPaHOp93IVkrj6RYyVIgGsUsjc8Tyu89vS
         9WTbfZpYCQHLnbKoC9o8fA8m6ivSKeiw48VhetF/qY+RnFeAXz91CqaQCXAG9qE+NcSL
         LU+e+nnwoZhhBCX21HvZEklDzQxLNbCBbCR7AOJ72AE794mG2MjWDQtVBGcLvM6Tch/b
         9Fk71tqKxbDj8x8gleLdF0UWF/JCtrJgc12gX45P8vYPoLBi4ijOxEBv8bvv1SThw3Lp
         iJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794425061; x=1795029861;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sL5fqWbHi6g8R+z+W0YnlVdwW61K08vu/pGLyPlBpM=;
        b=QREdGaT1+gG5zyGTox/6idZqvgh8eh8QogWGdDFnxvehxtv+Kt9J7oH0lasl+jT1qF
         gAEN1WOXo2cwpXvr+g/m0uTB9bWD7s2h1/kTth8mfX7HT2jMXdzPYJacL6f28IhJGhbO
         a+tA6pQvEx8LtTUaxTHcQjbzwKVFCpHjdOHB6au/PyeIm+g4WfRVx5CTgenVXhNQJFPR
         3kD2vjqT/xLjV7mio9YI8hT6nPVxsfDNG6SCSNf20g1XS48wIHnKQwh0fg7/TdVlwhzs
         S1NHrormv3jAPWne9aFYuAmP7UR/036xUJzSYIO3NBLLEIuwSuCoOvgmGgAWXYcr5E1m
         Vi8w==
X-Forwarded-Encrypted: i=1; AL+hErGQYQF7bKAZHE8ju04+kBPFYo6+s6E59vK9ZT5Xv0bsx0IZgvD7XxvtWk3Z0BnOWaJbvDw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E1UOIpfhQ6tmmU7IfSWEH6mOtbFOJaKszf7shgeVQ8KU+uddV
	65I3NjllIrhsHqGEq4FnxVswVu9h02sHHc6BxJiZorejAwFIshPV9dxQBBw/I2oD9sLl9aDRn6P
	XyZq65hV98dH7kg==
X-Received: from oabus13.prod.google.com ([2002:a05:6870:df8d:b0:4ad:8f23:4d1b])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:1644:b0:49e:f7c:fa52 with SMTP id 586e51a60fabf-4ae46ba7423mr2997611fac.36.1794425060739;
 Wed, 11 Nov 2026 11:24:20 -0800 (PST)
Date: Wed, 11 Nov 2026 19:24:08 +0000
In-Reply-To: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261111192411.4133780-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261111192411.4133780-5-dmatlack@google.com>
Subject: [RFC PATCH 4/7] vfio: selftests: Add vfio_pci_dmabuf_create() helper
From: David Matlack <dmatlack@google.com>
To: dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Matt Evans <mattev@meta.com>, 
	Matt Evans <matt@ozlabs.org>, Mina Almasry <almasrymina@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add vfio_pci_dmabuf_create() and __vfio_pci_dmabuf_create() to export a
VFIO PCI region range as a dma-buf fd via VFIO_DEVICE_FEATURE_DMA_BUF,
and preserve -errno on failure in vfio_device_feature_ioctl().

Native iommufd maps device MMIO BARs for peer-to-peer DMA via dma-buf
file descriptors rather than VM_PFNMAP virtual addresses.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  5 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 33 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 19d458adba1a..fd130f680a2d 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -172,6 +172,11 @@ static inline bool vfio_pci_device_match(struct vfio_pci_device *device,
 bool vfio_pci_find_mem_bar(struct vfio_pci_device *device, u64 min_size,
 			   struct vfio_pci_mem_bar *mem_bar);
 
+int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			     u64 offset, u64 length, u32 open_flags);
+int vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			   u64 offset, u64 length, u32 open_flags);
+
 const char *vfio_pci_get_cdev_path(const char *bdf);
 
 void vfio_pci_group_setup(struct vfio_pci_device *device, const char *bdf);
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 9840463594ab..eca6eb13d7f0 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -153,11 +153,44 @@ static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
 	feature->flags = flags;
 
 	ret = ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+	if (ret < 0)
+		ret = -errno;
 	free(feature);
 
 	return ret;
 }
 
+int __vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			     u64 offset, u64 length, u32 open_flags)
+{
+	u8 buf[sizeof(struct vfio_device_feature_dma_buf) +
+	       sizeof(struct vfio_region_dma_range)] = {};
+	struct vfio_device_feature_dma_buf *dma_buf = (void *)buf;
+
+	dma_buf->region_index = region_index;
+	dma_buf->open_flags = open_flags;
+	dma_buf->nr_ranges = 1;
+	dma_buf->dma_ranges[0].offset = offset;
+	dma_buf->dma_ranges[0].length = length;
+
+	return vfio_device_feature_ioctl(device->fd,
+					 VFIO_DEVICE_FEATURE_GET |
+					 VFIO_DEVICE_FEATURE_DMA_BUF,
+					 buf, sizeof(buf));
+}
+
+int vfio_pci_dmabuf_create(struct vfio_pci_device *device, u32 region_index,
+			   u64 offset, u64 length, u32 open_flags)
+{
+	int fd;
+
+	fd = __vfio_pci_dmabuf_create(device, region_index, offset, length,
+				      open_flags);
+	VFIO_ASSERT_GE(fd, 0, "VFIO_DEVICE_FEATURE_DMA_BUF failed: %d\n", fd);
+
+	return fd;
+}
+
 static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
 {
 	u32 flags = VFIO_DEVICE_FEATURE_SET | feature;
-- 
2.56.0.567.gdb80ae8cd5-goog


Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262F431E6F
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938010; cv=none; b=E2gJ5mcTB5KvranVYqu3De+wXB5PKiYvZbENaLy/lGR0EkQy6zv+a1JQuVAEAzk1fUiMNPgF1r7+srsRw8WfxM11J0bzQ6AO/XPj+MsXiKcWh/ir3JYGbrP58PHHW4blHqDxGVKbCCEr5J7pIn5cyTgDM2vriKC8K2o2VxwtmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938010; c=relaxed/simple;
	bh=OG0wbX1YHbbRtpOyPrbkH9ec7NoNJd/XAQ/iD3VEdpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LdAZcYprhjdneVBhV49B3UHm63qY35trN0zbLDVbQBSRvr5eVFo+ar1kEywTvGw04iw1Ot5hekgRTcDcb+P5nwYxReKwXv+EUrj4DxNYk1yF+MsDoCyEvo0tkKy4c7GB/k5dUVnQIeQIt2c6EMrHJrB7cYRS1lwjg5xDbyieRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq9ud/gH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq9ud/gH"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37fa907f98eso967672a91.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938009; x=1783542809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trFkLGElpB18qg+gQX3raUFt9xbGcfz4Dubn+4t0CYI=;
        b=kq9ud/gHkpa8Q9y5MtP/MulVmPxyE6brrgikg/SzVN2q3fYfqa4+98A9XmsBAkbVEY
         uhmW8U3Ovr5JMoMFUXZiglby3+1LKdpDM8A1lhw4zU6VKoqkrrovkDUyY5/JW13+9pIV
         0k/KASsHW6iYQ/BWMoIzc+Foo0g0z8qiDXd1/32ak1MZ8qaBAKhB1VplgKAyWCkZ5IfK
         YCWmHMrkBkiPI7ViCJRTxAoxf7wlDaEY3xnX3LMT3/JKx8Oa0Z9srK0cKpmZ/IftQSJx
         DnF8MjuJiV/24d4hmt0eqkgayz3VP+cS+VKEE3YoENnHzuXK2DjkjRCDst4r6j249k72
         ffMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938009; x=1783542809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trFkLGElpB18qg+gQX3raUFt9xbGcfz4Dubn+4t0CYI=;
        b=Z8N/1OOmQ4NqhLKIc7aNdvVGkevMJC79Q7Zb8RN5BmhLLw5z0gEay9fp0UzeSBvDay
         llESH0KxWy9nlQmCk/zAuFbUhN1p47mbiLv6ROYp9d5RKLf0d62AzGbipcwTl1GV8wtw
         DBSDP4ztscC5QSsgnHDVzYQIroTq5z2D3nlTHp+r/EGZb91hzVZpQvTDhp8szG+BYceK
         6nxylffVD8lfySNPHxnOFehcZ29jLNs7FpB5h/pNqaJGwS8OFOPZlnwilKFe89DxtC4Z
         EHB2q43ABPInRXJq3FYRUR0iURCNbXSZmXKRQsGLCulDophXOPXLUsmtbmKukbZV8nZA
         B3Ug==
X-Gm-Message-State: AOJu0Yxc1daBwq3El46zQRXGCjxoM4cDOhibdfzi727AIhOFF02VvxZB
	OZl8XiWKbb1U6Zl1Q9SFSKdkAh+MD9cNsB9VkcF6mIP1UI8mUE0BIe86xuQm/TocE1xhnXoGfBv
	Nx4Wn/TfNilC/JbvLIddwPew/Fqh2qLpkmu8CSY2zyQUdWIfQQuIDd7cBlrk8gmFnhA5CIhEvmI
	GboJM+OKpLQcpja3HZ96rgvouPRbREs/oRyMzu7ChixHBpSQ7eG3PZWA==
X-Received: from dyce14.prod.google.com ([2002:a05:7300:724e:b0:30e:eb5c:9ab3])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7ce:b0:37d:8426:40de with SMTP id 98e67ed59e1d1-380aa0ad396mr2899164a91.1.1782938008317;
 Wed, 01 Jul 2026 13:33:28 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:33:09 +0000
In-Reply-To: <20260701203311.326798-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701203311.326798-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701203311.326798-3-aaronlewis@google.com>
Subject: [PATCH 2/4] vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a second test to "vfio_dma_mapping_perf_test" to evaluate memfd
latencies. A key motivator for adding this test is to demonstrate that
the IOMMU_IOAS_MAP_FILE ioctl is significantly faster than other methods
of mapping DMA regions. While this performance difference is not fully
apparent with the test's current capabilities, it will become evident
as more features are introduced later in the series.

To support this, add IOMMU_IOAS_MAP_FILE ioctl support to the VFIO
selftest library via iommufd_map_file().

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |   7 ++
 tools/testing/selftests/vfio/lib/iommu.c      |  24 ++++
 .../vfio/vfio_dma_mapping_perf_test.c         | 118 ++++++++++++++++++
 3 files changed, 149 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..eeef5990292c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -35,6 +35,13 @@ struct iommu {
 struct iommu *iommu_init(const char *iommu_mode);
 void iommu_cleanup(struct iommu *iommu);
 
+int __iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd);
+
+static inline void iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd)
+{
+	VFIO_ASSERT_EQ(__iommufd_map_file(iommu, region, fd), 0);
+}
+
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
 
 static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..6730b39060ca 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -97,6 +97,30 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
 	return iova;
 }
 
+int __iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd)
+{
+	VFIO_ASSERT_TRUE(iommu->iommufd, "IOMMU_IOAS_MAP_FILE is an IOMMUFD IOCTL.");
+
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			IOMMU_IOAS_MAP_WRITEABLE |
+			IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = fd,
+		.start = 0,
+		.iova = region->iova,
+		.length = region->size,
+	};
+
+	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
+		return -errno;
+
+	list_add(&region->link, &iommu->dma_regions);
+
+	return 0;
+}
+
 static int vfio_iommu_map(struct iommu *iommu, struct dma_region *region)
 {
 	struct vfio_iommu_type1_dma_map args = {
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
index 87d84450fc47..4639bda7ebaa 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -117,6 +117,124 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 	printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
 }
 
+FIXTURE(vfio_dma_mapping_perf_memfd_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+};
+
+FIXTURE_VARIANT(vfio_dma_mapping_perf_memfd_test) {
+	const char *iommu_mode;
+	int mmap_flags;
+	int memfd_flags;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags, _memfd_flags) \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, _iommu_mode ## _ ## _name) {    \
+	.iommu_mode = #_iommu_mode,						      \
+	.mmap_flags = MAP_SHARED | (_mmap_flags),				      \
+	.memfd_flags = MAP_SHARED | (_memfd_flags),				      \
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(memfd, 0, 0);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(memfd_hugetlb_2mb,
+				    MAP_HUGETLB | MAP_HUGE_2MB,
+				    MFD_HUGETLB | MFD_HUGE_2MB);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(memfd_hugetlb_1gb,
+				    MAP_HUGETLB | MAP_HUGE_1GB,
+				    MFD_HUGETLB | MFD_HUGE_1GB);
+
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->iova_allocator = iova_allocator_init(self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_perf_memfd_test)
+{
+	iova_allocator_cleanup(self->iova_allocator);
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+static void *setup_memfd(int *fd, u64 size, int mmap_flags, int mfd_flags)
+{
+	void *buf = MAP_FAILED;
+	struct timespec start;
+
+	timer_start(&start);
+	*fd = memfd_create("vfio_dma_mapping_perf_memfd_test", mfd_flags);
+	printf("Completed memfd_create() in %.2lfms\n", timer_elapsed_ms(start));
+	if (*fd <= 0)
+		return MAP_FAILED;
+
+	if (ftruncate(*fd, size))
+		goto out;
+
+	timer_start(&start);
+	buf = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, *fd, 0);
+	printf("Completed mmap() for memfd in %.2lfms\n", timer_elapsed_ms(start));
+
+out:
+	if (buf == MAP_FAILED)
+		close(*fd);
+
+	return buf;
+}
+
+static void teardown_memfd(int fd, u64 size, void *vaddr)
+{
+	struct timespec start;
+
+	if (vaddr != MAP_FAILED) {
+		timer_start(&start);
+		munmap(vaddr, size);
+		printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
+	}
+
+	if (fd != -1) {
+		timer_start(&start);
+		close(fd);
+		printf("Completed close() in %.2lfms\n", timer_elapsed_ms(start));
+	}
+}
+
+TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
+{
+	const u64 size = SZ_1G;
+	struct dma_region region;
+	struct timespec start;
+	u64 unmapped;
+	int rc, fd;
+
+	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
+	ASSERT_NE(region.vaddr, MAP_FAILED);
+
+	region.iova = iova_allocator_alloc(self->iova_allocator, size);
+	region.size = size;
+
+	timer_start(&start);
+	if (strcmp(variant->iommu_mode, MODE_IOMMUFD) == 0) {
+		iommufd_map_file(self->iommu, &region, fd);
+	} else {
+		iommu_map(self->iommu, &region);
+	}
+	printf("Mapped HVA %p (size %luG) at IOVA 0x%lx in %.2lfms\n",
+	       region.vaddr, size / SZ_1G, region.iova, timer_elapsed_ms(start));
+	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
+
+	timer_start(&start);
+	rc = __iommu_unmap(self->iommu, &region, &unmapped);
+	printf("Unmapped IOVA 0x%lx in %.2lfms\n", region.iova, timer_elapsed_ms(start));
+	ASSERT_EQ(rc, 0);
+	ASSERT_EQ(unmapped, region.size);
+
+	teardown_memfd(fd, size, region.vaddr);
+}
+
 int main(int argc, char *argv[])
 {
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


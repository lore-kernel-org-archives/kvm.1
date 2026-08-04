Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074647DD59
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862686; cv=none; b=hZsgCLQ5KcchDhz7+oG5PFoZTUHrz8r7jHz49LcP3bk4UJegTqX+CLP3QsL/BP6meanmfyX50h55ZEUfn+vhYmPbhv4tx10xRx9VDJA1YE16XfHzv6E2VxAh6+k8/NFMna3/RLN3ofAVPYgFTpnomuylrq97C4jyQ5B0iU5rHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862686; c=relaxed/simple;
	bh=svpa07L2omlhW6FPRtZqOCJp+AHo1KxV731t3CaP/H4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQKsAdmdYsdk+GRpv8KvstbFfZYiDv23CsWqx8Ax6oNryuvvGk3AKuCPK3ZPNKE9GeByeIlhhueGzd24Tj1+iq8s9BPGnaIWDPsYnXsKsHTu+eR2WamiG4E0142gzQQ5zv7P+xX3ycQqADqVjhzS9npQV8MkFqH0Fgn3XaoXDtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rVembk2d; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVembk2d"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfe48ca1efso1148295ad.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862679; x=1786467479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yi81QoTuUsO1sPo7YdCWTFff2b4P10cs781lVBnI9ik=;
        b=rVembk2dH7oRoPKq6D0HQTk4OsV1wi71ZCtphk2l13GpW83t59pdkK6XzjiMQXKT1y
         x/Q4C5Wm2Yo8cnDpLLv/cYXQ4xiTIJWC/g5ONEkzwHxi3FJcxwKYR2Oit1pYj8kUsRNt
         43TZ62Y+Weug2r47dF5RB5+Oww1w+qH7+W6vyOyvtujWHgC2h0jdUYISQbz+0OBtzYKf
         u/N2Ifdh9+txzIFtSnaHn6HzC1pYfK30LtS2d+Q5AaNsuQflAJvQEuRjYwKGhICQ3DRW
         PAi8yqNdA4z81EgXmatJ/hrBUm0JCDccWTNnVHYRjdpwq2jh3EUU4S6Owqg31H4G8u1T
         IBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862679; x=1786467479;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yi81QoTuUsO1sPo7YdCWTFff2b4P10cs781lVBnI9ik=;
        b=N46tYi1RsoUWLIo3m6Z0acYNhvHWX9B7vK328faugUiupZs+4jng04BN4g313GBqZE
         sUYtvDhxfOfzoARtbU1PwDvLi+3PiWiwAL5a33RuvoZJQuwpfCGjMgi2foELBv7a3j6l
         6ofYTzqxxPO6y143j26iEwB5soTlMd6NllHozIWk8CdvJQCyZC1irvnGRMFujlVN4/Fj
         jIzJO5IuXBbnUAVMOOzw7HGSm+J7TLzZCTIknEVB/BjdcNoA5NKp0QPRZLb29o9SEN+l
         AVIMiY80zTMC+MUUKI73iQ9eJkS/6f+DIrl1e0sIsBzdkU7xkiyXDHb9IpCLmo854sfC
         fcdg==
X-Gm-Message-State: AOJu0YwnAGFomNt4/F4wLW+zosNF1fqz1yDDgU+Qdfmv4RShf9Cuz+A7
	gZ4dKKwb9cDs6Gui4Hadkzx0MmTt3IU6EKFmfWTqmNbH7GzeOnlU+oq0wsH/VR6pyyZwXDidXCA
	6VM1JyMIlDcAfL0KEL4JLF3iene12tMmihUrAvbcPq5C+wtoqG90wov5RdiX8GbgCb/26TYAisG
	D9lAQ6z8nOsqVdcs/yTRKC7/+MEhIL0vxWxMNvqkT8C75sTSTwH7ws+g==
X-Received: from dycne3.prod.google.com ([2002:a05:7301:c83:b0:2f9:af7:504e])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2b0d:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d0ca7afcc1mr2105625ad.4.1785862678442;
 Tue, 04 Aug 2026 09:57:58 -0700 (PDT)
Date: Tue,  4 Aug 2026 16:57:47 +0000
In-Reply-To: <20260804165748.1060476-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804165748.1060476-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260804165748.1060476-4-aaronlewis@google.com>
Subject: [PATCH v2 3/4] vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
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
 tools/testing/selftests/vfio/lib/iommu.c      |  24 +++++
 .../vfio/vfio_dma_mapping_perf_test.c         | 102 ++++++++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index 5c77875240f4..515976fb19be 100644
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
index b6f3c5c84e01..b76ae0a91c68 100644
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
index 26c04cabef61..5ef85deba4ee 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -83,6 +83,108 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 	TIME("munmap", ASSERT_EQ(0, munmap(region.vaddr, size)));
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
+#define FIXTURE_VARIANT_ADD_MEMFD_MODE(_name, _mmap_flags, _memfd_flags)      \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, iommufd ## _ ## _name) {\
+	.iommu_mode = MODE_IOMMUFD,					      \
+	.mmap_flags = MAP_SHARED | MAP_POPULATE | (_mmap_flags),	      \
+	.memfd_flags = (_memfd_flags),					      \
+}
+
+FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd, 0, 0);
+FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_2mb,
+				    MAP_HUGETLB | MAP_HUGE_2MB,
+				    MFD_HUGETLB | MFD_HUGE_2MB);
+FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
+				    MAP_HUGETLB | MAP_HUGE_1GB,
+				    MFD_HUGETLB | MFD_HUGE_1GB);
+
+#undef FIXTURE_VARIANT_ADD_MEMFD_MODE
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
+
+	TIME("memfd_create",
+	     *fd = memfd_create("vfio_dma_mapping_perf_memfd_test", mfd_flags));
+	if (*fd < 0)
+		return MAP_FAILED;
+
+	if (ftruncate(*fd, size))
+		goto out;
+
+	TIME("mmap",
+	     buf = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, *fd, 0));
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
+	if (vaddr != MAP_FAILED)
+		TIME("munmap", VFIO_ASSERT_EQ(0, munmap(vaddr, size)));
+
+	if (fd != -1)
+		TIME("close", VFIO_ASSERT_EQ(0, close(fd)));
+}
+
+TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
+{
+	const u64 size = SZ_1G;
+	const int flags = variant->mmap_flags;
+	struct dma_region region;
+	int fd;
+
+	printf("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
+
+	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
+
+	/* Skip the test if there aren't enough HugeTLB pages available. */
+	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
+		SKIP(return, "setup_memfd() failed: %s (%d)\n", strerror(errno), errno);
+	else
+		ASSERT_NE(region.vaddr, MAP_FAILED);
+
+	region.iova = iova_allocator_alloc(self->iova_allocator, size);
+	region.size = size;
+
+	TIME("IOMMU map", iommufd_map_file(self->iommu, &region, fd));
+	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
+
+	TIME("IOMMU unmap", iommu_unmap(self->iommu, &region));
+
+	teardown_memfd(fd, size, region.vaddr);
+}
+
 int main(int argc, char *argv[])
 {
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-- 
2.55.0.654.g21b8a5bc05-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662530;
	b=PPx0CskJTqfM3xvPeCgTZsau9OlfQC5Q9sjwJxzWRsVtbh4MjWgye1GA2Z16xzUELpJT
	 zxe8ki+ZkFoOaGcFm5dBmd1p6fr2rAqgaWJbB9RHCG6I9/kC0xIpIWP8o9gjYNSoy1+Dl
	 w1rD5KHGJEN68+GF0Uaca2xwqrxwPwVLgtu5RbgsRa4RuSMyCGAXi5ws1udDo45qR1ZKu
	 1mpsHCdShBFJLmClkTr0u8WoD3DJqe5r2psodAhCOCwJRTPSX9KMqqJ8KiYLbO/dA4q2G
	 yUtcoFrb/thtuWMyhwdpdNqwApK2GaonfTAn2P5UXdF0pGYoLgWN6pF1dsgxrcQb85Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=vorzF43BonkKNR1gp1NegEOher26yfJCUCzSjOMrhhg=;
	b=PZYJ76m2IoXQ9K+2xTZb5diETPosRP+gUgUWKZiGTb1XJXh1oXRmzkpJ251zI6Pp+ixm
	 H/KaQPy4DYaR1MBbZMBpp/ZeaowvOYVLdMHZhBAU8HFKzwnfQbfY83n6acBnMFd1hGK+S
	 ff//dNMuvNAOt5F9K/ABSI5/x+g2Zaketso9nLf2U/Gc83wyt1mLPqqipYbSIXHFezB1r
	 Jc8LjKx8Dz/902uEmtsAbxep1bJdhV/hYW+69/ZJ3MGl+pyTIz674RFRDCRfM4GDRkwyf
	 NyokOui1h+i5Nc2eG8kJtvpXFhMov86EmAvBPRqIYZm4owj4BdwCcvljoyHLwvSbLew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fuyRZv9n;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF92606A887
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AF92606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fuyRZv9n
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36fa5673fccso4712873eec.1
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 05:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794662529; x=1795267329; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vorzF43BonkKNR1gp1NegEOher26yfJCUCzSjOMrhhg=;
        b=fuyRZv9nEzoZGfrQ/Rp9HIj+32JDFjhdcG6rYmrnbNmgKs4xYhqXAMmMeq35Vf/STL
         um7Ixz4pmNmeaWktxQO3GIpUSSTn/iHhLYWjfXDhWnrwJiBjnH8HjtpNomKbtbiAfg3T
         KN9aj13yvrXzFhyR+QFGsydv6UIYN51kExdsqWSEXpFhBcaRz2u2NAzy71VVfoVPpvvI
         N+ipsENjO4iDJpmNTzVB2n1fJLGqXavxRs3YMg/6fS7gUg+XadFgRid7fJJP0Hn1KUi7
         kmueCKFY3Why3BEDUjV+zZ2XGxxiMf+Gae5lOnzyx92H37WqgOKuk15xjHNNqlMFzZgw
         UUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662529; x=1795267329;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vorzF43BonkKNR1gp1NegEOher26yfJCUCzSjOMrhhg=;
        b=u4srz2nJ85IUOVOnqto+8+++hYOi6z2KjpTRE5vE8OED515dQz1oyaHsE6W5pEZ6Bj
         45CeBkpyMQQ3NN/UTfFOQGda5L8I7+ITApEv3XFQdwj+WzKRgsW2oYxI0l/R6yNS8WCW
         OJSy/RAaOCv3l6FenmAgOssqqTlzARjj3znv4KdZKsJ1VqrfzBcCd7jYwjERLstEebsu
         /eMK58hEIAskk3RSEsaBD1UCRwfoMy5BlFWgd3/E3/54mm+Mi4KF8b5d9DdEgODzpgR3
         wQO/QXSUGunqCo+DRgbra2qpZyaGco3dJaR/Fp8HNULzEx/9zuf0Y/9O+l2Vn+y2Fd1q
         IGrA==
X-Gm-Message-State: APuU4Z+rECLLEycBygAPun54xOqcJtUkQDXrR5LrxdnW2S8KMX8f/II8
	76g0pyAKQkFJHLchZXaWOJzM0ItTFH+gMQRK2XRnCcs/g4FknULZvyQbM3IRg00SDZB7HrxT127
	ddKihsk2W9JegjDTQnCDdEPOKTZ1bgfWGIf0Vsu9LG+W+UlkSGiKlPRoK/uEv2Sc4c3HGzQ7Bll
	OlQFvoc5PZpBy2wReikjc4MLHrQXSkHx8KA+mU7dhDBPTxuoATKDBAfw==
X-Received: from dybrp3.prod.google.com ([2002:a05:7301:4603:b0:351:1933:2028])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4d16:b0:36a:1d6a:596b with SMTP id 5a478bee46e88-379675feb32mr5590009eec.29.1794662528910;
 Sat, 14 Nov 2026 05:22:08 -0800 (PST)
Date: Sat, 14 Nov 2026 13:21:58 +0000
In-Reply-To: <20261114132200.113697-1-aaronlewis@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261114132200.113697-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114132200.113697-4-aaronlewis@google.com>
Subject: [PATCH v4 3/5] vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a second test to "vfio_dma_mapping_perf_test" to evaluate memfd
latencies. A key motivator for adding this test is to demonstrate that
the IOMMU_IOAS_MAP_FILE ioctl is significantly faster than other methods
of mapping DMA regions. This performance difference is more apparent
with larger memory regions, which will be added in a subsequent commit.

To support this, add IOMMU_IOAS_MAP_FILE ioctl support to the VFIO
selftest library via iommufd_map_file().

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          |  9 ++
 tools/testing/selftests/vfio/lib/iommu.c      | 24 +++++
 .../vfio/vfio_dma_mapping_perf_test.c         | 99 +++++++++++++++++++
 3 files changed, 132 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index 5c77875240f4..2336dcebce5c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -22,6 +22,8 @@ struct dma_region {
 	void *vaddr;
 	iova_t iova;
 	u64 size;
+	int fd;
+	u64 fd_offset;
 };
 
 struct iommu {
@@ -35,6 +37,13 @@ struct iommu {
 struct iommu *iommu_init(const char *iommu_mode);
 void iommu_cleanup(struct iommu *iommu);
 
+int __iommufd_map_file(struct iommu *iommu, struct dma_region *region);
+
+static inline void iommufd_map_file(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_EQ(__iommufd_map_file(iommu, region), 0);
+}
+
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
 
 static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index b6f3c5c84e01..a0a3dc4b968c 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -97,6 +97,30 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
 	return iova;
 }
 
+int __iommufd_map_file(struct iommu *iommu, struct dma_region *region)
+{
+	VFIO_ASSERT_TRUE(iommu->iommufd, "IOMMU_IOAS_MAP_FILE is an IOMMUFD IOCTL.");
+
+	struct iommu_ioas_map_file args = {
+		.size = sizeof(args),
+		.flags = IOMMU_IOAS_MAP_READABLE |
+			IOMMU_IOAS_MAP_WRITEABLE |
+			IOMMU_IOAS_MAP_FIXED_IOVA,
+		.ioas_id = iommu->ioas_id,
+		.fd = region->fd,
+		.start = region->fd_offset,
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
index 4d41fecf2372..086a63a50df8 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -83,6 +83,105 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 	TIME("munmap", ASSERT_EQ(0, munmap(region.vaddr, size)));
 }
 
+FIXTURE(vfio_dma_mapping_perf_memfd_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+};
+
+FIXTURE_VARIANT(vfio_dma_mapping_perf_memfd_test) {
+	int mmap_flags;
+	int memfd_flags;
+};
+
+#define FIXTURE_VARIANT_ADD_MEMFD_MODE(_name, _mmap_flags, _memfd_flags)      \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, iommufd ## _ ## _name) {\
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
+	self->iommu = iommu_init(MODE_IOMMUFD);
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
+	TIME("munmap", VFIO_ASSERT_EQ(0, munmap(vaddr, size)));
+	TIME("close", VFIO_ASSERT_EQ(0, close(fd)));
+}
+
+TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
+{
+	const u64 size = SZ_1G;
+	const int mmap_flags = variant->mmap_flags;
+	struct dma_region region;
+	int fd;
+
+	ksft_print_msg("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
+
+	region.vaddr = setup_memfd(&fd, size, mmap_flags, variant->memfd_flags);
+
+	/* Skip the test if there aren't enough HugeTLB pages available. */
+	if (mmap_flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
+		SKIP(return, "setup_memfd() failed: %s (%d)\n", strerror(errno), errno);
+	else
+		ASSERT_NE(region.vaddr, MAP_FAILED);
+
+	region.iova = iova_allocator_alloc(self->iova_allocator, size);
+	region.size = size;
+	region.fd = fd;
+	region.fd_offset = 0;
+
+	TIME("IOMMU map file", iommufd_map_file(self->iommu, &region));
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
2.56.0.611.g1030f0b940-goog


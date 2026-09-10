Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F4453A5E
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054424; cv=none; b=IQOw2aaCruE+bDE/rVd08KeraAKHkzdGDGhl5/FnIjfqb4Hfv49906NLEOwvmjb3mjHkGDNm1Iv+jU66O7W9WwP1+Qx8Ar6iHVtwwiilgCkqj1Bj0C1l4DQ2JH3QvWjaObp1H8rxWEGxZzMqJqcP/hPLgM6sUbStp2rUiSVmVPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054424; c=relaxed/simple;
	bh=vC8b/vYIsDMhd2DbvPumHiRO8ZeW/nc2bLNKDnAcKl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qn4cQliZXqxyQ1tG9C4hIVZp/GWXKKYGugnGJniwSOBsrjeXXmzChUhWVotSD2k0JCsMIUwTU+R5QSz1TaGqvvOYqFEiq7nf7aS3F6wCDKFos3uI4AvXxoGF9kvzI5yk+1lnifMO4iuBmBlK0lHGFiJahre2jhOL6MBSjq897p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXhM805E; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXhM805E"
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7f4fa572ba2so5032333a34.3
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054422; x=1789659222; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xAUowbmdVS2xZUZdX8oh+kUUNtVZ8bfnVvBWWD/Itt8=;
        b=qXhM805Eo5U7hApb+U6/XxLBttk63yhNcmw73S9hjNqc0oxHl97noN5LGIfW2xfGAX
         n/EmCq17YTPXBTyn/ghqh6YwxTb8qm9YdE9t4HuAT/V7E6+plv9483j/9NiN1h5YwWZd
         Z2q0QaaaAlXtm7WZlx1FKWhYsKFmK6HNfkUCzLIERMPAMYOp++41PW2dNn8+OeqRewWu
         R8QnyRqBkeAD3tsCJNigVATkcLHMCymSzm1Go7Y5XF3W9kfUJJtE4i9QMMvt2lspirIK
         3xRAhS/+NYXTPS6UQ/NvRririijLggDwZ/M5qiyGE/Ca5xiNBjixQJCacpjOwVyD/l9m
         33RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054422; x=1789659222;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xAUowbmdVS2xZUZdX8oh+kUUNtVZ8bfnVvBWWD/Itt8=;
        b=Y+/W60BTx0Hcth7nOmZxyoOh0OoYgSb63UMIcDF6+RIZh/rwXuev8CjdMaoIUI/6Rj
         cfgaNK9hu5vlmdlUW/HtDGloEF5QUKT9w1nlvCN8m6qCqxwqQspsKLD4gbdYumkWt0nk
         p0V0dI2fOF/Bi9oatJsBv5VAuz8916QJRA01Ixw+MLrR25RC3RqprdWV+q0zdtobq89Q
         OwT6qGaoJkJWTFXruUJKgPnMBULOjsgzgmWzfL+3SIW5OaQurLIz/Elur85B5/IiUT6n
         8GG7A7OnUvBGN71CWrGaLx2XVEsFkZeAireYTz5IFhJnNs8NWfTOHBy0vSMb5ixZwiBl
         Boqg==
X-Gm-Message-State: AFuF++kUNw1WObyeSHMU1txSQhYBAtGbntqY5ay73ZeeAW28L471CKXk
	qtmrltRPT/xX7Aw765/8ThAFon7jxdEhAhNy84kgYfI5NVd82PxoQBImKiOkwphCOSFZ4AexRot
	DHT9k8ymlLyjDAXWwvnkCbGTHg1rhxn1w1wEwsEaalN1XA5R7INg+F09giWP7hdOEk1vDtWL+hi
	qvwuWrVEvPndfBmiedHU3mFDou7AUuwrSO3iKmhnITpf571udrdenogw==
X-Received: from dlk16.prod.google.com ([2002:a05:7022:110:b0:143:418c:2b13])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:f003:b0:6b7:46e9:9706 with SMTP id 006d021491bc7-6b746e9a26dmr23289605eaf.54.1789054421299;
 Thu, 10 Sep 2026 08:33:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:33:25 +0000
In-Reply-To: <20260910153326.3085937-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910153326.3085937-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910153326.3085937-4-aaronlewis@google.com>
Subject: [PATCH v3 3/4] vfio: selftests: Add memfd test to vfio_dma_mapping_perf_test
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
 .../vfio/lib/include/libvfio/iommu.h          |   9 ++
 tools/testing/selftests/vfio/lib/iommu.c      |  24 +++++
 .../vfio/vfio_dma_mapping_perf_test.c         | 101 ++++++++++++++++++
 3 files changed, 134 insertions(+)

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
index 4d41fecf2372..4113a20127de 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -83,6 +83,107 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
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
+	TIME("IOMMU map", iommufd_map_file(self->iommu, &region));
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
2.55.0.1003.g10538fe699-goog


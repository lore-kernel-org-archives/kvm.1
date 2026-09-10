Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EFF4A5C45
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054423; cv=none; b=Y9rOKft1N6DRWT7Mu93EiqMIcj/1pcJcfqudHx2Q0TFCrHjlEellzHYpFrdR46EdfNk5s/JAmfTihXlzd0PfNtbrlWt+IOqjU71l/qnXvvTEbKywNJbsPbWqnaRDhOA78dTCoOXjxae7sPOWoAK26ehcZ9Ni5RIBCNA4pT681H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054423; c=relaxed/simple;
	bh=VNbcmRetAjkylSs6qWgwqRBalXeAbX0lAHNJ5BRYTQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZfBETIfY1CBIi0SmnouqjO4LWSNvnlzYTY1hgmdn50ygS2ppUwrc07mpg9G3DIhSZtX1xZhs+pYK9HhR7/FeqXCDWIi0b60XFIGnO5fj99SF5ETRh8rWxXjuT+aqWRZD1W1txXmLdOPsANZM6aTjAp9zvjpkv3dTk8EdlSV6otY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtFU8xAH; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtFU8xAH"
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6b1a3f01d2aso9349716eaf.1
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054420; x=1789659220; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N6j+31HcfYz/+LBDb53gAZgVHeHcrXg/ZUoePPqoPwc=;
        b=qtFU8xAHXlmKEQORgWlYyOIKxpHt2yc45PNpohUkqRNc873pgozvgh+UlEsx+zGgeF
         /2K7UEgnXiY59M8kDeUm5t+MJ5RpkSrghznJ/MBTXnbPkPE4XoNCi4/MCk2VDsyJ566P
         zuZ6cSk39Xw2wg8Bq+353qDTWSJdZv2OlC9dwDhDL8TmiPiaprdfcKxCimhfEi60wLbv
         7FafQvXCXwlBNGbQm89mBatIx2WqFDFqedj9DE81P7R9FXITULjSlE8hVxkgbQKkn1F3
         D7ZIkzRdRFssry8ATvwZqD3y2e0WagUpDXm0VTjZAbL6VIrlQ2P1/WNu1Sv56z3wb+a1
         Z9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054420; x=1789659220;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N6j+31HcfYz/+LBDb53gAZgVHeHcrXg/ZUoePPqoPwc=;
        b=NiF/wdTMCgG4BnXzmqqI9bM9em/kyywfdXFCWyomTLuyyYPe63hJLkl5251kOM9na0
         AHFUwMwx61CdqOHTn9umwx2Q9s38DID6hK24DXg8wAbVMusRtlXAWLkvVb8CgQ3hegEz
         1gIpGGmwf+89EIh7Gs+Cs3RKc5gQWd2sB14ua9KPIPg5tZ8F2DDawxgiEfmge+s5ESTT
         i0Ne5ElrSU+39o94d0Wv1aopq08NTGC4sL6CYvR0SETkOuyP1+DfTGFCghtzQbR/e8yW
         cQ+YXswSiW+tZnur0rwtwL7WJlUiy5CihWA5V//HglHx/x2g25cNClR7oZXnd86Fgqg1
         VhDg==
X-Gm-Message-State: AFuF++mb9lqUuCrjmODwaM1pXHxyzFQdyhVW+9AHeFueo2V8v2dmVYcA
	r5W5W1lKDcLgcdJtyOQkbV8r/yACfVX5ID79AhgFRAlbU1irQvQWGtnqyMoAFuVVHL78A5/gA0N
	UuB3Mrg5mPi2224nu6wvK5mH7y6lSw5Yx9HUhv1JtdiFDi22FehFyrLbDdESVa4Bw928cuHyxKS
	Y5dg2mxt/YPQRNgHJzSTlIn/eEFmfBEdyBWEdFjXlxbtKMgEYyClNcVA==
X-Received: from dybtx20.prod.google.com ([2002:a05:7300:f294:b0:334:e08b:1b72])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:88f:b0:6b1:3552:3195 with SMTP id 006d021491bc7-6b6fb3df1bamr17399240eaf.11.1789054419678;
 Thu, 10 Sep 2026 08:33:39 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:33:24 +0000
In-Reply-To: <20260910153326.3085937-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910153326.3085937-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910153326.3085937-3-aaronlewis@google.com>
Subject: [PATCH v3 2/4] vfio: selftests: Introduce vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce vfio_dma_mapping_perf_test to aid in latency testing. Rather
than a traditional pass/fail test, which tends to be flaky when
enforcing latency bounds, this test directly reports the latency of
various stages in the mapping and unmapping process.

Start with a basic test that performs a simple DMA map/unmap and tracks
the duration of each operation. The test reports the following metrics:

1. Time taken by mmap().
2. Time taken to map a DMA region.
3. Time taken to unmap a DMA region.
4. Time taken by munmap().

Subsequent commits in this series will introduce more features to allow
for a wider variety of testing.

To ensure consistent DMA mapping times, the test uses MAP_POPULATE when
calling mmap(). This forces page faults to be handled upfront, isolating
the DMA mapping times from them.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/lib/include/libvfio.h      | 31 +++++++
 .../vfio/vfio_dma_mapping_perf_test.c         | 90 +++++++++++++++++++
 3 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..ed5856af5f9a 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -8,6 +8,7 @@ else
 CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
+TEST_GEN_PROGS += vfio_dma_mapping_perf_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 07862b470777..8496b8b4da3c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -9,6 +9,37 @@
 #include <libvfio/vfio_pci_device.h>
 #include <libvfio/vfio_pci_driver.h>
 
+#include <stdint.h>
+#include <time.h>
+#include <linux/time64.h>
+
+static inline void timer_start(struct timespec *start)
+{
+	clock_gettime(CLOCK_MONOTONIC, start);
+}
+
+static inline uint64_t timer_elapsed_ns(struct timespec start)
+{
+	struct timespec end;
+
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	return (uint64_t)(end.tv_sec - start.tv_sec) * NSEC_PER_SEC +
+	       (uint64_t)(end.tv_nsec - start.tv_nsec);
+}
+
+#define TIME(_name, _expression) do {				   \
+	struct timespec __start;				   \
+	int __errno;						   \
+								   \
+	timer_start(&__start);					   \
+	_expression;						   \
+	__errno = errno;					   \
+	ksft_print_msg(_name " = %.2lfms\n",			   \
+		       (double)timer_elapsed_ns(__start) / NSEC_PER_MSEC); \
+	errno = __errno;					   \
+} while (0)
+
 /*
  * Return the BDF string of the device that the test should use.
  *
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
new file mode 100644
index 000000000000..4d41fecf2372
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <limits.h>
+#include <stdio.h>
+#include <sys/mman.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/iommufd.h>
+#include <linux/limits.h>
+#include <linux/memfd.h>
+#include <linux/mman.h>
+#include <linux/sizes.h>
+#include <linux/time64.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+static const char *device_bdf;
+
+FIXTURE(vfio_dma_mapping_perf_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+};
+
+FIXTURE_VARIANT(vfio_dma_mapping_perf_test) {
+	const char *iommu_mode;
+	int mmap_flags;
+};
+
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags)		  \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_test, _iommu_mode ## _ ## _name) {	  \
+	.iommu_mode = #_iommu_mode,						  \
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE | (_mmap_flags), \
+}
+
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, MAP_HUGETLB | MAP_HUGE_2MB);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUGE_1GB);
+
+#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
+
+FIXTURE_SETUP(vfio_dma_mapping_perf_test)
+{
+	self->iommu = iommu_init(variant->iommu_mode);
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->iova_allocator = iova_allocator_init(self->iommu);
+}
+
+FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
+{
+	iova_allocator_cleanup(self->iova_allocator);
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
+{
+	const u64 size = SZ_1G;
+	const int flags = variant->mmap_flags;
+	struct dma_region region;
+
+	ksft_print_msg("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
+
+	TIME("mmap",
+	     region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0));
+
+	/* Skip the test if there aren't enough HugeTLB pages available. */
+	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
+		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
+	else
+		ASSERT_NE(region.vaddr, MAP_FAILED);
+
+	region.iova = iova_allocator_alloc(self->iova_allocator, size);
+	region.size = size;
+
+	TIME("IOMMU map", iommu_map(self->iommu, &region));
+	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
+
+	TIME("IOMMU unmap", iommu_unmap(self->iommu, &region));
+	TIME("munmap", ASSERT_EQ(0, munmap(region.vaddr, size)));
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0.1003.g10538fe699-goog


Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620D3009CB
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862689; cv=none; b=CDTg5LuIu7PCywRaTEgA6z+hM2dHFemQ5SaXZ1993VvSPgzBsIWzABc28zGK3TQLS+tf2osKVw/YojcQfrIaxLQebxNmsweyCcu0Y9TjbJvjmchs4yyTdiuuHWGmn5HTZ9LsM/NOGoIReK16oVTkoFH4LotnxfmHKl3ZYor83Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862689; c=relaxed/simple;
	bh=hASDLwgzz2InygbqWRIKK/JhXNwB5J1pChSeEg3azTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hlATlVkDUW61alJ3qFV6cqCXWq1XslAES1HUXhiTw7QA11fD6K9A/gdiqN4vnQA9X8SkJ+ihzIE8HdlfPSlNKN2yM294zgxq3xdO6dPJjRZxfNOP6AyHe0hsCz+sgoS2XRe4MT43hezqZ+c9s4wgZFKVl6meq20BtGHm+YlGZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afcIUME1; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afcIUME1"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84857446424so47722b3a.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862677; x=1786467477; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0cPV9+34Zovxzrsvfu/WKJplCkQJe+WXrKI8kv/n3ro=;
        b=afcIUME1343cFQHJIpjhyR80kCBRkkTD82mc5GyaFi/kYHdPzWUIrC6q8PrpKww/ZE
         s//lh9sMB6JcFKoLZshEA1rUiLJ1DO7jNJ+yZE5H8wGIZtPGswHWKkPPxcxgyUY1iNVI
         IqwzFnCqj/6Oqgg61ep0dj0fguQba1OnTLczxl+kL4fqk2W5ngsTfVXA63QvBBSsIU9C
         4SQjLqbK/0xQpZuBGsJjEgsMJy5Qo5qkdBp9BCfR1uHIIiNcq0WtVVlXSdsUA/W8Kk1+
         CZv3/QGa4ZzhBBVLo/hmDAlfDdAiPA/pgNii/s/fm21lWHlN86gfNMPHdHoLSq0pCPFk
         XlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862677; x=1786467477;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0cPV9+34Zovxzrsvfu/WKJplCkQJe+WXrKI8kv/n3ro=;
        b=W0zhqxdOhczEIsHAxn7r0eDTf/BK6tHDa91vqvdgdQslXQqpPdcyvTO9cIu2h7p+6A
         QPZAMX0Sl1v3L5n8r35xfI8DXS9ijKe9mfyL6WtKaRY/rk3JWMI08a9wzLMYqnlhV9tR
         plqthQzAl+JM5MYiY2ncCHktIKrjUQ6d+ka4wFo2OskODCRmVcjGn+uNi3sV0fuKBpor
         JWNWCbishhfAwEEX6QawxwA1IAcaJJToKmAe7kMM7m+5AWJNKu79+XwqG2X0Ypq/AZEq
         dmLa8a09kgCPnz+6dAqHc2kj+YMXh/EtxTVfq6KwMzriydQhpmHYpnO3LnYYmbpvhAxR
         Wt5w==
X-Gm-Message-State: AOJu0YzWL0LgN8o0oLS6W61kmmN8TqrlwA1q3ynC9AqBn9wIusyQpo6W
	u/BqnGtVQdH5C2IeQOF0NsglEcZ/IyAJqGx2yuixKGnIQKG2Jllg397LEAsV/FYbkSZm6Cgsusb
	S2sRC5xU4RlYFMXhIP5j5gJnCJ0o90a4JR2FPgi1aFJQ/9W0USV1zcqJAcKfhfB0Y2xfN60gq9V
	YdAi8o44dCsqbvQWmEIuMqpUcK0hkXTZ16qbCuYKyZ0rdLbNpoMHGNwQ==
X-Received: from dybkf25.prod.google.com ([2002:a05:7301:3a99:b0:30f:aee:94ce])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a86:b0:3c3:ad17:eded with SMTP id adf61e73a8af0-3cb8603af51mr192222637.36.1785862676399;
 Tue, 04 Aug 2026 09:57:56 -0700 (PDT)
Date: Tue,  4 Aug 2026 16:57:46 +0000
In-Reply-To: <20260804165748.1060476-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804165748.1060476-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260804165748.1060476-3-aaronlewis@google.com>
Subject: [PATCH v2 2/4] vfio: selftests: Introduce vfio_dma_mapping_perf_test
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
 .../selftests/vfio/lib/include/libvfio.h      | 28 ++++++
 .../vfio/vfio_dma_mapping_perf_test.c         | 90 +++++++++++++++++++
 3 files changed, 119 insertions(+)
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
index 07862b470777..cf322b499cfb 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -9,6 +9,34 @@
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
+								   \
+	timer_start(&__start);					   \
+	_expression;						   \
+	printf(_name " = %.2lfms\n",				   \
+	       (double)timer_elapsed_ns(__start) / NSEC_PER_MSEC); \
+} while (0)
+
 /*
  * Return the BDF string of the device that the test should use.
  *
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
new file mode 100644
index 000000000000..26c04cabef61
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
+	printf("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
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
2.55.0.654.g21b8a5bc05-goog


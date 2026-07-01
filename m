Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E9370AC5
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938009; cv=none; b=tEU8LhycOsUy1v2gryxCzizDwAJE4+KCsLpH/Zb+4tkujeelkkvxxBPwALAjDNWm+1i0v1ZpSNyAO+iE34ZcYdkIZ/TfUKhcGztLVWyxXVVMHOBrjw+jQbR/FsAmwhrAJa1+J9x25Hsn+uQtgz8c4o4gTIO72fE4mnaQQgw7G/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938009; c=relaxed/simple;
	bh=4KEfuHRJpFYT5jEmjcFTuOijhwJ/hoaYjh0Y17dUgSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8t3JxMfN9FtK+Etq/66eGymndss/snjPlKX4ATbVsB2UK3LFjaAwmK+eYTUIwFBcILoUkbTKcBRWF0gx4M0Uz3CtIYOjSqSwD31Zx3FiNrTKRKyoFaR3eE9NbVUbegEBOMroy7i3DkOvpSoJEOoXeAnpKujewEXjHdhXhEUfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZ5cK595; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZ5cK595"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9aa197d5easo1851257a12.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938007; x=1783542807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UgSSY8WUFGu6h80kFLXB2vQvMpiDB5sWsAbO0KnBss=;
        b=DZ5cK595lI6HP7ohW6s8qa2xm0tfuhEaLSfq9mXgxDs1f68DDGDuEOdmlgsd9bwC8+
         kE3N3PzNopJz/Bqn0BKsRbxKyTK+keKKRTV08+ta/U1OjBndRrL3qWrCBWT/veKH4op4
         hRLFxObejVGpujCtO2L4cJDxyCmj3PbfR6sncM/N2O3pElZ5L/mC7fw3nowOleW6mR0G
         D7nC92hy6hT1dIBwDG39FrKc4BTnzFjD9qmGpkc+Z6jJeQQ4yUOMYtoWaZFAlRTx2E8B
         xa3Z4q6pukcJYe5eKoYeOddIEmvJ92t1frSXbruQTZF/AbAY+jg1/hVNVl7FAvezg6rx
         cG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938007; x=1783542807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8UgSSY8WUFGu6h80kFLXB2vQvMpiDB5sWsAbO0KnBss=;
        b=VWhy8TC51uNg+EgCBBucB5U7irM6GG13Z7ZE5rDf+IyqRd2P7oQQB7OyLOgRuL5Uzi
         2TjYBKYnmZqhPjl7lM099brC59aiblsSOzP0CWUxsrB7ha+Y8pSvIdmT5oEYCbGQOsji
         vTwrNeKOxMklzBYoSfWuCdQEgZfG5oVEa5DPKIsiS2aclCmgGodev0Vku+Qb8NhiEyr5
         9WXNQCf/pDBa/syr8aksVz05We+Xzcuh727F41VOzXhcyVuVBdYS8GJF1G97xrnviII2
         ITaT3airKGy7dY4J1VmVpxcqZCW9e+/sSnG+OhfnaqWwpC7SvXgM/InKM/Dl7YTqiK+w
         wBAg==
X-Gm-Message-State: AOJu0YxcoS4ejicqpqlkduC4m/M6hMLvLSw6VxdYV9GWaJJ8DfFOtwTk
	/M1eyLab5p1bxBvPVEaOtfhG7XT74C2aJZVgp84DzI6IkEEnSKLAEz0hU0q2kxUrjrxWlcX06WK
	3wtTM7qxpFkYQ3hVd6vqa7AQ7U4fYZE26tgPST3X2Kox15yq4EuqFamQhU1+jnxq2buOm1q0NJ0
	x/1d6cRgQFjz3wkNlva+jYVI+qqgocnMPpwS+Xnb9uEQMJl6crsJNEpw==
X-Received: from dlbrn2.prod.google.com ([2002:a05:7022:1502:b0:135:dd6a:be57])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:e292:b0:39b:bc11:9ec5 with SMTP id adf61e73a8af0-3bfd26883b5mr6283219637.13.1782938006657;
 Wed, 01 Jul 2026 13:33:26 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:33:08 +0000
In-Reply-To: <20260701203311.326798-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701203311.326798-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701203311.326798-2-aaronlewis@google.com>
Subject: [PATCH 1/4] vfio: selftests: Introduce vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a tool to aid in latency testing rather than a traditional
pass/fail test. The goal is to make the test configurable to expose
latency issues and make them easy to reproduce and share.

Start with a basic test that performs a simple DMA map/unmap and reports
the duration of each operation. Report the following four metrics:

  1. Time taken by mmap().
  2. Time taken to map a DMA region.
  3. Time taken to unmap a DMA region.
  4. Time taken by munmap().

Subsequent commits in this series will introduce more features to allow
for a wider variety of testing.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/vfio_dma_mapping_perf_test.c         | 124 ++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index e6e8cb52ab03..9f620c5ef6ab 100644
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
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
new file mode 100644
index 000000000000..87d84450fc47
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -0,0 +1,124 @@
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
+struct iommu_mapping {
+	u64 pgd;
+	u64 p4d;
+	u64 pud;
+	u64 pmd;
+	u64 pte;
+};
+
+static void timer_start(struct timespec *start) {
+	clock_gettime(CLOCK_MONOTONIC, start);
+}
+
+static double timer_elapsed_ms(struct timespec start)
+{
+	struct timespec end;
+
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	return (double)(end.tv_sec - start.tv_sec) * MSEC_PER_SEC +
+	       (double)(end.tv_nsec - start.tv_nsec) / NSEC_PER_MSEC;
+}
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
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags)	       \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_test, _iommu_mode ## _ ## _name) {   \
+	.iommu_mode = #_iommu_mode,					       \
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),	       \
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
+	struct timespec start;
+	u64 unmapped;
+	int rc;
+
+	timer_start(&start);
+	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
+	printf("Completed mmap() in %.2lfms\n", timer_elapsed_ms(start));
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
+	timer_start(&start);
+	iommu_map(self->iommu, &region);
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
+	timer_start(&start);
+	ASSERT_TRUE(!munmap(region.vaddr, size));
+	printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run(argc, argv);
+}
-- 
2.55.0.rc0.799.gd6f94ed593-goog


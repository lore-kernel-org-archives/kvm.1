Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662530;
	b=v7cs84cL/+r3fDCmVr1ORmckiOAw1EhsH2/8IxCypIjFxzFTKZIrY+D8VWHH1G4nRpzh
	 7zqceSMPCDV7TmsI2gQ6TwlLsFV7DrvO2ftmJhgECAfqhRwFP+31EmyhHH0bGawPNCn7x
	 pCeteUdH6DKl/lz1q6dTlwTLyZHcVcIF9g9I6uAiEIcKIBGHwYfqOqt31voMlzEXMMQKP
	 OJchbudvbtnqlY0Yok6x+2SxEjnXnXKYk1jaO9IWnyFegcs9cFXMUcAYRIAElczBOOaUr
	 wbpAYipXIamdPa/tkIBAyXqORWYJS3EMvspZAI1+Sb0wj1cE7VdRiwWjrt5aGC4M3VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5/dHgOsKATyUKvDlZE/AdAPo/m4xByng9a6Io6rUTBo=;
	b=EpXPrapauGcRT37LT/i+nghteOiEkuivD2Y6sV363Z4c4IZPyWjcQHW7v/pbpJ4ww3N6
	 Fp9RPfw2APjzCwjiLfTi31FYhE3jtwgNEYK4yjGCkoGaheOnPXquLnzUTvNxlWcsCuWFf
	 1OQgQcS1JlhcRtAtqgB24KvogMna3IkjVzfWm9WcLvh1/Y4pwwS1I7QDK5bN44UD/Thdt
	 XVkFg1AwWxm0GkqsyU5VdtPV37QtqGS+0VuqVCwUVaih6Mqyq7F+Ih2HigfiVP4b7ItCg
	 oT03Nh5Ycc7v7y7r2Kn47sRAZ23BCOPD/tptmYUqjahzE/nEWvMDweZj4Z+oR6OTSTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cxB+6u9T;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC1606A889
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50AC1606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cxB+6u9T
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1a71dd190b0so2861730c88.1
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 05:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794662528; x=1795267328; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5/dHgOsKATyUKvDlZE/AdAPo/m4xByng9a6Io6rUTBo=;
        b=cxB+6u9TNaol4tGEF14YgapYtEqn3ywLXVGjWHX/JTyP1ghmDmshkjCQ3fht/lc0OS
         cIvlAvHioiNYkNDdJMRFEHYQlDK8iT66jV5cN8QkopTObSgAHoZjsvGIdxJValmsxi6r
         P/3fEmDKeaMn2xVp/QnMzmVS2uqkxtxAL9+jopzM9gFfs1deodxbdADRbtMY0Een/T/v
         rk9LHjiivkfwSsFcYT5csSkPGaqHa3+VMnkz6rxOjlFIhLQowrbC0m9fmGokyhLcJd6q
         ooVGF4e20mOpkBKv/kS7eINEDVgouHRvW3MLqq4PwNxTSLRGgCkNrrX7BVsloL1JhyZL
         YLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662528; x=1795267328;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5/dHgOsKATyUKvDlZE/AdAPo/m4xByng9a6Io6rUTBo=;
        b=1Ckv8iueRW5V8MolcVRg8I1Bf5FcgQX2AcQdq3JcGEYYVHTbbzpOtu5J2sQVmBS5Tr
         PzVsxkOknCVbwM8GoNsSryip43XsZQ8xz9WfRcqypHtMr+/DgRwr7/E5sPvwXlmP9Y0E
         MyYWoqEk9iXAAF4TG4bbowIExf0sFHd62ou2lfYVlGjEf9cF8L+eyz5s0zg9EWnOsWfi
         hnzx4dhGHaA1R5CJViJOj2J9bjbyOrwDiw6daWvcIOvrOkoqMwYgLPHk6hgbqqj4dpWa
         awRloopJuHhD+aU93wLHCcOFdKPBetVOkqtt7MjH9FHDmXeLlHDuk0wmNZmNs6Fl/gjm
         KETA==
X-Gm-Message-State: APuU4Z/ldBzMQz9JaIqdeCLdliGtt6rCkFft8QQ4SSqJvSmY2JzcG4FP
	iFQOzPMCLHj3sa8vlZScoxVmdRpyoNdjNVqV2/xQBSHPnU3KgZguHdvfCMBAFeqfz4/ehsCU1Ny
	xhH7G5E23FnzqTlk/e3y9kPoTciZusANbTiHDyPhFvl/GLp6SS642Xi4uBtJ2Bpw2ulpp1GTuyI
	A4t9B1/hS0f4qGByZZnRuOGN8FQL/Z9CTFhs8A8miM1L1n6OhIjqIy6Q==
X-Received: from dlev24.prod.google.com ([2002:a05:701b:4658:b0:1b2:375c:814])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:904:b0:195:c6c2:c6b with SMTP id a92af1059eb24-1b50319ce0bmr6027408c88.35.1794662527743;
 Sat, 14 Nov 2026 05:22:07 -0800 (PST)
Date: Sat, 14 Nov 2026 13:21:57 +0000
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
Message-ID: <20261114132200.113697-3-aaronlewis@google.com>
Subject: [PATCH v4 2/5] vfio: selftests: Introduce vfio_dma_mapping_perf_test
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

Subsequent commits will introduce more features to allow for a wider
variety of testing.

To ensure consistent DMA mapping times, the test uses MAP_POPULATE when
calling mmap(). This forces page faults to be handled upfront, isolating
the DMA mapping times from them.

Reviewed-by: David Matlack <dmatlack@google.com>
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
index 07862b470777..05802a2c3aba 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -9,6 +9,37 @@
 #include <libvfio/vfio_pci_device.h>
 #include <libvfio/vfio_pci_driver.h>
 
+#include <stdint.h>
+#include <time.h>
+#include <linux/time64.h>
+
+static inline void timer_get(struct timespec *ts)
+{
+	clock_gettime(CLOCK_MONOTONIC, ts);
+}
+
+static inline uint64_t timer_elapsed_ns(struct timespec start)
+{
+	struct timespec end;
+
+	timer_get(&end);
+
+	return (uint64_t)(end.tv_sec - start.tv_sec) * NSEC_PER_SEC +
+	       (uint64_t)(end.tv_nsec - start.tv_nsec);
+}
+
+#define TIME(_name, _expression) do {				   \
+	struct timespec __start;				   \
+	int __errno;						   \
+								   \
+	timer_get(&__start);					   \
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
2.56.0.611.g1030f0b940-goog


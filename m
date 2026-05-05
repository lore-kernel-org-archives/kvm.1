Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E04A2E33
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778019352; cv=none; b=fNmqgxa2tK9dpBloliPnFnxPPpgJRTgjxEZfjPnzOCC9fJm3uuNlhsYxNJU1FobDn1kAywHI1m2nXP0SEflgRq6Sx6A6XCB+bFkqje+SbE980Ad26qQ64pt2A43gK6DwKDWtDHnlZQhAa2HGFcXnf5LXIcVzR91NNzr5Sb0ewNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778019352; c=relaxed/simple;
	bh=DQLsDlRg9cK3KamXiSx3uW2lS+tLFTLFL9c5dcS3gjU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehKA5dv1GKnBAtCs0jVnC9Uzrye2Fvf2UWXx9AJrD7aFD4T44ZI4LfbLiCginBvX+7RezGEw3S1NzJAhzBKqL1FDzzrSex3rDcBC5jW4eQNTBg5aX1qDOVu0Dh5dwJgxILUbWlfVxOXEcE1HUNFTIdQl+Yw0Aah5zaCYo0+MxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/7ZKapQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/7ZKapQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2e8bba2e6so68610275ad.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778019350; x=1778624150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoB9bNzq2kNeo0SI5dGif4n9lwcujzy/IuEbYoKZRSY=;
        b=a/7ZKapQt/t6sA5tjdJCLfU1mI8aGWJAgwnAsqGFFk4df9QpkhXk1GbNNbi8Zho97q
         4i/8LeEV6seulWWyDLmVtDkVNLTmK3N31TPCnLwm2jK3H9hsWPkQRqh+4bckaog7al7E
         BRnQoWZdwE7P+eIJvlFAQFBnGy2M+QELUAZhChnLiuOhB3dA8ULv1ILv4Kqfll/QsM0k
         GDuga7x7pyCjmqNFPF129TQXgUx42qZyVeDxi1oACScww+m2qkM7ehW+L6eHwT8lXofU
         mQcVZAQMLtDMSUBVZ5db++nyDuC/zCj8VklHCHF/7CoG+XEtNOh2prgyFgVs0ZnEuNV+
         7mZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778019350; x=1778624150;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoB9bNzq2kNeo0SI5dGif4n9lwcujzy/IuEbYoKZRSY=;
        b=OF+3schyMKJ0ultTg+h9po0YICu+ceMXYeTw2IjB57UrnmnlvU2teG8RHHH8PaP4w5
         AXlhhseT4stj5SKNeVjTK9xXr3mTHEgGR1H2ZNbo1uWy5Rr6yHCIF/1EzyDaoyObp5zF
         YeB5FLdv9stzFzVRSLH+phfAulrt9ykX/syCKgSkes2nT+QQVIDxBdyDL0x/dP5Y1a8c
         9epVVRqKqEuXHgYJW2t74tU4nVrI56wdyOWm+z1HWusqFDnADpiNHUnhMZLryUmFBuHl
         oat0QJCQIi0WuCK9hC5Y+AqmX0y49FWGghUV2ZmtQkc/a1DwdiqbSkBuvK5YEc/MBaXu
         YRng==
X-Forwarded-Encrypted: i=1; AFNElJ9vCgRn5Ve6gJG81ykZ44MeAFn2Uw7gOy+qgAZH9/ct9kULdDA7S5lREvCPFnmgkxJp4K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV57CuljUMzp813hre78WLEtL5IzqXiHVPkbD8ySpLUKhOYOT0
	87D2fpN2XZBZfmu054FJmSVxLHpYtKvrunTlpAKfBNILv+wiGqZBMoDG/zVs0P2qAqKWsWagSOA
	j90IMnPjp5tdvNw==
X-Received: from pldp9.prod.google.com ([2002:a17:902:eac9:b0:2ba:f65:8ab8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b0b:b0:2b4:5d51:ce96 with SMTP id d9443c01a7336-2ba794b8457mr7527095ad.24.1778019349876;
 Tue, 05 May 2026 15:15:49 -0700 (PDT)
Date: Tue,  5 May 2026 22:14:36 +0000
In-Reply-To: <20260505221518.619123-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505221518.619123-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505221518.619123-3-skhawaja@google.com>
Subject: [PATCH 2/2] vfio: selftests: Add iommufd multi iommu test
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>, Aex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>
Cc: Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test for iommufd to verify creation of multiple iommus using an
already setup iommufd and switch between them.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/vfio_iommufd_multi_iommu_test.c      | 203 ++++++++++++++++++
 2 files changed, 204 insertions(+)
 create mode 100644 tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..24bdeaad590f 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -8,6 +8,7 @@ else
 CFLAGS = $(KHDR_INCLUDES)
 TEST_GEN_PROGS += vfio_dma_mapping_test
 TEST_GEN_PROGS += vfio_dma_mapping_mmio_test
+TEST_GEN_PROGS += vfio_iommufd_multi_iommu_test
 TEST_GEN_PROGS += vfio_iommufd_setup_test
 TEST_GEN_PROGS += vfio_pci_device_test
 TEST_GEN_PROGS += vfio_pci_device_init_perf_test
diff --git a/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c b/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
new file mode 100644
index 000000000000..7199c662637c
--- /dev/null
+++ b/tools/testing/selftests/vfio/vfio_iommufd_multi_iommu_test.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/sizes.h>
+#include <linux/vfio.h>
+
+#include <libvfio.h>
+
+#include "kselftest_harness.h"
+
+static const char *device_bdf;
+
+#define IOMMU_DEFAULT 0
+#define IOMMU_WITH_PT 1
+#define IOMMU_WITHOUT_PT 2
+
+static void region_setup(struct iommu *iommu,
+			 struct iova_allocator *iova_allocator,
+			 struct dma_region *region, u64 size)
+{
+	const int flags = MAP_SHARED | MAP_ANONYMOUS;
+	const int prot = PROT_READ | PROT_WRITE;
+	void *vaddr;
+
+	vaddr = mmap(NULL, size, prot, flags, -1, 0);
+	VFIO_ASSERT_NE(vaddr, MAP_FAILED);
+
+	region->vaddr = vaddr;
+	region->iova = iova_allocator_alloc(iova_allocator, size);
+	region->size = size;
+
+	iommu_map(iommu, region);
+}
+
+static void region_teardown(struct iommu *iommu, struct dma_region *region)
+{
+	iommu_unmap(iommu, region);
+	VFIO_ASSERT_EQ(munmap(region->vaddr, region->size), 0);
+}
+
+FIXTURE(vfio_iommufd_multi_iommu_test) {
+	struct iommu *iommu;
+	struct vfio_pci_device *device;
+	struct iova_allocator *iova_allocator;
+	struct dma_region memcpy_region;
+	void *vaddr;
+
+	u64 size;
+	void *src;
+	void *dst;
+	iova_t src_iova;
+	iova_t dst_iova;
+};
+
+FIXTURE_SETUP(vfio_iommufd_multi_iommu_test)
+{
+	struct vfio_pci_driver *driver;
+
+	self->iommu = iommu_init("iommufd");
+	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->iova_allocator = iova_allocator_init(self->iommu);
+
+	driver = &self->device->driver;
+
+	region_setup(self->iommu, self->iova_allocator, &self->memcpy_region, SZ_1G);
+	region_setup(self->iommu, self->iova_allocator, &driver->region, SZ_2M);
+
+	if (driver->ops)
+		vfio_pci_driver_init(self->device);
+
+	self->size = self->memcpy_region.size / 2;
+	self->src = self->memcpy_region.vaddr;
+	self->dst = self->src + self->size;
+
+	self->src_iova = to_iova(self->device, self->src);
+	self->dst_iova = to_iova(self->device, self->dst);
+}
+
+FIXTURE_TEARDOWN(vfio_iommufd_multi_iommu_test)
+{
+	struct vfio_pci_driver *driver = &self->device->driver;
+
+	if (driver->ops)
+		vfio_pci_driver_remove(self->device);
+
+	region_teardown(self->iommu, &self->memcpy_region);
+	region_teardown(self->iommu, &driver->region);
+
+	iova_allocator_cleanup(self->iova_allocator);
+	vfio_pci_device_cleanup(self->device);
+	iommu_cleanup(self->iommu);
+}
+
+FIXTURE_VARIANT(vfio_iommufd_multi_iommu_test) {
+	u32 start_iommu;
+	u32 end_iommu;
+};
+
+#define ADD_IOMMU_VARIANT(S, E) \
+	FIXTURE_VARIANT_ADD(vfio_iommufd_multi_iommu_test, S##_to_##E) { \
+		.start_iommu = IOMMU_##S, \
+		.end_iommu = IOMMU_##E \
+	};
+
+#define ADD_ALL_VARIANTS(S) \
+	ADD_IOMMU_VARIANT(S, DEFAULT) \
+	ADD_IOMMU_VARIANT(S, WITH_PT) \
+	ADD_IOMMU_VARIANT(S, WITHOUT_PT)
+
+ADD_ALL_VARIANTS(DEFAULT)
+ADD_ALL_VARIANTS(WITH_PT)
+ADD_ALL_VARIANTS(WITHOUT_PT)
+
+static struct iommu *setup_variant_iommu(struct iommu *fixture_iommu,
+					 u32 dev_id, u32 type)
+{
+	switch (type) {
+	case IOMMU_WITH_PT:
+		return iommufd_iommu_init(fixture_iommu->iommufd, dev_id,
+					  IOMMUFD_IOMMU_INIT_CREATE_PT);
+	case IOMMU_WITHOUT_PT:
+		return iommufd_iommu_init(fixture_iommu->iommufd, dev_id, 0);
+	default:
+		return fixture_iommu;
+	}
+}
+
+static void test_memcpy(struct vfio_pci_device *device, void *src, void *dst,
+			iova_t src_iova, iova_t dst_iova, u64 size, char val)
+{
+	if (!device->driver.ops)
+		return;
+
+	memset(src, val, size);
+	memset(dst, 0, size);
+
+	vfio_pci_driver_memcpy_start(device, src_iova, dst_iova, size, 100);
+	VFIO_ASSERT_EQ(vfio_pci_driver_memcpy_wait(device), 0);
+	VFIO_ASSERT_EQ(memcmp(src, dst, size), 0);
+}
+
+TEST_F(vfio_iommufd_multi_iommu_test, memcpy)
+{
+	struct dma_region memcpy_region1, driver_region1;
+	struct dma_region memcpy_region2, driver_region2;
+	struct iommu *iommu1;
+	struct iommu *iommu2;
+
+	iommu1 = setup_variant_iommu(self->iommu, self->device->dev_id,
+				     variant->start_iommu);
+	if (iommu1 != self->iommu) {
+		memcpy_region1 = self->memcpy_region;
+		driver_region1 = self->device->driver.region;
+
+		iommu_map(iommu1, &memcpy_region1);
+		iommu_map(iommu1, &driver_region1);
+
+		vfio_pci_device_attach_iommu(self->device, iommu1);
+	}
+
+	test_memcpy(self->device, self->src, self->dst, self->src_iova,
+		    self->dst_iova, self->size, 'x');
+
+	iommu2 = setup_variant_iommu(self->iommu, self->device->dev_id,
+				     variant->end_iommu);
+	if (iommu2 != self->iommu) {
+		memcpy_region2 = self->memcpy_region;
+		driver_region2 = self->device->driver.region;
+
+		iommu_map(iommu2, &memcpy_region2);
+		iommu_map(iommu2, &driver_region2);
+	}
+
+	vfio_pci_device_attach_iommu(self->device, iommu2);
+	test_memcpy(self->device, self->src, self->dst, self->src_iova,
+		    self->dst_iova, self->size, 'a');
+
+	vfio_pci_device_attach_iommu(self->device, iommu1);
+	test_memcpy(self->device, self->src, self->dst, self->src_iova,
+		    self->dst_iova, self->size, '1');
+
+	if (iommu1 != self->iommu) {
+		/* attach back to default iommu for cleanup */
+		vfio_pci_device_attach_iommu(self->device, self->iommu);
+		iommu_unmap(iommu1, &memcpy_region1);
+		iommu_unmap(iommu1, &driver_region1);
+		iommu_cleanup(iommu1);
+	}
+
+	if (iommu2 != self->iommu) {
+		iommu_unmap(iommu2, &memcpy_region2);
+		iommu_unmap(iommu2, &driver_region2);
+		iommu_cleanup(iommu2);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	device_bdf = vfio_selftests_get_bdf(&argc, argv);
+
+	return test_harness_run(argc, argv);
+}
-- 
2.54.0.545.g6539524ca2-goog


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312234;
	b=QGdVKnrLCZhPIm9UKATXw3Ibf/4A+0zcH7WyAyk4V6CaVrilZSlQNldEbgqbeRU6Frmx
	 imIhh+EiTf43ZnqaEtX7ltUSh9h2oJZC76XrwIDAFRQnToc/So7luCAtGmOlZ1eWGTTM+
	 YDBaIL88fWHMGZelO7gfvL1GEnYAzosCBYrBR81S3nu7srCxemzByVLacXXsMaj+rIk8N
	 IMMZ19xjnf9gkcVJ9pACC5Yq4JPrjx/Sk4F72xJ76OVP0DN5rgTYUj9Jm/PeRSTz63laV
	 MdDZetdH9fx72EZVNbp5MJKR9OvQSYEARIwDrc/nL5XVNonFfwKcdcEuZcCkwLBi2eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=29iMnvuhFO/JZRS7pb7tlMMukzGgcfiOEcJ6YX5Nc5k=;
	b=DfjPoKOo3vnLimPy9a/sAR4VdeVuwPEeL2vkLDvePFqiok7aNZTSAmCWaHDxZBlNEwwL
	 Kw/ie/Zg+R2iab67Qgda5eL32nQqRhEF2dGyMnd0zTK3r1KjygE57aIGUYPnVtojrSZ6r
	 EJ+EOZRGNSMsZNHdu2FH/YxkEYAv4sIEHs0/6juD4Q2HD0ROX60yZ72B6kVCxxoug4HV0
	 /FWjOsx9p6xYGNHKrbaP4OEUzc4Wp7hpuyobBh5ofgmE+OTIALe9KVHZs31Jtp1Rtl1+k
	 3FJtm/V9gMxtjAwyUPsWbdOBFYh4nh8GWqWZ88F2cB9QV9LWJvpqgWOmI3WaFbcbRqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a7Gxf3tc;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8D606A338
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19C8D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a7Gxf3tc
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so29537a12.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793312233; x=1793917033; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29iMnvuhFO/JZRS7pb7tlMMukzGgcfiOEcJ6YX5Nc5k=;
        b=a7Gxf3tcxxY4RappLczdU+SdTbix3jm0oEwGVYuVfwy94d+dBng1+Rjr0ZZk/8p6hY
         DdQlTgs+cA/nU9X75uOa0hAjs5mP0MN25cft/xDRPshcBliWehT4KNrSra9Cz3XKNrVW
         acVhKhS1Noi6NsZ77UuLsn/5ZRjGn/1zLPsvU7Rd4jOaJk7owzc3JFqqlEf6lQtyeI+p
         QlXixtdQ9zezmx3CP4eRlq1LFAJPI9T/slwbLOZsEJcU6cNlUGVZs3EIgR6ly6mP0uy8
         0SWEsMEM1g6dA3AOC6Ye8jXxrNcuzC+kUviegjKs4YRX+ogBosfhDC08EFHKoG7BFvUk
         UaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312233; x=1793917033;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=29iMnvuhFO/JZRS7pb7tlMMukzGgcfiOEcJ6YX5Nc5k=;
        b=oPmLz/K6QZYd/QRopkTZSTO98sdcU4hAot5t6wSDKQbi43xSKIzgaUvmh+gxosoCg7
         /CfJALzWWZqv7JGOZAUpQE9Nl8O/rGRRYArRUX51Uixon6Tr8RTOCmKLd+DXdbWGLqT5
         8xSU7A6yCGwDkuFjnID4nM9HFJlkiwxwh06U1X752/xQMYKXtgQ8OpwKeSTXakQbycbi
         K9IHfpiHDdJbSZdGOaCxF5EIeLZn1Pf252T8+5POk6Twn9cIfdgGl3na3SyKs/Mx3yMl
         txM6emuZn7CV2+SG0Y0ckfvjedfqzCDZm1z1opq3uHx+DLwjkHK/wW+O+pu+hRLfDkhf
         C+Hw==
X-Gm-Message-State: AFq9FYJiCqZTEfErlM+d8IZQR//pNmCCjp2NLe3Y340ej2RcBs8mcfdN
	hCrmG31Yd6HrjI5Ar0i2UcAShUHTpAShR0WNs305J1d0uqcrQ5I2Xkwe3k9a/CzXXgNhRyatQIB
	pMgd2w3QFoQA4FzIHDsDYSvYciC2KbElIXF5d/5Wpk2CmmaKE0TSfjnJ0F3is5Reo3tUxiOW47Z
	Nl79GPXPGa8FHPnG+AZ7f4moczQIMBNKUQCbImv/4BfDI=
X-Received: from plch11.prod.google.com ([2002:a17:902:f2cb:b0:2e2:c684:16fc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d986:b0:2e4:b112:14d with SMTP id d9443c01a7336-2eb3651ef90mr6403395ad.54.1793312232977;
 Thu, 29 Oct 2026 15:17:12 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:17:09 +0000
In-Reply-To: <20261029221710.1871112-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029221710.1871112-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029221710.1871112-3-dmatlack@google.com>
Subject: [PATCH 2/3] vfio: selftests: Skip tests when the IOMMU mode is not available
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Skip tests when the IOMMU mode they need is not available on the current
system, instead of failing. Add iommu_mode_is_available() to check whether
a given IOMMU mode (or, if NULL, any IOMMU mode) is available, and
SKIP_IF_IOMMU_MODE_UNAVAILABLE() to skip a kselftest harness test if not.

On a kernel without iommufd, for example, all of the iommufd and
iommufd_compat test variants currently fail on an assert in iommu_init().
Skip them instead, with a message that explains why:

  ok 33 vfio_pci_driver_test.iommufd.send_msi # SKIP IOMMU mode not available: iommufd

Use SKIP_IF_IOMMU_MODE_UNAVAILABLE() in all tests that run across multiple
IOMMU modes, and in the tests that let the library pick the mode by
passing NULL to iommu_init(). Also skip vfio_pci_driver_test, which calls
iommu_init() from main() to probe the device, if no IOMMU mode is
available.

Skip from the test via the kselftest harness's SKIP(), rather than from
within iommu_init() via ksft_exit_skip(). ksft_exit_skip() is not aware of
the harness, and so would emit a bogus "1..0 # SKIP" plan line in the
middle of the TAP output, and the harness would report the reason for the
skip as "unknown".

Signed-off-by: David Matlack <dmatlack@google.com>
---
 .../vfio/lib/include/libvfio/iommu.h          | 26 ++++++++++++++++++-
 tools/testing/selftests/vfio/lib/iommu.c      |  8 ++++++
 .../vfio/vfio_dma_mapping_mmio_test.c         |  2 ++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  4 +++
 .../vfio/vfio_pci_device_init_perf_test.c     |  2 ++
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +++
 .../selftests/vfio/vfio_pci_driver_test.c     |  7 +++++
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c |  4 +++
 8 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index fb0a681ecc72..04b0377a0f8f 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -32,11 +32,18 @@ struct iommu {
 
 /*
  * Pass NULL for iommu_mode to automatically pick the mode most likely to work
- * on the current system.
+ * on the current system. Use iommu_mode_is_available() to check that the mode
+ * is available before calling iommu_init(), e.g. to skip the test if not.
  */
 struct iommu *iommu_init(const char *iommu_mode);
 void iommu_cleanup(struct iommu *iommu);
 
+/*
+ * Returns true if the given IOMMU mode is usable on the current system. If
+ * iommu_mode is NULL, returns true if any IOMMU mode is usable.
+ */
+bool iommu_mode_is_available(const char *iommu_mode);
+
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
 
 static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
@@ -81,4 +88,21 @@ FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd, ##__VA_ARGS__)
 
+/*
+ * Skip the current kselftest harness test if the given IOMMU mode is not
+ * available on the current system, or if no IOMMU mode is available if
+ * _iommu_mode is NULL. Like SKIP(), statement is executed after marking the
+ * test as skipped (e.g. "return"), and this can be used anywhere SKIP() can be
+ * used.
+ */
+#define SKIP_IF_IOMMU_MODE_UNAVAILABLE(statement, _iommu_mode) do {		\
+	const char *__iommu_mode = (_iommu_mode);				\
+										\
+	if (!iommu_mode_is_available(__iommu_mode))				\
+		SKIP(statement, "%s%s",						\
+		     __iommu_mode ? "IOMMU mode not available: " :		\
+				    "No IOMMU mode is available",		\
+		     __iommu_mode ?: "");					\
+} while (0)
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOMMU_H */
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 535e6c7cf260..2c7cf6dc919a 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -107,6 +107,14 @@ static const struct iommu_mode *iommu_mode_lookup(const char *iommu_mode)
 	VFIO_FAIL("Unrecognized IOMMU mode: %s\n", iommu_mode);
 }
 
+bool iommu_mode_is_available(const char *iommu_mode)
+{
+	if (!iommu_mode)
+		return iommu_mode_detect();
+
+	return iommu_mode_probe(iommu_mode_lookup(iommu_mode));
+}
+
 int __iommu_hva2iova(struct iommu *iommu, void *vaddr, iova_t *iova)
 {
 	struct dma_region *region;
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
index d7f25ef77671..add7d3881930 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_mmio_test.c
@@ -64,6 +64,8 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
 
 FIXTURE_SETUP(vfio_dma_mapping_mmio_test)
 {
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, variant->iommu_mode);
+
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 7d0de8c79de1..e42170aecf6e 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -119,6 +119,8 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB |
 
 FIXTURE_SETUP(vfio_dma_mapping_test)
 {
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, variant->iommu_mode);
+
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
@@ -228,6 +230,8 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
 	iova_t last_iova;
 	u32 nranges;
 
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, variant->iommu_mode);
+
 	/*
 	 * Over-allocate mmap by double the size to provide enough backing vaddr
 	 * for overflow tests
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
index e1a54e153cd3..8a98c86096be 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_init_perf_test.c
@@ -44,6 +44,8 @@ FIXTURE_SETUP(vfio_pci_device_init_perf_test)
 {
 	int i;
 
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, variant->iommu_mode);
+
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->threads = calloc_assert(nr_devices, sizeof(self->threads[0]));
 	self->thread_args = calloc_assert(nr_devices, sizeof(self->thread_args[0]));
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 59a7c1f71804..1b1baa1e1c85 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -29,6 +29,8 @@ FIXTURE(vfio_pci_device_test) {
 
 FIXTURE_SETUP(vfio_pci_device_test)
 {
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, NULL);
+
 	self->iommu = iommu_init(NULL);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
@@ -121,6 +123,8 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 
 FIXTURE_SETUP(vfio_pci_irq_test)
 {
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, NULL);
+
 	self->iommu = iommu_init(NULL);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
diff --git a/tools/testing/selftests/vfio/vfio_pci_driver_test.c b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
index f8f99ee6bb1a..710f9e7684d9 100644
--- a/tools/testing/selftests/vfio/vfio_pci_driver_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_driver_test.c
@@ -80,6 +80,8 @@ FIXTURE_SETUP(vfio_pci_driver_test)
 {
 	struct vfio_pci_driver *driver;
 
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, variant->iommu_mode);
+
 	self->iommu = iommu_init(variant->iommu_mode);
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
@@ -270,6 +272,11 @@ int main(int argc, char *argv[])
 {
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
+	if (!iommu_mode_is_available(NULL)) {
+		fprintf(stderr, "No IOMMU mode is available\n");
+		return KSFT_SKIP;
+	}
+
 	if (!device_has_selftests_driver(device_bdf)) {
 		fprintf(stderr, "No driver found for device %s\n", device_bdf);
 		return KSFT_SKIP;
diff --git a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
index f3a018b8699d..32a1e651c815 100644
--- a/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c
@@ -90,6 +90,8 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(null_uuid, NULL);
 
 FIXTURE_SETUP(vfio_pci_sriov_uapi_test)
 {
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, variant->iommu_mode);
+
 	self->iommu = iommu_init(variant->iommu_mode);
 
 	self->pf_token = UUID_1;
@@ -163,6 +165,8 @@ TEST(failed_second_open_does_not_clobber_token)
 	struct iommu *iommu;
 	int ret;
 
+	SKIP_IF_IOMMU_MODE_UNAVAILABLE(return, MODE_IOMMUFD);
+
 	iommu = iommu_init(MODE_IOMMUFD);
 
 	/* Create and bind PF using UUID_1 */
-- 
2.56.0.317.g454f8302e1-goog


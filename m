Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665331;
	b=VJyRayVhhn8oOIys8NOq+E1/5eMMj1Ht7yxanv8MG2ocG+gINlBKq+3rTY0rFM0OivmN
	 tvBhDwwmiR09WZ7ntYTre5qu9wDlGi2OrIqXVj/8RsLQqQQBcIFhk34RHJXcLpCY1ZaAI
	 w0LDS/tuaONZxCr7hhvhFE9pA18THDnZz+BGsHp+1snSjujf/8mfiAzQfZqxE5ejcNNdx
	 rlnb/uOZ/baC1v3dZxpFLmHwW1WnWUOumZioSXDpYrFYd2U4QGbjEjbzPBkYh/v2rA95b
	 +8rxYfj9CaS2OEYZlJxNNt3YH5WYfw+7iMfxrOv3YlILrwSYcATVfMLPW+y+S5oFWOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665331;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=5SKEbrleWXCWjOecSIe6EnlSpL3KMpGQVEgAvQszztQ=;
	b=BByRAKABHAzWle/4Rv4IxXGaf3Dcvp5aw+lMkJsEyc3rHbYT0x7amCkkz0bEsXYhGumP
	 hq4Jng8MGbiq/vgcm14jfJ6Uhuz8nDIZ8QpkUwPqp8NLS3ZwKOy9EeQLmr421O03qasvE
	 1Gk3bjDoc8AnvcGww9RE8aNk+n6YPkDfbR2iwIbiu5s32Y6JZPQfdH6LO/GsWnaGRb4s0
	 sdVOEK63THq0uRocw5F+McGuc45150rq52dKRtcuMzoQZc9vHY94dgbS2Hwh22W7yRDZ5
	 au6Je6URR1RCAnL2olV1dI9VpjMnswA1iWz0Ov6xmmruWDiZxNtL2XxOWxZvpSev0Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nHeZxmKY;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5466606A33D
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5466606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nHeZxmKY
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ea71803effso38103315ad.3
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793665330; x=1794270130; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SKEbrleWXCWjOecSIe6EnlSpL3KMpGQVEgAvQszztQ=;
        b=nHeZxmKYh3ZGU39vDlrwpIAm8uycHmHmn5EFQxNFvuAxE8Naln5rJVHlPyjYs1ciba
         W/ntNKT+LWjxr6BqN3WUEBc0+DanQeqT/Sw+2paKMZEZ//mFb48P8vsSILHrHxKfJTeI
         dtDSBvasg2yQKd3KwEZuc0jT4S9Sbkdl9lsyNvKrRezyB9lyxLXkbt21FqiAWQatbDre
         ORrjPsDPedBJbjGnGGKJ5m+Q2+8Psee4b/RPHXQqF13H39gugwVNDRN+EUpdAhhCQ3y8
         OfZ6EvuUtBYGx8jFBg2PsAUSqWxFdM9/bhyqQZkt9N6OZPw8e9QqHtu9uNpj9Zbvk8f/
         ugRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665330; x=1794270130;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SKEbrleWXCWjOecSIe6EnlSpL3KMpGQVEgAvQszztQ=;
        b=jcD8znkdovghY7eZPv4Th4Q0xwAaUkK37WwpdljPxjCDs1B/o2Iu50iLUQoeji3rbY
         V31zZQSEoTGQDv9JUgv2wRXVur8PkllfGQqDc7BvtlOgIRAFDcqkyXcgxrWzacjXIB+N
         mzsGvXklkpP4Wt0UYUQsOlSdbMDiCarKvmvzXQ0xgtxCR6JyrMnWnKsizpBNeXg+pW/4
         WjBxam5E0rlCad1J0p0vnmpdiMPTM5qT5/nwaDKrVq9gSbRKkxadimtWjyrOLT/wP5k0
         x182VFWorTkupswqCVqbXcpyfVdJtHdJ9S90TMzxn7MwgXKayxNAG9CWM/uhDRwPKgpb
         oxBQ==
X-Gm-Message-State: APuU4Z9F/EFuTk9BcZ3ILdkouKg9hrjD35UaQo68cETiXDxSLX4wW6h1
	Olsy12CFNxT6pqek0NKXKkhd1h1t32vcsvl0gufHMKNeMmi2uXs1d2B3W22acHGZgxiwNQ3SEMq
	w/kzxGhtqFGfrChfRgvKVa55JuBeZozR1L5A08VlfmsBYz2aRMEu+YZqxK2AyyzwFSlqb3fE8UM
	2bP0NaN+t+YeMtGKWIstDv//Kf3nwMGdNr4HCIVee1cIU=
X-Received: from plct12.prod.google.com ([2002:a17:902:d28c:b0:2e5:712c:5c7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1cb:b0:2e5:a355:56e4 with SMTP id d9443c01a7336-2eb364953dbmr104803055ad.11.1793665329726;
 Mon, 02 Nov 2026 16:22:09 -0800 (PST)
Date: Tue,  3 Nov 2026 00:22:02 +0000
In-Reply-To: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103002205.3348519-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261103002205.3348519-3-dmatlack@google.com>
Subject: [PATCH v2 2/5] vfio: selftests: Skip tests when the IOMMU mode is not available
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Skip tests when the IOMMU mode they need is not available on the current
system, instead of failing. Add iommu_mode_is_available() to check whether
a given IOMMU mode (or, if NULL, any IOMMU mode) is available,
iommu_mode_unavailable_msg() to explain why a test is skipping, and
SKIP_IF_IOMMU_MODE_UNAVAILABLE() to skip a kselftest harness test if the
mode is not available.

On a kernel without iommufd, for example, all of the iommufd and
iommufd_compat test variants currently fail on an assert in iommu_init().
Skip them instead, with a message that explains why:

  ok 33 vfio_pci_driver_test.iommufd.send_msi # SKIP IOMMU mode 'iommufd' is not available

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
 .../vfio/lib/include/libvfio/iommu.h          | 31 ++++++++++++++++++-
 tools/testing/selftests/vfio/lib/iommu.c      | 20 ++++++++++++
 .../vfio/vfio_dma_mapping_mmio_test.c         |  2 ++
 .../selftests/vfio/vfio_dma_mapping_test.c    |  4 +++
 .../vfio/vfio_pci_device_init_perf_test.c     |  2 ++
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +++
 .../selftests/vfio/vfio_pci_driver_test.c     |  7 +++++
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c |  4 +++
 8 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index fb0a681ecc72..f204c71494fe 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -32,11 +32,25 @@ struct iommu {
 
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
+/*
+ * Returns a message explaining that the given IOMMU mode (or, if iommu_mode is
+ * NULL, any IOMMU mode) is not available, e.g. for tests to print when
+ * skipping.
+ */
+const char *iommu_mode_unavailable_msg(const char *iommu_mode);
+
 int __iommu_map(struct iommu *iommu, struct dma_region *region);
 
 static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
@@ -81,4 +95,19 @@ FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
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
+		SKIP(statement, "%s",						\
+		     iommu_mode_unavailable_msg(__iommu_mode));			\
+} while (0)
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOMMU_H */
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 0393536370e7..526bb21f2766 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -111,6 +111,26 @@ static const struct iommu_mode *iommu_mode_lookup(const char *iommu_mode)
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
+const char *iommu_mode_unavailable_msg(const char *iommu_mode)
+{
+	static char msg[128];
+
+	if (!iommu_mode)
+		return NO_IOMMU_MODE_AVAILABLE_MSG;
+
+	snprintf(msg, sizeof(msg), "IOMMU mode '%s' is not available",
+		 iommu_mode);
+	return msg;
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
index f8f99ee6bb1a..56178c25c2fd 100644
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
+		fprintf(stderr, "%s\n", iommu_mode_unavailable_msg(NULL));
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
2.56.0.385.gac671c819a-goog


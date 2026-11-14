Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662532;
	b=TZkea5RasjEtW4YkCB44VdcFJaBcdWQiJdqEtnnkEt/1I/1JaeQtGtsMqMXX5DhfxG8j
	 gRT0qx0MHccJnb/QR0zdCmF17gUvZj7fGsaC+ebUiGY7JI0d9Rf020OjPb1GkZJvmL9lW
	 9GYjXk7YKdCTQyldSfLPGUI6s05ytIdZHuS5mJFRyEedZnGjevsc9s/co/mt1LBpGXyIr
	 EJz1lnjPj2yJ19VdvtyUkBjNIuxdr/zAac92El9qUkvD1rViK5BOARxaWTr3nIkJl2ijL
	 4YTETvr23+nhHMp6b5ioZIrzU2UA5iH0U+IiqwehcnthgENBfQ6uipc2pprYHHT4mfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mr8KrDnzXuL95QpOwferNfI2WjvgEHCDBjvr34Rp5qY=;
	b=44qnBRiu+kBtL4Fp6fp0z5K9AkTu8Rb0c6JB938pBPfNJE7aLeRgfxNooVR7ZnNTrVm7
	 LFpY04eR3GEgeIwoNo5TcxuY3ovtxSzyM48J10oYaApfhlcJmaDhfdAKXNRIZZDzb8LaX
	 Myr2QkrC1T/BeRIX2/JZQskZIHeZDWkVxFT9p7k0BRvWaayi1KxN0ytm5DNat+thBDbmc
	 OZrNNQeAwLahqUQUlWOAsjUEOJcQlv1YyRlEfmIDY5UYuwlr8D2KuiVOc1JvGiujOYLhp
	 7lwMqyRgFLaR4mZr5kfwZtOvv+faiorXjSxlET0RGleT7F+pEzEizAHz+M25EDYWBSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ou0we7Sp;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B03606A882
	for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 13:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B03606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ou0we7Sp
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14373747468so544c88.1
        for <kvm@vger.kernel.org>; Sat, 14 Nov 2026 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794662531; x=1795267331; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mr8KrDnzXuL95QpOwferNfI2WjvgEHCDBjvr34Rp5qY=;
        b=Ou0we7SpIwUt6oK3wYbaGcGxTp6O9oPptV4MzvM3uJUBl0B1IKDIOJaOSjWzqvS+Sd
         frITv+vj6MBcNYcKdbKH5Oifod5SJ8hUJv0QwOX/dEOSMVvorBkNTuF8oHnWwvEZdXzI
         z/xvLgcZh/5+BYLXoeMjmSCY81qyzk4M+RMCxhtQtWrBR+WPsPBX02eciAgm90q++iBN
         pg6yvY9qapkupzgSIufJOg44OREoqPJ7W01Pq6gwKBTE9VsGfS3GFg09Xu77KA0XZsGA
         df7/QPm5iR4r7O+dEXk1tBNjxmQLSxIpa/FA/MPsKx5LP0aNuEHH86ZaCUp8BTgh2Dyl
         0dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794662531; x=1795267331;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mr8KrDnzXuL95QpOwferNfI2WjvgEHCDBjvr34Rp5qY=;
        b=CCyufEWnv55x0/bgM9Jj9AZfCylXxYhaeJLbJLTRV5TabB4EM8A6bMx4gSa2gafb6a
         Mkmr63XiQQVjE+6WcjBvv3Ohmbh3oWiQhJh8PpAEV+8mk4d+ruQqOm9u96HZRuhhe8pU
         WMx1Pe0w010c7asrzAcLVWAxKHBXxnWcyg85E/dhazNVy2c8b2ejQZIo41Qb9JHjBXc6
         mdwQ5P4wAD++x5B81FKYRQ3NEeCe3/IFbed9vrm5tvjexVTgbUzPzXQMwyQtpGjNQR7J
         nWAc353405SB0zp2t9ueUst2Cjqtbse6Pb/WeK4H/kbcQVo300o7PkHjwr0uGEG6Mvq3
         u95w==
X-Gm-Message-State: APuU4Z+j0OHHi7veYCnOUUG8RO2jFN9OCEoGGgRCQFwKkbea/2BscwPh
	KUIS4/ehhKQc53Fl1Y/Fvf4MuhLo/YfP5apCnZIx7ejbKwD1+d5rJXH/nEy/0qgFpqj+2/4AMyf
	6+evPxlPGF8khGwlSdSOQlxHYGrpny5eDDDC84PAsKhiXfmUbbiwO5SHzubNGXnP6qMghPQeG/x
	4pwt5GuO1oHMKgDgpLft3HjE7A/2bLDTkFP2J6Z/MkQb9JrzBILK5Vfg==
X-Received: from dyad23.prod.google.com ([2002:a05:693c:8357:b0:369:7ef0:57b0])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2912:b0:1b2:490b:6fdd with SMTP id a92af1059eb24-1b5030ad368mr5481397c88.24.1794662530894;
 Sat, 14 Nov 2026 05:22:10 -0800 (PST)
Date: Sat, 14 Nov 2026 13:22:00 +0000
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
Message-ID: <20261114132200.113697-6-aaronlewis@google.com>
Subject: [PATCH v4 5/5] vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the user to specify a DMA region size via the command line for
vfio_dma_mapping_perf_test.

Use test_harness_run_opts() to introduce a '-b' option to specify the
DMA region size so that both the test size and test harness options can
be passed together naturally:

  ./vfio_dma_mapping_perf_test -b 16G -v vfio_type1_iommu_anonymous_hugetlb_1gb

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 .../vfio/vfio_dma_mapping_perf_test.c         | 144 ++++++++++++++----
 1 file changed, 117 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
index 086a63a50df8..6e38cc134a49 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <ctype.h>
 #include <limits.h>
 #include <stdio.h>
 #include <sys/mman.h>
 #include <time.h>
 #include <unistd.h>
 
+#include <linux/align.h>
 #include <linux/iommufd.h>
 #include <linux/limits.h>
 #include <linux/memfd.h>
@@ -17,7 +19,81 @@
 
 #include "kselftest_harness.h"
 
-static const char *device_bdf;
+static struct {
+	u64 size;
+	const char *size_str;
+	const char *device_bdf;
+} test_params = {
+	.size = SZ_1G,
+	.size_str = "1G",
+};
+
+/*
+ * Parses "[0-9]+[kmgt]?".
+ */
+static u64 parse_size(const char *size)
+{
+	int shift = 0;
+	char *scale;
+	u64 base;
+
+	VFIO_ASSERT_TRUE(size && isdigit(size[0]),
+			 "Need at least one digit in '%s'.", size);
+
+	base = strtoull(size, &scale, 0);
+
+	VFIO_ASSERT_GT(base, 0, "Size must be greater than 0!");
+	VFIO_ASSERT_TRUE(base != ULLONG_MAX, "Overflow parsing size!");
+
+	switch (tolower(*scale)) {
+	case 't':
+		shift = 40;
+		break;
+	case 'g':
+		shift = 30;
+		break;
+	case 'm':
+		shift = 20;
+		break;
+	case 'k':
+		shift = 10;
+		break;
+	case 'b':
+	case '\0':
+		shift = 0;
+		break;
+	default:
+		VFIO_FAIL("Unknown size letter '%c'.", *scale);
+	}
+
+	VFIO_ASSERT_TRUE((base << shift) >> shift == base,
+			 "Overflow scaling size!");
+
+	return base << shift;
+}
+
+static void opts_help(void)
+{
+	fprintf(stderr,
+		"\t-b bytes Specify the size of the DMA region to be mapped\n"
+		"\t         and unmapped. e.g. 16M or 8G, (default: 1G)\n");
+}
+
+static int opts_handler(int opt, char *optarg)
+{
+	if (opt == 'b') {
+		test_params.size = parse_size(optarg);
+		test_params.size_str = optarg;
+		return KSFT_PASS;
+	}
+	return KSFT_FAIL;
+}
+
+static const struct test_harness_cli_opts opts = {
+	.optstring = "b:",
+	.handler = opts_handler,
+	.help = opts_help,
+};
 
 FIXTURE(vfio_dma_mapping_perf_test) {
 	struct iommu *iommu;
@@ -27,25 +103,27 @@ FIXTURE(vfio_dma_mapping_perf_test) {
 
 FIXTURE_VARIANT(vfio_dma_mapping_perf_test) {
 	const char *iommu_mode;
+	u64 page_size;
 	int mmap_flags;
 };
 
-#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags)		  \
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_test, _iommu_mode ## _ ## _name) {	  \
-	.iommu_mode = #_iommu_mode,						  \
-	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE | (_mmap_flags), \
+#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _page_size, _mmap_flags) \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_test, _iommu_mode ## _ ## _name) {	    \
+	.iommu_mode = #_iommu_mode,						    \
+	.page_size = (_page_size),						    \
+	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE | (_mmap_flags),   \
 }
 
-FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0);
-FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, MAP_HUGETLB | MAP_HUGE_2MB);
-FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUGE_1GB);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0, 0);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, SZ_2M, MAP_HUGETLB | MAP_HUGE_2MB);
+FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, SZ_1G, MAP_HUGETLB | MAP_HUGE_1GB);
 
 #undef FIXTURE_VARIANT_ADD_IOMMU_MODE
 
 FIXTURE_SETUP(vfio_dma_mapping_perf_test)
 {
 	self->iommu = iommu_init(variant->iommu_mode);
-	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -58,11 +136,16 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
 
 TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 {
-	const u64 size = SZ_1G;
+	const u64 page_size = variant->page_size ?: getpagesize();
+	const u64 size = test_params.size;
 	const int flags = variant->mmap_flags;
 	struct dma_region region;
 
-	ksft_print_msg("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
+	if (!IS_ALIGNED(size, page_size))
+		SKIP(return, "Size 0x%llx is not aligned to page size 0x%llx",
+		     (unsigned long long)size, (unsigned long long)page_size);
+
+	ksft_print_msg("mmap size = %s\n", test_params.size_str);
 
 	TIME("mmap",
 	     region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0));
@@ -90,30 +173,32 @@ FIXTURE(vfio_dma_mapping_perf_memfd_test) {
 };
 
 FIXTURE_VARIANT(vfio_dma_mapping_perf_memfd_test) {
+	u64 page_size;
 	int mmap_flags;
 	int memfd_flags;
 };
 
-#define FIXTURE_VARIANT_ADD_MEMFD_MODE(_name, _mmap_flags, _memfd_flags)      \
-FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, iommufd ## _ ## _name) {\
-	.mmap_flags = MAP_SHARED | MAP_POPULATE | (_mmap_flags),	      \
-	.memfd_flags = (_memfd_flags),					      \
+#define FIXTURE_VARIANT_ADD_MEMFD_MODE(_name, _page_size, _mmap_flags, _memfd_flags) \
+FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, iommufd ## _ ## _name) {	     \
+	.page_size = (_page_size),						     \
+	.mmap_flags = MAP_SHARED | MAP_POPULATE | (_mmap_flags),		     \
+	.memfd_flags = (_memfd_flags),						     \
 }
 
-FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd, 0, 0);
-FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_2mb,
-				    MAP_HUGETLB | MAP_HUGE_2MB,
-				    MFD_HUGETLB | MFD_HUGE_2MB);
-FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
-				    MAP_HUGETLB | MAP_HUGE_1GB,
-				    MFD_HUGETLB | MFD_HUGE_1GB);
+FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd, 0, 0, 0);
+FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_2mb, SZ_2M,
+			       MAP_HUGETLB | MAP_HUGE_2MB,
+			       MFD_HUGETLB | MFD_HUGE_2MB);
+FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb, SZ_1G,
+			       MAP_HUGETLB | MAP_HUGE_1GB,
+			       MFD_HUGETLB | MFD_HUGE_1GB);
 
 #undef FIXTURE_VARIANT_ADD_MEMFD_MODE
 
 FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
 {
 	self->iommu = iommu_init(MODE_IOMMUFD);
-	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -154,12 +239,17 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
 
 TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 {
-	const u64 size = SZ_1G;
+	const u64 page_size = variant->page_size ?: getpagesize();
+	const u64 size = test_params.size;
 	const int mmap_flags = variant->mmap_flags;
 	struct dma_region region;
 	int fd;
 
-	ksft_print_msg("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
+	if (!IS_ALIGNED(size, page_size))
+		SKIP(return, "Size 0x%llx is not aligned to page size 0x%llx",
+		     (unsigned long long)size, (unsigned long long)page_size);
+
+	ksft_print_msg("mmap size = %s\n", test_params.size_str);
 
 	region.vaddr = setup_memfd(&fd, size, mmap_flags, variant->memfd_flags);
 
@@ -184,6 +274,6 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 
 int main(int argc, char *argv[])
 {
-	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-	return test_harness_run(argc, argv);
+	test_params.device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run_opts(argc, argv, &opts);
 }
-- 
2.56.0.611.g1030f0b940-goog


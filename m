Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8A48033B
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862706; cv=none; b=Vj9kydv+X09kkXOVDU/8/cGEWZFzkGSW6svF5cM32XV60AAZG3C9bRJ62QUS8NzjXP+owBapj3I7ueF7JlKYbGLE5mKCIOAw5CtXfIT7inoHDg+mm1GhyUwIC75r85N2HjS+8EWvnD2drLiVdtu8kRxhj+hKXYohSny9/juxrd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862706; c=relaxed/simple;
	bh=xm3Jw1O7zAG64vyCjIzTczanJb913K0Znam/0iHb8oI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHogfO4kM/rGcPqgJaFEiP9fmsMM4Ak4UfC5PZY9/f6EA4DOPFd3qaJfowq5PSGOxi11/sbMK0phgApj+kzOpgV5h8ZhqAUc4rh2nT1ZJ5nyMxoe5+9ZedIc9kDvRiCzuVOCOn0JoWRLpWVM7DvNgVjUrXTiUQ1mx5Q2OZb2kOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QEyZcDhr; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QEyZcDhr"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso6544611a12.0
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862681; x=1786467481; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5K1AW3rhXuwzs89Vl73/ltc//3fOIBVVnSEj7kPLJM=;
        b=QEyZcDhrCQ+wkhXe//dDLvB64GiTse+Hnn2R2G3z+9YcCjR0izbrPdUs5yZgjLo9jl
         ++OSNx+vHjX9mJALDpdHzEWSEp8EhdDcqnzva/I8RQMK5Rlk6XXiTSBZVXOSvjDnIRZP
         shzSdQTvOQ2uo+2RBeOqgJo02rP1q8jfIj8JH1FQe/kM5fZIOp7RgusFIQsqMIqzlY+1
         Jk9DIVq5/xhZpFq9FagWhQbZSrMNkrqYFVfQIeSlqYOdRghgc0/3k+7GT2i5X3DuJACJ
         /JI1qcJ7X5R7CsVqiLG+7pEemtNGql814pChj/F+kzpamDF/HUFTTCj+jxqiXqo1z+kL
         fIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862681; x=1786467481;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5K1AW3rhXuwzs89Vl73/ltc//3fOIBVVnSEj7kPLJM=;
        b=SXYQlIfBRGkUHIbbo7j1j6k1/9UG77ocZO5heO9aP7xm+Hkr+yWATMW25UvixGjYmJ
         syQGAdPsFepWQ95V2zzZRfsYmtEuV3amMfAc+/B2dMaXGKo/J4/c+mjHyF7zKYMyNLcw
         mG/l7f6PDM6JYfk23m1eR2fRziGk8p5aUUqq4AhvITj+9vjiG+1hrBmA+ZnHPYBENcME
         dKAr17B5QVr06N5o1P1NrUkreXz46tjPCBINqCkrMMrVgo146//DcRMPaXL5jEzX1qHH
         XVLFyXC1CL7yMtHdrgkAk/Mq02fyg4tATXcjsopG8/QW/d6OzMOiInlb3ibNkqm2syZ+
         vhWw==
X-Gm-Message-State: AOJu0YxJL3yQb/lFOkfa93xgfvZKIcSnTHnL3TdCQ61D9/OBjLdwLiar
	di+wkaA20j9RnVkgmPv5xxQIenhdvf79iMv615wS++mlKTTyQm/w8vmQS3RnqtpySuQemeJgOFN
	CP1/A07YlOos2XwUhpJIKJA3TsqURcX/jLGj+eqr6s4hcUGbN2VzwGg5GfX5Ccv0/YOTmwwSP4D
	zPG5J5AX6uccsIVFMgvP5PDSK5QA/qi1f1zzoZ7KDWJvE8yzROxwWCXw==
X-Received: from dybfe36.prod.google.com ([2002:a05:7300:bfa4:b0:314:7abc:268])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:b97:b0:3bf:b8d8:8296 with SMTP id adf61e73a8af0-3cb85ea6f84mr290247637.26.1785862680822;
 Tue, 04 Aug 2026 09:58:00 -0700 (PDT)
Date: Tue,  4 Aug 2026 16:57:48 +0000
In-Reply-To: <20260804165748.1060476-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804165748.1060476-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260804165748.1060476-5-aaronlewis@google.com>
Subject: [PATCH v2 4/4] vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow the user to specify a DMA region size via the command line for
vfio_dma_mapping_perf_test.

Because the selftest harness also parses command-line parameters, sharing
them directly is problematic. Adding options directly to the test could
create conflicts with harness-defined options. Even without conflicts, the
harness would need to be updated to recognize test-specific options to avoid
failing on unknown parameters.

Resolve this by isolating the two sets of parameters. The standard command-line
options are consumed by the test itself. To pass options through to the test
harness, introduce a new '-a' option.

For example, both the test size and the test harness options can be set
like this:

./vfio_dma_mapping_perf_test -b 16G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"

This invocation configures a 16G DMA region and restricts execution to the
specified test variant, which is useful when debugging DMA mapping latency
issues for a specific IOMMU type.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 .../vfio/vfio_dma_mapping_perf_test.c         | 159 ++++++++++++++++--
 1 file changed, 149 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
index 5ef85deba4ee..af2273a0c6f5 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -4,6 +4,7 @@
 #include <sys/mman.h>
 #include <time.h>
 #include <unistd.h>
+#include <wordexp.h>
 
 #include <linux/iommufd.h>
 #include <linux/limits.h>
@@ -17,7 +18,12 @@
 
 #include "kselftest_harness.h"
 
-static const char *device_bdf;
+static struct {
+	u64 size;
+	const char *device_bdf;
+} test_params = {
+	.size = SZ_1G,
+};
 
 FIXTURE(vfio_dma_mapping_perf_test) {
 	struct iommu *iommu;
@@ -45,7 +51,7 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUG
 FIXTURE_SETUP(vfio_dma_mapping_perf_test)
 {
 	self->iommu = iommu_init(variant->iommu_mode);
-	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -58,7 +64,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
 
 TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 {
-	const u64 size = SZ_1G;
+	const u64 size = test_params.size;
 	const int flags = variant->mmap_flags;
 	struct dma_region region;
 
@@ -115,7 +121,7 @@ FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
 FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
 {
 	self->iommu = iommu_init(variant->iommu_mode);
-	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -159,17 +165,17 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
 
 TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 {
-	const u64 size = SZ_1G;
-	const int flags = variant->mmap_flags;
+	const u64 size = test_params.size;
+	const int mmap_flags = variant->mmap_flags;
 	struct dma_region region;
 	int fd;
 
 	printf("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
 
-	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
+	region.vaddr = setup_memfd(&fd, size, mmap_flags, variant->memfd_flags);
 
 	/* Skip the test if there aren't enough HugeTLB pages available. */
-	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
+	if (mmap_flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
 		SKIP(return, "setup_memfd() failed: %s (%d)\n", strerror(errno), errno);
 	else
 		ASSERT_NE(region.vaddr, MAP_FAILED);
@@ -185,8 +191,141 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 	teardown_memfd(fd, size, region.vaddr);
 }
 
+/*
+ * Parses "[0-9]+[kmgt]?".
+ */
+u64 parse_size(const char *size)
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
+static void help(char *name)
+{
+	puts("");
+	printf("usage: %s [-h] [-b bytes] [-a \"test harness args\"]\n", name);
+	puts("");
+	printf(" -h: Display this help message.\n"
+	       " -b: Specify the size of the DMA region to be mapped\n"
+	       "     and unmapped. e.g. 16M or 8G, (default: 1G)\n"
+	       " -a: Args that are forwarded to the test harness,\n"
+	       "     e.g. -a \"-t dma_map_unmap_from_file\"\n");
+}
+
+struct harness_args {
+	int argc;
+	char **argv;
+	wordexp_t exp;
+};
+
+static void populate_harness_args(struct harness_args *args, const char *argv_0,
+				  const char *cmdlne)
+{
+	int flags = WRDE_NOCMD;
+
+	if (!args->argv) {
+		/*
+		 * Initialize the argument list with the program name (argv[0]).
+		 * WRDE_NOCMD disables command substitution for safety.
+		 */
+		if (wordexp(argv_0, &args->exp, flags) != 0)
+			VFIO_FAIL("Failed to evaluate test harness argv_0 args!");
+	}
+
+	flags |= WRDE_APPEND;
+
+	/*
+	 * Use wordexp() to reliably parse the user-supplied command line string
+	 * into individual arguments, respecting shell quoting and escaping rules.
+	 * WRDE_APPEND merges these new arguments with the earlier argv[0].
+	 */
+	if (wordexp(cmdlne, &args->exp, flags) != 0)
+		VFIO_FAIL("Failed to evaluate test harness cmdlne args!");
+
+	args->argc = args->exp.we_wordc;
+	args->argv = args->exp.we_wordv;
+}
+
+static void setup_test(struct harness_args *args, int *argc, char *argv[])
+{
+	char *h_argv[] = { argv[0], "-h" };
+	int opt;
+
+	test_params.device_bdf = vfio_selftests_get_bdf(argc, argv);
+
+	while ((opt = getopt(*argc, argv, "a:b:h")) != -1) {
+		switch (opt) {
+		case 'a':
+			populate_harness_args(args, argv[0], optarg);
+			break;
+		case 'b':
+			test_params.size = parse_size(optarg);
+			break;
+		case 'h':
+		default:
+			help(argv[0]);
+			exit(test_harness_run(2, h_argv));
+		}
+	}
+
+	// Reset getopt() state to allow the test harness to use it.
+	optind = 1;
+}
+
+static void teardown_test(struct harness_args *args)
+{
+	if (args->argv) {
+		args->argc = 0;
+		args->argv = NULL;
+		wordfree(&args->exp);
+	}
+}
+
 int main(int argc, char *argv[])
 {
-	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-	return test_harness_run(argc, argv);
+	char *default_hargs[] = { argv[0], NULL };
+	struct harness_args args = {};
+	int r;
+
+	setup_test(&args, &argc, argv);
+
+	r = test_harness_run(args.argc ?: 1, args.argv ?: default_hargs);
+
+	teardown_test(&args);
+
+	return r;
 }
-- 
2.55.0.654.g21b8a5bc05-goog


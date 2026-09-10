Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CD3384CEC
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 15:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054426; cv=none; b=QzVP56OCpZ7ryocJK+IZZ3oKDA6gNGNnOcsF/838IdsK3RHZDGjHM9gqn3iUld6ZTXxJ6LwoTyU4XAJr2/aHzRxVYN11DHX1ibLw1PVOZhYfg8lncF6NwWi1NOxXWHvTIAgX9c11YK5O447YPHv3XvIbesOCOcZmfXGMbQfLoJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054426; c=relaxed/simple;
	bh=UwF2xNcZhdxxMOxGycH429agCSaiAYOzckmk7+qDGoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Em7vNF9u/3NX3+cYHbVnJ1HFCoV70VOlpuf9KR5Q1TjexS+C2u5TQ/hkpWdO5ODJ1uOSQDsX1IHR0+LOcImCthp2XNn5rpyaJH6qtiTtnZcXgZqcwm0fGrTpL/rxv/W65GzQNi1FuXNOKuYmyS9EM8odhHXkCZftNop3Y79UlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JlsCweiS; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JlsCweiS"
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-6bd74449818so4410453eaf.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789054423; x=1789659223; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guwfH8XHEgFoVKF1M7RK5maqC930ngsghW5TOkBHfLI=;
        b=JlsCweiSxtZUPLcNFsUF8ufdR+qDhYxldq2uf/KdWtJWfWWvagCiuZIfgw3CsFzhbO
         DWPhVIKfLWx/FLxSMIcmbLFWcLo5Gh0vEA9QOf/zwapfoIpUX/pXHkqI3SlMGYdcxK3h
         IM9QXbMWLcXUcU34sQno31xZpk7UUMco09bZ3fX615nC1rxGV3D5HpnsWDCYzMI/Lv9w
         mnOxsQDuEFCtDpKCH++TqbqB3Qu6LVa/va8CmlWxRdIaA48bcnU9eer6mVGToYuu+b3U
         4+LosRCAIBlO5deOsUq23gXF359CNrX6HSgy5lTKX1+MnDWesrQ1KQKSPOfq2x+hrxpN
         2/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789054423; x=1789659223;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guwfH8XHEgFoVKF1M7RK5maqC930ngsghW5TOkBHfLI=;
        b=qK1ZBtcVh2BZjuufwM9B2eD6I48PTGfDkiJsAltA3gaJYZksvDzWrPMoGTDE9HWWXP
         npJd0XzgrLEZQPP3E4ZzSi9QYroCXMvhf2+DIUJzLY2fAR/vP1s2rRlzU9kCFxiC3OgN
         a022+54zbYfYedqsiWgKkK0/3CgNxUIFNVgQ0Rzr7QxqijhlYIPXDJsceML0po+4vDQ1
         vcehZJ6oMyBva62m+RfpCyK18u5lzmxqgJjJ7588mIfYX5Vv91kVzu06V22gscb7NUG6
         pmRT7IW9gNWP7GkMC0YwavpLlF2h55YXCDIse9Fd+icG9bkCABJcdudXwVLFuX3E22I7
         5s+Q==
X-Gm-Message-State: AFuF++lAAMIuQkrYywO/i5bD5hDs6BrR6+vzvoPnQ6eVqTjS9s5+4qRR
	88odLmMUUmA06G2dIN5KoJrRM2C5VaZ11t3hZgi7omeU+LlgCg8xdNDBokT8wOxUkcKvw9NwTLa
	X+Wkh978Be7rY0R1q3mxcx1u+HXA5/luDbBWjye0RzV1zcV7F86tbbCF9Aws9SMnh6ZYstP417A
	07OFAzPzNpaVzcSrm6LBTU5nydVPhsb7z/++F7VfynWxPYDBxFLLB2yw==
X-Received: from dlbem11.prod.google.com ([2002:a05:7022:100b:b0:141:4595:b9d3])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:16a4:b0:6b7:83c5:fde2 with SMTP id 006d021491bc7-6b783c602ddmr23115905eaf.35.1789054422813;
 Thu, 10 Sep 2026 08:33:42 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:33:26 +0000
In-Reply-To: <20260910153326.3085937-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910153326.3085937-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260910153326.3085937-5-aaronlewis@google.com>
Subject: [PATCH v3 4/4] vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow the user to specify a DMA region size via the command line for
vfio_dma_mapping_perf_test.

Because the selftest harness parses command-line parameters, adding
custom options directly to individual tests requires the test harness
to recognize them.

Add support to kselftest_harness.h for custom command-line options via
struct test_harness_cli_opts and test_harness_run_opts(). Then use this
interface in vfio_dma_mapping_perf_test to introduce a new '-b' option to
specify the DMA region size.

For example, both the test size and test harness options can now be
passed together naturally:

  ./vfio_dma_mapping_perf_test -b 16G -v vfio_type1_iommu_memfd_hugetlb_1gb

Assert if the custom options string is problematic (e.g. conflicting with
built-in options or exceeding the buffer limit). This should only happen
when developing a test, and asserting makes the issue immediately obvious
to the developer.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 tools/testing/selftests/kselftest_harness.h   | 86 ++++++++++++++++---
 .../vfio/vfio_dma_mapping_perf_test.c         | 86 +++++++++++++++++--
 2 files changed, 151 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 29a19bc87084..5065eb7144bc 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -54,6 +54,7 @@
 #define _GNU_SOURCE
 #endif
 #include <asm/types.h>
+#include <assert.h>
 #include <ctype.h>
 #include <errno.h>
 #include <linux/unistd.h>
@@ -76,6 +77,18 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 		memset(s, c, n);
 }
 
+/**
+ * struct test_harness_cli_opts - Custom command-line options for test harness
+ * @optstring: getopt option string; must not conflict with harness options.
+ * @handler: Callback to handle custom options; returns KSFT_PASS or KSFT_FAIL.
+ * @help: Optional callback to print custom option help text.
+ */
+struct test_harness_cli_opts {
+	const char *optstring;
+	int (*handler)(int opt, char *optarg);
+	void (*help)(void);
+};
+
 #define KSELFTEST_PRIO_TEST    20000
 #define KSELFTEST_PRIO_XFAIL   20001
 
@@ -1097,11 +1110,36 @@ static void test_harness_list_tests(void)
 	}
 }
 
-static int test_harness_argv_check(int argc, char **argv)
+#define OPTSTRING_LEN 128
+
+static void optstring_append_custom(char *optstring, size_t size,
+				    const struct test_harness_cli_opts *opts)
 {
+	const char *c;
+
+	if (!opts || !opts->optstring)
+		return;
+
+	assert(strlen(optstring) + strlen(opts->optstring) < size);
+
+	for (c = opts->optstring; *c; c++) {
+		if (isalnum(*c))
+			assert(!strchr(optstring, *c));
+	}
+
+	strncat(optstring, opts->optstring, size - strlen(optstring) - 1);
+}
+
+static int test_harness_argv_check(int argc, char **argv,
+				   const struct test_harness_cli_opts *opts)
+{
+	char optstring[OPTSTRING_LEN] = "dhlF:f:V:v:t:T:r:";
 	int opt;
 
-	while ((opt = getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) != -1) {
+	optstring_append_custom(optstring, sizeof(optstring), opts);
+
+	optind = 1;
+	while ((opt = getopt(argc, argv, optstring)) != -1) {
 		switch (opt) {
 		case 'f':
 		case 'F':
@@ -1118,7 +1156,6 @@ static int test_harness_argv_check(int argc, char **argv)
 			ksft_debug_enabled = true;
 			break;
 		case 'h':
-		default:
 			fprintf(stderr,
 				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name]\n"
 				"\t-h       print help\n"
@@ -1139,7 +1176,14 @@ static int test_harness_argv_check(int argc, char **argv)
 				"include all tests from variant 'bla'\n"
 				"but not test 'foo' specify '-T foo -v bla'.\n"
 				"", argv[0]);
-			return opt == 'h' ? KSFT_SKIP : KSFT_FAIL;
+			if (opts && opts->help)
+				opts->help();
+			return KSFT_SKIP;
+		default:
+			if (opts && opts->handler &&
+			    opts->handler(opt, optarg) == KSFT_PASS)
+				break;
+			return KSFT_FAIL;
 		}
 	}
 
@@ -1149,31 +1193,39 @@ static int test_harness_argv_check(int argc, char **argv)
 static bool test_enabled(int argc, char **argv,
 			 struct __fixture_metadata *f,
 			 struct __fixture_variant_metadata *v,
-			 struct __test_metadata *t)
+			 struct __test_metadata *t,
+			 const struct test_harness_cli_opts *opts)
 {
 	unsigned int flen = 0, vlen = 0, tlen = 0;
+	char optstring[OPTSTRING_LEN] = "dF:f:V:v:t:T:r:";
 	bool has_positive = false;
 	int opt;
 
-	optind = 1;
-	while ((opt = getopt(argc, argv, "dF:f:V:v:t:T:r:")) != -1) {
-		if (opt != 'd')
-			has_positive |= islower(opt);
+	optstring_append_custom(optstring, sizeof(optstring), opts);
 
-		switch (tolower(opt)) {
+	optind = 1;
+	while ((opt = getopt(argc, argv, optstring)) != -1) {
+		switch (opt) {
 		case 't':
+		case 'T':
+			has_positive |= islower(opt);
 			if (!strcmp(t->name, optarg))
 				return islower(opt);
 			break;
 		case 'f':
+		case 'F':
+			has_positive |= islower(opt);
 			if (!strcmp(f->name, optarg))
 				return islower(opt);
 			break;
 		case 'v':
+		case 'V':
+			has_positive |= islower(opt);
 			if (!strcmp(v->name, optarg))
 				return islower(opt);
 			break;
 		case 'r':
+			has_positive = true;
 			if (!tlen) {
 				flen = strlen(f->name);
 				vlen = strlen(v->name);
@@ -1262,7 +1314,8 @@ static void __run_test(struct __fixture_metadata *f,
 			      diagnostic ? "%s" : NULL, diagnostic);
 }
 
-static int test_harness_run(int argc, char **argv)
+static int test_harness_run_opts(int argc, char **argv,
+				 const struct test_harness_cli_opts *opts)
 {
 	struct __fixture_variant_metadata no_variant = { .name = "", };
 	struct __fixture_variant_metadata *v;
@@ -1274,7 +1327,7 @@ static int test_harness_run(int argc, char **argv)
 	unsigned int count = 0;
 	unsigned int pass_count = 0;
 
-	ret = test_harness_argv_check(argc, argv);
+	ret = test_harness_argv_check(argc, argv, opts);
 	if (ret != KSFT_PASS)
 		return ret;
 
@@ -1283,7 +1336,7 @@ static int test_harness_run(int argc, char **argv)
 			unsigned int old_tests = test_count;
 
 			for (t = f->tests; t; t = t->next)
-				if (test_enabled(argc, argv, f, v, t))
+				if (test_enabled(argc, argv, f, v, t, opts))
 					test_count++;
 
 			if (old_tests != test_count)
@@ -1301,7 +1354,7 @@ static int test_harness_run(int argc, char **argv)
 	for (f = __fixture_list; f; f = f->next) {
 		for (v = f->variant ?: &no_variant; v; v = v->next) {
 			for (t = f->tests; t; t = t->next) {
-				if (!test_enabled(argc, argv, f, v, t))
+				if (!test_enabled(argc, argv, f, v, t, opts))
 					continue;
 				count++;
 				t->results = results;
@@ -1324,6 +1377,11 @@ static int test_harness_run(int argc, char **argv)
 	return KSFT_FAIL;
 }
 
+static inline int test_harness_run(int argc, char **argv)
+{
+	return test_harness_run_opts(argc, argv, NULL);
+}
+
 static void __attribute__((constructor(KSELFTEST_PRIO_TEST))) __constructor_order_first(void)
 {
 	__constructor_order_forward = true;
diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
index 4113a20127de..84a973a53b8c 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <ctype.h>
 #include <limits.h>
 #include <stdio.h>
 #include <sys/mman.h>
@@ -17,7 +18,78 @@
 
 #include "kselftest_harness.h"
 
-static const char *device_bdf;
+static struct {
+	u64 size;
+	const char *device_bdf;
+} test_params = {
+	.size = SZ_1G,
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
+static void opt_custom_help(void)
+{
+	fprintf(stderr,
+		"\nCustom options:\n"
+		"\t-b bytes Specify the size of the DMA region to be mapped\n"
+		"\t         and unmapped. e.g. 16M or 8G, (default: 1G)\n");
+}
+
+static int opt_custom_handler(int opt, char *optarg)
+{
+	if (opt == 'b') {
+		test_params.size = parse_size(optarg);
+		return KSFT_PASS;
+	}
+	return KSFT_FAIL;
+}
+
+static const struct test_harness_cli_opts opts = {
+	.optstring = "b:",
+	.handler = opt_custom_handler,
+	.help = opt_custom_help,
+};
 
 FIXTURE(vfio_dma_mapping_perf_test) {
 	struct iommu *iommu;
@@ -45,7 +117,7 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUG
 FIXTURE_SETUP(vfio_dma_mapping_perf_test)
 {
 	self->iommu = iommu_init(variant->iommu_mode);
-	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -58,7 +130,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
 
 TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 {
-	const u64 size = SZ_1G;
+	const u64 size = test_params.size;
 	const int flags = variant->mmap_flags;
 	struct dma_region region;
 
@@ -115,7 +187,7 @@ FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
 FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
 {
 	self->iommu = iommu_init(variant->iommu_mode);
-	self->device = vfio_pci_device_init(device_bdf, self->iommu);
+	self->device = vfio_pci_device_init(test_params.device_bdf, self->iommu);
 	self->iova_allocator = iova_allocator_init(self->iommu);
 }
 
@@ -156,7 +228,7 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
 
 TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 {
-	const u64 size = SZ_1G;
+	const u64 size = test_params.size;
 	const int mmap_flags = variant->mmap_flags;
 	struct dma_region region;
 	int fd;
@@ -186,6 +258,6 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 
 int main(int argc, char *argv[])
 {
-	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-	return test_harness_run(argc, argv);
+	test_params.device_bdf = vfio_selftests_get_bdf(&argc, argv);
+	return test_harness_run_opts(argc, argv, &opts);
 }
-- 
2.55.0.1003.g10538fe699-goog


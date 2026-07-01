Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BE431E79
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938012; cv=none; b=qOxIq3nP4T00fxPq91GOcGCn8TY26MKut6LXGaWYRP7HpHYdpTxBDwLxR/EF/qYFNSsVku5ZHNp+go19usFZV/QNdoz/5+hcw75B47lRgKq43fKSIRUt63jC010iCdNhyEmMtYKKF8x9z1OdTiXi+dLqr+8GxYS8w1Rf6Yl0a8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938012; c=relaxed/simple;
	bh=awBOo4nTYXpKS1+w5skam6omYXt4A2jbnL/6xzaEsYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cs4HzgffS5X5O5B8lGo5RAfJ9TOlhy57lpq87vb8TkmSWLMJ/BjaNhkutzA+BWFUlfThXO5BKPFc5i+hWtRKQYTGmp7PDOZsHvOEGNDEl+JG1aRc6N4o6MZl1MXAQudpKW512dwEf/VtK5lohefABsE7QkD0ITyHaoUwVnAbWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SRNKY9jo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SRNKY9jo"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8895156101so937482a12.1
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938010; x=1783542810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2y6QahbiYEeFWW4jLSow2z11zFEVCFP/ftrpD9J9AgE=;
        b=SRNKY9jo/ORVq8ZJ/0WHl1exzcC7RZub5Mm6B2Al5lcnBpibHJets3nO5UrPxbAPjp
         hMYgGTRgsDNS4JwANysIqV97dD8o3ildPuGb3uen1fcxx0IwdbcR7r//kLT4nbIvu9C5
         khSL4v0C8iCUAciaQNqT7scariFKXsPBBg9G4EV2Lz/cdhgFKFLCQyEJ5pVBbZ0WiWQu
         FKyyDsZbpQ4spQYFe5FaY3hcpiqu0k/JOnhCFTloWvvAHOhZqg++uluEXkW9Ndhr3hhq
         Rv2qCh/kmsF4inMS396HdK2pMoyyq+AHvU9vM+XeQ898MnAmD1KtwSt7O7USj8/1mVcP
         MjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938010; x=1783542810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2y6QahbiYEeFWW4jLSow2z11zFEVCFP/ftrpD9J9AgE=;
        b=L7+QYO/A0FrL2RGhCrq3NAfy9zAz8X7zaOUtSdcuYgQImej+/yVL7PyBBriUC8yXSu
         IAS5AlRmu5PUlVE2++KTxP+GdvbnnXV+qbGI8YPM4dmTyoUehDERKm/hiuMRW5J8Igep
         HjfGP3zvlWcAEtXoI5W/LOE9UwOmUCe0CBtmQZ2mRwyqJaCZROcPUlXOyRJenayybI6w
         6gunpi0KzFWC+99QkjXcRDYazt48K/Vg1XuyvQeT9F3iNZxAu8DFm7QM5NH4zAYPyCxy
         PGW1pSO+OE0FslnOYcBeLozF0EUZ00547qSz8Aq67qrP8XwDECp5kdd9BIuumtUahlII
         LfHg==
X-Gm-Message-State: AOJu0YyY8nkXYrpUMVjcN+9ruRyKE0lCUMrReDdNBQGk/wszAvFLRbYi
	SURPHbNT0+cwxrh97wWrG2WGe43Nrehz9JhQHxpnfbUCeHqcMRFMUe28fC+YBIc53RVHbhaNTfl
	BqmR+dDwr1PW0UwFVM0eq5CIc8xvkkWIcW9HonJUnj+zq5a7yI8fQhwVTysNE02fA4oYLYQgQcJ
	uvz5N8jF/D3C6dzNDOrR/MsxtycGJloKX9Poav8XIyFmk5iCbIy/iM+Q==
X-Received: from dlbpv9.prod.google.com ([2002:a05:7023:909:b0:139:db57:c30b])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:6715:b0:3bf:a0e5:999a with SMTP id adf61e73a8af0-3bfed41d909mr3477352637.48.1782938009973;
 Wed, 01 Jul 2026 13:33:29 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:33:10 +0000
In-Reply-To: <20260701203311.326798-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701203311.326798-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701203311.326798-4-aaronlewis@google.com>
Subject: [PATCH 3/4] vfio: selftests: Allow a size for vfio_dma_mapping_perf_test
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
 .../vfio/vfio_dma_mapping_perf_test.c         | 132 +++++++++++++++++-
 1 file changed, 129 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
index 4639bda7ebaa..6c025e9c4420 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -4,6 +4,7 @@
 #include <sys/mman.h>
 #include <time.h>
 #include <unistd.h>
+#include <wordexp.h>
 
 #include <linux/iommufd.h>
 #include <linux/limits.h>
@@ -19,6 +20,12 @@
 
 static const char *device_bdf;
 
+struct test_params {
+	u64 size;
+};
+
+struct test_params test_params;
+
 struct iommu_mapping {
 	u64 pgd;
 	u64 p4d;
@@ -80,7 +87,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
 
 TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 {
-	const u64 size = SZ_1G;
+	const u64 size = test_params.size;
 	const int flags = variant->mmap_flags;
 	struct dma_region region;
 	struct timespec start;
@@ -204,7 +211,7 @@ static void teardown_memfd(int fd, u64 size, void *vaddr)
 
 TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 {
-	const u64 size = SZ_1G;
+	const u64 size = test_params.size;
 	struct dma_region region;
 	struct timespec start;
 	u64 unmapped;
@@ -235,8 +242,127 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 	teardown_memfd(fd, size, region.vaddr);
 }
 
+/*
+ * Parses "[0-9]+[kmgt]?".
+ */
+size_t parse_size(const char *size)
+{
+	size_t base;
+	char *scale;
+	int shift = 0;
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
+struct harness_args
+{
+	int argc;
+	char **argv;
+	wordexp_t exp;
+};
+
+static void populate_harness_args(struct harness_args *args, const char *argv_0,
+				  const char *cmdlne)
+{
+	if (wordexp(argv_0, &args->exp, WRDE_NOCMD) == 0 &&
+	    wordexp(cmdlne, &args->exp, WRDE_APPEND | WRDE_NOCMD) == 0) {
+		args->argc = args->exp.we_wordc;
+		args->argv = args->exp.we_wordv;
+	}
+}
+
+static void setup_test(struct harness_args *args, int argc, char *argv[])
+{
+	int opt;
+
+	test_params = (struct test_params) {
+		.size = SZ_1G,
+	};
+
+	while ((opt = getopt(argc, argv, "a:b:h")) != -1) {
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
+			goto out;
+		}
+	}
+
+out:
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
+	struct harness_args args = (struct harness_args) {
+		.argc = 0,
+		.argv = NULL,
+	};
+	int r;
+
+	setup_test(&args, argc, argv);
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
-	return test_harness_run(argc, argv);
+	r = test_harness_run(args.argc, args.argv);
+	teardown_test(&args);
+
+	return r;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


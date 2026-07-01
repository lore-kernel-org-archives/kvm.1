Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58E739A7FD
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 20:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938014; cv=none; b=C6tswf1bznwegJa+KVmc/1XAgg6PnPr3XsKXcwhLZXWZ/dcGlZ3AQajSVPEb9ZVrr331fmvwcXtHTH683O5qpv7CJXo+sf0Udh+JaUmfAow1K6fuTyb1vfAd7cjmjbcJYO0tDl/kr4vIzmkW67FM1HPPDG47xGXVmlpztZtW0DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938014; c=relaxed/simple;
	bh=ZawwhdxIywgO/9ECYKUMwpymOQ1YpDFfdOfU92GhLlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U26tcmdGCeeFf1JsH4gI0nac27EZ9njjaJKDfZlMT9gfnPocdAEV5bXtnTlDtA8cLprBtOjSmhcBT0949LXTPTpTGKee3njRQfdPIfQXxv/LuA765H58RblwvsQwe1goZCS2xb69/yEXfQe25UltJ9IRu7jTpxmXzhzl6ZzdDsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QKoDDyzc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aaronlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QKoDDyzc"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9c26587e67so938480a12.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 13:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938012; x=1783542812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2PA6Ga9DsEjOFAGVfXcfvRvkGuXPbbRqNCm/bUuUUIw=;
        b=QKoDDyzc1OZZUoacVtNlbpMAMlsV/PzpCV8uqyIzq4xCMBGfB8M+mOr/12KkkP1WQG
         CLf0S+jpou/1eJ+ao36QdDfPVPX1Mbw2+Nsa9natcG4IIsHQHHbBHFB3Tngxc2cWZyaP
         QummFXRG0ssr5G7mxXHZbwB54FWfpkw2IT1lqmfuv13tTxv0BtrWULWcBgVrrVoRAnkO
         d8bJYaYfPQBUad5SOKKToPYNjQTmpez7ScYEAR1Fk+BhkGlR3gy8PvpprGuC3K1Y6nrC
         fTsYHTYJ0XkFDcpwZRCWSGBFDkxdhMlAJSdKmcRMsxYBc2k2BaSAsz9amMDQtY+NFxNM
         1lrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938012; x=1783542812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PA6Ga9DsEjOFAGVfXcfvRvkGuXPbbRqNCm/bUuUUIw=;
        b=HVH/IKZIMDNdrKSoVbxe7AlCFfEY+eSLD97Z1fpCKI9RkvT/nTPG+IadcO1VtucHTH
         ePQR+xsLtkj6NTtFWzMkpQcnbjjo8RZeCze1UK35GS76a+TztnS6+Lhw8UAmp4Ab49no
         iZVQTDxPElFiYfXBjHWce2Nt5yrAyTzIebFCD3ZzQtrcoMlPYwkh7WU6YcgvOC6vKpuU
         aS1ecaAEnO5WY/njkPBOsaex7l+s7L3RxiNYpoQNmMEx+3JbHov+xApib36UALzcEWjn
         yjLpJoqXu0uDy2/czK1lPMwZWVEZziA6+f+EQNZ682Phiipik48yNkS5rrlVoAMfp+7o
         RVGw==
X-Gm-Message-State: AOJu0YxUC6ffNnxIDrxGeoQuA8HId9n5JLApRs3SiXoW+Xlsn0vba3aI
	MO+iy8ABsarxW0xfBRnf3QY1GlLiZJO0S300i1iDaaLrjf0IQk2OW+wTSPkq7vPfhJsl/Yz6+8Y
	jkDiCwVad2FZsYapPFXS93LTPbi7KaBp1xIxfc3pY1+Jyamm7NSh/sRb4MkbchLrq22+SWVkIJa
	/FwFrU12Byy1GSsbz1fsjdFP5rAl3EcXeoJz3n28O+cJBmxABjEequrA==
X-Received: from dyckg24.prod.google.com ([2002:a05:7301:d198:b0:30c:b614:bad5])
 (user=aaronlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:690:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3bfd26acbacmr6991059637.17.1782938011846;
 Wed, 01 Jul 2026 13:33:31 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:33:11 +0000
In-Reply-To: <20260701203311.326798-1-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701203311.326798-1-aaronlewis@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701203311.326798-5-aaronlewis@google.com>
Subject: [PATCH 4/4] vfio: selftests: Allow the flag MAP_POPULATE to be set on
 the cmdline
From: Aaron Lewis <aaronlewis@google.com>
To: kvm@vger.kernel.org
Cc: alex@shazbot.org, dmatlack@google.com, jgg@nvidia.com, 
	Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a command-line option to vfio_dma_mapping_perf_test to set the
MAP_POPULATE flag during mmap(). This ensures consistent and accurate DMA
mapping latency measurements by forcing page prefaulting to occur during
the mmap() phase, rather than during the DMA mapping ioctl.

For example, mapping a 32G region without the -p (MAP_POPULATE) flag
results in:

  $ ./vfio_dma_mapping_perf_test -b 32G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"
  Completed mmap() for memfd in 0.00ms
  Mapped HVA 0x7f1840000000 (size 32G) at IOVA 0x800000000 in 2887.56ms

Here, the mmap() call completes instantly, but the ioctl to map the DMA
region incurs the ~3s cost of prefaulting the pages.

Running the same test with the -p flag results in:

  $ ./vfio_dma_mapping_perf_test -p -b 32G -a "-v vfio_type1_iommu_memfd_hugetlb_1gb"
  Completed mmap() for memfd in 2887.41ms
  Mapped HVA 0x7f8000000000 (size 32G) at IOVA 0x800000000 in 11.51ms

By shifting the prefaulting overhead to mmap(), the actual DMA mapping
latency is isolated and accurately reported as 11.51ms.

With user-defined mapping sizes and prefaulting in place, this test now
clearly demonstrates the difference in mapping speeds between VFIO's Type 1
IOMMU and IOMMUFD (i.e., IOMMU_IOAS_MAP_FILE).

Running the same configuration with the "iommufd_memfd_hugetlb_1gb" variant
highlights this difference:

$ ./vfio_dma_mapping_perf_test -p -b 32G -a "-v iommufd_memfd_hugetlb_1gb"
Mapped HVA 0x7f4fc0000000 (size 32G) at IOVA 0x800000000 in 0.11ms

The DMA mapping time drops dramatically from 11.51ms to 0.11ms.

Signed-off-by: Aaron Lewis <aaronlewis@google.com>
---
 .../vfio/vfio_dma_mapping_perf_test.c         | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
index 6c025e9c4420..8032f51c1a3e 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
@@ -22,6 +22,7 @@ static const char *device_bdf;
 
 struct test_params {
 	u64 size;
+	int mmap_flags;
 };
 
 struct test_params test_params;
@@ -88,7 +89,7 @@ FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
 TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 {
 	const u64 size = test_params.size;
-	const int flags = variant->mmap_flags;
+	const int flags = variant->mmap_flags | test_params.mmap_flags;
 	struct dma_region region;
 	struct timespec start;
 	u64 unmapped;
@@ -217,7 +218,9 @@ TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
 	u64 unmapped;
 	int rc, fd;
 
-	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
+	region.vaddr = setup_memfd(&fd, size,
+				   variant->mmap_flags | test_params.mmap_flags,
+				   variant->memfd_flags);
 	ASSERT_NE(region.vaddr, MAP_FAILED);
 
 	region.iova = iova_allocator_alloc(self->iova_allocator, size);
@@ -288,11 +291,16 @@ size_t parse_size(const char *size)
 static void help(char *name)
 {
 	puts("");
-	printf("usage: %s [-h] [-b bytes] [-a \"test harness args\"]\n", name);
+	printf("usage: %s [-h|-p] [-b bytes] [-a \"test harness args\"]\n", name);
 	puts("");
 	printf(" -h: Display this help message.\n"
 	       " -b: Specify the size of the DMA region to be mapped\n"
 	       "     and unmapped. e.g. 16M or 8G, (default: 1G)\n"
+	       " -p: Append 'MAP_POPULATE' to the mmap() flags to avoid\n"
+	       "     prefaulting while mapping DMA regions. Instead, any\n"
+	       "     and all prefaulting needed will happen during the\n"
+	       "     mmap() call. This will make mapping DMA regions\n"
+	       "     more consistent.\n"
 	       " -a: Args that are forwarded to the test harness,\n"
 	       "     e.g. -a \"-t dma_map_unmap_from_file\"\n");
 }
@@ -320,9 +328,10 @@ static void setup_test(struct harness_args *args, int argc, char *argv[])
 
 	test_params = (struct test_params) {
 		.size = SZ_1G,
+		.mmap_flags = 0,
 	};
 
-	while ((opt = getopt(argc, argv, "a:b:h")) != -1) {
+	while ((opt = getopt(argc, argv, "a:b:ph")) != -1) {
 		switch (opt) {
 		case 'a':
 			populate_harness_args(args, argv[0], optarg);
@@ -330,6 +339,9 @@ static void setup_test(struct harness_args *args, int argc, char *argv[])
 		case 'b':
 			test_params.size = parse_size(optarg);
 			break;
+		case 'p':
+			test_params.mmap_flags = MAP_POPULATE;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


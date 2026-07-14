Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BE4D8DBC
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047505; cv=none; b=aPBEYOCl5tva1msiKo+hQR3Yz0KvO7XIv4tu5nWhZXzpRTySf925UOiE3j6XuI+oOhpmxeoRrLxsf4aH4hpJZCQmeprSHSvhZ/g1n3hKEUJxb5pno388S1fS8ab5K2u8i9BC6ZSBliKxUddvSqAS9wPNzAU0L1FkFID+Lg9KOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047505; c=relaxed/simple;
	bh=fSuz7/aqn6gGRUJExyCb9+JHM4ys7TnY1EzQBhqas2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhbouqtgngIp+42TwRQ25AbJVH0+pvRrgnHgwdDpF0DilJa2oPPQpTKnM0sutRRnBuZVeYThcddERn3t6WmL3LHv1RvkZPhms9fM+J9vqphVhd+371nGlpRvEEqnaSl39BC9gaAub6M82c8D8tvk/dbwUA4ELKuPcLzxBAmrrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh7KmZe1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh7KmZe1"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc73e322dbso53664775ad.1
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784047503; x=1784652303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V3ZyvoTpPQ0Jj5kKndw9RHvcAxX1lCHVMtB20YrxxMU=;
        b=sh7KmZe1c3p2QeQ/L2xJc83WkzosMUbusdUh9+OdW9HojzVZ9XT1voE98PcUlpy1w5
         7JRrNY9NGvxx9ScJWs8BP3ToEs98T/Ow72j81UEaK05xhXqstesRmyZEWx+aFl4xwRyE
         bHlnbsA3WgEcfGmBuepi3HBem7D6wYQXF+2BLGeOO7PpbnGurOWJpe1QLfCNoIWOYyv1
         EzcoNEsKakJE6+4kYnfQ8/0flsTtvpArk1ur/gwBI92reOVEfPuuF4avd+OdyzX3bhn5
         5464uGVt3tPwHbIg2mMCrNFXFzLrEF8p+1JYRoFtB4hBkAo+tgwE7G/+PUgi/6HIOQRS
         sAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047503; x=1784652303;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3ZyvoTpPQ0Jj5kKndw9RHvcAxX1lCHVMtB20YrxxMU=;
        b=ogIs+PB2+RcaRboik7rLKGUTpdJtZoFHeWjOOwWQX7wfqoQ1QNeDcvGNTm+OiwRVUB
         T9jGQ1E2WGUXu8VGIQMF7ObO7rpAmPZZPioaITLgKSOfUK5D/WfGrkQ+WkrnnLloFgYQ
         UJAlwVllUbBnqpNESdDPuouv+Gs4iDK5TLCguxVQUGT/2Djka/c0LVLfXeVJcevpRvC0
         UPleUmJPng4mH3dJddJyGQy1KY0Ji/ZNm1gRJTR3S5XNDgNEDRgyTBxt7E39ViMbrZGP
         5paXit8Sf9gOLo0J5eWjC3atYPpjq5d+nd4OiJhonxFVGh5uRMiYwfm9a5nAlxo2UiBM
         k1eQ==
X-Gm-Message-State: AOJu0YxiP/k4IAeFntKl7DjymFboJKDski9HxwWUN39KVY4iC73PC4ka
	edSp0/9CbodP8MEXWUb9baRWLdvEXLJKZREHNdFbnplgs+Z3Zuby3gaQyRq3RacRyQ3mnriGQRj
	yoH6Otg==
X-Gm-Gg: AfdE7cn/EZsILu9XC2918derDrV0uOLHPPylUhTBxorgqAOW+ow/75udwv4xkhRrtVI
	cf5aPxajP0FHt16A/uzR3fRdUZmvTrgTIb13iE6H/4dcHeM/5OCuO5S5N0zpO+qNct0GWGSAOrB
	lN3mh/O8gaHfSbe7F6Qr+rY4ylH75JA0jC/BPewJczlwvGcsvgz7j7pEUSYQ/BA+Efe8QOYQXzf
	XUhCrERRP+1HIO/KIzUTCdfUsOLVPbH54F2ZvRY21dnRxxsPOwP8ufCitJMJiktTqH687CXj5Vr
	cX6DIdogcXXLPlJlaLxVOp5/xQ9jMH6A2IsLbd9BSUwVT68g8d5FS3Yp2xgm/DJcln9Fzpsg91r
	wCWZtNjVTeVzkKzwQ9/d+BXLKTNwEMicIARfPAtJ4kmYF4asCBi3/WvSU/hmEGXggmKVVNZ22Uy
	XdOaFyPRUSD/pEboOcDe2Y9ZkIn0HXl6+80fetKN5RytanedALY/0=
X-Received: by 2002:a17:903:240c:b0:2c9:da58:17dd with SMTP id d9443c01a7336-2ce9f050e8emr126919505ad.34.1784047502496;
        Tue, 14 Jul 2026 09:45:02 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccf797ebc4sm94300125ad.83.2026.07.14.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:45:01 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:44:58 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH 1/4] vfio: selftests: Introduce vfio_dma_mapping_perf_test
Message-ID: <alZnitH5racGUSr0@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-2-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701203311.326798-2-aaronlewis@google.com>

On 2026-07-01 08:33 PM, Aaron Lewis wrote:
> Introduce a tool to aid in latency testing rather than a traditional
> pass/fail test. The goal is to make the test configurable to expose
> latency issues and make them easy to reproduce and share.
> 
> Start with a basic test that performs a simple DMA map/unmap and reports
> the duration of each operation. Report the following four metrics:
> 
>   1. Time taken by mmap().
>   2. Time taken to map a DMA region.
>   3. Time taken to unmap a DMA region.
>   4. Time taken by munmap().
> 
> Subsequent commits in this series will introduce more features to allow
> for a wider variety of testing.
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>

> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> new file mode 100644
> index 000000000000..87d84450fc47
> --- /dev/null
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c

> +static void timer_start(struct timespec *start) {
> +	clock_gettime(CLOCK_MONOTONIC, start);
> +}
> +
> +static double timer_elapsed_ms(struct timespec start)
> +{
> +	struct timespec end;
> +
> +	clock_gettime(CLOCK_MONOTONIC, &end);
> +
> +	return (double)(end.tv_sec - start.tv_sec) * MSEC_PER_SEC +
> +	       (double)(end.tv_nsec - start.tv_nsec) / NSEC_PER_MSEC;
> +}

Please add these to the library and let's exposed the full granularity
(number of nanoseconds as a u64) and let caller decide how to format it.

> +
> +FIXTURE(vfio_dma_mapping_perf_test) {
> +	struct iommu *iommu;
> +	struct vfio_pci_device *device;
> +	struct iova_allocator *iova_allocator;
> +};
> +
> +FIXTURE_VARIANT(vfio_dma_mapping_perf_test) {
> +	const char *iommu_mode;
> +	int mmap_flags;
> +};
> +
> +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags)	       \
> +FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_test, _iommu_mode ## _ ## _name) {   \
> +	.iommu_mode = #_iommu_mode,					       \
> +	.mmap_flags = MAP_ANONYMOUS | MAP_PRIVATE | (_mmap_flags),	       \
> +}
> +
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous, 0);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_2mb, MAP_HUGETLB | MAP_HUGE_2MB);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(anonymous_hugetlb_1gb, MAP_HUGETLB | MAP_HUGE_1GB);
> +
> +#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
> +
> +FIXTURE_SETUP(vfio_dma_mapping_perf_test)
> +{
> +	self->iommu = iommu_init(variant->iommu_mode);
> +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->iova_allocator = iova_allocator_init(self->iommu);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_dma_mapping_perf_test)
> +{
> +	iova_allocator_cleanup(self->iova_allocator);
> +	vfio_pci_device_cleanup(self->device);
> +	iommu_cleanup(self->iommu);
> +}
> +
> +TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
> +{
> +	const u64 size = SZ_1G;
> +	const int flags = variant->mmap_flags;
> +	struct dma_region region;
> +	struct timespec start;
> +	u64 unmapped;
> +	int rc;
> +
> +	timer_start(&start);
> +	region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
> +	printf("Completed mmap() in %.2lfms\n", timer_elapsed_ms(start));
> +
> +	/* Skip the test if there aren't enough HugeTLB pages available. */
> +	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
> +		SKIP(return, "mmap() failed: %s (%d)\n", strerror(errno), errno);
> +	else
> +		ASSERT_NE(region.vaddr, MAP_FAILED);
> +
> +	region.iova = iova_allocator_alloc(self->iova_allocator, size);
> +	region.size = size;
> +
> +	timer_start(&start);
> +	iommu_map(self->iommu, &region);
> +	printf("Mapped HVA %p (size %luG) at IOVA 0x%lx in %.2lfms\n",
> +	       region.vaddr, size / SZ_1G, region.iova, timer_elapsed_ms(start));

To ease with parsing the test output for performance results maybe we
should avoid including specific addresses/sizes mixed in? You can print
out the configuration first and then all the performance data. e.g.

  Test Config: size=1GB, backing=HugeTLB, page_size=1GB
  mmap: XX.YYYYYs
  IOMMU map: XX.YYYYYs
  IOMMU unmap: XX.YYYYYs
  munmap: XX.YYYYYs

I don't think logging the HVA or IOVAs are particularly useful.

> +	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
> +
> +	timer_start(&start);
> +	rc = __iommu_unmap(self->iommu, &region, &unmapped);
> +	printf("Unmapped IOVA 0x%lx in %.2lfms\n", region.iova, timer_elapsed_ms(start));

Consider generating the timer code. e.g.

+#define TIME(_name, _expression) do {                                  \
+       struct timespec __start;                                        \
+                                                                       \
+       timer_start(&__start);                                          \
+       _expression;                                                    \
+       printf(_name ": %.2lfms", timer_elapsed_ms(__start));   \
+} while (0)
+
 TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
 {
        const u64 size = test_params.size;
        const int flags = variant->mmap_flags | test_params.mmap_flags;
        struct dma_region region;
-       struct timespec start;
        u64 unmapped;
-       int rc;

-       timer_start(&start);
-       region.vaddr = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0);
-       printf("Completed mmap() in %.2lfms\n", timer_elapsed_ms(start));
+       TIME("mmap",  mmap(NULL, size, PROT_READ | PROT_WRITE, flags, -1, 0));

        /* Skip the test if there aren't enough HugeTLB pages available. */
        if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
@@ -108,21 +112,13 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
        region.iova = iova_allocator_alloc(self->iova_allocator, size);
        region.size = size;

-       timer_start(&start);
-       iommu_map(self->iommu, &region);
-       printf("Mapped HVA %p (size %luG) at IOVA 0x%lx in %.2lfms\n",
-              region.vaddr, size / SZ_1G, region.iova, timer_elapsed_ms(start));
+       TIME("IOMMU map", iommu_map(self->iommu, &region));
        ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));

-       timer_start(&start);
-       rc = __iommu_unmap(self->iommu, &region, &unmapped);
-       printf("Unmapped IOVA 0x%lx in %.2lfms\n", region.iova, timer_elapsed_ms(start));
-       ASSERT_EQ(rc, 0);
+       TIME("IOMMU unmap", ASSERT_EQ(0,__iommu_unmap(self->iommu, &region, &unmapped)));
        ASSERT_EQ(unmapped, region.size);

-       timer_start(&start);
-       ASSERT_TRUE(!munmap(region.vaddr, size));
-       printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
+       TIME("munmap", ASSERT_TRUE(!munmap(region.vaddr, size)));
 }

> +	ASSERT_EQ(rc, 0);
> +	ASSERT_EQ(unmapped, region.size);
> +
> +	timer_start(&start);
> +	ASSERT_TRUE(!munmap(region.vaddr, size));
> +	printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> +	return test_harness_run(argc, argv);
> +}
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

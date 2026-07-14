Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA44DA53B
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047994; cv=none; b=lOPZ129x7Ngu9TfvQq/zSMkPjUlQkPdfzPKgwZu3ZCVv5P58yBDRbKwwJh1eovrussWxAQXehi/Su5qiB9EGsGRYfew7kmEYQUEi0KQPKQHD45/Ygbzj32v8PDtGBXB6n8kTCQL4wy2IXAqHUm5YMlApM5U6NA+zAQnoKgumYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047994; c=relaxed/simple;
	bh=WoMkLx5KS5CEMVHejFqn1Zg3Rul0pF0TkE9axUXE+qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al5JSWM4f0BtfjKebzCeQzpYpena/jRasVBQpJFDpiteRBeggtV7bKSplKQI0mOlE3DTajsF/aVI1fCQqnTf5BAegEBuuBvMyHzryxhd9uyZju5Z77fKL+9ojrhbMgzzgJrftv5O4lgQvBcaEJKq+mqx8cBxSwQJl+fM4gWrtXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7Y7zEH4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7Y7zEH4"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc61541f8cso16481915ad.0
        for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 09:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784047992; x=1784652792; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T01tswnQ7oRBZyTsyqLwu22CGWAJ6EjpKEFQ5aifsnA=;
        b=J7Y7zEH4zdtrfvdAWVP8C9aY+1yoENqggc68llSKMHwRKURwrkESa5iwtBr5R9K7y/
         MZvGWwkw1LJQQWW/oYhU/AlglysN9/5HWQ6FE2cfx2e2TmNPS5+XFt+bJYT73DBUNEsC
         NedDPfDm9BbfG/4KL8MwIkL6oh+3gBi5d20YZqJg919b2LToe7lAvc/B/gNySGOMN5VC
         5YXnld6y0z06dadS8uk+1fjxkjsThfDDHXBkvtJKzXx6t4e4SgXgS20m446kzq6T9wic
         P0nGBehqLANfYLlWdtafvS9vhN70W+lDRxXdzTOB9inxonvPXmwD0/G7DdcEOrarbjrG
         48gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784047992; x=1784652792;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T01tswnQ7oRBZyTsyqLwu22CGWAJ6EjpKEFQ5aifsnA=;
        b=eFJ53zF4MRtpD3/1e0k9WST4im5CWHzPXoklznfUwHxoVXynVO9uBO/oKmj9p/D/lU
         3wAi2Iu1S97eYBawzkaWtqGWNtS/bGKySTESOWC+yJk0h+q202PlrXsP58JjsUaUQxUr
         VSLqUKmL+BrxmtvBoive2WeFazP8XP4BS4/vhD5rOcJmxDYwOWY7LmZ/M3w9Ey6d2F/v
         tJ6MPOnie8n7izDfBOMAfiSy4EJEi+YKcJp2FtF1nifdHo/8DKnicymiMuba8zkNh3Lo
         5giqxmj91JHlWp5qzyQZODWe3oa+VtJBV+PKor2o52qXTa+tRbuqxQ+19YPQD0j+6OJ6
         4wog==
X-Gm-Message-State: AOJu0YyNu+EUxmeQ3ycysO572upRVBUhb+u0JSx3i2dO2WM8qOHxtWib
	ZaYjtApPYwlDt6b45ljDyiQ6D9CzK38Ma3NqlQ9AFkV8CP/WMXYpDLIS3K7TvC9d7g==
X-Gm-Gg: AfdE7ckNyl5Ds1Wz3hy/GvcNzNOVZ+deoqytQoeRBy3AEwssiMh2p0N07zeic5Shj/f
	m0paNg4XHyGmxsACq/8rW42n4PB75TcBZvTcCLhvubkJk/znAlJMVLCFHdc/7uTqWEPFKGSv0fd
	+75Sm75MvR0wMU9JlAMZDpAg+aT6HJ6XTT8DUiGvTEKkYjOR102kYPPVa0BW4oQVZ3YD6SRibKq
	xLHaQmxDR+Mgyj77RZso0yUGyJCdLRfTktmR+fgVukj0uoo/6O5GqD5nvk8EaI82MWcnY06A9MJ
	Y/YUo9LOTRcQir4Nv+OWHb3OcdUkazJHXKqAnHNHf33HAgDTE9KH7CaSOMIyIVYbjs23hzr72nZ
	Zvg6lSEynIgMlzstlEyQrnw8gEmMYex8w7YdV+RwCMVExr4SzSu8Z0B0DxxwDdWcZioAfvLhRyu
	VOmtAaz3vsVl95W7WKYfMGVuQoMpAimu6TPE4EJ7rkLPdvDJlrzSc=
X-Received: by 2002:a17:903:2f8c:b0:2c9:b90b:8448 with SMTP id d9443c01a7336-2ce82988528mr163460675ad.27.1784047991521;
        Tue, 14 Jul 2026 09:53:11 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bde9sm119644075ad.79.2026.07.14.09.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 09:53:10 -0700 (PDT)
Date: Tue, 14 Jul 2026 16:53:07 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH 2/4] vfio: selftests: Add memfd test to
 vfio_dma_mapping_perf_test
Message-ID: <alZpc7oSwtw7hExk@google.com>
References: <20260701203311.326798-1-aaronlewis@google.com>
 <20260701203311.326798-3-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701203311.326798-3-aaronlewis@google.com>

On 2026-07-01 08:33 PM, Aaron Lewis wrote:
> Add a second test to "vfio_dma_mapping_perf_test" to evaluate memfd
> latencies. A key motivator for adding this test is to demonstrate that
> the IOMMU_IOAS_MAP_FILE ioctl is significantly faster than other methods
> of mapping DMA regions. While this performance difference is not fully
> apparent with the test's current capabilities, it will become evident
> as more features are introduced later in the series.
> 
> To support this, add IOMMU_IOAS_MAP_FILE ioctl support to the VFIO
> selftest library via iommufd_map_file().
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>
> ---
>  .../vfio/lib/include/libvfio/iommu.h          |   7 ++
>  tools/testing/selftests/vfio/lib/iommu.c      |  24 ++++
>  .../vfio/vfio_dma_mapping_perf_test.c         | 118 ++++++++++++++++++
>  3 files changed, 149 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> index e9a3386a4719..eeef5990292c 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> @@ -35,6 +35,13 @@ struct iommu {
>  struct iommu *iommu_init(const char *iommu_mode);
>  void iommu_cleanup(struct iommu *iommu);
>  
> +int __iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd);
> +
> +static inline void iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd)
> +{
> +	VFIO_ASSERT_EQ(__iommufd_map_file(iommu, region, fd), 0);
> +}
> +
>  int __iommu_map(struct iommu *iommu, struct dma_region *region);
>  
>  static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
> index 035dac069d60..6730b39060ca 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -97,6 +97,30 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
>  	return iova;
>  }
>  
> +int __iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd)
> +{
> +	VFIO_ASSERT_TRUE(iommu->iommufd, "IOMMU_IOAS_MAP_FILE is an IOMMUFD IOCTL.");
> +
> +	struct iommu_ioas_map_file args = {
> +		.size = sizeof(args),
> +		.flags = IOMMU_IOAS_MAP_READABLE |
> +			IOMMU_IOAS_MAP_WRITEABLE |
> +			IOMMU_IOAS_MAP_FIXED_IOVA,
> +		.ioas_id = iommu->ioas_id,
> +		.fd = fd,
> +		.start = 0,
> +		.iova = region->iova,
> +		.length = region->size,
> +	};
> +
> +	if (ioctl(iommu->iommufd, IOMMU_IOAS_MAP_FILE, &args))
> +		return -errno;
> +
> +	list_add(&region->link, &iommu->dma_regions);
> +
> +	return 0;
> +}
> +
>  static int vfio_iommu_map(struct iommu *iommu, struct dma_region *region)
>  {
>  	struct vfio_iommu_type1_dma_map args = {
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> index 87d84450fc47..4639bda7ebaa 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> @@ -117,6 +117,124 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  	printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
>  }
>  
> +FIXTURE(vfio_dma_mapping_perf_memfd_test) {
> +	struct iommu *iommu;
> +	struct vfio_pci_device *device;
> +	struct iova_allocator *iova_allocator;
> +};
> +
> +FIXTURE_VARIANT(vfio_dma_mapping_perf_memfd_test) {
> +	const char *iommu_mode;
> +	int mmap_flags;
> +	int memfd_flags;
> +};
> +
> +#define FIXTURE_VARIANT_ADD_IOMMU_MODE(_iommu_mode, _name, _mmap_flags, _memfd_flags) \
> +FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, _iommu_mode ## _ ## _name) {    \
> +	.iommu_mode = #_iommu_mode,						      \
> +	.mmap_flags = MAP_SHARED | (_mmap_flags),				      \
> +	.memfd_flags = MAP_SHARED | (_memfd_flags),				      \
> +}
> +
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(memfd, 0, 0);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(memfd_hugetlb_2mb,
> +				    MAP_HUGETLB | MAP_HUGE_2MB,
> +				    MFD_HUGETLB | MFD_HUGE_2MB);
> +FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(memfd_hugetlb_1gb,
> +				    MAP_HUGETLB | MAP_HUGE_1GB,
> +				    MFD_HUGETLB | MFD_HUGE_1GB);

Only iommufd supports file-based mapping so not need to replicate across
all other IOMMU modes. Just run with iommufd.

And then you can drop the special case below where you fallback to
HVA-based mapping in the file-based test, which is largely duplicating
the other test.

If you want to also have test coverage for HVA-based mapping of
file-backed memory then you should add that separately, and include
iommufd in it.

> +
> +#undef FIXTURE_VARIANT_ADD_IOMMU_MODE
> +
> +FIXTURE_SETUP(vfio_dma_mapping_perf_memfd_test)
> +{
> +	self->iommu = iommu_init(variant->iommu_mode);
> +	self->device = vfio_pci_device_init(device_bdf, self->iommu);
> +	self->iova_allocator = iova_allocator_init(self->iommu);
> +}
> +
> +FIXTURE_TEARDOWN(vfio_dma_mapping_perf_memfd_test)
> +{
> +	iova_allocator_cleanup(self->iova_allocator);
> +	vfio_pci_device_cleanup(self->device);
> +	iommu_cleanup(self->iommu);
> +}
> +
> +static void *setup_memfd(int *fd, u64 size, int mmap_flags, int mfd_flags)
> +{
> +	void *buf = MAP_FAILED;
> +	struct timespec start;
> +
> +	timer_start(&start);
> +	*fd = memfd_create("vfio_dma_mapping_perf_memfd_test", mfd_flags);
> +	printf("Completed memfd_create() in %.2lfms\n", timer_elapsed_ms(start));
> +	if (*fd <= 0)
> +		return MAP_FAILED;
> +
> +	if (ftruncate(*fd, size))
> +		goto out;
> +
> +	timer_start(&start);
> +	buf = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, *fd, 0);
> +	printf("Completed mmap() for memfd in %.2lfms\n", timer_elapsed_ms(start));
> +
> +out:
> +	if (buf == MAP_FAILED)
> +		close(*fd);
> +
> +	return buf;
> +}
> +
> +static void teardown_memfd(int fd, u64 size, void *vaddr)
> +{
> +	struct timespec start;
> +
> +	if (vaddr != MAP_FAILED) {
> +		timer_start(&start);
> +		munmap(vaddr, size);
> +		printf("Completed munmap() in %.2lfms\n", timer_elapsed_ms(start));
> +	}
> +
> +	if (fd != -1) {
> +		timer_start(&start);
> +		close(fd);
> +		printf("Completed close() in %.2lfms\n", timer_elapsed_ms(start));
> +	}
> +}
> +
> +TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
> +{
> +	const u64 size = SZ_1G;
> +	struct dma_region region;
> +	struct timespec start;
> +	u64 unmapped;
> +	int rc, fd;
> +
> +	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
> +	ASSERT_NE(region.vaddr, MAP_FAILED);
> +
> +	region.iova = iova_allocator_alloc(self->iova_allocator, size);
> +	region.size = size;
> +
> +	timer_start(&start);
> +	if (strcmp(variant->iommu_mode, MODE_IOMMUFD) == 0) {
> +		iommufd_map_file(self->iommu, &region, fd);
> +	} else {
> +		iommu_map(self->iommu, &region);
> +	}
> +	printf("Mapped HVA %p (size %luG) at IOVA 0x%lx in %.2lfms\n",
> +	       region.vaddr, size / SZ_1G, region.iova, timer_elapsed_ms(start));
> +	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
> +
> +	timer_start(&start);
> +	rc = __iommu_unmap(self->iommu, &region, &unmapped);
> +	printf("Unmapped IOVA 0x%lx in %.2lfms\n", region.iova, timer_elapsed_ms(start));
> +	ASSERT_EQ(rc, 0);
> +	ASSERT_EQ(unmapped, region.size);

Maybe we should add this assert to iommu_unmap() and you can just use
iommu_unmap() here and in the other test?

> +
> +	teardown_memfd(fd, size, region.vaddr);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 

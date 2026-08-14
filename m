Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598623DA5B2
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 20:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740280; cv=none; b=IrfPtAIIlyl61f9bek+g/bUbnUdWkPfTZ1n1IaSoM78FsyKc/MTo2bytb1+Jwby8iILaKFltmVMrWEfsDvnQE9fU/S54s6mQxqIcK9samfkkVk186aI2w7VUlw2eq1o+77smEgj887dmqTWpwDcxWLxjzfXuDRqDexTM3GiZ34M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740280; c=relaxed/simple;
	bh=YgJGZwopRFt5LKPovlZMJB2y70ZD41IxouMj9pWSMbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpwPs/c9I4cf148KiVn3qcv54aMU+FcBMg/HJ+SK9/G5d+JSzjgfJ6xq4KFPtmVFcpTrahDT1Uwjon0COCRmCIGsZTmMas1zlWX1dWSGaWjHO8mDs3w4BggMekSJvB5jZhVUzm/+Sk7uT8n36BAkVeIPs5eLsB+eopv5nqqiP9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rh49zS7Y; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rh49zS7Y"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3811f512167so2083472a91.3
        for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786740279; x=1787345079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q0ngp/UsrpQYsX1xt267pJp9xJ4rgNth8LSOfPppyA0=;
        b=rh49zS7YDRP8h/JRPHHG9zQhvQADQkmUMAMTXDNYue0Yi8yJeHbk6sz/laNot23x1u
         ZhPaFP7ajigxCVxWbVYB/vQmedvKXo7sXJmtsL+NuVY1VgwJPGWjyWNPRhysw6nhJvHu
         rr+ygDQ11Nm+kGb84bWVUzUqN2sZVwWhvvlTSxWxgUCGZqxy88Y059ZYtPQnkhm7X8DZ
         eC++xdv+A2G/RuxLz1mGvMDsoGEzsrIN/Fet8qJej1+aFG147IHoEfV6ugu0IfmMyjaB
         iikwyPfRwfmjUv3lLrUXmVsg/VQQZwzpO/doffmIrYliqO0TqcO3keMowmA3xOtAvdxu
         0QSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740279; x=1787345079;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q0ngp/UsrpQYsX1xt267pJp9xJ4rgNth8LSOfPppyA0=;
        b=HHDndlc/i3JN4qbyIkkHe5D5utMjNvpdGWhhnwT2PtFShoT9QW3RBIGjAgxh5TUWzA
         33rucaApXkd6Z4bv/A5HzQG5GMnVGTXtRpuu4fBgR99N63SoIA6yJsmASujGXSClhWM3
         CFMaSqOoOM4sEACnw1iK0F/wHy+LkOCQuJBNhQQeT+Apv5WpJHi0ku9c2+5dTn3vgX3o
         8eNDGIxUAZTjv8hRszPGNH9B0fjzU38Xt2oF3cturb5Zbux2gjNSVAXqU65XeNpCEaEu
         kpkcq0rq3KChidmW6f9Qgk9YbPdV+WFvnn8Oj9NPqkm16icz62e/ZaktVpftfvienU+r
         j9rw==
X-Gm-Message-State: AOJu0YxWzWMYShjP+0GR9jPto5gfO8mX8tejcq+64UKhcdo8nFesdXmg
	iNH0mf4nqrGa/akOQ1k5RKWGbXC0Vk4du1jwYRtpkwpOaEl76vQXkSOD9TQunAQn8Q==
X-Gm-Gg: AR+sD13E6U3452JOL3A5sdvczCPJ/3qft3BFjUyeYNKBkj0stFEPTTEFFCIdGwphUPU
	MTivpiybxEx2XBqw4apdjPJmoOOqrMDzQtTz/0EYY/l37mFqGeR0Vj1dw4JMCLbOz137VrNf2eT
	YoekxA3pIzBhwSGnsf2cQ+7ckiK2joXoP8zbnkmorj4ZCrvMdmSpDbpMobhaMtaumezaN0DxW+j
	kihYAWB5kUfQ7ezdZerD1uIG7rn351oKeDakTQ4tOzEJZiqdvsiha+HXY0QFrQndnqtFbi0boNp
	YzJJkPlnJC7pNEIXuy7HbvACUvlp+nqoVn2VuonlATToc29vLEs35PJ/WmIwHQGEukhprVBYaVy
	gus41xDYVZX0xFnq5f6NIBR+FBd8NVUhMUAh6VjZtVTHDDnj4BfgJMaShLhbTU1hL/43lZmPLOC
	HZqRQFwtNtKwnWGvGr1MOLB8FZtAHWVoPT98OFOqnW9JRVukuCadeDGwnp+6tPJm5U7aa81QFIF
	NygkEKvryEQBIsrlJ6Ckp478i5N8A==
X-Received: by 2002:a17:90b:2891:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-3933b8e1ec2mr10029222a91.11.1786740278137;
        Fri, 14 Aug 2026 13:44:38 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea96947dsm3950132a91.1.2026.08.14.13.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:44:37 -0700 (PDT)
Date: Fri, 14 Aug 2026 20:44:34 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v2 3/4] vfio: selftests: Add memfd test to
 vfio_dma_mapping_perf_test
Message-ID: <an9-Mu60yJ1vhidb@google.com>
References: <20260804165748.1060476-1-aaronlewis@google.com>
 <20260804165748.1060476-4-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804165748.1060476-4-aaronlewis@google.com>

On 2026-08-04 04:57 PM, Aaron Lewis wrote:
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
>  tools/testing/selftests/vfio/lib/iommu.c      |  24 +++++
>  .../vfio/vfio_dma_mapping_perf_test.c         | 102 ++++++++++++++++++
>  3 files changed, 133 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> index 5c77875240f4..515976fb19be 100644
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
> index b6f3c5c84e01..b76ae0a91c68 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -97,6 +97,30 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
>  	return iova;
>  }
>  
> +int __iommufd_map_file(struct iommu *iommu, struct dma_region *region, int fd)

I would prefer to have the fd and offset (start) tracked as part of the
struct dma_region. e.g.

int __iommufd_map_file(struct iommu *iommu, struct dma_region *region)
{
	...

	struct iommu_ioas_map_file args = {
		...
		.fd = region->fd,
		.start = region->fd_offset,
		...
	};

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
> index 26c04cabef61..5ef85deba4ee 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> @@ -83,6 +83,108 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
>  	TIME("munmap", ASSERT_EQ(0, munmap(region.vaddr, size)));
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
> +#define FIXTURE_VARIANT_ADD_MEMFD_MODE(_name, _mmap_flags, _memfd_flags)      \
> +FIXTURE_VARIANT_ADD(vfio_dma_mapping_perf_memfd_test, iommufd ## _ ## _name) {\
> +	.iommu_mode = MODE_IOMMUFD,					      \
> +	.mmap_flags = MAP_SHARED | MAP_POPULATE | (_mmap_flags),	      \
> +	.memfd_flags = (_memfd_flags),					      \
> +}
> +
> +FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd, 0, 0);
> +FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_2mb,
> +				    MAP_HUGETLB | MAP_HUGE_2MB,
> +				    MFD_HUGETLB | MFD_HUGE_2MB);
> +FIXTURE_VARIANT_ADD_MEMFD_MODE(memfd_hugetlb_1gb,
> +				    MAP_HUGETLB | MAP_HUGE_1GB,
> +				    MFD_HUGETLB | MFD_HUGE_1GB);
> +
> +#undef FIXTURE_VARIANT_ADD_MEMFD_MODE
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
> +
> +	TIME("memfd_create",
> +	     *fd = memfd_create("vfio_dma_mapping_perf_memfd_test", mfd_flags));
> +	if (*fd < 0)
> +		return MAP_FAILED;
> +
> +	if (ftruncate(*fd, size))
> +		goto out;
> +
> +	TIME("mmap",
> +	     buf = mmap(NULL, size, PROT_READ | PROT_WRITE, mmap_flags, *fd, 0));
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
> +	if (vaddr != MAP_FAILED)
> +		TIME("munmap", VFIO_ASSERT_EQ(0, munmap(vaddr, size)));

Checking vaddr != MAP_FAILED seems unnecessary. The test will exit if
setup_memfd() fails.

> +
> +	if (fd != -1)
> +		TIME("close", VFIO_ASSERT_EQ(0, close(fd)));

Same here for fd != -1.

> +}
> +
> +TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
> +{
> +	const u64 size = SZ_1G;
> +	const int flags = variant->mmap_flags;
> +	struct dma_region region;
> +	int fd;
> +
> +	printf("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
> +
> +	region.vaddr = setup_memfd(&fd, size, variant->mmap_flags, variant->memfd_flags);
> +
> +	/* Skip the test if there aren't enough HugeTLB pages available. */
> +	if (flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
> +		SKIP(return, "setup_memfd() failed: %s (%d)\n", strerror(errno), errno);
> +	else
> +		ASSERT_NE(region.vaddr, MAP_FAILED);
> +
> +	region.iova = iova_allocator_alloc(self->iova_allocator, size);
> +	region.size = size;
> +
> +	TIME("IOMMU map", iommufd_map_file(self->iommu, &region, fd));
> +	ASSERT_EQ(region.iova, to_iova(self->device, region.vaddr));
> +
> +	TIME("IOMMU unmap", iommu_unmap(self->iommu, &region));
> +
> +	teardown_memfd(fd, size, region.vaddr);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	device_bdf = vfio_selftests_get_bdf(&argc, argv);
> -- 
> 2.55.0.654.g21b8a5bc05-goog
> 

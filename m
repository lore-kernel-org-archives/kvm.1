Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA148486437
	for <kvm@vger.kernel.org>; Thu,  8 Oct 2026 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453821; cv=none; b=ti6ll+FicM42jbWRlZRtVi7jYEK5Xyp/j4s0EOyRxOGVMwYoKcG6fs7lWW8egrqXi0HQol7qH2RGr7EXhymvYQ331QWWlJecPnQ/cSPCFyEX4Z3mffGfdNFW+h1yaYnsvoKJXSbXs6RgxR42YH682TAH8hT6knEEMhP/k9Fx2tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453821; c=relaxed/simple;
	bh=Ch2ZRMuUNav0DKxiyIXv9xpHzd1Sxiz2bITxOICneYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBGH1zZDZ1aKOx3OPmeFRbfBmg2Kt6A0QuCZfOr9nUOJY4TzQrAsJpH1/+47aPcudQyFnijoX7O/TW5TozZpbMu3EU2zASzLbtnDb9DnoWFdb1YnUmEEcWhgKoI7GO3OSFJeWHQ7rgdgVGkN6EKXH4U0J6ibfcPS7HQowVnLYgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KGBen8qF; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KGBen8qF"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4aa02a269so2280858a12.2
        for <kvm@vger.kernel.org>; Thu, 08 Oct 2026 03:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791453819; x=1792058619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DJ56dwwrQG11TNvoG9xsUsgIQZrW4ujejx9VXM0v1qc=;
        b=KGBen8qFBc6FMcaZOZ3sKhpDRUJlSktbMkn0SU8j1HFJAtMKFNtY1n/oYh3uvdAuYx
         sG4uXlDPFsohgNy0TAwYH0zLQOJjGLdXpPiBpdWm4J/kT+AUGkUG0mAhBGkIQr0k0N05
         LvSgn9ye1u5os9sJnx6ep6WXu3pTaL6p/W1U9c8X/sxvj+8YlUuLfzm7GCo8EMcxv7Gx
         px1/ariyr5TGNDb1bN2B/Eqt/PjrTaHduh7brcUUEPNLVURIkwnPb0b/4YglfN75Hd3b
         ZOPnbefvnduXVJqWfOvGFuFASfvyTv8e9ys5MQLAg61GDgTGl9ZLe97M05iyrgx/mLiv
         n1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453819; x=1792058619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJ56dwwrQG11TNvoG9xsUsgIQZrW4ujejx9VXM0v1qc=;
        b=OM/oVdtydC9yHCprQP2k/YdaBhGGYxABzXP4MjUBDSsc/msr5Q+VHOf5QF2lgdU9U5
         BwMs24M2em6Rtq/VPmLb2Jdy2k12veuFKmODTsx/6nVM8xFQPUwcBLuOdpQsJvCz4p/j
         nijWXGPynn6olRtZo8zSNW7h/1UMp7vvnWIxi8Fu2xE+LRsPwqKUJP9hFBzHA0q8hxYp
         r+UY+poab/0u3L/PHRHQdMir1f6ptTMRi6zllJmX+AFzrSwKNLEPaDNIctuzegdoW6rZ
         b9Bggh3oWrsolCgYb9ZlX8g8caTitLVPp7uED2gBs7PxJsFauI/jwwRWO2AOgNcX5tNP
         wD2w==
X-Gm-Message-State: AFq9FYKn2eeCG15jt5NWoBKe/8/NJy1/VGGjbqSlk9Awtz7eTtk+DShJ
	HBeMlLGwdj71ztfJ4WUAq05sRBR3N11KQlz7YFOLP8/4WiamXAdZg5KPM3C+SRbrQw==
X-Gm-Gg: AYBFou0FCl1yeyau484FFX8bYe9juwYdmp5NtaJuYuZvETXv6HWQVeNV8XWKFra8LlL
	Fh0xa/lFoh7a/D7QI5AuAkbXgNjImqE1MwdgWGFjSzVbPqJLNZ3LqBH03myb6Mka9zD/Sur8Bfk
	7ZsUp8PIC9JRpmH+8oX2Q58xBdMiKMUUwHyWUVp1N8j0Dy63DuKaxOV0h/KVUoUXHRNqNc+nwji
	T0wZEhAv69D0KOIY/1IMrU9To/qc7H8SviGl7Q0DC3tRUuNbUGmIO2sFAKl6KdS457gyS9BB5v1
	89sqPnL7F5ocYUgF9sXcykgRQ91+eGTsUrXdXer/Ai/SN3CnvnimytZIpxNXDe8pAToDaBr82N7
	o4OiDvDNuwz+lBnyhriWexBO//FRUBrShQ1kJGP/7P2nzW5na9gCxfJNZwqU8AW8QNwOZpsAK2E
	ojU87FBwTmGL8980LkjC+qxHuLGOvF1Y83mIi3Fv/SykRFZ0iDfL41WiUqmrnS5/BXy58OJqrDE
	2f6Hdpds0mquBZYoCbAruL3U6GgUyvVjIQ=
X-Received: by 2002:a17:90b:37d0:b0:3a4:8c41:fab6 with SMTP id 98e67ed59e1d1-3a8a1bca9e8mr4140380a91.46.1791453818299;
        Thu, 08 Oct 2026 03:03:38 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a9f1d10867sm4013056a91.13.2026.10.08.03.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:03:37 -0700 (PDT)
Date: Thu, 8 Oct 2026 10:03:33 +0000
From: David Matlack <dmatlack@google.com>
To: Aaron Lewis <aaronlewis@google.com>
Cc: kvm@vger.kernel.org, alex@shazbot.org, jgg@nvidia.com
Subject: Re: [PATCH v3 3/4] vfio: selftests: Add memfd test to
 vfio_dma_mapping_perf_test
Message-ID: <asdqdb0uTPT25Qj9@google.com>
References: <20260910153326.3085937-1-aaronlewis@google.com>
 <20260910153326.3085937-4-aaronlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910153326.3085937-4-aaronlewis@google.com>

On 2026-09-10 03:33 PM, Aaron Lewis wrote:
> Add a second test to "vfio_dma_mapping_perf_test" to evaluate memfd
> latencies. A key motivator for adding this test is to demonstrate that
> the IOMMU_IOAS_MAP_FILE ioctl is significantly faster than other methods
> of mapping DMA regions. While this performance difference is not fully
> apparent with the test's current capabilities, it will become evident
> as more features are introduced later in the series.

nit: Don't refer to series in commit messages. Prefer something like
"subsequent commit".

Also this sentence is extremely vague. How about:

  This performance difference is more apparent with larger memory
  regions, which will be added in a subsequent commit.

> 
> To support this, add IOMMU_IOAS_MAP_FILE ioctl support to the VFIO
> selftest library via iommufd_map_file().
> 
> Signed-off-by: Aaron Lewis <aaronlewis@google.com>

Aside from the minor comments,

Reviewed-by: David Matlack <dmatlack@google.com>

> ---
>  .../vfio/lib/include/libvfio/iommu.h          |   9 ++
>  tools/testing/selftests/vfio/lib/iommu.c      |  24 +++++
>  .../vfio/vfio_dma_mapping_perf_test.c         | 101 ++++++++++++++++++
>  3 files changed, 134 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> index 5c77875240f4..2336dcebce5c 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> @@ -22,6 +22,8 @@ struct dma_region {
>  	void *vaddr;
>  	iova_t iova;
>  	u64 size;
> +	int fd;
> +	u64 fd_offset;
>  };
>  
>  struct iommu {
> @@ -35,6 +37,13 @@ struct iommu {
>  struct iommu *iommu_init(const char *iommu_mode);
>  void iommu_cleanup(struct iommu *iommu);
>  
> +int __iommufd_map_file(struct iommu *iommu, struct dma_region *region);
> +
> +static inline void iommufd_map_file(struct iommu *iommu, struct dma_region *region)
> +{
> +	VFIO_ASSERT_EQ(__iommufd_map_file(iommu, region), 0);
> +}
> +
>  int __iommu_map(struct iommu *iommu, struct dma_region *region);
>  
>  static inline void iommu_map(struct iommu *iommu, struct dma_region *region)
> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
> index b6f3c5c84e01..a0a3dc4b968c 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c
> @@ -97,6 +97,30 @@ iova_t iommu_hva2iova(struct iommu *iommu, void *vaddr)
>  	return iova;
>  }
>  
> +int __iommufd_map_file(struct iommu *iommu, struct dma_region *region)
> +{
> +	VFIO_ASSERT_TRUE(iommu->iommufd, "IOMMU_IOAS_MAP_FILE is an IOMMUFD IOCTL.");
> +
> +	struct iommu_ioas_map_file args = {
> +		.size = sizeof(args),
> +		.flags = IOMMU_IOAS_MAP_READABLE |
> +			IOMMU_IOAS_MAP_WRITEABLE |
> +			IOMMU_IOAS_MAP_FIXED_IOVA,
> +		.ioas_id = iommu->ioas_id,
> +		.fd = region->fd,
> +		.start = region->fd_offset,
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
> index 4d41fecf2372..4113a20127de 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_perf_test.c
> @@ -83,6 +83,107 @@ TEST_F(vfio_dma_mapping_perf_test, dma_map_unmap)
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

Do not put constants in the fixture variant.

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
> +	TIME("munmap", VFIO_ASSERT_EQ(0, munmap(vaddr, size)));
> +	TIME("close", VFIO_ASSERT_EQ(0, close(fd)));
> +}
> +
> +TEST_F(vfio_dma_mapping_perf_memfd_test, dma_map_unmap_from_file)
> +{
> +	const u64 size = SZ_1G;
> +	const int mmap_flags = variant->mmap_flags;
> +	struct dma_region region;
> +	int fd;
> +
> +	ksft_print_msg("mmap size = %lluG\n", (unsigned long long)(size / SZ_1G));
> +
> +	region.vaddr = setup_memfd(&fd, size, mmap_flags, variant->memfd_flags);
> +
> +	/* Skip the test if there aren't enough HugeTLB pages available. */
> +	if (mmap_flags & MAP_HUGETLB && region.vaddr == MAP_FAILED)
> +		SKIP(return, "setup_memfd() failed: %s (%d)\n", strerror(errno), errno);
> +	else
> +		ASSERT_NE(region.vaddr, MAP_FAILED);
> +
> +	region.iova = iova_allocator_alloc(self->iova_allocator, size);
> +	region.size = size;
> +	region.fd = fd;
> +	region.fd_offset = 0;
> +
> +	TIME("IOMMU map", iommufd_map_file(self->iommu, &region));

Should this be "IOMMU map file"?

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
> 2.55.0.1003.g10538fe699-goog
> 

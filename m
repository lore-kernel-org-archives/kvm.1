Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35F376A17
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065942; cv=none; b=eg8MHAt54kQssnOG5OLOt3US3+T/QB86n18LFDOYySt5KH8F28ldKwY85wXx15cAi0oWkxRBuUo3rmGU7yDCYN0f7iT1XCmq7m2LXV6KXMU750S5Xr9EBhjecyTo5GmbxE0nWTTOeeII7PnXkMmsU5vnBtw1qpiQ/FmDCarzPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065942; c=relaxed/simple;
	bh=ZnAM9gR7mtwxYviDvC85ctRuzbailDGVIuUPTmkwCTM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TVKLqSqN3C3GU9mkJkdq3hPH6mkDWeP6quSU4dkmk3uH2F9kHdotD1gqbdc07iZgh7EeXvC0L2wnaOrkkS8yosIAIgNdrcGtKGxujXxw86LJn/lV1F5dUpLXh/mo1tgI7JQEV6OcXaBeAtk7rY+ijI/OOOSfgntDp2jB6fMVlvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYxGg4MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYxGg4MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38E71F000E9;
	Fri,  3 Jul 2026 08:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783065941;
	bh=F5EwIDZi7Z87f6AfKHaWuscNdc6sn0BPPTHFy9YL1NI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fYxGg4MVaGjQD5RnIe0eCHV6fTVPiOU17JtRsBdQlpGgr9Tghb+vYeujKxpo1LRg4
	 7dKLSsIcRjWDiMBan4OI53UTb937JGzBDgWdMQdK4fHeV8A92VTG2bwzF1h9Qole9t
	 bpS8UFsA6I1vPTKmH2fbFFqU3YED4d4GdPpsC9jVD82DkxPpqfsUz5fzYdIT6C6440
	 5OVs9zhj5bGeRxCvmFfJ2CdspYLInmLHVVL1vygUWON9Z3vhv9aYbgKLBBrwfO161k
	 7mosXbjAYqpPQKnW+itmj5WGm7FP3ReBJB/0ku8jpz7VUBz78TH8+F3M7iP7TlMR0q
	 Da5+wUQ+04fOA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/6] selftests/vfio: add sPAPR TCE v2 DMA window
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Narayana Murty N" <nnmlinux@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703032806.40946-4-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <20260703032806.40946-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:05:39 +0000
Message-Id: <20260703080540.F38E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] `vfio_iommu_map()` incorrectly returns a clobbered `errno` if `V=
FIO_IOMMU_MAP_DMA` fails.
- [Medium] If memory unregistration fails during unmap, the region is left =
in the `dma_regions` list despite being successfully unmapped in the IOMMU.
- [Medium] Failed DDW creation leaves `iommu->active_window` pointing to an=
 invalidated window, leading to stale IOVA ranges being returned.
--

commit 2deeaa397a1d09614f068ff5ae82a0732c573cd4
Author: Narayana Murty N <nnmlinux@linux.ibm.com>

selftests/vfio: add sPAPR TCE v2 DMA window helpers

This commit adds helper support for sPAPR TCE v2 DMA windows in the VFIO
selftest library. It tracks the platform default DMA window separately from
selftest-created dynamic DMA windows, and adds helpers to create, remove,
and register memory around DMA map/unmap operations.

> diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/sel=
ftests/vfio/lib/iommu.c
> index e86457a715bf7..19d19bb45a14b 100644
> --- a/tools/testing/selftests/vfio/lib/iommu.c
> +++ b/tools/testing/selftests/vfio/lib/iommu.c

[ ... ]

> +	/*
> +	 * Neither default nor DDW is sufficient.
> +	 * Remove only the selftest-created DDW, then create a new DDW.
> +	 */
> +	ret =3D spapr_tce_remove_window(iommu, &iommu->ddw_window);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D spapr_tce_create_ddw(iommu, min_size, page_shift);
> +	if (ret)
> +		return ret;

[Severity: Medium]
If spapr_tce_create_ddw() fails here, does it leave iommu->active_window
pointing to a window that was just invalidated by spapr_tce_remove_window()?

If iommu->active_window was previously set to &iommu->ddw_window, it is not
reset to NULL on this error path. Later, spapr_tce_iova_ranges() reads
iommu->active_window->start without checking if the window is valid:

static struct iommu_iova_range *spapr_tce_iova_ranges(...)
{
        ...
        ranges[0].start =3D iommu->active_window->start;
        ranges[0].last =3D iommu->active_window->start +
                         iommu->active_window->size - 1;
        ...
}

Could this return stale IOVA ranges to the caller?

> +
> +	iommu->active_window =3D &iommu->ddw_window;
> +	return 0;
> +}

[ ... ]

> @@ -113,9 +342,27 @@ static int vfio_iommu_map(struct iommu *iommu, struc=
t dma_region *region)
>  		.iova =3D region->iova,
>  		.size =3D region->size,
>  	};
> +	int ret;
> =20
> -	if (ioctl(iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args))
> +#ifdef __powerpc__
> +	if (iommu_is_spapr_tce_v2(iommu)) {
> +		if (!spapr_tce_iova_inside_window(iommu, region))
> +			return -EINVAL;
> +
> +		ret =3D spapr_register_memory(iommu, region);
> +		if (ret)
> +			return ret;
> +	}
> +#endif
> +
> +	ret =3D ioctl(iommu->container_fd, VFIO_IOMMU_MAP_DMA, &args);
> +	if (ret) {
> +#ifdef __powerpc__
> +		if (iommu_is_spapr_tce_v2(iommu))
> +			spapr_unregister_memory(iommu, region);
> +#endif
>  		return -errno;
> +	}

[Severity: Medium]
Can the cleanup call to spapr_unregister_memory() clobber the errno from the
failed VFIO_IOMMU_MAP_DMA ioctl?

Since spapr_unregister_memory() performs its own ioctl, it might overwrite
the thread-local errno. Will this result in vfio_iommu_map() returning the
result of the cleanup operation instead of the actual mapping failure?

> =20
>  	return 0;
>  }

[ ... ]

> @@ -177,8 +424,18 @@ static int __vfio_iommu_unmap(int fd, u64 iova, u64 =
size, u32 flags, u64 *unmapp
>  static int vfio_iommu_unmap(struct iommu *iommu, struct dma_region *regi=
on,
>  			    u64 *unmapped)
>  {
> -	return __vfio_iommu_unmap(iommu->container_fd, region->iova,
> -				  region->size, 0, unmapped);
> +	int ret;
> +
> +	ret =3D __vfio_iommu_unmap(iommu->container_fd, region->iova,
> +				 region->size, 0, unmapped);
> +	if (ret)
> +		return ret;
> +#ifdef __powerpc__
> +	if (iommu_is_spapr_tce_v2(iommu))
> +		ret =3D spapr_unregister_memory(iommu, region);
> +#endif
> +
> +	return ret;
>  }

[Severity: Medium]
If __vfio_iommu_unmap() succeeds but spapr_unregister_memory() fails, does
returning this error bypass the region cleanup in __iommu_unmap()?

In __iommu_unmap():

    if (iommu->iommufd)
        ret =3D iommufd_unmap(iommu, region, unmapped);
    else
        ret =3D vfio_iommu_unmap(iommu, region, unmapped);

    if (ret)
        return ret;

    list_del_init(&region->link);

If we return the unregistration failure here, the early return in
__iommu_unmap() skips list_del_init(). Will this leave the successfully
unmapped region in the dma_regions list and corrupt internal state tracking?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703032806.4094=
6-1-nnmlinux@linux.ibm.com?part=3D3

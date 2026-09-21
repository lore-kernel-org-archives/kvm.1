Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470A3AEF46
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974903; cv=none; b=IInnMaKFSFsgiZsQceQXtbtGKWyEciaMd7hnSAJzeg1ts9PwNFXwJjmT1sVz3ThjJ+86tPkPTpvroV6n/u2MdT2/Afj8zsR21s4fD912jo1uHZqmk0XAv+UxSzKBiK/1tVUsK10nyWOW8vQ7GAk2toqkajkq/Po/7FC7yaK1PAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974903; c=relaxed/simple;
	bh=Djvs8CqmlcxDu6wampq2FdQ2ZESJOfD11pZyY9tKEe4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VOamRBueaVZJ6pKuCtZWNb2B96/zPpvAbotPYRTHfSjIVw+pF2rzTGH3z6sS8k/a06NEMiNlo1+WABNnDpI/aPDTAwEu/RNivTcVNWTzj5OPm0p+jdlvZ+qoFEWH+kbUOVVnV0HVYDkCyxD8sXrWXB2Uio44RkbJHdn5pkdjxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6E9bBE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6E9bBE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FAF1F000FF;
	Mon, 21 Sep 2026 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789974901;
	bh=Nhai2uYylWVVU2n040EaB5PMjq0FjZU0m5sXz7LQeRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T6E9bBE61i7UmBPFASxd0o8fq7wida+/9JghjnL0I6WR2NX3Z3j1vikX4M85tiomm
	 jHC/VM4yaevODoVxT6BljiY73qbr/PpC+3dX3ZaQoZw5yCIAiOp+Hxa6xcYBYxBRmZ
	 AV92oPURCo1PHB3KswOx+Q9AuegkuD8A8/xPbnm6eqVPuK0GOuzXlJ7zmnVBwhCH7P
	 R7zCZ8fQdN3lfk2V/gfIVz+kALvPU5HMBVTXrD0kw4MdcFE5twEZOWgJf7PoNKADOR
	 8YqYmZsSK/cxvlRlywYbtWTgqYCMRfBgm8TSLJ7fWu5PGPyYWxFcaWhgDrBcD2OXcy
	 RkQbDG4AuNEzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] iommu: Reserve PCI host bridge MMIO windows in group
 reserved regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 07:15:00 +0000
Message-Id: <20260921071501.62FAF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] iommu: PCI window length truncated to 32-bit on PAE systems
- [Medium] iommu: Reserved regions list sorting and merging invariants brok=
en
- [Medium] iommu: Missed host bridge window reservations in shared IOMMU gr=
oups
--

commit 7e6d6a860340f3d138fa7f3fa2d3327a38aa9b7b
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: Reserve PCI host bridge MMIO windows in group reserved regions

This commit introduces iommu_get_pci_resv_windows() to collect PCI host bri=
dge
MMIO windows as reserved regions. It updates iova_reserve_pci_windows() to =
use
this helper and adds iommu_resv_pci_windows() to reserve these windows at t=
he
group level to prevent IOVA overlaps.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd43..bccb530434629 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
[ ... ]
> @@ -508,18 +509,26 @@ static int iova_reserve_pci_windows(struct pci_dev =
*dev,
>  		struct iova_domain *iovad)
>  {
>  	struct pci_host_bridge *bridge =3D pci_find_host_bridge(dev->bus);
> +	struct iommu_resv_region *region, *next;
>  	struct resource_entry *window;
>  	unsigned long lo, hi;
>  	phys_addr_t start =3D 0, end;
> +	LIST_HEAD(pci_windows);
> +	int ret;
> =20
> -	resource_list_for_each_entry(window, &bridge->windows) {
> -		if (resource_type(window->res) !=3D IORESOURCE_MEM)
> -			continue;
> +	ret =3D iommu_get_pci_resv_windows(dev, &pci_windows);
> =20
> -		lo =3D iova_pfn(iovad, window->res->start - window->offset);
> -		hi =3D iova_pfn(iovad, window->res->end - window->offset);
> -		reserve_iova(iovad, lo, hi);
> +	list_for_each_entry_safe(region, next, &pci_windows, list) {
> +		if (!ret) {
> +			lo =3D iova_pfn(iovad, region->start);
> +			hi =3D iova_pfn(iovad, region->start + region->length - 1);
> +			reserve_iova(iovad, lo, hi);

[Severity: High]
Does this length calculation risk passing inverted or truncated ranges to
reserve_iova()?

If region->length gets truncated in iommu_get_pci_resv_windows(), the
truncated length will be used here to reconstruct the upper bound, which can
result in an underflow. This could insert inverted ranges into the IOVA
rbtree, corrupting its invariants.

> +		}
> +		list_del(&region->list);
> +		kfree(region);
>  	}
> +	if (ret)
> +		return ret;
[ ... ]
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9af..de675ed277535 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> +#ifdef CONFIG_PCI
> +/**
> + * iommu_get_pci_resv_windows - collect PCI host bridge MMIO windows as
> + *                               reserved regions
> + * @dev: PCI device whose host bridge to scan
> + * @head: list head to append iommu_resv_region entries to
> + *
> + * Walks the MMIO windows of @dev's PCI host bridge and creates an
> + * IOMMU_RESV_RESERVED region for each one.  The caller must free the
> + * returned entries with kfree() when done.
> + *
> + * Returns 0 on success, negative errno on failure.
> + */
> +int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *he=
ad)
> +{
> +	struct pci_host_bridge *bridge =3D pci_find_host_bridge(dev->bus);
> +	struct resource_entry *window;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		struct iommu_resv_region *region;
> +		phys_addr_t start;
> +		size_t length;
> +
> +		if (resource_type(window->res) !=3D IORESOURCE_MEM)
> +			continue;
> +
> +		start =3D window->res->start - window->offset;
> +		length =3D window->res->end - window->res->start + 1;

[Severity: High]
Can this truncate the resource size?

On 32-bit systems with PAE/LPAE enabled, resource_size_t is 64-bit while
size_t length is 32-bit. If the MMIO window is >=3D 4GB, the 64-bit size is
implicitly truncated when assigned here.

> +
> +		region =3D iommu_alloc_resv_region(start, length, 0,
> +						 IOMMU_RESV_RESERVED,
> +						 GFP_KERNEL);
> +		if (!region)
> +			return -ENOMEM;
> +
> +		list_add_tail(&region->list, head);

[Severity: Medium]
Does this break the sorting and merging invariants of the reserved regions
list?

Directly appending the newly allocated PCI window regions to the end of the
list bypasses the iommu_insert_resv_region() insertion sort and merge logic.
Consumers like VFIO that expect a normalized list will be fed unsorted,
potentially overlapping address spaces.

> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_get_pci_resv_windows);
> +
> +/*
> + * Reserve PCI host bridge MMIO windows as IOMMU_RESV_RESERVED regions.
> + * This prevents IOVA allocations from overlapping with PCI MMIO address
> + * ranges, which could cause PCIe switches to misroute DMA transactions.
> + *
> + * All PCI devices within the same IOMMU group share the same host bridg=
e,
> + * so we only need to find the first PCI device.
> + *
> + * Caller must hold group->mutex.
> + */
> +static int iommu_resv_pci_windows(struct iommu_group *group,
> +				  struct list_head *head)
> +{
> +	struct group_device *gdev;
> +
> +	for_each_group_device(group, gdev) {
> +		if (!dev_is_pci(gdev->dev))
> +			continue;
> +		return iommu_get_pci_resv_windows(to_pci_dev(gdev->dev),
> +						  head);

[Severity: Medium]
Will this skip subsequent devices that might belong to different host bridg=
es
within the same IOMMU group?

If an IOMMU group contains PCI devices from multiple distinct PCI host
bridges (e.g., on platforms lacking hardware isolation), returning
immediately after finding the first PCI device means the MMIO windows for a=
ll
other bridges remain unprotected.

> +	}
> +	return 0;
> +}
> +#endif /* CONFIG_PCI */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921070234.8977=
36-1-guanghuifeng@linux.alibaba.com?part=3D1

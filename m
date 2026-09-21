Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6098F46F4BB
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 10:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987836; cv=none; b=f6AGi6zawhyR+VvClzdGje5G4SJBeRqexaOGfmTpn0sZyJTNCaTkCt6zb1x/0qHssfLhMheJ8e1VGX5o1ypASe1F1oyIx4gkoQpOM5dx6XheIRzsAPi4xiJm9AfdRYWxsjZfWJ2JUJEmTml6x4eoRWbfyKNUYIaWFWGOjaOUMiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987836; c=relaxed/simple;
	bh=QuuJ9/sMxOMTMYhmI5hgYXWMI9UckjgV27jkD71aqbU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxPGfPITgX41pqysF1KFbwrnuQHER7FZ+RuTar725aSRYv7RGVnfwGxfyEmhxIGKCBH4f9xT9p2pHo/GFqU8c3lpIM65elwu/RJXVFQrSYqbfc0Eb9a0qW2XRUcvnNgy2qSD8zo8FpEr3V5l940vsWOu6AO7D13FcTp03Bf7Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id5GbuZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id5GbuZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88791F000FF;
	Mon, 21 Sep 2026 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789987835;
	bh=u5cVf+XypqaajxUmqk8AJSr82vScSXH2ag069JeTBfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=id5GbuZd6q4Aj0Y9phhB9fdYhqClke7vnVmtQI6lq82+qHgNW1rgU04Z1Ldd7iXC2
	 iaM4TS4EV5KUf7cEfqMu7O4JiP8O91rdLRTGXB6AD4sDGlVL7qtAOStMBLpSubgUJ1
	 GCR3TDPS5/dWRr/NY8Xb6LTJEbqgWe2dcmbsPDQKUuPP6l84w1zfDsroeFrllvz6nX
	 0tTpA822Z2XFJAdQyzh3VBVzWAt24i5IEqt7iRVYHP7UhPNLkYAJTA7UhX8bfkpYGd
	 hWNiWPZYO0oX8xP2X4FzlzhtYm6Kaezcn2G2cZ33p3Gljw/t/NGURPpI2XUzLRYWip
	 JB5eQGbRv9CGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] iommu: Reserve PCI host bridge MMIO windows in
 group reserved regions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260921103922.1113752-2-guanghuifeng@linux.alibaba.com>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:50:34 +0000
Message-Id: <20260921105034.D88791F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mm: 32-bit truncation of PCI MMIO window length causes IOVA reserv=
ation underflow
- [Medium] mm: list_splice_tail breaks sorted invariant of group reserved r=
egions list
--

commit 29a58ada8b8ff270cc47d002ecdfe9863744ad28
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

    iommu: Reserve PCI host bridge MMIO windows in group reserved regions

    The DMA IOVA layer reserves PCI host bridge MMIO windows to prevent
    overlaps. VFIO currently does not receive these via
    iommu_get_group_resv_regions(), allowing userspace to choose conflicting
    IOVA addresses. This introduces a helper to provide these windows as
    reserved regions.

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd43..c97622826d9d9 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c

[ ... ]

> @@ -508,17 +509,23 @@ static int iova_reserve_pci_windows(struct pci_dev =
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
> +	if (ret)
> +		return ret;
> =20
> -		lo =3D iova_pfn(iovad, window->res->start - window->offset);
> -		hi =3D iova_pfn(iovad, window->res->end - window->offset);
> +	list_for_each_entry_safe(region, next, &pci_windows, list) {
> +		lo =3D iova_pfn(iovad, region->start);
> +		hi =3D iova_pfn(iovad, region->start + region->length - 1);

[Severity: High]
Does this calculation result in an incorrect reservation upper bound on 32-=
bit
architectures with 64-bit physical addresses?

Since region->length is populated in iommu_get_pci_resv_windows() where a
64-bit size is assigned to the size_t field tmp.length, it is implicitly
truncated to 32 bits on systems like ARM LPAE or x86 PAE.

If the PCI host bridge MMIO window is >=3D 4GB, the truncated length causes
reserve_iova() to reserve a drastically undersized region, which might fail
to prevent IOVA allocations from overlapping with PCI MMIO ranges.

>  		reserve_iova(iovad, lo, hi);
> +		list_del(&region->list);
> +		kfree(region);
>  	}

[ ... ]

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9af..b77e9818e4a40 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c

[ ... ]

> @@ -945,6 +945,84 @@ iommu_insert_device_resv_regions(struct list_head *d=
ev_resv_regions,
>  	return ret;
>  }
> =20
> +#ifdef CONFIG_PCI
> +/**
> + * iommu_get_pci_resv_windows - collect PCI host bridge MMIO windows as
> + *                               reserved regions

[ ... ]

> +int iommu_get_pci_resv_windows(struct pci_dev *dev, struct list_head *he=
ad)
> +{
> +	struct pci_host_bridge *bridge =3D pci_find_host_bridge(dev->bus);
> +	struct iommu_resv_region *region, *next;
> +	struct resource_entry *window;
> +	LIST_HEAD(resv_windows);
> +	int ret;
> +
> +	resource_list_for_each_entry(window, &bridge->windows) {
> +		struct iommu_resv_region tmp =3D {
> +			.type =3D IOMMU_RESV_RESERVED,
> +		};
> +
> +		if (resource_type(window->res) !=3D IORESOURCE_MEM)
> +			continue;
> +
> +		tmp.start =3D window->res->start - window->offset;
> +		tmp.length =3D window->res->end - window->res->start + 1;

[Severity: High]
Does this assignment implicitly truncate the window length on 32-bit system=
s?

Since window->res->end and window->res->start are 64-bit physical addresses
on architectures like ARM LPAE or x86 PAE, evaluating this difference yields
a 64-bit number. The tmp.length field is of type size_t, which is 32-bit on
these architectures.

Could this silent truncation prevent the reservation of the full bridge
window and potentially lead to PCIe peer-to-peer routing corruption?

> +
> +		ret =3D iommu_insert_resv_region(&tmp, &resv_windows);
> +		if (ret)
> +			goto err_free;
> +	}
> +
> +	list_splice_tail(&resv_windows, head);

[Severity: Medium]
Does list_splice_tail() break the sorted invariant of the group reserved
regions list?

When iommu_resv_pci_windows() is called by iommu_get_group_resv_regions(), =
the
head list may already contain device-level reserved regions (like MSI or RM=
RR).

Since the list is expected to be strictly sorted by start address and merged
for overlaps via iommu_insert_resv_region(), directly appending the PCI
windows to the end of head might leave the list unsorted if PCI MMIO
addresses are lower than existing regions.

Can this cause subsequent insertions to fail merging overlaps properly or
cause consumers like VFIO to encounter unsorted or overlapping regions?

> +	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921103922.1113=
752-1-guanghuifeng@linux.alibaba.com?part=3D1

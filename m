Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633E3E16B0
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503040; cv=none; b=sKpjyAo3qqCN372JZo4H8RErwof5WVx2eQUaS3RiSylRkIBoG87LSIDpWRBNQUmRk5RDHPhKv8oWIwO69MgwxoFPmNKAQc33x7QQOUypO9VpMyWZ390DD2XTb42GzkoABMCX9NtyE1W+hh/sfIkOHKpnYNUbHepwIUWvdCIVIHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503040; c=relaxed/simple;
	bh=Fcosd+GyuGkK62ytfXhhr3k6V8Ss3v+AKqqibpAimK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TynbWPgABZ9i05PKcSuwRXE/1g8xEYJcq9IMWilT9pvMOgwCWhNDSHRmpwst+WDxFmVbkYICk0ysUYy9IcNvu6Znn4I9pCxBYi1s9U1PTwTv9+G8JauauH+UsPvwRw7aUfgCl4FSpQvxy9fv9ZQjFVTtsLPUjY63vv3K1o9+258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+g08ZzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+g08ZzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF2D1F00893;
	Wed,  3 Jun 2026 16:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503038;
	bh=0z8d+ufBlu+8HTyRfqYSFsOIebQDwXtnq1GOYGXsL00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+g08ZzKNoouvX3Gv3k2c0MPoqw4aqYP3g/ZF2mGVXVT/ViXQcEad5JnmzZ+T5L3C
	 EO1Aiob7bs7VgNn+wgO/ZWj7cLaN1M58Ui8N6RPnQU4E7tLZNPke/oXxMR2o0aMbSO
	 aPT5wtK63R13vz8zH6jH17Upbx+SBAVmUs8LVwWxNPRDhnN3EjsjksLlJ77cpwNHEB
	 +KF4AEFV+6NKhTr7mdPRNAaodjVCbcM8g4iSsFBOFktvn9esZntEn5Bv7PO0AjBHqB
	 ZP7yoh5CXQ+Dkgjh4J5bU+7fIUrGi4XHRF6I1kraWpl7SLKkDF69xwOlXm9bdSDL3w
	 x+eGBMEYkCm2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/32] iommu/virtio: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-23-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-23-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:10:37 +0000
Message-Id: <20260603161038.8AF2D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] viommu_iova_to_phys_length incorrectly returns the total mapping s=
pan size instead of the remaining mapped length.
- [High] Calculation of mapped_length wraps around to 0 when a mapping cove=
rs the entire address space.

Pre-existing issues:
- [High] On 32-bit systems with 64-bit DMA addresses, the interval tree nod=
e silently truncates 64-bit IOVAs to 32 bits, leading to mapping collisions=
 and incorrect physical address translations.
--

commit 4bfdcec317099653f8ccbaeac00ce9bc697a92cf
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/virtio: implement iova_to_phys_length
   =20
Implement iova_to_phys_length for virtio IOMMU driver, returning the actual
PTE mapping size.

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -912,10 +912,11 @@ static size_t viommu_unmap_pages(struct iommu_domai=
n *domain, unsigned long iova
[ ... ]
> -static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
> -				       dma_addr_t iova)
> +static phys_addr_t viommu_iova_to_phys_length(struct iommu_domain *domai=
n,
> +					      dma_addr_t iova,
> +					      size_t *mapped_length)
>  {
> -	u64 paddr =3D 0;
> +	u64 paddr =3D PHYS_ADDR_MAX;
>  	unsigned long flags;
>  	struct viommu_mapping *mapping;
>  	struct interval_tree_node *node;
> @@ -926,6 +927,9 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_d=
omain *domain,
>  	if (node) {
>  		mapping =3D container_of(node, struct viommu_mapping, iova);
>  		paddr =3D mapping->paddr + (iova - mapping->iova.start);

[Severity: High]
This isn't a bug introduced by this patch, but on 32-bit systems with 64-bit
DMA addresses, is it possible that interval_tree_node truncates the 64-bit
IOVAs to 32 bits?

Because mapping->iova.start is an unsigned long, mixing the 64-bit iova
input with the truncated 32-bit mapping->iova.start can result in wild
physical address offsets when calculating paddr in
viommu_iova_to_phys_length.

> +		if (mapped_length)
> +			*mapped_length =3D mapping->iova.last -
> +					 mapping->iova.start + 1;

[Severity: High]
Can this logic in viommu_iova_to_phys_length overestimate the remaining
valid contiguous length?

By subtracting mapping->iova.start instead of the passed-in iova offset,
this evaluates to the total size of the mapping block. If a caller requests
translation at an offset within the block, returning the full block size can
cause callers to assume subsequent out-of-bounds physical frames are valid
and mapped.

[Severity: High]
Could this calculation in viommu_iova_to_phys_length also wrap around to 0
when a mapping covers the entire address space?

If the identity mapping has start =3D 0 and last =3D ULONG_MAX, the result =
of
ULONG_MAX - 0 + 1 overflows to 0. Returning a mapped_length of 0 can
trigger kernel warnings or infinite loops in iteration callers.

>  	}
>  	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D22

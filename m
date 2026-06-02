Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5853D34B1
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398911; cv=none; b=Gl92xv6u44ci9LryBnfbT8E+HTPy0W7mGRMr6mfv/oYNLPCVMebcU2lf/c8QpHSIjgjHExRbXOvO8IEpQag8P6E7Z2tpuqyVdiVVJxLh7wYBTFg863imIEp5D1lAVIOtNMUz3r4lgWjrdzNVU0lOyKmT4c3o8aet4vULXZyLYm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398911; c=relaxed/simple;
	bh=CMwlqN8ChML+tgXwKygMnANgvySkiMediPpCWT03Exs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y8TUCnAKOmQNbvQohUxVEEwg8O2cU7B7v2dTPcDbSdNRi4z67w8CnjdMcKdpCo7Tv6830596yqXLi1CbIXdFPG5LOo6kzUcbMcy6ct6sREfI6XXF3ci9GTth3rm1golPP2ZFQjR3MwdbI3e3GRpaO4xuBVNGCY6oWZ5ihrnbrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF+GGOLR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF+GGOLR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020F71F00893;
	Tue,  2 Jun 2026 11:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398909;
	bh=HzucvNNAB+nuBoRKRSWSo//jqnnryw+o87KMBpiUHfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SF+GGOLRsIa/Wq2bqlIogsjJ6o5eQaz/yHpauB1Rfj0dUWjMtMC/EF7VGb3V82xGd
	 mfS1mOWDhZacQOKBdDUsYYpj1VTX6XDKmzmGKfxaHVVH0n+KSTOjf9s+S1Dv7bTOio
	 bOMD1iLm/DNoTJx8rxQKtpT9CVmcv+vruZPE41KL6Yt+o3Y5wQkGMNR0AkcmRXjRNf
	 hG/YZcHe0hOCxHfkYHxRznYbacTKNbwWeCl1+SRgCJBvM0Gu8y5k2pwPhi8YkST3NO
	 lPtc/RQzQ/Au347UOWFonZWH+MoMi62uDNb60DI88cZEa7QDrWAvGM3OAQnPEfLO+Q
	 nrJrenG06vCEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/30] iommu/virtio: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-23-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-23-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:15:08 +0000
Message-Id: <20260602111509.020F71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] viommu_iova_to_phys_length returns the total arbitrary size of=
 the interval tree mapping instead of a valid power-of-two PTE page size, l=
eading to bitwise math errors in callers and out-of-bounds physical memory =
access.
- [High] The mapped_length calculation overflows to 0 for mappings covering=
 the maximum address space.

Pre-existing issues:
- [Critical] Virtio-IOMMU uses standard `interval_tree` which silently trun=
cates 64-bit `dma_addr_t` IOVAs to 32-bit `unsigned long` on 32-bit systems=
 with LPAE.
--

commit aeb0a59bd9dc88bffe77f19f211f3b107da4e089
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/virtio: implement iova_to_phys_length

Implement iova_to_phys_length for virtio IOMMU driver,
returning the actual PTE mapping size.

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f12..c90d02cbbfd0d 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
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
>  	struct viommu_domain *vdomain =3D to_viommu_domain(domain);
> =20
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
>  	node =3D interval_tree_iter_first(&vdomain->mappings, iova, iova);
>  	if (node) {
>  		mapping =3D container_of(node, struct viommu_mapping, iova);
>  		paddr =3D mapping->paddr + (iova - mapping->iova.start);

[Severity: Critical]
This is a pre-existing issue, but does this calculation in
viommu_iova_to_phys_length() suffer from truncation on 32-bit systems
with LPAE?

The standard interval tree node uses unsigned long for its boundaries.
When assigning a 64-bit dma_addr_t to mapping->iova.start on these
architectures, it is silently truncated to 32 bits.

Mixing the 64-bit iova with the truncated 32-bit start in this subtraction
could produce incorrect physical address offsets and corrupt memory.

> +		if (mapped_length)
> +			*mapped_length =3D mapping->iova.last -
> +					 mapping->iova.start + 1;

[Severity: Critical]
Does this return an arbitrary block size instead of a valid power-of-two PTE
page size?

The IOMMU API expects mapped_length to output the PTE page size, which is a
power of two. Since virtio-iommu tracks mappings as coalesced interval tree
nodes, this calculation returns the full block size which is not guaranteed
to be a power of two.

Callers like batch_from_domain() in drivers/iommu/iommufd/pages.c rely on
bitwise arithmetic that assumes a power-of-two size:

	npages =3D (pgsize - (iova & (pgsize - 1)) + page_offset) / PAGE_SIZE;

Passing a non-power-of-two size here calculates an incorrect, larger
remaining length, causing out-of-bounds physical memory accesses.

[Severity: High]
Can this mapped_length calculation overflow and evaluate to zero for mappin=
gs
covering the maximum address space?

If an identity mapping spans the entire available address space,
mapping->iova.last will be ULONG_MAX and mapping->iova.start will be 0.
Adding 1 to this difference causes an integer overflow resulting in 0.

While callers defensively handle a 0 return by falling back to PAGE_SIZE, it
triggers WARN_ON(!pgsize) in downstream callers like vfio_iommu_type1.c and
iommufd, which can panic the kernel if panic_on_warn is set.

>  	}
>  	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D22

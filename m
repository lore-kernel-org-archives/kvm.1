Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271135B636
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504371; cv=none; b=uyRbBNHPK4dEF4J5X2Liam6mKhA2+dAolD6UNt2t19xi07FaGLh8Y/umIomxHPvmxqTp+L9L4ZF7h+2IwYOvxBxYArKW4Ad+1hov1FDV9iMbtPXqn+0kB4ae4AP4mpqhWjyYSvbA7sRjQY7r/1SWkWF5YVpS/7/zu9bWvwDHtls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504371; c=relaxed/simple;
	bh=961XiAwkm07baSsdII83TzUH+FPJOeDf854xxnCEJhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qmiuCzZSu6N0jsH74voCmwql7381eFSVJYbZj89XtrLt6BAkzYnWjetOGjNSGLFXnNPont0HvpMph5c5WrY6A5QzMZqqJxVK7mxQxEIv93+M9g6xkQ575ROMqc55tTxvC7g6IDYhmZYvzY7Qx3E+U0p6oOax9EvkiBTnoXqqU/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRk9KI+I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRk9KI+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A2A1F00898;
	Wed,  3 Jun 2026 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780504370;
	bh=ZKPGLUdtKovmRFmBlWLazXjnGCIv3ZdM0+fFpkA7Qu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRk9KI+IxZaG+vzsWcTKnYhbVte/0E8ZYLA0/0kkBdviwA2iiJrY0bJNWiQfU/zZS
	 Zd0Hd0HcgFWvHuCNEPTHxa5ELteJlJw6jxwDYUa0RwCeFrKz2ipmk6l6URPJixtCAH
	 CtbwJ3whmP9Nvg5NxyjJLpCJH4+wxS0xmK+OhJ6eD6x/tbtHYBa14v1A5GpIarO/sd
	 aosZIOOFYbNQEfJX3pRcld1/FAsUEGYIAKbQUepA5e0Wr/nMeYjExk3UFyCvFLnfjT
	 MHmdkiezebwqsKjYFVGAdyN7dA/S/UBNegKeLQ1Y0jZ+TzXC0t4Fz7K3aM9rkqreIA
	 iJ5y89jFdHQVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 29/32] iommu/io-pgtable-arm: remove deprecated
 iova_to_phys wrapper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-30-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-30-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:32:49 +0000
Message-Id: <20260603163250.16A2A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The S1 fallback path in `arm_smmu_iova_to_phys_length()` fails=
 to populate the `mapped_length` parameter, leading to uninitialized variab=
le usage in caller loops (e.g., VFIO and iommufd) and massive page refcount=
 corruption.
--

commit a0705b9a6f111fb1cda1da70c89bd7254ec4c5db
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

    iommu/io-pgtable-arm: remove deprecated iova_to_phys wrapper

Remove the iova_to_phys wrapper function and .iova_to_phys assignment
from ARM LPAE io-pgtable, as all callers now use iova_to_phys_length.

While reviewing the caller migrations and the new iova_to_phys_length
interface finalized by this patch, I noticed a critical issue introduced
in the underlying driver implementations and their callers.

[ ... ]

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1384,20 +1384,21 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(str=
uct iommu_domain *domain,
>  	return addr;
>  }
> =20
> -static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> -					dma_addr_t iova)
> +static phys_addr_t arm_smmu_iova_to_phys_length(struct iommu_domain *dom=
ain,
> +					dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>  	struct io_pgtable_ops *ops =3D smmu_domain->pgtbl_ops;
> =20
> +
>  	if (!ops)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS &&
>  			smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1)
>  		return arm_smmu_iova_to_phys_hard(domain, iova);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
Does this fallback path leave mapped_length uninitialized?

If the SMMU domain has ARM_SMMU_FEAT_TRANS_OPS and uses stage 1 translation,
we return directly from arm_smmu_iova_to_phys_hard() without populating the
mapped_length parameter. This leaves the caller's stack variable completely
uninitialized.

> =20
> -	return ops->iova_to_phys(ops, iova);
> +	return ops->iova_to_phys_length(ops, iova, mapped_length);
>  }

[ ... ]

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1177,25 +1177,42 @@ static long vfio_unmap_unpin(struct vfio_iommu *i=
ommu, struct vfio_dma *dma,
> =20
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova =3D dma->iova + pos;
> =20
> -		phys =3D iommu_iova_to_phys(domain->domain, iova);
> -		if (WARN_ON(!phys)) {
> +		/* Single page table walk returns both phys and PTE size */
> +		phys =3D iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
> +		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX)) {
>  			pos +=3D PAGE_SIZE;
>  			continue;
>  		}
> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize =3D PAGE_SIZE;
> =20
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * mapped_length already accounts for contiguous entries
> +		 * from iova, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len =3D PAGE_SIZE; pos + len < dma->size; len +=3D PAGE_SIZE) {
> -			next =3D iommu_iova_to_phys(domain->domain, iova + len);
> +		len =3D min_t(size_t, pgsize, dma->size - pos);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
If mapped_length (returned here as pgsize) remains uninitialized from the
SMMU S1 fallback, couldn't this cause massive page refcount corruption?

If pgsize contains a large uninitialized value, the loop logic would assume=
 a
huge contiguous block of physical memory starting from the first translation
result.

When vfio_unpin_pages_remote() sequentially unpins this block, it could
corrupt the page refcounts of random host memory pages that were never
actually pinned or part of this DMA region, potentially leading to
use-after-free or host kernel panics triggered simply by untrusted
userspace.

[ ... ]

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -445,11 +470,36 @@ static struct page **raw_pages_from_domain(struct i=
ommu_domain *domain,
>  	if (start_index =3D=3D iopt_area_index(area))
>  		page_offset =3D area->page_offset;
>  	while (start_index <=3D last_index) {
> -		phys =3D iommu_iova_to_phys(domain, iova) - page_offset;
> -		*(out_pages++) =3D pfn_to_page(PHYS_PFN(phys));
> -		iova +=3D PAGE_SIZE - page_offset;
> +		size_t pgsize;
> +		unsigned long npages;
> +		unsigned long i;
> +
> +		/*
> +		 * Resolve the contiguous mapped length together with the
> +		 * physical address so we can fill multiple struct page
> +		 * pointers per page table walk when the IOMMU uses large
> +		 * pages. Query at page-aligned iova so pgsize covers from
> +		 * page start.
> +		 */
> +		phys =3D iommu_iova_to_phys_length(domain, iova - page_offset,
> +						  &pgsize);
> +		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX))
> +			break;
> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize =3D PAGE_SIZE;
> +
> +		npages =3D pgsize / PAGE_SIZE;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Critical]
Could this uninitialized pgsize value cause iommufd to expose arbitrary
physical pages?

Similar to the VFIO case, if pgsize is uninitialized, npages will be
calculated incorrectly. This treats multiple potentially non-contiguous
physical pages as contiguous and exposes them directly.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D29

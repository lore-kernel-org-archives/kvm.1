Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549439A80E
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501886; cv=none; b=S8Z1Mf8mcEQ/7mKVP5/BEkwgWayXQ4Wf+WSdStY7EP6I/9vP9nN7viHtT8QzXuiEQn9pqnwZPrPYfRLAW6cVY9SA5smIHnkgadIpThO9GJcxExWlmt1xxf+hfLTUCZBzAXid9XPcTFulFd2ZLBpAtPIfVr/EIuwmzwismKU4E8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501886; c=relaxed/simple;
	bh=BOmuCTath4yyF680aCkvU1O+1qIPp9pIPl7hdvKf3Sc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=silWVYW0BkOgWt2wD7E1+Xx7Pt8rS2W7vRt5J9xnNkWzLJLgODcPPZZeJB9hSbJwu70Edr0SVSzJxlhC5zbnxk8dHpt79aYdVTsTkb971js6ZoMOjlhS3dAnL7VXR8j+rYWAW3FL48SSsKwOxqMR0BYBGMzxBp3laO14UaRu53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReC0I0ii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReC0I0ii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 378E41F00898;
	Wed,  3 Jun 2026 15:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501885;
	bh=H3k11sPPqpiMCz51LEr+WSCWroAO+BVXqOlQ1+/AZNc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ReC0I0iiCP6NnwMvYx4Ki7kP+l9eGaLFxDka1Nowtj/z+NQvCLnwqZvLoowNxP4UI
	 UZ91zMFJAL4Szf3TMF8RSJkKU36hsKGq+Br2SvpTLnynJk9P1d6vsHhncvH3Oj2d7d
	 lVFA7EkNmaSkvFmOcCfAOw2c8tqkRlI1kHiesRnmTupRu8HRG7KUyAYEXIOABSY9Y4
	 ODGyvahmmtkluHZwTrDHF+lbWSj9mOCQh9BDOXx45N3Lq7WQ/G/A8hVIADcIopy8i8
	 FhJsi0yrosjrBKwBVOnCSmkhUbrljB8TGVcYr2YKZhpyCU7wG3hmCTKiRyL7B0hTL2
	 Goi2KLoHLNLNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/32] iommu/msm: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-15-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-15-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:51:24 +0000
Message-Id: <20260603155125.378E41F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] When `__enable_clocks()` fails, its negative error code is incorre=
ctly returned cast to `phys_addr_t` instead of `PHYS_ADDR_MAX`.
- [High] Unsafe `list_first_entry()` on a potentially empty list leads to o=
ut-of-bounds memory accesses.
- [High] Concurrent traversal and modification of `priv->list_attached` wit=
hout adequate common locking.
--

commit 48fb553fe9efe8fd4fc6286128070ec03e449c35
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/msm: implement iova_to_phys_length

Implement iova_to_phys_length for MSM IOMMU driver, returning the actual
PTE mapping size.

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0ad5ff431d5b6..1038e8141223f 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -523,15 +523,16 @@ static size_t msm_iommu_unmap(struct iommu_domain *=
domain, unsigned long iova,
>  	return ret;
>  }
> =20
> -static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
> -					  dma_addr_t va)
> +static phys_addr_t msm_iommu_iova_to_phys_length(struct iommu_domain *do=
main,
> +						 dma_addr_t va,
> +						 size_t *mapped_length)
>  {
>  	struct msm_priv *priv;
>  	struct msm_iommu_dev *iommu;
>  	struct msm_iommu_ctx_dev *master;
>  	unsigned int par;
>  	unsigned long flags;
> -	phys_addr_t ret =3D 0;
> +	phys_addr_t ret =3D PHYS_ADDR_MAX;

[Severity: High]
This isn't a bug introduced by this patch, but if
msm_iommu_iova_to_phys_length() is called on an IOMMU domain before any
devices are attached, priv->list_attached would be empty. In that case,
does list_first_entry() calculate an invalid pointer?

If so, would dereferencing this pointer in the subsequent
list_empty(&iommu->ctx_list) and __enable_clocks(iommu) calls lead to
out-of-bounds memory accesses?

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but when __enable_clocks() fails, it returns a negative integer
error code. Since ret is initialized to PHYS_ADDR_MAX but gets overwritten
shortly after:

msm_iommu_iova_to_phys_length() {
        ...
        ret =3D __enable_clocks(iommu);
        if (ret)
                goto fail;
        ...

Could this negative error code be incorrectly cast to phys_addr_t and
returned on the failure path instead of PHYS_ADDR_MAX?

[Severity: High]
This isn't a bug introduced by this patch, but is there a risk of
concurrent modification and traversal of priv->list_attached?

It looks like msm_iommu_attach_dev() modifies the list using list_add()
while holding only the msm_iommu_lock spinlock. However,
msm_iommu_sync_map() traverses this same list locklessly by calling
__flush_iotlb_range() without taking any locks, and msm_iommu_unmap()
traverses it holding only priv->pgtlock. Can this lack of synchronization
lead to list corruption?

>  	spin_lock_irqsave(&msm_iommu_lock, flags);
> =20

[ ... ]

> @@ -558,13 +559,19 @@ static phys_addr_t msm_iommu_iova_to_phys(struct io=
mmu_domain *domain,
>  	par =3D GET_PAR(iommu->base, master->num);
> =20
>  	/* We are dealing with a supersection */
> -	if (GET_NOFAULT_SS(iommu->base, master->num))
> +	if (GET_NOFAULT_SS(iommu->base, master->num)) {
>  		ret =3D (par & 0xFF000000) | (va & 0x00FFFFFF);
> -	else	/* Upper 20 bits from PAR, lower 12 from VA */
> +		if (mapped_length)
> +			*mapped_length =3D SZ_16M;
> +	} else {
> +		/* Upper 20 bits from PAR, lower 12 from VA */
>  		ret =3D (par & 0xFFFFF000) | (va & 0x00000FFF);
> +		if (mapped_length)
> +			*mapped_length =3D SZ_4K;
> +	}
> =20
>  	if (GET_FAULT(iommu->base, master->num))
> -		ret =3D 0;
> +		ret =3D PHYS_ADDR_MAX;
> =20
>  	__disable_clocks(iommu);
>  fail:

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D14

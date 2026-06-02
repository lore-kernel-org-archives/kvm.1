Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A21306D3F
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398654; cv=none; b=M7xEETvch+KY+6cUCap91TV+yrUdBqAXjHQgmGTlSHkE8aP/f0MMXjQ2nEIFQQpFH8Yo5YWD2ut54A0/I8c9ailhsBFf3PO6eXM5jdn5BMyKKV0mGpPJGgT8qgsOncansXYJZKbe/HYvCPjfiaokfwiUM+mP3tS190kLO5fI1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398654; c=relaxed/simple;
	bh=DPET6dMkgnaYZG70hP9jstJ12Sb9FqMRV5cmVFf+3jw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u9Q3nqdARErKl3EU/HKBRI9BvDXtL9C+bD2K5HA6hxN308Cv310iE7uQWJs1Cfj4uKwkn/6sLzjSIA7mSK1+Fe615J60isDo2SfjXI7hAmJ4g8tIQyuAOYiVqscC4cyuDqNlWtwyXibg8j9wzfWOI3ulvutMCc3hQgFIMZ704d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KD6JnWCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KD6JnWCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA271F00893;
	Tue,  2 Jun 2026 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398651;
	bh=+r7V0zXcEGAmwgRsGtRuYUEaRfWZbQBItGd+wEEQRpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KD6JnWCmzwvM6QEujj+fmCOusd1qjzxLCU3OXnn5Db3XgT3gnkWkPj4Dl5Pv91d4J
	 xW9+zMCE/MP+O7iBpwEj/q94wzrgoigqGQgLARbs1ZtnZWnOOjD4CcAm+6LKrFbwoq
	 5hyA4NUrbJ2FMkU7K2Jml9ODtA1ozPwLa65CZ2f4ZaJ8zlVEBQ8/6CPka8u88B9EJD
	 wmIAI0tF6FBl8O75+2GhVur9hWQTz/wON1uBuR56pipPB2oKWnoWYGKDhmYSOCkW4N
	 imoEJHkEPvlZ2u81Br95FIMd6UeF50PkaTX1tfTAVwhGccvJWzOELZ13bVo60cp1bd
	 vBv22TXyNFSug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/30] iommu/tegra-smmu: implement
 iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-22-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-22-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:10:50 +0000
Message-Id: <20260602111051.0DA271F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless traversal in `tegra_smmu_iova_to_phys_length` can cause a=
 use-after-free on page table memory and a TOCTOU race on the PTE value.
--

commit 681b9a6734c92cb4ecc9cde9011c68a58a0d83fd
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/tegra-smmu: implement iova_to_phys_length

This commit implements iova_to_phys_length for the Tegra SMMU IOMMU driver,
returning the actual PTE mapping size.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c

[ ... ]

> @@ -803,20 +803,26 @@ static size_t tegra_smmu_unmap(struct iommu_domain =
*domain, unsigned long iova,
> -static phys_addr_t tegra_smmu_iova_to_phys(struct iommu_domain *domain,
> -					   dma_addr_t iova)
> +static phys_addr_t tegra_smmu_iova_to_phys_length(struct iommu_domain *d=
omain,
> +					   dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct tegra_smmu_as *as =3D to_smmu_as(domain);
>  	unsigned long pfn;
>  	dma_addr_t pte_dma;
>  	u32 *pte;
> =20
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	pte =3D tegra_smmu_pte_lookup(as, iova, &pte_dma);
>  	if (!pte || !*pte)
> -		return 0;
> +		return PHYS_ADDR_MAX;

[Severity: High]
This is a pre-existing issue, but does this lockless traversal risk a
use-after-free on the page table memory?

Unlike tegra_smmu_map() and tegra_smmu_unmap(), this function looks up the
page table and reads the PTE locklessly. If a concurrent unmap operation
removes the last IOVA in a page directory, tegra_smmu_pte_put_use() will
synchronously free the page table:

tegra_smmu_unmap()
  __tegra_smmu_unmap()
    tegra_smmu_set_pte()
      tegra_smmu_pte_put_use() {
        ...
        iommu_free_pages(pt);
        as->pts[pde] =3D NULL;
      }

If this runs concurrently on an unmapped IOVA within the same directory,
could tegra_smmu_pte_lookup() return a pointer to freed memory, leading
to a crash when evaluating !*pte?

Additionally, is there a time-of-check to time-of-use race here? The pointer
*pte is evaluated twice without READ_ONCE(). If an unmap happens between
the check (!*pte) and the assignment:

>  	pfn =3D *pte & as->smmu->pfn_mask;

Could *pte become 0 during the second read, causing the function to silently
return a physical address of 0 instead of PHYS_ADDR_MAX?

> +	if (mapped_length)
> +		*mapped_length =3D SZ_4K;
> +
>  	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D21

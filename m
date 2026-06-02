Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4413D3CE5
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398736; cv=none; b=t16q8PCyg/j4ZKKdfFAl4ONOvR3kbf3MJY9RHgAFh0qlZR/Bq/Cpxgr+pNmQzWdigF9J9yxKgQ4mv0kMsNDGuiXutd265ZhglRu91REsKRAJVJKTh1tcA7qSRaS3SEFdvU0zvO3YcIMY2do5mBivHXgg2eHXD0gtYnsYkmIg6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398736; c=relaxed/simple;
	bh=4ZuTD/9R9tNxA+bYVRBCvs60Kl6yHPnV/yX0LF1vfWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6ZXaIiiVHwcP8VP1RPbT1FyqYRHiKy+V5AsJX2Fo4fO7ecB6qIZSRR5PH0+kC/7xAa2Reh9iQ1v8QLd5PRRgF1dSFD02tQjQZ/hTPVQ/LicfamSnuyxJ5bk6fp5oAH+Kk9QWdZEEI5yTe/1sqRESc9Fo+UhtKKoCYgsB1g+qJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZplr/vK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZplr/vK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317C21F00893;
	Tue,  2 Jun 2026 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398733;
	bh=NgSrb9IasZ4CmQH/qNMktXkhIgCUTZecNltE4j6sKeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eZplr/vKjnEyRk/joD2KkGn/nFwXndGGjkCriC2Bfde8RtH9BcZFa12v9jMCspP4s
	 sdDcvZ013h0VR9SL2Mfelq4bVzBUkXOpBpsnzbZ8BWvRwg7KngwLeGSFeJo7mHMCVd
	 E+oxDrI6w/BaxkiFAK9uvCPjKG32CVRJ7xcxOEEc9fUuXoTSja9+4TEHGOhrP4zYc7
	 7KrLSYuld9zUq4eie2yRqXfixJnNsVVLGGTVbk7EEZLBcerLZGPuAH1GIZEqTqBZud
	 pB2yRFchAEC4zH+c1G5lcIqRMMybBNT4sDJ53tQSAbxQuSiGjTrb1SdUGTLnlDu6ly
	 aHukcDbwbDJVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/30] iommu/mtk_v1: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-16-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-16-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:12:12 +0000
Message-Id: <20260602111213.317C21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Valid PTE mappings to physical address 0 are incorrectly treated a=
s unmapped.
--

commit 8a65585ea3e0470504b1a4dc830dd977b11466cf
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/mtk_v1: implement iova_to_phys_length
   =20
This commit implements the iova_to_phys_length callback for the MediaTek
v1 IOMMU driver to return the actual PTE mapping size. It also fixes a
bug by adding the page offset to the physical address.

> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
[ ... ]
> -static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain=
, dma_addr_t iova)
> +static phys_addr_t mtk_iommu_v1_iova_to_phys_length(struct iommu_domain =
*domain,
> +						    dma_addr_t iova,
> +						    size_t *mapped_length)
>  {
>  	struct mtk_iommu_v1_domain *dom =3D to_mtk_domain(domain);
>  	unsigned long flags;
>  	phys_addr_t pa;
> =20
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	spin_lock_irqsave(&dom->pgtlock, flags);
>  	pa =3D *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));
>  	pa =3D pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));
>  	spin_unlock_irqrestore(&dom->pgtlock, flags);
> =20
> +	if (!pa)
> +		return PHYS_ADDR_MAX;

[Severity: High]
Does this incorrectly treat a valid mapping at physical address 0 as
unmapped?

If the hardware PTE points to physical address 0x0, the raw PTE contains
valid flags, but the masking operation isolates just the physical address:

    pa =3D pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));

This results in pa evaluating to 0. The subsequent if (!pa) check will
then evaluate to true, returning PHYS_ADDR_MAX and leaving mapped_length
as 0.

Should this code check the valid bit on the raw PTE before applying the
physical address mask to determine if the page is mapped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D15

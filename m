Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21713DD513
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502245; cv=none; b=JqerKRPvzHpMFnCKsaKOvajdjmR8hYxZYBjwks1hUUQSB+Wgl7RBBc1Oa6bU19zXsHEQmEtbEG793001N5yqUp/E/RgqK24p3Rm9BvU2HqlOVOqsl62fuxYnt6Ed9W9GvUpa9TEKA70b+8P/0vZ3A9ntSHJdupjcDAicoca+e24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502245; c=relaxed/simple;
	bh=9NohqWEYvQjAPlZAgywLBr0OhdYuK2WMtzxDCeN70hs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TFAc8aQkhizVViqpBRFRJ6MsSjdL1hw3HQB4FFf37cT0bfHDWsEOdoSw+Ej9PDpaHXSibXtGdMVcFvC2b5q8ajrRQfSkVVC//oGOyDNWWinhVQ4LgoVNfqW3gvQXK0EgAr0XXeB56YDbGT28KLjVJxFeKCmBTd3c012zgI046po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A54Lv9aT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A54Lv9aT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FE41F00893;
	Wed,  3 Jun 2026 15:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502242;
	bh=9thv9+e+/wKUYq4QYzyjWZBvYOIVwuV/TCpm5Bpt4j4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A54Lv9aTJtQFqLG94LRVBUT67mfSpeu/wznLzuKQKNQicuHzX1GxIkaYW+0DTDOlD
	 UWZqTQRNF8122Ot0rjRKhrzEFWGSrd1JyuWt4cucLfbMXAVXfC+JS5EKZzGrML9eqE
	 oYp8i33B5ORSh7r3aHCNIq7EnutgbHQBGguk4lNXjvQg6GKbadSvl4eWK4Eh2/3Y0F
	 m1fHTo8bZCn+6boi5PGA+Dw8Qmzor+NOY2gT2koE4x9CZAItmM57WYXiw7HCSvLEfc
	 V5bRoBbMrq2IWhk+0lhMpIGwWa+C8q3G3hbalGeCmGf+nW+Dat6elXUno1KYxENoeS
	 ddVfFsclJSPPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/32] iommu/sprd: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-20-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-20-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:57:22 +0000
Message-Id: <20260603155722.80FE41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unchecked dereference of lazily-allocated `dom->pgt_va` when calle=
d on an unattached domain.
- [High] Missing memory barrier before IOMMU TLB invalidate allows the hard=
ware to fetch stale page table entries.
- [High] Physical addresses above 4GB are silently truncated before being m=
apped into the IOMMU page table.
--

commit 5443e99a8531bdfb126ef548ec91ab715067b91b
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/sprd: implement iova_to_phys_length

Implement iova_to_phys_length for Spreadtrum IOMMU driver,
returning the actual PTE mapping size.

> diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> index c1a34445d244f..3c04ec040d96e 100644
> --- a/drivers/iommu/sprd-iommu.c
> +++ b/drivers/iommu/sprd-iommu.c

[ ... ]

> @@ -376,13 +377,19 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct i=
ommu_domain *domain,
>  	unsigned long end =3D domain->geometry.aperture_end;
> =20
>  	if (WARN_ON(iova < start || iova > end))
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	spin_lock_irqsave(&dom->pgtlock, flags);
>  	pa =3D *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));

[Severity: High]
This isn't a bug introduced by this patch, but could this lead to a NULL
pointer dereference if called on an unattached domain?

Since dom->pgt_va is lazily allocated during sprd_iommu_attach_device(),
dom->pgt_va will be NULL if the IOMMU API queries the mapping on an unattac=
hed
domain (such as via a debug interface or an error recovery path).

> -	pa =3D (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PA=
GE_SIZE - 1));
>  	spin_unlock_irqrestore(&dom->pgtlock, flags);
> =20
> +	if (!pa)
> +		return PHYS_ADDR_MAX;
> +
> +	pa =3D (pa << SPRD_IOMMU_PAGE_SHIFT) + ((iova - start) & (SPRD_IOMMU_PA=
GE_SIZE - 1));
> +	if (mapped_length)
> +		*mapped_length =3D SPRD_IOMMU_PAGE_SIZE;
> +
>  	return pa;
>  }

I also noticed a few other pre-existing issues in this file:

[Severity: High]
This is a pre-existing issue, but is there a missing memory barrier before =
the
IOMMU TLB invalidate in sprd_iommu_sync_map()?

drivers/iommu/sprd-iommu.c:sprd_iommu_sync_map() {
    ...
	/* clear IOMMU TLB buffer after page table updated */
	sprd_iommu_write(dom->sdev, reg, 0xffffffff);
	return 0;
}

Because sprd_iommu_write() uses writel_relaxed(), it omits the write memory
barrier. Since the CPU updates the page table entries using standard memory
writes in sprd_iommu_map(), there is no memory barrier (wmb() or dma_wmb())
ordering these memory writes before the MMIO register write.

Could the CPU reorder the MMIO write before the page table writes are globa=
lly
visible, causing the IOMMU device to fetch stale PTEs?


[Severity: High]
This is a pre-existing issue, but does sprd_iommu_map() silently truncate
physical addresses above 4GB?

drivers/iommu/sprd-iommu.c:sprd_iommu_map() {
    ...
	u32 pabase =3D (u32)paddr;
    ...
}

The 64-bit phys_addr_t paddr is explicitly cast to a 32-bit integer before
computing the Page Frame Number (PFN), discarding the upper 32 bits.

If the target memory resides above the 4GB boundary, wouldn't the IOMMU be
programmed to map the device DMA to an incorrect lower physical memory addr=
ess?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D19

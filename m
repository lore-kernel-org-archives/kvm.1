Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BF3D904B
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502036; cv=none; b=Kgg1RdSmvF3oz++vm8BS/BfSlI7RBeKgzkHHDg8d+MNah5em5ZEf/mAEvyl1GvbYdAbzsNYfS41JN83H9yle5vGon1oCU1PRLp6iEXCoYoU2TneIMz48k+05egVNardrPNGz7Br5/O/aWqUhcKUfMtIb/OwbwH6fh4sKvFKW1xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502036; c=relaxed/simple;
	bh=Jfar/fLSNF8JdqTn9J9FfliuRGYAyoCfupU0iptmkvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vy93yMGFkqNzO/3BSPP+FY+r2kDRx/R/somV0XpA7sr2fgPkUEYftxqaP5E0tFuIzHna6AWC0+5TWHgHFWajUl5Ar4QSV6B+xFdCVXwTfv+XhtHbsLN4BeI/zlxL19xiCeL74GAK8UPkUioe2sYdLSHBUoXyUayK16LIpDM34lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY5JJoPH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY5JJoPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4A61F00893;
	Wed,  3 Jun 2026 15:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502035;
	bh=yX2rey6Fkz6RzzgSwmQ5KHvfouKdeY7tZALoPKXxu1M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SY5JJoPHtw0uHXngQYaib1nruxT6nWnuCUdK6+2oMp0NJ4sCaHblgq5kB/hul1hbz
	 WJGGXddPGBjxhWMewOAUSyF7zflHBOnBwaEPJu2aYruGo4bd3WEENWXBSAf6Kq8xO8
	 t71THTCCwu46j04WlBs0tcJsztAmjnJBvheYDLQUnaR/8MlcpGoXzExyZGEN0xfhL4
	 /F7wOSkKbRd1pDDAmbkx0pJqOIt7jaNitZV8GN+D/fTOGuw3EmmcVdVaKPYLnJ9UrR
	 7RWOJj0V9AMHt+NtftzVrNPtotOylIR1qGLAir4K0vimyu4QIv5U1nWxGk5GtgXVnr
	 bPXkIfl5+Ozrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/32] iommu/rockchip: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-18-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-18-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:53:54 +0000
Message-Id: <20260603155355.2C4A61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver incorrectly passes a DMA address to phys_to_virt() to a=
ccess and free page tables, causing severe memory corruption and memory lea=
ks if SWIOTLB or an IOMMU translates the mapping.
--

commit 0aedb97879160a60d3200236cd038dfd8a203524
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/rockchip: implement iova_to_phys_length

Implement iova_to_phys_length for Rockchip IOMMU driver,
returning the actual PTE mapping size.

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 87ae036d64145..94ee300983aee 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -650,12 +650,12 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_=
id)
>  	return ret;
>  }
> =20
> -static phys_addr_t rk_iommu_iova_to_phys(struct iommu_domain *domain,
> -					 dma_addr_t iova)
> +static phys_addr_t rk_iommu_iova_to_phys_length(struct iommu_domain *dom=
ain,
> +					 dma_addr_t iova, size_t *mapped_length)
>  {

[Severity: High]
This is a pre-existing issue, but does this function incorrectly pass a DMA
address to phys_to_virt()?

In rk_iommu_iova_to_phys_length(), we have this sequence:

	pt_phys =3D rk_ops->pt_address(dte);
	page_table =3D (u32 *)phys_to_virt(pt_phys);

Since the page tables are mapped via dma_map_single() and the DTE stores a
dma_addr_t, pt_phys holds a DMA address rather than a physical address.

If dma_map_single() uses a SWIOTLB bounce buffer or returns a translated
address, phys_to_virt() will yield an invalid pointer, potentially causing
memory corruption when dereferenced. This same pattern also appears in
rk_dte_get_page_table() and rk_iommu_domain_free().

>  	struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
>  	unsigned long flags;
> -	phys_addr_t pt_phys, phys =3D 0;
> +	phys_addr_t pt_phys, phys =3D PHYS_ADDR_MAX;
>  	u32 dte, pte;
>  	u32 *page_table;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D17

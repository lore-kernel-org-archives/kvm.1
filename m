Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5209391855
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398190; cv=none; b=qTGELk1l080NEmBbSulqF5bPC6cznNYEff9NRnW/LJKb2pR6WJ2C5ppJasyjI/gOET8xUgRMOLcGVCeW0Gq1o8Fwu9UAuGi0ETENAiUJ7Se/oKlDqkVDWXmTbRujhiP5Zc5aUrhajv4AxLicz9USinat8zemxuvEAAyc2082GeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398190; c=relaxed/simple;
	bh=pHcPv7W9UYIQVAgfWRA2hx2i1613IanbCpr66nBD1zs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jW1rcmbp124ROncvlkcTatwXNW+CttDRINtn85u+w6l/eH1I8XOW+qclGzC3tbl3G5I54F6lrWXcvnNQ92P6dzRh8HpKEy2OuwU7SWzrkk1/RCRRlHZHeer7aITv5VjYSP0VHdKHnaYoJLTBigTlMpsWPiwt/b/yC0D9IObFv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNrNNdXq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNrNNdXq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA8C1F0089A;
	Tue,  2 Jun 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398184;
	bh=sKuxZwSKXn2EBaPjlJyp5TGGdtmlpXA2plL2glgQ818=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNrNNdXqDXRlbPym98LNzDzhu3RNTz7dAHyMGLJMtDocV+K6ejphxwCNXkgmyI0z+
	 eW1Lcvi0bdhC3wMmwDmc1NWKOLUbquRXEFpr+vw5Wi4O7UG/p6f7To/rD6zg1YoyeK
	 7cw+eri2ISbbvYQ8kAXPq82taBnO7saaYIWoFpbzSS056PglRQLQprMZHvEI38RTO/
	 ey8/e4baPQf4iqjQSyA8wbSbeLwC4gEsx2c4HV87iap2qO9xS2O2IYeYz0SyUjW+ji
	 liPPrBuOEdFOSvmrB0Mo89PDkwZtX3OjMpodo5TcUpwBdNmtTxAELuB2153WLmscuZ
	 W6KK5W1B4Am6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 17/30] iommu/rockchip: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-18-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-18-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:03:03 +0000
Message-Id: <20260602110304.0AA8C1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver incorrectly uses `phys_to_virt()` on a DMA address extr=
acted from a page table entry, violating the DMA API.
--

commit d6c5c4bdd4cf407e0f8273e72add45053bb73b63
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/rockchip: implement iova_to_phys_length
   =20
Implement iova_to_phys_length for Rockchip IOMMU driver, returning the
actual PTE mapping size.

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 0013cf196c573..5bae28a123c1d 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -648,15 +648,18 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_=
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
>  	struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
>  	unsigned long flags;
> -	phys_addr_t pt_phys, phys =3D 0;
> +	phys_addr_t pt_phys, phys =3D PHYS_ADDR_MAX;
>  	u32 dte, pte;
>  	u32 *page_table;
> =20
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	spin_lock_irqsave(&rk_domain->dt_lock, flags);
> =20
>  	dte =3D rk_domain->dt[rk_iova_dte_index(iova)];

[Severity: High]
This is a pre-existing issue, but does this function pass a dma_addr_t to
phys_to_virt()?

When extracting the level 1 page table address via rk_ops->pt_address(dte)
just below this line, the returned value is a dma_addr_t, not a physical
address.

If the code continues with:

	pt_phys =3D rk_ops->pt_address(dte);
	page_table =3D (u32 *)phys_to_virt(pt_phys);

Could this result in an invalid kernel virtual address if the system uses
bounce buffers or if the chip uses a dma offset?

Dereferencing this virtual address on the next line when accessing the page
table could lead to a panic or silent memory corruption.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D17

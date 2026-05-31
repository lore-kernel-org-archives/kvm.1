Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4273030C366
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780223579; cv=none; b=Vg/wWK1gm88iLPVjed+AIj0a7ubKQpl0gbEywOHW2O1M9BMQeFeA3i5hxZ5HAzGZlg5QoVA59xyBDXRY+LnZIwxqIBezBBgrQ6zeCe148trKuoqVGLhrhWIK8Nl/GohsGIsGU+rFWVBY2jJJv6z1HRX/+yyRxdZwRDSre4qyNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780223579; c=relaxed/simple;
	bh=Fdyt1C6X6KGKrxzGQys5CuWgjA9wOEjrjptws5fLvzM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HJ9bTXnQ+/u8Ms2WxvuRj5OysaTgk4OPM9ZNUmb660gFUYwcigdEDpzXxMeugX3lCko496WvbiiL2QkFIstjWRKv6GYpC0oX+fcnN1kAjv7k9QxHSKez5WChRpO7GZ1OaMLsM+6Ps03OR5Dh64CDYJTGc36FRTrLWM1B/KTk4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTC7dKAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTC7dKAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B920C1F00893;
	Sun, 31 May 2026 10:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780223577;
	bh=5fhAZUY+uZJ9Y8O6uQ1L4chTQ1MU7QCyjC/LTvajk3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NTC7dKAsxJb2ErLUrbm2/yNMCjrT6fdAbhXbMQMFkzhTFOs7QzgdHEt20ZS2zsBkJ
	 6BOFy4wUcBDdNvtRAaUwBgEr628hFK4QZdnqNOslTZiMURajbUfCT0asY6QpWyzJ1S
	 rCBY92YpJK+ltqhK3JJ79uC8i8ZHjmPdscTXu/X48PkF86OHLbJxtG3I2V0XK+CuRc
	 ZcAd71E+4I23J9Gf8YOiNjxX3Eou/+Pabd6KhpBWGg6OUxsdMN4mhWTCfNon59vxUd
	 ILCK3nyi9DKSvWSt4INFKIeeYIR8YWyHn4VMKGukIEeJHcEjGVL+WAose+1Zkjt/+Y
	 cut8hiaKVuQ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] iommu: apple-dart/ipmmu/mtk_iommu implement
 iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-6-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-6-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 10:32:57 +0000
Message-Id: <20260531103257.B920C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe dereference of `iop` and `bank` pointers without NULL check=
s when querying an unattached domain.
--

commit ed347a72ff4d98b66b4b150fbb2b517fe7bcb883
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: apple-dart/ipmmu/mtk_iommu implement iova_to_phys_length

Migrate remaining io-pgtable user drivers to implement
iova_to_phys_length, passing through mapped_length from io-pgtable.

> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c

[ ... ]

> @@ -699,14 +699,18 @@ static void ipmmu_iotlb_sync(struct iommu_domain *i=
o_domain,
> -static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
> -				      dma_addr_t iova)
> +static phys_addr_t ipmmu_iova_to_phys_length(struct iommu_domain *io_dom=
ain,
> +				      dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct ipmmu_vmsa_domain *domain =3D to_vmsa_domain(io_domain);
> =20
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	/* TODO: Is locking needed ? */
> =20
> -	return domain->iop->iova_to_phys(domain->iop, iova);
> +	return domain->iop->iova_to_phys_length(domain->iop, iova,
> +						mapped_length);

[Severity: High]
This is a pre-existing issue, but could this unconditional dereference of
domain->iop cause a panic for unattached domains?

The IOMMUFD framework allows userspace to allocate a hardware page table
which creates an IOMMU domain without immediately attaching it. If a
translation is triggered on this unattached domain, domain->iop will be NUL=
L.

>  }

[ ... ]

> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c

[ ... ]

> @@ -858,13 +858,17 @@ static int mtk_iommu_sync_map(struct iommu_domain *=
domain, unsigned long iova,
> -static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
> -					  dma_addr_t iova)
> +static phys_addr_t mtk_iommu_iova_to_phys_length(struct iommu_domain *do=
main,
> +					  dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct mtk_iommu_domain *dom =3D to_mtk_domain(domain);
>  	phys_addr_t pa;
> =20
> -	pa =3D dom->iop->iova_to_phys(dom->iop, iova);
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
> +	pa =3D dom->iop->iova_to_phys_length(dom->iop, iova, mapped_length);
> +
>  	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT) &&
>  	    dom->bank->parent_data->enable_4GB &&

[Severity: High]
This is also a pre-existing issue, but does this function safely handle que=
rying
unattached domains without dereferencing NULL dom->iop and dom->bank pointe=
rs?

Similar to the ipmmu-vmsa driver, domain initialization is deferred until
attach_dev. If an unattached domain is queried, both pointers would be NULL,
causing a kernel panic. The apple_dart driver prevents this by explicitly
checking the operations pointer first before querying it.

>  	    pa >=3D MTK_IOMMU_4GB_MODE_REMAP_BASE)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D5

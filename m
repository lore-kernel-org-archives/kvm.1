Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BEA1BBBE5
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398544; cv=none; b=bp/Ht/JyVlaOGTJ4aG4PX52PBcaY3PJHxHsdyIwLhAgfnQfzNmqoi+1uQxS4Nf2QV50lC3hOJ59H2mYehcIKtjVLb2+FHE87qTAbseJLSFIYb0JqHckOl6ebWBcx+ekvvl0zH4izMwqKw73VyWgcn50x4JZxiz3JgJaUBcVztSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398544; c=relaxed/simple;
	bh=jdkPC0Q+muqB9KTYk0ie2snh3nTNetY/RXuAkN4n798=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r2vUwbp8vGwDoZgaJQkpaiMeuogaM2Yu6VjjkH9OM4gPTaZAQL3/20iv0C++7STeRcWMD7kch7wVtnHXiDWpJOjdgRIbBv4lqgdMjRV/JImQy8ClYpHcJ3pH1HMA9FWaxE761XXGfZWo3dEG7xJqaGSu8ag6NoK47pA4Y6crvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+0UyM+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+0UyM+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A860D1F00893;
	Tue,  2 Jun 2026 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398542;
	bh=7yeMHQbjEn9OwUc6a3dtFwRMibiAU9qI2ecbgNf6wcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N+0UyM+lvqWBPWOY4+a+c93RxkVcRZZSDl+MTb3ryam/PfJ/HypqHDEkbv5XwPGWB
	 W+Pr9vkbL2GQf6P1OQFEAtKhkSaysMZmOQHgKenliQnyBPoMbCazi1A+/JC643SZzP
	 XrBfQxqBI6/UfLItsbinqO/NhswrhnnJS4t1PD35Vot+Gk9XooCqDR0lEWbL0E0dKQ
	 Y5P+8qSCW+t70rhVUklwtV5IrZgwXGmz8R20+WmTnrVlE5lVagfbZbRBW7aWIhdHR3
	 kCR+DGUO3z7PGqjV6WMi82eu3HEDr/zfvZ/edb5o3qs7/ohNz+aNJdPBueruyVifAl
	 lhFXwjAxmGviQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/30] iommu/omap: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-17-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-17-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:09:02 +0000
Message-Id: <20260602110902.A860D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `iova_to_phys_length` on an unattached domain causes a NUL=
L pointer dereference.
--

commit 1684c564b3ca8b0ede767819c248c3b62e1635dd
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/omap: implement iova_to_phys_length

This commit implements the iova_to_phys_length callback for the OMAP IOMMU
driver. It modifies the existing translation function to also return the
mapped page size.

> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 8231d7d6bb6a9..883f9f61d4d95 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1592,15 +1592,19 @@ static void omap_iommu_domain_free(struct iommu_d=
omain *domain)
>  	kfree(omap_domain);
>  }
> =20
> -static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
> -					   dma_addr_t da)
> +static phys_addr_t omap_iommu_iova_to_phys_length(struct iommu_domain *d=
omain,
> +						  dma_addr_t da,
> +						  size_t *mapped_length)
>  {
>  	struct omap_iommu_domain *omap_domain =3D to_omap_domain(domain);
>  	struct omap_iommu_device *iommu =3D omap_domain->iommus;
>  	struct omap_iommu *oiommu =3D iommu->iommu_dev;

[Severity: High]
This isn't a bug introduced by this patch, but can this lead to a NULL poin=
ter
dereference if omap_iommu_iova_to_phys_length() is called on an unattached
domain?

When a domain is unattached, omap_domain->iommus is NULL, so setting
iommu =3D omap_domain->iommus and unconditionally accessing iommu->iommu_dev
would crash the kernel.

It seems possible to trigger this from userspace via iommufd by calling
IOMMU_HWPT_ALLOC with immediate_attach =3D false. This creates an unattached
domain and adds it to the IOAS.

If subsequent memory access operations trigger pfn_reader_first(), this
could query iova_to_phys_length on all domains within the IOAS, leading
to a local Denial of Service by unprivileged users.

>  	struct device *dev =3D oiommu->dev;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D16

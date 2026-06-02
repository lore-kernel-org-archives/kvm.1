Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D21D36657C
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398337; cv=none; b=aJDiL9XpMCM0pHyVXEH+YYkjzU3xf0hFx26rSgrkIkV/CoqTztSQWCRvDJXgtbW5ZjplECVFJKBtopxYqghErmyUVmeB/ews78bBpNZQw07gIqCA/V6//nPwxO7pfYxWv9iEHJ6HMFJQBp9B+vx9PJBZe1ku4v4NPAHsd6LJVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398337; c=relaxed/simple;
	bh=i32D/efITT4wndK1vR+xfoJpWj4mknqQCqwb+ErCcQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u8YFoFJuz5RauxGzIgyBbmcMUz7EQCekMp+J+FrWRvYxjcydArQ3TWELspdgT1w6WSAgennEVvFHP5FW1FcOX7ZFIth62IPLlP5N5SfTK/n0MOmK5CAiw8rIKOHbeieAs8FAipNCgzjldEm2D9SLaToX2aqUNAeplJaXPtHeJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cde0DAcp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cde0DAcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33961F00893;
	Tue,  2 Jun 2026 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398336;
	bh=SV7YGbYs7vX4EKUnmjPp2BgQs6EGIZpQ2KnRQE5BBNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cde0DAcpFspZ0L9wgAwPfq8GSHm9WItLt8axtIG0a1p03EHJYCAsZwFj7lveEKxbx
	 2PfC8gnU9YyYU6toc9fxHEeCCjnT9MvqCER0/b6MRdF8+GWi0mcRxbGCecPph1QlRy
	 BimbwTRYpIAxaZYG3AMg4oqxFVaQvxYFD4LZzHZshD+c2wMXndQixMPohRr+LP91IE
	 4UP3t6AeZMB0mcvNUeb8yPKV/XNF5nDKO4DuHEGTiqhmURAqkkh73GHdyx2CLJ2PER
	 U/sutJyMIcWhC1W/XRgPfIl318+UzWXzIG697iIfVF4mwNU9NeIjhL8OGT5QTNT1va
	 HWh5mwv/OJoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/30] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:05:35 +0000
Message-Id: <20260602110535.F33961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] For identity domains (`IOMMU_DOMAIN_IDENTITY`), `iommu_iova_to_phy=
s_length()` returns a valid physical address but leaves `*mapped_length` as=
 `0`, leading to an infinite loop in callers traversing IOVA space.
- [High] The core `iommu_iova_to_phys()` wrapper passes a `NULL` `mapped_le=
ngth` to `iommu_iova_to_phys_length()`, which is then passed directly to th=
e driver's `iova_to_phys_length` callback, creating a severe NULL pointer d=
ereference trap.
--

commit 8927aadcb32f5c1eb69647a6ec1ef7df78d3d8a6
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: introduce iova_to_phys_length in iommu_domain_ops

This commit adds an iova_to_phys_length callback to struct iommu_domain_ops
alongside the existing iova_to_phys. The new callback returns both the
physical address and the PTE mapping page size in a single page table walk.
It also adds an iommu_iova_to_phys_length core function to utilize this.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a05..1b1aaa53dd16a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2545,15 +2545,47 @@ void iommu_detach_group(struct iommu_domain *doma=
in, struct iommu_group *group)
[ ... ]
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY)
>  		return iova;

[Severity: High]
If we return here for an identity domain, mapped_length remains 0. Since the
API is intended for callers to traverse IOVA space by advancing by the
mapped_length, will returning 0 cause those callers to enter an infinite lo=
op?

Should we set mapped_length to a valid non-zero value, like PAGE_SIZE or the
remaining address space, before returning?

> -	if (domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (!domain->ops->iova_to_phys_length) {
> +		/* Fallback to legacy iova_to_phys without length info */
> +		if (domain->ops->iova_to_phys) {
> +			phys_addr_t phys =3D domain->ops->iova_to_phys(domain, iova);
> +			if (phys && mapped_length)
> +				*mapped_length =3D PAGE_SIZE;
> +			return phys ? phys : PHYS_ADDR_MAX;
> +		}
> +		return PHYS_ADDR_MAX;
> +	}
> +
> +	return domain->ops->iova_to_phys_length(domain, iova, mapped_length);

[Severity: High]
When iommu_iova_to_phys calls iommu_iova_to_phys_length with NULL for
mapped_length, it gets passed directly into the driver's iova_to_phys_length
callback here.

Because the driver callback documentation doesn't specify that mapped_length
can be NULL, does this place an undocumented burden on driver authors to ch=
eck
for NULL on every invocation? If a driver blindly writes to mapped_length, =
it
would cause a NULL pointer dereference.

Could we provide a dummy variable in the core function when mapped_length is
NULL to guarantee safety?

> +}
> +EXPORT_SYMBOL_GPL(iommu_iova_to_phys_length);
> +
> +phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t i=
ova)
> +{
> +	phys_addr_t phys =3D iommu_iova_to_phys_length(domain, iova, NULL);
> =20
> -	return domain->ops->iova_to_phys(domain, iova);
> +	return (phys =3D=3D PHYS_ADDR_MAX) ? 0 : phys;
>  }
>  EXPORT_SYMBOL_GPL(iommu_iova_to_phys);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D1

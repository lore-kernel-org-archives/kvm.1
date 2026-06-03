Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCF3B6C09
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501137; cv=none; b=W73ZqSdgsC6AM2yxicB+iBYN36f4I3Bgtaxf9wpbPUsPGr/YEjciIlnUFKMVnYbE6s8fbP3OZ52pUZ/ODli80l4iA7XOYz5s+Jtb+u9m+NcoeP3IrlljLUKbD+TRJ9Zlci/gOwQm+7vTlxwyGocNQi+nAQHJsw9RFI8f3fzTymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501137; c=relaxed/simple;
	bh=5Ix794C/l/iBpdl65hJJH4k4zHX0lOqDVZ8xwTy+J78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SAnjNaxwmWkgioFUbjGJQcjZSU6ffmxl3tLIOwut4mMSLjiDrglRX3pLwcVjFmgDvzhxADxtAYxN9Swk/AqXU3H6G5CdpDUy9wzXkxgbL/+HcWhuGEzfLvdMSc+mcTc6am/eY5gVGibmdE71lJHpuGmV+D9WpKW7ASeFJm2rqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrjcwg0p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrjcwg0p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491841F00893;
	Wed,  3 Jun 2026 15:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501136;
	bh=5wNckhODqj7/rwIH/5da/ADG1jHhLHgmac5QofUSLkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nrjcwg0pkt+gQJfjpSzkncwQSXXg83K4Xi6h8wpbYeS/n6dN+z6R9YTxQPt/8dUbq
	 o/mokb+Im5/DthH0VK85Gno0DDanxI9iv7mjf15zvE/DgyJtSzZLoOvj05Ty6XLgDY
	 wP7Lk7vmBzM2j9GjNG+xLlpZPyDJGzRu/+waaJLdZBMFriD0vEvHf8jsSUDsmrU00t
	 ERFeHOcewXkOj6kn+fuFqp+cVMqHxf+rVW06V8IbAN/SMCT2RRBr++wbAzwHowllmF
	 WQZt4p4etz8WsS7qOtsiH5syMQo8LqOJyrBQsKMBurLa8hkXqRg2OwrrGSbvlIw4yx
	 Q8C0befxfMRDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/32] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:38:55 +0000
Message-Id: <20260603153856.491841F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The iova_to_phys_length callback API lacks error-value documen=
tation, leading to implementations returning 0 on error instead of PHYS_ADD=
R_MAX, causing critical security issues when physical page 0 is wrongly unp=
inned.
--

commit 9607eab32e3052be526d8972c7af679e0ea36c75
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: introduce iova_to_phys_length in iommu_domain_ops

This commit introduces a new iova_to_phys_length callback in
iommu_domain_ops and a corresponding iommu_iova_to_phys_length() core
function. The callback allows returning both the physical address and the
PTE mapping page size in a single page table walk. Callers like VFIO can
use this to traverse IOVA space more efficiently.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a05..320ea13488e7b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c

[ ... ]

> @@ -2545,15 +2545,55 @@ void iommu_detach_group(struct iommu_domain *doma=
in, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
> =20
> -phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t i=
ova)
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page si=
ze
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/=
1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of t=
he
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or PHYS_ADDR_MAX if =
no
> + *         translation exists.
> + */
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {
> -	if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY)
> +	phys_addr_t phys;
> +
> +	if (domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> +		if (mapped_length)
> +			*mapped_length =3D PAGE_SIZE;
>  		return iova;
> +	}
> =20
> -	if (domain->type =3D=3D IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova, mapped_length);

[Severity: Critical]
Does this code handle failures correctly if the driver returns 0 on error?

The documentation for iommu_iova_to_phys_length() states that it returns
PHYS_ADDR_MAX if no translation exists. However, if the underlying driver
incorrectly returns 0 on failure, this wrapper directly propagates that 0.

If callers like VFIO check for PHYS_ADDR_MAX to detect errors, they will
assume 0 is a valid physical address. This can lead to unmapping and
unpinning physical PFN 0, which corrupts page refcounts and can result in
use-after-free vulnerabilities.

Could we sanitize the return value here?

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bf8a77a164e4d..29c7c042d400d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h

[ ... ]

> @@ -804,6 +807,9 @@ struct iommu_domain_ops {
> =20
>  	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain,
>  				    dma_addr_t iova);
> +	phys_addr_t (*iova_to_phys_length)(struct iommu_domain *domain,
> +					    dma_addr_t iova,
> +					    size_t *mapped_length);

[Severity: Critical]
Could we add documentation specifying the error return value for this new
callback?

Since legacy iova_to_phys implementations often returned 0 on error, drivers
implementing this new callback might also return 0 instead of PHYS_ADDR_MAX
on failure.

For example, arm_smmu_iova_to_phys_hard() defaults its address variable to 0
on translation faults.

Additionally, drivers might fail to set mapped_length on success, which
can cause kernel warnings in callers like VFIO and iommufd.

Explicitly documenting the expectations for mapped_length and the return
value on failure (PHYS_ADDR_MAX) might prevent these driver implementation
errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D1

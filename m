Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875B126FD97
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398261; cv=none; b=mDWrB3qaf1GYJIOm4ZJPUGyUbDG2ToM5CcsnARqTSlD6Dx7FkG47EazFyaEs3y9f0Id/FfWjYw8M9pWzsc3oBe3duDtLUwJcxuxmS7NFyJFJ81Fei9/tGDfvmp0RSyBRyB03B3FAXU9+dqbEI0Vfvc2b0qoJCvtnZr3vqPc47P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398261; c=relaxed/simple;
	bh=hL18qkjKKW9z5TjG95wskUdFJwIlJ2wQ217VV8DlFww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gXASbiSLY1wgsv7I984F6MDH6hmmqkARAIWx1RBxjALHjqFyiPlM0H02AqRqNjmUSSnGGaC1aVeeNxQQYXgiImICxhMJTS0bfQcCcb47xxV3mdjogmsR3g+T8ADnLz3311Y30ze63mwTt8ISZco452KafHsNXMA6KGdKMM5yNx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxZYMChn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxZYMChn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F061F00893;
	Tue,  2 Jun 2026 11:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398257;
	bh=sGsjAb0QiW9scrlL88rw9Ao2Wm+UdebLORQg05lDmw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IxZYMChnOvXMGYNcZDhT+l/ubAObn+uAIM1r0CY8QQW2N99OCwh6EFt9XBEaj5PJe
	 QNJUPYVCVhfMIN2H0Q/ZHitLsUN1PMZEst5X05CALU9En4K1YhzVcsEhrr9pqCMJWT
	 +tfHkkNpASBhuYeH1szX3upUihfUgIcD+1k/dQNMyip0MATlGJrWoI0XZt/+os1xje
	 mZlRQKftF8qER9FW4ihR94LfC/MzYrt1lOBcMrK2mpn0RTVHMLRp1jg4vNm7wncMma
	 8IbcfOdFfy6dmXrmRfTGO5th/bWrmVchXICGNaG1dWdi30hii7kj689zPvhg4B2tzz
	 SDkGu8i/hwdGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/30] iommu/msm: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-15-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-15-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:04:17 +0000
Message-Id: <20260602110417.C7F061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incorrect mapping length hardcoded to `SZ_4K` for 64KB and 1MB map=
pings causes unmap failures and resource leaks.

Pre-existing issues:
- [High] Negative error code from `__enable_clocks()` is returned as a vali=
d physical address, bypassing IOMMU API failure checks.
- [High] Unsafe `list_first_entry()` on a potentially empty list causes inv=
alid pointer dereference.
--

commit e11fea990236734e10ab3d7e27031085045028c3
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/msm: implement iova_to_phys_length

Implement iova_to_phys_length for MSM IOMMU driver, returning the actual
PTE mapping size.

> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 0ad5ff431d5b6..af4020ed99876 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -523,15 +523,19 @@ static size_t msm_iommu_unmap(struct iommu_domain *=
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

[Severity: High]
This is a pre-existing issue, but does list_first_entry() return a valid
pointer if the list_attached list is empty?

If a domain has no devices attached, such as directly after domain
allocation, the list will be empty. Because list_first_entry() does not
check for emptiness, it seems this could result in a bogus pointer being
dereferenced during the subsequent list_empty() check on the ctx_list:

msm_iommu.c:msm_iommu_iova_to_phys_length() {
        ...
        priv =3D to_msm_priv(domain);
        iommu =3D list_first_entry(&priv->list_attached,
                                 struct msm_iommu_dev, dom_node);

        if (list_empty(&iommu->ctx_list))
                goto fail;
        ...
}

[Severity: High]
This is also a pre-existing issue, but does the failure path for
__enable_clocks() unintentionally return a negative error code as a valid
physical address?

When __enable_clocks() fails, it returns a negative integer like -EINVAL.
This is assigned to ret, which is of type phys_addr_t. Since the code then
jumps to the fail label and returns ret, the unsigned cast of the negative
error code won't match the PHYS_ADDR_MAX failure sentinel:

msm_iommu.c:msm_iommu_iova_to_phys_length() {
        ...
        ret =3D __enable_clocks(iommu);
        if (ret)
                goto fail;
        ...
fail:
        spin_unlock_irqrestore(&msm_iommu_lock, flags);
        return ret;
}

Could this cause the IOMMU API to interpret the failure as a valid mapping?

>  	struct msm_priv *priv;
>  	struct msm_iommu_dev *iommu;
>  	struct msm_iommu_ctx_dev *master;

[ ... ]

> @@ -558,13 +562,22 @@ static phys_addr_t msm_iommu_iova_to_phys(struct io=
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

[Severity: High]
Does setting mapped_length to SZ_4K for all non-supersection mappings cause
issues with 64KB and 1MB mappings?

The hardware uses the ARM_V7S short descriptor format where the PAR register
doesn't explicitly differentiate between 1MB section, 64KB large page, and
4KB page mappings. If mapped_length is hardcoded to SZ_4K here, unmap
requests for larger regions might fail.

The underlying arm_v7s_unmap() pagetable code rejects partial unmaps of
larger sections. Could this lead to leaked memory and IOVA space?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D14

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703A3112AB
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398261; cv=none; b=on9zcCJ+PXH3xyHfY45eMg2j8rhfpkEapGIOLhxZNcym5SzbZbiKmDa+sSry4Nuk6NdEPHJl6fQwdDO3pQrnGvnaH4QpJ/hcDSa4H8Fi7ULnohjZ84W63uiK+6V0fSU2yLoSZNKT7wdoZK8qPgbixZoVLJQzSqPHv/8ytKYMaZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398261; c=relaxed/simple;
	bh=r7DceF34cmujh0Xfb2C3q4OhLLkTLCtREivtKiHo948=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RGzSDMsk5wEVUnJ0uuw4W9EvOF7TuvMoPM+hfA7b618P8PTH5z8ehYBEAwx4I3rYu+xHtg6vTpoDArkp+leDBCr3ub+5XsjJAj5FhRAYwkWbbBisS2C268YJQ7qwBLgYARF16oYuNqbDFYNLpKgSl2cBNSvphe/FDtnu3mb2lww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXGgXxnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXGgXxnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B231F00898;
	Tue,  2 Jun 2026 11:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398258;
	bh=DN8qWid0mYXFxyqEjyvBRib7FM631Jut95yJBBD+hic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mXGgXxnf502ycHYpB+UMpF4WlsGxCVqkFNYC0msIUJXoia8CSjAwEPFx9clVnGBMm
	 7tjmGtVT+S4wITiWtUegtd+sriAFH9hrMSMyQz55qNVn8GvyeUdGoNtUFwfsB9Pygr
	 SO9NRo9SEpgufojCVkWyp4v67USJxMjMZOPo7wGeZLCdzQq4BNFD41uBermqsiP92q
	 y+X12+3kuTGIzxVC2pgyexiQEce33yUuJBaiScZjZ+fn6X6OZ92st8pV2fgYA63FoI
	 X8kva9mBJwPvtry6PkjZwKUiBoGvL/u6FoRCNabznX8b9ELkxhSb4QVOiPIy3GFrY3
	 c9BAuuPXeBEuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/30] iommu/arm-smmu: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-8-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-8-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:04:18 +0000
Message-Id: <20260602110418.95B231F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The `iova_to_phys_length` API contract is violated because `mapped=
_length` is not populated during hardware translation or its software fallb=
ack.
- [High] `arm_smmu_iova_to_phys_hard` returns `0` instead of `PHYS_ADDR_MAX=
` on translation failure, masquerading as a successful translation.
- [Low] The error check for software table walk failures in `qcom_smmu_cont=
ext_fault` is broken, failing to detect `PHYS_ADDR_MAX`.

Pre-existing issues:
- [High] `arm_smmu_rpm_get()` can sleep, causing deadlocks if `iova_to_phys=
` is called from atomic contexts.
--

commit caa5d047d0fcd8b121e03e1968cc870e79540cdb
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/arm-smmu: implement iova_to_phys_length

Migrate ARM SMMU to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer. Update qcom-debug
caller accordingly.

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c b/drivers/i=
ommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> index 65e0ef6539fe7..4fd01341157f3 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c
> @@ -415,7 +415,7 @@ irqreturn_t qcom_smmu_context_fault(int irq, void *de=
v)
>  		return IRQ_HANDLED;
>  	}
> =20
> -	phys_soft =3D ops->iova_to_phys(ops, cfi.iova);
> +	phys_soft =3D ops->iova_to_phys_length(ops, cfi.iova, NULL);

[Severity: Low]
With the new iova_to_phys_length API returning PHYS_ADDR_MAX on failure,
should the error check further down in qcom_smmu_context_fault() be
updated?

It currently checks for zero:

qcom_smmu_context_fault() {
    ...
    phys_soft =3D ops->iova_to_phys_length(ops, cfi.iova, NULL);
    ...
    if (!phys_soft)
        dev_err(smmu->dev,
            "SOFTWARE TABLE WALK FAILED! ...");
    ...
}

If the software walk fails and returns PHYS_ADDR_MAX, will this check
silently skip the diagnostic error message?

> =20
>  	tmp =3D report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
>  				 cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAUL=
T_READ);

[ ... ]

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index 0bd21d206eb3e..dfbd541f9e3e0 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1366,7 +1366,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struc=
t iommu_domain *domain,
>  			"iova to phys timed out on %pad. Falling back to software table walk.=
\n",
>  			&iova);
>  		arm_smmu_rpm_put(smmu);
> -		return ops->iova_to_phys(ops, iova);
> +		return ops->iova_to_phys_length(ops, iova, NULL);

[Severity: High]
If we fall back to the software table walk here and pass NULL for the
mapped_length, does this violate the iova_to_phys_length API contract?
Callers might expect the mapped_length to be populated.

[Severity: High]
Is it necessary to update arm_smmu_iova_to_phys_hard() to return
PHYS_ADDR_MAX instead of 0 on failures?

The new iova_to_phys_length API contract requires returning PHYS_ADDR_MAX
on mapping failures. If this continues returning 0 on arm_smmu_rpm_get()
errors or translation faults, callers could incorrectly interpret it as a
valid mapping at physical address 0.

[Severity: High]
This is a pre-existing issue, but it looks like arm_smmu_iova_to_phys_hard()
calls arm_smmu_rpm_get() earlier in this function, which can sleep.

Since iommu_iova_to_phys() is frequently called from atomic contexts like
NAPI fast paths, could this cause a sleeping-in-atomic regression?

>  	}
> =20
>  	phys =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_PAR);

[ ... ]

> @@ -1384,20 +1384,23 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(str=
uct iommu_domain *domain,
>  	return addr;
>  }
> =20
> -static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> -					dma_addr_t iova)
> +static phys_addr_t arm_smmu_iova_to_phys_length(struct iommu_domain *dom=
ain,
> +					dma_addr_t iova, size_t *mapped_length)
>  {
>  	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
>  	struct io_pgtable_ops *ops =3D smmu_domain->pgtbl_ops;
> =20
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	if (!ops)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS &&
>  			smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1)
>  		return arm_smmu_iova_to_phys_hard(domain, iova);

[Severity: High]
When delegating to arm_smmu_iova_to_phys_hard(), the mapped_length pointer
is not passed and remains 0. Will callers that use this length to advance
their IOVA iterators enter an infinite loop when the size remains 0 after
a successful hardware translation?

> =20
> -	return ops->iova_to_phys(ops, iova);
> +	return ops->iova_to_phys_length(ops, iova, mapped_length);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D7

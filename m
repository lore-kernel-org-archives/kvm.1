Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828E3D3D0C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501328; cv=none; b=m9+7R4ewFzqVJOM+jQrSYweko2wfxeyFFeWhmMU1sXjxelaUSIY4h4zHuQaR7wEhf4sJGQZjjOfuQc9yRyXxcm2Wpn7RiDL+s7vjmCWHjzhtX4TIzpIJsV/UnKPJQUoGfnyHz+3Br8jmd5M6E14cXHiC1cSO3lFVdZJAV2iRsLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501328; c=relaxed/simple;
	bh=zengJJgnUQcvO1RtxEqzYVmwjyfgmjLJAi5F/2GQAVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MuF74Ra3UDwkilK9OV42KkMqcGrjUN6be8ztAa6LlOGQOB61CYOWYZdek1rc7f/xmBryrXrbJ4j0pwW+ahsgC75Pa0DtQfAklV5t2vxvLt2d3oAjDZ+6DALCvQA4AbuUHR4G3ELhS4cTkqZTe584YCiF3EYfD41kD1ZwA3zYins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ/4rg5y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ/4rg5y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DEB1F00893;
	Wed,  3 Jun 2026 15:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780501326;
	bh=1xDFZ8y25m5l9HY2MNrWGU37B8+vPhBfbSf4W5PuSbU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZ/4rg5yXnBpQ0DSzmZV8Yy/72j4jszXzZLtM2I2NNfJIxJlcK5hO5YtRSxKxfHhr
	 vOoUoFPQbCt0huzu1h9EDgj7o5i4LMvZnwCTtAwzGxHuVaXr+73fRmsWO186aqnW1F
	 Ma5puC03IirnlXxrXx8s2lmtA8dXxJclGKR6gxWyNrbp0V5JzeZ5CyyfAqMA3bVWAU
	 OHFL31o8oJTM7Hjjvyc3OEHO4OswMkWl8HgaPvOdCcZWL2MC8qkdbaQD6k/UarafsC
	 SDy8pp6CrXfnedhswtD2ViegXRREDoLd48ARZ7htLEy97rSHaRCN6jCQRTPrmqf7m2
	 XSUBDkYy2pDAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/32] iommu/arm-smmu: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-8-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-8-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:42:06 +0000
Message-Id: <20260603154206.90DEB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] arm_smmu_iova_to_phys_hard() returns 0 instead of PHYS_ADDR_MA=
X on failure, causing memory corruption via unpinned physical page 0.
- [High] arm_smmu_iova_to_phys_length fails to populate mapped_length in th=
e hardware translation path, causing potential DoS via log spam.
- [Medium] qcom_smmu_context_fault uses incorrect error checking (!phys_sof=
t) for the new iova_to_phys_length API.
--

commit b1a65029d801a1b04d4b609842ab52ac8eea5e30
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

[Severity: Medium]
Will this result in skipped error reporting later in this function?

Since io-pgtable implementations of iova_to_phys_length now return
PHYS_ADDR_MAX on error instead of 0, the check further down in
qcom_smmu_context_fault:

	if (!phys_soft)
		dev_err(smmu->dev,
			"SOFTWARE TABLE WALK FAILED! Looks like %s accessed an unmapped address!=
\n",
			dev_name(smmu->dev));

will evaluate to false when the table walk fails. Can this cause
PHYS_ADDR_MAX to be erroneously treated and printed as a successfully
resolved physical address?

[ ... ]

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index 0bd21d206eb3e..5c9ec7c937632 100644
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
Are we discarding the mapping size by explicitly passing NULL for
mapped_length?

If callers like vfio_unmap_unpin receive a pgsize of 0, will they trigger a
WARN_ON trace for every unmapped page, potentially spamming the kernel log
when unmapping large amounts of memory?

>  	}
> =20
>  	phys =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_PAR);
> @@ -1384,20 +1384,21 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(str=
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
> +
>  	if (!ops)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	if (smmu_domain->smmu->features & ARM_SMMU_FEAT_TRANS_OPS &&
>  			smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1)
>  		return arm_smmu_iova_to_phys_hard(domain, iova);

[Severity: High]
Could this delegation to hardware translation fail to populate mapped_lengt=
h?

Since arm_smmu_iova_to_phys_hard does not take a mapped_length parameter, it
leaves the size unpopulated. Similar to the software fallback above, can
this cause callers to receive a pgsize of 0?

[Severity: Critical]
Is arm_smmu_iova_to_phys_hard still returning 0 on failure?

The updated API requires returning PHYS_ADDR_MAX upon translation failure,
but arm_smmu_iova_to_phys_hard returns 0 when arm_smmu_rpm_get fails, and
also when a translation fault occurs:

	phys =3D arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_PAR);
	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
	if (phys & ARM_SMMU_CB_PAR_F) {
		dev_err(dev, "translation fault!\n");
		dev_err(dev, "PAR =3D 0x%llx\n", phys);
		goto out;
	}

Because 0 is a valid physical address, will callers erroneously treat this
as a successfully mapped address, which could result in unpinning physical
page 0?

> =20
> -	return ops->iova_to_phys(ops, iova);
> +	return ops->iova_to_phys_length(ops, iova, mapped_length);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70137348883
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780222961; cv=none; b=osxmzHeqhY+lacjlVu4uKCn/RxCXYaBzV0jd52HQUyPZqFI3RFHDINjmx24YU3DQIOJgBNATtr23sII9iRP6zJ8QaPH6FPSeoElgWjGl60e6cT7hRg9GUttX0HoYceyKucQ8+uYlv/p16DVbCOvCP4LMCDYTZl9Gl7NoFvq/KZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780222961; c=relaxed/simple;
	bh=8G3MU/rqFtlUIxoAIz8aW6U61nE8zRxP4jbVfQtvv+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eM8Fvrxmfv2v9xMbSKCRsmFxmwSWRvkc3LZ3XS840ycAVakcPTQRLNASxN13IkpMDMDkaak3XemYni2bwng5jdipq0/eUQdjUBmeBap1s2VaaKIZgwsN58GFFJQebnIAkI3YWJ3Un8PvJMAetrUgWuzgkBz0EGuoJ3xOjv/OEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTexwjpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTexwjpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A801F00893;
	Sun, 31 May 2026 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780222960;
	bh=dgo/5LiNlXpRNaE2EyXWXs2gTKWyMBLkVxokzA6hZz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QTexwjpSC88dL05Q6OPCDRAfwSvZuCfbqR+LhSSE5uPpSVRTagxgDMFq7xISLFgkq
	 HuGp+qaP8D0//lQa5ivJX/q/u2CrjORDsHYKbtJtPIDKD5p57bL61Dfusu4zBOboCj
	 5Wqzx+lhJ3LkQiKy5viSOXyaB3bT3KGvykDya10j/I8ah9r18yaE0kO7WvssnQHVJI
	 qhwn2KXvf76MFcwzrTbkjwv/v5d1lS1X0JKFQnMOxp8gU4fO6D/vBs33dziHV8XWm+
	 85oYvcHl1hnT+F2+5a6lHAECI9sKJjc7RFBCBLmqVOguVoTP2dJkmQh/ca6e43MdTw
	 awakr4tkCEs3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/9] iommu/arm-smmu: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-5-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-5-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 10:22:39 +0000
Message-Id: <20260531102240.12A801F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] `arm_smmu_iova_to_phys_length` fails to populate `mapped_length` w=
hen using the hardware translation path, silently defeating the page table =
walk optimization.

Pre-existing issues:
- [High] The `qcom_smmu_context_fault` interrupt handler can dereference a =
NULL `pgtbl_ops` pointer if a context fault interrupt fires before domain i=
nitialization completes.
--

commit 3fdd57d4dce5ad5d48f3b578b79029642d87bc3e
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/arm-smmu: implement iova_to_phys_length

Migrate ARM SMMU drivers to implement iova_to_phys_length, calling
ops->iova_to_phys_length on the io-pgtable layer to get both phys
and PTE page size.

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

[Severity: High]
This is a pre-existing issue, but is it possible for ops to be NULL here?

If a context fault interrupt fires early during domain initialization, befo=
re
pgtbl_ops is safely published in arm_smmu_init_domain_context():

    ret =3D devm_request_irq(smmu->dev, irq, context_fault, ...);
    ...
    mutex_unlock(&smmu_domain->init_mutex);
    smmu_domain->pgtbl_ops =3D pgtbl_ops;

Could an unhandled fault on a reused context bank cause an immediate
interrupt, leading to a NULL pointer dereference when
ops->iova_to_phys_length() is called?

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/ar=
m-smmu/arm-smmu.c
> index 0bd21d206eb3e..e29e0ea12f24a 100644
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
Does this hardware translation fallback path fail to populate mapped_length?

Since mapped_length is passed as NULL, callers like VFIO attempting to unmap
large regions might receive a length of 0. This could force them to fall ba=
ck
to PAGE_SIZE iterations, which would trigger hundreds of slow ATOS MMIO
operations and severely impact performance.

[ ... ]

> @@ -1384,12 +1384,15 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(str=
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
>  		return 0;
> =20
> @@ -1397,7 +1400,7 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iom=
mu_domain *domain,
>  			smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1)
>  		return arm_smmu_iova_to_phys_hard(domain, iova);

[Severity: High]
Does the hardware translation path here also defeat the page table walk
optimization by failing to populate mapped_length?

When arm_smmu_iova_to_phys_hard() is called, mapped_length is left as 0 sin=
ce
the function doesn't accept or update it. Will this result in callers
receiving a length of 0 and performing inefficient PAGE_SIZE iterations?

> -	return ops->iova_to_phys(ops, iova);
> +	return ops->iova_to_phys_length(ops, iova, mapped_length);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D4

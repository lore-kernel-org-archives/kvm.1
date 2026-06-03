Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D43E5EFD
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503988; cv=none; b=iwUHsJOujXXk7Ot9hk/YpoX3d4HOK9RJgYazX1laDNXdc6bAAZvgr8efA6PkdHWRKLutpjq23Z1JO/EtkSyqXOaDqxJPenA+05BwOgtEBlOq56ecec7sRkF0vCrnYXvQ5vatpnLb+LCclZEldtbOpK98wsk5T6X0CGivcytlP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503988; c=relaxed/simple;
	bh=t9B2D9k6OqX+yFcpZm7G5mMnq3RMITHR+A8vYkbB53c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=InZm/urjX6mPFOm9EInRLFH/tjorbI33mw1L7aSyCI9Qjsys0y4n+/JJRw1w9MORu0jJeOf8DyGCJppzql74cmGAsnhuf6DWOr1EIkhwDXGf7OOuKvkhMyqPjdRfhWgZ+ko0W8bd3Y4n3IboouyHHD40ulE3BSR3DRYYOJ32NeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krOADTtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krOADTtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECBD71F008A1;
	Wed,  3 Jun 2026 16:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503987;
	bh=ixxDGcSDffwx/ZUoUeCpmZMYvvcVYVlNQyYrEcyZrr4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=krOADTtd4+986eXJS4BcKgszfUzYc8DO+oYHkZkIjF5IcmtQAPwCuBXEM5YqJ/4XO
	 D/rPDSNeKci03D7GF/hAhIH1tq2Jrb1HTZsY2ugtPi55i3teLX+tJfDFh3xSokH8d4
	 GwD6Ad2wuHn5/wf/lEYN4uPnBywPXwrWTipOFNt1NYpF39d+lTfuzoy3g7vm5RY3iP
	 GYCXXeGdGq6stk8Sp599G+djMTgUbahhNNoe0ViDBQL2cvFaiGy7YUp35eEaoBDgew
	 q4MOAR6osZjLZhZPwpZ9ZVMA59ssaLZNfP4Jq11JjJM1tMmr5t3Q85rkgjbhxxsfK4
	 kNDGTfZ8/annA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 32/32] iommu: remove iova_to_phys from domain_ops and
 io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-33-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-33-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:26:26 +0000
Message-Id: <20260603162626.ECBD71F008A1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The commit removes `.iova_to_phys` from `struct iommu_domain_ops` =
but fails to update the VeriSilicon IOMMU driver (`drivers/iommu/vsi-iommu.=
c`), causing a build failure and breaking IOVA translation.
--

commit 07242ed991899ab6da27ae54405dbc3801f90876
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: remove iova_to_phys from domain_ops and io_pgtable_ops

This patch removes the deprecated .iova_to_phys interface from
struct iommu_domain_ops and struct io_pgtable_ops. It also cleans up the
fallback path in iommu_iova_to_phys_length() since all drivers are expected
to have migrated to .iova_to_phys_length.

> Now that all drivers implement iova_to_phys_length and all callers
> have migrated, remove the deprecated interfaces:

[Severity: High]
Is it possible the VeriSilicon IOMMU driver was missed during this migratio=
n?

Looking at drivers/iommu/vsi-iommu.c, it does not implement
.iova_to_phys_length and still assigns the removed field, which will cause
a build failure:

drivers/iommu/vsi-iommu.c:vsi_iommu_ops {
    ...
    .iova_to_phys       =3D vsi_iommu_iova_to_phys,
    ...
};

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 320ea13488e7b..1ad4787925cd3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> @@ -2572,20 +2570,10 @@ phys_addr_t iommu_iova_to_phys_length(struct iomm=
u_domain *domain,
>  	if (mapped_length)
>  		*mapped_length =3D 0;
> =20
> -	if (domain->ops->iova_to_phys_length)
> -		return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
> -
> -	/* Fallback to legacy iova_to_phys without length info */
> -	if (!domain->ops->iova_to_phys)
> +	if (!domain->ops->iova_to_phys_length)
>  		return PHYS_ADDR_MAX;

[Severity: High]
Because vsi-iommu.c doesn't implement .iova_to_phys_length, won't this=20
cause iommu_iova_to_phys_length() to unconditionally return PHYS_ADDR_MAX
for that driver?  This would break its IOVA-to-physical translation once the
build error is fixed.

> -	phys =3D domain->ops->iova_to_phys(domain, iova);
> -	if (!phys)
> -		return PHYS_ADDR_MAX;
> -
> -	if (mapped_length)
> -		*mapped_length =3D PAGE_SIZE;
> -	return phys;
> +	return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
>  }
>  EXPORT_SYMBOL_GPL(iommu_iova_to_phys_length);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D32

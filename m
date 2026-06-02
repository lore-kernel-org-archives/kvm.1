Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5C1C701F
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398126; cv=none; b=aQV3dWql1kiFl7lnNfo397wjvmBPo+cEUcma8SP8xCNV4ISTHE2FM6hQ4jtiOGMd6cHqU6dYVkKLrmT5G1OvJYZNAdb6iwbVLD0eQPqI1lexbZ08CuAlM5qA0lZ/eeQ46eIHke1ucWONKoiFhC2oVeH9HZcnA5Ln6lFeqr/1PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398126; c=relaxed/simple;
	bh=kimg1COE9QpQzqYrjuagTca4qdGQWnkfbFpi7O9BDbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kv8ol3Ioit4ocEmi8lMslqvE2Ym+wvZqNubnv89fZD9/fKwBse4NZOkZUnCUR8FSbDDvXCixL94gkH1jxzZkeDFUyrhrOg0nmSQCjWb/ij1Pn/d22eRfPdI9D0XrqU5MCR3y0R8Z9KN91ylKvPoWcFQngtL7os4cI70K4j0QZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIFPB8P+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIFPB8P+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F0A1F00898;
	Tue,  2 Jun 2026 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398124;
	bh=7FV60xh3khyUTP7luIt1WCAsY398QUC2OJ5BED/w/0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIFPB8P+TA/T3SRNWnJWxW6f/Hmzb44OkzpH2DiJzp81gxrZwk8iuMVQmFpuCOo+j
	 05JgebKvhslgm14XN0n4piBFUDl6ivIWHsl/lNlNw1SSMAne0B15B0qtydhBOvVb4f
	 UBGqvm+EKL1kTAEP46SGyudls2ehPf9hP/NvTsVqdp8cs3hw99AEMe64W59xSji0Ok
	 wrDnW+Rs2+hjqYVnQ114a1hOMjABSe/+ZhIsChU/0l8IZB/k6xPnKg7eUaWQnV+aSS
	 BrMeurLRKeIpIAJiyNLMlfFVaQuNdz+rRT7nZCTpBTWIzsg4JWu3lkOCyJp9OaYN1t
	 XElFFh5nvYPjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/30] iommu/io-pgtable-arm-v7s: introduce
 iova_to_phys_length in io_pgtable_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-4-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-4-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:02:04 +0000
Message-Id: <20260602110204.C2F0A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using PHYS_ADDR_MAX as an error sentinel breaks valid translations=
 to high physical memory on 32-bit systems.
--

commit 8d5316c44c1d3b102a4d8d7b0ce51537aca692ab
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/io-pgtable-arm-v7s: introduce iova_to_phys_length in io_pgtable_ops

Implement iova_to_phys_length in ARM v7s backend: returns block size
derived from level mask. The old iova_to_phys is kept as a thin wrapper.

> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtabl=
e-arm-v7s.c
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
[ ... ]
> +static phys_addr_t arm_v7s_iova_to_phys(struct io_pgtable_ops *ops,
> +					unsigned long iova)
> +{
> +	phys_addr_t phys =3D arm_v7s_iova_to_phys_length(ops, iova, NULL);
> +
> +	return (phys =3D=3D PHYS_ADDR_MAX) ? 0 : phys;

[Severity: High]
Does this condition inadvertently catch valid translations on 32-bit system=
s?

If CONFIG_PHYS_ADDR_T_64BIT is disabled, phys_addr_t is 32-bit, making
PHYS_ADDR_MAX exactly 0xFFFFFFFF. Since 0xFFFFFFFF can be a valid physical
address (e.g., in MMIO space), a valid IOVA mapping that resolves to
0xFFFFFFFF would perfectly match the error sentinel and incorrectly return =
0.

> +}
> +
> +static phys_addr_t arm_v7s_iova_to_phys_length(struct io_pgtable_ops *op=
s,
> +						unsigned long iova,
> +						size_t *mapped_length)
>  {
[ ... ]
>  	if (!ARM_V7S_PTE_IS_VALID(pte))
> -		return 0;
> +		return PHYS_ADDR_MAX;

[Severity: High]
Could this similarly cause direct callers of iova_to_phys_length() to
misinterpret a legitimate translation to 0xFFFFFFFF as a failure?

Since 0xFFFFFFFF is a valid physical address, using it as an error sentinel
might make it impossible to correctly translate IOVAs pointing to the top b=
yte
of memory on 32-bit systems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D3

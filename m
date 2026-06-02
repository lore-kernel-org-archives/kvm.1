Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0038F25A
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398143; cv=none; b=E99U0Mjdtn2ztsoWxggjptFcbE5XUVKIkZjX0qpfq5z5RZPF4B8nuHnZ8A+yUX8j7H4CzeHVsNpyO2xxMqYWv6HB+0Va+roQEgtItY+INA18u8k8n79Ccbe+wh8bkCKHKBTwmnB9B7Mdjl/CI7HABc7RSnMSMNdxSsvk3hqR3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398143; c=relaxed/simple;
	bh=WTPL+kxco5aLi0XVYXq6r/pMVZjWpG/u7osBuD95hm0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8coNkCXoLpRVBZMyq72fWOJnGKupiDQf8K/jmqlcKQ146nbmSM6yisg+v81cH5/erUolK1WdaKymYllxoNCui1JcvHiLEE9RiXwnPWt45ZEnQ0SS8fS5IuyYDqh9Dm8k6Kf/aGvit2JqRTcsiFUCChmRInrFlCrjDVQ81fz+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBjMknFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBjMknFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D3B1F00898;
	Tue,  2 Jun 2026 11:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398140;
	bh=z4h/3BA8wx8BbeldQsafRuPMvWSndaH/CT3NT/xSbU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBjMknFpekcq+JVPaPyPKXf1dl85n3RQy0nbJwBUHSQGULVJUxQ4ra1FFUHSkZnFf
	 JUaGdw2ksOA09WDOZdA2dWgxVOjYXx60SiGjhWGiGr3zeinIifajVR2TFq9qvdYIsH
	 gijQag2CNDVxEXlOK09I/yVdlvOpzjWToN8enY1KXgjtNUybEzrMtI74Ow+Ds5kwgA
	 kp3w8YERJuEq68yhVviKX2rgkxDvf4+85N23tJfx/NM5gPniFSLK+TEPYRyHfAFq2K
	 Tb/oIM3Qupx6zZncEIQJxRB8SluBDpmrQbu7SQFClncQxmJqhNM3U0+rd6uU7gEN6e
	 dK6MEafG3I3yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/30] iommu/fsl_pamu: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-14-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-14-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:02:20 +0000
Message-Id: <20260602110220.64D3B1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Assigning 64GB (1ULL << 36) to size_t *mapped_length causes a sile=
nt truncation to 0 on 32-bit platforms, leading to severe performance degra=
dation and kernel lockups.
--

commit 0bcd395ee310c27e90762eec37163a95fe19bc3f
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/fsl_pamu: implement iova_to_phys_length

This commit implements the iova_to_phys_length callback for the FSL PAMU
IOMMU driver. It configures the mapping to return the actual PTE mapping
size of the hardware window.

> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_dom=
ain.c
> index 9664ef9840d2c..643984ac6ae1c 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c

[ ... ]

> -static phys_addr_t fsl_pamu_iova_to_phys(struct iommu_domain *domain,
> -					 dma_addr_t iova)
> +static phys_addr_t fsl_pamu_iova_to_phys_length(struct iommu_domain *dom=
ain,
> +						dma_addr_t iova,
> +						size_t *mapped_length)
>  {
> +	if (mapped_length)
> +		*mapped_length =3D 0;
> +
>  	if (iova < domain->geometry.aperture_start ||
>  	    iova > domain->geometry.aperture_end)
> -		return 0;
> +		return PHYS_ADDR_MAX;
> +
> +	/*
> +	 * PAMU configures exactly one Primary PAACE entry per LIODN with the
> +	 * Multi-Window (MW) bit cleared and ATM =3D PAACE_ATM_WINDOW_XLATE,
> +	 * WBAL/TWBAL =3D 0. That is, every LIODN is backed by a single hardware
> +	 * mapping window of fixed size (1ULL << 36, i.e. 64GB, see
> +	 * pamu_config_ppaace()) performing an identity translation. The driver
> +	 * does not split this window into SPAACE sub-windows, so the entire
> +	 * aperture is one PAACE "PTE" entry. Return that single entry's size
> +	 * as mapped_length, matching the iova_to_phys_length contract that
> +	 * mapped_length reports the full size of the mapping entry which
> +	 * covers iova (not the remaining bytes from iova to its end).
> +	 */
> +	if (mapped_length)
> +		*mapped_length =3D 1ULL << 36;

[Severity: High]
Will assigning 1ULL << 36 (64GB) to a size_t pointer cause a silent=20
truncation to 0 on 32-bit platforms?

The FSL PAMU driver is used on 32-bit PowerPC architectures with 36-bit
physical addressing, where size_t is 32 bits wide. On these systems,=20
attempting to store 0x1000000000 into a 32-bit integer truncates to exactly=
 0.

If mapped_length is reported as 0, IOMMU core callers (like iommufd page
iterators or vfio_unmap_unpin) can receive a 0 mapped length, which triggers
a WARN_ON(!pgsize) and falls back to advancing by PAGE_SIZE (typically 4KB).

Stepping through a 64GB window in 4KB increments requires over 16.7 million
iterations.

Could this massive loop cause extreme log spam and system lockups?

> +
>  	return iova;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D13

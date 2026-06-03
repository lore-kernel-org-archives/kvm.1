Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1C3E171C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502661; cv=none; b=kPXqQMuCoE0lTvSmHrKoo9zzuF96a4FJgNQ9sravidfJTswpPRHMy/ejAsgZRNriNASPrzrnj2+iG+0VIuk+iO4aCjMLHJ1ttT+2ij0oQjPwuVyzGaoVdGK0a2/0dlBBq81wYa6z2vqlwY+0Vmd/FM9fBfJ5hybq8UFZ1y1dQ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502661; c=relaxed/simple;
	bh=KYUIGwa6B5YHoiTmSzxjqTElftkW/55qzfbdxBMjnyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5Q7/mGuM36ICI39Iaxkloq+6Ch7pO0OsxEOSfGTxZoCYUyGVUvlaf+9WB0BWUZ5ZH4s3vw5nAXgvtbEKd28EhU70w+ZxytcsSrVQ+HJiCG1OCc3phM2dFmDj3sFMyv+CubNQcwv5RYdW4TGTA01N+agR65m8RJhp8TOZvi2qfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDr/KEXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDr/KEXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C3B1F00893;
	Wed,  3 Jun 2026 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502657;
	bh=dpdIc91wItXzqrnMO8wUX8iqEybaTLD1ecU+xIUeeTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PDr/KEXnQ+k13At2QxIqM6C3b0eViiY81tY/umKAGepcowQE+cvb1TpARzK7dhihi
	 0s0VoM5bwpGKmXfCHqW0SaEQR3QluFB/0x4QJ9ipkE9uTzVQ7fwwuzNs0ppgGYo3ty
	 M6FmsEJHWXAqZKk928q0abhFm75/RHW9SJV8tiXJvF+2H26wA71czD3+Ao5Xe7F/ck
	 DrFXnvjTutaagnSyD2iQ2eHsozM0+F1jG0p8j1l5r0TVfCO1J77yLaiVXwfZQI9NV5
	 zcim1kUm5fedjh2gvArRSzU1WQL2SUlJQED9XhH/mkmy3DCePcsYBHxP3mV4WgWjLV
	 muMrc9o4CaMoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 21/32] iommu/tegra-smmu: implement
 iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-22-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-22-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:04:17 +0000
Message-Id: <20260603160417.83C3B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless page table access in `tegra_smmu_iova_to_phys_length` can=
 race with concurrent `unmap` operations, resulting in a Use-After-Free (UA=
F) on the page table memory.
--

commit 8bec8e55c0ad853218bde06b33f63906725b5a20
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/tegra-smmu: implement iova_to_phys_length

This commit implements the iova_to_phys_length callback for the Tegra
SMMU IOMMU driver. It returns the physical address and sets the mapped
length to 4K.

> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 67e7a7b925f0c..12f9bb623d874 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
[ ... ]
> @@ -813,10 +813,13 @@ static phys_addr_t tegra_smmu_iova_to_phys(struct i=
ommu_domain *domain,
> =20
>  	pte =3D tegra_smmu_pte_lookup(as, iova, &pte_dma);
>  	if (!pte || !*pte)

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless page
table access race with concurrent unmap operations?

tegra_smmu_iova_to_phys_length() calls tegra_smmu_pte_lookup() without hold=
ing
as->lock. tegra_smmu_pte_lookup() retrieves a pointer to a PTE within a page
table.=20

Concurrently, if an unmap operation for a different IOVA in the same page
table removes the last mapping, __tegra_smmu_unmap() (which holds the lock)
can call tegra_smmu_pte_put_use() to decrement the count and free the page
table via iommu_free_pages().

Could the lockless dereference of *pte here (and in the mask operation belo=
w)
read from freed page table memory if it races with such an unmap operation?
Should as->lock be held before calling tegra_smmu_pte_lookup() and across
the pointer dereference?

> -		return 0;
> +		return PHYS_ADDR_MAX;
> =20
>  	pfn =3D *pte & as->smmu->pfn_mask;
> =20
> +	if (mapped_length)
> +		*mapped_length =3D SZ_4K;
> +
>  	return SMMU_PFN_PHYS(pfn) + SMMU_OFFSET_IN_PAGE(iova);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D21

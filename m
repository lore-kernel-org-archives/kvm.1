Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44339B94D
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502332; cv=none; b=Nn7jzL7DDpSMIN0PoytY9QI8Vk97dqpz8XUewJejNXvgFY6N5ucbooVFOMFf47GGmB6R4JZmtiE8mcK3iCgoBBQlJ7w8wat6NDPJywERE9GfrtMpmvRcRhHEDXaLiMIAANzAWLV6Zgwl+QsoWrtcrcx8eaSdpqhCVdr1rZlf7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502332; c=relaxed/simple;
	bh=AznW+U7bHY3vpmLGO/G6OttxoNZ3RWWD5a+emWZtclI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rb9D3kCaB7ozHyapIY416RnH40zIS18rMV6XJNiFHSG3aHCp7O0eS/HhG47SHhAldlex9kGqs1lIel4LrflAIgK2hq5awLDQvlGCt4ZHGLZYRDhmQ1lEoJZEU0a48pxd385+Y1WHQgXuPo/GiiNRFi9mqBDRzMRVa1uBWPft6zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UigtCnTW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UigtCnTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86141F00893;
	Wed,  3 Jun 2026 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780502331;
	bh=Q4Na9HxTDcS3GGk/JY6lb5gsjbyKApToDHmq+kDWi3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UigtCnTWKlGurhOVEh8ybjFn+aWeciR7UpMBwJS8ZTVy2DZhEkrEE9Y0Ad7/vvYlS
	 WTEoO3vgrSeLjTm9xKbMALeb5mCZ6vTGoKvfFTp+fQCKXFu1ZdA4o6qQ1Be/UeAR50
	 gvyNcBGIiPYLZAnO0XDcFMsaspSkwF7Q5vi1W7CYdWUih5swigh8880HbMfzl6aehB
	 3N9QipybkYqX7vTQYMYrSQff1VIHPVU2CTRQB6raIjWYcbBhaMKFdLLzxBACRcMgvL
	 shyM8Q+ECF3W9GWzbymeYGDzSxiMoNP1uVttey7207KZVqRerwvwB9nKyGiXau11JO
	 QNK75PnrJa+ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/32] iommu/mtk_v1: implement iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-16-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-16-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 15:58:50 +0000
Message-Id: <20260603155850.D86141F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IOVA bounds checking leads to out-of-bounds array read/wri=
te on the `pgt_va` array.
--

commit 3d307c9faf5208f019d6a8f030da9330ce0aa29b
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu/mtk_v1: implement iova_to_phys_length
   =20
Implement iova_to_phys_length for MediaTek v1 IOMMU driver,
returning the actual PTE mapping size.
Also fix pre-existing bug: add page offset to physical address.

> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index ac97dd2868d4b..da41dda7620b8 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
[ ... ]
> -static phys_addr_t mtk_iommu_v1_iova_to_phys(struct iommu_domain *domain=
, dma_addr_t iova)
> +static phys_addr_t mtk_iommu_v1_iova_to_phys_length(struct iommu_domain =
*domain,
> +						    dma_addr_t iova,
> +						    size_t *mapped_length)
>  {
>  	struct mtk_iommu_v1_domain *dom =3D to_mtk_domain(domain);
>  	unsigned long flags;
> @@ -404,6 +406,13 @@ static phys_addr_t mtk_iommu_v1_iova_to_phys(struct =
iommu_domain *domain, dma_ad
>  	pa =3D pa & (~(MT2701_IOMMU_PAGE_SIZE - 1));

[Severity: High]
This is a pre-existing issue, but does this array access lack bounds
checking on the iova parameter?

Looking at the code just above this line in mtk_iommu_v1_iova_to_phys_lengt=
h():
    pa =3D *(dom->pgt_va + (iova >> MT2701_IOMMU_PAGE_SHIFT));

Since the driver doesn't appear to initialize domain.geometry.aperture_end
or set force_aperture =3D true, the generic IOMMU layer won't enforce an
upper limit on the IOVA.

If a user-space program using VFIO or a device with a >32-bit DMA mask
requests an IOVA >=3D 4GB, the index calculated by
(iova >> MT2701_IOMMU_PAGE_SHIFT) could exceed the bounds of the 4MB
pgt_va array, leading to an out-of-bounds read here.

This same out-of-bounds access pattern also seems to occur in
mtk_iommu_v1_map() and mtk_iommu_v1_unmap() when calculating pgt_base_iova,
where it can lead to memory corruption during out-of-bounds writes.

>  	spin_unlock_irqrestore(&dom->pgtlock, flags);
> =20
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D15

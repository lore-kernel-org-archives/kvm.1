Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D573B2FCC
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041138; cv=none; b=AcwFASGoF1XaWRcRHqVU4jF7qp9PFT03UxllEScMP9sCYK8F1VsxzeZD73AocjIWly4tyLmIdxM2nsSHkbMH9BZZsl+oO4mc63N1MHRF8OmH8gloHkj2/7YNF9JhC1EstgEgGq21ftnufMcWJbd+JWwuU9wyK7Nt6jDw6g6xMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041138; c=relaxed/simple;
	bh=gwBzjIYJfd0RT/9ubQ/npjqeQV9ArGaXZ6NannRMHeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q82e/cG3wuzLyBIANnXgdT1/l7l6E9RD1V16yOzwdjBfVkbzP/GsJSIfQaI3287jam72RlGna3607+tJhyIYC2Sug0R6+Rfsuz1BDGDAiTTpGn6MA1VRFE/zQU23hgCd2HUJJP0VkDawHlgmqD9CVfOCKIlV3q3pQSkIdbJh/Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru70M4fw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru70M4fw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A411F00893;
	Fri, 29 May 2026 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780041134;
	bh=7u76wrfUK7eB5YeUf95cuhJTEdxMtfgbt78NFIE+G74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ru70M4fwL5UbI8pZCT4J8+9SGLY9pl4H8Ja+3zleyjpkiWAUmaU5P9GC5mCFB8eFW
	 JR3hqoF3xaw1imYX0AwbhC2sroAYuv+0lrHvDd3u8W+q/jljIAmoCaPSXq33z0pu/a
	 PXAg7CNWMY8PaEs7rUta0YswEk88rKE1+9hHp3F3Sw+jTSzTMnL0SgvpoquZ2YOJUA
	 X+vXBBbgD/iwV4LME29litFI0gHUtYO/jHDE+ASD/zHo+siJgwXWeorouiJrZ8lKZP
	 dUXsmRqDuT5B1u4EmSM4QHsqCwJlf+pZT5CQ1rYqAtJgjflsgyJ+XWzIV/DyJXbE9V
	 Ren1wPJoPv1ag==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] Optimize VFIO and IOMMU mapping traversal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>
References: <20260529070932.2632907-1-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 07:52:14 +0000
Message-Id: <20260529075214.B3A411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The computed chunk size `len` in `vfio_unmap_unpin` is not cla=
mped to the remaining size of the target DMA region (`dma->size - pos`). Th=
is allows `len` to overshoot the DMA region boundary, causing out-of-bounds=
 unmapping and unpinning of adjacent memory.
--

commit 0f5b376f7b38b02730cdbd93b618b39e5e93f1d0
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

Optimize VFIO and IOMMU mapping traversal

This commit adds an iommu_iova_to_pgsize() implementation to query the
hardware mapping page size. It uses this in VFIO to optimize
vfio_unmap_unpin() by traversing the mappings at the IOMMU map granularity
rather than PAGE_SIZE.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de33..bf918a93a1591 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c

[ ... ]

> @@ -1191,11 +1191,24 @@ static long vfio_unmap_unpin(struct vfio_iommu *i=
ommu, struct vfio_dma *dma,
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * Query the actual IOMMU PTE mapping granularity at this IOVA
> +		 * to determine the guaranteed contiguous range. Use only the
> +		 * remaining portion within the current PTE from our position,
> +		 * in case we start from the middle of a large page mapping.
>  		 */
> -		for (len =3D PAGE_SIZE; pos + len < dma->size; len +=3D PAGE_SIZE) {
> +		pgsize =3D iommu_iova_to_pgsize(domain->domain, iova);
> +		if (!pgsize)
> +			pgsize =3D PAGE_SIZE;
> +		len =3D pgsize - (iova & (pgsize - 1));
> +		for (; pos + len < dma->size; len +=3D pgsize) {

[Severity: Critical]
Could this len calculation exceed the boundaries of the DMA region?

If the hardware mapped a large page that extends beyond the target vfio_dma
region, or if a partial unmap split the vfio_dma region but left the hardwa=
re
mapping intact, the calculated len can be larger than dma->size - pos.

The loop condition pos + len < dma->size prevents further iterations but do=
es
not clamp the oversized len. Does this result in unmap_unpin_fast() being
called with an out-of-bounds len, which would unmap and unpin pages belongi=
ng
to adjacent memory regions?

Would it be better to clamp len to the remaining size before the unmap?
len =3D min_t(size_t, len, dma->size - pos);

>  			next =3D iommu_iova_to_phys(domain->domain, iova + len);
>  			if (next !=3D phys + len)
>  				break;
> +			pgsize =3D iommu_iova_to_pgsize(domain->domain,
> +						      iova + len);
> +			if (!pgsize)
> +				pgsize =3D PAGE_SIZE;
>  		}
> =20
>  		/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529070932.2632=
907-1-guanghuifeng@linux.alibaba.com?part=3D1

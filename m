Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815EA3DB315
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398985; cv=none; b=JiO0M2TzvsoQP1dh19ggafgrAXVypdZM8+rdf+SafEzuFFis9u/IMJ+zRHv4Qv0dW3ai7gyM/MK+L54f3QvSKbF0FgUx1khZEPdl2pHUyWhN8FppfGuGjMTMv7UtUYmCQ7Y2ieJK70+dE4bZMbcQ0koNnAkg5KsibO2gHaq5GT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398985; c=relaxed/simple;
	bh=S8GIwAZTVbBlP10jmTqtvRssmn3p1C7eC1PRrYz4O+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XWYPMIDedKKtp9izpkM0IjAnbcbhLXy3X9BPkvnJCy4/xNwclhDg5C0gk6hhlEmnnYrVBvOduX5w6o3qQeyApbmY4LjK70orSqV23spkyzmUSmsJHI2LhHmAEnVizhakqhBtOk2V6Ex8yzjirOPta6vEsLXFXlbQKb/wnDxopfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1FMhSX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1FMhSX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0652F1F00893;
	Tue,  2 Jun 2026 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780398976;
	bh=L33cdy0fCz9vQ2Tnj7MrlOjjIL0SofNq3f6U31BlxA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q1FMhSX20veiDMuLee62AqIme2azyvdvwVUt3JUZtcLOaP1mxfJWJTkE1eb86g4uv
	 3dLiFLWwDYNh4Ri6Rsu+JttFSgWCsF4W05meXIId//LQmgHEe7YaeCldn0yqrgl/Za
	 Mr1fXzirYsrikAvTHMFQfFi7wQUwsHxD0pJZo7h2PZRBwB66iZLs41Y+B5bYdSdTzu
	 oJ0ev5LEng89UXmbeBB7zyvY9qbosG67Zwdi1P+CbgYai6DQq1+8u4gzItwqCPOpHi
	 vYqSxzalE+bAeWkOsGkUt9CQFqSNuhAlKDitgcVV0ow8EJvzFzCs6CMSWUJi2BYFNS
	 kopstH6SX2MlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 23/30] vfio/iommufd: use iova_to_phys_length for
 efficient unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260602104637.1219810-24-guanghuifeng@linux.alibaba.com>
References: <20260602104637.1219810-24-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 11:16:15 +0000
Message-Id: <20260602111616.0652F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Out-of-bounds memory unpinning and unmapping in vfio_unmap_unp=
in() due to missing length cap.
--

commit cb17e198ab7d19ccbb139738e16d729d0fafa5dc
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio/iommufd: use iova_to_phys_length for efficient unmap

This commit modifies the IOMMU unmap paths to use
iommu_iova_to_phys_length(), allowing the code to skip ahead by the
mapping granularity rather than walking the page tables in PAGE_SIZE
steps.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de33..c86315b1fcdad 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1177,25 +1177,41 @@ static long vfio_unmap_unpin(struct vfio_iommu *i=
ommu, struct vfio_dma *dma,
[ ... ]
>  		/*
>  		 * To optimize for fewer iommu_unmap() calls, each of which
>  		 * may require hardware cache flushing, try to find the
>  		 * largest contiguous physical memory chunk to unmap.
> +		 *
> +		 * Calculate remaining contiguous bytes within this PTE from
> +		 * our position, then try to join following physically
> +		 * contiguous PTEs.
>  		 */
> -		for (len =3D PAGE_SIZE; pos + len < dma->size; len +=3D PAGE_SIZE) {
> -			next =3D iommu_iova_to_phys(domain->domain, iova + len);
> +		len =3D pgsize - (iova & (pgsize - 1));
> +		for (; pos + len < dma->size; ) {
> +			size_t next_pgsize;
> +
> +			next =3D iommu_iova_to_phys_length(domain->domain,
> +							  iova + len,
> +							  &next_pgsize);
>  			if (next !=3D phys + len)
>  				break;
> +			if (WARN_ON(!next_pgsize || next_pgsize < PAGE_SIZE))
> +				next_pgsize =3D PAGE_SIZE;
> +			len +=3D next_pgsize;
>  		}

[Severity: Critical]
Does this code introduce an out-of-bounds regression when an IOMMU PTE cove=
rs
space beyond the current vfio_dma region?

If the IOMMU driver dynamically coalesces adjacent mappings into a larger P=
TE
(such as a 2M hugepage covering two contiguous vfio_dma regions), pgsize
can exceed the remaining dma->size.

Because len is initialized to pgsize - (iova & (pgsize - 1)) and is not
clamped to dma->size - pos, it appears this larger length will be passed do=
wn
to unmap_unpin_fast().

Could this result in unpinning physical pages that belong to adjacent DMA
regions, which might later be unpinned a second time when those adjacent
regions are processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602104637.1219=
810-1-guanghuifeng@linux.alibaba.com?part=3D23

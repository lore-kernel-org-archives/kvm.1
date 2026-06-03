Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2D3E3C47
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503291; cv=none; b=rVhTNegXWN+uv2xomQI88C88QARm2M1dO5+v/oEGPvvLk0uU3Jh+aXQnSmMot6g2h+WhFUdsYb6YRI+y2MyNqzMQZOZsVfdlxKuzlPvtZ7fQ+PNFKEHx8oZaEgvrH7OCMxeLMmILLqRar/3qP41tJmS42S5dGIfNjtyjsXuK1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503291; c=relaxed/simple;
	bh=H+/6Tz2hXqVGBVxRRP0+L6hhny1KGssGPtbyIlCcNfE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q8n/Ro6KkxmcXTHkMRIRdsAXVZ7Jd/4pEiRKGlSip0/KsGex8SmQJboaVyWgcgazb6Sa3MkF42+Fgm128sowM2byoIqffr0cic6OT0FsQziQudw16T6guZpEfeX7tBUicfxGGJGUB9FJ1zlNk1cIhTU0xVafVbQAz68YFJleCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOlcpH6p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOlcpH6p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14C91F00893;
	Wed,  3 Jun 2026 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503285;
	bh=A1D/bylSQB1V20Y3Ldpvg6e9ARsYjp9MQ3pz/cmwllQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOlcpH6pI8np60eTy4qeYJlz/Krydp+dGyJk/0zXNAmMeMPnncIBzWEPutByV1+ZD
	 fBu1Ex7Nmnf7N0kGScQowFyfB9fwQjhL3wWVc8G7eiCe5te797tZCMFWt6FQnrZG6I
	 MVis5h/+LfX4qLPF+La1VWOAsGrhhzYcvJYLNMf0OxLhOtJESzzNkosUvGTtveS5iS
	 ufj/oUA+avb8isFevkuecnYmhCxZhbAeOmbKG5JQAhY0C90IbxwKfQ+dqLjoHcwU5D
	 PweXClzHiT5gAqXWuL6WTqxsw7SqetwfDETScfPfc00vLaEc4fWXbmq2/4nwNTlwap
	 TgJV4Pv1L8/bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 23/32] vfio: use iova_to_phys_length for efficient
 unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-24-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:14:45 +0000
Message-Id: <20260603161445.A14C91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ARM SMMU translation fault mishandling leads to unbounded WARN_ON =
spam and a massive leak of pinned pages.
--

commit 4e6f222bdc9e32de4a4536a57f7ce9b046abb017
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

vfio: use iova_to_phys_length for efficient unmap
   =20
Use iommu_iova_to_phys_length() to get PTE page size, allowing
traversal by actual mapping granularity instead of PAGE_SIZE steps.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_ty=
pe1.c
> index c8151ba54de33..115d88d7003e8 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1177,25 +1177,42 @@ static long vfio_unmap_unpin(struct vfio_iommu *i=
ommu, struct vfio_dma *dma,
> =20
>  	iommu_iotlb_gather_init(&iotlb_gather);
>  	while (pos < dma->size) {
> -		size_t unmapped, len;
> +		size_t unmapped, len, pgsize;
>  		phys_addr_t phys, next;
>  		dma_addr_t iova =3D dma->iova + pos;
> =20
> -		phys =3D iommu_iova_to_phys(domain->domain, iova);
> -		if (WARN_ON(!phys)) {
> +		/* Single page table walk returns both phys and PTE size */
> +		phys =3D iommu_iova_to_phys_length(domain->domain, iova,
> +						  &pgsize);
> +		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX)) {
>  			pos +=3D PAGE_SIZE;
>  			continue;
>  		}
> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize =3D PAGE_SIZE;

[Severity: High]
How does this handle ARM SMMU Stage-1 domains where the iova_to_phys_length
callback delegates to arm_smmu_iova_to_phys_hard()?

When a translation fault occurs, arm_smmu_iova_to_phys_hard() returns 0 rat=
her
than PHYS_ADDR_MAX, and leaves pgsize as 0. Because 0 !=3D PHYS_ADDR_MAX, t=
his
check doesn't catch the fault.

Could this regression cause the WARN_ON(!pgsize) below to trigger and dump a
stack trace for every unmapped page in the region?

Additionally, when this falls through to unmap the page, unmap_unpin_fast()
correctly returns 0 unmapped bytes. This later hits the unmap loop break:

drivers/vfio/vfio_iommu_type1.c:vfio_unmap_unpin() {
        ...
        unmapped =3D unmap_unpin_fast(domain, dma, iova, len, phys, ...);
        if (!unmapped) {
                unmapped =3D unmap_unpin_slow(domain, dma, iova, len,
                                            phys, &unlocked);
                if (WARN_ON(!unmapped))
                        break;
        }
        ...
}

Does breaking out of this loop on the 0-byte unmap permanently skip and leak
any remaining pinned memory pages in the DMA region?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D23

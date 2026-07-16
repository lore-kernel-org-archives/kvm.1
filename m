Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF56332913
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216485; cv=none; b=GwDuHCHBw+R3QsIVcMmLRzucp/bn77LsZXjVjrEiwdjpbcd2raHyNnV0L1q83uWpLfAQpEV07xFP9YsYOn873oC9fnGJRzVOZcwp7Rhu3L6+gSJbpE5tYluHysMecqTv4agy2gP8AQAZb/aVftdJxcJlUfhsqYdjtlhuSOaOFQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216485; c=relaxed/simple;
	bh=I6DakvQi07t5HT3cxD4AOR+wrZ943nkYkvcpeYCPxDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIqtnEZvi4Txc71d4xfBAfPYp3aNb/DL5qKHNSCZJoIPfgc4S5a90NIPFl3tcldv4bBYWC52oPMQVk16UKYyUM2VnAViPFHZdn55QrAdPuA3vlmIutKU9q2VO6ReZxSinMEDsTYikcXSmh9MV9W3nH+F+rCGcE72NzAn1DmKpNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+yb7sNx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+yb7sNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DC01F000E9;
	Thu, 16 Jul 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216483;
	bh=9vJmtEa7ZvCe6+N4iC72T+uiuoXIKonH22FM7RGowQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m+yb7sNx+89/9D1RQ1uJHnFBgGXJN3zVeec5ckJZo+jjtkP0czbcGobj/5SZMhoC3
	 K2zq8KFj4Yw6alL394aY4ORe85vI7Uk9Vux2ATVRFwGZ7iVsaZ4vnz+xZGSn0ijwWT
	 2G6vIMzN2SQWMba9P5rM/nVnKGDZZhBqrRfBQRyCDa522Bp9U9W5HwT2m61EmIrIpE
	 zTdO5cVYjXoCxbF0scSTI+gMputZKjYLBcM1Cr5etPvwZQ3FlJaV9JwhxZ4YtrbOQj
	 SWsEr177tRttgRFcFzP9vjj47YYfIOViIHeDcBmwh42NE9KXfLC7bGqMvnmlCisUau
	 wZfbsGr5Nd6BQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/11] iommufd: Plumb dma-buf memory-type (RAM vs
 MMIO) through the phys map
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: media-ci@linuxtv.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <a716d496ec095e1f71bb5fc8be3e2559bbe914cc.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <a716d496ec095e1f71bb5fc8be3e2559bbe914cc.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:41:22 +0000
Message-Id: <20260716154123.32DC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Secondary domain attachments map MMIO DMA-bufs with BATCH_CPU_MEMO=
RY (IOMMU_CACHE) instead of BATCH_MMIO (IOMMU_MMIO), breaking DMA routing.
--

--- Patch [6]: [RFC PATCH 06/11] iommufd: Plumb dma-buf memory-type (RAM vs=
 MMIO) through the phys map ---
commit de7dbdc51049f527858115cc709f25b2cee585cb
Author: David Woodhouse <dwmw@amazon.co.uk>

iommufd: Plumb dma-buf memory-type (RAM vs MMIO) through the phys map

This commit plumbs the memory type of a dma-buf (CPU RAM vs MMIO) through
the IOMMU programming path. It adds an is_cpu_ram flag to dmabuf structures
to correctly choose between BATCH_CPU_MEMORY and BATCH_MMIO during mapping.
This prevents silent misrouting of device DMA on AMD-Vi when the physical
memory is RAM instead of a PCI BAR.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 2d4ea41460fdc..f9b2ae6d7e96c 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c

[ ... ]

> @@ -1106,9 +1108,15 @@ static int pfn_reader_fill_dmabuf(struct pfn_reade=
r_dmabuf *dmabuf,
>  	 * always filled using page size aligned PFNs just like the other types.
>  	 * If the dmabuf has been sliced on a sub page offset then the common
>  	 * batch to domain code will adjust it before mapping to the domain.
> +	 *
> +	 * The exporter's memory type (CPU RAM vs MMIO/BAR) selects the batch
> +	 * kind so downstream iommu_map sets IOMMU_CACHE for cache-coherent RAM
> +	 * or IOMMU_MMIO for BAR memory.  The kind was captured at map time by
> +	 * the exporter dispatch.
>  	 */
>  	batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
> -			  last_index - start_index + 1, BATCH_MMIO);
> +			  last_index - start_index + 1,
> +			  dmabuf->is_cpu_ram ? BATCH_CPU_MEMORY : BATCH_MMIO);
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does attaching a secondary domain map MMIO
DMA-bufs with BATCH_CPU_MEMORY instead of BATCH_MMIO?

When reading PFNs for a secondary domain, pfn_reader_fill_span() routes the
read to batch_from_domain() instead of pfn_reader_fill_dmabuf():

pfn_reader_fill_span() {
	if (span->is_used =3D=3D 2) {
		/* ... */
		batch_from_domain(
			&pfns->batch, area->storage_domain, area, ...);
		return 0;
	}
}

Then batch_from_domain() extracts PFNs from the already mapped domain and
unconditionally delegates to batch_add_pfn():

batch_from_domain() {
	/* ... */
	phys =3D iommu_iova_to_phys(domain, iova) - page_offset;
	if (!batch_add_pfn(batch, PHYS_PFN(phys)))
		return;
}

And batch_add_pfn() explicitly hardcodes BATCH_CPU_MEMORY:

static bool batch_add_pfn(struct pfn_batch *batch, unsigned long pfn)
{
	return batch_add_pfn_num(batch, pfn, 1, BATCH_CPU_MEMORY);
}

Could this silently overwrite the original memory type (e.g., BATCH_MMIO)
for secondary domain mappings, causing device DMA to misroute on AMD-Vi
even after this patch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D6

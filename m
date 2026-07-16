Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49F296BC8
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216034; cv=none; b=UdlpWJAM175QLLevhMdCJmgsCkdd57WXdUx5WtAUqDtDmL6ERC8AkhwY0l+gQIxwdmIazrNKILO97/v1LDvxqaiOhSsAL7cb0fCfwoZOtGGxtA11WB/TwuYcUzdKN2n62TnRKG8NW3uI07u31UZu4bl6eD/okMJMUv5uGABlfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216034; c=relaxed/simple;
	bh=1b54pgXLpHobTtmGY9H8KeIRNWMSbWotU15fOdA93mI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sVKt5oBUnpGLRAZzlYlXTDEHO3bMn+IOLdaV3M9YApzDmQwZQh0hbscLLJ0XtPK/gD6ZDwtumN8SusY0YjxXCX5nTKOJdyaJ2u7e3CFCpiI8/wQz8VgVCyUXBwoYwbu6swASXUhexSPI+6ZycplWcxDHHCgotowyNMgOrKvvW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdpBWijR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdpBWijR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B772C1F000E9;
	Thu, 16 Jul 2026 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216033;
	bh=ngb6bIAdXn8ygB+1BwodyPZ4MoSQbdldi0uaWZpeO7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdpBWijRGj0pELaN6593r5Vq3Dspl6Il2jeoPZQDVmh74spLOierYrVSKeXp67pF0
	 G+2GShSsgzyVfu9EiKUr5kwWibTqPfZ6FQRsIoVP0gjfz0M+HNJHvcdCVJszUFugFR
	 tn0Q6B4EeOoC341l7QSs+zVZZH88b5eTomPleBQaUPWxXf7lLvQyahfhm9g3PAsjzb
	 gFC+jLxr0UHMjtO+KcAJeSv3VVemjscqazmKpcTjpY4qDK80qWjGNXg/YrXYAHbwwj
	 SZqoK+th99vjLxc2G4wbgsQ1Z4yF5fSXneRATncrieglx0WLeB5sZnEDo4bzGTeTjr
	 0N3sA71SMUrTQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 05/11] iommufd: Look up private-interconnect phys
 via exporter symbols
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <23bae967aa2bf38b7696c5cbcdf003cf43e98358.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <23bae967aa2bf38b7696c5cbcdf003cf43e98358.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:33:52 +0000
Message-Id: <20260716153352.B772C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Mapping guest_memfd CPU RAM as uncached MMIO creates memory attrib=
ute aliasing, breaking bisection.
--

--- Patch [5]: [RFC PATCH 05/11] iommufd: Look up private-interconnect phys=
 via exporter symbols ---
commit a4bfbccbc028813d0ddd8502c6dc498ce23a16cb
Author: David Woodhouse <dwmw@amazon.co.uk>

iommufd: Look up private-interconnect phys via exporter symbols

This commit widens the dma-buf phys-map dispatch in iommufd to support
additional exporters by looking up a well-known symbol convention. It
initially tries a sample gmem provider before falling back to VFIO PCI.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 03c8379bbc347..2d4ea41460fdc 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c

[ ... ]

> @@ -1470,6 +1470,26 @@ sym_vfio_pci_dma_buf_iommufd_map(struct dma_buf_at=
tachment *attachment,
>  	if (rc !=3D -EOPNOTSUPP)
>  		return rc;
> =20
> +	/*
> +	 * Prototype: try the sample gmem provider's dma-buf exporter.  This
> +	 * mirrors the vfio-pci private-interconnect hook, and (like it) is
> +	 * meant to be replaced by a formal negotiated exporter op returning
> +	 * phys for iommufd.
> +	 */
> +	{
> +		extern int gmem_provider_dma_buf_iommufd_map(
> +			struct dma_buf_attachment *, struct phys_vec *);
> +		typeof(&gmem_provider_dma_buf_iommufd_map) gfn;
> +
> +		gfn =3D symbol_get(gmem_provider_dma_buf_iommufd_map);
> +		if (gfn) {
> +			rc =3D gfn(attachment, phys);
> +			symbol_put(gmem_provider_dma_buf_iommufd_map);
> +			if (rc !=3D -EOPNOTSUPP)
> +				return rc;

[Severity: High]
Will mapping guest_memfd CPU RAM as uncached MMIO cause memory attribute
aliasing issues here?

When gmem_provider_dma_buf_iommufd_map returns a physical address for RAM,
pfn_reader_fill_dmabuf() will hardcode it as BATCH_MMIO:

drivers/iommu/iommufd/pages.c:pfn_reader_fill_dmabuf() {
    ...
    batch_add_pfn_num(batch, PHYS_PFN(dmabuf->phys.paddr + start),
                      last_index - start_index + 1, BATCH_MMIO);
    ...
}

This causes batch_to_domain() to forcefully strip IOMMU_CACHE and apply
IOMMU_MMIO:

drivers/iommu/iommufd/pages.c:batch_to_domain() {
    ...
    if (batch->kind =3D=3D BATCH_MMIO) {
        iommu_prot &=3D ~IOMMU_CACHE;
        iommu_prot |=3D IOMMU_MMIO;
    }
    ...
}

On architectures like ARM64, this memory attribute aliasing between the
CPU (cacheable) and the IOMMU (uncached) can lead to a loss of coherency,
data corruption, or fatal SErrors.

Since the memory type plumbing is deferred to a later patch, could this
intermediate state introduce a bisection breakage if the sample provider
is utilized?

> +		}
> +	}
> +
>  	if (!IS_ENABLED(CONFIG_VFIO_PCI_DMABUF))
>  		return -EOPNOTSUPP;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D5

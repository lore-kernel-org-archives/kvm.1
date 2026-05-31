Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084B4256C6D
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 09:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780221285; cv=none; b=Cu5ES8NE+o4FfE4pQaswm21CXrEEQpWEcxerVPpwibMkT9iKdI6lIsWbsqSlwog8xEa0eJi0BlPP1t4hGKI72SrWKJE06TkHu2qc0nrTlOUIVF+I1+d9CSoJYY1Heg+8RpatPOS/pn+ualyTIbgdLd76omltzmxDBvl9K1tOSBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780221285; c=relaxed/simple;
	bh=YlYsCmmfRDudLxk3hRa6XH2v3oxD7aWPH6YRz0jjIww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ao5A5UTIoVcN6a4VQ+NMivEsXK/Jwq7iyl73f+pLijKeJf5Ml1Uesc7Oial6KKtaUsQNvek/WXuRIdGr5BWmV2cqWmcq5vb8LQh4fcG7qz2quOVdyGPHM7t7xc6E6wDV45T3p9BcXoM0zHpBTVxC4TRnkmsYn1iUN3CEdY49PHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE438uie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE438uie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C31F00893;
	Sun, 31 May 2026 09:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780221283;
	bh=tYbPN9GjrEtZ7SQhBKQJSW70vswm0VPEYF+giBEOpR8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NE438uieN91Rg9u4e/FdmK4xlxiiW8b+U/QqbPRAnbvewLJuilmYzabySeqg5HTeU
	 47Bz5/XkYmEKpaADUV7TZ/hT0Hdarkhzyjp+BHsqrJQrP5lx/pzPSk/d4oYKx3wmDy
	 Rr88EI1DbLuLpahLlbT4LmEp9e5iLEBToM1ntr/G1oE/eQZkS9BPzEWhvwqTIyr7rJ
	 5C55C2q8JOrwFzY/i9EnWq3w3HOblCvIm8YnEOvXYec8+dhNkOeyJ4Dvb6WAqxPiWx
	 VUA3JzwUtYLOpRRfaOjIFM9ZY02BEee4tB9WVR05b1ZPE86DhHCnth/fP/IONKauxC
	 4XP3do2j1zkWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
References: <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 09:54:43 +0000
Message-Id: <20260531095443.881C31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Out-of-bounds physical memory access in IOMMUFD due to non-pow=
er-of-2 mapping size returned by virtio-iommu.
- [Medium] Missing static inline stub for iommu_iova_to_phys_length when CO=
NFIG_IOMMU_API is disabled.
--

commit 1d85ac7114cff28b195e3c83a6653359f5181460
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommu: introduce iova_to_phys_length in iommu_domain_ops

Add iova_to_phys_length callback to struct iommu_domain_ops alongside
the existing iova_to_phys. The new callback returns both the physical
address and the PTE mapping page size in a single page table walk.

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d1a9e713d3a05..43323229a1df3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
[ ... ]
> @@ -2545,15 +2545,45 @@ void iommu_detach_group(struct iommu_domain *doma=
in, struct iommu_group *group)
>  }
>  EXPORT_SYMBOL_GPL(iommu_detach_group);
> =20
> -phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t i=
ova)
> +/**
> + * iommu_iova_to_phys_length - Translate IOVA and return mapping page si=
ze
> + * @domain: IOMMU domain to query
> + * @iova: IO virtual address to translate
> + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/=
1GB)
> + *
> + * Like iommu_iova_to_phys() but additionally returns the page size of t=
he
> + * PTE mapping at @iova through @mapped_length.
> + *
> + * Return: The physical address for the given IOVA, or 0 if no translati=
on.
> + */
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)

[Severity: Critical]
Is it possible for the underlying domain implementation to return a
non-power-of-2 length here?

If a driver like virtio-iommu implements iova_to_phys_length by returning
the size of the user mapping region stored in its interval tree
(e.g., mapping->iova.last - mapping->iova.start + 1), it can return an
unaligned or non-power-of-2 value (like 12KB).

Callers like IOMMUFD use bitwise math assuming the length is a power-of-2:

drivers/iommu/iommufd/pages.c:batch_from_domain() {
    ...
    npages =3D (pgsize - (iova & (pgsize - 1)) + page_offset) / PAGE_SIZE;
    for (i =3D 0; i < npages; i++) {
        if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
            return;
    }
    ...
}

VFIO does the same:

drivers/vfio/vfio_iommu_type1.c:vfio_unmap_unpin() {
    ...
    len =3D pgsize - (iova & (pgsize - 1));
    ...
}

When an unaligned or non-power-of-2 length is returned, pgsize - 1 is not
a valid bitmask, which can cause the formula to overestimate the remaining
contiguous length. This exposes unmapped physical memory, and could allow
an out-of-bounds physical memory access or unmapping lengths that exceed
the actual mapping.

Could this be documented to strictly require power-of-2 PTE page sizes,
or could the callers be updated to handle non-power-of-2 region lengths?

[ ... ]
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bf8a77a164e4d..29c7c042d400d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
[ ... ]
> @@ -958,6 +964,9 @@ extern ssize_t iommu_map_sg(struct iommu_domain *doma=
in, unsigned long iova,
>  			    struct scatterlist *sg, unsigned int nents,
>  			    int prot, gfp_t gfp);
>  extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_a=
ddr_t iova);
> +extern phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +					      dma_addr_t iova,
> +					      size_t *mapped_length);

[Severity: Medium]
Will this cause build failures for configurations without CONFIG_IOMMU_API?

It appears that the static inline stub for iommu_iova_to_phys_length() is
missing in the #else block for CONFIG_IOMMU_API in this header. Generic
drivers that use this API might encounter compilation and linkage failures
when IOMMU_API is disabled.

>  extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  			iommu_fault_handler_t handler, void *token);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531093637.3893=
199-1-guanghuifeng@linux.alibaba.com?part=3D1

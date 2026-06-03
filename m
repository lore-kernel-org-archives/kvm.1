Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D683E3D98
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503397; cv=none; b=jbEtHIfKycVctqa8WF2+PqDrJw5KYjjhfYV+j1gwo+oWMwkfmcwzIl9h4DIWpWProTnqwflx/7BP4PYVp8F7PecWQkPshwejz+GWjdzMmkFImCpyN1AiqTZ3dcEbOoxyGP83ahaRFanwf3fMQ2mZYg/ydrY72k28Go51V54N27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503397; c=relaxed/simple;
	bh=hXNR3H+qHMiUWGZ/L9/uMtoLnxy1VlcR51JDFnMn/A0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cuHOK+70bPbBEpd3bX9ih6+rCU8SXAgE3AglwNGiP0RRBSxNtAPp2Bxq9wLxLl1f8k7z3u6vObA4t7LhD18cQB86BC7WVaLEqnfqok9OJmAdszim2D+Lzq/BgqAzl+ehp/zrmnK7/YIdS+caCDs34M/C5PZg78bcZjHeX/9ipYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNinxKHB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNinxKHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DF01F00898;
	Wed,  3 Jun 2026 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503396;
	bh=j5fGxADU3mQWafBfSg8VVs2Lox8Z2fd+3++YWhnbvBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dNinxKHBMC8PhAvqbnaGyVzAtr4Z8s+J7xPk6fPL1rRI6gxnfiMyLm8XgjKye3XaF
	 BTTj+XbRKa43c3Py+cuE1Ivil/XIb/Z6fWZDngRn8RZjkG15PxZQdROlgQUI8VNJjz
	 4PZNZ9KfDmrth4bWAlzY1YdJs9vAxrT/78QKrV1yYXEcGneAjjCsUcoBftr7obbUju
	 XB7H/42nXWWKoUQRcUws/7yw5G5dW/mmKgjQh6qKo1tqygaiWHleRGds404wFW/mb8
	 ohFUPYR1H/QRuE+R5iIsY2YNTAqRA9PI895HVey3aLvpkv0UMPVJMNlUIxYTigJ7qx
	 AHVlKulfIH2Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 27/32] drm/panthor: switch to iova_to_phys_length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-28-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-28-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:16:35 +0000
Message-Id: <20260603161636.38DF01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The `iommufd` page batching incorrectly uses `pgsize` returned=
 by `iommu_iova_to_phys_length` as the contiguous length from an unaligned =
IOVA, leading to physical page boundary overshoots and unpinning of incorre=
ct pages.

Pre-existing issues:
- [High] The fallback loop in `panthor_vm_unmap_pages` incorrectly queries =
`iova + unmapped_sz` instead of `iova + offset + unmapped_sz`, leading to i=
ncorrect address checks and silent page table leaks when `offset > 0`.
--

commit f97ec54057d6791e1130bddbaac127660a0164bb
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

drm/panthor: switch to iova_to_phys_length

Migrate panthor_mmu to use ops->iova_to_phys_length(ops, iova, NULL)
instead of the deprecated ops->iova_to_phys.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 75d98dad7b1dd..3b635fc1f6518 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -903,7 +903,7 @@ static void panthor_vm_unmap_pages(struct panthor_vm =
*vm, u64 iova, u64 size)
>  			 * are out-of-sync. This is not supposed to happen, hence the
>  			 * above WARN_ON().
>  			 */
> -			while (!ops->iova_to_phys(ops, iova + unmapped_sz) &&
> +			while (ops->iova_to_phys_length(ops, iova + unmapped_sz, NULL) =3D=3D=
 PHYS_ADDR_MAX &&
>  			       unmapped_sz < pgsize * pgcount)
>  				unmapped_sz +=3D SZ_4K;

[Severity: High]
This is a pre-existing issue, but does this fallback loop in
panthor_vm_unmap_pages() incorrectly query the page table when offset > 0?

By passing iova + unmapped_sz instead of iova + offset + unmapped_sz, it se=
ems
this completely omits the block's offset. Since earlier blocks might have b=
een
successfully unmapped, won't iova_to_phys_length() spuriously return
PHYS_ADDR_MAX?

This could cause the fallback loop to improperly advance unmapped_sz to its
maximum (pgsize * pgcount), blindly skipping the failing block without
unmapping any remaining mapped pages inside it, permanently leaking page ta=
ble
entries and defeating the recovery logic.

I also noticed an issue in drivers/iommu/iommufd/pages.c that appears to
have the same root cause.

In batch_from_domain():

>		phys =3D iommu_iova_to_phys_length(domain, iova - page_offset,
>						  &pgsize);
>		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX))
>			break;
>		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
>			pgsize =3D PAGE_SIZE;
>
>		/*
>		 * pgsize is the contiguous length from the page-aligned
>		 * iova, so npages is simply pgsize / PAGE_SIZE.
>		 */
>		npages =3D pgsize / PAGE_SIZE;
>		npages =3D min_t(unsigned long, npages,
>			       last_index - start_index + 1);

[Severity: Critical]
Does this calculation blindly use the full block size (pgsize) without
subtracting the offset within the block?

Most IOMMU page table implementations return the full block size of the
underlying page table entry, regardless of whether iova is unaligned.
If queried at an offset of 4KB into a 2MB block, iommu_iova_to_phys_length()
returns phys corresponding to the 4KB offset and pgsize =3D 2M.

Since iommufd allows unmapping or tracking sub-regions, start_index can
correspond to an IOVA in the middle of a huge page. The code then computes
npages =3D 2M / 4K =3D 512 and iterates from i =3D 0 to 511, adding
PHYS_PFN(phys) + i.

Since there are only 511 pages remaining in the block, won't this loop
overshoot the physical block boundary by 1 page, incorrectly appending the
first page of the adjacent physical block?

When these collected PFNs are later passed to batch_unpin(), the kernel will
call unpin_user_page() on a page that is not part of the mapping, decrement=
ing
its refcount. Could this create a use-after-free vulnerability?

The identical logic flaw exists in raw_pages_from_domain():

>		phys =3D iommu_iova_to_phys_length(domain, iova - page_offset,
>						  &pgsize);
>		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX))
>			break;
>		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
>			pgsize =3D PAGE_SIZE;
>
>		npages =3D pgsize / PAGE_SIZE;
>		npages =3D min_t(unsigned long, npages,
>			       last_index - start_index + 1);

[Severity: Critical]
Does this code also overestimate the remaining contiguous pages when reading
from an unaligned IOVA?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D27

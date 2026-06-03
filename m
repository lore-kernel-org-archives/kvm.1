Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308413A9611
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503307; cv=none; b=alOU/DrkNVDcoH792iquwuqzvniMZWC02dXO93o+CZybSS7CEeXorRJKyx2JSYUAEknCH0h7v9MkeaiyyKtTnJ3wGNfmszlZ8FZ9cZ8ZoFU/Kua7X0biAEb926pfIZFR2n17qj1PkS5WrEk4XT1EfZ3yWd8fwtFFd18l5cbLOtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503307; c=relaxed/simple;
	bh=ISPN741uy2OffDlSVm9a0rtGzwNIeT7/T1pLIq86xd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zws/7cBq9pYSLaEMfekHBdlqvkYR39S47iL9/CVbA7a31N2J1Ws6j9WQ1pmU9MvVvmWsIVrdDNkvkDQSvwlEBjaC2odqB8YZuwnG+9Ua5ju0ytaQVtUy28fd4sD6MIgvU0Hf6DMJ7IZGcOSoPzW2+9eg2kmvuFCJgIOV8XTKmBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkXC5atd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkXC5atd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F88C1F00893;
	Wed,  3 Jun 2026 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780503291;
	bh=lSXqSwRkDXjVCrWFmvR7GKcVB/Ye+eQOxhuOlbDT/Bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EkXC5atd4lPJEIMz6VQXjp0xzcjINi4BFu0i9YDzwcw2eN0CqBUdTNzxdGhTARFge
	 lIgEo+qGu270Uehyl3V5c42wIliijyYvtZKMB6PlIX5lqGKClTWDJlDgbBT1weEzM1
	 qcsPpohVjneBp65d7aOsWTNouBiWDRPjCZJBWLyRlYIwhBfAQ2Sbo+c8t/Cr8je82H
	 QC+/gGe6HpJbXoS9kgt6k4vZGPhm/lMR4JBorTnvAw0P7AM48Y3JjKYL8rwUu4rm2G
	 +jdkgbiEWpL467mO9qmJgAe8eyPL4pnJhZP0X6JXgzSdQFT1pntR834pvJy+1OqJua
	 YV91rrSR+m5Lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/32] iommufd: use iova_to_phys_length for efficient
 unmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guanghui Feng" <guanghuifeng@linux.alibaba.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
References: <20260603151804.1963871-25-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 16:14:51 +0000
Message-Id: <20260603161451.9F88C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] batch_from_domain and raw_pages_from_domain misinterpret the m=
apped_length returned by iommu_iova_to_phys_length() as the remaining conti=
guous length, resulting in out-of-bounds physical memory exposure and IOVA =
loop corruption.
- [High] Returning early from batch_from_domain when iommu_iova_to_phys_len=
gth fails causes a hard infinite loop in iopt_area_unpin_domain.
- [High] Silent failure when iommu_iova_to_phys_length() returns PHYS_ADDR_=
MAX leads to an uninitialized array of page pointers being returned and use=
d by callers.
--

commit fbf04fecd109bf03fe5fc6f1c1c874977e8904ac
Author: Guanghui Feng <guanghuifeng@linux.alibaba.com>

iommufd: use iova_to_phys_length for efficient unmap

This commit updates batch_from_domain and raw_pages_from_domain to use
iommu_iova_to_phys_length to retrieve both the physical address and mapping
contiguous length. This allows the unmap path to process actual mapping
granularities instead of walking page tables for every PAGE_SIZE.

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 9bdb2945afe1e..40a2fe9adf9c9 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -417,17 +417,42 @@ static void batch_from_domain(struct pfn_batch *bat=
ch,
>  	if (start_index =3D=3D iopt_area_index(area))
>  		page_offset =3D area->page_offset;
>  	while (start_index <=3D last_index) {
> +		size_t pgsize;
> +		unsigned long npages;
> +		unsigned long i;
> +
>  		/*
> -		 * This is pretty slow, it would be nice to get the page size
> -		 * back from the driver, or have the driver directly fill the
> -		 * batch.
> +		 * Use iova_to_phys_length to get both the physical address
> +		 * and the contiguous mapped length in a single page table
> +		 * walk, allowing us to skip ahead by the contiguous region
> +		 * size instead of walking page tables for every PAGE_SIZE.
> +		 * Query at page-aligned iova so pgsize covers from page start.
>  		 */
> -		phys =3D iommu_iova_to_phys(domain, iova) - page_offset;
> -		if (!batch_add_pfn(batch, PHYS_PFN(phys)))
> -			return;
> -		iova +=3D PAGE_SIZE - page_offset;
> +		phys =3D iommu_iova_to_phys_length(domain, iova - page_offset,
> +						  &pgsize);
> +		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX))
> +			break;

[Severity: High]
If iommu_iova_to_phys_length() returns PHYS_ADDR_MAX on the first iteration
and triggers this break, the function returns with 0 PFNs added to the batc=
h.

When the caller iopt_area_unpin_domain() processes this, it computes:

batch_last_index =3D start_index + batch->total_pfns - 1;
start_index =3D batch_last_index + 1;

If total_pfns is 0, start_index does not advance. Could this cause an
infinite loop in iopt_area_unpin_domain() while holding locks?

> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize =3D PAGE_SIZE;
> +
> +		/*
> +		 * pgsize is the contiguous length from the page-aligned
> +		 * iova, so npages is simply pgsize / PAGE_SIZE.
> +		 */
> +		npages =3D pgsize / PAGE_SIZE;
> +		npages =3D min_t(unsigned long, npages,
> +			       last_index - start_index + 1);
> +		if (!npages)
> +			npages =3D 1;
> +
> +		for (i =3D 0; i < npages; i++) {
> +			if (!batch_add_pfn(batch, PHYS_PFN(phys) + i))
> +				return;
> +		}

[Severity: Critical]
Since iommu_iova_to_phys_length() returns the total size of the mapped block
in pgsize, what happens if the iova being queried is unaligned within that
block?

For example, if the function is querying a 1MB offset into a 2MB huge page,
phys will correctly be the offset physical address, but pgsize will still be
2MB. The npages calculation would result in 512 pages. Adding the full 512
pages starting from the offset physical address would overshoot the mapped
block by 1MB.

Does this expose unmapped or unrelated physical memory to the batch, and
cause iova to be advanced incorrectly, skipping valid IOVAs?

[ ... ]

> @@ -445,11 +470,36 @@ static struct page **raw_pages_from_domain(struct i=
ommu_domain *domain,
>  	if (start_index =3D=3D iopt_area_index(area))
>  		page_offset =3D area->page_offset;
>  	while (start_index <=3D last_index) {
> -		phys =3D iommu_iova_to_phys(domain, iova) - page_offset;
> -		*(out_pages++) =3D pfn_to_page(PHYS_PFN(phys));
> -		iova +=3D PAGE_SIZE - page_offset;
> +		size_t pgsize;
> +		unsigned long npages;
> +		unsigned long i;
> +
> +		/*
> +		 * Resolve the contiguous mapped length together with the
> +		 * physical address so we can fill multiple struct page
> +		 * pointers per page table walk when the IOMMU uses large
> +		 * pages. Query at page-aligned iova so pgsize covers from
> +		 * page start.
> +		 */
> +		phys =3D iommu_iova_to_phys_length(domain, iova - page_offset,
> +						  &pgsize);
> +		if (WARN_ON(phys =3D=3D PHYS_ADDR_MAX))
> +			break;

[Severity: High]
If phys is PHYS_ADDR_MAX and triggers this early break,
raw_pages_from_domain() returns the out_pages pointer without fully
populating the requested array.

Its caller iopt_pages_fill_from_domain() ignores the populated count and
returns success. Because the underlying array in iopt_pages_fill_xarray()
may be allocated without __GFP_ZERO, the unpopulated entries contain
uninitialized heap data.

When these pages are eventually stored in the xarray and unmapped, will
unpin_user_page() be called on these uninitialized pointers and cause
kernel memory corruption or panics?

> +		if (WARN_ON(!pgsize || pgsize < PAGE_SIZE))
> +			pgsize =3D PAGE_SIZE;
> +
> +		npages =3D pgsize / PAGE_SIZE;
> +		npages =3D min_t(unsigned long, npages,
> +			       last_index - start_index + 1);
> +		if (!npages)
> +			npages =3D 1;
> +
> +		for (i =3D 0; i < npages; i++)
> +			*(out_pages++) =3D pfn_to_page(PHYS_PFN(phys) + i);

[Severity: Critical]
Similar to the issue in batch_from_domain(), if the queried iova is unalign=
ed
within a larger mapped block, pgsize will reflect the entire block's size.

Calculating npages from the total pgsize instead of the remaining length in
the block will cause this loop to extrapolate struct page pointers past the
bounds of the mapped block.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603151804.1963=
871-1-guanghuifeng@linux.alibaba.com?part=3D24

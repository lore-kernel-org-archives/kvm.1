Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5675C13E02A
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712584; cv=none; b=OC8+Tbp5tRZx862OieJ7ovbmqgUmeWI3VWiVLqIZSDecwmc9ovgB8cm57uH2WAKN1HZ4oGzcUZQtEDjl9CvaHVcRPnvvTo3QCdQDVSGS/9Ci1eux90IEL8t5Kdrl5HEpvh908hGYyQA1IQfL3edJx9pAZ4BnhbB3mXB0M4cIE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712584; c=relaxed/simple;
	bh=i+8TfioAGFt4do6YDXQ7APHCj04YbhbkAvigQaXMcyU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FVMGzD27oB4Lau+9Gczh+ZwnbGucM62W9btmvZj1XXJ04aV16HApx0YFkdoCXOvvZlmGr2b+hIodC+/yGzsIiUoEb9rlD711p6kFROlBaoG+psX3UCO1Ds3RbitWJ8j6fC0qJ7rgRVXrUjZLAjyz/oGV1qPDCCotXjc76eB6nOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0rMoNtp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0rMoNtp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF511F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712583;
	bh=IctE2aWCuL9d4xiUTXXf9Bdj1z0VVWAgoFgMxUtfb3A=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=V0rMoNtp6/UZmrj2ptsmBAQEItRm4aekxyy6QPKSAzZ/48b+4xcrwO4pCQfWKPgnY
	 s1B8O06IRCSL8ElQFEDt9ZArnUUFqcQqKAfQfiA22aGlaA7bhTGByjFwsT9kLQJekj
	 UARHvmdVWGuB63qfYAf+ak3hLuM0hc56835LU9NpYd43uww29q6zBz1KrVQzTUGZok
	 sVplVHjFQnE4knMTFcgpUObYvTNT4rBKynvVkxnezbR3XF8LTsFVERORdtOmt4LSMY
	 kdIiIULEeZY2pehE6x29uJHIbNdTAnn9HUmGdRwpK+ZBe6nZs+u4bRDw/vyYnCtyi/
	 mjN3BFzoChWhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/14] userfaultfd: add UFFD_FEATURE_RWP_ASYNC for
 async fault resolution
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-12-kas@kernel.org>
References: <20260525113737.1942478-12-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:36:22 +0000
Message-Id: <20260525123622.DEF511F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Asynchronous UFFD RWP resolution creates invalid clean+writabl=
e page table entries, violating the software invariant that writable PTEs m=
ust be dirty.
--

commit 1c4c9040fe9c09a64714fa2d71bf254acc3ebf2f
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFD_FEATURE_RWP_ASYNC for async fault resolution

This commit introduces asynchronous resolution for read-write protection
(RWP) faults in userfaultfd. It allows the kernel to auto-resolve faults
on protected pages by restoring PTE permissions in-place without blocking
the faulting thread.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cd32bd51e3118..803fbc41e5014 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c

[ ... ]

> @@ -2291,7 +2291,30 @@ static inline bool can_change_pmd_writable(struct =
vm_area_struct *vma,
> =20
>  vm_fault_t do_huge_pmd_uffd_rwp(struct vm_fault *vmf)
>  {

[ ... ]

> +	pmd =3D pmd_modify(vmf->orig_pmd, vma->vm_page_prot);
> +	/* pmd_modify() preserves _PAGE_UFFD; drop it on resolution */
> +	pmd =3D pmd_clear_uffd(pmd);
> +	pmd =3D pmd_mkyoung(pmd);
> +	if (!pmd_write(pmd) &&
> +	    vma_wants_manual_pte_write_upgrade(vma) &&
> +	    can_change_pmd_writable(vma, vmf->address, pmd))
> +		pmd =3D pmd_mkwrite(pmd, vma);

[Severity: Critical]
Does this create an invalid clean and writable PMD entry?

When upgrading the PMD to writable using pmd_mkwrite(), it looks like
pmd_mkdirty() also needs to be called. Writable page table entries must be
dirty.

If a clean anonymous page undergoes an asynchronous RWP resolution, it could
be upgraded to a clean and writable PMD. This allows modifications to the
page without the kernel's knowledge, which could cause the reclaim mechanism
to discard the modified page instead of writing it to swap.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f63718296cc20..a5ff9018af060 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c

[ ... ]

> @@ -6070,7 +6070,37 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, str=
uct vm_area_struct *vma,

[ ... ]

> +		ptl =3D huge_pte_lock(h, mm, vmf.pte);
> +		pte =3D huge_ptep_get(mm, vmf.address, vmf.pte);
> +		if (pte_protnone(pte) && huge_pte_uffd(pte)) {
> +			unsigned int shift =3D huge_page_shift(h);
> +
> +			pte =3D huge_pte_modify(pte, vma->vm_page_prot);

[Severity: Critical]
Can this result in a clean and writable PTE for shared mappings?

The huge_pte_modify() function applies vma->vm_page_prot, which might be
writable for shared mappings. If the original PTE was clean, applying the
writable protection could create a clean and writable entry without
explicitly ensuring the dirty bit is set.

> diff --git a/mm/memory.c b/mm/memory.c
> index 3e393881031d2..89c9a44d07ced 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

[ ... ]

> @@ -6137,8 +6137,31 @@ static void numa_rebuild_large_mapping(struct vm_f=
ault *vmf, struct vm_area_stru
> =20
>  static vm_fault_t do_uffd_rwp(struct vm_fault *vmf)
>  {

[ ... ]

> +	pte =3D pte_modify(vmf->orig_pte, vmf->vma->vm_page_prot);
> +	/* pte_modify() preserves _PAGE_UFFD; drop it on resolution */
> +	pte =3D pte_clear_uffd(pte);
> +	pte =3D pte_mkyoung(pte);
> +	if (!pte_write(pte) &&
> +	    vma_wants_manual_pte_write_upgrade(vmf->vma) &&
> +	    can_change_pte_writable(vmf->vma, vmf->address, pte))
> +		pte =3D pte_mkwrite(pte, vmf->vma);

[Severity: Critical]
Does this write upgrade need to set the dirty bit?

Similar to the PMD case above, upgrading to a writable PTE via
pte_mkwrite() without also calling pte_mkdirty() creates an invalid clean
and writable page table entry.

For comparison, the NUMA fault handling in do_numa_page() correctly sets
both when performing a write upgrade.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D11

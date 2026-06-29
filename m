Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B53FF8A4
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736401; cv=none; b=aReetQhjwntQJVBwWDLuCpF35K0AJPLbhJPO7GZZojnKBsOzgawAeDEUSPM7clCPVhXvH3MLRdi4/26n8K28h/zqvUG3yvUVrvHeU0sn5wk+Sjg6dDvu4HPgwo7/UkHCTrBu8HbuTpnwImiDMxe8uTgKQGE01D8DbeAt3PAPXvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736401; c=relaxed/simple;
	bh=4KiDUgC3XUubVXJ72QMkOkYpiotmTAJGplioSZ0NKpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t20M0frCewZp358z+UCundGPEtwERT4jVjWxWYhYP/+OKzvng29dfAETf+6UzRIOuj+YIetlxglnm+yeDTeIzCq+U6hvjATHMwHEq4UWYAscs4XBjIyKBosvnFP95D1Abq/xYUI68GweYH7n4RAEbu7KySg0P8ND1NyNKydxIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7J65pXR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7J65pXR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF891F000E9;
	Mon, 29 Jun 2026 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782736400;
	bh=zWPX/uQqChQ/okR+Zz41pi9Iv4LRCGx7h1uE+dPx5h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7J65pXRA4g8s9Ti7z2lIFmlM0DJe05VLTBvPrtNZ0Fm0Tyv9DXTb9LAjhaH57QJd
	 1EcZTIZn1O+FxpIsf5o3oczuDD2eJgIahoTy1HZWEl6Tm000NJo9gDCpogjBCHyAmt
	 1kGobCqfS5IWTy+phCU7FYEbeIxj6eGrW0s5cfdO20495uYjSuyraeFB/2cgt/ZLCa
	 CzqL4Nxxty4p+AhvvoKU23mY0EVBSczGLKgfxeBw7x5jpWp+6pGTl9BUAW9NbPf2yt
	 c3N0mBZCYCfLW1vkuL7NpsoV3DHP9rI2AotEMK3r1P7zBtj4hwYLoK8Ct4DOZtSyrB
	 aBXWsbgPrPXDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/15] mm: preserve RWP marker across PTE rewrites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629120749.566063-8-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-8-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:33:19 +0000
Message-Id: <20260629123320.1EF891F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] do_swap_page bypasses RWP tracking on non-exclusive private pa=
ges by resolving COW faults internally, dropping the RWP marker.
- [High] move_huge_pmd() and move_huge_pte() unconditionally overwrite the =
protection bits of ALL present huge entries in RWP-enabled VMAs, omitting m=
arker validation.
- [High] RWP markers (PAGE_NONE PTEs) are incorrectly made writable by subs=
equent pte_mkwrite/pmd_mkwrite calls, violating PTE invariants.
--

commit 5e6bf53c7874736a0aaea6decc0c390ca2b40f26
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: preserve RWP marker across PTE rewrites

This commit wires the preservation of the uffd RWP marker (PAGE_NONE
semantics) through various paths that rewrite PTEs, PMDs, and huge PTEs
on a VM_UFFD_RWP VMA. This includes swap, migration, fork, and mprotect
paths to prevent tracking leaks on next access.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
[ ... ]
> @@ -2539,8 +2545,16 @@ bool move_huge_pmd(struct vm_area_struct *vma, uns=
igned long old_addr,
>  			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>  		}
>  		pmd =3D move_soft_dirty_pmd(pmd);
> -		if (vma_has_uffd_without_event_remap(vma))
> +		if (vma_has_uffd_without_event_remap(vma)) {
> +			/*
> +			 * See __copy_present_ptes(): normalise RWP PMDs so
> +			 * the destination starts accessible instead of taking
> +			 * a numa-hinting fault on first access.
> +			 */
> +			if (pmd_present(pmd) && userfaultfd_rwp(vma))
> +				pmd =3D pmd_modify(pmd, vma->vm_page_prot);

[Severity: High]
Does this unconditionally overwrite the protection bits of all present PMDs
in RWP-enabled VMAs? By omitting a pmd_uffd(pmd) check, this could strip
legitimate write permissions from private VMAs or inject write permissions
into clean shared pages when mremap() is called on a VM_UFFD_RWP VMA with
mixed RWP-protected and accessible huge pages.

>  			pmd =3D clear_uffd_wp_pmd(pmd);
> +		}
>  		set_pmd_at(mm, new_addr, new_pmd, pmd);

[ ... ]
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
[ ... ]
> @@ -5060,10 +5075,22 @@ static void move_huge_pte(struct vm_area_struct *=
vma, unsigned long old_addr,
>  		huge_pte_clear(mm, new_addr, dst_pte, sz);
>  	} else {
>  		if (need_clear_uffd_wp) {
> -			if (pte_present(pte))
> +			if (pte_present(pte)) {
> +				/*
> +				 * See __copy_present_ptes(): normalise RWP
> +				 * PTEs so the destination starts accessible
> +				 * instead of taking a numa-hinting fault on
> +				 * first access.
> +				 */
> +				if (userfaultfd_rwp(vma)) {
> +					pte =3D huge_pte_modify(pte, vma->vm_page_prot);

[Severity: High]
Is a huge_pte_uffd(pte) check missing here as well? Without it, any mremap()
on an RWP-registered VMA could incorrectly modify all present huge PTEs
regardless of their actual marker status.

> +					pte =3D arch_make_huge_pte(pte, huge_page_shift(h),
> +								 vma->vm_flags);
> +				}
>  				pte =3D huge_pte_clear_uffd(pte);

[ ... ]
> diff --git a/mm/memory.c b/mm/memory.c
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> @@ -896,6 +896,10 @@ static void restore_exclusive_pte(struct vm_area_str=
uct *vma,
>  	if (pte_swp_uffd(orig_pte))
>  		pte =3D pte_mkuffd(pte);
> =20
> +	/* See do_swap_page(): restore PAGE_NONE for RWP */
> +	if (pte_swp_uffd(orig_pte) && userfaultfd_rwp(vma))
> +		pte =3D pte_modify(pte, PAGE_NONE);
> +
>  	if ((vma->vm_flags & VM_WRITE) &&
>  	    can_change_pte_writable(vma, address, pte)) {
>  		if (folio_test_dirty(folio))

[Severity: High]
Could this create an invalid clean+writable PTE? If the folio is clean,
pte_mkdirty() is skipped but the subsequent code calls pte_mkwrite() on
the PAGE_NONE PTE. Writable PTEs must be dirty to avoid hardware faults on
architectures without hardware A/D bit management.

[ ... ]
> @@ -5041,6 +5068,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	if (pte_swp_uffd(vmf->orig_pte))
>  		pte =3D pte_mkuffd(pte);
> =20
> +	/*
> +	 * A page reclaimed while RWP-protected carries the uffd bit on
> +	 * its swap entry. Re-apply PAGE_NONE on swap-in so the first access
> +	 * still traps as an RWP fault. pte_modify() preserves _PAGE_UFFD.
> +	 */
> +	if (pte_swp_uffd(vmf->orig_pte) && userfaultfd_rwp(vma))
> +		pte =3D pte_modify(pte, PAGE_NONE);
> +
>  	/*
>  	 * Same logic as in do_wp_page(); however, optimize for pages that are
>  	 * certainly not shared either because we just allocated them without

[Severity: High]
Similar to restore_exclusive_pte() above, does this lead to a clean+writable
PAGE_NONE PTE during a read fault? In do_swap_page(), if it is a read fault,
pte_mkwrite() is called but pte_mkdirty() is skipped, which violates the
clean+writable PTE invariant.

[Severity: Critical]
What happens later in do_swap_page() for non-exclusive private pages on a
write fault?

Since the RWP marker is restored as PAGE_NONE, do_swap_page() will eventual=
ly
call do_wp_page() to resolve the COW fault. However, wp_page_copy() appears
to allocate a new page and map it with full accessible permissions, missing
the PAGE_NONE protection.

Does this completely bypass the userfaultfd RWP boundary for shared or
forked swapped-out pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629120749.5660=
63-1-kirill@shutemov.name?part=3D7

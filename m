Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62740D56F
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329653; cv=none; b=MRbaLgjw2QZXu6zpC3FeU+4VR2PWdOshLzg3yFPTPVFoHEXMhM6lBi3m+CpEmNvGpNBu0H/yEwWtk5XCvZwDk3ZsWNWz7u6BISLL4DIibkafHWdeErEBQfYL2I4BMzTl303WSp9WskzGdNPko4r2UZ5SRMs6n1J+SRd+UGR4haU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329653; c=relaxed/simple;
	bh=Fj5zX0TvFAUcnITEjkJifq1T5acN6r9QeGeFT42FQoc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jBhwCn+vUtCNlA+3IyJ3YynZCNIM3qgCQydO5d6MPhfHDQAVCOyfd3k4HZljlJ9C7PJHCi0QCq3IqhUUpcOCbSLhuMJQjy7hgqhAfcTALpCW/c8MTdxBsK9nHKiZ5IhbgJsX2/7Sa3ClRx1nnyIyAbeDyVFLnkTfKuNH3ItiMtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2YzAz0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2YzAz0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F521F000E9;
	Mon,  6 Jul 2026 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329649;
	bh=8vmwigdfZTM7GuYLrdl6QPvwyGhz2tpLQUnXU0ZgpnA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V2YzAz0B7Rp1cQ4tOD9VJ5pNKb2s3FSHiCmRzWqY3yXHUAXF93FByZdKdzElT511l
	 wvpGqhcZfhKEzxiqF7EiDIB8gQHPPiL79wg17Zym5NNArGS+F+RAWreTKUcdyeGoDW
	 8iLLXI/0oMq7GN25VXA/zIyAjmCccKqnZ4fdG9LL+Q20IX3lNiCVKvv/2LaPrEcoQ8
	 TBUwsEbkJtmgqxcyEXkPyxfM4cndphNH2RkUE0cTlx4b0hMfDnuoceS1c8YsII7SKq
	 +XlXyUy0kLwCi8gTVtY3Zr7TlAnEMH99DPkWbwKY2rJB90o6zBQkCpLH2bI9G6X5dU
	 WLzDAEd/Q1+aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 07/15] mm: preserve RWP marker across PTE rewrites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260706084805.8400-8-kirill@shutemov.name>
References: <20260706084805.8400-1-kirill@shutemov.name>
 <20260706084805.8400-8-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:20:48 +0000
Message-Id: <20260706092049.08F521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Unconditional arming of the RWP marker on moved pages during U=
FFDIO_MOVE destroys resolved page states and corrupts non-present huge PMDs.
--

commit e8dc073d377e5c18e627781dbdae660ee5f20a44
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: preserve RWP marker across PTE rewrites

This commit wires the preservation of the uffd PTE bit and PAGE_NONE
marker through various paths that rewrite PTEs on VM_UFFD_RWP VMAs,
including swap, device-exclusive, migration, fork, and mprotect.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index aca2f10fc1f1b..7ee7651202e2a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c

[ ... ]

> @@ -2846,6 +2867,13 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_=
t *dst_pmd, pmd_t *src_pmd, pm
>  		_dst_pmd =3D move_soft_dirty_pmd(src_pmdval);
>  		_dst_pmd =3D clear_uffd_wp_pmd(_dst_pmd);
>  	}
> +
> +	/* Re-arm RWP on the moved PMD if dst_vma is RWP-registered. */
> +	if (userfaultfd_rwp(dst_vma)) {
> +		_dst_pmd =3D pmd_modify(_dst_pmd, PAGE_NONE);
> +		_dst_pmd =3D pmd_mkuffd(_dst_pmd);
> +	}
> +
>  	set_pmd_at(mm, dst_addr, dst_pmd, _dst_pmd);
> =20
>  	src_pgtable =3D pgtable_trans_huge_withdraw(mm, src_pmd);

[Severity: Critical]
Does this corrupt non-present PMDs like migration entries?

In move_pages_huge_pmd(), if the source is a non-present huge PMD
(such as a migration entry), the code takes the !src_folio path.
Applying pmd_modify() with PAGE_NONE to this entry will set the present
bit, because PAGE_NONE contains the present bit.

If a user thread accesses this corrupted migration entry, won't the page
fault handler treat it as a present PMD, call pmd_folio(), and dereference
the swap offset/type data as a physical PFN, causing a panic?

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index ec1880d181711..4fca0409b7d7c 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1292,6 +1292,13 @@ static long move_present_ptes(struct mm_struct *mm,
>  		if (pte_dirty(orig_src_pte))
>  			orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
>  		orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);
> +
> +		/* Re-arm RWP on the moved PTE if dst_vma is RWP-registered. */
> +		if (userfaultfd_rwp(dst_vma)) {
> +			orig_dst_pte =3D pte_modify(orig_dst_pte, PAGE_NONE);
> +			orig_dst_pte =3D pte_mkuffd(orig_dst_pte);
> +		}
> +
>  		set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
> =20
>  		src_addr +=3D PAGE_SIZE;

[Severity: Critical]
Can this unconditional modification destroy the resolved state of the PTE?

In move_present_ptes(), the source PTE might have already been resolved
and have valid access state. By unconditionally applying PAGE_NONE to the
destination PTE regardless of the source PTE's state, won't this force a
spurious RWP fault on the next access?

> @@ -1373,6 +1380,9 @@ static int move_swap_pte(struct mm_struct *mm, stru=
ct vm_area_struct *dst_vma,
>  	orig_src_pte =3D ptep_get_and_clear(mm, src_addr, src_pte);
>  	if (pgtable_supports_soft_dirty())
>  		orig_src_pte =3D pte_swp_mksoft_dirty(orig_src_pte);
> +	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
> +	if (userfaultfd_rwp(dst_vma))
> +		orig_src_pte =3D pte_swp_mkuffd(orig_src_pte);
>  	set_pte_at(mm, dst_addr, dst_pte, orig_src_pte);
>  	double_pt_unlock(dst_ptl, src_ptl);
> =20
> @@ -1399,6 +1409,13 @@ static int move_zeropage_pte(struct mm_struct *mm,
> =20
>  	zero_pte =3D pte_mkspecial(pfn_pte(zero_pfn(dst_addr),
>  					 dst_vma->vm_page_prot));
> +
> +	/* Re-arm RWP on the moved PTE if dst_vma is RWP-registered. */
> +	if (userfaultfd_rwp(dst_vma)) {
> +		zero_pte =3D pte_modify(zero_pte, PAGE_NONE);
> +		zero_pte =3D pte_mkuffd(zero_pte);
> +	}
> +
>  	ptep_clear_flush(src_vma, src_addr, src_pte);
>  	set_pte_at(mm, dst_addr, dst_pte, zero_pte);
>  	double_pt_unlock(dst_ptl, src_ptl);

[Severity: Critical]
Does unconditionally arming the RWP marker here in move_swap_pte() and=20
move_zeropage_pte() cause similar issues with state loss or spurious faults=
=20
when the pages are moved via UFFDIO_MOVE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706084805.8400=
-1-kirill@shutemov.name?part=3D7

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60723D890B
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087214; cv=none; b=VHsN2gaGOXM1n3QMdj6LuOSedIPdBJ368RExuEGlszbE74yZELjiqgHC5AwgdFv+Xidd6wLDM3ZlCfi1Rfz3d3dWJnSeGtfzDEE2hB/DxwnvbmjGr2MVFc3upwrw9tpvvJKzmfyNOq9jp79OWriNtJgvFXofS0eietYt22+asf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087214; c=relaxed/simple;
	bh=mP2epvc9T4mlgCSTPWFtQpJPnDLfvi0yGfAF9PaSvts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3ZXHUx4UmmjSeVmh91fYlaCTqjp9uCfp3Mv4Oa75Syr1lH6Ry/2ea3OcKZUBv2j9vgeV0JGzpWqluMqMv2BFXaffgwBIzriPxMfaVaJMtZ5meKLGIY1SrNsmYI5kAb4eGWAzKxxAqJbsV2CZyzil0YnQ/lBc+34g9OS78ETYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=absKX2AN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="absKX2AN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E601F000E9;
	Fri,  3 Jul 2026 14:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087212;
	bh=R896rwygW4lMvFH0CSWBLZdEAkYTQ6TFgS4zdLnVEq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=absKX2AN6TMir5gIFVHvD91FAtjpVI9Ro3brqVRRtvzwxkufHBEWPGpkwDOISMtXd
	 q/k4J59vPxiebnz2CFkzMaKKlyCnKbOcxilZh1r691lpikjzzR7ac/SSYd6RqB/V0S
	 3vTm1erd7CUxDtv/AVpwQY45IhuSWw1iPe4Xcb/rD64TbUD+Ib6Z3UBgbmM+deAHuq
	 Ft56YkFMztdwL+zf0crt/IGh2rTtHjMuE78SwZnQR0gTN3UU7W5vht3wVfN+v3ZvtL
	 6xo5oBA8Xg+5mKr4tDTXJMag1pbi2/rXvUImmV7cCjE0L2u7IDQXLZblajunGH/0Pl
	 57N9Ktigwe5zQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/15] mm: rename uffd-wp PTE accessors to uffd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-4-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-4-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:00:11 +0000
Message-Id: <20260703140011.99E601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] copy_hugetlb_page_range() corrupts migration and hwpoison entr=
ies by calling huge_pte_clear_uffd() on non-present swap entries.
--

commit 0b0eb26ee7d795e29edb6848da6b35e60e8b4ec9
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: rename uffd-wp PTE accessors to uffd

Userfaultfd RWP will reuse the uffd-wp PTE bit to mark access-tracking PTEs.
This patch mechanically renames the internal uffd-wp accessors to uffd to=20
reflect the broader usage, without introducing behavior changes.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835e..d0c81a056ae2a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
[ ... ]
> @@ -4918,10 +4918,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst=
, struct mm_struct *src,
>  		softleaf =3D softleaf_from_pte(entry);
>  		if (unlikely(softleaf_is_hwpoison(softleaf))) {
>  			if (!userfaultfd_wp(dst_vma))
> -				entry =3D huge_pte_clear_uffd_wp(entry);
> +				entry =3D huge_pte_clear_uffd(entry);

[Severity: Critical]
This is a pre-existing issue, but does copy_hugetlb_page_range() corrupt
migration and hwpoison swap entries here?

The function calls huge_pte_clear_uffd() on non-present swap entries. This
applies the present PTE mask (e.g., _PAGE_UFFD) instead of the swap PTE mask
(_PAGE_SWP_UFFD). Because these bits reside at different positions (such as
bit 58 vs bit 3 on arm64, or bit 10 vs bit 2 on x86), applying the present
PTE mask to a swap entry inadvertently modifies other fields.

On arm64, this clears a bit inside the swap offset, which corrupts the
physical page frame number (PFN) stored in the migration entry. On x86, it
alters the swap type. When these corrupted swap entries are later faulted
in, the kernel may map the wrong physical page or panic.

This seems reachable if a process using userfaultfd WP forks while a hugetlb
page in the VMA is under migration or is hwpoisoned. The child VMA does not
inherit the WP flag, so the code attempts to clear the uffd bit on the swap
entries during the copy.

>  			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
>  		} else if (unlikely(softleaf_is_migration(softleaf))) {
> -			bool uffd_wp =3D pte_swp_uffd_wp(entry);
> +			bool uffd =3D pte_swp_uffd(entry);
> =20
>  			if (!softleaf_is_migration_read(softleaf) && cow) {
>  				/*
> @@ -4931,12 +4931,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst=
, struct mm_struct *src,
>  				softleaf =3D make_readable_migration_entry(
>  							swp_offset(softleaf));
>  				entry =3D swp_entry_to_pte(softleaf);
> -				if (userfaultfd_wp(src_vma) && uffd_wp)
> -					entry =3D pte_swp_mkuffd_wp(entry);
> +				if (userfaultfd_wp(src_vma) && uffd)
> +					entry =3D pte_swp_mkuffd(entry);
>  				set_huge_pte_at(src, addr, src_pte, entry, sz);
>  			}
>  			if (!userfaultfd_wp(dst_vma))
> -				entry =3D huge_pte_clear_uffd_wp(entry);
> +				entry =3D huge_pte_clear_uffd(entry);

[Severity: Critical]
This is a pre-existing issue, but the exact same swap entry corruption
appears to happen here for migration entries as well.

>  			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
>  		} else if (unlikely(pte_is_marker(entry))) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D3

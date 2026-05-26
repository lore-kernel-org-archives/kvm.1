Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E138424D
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 13:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802160; cv=none; b=EVoViZoNq9wwEaYVyi3EAhk0pkg0WA6BucpsQlivk+QcmzBqLBE/wAL5mvFK0dppiaQj6b3ZNEk9QB0gS7lULOJQzDNFaCFecxo8N5fJ1DAcf0wyIgoL7s16WJRNYQMwf1LDR6PiFjWH2rnPqZ57OnwqqhONZd47LpzXIP+e4Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802160; c=relaxed/simple;
	bh=bWs5iBHaZpaDceS+ISlKl30xwFuON0KQHCBvXgOeZpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JV5zGiOdPULG2p+J3NCM+VyCW0hlmf5Gzgb/6Jre9AxmlJV2wIn5KnPAwvgJR19nZVLLAqAI4AFCzQ8uE5ABKh1pbHNmWU02OdDAcDbzHYBUgXXaxKd/fD8GaX7eTmfF0z1MTbWfmbIKeyetnluLZkZz0PCAFBxhOsBnVpeFnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGfRs7C7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGfRs7C7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84591F000E9;
	Tue, 26 May 2026 13:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802158;
	bh=v+mD3T1/Y50iRZ86jhhx2i/GaX49aeqF++iG6Je5h2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGfRs7C7seZsPU1p2DYR8SwTkqk/52ltDy5I2G9ga/msmKaX9kD+iXTlFd+HmFG1b
	 u51CbbPjFOafCer010ddADNeeBUEZ5l211QZEATJScfXog76QPgkjSzsHrE2pyRtsf
	 5oHLPq7D+KFk2DCujqtF7MQgyDsXJmFWUM/794lacGaJBD1GvuAZBhLBlBXVuekUYg
	 LDm4dwhRF/i5XzrDIlbkaGoMz+vd/pS1k6y+LjMyzE7ql8kgc0r/WOOL3YVY6tLhNp
	 GU6Ifcx0+x9qLZrYbdLhg8e5HVFBOf9d7WE+bHDU19PATIlrDipd9RDlwh8wC11GQD
	 /D9Mck/ztFdYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/18] mm: rename uffd-wp PTE accessors to uffd
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-8-kirill@shutemov.name>
References: <20260526130509.2748441-8-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 13:29:18 +0000
Message-Id: <20260526132918.C84591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] copy_hugetlb_page_range() incorrectly applies huge_pte_clear_u=
ffd() to non-present swap entries (HWPoison and Migration entries), which f=
ails to clear the intended bit and can corrupt the swap entry's offset.
--

commit e93aa2eb8e2d0c3ad18e5c1d814ca772bba7232e
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: rename uffd-wp PTE accessors to uffd

This commit mechanically renames uffd-wp PTE accessors, capability queries,
and scan enums to drop the -wp suffix. This prepares the codebase for
userfaultfd RWP to reuse the same PTE bit for access tracking.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835e..d0c81a056ae2a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4918,10 +4918,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst=
, struct mm_struct *src,
>  		softleaf =3D softleaf_from_pte(entry);
>  		if (unlikely(softleaf_is_hwpoison(softleaf))) {
>  			if (!userfaultfd_wp(dst_vma))
> -				entry =3D huge_pte_clear_uffd_wp(entry);
> +				entry =3D huge_pte_clear_uffd(entry);

[Severity: Critical]
This is a pre-existing issue, but doesn't this incorrectly apply the
present-PTE clear function to a non-present swap entry?

For non-present entries like hwpoison or migration entries, shouldn't we use
pte_swp_clear_uffd() instead of huge_pte_clear_uffd()?=20

Since huge_pte_clear_uffd() targets the present-PTE bit index, which on
architectures like arm64 is located at a different bit (e.g., bit 58) than
the swap PTE bit index (bit 3).

Migration entries store the page PFN in the swap offset. Could clearing the
wrong bit accidentally corrupt the PFN? When the migration completes, this
corrupted PFN could then be restored into the PTE.

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
This isn't a bug introduced by this patch, but this shares the same issue as
above. We are clearing the UFFD bit on a migration entry using
huge_pte_clear_uffd().=20

Is it possible to change this to pte_swp_clear_uffd() to avoid corrupting
the migration entry's PFN?

>  			set_huge_pte_at(dst, addr, dst_pte, entry, sz);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D7

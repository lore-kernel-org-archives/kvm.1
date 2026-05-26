Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97C400E19
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779804954; cv=none; b=sUQ1HAzpn4eBcYPBn4LiKWVogr6y9pHPMuOv79LcpkZHSL6MKGpwG/o5iJhlIU5tIjFsjyJt22sBkGOeOW2SvRKwTO+2wZVWHsJmYrgDh5LE/6KfO6SDFFL7oQ5E9T2N3xBQo/oCYyhGFNF6aPh/YxlD1Zqj7UUEIcWKFMhz8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779804954; c=relaxed/simple;
	bh=ZPn9WYCwCXK6jZkbk1AjzJH06YfdNqEomASfJAT/kgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RJy6J9t0AJAeOXNHSghckiAKxE3zOzOWpsuYHgxZKBrxUNDq5Whq0jWe5umsrsLGyab/ps4m+s5SURTa/xVHnyzxR3KqbHAJH45gCRyeTNLhJd6auM9fbAvke8RNudc20D4RI8PKwWTDhkOTAEvEljq3N7fMNCVfeOU6rNd2mrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/PaG32L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/PaG32L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64F51F000E9;
	Tue, 26 May 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779804950;
	bh=l8qwrj6K1+8P8eAT/Wym7s8cb68sETyJfJFEbWqI9og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/PaG32Lp/X0jT6ciE859inLddF3gXIHRWZ4Wwulog+zL7OlGaFEmMxeKm++nhs3/
	 yRSiprHRN9QNUuhpiwQY0tICdBP+KMxq3eRFJYKmcILxy1UDiz8l+An33JrNpVY1UX
	 lBLSxzRRlZfdawFi0zHAQTt/CPviX8zK/dBk1zf9bLMHYzVIKCe63gU9J00gouphkf
	 Lz3AgnVev4/1iAqd4zDZnCH++Rzh7qTSasHqxMWOOX0qGZ82QSU6zYYY0shzR+OEO4
	 TpqVupNwwLDUXNBsKwSqi9hz1S53MFEzVoGOdVyIenpDzRwjqP/aotsavh4sr4h4IX
	 wDn0JpNYIUJrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/18] mm: preserve RWP marker across PTE rewrites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260526130509.2748441-11-kirill@shutemov.name>
References: <20260526130509.2748441-11-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 14:15:49 +0000
Message-Id: <20260526141550.B64F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] UFFD-WP bypassed during early COW due to the creation of a hardwar=
e-writable PTE that carries the UFFD-WP marker.
--

commit ba2faed46707cba7c55a2140714d82ba45c22e4e
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
Subject: mm: preserve RWP marker across PTE rewrites

This commit ensures the uffd PTE bit survives any kernel path that
rewrites a PTE on a VM_UFFD_RWP VMA. It wires the preservation logic
through multiple paths including swap, migration, fork, and mprotect.

> diff --git a/mm/memory.c b/mm/memory.c
> index c4fd5cb4a08f8..06473285c0dcc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
[ ... ]
> @@ -1088,9 +1092,13 @@ copy_present_page(struct vm_area_struct *dst_vma, =
struct vm_area_struct *src_vma
>  	/* All done, just insert the new page copy in the child */
>  	pte =3D folio_mk_pte(new_folio, dst_vma->vm_page_prot);
>  	pte =3D maybe_mkwrite(pte_mkdirty(pte), dst_vma);
> -	if (userfaultfd_pte_wp(dst_vma, ptep_get(src_pte)))
> -		/* Uffd-wp needs to be delivered to dest pte as well */
> +	if (userfaultfd_protected(dst_vma) && pte_uffd(ptep_get(src_pte))) {
> +		/* The uffd bit needs to be delivered to the dest pte as well */
>  		pte =3D pte_mkuffd(pte);

[Severity: High]
This is a pre-existing issue, but does this code allow UFFD-WP monitoring
to be bypassed during early COW for pinned pages?=20

When maybe_mkwrite() is called for a writable VMA, it unconditionally sets
the hardware writable bit. If the source PTE was UFFD-WP protected,
pte_mkuffd() adds the software marker, but it doesn't clear the hardware
writable bit. Because pte_wrprotect() is not called here to disarm the write
permission, the newly allocated exclusive page appears to remain hardware
writable.

Could this allow the CPU to silently permit writes without triggering a page
fault, completely bypassing userfaultfd-wp tracking?

> +		/* Restore PAGE_NONE so the RWP marker keeps trapping */
> +		if (userfaultfd_rwp(dst_vma))
> +			pte =3D pte_modify(pte, PAGE_NONE);
> +	}
>  	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>  	return 0;
>  }
[ ... ]
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4d75b69d42728..0d8d39cd88885 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
[ ... ]
> @@ -4843,8 +4843,16 @@ hugetlb_install_folio(struct vm_area_struct *vma, =
pte_t *ptep, unsigned long add
> =20
>  	__folio_mark_uptodate(new_folio);
>  	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
> -	if (userfaultfd_wp(vma) && huge_pte_uffd(old))
> +	if (userfaultfd_protected(vma) && huge_pte_uffd(old)) {
>  		newpte =3D huge_pte_mkuffd(newpte);

[Severity: High]
This is also a pre-existing issue, but does hugetlb_install_folio() share
the same UFFD-WP bypass concern?

The new huge PTE is constructed with make_huge_pte(vma, new_folio, true),
which sets the writable bit. When huge_pte_mkuffd() propagates the marker,
it does not appear to revoke the hardware write access, similar to the
copy_present_page() path above.

> +		/* Restore PAGE_NONE so the RWP marker keeps trapping. */
> +		if (userfaultfd_rwp(vma)) {
> +			unsigned int shift =3D huge_page_shift(hstate_vma(vma));
> +
> +			newpte =3D huge_pte_modify(newpte, PAGE_NONE);
> +			newpte =3D arch_make_huge_pte(newpte, shift, vma->vm_flags);
> +		}
> +	}
>  	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte, sz);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526130509.2748=
441-1-kirill@shutemov.name?part=3D10

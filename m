Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905E3D3314
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087839; cv=none; b=bXORl0u2g6aYhzAAnnSwrpQhUTjuSqGpFavYzYORiZPNqs9GCARcvTK/pElmqCRbI8+P4bcvuwSEFjaxfeHXIWXwogQG5wRdoOmEdOfOXYms6JCI6WlA/oov0HYcYx2PxAXpj/E1wwnA+kIORVJOmS6LRUKCwjxy3Eg2eXSvykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087839; c=relaxed/simple;
	bh=ZYA8ZicpCajA6mR7OdArj+HpzWZV3DN4vSHE/w9GXTw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RaGsmx3637mXujo32UDMuJa6Z7WtHOfBqBE8/2f6SNHNiL2TZ5K34W75yplfLMYeDZimZMw2a3PbGP+7w6+DE4b5agYV/tk0dNAuwYDQdnGEYUwx7pGt04P+tsi2T1E3GwLP7tT6pEfu1/H096C17FI+vZZtLiG7jHufn3E5NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0TyLeRt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0TyLeRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C741F000E9;
	Fri,  3 Jul 2026 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783087837;
	bh=PqkmBOQmeVDhkDwRyogOVe1Ich3IX5tVuW03BRXuJN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0TyLeRtUT4oDDE9IYVd9XbCm/eQebglPZV4wDSCf03F/7ZvRXcQT8VRmQu9gHaAQ
	 XToQpDozrW83sFEfp9b5XlpWrNjclj1nD0ZzFpRx51XM+SNwB4i7Q4KVo907pfRAwx
	 Q+nfstvvBfpkx1wyzU21Y3RQIZbXt4AJbw05aH7bW10uUXxutVTNz9iDMEWMgi6kxq
	 l8Ics86TCZN34hJ+zw6RbuaVOsrAa7wXulh1FGMzJrJ4lDcTPq2G15qHLLr9JY00hw
	 xpVxBTCghow8RQEoYeoWD5DesDOJUcmfQJ5GjqCUazcvh8jYVYEJZrGAYQdyGku0kI
	 FwrlDISOyeC6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 06/15] mm: add MM_CP_UFFD_RWP change_protection()
 flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-7-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-7-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:10:36 +0000
Message-Id: <20260703141037.89C741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Unnecessary splitting of file-backed THPs when applying userfaultf=
d RWP.
- [High] UFFD RWP protection is silently bypassed on reclaimed file-backed =
pages because PTE markers are intentionally skipped.
- [Medium] Missing safety check and unimplemented logic for UFFD RWP in PUD=
-sized THPs.
--

commit 78f87ff63726a93ba1fde6b06abbe7f59d5ff035
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: add MM_CP_UFFD_RWP change_protection() flag
   =20
Preparatory patch. Add the change_protection() primitive that
userfaultfd RWP will use.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 5b60862684aa6..b352b0dfe1ba2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c

[Severity: Medium]
Could this change miss updating change_huge_pud() to reject
MM_CP_UFFD_RWP_ALL?

Currently, change_huge_pud() explicitly rejects MM_CP_UFFD_WP_ALL since
anonymous PUDs are not yet supported. By omitting a similar check for
MM_CP_UFFD_RWP_ALL, an anonymous PUD could be modified to PAGE_NONE without
the _PAGE_UFFD bit.=20

Would this cause future faults to be misidentified as NUMA or mprotect faul=
ts
if anonymous PUDs are introduced?

[ ... ]

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 8340c8b228c67..7dcc94e7bfd60 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
[ ... ]
> @@ -325,6 +327,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>  	long pages =3D 0;
>  	bool is_private_single_threaded;
>  	bool prot_numa =3D cp_flags & MM_CP_PROT_NUMA;
> +	bool uffd_rwp =3D cp_flags & MM_CP_UFFD_RWP;
>  	bool uffd_wp =3D cp_flags & MM_CP_UFFD_WP;
>  	int nr_ptes;

[Severity: High]
Does skipping PTE markers for uffd_rwp on pte_none entries allow silent
protection bypass under memory pressure?

When memory pressure reclaims a file-backed page protected with
UFFDIO_RWPROTECT, try_to_unmap_one() in mm/rmap.c clears the PTE to pte_non=
e()
without preserving the UFFD state.

Since change_pte_range() explicitly skips installing markers when uffd_rwp =
is
set and oldpte is pte_none():

mm/mprotect.c:change_pte_range() {
        ...
        } else if (pte_none(oldpte)) {
                if (likely(!uffd_wp))
                        continue;
        ...
}

Would the page fault handler subsequently repopulate the PTE with normal
RW permissions from the page cache? This appears to lose the read-write
protection once a page is reclaimed.

[ ... ]

> @@ -428,7 +441,7 @@ pgtable_split_needed(struct vm_area_struct *vma, unsi=
gned long cp_flags)
>  	 * (e.g. 2M shmem) because file thp is handled differently when
>  	 * split by erasing the pmd so far.
>  	 */
> -	return (cp_flags & MM_CP_UFFD_WP) && !vma_is_anonymous(vma);
> +	return (cp_flags & (MM_CP_UFFD_WP | MM_CP_UFFD_RWP)) && !vma_is_anonymo=
us(vma);
>  }

[Severity: High]
Does this logic unnecessarily split file-backed THPs when applying
MM_CP_UFFD_RWP?

When UFFDIO_RWPROTECT is applied to a file-backed THP, change_pmd_range()
evaluates pgtable_split_needed(). Since this now returns true for
MM_CP_UFFD_RWP on non-anonymous VMAs, it forces __split_huge_pmd().

For file-backed THPs, splitting clears the PMD and creates unpopulated PTEs.
Because RWP intentionally skips installing markers for unpopulated PTEs, the
protection can be silently bypassed. Is it possible to avoid splitting here
since RWP does not require PTE markers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D6

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EE401A3C
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736821; cv=none; b=NX+umJVEayYkyF9fp2rLpJ0QSkdGjXP/evbdk3AYXFxgrK70Oz0XI4/d7JOLqRvMzv0mgIzJiwSVCzgxtEkY62sa3z+GhRbsPIBnbX2L+0QM9ROQcOB6OiQD973UPJ7KGp5Wgkj40KE7AaXPknrv1jCdxx6XNMR3bg8ZPuEI0Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736821; c=relaxed/simple;
	bh=EZ5vnA7buQPeiKXRc7zV3e0r9DnWF0YOpGJYUpP4BEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EVfcJNDXHonqoBdv33b7F202/M72yPjStNGRhq813wU5TTiE9y5AMx7IHvI63Fd6dkDI2Pw+9q9sfTJ+gYyAGzjhxfQqeowzUnMXIo1N0agYWn+WFjWoJL8D55bkShjN3DxYAsjLExc+t93stER1+gNnfp5UufmLq0SwYhqqmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJvnEhZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJvnEhZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02361F000E9;
	Mon, 29 Jun 2026 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782736820;
	bh=7W56bPeni0TTgFiTl5WG5rRXJeZw54s8eacVxFPl7Kk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PJvnEhZXSZK6cIsT3gSHBhY50Sf71fYusw2XGaqA4p5VXbtj3mZyGiECZQD4hR7qr
	 MvFQieqEWDtQn3orPtqXLcFnpkifxBWbMF9m7kjs1kNFTfVxT9cdQvmSFxf6i/7p52
	 hQ4nc1pI9n+whJJtyqtNyR95xeE+pZXmo+XBsylGQUpo/GnGIV8SoI0WRktfhOm/22
	 EI4e6Z+mBKnCHit4GWbgCs6LjyM67LcUYS7HcrxtyoCAjD+Ygg4iS2xMxdFq7N2Hqf
	 UKRhzA5PG4b8mtkt8W6FTsbB4C4rJNFo7i2uMeNpgaIWi3Ys5gh3uWX/iFhnJyuDju
	 0mrg3B1oQHJ7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/15] userfaultfd: add UFFDIO_REGISTER_MODE_RWP and
 UFFDIO_RWPROTECT plumbing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629120749.566063-10-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-10-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:40:19 +0000
Message-Id: <20260629124019.B02361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] userfaultfd_clear_vma() modifies page tables before write-locking =
the VMA, allowing concurrent page faults to leak stray UFFD markers.
- [High] UFFDIO_MOVE completely drops userfaultfd_wp protection markers on =
present PTEs, silently breaking write protection tracking.
--

commit 325a6bfce816d9aabb37133a65ed3422bc565fb2
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

userfaultfd: add UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT plumbing

This commit adds the userspace interface and internal plumbing for
read-write protection tracking (RWP). It introduces UFFDIO_REGISTER_MODE_RWP
and UFFDIO_RWPROTECT, which allow tracking access to memory ranges.

> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
[ ... ]
> @@ -2204,9 +2282,22 @@ static struct vm_area_struct *userfaultfd_clear_vm=
a(struct vma_iterator *vmi,
>  	if (start =3D=3D vma->vm_start && end =3D=3D vma->vm_end)
>  		give_up_on_oom =3D true;
> =20
> -	/* Reset ptes for the whole vma range if wr-protected */
> -	if (userfaultfd_wp(vma))
> -		uffd_wp_range(vma, start, end - start, false);
> +	/* Clear the uffd bit and/or restore protnone PTEs */
> +	if (userfaultfd_protected(vma)) {
> +		unsigned int mm_cp_flags =3D 0;
> +		struct mmu_gather tlb;
> +
> +		if (userfaultfd_wp(vma))
> +			mm_cp_flags |=3D MM_CP_UFFD_WP_RESOLVE;
> +		if (userfaultfd_rwp(vma))
> +			mm_cp_flags |=3D MM_CP_UFFD_RWP_RESOLVE;
> +		if (vma_wants_manual_pte_write_upgrade(vma))
> +			mm_cp_flags |=3D MM_CP_TRY_CHANGE_WRITABLE;
> +
> +		tlb_gather_mmu(&tlb, vma->vm_mm);
> +		change_protection(&tlb, vma, start, end, mm_cp_flags);
> +		tlb_finish_mmu(&tlb);
> +	}
> =20
>  	ret =3D vma_modify_flags_uffd(vmi, prev, vma, start, end,

[Severity: High]
This isn't a bug introduced by this patch, but userfaultfd_clear_vma() in
mm/userfaultfd.c appears to modify page tables before write-locking the VMA.

By calling change_protection() before vma_modify_flags_uffd() triggers
vma_start_write() to drain concurrent per-VMA readers, could a concurrent p=
age
fault thread that already acquired the per-VMA lock see the old VM_UFFD_WP =
or
VM_UFFD_RWP flags?

If so, could it instantiate a new PTE with the _PAGE_UFFD marker after
change_protection() has already scanned that address, leaking a stray marke=
r?

[ ... ]
> @@ -1358,7 +1358,7 @@ static long move_present_ptes(struct mm_struct *mm,
>  		orig_dst_pte =3D folio_mk_pte(src_folio, dst_vma->vm_page_prot);
>  		/* Set soft dirty bit so userspace can notice the pte was moved */
>  		if (pgtable_supports_soft_dirty())
>  			orig_dst_pte =3D pte_mksoft_dirty(orig_dst_pte);
>  		if (pte_dirty(orig_src_pte))
>  			orig_dst_pte =3D pte_mkdirty(orig_dst_pte);
>  		orig_dst_pte =3D pte_mkwrite(orig_dst_pte, dst_vma);

[Severity: High]
This is a pre-existing issue, but does UFFDIO_MOVE drop userfaultfd_wp
protection markers on present PTEs here in move_present_ptes() in
mm/userfaultfd.c?

When constructing the destination PTE with folio_mk_pte() and pte_mkwrite(),
it doesn't seem to check if the source PTE was write-protected
(e.g., via pte_uffd()), nor does it transfer the _PAGE_UFFD marker to the
destination PTE.

Could this silently break write protection tracking on pages moved via
UFFDIO_MOVE?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629120749.5660=
63-1-kirill@shutemov.name?part=3D9

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2D4303C83
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710901; cv=none; b=Yqp9+LmzLmL92sE7KLxGpCua8lub58lV0Whu1SdSmH4j6v1tcJGrSDI06nKl2WG8MINHC/9S69zd6XLJmZ1n32vBClzSDEOcqS8CsXdtULaOvVnomlj82j4faj9X8S/y4aoYCFitsE44qwUuv9rVSwtsjjZxAKfh54SZnybTPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710901; c=relaxed/simple;
	bh=r6JoMj/VB11BsrbHX4qg2+ivmgqByjuFjuHZGmr6Rt8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b2urJ/VJmdsdzlyzjfnykcpHsw1ytkRpylAR4MtX0ySuVlNIP75zIBbZXZnYw0Uo6sLM40BDgxQ67aSK/GAkO+x352GzvtXzZYOscIjocqwK134JftrV0k/BCy2w+FK+WncoxRIwQUquebSrsViclfREeRyb13S5nPZlk0t8QkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHZOqDe5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHZOqDe5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18561F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779710899;
	bh=Jumm4QHaJ6qnXS7ru0OycwVNpPbe8ttaVcv8GOzOCfU=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=EHZOqDe5NtXqyWudsjJpnsYYvEPsV0mbhnuVeFPmiyz98kq7ZWWi0lQxWB2UIwDhI
	 kNly8N5GM9EAy4Hv6MLNI8PkbKOljgdZoEn6bLJvkH5kwk5qvHiTjvIbkDhp3cEnxU
	 MvpozI55DrrA9QWwDKVNT/y7jn5GCefzQma0AqMhAMeLB6RQ0jeVo26RUlJhD3557Z
	 rZrBZCaDmf4IDHvQmRSzf/uIiKsS4ab1HG1fJ4EcVw4gHkvUpCOB7BtCfkE17eLpuv
	 LgStfqMNGobV+kCA4ec4Mf99z1n+cYJodwwjDeWymtKtcJap1Is7ASuPe4KfcYXf1/
	 +lJfi3GuL2k2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/14] mm: preserve RWP marker across PTE rewrites
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-7-kas@kernel.org>
References: <20260525113737.1942478-7-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:08:19 +0000
Message-Id: <20260525120819.C18561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] Unconditional normalization of all PTEs to vma->vm_page_prot d=
estroys granular protections and creates invalid clean+writable PTEs for sh=
ared mappings.
- [High] Applying pte_mkwrite() to a PAGE_NONE PTE breaks UFFD RWP trap sem=
antics and creates accessible Write-Only PTEs.

Pre-existing issues:
- [High] Failure to write-protect the destination PTE in copy_present_page(=
) completely bypasses UFFD_WP tracking for pinned pages.
--

commit 628bc06f073107f9d9ba34cad6fd490dbe05796a
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: preserve RWP marker across PTE rewrites

This patch ensures that the userfaultfd RWP (Read-Write Protect) marker
survives various PTE rewrite paths, such as swap, migration, fork, and
mprotect. It wires the preservation of the PAGE_NONE semantics through
every path that rewrites a VM_UFFD_RWP PTE.

> diff --git a/mm/memory.c b/mm/memory.c
> index c4fd5cb4a08f8..e4ae5350db416 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
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
>  			pte =3D pte_mkdirty(pte);
>  		pte =3D pte_mkwrite(pte, vma);

[Severity: High]
Does applying pte_mkwrite() to a PAGE_NONE PTE break the UFFD RWP trap
semantics?

The code sets PAGE_NONE via pte_modify() to enforce RWP protection, but
shortly after, it may conditionally call pte_mkwrite(). On architectures
like RISC-V, where PAGE_NONE is implemented by clearing the Read, Write,
and Execute bits while leaving the Present bit set, calling pte_mkwrite()
sets the Write bit. This creates a valid leaf Write-Only PTE, allowing
the hardware to process write accesses natively without generating a
page fault and silently bypassing the UFFD RWP monitor.

This pattern also appears in do_swap_page(), change_present_ptes(),
and change_huge_pmd().

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
> +		/* Restore PAGE_NONE so the RWP marker keeps trapping */
> +		if (userfaultfd_rwp(dst_vma))
> +			pte =3D pte_modify(pte, PAGE_NONE);
> +	}
>  	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but does the failure to write-protect the
destination PTE completely bypass UFFD_WP tracking for pinned pages?

When handling a pinned page in a COW mapping, the code allocates a new page
and creates the child's PTE using maybe_mkwrite(), which sets the hardware
write bit if the VMA allows writes. Even though the _PAGE_UFFD marker is
propagated to the child's PTE, it fails to clear the hardware write bit
with pte_wrprotect().=20

If the child process writes to this page, the hardware could allow the
access natively without triggering a fault, entirely bypassing the UFFD_WP
monitor.

[ ... ]

> @@ -1100,9 +1108,29 @@ static __always_inline void __copy_present_ptes(st=
ruct vm_area_struct *dst_vma,
>  		pte_t pte, unsigned long addr, int nr)
>  {
>  	struct mm_struct *src_mm =3D src_vma->vm_mm;
> +	bool writable;
> +
> +	/*
> +	 * Snapshot writability before the RWP-disarm rewrite below: when the
> +	 * child is not RWP-armed, pte_modify(pte, dst_vma->vm_page_prot) can
> +	 * silently drop _PAGE_RW from a resolved (no-marker) writable PTE,
> +	 * so a later pte_write(pte) check would skip the COW wrprotect and
> +	 * leave the parent writable over a folio shared with the child.
> +	 */
> +	writable =3D pte_write(pte);
> +
> +	/*
> +	 * Child is not RWP-armed: restore accessible protection so the
> +	 * inherited PAGE_NONE does not cost a fault on first read.
> +	 */
> +	if (!userfaultfd_protected(dst_vma)) {
> +		if (userfaultfd_rwp(src_vma))
> +			pte =3D pte_modify(pte, dst_vma->vm_page_prot);
> +		pte =3D pte_clear_uffd(pte);
> +	}

[Severity: Critical]
Could this unconditional normalization of PTEs overwrite granular
protections and create invalid clean+writable PTEs for shared mappings?

The userfaultfd_rwp(src_vma) check applies to the entire VMA without
verifying if the specific PTE actually had the UFFD marker via
pte_uffd(pte). This forces every present PTE to be modified to
dst_vma->vm_page_prot.=20

This appears to destroy PTE-specific protection states like PROT_NONE
used by NUMA balancing. Additionally, for shared mappings where
vm_page_prot includes write permissions, a previously clean and read-only
PTE will be forced to writable without setting the dirty bit. This would
allow a process to write to the page without a page fault (bypassing
page_mkwrite()), leading to silent data loss during memory reclaim or
writeback.

This same logic seems to occur in copy_huge_pmd(), move_ptes(), and
copy_hugetlb_page_range().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D6

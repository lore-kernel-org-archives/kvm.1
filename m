Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920E3D170C
	for <kvm@vger.kernel.org>; Fri,  3 Jul 2026 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088041; cv=none; b=sLMoJTlOQdJfOqopkWpqiCc6SbRk7pCkQQBjF1xhYwF/wbDBUirhM3w9pBk2AQVpZtvZ4WQLpX+7R9nvAnZEXT8clf1GbLZ9kujceTnLr3XOFcdq8cuzaGKki5xfHt9OVMQJUbNVs38G1tt9voaJlOuEkdy8z1Unxf8FFEzNshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088041; c=relaxed/simple;
	bh=6cyxRlcq7ZezYC4lP0/rFOUK2o7TcVTzhCpzfBB64AU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KBfMBUuFj9nW5z7nOA6BFc7kn76vTOw+aOF0enG3aVRoaehiWQibkyRXC8053gVE93kKOSWCake0c4kSQSTbgQ8LTcrxNPpecXzkJvRFQYzoH+n6Z+Xb0TsMNiFqfyM6WhxJUjJuG+m0kyeKg42DsZAGJEObN1EcTwIDidaKfVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8z22S8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8z22S8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B0F1F000E9;
	Fri,  3 Jul 2026 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783088039;
	bh=TrOExUUNWr+v9ixP3/pZllf59DMj/S9JHyxMCS1SVBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8z22S8uzjrikzdwLaZ7b5H/Eug1KKxJECOgymgra7BvULSrLzA0YWuu8T5K0DlKi
	 3ZLqVfBAivgU1vsVAf0C9hg1UFGfPjDveK39wgfi6Lhxy5Q9ecihdytCF59AVWsPwr
	 bkq+Ody2W1N6Mhh6dN9vzy7TM7S8pZ5JpZBmKiGCzei3NJaNxyIpNmeX2+MK9w2OMa
	 f33A1q/wo91Fb+o0PznUI/2RkIXVeYtkB9l67tlvCu9ob9CsqJrRZQsDP4aXTDAGRF
	 Mym3ZnQG7hoxBihAtD5pdZnKyQj0oWKUaO/ZQHm9wPrBsZq/7y8cngfOuwpPYmDabb
	 wgjALBLNMq77Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/15] mm: preserve RWP marker across PTE rewrites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260703133615.1039465-8-kirill@shutemov.name>
References: <20260703133615.1039465-1-kirill@shutemov.name>
 <20260703133615.1039465-8-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 14:13:58 +0000
Message-Id: <20260703141359.36B0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] COW (Copy-On-Write) bypass in fork() due to PTE permission upg=
rade on RWP markers.
- [Critical] COW (Copy-On-Write) bypass in mremap() due to unconditional PT=
E/PMD permission upgrade.
- [High] restore_exclusive_pte() incorrectly applies write permissions to a=
 PAGE_NONE RWP marker.
- [High] Kernel Samepage Merging (KSM) silently disarms RWP markers when re=
placing pages.
--

commit 774184e482d558cfd9ea45101fb7b151ec350b6b
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: preserve RWP marker across PTE rewrites

This commit wires the preservation of the userfaultfd RWP marker across var=
ious
kernel paths that rewrite PTEs. It ensures the uffd PTE bit and PAGE_NONE
semantics survive operations like swap, device-exclusive restore, migration,
fork, and mprotect.

> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b352b0dfe1ba2..ddf8d2e49c127 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c

[ ... ]

> @@ -2539,8 +2545,19 @@ bool move_huge_pmd(struct vm_area_struct *vma, uns=
igned long old_addr,
>  			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
>  		}
>  		pmd =3D move_soft_dirty_pmd(pmd);
> -		if (vma_has_uffd_without_event_remap(vma))
> +		if (vma_has_uffd_without_event_remap(vma)) {
> +			/*
> +			 * See __copy_present_ptes(): normalise the RWP marker
> +			 * so the destination starts accessible instead of
> +			 * taking a numa-hinting fault on first access. Only the
> +			 * marker (protnone + uffd) needs it; leave other present
> +			 * PMDs in the VMA untouched.
> +			 */
> +			if (pmd_present(pmd) && userfaultfd_rwp(vma) &&
> +			    pmd_uffd(pmd))
> +				pmd =3D pmd_modify(pmd, vma->vm_page_prot);

[Severity: Critical]
Does this code inadvertently bypass Copy-On-Write protections?

In move_huge_pmd(), when mremap() is called on a VM_UFFD_RWP VMA without
EVENT_REMAP, the destination VMA drops the uffd context. By normalizing the
marker via pmd_modify(pmd, vma->vm_page_prot), any pre-existing COW read-on=
ly
restrictions (such as from a prior fork or KSM) seem to be overwritten by t=
he
VMA's default writable permissions. Can this result in a shared page being
mapped writable?

>  			pmd =3D clear_uffd_wp_pmd(pmd);
> +		}
>  		set_pmd_at(mm, new_addr, new_pmd, pmd);

[ ... ]

> diff --git a/mm/memory.c b/mm/memory.c
> index 6b0304caf1a4a..c1f79a3dfd6a0 100644
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
>  			pte =3D pte_mkdirty(pte);
>  		pte =3D pte_mkwrite(pte, vma);
>  	}

[Severity: High]
Does this block create an invalid clean+writable PTE and bypass RWP trackin=
g?

In restore_exclusive_pte(), the RWP marker gets its PAGE_NONE protection
restored. However, if the VMA has VM_WRITE, the code proceeds to
unconditionally apply pte_mkwrite() to the PTE. Can this hardware write bit
added to a PAGE_NONE PTE cause hardware writes to succeed without trapping,
permanently bypassing the VMM's access tracking?

[ ... ]

> @@ -1100,9 +1108,31 @@ static __always_inline void __copy_present_ptes(st=
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
> +	 * inherited PAGE_NONE does not cost a fault on first read. Gate on
> +	 * pte_uffd(pte) so unrelated PAGE_NONE markers (e.g. NUMA balancing)
> +	 * are not normalised away.
> +	 */
> +	if (!userfaultfd_protected(dst_vma)) {
> +		if (userfaultfd_rwp(src_vma) && pte_uffd(pte))
> +			pte =3D pte_modify(pte, dst_vma->vm_page_prot);

[Severity: Critical]
Does this normalization branch inadvertently upgrade a COW-shared page to
writable?

In __copy_present_ptes(), the "writable" variable is evaluated before this
block. For an RWP marker (which is PAGE_NONE), pte_write() evaluates to fal=
se.
If the child VMA drops VM_UFFD_RWP and the RWP normalization branch execute=
s,
the PTE may be made writable based on dst_vma->vm_page_prot.

Because "writable" was originally false, the subsequent COW write-protect
block (is_cow_mapping() && writable) is skipped. Does this result in a fully
writable PTE being installed for a shared Copy-On-Write page?

> +		pte =3D pte_clear_uffd(pte);
> +	}
> =20
>  	/* If it's a COW mapping, write protect it both processes. */
> -	if (is_cow_mapping(src_vma->vm_flags) && pte_write(pte)) {
> +	if (is_cow_mapping(src_vma->vm_flags) && writable) {
>  		wrprotect_ptes(src_mm, addr, src_pte, nr);

[ ... ]

> diff --git a/mm/mremap.c b/mm/mremap.c
> index 12732a5c547e9..8a46ec5831c84 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c

[ ... ]

> @@ -296,10 +296,19 @@ static int move_ptes(struct pagetable_move_control =
*pmc,
>  			pte_clear(mm, new_addr, new_ptep);
>  		else {
>  			if (need_clear_uffd_wp) {
> -				if (pte_present(pte))
> +				if (pte_present(pte)) {
> +					/*
> +					 * See __copy_present_ptes(): normalise
> +					 * RWP PTEs so the destination starts
> +					 * accessible instead of taking a
> +					 * numa-hinting fault on first access.
> +					 */
> +					if (userfaultfd_rwp(vma) && pte_uffd(pte))
> +						pte =3D pte_modify(pte, vma->vm_page_prot);

[Severity: Critical]
Could this unconditionally upgrade PTE permissions and destroy Copy-On-Write
protection during mremap()?

Similar to move_huge_pmd(), when move_ptes() encounters an RWP marker on a =
VMA
dropping its uffd context, it overwrites the PTE protection with the VMA's
default via pte_modify(). If the page was previously shared and COW-protect=
ed,
its read-only status appears to be lost.

>  					pte =3D pte_clear_uffd(pte);
> -				else
> +				} else {
>  					pte =3D pte_swp_clear_uffd(pte);
> +				}

[ ... ]

[Severity: High]
Does Kernel Samepage Merging (KSM) silently disarm RWP markers when replaci=
ng
pages?

Looking at replace_page() in mm/ksm.c:

	newpte =3D mk_pte(kpage, vma->vm_page_prot);

When KSM merges an anonymous page in a VM_UFFD_RWP VMA, it constructs the n=
ew
PTE using the VMA's default protection. This appears to entirely drop the
PAGE_NONE marker and the _PAGE_UFFD bit required for RWP tracking. Will rea=
ds
to the page bypass the RWP trap entirely because it is now mapped accessibl=
e?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703133615.1039=
465-1-kirill@shutemov.name?part=3D7

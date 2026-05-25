Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86C2AE78
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779711201; cv=none; b=FzULJjdquJe3a1OgvA+KletvufHTHT9c6wcpLWWmsM8Hjud81EWkbsoFtf5zWH5f/4SJUCCp32yi0/41ZLXin2KNUUsZWUcAA3F+143bWK4CtgWR4OaW45zj48AzfkJX02t8DSnFLPB0QouN0j3y4GrfmHRWExSyE7/wmR9G14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779711201; c=relaxed/simple;
	bh=P4ktzbMy6IdeQ2h+x+JLxLFvHWbghC5TqPICi+Oy51o=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DZZJUy22In4272rnXdTyg1ZItvy6teJhOKLfHrHPkvrhKdrgDqntop6XQx3d/5lh9xMBpOga9VyVHv6w6hs8DmBEvz1xljE4Aj3kqrYgl8+AM5PBMwxnnx7nnyVv54rDMOIww3QmnXyLKfhc0FJGWYgW8cNDiQsjbGnYQs3+PVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWivJzO9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWivJzO9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B03D1F000E9
	for <kvm@vger.kernel.org>; Mon, 25 May 2026 12:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779711199;
	bh=fp6hk6KA0i5qoHgRNr+OwE3rCCENPUzTVKgK61HZcCo=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=NWivJzO9yXBOFNIn4Gf+60kJbFVQALzPqQAgSmFeL7rjT/HM7VyvghubAdh9bSup7
	 +W2MvL39I3FN9or8LcU7V4HmJ21IFH48y3p+OhxLHx7QC3u+fXtrTkr8/m/fmV/r1N
	 g19t1pSVfBIe1LshSzdxeKaGtzWnmCX31QGeDuElC26EiSCIljlA+ABfcc5HFlkPf7
	 2s3mi0PzBDOtDwr80w5cOuDmRN8hVCWm7gyadXFJkXD7DCSLZ3luqDy1L7szvr7paI
	 7QvT8QPuOzRSf2RyQ9hNvgE21Kku3iNltuG0bHe4OOOtwnIHMxoTXqvDATB7pNmvK1
	 q0KsLfxp9W/2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/14] mm: add MM_CP_UFFD_RWP change_protection()
 flag
Reply-To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
In-Reply-To: <20260525113737.1942478-6-kas@kernel.org>
References: <20260525113737.1942478-6-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 12:13:18 +0000
Message-Id: <20260525121319.3B03D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] UFFD_RWP silently fails to apply PAGE_NONE protection on architect=
ures without CONFIG_ARCH_HAS_PTE_PROTNONE.
- [High] Resolving UFFD_RWP incorrectly clears UFFD_WP PTE markers.

Pre-existing issues:
- [High] mprotect() silently drops userfaultfd protection bits from migrati=
on and device-private swap entries.
--

commit 53d11b1df1ce4306088d5ef4ffa8552398e6493b
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>
Date:   Mon May 25 11:37:19 2026 +0000

mm: add MM_CP_UFFD_RWP change_protection() flag

This commit introduces the change_protection() primitive for userfaultfd RW=
P.
It adds MM_CP_UFFD_RWP and MM_CP_UFFD_RWP_RESOLVE flags, wiring them through
the change_pte_range(), change_huge_pmd(), and hugetlb_change_protection()
paths.

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d0c81a056ae2a..4d75b69d42728 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
[ ... ]
> @@ -6488,19 +6496,24 @@ long hugetlb_change_protection(struct vm_area_str=
uct *vma,
>  			 * pte_marker_uffd_wp()=3D=3Dtrue implies !poison
>  			 * because they're mutual exclusive.
>  			 */
> -			if (pte_is_uffd_wp_marker(pte) && uffd_wp_resolve)
> +			if (pte_is_uffd_wp_marker(pte) &&
> +			    (uffd_wp_resolve || uffd_rwp_resolve))
>  				/* Safe to modify directly (non-present->none). */
>  				huge_pte_clear(mm, address, ptep, psize);

[Severity: High]
Could this inadvertently destroy userfaultfd WP state? Since RWP does not
install or use PTE markers, any marker encountered here must be a UFFD_WP
marker. If a resolve operation for RWP is allowed to clear these markers,
it seems like it might drop the write-protect state completely.

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 8340c8b228c67..4a6b35482aee9 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -214,8 +214,9 @@ static __always_inline void set_write_prot_commit_flu=
sh_ptes(struct vm_area_stru
>  static long change_softleaf_pte(struct vm_area_struct *vma,
>  	unsigned long addr, pte_t *pte, pte_t oldpte, unsigned long cp_flags)
>  {
> -	const bool uffd_wp =3D cp_flags & MM_CP_UFFD_WP;
> -	const bool uffd_wp_resolve =3D cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	const bool uffd_prot =3D cp_flags & (MM_CP_UFFD_WP | MM_CP_UFFD_RWP);
> +	const bool uffd_prot_resolve =3D cp_flags &
> +		(MM_CP_UFFD_WP_RESOLVE | MM_CP_UFFD_RWP_RESOLVE);
>  	softleaf_t entry =3D softleaf_from_pte(oldpte);
>  	pte_t newpte;

[Severity: High]
This is a pre-existing issue, but I noticed that when downgrading
permissions for a migration_write entry (such as during a standard
mprotect), this function constructs the new PTE via swp_entry_to_pte().
While the soft_dirty bit is explicitly preserved, it does not appear to
check or preserve pte_swp_uffd().

Could a standard mprotect() running concurrently with migration silently
strip the UFFD bit, permanently bypassing userfaultfd traps when the page
is restored? It looks like change_non_present_huge_pmd() might have a
similar issue with device_private_write entries.

[ ... ]
> @@ -256,7 +257,7 @@ static long change_softleaf_pte(struct vm_area_struct=
 *vma,
>  		 * to unprotect it, drop it; the next page
>  		 * fault will trigger without uffd trapping.
>  		 */
> -		if (uffd_wp_resolve) {
> +		if (uffd_prot_resolve) {
>  			pte_clear(vma->vm_mm, addr, pte);
>  			return 1;
>  		}

[Severity: High]
Does this have the same side effect as the hugetlb path above? By using
uffd_prot_resolve, which includes MM_CP_UFFD_RWP_RESOLVE, an RWP
resolution would clear UFFD_WP markers. Since RWP does not use PTE
markers, should this check remain specific to WP resolution?

[ ... ]
> @@ -681,6 +703,10 @@ long change_protection(struct mmu_gather *tlb,
>  	WARN_ON_ONCE(cp_flags & MM_CP_PROT_NUMA);
>  #endif
> =20
> +	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE) &&
> +	    (cp_flags & MM_CP_UFFD_RWP))
> +		newprot =3D PAGE_NONE;
> +
>  	if (is_vm_hugetlb_page(vma))
>  		pages =3D hugetlb_change_protection(vma, start, end, newprot,
>  						  cp_flags);

[Severity: High]
On architectures that do not define CONFIG_ARCH_HAS_PTE_PROTNONE, will
newprot default to the VMA's standard permissive protections (such as
readable/writable)?

If change_present_ptes() applies these permissive protections alongside the
_PAGE_UFFD bit, memory accesses might not fault. Will this silently fail
open and bypass the userfaultfd RWP trap entirely instead of trapping?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525113737.1942=
478-1-kas@kernel.org?part=3D5

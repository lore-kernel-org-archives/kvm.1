Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C6340418
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737456; cv=none; b=qvDaYENBgaeHg7QE7A9Z5x+4SLisyHFVb10I8Nuz2OvEliz9gcCq2N3JQansFFw96arEaM38GrF7EU2HJCOAwXfYxoZ1Huf6f/aPPasM2SAtItPwJNwCJulnJYNxeuB1LPXbJi2lzs+CDd4nM2O2EggCLVqGHQUNOw9wbPOwj1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737456; c=relaxed/simple;
	bh=OmP6zqWIZoks3isXRmyN8GsxHOb0TWGi/eRLzwB0ylM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELOEy3kKYrrC/F/cm4c8x2CXMw/Vlp7Jb5GgVLux157Y1EgOaFUWljDuwLqmkROjv0M+fuwDa+gnQlWasYy3EWdO4Mq9csFcoJSt4HWsdS2L5Se5sH81JFdtd+/ooM+d8GppTz3NF2F9RSsY2DAMOBug0IZBCpcb3AZ8pc0znDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlAlwsS+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlAlwsS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5265F1F000E9;
	Mon, 29 Jun 2026 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782737455;
	bh=G+hUoACZpgymFU3vEtnID19tFpSKR134Urqhyv7hZc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XlAlwsS+EZXPBp8kPAIA/JwsmgTGmxRTct5gsRdOUgYB4xiA2FzmDurlTVaEjovx3
	 vNUxE+l6Xoj/EVtrTAVW3/3KOROfZoaT0VMHBeR2eGoje2Ha8LyWYMVMfTtGBf6Kdq
	 /jH8XEP6GoH7Jo9coQQ+RIHgPY5Vu2qNxdG1TZuqkt0LMclXpw+iMty/QJN5KgUews
	 RH38efnF1/V0hfu67qp5Yjk53+gZ8WlREuPTj2uy2Fz0BzUzucur1uLIhp1EF5k1QF
	 6xPIHW+LIuvO8q5yahfeQjNYN6jYxZx18EHyJ0LEdYwAreEucEhZNh5WjneYUP8OLJ
	 SqUBOkfMpK9aw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] mm: handle VM_UFFD_RWP in khugepaged, rmap,
 and GUP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kiryl Shutsemau" <kirill@shutemov.name>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260629120749.566063-9-kirill@shutemov.name>
References: <20260629120749.566063-1-kirill@shutemov.name>
 <20260629120749.566063-9-kirill@shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 12:50:54 +0000
Message-Id: <20260629125055.5265F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Per-PTE VM_UFFD_RWP tracking state is silently destroyed upon page=
 eviction, zap, or unmap for file-backed and shmem memory.
- [Medium] GUP with FOLL_FORCE on an inaccessible VM_UFFD_RWP VMA silently =
bypasses userfaultfd RWP tracking.
--

commit 92ff6bd1fb225e8b6307693d55c268c0ef54ee61
Author: Kiryl Shutsemau (Meta) <kas@kernel.org>

mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP

Three mm paths outside the fault handler gate on the uffd PTE bit
today: khugepaged (skip collapse on ranges carrying markers), rmap
(cap unmap batching), and GUP (force a fault through
gup_can_follow_protnone).

[ ... ]

> Extend each to treat VM_UFFD_RWP the same as VM_UFFD_WP; otherwise per-PTE
> RWP state is silently destroyed or bypassed.

[Severity: High]
Is the per-PTE VM_UFFD_RWP tracking state still silently destroyed upon page
eviction, zap, or unmap for file-backed and shmem memory?

When an RWP-protected file-backed page is unmapped due to memory pressure
in try_to_unmap_one() or via MADV_DONTNEED, the PTE is cleared to pte_none(=
).

Because pte_install_uffd_wp_if_needed() and zap_install_uffd_wp_if_needed()
only check userfaultfd_wp(vma), no PTE marker is installed to remember the
RWP state:

include/linux/mm_inline.h:pte_install_uffd_wp_if_needed() {
	if (vma_is_anonymous(vma) || !userfaultfd_wp(vma))
		return false;
}

Additionally, UFFDIO_RWPROTECT explicitly skips pte_none() entries in
change_pte_range():

mm/mprotect.c:change_pte_range() {
	} else if (pte_none(oldpte)) {
		/*
		 * Nobody plays with any none ptes besides
		 * userfaultfd when applying the protections.
		 */
		if (likely(!uffd_wp))
			continue;
}

On subsequent access, the page faults in from the page cache with the defau=
lt
vma->vm_page_prot (accessible), bypassing RWP tracking completely. Should
these functions also be updated to check for RWP?

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3d4d5f9a6f1bf..da8a07cd49a14 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

[ ... ]

> @@ -4644,11 +4644,25 @@ static inline int vm_fault_to_errno(vm_fault_t vm=
_fault, int foll_flags)
> =20
>  /*
>   * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
> - * a (NUMA hinting) fault is required.
> + * a (NUMA hinting or userfaultfd RWP) fault is required.
>   */
>  static inline bool gup_can_follow_protnone(const struct vm_area_struct *=
vma,
>  					   unsigned int flags)
>  {
> +	/*
> +	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
> +	 * NUMA hinting. GUP must always take a fault so the access is
> +	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
> +	 *
> +	 * Only do so while the VMA is accessible. If it has been made
> +	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
> +	 * below: forcing a fault there would loop, as handle_mm_fault() makes
> +	 * no progress on protnone in an inaccessible VMA, and the access is
> +	 * denied regardless of RWP anyway.
> +	 */
> +	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
> +		return false;

[Severity: Medium]
Does this logic allow GUP with FOLL_FORCE to silently bypass userfaultfd
RWP tracking?

If an external process uses ptrace or process_vm_readv (which set FOLL_FORC=
E)
to access an RWP-protected VMA that has been marked inaccessible (for examp=
le
via mprotect(PROT_NONE)), vma_is_accessible() will return false.

This causes gup_can_follow_protnone() to return true, which instructs GUP
to proceed without triggering a fault, resulting in missed access
notifications for the VMM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629120749.5660=
63-1-kirill@shutemov.name?part=3D8

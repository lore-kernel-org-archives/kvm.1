Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666193C8195;
	Tue, 12 May 2026 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604318; cv=none; b=s3cL6MvHKDnd9jw1nHsFZ1IZFAEpSVjBRLDNrX7GDF3fgDrLWdyKIUb/5esWQRUY7BMPW3gMJN5vcmt2nk56+xTlGP6PHh7J2taY3shKcBYhNT+KDY9SdQzgRYjxDTDFbRWDulmgjeymSgTXXXcejPuDjJGSV3SfOGooCo7oxDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604318; c=relaxed/simple;
	bh=nWqCxq7T/dq+SPOZyMunKEPynEE38sPxedaX27vX4VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXCdJln1yB0EKlp2qpcHcEVUu1bwL0JfEcHhfIU+BntYdP3VkqlKNiH/pv2QC5Gvs0jb16RzTXlUdpvHwEdgL/PqZ/gI6gydisQDTaYDl+O7ISsswe8gaKYuWpETK0QHrB8g2BoSsj/B12nrCuBMO3A+8y+uYyemzfea1f1ZIqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blgoe6k7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blgoe6k7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425B2C2BCFA;
	Tue, 12 May 2026 16:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604318;
	bh=nWqCxq7T/dq+SPOZyMunKEPynEE38sPxedaX27vX4VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Blgoe6k7d6myKJ/eH1T8UqBraO0ckIsqoEg2Qk8eM/IQFubB+3yd7WkJNTMp89VYI
	 mnGIgwWAreQfVWT0QFvY6K/HIgi8FBPyP07jDM78j2Y6gSd4eqlQ1conhfbWLsf/QM
	 /+6VaA8siC/qB98opCiUfvurPjLq6aFkD85qoTmE1FafYVfG3pzSsQ0LL1OCZexr2o
	 w5jaXHCmcpAnH4LRkcnYoWz4ECcXQXkSJW1I++LK1DLwH3OWSpj1NZziysd1ZXpATI
	 uEbg2+M/OvMSFqaQROQ9I2eXzb7p3ZEJ6LFreAwy0++fDCiTcNSO3spfiKSb9q6dbM
	 S3sEZOlzukBBA==
Date: Tue, 12 May 2026 19:45:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org,
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
	jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
	usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 05/14] mm: add MM_CP_UFFD_RWP change_protection() flag
Message-ID: <agNZE49m8Pkn8CeW@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
 <ff3420fdd75f58d56827ff3d2eaffc0d74154627.1778254670.git.kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff3420fdd75f58d56827ff3d2eaffc0d74154627.1778254670.git.kas@kernel.org>

On Fri, May 08, 2026 at 04:55:17PM +0100, Kiryl Shutsemau (Meta) wrote:
> Preparatory patch. Add the change_protection() primitive that
> userfaultfd RWP will use.
> 
> An RWP-protected PTE is PAGE_NONE with the uffd PTE bit set. The
> PROT_NONE half makes the CPU fault on any access; the uffd bit
> distinguishes an RWP fault from a plain mprotect(PROT_NONE) or NUMA
> hinting fault. MM_CP_UFFD_WP and MM_CP_UFFD_RWP share the same PTE
> bit, so the two cannot be used together on the same range.
> 
> Two new change_protection() flags:
> 
>   MM_CP_UFFD_RWP            install PAGE_NONE and set the uffd bit
>   MM_CP_UFFD_RWP_RESOLVE    restore vma->vm_page_prot, clear the uffd bit
> 
> Both are wired through change_pte_range(), change_huge_pmd(), and
> hugetlb_change_protection() so anon, shmem, THP, and hugetlb all
> share the same semantics.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> ---
>  include/linux/mm.h            |  5 +++++
>  include/linux/userfaultfd_k.h |  1 -
>  mm/huge_memory.c              | 20 ++++++++++++------
>  mm/hugetlb.c                  | 25 ++++++++++++++++------
>  mm/mprotect.c                 | 40 +++++++++++++++++++++++++++++------
>  5 files changed, 71 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3f53d1e978c0..2b65416bb760 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3291,6 +3291,11 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
>  #define  MM_CP_UFFD_WP_RESOLVE             (1UL << 3) /* Resolve wp */
>  #define  MM_CP_UFFD_WP_ALL                 (MM_CP_UFFD_WP | \
>  					    MM_CP_UFFD_WP_RESOLVE)
> +/* Whether this change is for uffd RWP */
> +#define  MM_CP_UFFD_RWP                    (1UL << 4) /* do rwp */
> +#define  MM_CP_UFFD_RWP_RESOLVE            (1UL << 5) /* Resolve rwp */

Nit: any reason except copy/paset to use different case in "do rwp" and
"Resolve rwp"? ;-)

> +#define  MM_CP_UFFD_RWP_ALL                (MM_CP_UFFD_RWP | \
> +					    MM_CP_UFFD_RWP_RESOLVE)
>  
>  bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t pte);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index fcf308dba311..3725e61a7041 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -397,7 +397,6 @@ static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
>  	return false;
>  }
>  
> -
>  static inline bool userfaultfd_armed(struct vm_area_struct *vma)
>  {
>  	return false;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d88fcccd386d..2537dca63c6c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2665,6 +2665,8 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	spinlock_t *ptl;
>  	pmd_t oldpmd, entry;
>  	bool prot_numa = cp_flags & MM_CP_PROT_NUMA;
> +	bool uffd_rwp = cp_flags & MM_CP_UFFD_RWP;
> +	bool uffd_rwp_resolve = cp_flags & MM_CP_UFFD_RWP_RESOLVE;
>  	bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;

It looks like uffd_wp* are always ORed with uffd_rwp, we could fold this to
e.g.

	bool uffd_prot = cp_flags & (MM_CP_UFFD_WP | MM_CP_UFFD_RWP);

>  	int ret = 1;
> @@ -2679,11 +2681,18 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		return 0;
>  
>  	if (thp_migration_supported() && pmd_is_valid_softleaf(*pmd)) {
> -		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
> -					    uffd_wp_resolve);
> +		change_non_present_huge_pmd(mm, addr, pmd,
> +					    uffd_wp || uffd_rwp,
> +					    uffd_wp_resolve || uffd_rwp_resolve);
>  		goto unlock;
>  	}
>  
> +	/* Already in the desired state */
> +	if (prot_numa && pmd_protnone(*pmd))
> +		goto unlock;
> +	if (uffd_rwp && pmd_protnone(*pmd) && pmd_uffd(*pmd))
> +		goto unlock;
> +
>  	if (prot_numa) {
>  
>  		/*
> @@ -2694,9 +2703,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		if (is_huge_zero_pmd(*pmd))
>  			goto unlock;
>  
> -		if (pmd_protnone(*pmd))
> -			goto unlock;
> -
>  		if (!folio_can_map_prot_numa(pmd_folio(*pmd), vma,
>  					     vma_is_single_threaded_private(vma)))
>  			goto unlock;
> @@ -2725,9 +2731,9 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	oldpmd = pmdp_invalidate_ad(vma, addr, pmd);
>  
>  	entry = pmd_modify(oldpmd, newprot);
> -	if (uffd_wp)
> +	if (uffd_wp || uffd_rwp)
>  		entry = pmd_mkuffd(entry);
> -	else if (uffd_wp_resolve)
> +	else if (uffd_wp_resolve || uffd_rwp_resolve)
>  		/*
>  		 * Leave the write bit to be handled by PF interrupt
>  		 * handler, then things like COW could be properly
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 61cda9992043..63f6b19418b9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6434,6 +6436,11 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
>  
>  		ptep = hugetlb_walk(vma, address, psize);
>  		if (!ptep) {
> +			/*
> +			 * uffd_wp installs a pte marker on the unpopulated
> +			 * entry; RWP does not install markers so the

Nit:                              uffd_rwp

> +			 * allocation is unnecessary for it.
> +			 */
>  			if (!uffd_wp) {
>  				address |= last_addr_mask;
>  				continue;
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 8340c8b228c6..23e71f68cf7a 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -216,6 +216,8 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
>  {
>  	const bool uffd_wp = cp_flags & MM_CP_UFFD_WP;
>  	const bool uffd_wp_resolve = cp_flags & MM_CP_UFFD_WP_RESOLVE;
> +	const bool uffd_rwp = cp_flags & MM_CP_UFFD_RWP;
> +	const bool uffd_rwp_resolve = cp_flags & MM_CP_UFFD_RWP_RESOLVE;

And here a single pair of bools should be enough I think.

>  	softleaf_t entry = softleaf_from_pte(oldpte);
>  	pte_t newpte;
>  
> @@ -256,7 +258,7 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
>  		 * to unprotect it, drop it; the next page
>  		 * fault will trigger without uffd trapping.
>  		 */
> -		if (uffd_wp_resolve) {
> +		if (uffd_wp_resolve || uffd_rwp_resolve) {
>  			pte_clear(vma->vm_mm, addr, pte);
>  			return 1;
>  		}
> @@ -265,9 +267,9 @@ static long change_softleaf_pte(struct vm_area_struct *vma,
>  		newpte = oldpte;
>  	}
>  
> -	if (uffd_wp)
> +	if (uffd_wp || uffd_rwp)
>  		newpte = pte_swp_mkuffd(newpte);
> -	else if (uffd_wp_resolve)
> +	else if (uffd_wp_resolve || uffd_rwp_resolve)
>  		newpte = pte_swp_clear_uffd(newpte);
>  
>  	if (!pte_same(oldpte, newpte)) {

-- 
Sincerely yours,
Mike.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904B37C90A;
	Wed,  3 Jun 2026 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780491453; cv=none; b=rREOPFy+93maTeOr8psVHs9qmC0cW9kQhTPdIFIq6jNWJRSXHGfDASKpo7io6r46znmiv0vu+WdQeZT3Vcg70zWf61+adgIQzZNC6+PVU6ApjtC9jfhjLPwREIVXMxav4q+wPagksI+m5xsM1Y79yMFrY4ql4pxhkjcFDOEPhjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780491453; c=relaxed/simple;
	bh=GFSky3xf5AxPLQZnoZqywkJpcB3vZ/c6/4n8muNhFvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smoFShhZk3f7Co3V1CG/GehEthQCP7KbTKFF6cddWq9I0IgRDScsmCo5cZENRZ49pg9FrjcoYlP2ITfl4CfaC67Sx2LnMlXW4rcB9oGJuMWFd/+wnxXrrg3Wvqnu/hZRtBtlQaGo2wWWCPX49cNYZN2GUd1HyB32E21K24J9Yh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD9Yx1lL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD9Yx1lL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D091F00893;
	Wed,  3 Jun 2026 12:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780491452;
	bh=dtMtYIOXYp6nZhFwb/fVgtiIgWg/t0b1ReYJZF7zT/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aD9Yx1lLUyqm2rox24HF4tnMYIhzSk1E+1+H/BF42EIA38d7kdpLTBkAU7QY5yL1z
	 tSKVJf4LvPTt7nUCMN97oZg6kTtOFe8S3IocaJ+rqGSSMhcBhMhkDF/IfffFLi0FpV
	 R7hkzKLr5otOxmjNeEZl0ZvHi96o4q8fZYNm6ersWe6APcP71v9Zc0zRYLoz2z6mBN
	 exvP4Gu3sqUIVutv+UtTIjgdvgm0B2umqZ/3tbzZNHYl+y+1nbrb/u2eHWj9SUzbC6
	 3P+X+aXbGy7nJpO/pBAbOHKCBVdPoJGFx3Zy+I1BqVrZaF7/bSeC7n35pM2K9wyV1R
	 aQA/TOxz6IO5w==
Date: Wed, 3 Jun 2026 13:57:24 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 08/15] mm: handle VM_UFFD_RWP in khugepaged, rmap, and
 GUP
Message-ID: <aiAkXF-x7374lZff@lucifer>
References: <20260529172716.357179-1-kas@kernel.org>
 <20260529172716.357179-9-kas@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529172716.357179-9-kas@kernel.org>

On Fri, May 29, 2026 at 06:26:37PM +0100, Kiryl Shutsemau (Meta) wrote:
> Three mm paths outside the fault handler gate on the uffd PTE bit
> today: khugepaged (skip collapse on ranges carrying markers), rmap
> (cap unmap batching), and GUP (force a fault through
> gup_can_follow_protnone). Extend each to treat VM_UFFD_RWP the same
> as VM_UFFD_WP; otherwise per-PTE RWP state is silently destroyed or
> bypassed.
>
> khugepaged: try_collapse_pte_mapped_thp() and
> file_backed_vma_is_retractable() already refuse to collapse or
> retract page tables on ranges carrying the uffd PTE bit. Broaden the
> VMA predicate from userfaultfd_wp() to userfaultfd_protected() so
> VM_UFFD_RWP ranges get the same protection. hpage_collapse_scan_pmd()
> needs no change — its existing pte_uffd() check already catches an
> RWP PTE because it carries the uffd bit.
>
> rmap: folio_unmap_pte_batch() caps batching at 1 for VM_UFFD_RWP so
> the restore path handles each PTE with its own marker.
>
> GUP: gup_can_follow_protnone() forces a fault on VM_UFFD_RWP VMAs
> regardless of FOLL_HONOR_NUMA_FAULT. RWP uses protnone as an
> access-tracking marker, not for NUMA hinting, so any GUP — read or
> write — must go through the userfaultfd fault path.
>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Assisted-by: Claude:claude-opus-4-6
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Nit below but LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  include/linux/mm.h | 16 +++++++++++++++-
>  mm/khugepaged.c    | 18 +++++++++++-------
>  mm/rmap.c          |  2 +-
>  3 files changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3d4d5f9a6f1b..2b04f690b516 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4644,11 +4644,25 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>
>  /*
>   * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
> - * a (NUMA hinting) fault is required.
> + * a (NUMA hinting or userfaultfd RWP) fault is required.
>   */
>  static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
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
> +	if ((vma->vm_flags & VM_UFFD_RWP) && vma_is_accessible(vma))
> +		return false;

Can be:

	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
		return false;

> +
>  	/*
>  	 * If callers don't want to honor NUMA hinting faults, no need to
>  	 * determine if we would actually have to trigger a NUMA hinting fault.
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index afa218be15de..4f3fedcd75cf 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1895,8 +1895,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return SCAN_VMA_CHECK;
>
> -	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
> -	if (userfaultfd_wp(vma))
> +	/*
> +	 * Keep pmd pgtable while the uffd bit is in use; see comment in
> +	 * retract_page_tables().
> +	 */
> +	if (userfaultfd_protected(vma))
>  		return SCAN_PTE_UFFD;
>
>  	folio = filemap_lock_folio(vma->vm_file->f_mapping,
> @@ -2109,13 +2112,14 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
>  		return false;
>
>  	/*
> -	 * When a vma is registered with uffd-wp, we cannot recycle
> +	 * When a vma is registered with uffd-wp or RWP, we cannot recycle
>  	 * the page table because there may be pte markers installed.
> -	 * Other vmas can still have the same file mapped hugely, but
> -	 * skip this one: it will always be mapped in small page size
> -	 * for uffd-wp registered ranges.
> +	 * VM_UFFD_RWP ranges similarly rely on per-PTE uffd state
> +	 * and cannot be recycled to a shared PMD. Other vmas can still
> +	 * have the same file mapped hugely, but skip this one: it will
> +	 * always be mapped in small page size for these registrations.
>  	 */
> -	if (userfaultfd_wp(vma))
> +	if (userfaultfd_protected(vma))
>  		return false;
>
>  	/*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 546bc1cf9391..9fb733489898 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1965,7 +1965,7 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
>  	if (pte_unused(pte))
>  		return 1;
>
> -	if (userfaultfd_wp(vma))
> +	if (userfaultfd_protected(vma))
>  		return 1;
>
>  	/*
> --
> 2.54.0
>

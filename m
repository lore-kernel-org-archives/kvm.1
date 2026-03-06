Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4938934DB4C;
	Fri,  6 Mar 2026 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795488; cv=none; b=Uy8diqooRrkr9oRAvJ3YHuHQDQ9BsxiXboCnal+Milj+0U+RrU1khGd5OnODByCeYtizbQHrV+GlUM6N7lxNsfRsVC8uTAuXwIwwxh3PlLxl172p0UEanJRFcYNDSUnQRRYxKE3dg+HKpY4l3a0yB8pmEMj9QKZpLZWM+wSDJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795488; c=relaxed/simple;
	bh=XPnWJ/zcW6bcNJfU50q7o2JeLb8fNCmjYqceT7SznhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIadgOg14X5LUImIRiy656stT8Wv/za03oXFyb5ChY7RICOTnMZV3jbBSkF91MeGpBfS00j6bu4RFSJxC0Iv+iKnfQ1myzd0sobCZFYhm43sP/cykTnGt+HXructqKm6lhXI41yAaIc2/mXGIBfD2PitFzBHUzQEwTCF0/m0OgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdHvIeL/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdHvIeL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B593EC4CEF7;
	Fri,  6 Mar 2026 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795488;
	bh=XPnWJ/zcW6bcNJfU50q7o2JeLb8fNCmjYqceT7SznhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdHvIeL/wlKDg0FcHc0VzSvms6Qw1rJu3w5LF8u/FdPD9nAOxopFjS63ed7LiZtQn
	 UkSZl8EQ/mSVlZMpC43C6W86wNCXOoApnPfV/pfMb9E6n3qbpoNGB1qIVoLon3ASbH
	 nPcp27j5jCCwpmNUZMuAZX5MlN/ZRYDxiZ7xcKGfVHH++DqHgOeNE36bRq48VMLtNw
	 0liKlv8hMf/KQ/gdlYvpGQNcZQluXf/jHE6RmlecqumS3+3cBxXFlidPpilxI+l56B
	 mcSNfvgEx7MbN3meiAgJb3tkUpCw3KI3eicxkTPgCB2KGUdzChTV5da5pFQkzP0CDk
	 hRbRCxTW1/N/w==
Date: Fri, 6 Mar 2026 11:11:25 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] mm: move vma_mmu_pagesize() from hugetlb to vma.c
Message-ID: <8ed76150-9e06-45c9-a061-1a1bd1d4c0fa@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-3-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306101600.57355-3-david@kernel.org>

On Fri, Mar 06, 2026 at 11:15:58AM +0100, David Hildenbrand (Arm) wrote:
> vma_mmu_pagesize() is also queried on non-hugetlb VMAs and does not
> really belong into hugetlb.c.
>
> PPC64 provides a custom overwrite with CONFIG_HUGETLB_PAGE, see
> arch/powerpc/mm/book3s64/slice.c, so we cannot easily make this a
> static inline function.
>
> So let's move it to vma.c and add some proper kerneldoc.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  include/linux/hugetlb.h |  7 -------
>  include/linux/mm.h      |  2 ++
>  mm/hugetlb.c            | 11 -----------
>  mm/vma.c                | 21 +++++++++++++++++++++
>  4 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 44c1848a2c21..aaf3d472e6b5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -777,8 +777,6 @@ static inline unsigned long huge_page_size(const struct hstate *h)
>  	return (unsigned long)PAGE_SIZE << h->order;
>  }
>
> -extern unsigned long vma_mmu_pagesize(struct vm_area_struct *vma);
> -
>  static inline unsigned long huge_page_mask(struct hstate *h)
>  {
>  	return h->mask;
> @@ -1175,11 +1173,6 @@ static inline unsigned long huge_page_mask(struct hstate *h)
>  	return PAGE_MASK;
>  }
>
> -static inline unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> -{
> -	return PAGE_SIZE;
> -}
> -
>  static inline unsigned int huge_page_order(struct hstate *h)
>  {
>  	return 0;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 227809790f1a..22d338933c84 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1327,6 +1327,8 @@ static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
>  	return PAGE_SIZE;
>  }
>
> +unsigned long vma_mmu_pagesize(struct vm_area_struct *vma);
> +
>  static inline
>  struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 66eadfa9e958..f6ecca9aae01 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1017,17 +1017,6 @@ static pgoff_t vma_hugecache_offset(struct hstate *h,
>  			(vma->vm_pgoff >> huge_page_order(h));
>  }
>
> -/*
> - * Return the page size being used by the MMU to back a VMA. In the majority
> - * of cases, the page size used by the kernel matches the MMU size. On
> - * architectures where it differs, an architecture-specific 'strong'
> - * version of this symbol is required.
> - */
> -__weak unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> -{
> -	return vma_kernel_pagesize(vma);
> -}
> -
>  /*
>   * Flags for MAP_PRIVATE reservations.  These are stored in the bottom
>   * bits of the reservation map pointer, which are always clear due to
> diff --git a/mm/vma.c b/mm/vma.c
> index be64f781a3aa..e95fd5a5fe5c 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3300,3 +3300,24 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>
>  	return 0;
>  }
> +
> +/**
> + * vma_mmu_pagesize - Default MMU page size granularity for this VMA.
> + * @vma: The user mapping.
> + *
> + * In the common case, the default page size used by the MMU matches the
> + * default page size used by the kernel (see vma_kernel_pagesize()). On
> + * architectures where it differs, an architecture-specific 'strong' version
> + * of this symbol is required.
> + *
> + * The default MMU page size is not affected by Transparent Huge Pages
> + * being in effect, or any usage of larger MMU page sizes (either through
> + * architectural huge-page mappings or other explicit/implicit coalescing of
> + * virtual ranges performed by the MMU).
> + *
> + * Return: The default MMU page size granularity for this VMA.
> + */
> +__weak unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
> +{
> +	return vma_kernel_pagesize(vma);
> +}
> --
> 2.43.0
>

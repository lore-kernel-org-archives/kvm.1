Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A13BC2FF;
	Fri,  6 Mar 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772795262; cv=none; b=ZUfJnLH7MwUbxfRSifwfg2IZkrNh0YLc/bt0NPInQwBdfOhZY1UX1pSvv4JtLFwIeKU4Fi/+580lzqLTKZYfwI5KnuvqCoWwDxgy2iTVAEPPZ0QR7JfCzkLj0ZrQkOxab5UK9YfIAhGCVqCmCFCT3YuIqlw7zMfNazStQgTyNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772795262; c=relaxed/simple;
	bh=xHA3xv8H6bWtNG4YWuzx0gTRR1QZaKIgnv1aEOMe/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K858G9kvPG4hK17WuWhqc0dvMT/8Nh2oC6Tf44hYPZKzEET38jiprpRGWFIlESeZjoMYRmOB/uzI709ldiOtRVwLDLNIcCfnFBuh5nYzmXgjHYGi3V3dV7UVQS+yS5cDOUUlztcWGhlI/rwCR5AfbOIl3hib7YY4FavUU9i3oZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfXrGnQj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfXrGnQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD42C4CEF7;
	Fri,  6 Mar 2026 11:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772795262;
	bh=xHA3xv8H6bWtNG4YWuzx0gTRR1QZaKIgnv1aEOMe/sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LfXrGnQjHWNBBCETU/U4oSl/XQLAxUW5IW4VzDgbJuqr8rMv2CC9tqLHt++rzGNHE
	 t0r7h92NQurOz8dlsIXe9stMOQlmA9ZH6uLf2rKEazE2DmsuCUq0OtForVaXI/uXVW
	 xtlO4A6wks/mXhKXFf8pRc21P5Mj4x0jcKTcGp5pDBK5Rz7C8/7ojyk95zx5cNCewp
	 1u29pZldqh+4VOJ/ZgmA75LILHILbY+xmhXnvOKJTsfxC6LVYIr2RXdmffQ1gmyK+q
	 OgN6lcJBXIMNxzWGvz7oM3X3rkkwdktXnGjssSHgVBLcvQYAK7mQTpIC3PR4xxKLyg
	 qnM/YAedK++bQ==
Date: Fri, 6 Mar 2026 11:07:38 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 1/4] mm: move vma_kernel_pagesize() from hugetlb to
 mm.h
Message-ID: <833950ef-e01d-4914-b5f9-bc1f6261b184@lucifer.local>
References: <20260306101600.57355-1-david@kernel.org>
 <20260306101600.57355-2-david@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306101600.57355-2-david@kernel.org>

On Fri, Mar 06, 2026 at 11:15:57AM +0100, David Hildenbrand (Arm) wrote:
> In the past, only hugetlb had special "vma_kernel_pagesize()"
> requirements, so it provided its own implementation.
>
> In commit 05ea88608d4e ("mm, hugetlbfs: introduce ->pagesize() to
> vm_operations_struct") we generalized that approach by providing a
> vm_ops->pagesize() callback to be used by device-dax.
>
> Once device-dax started using that callback in commit c1d53b92b95c
> ("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
> it was missed that CONFIG_DEV_DAX does not depend on hugetlb support.
>
> So building a kernel with CONFIG_DEV_DAX but without CONFIG_HUGETLBFS
> would not pick up that value.
>
> Fix it by moving vma_kernel_pagesize() to mm.h, providing only a single
> implementation. While at it, improve the kerneldoc a bit.
>
> Ideally, we'd move vma_mmu_pagesize() as well to the header. However,
> its __weak symbol might be overwritten by a PPC variant in hugetlb code.
> So let's leave it in there for now, as it really only matters for some
> hugetlb oddities.
>
> This was found by code inspection.
>
> Fixes: c1d53b92b95c ("device-dax: implement ->pagesize() for smaps to report MMUPageSize")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, but you need to fix up VMA tests, I attach a patch below to do this. Will
this resolved:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  include/linux/hugetlb.h |  7 -------
>  include/linux/mm.h      | 20 ++++++++++++++++++++
>  mm/hugetlb.c            | 17 -----------------
>  3 files changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 65910437be1c..44c1848a2c21 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -777,8 +777,6 @@ static inline unsigned long huge_page_size(const struct hstate *h)
>  	return (unsigned long)PAGE_SIZE << h->order;
>  }
>
> -extern unsigned long vma_kernel_pagesize(struct vm_area_struct *vma);
> -
>  extern unsigned long vma_mmu_pagesize(struct vm_area_struct *vma);
>
>  static inline unsigned long huge_page_mask(struct hstate *h)
> @@ -1177,11 +1175,6 @@ static inline unsigned long huge_page_mask(struct hstate *h)
>  	return PAGE_MASK;
>  }
>
> -static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
> -{
> -	return PAGE_SIZE;
> -}
> -
>  static inline unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
>  {
>  	return PAGE_SIZE;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 44e04a42fe77..227809790f1a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1307,6 +1307,26 @@ static inline bool vma_is_shared_maywrite(const struct vm_area_struct *vma)
>  	return is_shared_maywrite(&vma->flags);
>  }
>
> +/**
> + * vma_kernel_pagesize - Default page size granularity for this VMA.
> + * @vma: The user mapping.
> + *
> + * The kernel page size specifies in which granularity VMA modifications
> + * can be performed. Folios in this VMA will be aligned to, and at least
> + * the size of the number of bytes returned by this function.
> + *
> + * The default kernel page size is not affected by Transparent Huge Pages
> + * being in effect.
> + *
> + * Return: The default page size granularity for this VMA.
> + */
> +static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
> +{
> +	if (unlikely(vma->vm_ops && vma->vm_ops->pagesize))
> +		return vma->vm_ops->pagesize(vma);
> +	return PAGE_SIZE;
> +}
> +
>  static inline
>  struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long max)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1d41fa3dd43e..66eadfa9e958 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1017,23 +1017,6 @@ static pgoff_t vma_hugecache_offset(struct hstate *h,
>  			(vma->vm_pgoff >> huge_page_order(h));
>  }
>
> -/**
> - * vma_kernel_pagesize - Page size granularity for this VMA.
> - * @vma: The user mapping.
> - *
> - * Folios in this VMA will be aligned to, and at least the size of the
> - * number of bytes returned by this function.
> - *
> - * Return: The default size of the folios allocated when backing a VMA.
> - */
> -unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
> -{
> -	if (vma->vm_ops && vma->vm_ops->pagesize)
> -		return vma->vm_ops->pagesize(vma);
> -	return PAGE_SIZE;
> -}
> -EXPORT_SYMBOL_GPL(vma_kernel_pagesize);
> -
>  /*
>   * Return the page size being used by the MMU to back a VMA. In the majority
>   * of cases, the page size used by the kernel matches the MMU size. On
> --
> 2.43.0
>

----8<----
This breaks the VMA tests when patch 2/4 removes the references in other
headers. So this patch should also update them, I enclose a simple fix for
convenience:

From bec84895cbdbe28e3495c4d90e097074598419e5 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Date: Fri, 6 Mar 2026 11:05:12 +0000
Subject: [PATCH] fix

---
 tools/testing/vma/include/dup.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 3078ff1487d3..65b1030a7fdf 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1318,3 +1318,10 @@ static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 	swap(vma->vm_file, file);
 	fput(file);
 }
+
+static inline unsigned long vma_kernel_pagesize(struct vm_area_struct *vma)
+{
+	if (unlikely(vma->vm_ops && vma->vm_ops->pagesize))
+		return vma->vm_ops->pagesize(vma);
+	return PAGE_SIZE;
+}
--
2.53.0

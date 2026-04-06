Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1681DED40;
	Mon,  6 Apr 2026 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440463; cv=none; b=JO/RZDDsprS0Im2XPttMjnSe86G2MRcGU+aE+oVbOIApB27RXXH+hDGzRXsAXYEjc2NWCx/Z1YIhFAYa/vrwxdzoTjVk4LbyM82YxU+RkWxENIeULeWXr0+JNm0jm6S1Ur+/SFIjr0gTlKS7ZeJPH/XcSfIkqP0zPfNDNgvxyIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440463; c=relaxed/simple;
	bh=i3tkyONMstJd7/bB4kFhKh47p0J+DD4A0sqUFsz1AKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkyDgNhUu78Ia+/6Oc7wnAB5YGG7HVSDVZvtGt/FHI49LQoWWH+ONQJUbKBZgkAsuekGOm1cAlH3ZUPrLcRXx+XUvHmEjRozkypm3BrvhG6P4OkePnAqwWgKzxREcRQgFWizyh/aCv2rAD9nm8O6TQG6FNRgSuRQSwkl86LnXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCp/eFA1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCp/eFA1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73543C116C6;
	Mon,  6 Apr 2026 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775440462;
	bh=i3tkyONMstJd7/bB4kFhKh47p0J+DD4A0sqUFsz1AKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCp/eFA19HIS+NAFw7U11vCNfNTYBCc+LISNDwQwpselRC0UaA21FrMIuos8xo9cV
	 4kfOJuZ8biK/kakJnm2xHEos8e0XArbBzRUKqQZ8+/KhYZwFUa185NiHdCyMTWggum
	 e/yvAZzxSkAD6BLjhaLU2RzvoybgovlPurAQeMR1qUFNSaS/Fc7fBsWdceSk9rWIC6
	 4tKWCWRh16r8TAS1dKdtnd7ZjreW8tCsgDYjcP4PEYkXtO3fsM+NGB8a3Og/llrpjE
	 CmxfE1GwW0Inqg4Lmz1ynYR3Hl13kLFkBlTLJR11PNm0oWfYxBHj2ieORA8GqYDakE
	 h1Kmk6mfhBaag==
Date: Mon, 6 Apr 2026 10:54:20 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, kvm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 05/15] userfaultfd: retry copying with locks dropped
 in mfill_atomic_pte_copy()
Message-ID: <adMSTB35f-ki15fj@hyeyoo>
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-6-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402041156.1377214-6-rppt@kernel.org>

On Thu, Apr 02, 2026 at 07:11:46AM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Implementation of UFFDIO_COPY for anonymous memory might fail to copy data
> from userspace buffer when the destination VMA is locked (either with
> mm_lock or with per-VMA lock).
> 
> In that case, mfill_atomic() releases the locks, retries copying the data
> with locks dropped and then re-locks the destination VMA and
> re-establishes PMD.
> 
> Since this retry-reget dance is only relevant for UFFDIO_COPY and it never
> happens for other UFFDIO_ operations, make it a part of
> mfill_atomic_pte_copy() that actually implements UFFDIO_COPY for anonymous
> memory.
> 
> As a temporal safety measure to avoid breaking biscection
> mfill_atomic_pte_copy() makes sure to never return -ENOENT so that the
> loop in mfill_atomic() won't retry copiyng outside of mmap_lock.  This is
> removed later when shmem implementation will be updated later and the loop
> in mfill_atomic() will be adjusted.
> 
> [akpm@linux-foundation.org: update mfill_copy_folio_retry()]
>   Link: https://lkml.kernel.org/r/20260316173829.1126728-1-avagin@google.com
> Link: https://lkml.kernel.org/r/20260306171815.3160826-6-rppt@kernel.org
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Looks good to me,
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

>  mm/userfaultfd.c | 75 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 51 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index c6a38db45343..82e1a3255e1e 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -405,35 +405,63 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
>  static int mfill_atomic_pte_copy(struct mfill_state *state)
>  {
> -	struct vm_area_struct *dst_vma = state->vma;
>  	unsigned long dst_addr = state->dst_addr;
>  	unsigned long src_addr = state->src_addr;
>  	uffd_flags_t flags = state->flags;
> -	pmd_t *dst_pmd = state->pmd;
>  	struct folio *folio;
>  	int ret;
>  
> -	if (!state->folio) {
> -		ret = -ENOMEM;
> -		folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, dst_vma,
> -					dst_addr);
> -		if (!folio)
> -			goto out;
> +	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, state->vma, dst_addr);
> +	if (!folio)
> +		return -ENOMEM;
>  
> -		ret = mfill_copy_folio_locked(folio, src_addr);
> +	ret = -ENOMEM;
> +	if (mem_cgroup_charge(folio, state->vma->vm_mm, GFP_KERNEL))
> +		goto out_release;
>  
> -		/* fallback to copy_from_user outside mmap_lock */
> -		if (unlikely(ret)) {
> -			ret = -ENOENT;
> -			state->folio = folio;
> -			/* don't free the page */
> -			goto out;
> -		}
> -	} else {
> -		folio = state->folio;
> -		state->folio = NULL;
> +	ret = mfill_copy_folio_locked(folio, src_addr);
> +	if (unlikely(ret)) {
> +		/*
> +		 * Fallback to copy_from_user outside mmap_lock.
> +		 * If retry is successful, mfill_copy_folio_locked() returns
> +		 * with locks retaken by mfill_get_vma().

nit: mfill_copy_folio_locked() -> mfill_copy_folio_retry();

> +		 * If there was an error, we must mfill_put_vma() anyway and it
> +		 * will take care of unlocking if needed.
> +		 */
> +		ret = mfill_copy_folio_retry(state, folio);
> +		if (ret)
> +			goto out_release;
>  	}
>  
>  	/*

-- 
Cheers,
Harry / Hyeonggon

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCA3FB7FE;
	Tue, 31 Mar 2026 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967560; cv=none; b=MseVlxRM0a1sJF5MTjr3/cV3ifARVj5gCw21MXm2JWuOJlsspMpF5FEaiEwzWB4Ft6nycAJKpbp4KW+ou1AR0eduxa29nyvuodz1KfXfJlAAcWOLtoSC3e9GLW2OG7ktIFqKey+qnHI76W3th7jIaXR27+eYLUn+XXqVTz1bgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967560; c=relaxed/simple;
	bh=eCcZFLBMKfzOLFrTMyw6/QPJblN9ZaXUah2YenOiatQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sP6g+XkFxaYpGe0UT2UnoNxKzJ7pbkLC2MdeP/VrHnu3yTy69sAHXPOuRR2+woZly1L80jqnxBGNglRUMmmOcIQ/zqqQyK440dKB51X0464idTBGVvDJ/e58xC6HoUyL6ARXG84GY11eRSsHVBTJPGR8KOQDQYtmcXHZO1jvDtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zck+Jne5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zck+Jne5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CCCC19424;
	Tue, 31 Mar 2026 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967560;
	bh=eCcZFLBMKfzOLFrTMyw6/QPJblN9ZaXUah2YenOiatQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zck+Jne5EuclgGsxonpXVSJJaoN10ildftuLrZuUiFKQeHmChX1y7iFUOzhIn0915
	 3beBBAYGThwIgQD9OF23CIYHAXoaY1EMDIQ5+LQlMvBkKJuFSFufIfhSxwkbT8xysl
	 pT1ZNVdwzR79WKuUktdBRdvoXyNu0BxDpt7zALp2cZ/bPbxkM6i4pf/V7SXdtJ8XFw
	 rP777dipQdkTEK10hyfpevVhB+dLfoI3xl8f/vDZxjHUpuHu5cF79a+EmdKyW5n4FC
	 fqoF67FQusrW3nObktdTNu2kjRDxZoTKqHUKOtv8qXptagyfoPAkCy4S98/M8PSW0Y
	 wAagqRHHVbs3w==
Date: Tue, 31 Mar 2026 17:32:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
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
Subject: Re: [PATCH v3 02/15] userfaultfd: introduce struct mfill_state
Message-ID: <acva_NKf7T5rbIC8@kernel.org>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-3-rppt@kernel.org>
 <actxscYZGFiyvUcs@hyeyoo>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <actxscYZGFiyvUcs@hyeyoo>

Hi Harry,

On Tue, Mar 31, 2026 at 04:03:13PM +0900, Harry Yoo (Oracle) wrote:
> On Mon, Mar 30, 2026 at 01:11:03PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > mfill_atomic() passes a lot of parameters down to its callees.
> > 
> > Aggregate them all into mfill_state structure and pass this structure to
> > functions that implement various UFFDIO_ commands.
> > 
> > Tracking the state in a structure will allow moving the code that retries
> > copying of data for UFFDIO_COPY into mfill_atomic_pte_copy() and make the
> > loop in mfill_atomic() identical for all UFFDIO operations on PTE-mapped
> > memory.
> > 
> > The mfill_state definition is deliberately local to mm/userfaultfd.c,
> > hence shmem_mfill_atomic_pte() is not updated.
> > 
> > [harry.yoo@oracle.com: properly initialize mfill_state.len to fix
> >                        folio_add_new_anon_rmap() WARN]
> > Link: https://lkml.kernel.org/r/abehBY7QakYF9bK4@hyeyoo
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> >  mm/userfaultfd.c | 148 ++++++++++++++++++++++++++---------------------
> >  1 file changed, 82 insertions(+), 66 deletions(-)
> > 
> > @@ -790,12 +804,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
> >  	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> >  		goto out_unlock;
> >  
> > -	while (src_addr < src_start + len) {
> > -		pmd_t dst_pmdval;
> > +	state.vma = dst_vma;
> 
> Oh wait, the lock leak was introduced in patch 2.

Lock leak was introduced in patch 4 that moved getting the vma.
Patch 2 missed the assignment of state.len and introduced an issue with
bound checks.

> If there's an error between uffd_mfill_lock() and `state.vma = dst_vma`,
> it remains unlocked.
> 
> Probably should have been fixed in 2, not patch 4...
> Sorry didn't realize it earlier.
> 
> > -		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
> > +	while (state.src_addr < src_start + len) {
> > +		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
> > +
> > +		pmd_t dst_pmdval;
> >  
> > -		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
> > +		dst_pmd = mm_alloc_pmd(dst_mm, state.dst_addr);
> >  		if (unlikely(!dst_pmd)) {
> >  			err = -ENOMEM;
> >  			break;
> > @@ -866,10 +882,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
> >  
> >  out_unlock:
> >  	up_read(&ctx->map_changing_lock);
> > -	uffd_mfill_unlock(dst_vma);
> > +	uffd_mfill_unlock(state.vma);
> >  out:
> > -	if (folio)
> > -		folio_put(folio);
> > +	if (state.folio)
> > +		folio_put(state.folio);
> 
> Sashiko raised a concern [2] that it the VMA might be unmapped and
> a new mapping created as a uffd hugetlb vma and leak the folio by
> going through
> 
> `if (is_vm_hugetlb_page(dst_vma))
>         return mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
>                                     src_start, len, flags);`
> 
> but it appears to be a false positive (to me) because
> 
> `if (atomic_read(&ctx->mmap_changing))` check should have detected unmapping
> and free the folio?

I think it's real, and it's there more or less from the beginning, although
nobody hit it yet :)

Before retrying the copy we drop all the locks, so if the copy is really
long the old mapping can be wiped and a new mapping can be created instead.

There's already a v4 of a patch that attempts to solve this:

https://lore.kernel.org/all/20260331134158.622084-1-devnexen@gmail.com
 
> [2] https://sashiko.dev/#/patchset/20260330101116.1117699-1-rppt%40kernel.org?patch=13671
> 
> >  	VM_WARN_ON_ONCE(copied < 0);
> >  	VM_WARN_ON_ONCE(err > 0);
> >  	VM_WARN_ON_ONCE(!copied && !err);
> 
> Otherwise looks correct to me.
> 
> -- 
> Cheers,
> Harry / Hyeonggon

-- 
Sincerely yours,
Mike.

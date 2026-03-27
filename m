Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7DA3C8715;
	Fri, 27 Mar 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597588; cv=none; b=cFyHkjOdvT89rpWgBkIstSivVtxcsHtNo4Eqw+CYyRsBPvJIpupUyuBDcsxEi0ilAJsvCJ42WM02usiWVJkh3YKZ3HeX03w/zGCwCapDD5G5zZeNVKVWiWllLau0nvUUhLaVrB1Q0PJ/Vwx5hFXTFbSY2u7n6JMJlua8uN95S6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597588; c=relaxed/simple;
	bh=YpYLgI0jbsF+A0nzcAUua2nUX4/yXL66W0C5PJTgXrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nq/N6Hk/W5ipTmTN2rKtHSpzQUrnzY/sVq4SFk4UqLQQbDIegPjFQuM216G1g8KAf+YK++fiZLbbUbsNpqNJGYP5K+qcOSTwnsg+MPONoL6ERs8z3A6i0zONISXQm/MBS8as5FaaFu8SrXmvXlNhylzz4ZaqzxdgpIXseBDRQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAnfdjN+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAnfdjN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BD4C19423;
	Fri, 27 Mar 2026 07:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774597587;
	bh=YpYLgI0jbsF+A0nzcAUua2nUX4/yXL66W0C5PJTgXrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAnfdjN+EsvFi1j+dVGjzyHPyTGqTDMKTZrNVgQtgdS3xTJN/KeC6SXfA6DW6KjZ+
	 aXiEtUM3bJ0ki+Z9akOlTunEzzX5U9ssu8zkRelLpjeQHa/HwmIwwj6h10u5dOEg0M
	 EKBK/9ZwAoABVZvbLpHEF0ii0f6vV3ud6iWKWuUuKizQooRHUkahfT6Z9o8xP7UzAv
	 V7Ey/wrGk7siZDOJ5MJ/BLtJ5l6cix8sJsH1OOi+2j3uqZx/SfPbQJnE1wX5So5cdI
	 qTCscyLEFql+4cw/7JjIAf1/JD2WybgTQS/Y93nhclmXbb4rNjhVp/Hxc+mgKRvhwF
	 qjAqgYGSU/bnA==
Date: Fri, 27 Mar 2026 10:46:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Subject: Re: [PATCH v2 10/15] shmem, userfaultfd: implement shmem uffd
 operations using vm_uffd_ops
Message-ID: <acY1x8M3y7xWLwBa@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-11-rppt@kernel.org>
 <CADrL8HXajnfE=WusxL=DeF7VcvrsX9z5XDC4mPt1JfMOd7J5DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HXajnfE=WusxL=DeF7VcvrsX9z5XDC4mPt1JfMOd7J5DA@mail.gmail.com>

On Thu, Mar 26, 2026 at 06:13:37PM -0700, James Houghton wrote:
> On Fri, Mar 6, 2026 at 9:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Add filemap_add() and filemap_remove() methods to vm_uffd_ops and use
> > them in __mfill_atomic_pte() to add shmem folios to page cache and
> > remove them in case of error.
> >
> > Implement these methods in shmem along with vm_uffd_ops->alloc_folio()
> > and drop shmem_mfill_atomic_pte().
> >
> > Since userfaultfd now does not reference any functions from shmem, drop
> > include if linux/shmem_fs.h from mm/userfaultfd.c
> >
> > mfill_atomic_install_pte() is not used anywhere outside of
> > mm/userfaultfd, make it static.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  include/linux/shmem_fs.h      |  14 ----
> >  include/linux/userfaultfd_k.h |  21 +++--
> >  mm/shmem.c                    | 148 ++++++++++++----------------------
> >  mm/userfaultfd.c              |  79 +++++++++---------
> >  4 files changed, 106 insertions(+), 156 deletions(-)
> >
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index a8273b32e041..1a345142af7d 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -221,20 +221,6 @@ static inline pgoff_t shmem_fallocend(struct inode *inode, pgoff_t eof)
> >
> >  extern bool shmem_charge(struct inode *inode, long pages);
> >
> > -#ifdef CONFIG_USERFAULTFD
> > -#ifdef CONFIG_SHMEM
> > -extern int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
> > -                                 struct vm_area_struct *dst_vma,
> > -                                 unsigned long dst_addr,
> > -                                 unsigned long src_addr,
> > -                                 uffd_flags_t flags,
> > -                                 struct folio **foliop);
> > -#else /* !CONFIG_SHMEM */
> > -#define shmem_mfill_atomic_pte(dst_pmd, dst_vma, dst_addr, \
> > -                              src_addr, flags, foliop) ({ BUG(); 0; })
> > -#endif /* CONFIG_SHMEM */
> > -#endif /* CONFIG_USERFAULTFD */
> > -
> >  /*
> >   * Used space is stored as unsigned 64-bit value in bytes but
> >   * quota core supports only signed 64-bit values so use that
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> > index 4d8b879eed91..bf4e595ac914 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -93,10 +93,24 @@ struct vm_uffd_ops {
> >         struct folio *(*get_folio_noalloc)(struct inode *inode, pgoff_t pgoff);
> >         /*
> >          * Called during resolution of UFFDIO_COPY request.
> > -        * Should return allocate a and return folio or NULL if allocation fails.
> > +        * Should allocate and return a folio or NULL if allocation
> > +        * fails.
> >          */
> >         struct folio *(*alloc_folio)(struct vm_area_struct *vma,
> >                                      unsigned long addr);
> > +       /*
> > +        * Called during resolution of UFFDIO_COPY request.
> > +        * Should lock the folio and add it to VMA's page cache.
> 
> I don't think "should lock the folio" is accurate. That sounds like
> "it will call folio_lock()" but it actually calls
> __folio_set_locked(). Maybe this is better:
> 
> "Should only be called with a folio returned by alloc_folio() above.
> The folio will set to locked."

Yeah, sounds good.
 
> > +        * Returns 0 on success, error code on failure.
> > +        */
> > +       int (*filemap_add)(struct folio *folio, struct vm_area_struct *vma,
> > +                        unsigned long addr);

> > @@ -404,6 +400,9 @@ int mfill_atomic_install_pte(pmd_t *dst_pmd,
> >
> >         set_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
> >
> > +       if (page_in_cache)
> > +               folio_unlock(folio);
> 
> I don't really like doing the folio_unlock() *here*, I think it's
> clearer if the callers (mfill_atomic_pte_continue() and
> __mfill_atomic_pte()) unlocked the folio themselves. But that's just
> my opinion.

We already have page_in_cache here, so I'd prefer to keep a single
folio_unlock() rather than add additional if (page_in_cache) in
__mfill_atomic_pte().
 
> > +
> >         /* No need to invalidate - it was non-present before */
> >         update_mmu_cache(dst_vma, dst_addr, dst_pte);
> >         ret = 0;
> > @@ -836,41 +856,18 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
> >
> >  static __always_inline ssize_t mfill_atomic_pte(struct mfill_state *state)
> >  {
> > -       struct vm_area_struct *dst_vma = state->vma;
> > -       unsigned long src_addr = state->src_addr;
> > -       unsigned long dst_addr = state->dst_addr;
> > -       struct folio **foliop = &state->folio;
> >         uffd_flags_t flags = state->flags;
> > -       pmd_t *dst_pmd = state->pmd;
> > -       ssize_t err;
> >
> >         if (uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> >                 return mfill_atomic_pte_continue(state);
> >         if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON))
> >                 return mfill_atomic_pte_poison(state);
> > +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
> > +               return mfill_atomic_pte_copy(state);
> > +       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE))
> > +               return mfill_atomic_pte_zeropage(state);
> 
> Thanks for this cleanup. :)
> 
> >
> > -       /*
> > -        * The normal page fault path for a shmem will invoke the
> > -        * fault, fill the hole in the file and COW it right away. The
> > -        * result generates plain anonymous memory. So when we are
> > -        * asked to fill an hole in a MAP_PRIVATE shmem mapping, we'll
> > -        * generate anonymous memory directly without actually filling
> > -        * the hole. For the MAP_PRIVATE case the robustness check
> > -        * only happens in the pagetable (to verify it's still none)
> > -        * and not in the radix tree.
> > -        */
> > -       if (!(dst_vma->vm_flags & VM_SHARED)) {
> > -               if (uffd_flags_mode_is(flags, MFILL_ATOMIC_COPY))
> > -                       err = mfill_atomic_pte_copy(state);
> > -               else
> > -                       err = mfill_atomic_pte_zeropage(state);
> > -       } else {
> > -               err = shmem_mfill_atomic_pte(dst_pmd, dst_vma,
> > -                                            dst_addr, src_addr,
> > -                                            flags, foliop);
> > -       }
> > -
> > -       return err;
> > +       return -EOPNOTSUPP;
> 
> WARN_ONCE() here I think.

I'll add VM_WARN_ONCE() here.

> Feel free to add:
> 
> Reviewed-by: James Houghton <jthoughton@google.com>

Thanks!

-- 
Sincerely yours,
Mike.

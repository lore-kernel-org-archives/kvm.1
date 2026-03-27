Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6FB354AC7;
	Fri, 27 Mar 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611078; cv=none; b=kDPZuFhpDRbGKzK+nY6LtDHm/0vZPZucwXnmZGV/T0wGx2WZDqYhV2NxwlgzMbQnvliudPTgeZXrYLEoxXWKJDexvWxqhZ/Z9niF0vmHDl33VCZyNE24bROdtfi0S4k9DuCDlD/9m7K8+wiIGbgE6R66aoqpLyJ8U35785X4998=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611078; c=relaxed/simple;
	bh=mOs+f1u+WyiqSYt3GiUnjwCnkAFMVSxmeQkggvC2jHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/U9A/bs1zX2//gCxxTep92wyEStgieJ9ZvUCwSlLKF/hLaNKlQ3T4/bJJh7aPLCEX9NUZN8zgrzByRJ1XbWr2NziX6UFzZTxSLF+s3ZbxyhY4IVVYHRU3kOY/H2y8ItuJ5A26aKp6dTcmB+Ki1x1btN3A2OIlSmrlQnfXwqDso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4MjpK69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4MjpK69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C54C19423;
	Fri, 27 Mar 2026 11:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774611078;
	bh=mOs+f1u+WyiqSYt3GiUnjwCnkAFMVSxmeQkggvC2jHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4MjpK69mTjB/d2r6HzwMtnkpMhj2cskZeq51ftIyHennIa4UuCYvWAsK8iGF7qq7
	 X4C8uDhyAVOa3c3YnkWLnQ/y52VQT4mIc4BId9LWlE2RE3UWPY+4RT/i56F36rg2n1
	 F5/yPnkFF9H3F0t35IBJsXhAoitFF4aBJzdqpeVbnchRKAVB7/IfIkX0EzslHgbymv
	 XLNXYmoqkKQL0dSkCjBjcRJPNokENji14QZKgVc2q/1YzqZssKYyoHVfxEWQp9vZyQ
	 22A97Yrhcii0R9h3fZ9vztdAWUGJcu8Za9rfEvFS11k9EqOJG3JFV+bAMvC44Xxmj3
	 y32xynP6g2Alg==
Date: Fri, 27 Mar 2026 14:31:06 +0300
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
Subject: Re: [PATCH v2 12/15] mm: generalize handling of userfaults in
 __do_fault()
Message-ID: <acZqemRy3ltBWGL2@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-13-rppt@kernel.org>
 <CADrL8HVUJ5FL97d9ytxp2WXos6HS+U+ycpsi5VxffsW9vacr9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HVUJ5FL97d9ytxp2WXos6HS+U+ycpsi5VxffsW9vacr9Q@mail.gmail.com>

On Thu, Mar 26, 2026 at 06:55:15PM -0700, James Houghton wrote:
> On Fri, Mar 6, 2026 at 9:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Peter Xu <peterx@redhat.com>
> >
> > When a VMA is registered with userfaulfd, its ->fault()
> > method should check if a folio exists in the page cache and call
> > handle_userfault() with appropriate mode:
> >
> > - VM_UFFD_MINOR if VMA is registered in minor mode and the folio exists
> > - VM_UFFD_MISSING if VMA is registered in missing mode and the folio
> >   does not exist
> >
> > Instead of calling handle_userfault() directly from a specific ->fault()
> > handler, call __do_userfault() helper from the generic __do_fault().
> >
> > For VMAs registered with userfaultfd the new __do_userfault() helper
> > will check if the folio is found in the page cache using
> > vm_uffd_ops->get_folio_noalloc() and call handle_userfault() with the
> > appropriate mode.
> >
> > Make vm_uffd_ops->get_folio_noalloc() required method for non-anonymous
> > VMAs mapped at PTE level.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  mm/memory.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  mm/shmem.c       | 12 ------------
> >  mm/userfaultfd.c |  8 ++++++++
> >  3 files changed, 51 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 07778814b4a8..e2183c44d70b 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5328,6 +5328,41 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> >         return VM_FAULT_OOM;
> >  }
> >
> > +#ifdef CONFIG_USERFAULTFD
> > +static vm_fault_t __do_userfault(struct vm_fault *vmf)
> > +{
> > +       struct vm_area_struct *vma = vmf->vma;
> > +       struct inode *inode;
> > +       struct folio *folio;
> > +
> > +       if (!(userfaultfd_missing(vma) || userfaultfd_minor(vma)))
> > +               return 0;
> > +
> > +       inode = file_inode(vma->vm_file);
> > +       folio = vma->vm_ops->uffd_ops->get_folio_noalloc(inode, vmf->pgoff);
> 
> If you do away with the change you made to vma_can_userfault(), please
> add a WARN_ON_ONCE() here if uffd_ops or uffd_ops->get_folio_noalloc
> are not present.
> 
> > +       if (!IS_ERR_OR_NULL(folio)) {
> > +               /*
> > +                * TODO: provide a flag for get_folio_noalloc() to avoid
> > +                * locking (or even the extra reference?)
> > +                */
> 
> I think a whole new op is better than adding a flag. Something like
> uffd_ops->folio_present().

Right now it follows what shmem does, let's keep it as TODO for future
optimizations.
 
> > +               folio_unlock(folio);
> > +               folio_put(folio);
> > +               if (userfaultfd_minor(vma))
> > +                       return handle_userfault(vmf, VM_UFFD_MINOR);
> > +       } else {
> > +               if (userfaultfd_missing(vma))
> > +                       return handle_userfault(vmf, VM_UFFD_MISSING);
> > +       }
> > +
> > +       return 0;
> > +}
> > +#else
> > +static inline vm_fault_t __do_userfault(struct vm_fault *vmf)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  /*
> >   * The mmap_lock must have been held on entry, and may have been
> >   * released depending on flags and vma->vm_ops->fault() return value.
> > @@ -5360,6 +5395,14 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
> >                         return VM_FAULT_OOM;
> >         }
> >
> > +       /*
> > +        * If this is an userfaultfd trap, process it in advance before
> 
> "If this is a userfault"

Indeed :)
 
> > +        * triggering the genuine fault handler.
> > +        */
> > +       ret = __do_userfault(vmf);
> > +       if (ret)
> > +               return ret;
> > +
> >         ret = vma->vm_ops->fault(vmf);
> >         if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
> >                             VM_FAULT_DONE_COW)))
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 68620caaf75f..239545352cd2 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2489,13 +2489,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
> >         fault_mm = vma ? vma->vm_mm : NULL;
> >
> >         folio = filemap_get_entry(inode->i_mapping, index);
> > -       if (folio && vma && userfaultfd_minor(vma)) {
> > -               if (!xa_is_value(folio))
> > -                       folio_put(folio);
> > -               *fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
> > -               return 0;
> > -       }
> > -
> >         if (xa_is_value(folio)) {
> >                 error = shmem_swapin_folio(inode, index, &folio,
> >                                            sgp, gfp, vma, fault_type);
> > @@ -2540,11 +2533,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
> >          * Fast cache lookup and swap lookup did not find it: allocate.
> >          */
> >
> > -       if (vma && userfaultfd_missing(vma)) {
> > -               *fault_type = handle_userfault(vmf, VM_UFFD_MISSING);
> > -               return 0;
> > -       }
> > -
> >         /* Find hugepage orders that are allowed for anonymous shmem and tmpfs. */
> >         orders = shmem_allowable_huge_orders(inode, vma, index, write_end, false);
> >         if (orders > 0) {
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 7cd7c5d1ce84..2ac5fad0ed6c 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -2045,6 +2045,14 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
> >             !vma_is_anonymous(vma))
> >                 return false;
> >
> > +       /*
> > +        * File backed memory with PTE level mappigns must implement
> 
> "File-backed VMAs (except HugeTLB VMAs) must implement
> ops->get_folio_alloc() to support userfaults, as all userfaults in
> file-backed VMAs wlll call ops->get_folio_alloc() to determine the
> userfault type."

I like (except HugeTLB) more than "PTE ...", but it's not here to determine
the userfaulfd type, it's here to ensure we can __do_userfault() for a
memory type. 

	/*
	 * File backed VMAs (except HugeTLB) must implement
	 * ops->get_folio_noalloc() because it's required by
	 * __do_userfault() in page fault handling.
	 */
 
> > +        * ops->get_folio_noalloc()
> > +        */
> > +       if (!vma_is_anonymous(vma) && !is_vm_hugetlb_page(vma) &&
> > +           !ops->get_folio_noalloc)
> 
> With the separate folio_present() (or whatever) op, this check becomes
> more obvious. (Looking at this right now, it looks like we're checking
> for UFFDIO_CONTINUE/minor fault support here, but that's not really
> what's going on.)
> 
> Honestly I'm not 100% sure if this check should be here. If it's going
> to be here, then we should probably also have checks like these here:
>
> if (vm_flags & VM_UFFD_MINOR && !ops->get_folio_noalloc)
> 
> and
> 
> if (vm_flags & VM_UFFD_MISSING && !ops->alloc_folio)
> 
> So, maybe we should just leave it up to ops->can_userfault() to make
> sure we're doing the right thing?

This must be in the core so it can reject VMAs that can't be used in
__do_userfault() without complicating hot path in the page fault handler
with extra conditions.

> 
> > +               return false;
> > +
> >         return ops->can_userfault(vma, vm_flags);
> >  }
> >
> > --
> > 2.51.0
> >

-- 
Sincerely yours,
Mike.

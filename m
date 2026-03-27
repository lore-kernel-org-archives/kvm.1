Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF47D311C38;
	Fri, 27 Mar 2026 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612071; cv=none; b=XiBBML+wfoYOEwMzchMd2pmOI/Vqq6DuNjwATylzhU0drFsvot8G/APBiS6W0u0Z0DCKJnp7Q/NeO/r3bmaQ0wvi6D/0yckOBZ+Lecr33XI8b4q8sx0S1WrCDng6WlQ3zTRuwePg+wYRiXW9lyoMa2qEeTzEtVSBh54myds31Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612071; c=relaxed/simple;
	bh=UWqo7y+v96VP3ho6z6Rwh/7HEqf87P4hquLIZgzv6Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCvogHZFJJExZXOAFjxHgK1YCv1I/TNVUdiUAhWYD5dyxM7XM861HJDM78EUXyXH1c9ALgQaxUaidWs2UaS7IX+KhnZWqyth0GxmndltxuT0E2yUwPZeg4IW7oEafrOvQPcjWcPPED5xcg9iwpvF1LA8QVw7W062XfY/Q1HysQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVtPQC1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVtPQC1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307D5C19423;
	Fri, 27 Mar 2026 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774612070;
	bh=UWqo7y+v96VP3ho6z6Rwh/7HEqf87P4hquLIZgzv6Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVtPQC1QKmz6DnjLXtwlTrh2b0p+bEwQvHTZifkPYXVY/sul5MEIRGg0gtTzzhmIg
	 SOGSODY42KxI6xrUOZWneQwo0/9fFNjxWkE0iVbvA6fq5vezKgPyEbTg0E+ho+FxCQ
	 Ju7kEjh/hXS8KNnmOQF5JsaiLpwCeotJWliIg3fmEtBuDtZ6Bi4wuYNaHw1plsOYGk
	 gaHo6F+0A96bzW5HbCtHSIeyk+hMcweQG1/EkAB/+41G0jGn/pXRA198KEdiR6PdaM
	 ncKwKOZMVRHgjWWikiYYWKcmcRoZARR2HT3hEgLKKACDsECDeL+MWwTyuNLOkavVsV
	 6r+o+bsgkDZrg==
Date: Fri, 27 Mar 2026 14:47:39 +0300
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
Subject: Re: [PATCH v2 13/15] KVM: guest_memfd: implement userfaultfd
 operations
Message-ID: <acZuW7_7yBdVsJqK@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-14-rppt@kernel.org>
 <CADrL8HViJ_GaRUd-k9MyM0S8b7sz3whGJHNwvFfCk+pw0+kRgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADrL8HViJ_GaRUd-k9MyM0S8b7sz3whGJHNwvFfCk+pw0+kRgA@mail.gmail.com>

On Thu, Mar 26, 2026 at 07:33:03PM -0700, James Houghton wrote:
> On Fri, Mar 6, 2026 at 9:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Nikita Kalyazin <kalyazin@amazon.com>
> >
> > userfaultfd notifications about page faults used for live migration
> > and snapshotting of VMs.
> >
> > MISSING mode allows post-copy live migration and MINOR mode allows
> > optimization for post-copy live migration for VMs backed with shared
> > hugetlbfs or tmpfs mappings as described in detail in commit
> > 7677f7fd8be7 ("userfaultfd: add minor fault registration mode").
> >
> > To use the same mechanisms for VMs that use guest_memfd to map their
> > memory, guest_memfd should support userfaultfd operations.
> >
> > Add implementation of vm_uffd_ops to guest_memfd.
> >
> > Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> > Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Overall looks fine to me, but I am slightly concerned about in-place
> conversion[1], and I think you're going to want to implement a
> kvm_gmem_folio_present() op or something (like I was saying on the
> previous patch[2]).

Let's solve each problem in it's time :)
 
> [1]: https://lore.kernel.org/kvm/20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com/
> [2]: https://lore.kernel.org/linux-mm/CADrL8HVUJ5FL97d9ytxp2WXos6HS+U+ycpsi5VxffsW9vacr9Q@mail.gmail.com/
> 
> Some in-line comments below.
> 
> > ---
> >  mm/filemap.c           |  1 +
> >  virt/kvm/guest_memfd.c | 84 +++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 83 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 6cd7974d4ada..19dfcebcd23f 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -107,6 +108,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
> >         return __kvm_gmem_prepare_folio(kvm, slot, index, folio);
> >  }
> >
> > +static struct folio *kvm_gmem_get_folio_noalloc(struct inode *inode, pgoff_t pgoff)
> > +{
> > +       return __filemap_get_folio(inode->i_mapping, pgoff,
> > +                                  FGP_LOCK | FGP_ACCESSED, 0);
> > +}
> 
> When in-place conversion is supported, I wonder what the semantics
> should be for when we get userfaults.
> 
> Upon a userspace access to a file offset that is populated but
> private, should we get a userfault or a SIGBUS?
> 
> I guess getting a userfault is strictly more useful for userspace, but
> I'm not sure which choice is more correct.
 
Me neither :)

We can deliver userfault, but just block UFFDIO_COPY, can't we?

> > +static int kvm_gmem_filemap_add(struct folio *folio,
> > +                               struct vm_area_struct *vma,
> > +                               unsigned long addr)
> > +{
> > +       struct inode *inode = file_inode(vma->vm_file);
> > +       struct address_space *mapping = inode->i_mapping;
> > +       pgoff_t pgoff = linear_page_index(vma, addr);
> > +       int err;
> > +
> > +       __folio_set_locked(folio);
> > +       err = filemap_add_folio(mapping, folio, pgoff, GFP_KERNEL);
> 
> This is going to get more interesting with in-place conversion. I'm
> not really sure how to synchronize with it, but we'll probably need to
> take the invalidate lock for reading. And then we'll need a separate
> uffd_op to drop it after we install the PTE... I think.

I think we can start simple and then move on along with the in-place
conversion work. If there will be a need for a new uffd_ops callback we can
add it then.
 
-- 
Sincerely yours,
Mike.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81F246783;
	Fri, 27 Mar 2026 00:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774571196; cv=none; b=D+ZPrLyJRwJOd895OR8VcB65cSvN0lXQ9e858NhHH0hewgYqootZ4lYxU83RKYrGN19JXFc8yPEZFdHQrl1JWDR3g9NKyhWh3cRl8lbYgsTLTi0gH9T57pH5Ry5cLPQqjI6X0AqYtc77sGsqrTxbBSa8xXTqp32knBTp979BlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774571196; c=relaxed/simple;
	bh=DmnxU7Wn50/b1W1iUaXZMK/22QeVR6KQ3xAre+v1FVk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V27D2IZ2F4GfvhM/1wE5bws20Wm2eAaZDkxNbFobuS3jobq31/XLAWsH3HEzEr9KM4VKGs9lerTYx8pG7RKtLRfERXrTQGgnYrfB6sF4dt6UHQ8s5rkq9t1IkyDcwV6di2ol3wiOZhurbwHK/x7SrISuiPb7Jhvt10Ufo5jOTC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uweo7ewx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uweo7ewx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0709C116C6;
	Fri, 27 Mar 2026 00:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774571195;
	bh=DmnxU7Wn50/b1W1iUaXZMK/22QeVR6KQ3xAre+v1FVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uweo7ewxvIAb/XfhHkku7Y7z/JEQW5F3fnuxI2Y360uEmlAgFOL7e/1MTNPXbqSZ0
	 rHl32t2/ymETPBIh2E4oSHsrneCeq1kkB8GmzBiAY1s5mtbrTJa2QyD/Wyr/s7V4q2
	 dO4xQck9r2/UJxjzihuCa5x44nLmo8+vEotrCMyY=
Date: Thu, 26 Mar 2026 17:26:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: James Houghton <jthoughton@google.com>
Cc: Mike Rapoport <rppt@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, Hugh
 Dickins <hughd@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, Muchun Song
 <muchun.song@linux.dev>, Nikita Kalyazin <kalyazin@amazon.com>, Oscar
 Salvador <osalvador@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
 <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v2 08/15] shmem, userfaultfd: use a VMA callback to
 handle UFFDIO_CONTINUE
Message-Id: <20260326172634.11ee1b67cedfc5984bc9db6c@linux-foundation.org>
In-Reply-To: <CADrL8HWLnuQHEPFN9SZbAd_Lq1USJDV=Di4fsQuztwp4v5oXOg@mail.gmail.com>
References: <20260306171815.3160826-1-rppt@kernel.org>
	<20260306171815.3160826-9-rppt@kernel.org>
	<CADrL8HWLnuQHEPFN9SZbAd_Lq1USJDV=Di4fsQuztwp4v5oXOg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 26 Mar 2026 16:43:27 -0700 James Houghton <jthoughton@google.com> wrote:

> On Fri, Mar 6, 2026 at 9:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > When userspace resolves a page fault in a shmem VMA with UFFDIO_CONTINUE
> > it needs to get a folio that already exists in the pagecache backing
> > that VMA.
> >
> > Instead of using shmem_get_folio() for that, add a get_folio_noalloc()
> > method to 'struct vm_uffd_ops' that will return a folio if it exists in
> > the VMA's pagecache at given pgoff.
> >
> > Implement get_folio_noalloc() method for shmem and slightly refactor
> > userfaultfd's mfill_get_vma() and mfill_atomic_pte_continue() to support
> > this new API.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> I found myself asking why HugeTLB wasn't included here; it's because
> we call into hugetlb_mfill_atomic_pte() pretty early. It would be nice
> to have HugeTLB implement get_folio_noalloc() and use the same path as
> shmem, but we don't have to do that now.
> 
> Feel free to add:
> 
> Reviewed-by: James Houghton <jthoughton@google.com>

Thanks.

> >  static int mfill_atomic_pte_continue(struct mfill_state *state)
> >  {
> >         struct vm_area_struct *dst_vma = state->vma;
> > +       const struct vm_uffd_ops *ops = vma_uffd_ops(dst_vma);
> >         unsigned long dst_addr = state->dst_addr;
> >         pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
> >         struct inode *inode = file_inode(dst_vma->vm_file);
> > @@ -586,16 +590,13 @@ static int mfill_atomic_pte_continue(struct mfill_state *state)
> >         struct page *page;
> >         int ret;
> >
> > -       ret = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
> > +       if (!ops)
> > +               return -EOPNOTSUPP;
> 
> Perhaps WARN_ON_ONCE(!ops)?
> 

fyi, I (and I expect many others) tend to consider a "Reviewed-by:" as
end-of-message, So if you have additional comments then add something
like "comments below" so we know to keep scrolling!

If there are no additional comments, simply zap all quoted material after the
R-b to remove all doubt.

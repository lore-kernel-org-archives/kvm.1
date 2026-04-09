Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DDD3C3444;
	Thu,  9 Apr 2026 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755150; cv=none; b=o7nbtqJcQVUqyMtMuSAGK9B7xFdQuz9+OaQcdyUYgg330Bd2JLP8aQwEogg7zJEGazJlix3YBeARUA+wb46WFhybXorNus53+yDNIEdczYUTieRYzBb9WINbbaaHr3Yu6JUMMdUSCq0NG15nft8JDDRDKLsGOTa8ah+RYrQ0aHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755150; c=relaxed/simple;
	bh=cGMLUPOtx8qaZqawYKdm2oqkNFYMjpc+BvWqDcnrHmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPxCrOK8pj/jfZIujQoJcmvWO1yxbURb/e5vafXW1h/WDEyUtPeQwzZTLlkKA8Rv/z6bi6+STNYUSOYDwTL/JeYMXu54wTHJVTM866aCtaJZUqcNrgzQrBNM4RrKo24NFILoRcUFZVQ6idnb8cqPgladaCaUKHM1wIyosrsQ2K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TANCjvkw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TANCjvkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338ACC4CEF7;
	Thu,  9 Apr 2026 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775755149;
	bh=cGMLUPOtx8qaZqawYKdm2oqkNFYMjpc+BvWqDcnrHmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TANCjvkwBh0HGfxUlaqhwxG1wASBAqCJhrHR+iNTurVIvK7eDEUwCeDqx+t4TlRol
	 AgdDj8kwm6Vk3GekEV/tztKEH2omKNhV816obK929+XIO7HpukmwN1iiFr8cymvieU
	 njkaq1E3/Sa5xZ/MitYIofrgWeZ0jhhXzJVakyzoNvEFhnQrK5DfMlp+AiOm1lgCB8
	 BTQicRTFbKOgnCpDMGjf6/mDFFkPQH3EtMWoGjxGyMebiHPNnTvROup6Xxn1vZDVak
	 dYrfOgpFh2ictQjcE7u6Kn4eZDIdwVV5RAyvgwIpubxVyMxTe4pQWuHa1RllwfEXUC
	 URTq/JMPoPSpw==
Date: Thu, 9 Apr 2026 20:18:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Harry Yoo <harry.yoo@oracle.com>, Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCH v4 07/15] userfaultfd: introduce vm_uffd_ops
Message-ID: <adffgfM5ANxtPIEF@kernel.org>
References: <20260402041156.1377214-1-rppt@kernel.org>
 <20260402041156.1377214-8-rppt@kernel.org>
 <6a171abc-ebd2-4ddf-8c36-34c66ca42043@columbia.edu>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a171abc-ebd2-4ddf-8c36-34c66ca42043@columbia.edu>

On Thu, Apr 02, 2026 at 03:32:58PM -0400, Tal Zussman wrote:
> Hi Mike,
> 
> On 4/2/26 12:11 AM, Mike Rapoport wrote:
> > @@ -2021,34 +2040,33 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> >  bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
> >  		       bool wp_async)
> >  {
> > -	vm_flags &= __VM_UFFD_FLAGS;
> > +	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
> >  
> > -	if (vma->vm_flags & VM_DROPPABLE)
> > -		return false;
> > -
> > -	if ((vm_flags & VM_UFFD_MINOR) &&
> > -	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
> > -		return false;
> > +	vm_flags &= __VM_UFFD_FLAGS;
> >  
> >  	/*
> > -	 * If wp async enabled, and WP is the only mode enabled, allow any
> > +	 * If WP is the only mode enabled and context is wp async, allow any
> >  	 * memory type.
> >  	 */
> >  	if (wp_async && (vm_flags == VM_UFFD_WP))
> >  		return true;
> >  
> > +	/* For any other mode reject VMAs that don't implement vm_uffd_ops */
> > +	if (!ops)
> > +		return false;
> > +
> > +	if (vma->vm_flags & VM_DROPPABLE)
> > +		return false;
> > +
> 
> Doesn't moving the VM_DROPPABLE check after the wp_async early return make
> the issue David raised in [1] possible again (i.e. moving swapbacked pages
> into a droppable region using UFFDIO_MOVE)? With this change, VM_DROPPABLE
> pages can now be registered with uffd under wp_async, which allows
> UFFDIO_MOVE.
> 
> I think the VM_DROPPABLE check should go right before the wp_async check.
> And it would probably benefit from a comment...

You are right.

Andrew, if it's not too late can you please add this fixup:

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f1828106484b..75290483ffc7 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2019,6 +2019,9 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 {
 	const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
 
+	if (vma->vm_flags & VM_DROPPABLE)
+		return false;
+
 	vm_flags &= __VM_UFFD_FLAGS;
 
 	/*
@@ -2032,9 +2035,6 @@ bool vma_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags,
 	if (!ops)
 		return false;
 
-	if (vma->vm_flags & VM_DROPPABLE)
-		return false;
-
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
 	 * uffd-wp, then only anonymous memory is supported

 
> Thanks,
> Tal

-- 
Sincerely yours,
Mike.

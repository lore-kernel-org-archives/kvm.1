Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B42D7398;
	Sun, 22 Mar 2026 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774174950; cv=none; b=doYAIOJPFCOsXgXKxxw8FNl6W8P3uuok1Jml3Bxu3dlINi/FoKodbqA1U7HD9BLjUHbJqSi+uHsPyvdr7aZBMcCiyESJXt5tBmqpQyJ/5ryAVIdbfOhNsJaVrlDrka8CXy4IeVsfXDfaBjE59A9zQDIs3f/9aeAJeRQ/ndGf8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774174950; c=relaxed/simple;
	bh=ja8xYsnuPES+yA0rNROYguH6Aiw+cEWcqhgX6fvgPdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRxnZ1rH7tG3izoqCbAg7/AdyhzyB4BQjRZ+nAiPeWB0hdxdJelzsZrhUEnYRYmSNRvkO3wCEQPi9zFDY4WSXvTg71OSa5/vCPjMn7+25hp/YSVnt1hIB6X86gZ1tTnrNa6lgdHjVYDoax8SLKFObVHwgkuLygkN1v8uiUoMTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBUBeWMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBUBeWMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2CBC19424;
	Sun, 22 Mar 2026 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774174949;
	bh=ja8xYsnuPES+yA0rNROYguH6Aiw+cEWcqhgX6fvgPdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBUBeWMGDb+8siC07t1h2NvFCZ9g+o0BUqaeaOADmskfTDWZlRbxSMC+IV4f1YRm8
	 7xNJWwypic+vW4gFPxCCxB9YUNfWNaZLHHLQT62spAQ6sQn0pLbITciakpYMnFzlHY
	 7QV4Dthc4IrKZS/wmEJ9Avw+QhcHFpHBCQD8/snwbHF3npHHvLCLdE5+fBLHwOmLEe
	 FlzeqpsvnJIB20mxp/4p+bUvzVzHdPu6RCoL2CoJEPxfp/ZtIxNR1AD47QusOm/Ah/
	 7Elnp421pTGBrVqC/rBBgk0YRP/cFrtzTDJejpVNplpIxI1qzCtLuxd4MPY0XcGiVK
	 S48LVT8HX5yVA==
Date: Sun, 22 Mar 2026 12:22:17 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
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
Subject: Re: [PATCH v2 03/15] userfaultfd: introduce mfill_get_pmd() helper.
Message-ID: <ab_C2enJ5DTIH5aH@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-4-rppt@kernel.org>
 <ac39f02d-ed00-4b8d-8156-1e999f5b0af3@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac39f02d-ed00-4b8d-8156-1e999f5b0af3@kernel.org>

On Fri, Mar 20, 2026 at 01:55:29PM +0100, David Hildenbrand (Arm) wrote:
> On 3/6/26 18:18, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Nit: "." at the end of the patch subject
 
Oops :/
 
> > +static int mfill_get_pmd(struct mfill_state *state)
> > +{
> > +	struct mm_struct *dst_mm = state->ctx->mm;
> > +	pmd_t *dst_pmd;
> > +	pmd_t dst_pmdval;
> 
> I'd just have both on a single line.

Can do :) 

> > +	/*
> > +	 * If the dst_pmd is THP don't override it and just be strict.
> > +	 * (This includes the case where the PMD used to be THP and
> > +	 * changed back to none after __pte_alloc().)
> > +	 */
> > +	if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval)))
> 
> Can we directly switch to pmd_leaf() while touching that?

You mean instead of pmd_trans_huge()?
Yeah, sure.

> > @@ -809,41 +838,15 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
> >  	while (state.src_addr < src_start + len) {
> >  		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
> >  
> > -		pmd_t dst_pmdval;
> > -
> > -		dst_pmd = mm_alloc_pmd(dst_mm, state.dst_addr);
> > -		if (unlikely(!dst_pmd)) {
> > -			err = -ENOMEM;
> > +		err = mfill_get_pmd(&state);
> > +		if (err)
> 
> 
> It's a bit odd that a "get" function doesn't return a PMD pointer but
> instead stores it in the state.
> 
> Maybe more like "mfill_prepare_pmd" ? But actually you want to have a
> pte table.
> 
> mfill_prepare_pte_table() or alternatively mfill_alloc_pte_table() /
> mfill_alloc_dst_pte_table()

As it actually allocates the pte table once in 512 times, I'd prefer
mfill_establish_pmd().
 
> -- 
> Cheers,
> David

-- 
Sincerely yours,
Mike.

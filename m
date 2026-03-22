Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001B40DFC3;
	Sun, 22 Mar 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774173812; cv=none; b=Zyn+T+j1uK6UnioVGDE0VZ2anbl3C48Gmz09KImWhcnNH73cKuR1p6Tt0lZWS2Yu1+6bhXL7cA1sOU4G1stNZ68IiyYqyyQpNczCh0gslQUIhVGHFXjzZhkoqeaxtpgVNAeXX175r6AaZpTJr945MpAGh+oSX0GpNZMGv4SgkU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774173812; c=relaxed/simple;
	bh=Fd+lxjtADX8/WZHW/OyQK4X1bNRqeHw1tgTw6r/x3uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1HU40s+eKPqn21CcB82M8KlpqrLkHopLjUewWuIaegvqqtLKYFs54KeVwMQNwMafN1ZwlFfu70SXX6goXjtkNv1qwHPRWXoOfUSY0sTfvIlHyFEDfPoRKyXttglwJ0LN7yaz6kgECLIp2r5p5KIQrT0SvA6TbbRAVPxDlxFkc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkwqs+Gd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkwqs+Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E66C19424;
	Sun, 22 Mar 2026 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774173811;
	bh=Fd+lxjtADX8/WZHW/OyQK4X1bNRqeHw1tgTw6r/x3uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkwqs+GdaaEAajw166Bmx1YdcGAsvLlGDPSFBV70sxX+r1fX5sTLxCaahqhaG/lUd
	 MUVFpXziVlYbj1lO2VnT9P8q0ZW4amvS6+Pc+bGSziz9pcMYA0Wv3M2IXakVzvhvJM
	 LJGXn61p9spS2dEUse2xD8c2n/9cNe9Fv5vRUXOOoFl5PmWJg8GZ9oxHl+WeAUWa5t
	 xlfltvoQkLoBSKpJUaerBRbWx2DpQAlkTGOhBSNaZvvhwwk6NnJtbolesp9EM9EIFO
	 cNiBxU0nK9gppQK6FZUvlQkCpr/05lk+bGhp/MJUH7Uek1PPbNsbeQkncCWE4VhLOn
	 7TY1/0TcY3zSQ==
Date: Sun, 22 Mar 2026 12:03:20 +0200
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
Subject: Re: [PATCH v2 02/15] userfaultfd: introduce struct mfill_state
Message-ID: <ab--aBVpTIU0Kn7d@kernel.org>
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-3-rppt@kernel.org>
 <cf190f78-3f5f-499a-aa78-35261850b01a@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf190f78-3f5f-499a-aa78-35261850b01a@kernel.org>

On Fri, Mar 20, 2026 at 01:43:02PM +0100, David Hildenbrand (Arm) wrote:
> On 3/6/26 18:18, Mike Rapoport wrote:
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
> > The mfill_state definition is deliberately local to mm/userfaultfd.c, hence
> > shmem_mfill_atomic_pte() is not updated.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> 
> [...]
> 
> >  			if (fatal_signal_pending(current))
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
> >  	VM_WARN_ON_ONCE(copied < 0);
> >  	VM_WARN_ON_ONCE(err > 0);
> >  	VM_WARN_ON_ONCE(!copied && !err);
> >	return copied ? copied : err;
> 
> I guess, "copied" could be easily avoided by
> comparing state.src_addr with start_addr.

Yeah, but a dedicated variable is more robust against potential changes
in state handling. And it's surely more descriptive and shorter than 

state.src_addr - src_addr;
 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.

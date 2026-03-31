Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07982BF3D7;
	Tue, 31 Mar 2026 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940595; cv=none; b=aXfIFN5cKcYq73Ms9RebcyIm2ZUNCK1RWa7F6M4Sfy47wuzFTuwgJMBol5EVMy9Ch5OJGTKOEgnehAapruKNdCAJGZvKK4JT1C9vh2qqFlAOUAAI9oRd+hUN7xK4lqZiGVDZGk1LeU2D3pF/wHrPQYfR61Q+dJGw9tfGqS9YnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940595; c=relaxed/simple;
	bh=ic+S5YIOVZVio0bt8w8FKUddY4R5LxfMt3J8CL3Z2pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS4jf73YXOnsYrdZFkupmt1phWF7BVJkWMv02A+fjWGe6MF4yNzVpkdtvCwVN4OY0Bpquxmr9rPNXxpshd3NvhSoeVlpbyAgtuc2R8hgsQkyzHjqCri0q7tNGN8t344xTOTHvMo2ZsP9gS/WvbA6fRJFNrYCkh7AWTp7zZY+6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7BkWakY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7BkWakY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBFBC19423;
	Tue, 31 Mar 2026 07:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774940595;
	bh=ic+S5YIOVZVio0bt8w8FKUddY4R5LxfMt3J8CL3Z2pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7BkWakYWogd1+dlacH+q+UQNww+wVXoAME49WY2cx7GjFabSYL49wrASs3mSyhuS
	 kohcpBLMxpJ5WYqZwsAj0+9fWIxhRXPfU9U9VuLRPS4gKM75uM3teIQ0Zu/kZU+ABC
	 4v9e//T8Mwif3OEvRMtktAYV3OgKazSPdCbPR5UmugDNGQa5WzOgd34W0Et+ie4AXp
	 hghn6Ww/zX7tgwUWfWXUGQCNcGRd3VD3++E6xV5ic0jzFd/qGOgPIotcfrq2jpmUcq
	 GEEnFWYaoiTh2dhBX+JEWgWG2JPNWGk0qGJ7GV3jBhIF2ijo3nwaUzhNvHgHp3vH0W
	 UIcnlpKA4zy3w==
Date: Tue, 31 Mar 2026 16:03:13 +0900
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
Subject: Re: [PATCH v3 02/15] userfaultfd: introduce struct mfill_state
Message-ID: <actxscYZGFiyvUcs@hyeyoo>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330101116.1117699-3-rppt@kernel.org>

On Mon, Mar 30, 2026 at 01:11:03PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> mfill_atomic() passes a lot of parameters down to its callees.
> 
> Aggregate them all into mfill_state structure and pass this structure to
> functions that implement various UFFDIO_ commands.
> 
> Tracking the state in a structure will allow moving the code that retries
> copying of data for UFFDIO_COPY into mfill_atomic_pte_copy() and make the
> loop in mfill_atomic() identical for all UFFDIO operations on PTE-mapped
> memory.
> 
> The mfill_state definition is deliberately local to mm/userfaultfd.c,
> hence shmem_mfill_atomic_pte() is not updated.
> 
> [harry.yoo@oracle.com: properly initialize mfill_state.len to fix
>                        folio_add_new_anon_rmap() WARN]
> Link: https://lkml.kernel.org/r/abehBY7QakYF9bK4@hyeyoo
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/userfaultfd.c | 148 ++++++++++++++++++++++++++---------------------
>  1 file changed, 82 insertions(+), 66 deletions(-)
> 
> @@ -790,12 +804,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	    uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
>  		goto out_unlock;
>  
> -	while (src_addr < src_start + len) {
> -		pmd_t dst_pmdval;
> +	state.vma = dst_vma;

Oh wait, the lock leak was introduced in patch 2.
If there's an error between uffd_mfill_lock() and `state.vma = dst_vma`,
it remains unlocked.

Probably should have been fixed in 2, not patch 4...
Sorry didn't realize it earlier.

> -		VM_WARN_ON_ONCE(dst_addr >= dst_start + len);
> +	while (state.src_addr < src_start + len) {
> +		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
> +
> +		pmd_t dst_pmdval;
>  
> -		dst_pmd = mm_alloc_pmd(dst_mm, dst_addr);
> +		dst_pmd = mm_alloc_pmd(dst_mm, state.dst_addr);
>  		if (unlikely(!dst_pmd)) {
>  			err = -ENOMEM;
>  			break;
> @@ -866,10 +882,10 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  
>  out_unlock:
>  	up_read(&ctx->map_changing_lock);
> -	uffd_mfill_unlock(dst_vma);
> +	uffd_mfill_unlock(state.vma);
>  out:
> -	if (folio)
> -		folio_put(folio);
> +	if (state.folio)
> +		folio_put(state.folio);

Sashiko raised a concern [2] that it the VMA might be unmapped and
a new mapping created as a uffd hugetlb vma and leak the folio by
going through

`if (is_vm_hugetlb_page(dst_vma))
        return mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
                                    src_start, len, flags);`

but it appears to be a false positive (to me) because

`if (atomic_read(&ctx->mmap_changing))` check should have detected unmapping
and free the folio?

[2] https://sashiko.dev/#/patchset/20260330101116.1117699-1-rppt%40kernel.org?patch=13671

>  	VM_WARN_ON_ONCE(copied < 0);
>  	VM_WARN_ON_ONCE(err > 0);
>  	VM_WARN_ON_ONCE(!copied && !err);

Otherwise looks correct to me.

-- 
Cheers,
Harry / Hyeonggon

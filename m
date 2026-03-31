Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B583CE4B3;
	Tue, 31 Mar 2026 07:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943454; cv=none; b=C2yygD57j3RQzk9MN8rn1FcQsROZVgHb0OGA4DP3G0VHucqHElx+BCqDtXr99IWdpFYECM8/SMdEn1qXF2L4iRRvJm/IHlkAVStFp4orl1Cv92ZOfmV39VGQg1DnJoq17sMvOmvPE1w0xtCo5GX1rNU1oLqXm15vwNIaowqksUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943454; c=relaxed/simple;
	bh=QmBrY5BKVbXz9CXTgV6unLVzlvXFNRWXO9R3+/R7gS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LasJe4qmdOaPSUPZmvFZL757LM+s0tJCkdCh9vEV0efvpHTUvS1UxUkA4dGKcikd246bb8OVMVQtsMdayJb1Ubq481yDq7CvcgVhDfBYP+iqwz0Bo7CkafVP387OOnFEi7MEZBFNUQ/hh9wf/6im7Yi0C+kcOvwGOZOa5NoeApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otLloVur; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otLloVur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26696C19423;
	Tue, 31 Mar 2026 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774943454;
	bh=QmBrY5BKVbXz9CXTgV6unLVzlvXFNRWXO9R3+/R7gS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otLloVurIebAAh64mVkWyy1Yx4OPNvjHY6Wavo2/t4scZtIey5FAsclGVAReyXELv
	 acxPd9t/ZfkfPv+8RIRukk+mhkmlBvA+a2FBtpVBpcMXMdKf9jax1Ic5HrqbXCTaup
	 L75gDcEL/qZJCWDPtiE0uv2tcJ6ipRACww0DE+70ADtXMBfVxH1qiK2c2+ILM1nif2
	 c6tAhrmqudLZPc4H8kWeC1d15Fd6KPnMbP8ucuuzdJcntZ/ZyBTViRoOtw++xYFqIP
	 mZ8dgFOzD3fLbeFA3spBT4TBU6/1zqW4GUaEm90ycw/3i2nT+5rj39NOfszj0isSvg
	 0qPx21ePK4h+w==
Date: Tue, 31 Mar 2026 16:50:52 +0900
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
Subject: Re: [PATCH v3 03/15] userfaultfd: introduce mfill_establish_pmd()
 helper
Message-ID: <act83N6QP8kgcrZn@hyeyoo>
References: <20260330101116.1117699-1-rppt@kernel.org>
 <20260330101116.1117699-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330101116.1117699-4-rppt@kernel.org>

On Mon, Mar 30, 2026 at 01:11:04PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> There is a lengthy code chunk in mfill_atomic() that establishes the PMD
> for UFFDIO operations.  This code may be called twice: first time when the
> copy is performed with VMA/mm locks held and the other time after the copy
> is retried with locks dropped.
> 
> Move the code that establishes a PMD into a helper function so it can be
> reused later during refactoring of mfill_atomic_pte_copy().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---

Looks good to me,
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

>  mm/userfaultfd.c | 102 ++++++++++++++++++++++++-----------------------
>  1 file changed, 52 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index fa9622ec7279..291e5cfed431 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> +static int mfill_establish_pmd(struct mfill_state *state)
> +{
> +	struct mm_struct *dst_mm = state->ctx->mm;
> +	pmd_t *dst_pmd, dst_pmdval;
> +
> +	dst_pmd = mm_alloc_pmd(dst_mm, state->dst_addr);
> +	if (unlikely(!dst_pmd))
> +		return -ENOMEM;
> +
> +	dst_pmdval = pmdp_get_lockless(dst_pmd);
> +	if (unlikely(pmd_none(dst_pmdval)) &&
> +	    unlikely(__pte_alloc(dst_mm, dst_pmd)))
> +		return -ENOMEM;
> +
> +	dst_pmdval = pmdp_get_lockless(dst_pmd);
> +	/*
> +	 * If the dst_pmd is THP don't override it and just be strict.
> +	 * (This includes the case where the PMD used to be THP and
> +	 * changed back to none after __pte_alloc().)
> +	 */
> +	if (unlikely(!pmd_present(dst_pmdval) || pmd_leaf(dst_pmdval)))

Just noting:						 ^ this was
						 pmd_trans_huge() but
						 now it is pmd_leaf().

but since the present bit is separately checked and hugetlb vma is handled
in a different path I don't expect functional change.

> +		return -EEXIST;
> +	if (unlikely(pmd_bad(dst_pmdval)))
> +		return -EFAULT;
> +
> +	state->pmd = dst_pmd;
> +	return 0;
> +}

-- 
Cheers,
Harry / Hyeonggon

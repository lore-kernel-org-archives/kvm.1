Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524453B6371;
	Fri, 20 Mar 2026 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011336; cv=none; b=g5amSJwt4EYFttOqqp7tDtjugzXqqnD+Frphgu2oq7dssiWxh30aXsEmU0vf2SIfBhMvIBgxb9tZ4wCsTvwX/esc/xTvczFS98k6ahEA7DmqHBlHMNK7cdogVPw8ky7Mkj1T01fr3QWBRf2EFR8VK3lg2KRtxiEdtn8nrus7RSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011336; c=relaxed/simple;
	bh=x2Ny+tySB/kVv3CHXuFUaXt/pcvgPiB8gk4xB8tYNME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOeXGQ4ACdPzzpnhoqiOqVdeZ2F/xceium2dEDv0elkavFC0o8uZVaCWbkCCLuWlaSAN+KVJdvB/KiL7CotVdB6Yd6edsDro971Dlzs6VnDnBsUBgHa62jDF6CUUx+NNnZ2bqnIThsFxEBYYbA9O+4Qm92Bn8o7Ax6baa3WRobo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TERs092U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TERs092U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C86C4CEF7;
	Fri, 20 Mar 2026 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774011336;
	bh=x2Ny+tySB/kVv3CHXuFUaXt/pcvgPiB8gk4xB8tYNME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TERs092UahZEq4jjzMNizqn0nsc1Vpeb/XxyK4Grhudmgyb5fXb+fl1RtkcRuCoNj
	 nL+HEM4DH+nMELtouqvqX2lr3HNzyjWuXDSFiKrIU8cwQ59NSHl2iyBF7OLjrY+cO3
	 8J6M3W8AWwpSCJWbbsnpNNIRfklviwcht5ytuaz2eAskh+67MrPzZlkiucpDGvLEeq
	 dBfdJ0S2xZpd8DPUqn3TxND1IExaSBMlR0wK2uA1+b0hNZvyBruOGrzulE9vF+EDBL
	 ULe9kkrQO0eXiR3hQaXan+lM/U1arWK69K+kGbHGHsc2px+5Qd5xFb8GxW4vuR5bQF
	 /rKnzp9LGma6Q==
Message-ID: <ac39f02d-ed00-4b8d-8156-1e999f5b0af3@kernel.org>
Date: Fri, 20 Mar 2026 13:55:29 +0100
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/15] userfaultfd: introduce mfill_get_pmd() helper.
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins
 <hughd@google.com>, James Houghton <jthoughton@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Nikita Kalyazin <kalyazin@amazon.com>, Oscar Salvador <osalvador@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <20260306171815.3160826-1-rppt@kernel.org>
 <20260306171815.3160826-4-rppt@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260306171815.3160826-4-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 18:18, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Nit: "." at the end of the patch subject

> 
> There is a lengthy code chunk in mfill_atomic() that establishes the PMD
> for UFFDIO operations. This code may be called twice: first time when
> the copy is performed with VMA/mm locks held and the other time after
> the copy is retried with locks dropped.
> 
> Move the code that establishes a PMD into a helper function so it can be
> reused later during refactoring of mfill_atomic_pte_copy().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  mm/userfaultfd.c | 103 ++++++++++++++++++++++++-----------------------
>  1 file changed, 53 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index e68d01743b03..224b55804f99 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -157,6 +157,57 @@ static void uffd_mfill_unlock(struct vm_area_struct *vma)
>  }
>  #endif
>  
> +static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +
> +	pgd = pgd_offset(mm, address);
> +	p4d = p4d_alloc(mm, pgd, address);
> +	if (!p4d)
> +		return NULL;
> +	pud = pud_alloc(mm, p4d, address);
> +	if (!pud)
> +		return NULL;
> +	/*
> +	 * Note that we didn't run this because the pmd was
> +	 * missing, the *pmd may be already established and in
> +	 * turn it may also be a trans_huge_pmd.
> +	 */
> +	return pmd_alloc(mm, pud, address);
> +}
> +
> +static int mfill_get_pmd(struct mfill_state *state)
> +{
> +	struct mm_struct *dst_mm = state->ctx->mm;
> +	pmd_t *dst_pmd;
> +	pmd_t dst_pmdval;

I'd just have both on a single line.

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
> +	if (unlikely(!pmd_present(dst_pmdval) || pmd_trans_huge(dst_pmdval)))

Can we directly switch to pmd_leaf() while touching that?

> +		return -EEXIST;
> +	if (unlikely(pmd_bad(dst_pmdval)))
> +		return -EFAULT;
> +
> +	state->pmd = dst_pmd;
> +	return 0;
> +}


[...]

>  	/*
>  	 * Sanitize the command parameters:
> @@ -809,41 +838,15 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	while (state.src_addr < src_start + len) {
>  		VM_WARN_ON_ONCE(state.dst_addr >= dst_start + len);
>  
> -		pmd_t dst_pmdval;
> -
> -		dst_pmd = mm_alloc_pmd(dst_mm, state.dst_addr);
> -		if (unlikely(!dst_pmd)) {
> -			err = -ENOMEM;
> +		err = mfill_get_pmd(&state);
> +		if (err)


It's a bit odd that a "get" function doesn't return a PMD pointer but
instead stores it in the state.

Maybe more like "mfill_prepare_pmd" ? But actually you want to have a
pte table.

mfill_prepare_pte_table() or alternatively mfill_alloc_pte_table() /
mfill_alloc_dst_pte_table()

-- 
Cheers,

David

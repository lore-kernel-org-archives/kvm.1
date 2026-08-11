Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02673384CE5;
	Tue, 11 Aug 2026 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461166; cv=none; b=QRjAxCOHfLJvObqjCJ/hWuiCnQjHyhpiFgYTo/Wu22WwUE6AXGelbgj57of4v1ZvpBVUYqSQ4qcOZtySLJdU2dW98/GYn1LZtZ9ZuL2xx40YRER54gysgaec6IdYuEPqo2z9krNqLXJtpLab3fS5nZWFbVc2uuiUL2K/VPFH2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461166; c=relaxed/simple;
	bh=v0dPlt+Aa4+ZqeZw/6bpu02tt94HRXGQVIZ5D96o5MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QK7RA62KCxxE7qo2jOvbs0QB9S5ED+XE/6lF/FOFn2Tc1+LBFCOsl0bdR77gyL55/AGQ98+krgWr1ruzg1t4zi68joWlFl4eJbx8k5sFoKR+jgBY+SpFS4cKTFZCfj7y7ptzIOD5PYV3MQIQ8H2Ug5hx4+1lgoo9SDGGygsIsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKA8YClY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKA8YClY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481201F000E9;
	Tue, 11 Aug 2026 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786461164;
	bh=KjnbmQ0CjfvfCvabbRwgNKDlNYfwps6m9E+P6DWnXxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jKA8YClY4dU0SZbFCX+nX9ALHXaAF20S0uGoTYSxg5w75bE1NwCY62evaVYkNAPu/
	 Bd/q7K9i9DO+b0WWHVcv/gLPWt+Tt0ILRby87yQpaUOfNyGln0BebF1/izQX7MtON0
	 XrrKtaeU865KbkDPKqNQuCdLPhT7VFJ0Xm3pAS4zysFw/rBr5jENWy/V43y7bD4vdy
	 0C+G7U8jTrD3DrnXUJ3Xtgxj8IrQMetLRD+eE0GPzTAiHiFrQPf3PUYhpM0g+XSmDy
	 vVP0rMGdX3CFM0/nCEhd5Kp9uWFI7VQuWrZ3aVqE5DsrnXuLz+3b5hBxB66NfXMFsH
	 358dILGA9WzYQ==
Message-ID: <0b3ce586-a090-4741-b269-488106d33e3a@kernel.org>
Date: Tue, 11 Aug 2026 17:12:36 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
To: David Woodhouse <dwmw2@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Simona Vetter <simona.vetter@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 10:58, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This effectively reverts commit ba170f76b69d ("mm, notifier: Catch
> sleeping/blocking for !blockable") for the mmu_notifier call sites.
> 
> The non_block_start/end() annotation causes the scheduler to complain
> about *any* voluntary sleep in a non-blockable notifier. But that was
> never the actual constraint. As Michal Hocko put it when the
> annotation was first proposed (quoted in commit 312364f3534c
> ("kernel.h: Add non_block_start/end()")), the OOM reaper "shouldn't
> depend on any locks or sleepable conditionals" and checking for
> sleepable context was "the best thing we could come up with that would
> describe these demands at least partially". The real requirement is that the reaper
> must not block on anything which may itself depend on memory
> allocation (or on the dying mm) to make progress — which is why
> spinning locks were always considered fine.

I think it's conceptually more than that: "we mostly do care about it to make a
forward progress". So yes, memory allocations are the obvious problem, but we
also wouldn't want to wait on any lock that will be hard/impossible to get while
reaping.

Just take a look at what some mmu_notifier_range_blockable() users end up doing:
they skip taking locks.

[...]

> 
> diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> index 245b74f39f91..cd5d15cd646a 100644
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -520,11 +520,7 @@ static int mn_hlist_invalidate_range_start(
>  		if (ops->invalidate_range_start) {
>  			int _ret;
>  
> -			if (!mmu_notifier_range_blockable(range))
> -				non_block_start();
>  			_ret = ops->invalidate_range_start(subscription, range);
> -			if (!mmu_notifier_range_blockable(range))
> -				non_block_end();
>  			if (_ret) {
>  				pr_info("%pS callback failed with %d in %sblockable context.\n",
>  					ops->invalidate_range_start, _ret,
> @@ -591,14 +587,9 @@ mn_hlist_invalidate_end(struct mmu_notifier_subscriptions *subscriptions,
>  	id = srcu_read_lock(&srcu);
>  	hlist_for_each_entry_srcu(subscription, &subscriptions->list, hlist,
>  				 srcu_read_lock_held(&srcu)) {
> -		if (subscription->ops->invalidate_range_end) {
> -			if (!mmu_notifier_range_blockable(range))
> -				non_block_start();
> +		if (subscription->ops->invalidate_range_end)
>  			subscription->ops->invalidate_range_end(subscription,
>  								range);
> -			if (!mmu_notifier_range_blockable(range))
> -				non_block_end();
> -		}
>  	}
>  	srcu_read_unlock(&srcu, id);
>  }

It's a bit odd. We have infrastructure to disallow blocking, and do so on
multiple paths (just check for mmu_notifier_range_blockable() users where we
skip taking mutexes, not performing memory allocations!), but now essentially
allow blocking on some paths.

That's just inconsistent. If we want different semantics, I think the whole
thing should be re-thought: if blocking is suddenly allowed.

-- 
Cheers,

David

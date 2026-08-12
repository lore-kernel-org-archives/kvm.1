Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1AF2C027C;
	Wed, 12 Aug 2026 21:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570720; cv=none; b=Hq9VJKYOWMnyL5drLqHfrLOlpFnjI1XqiC0RK4yIyEn0kBSmCbodYyqXR8VGOGy9KRtu9MrBrH+QsCJiUSXLOrT1tM58SIw+wm/wpoZF+K8ETY7izu0+hYdhxPP/wgc0mi7eumsZKYZ7upjEe7LdzyHuvzUWjOAylEFNrvO1aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570720; c=relaxed/simple;
	bh=stKds13iSSP2ngSa0pzJ8Vud6Mih+cAVmVydvNFaIPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqtAgdb/JR4cMMOCokupmPyfBPUwbxupYLkF1imF3BKhsjMyBmAFyyGvEee3PJT2Ogt9QcaxW7hlskr3+LPJoem+XYAUQ0itBYgn0MBO+wyAXtZIEVTl3cyS77V7Y3ZD8Q7KdV+5wvNJxPmu6RGz8RwXvvzYalK6bk7aN7w7GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mipp/Tam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mipp/Tam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0081F000E9;
	Wed, 12 Aug 2026 21:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786570718;
	bh=Cp8VKR+mPn5OPJBFC9VfSl1Nu9BWx9Sa1qFuiOfB2n8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Mipp/TamjMFifPGmGfcl3Aa7QIIOnIoUyxP5D2zaiECAy4CT+kswN3I69AAIXMqj1
	 TIfrfHGeiC3EyvRqGYWBT6/CZW6A2ZFdyWIZyFrs2+4a882RT1BgAu6RV4wGrZuCQ0
	 Uf5bIPpg66u1BEdyUQ62PQGF0lttJQWukYKr7OChDw8pMrAz8qXzu7zt2YT1gUTLFz
	 5EPpBLTRA46qUC3Vk5MIMkwQaDOlvKgL59FWWAhne9iGmRq79LhrYcyfGwuQlkr7V0
	 z5fb08Jf9qTh9XGB3p00AiEd+p1M+Z241W6YMJaDiNYb39skY3A+A5kRlfr9OTPQEy
	 O0FoyCy9nblUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 519DECE0EBE; Wed, 12 Aug 2026 14:38:38 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:38:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <b736237c-64ee-4eb2-8201-5685a3853844@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org>
 <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
 <d0692500893f303906fba1d7d596eb59a07a806a.camel@infradead.org>
 <anydY25Cl78l1HfU@google.com>
 <932DB129-1794-4855-A61E-F4C2B54B1EE6@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932DB129-1794-4855-A61E-F4C2B54B1EE6@infradead.org>

On Wed, Aug 12, 2026 at 06:17:50PM +0100, David Woodhouse wrote:
> On 12 August 2026 17:20:51 BST, Sean Christopherson <seanjc@google.com> wrote:
> >On Wed, Aug 12, 2026, David Woodhouse wrote:
> >> On Wed, 2026-08-12 at 16:03 +0100, David Woodhouse wrote:
> >> > On Wed, 2026-08-12 at 15:34 +0100, David Woodhouse wrote:
> >> > > On Wed, 2026-08-12 at 15:05 +0100, David Woodhouse wrote:
> >> > > > I'll rephrase that for my own understanding:
> >> > > > 
> >> > > > *If* we go all the way to building a whole SRCU flavour for this *and*
> >> > > > implementing a spin-only variant of srcu_synchronize() which is
> >> > > > tailored to the atomic-reader use case, *then* we don't need to remove
> >> > > > the non_block_{start,end} guards around the MMU notifiers, which are
> >> > > > basically never being called anyway and don't actually seem to protect
> >> > > > against any real bugs.
> >> > > > 
> >> > > > Yes?
> >> > > 
> >> > > FWIW it looks something like this. I'll throw it into my torture and
> >> > > latency tests, and we can see what Paul thinks of it. I'm still utterly
> >> > > unconvinced it's needed, but I concede it has its good points.
> >> > 
> >> > This slightly refactored version is the one that's actually going into
> >> > my torture tests...
> >> 
> >> Well, it survived first contact, and it's doing the soak testing now.
> >> 
> >> The average is basically no better than the try_synchronize_srcu()
> >> case, unsurprisingly — as *both* of them just observe that there are no
> >> readers and proceed immediately, in at least 99% of cases.
> >> 
> >> Like the existing rwlock case, it still manages double-digit p100
> >> latency even when though *doesn't* actually sleep.
> >> 
> >> I don't *hate* it, but I do question the benefit of it over try-first.
> >
> >FWIW, the max latency and >8ms numbers are very appealing to me, as my concerns
> >with using SRCU are all about the tail latencies.
> >
> >But I'm obviously not the one who'd be saddled with maintaining the code, so I'm
> >more than a little biased towards choosing the more complex version.
> 
> Ack. Well, it isn't even *that* bad in terms of complexity. It's mostly just a while loop around the core of the try_synchronize_srcu() I posted before, and some syntactic sugar and safeguards.
> 
> Let's see what Paul thinks.

A single call to try_synchronize_srcu() that, upon failure, invokes
synchronize_srcu_expedited() would work fine.  And a limited loop on
try_synchronize_srcu() that invokes synchronize_srcu_expedited() upon
repeated failure return would also work fine.

But if you had a large system, an unlimited loop on try_synchronize_srcu()
could wait forever on a system that was large enough that there was at
least one reader at all times.  To guarantee loop termination, it is
necessary to flip the index.  That way, new readers would use the index
that was already seen to be clear, and old readers would eventually
drain from the old index.

So is your use case adddressed by the single call to
try_synchronize_srcu() that, upon failure, invokes
synchronize_srcu_expedited()?  If so, we have a solution!

If not, please let me know, and I will put together that does the job.

							Thanx, Paul

> >> Again, I'll defer to Paul, but personally I'd want to see a more
> >> compelling use case for it.
> >> 
> >>   ┌───────────────┬─────────────────────┬───────────────────┬─────────────────────┐
> >>   │               │      expedited      │     try-first     │       atomic        │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ median drain  │ 32-128µs            │ 4-16µs            │ 4-16µs              │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ avg           │ 118µs               │ 13.8µs            │ 12.3µs              │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ >1ms          │ ~950ppm             │ ~990ppm           │ 838ppm              │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ >8ms          │ 42ppm               │ 4.4ppm            │ 0.10ppm             │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ max           │ 33.6ms              │ 17.6ms            │ 10.25ms             │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ fallback rate │ —                   │ 1.2%              │ 0%                  │
> >>   ├───────────────┼─────────────────────┼───────────────────┼─────────────────────┤
> >>   │ sample        │ 32.6M drains, 10min │ 41M drains, 10min │ 40.5M drains, 10min │
> >>   └───────────────┴─────────────────────┴───────────────────┴─────────────────────┘
> 

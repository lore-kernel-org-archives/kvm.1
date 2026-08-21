Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0360358389;
	Fri, 21 Aug 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333894; cv=none; b=lwwkSbEOFhTm+5DAaOJVuTm5gxkHK42ZdPPjOI5p0f+POVKHw2okYmxMZKcoJo1k5mFJa7PJAYydkayisVbMBQQXyKl3SZl6lmDmkWX82vIAl732Jm6g1Z+/xR8pYER9Suvu3hTpfsFF+854lT3jqpsP4H8m8/LYFlFVJ0odzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333894; c=relaxed/simple;
	bh=gtLFRmGix5BlLe7iyaTulkKgNY/5kdFtH+HZ3RaDEnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdvh5/Mp6cTOzSK6OCSznMo/qTlnl+HEySe1VjX0iH3nakE0oNzSbr/U+rKoPAI/rkvUz9SB6GNu7QKnUcZq7x5E4hf9DG1FQ30B8+YHODUsh+aQt+aLq6ab12gmuH+V5QyZSrDoWZ6II7UKkUyiUaUlbJCHhJ7+qQ12iHqahBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NClu/56f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NClu/56f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405CE1F00A3A;
	Fri, 21 Aug 2026 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787333892;
	bh=Fq1qopQjiGOPEPv7nYP2HWEyvKAIWD9DM17U/AxQx8w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=NClu/56frA0h3WA5bKxCjZdnf3aTWlzEWF3yD1soGE14ElWcChnEkVdNaLT3GRkDc
	 PKlC14Ixf6CvQBeTKsRKC8dvh+oB8yf6lh/YFOndr634PGp/TnTP10ixW1k6PV/o4h
	 JzXK/SByraA7LRcN+OluR519sEvtOYF6iegKoBiK7+vpUIumPAcUvoQ3+qsYqv2A6n
	 kDmYjPr/M5hz1H8WOy9rptUsmPN5KiUEAWxbkwHCOsNrxNsM1Qc7wTAnQvh72aV7f1
	 FngUTTtnoqTRUhPYNMQj4EtKGhqmtjHUtkjD1PzS5Xyu/Z49X41gXFFwEFE7XdFP6M
	 KzPvSdagV4CIg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ECABCCE0978; Fri, 21 Aug 2026 10:38:06 -0700 (PDT)
Date: Fri, 21 Aug 2026 10:38:06 -0700
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
Message-ID: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org>
 <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
 <d0692500893f303906fba1d7d596eb59a07a806a.camel@infradead.org>
 <anydY25Cl78l1HfU@google.com>
 <932DB129-1794-4855-A61E-F4C2B54B1EE6@infradead.org>
 <b736237c-64ee-4eb2-8201-5685a3853844@paulmck-laptop>
 <5f6a0669f319951462c2aae3a50d595983a42e4c.camel@infradead.org>
 <49df45c6-4d0e-483a-8acc-0ace7f9a6484@paulmck-laptop>
 <a17c8d33102c49c74a64fb62d402b315ba950577.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a17c8d33102c49c74a64fb62d402b315ba950577.camel@infradead.org>

On Thu, Aug 20, 2026 at 03:43:01PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-18 at 11:18 -0700, Paul E. McKenney wrote:
> > On Thu, Aug 13, 2026 at 08:54:44AM +0100, David Woodhouse wrote:
> > > On Wed, 2026-08-12 at 14:38 -0700, Paul E. McKenney wrote:
> > > > If not, please let me know, and I will put together that does the
> > > > job.
> > > 
> > > If you're working on that, I assume it'd need the readers to be known-
> > > atomic. So if any of the read-side SRCU_READ_FLAVOR_ATOMIC thing I
> > > already threw together is useful, you can find it in my tree at
> > > https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/srcu-atomic
> > 
> > Thank you, happy to steal pieces of that with attribution.  ;-)
> > 
> > My current plan says that if you have an atomic SRCU on which you
> > use srcu_read_lock_atomic() and srcu_read_unlock_atomic(), you only
> > ever get to use synchronize_srcu_atomic(), never synchronize_srcu(),
> > synchronize_srcu_expedited(), or call_srcu().  Does that work for you?
> 
> I just said this elsewhere in the thread¹ but I don't necessarily
> expect you to be following that. So to bring it back here...
> 
> My mental model for srcu_read_lock_atomic() was that it was always
> atomic, even on RT — it was basically equivalent to a raw spinlock.
> 
> In fact I think it would be OK for it to be equivalent to a *plain*
> spinlock — i.e. atomic on non-RT, but might sleep on RT.
> 
> When I wrote that previous email I was thinking that might end up being
> additional complexity in your implementation, but as I type this I
> guess it could be as simple as falling back to the normal non-atomic
> case for RT?
> 
> ¹ https://lore.kernel.org/all/448c5c0128b08ab98d175ae1099ff4d4874e49b3.camel@infradead.org/

The current state is that if you invoke synchronize_srcu_atomic()
from a given context, then srcu_read_lock_atomic() must be invoked
from that same context, or a more strict one.

So, for example, you can disable preemption across your invocation of
synchronize_srcu_atomic(), but only if you also do so across the entire
reader, starting before srcu_read_lock_atomic() and ending after the
matching srcu_read_unlock_atomic().  Or you could instead disable
interrupts across the entire SRCU reader.

Does that work?

Also, Tiny SRCU atomic turned out to be a bit more complicated than
we were thinking due to lazy preemption.  ;-)

If you want a sneak preview, please feel free to take a look at
the first few commits on the "dev" branch of my -rcu tree.

							Thanx, Paul

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5564738F654;
	Tue, 25 Aug 2026 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676431; cv=none; b=thKts/f1439RAU8shBYiD9YJn6Occeu0A4Dig7mu13Ii6KlZyiSEM2d8tkUyqKEFTlCXWpjKKQ2CUAVuLFMvxjWCTC8j9KwNEljeuuqL+jy1C5VTI8fEsFjaEUAtmiHRaO0FrKzbtjt7iw61UKFdPNiYGn9iOSMKC9z2TeFuJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676431; c=relaxed/simple;
	bh=p0/p7lGET1X6QVDDQQaipShhjACLX6o3wQfqufZ9WZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrP/F7AVST/RRzjAiWkE6uu53XqTWeSvUz6oLup9gRg0F1ZjHLdAveXr+2HRciDZjrpKrS2/heCh/C/HnQWYPpH8YurPgld7clPS79rrqiSttYlV/ywmcp3jCKMZ9TIZ7aWjLFTz18/r0Z9nzOcZNO4u//iXusYmp8RO32ZnVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsslkUCa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsslkUCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A26F1F00A3A;
	Tue, 25 Aug 2026 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787676430;
	bh=LKynmMcCNdHBz7/vpvw9+vH0+hvMd9pKSWrGj0p1+Tk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=MsslkUCawPPJeN74Hlb3+xGB//zBOdRkL34fZCyp8WAyspCTnqr8s5JXlxE4O1Dc4
	 xdr13esqX/XWBl2PbLDnjcrPc16zMfHB9nr4mcW+qZEUdgn6QAKIhY1W8vzs/8tDRI
	 7OZHpX+a9jaUWuzBGWNuCKHWKOSKYux6LDJRg1ykrp1Zd679/nGJZaPKtHFRY+/Gsr
	 J68K2it4JEgroslYTDz9ltduO3r75rfFAGyzAkigr5s1OB+X0y2mDao8ut3MbagpYf
	 CfTe6UKsFfSdrk+BWLjZlEsCDQFbr746spauWJqsqfwqE9EeFuvBiOzMb/lLMbpdb+
	 /pprk0cdbSTqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D37C9CE098D; Tue, 25 Aug 2026 09:47:09 -0700 (PDT)
Date: Tue, 25 Aug 2026 09:47:09 -0700
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
	Jerome Glisse <jglisse@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>

On Tue, Aug 25, 2026 at 01:15:42PM +0100, David Woodhouse wrote:
> On Fri, 2026-08-21 at 10:38 -0700, Paul E. McKenney wrote:
> > The current state is that if you invoke synchronize_srcu_atomic()
> > from a given context, then srcu_read_lock_atomic() must be invoked
> > from that same context, or a more strict one.
> >
> > So, for example, you can disable preemption across your invocation of
> > synchronize_srcu_atomic(), but only if you also do so across the entire
> > reader, starting before srcu_read_lock_atomic() and ending after the
> > matching srcu_read_unlock_atomic().  Or you could instead disable
> > interrupts across the entire SRCU reader.
> >
> > Does that work?
> 
> Yes, I think that should work; thanks. I don't think we *need* to
> disable interrupts or even preemption for the KVM case, but I played
> with it a bit to look at the tail latencies that Sean was concerned
> about.
> 
> I converted the GPC series to use srcu_read_lock_atomic() and
> synchronize_srcu_atomic()¹ and redid the same invalidation flood
> testing: 8× shinfo + 4× vcpu_info reproducers on 128-way Ice Lake.
> 
> On its own it isn't much of a win for this use case AFAICT, but it does
> work nicely when combined with the try_synchronize_srcu() thing that I
> posted before².
> 
> I compared three variants: synchronize_srcu_atomic() as in your dev
> branch; the same with try_synchronize_srcu() as an inline fast path
> in front of the GP spin loop; and my previous try_synchronize_srcu()
> + synchronize_srcu_expedited() fallback for comparison. With
> PREEMPT_DYNAMIC, and without all the KASAN and lockdep debugging I had
> added for correctness checking:
> 
>                     avg     max
>   atomic spin       8.0µs   6.0ms
>   try + atomic      3.6µs   326µs
>   try + expedited   3.7µs   4.4ms
> 
> The try fast path more than halves the average — it skips
> srcu_gp_start() and the flip-driven advance loop entirely for the
> no-readers case, which is >99% of them here. It also seems to fix
> a problem where synchronize_srcu_atomic() calls spend their time
> queued behind *each other* — atomic alone has no sub-4µs drains at
> all, and 40% of its drains take 8-16µs, presumably contending for
> the driver role and waiting out each other's flip cycles. With the
> try in front, only the genuinely-contended calls enter the GP spin
> loop at all.
> 
> I was initially dubious about that 326µs max — the slow path is still
> just spinning like the atomic variant, just with two orders of
> magnitude fewer entries into it, so perhaps it just didn't hit the same
> p100 in my test runs. So I redid it with the try-failed slow path
> instrumented separately, and it does seem to be real. Of ~5M drains,
> 3474 took the real GP slow path: avg 13.7µs, max 326µs, none over a
> millisecond — and the *fast* path's max was 282µs, so the worst case is
> something like interrupt noise, not the actual grace period. For
> comparison, the expedited fallback was consistently producing drains
> over 1ms (sleeping and waiting for the workqueue under a saturated
> machine). There were about 100 such >1ms waits in each 300-second test
> window (of about 60k fallbacks).
> 
> So the tail win over try+expedited is real, if we care about hundreds
> of µs vs single-digit ms. Which I think we do — that's what brings the
> p100 to parity with the existing rwlock code (~330µs on the same test)
> while also scaling better on the readers and resolving the whole
> PREEMPT_RT issue.
> 
> One thing I didn't expect: the try falls through to the slow path about
> 10× less often in front of the atomic variant (0.07% of drains vs 0.5-
> 0.7% falling back to synchronize_srcu_expedited()). I suspected the
> preempt-enabled readers in the latter, but rerunning that test with the
> readers non-preemptible made no difference at all. So it's an effect of
> the wait side itself somehow. It looks like the sleeping variant lets
> the abusive invalidate/refresh cycle churn about twice as fast (11M
> drains per window vs 5M), so the try observes readers in flight more
> often? I'm not sure that higher throughput of the abusive test is the
> metric we're here to measure though.
> 
> Could we put try_synchronize_srcu() at the front of
> synchronize_srcu_atomic()? Without it, the atomic version is slower
> than what I had before, across the board.
> 
> However...
> 
> Testing with my KASAN+lockdep kernels showed the p100 latency going up
> to 200ms for the atomic version, while with try+expedited it was only
> about 25ms (the same order of magnitude as the existing rwlock-based
> implementation in the debug setup):
> 
>                     avg      max
>   atomic spin       10.2µs   172-212ms
>   try + atomic      10.2µs   173ms
>   try + expedited   14.7µs   25ms
> 
> Pinning the grace period driver with preempt_disable() didn't make a
> difference. A sched_switch-instrumented run showed the >1ms tail is
> bimodal: half the samples ~100% off-CPU (the *waiter* descheduled after
> the wait was already over), and half genuinely on-CPU spinning and
> waiting for readers.
> 
> So on a debug kernel under CPU saturation a spinning waiter has a much
> worse worst case than a sleeping one; on a production-like kernel the
> try+spin mode does seem to give a big win in the tail latencies that
> Sean was concerned about. I think that's OK.
> 
> ¹ https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-atomic-dev
> ² https://lore.kernel.org/all/05e5a29a95793651062dc5d165661b4d590f08ab.camel@infradead.org/

Nice!

Things are getting more stable, still a few corner cases that I am
chasing, mostly in rcutorture testing.  (No, I did not design rcutorture
to deal with atomic grace periods, and no, it did not take this sitting
down!)

The no-readers fastpath is in place for Tiny Atomic SRCU (though with
a bug that I am just now fixing), and it should not be hard to set up
for Tree Atomic SRCU.

On the tail latencies...

The easiest way to reduce them is to require that preemption be disabled
across srcu_read_lock_atomic()/srcu_read_unlock_atomic() regions and
across all calls to synchronize_srcu_atomic().  Without that, the problem
is that the scheduler does not know that the spinning is pointless,
and we cannot use the blocking primitives that we could otherwise use
to tell it what is going on.

So, is it feasible to simply require preemption be disabled as called
out above?

PREEMPT_RT might need something different?

							Thanx, Paul

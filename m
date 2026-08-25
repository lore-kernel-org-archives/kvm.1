Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197332A3FF;
	Tue, 25 Aug 2026 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787681816; cv=none; b=cd5NC1laZkSU5VW9uP9ZeCulJ5J2gqN73XhW6z1KIfZdX43e/W5uLV4Czpx1cceHY9Jv7QIVXwuij7rfQvNJEmjD04YbHnhJPpuZqhTWWcC6jnmjz7X1mjyN34jvDEX1zkvrWuHIYxl3Rd/rFvfjes3FZm+AQ45EG7wDpx1NX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787681816; c=relaxed/simple;
	bh=lk6+aq4TtkVL3w8PtFHde39en3+x6Qlr4508mgjkczI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9QQLtvirqGAav/ypk/Sd2iTgV2FfTbYdP6xhZCjB8JJXJ86+/YginV4h5X3pK/AYzsMUug9R3Y+S/fZZ/mvVEbMUZvWNMHXcHWsffNzD3RlYgQyATJvvKH4Lx0SL3BVYR6A4qa0YVj2mqEFRH8etTJjuxidyKt3VOOd6aAvUNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAf83z3g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAf83z3g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC4B1F00A3D;
	Tue, 25 Aug 2026 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787681814;
	bh=DzVEjVkRW6HxHuHwKFpTtnTA+OQV/p8rhJpcnutWj+A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=IAf83z3giM+IdSU1Wx7HPfLxMgJ1LuLBEYyP1tz0NRK0xkqPtMZfhzBeIJbewdCr4
	 EvaB18dUYG6KIagSmlgJkM5HsyvuZUWiBi0kiLXp4XcB3WYQv+io6Amn5wlp9wm44U
	 40VlLgFO0y0TTuvhlPZsjX9Wyv+1BP5i+5+D28x+BNrMT7Ey+SD6c81cvID0Nmwp52
	 ZHeU9vcQ81wMIc3M7aPp+OVOdB/O3tI64i4Mu8xXgG/Iadtcb/X/v/C0d9hGGduQDn
	 X2MqaclqUquFCmBk9Sz/TNudKA0RJcO8ARwIEl1Rd6wHltYQAC5JO/X992KSgdWPnp
	 NKPcnzRi46p5w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 98437CE098D; Tue, 25 Aug 2026 11:16:54 -0700 (PDT)
Date: Tue, 25 Aug 2026 11:16:54 -0700
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
Message-ID: <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>

On Tue, Aug 25, 2026 at 06:48:08PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-25 at 10:19 -0700, Paul E. McKenney wrote:
> > On Tue, Aug 25, 2026 at 06:05:54PM +0100, David Woodhouse wrote:
> > > On Tue, 2026-08-25 at 09:47 -0700, Paul E. McKenney wrote:
> > > > 
> > > > On the tail latencies...
> > > > 
> > > > The easiest way to reduce them is to require that preemption be disabled
> > > > across srcu_read_lock_atomic()/srcu_read_unlock_atomic() regions and
> > > > across all calls to synchronize_srcu_atomic().  Without that, the problem
> > > > is that the scheduler does not know that the spinning is pointless,
> > > > and we cannot use the blocking primitives that we could otherwise use
> > > > to tell it what is going on.
> > > > 
> > > > So, is it feasible to simply require preemption be disabled as called
> > > > out above?
> > > 
> > > I'd experimented with disabling it around the GP driver loop in
> > > synchronize_srcu_atomic() as seen in
> > > https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=07165e79340e
> > > and that didn't seem to change anything (which seems reasonable, as
> > > it's the *waiters* that were descheduled, not the threads driving the
> > > actual GP). So your suggestion that we do it around the whole function
> > > certainly makes sense too. I'll test it.
> > > 
> > > I do wonder if we're really doing the right thing here by selfishly
> > > blocking preemption because we want a specific tail latency to remain
> > > low in a contended system. Maybe we should allow preemption and trust
> > > that the right thing will happen? Maybe the p100 isn't the right
> > > benchmark to be chasing... I'm looking at it because Sean expressed
> > > concerns about it, but it's not the only consideration.
> > 
> > My concern is algorithmic, not benchmark optimization.
> > 
> > Suppose that there is only one CPU, or, alternatively, that one of the
> > atomic SRCU readers is pinned to the same CPU occupied by the (higher
> > priority) task running synchronize_srcu_atomic().  In this case, the
> > call to synchronize_srcu_atomic() uselessly burns CPU time until its
> > priority decays, real-time throttling kicks in, or in some configurations,
> > maybe never.
> 
> I certainly have no problem with a blanket preempt_disable() around
> both sides for algorithmic reasons. As long as we aren't *just* doing
> it for the selfish reasons I described. 

Suppose I simply disable preemption in srcu_read_lock_atomic(),
enable it in srcu_read_unlock_atomic(), and disable it internally to
synchronize_srcu_atomic()?  It might be against all RCU tradition,
but might also be easier to use.  ;-)

> > Requiring preemption be disabled across both the atomic SRCU readers
> > and the synchronize_srcu_atomic() avoids this, at least when running on
> > bare metal.  My (perhaps naive) hope is that guest OSes get some use
> > out of those cpu_relax() calls.
> 
> Yeah, an overcommited guest vCPU should be able to get preempted there
> by the hypervisor, allowing other vCPUs to run.

Whew!!!  ;-)

							Thanx, Paul

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D3E489866;
	Tue, 25 Aug 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787678365; cv=none; b=hoYqRPEFcs9wVvLgVV3wrYnaV4Z0D9uNL3YxB2vDHNaijjb3E4EKIVU4oloXHsLZgtR3L40PgX/meWJRCjeLPX7ELzqi2aCwbpzfuZtbs4jJPpGFp8/HUuzPr8tFAEtVt9EFaZOfgOrK5k8fjTCWSFk9QjwgQzb47aD5aouijsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787678365; c=relaxed/simple;
	bh=5vrD4M6AMawsvEs8a5Bwv6z28IbfdRdBl4tHzE0m5W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H665YXnHRi+stk/J14VQrD0V+b9qW10MMEdFiuvah7Dy2iTN2yAHtwD2pev3EqkJ3ryv0sGpgVB22GbLkV3ZgyIS2+CKsEGeFG18RB5xOKS30IdH2/PQTlnF5fIo7r8ZhVvsAANfpwXuUAvi8/JLx0cWXo+DX3BqpjHfAuE0BvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDDYGtp0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDDYGtp0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6380E1F000E9;
	Tue, 25 Aug 2026 17:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787678364;
	bh=N+z+EWfwawr13AA/05vPGZDapLHVer9oJUDN4V4rsvc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=YDDYGtp07+d2njAvClMBj9eUXdhAJfOASpMOQdvz2AI7peJccpWljTKoDa+NMAnlf
	 ugIt4e4STr6xZMh9SV+b1bqcGzUZV1X3kT2lg/rFRnPTyRkW2gMViFeu7HPVeN3SVT
	 s5YpOpQBJQTDRSIF2J6R4a1bGI7QdKpz4K8S9+HwLD4SJ31y1vQAk8u4QHrA3uYZl/
	 Hd8HtWbZSiCK6Cl/qpnmaZ5Ls3z8oGCeC7x2cWsTLUurqrHXH4b4JxMq6d725X0miu
	 ooekQNlwnEVBBGhMnHhtegiomTApUtyyiaKRXLHCXLTSqMbcmPpiL3aIaLnxZWBiU4
	 VeXhxQusnn0nQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 272C5CE098D; Tue, 25 Aug 2026 10:19:24 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:19:24 -0700
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
Message-ID: <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>

On Tue, Aug 25, 2026 at 06:05:54PM +0100, David Woodhouse wrote:
> On Tue, 2026-08-25 at 09:47 -0700, Paul E. McKenney wrote:
> > 
> > On the tail latencies...
> > 
> > The easiest way to reduce them is to require that preemption be disabled
> > across srcu_read_lock_atomic()/srcu_read_unlock_atomic() regions and
> > across all calls to synchronize_srcu_atomic().  Without that, the problem
> > is that the scheduler does not know that the spinning is pointless,
> > and we cannot use the blocking primitives that we could otherwise use
> > to tell it what is going on.
> > 
> > So, is it feasible to simply require preemption be disabled as called
> > out above?
> 
> I'd experimented with disabling it around the GP driver loop in
> synchronize_srcu_atomic() as seen in
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=commitdiff;h=07165e79340e
> and that didn't seem to change anything (which seems reasonable, as
> it's the *waiters* that were descheduled, not the threads driving the
> actual GP). So your suggestion that we do it around the whole function
> certainly makes sense too. I'll test it.
> 
> I do wonder if we're really doing the right thing here by selfishly
> blocking preemption because we want a specific tail latency to remain
> low in a contended system. Maybe we should allow preemption and trust
> that the right thing will happen? Maybe the p100 isn't the right
> benchmark to be chasing... I'm looking at it because Sean expressed
> concerns about it, but it's not the only consideration.

My concern is algorithmic, not benchmark optimization.

Suppose that there is only one CPU, or, alternatively, that one of the
atomic SRCU readers is pinned to the same CPU occupied by the (higher
priority) task running synchronize_srcu_atomic().  In this case, the
call to synchronize_srcu_atomic() uselessly burns CPU time until its
priority decays, real-time throttling kicks in, or in some configurations,
maybe never.

Requiring preemption be disabled across both the atomic SRCU readers
and the synchronize_srcu_atomic() avoids this, at least when running on
bare metal.  My (perhaps naive) hope is that guest OSes get some use
out of those cpu_relax() calls.

> I'll have another look, but right now I'm in the middle of rebasing
> onto kvm/next and the whole nested story has fallen apart and I don't
> know (yet) what broke... :)

No hurry.  I am allowing preemption (but dangerously as noted above)
for the moment, and can easily add lockdep checks if and when.

Plus I need to turn my rcutorture changes from shameless hacks into
something maintainable.  And find and fix the inevitable remaining bugs.

							Thanx, Paul

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7657337F327;
	Tue,  1 Sep 2026 00:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224285; cv=none; b=Sn2350UTUGUsutIAvAgGVcr4Dvj9NTNeEgL8WlQPPB3vTAvisApO6TYu1EWxS2C3pztEaCTd25A1gLC8AgqH0h7pz4rZKI2Dy5FTkWpsmk/rDwM7elpN935fP69X7lmzJg1Bi78kUoqNHrNYsDlJ3mBIeymN3azDwv+B68RY2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224285; c=relaxed/simple;
	bh=ZRbDdv3ON6gVaFfFiplD76Nt/U8R1aLF2BKq42LxqEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSxLhi81AY4d0mrkqDIEOxliwt0mrF2IOaKOYLjZnDePtGAb76wRyndS2kANk+yirp51nxvbkGdCtOHyHV2p1W+/VU122lkaSh8XGjPw5/uN9djIxIaFoXm5gvAsQq9xwDSxviP8y487tlOBnfbFa+++5J2aSVyG3Fqg4beUQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIfHlfBz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIfHlfBz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21241F000E9;
	Tue,  1 Sep 2026 00:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788224282;
	bh=1bp63kcVJIGUXxJRr+a1pHibhDOvZDH0FPxWAxX9Bno=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KIfHlfBzoIkHss6og+1dX0nGSvHrR69wBOpNZ+4R53mnZPPoJtuPTbat9lz89zYxd
	 VoFyeKLFUG/RNEBTl/OEAaJvSVIF39P7eiAdlR3Gc5pFIStbqwCLg34Oz8CZtu+iIG
	 cBME9O+ibShHLNVKaml/GGE4J1zl94NnomECTSbPaDtoWVSCpT3Nmcym62QsfvXJMY
	 XO1shOHtkB0j/8Ksi1YXKq0MDkuikPzlMGo9Efhk6l8xMd9AQQKvPuIcW2vH2RGEJO
	 uZr8/sINuVWPqGWlsVcZb6WHqqiDbtIINzWQC9Tu1mEgbGTAwkVhpvY0/iLNuUJtAC
	 6FQqDmTaNWaJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8E91ECE0B65; Mon, 31 Aug 2026 17:58:02 -0700 (PDT)
Date: Mon, 31 Aug 2026 17:58:02 -0700
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
Message-ID: <90d91673-a912-439f-98ee-e43285294486@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <333c4cdb-8f34-4e3f-a47f-961f47e089a0@paulmck-laptop>
 <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>

On Fri, Aug 28, 2026 at 12:25:01AM +0100, David Woodhouse wrote:
> On Tue, 2026-08-25 at 11:16 -0700, Paul E. McKenney wrote:
> >  
> > > > Suppose that there is only one CPU, or, alternatively, that one of the
> > > > atomic SRCU readers is pinned to the same CPU occupied by the (higher
> > > > priority) task running synchronize_srcu_atomic().  In this case, the
> > > > call to synchronize_srcu_atomic() uselessly burns CPU time until its
> > > > priority decays, real-time throttling kicks in, or in some configurations,
> > > > maybe never.
> > > 
> > > I certainly have no problem with a blanket preempt_disable() around
> > > both sides for algorithmic reasons. As long as we aren't *just* doing
> > > it for the selfish reasons I described. 
> > 
> > Suppose I simply disable preemption in srcu_read_lock_atomic(),
> > enable it in srcu_read_unlock_atomic(), and disable it internally to
> > synchronize_srcu_atomic()?  It might be against all RCU tradition,
> > but might also be easier to use.  ;-)
> 
> Which indeed you have done in commit c2225b77b028 "srcu_tree: Disable
> preemption across synchronize_srcu_atomic()" so I've dropped that hack
> from my side. The important RCU patches remaining in my tree are the
> addition of try_synchronize_srcu() and then using it as the fast path
> of synchronize_srcu_atomic(). I've stopped bothering to test *without*
> those.

Understood, and that fastpath is on its way.

> Since it looks like I have successfully nerd-sniped you with the srcu-
> atomic concept, I've reworked my tree to convert directly to that
> rather than first converting to SRCU and then to atomic in a later
> incremental commit.

Now, now, that would be you *and* your friend Claude doing the
nerd-sniping.  ;-)

> This is what I'm now testing, in 
> https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-v3
> 
> It's working; the latency numbers have been looking good in all of my
> RT/DYNAMIC and debug/prod-like permutations. Redoing on the very latest
> now...

Very good!

>   * 1ccf7ba90f8b KVM: x86/mmu: Take mmu_lock for the lockless aging walk on PREEMPT_RT (gpc-v3)
>   * 51de7a793839 KVM: selftests: Add nested transition benchmark
>   * 37c9400feec3 KVM: nSVM: Cache L1's IO permissions map pages
>   * 1c10fdf9c46d KVM: nSVM: Cache L1's MSR permissions map pages
>   * 7af4264346c2 KVM: nSVM: Use a gfn_to_pfn_cache for the vmcb12 page
>   * de951cadb238 KVM: x86: Move nested GPC lock helpers to x86.h as kvm_gpc_lock_page()
>   * f04543987d9f KVM: selftests: Add nested VMX APIC cache invalidation test
>   * 1b50353089d4 KVM: nVMX: Use pinned pfncache for L1 APIC virtualization pages
>   * 4ae1202ef919 KVM: nVMX: Implement cache for L1 MSR bitmap
>   * 5102fb3c55fb KVM: x86: Post KVM_REQ_GET_NESTED_STATE_PAGES on memslot updates
>   * 47998916d89f KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
>   * 2dab55238cd7 KVM: pfncache: Add guest-mode pinning (GUEST_USES_PFN successor)
>   * 9740a75db3d5 KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status
>   * 3898f98ca5cd KVM: x86: Request the guest TLB flush from record_steal_time()
>   * 0a06af648fa6 KVM: x86/xen: Don't dirty track "vCPU info" page
>   * eef7b09e5b52 KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
>   * 99a7eae0266e KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
>   * f0162bb012fb KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
>   * 003716df6605 mm/mmu_notifier: Remove non_block_start/end() from notifier invocation
>   * 6d484ca99bc9 srcu: Try the inline no-readers proof first in synchronize_srcu_atomic()

This is in the works.

>   * 23f10e07aba3 srcu: Add try_synchronize_srcu() for callers which can prove readers absent

I do not intend to provide a separate API for this given the possibility
of indefinite postponement.

>   * 2a55908bb12d srcu: Keep a spare node array so srcu_gp_end() need not block in reclaim

This should not be necessary given that call_srcu(), synchronize_srcu(),
synchronize_srcu_expedited(), and start_poll_synchronize_srcu() are all
ruled out for atomic srcu_struct structures.  Thus, there will never be
a conversion to big, and thus no memory allocation.

Or am I missing something here?

							Thanx, Paul

>   * cb117542cb92 srcu: Remove development pr_alert()s from synchronize_srcu_atomic()
>   *   02738b15e08c Merge remote-tracking branch 'rcu/dev' into gpc-v3
>   |\
>   | * 7b9f3a948136 torture: Allow specifying alternative ssh command to kvm-remote.sh (rcu/dev)
>   | * cd71c7941b25 doc: RCU: Fix s/strategem/stratagem/ typo in Requirements.rst
>   | * f1b2e15ef249 rcu: fix shrink budget underflow in lazy_rcu_shrink_scan
>   | * 8c9be6c76148 rcutorture: Synchronously wait for all rcu_torture_irq() callbacks to complete
>   | * 48b4d9799efe rcu: Use IRQ_WORK_INIT_HARD for srcu's irq_work
>   | * 260d0fdf6ea3 rcutorture: Fix divide-by-zero with fwd_progress_div=1
>   | * 5d9c38fbf615 fixup! srcutiny: Add an atomic Tiny SRCU
>   | * 7a263580788e fixup! srcutree: Add an atomic Tree SRCU
>   | * c2225b77b028 srcu_tree: Disable preemption across synchronize_srcu_atomic()
>   | * e56c969b6c7b rcutorture: Add support for testing synchronize_srcu_atomic()
>   | * 9a2e9996ccec srcutiny: Add an atomic Tiny SRCU
>   | * 6cf65dd4d8fb srcutree: Add an atomic Tree SRCU
>   | ⋮  (older rcu/dev elided)
>   * | dc14992a9abe KVM: pfncache: use a dedicated invalidation sequence for cache refresh (xen-v3)
>   * | a83533b07c67 KVM: x86/xen: Mark poll_evtchn accesses with READ_ONCE()/WRITE_ONCE()
>   * | f578df3dda4e KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
>   * | 0e38de3983e6 KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents
>   * | f6179ff87266 KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
>   * | 9c3243ef9edb KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
>   * | 113a5ed7489f KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
>   * | 2505c393701c KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
>   * | 9dfe99cf7b45 KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()
>   * | 59325fcde6db KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
>   * | 2d366afb5114 KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
>   * | 2e26fc558ac9 KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
>   o |  (kvm/next: 76671054f9a1 Merge tag 'kvmarm-7.3' ...)



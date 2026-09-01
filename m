Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBF73E16A5;
	Tue,  1 Sep 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303933; cv=none; b=jpUox8hlfoNvFELqtda9afgzHREKdAxn2juoRcd6JH5PGcwLHZiTn7JMmEnb+aWVpusx/CFrKF4Gm8lnUNjRIlJYE1znNV2CdfX9nUWjvlXInYee4xhbeA2YoXtVaczQ6LyoPoM/E1RdmQgQ12ciPg+KcMpFGDbzd5oWoWdyPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303933; c=relaxed/simple;
	bh=HB8OXMI/qKkxfyXqsL/wC71Nav5Hz12TvZWbjZ/91j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+9aakIOvjTdvDGUatHZLNYtYmZ0VLgIhesVLoEPR+XT1rpcbnVeew76ZEzdWDffgqQPPXuibwNJkZFu7GPtkUybEPD3UOmI7A1GcX5YiWdwuGHJX7sPQuiZ3tQj1l/LLQQwjqjvJu23lWptCYqB0ANXLWZ0CtR/yiyLe1NgHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA59QNDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA59QNDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612EB1F000E9;
	Tue,  1 Sep 2026 23:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303931;
	bh=0htWeaKeIqw48Ih+M0qU/N2hCQgDCF5iuzUPSnGY/sQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=IA59QNDEFlOCImNWFQJPZbXiWFaq1xTWw9bnb5X7bxpsdSW/X/3c8p5mts3Azgq2Z
	 7lSsnOCFsOI961FM9HrSshMg4uDVR8LTudC00ThQ0Qxw+JDDWkdPun8xOEzEwOIzSA
	 GDjCtziFxJxsMY2H/R0LkW5yYqsO39ugtiXXsvTErPrCgGmG99stE720A6j7F5G6mp
	 6NozGNcA8AvzBb4uQAFzbSTZdymAO3Zq2xOrRgyVs6HoOJ/lXO7siUu8wZBGIK5Km+
	 9FYxC24GXaOySPLTlqpxuM+3GR+iSooMmgT10XvJb//kdQOuZ7qlCFYrh83pQ/c4N+
	 IHIPejGZ6H/+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 24F23CE09F8; Tue,  1 Sep 2026 16:05:31 -0700 (PDT)
Date: Tue, 1 Sep 2026 16:05:31 -0700
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
Message-ID: <20bc5559-a1b9-4ff3-badd-1166eca60b57@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>
 <90d91673-a912-439f-98ee-e43285294486@paulmck-laptop>
 <8cd4aa65b1b499d4c614aa4cba445b6aeb89acf7.camel@infradead.org>
 <apcjs83XSU4Eb9hm@google.com>
 <e3197a0a-e167-4ea1-bbde-9c7f11f42198@paulmck-laptop>
 <apdW2edsT_ZKfuUR@google.com>
 <19e2a25c50a551398dec060fe0e5d3720b027ad2.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19e2a25c50a551398dec060fe0e5d3720b027ad2.camel@infradead.org>

On Tue, Sep 01, 2026 at 11:53:26PM +0100, David Woodhouse wrote:
> On Tue, 2026-09-01 at 15:51 -0700, Sean Christopherson wrote:
> > On Tue, Sep 01, 2026, Paul E. McKenney wrote:
> > > On Tue, Sep 01, 2026 at 12:12:51PM -0700, Sean Christopherson wrote:
> > > > On Tue, Sep 01, 2026, David Woodhouse wrote:
> > > > > On Mon, 2026-08-31 at 17:58 -0700, Paul E. McKenney wrote:
> > > > > > On Fri, Aug 28, 2026 at 12:25:01AM +0100, David Woodhouse wrote:
> > > > > > 
> > > > > > 
> > > > > > >   * 23f10e07aba3 srcu: Add try_synchronize_srcu() for callers which can prove readers absent
> > > > > > 
> > > > > > I do not intend to provide a separate API for this given the possibility
> > > > > > of indefinite postponement.
> > > > > 
> > > > > Makes sense. In that case, calling it internally from the 'right'
> > > > > places becomes important, as the callers who care can't do so for
> > > > > themselves.
> > > > > 
> > > > > We discussed the fact that synchronize_srcu_expedited() will also want
> > > > > to use the same fast path.
> > > > > 
> > > > > I'm also looking back to Sean's call_srcu_expedited() patch from March:
> > > > > https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.com/
> > > > > 
> > > > > 
> > > > > > Due to differences in how VMMs manage guest devices, and in the
> > > > > > architecture being emulated by userspace, some updates trigger call_srcu()
> > > > > > with concurrent readers (i.e. while the VM is active), while others occur
> > > > > > without readers, e.g. when configuring devices during a pre-boot setup.
> > > > > > For the later case (no concurrent readers), using the vanilla call_srcu()
> > > > > > is problematic, as it can kick off a normal grace period (totally fine for
> > > > > > freeing the object) and effectively transfer the non-expedited grace period
> > > > > > to the upcoming synchronize_srcu_expedited().
> > > > > 
> > > > > So the offending path uses call_srcu() and triggers a normal GP, while
> > > > > the victim calls synchronize_srcu_expedited() and gets stuck behind
> > > > > that non-expedited GP.
> > > > > 
> > > > > Sean, if the victim is the "no concurrent readers" code path, as you
> > > > > said above, do you think the fast path in the victim should suffice,
> > > > > without the cost of an expedited GP for every bus registration?
> > > > 
> > > > IIUC, you're asking if being able to use try_synchronize_srcu() for the fast/happy
> > > > of synchronize_srcu_expedited() (i.e. for kvm_swap_active_memslots()()), even if
> > > > there's an in-flight GP, would suffice for a fix of the regression introduced by
> > > > commit 7d9a0273c459 ("KVM: Avoid synchronize_srcu() in kvm_io_bus_register_dev()").
> > > > 
> > > > If my understanding is correct, then yes, that should work, and presumably would
> > > > be a notable improvement overall.
> > > 
> > > Then we could abandon synchronize_rcu_atomic()?  That would not be a
> > > bad thing from my perspective.
> > > 
> > > Just to be sure, please note that synchronize_rcu_expedited() can and
> > > sometimes does sleep in order to avoid odd corner cases that could
> > > otherwise pointlessly monopolize a CPU.
> > 
> > I think one (or both) of us is confused.  I thought David was asking if we could
> > avoiding adding call_srcu_expedited(), because the proposed try_synchronize_srcu()
> > would fix a regression related to KVM's use of synchronize_srcu_expedited().
> 
> Indeed. This is a *separate* problem, for which you had previously
> proposed adding call_srcu_expedited(), but it looks like having
> try_synchronize_scru() as a fast path of synchronize_srcu_expedited()
> would suffice.
> 
> We do still need synchronize_srcu_atomic() for the MM notifier case for
> which we originally built it.
> 
> > I don't think that has anything to do with non-sleepable RCU?  Or is there a
> > separate discussion and/or implicitations I don't understand?
> 
> I think the lack of 's' there was just a typo. This is synchronize_srcu_atomic().

Right you are, and apologies for the confusion!

							Thanx, Paul

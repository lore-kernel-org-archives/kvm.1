Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A24252AB;
	Tue,  1 Sep 2026 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295257; cv=none; b=FjOAOWXeeULIpQmsCwtNT0swGr/ywbGg7oX3C7LOwD+fFeIv5rbv4ITM2lZuafTFpPhytuc9z43O7jv9zrF5YnEyWfDg4FVtetos7xKDlL1Hk0jCfPsb1GW7Ouuyku9w33HycSs3SFVC5pFk0pZUq6sOs7wzRyfukPCtTQYX/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295257; c=relaxed/simple;
	bh=2yF6QNaXTMDFCKZ7qT+HkNyGYYrPal6hKbANGvA3IUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mneIremRRdnV8TIXa7NMoZKCPtGsTdgwoX0coOwf2X9+aIk16LdGJfRlVEBA8ploSm/hPV+wbvxmuQxX9OdjcFkjtmOEoXTj3LC7Ym8eip3eEeU0lpz4onfMjZeyvjg/iWu5BWMhZXDlm+YUfHYJ0oZise98NIsQnwziL/Ut61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsffA4pM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsffA4pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DB81F000E9;
	Tue,  1 Sep 2026 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788295255;
	bh=lTqSBy/5+AkfT27Mcm6NsSAgir8oHYfp952cjXDCZTU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jsffA4pMJhRjvS+g0egMuEshBL2lvsMIMlk8cDQlWP8HCF8035Klp6vh3M2m2dJ1i
	 xmJZSXW3Zg91S5Jucfq9H4vQV1ciIvBB0gJKxWpx0SEVk4Wtkd0nNjFM5uF6joIhMy
	 Hzn5dVmEA/U9V3pQVbVwPoez7qyRjZUyWH6JMAI9sCCIq2hTR8V1x482isg6bT3Lnx
	 EF7NZQ4bY1yWu5q2IwQ742r2e/a0h3L+YOlnQJfZx8JVWeHRmNQnZqaSpFU75oR5Zy
	 KMaAfJAjYBtLHN7I2+D8HE0NZgwB3DDBbICLUPO6Zwsf+sgsumwXhxYObqk/QcEhvz
	 7BcKAAQvmXxcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4098ACE0ABD; Tue,  1 Sep 2026 13:40:55 -0700 (PDT)
Date: Tue, 1 Sep 2026 13:40:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <e3197a0a-e167-4ea1-bbde-9c7f11f42198@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <c39bda52f4c1573193aed39246f0d705755143fe.camel@infradead.org>
 <90d91673-a912-439f-98ee-e43285294486@paulmck-laptop>
 <8cd4aa65b1b499d4c614aa4cba445b6aeb89acf7.camel@infradead.org>
 <apcjs83XSU4Eb9hm@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apcjs83XSU4Eb9hm@google.com>

On Tue, Sep 01, 2026 at 12:12:51PM -0700, Sean Christopherson wrote:
> On Tue, Sep 01, 2026, David Woodhouse wrote:
> > On Mon, 2026-08-31 at 17:58 -0700, Paul E. McKenney wrote:
> > > On Fri, Aug 28, 2026 at 12:25:01AM +0100, David Woodhouse wrote:
> > > 
> > > 
> > > >   * 23f10e07aba3 srcu: Add try_synchronize_srcu() for callers which can prove readers absent
> > > 
> > > I do not intend to provide a separate API for this given the possibility
> > > of indefinite postponement.
> > 
> > Makes sense. In that case, calling it internally from the 'right'
> > places becomes important, as the callers who care can't do so for
> > themselves.
> > 
> > We discussed the fact that synchronize_srcu_expedited() will also want
> > to use the same fast path.
> > 
> > I'm also looking back to Sean's call_srcu_expedited() patch from March:
> > https://lore.kernel.org/all/20260309193059.2244645-1-seanjc@google.com/
> > 
> > 
> > | Due to differences in how VMMs manage guest devices, and in the
> > | architecture being emulated by userspace, some updates trigger call_srcu()
> > | with concurrent readers (i.e. while the VM is active), while others occur
> > | without readers, e.g. when configuring devices during a pre-boot setup.
> > | For the later case (no concurrent readers), using the vanilla call_srcu()
> > | is problematic, as it can kick off a normal grace period (totally fine for
> > | freeing the object) and effectively transfer the non-expedited grace period
> > | to the upcoming synchronize_srcu_expedited().
> > 
> > So the offending path uses call_srcu() and triggers a normal GP, while
> > the victim calls synchronize_srcu_expedited() and gets stuck behind
> > that non-expedited GP.
> > 
> > Sean, if the victim is the "no concurrent readers" code path, as you
> > said above, do you think the fast path in the victim should suffice,
> > without the cost of an expedited GP for every bus registration?
> 
> IIUC, you're asking if being able to use try_synchronize_srcu() for the fast/happy
> of synchronize_srcu_expedited() (i.e. for kvm_swap_active_memslots()()), even if
> there's an in-flight GP, would suffice for a fix of the regression introduced by
> commit 7d9a0273c459 ("KVM: Avoid synchronize_srcu() in kvm_io_bus_register_dev()").
> 
> If my understanding is correct, then yes, that should work, and presumably would
> be a notable improvement overall.

Then we could abandon synchronize_rcu_atomic()?  That would not be a
bad thing from my perspective.

Just to be sure, please note that synchronize_rcu_expedited() can and
sometimes does sleep in order to avoid odd corner cases that could
otherwise pointlessly monopolize a CPU.

							Thanx, Paul

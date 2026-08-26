Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAE184540;
	Wed, 26 Aug 2026 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787756708; cv=none; b=RRMbef8mXiJwU952SiltkX9EfBDOVEfFJYSAlTUAaoaybZ5yR9+ZXcwYDUx1PdGWt8PJMFgJBBLJYTSy0IMZne2M5fY9A+s0NH5j2jGMhwqGXM8oELpugAGDTu38RujUOm6+TMxciUlaJ+ffDAq+D72hhcODRCd6AtagSuFoFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787756708; c=relaxed/simple;
	bh=M5vRzFgBWucHQG5a7k2WdFivewH8+vxgM0o5ta5rMgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsq2LiXkN7GM2t2k1zs93F2+PTVzryebOccVI4VBOpnxllS8PT5mU2HV3q13GLJkbc73zlFpj9X2eGsRm7R8Lae3iDceVE72gzqx/6EaiMGaW+5C12HwFDsIdcB8X1ekHO+UCOVCaaOrPf/CzVRG8e3NVLMbmlVMCMoSfsTN1tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8bDSvms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8bDSvms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A481F000E9;
	Wed, 26 Aug 2026 15:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787756706;
	bh=P++naScNZowUvRJGvpwZuOXHFESG3Sw1NB7yivdb/jg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=h8bDSvmsmumTK1wPZfvvnD6Mh7l4lkruuUlW4NmjgzaGmgJ59OW6MHEVHxbpSn93i
	 nb7BjisVl9X6I5GXUN/85C7ho409ilqX7Mu8P+jxd6Id9mAkDC5Lb4q5ezn3SYXrAF
	 /yl7HMA7m8r2fWSi22hFgiLA3eKzuUoVYKfc85y4HWs2pU3FEfr4QHQp6uWKoDLNOZ
	 M7ICBWkKbd6Ypel4vrldLgXEuNM5iTJsfU8yg2YDh+RAVQDiRNAkhtEC8A2cwevHo6
	 ZorGmhZu4xIbuEvFYl0z7cSprK8zR9wsNpFjMwVVrzjoldxui6KlMckMwAQbuoO1x7
	 tAN2oODb3bjEg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 693BECE0484; Wed, 26 Aug 2026 08:05:06 -0700 (PDT)
Date: Wed, 26 Aug 2026 08:05:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jerome Glisse <jglisse@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <dbbd6634-4da9-4ecc-9fb2-d7430e2743ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <11dcf5a87125451897982f728c1f65a5151987e4.camel@infradead.org>
 <69567965-48fd-48c5-abb6-0699d7f5bd16@paulmck-laptop>
 <124af87fb49c267eeb26b8b4d952b9b1a5b3fb68.camel@infradead.org>
 <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <ao3z7Rtw2FROkVpy@google.com>
 <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop>
 <20260826073233.T-KtFXmj@linutronix.de>
 <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org>

On Wed, Aug 26, 2026 at 08:38:27AM +0100, David Woodhouse wrote:
> On Wed, 2026-08-26 at 09:32 +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-08-25 13:51:14 [-0700], Paul E. McKenney wrote:
> > > Very good, preemption disabling it is!  It is quite possible that the
> > > PREEMPT_RT guys will need something else, but one thing at a time.
> > 
> > This reminds me of classic RCU ;) It might work in this use case but I
> > am afraid that other users might come along where it actually hurts.
> > With PREEMPT LAZY the preemption within the read-section should
> > hopefully be the exception.
> 
> Given the way that PREEMPT_RT treats other locks like spinlocks and
> rwlocks — turning them into sleeping locks — I suspect it makes most
> sense, and is consistent, to also turn rcu_read_lock_atomic() and
> synchronize_rcu_atomic() into plain rcu_read_lock() and
> try_synchronize_srcu()+synchronize_scru_expedited().

That makes a lot of sense to me.

For that to work, we will need a wrapper sort of like what we have for
synchronize_rcu_tasks_trace(), but one that does SRCU for !PREEMPT_RT
and vanilla RCU for PREEMPT_RT.

Sebastian, thoughts?

							Thanx, Paul

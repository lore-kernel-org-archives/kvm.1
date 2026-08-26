Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0772C40A937;
	Wed, 26 Aug 2026 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787778274; cv=none; b=LYyM6AyXwlsdMY9KZhfOE8KjKF9R46bmMnhU1ksmvSf+RouQ1wGWp6Cib20yDvJMwMh6tSO3WtHvQGVg8qz+MMSB79JCl0AqfXpRI/l+wL2nMWzW9Jumx3ijyLfwG+RkJZR1ddMkhNA8bpaDHHW8E1mBcZISKEjkK7njjWol1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787778274; c=relaxed/simple;
	bh=XM6E9RlD5qF28woF5Bgq2f15LWI0TRuR39pcwDsdGJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIuFIZ4Jd5xER4qVr3PcAAV/ZdE2LiY43g08YAKv7PJ8eidYKbr3KySjqJ9C3rsb1ZIGGFJKfqzRyDJ+9GMfmjWfMbVMeeURpyZHF7n6+D+e1hjOt0TuUFkX/8xoiqxkN5yVzY89oxHbSS4ImaXoMOSV+I/Q+mHKY7rXy/mR5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhQSVXjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhQSVXjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9975E1F000E9;
	Wed, 26 Aug 2026 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787778272;
	bh=wd9D8o6DYVa1N38/T0CvGYo4puGoZ+VeLzsnpIr+Xj4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=lhQSVXjdgZwex5bvjjr7tkNgtCyI0uh3QOi97Mn+cGoo7bug7cBFqPh4Bcvz/TW1M
	 haTgWlQYOjVnbxfJx3B/DsL6ZSG/kf9n1MrX6q26iIpenqY10g/rg2fzjlgJt14sWG
	 3dSP5E2srWDX+MEwBm0xlxAYMEf7oC9hyARAxYmEsiZnl61DzYrTeBGqgOlt994U6V
	 i0JOpFzibPy2UxMEjVA1dC53FAjJ/qrCFVWNaBQqfi9CKA3NMZttw9YiEWBG6oDoC9
	 G/UCMlmFl1i8BdHtuy/WX37Q/rns6nlG5d9xsX6gn+ww/fTV8ZHmgPc5lTz1AEvnWz
	 JWfsvLvEd2KUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 64492CE086B; Wed, 26 Aug 2026 14:04:32 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:04:32 -0700
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
Message-ID: <4415dbf2-10b0-4cb1-b045-13dbcd69c5d5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <ao3z7Rtw2FROkVpy@google.com>
 <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop>
 <20260826073233.T-KtFXmj@linutronix.de>
 <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org>
 <dbbd6634-4da9-4ecc-9fb2-d7430e2743ca@paulmck-laptop>
 <98e123c9-3dc4-45fb-815b-881b3346741c@paulmck-laptop>
 <ACC45EB6-F881-4EE9-A9F8-D53A2B921FEE@infradead.org>
 <e62a7362-7dd0-4615-8877-6ab675971ab2@paulmck-laptop>
 <06F9A0F0-2177-4173-A201-56325A73F89B@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06F9A0F0-2177-4173-A201-56325A73F89B@infradead.org>

On Wed, Aug 26, 2026 at 09:30:43PM +0100, David Woodhouse wrote:
> On 26 August 2026 20:59:31 BST, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >On Wed, Aug 26, 2026 at 07:01:24PM +0100, David Woodhouse wrote:
> >> On 26 August 2026 17:28:27 BST, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >> >On Wed, Aug 26, 2026 at 08:05:06AM -0700, Paul E. McKenney wrote:
> >> >> On Wed, Aug 26, 2026 at 08:38:27AM +0100, David Woodhouse wrote:
> >> >> > On Wed, 2026-08-26 at 09:32 +0200, Sebastian Andrzej Siewior wrote:
> >> >> > > On 2026-08-25 13:51:14 [-0700], Paul E. McKenney wrote:
> >> >> > > > Very good, preemption disabling it is!  It is quite possible that the
> >> >> > > > PREEMPT_RT guys will need something else, but one thing at a time.
> >> >> > > 
> >> >> > > This reminds me of classic RCU ;) It might work in this use case but I
> >> >> > > am afraid that other users might come along where it actually hurts.
> >> >> > > With PREEMPT LAZY the preemption within the read-section should
> >> >> > > hopefully be the exception.
> >> >> > 
> >> >> > Given the way that PREEMPT_RT treats other locks like spinlocks and
> >> >> > rwlocks — turning them into sleeping locks — I suspect it makes most
> >> >> > sense, and is consistent, to also turn rcu_read_lock_atomic() and
> >> >> > synchronize_rcu_atomic() into plain rcu_read_lock() and
> >> >> > try_synchronize_srcu()+synchronize_scru_expedited().
> >> >> 
> >> >> That makes a lot of sense to me.
> >> >
> >> >Another option is to instead fall back to non-atomic SRCU.
> >> 
> >> That's exactly what I thought I was suggesting; I think I left an 's' out though :)
> >
> >Heh!!!
> >
> >About 20 years ago, I was shocked to learn of a valid use case involving
> >sleeping RCU readers, which resulted in SRCU.  And now it is time
> >to be shocked at non-sleeping sleeping RCU readers, and especially a
> >non-sleeping grace-period wait.  ;-)
> >
> >Anyway, easy enough:
> >
> >#ifdef CONFIG_PREEMPT_RT
> >DEFINE_SRCU(whatever);
> >#define my_srcu_read_lock() srcu_read_lock(&whatever);
> >#define my_srcu_read_unlock(idx) srcu_read_unlock(&whatever, (idx));
> >#define my_synchronize_srcu() synchronize_srcu(&whatever);
> >#else
> >DEFINE_SRCU_ATOMIC(whatever);
> >#define my_srcu_read_lock() srcu_read_lock_atomic(&whatever);
> >#define my_srcu_read_unlock(idx) srcu_read_unlock_atomic(&whatever, (idx));
> >#define my_synchronize_srcu() synchronize_srcu_atomic(&whatever);
> >#endif
> 
> We could do that for the KVM GPC locking, but more consistent would be to change *all* users of the 'atomic' lock under PREEMPT_RT to silently get the sleeping version instead, like PREEMPT_RT does with spinlocks and rwlocks.
> 
> So it's srcu_read_lock_atomic() itself (et al) which would get that if/else treatment.

OK, the traditional approach is that raw_synchronize_srcu_atomic() and
friends with the raw_ prefix are always atomic, and without the raw_
prefix it is atomic for !PREEMPT_RT and non-atomic otherwise.  You would
use the non-_raw primitives.

Easy enough to do.  But does it do the job, both from a PREEMPT_RT
perspective and a notifier perspective?

And notifiers (though a different type of them) were the first use case
for SRCU.  ;-)

							Thanx, Paul

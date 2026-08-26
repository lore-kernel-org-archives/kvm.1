Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453D43E08D;
	Wed, 26 Aug 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787774374; cv=none; b=Q3gVo/QVGreOvrJ1awnXt0Y/NlEyIaDYKdE7QxO/7wxCauj6qSEywllaeCAS2ge+/y+y+EjGuJAs5pZjfpBVOFHNXs8a67R4TX3EYOb00kT47bAXibBM8/tIaHliz6AuU2jt9fdhM4SMmusG2vUIATvlKzpJhEsYqHhBpVxDKLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787774374; c=relaxed/simple;
	bh=kqazfdGBSri8PqguxwldlZEhoaZc539YAwgcw0IQaHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G11YAK1V6tEYnNtECjWM+ZShu/fmfifPp9jQK/oT3AN106JkscQrztEj+/x6OpMvg8j31aawEbMXLN5qfhXM9T/NsSjH2aPd3nhKjVL7oDRA+mjDk2XoRh+O2BtAuoL7FJmZGMpM6T5RzEZa3m+XhLNtQXtDtHVEwmzZUTult+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpkDQYM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpkDQYM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9BF1F000E9;
	Wed, 26 Aug 2026 19:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787774371;
	bh=eKPW/iuHg1j2h6dZ9e5C+Ipu3cGJwB9tdZgvrYICRsM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=HpkDQYM3bLmHle/vutflxN8rq3rytEYtj22NqgqqtG5Bw9X1U05PRmODYavLMAHmV
	 bg7HR8c2uL88D/2tG+arrf/CDP9QXzfP9z8agK1NSHmO1Hcm8e9LR4iSKg1DnhExIU
	 rzZHaM8LjDc5/YchWQbldEYz/IWzfZAuUDasVpMPkL6pH4v7gsuaJLDD45JiOE9+N7
	 NwqIsw41ntp5M5ePHPacE3q3w48FU+egzG2HoOHjcWnouy9v2JN1dsqaZKFuTmXSmW
	 UfVFLuhUUACyiWv9Qax63v96g6mtcR3iJQ+k2Mh5ExGhlL2N1nIkRF2DHiaMKV2aCI
	 PLf1bWiXpVOoQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C907CE086B; Wed, 26 Aug 2026 12:59:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 12:59:31 -0700
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
Message-ID: <e62a7362-7dd0-4615-8877-6ab675971ab2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <9427a8e0-3ba6-4f31-a35d-54429bd7e071@paulmck-laptop>
 <3d0463b6099d4fcde9a025a2f9e231d75303b61c.camel@infradead.org>
 <b0be19e9-b0ae-48de-bef6-d905ee007c8a@paulmck-laptop>
 <ao3z7Rtw2FROkVpy@google.com>
 <d4f8ff92-08ac-4253-b647-f9e95c66698d@paulmck-laptop>
 <20260826073233.T-KtFXmj@linutronix.de>
 <da5ee56b7d082abfbb20f71be99a6885247e9811.camel@infradead.org>
 <dbbd6634-4da9-4ecc-9fb2-d7430e2743ca@paulmck-laptop>
 <98e123c9-3dc4-45fb-815b-881b3346741c@paulmck-laptop>
 <ACC45EB6-F881-4EE9-A9F8-D53A2B921FEE@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ACC45EB6-F881-4EE9-A9F8-D53A2B921FEE@infradead.org>

On Wed, Aug 26, 2026 at 07:01:24PM +0100, David Woodhouse wrote:
> On 26 August 2026 17:28:27 BST, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >On Wed, Aug 26, 2026 at 08:05:06AM -0700, Paul E. McKenney wrote:
> >> On Wed, Aug 26, 2026 at 08:38:27AM +0100, David Woodhouse wrote:
> >> > On Wed, 2026-08-26 at 09:32 +0200, Sebastian Andrzej Siewior wrote:
> >> > > On 2026-08-25 13:51:14 [-0700], Paul E. McKenney wrote:
> >> > > > Very good, preemption disabling it is!  It is quite possible that the
> >> > > > PREEMPT_RT guys will need something else, but one thing at a time.
> >> > > 
> >> > > This reminds me of classic RCU ;) It might work in this use case but I
> >> > > am afraid that other users might come along where it actually hurts.
> >> > > With PREEMPT LAZY the preemption within the read-section should
> >> > > hopefully be the exception.
> >> > 
> >> > Given the way that PREEMPT_RT treats other locks like spinlocks and
> >> > rwlocks — turning them into sleeping locks — I suspect it makes most
> >> > sense, and is consistent, to also turn rcu_read_lock_atomic() and
> >> > synchronize_rcu_atomic() into plain rcu_read_lock() and
> >> > try_synchronize_srcu()+synchronize_scru_expedited().
> >> 
> >> That makes a lot of sense to me.
> >
> >Another option is to instead fall back to non-atomic SRCU.
> 
> That's exactly what I thought I was suggesting; I think I left an 's' out though :)

Heh!!!

About 20 years ago, I was shocked to learn of a valid use case involving
sleeping RCU readers, which resulted in SRCU.  And now it is time
to be shocked at non-sleeping sleeping RCU readers, and especially a
non-sleeping grace-period wait.  ;-)

Anyway, easy enough:

#ifdef CONFIG_PREEMPT_RT
DEFINE_SRCU(whatever);
#define my_srcu_read_lock() srcu_read_lock(&whatever);
#define my_srcu_read_unlock(idx) srcu_read_unlock(&whatever, (idx));
#define my_synchronize_srcu() synchronize_srcu(&whatever);
#else
DEFINE_SRCU_ATOMIC(whatever);
#define my_srcu_read_lock() srcu_read_lock_atomic(&whatever);
#define my_srcu_read_unlock(idx) srcu_read_unlock_atomic(&whatever, (idx));
#define my_synchronize_srcu() synchronize_srcu_atomic(&whatever);
#endif

Or is there a better way?

							Thanx, Paul

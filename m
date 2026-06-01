Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D287369D71;
	Mon,  1 Jun 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314032; cv=none; b=B+OzS3QJIBKwxTJ0y7Xtaer5RGy7Vw/tP9j65skzqjUdeAPUCwejE1DQ5BgxU6dwPoi0juT1elc+74EORuyrJ0IITfZQAxYfx6CZeV4/jOWLPiPvA67XHXajfVHXlByHA62M5s1hhEhWOx54CEZ1aYpui0DKMF+W4Olf5ZNQ2PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314032; c=relaxed/simple;
	bh=ZbU4u1OmBBEedgr4rHhmioG58QE5ZCrIs3vpQ+e7sCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXPwntHtf2a+3cMi2NyIzbp7naidIsN+9sdh3A7k8HCQxUjg4cQuVZhobbDfoq6FlMmhEKZF6+C9JEmBdBCoXtzJ7WAsHiy+xlBcYuRKzpG/m5+xKqrCS0QLEI/MEHeZIRcHWlX7DMHFk0azWueJWPCt9MQ5PRrHXlGJF9qx+3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dbe9k+nw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dbe9k+nw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iO68USuj9Ic7SEepg5zAdiYXElFpdlaG8Qko3ceRtk0=; b=Dbe9k+nwrVibeFQM7eqY4Qu1cp
	67gIPXuZh3yCvex13FwBNMq1kjuih8A8JfKPTUZB3eM36SgpPixGOy+tlLjxCsp4Su4C273cRiuR5
	Bfw2HfyosQ8IN5YnEG7MGM6X0r0F5ZHPqvgnIzy9yZZPQuD2eJ+XVd/GQQcXxszMHLG5Y1YRtNoDc
	Kl725iN4yToXZHtLcCDSgp1RChBP7eyFjyAkKi++Cjiawj5Y4V8C4d25ARoZXmc/+3AT+mFOppmSm
	LlokJ1lD234sfIrNnQcBIBIYkub9tzF/QsgcqYJN/RXNIihih6cuS1bRwTyesHoG4+6LHR6PmhWyw
	Qe/B58Xg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU10K-00000006YdB-35P1;
	Mon, 01 Jun 2026 11:40:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7E626300642; Mon, 01 Jun 2026 13:40:24 +0200 (CEST)
Date: Mon, 1 Jun 2026 13:40:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260601114024.GS3493090@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <20260601084045.GL3102624@noisy.programming.kicks-ass.net>
 <20260601111109.r5gExfB1@linutronix.de>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601111109.r5gExfB1@linutronix.de>

On Mon, Jun 01, 2026 at 01:11:09PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-01 10:40:45 [+0200], Peter Zijlstra wrote:
> > > When raw_seqcount_try_begin() is used, the typical action when
> > > the seqcount is busy is to take the same lock that the writer uses.
> > > Another possibility, found in kernel/events/uprobes.c, is to delay
> > > the work to a safe point using RCU.  Either way there is no need
> > > to guarantee progress of the writer under CONFIG_PREEMPT_RT,
> > > because the caller is not going to call raw_seqcount_try_begin() in a loop.
> 
> This does not happen. It only happens if the associated lock is
> preemptible. This is not the case for uprobes.c so there is no lock/
> unlock.
> 
> > > However, raw_seqcount_try_begin() currently uses seqprop_sequence()
> > > via raw_read_seqcount(), and therefore does a lock/unlock of the
> > > write-side lock on PREEMPT_RT kernel.  This prevents it from being
> > > used in atomic context.  Use __seqprop_sequence() instead of
> > > raw_read_seqcount() to allow it.
> 
> So it would work if there is no lock associated or it is something like
> raw_spinlock_t.
> 
> > > --- a/include/linux/seqlock.h
> > > +++ b/include/linux/seqlock.h
> > > @@ -338,7 +338,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
> > >   */
> > >  #define raw_seqcount_try_begin(s, start)				\
> > >  ({									\
> > > -	start = raw_read_seqcount(s);					\
> > > +	start = __seqprop_sequence(s);					\
> > > +									\
> > > +	if (!(start & 1))						\
> > > +		kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);		\
> > >  	!(start & 1);							\
> > >  })
> > 
> > Yeah, I think this makes sense. Thanks!
> 
> Do I make sense or do I miss something obvious? On the other it would
> make sense to have this even for spinlock_t assuming the try_begin
> version does not try spin and expect to make progress (which it does not
> for the current users).

Ah, so I was thinking that since it is try_begin(), it is already set up
for failure and we could elide that initial lock+unlock thing. But yes,
I suppose the user could simply use &s->seqcount to get the seqcount_t
variant.

Let me forget I ever seen this patch ;-)

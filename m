Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E6239A4DC;
	Mon,  1 Jun 2026 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312275; cv=none; b=CZ4Nrd0yBbHIcr+TH+5gRBLhMPgR1jZrXXRKOgBMI/YVh1liefqMDfoGDFL808NwXfN5dxN/It8VrJTsKUWeLBylQLjUNYKI1vWore+kNdypbwCO8NbdrPDvDqqjowP2IhpR2ASi2RWKqXbT5ljfvrr5wWU1TDat1QTqi+Mp1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312275; c=relaxed/simple;
	bh=8RegA0ORWRMpT31K6TAjP6HdePr2oU9f6gvAI++Jr8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3lTIs7/RzSdr114Xlq137qb2rGNmIPFjTr3emPYKuC+E1okG9MoqIBKh4CSAtYs/YdXZPONNFJPzBP0DIFkSgtsH967Hpq0cZyDkUXmeDNHeyN2F1Iu+E13gDLrQfSKo495llhz4JchbtjQqqXqHSduky+9iYk4t7V1cUmZ2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t2klfAE8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MJS/7a6z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t2klfAE8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MJS/7a6z"
Date: Mon, 1 Jun 2026 13:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780312270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVpJIfOPv5KXeQrzOSS5lnp8tIaa/QwzSa+6HvKG2JQ=;
	b=t2klfAE8eM3L7YnVUv0B1TCHcd7AgIcI7/upEM6CxrZfLDnpna/z77Z1AJrARaWvb0Zq+Q
	GPjOTGLoue6jqvnS2j6KW6Z2zMN+RXaXkj+nqg+76kvZNjFCztvlL9GsO1j++mPGayDzv6
	lKub7zbue19ETOxJ3n3PzSMf3D69CecK5G8R4vT+MnBNmzPU64S/k9Uv6wxlpDYkR1hzrD
	9vhlj/43POOIQMgcBO1NfFPgmVGRWpQncgD/Dgfkp1Y+v04n5R61B2TA0/Z+nn6PxbFDz1
	RagMVJVU/d5idco6xznhVBc6Wos58q1fdaintXpoRj9HoBOiCSgE2rkqAYVY0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780312270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rVpJIfOPv5KXeQrzOSS5lnp8tIaa/QwzSa+6HvKG2JQ=;
	b=MJS/7a6z38ZuCy9iy++6fxHP9JEeAm737miC6mBpKpq3dXPIspVsrwMnOAoFP5rqacFAix
	M0+VX8g2+b1Nn5Cg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20260601111109.r5gExfB1@linutronix.de>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <20260601084045.GL3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260601084045.GL3102624@noisy.programming.kicks-ass.net>

On 2026-06-01 10:40:45 [+0200], Peter Zijlstra wrote:
> > When raw_seqcount_try_begin() is used, the typical action when
> > the seqcount is busy is to take the same lock that the writer uses.
> > Another possibility, found in kernel/events/uprobes.c, is to delay
> > the work to a safe point using RCU.  Either way there is no need
> > to guarantee progress of the writer under CONFIG_PREEMPT_RT,
> > because the caller is not going to call raw_seqcount_try_begin() in a loop.

This does not happen. It only happens if the associated lock is
preemptible. This is not the case for uprobes.c so there is no lock/
unlock.

> > However, raw_seqcount_try_begin() currently uses seqprop_sequence()
> > via raw_read_seqcount(), and therefore does a lock/unlock of the
> > write-side lock on PREEMPT_RT kernel.  This prevents it from being
> > used in atomic context.  Use __seqprop_sequence() instead of
> > raw_read_seqcount() to allow it.

So it would work if there is no lock associated or it is something like
raw_spinlock_t.

> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -338,7 +338,10 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
> >   */
> >  #define raw_seqcount_try_begin(s, start)				\
> >  ({									\
> > -	start = raw_read_seqcount(s);					\
> > +	start = __seqprop_sequence(s);					\
> > +									\
> > +	if (!(start & 1))						\
> > +		kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);		\
> >  	!(start & 1);							\
> >  })
> 
> Yeah, I think this makes sense. Thanks!

Do I make sense or do I miss something obvious? On the other it would
make sense to have this even for spinlock_t assuming the try_begin
version does not try spin and expect to make progress (which it does not
for the current users).

Sebastian

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276E377EC3;
	Tue,  2 Jun 2026 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385685; cv=none; b=Ow0Efh6esKFtpG9W3vkCqzfHJZ06aV+eTMIxh1q0MIj28FO6zymoXTb+1yK6IIRd/LxlgNbT+fXLi2vG3dTqQSToVlH7hnF9KWadSXJC/eG8bbVgPMsvPhhNkn4bgvn8i3ZFph/XyjbSpYIrz2GtW0HLdcrT8UxPv8AJc69R0dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385685; c=relaxed/simple;
	bh=cpTu+b+O1h/jt9mdh1DhwrEaSBIJ7XmqkNr6ZvgLpG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnFh1/Pt7bbYhr7aEv3MEB4n0A9wO1ZVv3rMbZGCgXV87pDnIWKHEK4c7O9SLB7wMIlrelMe5Wz/e3vxYEcb0xNmLTSoCgb5cgdN/hMoaUnFse4lvDdWUmUbbDsJd92v3IUdrbYW/R7+4TTdIJJwRvaCimYTvVlMQLGUVLCdW5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0LOD7926; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BhB7d3Wk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0LOD7926";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BhB7d3Wk"
Date: Tue, 2 Jun 2026 09:34:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780385674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3khFEdDOcAAYMECa7SNwzJ72QMBUBo+9S/7pqar0Es=;
	b=0LOD7926WRaPj+Xn9R1VTCMqCkuFM1sdOktjDWsoqlsv7T/OpTflTHGZx9tXh6srSGQGoz
	rZZsFokqSH5Ck6LlECDID0CZW0/larWe47COVjiwmi20jF2vKfYWnxBpj67UDPei2UGekm
	5df7EcdqVtqNJWjC9S9ZlQdKtmVFjB80bb/E929PxsqOZDWTCACKpq3zOP4YsTa7sKr9nu
	gQx/WJdp/VCjVTqE7QGSghqvK9SNOh1J3xpqS9JeY1m5gZVJdAamodNTxDqGMf2O3x8ggk
	sU7zAFKWFuU2uEBxC4fdJM1PdFsLXOl7Jf2RzZ72n6VtT5+qi4oieoYHmWRClQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780385674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3khFEdDOcAAYMECa7SNwzJ72QMBUBo+9S/7pqar0Es=;
	b=BhB7d3WkI4ijhARaKi3RKTxEByHL873oDbvCKOTYiD+aCwXpjPbqYvPsShJkwfUfSWLZiG
	ZcJKDW3SavzVegBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	kvm <kvm@vger.kernel.org>,
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260602073432.PLMxuDdI@linutronix.de>
References: <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <20260601084045.GL3102624@noisy.programming.kicks-ass.net>
 <20260601111109.r5gExfB1@linutronix.de>
 <CABgObfY8_J4D5C8CHMSuoa7c4-PnVxY6CCVgGO+yq9E_5NYtxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfY8_J4D5C8CHMSuoa7c4-PnVxY6CCVgGO+yq9E_5NYtxg@mail.gmail.com>

On 2026-06-01 21:13:56 [+0200], Paolo Bonzini wrote:
> Il lun 1 giu 2026, 13:11 Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> ha scritto:
> > On 2026-06-01 10:40:45 [+0200], Peter Zijlstra wrote:
> > > > When raw_seqcount_try_begin() is used, the typical action when
> > > > the seqcount is busy is to take the same lock that the writer uses.
> > > > Another possibility, found in kernel/events/uprobes.c, is to delay
> > > > the work to a safe point using RCU.  Either way there is no need
> > > > to guarantee progress of the writer under CONFIG_PREEMPT_RT,
> > > > because the caller is not going to call raw_seqcount_try_begin() in a loop.
> >
> > This does not happen. It only happens if the associated lock is
> > preemptible. This is not the case for uprobes.c so there is no lock/
> > unlock.
> 
> The uprobes reference is just an example of a different try_begin
> pattern, that does not involve taking a lock but also doesn't need to
> guarantee progress of the writer. uprobes uses it without a lock but
> that doesn't have to be the case. I thought the commit message was
> reasonably clear but perhaps I was wrong?

I wasn't sure if you followed the code wrong or not. Based on the
example it does not happen. But I get the idea.

> > > > However, raw_seqcount_try_begin() currently uses seqprop_sequence()
> > > > via raw_read_seqcount(), and therefore does a lock/unlock of the
> > > > write-side lock on PREEMPT_RT kernel.  This prevents it from being
> > > > used in atomic context.  Use __seqprop_sequence() instead of
> > > > raw_read_seqcount() to allow it.
> >
> > So it would work if there is no lock associated or it is something like
> > raw_spinlock_t.
> 
> Yes, in which case the patch is a no-op. But in the KVM case that we
> are thinking about in this thread, raw spinlocks are not needed
> because the atomic-context read side would just punt if try_begin()
> fails; and unlike the uprobes case, there would be a lock involved.
> Since it'd be possible to use a regular spinlock, this patch would
> help.

Yes, I understand.

> > > Yeah, I think this makes sense. Thanks!
> >
> > Do I make sense or do I miss something obvious? On the other it would
> > make sense to have this even for spinlock_t assuming the try_begin
> > version does not try spin and expect to make progress (which it does not
> > for the current users).
> 
> That was my point. The lock/unlock is not causing any current bug in
> the kernel, other than maybe some minor inefficiencies, but it makes
> try_begin() subtly different for PREEMPT_RT kernels and the "obviously
> correct" way to do it isn't the right one. Having to use &s->seqcount
> is yucky.
> 
> The docs for try_begin() don't say it super explicitly, but still they
> heavily imply you're not meant to spin on it. At that point it's not a
> "try" anymore.

I don't mind the patch if the commit message would be clearer. This is
what confused me since it did not make sense based on the example.
The kernel doc says "w/o counter stabilization" but it is w/ on
PREEMPT_RT. Based on the API and the current users is not required.
Correct.
It could make sense to update the doc clarifying that a retry loop in
with raw_seqcount_try_begin() is not a valid pattern/ usage.

> Thanks,
> 
> Paolo

Sebastian

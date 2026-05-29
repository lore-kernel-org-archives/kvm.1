Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC617348C42;
	Fri, 29 May 2026 20:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780085622; cv=none; b=m6n+4WJME5pIxG3n3D2s/tF9utkU/WzPSQx8MD94o3MK+xi+kP90sXfXtAQQvecSJo9a+/qUDH55SpOTebMCdeHtwiZDBhH9lYfcqcdBlFg2vh3gazd3DA4x8fTKNI1GL099moANr+Wo/10DGsMc+01kU3iLe9GA+5RM+IEwgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780085622; c=relaxed/simple;
	bh=uwAiG/MLAsLU7jvfNcgX8VIOAFNkzQTd5sSwbpoj0Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5GoNmQLXmN6k3+f4oXkIx2UW4O9mKI/eQVf0v77Yi3N4yYgWFvPCn1wtnJzFLoHrbUls6WSe7GPrmJjwchTK5+HAAORk0BZwiyhhWoPO0FVxnwCUVupHD7THsZiQY9Os9Odv6oQGOkwNfWCRogkId62yxbM77QS8Eq0e9QmeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kuHibrll; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kuHibrll"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y4wBT7I/iH2K67xH5207nlbk+NWE1Q6HFc49/bBEZzU=; b=kuHibrll3UtKrcw18wM8R3ryHp
	QjcfwVB9dskKnpgkuN1MUxcrXdei7DB/opHxf2BloBmtlrDz8gpR9D+DL00IQVIT2zlv3P/CXIkVz
	keXfRGGPoxP3Pr1eRUABypoojSY679755LG1p8l5hUMp6L/LTAKHC1SMPlhjEGDbst09mCuQFHDc1
	wow16ZwtqccohVhoDC+bYcEF8pg1v1x3K5qjOA+4r7eXdTZmk1RWa9nJRqYqenz261fmgwRmi6Brm
	Kq6T1tepOf6nkmmAr5XApqlkEvuLPQEPxtl4PTde3RKVglbn+e3xHk7GWfcTv8AQVmWOfFn2LB5sk
	9tvJCmLg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT3aK-00000006jGz-1qie;
	Fri, 29 May 2026 20:13:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F1D61300324; Fri, 29 May 2026 22:13:35 +0200 (CEST)
Date: Fri, 29 May 2026 22:13:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahnxfACTGeVFbJMk@google.com>

On Fri, May 29, 2026 at 01:05:16PM -0700, Sean Christopherson wrote:
> On Fri, May 29, 2026, Peter Zijlstra wrote:
> > On Fri, May 29, 2026 at 09:32:14PM +0200, Peter Zijlstra wrote:
> > > On Fri, May 29, 2026 at 09:50:55AM -0700, Sean Christopherson wrote:
> > > > From: David Woodhouse <dwmw@amazon.co.uk>
> > > > 
> > > > __rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
> > > > which unconditionally disables and re-enables interrupts. When
> > > > read_unlock() is called from hardirq context (e.g. after a successful
> > > > read_trylock() in a timer callback), the raw_spin_unlock_irq()
> > > > incorrectly re-enables interrupts within the hardirq handler.
> > > > 
> > > > This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
> > > > context) and can lead to IRQ state corruption.
> > > > 
> > > > Using read_trylock() in hardirq context on PREEMPT_RT is safe because
> > > > it does not record the lock owner. The read_unlock() acquires the
> > > > wait_lock which is hardirq safe. This change additionally allows
> > > > rwlock_t during early boot.
> > 
> > Forgot to reply to this; it is safe with this implementation. If we were
> > to ever do reader owner tracking this goes sideways real fast.
> > 
> > I really think this is a very bad approach.
> > 
> > > > Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
> > > > preserve the caller's IRQ state.
> > > > 
> > > > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > > > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > 
> > > We have very specifically not supported the: trylock+unlock from hardirq
> > > (although typically this comes up for mutex). Specifically with PI this
> > > can lead to trying to boost the idle thread.
> > > 
> > > Consider doing this from an interrupt that hits idle, then idle becomes
> > > the 'owner' of a successful acquisition. This is absolutely broken.
> 
> I assume the only alternative is to implement raw versions of rwlock?  Or do I
> understand all of this even less than I thought? :-)

Well, the code needs to do something when trylock fails, can't you
pretend it fails unconditionally?

It is somewhat possible to do an RT aware read-write spinlock thing, but
it is definitely non-trivial and this would be the only user.

Also, why does it have to be a rwlock? Can't this be RCU-ified in some
way?


Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ADC340413;
	Fri, 29 May 2026 19:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083283; cv=none; b=H1R3COfo0igYrKxsP5swNhlmCOlTTgnYsMyRKefo0yKMvKcc/52MwyIEZGrYOOJn1dqKoOP6fLLs6LQxW/ssEmOF/uzrFLQcMjYhDRuP9qhvOkyp20S8Ppu5ZiqNq+4LTWILlkzS2LDhFmyMl2LrMdWDh/OJPS7ud+fCMOgVe0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083283; c=relaxed/simple;
	bh=irhVmMfhXO370ObLCPBVL4KDgBfb+EigNjZddkh19EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMkmKP0ejtYYQ+asIRCErda+SDRs/RUOJYsdyJa1yW9W3HIB5ZVvzSSiD1uNKEE3kwHv7/SeupVhh/wzyDtpcCGPeW0WK+qBf3GlxpfmGAw4sbbZOt8XJgaYtsLsMgOp6wBSKWubL7yEmeFdLcWf3tOk0A0D4zhU01K1dFzbwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DhgXHv0Y; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DhgXHv0Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Rg95JCw3fA/SUmk+SCbl6nNl/uqefndCcXh66uCQ/H8=; b=DhgXHv0YUslGioZrNDlkMJHcrn
	mExWDD7kq2k2O9v1fBhaG0nNYBefaJXjYuWQLRfjt2EpQDJFdfebDmRMeCmRIwVstEP/iqedPE76s
	p0Fx37L5VnTYBT/bRG5BlQFpli+zJyKU1CCpW0I5/W6Rd/pn7E/7FqnWRDwxUzcfZTsjB0/tAsa38
	zVvZs1s7h+1Tdd2Cp4DPsY0z89L0pRFjjoQY2QsNGcVz4CJjt0HfEapmNCa3nuYdF2SwMFBbQuMF3
	1FU1YS3Ru5y4Tzofl0QKDe5JDKZWnOrWklMfULZMJXy7M5MXxsyZxKLAAwRKSvHwK8V5wTOwfxTBu
	rowHItEg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT2yc-00000006gBM-080D;
	Fri, 29 May 2026 19:34:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28A0C3003DE; Fri, 29 May 2026 21:34:37 +0200 (CEST)
Date: Fri, 29 May 2026 21:34:37 +0200
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
Message-ID: <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529193214.GN3493090@noisy.programming.kicks-ass.net>

On Fri, May 29, 2026 at 09:32:14PM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 09:50:55AM -0700, Sean Christopherson wrote:
> > From: David Woodhouse <dwmw@amazon.co.uk>
> > 
> > __rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
> > which unconditionally disables and re-enables interrupts. When
> > read_unlock() is called from hardirq context (e.g. after a successful
> > read_trylock() in a timer callback), the raw_spin_unlock_irq()
> > incorrectly re-enables interrupts within the hardirq handler.
> > 
> > This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
> > context) and can lead to IRQ state corruption.
> > 
> > Using read_trylock() in hardirq context on PREEMPT_RT is safe because
> > it does not record the lock owner. The read_unlock() acquires the
> > wait_lock which is hardirq safe. This change additionally allows
> > rwlock_t during early boot.

Forgot to reply to this; it is safe with this implementation. If we were
to ever do reader owner tracking this goes sideways real fast.

I really think this is a very bad approach.

> > Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
> > preserve the caller's IRQ state.
> > 
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> We have very specifically not supported the: trylock+unlock from hardirq
> (although typically this comes up for mutex). Specifically with PI this
> can lead to trying to boost the idle thread.
> 
> Consider doing this from an interrupt that hits idle, then idle becomes
> the 'owner' of a successful acquisition. This is absolutely broken.

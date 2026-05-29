Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11279342146;
	Fri, 29 May 2026 19:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083145; cv=none; b=iM5bpIgwPpSVDieGQs7sFz0P/mtYn7QoNj7iEMFlhyMDoyAnSrdxOfHbjs0DZ2efVFqtvNGoy99CFlG/LFBWkvEOGXxBNVvelpJUmdi2Il8OThC6HK5SG6xXY4+V1zaf+T01nujphdWEQkX13fpINu3HcaMHY/bTA9sqZHZNDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083145; c=relaxed/simple;
	bh=xn+WiKfGbGMVvA1DDwwi3y9Iq8tOSAuwLEBKk0SouUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1ChhmRwK2zLwBaTSXrVgss26iD3TDAmgJSlnoSX1F0L+0H/MIlwlAM0ONVsG+r+mxcXvkpcDoo5XJMZskoVMTY8FGqSxg+1fAQZwOqo6GfPJYBySG4wyKVXNKGPaXxLH6hWuQ1avp9yNUxQWSMFBkwQQX5MWpGDodpg32QJg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bS5wqYWM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bS5wqYWM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3fjjHmrPqBpH0BN7luIRa47tBht0yyNloFesaSfXXQw=; b=bS5wqYWMVW+lYn71s2OgQlBCsC
	0JMO1X8ewkn7GtqhKgI8dGGj6oQsS8BBkDrUjGImGNFtqfvERXkbB8L4E/cf5aWKMNsvshc2+oRHX
	g19SWQ0vHRtzKfgrAhrXNV8SX5bvaXVFXrot3JjwG7mR3Z9u36VrJ/mZjA9sgey0rdmvoLMjxK9Zh
	TO38/kSL+3Ssu9J6nig9pM2DxZmWz8mdMFTRyqcu0KMwVroT1yhhaEWMi/7q1WbjSjGw552Ty9qS3
	9UlGRJXrU3uvEL2LdQszwC/82vzlYRfFFfLUMEG/QkTf+I+QNMRKYDQqK2aDMUrTPEQZ5Bda+Suyr
	ajsaRu4g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT2wJ-00000006g3K-1A90;
	Fri, 29 May 2026 19:32:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CEB35300324; Fri, 29 May 2026 21:32:14 +0200 (CEST)
Date: Fri, 29 May 2026 21:32:14 +0200
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
Message-ID: <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529165114.748639-2-seanjc@google.com>

On Fri, May 29, 2026 at 09:50:55AM -0700, Sean Christopherson wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> __rwbase_read_unlock() uses raw_spin_lock_irq()/raw_spin_unlock_irq()
> which unconditionally disables and re-enables interrupts. When
> read_unlock() is called from hardirq context (e.g. after a successful
> read_trylock() in a timer callback), the raw_spin_unlock_irq()
> incorrectly re-enables interrupts within the hardirq handler.
> 
> This causes lockdep warnings ('hardirqs_on_prepare' from hardirq
> context) and can lead to IRQ state corruption.
> 
> Using read_trylock() in hardirq context on PREEMPT_RT is safe because
> it does not record the lock owner. The read_unlock() acquires the
> wait_lock which is hardirq safe. This change additionally allows
> rwlock_t during early boot.
> 
> Switch to raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() to
> preserve the caller's IRQ state.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

We have very specifically not supported the: trylock+unlock from hardirq
(although typically this comes up for mutex). Specifically with PI this
can lead to trying to boost the idle thread.

Consider doing this from an interrupt that hits idle, then idle becomes
the 'owner' of a successful acquisition. This is absolutely broken.

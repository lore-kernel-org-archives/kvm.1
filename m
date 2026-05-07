Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B03F7897;
	Thu,  7 May 2026 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778160081; cv=none; b=pcx8e+n2yt4KBxzydYOlEb9zlXFMOsaTBzVmDwrh5hYTYnkKVDDmQNsjYkMlNgGQtqVDV2VK4cFxL9JH5x9x8wpXFhkRFjy7f0uAQYZ99cDp4pxlKjKDfHgvHDNUyK9l0ycJSf8ohKklLMw5X72UBOwtuWzYzk7Jk81ptBYcmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778160081; c=relaxed/simple;
	bh=+a0j444uHEUgownYxRFw/eFzDQRZfI4DWbRVdEJuPhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc222Qxu2ZQkH1II7Dm/Pbq/cQ/HPw+mRNEnvbUHphLg9BWqs1Z5xeGvm9P0G1ODu5MO9fEm93r9p9EvJX2xz/0rWyZfGhTEL6OxxXG24k0W4nldxBKJlb+8tlR8Koy6oXYiqylK3/B+59EVPeaz6+1pPNSbLF5ZxwRfSADEaz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zUuMP7wM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WEnEo99+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zUuMP7wM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WEnEo99+"
Date: Thu, 7 May 2026 15:21:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778160076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HjdgPmDV3FZA+j4lWb0JZyxxcOJn8CdZB/jhMnjG88=;
	b=zUuMP7wMVn9eDRqJhKHwwzYUGsdPbCBKdBxPWej7vhGz2dwN8DmaxI2JTME9osNFyI4iwK
	t6sNPIPnQPmFmscCrSBGDvlX7wTP1K9eiwSQVN0/CYcPhD9Nmvf1K7nZuPhre9+i8l0UNq
	FUmEFQGALFq6i30Nj+qpBNScPaX9ogCpUFPgzbeu9WDxhn+vZhe+rVAkh6FpT0jMsVK/dq
	sMs9J55VCzAGrlvn7qWcb5cOvycHHe/06H0aSGLjd/YYDH+EmDNj7BmN4SfCUL4YfD1eer
	N2ByLqcGqtnyD7xeNA/uczKqd1FAv3gVaL3BL8u5xcP50A8Mcv7U7eYJNfC2+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778160076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6HjdgPmDV3FZA+j4lWb0JZyxxcOJn8CdZB/jhMnjG88=;
	b=WEnEo99+6RhF6+wheT689C8QdJc5J2KRPNhQBxp+422sBaO2pf2yh42CGhyaxRpXxiRzOm
	W0Olb0ebVKcdMwBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Mauricio Faria de Oliveira <mfo@igalia.com>,
	Paul Durrant <paul@xen.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, kernel-dev@igalia.com,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86/xen: bail in IRQ context on PREEMPT_RT in
 kvm_xen_set_evtchn_fast()
Message-ID: <20260507132115.w1nOBvlS@linutronix.de>
References: <20260506-xen-rt-sleep-v1-1-53b6b60a671d@igalia.com>
 <8e7bc66a7994ca06f164a5d5f7ceb3f07d3a1357.camel@infradead.org>
 <20260507071235.rdb4aGeE@linutronix.de>
 <f0f447dea6c8f2deb7f153f745add15d3ecadd19.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f0f447dea6c8f2deb7f153f745add15d3ecadd19.camel@infradead.org>

On 2026-05-07 14:00:49 [+0100], David Woodhouse wrote:
> On Thu, 2026-05-07 at 09:12 +0200, Sebastian Andrzej Siewior wrote:
> > 
> > So the cited patch does not look bad. That read-trylock should be fine
> > on RT (as in I don't see anything wrong with it). What did happen to it?
> 
> The read_trylock() may be fine... but does a read_unlock() try to
> "re-enable" hardirqs?

Yes, I missed it while looking for it. This could become a _irqsave().

We do this already for spinlock_t/ rt_spin_lock()/ _unlock() because it
is used during early boot where interrupts are disabled and locks are
acquired. So it needs to preserve the state and since rwlock_t is not
(yet) used during early boot it was not done/ observed.

The try-lock on the read lock just increments a counter in order to
acquire the lock. This is it. The spinlock_t on the other hand records
the current context as owner which can lead to a mess. Therefore a
trylock on a spinlock_t from hardirq context is wrong but it should be
doable for rwlock_t. I don't see anything wrong with it (except for this
one thing can be corrected).

Sebastian

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5747A868;
	Thu, 20 Aug 2026 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240058; cv=none; b=YZetCjYq7jzhD6UOJu7QfiL1qIXpmLfK9eZwU0X1wuZuCXir6XtYYrsHEQcu6Iis0JhzqCr29mfRhO5qOu73yBUt7Pzq/CJvIcPhO3UcXy+zlV9gaX6aoVSVsaA3FB5NnnuI9hqpaRT5jwg5+gsokK/mhzzfucpM0CH82M4lN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240058; c=relaxed/simple;
	bh=l/Ollc2Gxv9AZOgk9zNP4zB3Y8ps7p00jkEgW36uJcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMQ+9+x95XMTTHbEfC6hxtG3Fo02xDgL/+xFI61EDXaAnWzYRvSYeUceShYtt2xIESYTgL30LYY8Ql9VndBKdPMoBw3t9ngjKzjiA2Xl4XY+P6UeDi3vKILo39ykEeIbCl4BGhlmwYBJZ8fpG8zQFrzha+MM1alNZffSB8zgdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfcctPuN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbnMBF3Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfcctPuN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbnMBF3Y"
Date: Thu, 20 Aug 2026 17:34:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787240055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnQ07X6Vq1lV2T06V5sf/SOjpM/4n7JqjKjnkaB9qXc=;
	b=pfcctPuN5/Xbfx3OXgOZDbHxVwzMgOj+0VGDZnd2Tffm0m01fR0cJvlT6tINnj1YogvMNz
	iycKG7KKK5z+DtNSjyd7I5L6KJ98j+TuHFVAFDDJd4zP65mCNStqEyzp4hNi2FJydFiEeY
	vOADJVPPv6e+6zQAzax6ShueyhGSokHbl6mAvnppmno6TkgV0JJZPyS3nZV89H8GbFC8sh
	o2hxXTs4hWMZ1YmtDnYguiGQZHU1mc2Uj8zoEy7IXyPRQFy+Y09tbME7s4CUIiQyvCsAjR
	RW1eiGVXpyQ/ajFUfUjJo9FY4iixItpjyUtKPZKMmwazIg7lWKwM+KtT4dIwUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787240055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XnQ07X6Vq1lV2T06V5sf/SOjpM/4n7JqjKjnkaB9qXc=;
	b=SbnMBF3Yj7gzKAbvIHxsY1eMaDbTkPtAdcZdgBYd1G/FlP05ovO/uptZmhdHqzIV3qJjHX
	vlBOFDr8qv6M7MBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Hocko <mhocko@suse.com>,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260820153413.1EAmdFht@linutronix.de>
References: <20260820133020.7ZCRIhwX@linutronix.de>
 <448c5c0128b08ab98d175ae1099ff4d4874e49b3.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <448c5c0128b08ab98d175ae1099ff4d4874e49b3.camel@infradead.org>

On 2026-08-20 15:26:35 [+0100], David Woodhouse wrote:
>=20
> So if you fix the might_sleep() and Paul comes through with the atomic
> SRCU thing, I no longer care *much*, but still think the whole thing
> deserves to die.

Okay. Let me look into it then. But "the whole thing deserves to die" is
limited to the kvm usage, not in the kernel?

> Going back to SRCU atomic (citing your mail in reverse order):
> > In
> >    https://lore.kernel.org/all/a94b75e8b9b1d2191f365c0f4275fd5082332df5=
=2Ecamel@infradead.org
> > there was a suggestion for "srcu: Add an ATOMIC reader flavor and a spi=
nning
> > synchronize_srcu_atomic()". This one had preempt_disable() in
> > srcu_read_lock_atomic(). This is bad as not only forbids to acquire any
> > sleeping locks (such as spinlock_t) but it also does not allow any
> > scheduling of any kind within this section.
>=20
> That was kind of the point :)=C2=A0
>=20
> My=C2=A0srcu_read_lock_atomic/synchronize_srcu_atomic() were born of the
> "need" to avoid scheduling in OOM (RT or no), but actually I think they
> survive even when that requirement goes away.=C2=A0Even with my
> try_synchronize_srcu() optimisation, we saw higher tail latencies when
> deferring to the workqueue, and Sean was very much in favour of
> eliminating those.
>=20
> So I think we do want synchronize_srcu_atomic() if Paul can find a way
> to give us that.
>=20
> To your point about preempt_disable() in srcu_read_lock_atomic() on the
> read side... I don't know if we *need* it to be like that. When I threw
> it together, I was thinking of it as a raw_spinlock, in the "must not
> sleep" mindset.
>=20
> In fact, as long as the splats are dealt with, it would probably be OK
> for it to be equivalent to a non-raw spinlock: disable preemption on
> non-RT, but not on RT. I think that's perfectly OK for us from the KVM
> point of view. But does heavily depend on how Paul wants to implement
> it, of course.

okay.

Sebastian

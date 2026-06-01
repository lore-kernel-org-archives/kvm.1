Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C1330F548;
	Mon,  1 Jun 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306830; cv=none; b=T3JKhcdq+7XQ5wZVPCsQhg3xgzPiITyWBt37YhQas1DKyPRoxGW2wY84QzfLhEvxxoUdoLo5BbKrLE4jB5+mznVe4DOXQb9FJbboTnQ+5/+1+IKfvG22zqnu0+CrFqapLXFey1MMuRz2wKNVzeM6RofXgzYoVLgKaud3tEEAXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306830; c=relaxed/simple;
	bh=23DTnbP2lnYl3ZjEDf3TJBmPZV+NNa3n3j46ggDfhfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB+XrS0qzoMoBaDpvUYzrGuGxt9KEQkoZbEg9RzDAJ/ZGxLrdRh6dKVLY3OKxQ8mT8IpYosNncEYg6XnIAb3rqjQhtoxqTDuOjpgUgL54Zo9vNrGOsdiAC20raj6/tSWEsQ40ClkKoTIKc88t6cDKQOvD5jD2ZpsQhP8ugKqAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n8uRNnQw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n8uRNnQw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=23DTnbP2lnYl3ZjEDf3TJBmPZV+NNa3n3j46ggDfhfs=; b=n8uRNnQwWReNVaE4x1SuQkhLFR
	yWfLFoAHRtjpbIpbkFavxot1bM55KFWvE0UvCqPQDACDKsCLsdLlzCMmjjU7jjfQXE9hy6v5GmJ3S
	tKA4lNoaLlnd5HCIIUAhrv0I8gzJVFN4OXj3PA7NjKYpUm4NDELpMVZh8+Mh1rqAA7fM1Wv3iPSPx
	fZDjr83oA/5MvQKtxQxD1WuAnLKRXfRWZSwGfbsVgU3J4DRpAfcp1okfDXyCKi0YHzYaKJK9h/Vpf
	LHkozlKMYbETVeDrLhtn+i/58770FcuOhXMlr9I2rW+SOtgsC2CeGi0ux2MwZWPQ5wbUI0fv3ibpC
	liDuxb+g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTz86-00000006GKY-1ReC;
	Mon, 01 Jun 2026 09:40:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94D2D300454; Mon, 01 Jun 2026 11:40:17 +0200 (CEST)
Date: Mon, 1 Jun 2026 11:40:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	Carsten Stollmaier <stollmc@amazon.com>
Subject: Re: [PATCH v2 01/20] locking/rt: Use raw_spin_lock_irqsave() in
 __rwbase_read_unlock()
Message-ID: <20260601094017.GM3102624@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
 <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
 <aho1M7fvK1Qzmiai@google.com>
 <1c3b224f-2780-4347-b72b-783586a9b0e1@redhat.com>
 <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <58d17a623c1c5c9c09bd91baa30510aaf42f899b.camel@infradead.org>

On Sat, May 30, 2026 at 01:47:06PM +0100, David Woodhouse wrote:
> On Sat, 2026-05-30 at 12:26 +0200, Paolo Bonzini wrote:
> >=20
> > Yeah, I think so.
> >=20
> > The write side needs kvm->srcu so it would have to be yet another SRCU.=
=20
> > I initially thought that sucks for the code that calls kvm_gpc_check(),=
=20
> > but maybe not because it simply replaces read_lock/read_unlock.
> >=20
> > By using a seqcount for the data, SRCU only needs to be synchronized in=
=20
> > gpc_unmap().=A0 So, something like this:
>=20
> It isn't just gpc_unmap() which does the invalidation. We also
> invalidate from the MMU notifier in gfn_to_pfn_cache_invalidate_start()
> which would also have to synchronize, wouldn't it?

Ok, so I had a look at what this code actually does, and it appears to
be a guest frame number to page frame number cache, managed by
mmu_notifiers.

IOW, its some software TLB thing (pre HVM Xen support?)

Now, mmu_notifier_invalidate_range_start() has a rather explicit
might_sleep() in, and while there is an
mmu_notifier_invalidate_range_start_noblock(), that has an error return,
and it is clearly specified that if that thing returns non-zero, PTEs
must not be changed.

With all that, I don't see why we can't block for srcu_synchronize() in
gfn_to_pfn_cache_invalidate_start().

Now, I've never much looked at mmu_notifiers, but for native, TLBI might
require sending IPIs to all CPUs, and as such cannot happen in atomic
sections. I would expect this same to extend to mmu_notifiers. It must
be possible to sleep in them.

What am I missing?

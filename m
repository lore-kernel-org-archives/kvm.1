Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6E34E746;
	Fri, 29 May 2026 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087144; cv=none; b=iIyLKkXyzaDt+daQcEwHVcOzo5AKcXFGBhBHKwt9tez/xerrr/7EJ81MTx91Q2O8obE1QVe4ZtrJIugVDNriU7rxaZKz0UED0tRnBw7cZeGEnmDDv1Y+8BtYtHx1L5iU8kIOL3GYJitwfV093cgrN9Tavd31oxheuOJGwhPhEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087144; c=relaxed/simple;
	bh=2JdrGw+sHRi+Pi+J/euN//Cy+HOEsitDVfWJ8FzedCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFFcoo4Sw1nrz1xsAUqH9SGqmWKHHhhIgzyAdtxkSyRI7iGPlunf33+/dbP1EuUxtSTSntFYz52qofH3P2Q5ZD8M70WlQPQqGbNuyEHa/WwD3WZRuOy9847/31VTylkoGWzh4RoSk1wP9U9tknoTTHG6vChZgcar1ZrFKiVmzYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bwjrgYbB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bwjrgYbB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2JdrGw+sHRi+Pi+J/euN//Cy+HOEsitDVfWJ8FzedCg=; b=bwjrgYbBTddXNa3DSdll9oYzhJ
	GhkhP1/TXXoCG5M3M87gBLYqBK57eCCFQg/35YaG0NZFWJkl5xVyybVWRNaj1qONyHILpCRJrYB9e
	r+tvk+hgnN1PILcQIS86axlV2D+/QFFEyEkES+XErAS373nkaEVQsyE3s3IPxOoalTcbzkOa3+az7
	019BFLXqG9HGHaNHspFfztCh37iC2hK7ZR8lwjM2G+U28Oi/JwjxbWXmNzkuY9B0E6coZMWJlzBGk
	55k8exnIz5W92/OEbUeNW0hROhXu/bHjxI4xYYai0IRuCz/VJKjhH1oVl+L8kJ++ImJtPxGQWrRn3
	U+S4GjYg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT3yc-00000002Oju-1A2C;
	Fri, 29 May 2026 20:38:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4FAD23003DE; Fri, 29 May 2026 22:38:41 +0200 (CEST)
Date: Fri, 29 May 2026 22:38:41 +0200
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
Message-ID: <20260529203841.GC3568911@noisy.programming.kicks-ass.net>
References: <20260529165114.748639-1-seanjc@google.com>
 <20260529165114.748639-2-seanjc@google.com>
 <20260529193214.GN3493090@noisy.programming.kicks-ass.net>
 <20260529193437.GB3568911@noisy.programming.kicks-ass.net>
 <ahnxfACTGeVFbJMk@google.com>
 <20260529201335.GP3493090@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529201335.GP3493090@noisy.programming.kicks-ass.net>

On Fri, May 29, 2026 at 10:13:35PM +0200, Peter Zijlstra wrote:

> It is somewhat possible to do an RT aware read-write spinlock thing, but
> it is definitely non-trivial and this would be the only user.

Furthermore, it is fundamentally one of the worst possible lock types.

It really isn't something you *want* to have -- arguably even for !RT.

They scale like ass; per them being a spinlock type, the critical
sections must be short, but this means there is nothing to amortize the
cost of bouncing the shared lock around -- which is the 'saving' grace
of the rwsem.

For short sections the cost of the shared access will dominate. I'm sure
Paul has a bunch of graphs to illustrate this point :-)


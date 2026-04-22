Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B461279DC9
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871613; cv=none; b=BLjaTJHtTovywu85djVw5aklJHlLKx0ZmCFyj4N/gPgWYelX1KohfOmlNZdWEh0vf+DRoI8LmAcLSBsh1PAtkky/y9xTEwDPu3OC+OaNS5nk/WR9mY32Cve+axQOXgwF8fz8CXQmYO1QzPFVfST7rfjKKZ085OEUjfYWyZFWhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871613; c=relaxed/simple;
	bh=WU+RKA4tSbjargT3TM5bKMklzQRv7p8vgxdbQ6DrEuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MPuQ/9Zr3nIPWS0hNbs61X1Gk+7GZ91KWd8xvKrnTJRiRgRy15iERP9cQYfoqI6+pQVWiv3IXFG9KNoitkoOJUvKuVdc447+JiuA5/CeMtd5KiSc8bpZ1FTS+R5LFEpRx6kEuzRTKIpNm2Kf+fh+P39H9Tk14xbKT0uKd2wv4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnV1xoT6; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnV1xoT6"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7985752be1so1927953a12.0
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 08:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776871611; x=1777476411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvv7wEoh6kZ4KG1aTICtQtgLpUqc1kNtqxqmBNFAfig=;
        b=cnV1xoT6QAdtumb4vGVNNu2GAa9urFadSlW4Ry0eKlX97dN48/2G0Imex05jMwc4BF
         pspE2kPXZkyQlvIrVxnxwnDC+j63STz9YBkeAzOHDNu7ytEKIEXBmExvygqx31GYgUU7
         XrsNld965NUxEF6Oyh9EBseORb7WoD22yVMtuVmofQDrCZLOQ0CH5s6KOZl/ihN2RUTv
         lTlTE0vC/q4DFnQzOWW4lfJ1Zzv8xu8txrp4eFjHik5e6qNrtDBws62Tx6a4rCz/Ifd6
         DfcwDfrLU3bhIzsNd0r6J1gHnFfgOYh1wkzN9LlXZw3tkRSIUGRrP3REcy8Y3yAaKTji
         cddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776871611; x=1777476411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvv7wEoh6kZ4KG1aTICtQtgLpUqc1kNtqxqmBNFAfig=;
        b=K+3hCHoJd2tv2Iex1yEUwnKWqn2zKrFJA1fmNLNxQLpXIFslBFa/hcXUzCCMW7mY1m
         n+swXba4wmMue3b0K6yLluFXrT7p71TNtLD9Edl7aq9w3woNCYDPawTbOigJZg5DsViF
         kYXmFlNDHF6hxMcoZhe1yC8SUmgPYReDppnnJTHWbhcnlF+vlHoKKPXPIs/J6+FN7R20
         NTZ8QbMzUV3hn521WCXDSotKBN7VaGGe5bZPt0l2G4UUcwEW8EIrFqI1gIHnePUtNpZ3
         cXIs5cMueqFl3VWPZhP9ZDSAwIfm2oOx+Xtxmo+w38IGVx2hmTilX5SyCadKfW7K5N+C
         B4+w==
X-Forwarded-Encrypted: i=1; AFNElJ9J07zuZfWjwHc7DMgF0EiS+ddyGgkjqFT76T4qPb47t0pulkSevjNrUUHCYYIFxhlmVy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg6xqJHdjI6BnS1bVQbTH3ngEWtt+Hai2hwACwhfKYFBfjI1Tk
	cKOwcz8uVGN8i3fWy1h+dsus4wffEeWsWAWAgOsDL+5WeTuwnOirnggMCcJWd2Cyrb7es3O0WLz
	EO1YF3A==
X-Received: from pgnh8.prod.google.com ([2002:a63:3848:0:b0:c79:7b38:e8bf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3298:b0:398:b8eb:6716
 with SMTP id adf61e73a8af0-3a08d7ac303mr25642708637.23.1776871611248; Wed, 22
 Apr 2026 08:26:51 -0700 (PDT)
Date: Wed, 22 Apr 2026 08:26:50 -0700
In-Reply-To: <20260422140831.GR3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com> <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com> <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
 <20260422074646.GO3126523@noisy.programming.kicks-ass.net> <20260422140831.GR3102624@noisy.programming.kicks-ass.net>
Message-ID: <aejouuIqsyOuICSj@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Jim Mattson <jmattson@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 22, 2026, Peter Zijlstra wrote:
> On Wed, Apr 22, 2026 at 09:46:46AM +0200, Peter Zijlstra wrote:
> > +		instrumentation_begin();
> > +		/*
> > +		 * KVM/VMX will dispatch from IRQ-disabled but for a context
> > +		 * that will have IRQs-enabled. This confuses the entry code
> > +		 * and it will not have reprogrammed the timer (or do
> > +		 * preemption). Minimal fixup for now.
> > +		 */
> > +		hrtimer_rearm_deferred();
> > +		instrumentation_end();
> 
> So I've been looking at this preemption thing. After having gotten my
> head in a twist a few times around, I think this is done by
> vcpu_enter_guest() like:
> 
> 	preempt_disable();
> 	local_irq_disable();
> 	...
> 	kvm_x86_call(handle_exit_irqoff)(vcpu); <--- all of this VMX nonsense

To be fair, there's some SVM nonsense too. 

> 	...
> 	local_irq_enable();
> 				<--- WTF goes here :-)

All IRQs on AMD, and tick IRQs on VMX that arrive _just_ after the VM-Exit.

Because IRQ exits on AMD/SVM are purely a notification, KVM needs to enable IRQs
in order to service the exit.  The early enabling exists to get the timeslice
accounting correct.  With the comments...

	/*
	 * Consume any pending interrupts, including the possible source of
	 * VM-Exit on SVM and any ticks that occur between VM-Exit and now.
	 * An instruction is required after local_irq_enable() to fully unblock
	 * interrupts on processors that implement an interrupt shadow, the
	 * stat.exits increment will do nicely.
	 */
	kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
	local_irq_enable();
	++vcpu->stat.exits;
	local_irq_disable();
	kvm_after_interrupt(vcpu);

	/*
	 * Wait until after servicing IRQs to account guest time so that any
	 * ticks that occurred while running the guest are properly accounted
	 * to the guest.  Waiting until IRQs are enabled degrades the accuracy
	 * of accounting via context tracking, but the loss of accuracy is
	 * acceptable for all known use cases.
	 */
	guest_timing_exit_irqoff();

When NOT precisely accounting virtual CPU usage, accounting is done by setting
PF_VCPU on current->flags on the way into the guest, and then clearing it on the
way back out.  The latter is done by guest_timing_exit_irqoff().  If KVM waits
to enable IRQs until after guest_timing_exit_irqoff(), then the tick IRQ handler
will account the tick to the host, not that guest, even if 99.99999% of the time
was spent in the guest.

As to why this is in common code, i.e. isn't AMD/SVM specific, if the guest and
host are running with the same tick frequency, it's suprisingly easy to get in
a state where the host tick IRQ almost always arrives just after VM-Exit, before
KVM fully enables IRQs.  Specifically, the guest's programmed tick will trigger
a VMX Preemption Timer VM-Exit at the same frequency the host's tick triggers an
IRQ.

> 	++vcpu->stat.exits;
> 	local_irq_disable();
> 	...
> 	local_irq_enable();
> 	preempt_enable(); <--- here we finally preempt
> 
> This earlier IRQ-enable makes my head hurt and I had to go buy a new
> WTF'o'meter (again!).

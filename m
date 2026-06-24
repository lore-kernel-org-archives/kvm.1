Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DDD30C144;
	Wed, 24 Jun 2026 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782275038; cv=none; b=OtX3kFDXO2iIHmcA/1CQpWWErgb94GnGoYJXu/lJ5rfX3iysXRqdFReVkNjZXm4gFgyvTlNl8yVSkgDG7mnM2lHMqb97LN+0wN5nB1uY/YZQN5iP3tu5koh417GN+HSRZKRXojFgaq5WLtYQVrkYTe4ZTUs6SY+5auTqw/1QMhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782275038; c=relaxed/simple;
	bh=/VDAWvqEVWRwL2bygJTtxYJnAUhDrljbETsx/v9Qni8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mobtX5epslFQpuhEu0q7aqtq6w26Xwn0tyDinRGGjQPKU5bILp5Twhbqri5uCgYaNbbf2M1tBViE/obKOZROU5w/Lix5V9gdEjcr89SxX41ztFcgH02/+HSQ1aZrgXjth2hUrKeGSGYOwScpf6x0D/2cuTFQ5yIhdDoDC0OlPgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8C2F692009C; Wed, 24 Jun 2026 06:23:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 852C692009B;
	Wed, 24 Jun 2026 05:23:54 +0100 (BST)
Date: Wed, 24 Jun 2026 05:23:54 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Sean Christopherson <seanjc@google.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
Subject: Re: [PATCH v2 2/6] KVM: x86: Prioritize DR7.GD #DB over #GP due to
 illegal DR6/7 value
In-Reply-To: <aig9ckd1f6oZaYgA@google.com>
Message-ID: <alpine.DEB.2.21.2606240442420.58268@angie.orcam.me.uk>
References: <20260603230718.1733483-1-seanjc@google.com> <20260603230718.1733483-3-seanjc@google.com> <alpine.DEB.2.21.2606040048520.22659@angie.orcam.me.uk> <aig9ckd1f6oZaYgA@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 9 Jun 2026, Sean Christopherson wrote:

> > > When emulating a MOV DR, specifically a write to DR6 or DR7, treat a #DB
> > > due to DR7.GD (General Detect) as higher priority than a #GP due to an
> > > illegal value.  While neither Intel's SDM nor AMD's APM says anything
> > > about the relative priority, empirical testing on Intel and AMD shows that
> > > the #DB has higher priority.  
> > 
> >  It has to.  
> 
> Not super strictly speaking though, because ucode _could_ check for an illegal
> value before enforcing DR7.GD.

 Sure, hardware can do anything insane, but that defeats the purpose of 
DR7.GD.  When the debug register stack is under debug firmware control one 
can reasonably expect it is up to the firmware how to emulate access and 
interpretation could potentially be given to these otherwise invalid bit 
patterns (semihosting comes up to mind).

> OMG, Intel and AMD don't even behave the same.  I _was_ going to say that
> "obviously the CPL #GP check has priority over DR7.GD", but on Intel the DR7.GD
> #DB has priority over the CPL check, whereas on AMD the CPL check has priority.
> 
> Which actually proves my point: hardware/ucode doesn't _have to_ treat DR7.GD
> with the absolute highest priority.

 Sigh, what can I say?  Arguably either approach has its advantages and 
disadvantages from the debug environment implementer's point of view, and 
the Intel interpretation seems more flexible to me: the debug firmware can 
examine conditions and still arrange for #GP to be delivered whereas if 
hardware does that without trapping into SMM, then there's no choice.

 Notice the symmetry with ICEBP/INT1, which always traps into SMM under 
debug firmware control regardless of CPL.

> Ugh, and KVM's emulator doesn't get the priority between the #UD checks and the
> CPL check.  Double ugh, half of the instructions that #GP at CPL>0 don't get the
> priority right.

 No doubt people get confused with all these corner cases; this isn't 
common usage.

> > The primary reason for the existence of DR7.GD is to prevent 
> > software being debugged such as an OS kernel from clobbering the debug 
> > register state when executed under the control of an ICE or a JTAG (XDP) 
> > debug probe.  Under these circumstances #GP remains an ordinary exception 
> > routed via the IDT to a handler provided by the OS, however #DB traps into 
> > the ICE or SMM mode instead and the OS handler is never reached.
> > 
> >  This is also the reason why DR7.GD gets cleared at the same time -- so
> > that the debug firmware can then access the debug state rather than making 
> > the exception trigger again -- and for the existence of the ICEBP aka INT1 
> > instruction -- so that #DB can be triggered and control regained by the 
> > debug firmware via a software breakpoint, since the number of hardware 
> > breakpoints is limited (and #BP is an ordinary exception).
> > 
> >  It's unsurprising that the priority of these exceptions is not documented 
> > well in the processor developer's manuals given that x86 hardware debug 
> > features remain vaguely documented overall in public resources.  Though I 
> > note the Intel wording for the GD bit is "[it] causes a debug exception to 
> > be generated prior to any MOV instruction that accesses a debug register." 
> 
> Define "accesses" though.  MOV DR at CPL>0 definitely isn't going to access
> anything, and so that statement still holds true if the #GP due to CPL>0 had higher
> priority, as there wouldn't be any DR access to prevent.

 Fair enough, but please see my observation above as to usability.

  Maciej

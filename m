Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7702BE621
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809254; cv=none; b=WSIb0KMFzUL7/T6ss3+Hzi437EDHlJv2dJP3DwW4qcsojCJvq7tjJkF/adCEApWVNqCgPFWEWMERR0Q2WeDq6nw19SO9BXiBN5v45Ic0h/j5lqBT02CcPawWJOWx7Uok7Ihd/Ub+7g31OeCYoRXkAMpZPIGvb/IdFi4iArIxI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809254; c=relaxed/simple;
	bh=5iih2ZG+vdquRourwEyHD2wC82cNcGWw6hfAqUBMCgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gVXgPXb3mMf8UO3ArvBVK/bF7TuY2iGd6+wEuod5SJlp9yBYMRnYgAeiXQqGY2RZRbHmTpmIGmzfq2KxZeYV30b80rdM3/9lugxX4GLAe/aiyeoYFplpC1oWVJnV9u5kYh4otPhHj8F/KJYjApl9w78pDUE5NKwV/xTZoy7ROh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDjJwKEU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDjJwKEU"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa6c3a77cso2318081b3a.3
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 15:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776809252; x=1777414052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMoXpXbVl083KnyFi3yDRGSD7VnR/sMx65KMxbedEx8=;
        b=hDjJwKEUInjAEHMO1wDqC5BDQ8TFXlWfJ5pwcskJHtnn6ob3fhBPqjJc2aofGV4KAM
         yANYQuKlBE4ousoHOuXEhFn68bUZb4KXHY9oxkuFpUg0wzyxml+6rhXxrq5fv9Hgr+Id
         EMpwgduSSzKcgp8kuPaER/HtFIm3vlvmHev5V1B9gTFQ6FvJVEcFpILJCzJNq2evEeJP
         5ljs81hD8bGcr5ulPQhYG/Vdh7fqYRf/IgGHTVUHFL0AUzPg0ui2U6VY3P35hfP0G5Nc
         G0ZruP6G/u/5UVC7BZouLC2LKWnt3QSktZEbfr7OhsBqlyEZblUBOyeloBb1heMaCIOU
         h2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809252; x=1777414052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMoXpXbVl083KnyFi3yDRGSD7VnR/sMx65KMxbedEx8=;
        b=F/0vCbafoLX9WGHXnADSfQggMpPfEzx5KtttRDksNeRqh6opnhxuVn19qxOs9Y4ENx
         /1IL1Xo0+SI/PqaU5cp2WvPNLphyQIVhZRrfSeJWhEJH7ar9dIuRIBDaJCqe3ReL+fyp
         Qq9tAEuAWsa8UzfGlVOGCUq8z7Zek2an443LuJEm3M9q0tknBuXXuPquQJmM5zBu5EgP
         4xeyS2ccApwbnJd6lkoe2Je5hUfsePOGmSnpVtFnQwdo4EZXE7TNxOEImsyjX627nfiU
         02PpMpb0GNZ2QeSQtpK3yGr2Eda5HC7R+EzlPkJi6eWyTfGgQLkUlc+2cAe/aOXw8pF0
         AuZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tcc1j4/NqeTw1SxqABshfoRy8RSTvWv6bfKC1zh4nBm7BCTbdYR3JYiTBVhhFU7EY1Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5fdj4Tv6UYJs5x2qjB8egXB2t59gVF1sCrRKh/kE2e5DVfdb
	X3DEDmX8QoL23+mVbOA8J+dQh0agsUb0tdNRwn1knxVuAckAgvP0j2p5AItPpipbIhD0V+6o1ed
	/Dl9JaA==
X-Received: from pffv19.prod.google.com ([2002:aa7:8093:0:b0:82f:5d4f:734f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6c8d:b0:82c:7f08:8826
 with SMTP id d2e1a72fcca58-82f8c8b3dbemr17929987b3a.17.1776809251904; Tue, 21
 Apr 2026 15:07:31 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:07:30 -0700
In-Reply-To: <87zf2w9e78.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com> <87zf2w9e78.ffs@tglx>
Message-ID: <aef1ItiR3bEYDkWH@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Thomas Gleixner wrote:
> On Tue, Apr 21 2026 at 11:55, Sean Christopherson wrote:
> > On Tue, Apr 21, 2026, Thomas Gleixner wrote:
> >> >> Looks like. It will take the interrupt after local_irq_enable().
> > VM_EXIT_ACK_INTR_ON_EXIT also provides symmetry with Intel's handing of NMIs, as
> > NMIs are unconditionally "acked" on VM-Exit.
> 
> What's the exact point you are trying to make?

That no matter what we do for IRQs, KVM needs a direct call into the kernel to
handle an asynchronous event that arrived in the past.

> The symmetry is a cosmetic nice to have bullet point, but neither a
> functional nor a correctness requirement. The fact that hardware people
> provided something which looks "useful" at the first glance does not
> make it so.
> 
> > Even if performance is "fine", changing decades of fundamental KVM behavior is
> > terrifying.
> 
> It worked perfectly fine before this was introduced in commit
> a547c6db4d2f ("KVM: VMX: Enable acknowledge interupt on vmexit") in 2013.

Yes, but that configuration hasn't been tested (by KVM) on any CPU released in
the last decade+.  That's what scares me.  Do I think it's at all likely that
there's a lurking ucode bug?  No.  But the risk vs. reward isn't there for me.

But as Paolo pointed out, the "killer" feature gated by ACK-on-exit is posted
interrupts, and _that_ provides a massive performance win.

> > IMO, that's the way to go.  But instead of exporting __hrtimer_rearm_deferred(),
> > move vmx_do_nmi_irqoff() and vmx_do_interrupt_irqoff() into core kernel entry code
> 
> Surely not into core kernel entry code as this is x86 specific hackery.

Oh come on.  I have a hard time believing that you really truly thought that's
what I was suggesting.

> > (along with the assembly glue), and then EXPORT_SYMBOL_FOR_KVM those.  It'd mean
> > some extra surgery, e.g. to provide an equivalent to KVM's IDT lookup:
> >
> > 	gate_offset((gate_desc *)host_idt_base + vector)
> >
> > But I suspect it would be a big net positive in the end.i  E.g. the entry code
> > would *know* it's dealing with a direct call from KVM, and thus shouldn't need
> > to play pt_regs games.
> 
> As this is x86 specific the generic entry code knows absolutely nothing
> unless there is a magic indicator like PeterZ's hack or yet another
> duplicated version of the irqentry_exit() code just to accomodate KVM
> for handwaving reasons.
> 
> As Peter and myself pointed out before this will also not solve the
> problem that due to that KVM won't be able to benefit from the recent
> hrtimer/hrtick improvements on VMX(TDX) hosts.

Sorry, you lost me here.  What's the TDX angle?  Or are you just saying that VMX
is currently hosed with the deferred rearm?

> To be entirely clear: We are not going to disable HRTICK for the benefit
> of this dubious "decades old performance" hack.

No one suggested that.

> > Actually, even better would be to bury the FRED vs. not-FRED details in entry
> > code.  E.g. on the KVM invocation side, we could get to something like the below,
> > and I'm pretty sure _reduce_ the number of for-KVM exports in the
> > process.
> 
> That's an orthogonal issue. The problem at hand is independent of FRED
> or not-FRED as both end up providing a pt_regs frame with eflags.IF = 0.

Eh, not if it gives us a clean, maintable solution for for the problem.

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2614F2D23B9
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808159; cv=none; b=btDrGUyrgtZhmyTqdTCfXIAQm6SLdSmfWyf3PIsU1Kg1TwJfzIvbCzZh0kWBSI82VchamK5/SCQfTzmpzSMn8k7pJoz0ik/K9DSOZznRtFy83cQ1P6QrUT+gbR2N0OVSQmZf2LcKu/YE1mD2ZW1n5rwmQNm9JPeZJDT6p3o97fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808159; c=relaxed/simple;
	bh=jweytZp/wgEfOOVr2z3gzawyHMwlC4m7HAeJWhLPMRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6Y8yXQ/A7H5vZeo4oki69RU8HFtcrGF+fCx8BB6EidQTPx1WgOjij4eqvR8uUvBAsV46+YnWgkXzdn0Jvg2w3gGGfncFb/92is8YgvYcBfcCNRgoKiCu6xqE7jwEH1ZkDwhY1GHlEwDBNk4xrfOg4w8pvqXNWuB9HRpiXgUdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMBSuHxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMBSuHxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA72C2BCB4;
	Tue, 21 Apr 2026 21:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776808158;
	bh=jweytZp/wgEfOOVr2z3gzawyHMwlC4m7HAeJWhLPMRU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eMBSuHxSx90HRb57mBndb6vCbYha6nXoXH7FIAFpsM0s5CiqMk+3quZE1eejaSlFO
	 AEdpLNbVQ9dTjJB0lys3Fx91402zvRSRbcmqIr5JabFuj7W6dLxVgwF7Yki/RPQNaU
	 09zXtoX0tX3Ih67rKpnXXHs0pmBaPvqREbDZXOA/xoQ4yVNh6hGQVkIWSe4BeiUKUQ
	 E6i9Cp3xLKS6CXh/KU5Ac4CsGOcNbKmEpK9HuajhlxhgB3yqNNKLqLkz0AnLdH79Am
	 o7GY0mA9L0gXrkF4Rn8ObHEFRDgky6N19q4R5lZ1uLSGTJwYn4m7WJn5n7SeODtQIE
	 5jesbXoJUgaaA==
From: Thomas Gleixner <tglx@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, Vishal L
 Verma <vishal.l.verma@intel.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo
 Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <aefIJR_FcEeP-fcS@google.com>
References: <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com>
Date: Tue, 21 Apr 2026 23:49:15 +0200
Message-ID: <87zf2w9e78.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 11:55, Sean Christopherson wrote:
> On Tue, Apr 21, 2026, Thomas Gleixner wrote:
>> >> Looks like. It will take the interrupt after local_irq_enable().
>> >
>> > FWIW, VMX should work just like SVM if we clear VM_EXIT_ACK_INTR_ON_EXIT.
>
> Hell no.

I knew for sure that someone from the KVM camp would cry murder :)

>> I know. What's the point of that VM_EXIT_ACK_INTR_ON_EXIT exercise? Is
>> there any performance benefit or is it just used because it's there?
>
> There are performance benefits, and it preserves ordering: the first IRQ that's
> serviced by the host is guaranteed to be _the_ IRQ that triggered the VM-Exit.
> E.g. with AMD's approach, any IRQs that arrive between the VM-Exit and STI (which
> is a pretty big swath of code) could be serviced before the IRQ that triggered
> the exit, depending on priority.

I might eventually buy the performance benefit, but the ordering is not
interesting at all. That's a pure virt-cult fallacy to believe that it
matters. Why?

Look at this bare metal scenario with two interrupts A and B where B has
a higher priority than A:

     cli
     interrupt A is raised in the APIC
     tons of code
     interrupt B is raised in the APIC
     sti
     handle(B)
     handle(A)

or
     cli
     interrupt A is raised in the APIC
     tons of code
     sti
     handle(A)
        interrupt B is raised in the APIC
     handle(B)

It's completely uninteresting which one is handled first. Otherwise this
'handle it directly' approach in VMX would not be correct at all.

The only valid argument here is performance and I'm not really convinced
that it actually matters given the amount of other nonsense which has to
be done on a VMEXIT nowadays.

The point is that the early handling only affects the actual response
time to the interrupt itself, but it does not affect the response time
to anything the interrupt might trigger which requires interrupt and/or
preemption enabled context:

      VMENTER
 -> Host interrupt
      VMEXIT
      handle_early()
        irqentry_enter()
          irq_enter();
          handle();

          irq_exit();        // Cannot handle soft interrupts because IF = 0

        irqentry_exit();     // Cannot handle preemption because IF = 0
 
I understand that this is optimizing for the case where neither soft
interrupts nor preemption has to be handled, but all I have seen so far
is handwaving about the actual performance benefits. See below.

> VM_EXIT_ACK_INTR_ON_EXIT also provides symmetry with Intel's handing of NMIs, as
> NMIs are unconditionally "acked" on VM-Exit.

What's the exact point you are trying to make?

The symmetry is a cosmetic nice to have bullet point, but neither a
functional nor a correctness requirement. The fact that hardware people
provided something which looks "useful" at the first glance does not
make it so.

> Even if performance is "fine", changing decades of fundamental KVM behavior is
> terrifying.

It worked perfectly fine before this was introduced in commit
a547c6db4d2f ("KVM: VMX: Enable acknowledge interupt on vmexit") in 2013.

If you decrypt that commit message and read the patch then you'll notice
that back then this issue would not have happened at all because the
register frame had IF set.

This got changed by f2485b3e0c6c ("KVM: x86: use guest_exit_irqoff") in
June 2016 to save an completely unspecified amount of 'few cycles'.

So much for decades and for useful changelogs which actually prove that
something has a substantial benefit.

Given the amount of changes since then it would be really interesting to
see actual numbers for the benefit of VM_EXIT_ACK_INTR_ON_EXIT before we
end up with more KVM/VIRT specific oddities all over the place.

I'm more than mildly amused that you are terrified by the thought of
reverting back to something which is known _and_ guaranteed to work
while at the same time you are willing to accept any shortcut in the so
fundamental KVM behavior to gain a cycle for the price that everything
else has to adjust to the semantically broken view of KVM.

There is plenty of proof in the git history that KVM follows the
performance first, correctness later principle and I personally have
wasted a lot of _my_ precious time due to that since the day KVM was
shoved into the kernel, which was actually almost _two_ decades ago.

> Pulling in an earlier idea:
>
>  : Now for VMX, that hrtimer_rearm_deferred() call should really go into
>  : handle_external_interrupt_irqoff(), which in turn requires to export
>  : __hrtimer_rearm_deferred().
>
> IMO, that's the way to go.  But instead of exporting __hrtimer_rearm_deferred(),
> move vmx_do_nmi_irqoff() and vmx_do_interrupt_irqoff() into core kernel entry code

Surely not into core kernel entry code as this is x86 specific hackery.

> (along with the assembly glue), and then EXPORT_SYMBOL_FOR_KVM those.  It'd mean
> some extra surgery, e.g. to provide an equivalent to KVM's IDT lookup:
>
> 	gate_offset((gate_desc *)host_idt_base + vector)
>
> But I suspect it would be a big net positive in the end.i  E.g. the entry code
> would *know* it's dealing with a direct call from KVM, and thus shouldn't need
> to play pt_regs games.

As this is x86 specific the generic entry code knows absolutely nothing
unless there is a magic indicator like PeterZ's hack or yet another
duplicated version of the irqentry_exit() code just to accomodate KVM
for handwaving reasons.

As Peter and myself pointed out before this will also not solve the
problem that due to that KVM won't be able to benefit from the recent
hrtimer/hrtick improvements on VMX(TDX) hosts.

To be entirely clear: We are not going to disable HRTICK for the benefit
of this dubious "decades old performance" hack.

> Actually, even better would be to bury the FRED vs. not-FRED details in entry
> code.  E.g. on the KVM invocation side, we could get to something like the below,
> and I'm pretty sure _reduce_ the number of for-KVM exports in the
> process.

That's an orthogonal issue. The problem at hand is independent of FRED
or not-FRED as both end up providing a pt_regs frame with eflags.IF = 0.

For the short term fix, which is required no matter what, checking
irq_regs in hrtimer_interrupt_rearm() is not the worst solution as it
covers _all_ not yet unearthed issues which are nicely hidden in some
dusty corners of architecture specific KVM optimizations and will only
come out around 7.1-rc7 or later when people actually can be bothered to
test stuff...

I just booted a big machine with that patch applied. get_irq_regs() and
the regs_irqs_disabled() check are barely visible in perf because the
cache line is 99% of the time hot and as it is strictly per CPU there is
no contention at all. The only case where it shows up is when there is a
massive amount of hrtimers to expire at the same time with D-cache
consuming callbacks. But in that case the extra cache miss of
get_irq_regs() is just in the noise and not really relevant.

So far that deferred reprogram mechanism seems to be the only known
mechanism which relies on the irqentry_exit() pt_regs::flags::IF state
being correct, but in the long run that's not a sustainable solution.

You really want to come up with real numbers which prove the performance
benefit to justify the extra complexity of this.

Thanks,

        tglx

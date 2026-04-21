Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B237269A
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 18:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797737; cv=none; b=Mi7De6EEwW60mLdzwT5H1HVL+viejLLRjRJytlWbVvm/ZnMHqLEWkxwoMiwcaTfoaSwWxex+5Jq2Ig6BLezmaAO3zFKec4LtMKaR/plEtroDwfzKzgdXkCcE4cO8SJucQfkVMkL+OSowgrpKMHXYgtbvAjhl8FMKgAhYxAYLkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797737; c=relaxed/simple;
	bh=qVvBvOQqKGEzLCHyOgMcDhSNkB14NQcii4Q5A3oGYnw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqoThke4PLn+RlFm6Hde9xzY0VVBxhaX2GxEN7f43FiSM8JYBEVreyYQtuPKfoQQJt9FEuM9CzTl3MFF1AUBchZ8WvjadAP0kYJ6xVqAA37sxj2oJ7Y9Q5d8+LIOfrUFBm2QA054TmLGd8nyGjRRmVuFcW15zzUyqn21Srt+a1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M89eztci; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M89eztci"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ec948174so43132315ad.0
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 11:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776797735; x=1777402535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLWlLX522r0XZtMZZCqXdxFCNg/wdnKZiwaXTjpO9Mk=;
        b=M89eztciHAIYQ9nLycKyszOPuxnYoFK041Ff8SU7zZHYQFjpTjxNDENssrqWPfVjkE
         ZRFdqrLQVxxw0jYS0vyAXqf/VFwGC723RT6V4KvU9LrfYLxkwYTSDcL2UX2q/iSmKdPw
         VhdlcEWJWf94tztWPrwQtEyZT0VpeHXNZcCfUfhNcVU/1ihIQWKwu9ym6Z4XN8UORz3x
         zi77yedRV8IOdWYlFLCcQ1GErmlM6aMAZSDOM1FYwg0g4wNUDHYJIOEqRkpVfj8UOAie
         UVvjNvTX+Pp1IhZCTKZFLiusDGbSRO+LE/9YEIysSVyQ3H9cJCxo1h6ZR0gXfYxyqeCw
         rWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776797735; x=1777402535;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZLWlLX522r0XZtMZZCqXdxFCNg/wdnKZiwaXTjpO9Mk=;
        b=Tpv1hNl3BXQgCDRw9sBdnCABxhfRWy7NqKzy12mq7HOeKYEKLD8rvOYbBZPaZK6fV6
         4MmZ/HTIlrHtj94GlfsHNQJWwuXHAwymQX/n8Mwgh+PwcsFxMifAL98Bg6BYsbvr6nb+
         cMUTdf1rdGpU4ouhWm3wlK7tskP27Ah3C8QEoWSloonI9+kN2WgD2LDIR7cYjsecfN5u
         TRTgwPssWyf6z/8vBHD0Oz6spKfDJOC7UYQoVVA9GXh6I7Zqgy2q89S/wRJ3pDSPTUT5
         4EpIpfTZU7J3mPQJkRrM8jXeVYi5Odl1YhpsAlztx5qC2CZ3amE41m9b4CgO++cr3XsQ
         EeiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Kswa/Uj71EAnH10mT4smSb4R9cW+oqI2ayw9nMdq0Py4ABbJsXQYBjRY4JLjTA0EHfdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJU/NTpTRpVvqMlnweJaPMEhcpSLRQAITVW1aTaAPgaAr7iPRs
	RNzHiE6E+Fo1Kz8WQRL7pDNw7E1E4GHfNEKaPPFUQ7slcGT1aAma4ZN9qcJMJTjoRDZiIhzIp/Z
	SURrJRw==
X-Received: from plbkg4.prod.google.com ([2002:a17:903:604:b0:2b4:5f51:534e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b30:b0:2b4:586d:2e5c
 with SMTP id d9443c01a7336-2b5f9ecbaa1mr193571915ad.2.1776797735374; Tue, 21
 Apr 2026 11:55:35 -0700 (PDT)
Date: Tue, 21 Apr 2026 11:55:33 -0700
In-Reply-To: <878qagb20x.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87mryxekxy.ffs@tglx> <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx> <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx> <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx>
Message-ID: <aefIJR_FcEeP-fcS@google.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, Thomas Gleixner wrote:
> On Tue, Apr 21 2026 at 10:20, Jim Mattson wrote:
> > On Tue, Apr 21, 2026 at 10:14=E2=80=AFAM Thomas Gleixner <tglx@kernel.o=
rg> wrote:
> >>
> >> On Tue, Apr 21 2026 at 13:49, Peter Zijlstra wrote:
> >> > On Tue, Apr 21, 2026 at 01:34:07PM +0200, Peter Zijlstra wrote:
> >> >> > > > KVM invokes regular interrupts with pt_regs which have interr=
upts
> >> >> > > > disabled. That's correct from the KVM point of view, but comp=
letely
> >> >> > > > violates the obviously correct expectations of the interrupt =
entry/exit
> >> >> > > > code.
> >> >> > >
> >> >> > > Mooo :-(
> >> >>
> >> >> Also, is this a x86/KVM 'special' or is this true for all arch/KVM =
that
> >> >> use GENERIC_ENTRY?
> >> >
> >> > Should we not make asm_fred_entry_from_kvm()/VMX_DO_EVENT_IRQOFF fix=
 IF
> >> > on the fake frame instead? We know it will enable IRQs after doing
> >> > handle_exit_irqoff() in vcpu_enter_guest().
> >>
> >> Doesn't work :)
> >>
> >> > SVM does not seem affected with this particular insanity.
> >>
> >> Looks like. It will take the interrupt after local_irq_enable().
> >
> > FWIW, VMX should work just like SVM if we clear VM_EXIT_ACK_INTR_ON_EXI=
T.

Hell no.

> I know. What's the point of that VM_EXIT_ACK_INTR_ON_EXIT exercise? Is
> there any performance benefit or is it just used because it's there?

There are performance benefits, and it preserves ordering: the first IRQ th=
at's
serviced by the host is guaranteed to be _the_ IRQ that triggered the VM-Ex=
it.
E.g. with AMD's approach, any IRQs that arrive between the VM-Exit and STI =
(which
is a pretty big swath of code) could be serviced before the IRQ that trigge=
red
the exit, depending on priority.

VM_EXIT_ACK_INTR_ON_EXIT also provides symmetry with Intel's handing of NMI=
s, as
NMIs are unconditionally "acked" on VM-Exit.

Even if performance is "fine", changing decades of fundamental KVM behavior=
 is
terrifying.

Pulling in an earlier idea:

 : Now for VMX, that hrtimer_rearm_deferred() call should really go into
 : handle_external_interrupt_irqoff(), which in turn requires to export
 : __hrtimer_rearm_deferred().

IMO, that's the way to go.  But instead of exporting __hrtimer_rearm_deferr=
ed(),
move vmx_do_nmi_irqoff() and vmx_do_interrupt_irqoff() into core kernel ent=
ry code
(along with the assembly glue), and then EXPORT_SYMBOL_FOR_KVM those.  It'd=
 mean
some extra surgery, e.g. to provide an equivalent to KVM's IDT lookup:

	gate_offset((gate_desc *)host_idt_base + vector)

But I suspect it would be a big net positive in the end.i  E.g. the entry c=
ode
would *know* it's dealing with a direct call from KVM, and thus shouldn't n=
eed
to play pt_regs games.

Actually, even better would be to bury the FRED vs. not-FRED details in ent=
ry
code.  E.g. on the KVM invocation side, we could get to something like the =
below,
and I'm pretty sure _reduce_ the number of for-KVM exports in the process.

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a29896a9ef14..f6f5c124ed3b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7127,17 +7127,9 @@ static void handle_external_interrupt_irqoff(struct =
kvm_vcpu *vcpu,
            "unexpected VM-Exit interrupt info: 0x%x", intr_info))
                return;
=20
-       /*
-        * Invoke the kernel's IRQ handler for the vector.  Use the FRED pa=
th
-        * when it's available even if FRED isn't fully enabled, e.g. even =
if
-        * FRED isn't supported in hardware, in order to avoid the indirect
-        * CALL in the non-FRED path.
-        */
+       /* For the IRQ to the core kernel for processing. */
        kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ);
-       if (IS_ENABLED(CONFIG_X86_FRED))
-               fred_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
-       else
-               vmx_do_interrupt_irqoff(gate_offset((gate_desc *)host_idt_b=
ase + vector));
+       x86_entry_from_kvm(EVENT_TYPE_EXTINT, vector);
        kvm_after_interrupt(vcpu);
=20
        vcpu->arch.at_instruction_boundary =3D true;
@@ -7447,10 +7439,7 @@ noinstr void vmx_handle_nmi(struct kvm_vcpu *vcpu)
                return;
=20
        kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
-       if (cpu_feature_enabled(X86_FEATURE_FRED))
-               fred_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
-       else
-               vmx_do_nmi_irqoff();
+       x86_entry_from_kvm(EVENT_TYPE_NMI, NMI_VECTOR);
        kvm_after_interrupt(vcpu);
 }

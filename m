Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EB18DB2A
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823815; cv=none; b=gFZc7Doynn8kXC3raZMw3h581v60q50q8Ylf8RkASuboctYM3lIW49/HzNPuHp9K2Bd6jAm2g9OQL7dsO4+yDcP2ApO0hB+5n5bpi+xhnAcbZhb5mK+rZRh16UZgscYtqm+nGmpbPCZ66SsBzKp/VB48vxUjneeCy91D5twHqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823815; c=relaxed/simple;
	bh=jYlrGVJpPLE98JpY9/Hqo/C9pk1MPZ6T8MXx+WrhBzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dz2w5VtOXfwT7PsQgnZXR2iBjUUgIoymUkbbGQuTqoprz7YxkctkN9CNRYYFo5F1kcDB5AWHcKwbdWJrqJeTi7cAQ1xBoiT/mv8b+4Ei/11uDQpKxp4iUvgF7+lsJAJsP2p5TmlelWg5cNwvzVMU06bo/JgO3F4AZ+UyZg8Epg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpc+jIW4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpc+jIW4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AFA5C2BCB0;
	Wed, 22 Apr 2026 02:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776823814;
	bh=jYlrGVJpPLE98JpY9/Hqo/C9pk1MPZ6T8MXx+WrhBzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cpc+jIW4v8UAwvZlqYay3OrYp7lT8TJPtCtlumLo/VQPwlR5QwBv+LxiTIj6pnGzY
	 MSzl1tfdKozPmgdQJMYJNjN8OyzXkJooV5rutEecKiCS111T7dmyKdtXE0ST30Z/y2
	 XoyZYQgAI+D7O43V2qG8NQSGKKSSox7wHoczQltfi3aLYZceD3ETELfrZquzGM5an/
	 +mI7JahUEipTLOGnMM8GdDiI8QUDgmlp7zzxVD1AuMx26xUnxryVvhvGA1bqD69AEw
	 DS0evmBTPLKRmn21ILB2uVbKR1q1FFOb92KqkDBbAmr0BsxqULOvziMu2pyVm84OD2
	 w/wCuxfo/EjnA==
From: Thomas Gleixner <tglx@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, Jim Mattson
 <jmattson@google.com>, Peter Zijlstra <peterz@infradead.org>, Binbin Wu
 <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>,
 kvm <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>,
 Binbin Wu <binbin.wu@intel.com>, the arch/x86 maintainers
 <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <CABgObfb7Yy5Q3E2Boy_H4a0F3GodDOr1Z_Sw0BzdfvOmagcRnA@mail.gmail.com>
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
 <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
 <87tst49bgt.ffs@tglx>
 <CABgObfb7Yy5Q3E2Boy_H4a0F3GodDOr1Z_Sw0BzdfvOmagcRnA@mail.gmail.com>
Date: Wed, 22 Apr 2026 04:10:11 +0200
Message-ID: <87o6jbagos.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22 2026 at 00:15, Paolo Bonzini wrote:
> On Tue, Apr 21, 2026 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@kernel.org=
> wrote:
>> On Tue, Apr 21 2026 at 21:39, Paolo Bonzini wrote:
>> > ... it's not decades, ack on VM exit is actually relatively recent (10
>> > years out 20 :)). The reason why it was introduced is another killer
>> > for the idea, though. Posted interrupts require it, for some reason
>> > only known to Intel.
>>
>> That's yet another attempt to provide an halfways decent argument, but
>> as anything else related to KVM/VIRT it is neither documented nor proven
>> to be true.
>
> SDM, "27.2.1 Checks on VMX Controls", under "VM-Execution Control Fields":
>
> If the =E2=80=9Cprocess posted interrupts=E2=80=9D VM-execution control i=
s 1, the
> following must be true: [...]
> =E2=80=94 The =E2=80=9Cacknowledge interrupt on exit=E2=80=9D VM-exit con=
trol is 1.
>
> I grant you the "not documented" (not cross referenced to the manual
> in commit 01e439be775) part, but "not proven to be true"? Neither I
> nor my predecessors are *that* clueless.

I did not claim at all that you or your predecessors are clueless, but
do I really have to do all the homework which you and them obviously
failed to do?

And even now in this discussion you came only forth with a real
explanation after I told you that it's nowhere documented in the kernel
code or the related changelogs.

Still now you tell me that 01e439be775 is the key to all of this, which
is completely irrelevant because the commit which started to violate the
core kernel code semantics and expectations is f2485b3e0c6c ("KVM: x86:
use guest_exit_irqoff") which happened _three_ years _after_ 01e439be775
introduced the detection of posted interrupts.

Do you really expect me to connect the useless changelog of f2485b3e0c6c
to the posted interrupts restrictions which are not mentioned anywhere?

> Is reading the manual enough?

Are you seriously asking me to read the manual to figure out why some
completely undocumented code exists? And then deduce why that code
violates basic principles of the core code assumptions which have been
there way _before_ any of this x86 virtualization gunk even existed on a
napkin sketch?

You are putting the cart before the horse.

KVM is violating basic principles without giving any clue to those who
try to keep them maintained. Neither in changelogs nor in code nor in
comments.

Please don't misunderstand me. I'm not trying to fingerpoint here. I'm
trying to understand how we got into this mess and what's the proper way
out of it.

At least after tons of useless wasted cycles/emails I know now that
there seems to be some real existing hardware constraint.

As a consequence I'll go and use the irq_regs workaround in
hrtimer_interrupt_rearm() for now. It's not pretty, but as I pointed out
before, it _is_ covering _all_ (even not yet discovered) KVM/VIRT
induced violations of core code semantics and expectations in one go and
it is pretty much performance neutral for the price that the KVM/VMX
host side can't take advantage of it.

If KVM/VMX want's to benefit from the semantically correct
hrtimer/HRTICK related core code improvements, then please post patches
which might hit the 7.2 merge window eventually in case they make sense
and most importantly are semantically correct.

Thanks,

        tglx



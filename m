Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8566346E51
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811702; cv=none; b=ZDsV+gB/Q5ldnopofjpdqmSxvHtSl0A6cF3SKF7wauefgoArckZCwQk8dzZrBMgehAT/TkPDcqqOzNVURiIqTbGJ1c9Y1ZcAPJAEZa06g6LdDlvLctnXekAzG7MCmXokEjJ6k9tW5/iWlP4RYmb3aGjv8hv+6GjZEWtehS3iRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811702; c=relaxed/simple;
	bh=/s1jfJRIIohBJ62f5TPUGLOcXaTbCEOIFACM7U/ox0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LJNsCSuD5ncrY6kgKI1buUcEcj3jXRnvSCSrBwJiVATeV5Jk3F7yI88/bhkyMqMJVcLsa+w3IUTY6eNfQhqxGXo/6wPIVHaxRTirxK5H9Wi8pm8pTH+CAlgI8lHytdbYTgqVEDaPvZQxMWZKxf3wLwL7h5QbP1FSgv+s2FgiPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFrGKpak; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFrGKpak"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4A1C2BCB0;
	Tue, 21 Apr 2026 22:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776811702;
	bh=/s1jfJRIIohBJ62f5TPUGLOcXaTbCEOIFACM7U/ox0g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YFrGKpakS6lkn5/DOZZz1vMOYVtP0COtKDCX5F510HNFl7HnWEwli8jbBnGlhXvU2
	 8okN45Vqt3so+snC99SJz9TpBKAghtFXTtc8iwTzN8hixNbwJpFK2Ppcsk8v1smD9z
	 4joPcBEMZF9h1XH5umvWoBEqhdjyZjaQ83a2MJ+uCUScbC7aBoUyWey82nUyUmt01d
	 8BxaRnvaUFnknEoLks8VtEi2Y++omzH2oTeldMCHqk3QYuPUcLSncfxX0zmSiqVVtA
	 j5Z/KzhG7379avA0YWNqONjb4Qf0PPVXtyxsYpmvxz//6v44vuNxWMyZWkijsAbN1b
	 65y2zRxKHyXaQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra
 <peterz@infradead.org>, Binbin Wu <binbin.wu@linux.intel.com>, Vishal L
 Verma <vishal.l.verma@intel.com>, kvm <kvm@vger.kernel.org>, Rick P
 Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>,
 the arch/x86 maintainers <x86@kernel.org>, Paolo Bonzini
 <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <CABgObfaNaDYCo_rkkwAnFzKYYe9G9wnz1+yiv0H73CbtE8AXpw@mail.gmail.com>
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
Date: Wed, 22 Apr 2026 00:48:18 +0200
Message-ID: <87tst49bgt.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 21:39, Paolo Bonzini wrote:
> Il mar 21 apr 2026, 19:55 Sean Christopherson <seanjc@google.com> ha scritto:
>> Even if performance is "fine", changing decades of fundamental KVM behavior is
>> terrifying.
>
> ... it's not decades, ack on VM exit is actually relatively recent (10
> years out 20 :)). The reason why it was introduced is another killer
> for the idea, though. Posted interrupts require it, for some reason
> only known to Intel.

That's yet another attempt to provide an halfways decent argument, but
as anything else related to KVM/VIRT it is neither documented nor proven
to be true.

Your claim is just another prove of the KVM handwaving approach as the
change log which introduced this (commit a547c6db4d2f) does not mention
it at all. In fact posted interrupt support came _three_ years after
that and there is exactly _zero_ information about this dependency if I
read the relevant change logs correctly.

Especially commit f2485b3e0c6c ("KVM: x86: use guest_exit_irqoff") which
fundamentally changed the behavior from regs::flags::IF = 1 to
regs::flags::IF = 0 does not mention this at all:

    KVM: x86: use guest_exit_irqoff
    
    This gains a few clock cycles per vmexit.  On Intel there is no need
    anymore to enable the interrupts in vmx_handle_external_intr, since
    we are using the "acknowledge interrupt on exit" feature.  AMD
    needs to do that, and must be careful to avoid the interrupt shadow.

Written and committed by a Paolo Bonzini dude. You might know him
perhaps.

Where exactly is the reference to posted interrupts and how did you or
someone else establish that this hack is a requirement for posted
interrupts in the first place?

Nice try. Try again.

Thanks,

        tglx









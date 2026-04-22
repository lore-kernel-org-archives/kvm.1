Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E41D63F3
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898674; cv=none; b=GawqJ8sjAZkMPEcoQr/nA94Iobzjc8S394odESQ8qi0rSztI4OQKAYM14JMkYBTZmqY39+c4uyIvGgdHz0NvfiNbFctMZmlMXPG2opZYkFsf70Xn7i5KyTn2qNgAL8Umn/tsO1irIqkDIhxjP//JF0Y1lHFidmaK5r6gBbaENb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898674; c=relaxed/simple;
	bh=B1R2c6JNE+zBexpJMRJz+Qzouw1D3PuYiq4d/ZFNdWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gw69KRwSSZT+o02d4zzyyRYod9ZJDf5TTpz9wk67H3qvVr3lnklvFuvQYOQ5XNC9aSQLDVICLPJO5tNrixXt8WBYrr3pgBgs7hyHmWFch88cCoDbrMKp2C/ukmrygmc1aI3OrHJ4vakxnNLOp6ioiHNQbb1dYOPU+uVqqeHpzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctkcKffG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctkcKffG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E2BC2BCB6;
	Wed, 22 Apr 2026 22:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776898673;
	bh=B1R2c6JNE+zBexpJMRJz+Qzouw1D3PuYiq4d/ZFNdWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ctkcKffG5GjIHpVJ8LjLI/c3zsjyXme2CG3cKJY8+wXve4tPQ0XXmKjlsvxCTlyIR
	 sn8dHwsT6JADvEK7hX6S4Y6V+ijVr9obm9awQuWA3hipdA5VfEa2UmVk+QET9ko0i9
	 utJeg7+oXDmxxrZobt/3yCjIz+cyr0jpwpSzMIw+s0pX5bG/jJIoAkQrgnaxUdfzm4
	 XHXmZ2nC8rZ1Zp/2MnKlKmf5ejTcTArXeZvXPYPPyyfSvTaE8IF3FWCMCDXMfTYGF1
	 A+19ZyG5iRjRikDjHbc2RduPxEZ5vCyhSkOcLgH3iKpDdEMtq1A5EudB1IYIofOVDH
	 vVViucEGepM0A==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Sean Christopherson
 <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Binbin Wu
 <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe
 <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
References: <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
 <87cxzsb5n0.ffs@tglx>
 <CALMp9eTeqE4u6ioepVeowRkcNs63DYZTg8og8em12u4FsVWNfw@mail.gmail.com>
 <878qagb20x.ffs@tglx> <aefIJR_FcEeP-fcS@google.com>
 <20260421200620.GK3126523@noisy.programming.kicks-ass.net>
 <aefktNLiS3ur10yD@google.com>
 <20260421210201.GM3126523@noisy.programming.kicks-ass.net>
 <aefvVjTtx22EzMkR@google.com>
 <20260422065542.GN3126523@noisy.programming.kicks-ass.net>
 <20260422074646.GO3126523@noisy.programming.kicks-ass.net>
Date: Thu, 23 Apr 2026 00:57:49 +0200
Message-ID: <87o6ja1u36.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 22 2026 at 09:46, Peter Zijlstra wrote:
> On Wed, Apr 22, 2026 at 08:55:42AM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 21, 2026 at 02:42:46PM -0700, Sean Christopherson wrote:
>> > On Tue, Apr 21, 2026, Peter Zijlstra wrote:
>> > > On Tue, Apr 21, 2026 at 08:57:24PM +0000, Sean Christopherson wrote:
>> > > > This as delta? (I had typed this all up before Peter posted a new verison, so
>> > > > dammit I'm sending it!)
>> > > 
>> > > :-)
>> > > 
>> > > I'll go stare at it in the morning, I'm about to go crash out.
>> > 
>> > New delta against your effective v2, builds all of my configs (which isn't _that_
>> > many, but I think they cover most of the weirder ways to include KVM (or not)).
>> > 
>> > I'll start testing the full thing to try and get early signal on the health.
>> 
>> Oh, re-reading commit 28d11e4548b7, I think this wrecks NMIs. The patch
>> will also use the FRED NMI path and that's not good when running IDT.
>> 
>> I'll go fix that and stick in a few more comments to clarify this magic.
>
> This should probably we at least two patches, one moving the code into
> the x86 core and one adding that hrtimer fix on top. But kept as one for
> now.
>
> Irrespective of the hrtimer fix, I think the initial move into x86 core
> part is a sane move.

I agree.

> +#if IS_ENABLED(CONFIG_KVM_INTEL)
> +/*
> + * On VMX, NMIs and IRQs (as configured by KVM) are acknowledge by hardware as
> + * part of the VM-Exit, i.e. the event itself is consumed as part the VM-Exit.
> + * x86_entry_from_kvm() is invoked by KVM to effectively forward NMIs and IRQs
> + * to the kernel for servicing.  On SVM, a.k.a. AMD, the NMI/IRQ VM-Exit is
> + * purely a signal that an NMI/IRQ is pending, i.e. the event that triggered
> + * the VM-Exit is held pending until it's unblocked in the host.
> + */
> +noinstr void x86_entry_from_kvm(unsigned int event_type, unsigned int vector)
> +{
> +	if (event_type == EVENT_TYPE_EXTINT) {
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * Use FRED dispatch, even when running IDT. The dispatch
> +		 * tables are kept in sync between FRED and IDT, and the FRED
> +		 * dispatch works well with CFI.
> +		 */
> +		fred_entry_from_kvm(event_type, vector);
> +#else
> +		idt_entry_from_kvm(vector);
> +#endif
> +		/*
> +		 * Strictly speaking, only the NMI path requires noinstr.
> +		 */
> +		instrumentation_begin();
> +		/*
> +		 * KVM/VMX will dispatch from IRQ-disabled but for a context
> +		 * that will have IRQs-enabled. This confuses the entry code
> +		 * and it will not have reprogrammed the timer (or do
> +		 * preemption). Minimal fixup for now.

It's sadly the final fixup.

There is no way that KVM can benefit from the deferred rearm mechanism
in case that NEED_RESCHED is set.

That's actually independent of the VMX specific handle_exit_irqoff()
situation, which obviously cannot reschedule.

The other early local_irq_enable/disable dance, which caused you to buy
a new WTF'o'meter, happens with preemption disabled, so the irq exit
code will do the rearm right there.

So be it ....

Thanks,

        tglx

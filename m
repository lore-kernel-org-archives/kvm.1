Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418937B020
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757158; cv=none; b=Odl3ENAXqnqR3ESLJtIF1O6u6TvvjvarKHbpELyvu6kNHwTAglmz4hXKHSJpkuDLQSTx3RfSR3E4PYfzpwDIp5PUY8207FqQcgaN0mjuEZJLx2u4YWFScfEtHzOfNtLYIB9rL6yiWDzjH6kzyq1TRKD2Zdq8thkTgWlSs+8lhNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757158; c=relaxed/simple;
	bh=4IbGy36IosVUSriwz99c2P//S+z90WBxPFyAYswm+tI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gw9eYS8e/Y49fiAjzYWDgJ5+MIoa3JqK5CURcwJHCmnp7XnFZaXAyc7cyYWJr1qru3q5W3eVwYs7HjBx3+aht5UkaNdt49CXeI7KrE18JrOll+KPOHYNIvV1YbpXXhLLWpWqQzIFPvDAWqwZOQ8MbF2jsYyeM709QUIP1QKZzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbWLRf6I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbWLRf6I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79343C2BCB0;
	Tue, 21 Apr 2026 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776757158;
	bh=4IbGy36IosVUSriwz99c2P//S+z90WBxPFyAYswm+tI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hbWLRf6IM+hCXR6PJkhP2cb897NyMROnH5IhbXGx9815B/OiF7lxT8jffe/c2pKjw
	 YGNxRylbgmJWFNILjekVQ+ug+kEyrgrMuZDEaw6APCkw4JlCYSdcFJVHHCKv9DOYlp
	 ZzS8Vmwu3G3nxNLTEX0mlYYqohl6PsOOK+m0wnKFKBI2bxMrQhlOVCkygmef+21zBE
	 AMafA/A7eroWd5fZEL2gLMMiU5k/B5DN6b05/zMZqf2L3WA9/SvClVFtoY3bI0FaLj
	 bdedj+3PAI8KmJDg1gC5nJzFbGgP6kXRGBh+Q8UAXLR/ygvOcT3eHkfOOK60F5S0U6
	 nrwttU4jxIBvw==
From: Thomas Gleixner <tglx@kernel.org>
To: Binbin Wu <binbin.wu@linux.intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, "Wu, Binbin" <binbin.wu@intel.com>,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
Date: Tue, 21 Apr 2026 09:39:14 +0200
Message-ID: <87eck8daot.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 12:51, Binbin Wu wrote:
> On 4/20/2026 11:00 PM, Thomas Gleixner wrote:
>>>  static inline void xfer_to_guest_mode_prepare(void)
>>>  {
>>>         lockdep_assert_irqs_disabled();
>>> +       hrtimer_rearm_deferred();
>>>         tick_nohz_user_enter_prepare();
>> 
>> 
>> This code should never be reached with a rearm pending. Something else
>> went wrong earlier. So while the patch "works" it papers over the
>> underlying problem.
>
> IIUC, the problem might be:
>
> HRTimer -> VMExit:
> [IRQ is disabled]
>     kvm_x86_call(handle_exit_irqoff)(vcpu)
>         vmx_handle_exit_irqoff
>             handle_external_interrupt_irqoff
>                 sysvec_apic_timer_interrupt
>                     irqentry_enter
>                     ...
>                     irqentry_exit
>                         irqentry_exit_to_kernel_mode
>                             if (!regs_irqs_disabled(regs)) //<-- This is false, hrtimer 
>                                 hrtimer_rearm_deferred()         rearm is skipped!
>
>
> This issue is triggered on TDX since TDX can't use preemption timer while normal
> VMX VM uses preemption timer by default.

Kinda.

The issue is that vmx_handle_exit_irqoff() always hands in regs with
regs->flags.X86_EFLAGS_IF == 0. That has absolutely nothing to do with
TDX and the preemption timer.

The patch below solves the problem right there in the exit code, which
is unfortunate as there might be a NEED_RESCHED pending. But that can't
be taken into account as KVM enables interrupts _before_ reaching the
exit work point.

Yet another proof that virt creates more problems than it solves.

Thanks,

        tglx
---
Subject: entry: Enforce hrtimer rearming in the irqentry_exit path
From: Thomas Gleixner <tglx@kernel.org>
Date: Tue, 21 Apr 2026 09:00:52 +0200

irqentry_exit_to_kernel_mode_after_preempt() invokes
hrtimer_rearm_deferred() only when the interrupted context had interrupts
enabled. That's a correct decision because the timer interrupt can only be
delivered in interrupt enabled contexts. The interrupt disabled path is
used by exceptions and traps which never touch the hrtimer mechanics.

So much for the theory, but then there is VIRT which ruins everything.

KVM invokes regular interrupts with pt_regs which have interrupts
disabled. That's correct from the KVM point of view, but completely
violates the obviously correct expectations of the interrupt entry/exit
code.

Cure this by adding a hrtimer_rearm_deferred() invocation into the
interrupted context has interrupt disabled path of
irqentry_exit_to_kernel_mode_after_preempt().

That's unfortunate when there is an actual reschedule pending, but it can't
be avoided because KVM invokes a lot of code and also reenables interrupts
_before_ reaching the point where the reschedule condition is handled. That
can delay the rearming significantly, which in turn can cause artificial
latencies.

Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
Reported-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Closes: https://lore.kernel.org/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com
---
 include/linux/irq-entry-common.h |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -516,6 +516,14 @@ irqentry_exit_to_kernel_mode_after_preem
 		instrumentation_end();
 	} else {
 		/*
+		 * This is sadly required due to KVM, which invokes regular
+		 * interrupt handlers with interrupt disabled state in @regs.
+		 */
+		instrumentation_begin();
+		hrtimer_rearm_deferred();
+		instrumentation_end();
+
+		/*
 		 * IRQ flags state is correct already. Just tell RCU if it
 		 * was not watching on entry.
 		 */

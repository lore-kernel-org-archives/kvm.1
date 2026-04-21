Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC23876B0
	for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791482; cv=none; b=AUVbRSuMChk9xvmDHm+OQWucWVSBL4IUfGvLAfj1JeoYoCqYqT2OWM8MpmNtxeFOJyVAuopwW+WZ+n3j23FE0IBQqPVOP//exfr3yHS9je2AcZK8WdFCr13OPpKcb3OwohRj6TOHc+dBYOIigl5QLCkTE1SC6MFEiscPYXJkAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791482; c=relaxed/simple;
	bh=cQ3QmS39zsJclVNW/8SGXVmQ05E/zjnjKtIv60q0mjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a2Vistary0o4g0V48rgjcF7pPeTRbQZjHYlI66gr1Wi+6fJ6EZw8qTBq/TiTDNaz7TVdfrRA3cXpxh2S27sMeRRz5GIZRHohQ1c5kCKJIigQfrvqXVibJ69QXeHRId8fMlYKiDds8PVCcn+WtNMhbAoddYPfcf6FFe+238eGYPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsIWyvNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsIWyvNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085D9C2BCB7;
	Tue, 21 Apr 2026 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776791481;
	bh=cQ3QmS39zsJclVNW/8SGXVmQ05E/zjnjKtIv60q0mjo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FsIWyvNvRbrdXrGI5W5s8+Vp07QL/0gXi0yxybVQuJSTSARaO2g+LkUvARdZ6V9g2
	 WGBU+wfyp2x+ipVWIkvxiKMOYJqKufyrTVrRVFh/mnylPjxFOXTIXf5CAyGDC3qYjc
	 /i8MNwD7qSW/ufIMQH/9zqI0DgTSmLNAmA7WnZk/tjSKZWMnPkwiU38A05nBbblG+F
	 QDTv2Hiu7zhArQlgKlROVG4HRaXSsJrDBN02AaxhfZFGUkGJswwiOYwwu0p/gKVHeZ
	 zNmr5MfyqKRYJEDsBE4ROWhbq3KOfVDdjq4/755G/CRQU4+Yxe1yGmGFZQETLJZxTi
	 mssM5B60kAXlg==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, "Verma, Vishal L"
 <vishal.l.verma@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Wu, Binbin"
 <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Sean
 Christopherson <seanjc@google.com>, Paolo Bonzini <bonzini@redhat.com>
Subject: Re: CPU Lockups in KVM with deferred hrtimer rearming
In-Reply-To: <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
References: <70cd3e97fbb796e2eb2ff8cd4b7614ada05a5f24.camel@intel.com>
 <87mryxekxy.ffs@tglx>
 <770ae152-c3fd-4068-8462-23064de02238@linux.intel.com>
 <87eck8daot.ffs@tglx>
 <20260421111858.GH3126523@noisy.programming.kicks-ass.net>
 <20260421113212.GI3126523@noisy.programming.kicks-ass.net>
 <20260421113407.GE3102924@noisy.programming.kicks-ass.net>
 <20260421114940.GJ3126523@noisy.programming.kicks-ass.net>
Date: Tue, 21 Apr 2026 19:11:15 +0200
Message-ID: <87cxzsb5n0.ffs@tglx>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 21 2026 at 13:49, Peter Zijlstra wrote:
> On Tue, Apr 21, 2026 at 01:34:07PM +0200, Peter Zijlstra wrote:
>> > > > KVM invokes regular interrupts with pt_regs which have interrupts
>> > > > disabled. That's correct from the KVM point of view, but completely
>> > > > violates the obviously correct expectations of the interrupt entry/exit
>> > > > code.
>> > > 
>> > > Mooo :-(
>> 
>> Also, is this a x86/KVM 'special' or is this true for all arch/KVM that
>> use GENERIC_ENTRY?
>
> Should we not make asm_fred_entry_from_kvm()/VMX_DO_EVENT_IRQOFF fix IF
> on the fake frame instead? We know it will enable IRQs after doing
> handle_exit_irqoff() in vcpu_enter_guest().

Doesn't work :)

> SVM does not seem affected with this particular insanity.

Looks like. It will take the interrupt after local_irq_enable().

Now for VMX, that hrtimer_rearm_deferred() call should really go into
handle_external_interrupt_irqoff(), which in turn requires to export
__hrtimer_rearm_deferred().

But we can avoid that alltogether. Something like the untested below.

Thanks,

        tglx
---
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -42,9 +42,10 @@
 #include <linux/timer.h>
 #include <linux/freezer.h>
 #include <linux/compat.h>
-
 #include <linux/uaccess.h>
 
+#include <asm/irq_regs.h>
+
 #include <trace/events/timer.h>
 
 #include "tick-internal.h"
@@ -2062,11 +2063,16 @@ void __hrtimer_rearm_deferred(void)
 static __always_inline void
 hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t expires_next)
 {
-	/* hrtimer_interrupt() just re-evaluated the first expiring timer */
-	cpu_base->deferred_needs_update = false;
-	/* Cache the expiry time */
-	cpu_base->deferred_expires_next = expires_next;
-	set_thread_flag(TIF_HRTIMER_REARM);
+	/* Lies, damned lies and virt */
+	if (likely(!regs_irqs_disabled(get_irq_regs()))) {
+		/* hrtimer_interrupt() just re-evaluated the first expiring timer */
+		cpu_base->deferred_needs_update = false;
+		/* Cache the expiry time */
+		cpu_base->deferred_expires_next = expires_next;
+		set_thread_flag(TIF_HRTIMER_REARM);
+	} else {
+		hrtimer_rearm(cpu_base, expires_next, false);
+	}
 }
 #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
 static __always_inline void



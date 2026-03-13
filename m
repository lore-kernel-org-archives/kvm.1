Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9CE1A3029
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773364414; cv=none; b=AgfzueGBC2ck11eA4UqnDdaV2oYZve+EgHLQVIMawa8hy5G4QoJ2MuDomtP+y4Pf0r3NMrz59/3QH8WKTMEcicNMkynmtPPDnxVq2/XExujnFgGPrOf+fGZm+FslQ7C0zjtw+kFQIcHuNIclSf8Xj8EvaISR5cuMIUwp0n92ErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773364414; c=relaxed/simple;
	bh=vZmnUXq5KFtd5qnG/6q8QhIiDzT3xNt1c9shikeAPEg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ar0IsUh2kchAZZ1i4vvU3Rh+cpBRjBCNIB/+VyyChZSTMNOUgtByHnzRTBCYngJ5q5PM1HcM3ZwZXJO7DumDdGA1PRmSuzoNe+/1VbyzQYfBTw8btLz8c+aO627w1E4RZPhc6SM0pwgTDLdBGIQ0ENGfk1WKfPwJ29wYc7QbwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTFPkmSd; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTFPkmSd"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35842aa350fso10304101a91.0
        for <kvm@vger.kernel.org>; Thu, 12 Mar 2026 18:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773364412; x=1773969212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqeK/ur+cvogUjBCGY/XKADywQ5XvSMBcIYC3jtarmk=;
        b=jTFPkmSdHIOkAp43kWCMIJTlRkIEd8z960/Yu74f5/c48VWgRSBeK0fITiAeKdjdf/
         Wu7ONz3z8A/MWaqk8jStLcMKnzECKgrzF0q3tDdLYgVPEqT9FUnhpEDR4NQuPID1jiMg
         22htDhQbzxOco5ihYBGMVMQdpH6ODXdaSuG+T2KIyLDQ7FuN+G3Jl9llEclm/vns60MH
         uK7/gWCVeYKE5KqHbNcJPrJ7R3zgb3cB+FWcVAbK2lQNiGEMjanX7zL0BEAhRSlWx+L+
         aYFjBsvAUmr3IP5pXpFcXf2+Bif4hE4zoN0AsT3N/GIhEHyDW/9qeSV1Vmxe6SKYmavr
         U4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773364412; x=1773969212;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqeK/ur+cvogUjBCGY/XKADywQ5XvSMBcIYC3jtarmk=;
        b=aLlWzaSdxfuNzEdoMCtzi7tdopLtF6I+fioskGpRH+fWqcW1HUaWjVrYojNH+/FAio
         Ubr4R5WzzxrA8eAn+5j36uEnNoLKyjpNy9R0qURIUQ/z4IzQ2tCPiZJC8cqRdLFl8QXU
         M56Eirtn5uVZA35GbKPyQxosUt5epRts3MSlUCnAYqmmzDMS/89tAIxrdOq6jX2DFiDC
         hjGWPKNKnUteg8SZSb+qIIpwjTyTkPK7FG2uT0b9wHG/mT9WTOnwvoWaFfTaCuAN/hma
         tYV0iNeG0ctwiykQHuYLZn185MYg635eauJtzTczwkA3a9PglHCOia9qvxd22M2szD6u
         g9NA==
X-Forwarded-Encrypted: i=1; AJvYcCWpmpNttCB4ubsHrzzjF2qr84po1JCZaENrkgyLUhHSIlwUfXtQoOlthZI5FucI0cWyKq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsr1mYoZtOCXflRpAZF3QWJRulFCkKBOYcetL+cMI04IjjL/Wg
	n/791bIuaRyjKLbOu8qepUS5HwAT16JoKJobI7gMUrkZuhzpHI5afFOHIH6TxVR8bzs7f9D2bRS
	CpdGd/w==
X-Received: from pgbcv4.prod.google.com ([2002:a05:6a02:4204:b0:c6e:795e:f99a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6190:b0:398:8766:4d0a
 with SMTP id adf61e73a8af0-398eca9db12mr1105092637.19.1773364412241; Thu, 12
 Mar 2026 18:13:32 -0700 (PDT)
Date: Thu, 12 Mar 2026 18:13:31 -0700
In-Reply-To: <20251219035334.39790-1-kernellwp@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219035334.39790-1-kernellwp@gmail.com>
Message-ID: <abNku6Vgx2eAn-ki@google.com>
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
From: Sean Christopherson <seanjc@google.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 19, 2025, Wanpeng Li wrote:
> Part 2: KVM IPI-Aware Directed Yield (patches 6-9)
> 
> Enhance kvm_vcpu_on_spin() with lightweight IPI tracking to improve
> directed yield candidate selection. Track sender/receiver relationships
> when IPIs are delivered and use this information to prioritize yield
> targets.
> 
> The tracking mechanism:
> 
> - Hooks into kvm_irq_delivery_to_apic() to detect unicast fixed IPIs (the
>   common case for inter-processor synchronization). When exactly one
>   destination vCPU receives an IPI, record the sender->receiver relationship
>   with a monotonic timestamp.
> 
>   In high VM density scenarios, software-based IPI tracking through
>   interrupt delivery interception becomes particularly valuable. It
>   captures precise sender/receiver relationships that can be leveraged
>   for intelligent scheduling decisions, providing performance benefits
>   that complement or even exceed hardware-accelerated interrupt delivery
>   in overcommitted environments.
> 
> - Uses lockless READ_ONCE/WRITE_ONCE accessors for minimal overhead. The
>   per-vCPU ipi_context structure is carefully designed to avoid cache line
>   bouncing.
> 
> - Implements a short recency window (50ms default) to avoid stale IPI
>   information inflating boost priority on throughput-sensitive workloads.
>   Old IPI relationships are naturally aged out.
> 
> - Clears IPI context on EOI with two-stage precision: unconditionally clear
>   the receiver's context (it processed the interrupt), but only clear the
>   sender's pending flag if the receiver matches and the IPI is recent. This
>   prevents unrelated EOIs from prematurely clearing valid IPI state.

That all relies on lack of IPI and EOI virtualization, which seems very
counter-productive given the way hardware is headed.

My reaction to all of this is that in the long run, we'd be far better off getting
the guest to "cooperate" in the sense of communicating intent, status, etc.  As
a stop-gap for older hardware, this obviously is beneficial.  But AFAICT the IPI
tracking is going to be dead weight in the near future.

And there are many, many use cases that what PV scheduling, i.e. if people band
together, I suspect it's feasible to get Linux-as-a-guest to provide hints to the
host that can be used to make scheduling decisions.

> Performance Results
> -------------------
> 
> Test environment: Intel Xeon, 16 physical cores, 16 vCPUs per VM

What generation of CPU?

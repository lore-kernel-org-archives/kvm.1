Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F83803DA
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173397; cv=none; b=FOhehCq8a5yEGZHZh35q+lTVxPAo1XEDHi+ffWqEAhBK5sYs9SZ0vKr8cmEKn3az5c/pwI5oWd+Svu34O4EclXypfP5y8tMFmHV/718rdqfgxS0wdqGXgAj4TiUHf3EY0+ygAN+wkSGBcmzBEqkLwG65EazsOcK3SigcdVUIO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173397; c=relaxed/simple;
	bh=RQPMPNQsp3C7ur7PxdI1+QD14raG45GBututxddKNZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cOIQ2b2+VUF0QN/DAViXpwD2FDdtCIyjnqnwVF+ja4xFh+Zmrw1pYnKL2SWsEPI9AVEtyt8FTVvaxJkRExtkgNwcJjBzq4Jun45on16WGB5YcquKbBb2wgTbLxYfRgTyUdwpI4ZdqZez7Npmt4PcgLkinxc844fsyOIn3tDdmao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uqTN6cRF; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqTN6cRF"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35641c14663so1257972a91.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775173395; x=1775778195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3Bkh+YoH7VRTTDGrQr2eN+MBs2edXW8qG3g5Rslc5k=;
        b=uqTN6cRFJCjzH3hWE9sOWoI9eXHKrWfYx7eV8VAIrPNGA1aRcwCrDpz3Wi7MUnWzhX
         kCtEx3Suu5pEUWYO6Ga/LuZ9eH+024Oh1Xk+uXQzTKTocWb2rQaDFF2IQMNvyWVzgU61
         VbuckkE4ybdCzbmRgD2LMujazr0J9AI+tInRmnb5odMHhmHaGvCZ8ntdmhq/m5DIZNcT
         AZiGGhvStsX2wgU75w0EY7vG3DZk/gRNCsdXVLyM2kvZmW2eKdJg7QwvicjYXkZ0iK6s
         5Z7ManSiPWTetBGl1Z2gBBjYrIAF6wnirrcsTqLPwhXxs/2/1ucxoRfV/+0khe2xhLrZ
         mpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173395; x=1775778195;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z3Bkh+YoH7VRTTDGrQr2eN+MBs2edXW8qG3g5Rslc5k=;
        b=rAtMCgtbSh9QsvAdjdlpSBrEuLVCk459mNZ4uh0O5mwgzcBVhlD8Woz4q8448YleFK
         B4YBI4OGUNWjOKn0oZeoVhg0dq+lwZKnb+mWGlDT+zhz8wECgA4yFDpDEn0SiCDd7jil
         DqZG57nCdqwwHpb9W3rS+RJXj0S8+r1DyCEcrQqB0f3DaEH34NJbjDRF8YlBjLblQQ0L
         Js5oLf0PcwviExYgmH8zk4iFonDw1dWzLhqrLbzeiY/F3PS7n4Pr2wNMp22B2J2EUxdM
         0E/gmzykdhbdM4416y4mksw88qJL57xO6ZgXuGDJxRklTC4GRjqVZuCDJo+JlQQwKAdj
         zMJg==
X-Forwarded-Encrypted: i=1; AJvYcCVyRcahEu9j2kudxhLlzvy5AHAqS/fAOuPaNTZ4ZVlkJ7d7m4Us+/9Y+KXeLFyOh0xPBN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMS6lcyJWHvteC2pdaSvuJ1I50fMLrTiYkLexHSOsuspifNiu8
	aTkvn7/0azOrG87mXkYTYI7XeZkwGYfCo5HBc4I+SHqFTVU8V6kCOwClky6VkySEqNQhu4FeI8u
	FULdWKw==
X-Received: from pffx14.prod.google.com ([2002:aa7:93ae:0:b0:82c:efb6:4087])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a125:b0:39f:1f92:28d
 with SMTP id adf61e73a8af0-39f2efac665mr737450637.29.1775173395093; Thu, 02
 Apr 2026 16:43:15 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:43:13 -0700
In-Reply-To: <CANRm+Cy4MxrtvufkCeefFZm2ycT5WjUmHLuiG1xPthbf58VDjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219035334.39790-1-kernellwp@gmail.com> <abNku6Vgx2eAn-ki@google.com>
 <CANRm+Cy4MxrtvufkCeefFZm2ycT5WjUmHLuiG1xPthbf58VDjQ@mail.gmail.com>
Message-ID: <ac7_EcgDhs5s4s0P@google.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026, Wanpeng Li wrote:
> Hi Sean=EF=BC=8C
> On Fri, 13 Mar 2026 at 09:13, Sean Christopherson <seanjc@google.com> wro=
te:
> >
> > On Fri, Dec 19, 2025, Wanpeng Li wrote:
> > > Part 2: KVM IPI-Aware Directed Yield (patches 6-9)
> > >
> > > Enhance kvm_vcpu_on_spin() with lightweight IPI tracking to improve
> > > directed yield candidate selection. Track sender/receiver relationshi=
ps
> > > when IPIs are delivered and use this information to prioritize yield
> > > targets.
> > >
> > > The tracking mechanism:
> > >
> > > - Hooks into kvm_irq_delivery_to_apic() to detect unicast fixed IPIs =
(the
> > >   common case for inter-processor synchronization). When exactly one
> > >   destination vCPU receives an IPI, record the sender->receiver relat=
ionship
> > >   with a monotonic timestamp.
> > >
> > >   In high VM density scenarios, software-based IPI tracking through
> > >   interrupt delivery interception becomes particularly valuable. It
> > >   captures precise sender/receiver relationships that can be leverage=
d
> > >   for intelligent scheduling decisions, providing performance benefit=
s
> > >   that complement or even exceed hardware-accelerated interrupt deliv=
ery
> > >   in overcommitted environments.
> > >
> > > - Uses lockless READ_ONCE/WRITE_ONCE accessors for minimal overhead. =
The
> > >   per-vCPU ipi_context structure is carefully designed to avoid cache=
 line
> > >   bouncing.
> > >
> > > - Implements a short recency window (50ms default) to avoid stale IPI
> > >   information inflating boost priority on throughput-sensitive worklo=
ads.
> > >   Old IPI relationships are naturally aged out.
> > >
> > > - Clears IPI context on EOI with two-stage precision: unconditionally=
 clear
> > >   the receiver's context (it processed the interrupt), but only clear=
 the
> > >   sender's pending flag if the receiver matches and the IPI is recent=
. This
> > >   prevents unrelated EOIs from prematurely clearing valid IPI state.
> >
> > That all relies on lack of IPI and EOI virtualization, which seems very
> > counter-productive given the way hardware is headed.
>=20
> I think there is an important distinction here. APICv / posted
> interrupts accelerate IPI *delivery*, but they do not help with the
> host-side *scheduling decision* in kvm_vcpu_on_spin().

I know, but that doesn't change the reality of where hardware is headed (or=
 rather,
already is).

> A posted interrupt can land in a not-yet-scheduled vCPU's PIR, but that v=
CPU
> still won't process it until it actually gets CPU time. IPI tracking targ=
ets
> exactly this gap: which vCPU should we yield to right now.
>=20
> In high VM density / overcommitted scenarios, APICv's advantage narrows
> precisely because the bottleneck shifts from IPI delivery latency to
> *scheduling latency* =E2=80=94 the target vCPU may have its posted interr=
upt sitting
> in PIR but cannot process it because it is competing for physical CPU tim=
e
> with many other vCPUs. In that regime, making a better yield-to decision =
on
> the host side has a more direct impact on end-to-end IPI response time th=
an
> faster hardware delivery to a vCPU that isn't running.
>=20
> So I would not characterize IPI tracking as a workaround for lack of hard=
ware
> virtualization support. It addresses an orthogonal problem =E2=80=94 host=
-side
> scheduling decisions =E2=80=94 that hardware IPI acceleration does not so=
lve. The two
> are complementary: APICv makes delivery fast when the target is running;
> IPI-aware directed yield makes scheduling better when the target is not
> running.

Except they aren't complementary in the sense that, as implemented, they ar=
e
mutually exclusive.  The x86 changes here rely on tracking IPIs, and unless=
 I'm
missing something in the series, that code falls apart when IPI virtualizat=
ion
is enabled.

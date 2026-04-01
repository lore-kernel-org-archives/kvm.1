Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840A3BED33
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036915; cv=pass; b=X8uOp4R9zXB61ltxsgIL/TxxokMcX94c33uovcUXvoFQFyQr2jUGCRozZsBl5CtW2hBbkjewovJfVmlbngxUkH5kXdcckrxLLHpxka57ShXvlpQmBSsDuYUtGQ0CzViAsG6C43jjSSdnjEE+38Y8aIZ3eAf1PDAllZOAjwmF8J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036915; c=relaxed/simple;
	bh=GZli/LHTedU6rip3UvZKNcK1kxLRUBMPFr36LKZlEoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VWbfIqGVRCTyOLEq3j57jdzSbD7XnmhkeH2wLzHri2GQb1IXe/J3IqH7/3nVmNPPjcVgAIWhbcnEdfgWKbEe9I7uSQZXuDovIkr27EukS1AsHI+mX1jAoEs+18TJp/xK+b+O17U3kBRXJ/WN4VfZHs9xUDi385d33GUAAej8aPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqXNLNT9; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqXNLNT9"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4be94eeacso6290443a34.2
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 02:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775036913; cv=none;
        d=google.com; s=arc-20240605;
        b=M85iIHyDcjfQZluO/7SIh6lNdeuI9sBHkTLre6fM4PKY1j5c5+L2vDvTu9UuRYz0g5
         iNJXJiOIfVDXcGCoo64X+dhicXK1BZlL/RusxBuECwTdiXvgaI9tyzewJh5ollB/zIdl
         Fa0SF99nohhLcPwxqCf1l23+Ik0bT2nYXV08uduwWCPPDDG6K69utP27tJtcOFgXO3Qe
         j6wieCHcxVJgxlFoqNYg6H+CVrFcDuvGSkDTL8YcYWG8dt8RVwmNJmh6L2l+8WvENWjh
         wrsl/efF6Gn8ogaZ4mod8EiAgh6Ceqxl9/yn+GHcMaGljgxoYiEkPk3mJ4ZJWrG4Q9OA
         4HAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/wztYxSQ8FeDXYv0doyrHu4Krq/mXz4Kvd+nHq+kFLA=;
        fh=fcYt6cr+mR9/F0DyxRM+IGbnY8gA+es/IaVUh/Pdesk=;
        b=XiZ98pfXdKGUoVu/QCGYXKG1QfMw8XxtX7fMUqHTS5LLkNsWx1s+o1l2CQo7CF/Qel
         Di55bi+VO6mNeeJFcl7Yqa+pgc7/ARpaSkvgK1F+xBxIJ2RuX61AHNc+d9TLPAGNXBah
         lLKqwtYnccdSsp1lUoRW6/hlWqKeltUv7xyUsLS9SJdlpfDggW549UbimSPe2UkXPLDB
         fjFqG3/PHpxI/e1YzW+vivsKAg08E67fvBVEI+OzUzSM+Q2I4/ebbuKv6dUiafCbwU8d
         caLwO4zc2qwOPjegLVJpw6tFJzbRTheKZHLIklLRGnV0rVutzY4iEzgK1QxEPpunWPQg
         Cf9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775036913; x=1775641713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wztYxSQ8FeDXYv0doyrHu4Krq/mXz4Kvd+nHq+kFLA=;
        b=nqXNLNT91XCinz4H7zKTIuLdYZhHAff5DjZ7pCYlTtUlefcnZEneocjV/U2Ywd+S4D
         qRZRNYKMwjzyG0QRv5B0RfZHGtlYKR3K0oGy7ZbF9N8JvkzFC34xCN27CRYah3fyQlDc
         rqiygl5ExCuxuQXIQPaA2477+NYf6kfMWVTffewxWEL3l7QrOy0UodoD+n3eOLoPzUbN
         s7q9wLtbRwch3Qp4yFvofL5UJJZwCVmVNGweSo05kl4EHoHLQ9G2EVg9c5Ia2Fop844F
         wj2oywElaST9KkJEorGtndJ2JNgSn2GYGx8lm5JX1B+gxXEqu5v4HZObbaKZ0wjmvd6B
         MdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775036913; x=1775641713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/wztYxSQ8FeDXYv0doyrHu4Krq/mXz4Kvd+nHq+kFLA=;
        b=iOsZYLlOLFSFrj3ZnYRwOu1mXT70DnFWWJOdW1g/J/PjvBzKl6kTh36zFV3uk5bxJB
         aUs5fs6WZiDnH1pO92OLsXesm7NkN6p/f4qjJPcHz3PXh/gA7HhbpCIAKKDQnHV9Rvpr
         P6ZHNV0md3/JQTa2gi5HXjIcx2aONeq2Hz/Y7vA+sGYUsTu9ap8Yg4tHDEGdKjR331nJ
         t+KcQ+LeR28XbOINxjw6nPFfoGlMxXcC3I5Zft4QJf+HcIkx/OPNo8ahdD8yIq9DT78J
         /DZdoERQwEdj1K9xrXT86IBaf7+sGh/a0omcU0nGJiSmL7DKLobgsuRcczUOO7UgEX++
         u0CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbb/zn+pYEtgw/GYPJSzofzGXYlIQChNVMfBP99EBpEcOhbsKqK95VgI/IhDk/qOsJRA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/gONNKwkUhuSdcXfrIpmKqsEjCD+E25WhDrBnsMVubSIAQCAZ
	5gwz389sQMZjXcjNn2n1YjwJNB4INaXds03FjUwVmh+JDqeY10yC9Y08n0EibeprQ5ikgOUIdA6
	T5PCoTu+A0RKJ/N6R/+Ex5G4fwWpPlOQ=
X-Gm-Gg: ATEYQzxsLXH6iOx8soDtJURMKbjuBodLypSHwOkQFU+uhSQiAHMW0STqIXbj30lyf/i
	11hQz/q9sVe3b6hx418+1WIF2uOHFrMDYGzU0cJTjjB/mOhP0mHzvyp2qU2SfMC4eXSOg6Tf8Zu
	PauoaNx6orYb7YhthCgIRVfEZdLn3MuXW/HgQaLV1KhBoTzL1+qvU8+K4U1trIgAi5OeEd8ebQR
	eIiq78xGO2KWrsLk53Ch7Y4z4rXJ0s4X3fBksNasx16Gehgd00kUk6k+oFoGxuGqjcWNLmwsZrJ
	dQ2+fWMn
X-Received: by 2002:a05:6820:1794:b0:67e:331c:9ac4 with SMTP id
 006d021491bc7-67fabc05a37mr1474937eaf.23.1775036912600; Wed, 01 Apr 2026
 02:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219035334.39790-1-kernellwp@gmail.com> <abNku6Vgx2eAn-ki@google.com>
In-Reply-To: <abNku6Vgx2eAn-ki@google.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 1 Apr 2026 17:48:21 +0800
X-Gm-Features: AQROBzCvshFpmBew3lVhJRFCjtN6YdmENqPm4VJGszE0C4DZtJ2ofSW0-dZMU7w
Message-ID: <CANRm+Cy4MxrtvufkCeefFZm2ycT5WjUmHLuiG1xPthbf58VDjQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] sched/kvm: Semantics-aware vCPU scheduling for
 oversubscribed KVM
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean=EF=BC=8C
On Fri, 13 Mar 2026 at 09:13, Sean Christopherson <seanjc@google.com> wrote=
:
>
> On Fri, Dec 19, 2025, Wanpeng Li wrote:
> > Part 2: KVM IPI-Aware Directed Yield (patches 6-9)
> >
> > Enhance kvm_vcpu_on_spin() with lightweight IPI tracking to improve
> > directed yield candidate selection. Track sender/receiver relationships
> > when IPIs are delivered and use this information to prioritize yield
> > targets.
> >
> > The tracking mechanism:
> >
> > - Hooks into kvm_irq_delivery_to_apic() to detect unicast fixed IPIs (t=
he
> >   common case for inter-processor synchronization). When exactly one
> >   destination vCPU receives an IPI, record the sender->receiver relatio=
nship
> >   with a monotonic timestamp.
> >
> >   In high VM density scenarios, software-based IPI tracking through
> >   interrupt delivery interception becomes particularly valuable. It
> >   captures precise sender/receiver relationships that can be leveraged
> >   for intelligent scheduling decisions, providing performance benefits
> >   that complement or even exceed hardware-accelerated interrupt deliver=
y
> >   in overcommitted environments.
> >
> > - Uses lockless READ_ONCE/WRITE_ONCE accessors for minimal overhead. Th=
e
> >   per-vCPU ipi_context structure is carefully designed to avoid cache l=
ine
> >   bouncing.
> >
> > - Implements a short recency window (50ms default) to avoid stale IPI
> >   information inflating boost priority on throughput-sensitive workload=
s.
> >   Old IPI relationships are naturally aged out.
> >
> > - Clears IPI context on EOI with two-stage precision: unconditionally c=
lear
> >   the receiver's context (it processed the interrupt), but only clear t=
he
> >   sender's pending flag if the receiver matches and the IPI is recent. =
This
> >   prevents unrelated EOIs from prematurely clearing valid IPI state.
>
> That all relies on lack of IPI and EOI virtualization, which seems very
> counter-productive given the way hardware is headed.

I think there is an important distinction here. APICv / posted
interrupts accelerate IPI *delivery*, but they do not help with the
host-side *scheduling decision* in kvm_vcpu_on_spin(). A posted
interrupt can land in a not-yet-scheduled vCPU's PIR, but that vCPU
still won't process it until it actually gets CPU time. IPI tracking
targets exactly this gap: which vCPU should we yield to right now.

In high VM density / overcommitted scenarios, APICv's advantage
narrows precisely because the bottleneck shifts from IPI delivery
latency to *scheduling latency* =E2=80=94 the target vCPU may have its post=
ed
interrupt sitting in PIR but cannot process it because it is competing
for physical CPU time with many other vCPUs. In that regime, making a
better yield-to decision on the host side has a more direct impact on
end-to-end IPI response time than faster hardware delivery to a vCPU
that isn't running.

So I would not characterize IPI tracking as a workaround for lack of
hardware virtualization support. It addresses an orthogonal problem =E2=80=
=94
host-side scheduling decisions =E2=80=94 that hardware IPI acceleration doe=
s
not solve. The two are complementary: APICv makes delivery fast when
the target is running; IPI-aware directed yield makes scheduling
better when the target is not running.

>
> My reaction to all of this is that in the long run, we'd be far better of=
f getting
> the guest to "cooperate" in the sense of communicating intent, status, et=
c.  As

I agree that guest cooperation / PV scheduling hints could provide
even richer semantic information for these decisions in the long term.
The host-side IPI tracking approach has the practical advantage of
working with unmodified guests and mixed-OS deployments today, which
covers a large fraction of real-world overcommitted environments.

These two directions are not mutually exclusive =E2=80=94 PV hints can coex=
ist
with host-side heuristics, and the IPI tracking infrastructure could
serve as a useful fallback or baseline even after PV scheduling is
available, for guests that do not support it.

Regards,
Wanpeng

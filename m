Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF636411685
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542987; cv=none; b=D5EW2GlVmLvE/d1H472mCoUHLK0k4M9jFI1b3PtNTgVxpl0P4NWMOU0yY/vpOwmQUxqCn5J+eM/CO/Awr32ySoOO9ejf/6bG5EnU1KN0YmDEIhAMS+oJlpquw+5WkLQZSJuswQTeIhETJ2s8nH7fErTIvXdaezN6jtaLIsaHjQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542987; c=relaxed/simple;
	bh=Y6iEWtME68TB8Ifyh8CZmBsdibnHv2cqxvXDhEYwSeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YmcyRYlXGC4tD58Dbg4kDJ+vO6qdraleRTvePVLEhnRJ1J4XCqXJ2o/IVCGrvgV+wGr/b2OY9iKDm4FYvcKQ967RF4aE8orK4jFUh4UjejNP0YxTaY3h0SDwSc+qmrEv3xtCI0vUokWAS9TlHxAZXWTrPmTc4fAO4ybm5GJNRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vh1uosx5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vh1uosx5"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c20f7581so36893045ad.0
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542985; x=1782147785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYpzGCPyYHUzAOr3s/xUZ/kiM/zvrLWU+ahmw9F4/q4=;
        b=Vh1uosx5kiLonH83dvDFjvR9N84Nn1Da62agZC9vR4SZqy7gRtXVVMa/YZdZ5xdtjo
         WsXBfW8OtbquIMmisyj2qYZYYoqcOeNB02YLkyEjfaoWzHVLBsUKqvFAbE61cyi1GTvZ
         RlCABsZhsCJltzozaI6ZPv3CAcsp/YV6kUpe3RaOXEQSyFCGVn5jJtmStZDEcm37cjw/
         9KBhB3kpOPZS3r8rqdbdImKxuQ4C9yW4470Upltfp0pgQ09MpH9HIvB5zVoMWZ+85pes
         MxAeK3vfisNzTt2uoCiZ/77Ec3kwqzDza+S/Ad7fdLJvrIdSUf6btnS2eCF4cCdh878X
         /HlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542985; x=1782147785;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lYpzGCPyYHUzAOr3s/xUZ/kiM/zvrLWU+ahmw9F4/q4=;
        b=oM4njmxfCkAPI3fV+BwveWS3h/R7HvPLl4892DtltUyw6GeGuFbO9ZfFQ/PJeSsQKy
         DuzxgY9ZX5tepFpM6ziof3miYvJAqHeAyJncbN6nTGoibdrR5711seFV0StEFv3HY1D3
         bUqqwRdbdbZmEqPzCKFG43xXnACLQy8MpgS51sKUxfj3xZ0MOx2ldw0kqBjeAk78+2GW
         m8nDModhEzO1apYK54uj2oyHtcUbwznwkMOWQ5uFLJYeOvKe0o2GHq1YvzlfiUZJbWQF
         Kn3V945Yt9cFqhhpWhphxyTMVJsKdMyIVjn+Gb2j864/QI0bEPqX8x0THHbLogrYh+Ax
         hp8A==
X-Forwarded-Encrypted: i=1; AFNElJ+rS0hvKC9t/aVT4vEsplJoj0+YZ9IILEF+n6n/R/WtPs7v1XxK5nPSmFFXVRxqRZR8jUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YmsEDhFRx+Q7hF9FEii1Ydn9OOm6QFfn+jyWk3YHs9isxgUj
	1bINb60DCAXRyKN1If510iZaqEC1AIhVPeRMkwMjLV+NJLgmPEE7T7XS8JTFv2LZs2iftq4IsFv
	RLVP+IQ==
X-Received: from plgu6.prod.google.com ([2002:a17:902:e806:b0:2c6:8264:8add])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced0:b0:2c6:6424:c79f
 with SMTP id d9443c01a7336-2c69a0dc52amr1151935ad.8.1781542984887; Mon, 15
 Jun 2026 10:03:04 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:03:04 -0700
In-Reply-To: <CAO9r8zMX3_JgrJNQGuvFaANXKsA4hMEgO7=OS=q=-AA4mMhhaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000329.732085-1-seanjc@google.com> <20260613000329.732085-27-seanjc@google.com>
 <CAO9r8zP4aYJ8SuL+eWXOch=BByfWmmCGVRwkHo=1cVx8Y5JAPg@mail.gmail.com> <CAO9r8zMX3_JgrJNQGuvFaANXKsA4hMEgO7=OS=q=-AA4mMhhaw@mail.gmail.com>
Message-ID: <ajAwSMLG9OJfnVQT@google.com>
Subject: Re: [PATCH v4 26/30] KVM: x86: Don't treat interrupts as allowed just
 because a nested run is pending
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026, Yosry Ahmed wrote:
> On Mon, Jun 15, 2026 at 9:40=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Fri, Jun 12, 2026 at 5:04=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > When querying whether or not interrupts (IRQs) are allowed, check for=
 a
> > > pending nested run _after_ checking whether or not interrupts are blo=
cked.
> > > If L1 is running L2 _without_ nested_exit_on_intr(), i.e. if L1 IRQs =
can
> > > be blocked while running L2, and interrupts will indeed be blocked on=
ce the
> > > nested VM-Enter to L2 is completed, then KVM should treat interrupts =
as not
> > > being allowed.
> > >
> > > For injection, this avoids an unnecessary (forced) VM-Exit, as KVM ca=
n
> > > immediately request an IRQ window, instead of forcing an exit and _th=
en_
> > > requesting an IRQ window (because after the forced exit, KVM will see=
 that
> > > interrupts are blocked).
> > >
> > > For non-injection usage, only kvm_vcpu_ready_for_interrupt_injection(=
) is
> > > affected in practice.  kvm_vcpu_has_events() is unreachable when a ne=
sted
> > > run is pending, as KVM clears nested_run_pending prior to calling
> > > kvm_emulate_halt_noskip() when putting L2 into HLT via GUEST_ACTIVITY=
_HLT,
> > > and SVM has no equivalent to GUEST_ACTIVITY_STATE.  I.e. the vCPU wil=
l
> > > always be runnable if a nested run is pending, and thus
> > > kvm_arch_vcpu_runnable() =3D> kvm_vcpu_has_events() is effectively de=
ad code,
> > > as is __kvm_emulate_halt() =3D> kvm_vcpu_has_events().  Oh, and TDX d=
oesn't
> > > support nested VMX.  Similarly, kvm_can_do_async_pf() is unreachable =
as
> > > KVM shouldn't be faulting in memory with a pending nested VM-Enter.
> > >
> > > As for kvm_vcpu_ready_for_interrupt_injection(), incorrectly treating
> > > interrupts as being allowed could result in KVM prematurely exiting t=
o
> > > userspace to accept an ExtINT.
> >
> > "incorrectly treating interrupts as being allowed" is the status quo,
> > that this patch fixes, not sth this patch introduces -- right?
> >
> > The changelog reads like for the non-injection case this change might
> > not be the right thing to do, but I don't think this is the case? I
> > assume returning false from
> > kvm_vcpu_ready_for_interrupt_injection() and kvm_vcpu_has_events() if
> > L1's interrupts are blocked while L2 is running is the right thing to
> > do?
> >
> > The code makes sense to me but I am trying to make sense of the changel=
og.
> >
> > Aside from that, I have two comments about existing issues (Sashiko-sty=
le):
> >
> > 1. The return values of {vmx/svm}_interrupt_allowed() are annoying.
> > IIUC, 0 is not allowed, 1 is allowed, and -EBUSY is generally allowed
> > but not right now, request immediate exit and try again? That should
> > be documented somewhere (maybe I just missed it?).
>=20
> The next patch is adding the documentation, I spoke too soon :)
>=20
> >
> > 2. Aside from TDX, seems like {vmx/svm}_interrupt_allowed() are doing
> > the same thing? So maybe move all that logic into
> > kvm_arch_interrupt_allowed(), rename it (because it's only used by
> > x86), and make interrupt_blocked() the actual per-vendor callback?

Doesn't work, at least not with more changes/hooks, because nested_exit_on_=
intr()
is subtly vendor specifc.  The concept is identical, but the implementation=
 needs
to query vmc{b,s}12. :-/

I'm not opposed to figuring out a way to move the logic to common x86, beca=
use
I agree that's where it would ideally live, but I don't want to tack that i=
n this
series.

> > I assume this is the case because nested_run_pending used to be per-ven=
dor,
> > but now we can clean this up. For TDX, I assume the per-vendor hook can
> > just be tdx_interrupt_allowed() reversed?
>=20
> It also does the renaming (nice!), so we're halfway there. I think for
> this series, we should at least convert all direct calls to the vendor
> .interrupt_allowed through the new kvm_is_interrupt_allowed() helper.

Sadly not in this series, because handling the for_injection=3Dtrue case re=
quires
moving the nested_run_pending logic to common x86, and without that, we end=
 up
with two very silly wrappers.

> Unless you wanna go all the way and rework .interrupt_allowed to
> .interrupt_blocked while at it as well.



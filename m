Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64048374170
	for <kvm@vger.kernel.org>; Fri, 27 Feb 2026 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772216311; cv=none; b=X8xPObLzjCSN5QwhBSFQmZxvBFH5pBcTq9vc/AviWT6qN5P+HTg9ns6awF3D9OnJbVbNZWgtn+YkqdmqseYbwpCeDcsUThdVe2XaMTZkZ9T8X6Ii05zkFSl9mpXI/yXGRfcgmTDDfRlcNeMbmsdiUyabj/SXjFau95EALxQeQUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772216311; c=relaxed/simple;
	bh=dL2lED0H4Vh+DQX2gfoN9cduNziRZausggYZg05Rrec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDaGEvmfNoP8wx5jl08lWKP+9/glZPktA1nS4CHIXdPAlx7YWA/LhVQHAjjlRK5wKx3SkaX/pyjI8DTMWSEC31fJ/xFc1AB107+ZSjJwPrufpeOhVFNyXvVkHX9qCX3LU72HSxwqYAKIz5Pm9C79+4cBRzvcQeZp/PUje16Y9sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyD0q3Z4; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyD0q3Z4"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35658758045so1597082a91.3
        for <kvm@vger.kernel.org>; Fri, 27 Feb 2026 10:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772216310; x=1772821110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VjtrC6wXSkKwjHrwny4zHfiltbsgu7d4FOLycr3Qios=;
        b=eyD0q3Z4CQsszQM0RhVrsgWsXgEOkj/VMpUrQk7/OsrFILNQKNmazxvTsQCZ/S90oL
         6MLWgTGOYGCYnSfDuo4Cqb5pXjpGdmBCK/N6LjtCnJ5e9CVxIfieGhyQDJDT4jj7FsUk
         R389cPHmRZjCeYOU7W1tCnX+GFdFvT4cFGPm0yGvDvW8txVNs6vRhWAgK4z1R1QzYQyt
         Nek2JzIFtZzbg7hzRweG7q2Evy88AWXnD6x1brXDepqm5Cj0Ofd/vDO5GWjSznDyPIql
         qVlcRD05cYXbIbYlCWPacuTq+rrv6Dhiu5Z8EJ7WDkuOn7BI6pMG/t64FJDc5Eknrnta
         SApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772216310; x=1772821110;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VjtrC6wXSkKwjHrwny4zHfiltbsgu7d4FOLycr3Qios=;
        b=BjU97ZQSV88suh+AZ5+9npBzZ6+6qT0qYBsDVgTJLcsjSDfuUW9O0BNiKfm3k2frdr
         zedp9go7Iz7PjHZ9q3F+5E3Yj3GacrV4uJt4haI76xEbONsekjI2qmspsVQw9ow8cM73
         R96Uovp2/WFBaK/ZreSDGdOUCJwIogjRHkQhDh/Wdbpei1ez6uYX+qr2mxD+zgbk5LyL
         pJNDDqp9u1zX0p9BGQUaHeNA9gFs35LuGJrYrvlRDQpOhQ5oBsnE0Ba9VYs9jFlcSjl/
         V45bvD7L8W6vUwktAXTXXlbaYrkd4wqP7wjUUsngfAMqPPcXz/wlVuM7QSkbeH8JEjR4
         H4ug==
X-Forwarded-Encrypted: i=1; AJvYcCX4os7ElPG41KTMy7Bgj4owy1YSvh9XcwL9uSfWOQlKcIpX7xJwj2/kEW2Myb7IrfNuN3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkIpgr14zk/JTdyc2tW9ThpBoYx2m1PDAQ+9Eo4PE9/mMQ4KHR
	izKtqiywXGnZP5Um2jE4m6oRETNtLzZWgt1jLL6o0doT5XkeWhHkTZUeu1VKobvxg5zaXKRuV9P
	YW27hvw==
X-Received: from pjqh24.prod.google.com ([2002:a17:90a:a898:b0:358:e428:f935])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3852:b0:356:2132:67bf
 with SMTP id 98e67ed59e1d1-35965c9c995mr3815276a91.18.1772216309531; Fri, 27
 Feb 2026 10:18:29 -0800 (PST)
Date: Fri, 27 Feb 2026 10:18:28 -0800
In-Reply-To: <CAO9r8zMdyvAJUvnxH0Scb6z3L51Djb1qpMAzX3M9g7hOkB=ZOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227011306.3111731-1-yosry@kernel.org> <20260227011306.3111731-4-yosry@kernel.org>
 <aaG_o58_0aHT8Xjg@google.com> <aaHHg2-lcpvkejB8@google.com> <CAO9r8zMdyvAJUvnxH0Scb6z3L51Djb1qpMAzX3M9g7hOkB=ZOQ@mail.gmail.com>
Message-ID: <aaHf9Lxx8ap_3DRI@google.com>
Subject: Re: [PATCH 3/3] KVM: x86: Check for injected exceptions before
 queuing a debug exception
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026, Yosry Ahmed wrote:
> On Fri, Feb 27, 2026 at 8:34=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Feb 27, 2026, Sean Christopherson wrote:
> > > So instead of patch 1, I want to try either (a) blocking KVM_SET_VCPU=
_EVENTS,
> > > KVM_X86_SET_MCE, and KVM_SET_GUEST_DEBUG if nested_run_pending=3D1, *=
and* follow-up
> > > with the below WARN-spree, or (b) add a separate flag, e.g. nested_ru=
n_in_progress
> > > or so, that is set with nested_run_pending, but cleared on an exit to=
 userspace,
> > > and then WARN on _that_, i.e. so that we can detect KVM bugs (the who=
le point of
> > > the WARN) and hopefully stop playing this losing game of whack-a-mole=
 with syzkaller.
>=20
> I like the idea of the WARN there, although something in the back of
> my mind tells me I went through this code before with an exception in
> mind that could be injected with nested_run_pending=3D1, but I can't
> remember it. Maybe it was injected by userspace and all is good.

If there is such a flow, it's likely a bug, i.e. we'd want the WARN.  AFAIK=
,
every single time the WARN has been hit in the last ~2-3 years has been due=
 to
syzkaller.

> That being said, I hate nested_run_in_progress. It's too close to
> nested_run_pending and I am pretty sure they will be mixed up.

Agreed, though the fact that name is _too_ close means that, aside from the
potential for disaster (minor detail), it's accurate.

One thought is to hide nested_run_in_progress beyond a KConfig, so that att=
empts
to use it for anything but the sanity check(s) would fail the build.  I don=
't
really want to create yet another KVM_PROVE_xxx though, but unlike KVM_PROV=
E_MMU,
I think we want to this enabled in production.

I'll chew on this a bit...

> exception_from_userspace's name made me think this is something we
> could key off to WARN, but it's meant to morph queued exceptions from
> userspace into an "exception_vmexit" if needed. The field name is
> generic but its functionality isn't, maybe it should have been called
> exception_check_vmexit or something. Anyway..

No?  It's not a "check", it's literally an pending exception that has been =
morphed
to a VM-Exit.

Hmm, though looking at all that code again, I bet we can dedup a _lot_ code=
 by
adding kvm_queued_exception.is_vmexit instead of tracking a completely sepa=
rate
exception.  The only potential hiccup I can think of is if there's some wri=
nkle
with the interaction with already pending/injected exceptions.  Pending sho=
uld be
fine, as the VM-Exit has priority.

Ah, scratch that idea, injected exceptions need to be tracked separate, e.g=
. see
vmcs12_save_pending_event().  It's correct for vmx_check_nested_events() to
deliver a VM-Exit even if there is an already-injected exception, e.g. if a=
n EPT
Violation in L1's purview triggers when vectoring an injected exception, bu=
t in
that case, KVM needs to save the injected exception information into vmc{b,=
s}12.

> That gave me an idea though, can we add a field to
> kvm_queued_exception to identify the origin of the exception
> (userspace vs. KVM)? Then we can key the warning off of that.

That would incur non-trivial maintenance costs, and it would be tricky to g=
et the
broader protection of the existing WARNing "right".  E.g. how would KVM kno=
w that
the VM-Exit was originally induced by an exception that was queued by users=
pace?

> We can potentially also avoid adding the field and just plumb the
> argument through to kvm_multiple_exception(), and WARN there if
> nested_run_pending is set and the origin is not userspace?

Not really, because kvm_vcpu_ioctl_x86_set_vcpu_events() doesn't use
kvm_queued_exception(), it stuffs things directly.

That said, if you want to try and code it up, I say go for it.  Worst case =
scenario
you'll have wasted a bit of time.

> > > I think I'm leaning toward (b)?  Except for KVM_SET_GUEST_DEBUG, wher=
e userspace
> > > is trying to interpose on the guest, restricting ioctls doesn't reall=
y add any
> > > value in practice.  Yeah, in theory it could _maybe_ prevent userspac=
e from shooting
> > > itself in the foot, but practically speaking, if userspace is restori=
ng state into
> > > a vCPU with nested_run_pending=3D1, it's either playing on expert mod=
e or is already
> > > completely broken.
> > >
> > > My only hesitation with (b) is that KVM wouldn't be entirely consiste=
nt, since
> > > vmx_unhandleable_emulation_required() _does_ explicitly reject a "use=
rspace did
> > > something stupid with nested_run_pending=3D1" case.  So from that per=
spective, part
> > > of me wants to get greedy and try for (a).
> >
> > On second (fifth?) thought, I don't think (a) is a good idea.  In addit=
ion to
> > potentially breaking userspace, it also risks preventing genuinely usef=
ul sequences.
> > E.g. even if no VMM does so today, it's entirely plausible that a VMM c=
ould want
> > to asynchronously inject an #MC to mimic a broadcast, and that the inje=
ction could
> > collide with a pending nested VM-Enter.
> >
> > I'll send a separate (maybe RFC?) series for (b) using patch 1 as a sta=
rting point.
> > I want to fiddle around with some ideas, and it'll be faster to sketch =
things out
> > in code versus trying to describe things in text.
>=20
> So you'll apply patch 3 as-is, drop patch 2, and (potentially) take
> patch 1 and build another series on top of it?

Yeah, that's where I'm trending.

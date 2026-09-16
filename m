Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B1F414A11
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581667; cv=none; b=nODWiKAmR/95eWgzanvzZu29TuBmwIdLn+pTJFHn+39S9+dQm/VzZ0+xYGu8CzzJt5gig+ygMvFtHP/qn2yp31Nhp2xm2SLJEzVD4EuzvGQo3vFWb3mRmmljINI/wTN3vFKazkS7ebnjRq1nKsHHPvvx1VGCfoTskbbYR2hwh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581667; c=relaxed/simple;
	bh=BM7m2qMuLHC97pgGicfcI+F7Qy4IfuoGYUuoHV6tpug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SPZCtgYZsv3dtRlOJi2SGnngcshFOIXZMLtnEPT0gy2BgIdA8cjLEHISCAiBlZNuyqCcsIwIQh28mQKK/vnwynt8jZNafg2P7nmym/GzumK3zLhbU+sVzOmWwN8eWeuL0+yNEG+Xkbzb7qZ6byCTN3iiwq3rIBqbtkwj3Gv+xxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m5w8Rwhy; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m5w8Rwhy"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd8920c132so14545ad.0
        for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789581651; x=1790186451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4s+521Fqa19KtzEYgOec6+FEoiMkZDuNR0N9XHxDUm8=;
        b=m5w8RwhyJ41ughHK7n0FGeBmgyJiIeIEU3qiCkRtjr7k1yy5Syo2s8DXH+tRb+F5PJ
         nUKeC0JdrO0m+dIUv+iwZtyYPKNYwFezyasvY1syblFUokYneMR67ZkjWufVe5eCNVrm
         +e89oYN0b4Fa+SzOsuPpTr06L3Q4wYPQ3Oefyok5J+0Oj4294wrVfZh6LFv2Rq1c6yn8
         3SY/AZee7R2vTE0xa76B6JVdCGBeJbIl+RLydoSARGnZRIp1w+dFAPSOKzNRlBo6yDnU
         ST5RhrgPirb1Aw1OU7ksQK8wEZ+ypjEdg9N9cW7E8Cg70SrCjVJdzzL5zUZ+KxyJ6UBq
         zQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789581651; x=1790186451;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4s+521Fqa19KtzEYgOec6+FEoiMkZDuNR0N9XHxDUm8=;
        b=rmSLgieftB2K0sXNJ9KI4cSdRbwFH0/MZXYCnCEc69yBU6IxVO39tohewor7UoJpmv
         /dzfGdicpXVQLX4ezO/bxTBQvuLGaAxJ11vurAyOYj52PJ5c2mRCUuCQj6k2joWa/EqC
         sdlOnsKOk2lSX0a8FC0MVGCqD24va7tN3pDFU083bfxWVvutchbWqkJRAYEm049sCs/2
         JznSMWC4qnla9KfW2632Ad1GsmJoBJODtnIPrKJ7T2JRS7Shr77NtifwRNERcp0b8UK1
         3NAY94fc5MEq4G28txOKpTmvxGxjfCiN/EPpvwe1CBgsz8u/bMW4O5gnM7xSpuoVwvGJ
         v43Q==
X-Forwarded-Encrypted: i=1; AKwUvByhernYR2vWplChfKeTyo+5XZdoYpkm3B23LUZ38wcgrdxh3DkahLay5r7QUGIJnbnxKKk=@vger.kernel.org
X-Gm-Message-State: AFuF++nV8DW5AGjfOBzBHMV/nXGV+ZvuYdNFAZnfk2l8yyILFM/ze+Yg
	6cvVkZzCTbGeD4bZ+Gsvqo597wVpFOaXLDDRh8tghwjF/+guJx+icoE+KmAY1i7iTeZu2G6lXSl
	zUj3uAA==
X-Received: from plih6.prod.google.com ([2002:a17:903:37c6:b0:2dd:4a8d:e22b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1211:b0:2d9:3bee:4f32
 with SMTP id d9443c01a7336-2dd8e752eb8mr73324115ad.20.1789581650896; Wed, 16
 Sep 2026 11:00:50 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:00:49 -0700
In-Reply-To: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
Message-ID: <aqrZUZtSZ-YItclT@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Dave Hansen <dave.hansen@intel.com>, 
	"kas@kernel.org" <kas@kernel.org>, Elena Reshetova <elena.reshetova@intel.com>, 
	Yilun Xu <yilun.xu@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Peter Fang <peter.fang@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026, Rick P Edgecombe wrote:
> Here is the overdue analysis of what a TDG based TDX quote operation coul=
d look
> like, pulled together as writeup somewhat quickly. This was from Sean's r=
equest
> originally. The writeup is based on a bunch of gathering by Peter, Elena =
and I.
> Some TDX interrupt input from Binbin.

Thank you!

> This DICE quote generation can take a long time. Exactly how long is not =
known,
> but it is expected to vary and often exceed the time a SEAMCALL can be ex=
ecuting
> in the TDX module by a considerable amount.

What's the ballpark?  Are we talking tens of nanoseconds, tens of microseco=
nds,
tens of milliseconds?

Is the CPU spinning the entire time?  Or is the quote degeneration I/O-like=
?

>    It is not nice to keep the guest from running for too long. The TDH.QU=
OTE.GET
>    SEAMCALL monitors for host interrupts, but not guest ones. Similarly, =
the SGX
>    quoting enclave doesn't know what is happening in the TD. So, to help =
reduce
>    guest latencies, the GHCI exposes a way to register for a notification
>    (SetupEventNotifyInterrupt) when the quoting is finished. A quote TDVM=
CALL
>    handler can start the quote operation on another host thread, and resu=
me
>    guest execution waiting for the quote to finish.

To me, this just *screams* for a virtio-like device to provide quotes to th=
e guest,
especially if the slow part of quote generation is I/O-like.  Even if it ho=
gs a CPU,
an asynchronous virtio-like interface would be far easier to support.  E.g.=
 the
userspace device backend spawns a thread (affined to the same set of pCPUs =
as the
vCPU, i.e. to "tax" the guest instead of requiring dedicated "overhead" CPU=
s),
and kicks the guest when the quote is ready.

Ahh, that's more or less what SetupEventNotifyInterrupt is.  I guess that's=
 not
the end of the world, so long as the backend for SetupEventNotifyInterrupt =
is
handled entirely in host userspace.
  =20
>    A resumable TDG quote call would have to solve a slightly different pr=
oblem.
>    A bad guest could refuse to resume the TDG call and hold the TDX modul=
e
>    extension save state slot hostage.

The whole "what about guest interrupts?" thing makes me think the quote gen=
eration
is CPU-bound, i.e. not I/O-like.

Does the TDX Module *need* to provide a save slot?  What would prevent TDX =
from
requiring the guest to provide storage for whatever in-flight data is neede=
d?
That way there it doesn't matter if the guest never resumes the call, it ca=
n only
hurt itself.

>    So instead, a TDG call could work by remotely canceling another TD=E2=
=80=99s paused
>    operation if that TD didn't call back frequently enough. After a time-=
limit
>    was reached on an extension save state slot usage, another TD=E2=80=99=
s TDG call
>    could abort the stalled TD=E2=80=99s operation. There existing designs=
 around doing
>    this cancellation already in the TDX extension arch. It would need to =
be
>    adapted to the guest side calls and incorporate the extra cancellation=
 work
>    into the time limit math. Some good timeouts would need to be picked.

...

>    If a quote operation is long enough, the TDG SEAMCALL should probably =
support
>    a resumable-like flow from the guest side too, where it also monitors =
for
>    pending guest interrupts and returns from the TDG call to let the gues=
t
>    handle them.
>
>    Then the host wouldn't need a thread and a completion guest notificati=
on
>    mechanism. It basically transfers that complexity to the TDX module.


>    But it also might transfer some of the control. The TDX module would h=
ave to
>    embed some policy on how to decide when to inject guest interrupts. If=
 the
>    host and TDX module had different logic on when to actually re-enter t=
he TD,
>    that could be annoying.

But the TDX-Module already has some policy, no?  In the sense that it decid=
es
when to exit to the host because there's an interrupt pending.

> =3D=3D Summary =3D=3D
>=20
> From what we found, I think it doesn't seem overly impossible for the mod=
ule. But
> the exact cancellation rules and timeout logic would need to be hashed ou=
t a bit
> more.=C2=A0The simple mutex on the host side does still seem a fair amoun=
t simpler than
> the TDX module's fairness options.
>=20
> How do we feel about the roles and responsibility shifts? Any other probl=
ems to
> solve?

What about the whole "TD-specific data in the quote" thing?  If getting a q=
uote
(or report?) is punted to the host, I'd still like to keep it out of KVM.=
=20

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01A3BFE24
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821451; cv=none; b=HM4aan9NCBoliVN9O+5Z/mcSwydpREJU55sJu6UwhyQ4z5P24N+vrlNRLNCOXmnHleSV3wIsqBVDsZMy01cOW7swiun+HwXfv42NFkAfoRdifOZ850AceoGOyJf7AuJsi4o8XKef3p32Vz8C2beliMvEboEUfb29uQwnHUnJQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821451; c=relaxed/simple;
	bh=g/OnkkyRx0zzedtsLbDYYcuHrTucGvnPwjn0juWf8KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KTSEkUiHenDclNyvJQrhvv6jw9RiKm2e5uCePI1BP9fyjpTaYyQgQfDgZIdsyr3VROtuWf5NZEXa6cddv8cmDoRZNc4ranTb5U35mqReLYsYaf1Cv0LDawT/20rj6ltFUJemfNq/niDnpouo4rXDQMsWrbEBuQ+0CTatHAS+8Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7N+xtbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7N+xtbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353FB1F00ACF
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779821450;
	bh=Nq/BwNTq8jAtzNULC/+90W4eHS56uIQr3hvZxrqeGWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C7N+xtbqHxS3h7NSfle55r0+VuM5cCjgqBpW0llKd9iiConazWQy0LwO3SVLjzK7H
	 5qclFaA37X+PIKqAYUV1BT0TIQJArNkPsFg2FFQ/XU72YH6RFrJJO4Nj1pjzAfqbmJ
	 4NP1PsdydFmeRedBmwu2SxgPQRwgQ9oiEnQvNi9+QEiMaHL6cZM79ykWqykOZGiMfQ
	 4kU0IqX/cXRL10A87E0b4dAxzAZsojtv2z1BUBduRCd/4tQ9UIAxSlIDOLUucwq4n1
	 OPlNzGIie4hrjfxWO3jUn7HPNkBzYzuGIArpmTG4RMdJqau1OZ03KJoNTw9mWz8Q+V
	 T4+5pfWh0VB2g==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so1640662166b.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ84SoGAtTw/u3i8wKNoLrM8o+JO6p0+osyp2bLxY6pwr4s2WY1vZRS/Xa2TurE/rjgJBqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaj6SSj+jvFyDkxy6UvTohOiQZki5qw8mrHxxhgCB7r4s1zaVd
	O2Wo8kJvJl/diOyG1s2E6QS+JeY9eIuKnQPWI9xDtKp1XLq/9LE0prY/oJFIptCPZdjnjROFiON
	lv9V09UBSnxJmoPAZGyCFvYWqhhbt2w4=
X-Received: by 2002:a17:907:b14:b0:bd1:4da0:b0d3 with SMTP id
 a640c23a62f3a-bdd229317c5mr845955066b.9.1779821449113; Tue, 26 May 2026
 11:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-4-seanjc@google.com>
 <CAO9r8zP-t3YsiXNZm2beR6RcRZaDN386_ktmipGm+sA=2PGcaQ@mail.gmail.com> <ahXp9V3o0bWVi1lj@google.com>
In-Reply-To: <ahXp9V3o0bWVi1lj@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 26 May 2026 11:50:37 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMGwUszi1xvi4WU1M85ZZWTDTfbQacjBfNDw8+QS4WDOw@mail.gmail.com>
X-Gm-Features: AVHnY4Lj-UdrOuTNIP3DIyC7N66OAcTr-F0yVlAYsJrxWWmVRXGdfIlYudFnrE4
Message-ID: <CAO9r8zMGwUszi1xvi4WU1M85ZZWTDTfbQacjBfNDw8+QS4WDOw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] KVM: SVM: Fix nested NPF injection of
 PFERR_GUEST_{PAGE,FINAL}_MASK bits
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="UTF-8"

> > > +       vmcb->control.exit_code = SVM_EXIT_NPF;
> > > +       vmcb->control.exit_info_1 = fault_stage |
> > > +                                   (fault->error_code & ~PFERR_GUEST_FAULT_STAGE_MASK);
> >
> > Do we need to do this in the common path?
>
> What do you mean by "this"?  Pulling flags from fault->error_code?

Yes, sorry if that wasn't clear.

>
> > If from_hardware=true, can the fault injected by KVM have different flags
> > from the one produced by hardware?
>
> Flags, yes.  fault_stage, no.

Right, I meant the flags.

>
> > I guess the answer is yes, (e.g. if KVM is doing write-protection?). Might be
> > worth a comment.
>
> Or if L1 has modified its TDP PTEs in memory, but hasn't yet flushed TLBs.  In
> that case, KVM's software walker can see the updated PTEs, while hardware may
> have seen something else.

Makes sense. A comment would be helpful for laymans like myself.

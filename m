Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391712C0285
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779143191; cv=none; b=ZzrgHTepopAf8LTLxbj0CxFHWTeg4vOmHg999gNLCiJ2yyM224/y7vJqg7E+JCQiLWLlQ5lfx9kGMYVXIguELh9jIrTgGHQsLjoLMV23A7EGaPiD+wBJqEX/rssl42lbRcAn0Pu1txw4r6BpQg7DUZwRJ9BteK4mtO8VWcXaL0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779143191; c=relaxed/simple;
	bh=pAiQ8weQnD8kYLZNRdjn/Xj6tyCUVAWdYrNxRH/8f/M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F1qsY/t+wlsSqOnKiFKnabWmJEXt5kKQO0M/+4mdFCC2L7/ku4EDShckHMwKhvzR+SICGe2nsrR7moLOzXUvze4i6ebhmovprSyjkFm03bxEzLJMpUKIPHb7mh/IU2+IIAk+YSLLj1hmrxRHUHYxaQJbmBS8IZcbISImyyoif98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=quPRU/Y1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="quPRU/Y1"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baf7748d0aso26948165ad.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779143189; x=1779747989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zMAAYUYdETKDGsjR6KGZ12nZYWyeb5UUSXBwnlv7L8=;
        b=quPRU/Y1ODhFXmmo4C0pijEANsHYsqLD3NmpiaF/H2CrU7VyTEie4PSXqpmbGoJYjE
         abaBvK/hKqMiRceRAvZ4trq1Xbwidmaghce8zL10y3mBUPbYutK0xEVBi1Q+eF6azIuJ
         aZItcbdrjVvp2knj2Voen7TDx+ggLnpfDxubYpJz9RaIS/LwnIblAkK0unRrXC3qzg3c
         1LsOkwtrp18A1fS+p3yD/hoiRi+TqnwbT+QsxnmCnNE/OgrcCJHVrMaKWczFw6G4qWxG
         rci35WGoP87R4M7GB/7WS5sBo7yNkxJall3D8HpcyxKmTraj8/rvAvchmsMHkYuCnpEt
         75+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779143189; x=1779747989;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4zMAAYUYdETKDGsjR6KGZ12nZYWyeb5UUSXBwnlv7L8=;
        b=eUJh9j+hi8+26pH/7uenejg0FuOF6M4ZWdDMlNyC/moi1BLRVrvEv7ZLYUONZt+90V
         03YVjF0PC3cav9HBLS/O3H7j3CfZoLyap9HsuMb+XMaM7N/WfWH3BKAKJ0b0IOr5dCsT
         doys8MSjNYCKoX4TuCkU+0XPODbzkPO/AZn2WOv6qbppnYvJXuy+TYeF+Fp5ypMMI9ZB
         F1Fqa7plU2F79TVjldJg97BShkCUyJFOOd7jrlFU4t1lxuzvz8DcxSt21C0/ixw2wJLY
         1yhBW6epfzvPTU98VEuBPLcRMt0oOvbtsBFcry88TaCo2Wq0yy76bXODI54W7mrg+deo
         Gskw==
X-Gm-Message-State: AOJu0YzRRXo4NY9iuWV6KB2VK2xu0uUT2u/ztmWmM7sRYwGT7rD8Z8NP
	Ay3mtTgFtXrJGVzJXwyo0Onn5fo/nrZ5AWU7oe4JhLpkiBDHRPrOK4RpHUNzOLr6Pk6QSRsotvB
	J9Omf8Q==
X-Received: from plbkn8.prod.google.com ([2002:a17:903:788:b0:2b0:b410:3605])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:b409:b0:2b7:975c:dacc
 with SMTP id d9443c01a7336-2bd7e8037f7mr128805045ad.1.1779143189179; Mon, 18
 May 2026 15:26:29 -0700 (PDT)
Date: Mon, 18 May 2026 15:26:28 -0700
In-Reply-To: <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <agt_1yfdx3YmjYei@google.com> <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
Message-ID: <aguSFIoEbE_PPpeB@google.com>
Subject: Re: sashiko-bot@kernel.org's Cc list on reviews
From: Sean Christopherson <seanjc@google.com>
To: Roman Gushchin <kfree@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026, Roman Gushchin wrote:
> On Mon, May 18, 2026 at 2:08=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Hey Roman!
> >
> > Sashiko's choice of Cc is... odd.  The original mail has a whole pile o=
f folks
> > in both the To: and Cc:, but sashiko-bot is only replying to myself and=
 (very
> > bizarrely) linux-hyperv@vger.kernel.org.
> >
> > Oooh, is it perhaps because linux-hyperv@vger.kernel.org is the only ma=
iling
> > list on the original Cc that has opted-in to getting emails?  If that's=
 the case,
> > we might want to change that, even though it could result in people get=
ting grumpy
> > about unwanted bot mail, because IMO the alternative is worse.  I've be=
en responding
> > to some (mostly very good!) good sashiko-bot feedback, but only just no=
w noticed
> > that the vast majority of folks on the To/Cc of the original patch won'=
t see the
> > reviews.  That's bound to cause confusion, e.g. if someone reports the =
same issues
> > and/or manually looks at sashiko.dev.
>=20
> Hi Sean!
>=20
> It's expected per configuration here:
> https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_policy=
.toml#L138
> .
> It can be configured to reply to all as well, but since there are some
> very vocal anti-AI folks in the community, this might create some
> friction.=20

Heh, "might".

> In any case, I'm relying on the corresponding maintainers' decision on ho=
w
> they want to configure Sashiko.

What level of configurability does the parser have?  Specifically, can it k=
ey off
the Cc/To in addition to the list?  I ask because I really, really, want to=
 enable
auto-mailing for at least KVM x86, but kvm@vger.kernel.org is wildly overlo=
aded.
I could try and drive consensus across all 30+ maintainers, but if there's =
a way
to precisely enable it for just KVM x86...

E.g. is there a way to do something like:

[subsystems.kvm_x86]
lists =3D ["kvm@vger.kernel.org" && <email is To: seanjc@google.com>]
reply_all =3D true

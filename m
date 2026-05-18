Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBF192D97
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779148766; cv=none; b=tp4k8lQmwEv0ZJ3O2ktrR7E5WRhKaB2Z9XQ/uDxSsxp+QZ//Hw+jfNoZPcLa2bMOQsjFYL6Ii5t5JhMfJhgMCUiYmtJT5FVh49ZYOjlgiP1a64aa6fy0MR3XZtmf+ySuQnTZLSPdWMVf4+m/6EAwaemGEMRZOR4rQ2hnvO5YTuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779148766; c=relaxed/simple;
	bh=M2JO54/T29iTHbfw2ECqj0TSL6Kfm2Z3nn/1O5aeuQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p5wZPp7R+JmE9ji9jPLBuKGViZegJUf1ir6dtH2m9nNXybNxSd0ReMbzB93A0pwuaflSHX2JfSShZe20ySWeplkG7CWPS53uehQARYBfMd4W2ekg0C1d/XiFkPnUzzkikJvnZCQ1K22/AITnUaPlTT8eRc2dsGT1a5iDJjI7dGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fTjx7Mw/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fTjx7Mw/"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82ac893940so1294754a12.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779148765; x=1779753565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjyDZODCsY4T2fLhqAwfuKyPq9OO+rzN9BmDMARSEFg=;
        b=fTjx7Mw/ZJ0LY4atRYaIvOz2DygpIE2UP/avGQWRPpTpy+X/I/o+u7p3cxc8FUGupm
         IiUIHBIgyP3OlVaroFLOIbceRe932hhvNHpDcwh5qhU/SQ96ikmcRo/+9BEmO5QdQgGj
         E6NGRNLPKI0KM5o6OfMXIPk7bVgGlKWpU4FhIpZX/ucm39M1XihxirckmHNgkHk15FKD
         OQK0SwRqcmaJtyQDiN26xDQIVIbw9X5XMle6ixjwBfe3ug9Upmq+ZVIuZHGvn4hd6Dmt
         9GmGquZfIcm/7IC0mVtmqKjHFh3DXxIgT5UBeMT7LTyyeUpZgMjZLBJQVf1dE7acsVOt
         jIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779148765; x=1779753565;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjyDZODCsY4T2fLhqAwfuKyPq9OO+rzN9BmDMARSEFg=;
        b=cEqtzkLlf4SN1moL+hGHkSdGmvIp62I/H/E4HV3DDTWbkJ3u8M8Y1I93Gkt9FpkD+Z
         A/TqJ4jnZd1Y/F/gibYpKuf/nBp7xX+P8zLVzAzncbrHmRb+LtTIk9sqNp4u8gP7lmMH
         RgvicgSdkCfxEvSaePvqDq09YSnIZhJnkqFpPgSesEkrUFNsRRi4cle8c+Gbj1I1U5Ri
         O6xcNPIcyTiYpkSFPs7NuoC6vEvoly5NUKAf+0WEeUrNgVQD1bRmgSboMHfz8nj329SH
         WXhvR8RQK+gpQY0Qd+hQWY9uNrQWdpyXOu3t6BLdcWkAgNioda1L5mg4O5k7UFy4boKP
         Vw5Q==
X-Gm-Message-State: AOJu0Yzmh1DwVjEgCYNU+wEuu+ZkkN9cgGNQR0WTOmjl+OyeN7HJGyjl
	4Z7wyzkwH+2IhA/jIwKisMptKpnkD/RiTa+WL+vsyO3K3sSptu1sdAFxGBGvpAKdecpVaC0txpY
	vKo6hiQ==
X-Received: from pgc19.prod.google.com ([2002:a05:6a02:2f93:b0:c73:9dbd:c981])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4305:b0:3a2:d68d:9e80
 with SMTP id adf61e73a8af0-3b22ebcca49mr19839378637.29.1779148764627; Mon, 18
 May 2026 16:59:24 -0700 (PDT)
Date: Mon, 18 May 2026 16:59:24 -0700
In-Reply-To: <CADKH=+2sHHR8M5qjDdjt6CjKOwdte_p8w03V_-kF7P1NwK9E6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <agt_1yfdx3YmjYei@google.com> <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
 <aguSFIoEbE_PPpeB@google.com> <CADKH=+2sHHR8M5qjDdjt6CjKOwdte_p8w03V_-kF7P1NwK9E6g@mail.gmail.com>
Message-ID: <agun3LseAsc8bmnk@google.com>
Subject: Re: sashiko-bot@kernel.org's Cc list on reviews
From: Sean Christopherson <seanjc@google.com>
To: Roman Gushchin <kfree@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026, Roman Gushchin wrote:
> On Mon, May 18, 2026 at 3:26=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > On Mon, May 18, 2026, Roman Gushchin wrote:
> > > On Mon, May 18, 2026 at 2:08=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > In any case, I'm relying on the corresponding maintainers' decision o=
n how
> > > they want to configure Sashiko.
> >
> > What level of configurability does the parser have?  Specifically, can =
it key off
> > the Cc/To in addition to the list?  I ask because I really, really, wan=
t to enable
> > auto-mailing for at least KVM x86, but kvm@vger.kernel.org is wildly ov=
erloaded.
> > I could try and drive consensus across all 30+ maintainers, but if ther=
e's a way
> > to precisely enable it for just KVM x86...
> >
> > E.g. is there a way to do something like:
> >
> > [subsystems.kvm_x86]
> > lists =3D ["kvm@vger.kernel.org" && <email is To: seanjc@google.com>]
> > reply_all =3D true
>=20
> No, currently it's only per-mailing list. I did not expect that it
> would be that contentious.

Before you go add more configuration goo on your end, let me see what the o=
ther
kvm@ maintainers think.  Maybe we'll get lucky and everyone is on-board alr=
eady.

> Maybe it should be based on entries in the maintainers file instead.
> But even then, what if a sub-subsystem wants emails and the top-level
> subsystem maintainers are against it? Or if a patchset touches multiple
> subsystems.

Hmm, maybe use a page table walker approach, and only send emails if every =
node of
the tree says yes?  Only getting email some of the time would be pretty dar=
n
annoying though :-/

> I mean if building a complex configuration system is the only way forward=
,
> ok, it's kinda silly, but why not.

s/kinda silly/flat out stupid, given how easy it is to filter/ignore email.

Crazy idea: as a stopgap, what if sashiko emails linux-kernel@vger.kernel.o=
rg if
the list hasn't opted-in?  It wouldn't be as good as getting mails sent dir=
ectly
to me, but subscribing to and filtering linux-kernel@vger.kernel.org mails =
is very
doable.  And even without subscribing to linux-kernel@vger.kernel.org, for =
those
of us that heavily utilize b4, it would better than clicking through a web =
site.

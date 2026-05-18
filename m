Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F85229B228
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146870; cv=none; b=kqKK4l/liVoSLCLZ9hsYyCnWrhV9qPz5jb6o4kTKpUqmcTv7t97X/AtRjLBcVBr6HdeagizebtMkkTyVXkFPaes+bEZzvTA/e+DOwSa7fWUcEfdNPX5P+UX4bcUFvlLWUITNL+5fzWujSVq2cgRHMRZ9al+0q2vdXd554aojxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146870; c=relaxed/simple;
	bh=LveWEQjaE69imEDVnKHgoFrnNq3PUs1D6OYrC+OM+Q0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JkUqN8uzQvmDhlaiPAh1yoqARikKGnqHYKS2iGV8pFYfwlg2s+PWOqwBH0SODa/JIayEx00oXIapyAoYIXYfpsXo7t5hUUA/b7VFEAQA9fJptNtKRl6f+4waE4GdMxEWUTnzusVO+IuO4pimVr50hWsbbH1b7abGDOqmTGLU1ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFcVwE4z; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFcVwE4z"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so1607290b3a.0
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 16:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779146869; x=1779751669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Y+xPAwIC8eSb48BdESvpMKCt3vsSSWOJ9eLuR912qI=;
        b=sFcVwE4zcje5T8O3Zp3PlTO2p0Byxojnj3wg/g3/556jNuDCyqpBLvbdAakmKIpyLc
         2LBxxvPCFUQdukMUkG5S9WSTRVMCHlH6HmO4AE2MsgB91zgKNvWpUr6VE4YfRGvjwfq6
         8P6IE4ik92wSYN8NkvMnR8zn7PdlD3qiRZi5pF2f3Je3GB80Vj4+sCGWMxG2gm7tTnNO
         kdMPOTwACbkLR5UmrkdZeW79LwLJfMqhG4urcnQ8q7w86J+crDQTuGB2A+cSY4BczoVt
         qm4/IOihzWPSphCISy8KevNwCH1g2AG7cOTVAothhzC87smE84up9diA7kw4bJ3OzhE2
         6bwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146869; x=1779751669;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Y+xPAwIC8eSb48BdESvpMKCt3vsSSWOJ9eLuR912qI=;
        b=PIEs678bhaaCNY6euKzFz2/H3dilleN6zBbQPVAqoWo606hxkjSi2+pfEDDd/vWaO3
         vTB5+ROkJ35sx87b5sM3p2XNVRTyjDq6wuAJps5PHCqA6jhFTJBH3I4DsCiXfasBYKZa
         6qHnkEmoN1XNSHfCm2F29suP+G4pwOXVa26N05+XZaYFqXxzBxPGRTL/4J1Rx5DevQr+
         zzk0wB3AIZrolRaULy5Og7HT00d1P25wPjiPhb0QtR2/5tD3lIbYYC3mAz/xp3uyUNwZ
         iTHx3Uae832dbV9vxPWK0Y5MS+FWu2SHdSVcP9ZTR+wceVw/75on4vOnn6uHFwZyj/W4
         b3lg==
X-Gm-Message-State: AOJu0YwHCYc+IjY9J4e0MAY07dJUusInku7CZNISEyYsTsvLkadTAp6s
	fPoQt6Qma+Lf9g24GXrZWdi+WS3JkPiFB7ZHzgCEP6J04w522KuPrwkxDIbcRaVptnAZ3iAGM/M
	iYGSrcQ==
X-Received: from pfbg13.prod.google.com ([2002:a05:6a00:ae0d:b0:838:f05:69ac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12cf:b0:83c:928:6e5a
 with SMTP id d2e1a72fcca58-83f33c8794dmr16843008b3a.13.1779146868490; Mon, 18
 May 2026 16:27:48 -0700 (PDT)
Date: Mon, 18 May 2026 16:27:47 -0700
In-Reply-To: <aguSFIoEbE_PPpeB@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <agt_1yfdx3YmjYei@google.com> <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
 <aguSFIoEbE_PPpeB@google.com>
Message-ID: <agugc_uo58qXHN98@google.com>
Subject: Re: sashiko-bot@kernel.org's Cc list on reviews
From: Sean Christopherson <seanjc@google.com>
To: Roman Gushchin <kfree@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026, Sean Christopherson wrote:
> On Mon, May 18, 2026, Roman Gushchin wrote:
> > On Mon, May 18, 2026 at 2:08=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Hey Roman!
> > >
> > > Sashiko's choice of Cc is... odd.  The original mail has a whole pile=
 of folks
> > > in both the To: and Cc:, but sashiko-bot is only replying to myself a=
nd (very
> > > bizarrely) linux-hyperv@vger.kernel.org.
> > >
> > > Oooh, is it perhaps because linux-hyperv@vger.kernel.org is the only =
mailing
> > > list on the original Cc that has opted-in to getting emails?  If that=
's the case,
> > > we might want to change that, even though it could result in people g=
etting grumpy
> > > about unwanted bot mail, because IMO the alternative is worse.  I've =
been responding
> > > to some (mostly very good!) good sashiko-bot feedback, but only just =
now noticed
> > > that the vast majority of folks on the To/Cc of the original patch wo=
n't see the
> > > reviews.  That's bound to cause confusion, e.g. if someone reports th=
e same issues
> > > and/or manually looks at sashiko.dev.
> >=20
> > Hi Sean!
> >=20
> > It's expected per configuration here:
> > https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_poli=
cy.toml#L138
> > .
> > It can be configured to reply to all as well, but since there are some
> > very vocal anti-AI folks in the community, this might create some
> > friction.=20
>=20
> Heh, "might".
>=20
> > In any case, I'm relying on the corresponding maintainers' decision on =
how
> > they want to configure Sashiko.
>=20
> What level of configurability does the parser have?  Specifically, can it=
 key off
> the Cc/To in addition to the list?  I ask because I really, really, want =
to enable
> auto-mailing for at least KVM x86, but kvm@vger.kernel.org is wildly over=
loaded.
> I could try and drive consensus across all 30+ maintainers, but if there'=
s a way
> to precisely enable it for just KVM x86...
>=20
> E.g. is there a way to do something like:
>=20
> [subsystems.kvm_x86]
> lists =3D ["kvm@vger.kernel.org" && <email is To: seanjc@google.com>]
> reply_all =3D true

Actually, shouldn't this be a line item in MAINTAINERS?  E.g. an "A:" secti=
on
to describe the subsystem's preferences for AI reviews (and in the future, =
other
things?).

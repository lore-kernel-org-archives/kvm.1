Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5403195E4
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147324; cv=pass; b=q0YOEo7iRxqpLaEg6wVIyKw5+hbWNcZ2Y9zVlWY4pUuYauFWasFnTTGev0AcfFsE8t0AEfBdxOStBRDNFYR+TShkgoVHlx2rTwvCoCp4ykC6Gkl88/tbOETp0/T+A+0xBftUXg/07+FrQlh4XbksxmUSGrXsQRCIZfyxAxCuSzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147324; c=relaxed/simple;
	bh=MwNfUhYUnOZ1uo5nR2wJEKx9toMpMh+8seMMRoS+86g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEmMWrOsaV3v860Ie9J5a6agLJwiqToDO8aM0yO0qRPJqDxV08ZykrIK+gb6mznb6IT3ASHmh/MjBv+txvVW22sx0Ch1R9a00/gc/G1pDr2dPf5SvmQRvN9XRpIjS2M+ccMcp5GPWT30cVw+goZ3NaKOYp3d5mF/CE8r8nOvlYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m35VFafV; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m35VFafV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50e61648f10so5011cf.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 16:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147322; cv=none;
        d=google.com; s=arc-20240605;
        b=HhBANvHevLT2gaOkpFvKezQHGkUsu9T0joDpjpw+fs997PETBioxwBCdr+xCO8LF4E
         PTCQ8ATmMdMNKRmG1mrudN4L8HZSdRQfiMOfzTdsXISkDYqnuzhkacpJ4ApMm9XJjpG7
         WvgrRoaCXlPc+NVmpeAa9pbCtyLD0ZCCqfEgxHKI0sdd4qatUuulVR/8WMOsWxfHiWor
         hDzEN4rZbT7BmedAgHNbAUjMlJfg+QiNFE1UDbL5L6A1p6u59Jj7CmWPe882jgX6GZ/H
         PLT4TaQoVANIael1P/LbfBlyo4wBtN7ngpOwWbaIWY8gsiuV3XZr9cbBKvk5gQa5DnSU
         lHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JoMmqs629o4jjqIBWWMmDR7pHYY2FGw+FMuTWiPkuO8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=g/Af257HcmsTvXw5TF6rAQT33ngoFbVI/q0pA+5aZtlQEI2tROtwLXVfmwdsJ5uGVD
         PkhDtWMeW10JEFSgvC9WgcjEWOm9N3Mz/YtwduAJp1a40j01lzvN9ghiuFcJy1vYBw5Y
         82+uAf77riElZzInnDw+dUKMzLtM4ZeL/9zP0udDydPdXuVzfmJePgJ5QhtC2aHnNP3B
         JBgWNzTW0EjVQufEfx1E117pN47YHSxP3m3Y4c4+eeswwZjSkdvJlu5FUrOHMYcu8bxL
         ibtTtSPbqwpZgjUJzPpmD4PbBh2kXRnrzPS1x2X5az/pVrkpwOI+uUGhg1Fg2ewhA/qF
         FS+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147322; x=1779752122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoMmqs629o4jjqIBWWMmDR7pHYY2FGw+FMuTWiPkuO8=;
        b=m35VFafVzyWzGkwz6qUOXqJQTzEWQH5NsXga81LI0wLxXwDOWHQdzQZThQ8mGAdoy9
         ww7KSgSyhKDcttGu0fQAD/5H8iZy7sW6l48oMnB1Uxhd5+D/ZzKFVBfxAvW2dTJeDh90
         yO6trQRDIl5oTVDZcJrLV2g/pB6rfXZUR/gEcAiPjXFyJFqcgT+VMwe7oVyJOZOZ1/dK
         +hTyhlUQerFAbLyzJQisGmCekO4SZHGiDOd6w5gM2wJ5nYYzSaQ0LyLmIOhw7AhwJi/v
         I0IMZKeWArx9SYK8xA8lYtb19WIvptnkrMObQc0ylT+cvvRHtWO5GSK4unbn7zFa2Y9t
         6+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147322; x=1779752122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JoMmqs629o4jjqIBWWMmDR7pHYY2FGw+FMuTWiPkuO8=;
        b=RWVHlfsoaUQRSf5HwlJYxqt3IkJxPK7CdxRNPQNz+vSIcaKPuCGnKtTkVaa6eoA7P5
         1iVVVxWzf2F8ID3ZiwQDY+VabMPHh4ZIdrljpra/GTJg/KjABxZUDnk04VKAWUmmQx4Q
         H4Bgi/FW+JZ5fPmlKJszA1bLwKCRE9ZyK+XolQAbYBE1chcLNDXBAI0wKb3oFTSdbPrK
         VzCP+iBgI1bmObyNUvCcXsvcPL/IGSwTCL/t0YJUGZ3jwvlX2tZ0Ia8+0tasbtZdn2Ji
         tSj/TlBhB14os+RSKmxCEBOTJkk5tAbgP+DRDdKwOEvfUKDpR31KfRFhulkvcyljeEif
         CqCw==
X-Gm-Message-State: AOJu0YyDP82eFVayDDbJKCWMwbDVmE4rlSkWgcxDWYc+SDD7bpwf6WoK
	0xoyMgti+XMfSlarUklJo/s0S6/oQ49DafoxJHrxqv2phsllgKERgFAVY+w1CbJI9tHRjKMGr+E
	/M5RIIFS95oDUpiA1xsLX3/vmvwyNTZUCKjV5JeC4
X-Gm-Gg: Acq92OFOPtCQWbQXeEozrpB/uXp9E6ftQDhyC+Ga20iXFjYXncuGi5eb30NhDx8sH8y
	CSKTr4Dmx6Q4o4iRgaRVXYITGKhUuW2rYD4jMcZ2BxVpAlrx9mn4qw5CKrBoSBiHPhX7kBuK4GN
	snk5k+emkuYgJ0uH3IyQ2o90SkX59EbtAFTTcE3o6Tg3bfo+T1cfdgkqsmvu9LsL0HRfViiQTCt
	UHNNUFuuCkwF6Uqc6Y2fnTypiwOD1FJGmQJg6APhkajDhtkJ+ni7r01xKz/+Ji+kGRYTSkoYic8
	/9G5crTnX1b2ExQI4XYVXq3mFrcKp0MR3xGmtpuxCcfCUaRCQibeurUu8gcwNYIX70QqW623d8c
	Mvt4/bGM=
X-Received: by 2002:ac8:5f91:0:b0:50e:41f3:6467 with SMTP id
 d75a77b69052e-5167943f41emr23521401cf.12.1779147321533; Mon, 18 May 2026
 16:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agt_1yfdx3YmjYei@google.com> <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
 <aguSFIoEbE_PPpeB@google.com> <agugc_uo58qXHN98@google.com>
In-Reply-To: <agugc_uo58qXHN98@google.com>
From: Roman Gushchin <kfree@google.com>
Date: Mon, 18 May 2026 16:35:09 -0700
X-Gm-Features: AVHnY4LI1lz6UyYX4k8ORf0V8c0J1m-w7Ck8S9Gx7cbGxiZ_3kHUSBsWPV4w95w
Message-ID: <CADKH=+1SNyrCKfvCwz3Gz-VhHQzs1fo=juKksSb8Q-VqtXpyMA@mail.gmail.com>
Subject: Re: sashiko-bot@kernel.org's Cc list on reviews
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, May 18, 2026, Sean Christopherson wrote:
> > On Mon, May 18, 2026, Roman Gushchin wrote:
> > > On Mon, May 18, 2026 at 2:08=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > Hey Roman!
> > > >
> > > > Sashiko's choice of Cc is... odd.  The original mail has a whole pi=
le of folks
> > > > in both the To: and Cc:, but sashiko-bot is only replying to myself=
 and (very
> > > > bizarrely) linux-hyperv@vger.kernel.org.
> > > >
> > > > Oooh, is it perhaps because linux-hyperv@vger.kernel.org is the onl=
y mailing
> > > > list on the original Cc that has opted-in to getting emails?  If th=
at's the case,
> > > > we might want to change that, even though it could result in people=
 getting grumpy
> > > > about unwanted bot mail, because IMO the alternative is worse.  I'v=
e been responding
> > > > to some (mostly very good!) good sashiko-bot feedback, but only jus=
t now noticed
> > > > that the vast majority of folks on the To/Cc of the original patch =
won't see the
> > > > reviews.  That's bound to cause confusion, e.g. if someone reports =
the same issues
> > > > and/or manually looks at sashiko.dev.
> > >
> > > Hi Sean!
> > >
> > > It's expected per configuration here:
> > > https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_po=
licy.toml#L138
> > > .
> > > It can be configured to reply to all as well, but since there are som=
e
> > > very vocal anti-AI folks in the community, this might create some
> > > friction.
> >
> > Heh, "might".
> >
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
>
> Actually, shouldn't this be a line item in MAINTAINERS?  E.g. an "A:" sec=
tion
> to describe the subsystem's preferences for AI reviews (and in the future=
, other
> things?).

This would work too. But when people send patches (including
LLM-generated patches) get_maintainers.pl
will produce a combined list of all relevant maintainers and mailing
lists. There is no option for "I don't want to be cc'ed
on patches from mailing list X". It sounds like some folks are looking
for this option for AI reviews...

Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FC29B228
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146848; cv=pass; b=ecWxYVFs6t9C1eLfKrXnIcBTBzaoj7fOUQohIH4bjkGrQeUrNnQPlvvF257ThqR8dUlNC89rDZUtJdQRsoFApFvy9HpVftf8G5hni+Vb59NqO6u8/pa7QDkUBF7uImH7RSdCYvFdALyXCT7poxE0UAHWmym+bxXQsxSLUk9rESM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146848; c=relaxed/simple;
	bh=yg01BXHRsGNodJNQJmmtjcsC7Srt+3YrkE2ndWpUMZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJZXd61DmSh+gQCOHmotk2KYcmUTycp07SynFWCj4yHR8ZOBbYQbQIoH+VWfdUNT0ozg56hmDEr+9Nf2JG94NwHMpd9fPzQI/AxjjxacnTfiHICfVSUe6WOYwDjiS+P0BIxJZ3AFQLwSdT0LJiYFqfTRRNlz5QY4LmeHfn+ECO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+PilL9r; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+PilL9r"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50e61648f10so2291cf.1
        for <kvm@vger.kernel.org>; Mon, 18 May 2026 16:27:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146846; cv=none;
        d=google.com; s=arc-20240605;
        b=YwLonxdc2TqRbg/Sg4eTS2a0LIMpyPmY8FCfmEBBK7l4mfzRIN9oY8Syx4vGF9/kFr
         ous471BDDxfdTHDKukv57W3eRiJt5UV4HKLw5G8BQIE3a6C5re2LscxF5hM5o5W6+OhE
         xza4dDu2joMf1FJu+REaW/2F2/lZx+r2D+Sta72m8KbLvUZOHQOuJfZfjhV0PrkKUKHs
         yrLt5zNrxl1crY6p2o1kaOmeUbHMCz1TvI2V/cpujrH62POjfYtOq2ce4slb7kj70MMt
         3X9sA4L7yft7XDH/09oQs2kHMU5tbq13XRHIjlgKb90i6s//WVP4cfCZEimx8EY9Ec/b
         b0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WV2crTqNDj8RQPlzna/bQweYeq1pojQpC+tSUC5NxkU=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=RoGaiUyXBzglJN+86DSwYml7zAwyzpYJdXIT/PxQQrIQX25pXPvPpyZFnwMiEk1lkF
         2K2yKnSVGJgSV6kV7dj1pj50W+p6akKJdf4Dq3bJ9X5+HVddv4cs43Vu5TQCnw5RCL0U
         gdEGx7jl1LOzKCDv6SbXf0ufKqwTS/8VjrZADE4o9q5Tx3FjY3qKSh0kCeVDLZ5uQ3qg
         Ry0O+3uGsChtNj7P4qOgjxFpkpYMcELgHZ8Vt/B47F2eZ6GRyZd4naVYv0NCgavz3jKT
         IXh+BZolFaMaGbWt9Ga/GB5J8vaKFciR1fhACminVcpf0FAXp/IDXdozbH1pyBxl4GSd
         cVvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779146846; x=1779751646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV2crTqNDj8RQPlzna/bQweYeq1pojQpC+tSUC5NxkU=;
        b=n+PilL9rgdCVgJJoKfPku+Vu5qoqr3AUunz6L7PcpbxjeFRTGzDTWealCnn7A8ZS9g
         dn/dZmcK65NFA1LLJ3OixHeoWXeaxqEaFQXPR3uFSxHKJOy8qse0F3dd3wjtKIC9rK62
         nBWxPHKgTDldB+xc8OCEdXnmInEaM1kMzbdiDPhzmIOhawpCJZwD5Ps0pNphtqYZWWP6
         BMv3Pbzaa9iioFV8HAufLE/6/8kA67awYNBgoBdfOFrr+u23rQ+aTXwyNGPnyA8I1lNO
         VjKggJ6NAQRxvwBR1jXJ4ubkhi6DqQ2fG7WPabWbcUp3XGxpcd8gk88pPnWHCvOTZREB
         oL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146846; x=1779751646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WV2crTqNDj8RQPlzna/bQweYeq1pojQpC+tSUC5NxkU=;
        b=BPA8Pn8V/vO49azo4RF3SHIgvtVnGFDuDopeBYp1zIZzGM6xncxIDO5dYMAwtAP/TJ
         RZpT3Y+6iTwalXsrXJr8j54vqBLewD+S0Y+IMv0PDfwNN9gMWEZlqpZ1lUYlagEWivUt
         xYxVPo8xleuFl2nEB8tkWWWiWCVmJTmpXQ4HDsqXDLZHxhWN7yaS0SYqOC2MxW2/aJ42
         7e3yjtcDzlj+Zspune1svBFU8U/Iyv1+/u2q2kEdOg4xByD0Ua3MoC5Nd+1oywlBKRZx
         hD2+IPxT26yC0AglheMB2dFYeEbuDHTqBpElRwMj7MrUKFSpNCkGLz6ClnOXK90daOsZ
         oJTQ==
X-Gm-Message-State: AOJu0Yyr5GuF/SrubmIBAYF+J5cWUn+ljuPYy0K6ZPrm1+ZXhEA7q4lY
	97PSJ0JKHz5IKGilIehgDsWVhkM4mL2eqKbSYX5njiEwDILaBwmCXP0PkOh7smjFnaIxUsIJX7P
	EPWhOih1wBc8xkY/jSloNHbl8K4WsedwvCk6reiDlI5DrSdA73mwgndauh4E=
X-Gm-Gg: Acq92OH9aG+fox0H3Mp6HAEU/dpa48nqGol3epNJnVbiWq4k7W9aobE+0jOXfxqKh8m
	PE9WlAhc6kk7byQdMOCcYO83UVCeX87fX6PvQtbPtfuX6xUm+dTirFALpigWQTOCer2Tf4ytw+A
	R1WdYN4VzxWcf2rP1YqZMEmjqNNzEE02RuocUQVmE6iePxyyXENxu8ldev0oY3uEa35lqmvGGIc
	JPbJorgi9B2hHI1nZehgoYnwuxuAt6MRrf7yJdP0kHSMgHeI2qhc6PSDM0+dCZOH2yLcKj3meWW
	32ECgqBWRwm+LKg74H41FQ74tShdDhp+ieCqCGKhd6hOJ1WOJv12VPx4Db3pDZHW/bPABaqMJdp
	EKEDGF0A=
X-Received: by 2002:a05:622a:54f:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-5167b6ded7emr12858421cf.19.1779146845734; Mon, 18 May 2026
 16:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agt_1yfdx3YmjYei@google.com> <CADKH=+2ZwLuona9esxGfbxO+g57EgmU96ReotPfQG3fY7Pp8KA@mail.gmail.com>
 <aguSFIoEbE_PPpeB@google.com>
In-Reply-To: <aguSFIoEbE_PPpeB@google.com>
From: Roman Gushchin <kfree@google.com>
Date: Mon, 18 May 2026 16:27:14 -0700
X-Gm-Features: AVHnY4JnfuSpKcorKASa9VPmhQcjTUgiSL9PuF-BOjVJF66GXFc4UVmUKAvISOU
Message-ID: <CADKH=+2sHHR8M5qjDdjt6CjKOwdte_p8w03V_-kF7P1NwK9E6g@mail.gmail.com>
Subject: Re: sashiko-bot@kernel.org's Cc list on reviews
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 3:26=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
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
> >
> > Hi Sean!
> >
> > It's expected per configuration here:
> > https://github.com/sashiko-dev/sashiko/blob/main/sashiko.dev/email_poli=
cy.toml#L138
> > .
> > It can be configured to reply to all as well, but since there are some
> > very vocal anti-AI folks in the community, this might create some
> > friction.
>
> Heh, "might".

:)

> > In any case, I'm relying on the corresponding maintainers' decision on =
how
> > they want to configure Sashiko.
>
> What level of configurability does the parser have?  Specifically, can it=
 key off
> the Cc/To in addition to the list?  I ask because I really, really, want =
to enable
> auto-mailing for at least KVM x86, but kvm@vger.kernel.org is wildly over=
loaded.
> I could try and drive consensus across all 30+ maintainers, but if there'=
s a way
> to precisely enable it for just KVM x86...
>
> E.g. is there a way to do something like:
>
> [subsystems.kvm_x86]
> lists =3D ["kvm@vger.kernel.org" && <email is To: seanjc@google.com>]
> reply_all =3D true

No, currently it's only per-mailing list. I did not expect that it
would be that contentious.
Maybe it should be based on entries in the maintainers file instead.
But even then,
what if a sub-subsystem wants emails and the top-level subsystem maintainer=
s
are against it? Or if a patchset touches multiple subsystems.

I mean if building a complex configuration system is the only way
forward, ok, it's kinda silly,
but why not.

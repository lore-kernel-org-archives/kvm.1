Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A895A3C98BF
	for <kvm@vger.kernel.org>; Fri,  7 Aug 2026 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786142343; cv=none; b=pW81q+Eb6wIjgYoNs7B3VOq3H7XHjuwRAQejz/JyQDLOwMUymW/ilQYPGjP4f9nPmfrAVWKJ9zSlq1Q+m0SEiM7iFUmDbIZ6xVV2aRKDIC3Q68psiwQNMGcYIFo3YU9CeZc6guCXKa9SJGTkef2SMFB2fMyPz/jInWC1nOzh+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786142343; c=relaxed/simple;
	bh=90qft761TG4mju73n++8iP2u5y7oZ26yA1cyGv2gg0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SsQBLQustemHPYIX8GVA6HJbFbEqspomNqtIRklHyxhxpd7Y9wIsjHY42akYUmiP8V5Gbv6+2T/Pmorid8oAYfVhYq99yK7s6GkmFL4jo8Ro/+ddi6M/JbfUFmgK4CwC98ervOsHGP+Sv4ozcfRfo4LW/+ZAlPTcDe0lb8y/vUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZ1WSLRG; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZ1WSLRG"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso3136027b3a.1
        for <kvm@vger.kernel.org>; Fri, 07 Aug 2026 15:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786142341; x=1786747141; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTXrPvON64U3D8gfjSGTNrFDqHyTIsu8UP1dMgNPkZQ=;
        b=uZ1WSLRGJPe+Yrp0RPYwGuA+kcmQsbPhz5AAMwqMn2Go4GU6+qbhot2sg2Dr71acpa
         vwQYyQceedqwJTgcBrBS3YOEwUejeN/a6eXHvUGUp2f/+GEMIyePtinDLMDxXOCoNS/I
         J6Kx5kn2xnjEIfgQCzWvDrrgxAvCZKpEqGst+QK/iTV06glZJYfEeen1oBAzXKqG0ozt
         h0IEO5rJd8IS8wNW2LW+GNZdvP44o6odLggOwzdsCHFhKKQbPu+5eWGw2iwW6n0fAI6O
         61Xa+zHPZYLDhBvYcmohhd9eHVJNA7rpoJVMMXG4K6zW6FTnKBNQr0F4uP1liRzLQSyQ
         e6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786142341; x=1786747141;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTXrPvON64U3D8gfjSGTNrFDqHyTIsu8UP1dMgNPkZQ=;
        b=VISgE71yCC+nTy9+oh+yvay+8mD3mdfJMUQ+kVMZNTeye+ZnwS9Z5+j5V10+XSkNTu
         0O/X7ehhceRe1G5MFo/RXEG5bm+Il9G64401pltyb++31UJIzFbcppmNbxaMjBHzJBgf
         cTfYVSvIy2mtp1xRuvFKzbsTUm1ofUZbMzt0DEz3TfIic4GJW5tpNuE5GZgQTvUcvenz
         RI6Mt/n4rq9nEiB1Jh3aKn+HosRRERClUtmaERlgsRTuij4rkolCn7BsjXwbEaz4ZQU7
         kTUWfcjvHW7HzeKNWasQ9FJz5+Tb5jHI3IdWFS6Hrvs0qpudV3nYFOdkS4Fj1lSX4Dr8
         SOJg==
X-Forwarded-Encrypted: i=1; AHgh+Ro478rgAHO0wWDSaJUQwRTVQ3G0JEJvz1K6NEID7ohlTajSIGUnNRMLv9Pj/eGyhrt3STs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm46SX86Yc7GPOB5BV2++HEzMmf8+4WrwMop4g45jpbkRuYahq
	ilrLtk8stjGLtA7h3pndk3H9zxvNVTIEnGhx/Vh/nAMYzsT2lisPkL3xDWxKXybylK4kIsDt/Ev
	NCwzsDQ==
X-Received: from pgka7.prod.google.com ([2002:a63:e847:0:b0:c9f:dabd:440f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e8c:b0:3bf:bbad:500e
 with SMTP id adf61e73a8af0-3cbd37eeb21mr2410103637.5.1786142340853; Fri, 07
 Aug 2026 15:39:00 -0700 (PDT)
Date: Fri, 7 Aug 2026 15:39:00 -0700
In-Reply-To: <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260807135327.2629594-1-pbonzini@redhat.com> <anYQsMnpS2kpYoqA@google.com>
 <CABgObfak2WM10cj4eQ0DejFQPjsK1ftjS-y2Ygr_gcPs=KyChg@mail.gmail.com>
Message-ID: <anZehP6yD66SRsNj@google.com>
Subject: Re: [GIT PULL] KVM (mostly s390) fixes for Linux 7.2-rc7
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> Il ven 7 ago 2026, 19:07 Sean Christopherson <seanjc@google.com> ha scritto:
> > On Fri, Aug 07, 2026, Paolo Bonzini wrote:
> > I don't care _that_ much about the code itself, though I still think the out-param
> > is all kinds of ugly. I'm not at all ok with doing so silently
> >
> > and without what I would consider an honest attempt to address review feedback.
> 
> Sorry about that, but again - I waited two weeks and got no reply to
> https://lore.kernel.org/all/CABgObfbDE+=ir_phPC+9sVYnNXur6dFx6oAfEGSnCbrOqFoyVA@mail.gmail.com/.
> I consider two weeks of wait, on a review that so far had been
> exclusively about taste, to *be* an honest attempt to gather the next
> round of feedback (which never came).

Heh, and I was waiting for a response to Yosry's thread:
https://lore.kernel.org/all/CAO9r8zODKgCcjTBK=P6BuXBBZRoOAFMeRJU8BmkWL-BCX2LoBw@mail.gmail.com

I also didn't prioritize responding (or even digging deeper) because I wasn't
expecting the patch to get fast-tracked to 7.2.  It's not tagged for stable, the
code has existed for years, and at least for me, nothing else suggested it needed
to go in *now*.  It doesn't help that the commit showed up in kvm/master late
yesterday; the first heads up I got that you were applying the patch as-is was
this pull request.

In other words, it's the lack of communication that's frustrating.  Even a simple
"Hey, I'm applying this unless someone screams" would have sufficed.

> If you had proposed the above small patch, for example, it would have
> been a completely different thing. 

Heh, if only past me had realized we could have done that.  I guess the desire to
prove someone "wrong" on the internet is the mother of all invention? :-D

> I would have taken your suggestion immediately.
> 
> Paolo
> 
> >
> > [1] https://lore.kernel.org/all/amPo-XdhFGIZquES@google.com
> > [2] https://lore.kernel.org/all/CAO9r8zM=Mb=eTEFGF0G-POvwwbSr7e8SN6zcDp=GstzKtBKcow@mail.gmail.com
> > [3] https://lore.kernel.org/all/CAO9r8zMopB=YKXs5pkQmPf9uHKE0P0XORcNbc60AWXTusuY3tg@mail.gmail.com
> >
> 

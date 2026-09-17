Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F65524AE8
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652259; cv=none; b=R8WTdYPcdeWxNIhclQDp+DvIq0WNJGB/hKZ+IBhLds9z+HIDZMGnVKyUIQ41ND1rayDaKkdqE5gO9qZTVTzPuuCCDdaRXbJuRZXoKND1wbvWKnZzWacn6GMqCGlWtwxl2imel0zsIy/vSOQErfzcq0ldQ6Q+MoXDlXdqKY9bxnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652259; c=relaxed/simple;
	bh=ANDl/5v0fxRpOzCImDuf3M6HQOSPkF9ZfV/ybVQrV0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YkGuGQWt4W9Q8joAJ4Izpx31Kir7zY5ATr/e8zZNyuKND69nbkwz3v+mhlBpdAM79ZmCw+L4Qgz4wxPtcxtS5vwnKhOwzkuh1C3jtkDHAM8SGrhGXuj/0D/FNn1bVOG6lKy2R4woETpCFY5CEQDKd5nBhsAT8RAV/CP803SUkvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttNnT6SE; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttNnT6SE"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dc92350888so16962735ad.3
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789652252; x=1790257052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=trTMJfjyYMrQlQirbNUWIdpNuWI6E2e7zL0lle6byUM=;
        b=ttNnT6SEQC+olLvGIvJhXIPxTs9BHOOJK7DBl2oz/5ycVOM1A9tQ2X1e9XqNqqUEYp
         +v53Bx1XGurySimzXtt/RWMFRuYLXtn0VRr52GLxJLtSCEL9rSCeQAvB3FMzfVmFVy/l
         O4A1grU4KcJ0bPngQzi4GMAxczQK2HWPs8adjBwlMhzInarK2ipJ5ZoAN2E5k3gJ6z0W
         JRuos181Hl4Nl8ntefml1+foODGLdlidD8yQhUD/RHspdfZXmvyBLH0vOWC+egaTkD+1
         HpVvTou4suhaBmW8jwtpb6XS8Mhk278rL5RTGJJXqGytmhqeIa4AbcLGen2ydVrULelh
         YcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789652252; x=1790257052;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=trTMJfjyYMrQlQirbNUWIdpNuWI6E2e7zL0lle6byUM=;
        b=dGSAbRytE1sUoh+6oiCm8C3V7mfE5USYFuSqaH3AjKi3bPDjySOIz2Tz+K/PfDSdu/
         iFeqg69tgy71/j6FvLjMfCRisXhnAnmQqsdgR6vN/l0vwsM88ny4x1egwnpdY+BwomTk
         UuMEpYnLS8HZJRHS2ICWKIHpR9StiIpAObqE4k6t3bt1kjGelQaqFrY2znpLYrJszFDZ
         jeQZldEol1jyMoqHGj2dP4oi2FcNbFAyOzNARDHPhSic0DhmHzT90hFjUouON9LJtBYH
         9pw7CgKe0ue164hj0Bhhh/8Xla5rzUdsaqWeXbro5htt+cyTvDbslnAGLZP0aS3/nlEb
         AVyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWJORnFPfWtOGH5LaHdurAVji6YZUUfQrrG7crApSzCoBZmjhjh0iFdNVB4OkGPbxx5eI=@vger.kernel.org
X-Gm-Message-State: AFuF++kIeaL9Zw3G9KLtRlrMYV+RF4HXKKDXRJTOp1V1BhKfK+bCVrIG
	JR5R1fp0LsOXLTXhCU5OW0TOregTM23fzEydxIQIRPSH8ka5sFHjaONmYaR+QWflnbB1a5X4dGR
	V7bVW4w==
X-Received: from plpc7.prod.google.com ([2002:a17:903:1b47:b0:2dd:a9d1:e5af])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0f:b0:2da:dcd8:713d
 with SMTP id d9443c01a7336-2dd8e635b49mr128566625ad.15.1789652252038; Thu, 17
 Sep 2026 06:37:32 -0700 (PDT)
Date: Thu, 17 Sep 2026 06:37:31 -0700
In-Reply-To: <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
 <aqrZUZtSZ-YItclT@google.com> <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
 <aqrtprn5YaMijVdZ@google.com> <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com> <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
Message-ID: <aqvtG90zWq6SkU8L@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Peter Fang <peter.fang@intel.com>, Yilun Xu <yilun.xu@intel.com>, 
	Elena Reshetova <elena.reshetova@intel.com>, Binbin Wu <binbin.wu@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-09-16 at 16:57 -0700, Sean Christopherson wrote:
> > > The current estimate is 10s of milliseconds for HW based, and
> > > milliseconds or less for CPU based.
> >=20
> > I am beyond confused.
>=20
> Sorry if this is another gap. Trying to find the right level to cover the
> important points. Did we not talk about S3M?=20

We talked about S3M, it's the "CPU based" thing that confused me.  I wasn't=
 aware
that manually doing "everything" in software, on the CPU, was an option.

> > =C2=A0=C2=A0What is "HW based" versus "CPU based"?
>=20
> "HW" is talking about the S3M thing. The quote operation could go directl=
y to
> the S3M to get the quote. (HW based) Or it could get an intermediate key =
and

Get an intermediate key from where?  I assume this is a privileged key that=
 can't
be exposed outside of the TDX-Module?  I.e. we can't hand that key to the g=
uest
to let it complete the quoting process, in an inherently interruptible envi=
ronment?

> generate quotes using CPU instructions. (SW based). Think like a crypto l=
ibrary
> in the TDX module.

That's not a library...

> > At this point, I don't care about the gory details, I just want to unde=
rstand
> > the basics:
> >=20
> > =C2=A0- Does generating a quote require the CPU to actively execute ins=
tructions?
> > =C2=A0- If not, how does software know when a quote is ready?=20

I would still like an answer to this question.  Even if the end-to-end solu=
tion
isn't nailed down, I hope that the physical capabilities of the S3M are def=
ined
enough to cover this.

> Oh man. There are actually a ton of attestation plans. I don't know which=
 will
> become real. So these two behaviors we are enumerating are actually an ed=
itorial
> decision.
>=20
> The software based flow would be expected to first. It would involve the =
CPU
> doing crypto stuff as above.=20
>=20
> Then a HW based flow where the crypto happens on the limited HW resource.=
 This
> is where full parallelization is not possible, because the CPU is not doi=
ng the
> heavy work. You might want this one instead for security reasons. But the=
 main
> point of discussing it is that you could expect some quotes to take a lon=
g time
> and support a limited number of parallel quotes.

It's not just the raw time that matters, where/how that time is spent also =
matters
greatly.  There is a *massive* difference between "fire off an operation an=
d get a
notification" and "churn on crypto stuff for the entire time", especially w=
hen the
thing churning on crypto stuff isn't interruptible by default.

> But neither of these solutions are actually nailed down yet. How should a=
 off-
> cpu based flow work? We can discuss it. I'd think to have some interface =
that
> doesn't require guest changes all the time. Focusing on something that ju=
st
> supports long quotes seems the most robust.

No, because they are wildly different beasts.  This is basically like compa=
ring
zswap and traditional swap; yes, they're both swap, but they have *very* di=
fferent
characteristics that need to be accounted for at the system level.  Now mak=
e the
zswap (de)compression code completely uninterruptible.  The whole problem s=
pace
changes, because either the host has to be ok with a CPU "disappearing" for=
 an
extended duration, or the interface needs to be reworked to make the swap s=
equence
restartable.

It sounds to me like y'all need to take a step back and nail down your cust=
omer
requirements, including what is tolerable latency from the guest perspectiv=
e.

FWIW, if S3M quoting isn't I/O-like, i.e. isn't fire and get notified, then=
 IMO
it's completely broken and likely unusable.

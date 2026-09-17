Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C34E324A
	for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675067; cv=none; b=gn+JR5MbiicLy6G8ygc0kvXsB582RZUYzxGzEY9s4+SW6CJ4Af87aBsrlnAkDWxTp40jeakg3tpwNHERYInMwraVDQ57SNvPe6KSUB4TGg/iKpc3SDLfq8qkcPfE+GMym9TKv0GVYpegdVhiVNeQeJKNueiCFnzrqBqkfNQDQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675067; c=relaxed/simple;
	bh=FHfLiWiNq4RKh4poymEsvKozgyv0e5aUMoATqs61pmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UVtQMLjjWk/Zsk8415nvNd8s4D5L0ThgIpDuZEBgQDGDwjXTL4TzMlT2QjsRVkv7KMArpQ3oMdjcJeLGlGhIs4Hv4mTCO7Tw7G6Akou6FK2tGG3RnV15U84qzR5MMYi5iUlqvgRcrA9mQADcn9D4cM0c0cApllsN9BjRe/PHif0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=of/9RWoA; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="of/9RWoA"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d9057fab9eso447115ad.1
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789675065; x=1790279865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XuymlHAaKnbiCx6QP3c8JpsEdr7jMSlQot5f7E6mupc=;
        b=of/9RWoA23vrJEWRVo9JB/fvCctKsyviovZWEQm93ysHsi7JU4XWwTjeGqDJLEwk/o
         r48xA0l0/1Zy/Fg6gNROZDjN28P9d5CupMkXM9Ln2wiIrnJGkipKRvHl0Wu3w76ZKfGk
         EPIovECe0SoZA1JlADCUHs/DsTj4PdpFS9ckeT9q1CmX+jp7aFpe6PQOEj2m9TFkjuzv
         t7Seo+XROfXXGZNv65FOpkhgXe+Tu6ziVm5T4smStZXnYLDW4rpOk4Iudmk9TfVpCXKv
         yV4gjOtEmF30dPfpaSu3woUBRIU3wc2iIAmY/tcfhUtKYlHKp3wML6ZUviJxfou8vpeG
         NU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675065; x=1790279865;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XuymlHAaKnbiCx6QP3c8JpsEdr7jMSlQot5f7E6mupc=;
        b=ejvICt1KGlHyR1G94DpvoWB8aTJSU1MhDGbXRIiIM7KanjrNobuIniJWpAiFTCA+Yp
         9cTevzvqVZUzqmkwviqs7i+rjX5fDUkjlfYxgyqtT9vsCsD/5CDy84frsxYbJeQKrj2O
         bH9NM7FYInAdyp2RayA6aAv/gMSW0f0mlXvDsXQeg5fN1Y7/omt9IyS6yQlZZQrAdWae
         X0S6JkZg4A6fES8fIQtD5cVz/5IyQWd6T3lSv6yFh9UyzRq97OfkI3GQO7V4s0J2o68k
         kkBmKgixnjlX0scbrcVLP+5dWPkqgN8Abs03fViIL3xPJT9T0vupwXAq0DVxisMxXcrD
         shag==
X-Forwarded-Encrypted: i=1; AKwUvBx4mHsgd6ICFs8bL37ZDS773vfUd07IZhullpJJfoq9WoF3OJGoX4ZyO/rYxelRgCts61Q=@vger.kernel.org
X-Gm-Message-State: AFuF++nKjI7QQ8UgJLo1DcprIlWlV4Wgg8xIBodGd0hEH6B6aySUHefF
	chegNCMaRzyFEa42VTWBTaUaRboz1gPUMQ3kbthUxhNAZfYrRxRvcD9PUx6dJ/vtnWBB9+VkUHB
	OAqAS0A==
X-Received: from plcm18.prod.google.com ([2002:a17:902:f212:b0:2dd:6c51:6e21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e748:b0:2da:f7ad:cfea
 with SMTP id d9443c01a7336-2ddb1ae3d88mr5399915ad.8.1789675064699; Thu, 17
 Sep 2026 12:57:44 -0700 (PDT)
Date: Thu, 17 Sep 2026 12:57:43 -0700
In-Reply-To: <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <24a751d16ba0dc37aa7774df5739f39734cf9aca.camel@intel.com>
 <aqrZUZtSZ-YItclT@google.com> <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
 <aqrtprn5YaMijVdZ@google.com> <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
 <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
Message-ID: <aqxGN2Zc8sOl2RKx@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-09-17 at 06:37 -0700, Sean Christopherson wrote:
> > > The software based flow would be expected to first. It would involve =
the CPU
> > > doing crypto stuff as above.=20
> > >=20
> > > Then a HW based flow where the crypto happens on the limited HW resou=
rce. This
> > > is where full parallelization is not possible, because the CPU is not=
 doing the
> > > heavy work. You might want this one instead for security reasons. But=
 the main
> > > point of discussing it is that you could expect some quotes to take a=
 long time
> > > and support a limited number of parallel quotes.
> >=20
> > It's not just the raw time that matters, where/how that time is spent a=
lso matters
> > greatly.=C2=A0 There is a *massive* difference between "fire off an ope=
ration and get a
> > notification" and "churn on crypto stuff for the entire time", especial=
ly when the
> > thing churning on crypto stuff isn't interruptible by default.
>=20
> In general, S3M is described as a mailbox. So my understanding is that th=
e CPU
> is not churning while S3M works. More below.
>=20
> >=20
> > > But neither of these solutions are actually nailed down yet. How shou=
ld a off-
> > > cpu based flow work? We can discuss it. I'd think to have some interf=
ace that
> > > doesn't require guest changes all the time. Focusing on something tha=
t just
> > > supports long quotes seems the most robust.
> >=20
> > No, because they are wildly different beasts.=C2=A0 This is basically l=
ike comparing
> > zswap and traditional swap; yes, they're both swap, but they have *very=
* different
> > characteristics that need to be accounted for at the system level.=C2=
=A0 Now make the
> > zswap (de)compression code completely uninterruptible.=C2=A0 The whole =
problem space
> > changes, because either the host has to be ok with a CPU "disappearing"=
 for an
> > extended duration, or the interface needs to be reworked to make the sw=
ap sequence
> > restartable.
> >=20
> > It sounds to me like y'all need to take a step back and nail down your =
customer
> > requirements, including what is tolerable latency from the guest perspe=
ctive.
> >=20
> > FWIW, if S3M quoting isn't I/O-like, i.e. isn't fire and get notified, =
then IMO
> > it's completely broken and likely unusable.
>=20
> Let's take a step back here. There is an existing attestation flow that w=
as
> designed around some limitations that are changing (specifically whether =
the
> quoter has knowledge of the TD). The current host side quote discussion (=
KVM
> ioctl) is basically a straight forward evolution of the existing design, =
even
> though the limitations are getting removed.
>=20
> You asked whether we could do a re-design that makes more sense in the co=
ntext
> of the lack of that old limitation. At that point we are faced with the a=
ge-old
> question: how far into the fuzzy future should we design around?

Now I'm trying to understand what the *current* plan is.

> The nearest term thing is a SW based flow where work happens on the CPU. =
But the
> exact amount of time is not know yet. Peter gave a ballpark.

Why are we even discussing this?  I am so confused.  I thought there were t=
wo
options: SGX and S3M.  Now all of a sudden there's a third "let's do insane=
 things
in software in the TDX module" option!?!?

> A future thing is a flow where S3M is engaged for every quote. That would=
 be
> expected to take longer, and have greater limits on concurrency. But the =
details
> are not sorted on what exactly the user will want, or how it would be
> implemented.
>=20
> I think you are maybe wondering whether S3M could be used such that the g=
uest
> could wait on a quote while not needing any saved state area?=20

I'm trying to figure out if *any* path is viable.

Burning 1ms of CPU time to generate a quote in uninterruptible code is a no=
n-starter.
Hell, 100us is a non-starter.

Waiting 2s for a quote to come back from the S3M is a non-starter.

The numbers matter, and *none* of this is reviewable, even in RFC format, w=
ithout
a crisp understanding of what latencies we are talking about.

> If you want to know more about S3M we can round up some more info on it.
> There are some public docs on it, but the intel link seems to be dead.
>=20
> AFAICT, outside of TDX and just in the world in general, crypto is in a
> transition phase. I read this interesting article on lwn awhile back abou=
t
> "hybrid crypto" to add safety during the transition:
> https://lwn.net/Articles/1048978/
> Not trying to toss FUD here, but I'm imagining all the combinations of CP=
U or
> S3M work that could possibly come up unpredictably.
>=20
> If we want a redesign for TDX attestation, I think we shouldn't fall into=
 the
> trap of designing everything up front before taking the next near term st=
ep. We
> should either stick with the current approach (guest report and host quot=
e).

Forget redesigning anything, I want to know if there's a path forward with =
*any*
design based on the limitations of hardware.

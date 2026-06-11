Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BB4D2EF7
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205280; cv=none; b=tVMDqYryJfo9UwcahzyblpGPlpxBcT1MUIaxovdQIUswaBPOtay1c5npT2n1jZ55yAGvIBaqeCp8JPNl7BZsJ9ErEQqF86cThs5XRg5x37AfL5YijYk7rFF2DXZwmbuq6L2ukAkcAwyYrvNz7OwVNknb4KFXtUePwNE4GSDjF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205280; c=relaxed/simple;
	bh=xbVJML230yKeUvNITt95ue6YNo9RjYwciNyHOYUt+5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nemRsMRdc5hq1WCKGSPaRxl7LVwSw8np+mnaVM8IvEoYkuutDWzUJA8Yp786yfG6sHD6Ymw3OxIrpm9fdWgEhK4K8FLR26RnXXUZXZIHvtC8IXSS8WkucdeQmUA8l2y9V6XKHJnMARfh/vrCATbGaSB+pkOsgdc9FRkGvmjbVnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksZHw8Jj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksZHw8Jj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90581F00A3A
	for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 19:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205278;
	bh=7VADOQgsZ+nB0F0qeAZfXqhe9nKZgfofXnfonH3aZZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ksZHw8Jj4KgdiAEGnz2u1ysdGM7Gz9VGSqsZwKn3oJugu9ny7izMj631OyKgLn4vn
	 l4Upxm2zcktT4V16jM/44T81eckXEzcR7+V5n7IAYCznmr8Xvaf2ct9NeRZ4PSy0bg
	 +ymgp+gYhjnLiXXonSy6NT2lbDsNO0cF77ATvr4pR2+dhCg6GahIVYpujxrmJml0Ci
	 6oeBRlYIOCtxA2F4YX2Jh6HJDwTmX1mtgVmeFm6bYO28q06dpjpXMAX0l5JrwLRCeQ
	 q5gtDyqIT4JABkyfT9j16ewNx3ew9SPzVo8KxpDeGTwF3dQgbHddNHFIX5rUjzXEet
	 JTcE9q78ODZ8Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bed19623d6eso29628366b.1
        for <kvm@vger.kernel.org>; Thu, 11 Jun 2026 12:14:38 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywmx/kEZ/0WAo1qNqGu3MovjcZgLk4q4n9k4loTLRhrsVqRbDX9
	tuSvcb4PAqAacPctkqgaDhj8/ibI7IKcExnTntDOH7vhCZv7f8PXq496HZZxwCloIAzqNm/sIqL
	ytoWJ71cP0KCGyBgY7kV0RjM80L+mVwM=
X-Received: by 2002:a17:907:b18:b0:bb8:fd88:f400 with SMTP id
 a640c23a62f3a-bfc85f88eb0mr168781766b.21.1781205277757; Thu, 11 Jun 2026
 12:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604203546.365658-9-yosry@kernel.org> <20260604204911.80D601F00893@smtp.kernel.org>
 <CAO9r8zMQrKy8YTNebBVXLt3Zsrbym57wOsbv1Rw-vGFO-osjnw@mail.gmail.com>
In-Reply-To: <CAO9r8zMQrKy8YTNebBVXLt3Zsrbym57wOsbv1Rw-vGFO-osjnw@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 11 Jun 2026 12:14:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPHX2DH8q-G9xO91DvumNL87M6epVxo+rq1XQm4oxL4ww@mail.gmail.com>
X-Gm-Features: AVVi8CcHErePEs6k0xG28ur8Fhf2xpSAogmMuV-_I8d_EUrORsR2L5ur6B9yR1s
Message-ID: <CAO9r8zPHX2DH8q-G9xO91DvumNL87M6epVxo+rq1XQm4oxL4ww@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] KVM: selftests: Trigger save+restore randomly in
 the #PF stress test
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > +static void *sigusr_thread_fn(void *arg)
> > > +{
> > > +     pthread_t vcpu_thread = (pthread_t)arg;
> > >
> > > -             GUEST_SYNC(guest_faults);
> > > +     for (;;) {
> > > +             pthread_testcancel();
> > > +             pthread_kill(vcpu_thread, SIGUSR1);
> > > +             usleep(100);
> >
> > [Severity: Medium]
> > Could this aggressive 100-microsecond signal interval cause a livelock on
> > slower hosts or nested environments?
>
> Not sure if that's practically a concern.

Spoiler alert: it is.

>
> In earlier iterations of the test, I remember higher intervals not
> reliably reproducing the bug, but trying now, seems like this is no
> longer the case. With 1 msec the bug still seems to reproduce
> reliably, at least on Turin, and we get a lot more page faults. The
> overall test runtime doesn't change much either.
>
> So I think we can do usleep(msecs_to_usecs(1)) in the next version.

We observed the test failing internally on slow builds (e.g. with
ASAN), due to the test not completing any accesses. Using 1 msec
instead of 100us does fix it indeed.

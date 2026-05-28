Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D12C339866
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998675; cv=none; b=Wesqa8ulRfzslGUWs9hjKoPn+O6ZvCDNKH4yrdx7V4g2kvZeAjhlZ7XyALEvYGforqQlMmDpFCTxNAAFD63uQdCGFiTKyOmd43JEgNJTRvUc3KIq+HXm57gg0T8zIGq4RAdWCL5M1vmKStu24AKxzAIOfxIBXBcMJ4hpJ+ZxtWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998675; c=relaxed/simple;
	bh=aeYRqwvCXzmYimyK2z9v7qH06rnmKfDv5h/cqaxtSz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MohFKzNmVphdiF7uDkEBH5dQKOOF9/5vUI9cArWj5pPZS8BcGP1mcOUvrs50hG/UVcAnm9+4fw0Tvs1Cvlf5h5CNpHFKsre77RIlvuCDipvFe/FMW7SwPwGb7MrUg+yqFsna2yQCJzApo559dKw/ELyw0dCZeKXb8bf8sU1zYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UvTU+yW2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvTU+yW2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso89089075ad.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779998672; x=1780603472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E2xCZftMYhIH9CUbURjBxqtytmLo+CBf4AnXX4arPk=;
        b=UvTU+yW2T1VRmfczWypjhIGATPsN/tl6RSZpqVmnIRGDvcqKIeGUaznS5YBDypnzwY
         lUlfhAWqjMtu/Iy9l6grMRW+pozxIup6uS9YPEgJRO/aHdqQpHBe/b9yostsE2TQH+dZ
         JoOpT8ROtddIUwpEYqK/K31PVAo01UeRiFqmD3scLLbAjR/v4RtzD3xIuh9QD4rUS57v
         TnxdVll/dcQLognXqICVRMs6DLAg6SPfxfGpZC1I9gonxmNutLYsCoo1kchcTisWwBsP
         OySHrwr/TvhxxZZpp/UL9wFptFxKJSd1Zt4c+Qzre6wQHtwvvvu9gI/p9RBPZhqZ1xts
         fk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779998672; x=1780603472;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3E2xCZftMYhIH9CUbURjBxqtytmLo+CBf4AnXX4arPk=;
        b=S9j6pjSlqcFOPDdL5YYK+fcOJo51DgucsH8FCQkcjmHCUEYjaEr46khvkxDhwaGaaQ
         JjjlrGaV4gIzJmp1sDphAArpEZAEke7yzdKmTa1XlK47BQZLHX3mvqJRfOqoHEeZXFxJ
         MQ5kjaxGbE1oQgGJyTRvNwWne7bxwIKiWugjkllFsG3pRDBd75dvOP0xliUv40q/J8dy
         Xr+G1xAdOxbruiY6HdpVHdT9DyaMbv/CoXC7Niq0rXTr7mPn1aJXSi7nRyMfInwxKC5p
         i16zlm6H2NuONE7j0uShgFe9PeTBi2+ZTPY3TozX3GKXAwkmnMdc252Q+TugqWD96x5j
         EAbQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Vvtb21ZFwgm0y7p7OX68LcsBIBg9+rwvr06YY5rtLlM978EGpsHjS8GP0+C/FpDg6Ndo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Dmn1LlhdFiNS384FFdXhGdOmN1HlInM7ldl54t6UAUOmNdOY
	3ZIasna79mUZofTswf4NRe+z90Ounqmdl0VKXo+CFFnXSMq4x6igJ6JCgQSQbg59Ztdfp7/tWqY
	xGJUj8Q==
X-Received: from plbbe9.prod.google.com ([2002:a17:902:aa09:b0:2b0:b22a:e6ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b25:b0:2bd:c5f8:504f
 with SMTP id d9443c01a7336-2bf1ed3452dmr3670415ad.40.1779998671795; Thu, 28
 May 2026 13:04:31 -0700 (PDT)
Date: Thu, 28 May 2026 13:04:31 -0700
In-Reply-To: <CAO9r8zMXFmx3q-u0KbuQDXOW7=0QmKmQV0cp_vzU5GPPVG3sSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527180417.4119289-1-seanjc@google.com> <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
 <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com>
 <ahiSeDZibiaD7pOC@google.com> <CAO9r8zMXFmx3q-u0KbuQDXOW7=0QmKmQV0cp_vzU5GPPVG3sSg@mail.gmail.com>
Message-ID: <ahifz63VorFiQduF@google.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026, Yosry Ahmed wrote:
> On Thu, May 28, 2026 at 12:07=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > > > ----------------------------------------------------------------
> > > > > Isaku Yamahata (2):
> > > > >       x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to ser=
ialize deadline timer
> > > > >       x86: tscdeadline_latency: Remove unnecessary nop
> > > > >
> > > > > Jim Mattson (1):
> > > > >       x86: nVMX: Add retry loop to advanced RTM debugging subtest
> > > > >
> > > > > Kevin Cheng (2):
> > > > >       x86/svm: Add missing svm intercepts
> > > > >       x86/svm: Add unsupported instruction intercept test
> > > >
> > > > Any reason not to include this series:
> > > > https://lore.kernel.org/kvm/20260312200308.3089379-1-chengkev@googl=
e.com/?
> >
> > I ran out of steam (and time), and I don't want to merge like this with=
out a high
> > level of confidence that it's the least awful option.
>=20
> We're already doing this for vmx:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/vmx_te=
sts.c?ref_type=3Dheads#L806.
>=20
> If this is the only thing holding that series, I think cleaning it up
> should be done separately for both VMX and SVM.

I don't buy that argument.  Taking it to the extreme, that's like saying it=
's ok
to use bare "unsigned" because there exists such code in the kernel.  It's =
very
difficult to make progress if we don't raise the bar.

I'm not saying "no" to the series, nor am saying you (or Kevin) needs to cl=
ean
up the nVMX code in order to land the nSVM code.  I'm simply explaining why=
 I
didn't grab the series: it's got some fugly code I want to look at more clo=
sely,
but I ran out of time and brainpower.

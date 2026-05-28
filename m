Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793A2FD7C3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999952; cv=none; b=XRBxW/ruhtPPy5g7dCQIITrT+NUZL3lWrmq4Z4CTIA/anM+rjJqnJ5lstPG1inYgwFcmvs0wpPO04p/z5msleHGUtGT1keHz62VFlAps9d28PJVML6KQXSDhtAzXznRc05PZ5R9C1grQ09PDkBclIg0/qEhbg779WCnsfDkSb2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999952; c=relaxed/simple;
	bh=xYFQf1RkbR6RHKn2L0/j/mbFEqrKRLC4pXbQNmbojbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zb6HjFlGoYdrJKcIYhbHfEYN5G3BQOSeVTd3jBsJsLElBQ4T/1Ual06ZTHhnua4uHqEXHGjRlkQbtJCH10gRYNQMZzAr/4UbS2GebdzgFtLrBwX7WtlPPlt95KkPt9jXGLh+3IootV3XrxVZB8cwI+wqB3NNMvLCA4iDa/yumQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou0T8Yvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou0T8Yvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291491F00A3A
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 20:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779999951;
	bh=m5avoggkiikBA4JWt84BXn0+gXaD7nIyUfsJS6sFDT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ou0T8YvkhDDcornrlQICbIFe5bwLFo0VnfVA5KtDIivaiaZgLCUSLokQSjDJff2hR
	 Fdr4KkxGOAhoqeJyKxuv43N1UZa319ujMpVNm8n7USc8Ueb9WRYkQ7kBgw7AFqfq7f
	 SOhPUmNdhMRsMnnij2IAzxVZqudA78V7UAnpqO1A8ySoczobJsfFvGjj3MsZKD6XNQ
	 Dtit24Mh05m94VAhxfG22/MGK8tgZaOHr30gOQyuSUVjM0dULZaDJaxtuqdX41jXKh
	 YMuA0p6BrUltE1hn6lHf73UhaoFXqgTnOwPZ2wMXMJvvizv/AUZ9qg9w1MD4xYG9VM
	 ZIYQXguHnazlQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd22b2abaa4so2098724866b.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:25:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9DGT01xwmfHf/zR0CyGLcX8T6Rb4Ilf4OIdbOWNJWxUkSm4xS2jJNXE2L3cdTMnmq8B8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBp5cAN7YuGPAafaNC4tzCePbRb3zy6uMR9xsTYBvlBUf3a/y1
	XO7n6n5YXv27bMboBE+44qv2sWtq3r7gsVKQCUR/AA5kZzgpkprbPFqR362ErbA0UMWvTkQS/ce
	9T9fwgd4DihhkLJIURfaKmNKhpHqcTtE=
X-Received: by 2002:a17:907:d12:b0:baf:19a8:b44b with SMTP id
 a640c23a62f3a-be9738440b5mr49315166b.25.1779999950073; Thu, 28 May 2026
 13:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527180417.4119289-1-seanjc@google.com> <CAO9r8zNrz3U18hGOj9MAd46X-OHYzs9-QebH=D1TRp=wcHmk=A@mail.gmail.com>
 <CAO9r8zOLxAmtkGD0_pQdbikDR+jL2jaAgOY_nooyY+S_mOoo+Q@mail.gmail.com>
 <ahiSeDZibiaD7pOC@google.com> <CAO9r8zMXFmx3q-u0KbuQDXOW7=0QmKmQV0cp_vzU5GPPVG3sSg@mail.gmail.com>
 <ahifz63VorFiQduF@google.com>
In-Reply-To: <ahifz63VorFiQduF@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 28 May 2026 13:25:37 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPevcaft2j0ChvsB9NnFvCU47ZQeCKSV=Ja8=aPJq4=UA@mail.gmail.com>
X-Gm-Features: AVHnY4LgTqeVloLC94TD075LSRpVbpYjphxUf0IX3LdopO2ep--KErWLQAbyLro
Message-ID: <CAO9r8zPevcaft2j0ChvsB9NnFvCU47ZQeCKSV=Ja8=aPJq4=UA@mail.gmail.com>
Subject: Re: [kvm-unit-tests GIT PULL] x86: random smattering of changes
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:04=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 28, 2026, Yosry Ahmed wrote:
> > On Thu, May 28, 2026 at 12:07=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > >
> > > On Wed, May 27, 2026, Yosry Ahmed wrote:
> > > > > > ---------------------------------------------------------------=
-
> > > > > > Isaku Yamahata (2):
> > > > > >       x86: Replace NOP with CPUID after WRMSR(TSCDEADLINE) to s=
erialize deadline timer
> > > > > >       x86: tscdeadline_latency: Remove unnecessary nop
> > > > > >
> > > > > > Jim Mattson (1):
> > > > > >       x86: nVMX: Add retry loop to advanced RTM debugging subte=
st
> > > > > >
> > > > > > Kevin Cheng (2):
> > > > > >       x86/svm: Add missing svm intercepts
> > > > > >       x86/svm: Add unsupported instruction intercept test
> > > > >
> > > > > Any reason not to include this series:
> > > > > https://lore.kernel.org/kvm/20260312200308.3089379-1-chengkev@goo=
gle.com/?
> > >
> > > I ran out of steam (and time), and I don't want to merge like this wi=
thout a high
> > > level of confidence that it's the least awful option.
> >
> > We're already doing this for vmx:
> > https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/blob/master/x86/vmx_=
tests.c?ref_type=3Dheads#L806.
> >
> > If this is the only thing holding that series, I think cleaning it up
> > should be done separately for both VMX and SVM.
>
> I don't buy that argument.  Taking it to the extreme, that's like saying =
it's ok
> to use bare "unsigned" because there exists such code in the kernel.  It'=
s very
> difficult to make progress if we don't raise the bar.

That's fair.

> I'm not saying "no" to the series, nor am saying you (or Kevin) needs to =
clean
> up the nVMX code in order to land the nSVM code.  I'm simply explaining w=
hy I
> didn't grab the series: it's got some fugly code I want to look at more c=
losely,
> but I ran out of time and brainpower.

Understandable, sorry if I came off too pushy. Thank you for taking
the time to shepherd x86 KUT changes.

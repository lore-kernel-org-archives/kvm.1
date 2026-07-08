Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1A3BB106
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537941; cv=none; b=QboH+sL9jgHEa8scECZAc4GR2dc6t3ovRFQHpmQ2YGLqprxGxEOKGKP+bMPYk1UhkRTRflXbV1sAB81eFDBKXNcaML5W4b7m1yhcRzlUs752jDN2ysBglytjIA69LROOZDmCrwfarWQnOyttBMajoNWy2TAIJugX0ljpkj+1XzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537941; c=relaxed/simple;
	bh=ozuarTA5yDAJKG9+W1Sq1V2z5le0AugHHuKwbejukos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n33D1gvcd7VIwSgzhJfQyvgWtCNNwbQW7PkOv4fgtWo4t8fmfEDbB7L1j8WwymcXdLfYj5uDxIX4kAAhN9kszlhyFeeGA9qlnRrNzx4jViv1VNizDA9JBbezTJ0051J0nGUk84400jpNNQk+dMwcFCaa9NMHjsg6kgzJ2OauWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/L1DV48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/L1DV48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AA01F00A3A
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 19:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537940;
	bh=XCV8ihNwNJqTxSxIZjEYQcsxb6sPh74znVQ8xR64ajI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Q/L1DV48uvBfOatm2pe8mQybUYIIAu0bXM63GL+bmMYVE5ln/mEUiyjcIxp20PyBM
	 3cq6pP2rrH8NRSeR4pJaZ+a0+OaqRzGh05Yg4uHbjCoCmI2MMzlFTpRh0qrYaCHVC8
	 iUb87UpztlK2LqEQuFHQCPoekU+uTxIsKdvrISFDHT+g8rZlQrLE91M0g8TKdhtd0I
	 A0D47rsBr+LACX7GzpoEF5OmGl8pKPZJPYRDRCSYh+mGPlQayqTfQkBsvxs8wItOuO
	 azKDJ+u8aiQp9FMh3+9ePuvwM8+64SDZz3FW7ou2NHzqrarWXTUyF2Qct0qx201rs+
	 5bE2m4jtiHHwQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c125fbfbae0so14571266b.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 12:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro3I+luzO4ScaAEkpO92WbAUq21AM3ID5a6yGsYR/1fhSeHhDKVG1bQjEY/DZka0XTiZew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu5kiZ3tr4rCRVpXScgmQTgqkhlPYOBS0di3PiELPGigwCDIL7
	8PIfD3ZgFEqDV20K4vhU91XIgd9UNivfMuftmgmVAXbnh96P28y2DRNsdsjm4brbB1HS9lOZubT
	z6PYJGIvWvQMJzC8nANeSMPtNd/cufD4=
X-Received: by 2002:a17:906:6a1e:b0:c12:8ade:dce1 with SMTP id
 a640c23a62f3a-c15ce0ea864mr198012866b.48.1783537939232; Wed, 08 Jul 2026
 12:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706195413.1966458-1-yosry@kernel.org> <20260706195413.1966458-5-yosry@kernel.org>
 <ak119GtNZOmBpGmW@google.com> <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
 <ak5YUdHyA36ogsvD@google.com>
In-Reply-To: <ak5YUdHyA36ogsvD@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 8 Jul 2026 12:12:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNyAfFFPxNYeht+FK-BHHxcUh1DTb6aOpffm_9ebEVUSA@mail.gmail.com>
X-Gm-Features: AVVi8Cf03eILhdXnJSjnJp76nCP6Wf_3YaHsGVnTAaGYGpRNYHFlFuN8e75yDwk
Message-ID: <CAO9r8zNyAfFFPxNYeht+FK-BHHxcUh1DTb6aOpffm_9ebEVUSA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 7:01=E2=80=AFAM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Tue, Jul 07, 2026, Yosry Ahmed wrote:
> > On Tue, Jul 7, 2026 at 2:56=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Mon, Jul 06, 2026, Yosry Ahmed wrote:
> > > > Move handling EFER.SVME and EFER.LMSLE from hardware setup to a new
> > > > optional per-vendor callback invoked from kvm_setup_efer_caps(). Th=
is
> > > > centralizes allowed EFER bits handling to kvm_setup_efer_caps(),
> > > > facilitating following changes to move efer_reserved_bits into kvm_=
caps.
> > > >
> > > > Move the call to kvm_setup_efer_caps() after per-vendor ops are
> > > > initialized.
> > >
> > > Why?
> > >
> > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > index a0b2c40d93c21..a297a77469b38 100644
> > > > --- a/arch/x86/kvm/x86.c
> > > > +++ b/arch/x86/kvm/x86.c
> > > > @@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
> > > >
> > > >       if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
> > > >               kvm_enable_efer_bits(EFER_AUTOIBRS);
> > > > +
> > > > +     kvm_x86_call(setup_efer_caps)();
> > >
> > > I would rather move the togging to kvm_setup_efer_caps(), e.g.
> >
> > I didn't do it this way because it creates a dependency on SVM setting
> > the X86_FEATURE_SVM cap before kvm_setup_efer_caps() is called.
>
> For all intents and purposes, that dependency already exists due to the
> X86_FEATURE_{NX,FXSR_OPT,AUTOIBRS} checks.  And thanks to kvm_is_configur=
ing_cpu_caps,
> it's "impossible" for those caps to be toggled outside of svm_set_cpu_cap=
s().

Right, I missed this. kvm_is_configuring_cpu_caps is neat. I wonder if
we can make that an enum with values {UNINIT, CONFIGURING,
INITIALIZED}, then we can be more paranoid and WARN if the the state
isn't INITIALIZED in kvm_setup_efer_caps(). That might be too paranoid
though.

>
> > e.g. it would break if the call to kvm_setup_efer_caps() is moved
> > before the vendor-specific hardware_setup().
>
> As above, that would break for other reasons.
>
> > Maybe that's fine, but it just seemed like the dependency can be easily
> > avoided here by adding a new vendor-specific callback.
>
> No, all it does is change what can go wrong.   E.g. if KVM cleared "neste=
d" in
> svm_hardware_setup(), which is *very* realistic given that we carry an in=
ternal
> patch to disable nested if TDP is disabled, then hoisting kvm_setup_efer_=
caps()
> above ops->hardware_setup() would still break (even ignoring the above is=
sues).

Yeah, thanks for explaining that. I will drop the per-vendor callback
and just do it directly in kvm_setup_efer_caps().

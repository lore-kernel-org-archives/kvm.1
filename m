Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E748F3AB29E
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546510; cv=none; b=gNIxdmshPFnrAMGsITpBGz4j+r0kUZD0x/zf9FxqOGqo5q3BxmfktKbUyhS4PVSTc/5nPpi3TVikHIbZnEcS7L76ahvt0IcD/KTQhjBFqQ2QBQn5WsKkBxTcwECRvB+x4iSXHh3MGmPY/R6Ufylk9D1xjS/4r8tDif1r1L13YAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546510; c=relaxed/simple;
	bh=M79PJC71DpxMMl2xsWWfEnYngaePrr5tx3A7lSygMq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6aqiSq1l0SvVyfoZau7aa7JytsQoSJN5po21bAZYX6auxJIK4bx9bVZJQDuTkzuMKo6OY2CeLe/i5RwZ6A2vdWLapMlfVhEUem6D0VjWSltbJi2EyR9VQXBb9nZq5oFjlQd1/3uV5Dp+eLsaAAorXCyjd5iomzoNKmWvq9sGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVunKCsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVunKCsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BF11F00A3D
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783546508;
	bh=KJlIbgXYHmd4abUJY6AqeJ/PVCnqwu/yQPQwFM+AXcQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BVunKCsZzSwtKp1M9hTaBbk0lX6NRM91hKVKhWkJi+NdFUYiVITY931XlkP1dI4Wh
	 i+RDlv7J2Kx2AP8xXgFGFAEv8KC0HDUVvd2lhHrb+tuZQVe8dtvTr84WM/2ojrDpB0
	 2sLbs+9d6FvvPcdREhkjr1TSpvBxcuaqVJtk6j6Ym5ZQzXbzAPH8hnAa8ecdDe7syq
	 XfgZGtUGLlteVitISnDuHCuJNnUM/i04rojOj9y2DrrGDWVkvIUEXQUPix++KunA0B
	 qWh/DNgcEw3cfBtfjRRYZDnIv6+q64xj2FjLIKabLbERPZtul0UERzd9gTDQGlrPLB
	 PKNoF6tgc0ycA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c029505b389so44391066b.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 14:35:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RojPJar1NuCVnnTN2+cTKctwhl6DNxpO1wLeA/OuGC2bJmNHMFxzQJtCotz9YORee2/P5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEM9TZRLht1ybpBQ1htCyrkFPdn/7OYx5qbkfZk88PMx38Bgg
	3LYRCio7kL2qLjvdYVFGShB77Tj9P5455L19DDSdQEdqHpveP4gaNGbDP3PVWPYBDpCTKoGj4iq
	fv8xspmJ2NmPpjpcFRykhuH+y7dbLFG0=
X-Received: by 2002:a17:907:97c5:b0:c15:ce1f:e3ef with SMTP id
 a640c23a62f3a-c15e776d9b5mr2350566b.16.1783546507437; Wed, 08 Jul 2026
 14:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706195413.1966458-1-yosry@kernel.org> <20260706195413.1966458-5-yosry@kernel.org>
 <ak119GtNZOmBpGmW@google.com> <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
 <ak5YUdHyA36ogsvD@google.com> <CAO9r8zNyAfFFPxNYeht+FK-BHHxcUh1DTb6aOpffm_9ebEVUSA@mail.gmail.com>
 <ak65cOXmxoznMCNo@google.com>
In-Reply-To: <ak65cOXmxoznMCNo@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 8 Jul 2026 14:34:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPA5Q2HtxPztDU4pPnkDJMXKbnO5RKEzFRHOJtQoAO5Pg@mail.gmail.com>
X-Gm-Features: AVVi8CcW4BdyqzYKkXKdSKLUIFSKG7tsM8YM0NkFnyGRKHz1ommSRpoxA51nHn8
Message-ID: <CAO9r8zPA5Q2HtxPztDU4pPnkDJMXKbnO5RKEzFRHOJtQoAO5Pg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 1:56=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Wed, Jul 08, 2026, Yosry Ahmed wrote:
> > On Wed, Jul 8, 2026 at 7:01=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >
> > > On Tue, Jul 07, 2026, Yosry Ahmed wrote:
> > > > On Tue, Jul 7, 2026 at 2:56=E2=80=AFPM Sean Christopherson <seanjc@=
google.com> wrote:
> > > > >
> > > > > On Mon, Jul 06, 2026, Yosry Ahmed wrote:
> > > > > > Move handling EFER.SVME and EFER.LMSLE from hardware setup to a=
 new
> > > > > > optional per-vendor callback invoked from kvm_setup_efer_caps()=
. This
> > > > > > centralizes allowed EFER bits handling to kvm_setup_efer_caps()=
,
> > > > > > facilitating following changes to move efer_reserved_bits into =
kvm_caps.
> > > > > >
> > > > > > Move the call to kvm_setup_efer_caps() after per-vendor ops are
> > > > > > initialized.
> > > > >
> > > > > Why?
> > > > >
> > > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > > index a0b2c40d93c21..a297a77469b38 100644
> > > > > > --- a/arch/x86/kvm/x86.c
> > > > > > +++ b/arch/x86/kvm/x86.c
> > > > > > @@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
> > > > > >
> > > > > >       if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
> > > > > >               kvm_enable_efer_bits(EFER_AUTOIBRS);
> > > > > > +
> > > > > > +     kvm_x86_call(setup_efer_caps)();
> > > > >
> > > > > I would rather move the togging to kvm_setup_efer_caps(), e.g.
> > > >
> > > > I didn't do it this way because it creates a dependency on SVM sett=
ing
> > > > the X86_FEATURE_SVM cap before kvm_setup_efer_caps() is called.
> > >
> > > For all intents and purposes, that dependency already exists due to t=
he
> > > X86_FEATURE_{NX,FXSR_OPT,AUTOIBRS} checks.  And thanks to kvm_is_conf=
iguring_cpu_caps,
> > > it's "impossible" for those caps to be toggled outside of svm_set_cpu=
_caps().
> >
> > Right, I missed this. kvm_is_configuring_cpu_caps is neat. I wonder if
> > we can make that an enum with values {UNINIT, CONFIGURING,
> > INITIALIZED}, then we can be more paranoid and WARN if the the state
> > isn't INITIALIZED in kvm_setup_efer_caps(). That might be too paranoid
> > though.
>
> I thought about trying to do something like that too, and mostly landed o=
n "too
> paranoid".  Or rather, landed on "mostly just shifts where the bugs will =
be".
> E.g. kvm_setup_efer_caps() needs to run after kvm_cpu_caps are configured=
, or
> more specificaly, before ops->hardware_setup().  But supported_{xcr0,xss}=
 need
> to be initialized before ops->hardware_setup(), so that KVM can manipulat=
e the
> support bits at the same time kvm_cpu_caps are updated.  And so adding on=
e-off
> WARNs still requires on having a priori knowledge of exactly where in the
> bootstrapping process the code needs to run, i.e. we still have to "manua=
lly"
> select the right stage of kvm_is_configuring_cpu_caps.

I think that's fine, but I get your point that the bugs this protects
against will probably be caught otherwise anyway.

> What _would_ scale a little better would be to have kvm_cpu_cap_get() WAR=
N if
> kvm_is_configuring_cpu_caps isn't INITIALIZED, but I'm hesitant to do tha=
t because
> it'll pollute KVM with WARNs just to detect rare bugs that really should =
be caught
> during initial development anyways.

Yeah, I will resist the need to be paranoid and drop this :)

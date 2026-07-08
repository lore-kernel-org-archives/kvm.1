Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6B3ACA43
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544179; cv=none; b=MkCmSVDvK0/4HMU6Wlz5Z26qlScYGyejikwiJmPdx5rFMb/bJCzVAAR9IWHvB6uHa8pK6xDlVdoQHcyvjSfAkrxOdJCFl0pkB0Cp6aLxBPZv9EceuD/gVPx/JPqpWXdHH8f8PFF9yMWIu/2Bo4EJHihi8D4/cADVur5dhsGk274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544179; c=relaxed/simple;
	bh=InSA6fC0hkW32c7upPwErjTBuiPt1MrZU/S0Yyi4ytk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=puTXEnlWLojEI/N2UGcKW3HAOSFQCW0iXuDY+Pn4ia7N7mENE14KVDk9arn7eeKAk0imSCf5G+m3mXd7+r2b39l8kgqAt5dEEjXZ/THHHF0ofZxGw3RS+S96TDu2L53vFTKmKgLo9wJLnwx010yoQlFFZ8/Sac1dzAIfjBrSp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svGEKe0i; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svGEKe0i"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84770f89b99so260220b3a.1
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783544178; x=1784148978; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IP4LTaRb3hmZ9XV9/GrFwPjyDBEGniEFXtNfgJ/yveA=;
        b=svGEKe0i5fLpD9VwBB76+LdqE1AFynJvezmndf+IVNBgQ45K+l1tBCkuKx2QLPJ0So
         lIQe4PhG/FAxRCWecIAlJfRbP/XNm3hcCU4zvrBCkNGbFKOl1vcqvciGGqombuNo2SuA
         Zoa9upuUNe+Z2L2rOw8DUxbkb+RYVCDUhH57h5+eIIbTUXdysnie4CGdMrDfUeAXUnL9
         7Sy2ZNQ2sM/0WtPVVQSFjwDSGlkPTBpJgbdnA2PavSjNSoJKBOnjkyfUvT04fDAHi5ea
         U5J5+OkHmeO3bLys9xKDeKOQ6WLHI2AzmmKrNiiupg8dw9+AS28rjYqheFiRlnpgTgg3
         uKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783544178; x=1784148978;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IP4LTaRb3hmZ9XV9/GrFwPjyDBEGniEFXtNfgJ/yveA=;
        b=koMpuBV4PmIZ2p4JIcuPl4y8y/txBBpujrQsjF9Ix6gQH4bqKT6EDfAd1b1rhXDVdV
         ySWLvZaEzlmRaf++9vy8UHtM3F/S5I/oeI1RzR7k4YMO3WntwYosIAbz/qnbkLxVo0kj
         eXO848bsqnrviCMbdjjevPavklj64Pa+fuzipEUWSdwS70O2uhZXZ5npNWL2N2pVeVmo
         rUMW4GfJc+VsH2k6Hx+ZuMrKBEIuDRfnRx1/LWa3TP5gIVIi+Xdql2q4kQurZzT/gDcK
         Hl8ueTzefhqB/vUfKjZPfEFzCKoTnqyS65fA1N/nsTomfJ8GX3I3UDjPTei4hFjWJejn
         zjnA==
X-Forwarded-Encrypted: i=1; AHgh+Rou3P8aLeHW03YSMHSO3Wb4i0YalH+fwxnMc701OMOl0kdcH6clmAZ6q7bBRbLTpT+jsHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDqNpa4x/KvUWSSK3bs+3Mjem8SarqOYtonv/RP1RmX5RtBOre
	5sW/sHBYFzJMMiYFshFsCqLHj5IKvvMrrby/itc+KrxgqeJKXEAETGGxOS1hlUBVGDbLL2/bfQU
	L5jQYqA==
X-Received: from pgbfe8.prod.google.com ([2002:a05:6a02:2888:b0:c9e:a22d:15b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1826:b0:848:2f84:730
 with SMTP id d2e1a72fcca58-8484303c9dbmr3420666b3a.67.1783544177427; Wed, 08
 Jul 2026 13:56:17 -0700 (PDT)
Date: Wed, 8 Jul 2026 13:56:16 -0700
In-Reply-To: <CAO9r8zNyAfFFPxNYeht+FK-BHHxcUh1DTb6aOpffm_9ebEVUSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706195413.1966458-1-yosry@kernel.org> <20260706195413.1966458-5-yosry@kernel.org>
 <ak119GtNZOmBpGmW@google.com> <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
 <ak5YUdHyA36ogsvD@google.com> <CAO9r8zNyAfFFPxNYeht+FK-BHHxcUh1DTb6aOpffm_9ebEVUSA@mail.gmail.com>
Message-ID: <ak65cOXmxoznMCNo@google.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026, Yosry Ahmed wrote:
> On Wed, Jul 8, 2026 at 7:01=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Tue, Jul 07, 2026, Yosry Ahmed wrote:
> > > On Tue, Jul 7, 2026 at 2:56=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > >
> > > > On Mon, Jul 06, 2026, Yosry Ahmed wrote:
> > > > > Move handling EFER.SVME and EFER.LMSLE from hardware setup to a n=
ew
> > > > > optional per-vendor callback invoked from kvm_setup_efer_caps(). =
This
> > > > > centralizes allowed EFER bits handling to kvm_setup_efer_caps(),
> > > > > facilitating following changes to move efer_reserved_bits into kv=
m_caps.
> > > > >
> > > > > Move the call to kvm_setup_efer_caps() after per-vendor ops are
> > > > > initialized.
> > > >
> > > > Why?
> > > >
> > > > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > > > index a0b2c40d93c21..a297a77469b38 100644
> > > > > --- a/arch/x86/kvm/x86.c
> > > > > +++ b/arch/x86/kvm/x86.c
> > > > > @@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
> > > > >
> > > > >       if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
> > > > >               kvm_enable_efer_bits(EFER_AUTOIBRS);
> > > > > +
> > > > > +     kvm_x86_call(setup_efer_caps)();
> > > >
> > > > I would rather move the togging to kvm_setup_efer_caps(), e.g.
> > >
> > > I didn't do it this way because it creates a dependency on SVM settin=
g
> > > the X86_FEATURE_SVM cap before kvm_setup_efer_caps() is called.
> >
> > For all intents and purposes, that dependency already exists due to the
> > X86_FEATURE_{NX,FXSR_OPT,AUTOIBRS} checks.  And thanks to kvm_is_config=
uring_cpu_caps,
> > it's "impossible" for those caps to be toggled outside of svm_set_cpu_c=
aps().
>=20
> Right, I missed this. kvm_is_configuring_cpu_caps is neat. I wonder if
> we can make that an enum with values {UNINIT, CONFIGURING,
> INITIALIZED}, then we can be more paranoid and WARN if the the state
> isn't INITIALIZED in kvm_setup_efer_caps(). That might be too paranoid
> though.

I thought about trying to do something like that too, and mostly landed on =
"too
paranoid".  Or rather, landed on "mostly just shifts where the bugs will be=
".
E.g. kvm_setup_efer_caps() needs to run after kvm_cpu_caps are configured, =
or
more specificaly, before ops->hardware_setup().  But supported_{xcr0,xss} n=
eed
to be initialized before ops->hardware_setup(), so that KVM can manipulate =
the
support bits at the same time kvm_cpu_caps are updated.  And so adding one-=
off
WARNs still requires on having a priori knowledge of exactly where in the
bootstrapping process the code needs to run, i.e. we still have to "manuall=
y"
select the right stage of kvm_is_configuring_cpu_caps.

What _would_ scale a little better would be to have kvm_cpu_cap_get() WARN =
if
kvm_is_configuring_cpu_caps isn't INITIALIZED, but I'm hesitant to do that =
because
it'll pollute KVM with WARNs just to detect rare bugs that really should be=
 caught
during initial development anyways.

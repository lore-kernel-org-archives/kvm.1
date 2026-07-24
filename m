Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9C83AFB1A
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925157; cv=none; b=oSEPD0gbVL+KpGmz61Sy5Qlcgicgo123B+9nCaT2PuxKAD5IaK7ETIieR5EoHYyXKNfP+L+vuvcUojZbDYYb9icZcheJHMxWp087S3dQRD3k5FWjPzrpLjbI9VzggQcIDboyYaSXqH+/VCRZ8No4q7j+b7kQRAfgNGZ11Z7gSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925157; c=relaxed/simple;
	bh=wbvnFfXVNNyCetXL1G+HGd5vNzk6KZOEDyK1EU9PmL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b6azcGLrMV2G3llG+IbveYC7tUI4EeG/iyQaejyDBu1MrVsrBaEKdiXja7dwQUWJ8HDGWpSbFm+JfoIteivkf4jxczOnrt7K/GHa0pjYR5EcWg833Dp+LKycEGE0ykauk3RwnE7q9BY3ss2h7y1llYwU7FWDxdfP13qF+p6dF4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wcoa9gmc; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wcoa9gmc"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa4e4684bso21249355ad.2
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784925154; x=1785529954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8vQ5j8kt71qvQYEPkJl0026Rq7b2mwI8dRhp5tUeKPk=;
        b=Wcoa9gmcUSG+7x8634quKwrSBSZilETuA9U6UBWd51DvZDYK7W/Uw+8q5V2NcGKE1N
         8q2B0yb7Qh+RGGW73FuCeBa9ePI9YqrJkyH2wkGCpLHXDbwrlX5U1WL6/4SDklHzJ9su
         LBQR/XzFh+7DpD7aQTKTzrNcD27cHRslFTjoG4PtprwFY6exRBt2nCwV1BqRsIrTVuMW
         BOXg2N+14cA9wPnnsne5cGjWvNiPAMWzasfZu1neqhlpDpBGDnDXQHUoHBCoLhcUdvmT
         kL4Oz7UOAoOcOkuPR3XJHovVkhTcQj05jTcp5zr+IZGcQj5E/raDu8u4w+iLzvnxQ0JY
         N3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925154; x=1785529954;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8vQ5j8kt71qvQYEPkJl0026Rq7b2mwI8dRhp5tUeKPk=;
        b=U0IS+rjb0J1Q94bI1WY9MpX7zR9pV47oW6/Ht2PIN9l1TOz5NmYRZxlb8nkT5+dhOs
         qkw2LcSURKT18fu/gU9Wv4+P8gWRPfPyzwdQX6fkn1cLOW6CSTmTdVY3YtjOSUAz48NH
         Mt60hHXrS6Rh1IEcjNjOMb0ZSYvqFqqxZx2JcwF83TkB+XD8883VwzHvL4KwPpnPlxaQ
         6RbPlLdAUp8C2yyVf/LknbEIwgOgqPaKqiC7NK/oZm9vaPDqWsCDyz4xl0XP/DHqSJfn
         Ap/7IByWZbCqXJqt8GubT5TE/d3OKfF5HsLQ98sM05nxOrXBsnK0pH82xKcT7ZQWmV3X
         7R2A==
X-Forwarded-Encrypted: i=1; AHgh+RqcVwkK9Ju81JxVecFOuTWxd7GBaxgxz4hm1D2y8B/HXdN8Nqz2lxgy1gJt8B2FuX2SP0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPcolY1ArSMC9vzdn4dn2NDY7sgEZ55PTP9rHTqrGH4Hy3a13
	TH5PAfJVUAfqPCzTFLnxv7AUdINA8QzR49iiVgrQdrlVRtuzHRnqaccWxfwimAzFptvkSCsaytg
	wiF5UMQ==
X-Received: from plbkt11.prod.google.com ([2002:a17:903:88b:b0:2ca:b8f5:2d26])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94d:b0:2bf:dd0:c8b1
 with SMTP id d9443c01a7336-2cfde56bf07mr370435ad.0.1784925154059; Fri, 24 Jul
 2026 13:32:34 -0700 (PDT)
Date: Fri, 24 Jul 2026 13:32:33 -0700
In-Reply-To: <CAO9r8zO15oLHXVhyE8rR7bOMM4Ks+qzRAsz=5W8kXMwKU5gbnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
 <amOl8kczWlZP_ftH@google.com> <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
 <amOuALTiqI9u4tFh@google.com> <CAO9r8zO15oLHXVhyE8rR7bOMM4Ks+qzRAsz=5W8kXMwKU5gbnA@mail.gmail.com>
Message-ID: <amPL4b7x3cBxA_y_@google.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> On Fri, Jul 24, 2026 at 11:25=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > > On Fri, Jul 24, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@=
google.com> wrote:
> > > > >  static bool parse_args_nested(int argc, char *argv[])
> > > > >  {
> > > > >       bool nested =3D false;
> > > > > @@ -192,10 +218,13 @@ int main(int argc, char *argv[])
> > > > >       gva_t gva;
> > > > >       u64 pte;
> > > > >
> > > > > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
> > > >
> > > > But KVM_CAP_EXCEPTION_PAYLOAD _isn't_ required, it's an optional fe=
ature.  Actually,
> > > > this is ridiculous.  The test is injecting a #UD, it doesn't have a=
 payload.
> > > > Bad AI, bad.
> > >
> > > KVM_CAP_EXCEPTION_PAYLOAD is required to inject a *pending* exception=
,
> > > which is needed as KVM won't check for interception on already
> > > injected exceptions. I will add a comment.
> >
> > Drop the TEST_REQUIRE(), and instead only inject the pending #UD if the=
 CAP
> > is supported.
>=20
> I prefer to keep the TEST_REQUIRE() as I don't like the test coverage
> silently changing based on the available caps tbh.

That ship already sailed by agreeing to make nested support conditional :-)

> Does it matter in practice? IIUC it's only possible for KVM_CAP_EXCEPTION=
_PAYLOAD
> to not exist if the test is run on an older kernel, right?

Correct, but people do run upstream selftests on older kernels, myself incl=
uded.
We do effectively break/drop backwards compatibility if there's sufficient
justification, e.g. KVM_SET_USER_MEMORY_REGION2 is required for tests that =
create
memslots so that selftests doesn't have to carry fallback code, but I don't=
 think
this one-off test qualifies for exemption.

> > > > > +
> > > > >       nested =3D parse_args_nested(argc, argv);
> > > > >
> > > > >       vm =3D vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_cod=
e : guest_access_memory);
> > > > >       vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handle=
r);
> > > > > +     vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
> > > >
> > > > -2ul?
> > >
> > > That was actually me, not the AI. Apparently the other selftests also
> > > write -2ul for some reason. I was too lazy to go change them and/or
> > > figure out why -2ul, it didn't make any sense to me. I chose the lazy
> > > option and just used the same thing here.
> > >
> > > Someone named Sean Christopherson wrote the other two, maybe we can a=
sk him? :P
> >
> > Nah, that guy's an asshole, not worth your time.
> >
> > > > >       if (nested) {
> > > > >               TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cp=
u_has(X86_FEATURE_VMX));
> > > > > @@ -270,8 +299,16 @@ int main(int argc, char *argv[])
> > > > >
> > > > >               state =3D vcpu_save_state(vcpu);
> > > > >
> > > > > +             /*
> > > > > +              * If the vCPU is in guest mode, inject a #UD to tr=
igger an
> > > > > +              * L2->L1 VM-Exit every other iteration.
> > > > > +              */
> > > > > +             if (nested && vcpu_state_is_guest_mode(state) && co=
unt % 2 =3D=3D 0)
> > > >
> > > > Checking "nested" here is unnecessary.
> > >
> > > It is, actually. Sashiko pointed out [1] that
> > > vcpu_state_is_guest_mode() will read uninitialized memory otherwise.
> > >
> > > [1]https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40ke=
rnel.org?part=3D8
> >
> > Oof.  That's subtle.  At the risk of true evil, what if we did:
>=20
> As I mentioned above, I prefer taking a dependency on
> KVM_CAP_EXCEPTION_PAYLOAD rather than varying coverage. At least for
> the nested case, I think I can move the TEST_REQUIRE() into the
> 'nested' case, but then it's probably better to leave it as an arg to
> allow for meaningfully running the test in L0.

The problem is that TEST_REQUIRE() skips the whole test, regardless of when=
 it's
called.  I.e. if you go that route, passes for the non-nested case will sho=
w up
as skips.  TEST_REQUIRE() really is intended to be used when something is a=
 hard
requirement.

> Actually, what if we just skip the nested case completely if
> KVM_CAP_EXCEPTION_PAYLOAD isn't available?

Can you use KVM_NMI instead of KVM_SET_VCPU_EVENTS to effect the nested #VM=
EXIT?
That ioctl is so ancient that I'm a-ok skipping any CAP check for it.

> >         int inject_ud;
> >
> >         /*
> >          * Big comment here, explaining both the CAP dependency and the=
 need to
> >          * check for nested before querying guest state.
> >          */
> >         inject_ud =3D nested && kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD);
>=20
> Either way yeah I think we should document why checking 'nested' is neede=
d.
>=20
> Or.. what if we just check state->nested.size inside
> kvm_x86_state_is_guest_mode()? or explicitly clear state->nested in
> vcpu_save_state() if nested_size =3D=3D 0?

I like both of those ideas.  If you do the former, definitely make
kvm_x86_state_is_guest_mode() a "public" API.

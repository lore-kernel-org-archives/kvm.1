Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D32222C5
	for <kvm@vger.kernel.org>; Wed,  8 Jul 2026 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519316; cv=none; b=dBQTnbERM7UKeefsUPUxlAoGdJMdYfKxWHH8UvI/5ipSugnvvNtjD/n01R9SpIcn5yvf1sYArcOxzmePu/qB07CqQiuJnS2X4/5lphySsirusvVM8Of+2bRUEmuFZKosRf3nEdDczw/C8Al9YjFvFSgcEWBe1QVAaZ+MIp6sjbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519316; c=relaxed/simple;
	bh=zBXsTai/z/riqP2ORiZQ+/4kcYLuwuCmQqpIK8pTWCM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YzvLqGq4blN2bbCJOcU9YmCFkPjnl1X813V0TbyTSXKCoHswFQtfoRtF5ehW5K6jO1no2149TR6W3+BRbAElOMI4pdiLU+FcgwNt25OJSROMj/vsJtFB5W3IJebUbcdSFdFOTU/0SNwV4xhW5a6jqF+JCMWnIz4CPTOvYYhrHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ud87mpf6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ud87mpf6"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-847ad67cc51so877351b3a.3
        for <kvm@vger.kernel.org>; Wed, 08 Jul 2026 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783519315; x=1784124115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxR81hBer5PwAaK7yGpwVn/yDsCCiJJD6D6Il8CrWlw=;
        b=ud87mpf6Xbw+xGjiPL5IEjNLadgaaTN5eUSuJnIBPKr4CZBkCcODDfZMjOIIlT8Iqp
         XgXPMmnhHE3FfTLumznWqATplIHOLwQ+tMRIDoO0eA/IMxgfDEQgzOWQ8Y78yjO44m8Y
         m8Mroxx9bKM/BRha+Ky6MwtoOBjCMUl1VHfR3ykSEhvyp++f9ye1C/BfRsTDRchE8XLh
         /UO0Pg5Ool1GyQdxyyW1u83fffEb3mKHwEXXqeZhdx7i2t9Gl3WaWP1ZQ3O6919nqsEK
         KSsH7mBjn0NqOCLi1/EHYi+1uRoL5ie7ItbCFcfLz3+ZUvkvKrZ3rqb30Gn1VUF7V5nW
         tlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519315; x=1784124115;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oxR81hBer5PwAaK7yGpwVn/yDsCCiJJD6D6Il8CrWlw=;
        b=o3fzCwMD74wn4K5xgtHzLzBUh/9S1Df8EqY9/fD1PIDRbgV3vIFFoIzo681fUFygxg
         7KtZbXj189l3z0d/HpxS7FD8/UuWxKzEMzaQv3fPtUB1635SQfXVHVmqRUgwLLvLf1lZ
         4FmwzOyEZAbSrS9KzVZM8zASkDImaZyA/ns2rW3l7PtBRM6S7oO2BPLNGJsbgR5MHF6T
         ecRJYcys5N2Gdr2alux+3PQAfdYt5V8AvfNLcOgJ1uDgiE3AY8itzIAsvXQNCirvSgkO
         h9yvhwLZDoT+PF2riCFty2G/aOUOkClZWiRBNxD+m3pl5I4K9TUjRfBOa/2VAjfUcf5J
         xWMg==
X-Forwarded-Encrypted: i=1; AHgh+Roh4IvgdF/yVvb6bK+Zi8JNRNXvLnsvtN3vT0ltRAGaMfhbEf5f3FG280Kz0x2oADSQCQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyofIXPI+o+OIyKrHbryrsmRVBuTDmg6rjq4Lz7KIJLZ3yH1+xo
	XqaIQAE4W7W2uhPPZ/Z7wfSh8L+hZgVKfdcwxkbx1I/mc3hpGbC5BiNA53I3J8qLnq/abi/qAOK
	FUKwQqw==
X-Received: from pfbef21.prod.google.com ([2002:a05:6a00:2c95:b0:848:42b1:ffd7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3996:b0:842:2ddb:e305
 with SMTP id d2e1a72fcca58-84842f9f06fmr2427282b3a.43.1783519314467; Wed, 08
 Jul 2026 07:01:54 -0700 (PDT)
Date: Wed, 8 Jul 2026 07:01:53 -0700
In-Reply-To: <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260706195413.1966458-1-yosry@kernel.org> <20260706195413.1966458-5-yosry@kernel.org>
 <ak119GtNZOmBpGmW@google.com> <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
Message-ID: <ak5YUdHyA36ogsvD@google.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026, Yosry Ahmed wrote:
> On Tue, Jul 7, 2026 at 2:56=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Mon, Jul 06, 2026, Yosry Ahmed wrote:
> > > Move handling EFER.SVME and EFER.LMSLE from hardware setup to a new
> > > optional per-vendor callback invoked from kvm_setup_efer_caps(). This
> > > centralizes allowed EFER bits handling to kvm_setup_efer_caps(),
> > > facilitating following changes to move efer_reserved_bits into kvm_ca=
ps.
> > >
> > > Move the call to kvm_setup_efer_caps() after per-vendor ops are
> > > initialized.
> >
> > Why?
> >
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index a0b2c40d93c21..a297a77469b38 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
> > >
> > >       if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
> > >               kvm_enable_efer_bits(EFER_AUTOIBRS);
> > > +
> > > +     kvm_x86_call(setup_efer_caps)();
> >
> > I would rather move the togging to kvm_setup_efer_caps(), e.g.
>=20
> I didn't do it this way because it creates a dependency on SVM setting
> the X86_FEATURE_SVM cap before kvm_setup_efer_caps() is called.

For all intents and purposes, that dependency already exists due to the
X86_FEATURE_{NX,FXSR_OPT,AUTOIBRS} checks.  And thanks to kvm_is_configurin=
g_cpu_caps,
it's "impossible" for those caps to be toggled outside of svm_set_cpu_caps(=
).

> e.g. it would break if the call to kvm_setup_efer_caps() is moved
> before the vendor-specific hardware_setup().=20

As above, that would break for other reasons.

> Maybe that's fine, but it just seemed like the dependency can be easily
> avoided here by adding a new vendor-specific callback.

No, all it does is change what can go wrong.   E.g. if KVM cleared "nested"=
 in
svm_hardware_setup(), which is *very* realistic given that we carry an inte=
rnal
patch to disable nested if TDP is disabled, then hoisting kvm_setup_efer_ca=
ps()
above ops->hardware_setup() would still break (even ignoring the above issu=
es).

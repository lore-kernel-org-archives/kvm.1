Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F63DC4AB
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783463362; cv=none; b=TETaJTV2sGBsHAKxZzb5GpRSfRnJC0vpIhNEbEHFsMENPwMuyduU+kZemh2ncHiMiAAoxDXXKP/mHsq+s4eqOZUkzxQgDe/Ek3SXuaVdMa/RdGHCceN4v9eYmnKWl63be7sqX9UycuuGsHHhLrxkMjLubvAKWTiKzD5ZCdwhFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783463362; c=relaxed/simple;
	bh=hucUs12t9+ffNbK4mZWIqhMBRV5Jx36UP9ORrsz45l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUsZos6NxfNwrQcJCVfwh24oxQar6lJvAwMd2AaRE8cz+VLDI6zpAAFKsneBU0kTDQHhzFoG2ZXpiTebIVHa8pjvqEsJKI1fan4Nix12n9VViGdih1PBBtXMFQttk6niWqHHZ8RKnpazI5RBxV4UfwZdoMgIj6+xA4usi2Hj5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsp+UtJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsp+UtJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5557A1F00ACF
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783463361;
	bh=MpXaJc6o13imtxHDmbffo12Gawp66Vu6Ek6Chs1NAS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gsp+UtJ5kgBr1YD4VweTrIKnB5wNy5ShU5Zy6H+9qjLYHDfIOmH/2ow0YFoVZVFbP
	 TZviwm7D0U2JBDlAaiBFxChCLP7RGQ2OCv+PZ5rJBCtYz/IweiN6U8nEFjBM/lZ7gH
	 7b5y1VhDsUwzpyIMt19QkxWwsEwHhm1GVZO8pBgqTsZox1SpGLfNe3TkKDjGiER4+D
	 jGf2IcEECdZisLYfXMTU3aRsv0u8GEPUdjo2l1mxxHwaq0SSdzioFWl6/f/5Vy8D1C
	 lNGNfVwHZJ5V7CkSJizFhN0vsP51hPDPoz2KpLkqSQrf92vnuWxQlLh2pf9gC7GvI0
	 ewr2KLkwr0aZg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15b75c9e48so936166b.1
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:29:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqxfOkDVsKZPLQdkaQyhNS+5CTDdISCn+Q5w61j4Ciy7pqD3+2rDkxhwiGwYUJBM0j/zVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKahfnIx+xA/ge//4ynbDTuZ0PkDDj+L7c46zeVhqMoTGWJHng
	XVsyISB27atndjStm8Cv+DXlGvRTwzia3WQKHwL4JQtwA/PiVqSD7hWNx6nllb+OveEoNyrIAGw
	2qXjV+eQzml1WEB9USl0HR6e5YE4R4o8=
X-Received: by 2002:a17:907:9444:b0:c12:a417:30ad with SMTP id
 a640c23a62f3a-c15cdec7780mr2746266b.7.1783463360267; Tue, 07 Jul 2026
 15:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706195413.1966458-1-yosry@kernel.org> <20260706195413.1966458-5-yosry@kernel.org>
 <ak119GtNZOmBpGmW@google.com>
In-Reply-To: <ak119GtNZOmBpGmW@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 7 Jul 2026 15:29:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
X-Gm-Features: AVVi8CcK9bjjoR2ZaSDM2oF1nQozu69mexfTXTKXYRqlQAcN0L_XraM7eem8kw4
Message-ID: <CAO9r8zPdJHE=ztF8enA58EbR3iy4_Urhc93RkHiS2HkEsDkS_A@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Add a per-vendor callback to setup EFER caps
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 2:56=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Jul 06, 2026, Yosry Ahmed wrote:
> > Move handling EFER.SVME and EFER.LMSLE from hardware setup to a new
> > optional per-vendor callback invoked from kvm_setup_efer_caps(). This
> > centralizes allowed EFER bits handling to kvm_setup_efer_caps(),
> > facilitating following changes to move efer_reserved_bits into kvm_caps=
.
> >
> > Move the call to kvm_setup_efer_caps() after per-vendor ops are
> > initialized.
>
> Why?
>
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index a0b2c40d93c21..a297a77469b38 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -6903,6 +6903,8 @@ static void kvm_setup_efer_caps(void)
> >
> >       if (kvm_cpu_cap_has(X86_FEATURE_AUTOIBRS))
> >               kvm_enable_efer_bits(EFER_AUTOIBRS);
> > +
> > +     kvm_x86_call(setup_efer_caps)();
>
> I would rather move the togging to kvm_setup_efer_caps(), e.g.

I didn't do it this way because it creates a dependency on SVM setting
the X86_FEATURE_SVM cap before kvm_setup_efer_caps() is called. For
e.g. it would break if the call to kvm_setup_efer_caps() is moved
before the vendor-specific hardware_setup(). Maybe that's fine, but it
just seemed like the dependency can be easily avoided here by adding a
new vendor-specific callback.

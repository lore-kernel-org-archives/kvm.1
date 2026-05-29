Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEA3E51E6
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063852; cv=pass; b=VhfpBdk0OHB7+U1TlO7BjleCN40LGX4CUkKtOf2Ii6EdM3WtjWrrv29KnSqx/E18JzkFQ6EUVc+lMvWeUVRXFeoyo03ZQy582yAZVpXftdhWk8wTKO9nDkfMgFfDrmQxY6i+EuHEA0Inh9Cjw3r6ftf/1nJ7Gh5ZTczfFb43LCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063852; c=relaxed/simple;
	bh=+cH4m6H+vLmmUmC4jPEYFeIBBvt0KRbPmUIK9xWmPUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4/OJB1T2J8ozDMBfhrmgxK7SgT84XfbCMZL7TaxwKZZqgFJ8D7GfL2P2TxF9r437ARDSDsRGvfVFGkpaBCiXLXsWjQ0pWUU2wGmuASTPVfQE4l11eEzR1hsE2WM6TcYCa6tW1FjlY+pU7E1IhksQ6KKsHMaR3NQYvYOacvxIcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W+xproUE; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W+xproUE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso272a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780063845; cv=none;
        d=google.com; s=arc-20240605;
        b=T6QtIS/2AdSEe74a4Us7EyFuGwXIryx+Vp7o71/hga/U9Zwk+28xUhstk6UeOnesWB
         ScJ5jAQEzU5Rhm58otIdoMIOP2bCWRtXevY80DEVv7Ish2NncAFOYbECWL77IgNn4zeM
         IGZYum0hnKRAMxqjAppx33eI9EfbkM/K1ZhzlLDEg4d1JqdQFf8lwXA7AxKZMnj9RDJm
         PgwxzQ6Lti7QG708By9bkro3III8b+DgG6BQ/IzaWP23Q1iLRBFnMyTqq0GjfvZ2rKnk
         2HpdkGOoKepEkEPr1Xu+Kkd2P1sicMLeFmFnEv5ZM2pEVGCtyB+u1Xvhymc6XvkPeKoI
         O+MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVqlXYgn9XYbyQhIBRqAaGMuFYQJj7MF5WCC0ENHb44=;
        fh=zYvDmUq4vxt89JPZCzK+M7YNFJBQD4W8x29BXyD8998=;
        b=JxPEh+yGMUvvMvm9tHO6s6wlLEt6UFGbFrVgFZnhBLhKaopxKQWnBkIkQ1eDwKFcfi
         pcGx9mAbpI2KiNGwi3nGQ5lnB7RUdjkDvBwK/EnuR5bDLxFcGn5pBfriswhJSf60X95T
         DLYR4q0MKZiskpEU0C9qrl0Jv+5D7GQXO6TAEHUsbUixgVlxvNEUUFUH9/1FUOx6rUej
         levzhjg60Bo70kjLoLHIcq/UUrV+o9GRNmcjsdOf4r77wJcXKQlHXab52Kdd9DUcBAfs
         w+ShmJMvFoG79n0UzAjQpYPMhLYiqYIDTLcgDiRK+3MCiQKYPE/Aswk9Kal0teh75MFG
         JaMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780063845; x=1780668645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVqlXYgn9XYbyQhIBRqAaGMuFYQJj7MF5WCC0ENHb44=;
        b=W+xproUEQTrIVAAR9W0P7LEXW2+D/d+FWNZYiwpISskXSNH0QYINf8pRXP8aa86uKl
         2p7obKuzXMmh/HLxMxMOW+IxB3z+nsI1DwsLU+v4snla5c6UAUKB2h/TnuaVVMk0utSa
         q9wpqfpH3VfRyv+9dUq7AcYw3vogWxmK3RNsPnyO94/APsuRpd5MFcAomGoFEqatwPj8
         1VgeAZhkC4flXnGMpLelTV5rrcjVI3PUf9GBtkSMT+ToTWv1WHjdoceJ1bkyrSA2amVI
         yrkYlRGSsc49MZNEzEbd4YFn/wDV4eRzCTCW4ta6CVy0vLqRQCJzxTbkV2oEV0zacOJT
         A88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063845; x=1780668645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVqlXYgn9XYbyQhIBRqAaGMuFYQJj7MF5WCC0ENHb44=;
        b=jlUzy2w7iRMF3+uxAf2CrhbaUgBFGRh9RGs4GmHkfxlraqXq9rbXigu+Xm+TaJA9E/
         sfxE/zULf5GqcegayyuFfVfnGlESEr9EVxOKUuMglYH4FNEmxf3OX4+aYiwjzZhYRGVN
         2qf8jpZXcP9bcT7/xF9pGSL/gYDCqdmzEyL2n7HbQnD+b4dT9x4UzhOQ6UG5xGV5QrEV
         pnorplqhGYJrJj+X82/t7tM/CMmAaAiNqIs2+QCPGSIKJcwk+YUWU+1tFESab4qqWws7
         oBIxqjdEB/EucCydFKo94XC2stsJL0TKy49ZHbHEoc3L/i9mTZ1KQnLSGx2s40ihABJH
         P+9A==
X-Forwarded-Encrypted: i=1; AFNElJ+7x12fXx1TgGy/TjlJaMj9K0SR83imyZqyWCaemOryCRGczsvKKDEfbczJj3MvDaBHZM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfoLm0nktluFc9+Zdn7NlXVWZfGWGv3cmiro8EaA8p89wOKyCQ
	Qngkwdee+B+enrk6a+5MffE77BloWpxOS5YvCnH+a5MY4TP+9pzPne+9twwvWIby+qkPaUuxNT7
	GyLoM43HmwGs0QESPhL1qvx+pyEDUii/ibeJK9Dhe
X-Gm-Gg: Acq92OFx3Qp4sfs6PzQY5itrGGpHJUaixKJ0yAxMILhOXjFPWO2TTTeGJjPo6pqa4+W
	lfLOOE0GSvSPlCIJW5cRwZXgXYOgJoo2dYF3CiX0sQRm3dP5cokd72+hY7gsiPc+W6SU5lsH2q4
	EUE1BIzgtXkO4/Sf0Pa/JJ+3DJEIVnecdA+eij0+VIVcheE9pEPdKod4BoBiQizO/AFqEgLf20L
	u3FRemeOqp5Z0WP4g3NAC/Er5CO2mprGMAdHgOcZ5zhjJw890+RGTd1d7uUb4Qln+vD8cid8eMe
	pyQRqlv8A4GEtUvsJw==
X-Received: by 2002:a05:6402:2270:b0:688:9c23:24aa with SMTP id
 4fb4d7f45d1cf-68c0a49bc86mr40478a12.10.1780063844941; Fri, 29 May 2026
 07:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com> <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
 <ahmUPsB2nOPFCRrW@google.com>
In-Reply-To: <ahmUPsB2nOPFCRrW@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 29 May 2026 07:10:31 -0700
X-Gm-Features: AVHnY4IQqSvI2pqTfmvMt0vdawFBiU7Rfknr1YxCi3kDJAQ1SnYa5a7RI0FInQU
Message-ID: <CALMp9eQ+XmKbpY8QePbjZMA9fNm4-77zbDBNX2M-ZOdumNGyxw@mail.gmail.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 6:29=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, May 28, 2026, Yosry Ahmed wrote:
> > > +int main(int argc, char *argv[])
> > > +{
> > > +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > > +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > > +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > > +                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > > +
> > > +       if (!kvm_cpu_has(X86_FEATURE_NPT))
> > > +               goto skip_npt;
> > > +
> > > +       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_ena=
bled =3D true);
> > > +       gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled =
=3D true);
> > > +skip_npt:
> > > +       gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled =
=3D false);
> > > +       return 0;
> > > +}
> >
> > The goto is really unnecessary here:
> >
> > if (kvm_cpu_has(X86_FEATURE_NPT)) {
> >        gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat,
> > npt_enabled =3D true);
> >        gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled =3D t=
rue);
> > }
> > gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled =3D false);
>
> Well, it's necessary to avoid the indentation.

Or refactor as:

if (kvm_cpu_has(X86_FEATURE_NPT))
        run_npt_tests();

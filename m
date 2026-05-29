Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0336E498
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 23:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095677; cv=none; b=Wc8Y4c+X/AToLii42EJ0vzfoGyNPdrjPXj6Xq3waENrS1aKS4K8OQiLbmUJn5ya/d+7hcB1GiaUytrL3zyC47nHnEzW7CSLhyBGG6tv2Alld5/9mX08ESEKBd533jmmJuF8AJ2QZQ5DGAq2hAxGdUy8RHlk3NAJqy9xNMtnaPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095677; c=relaxed/simple;
	bh=Wtzh3vZgvoV73yIHEEenuFdz2wwq/WdzuKJyl1MX12w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPX74TMKSOoFyk5c4B3vr+LTluSZlORSvM9QqF8wZZ+/AQPhgze0WHLNaU3fsQ6WJEYXy4lO4VSeRQCZDDKVS1Qjcr1MzRfe6FVacDjo0NdWr/EFO4oBVfbJFDpx1Sy8MlgqpbHgko/yHzQ+WY7HhZiHZbxDlXN7leluq+AdacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFcVr2FZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFcVr2FZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9401F0089B
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 23:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780095675;
	bh=QEHj7IM93tgAoLWoq1d3VS8HcDS5hgINQQCwWeuQDDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MFcVr2FZRnjRaSeZ6ttKOiJo4jW0WJm1ZNP6pd1PmLAWrSZ69dTCS7x8IELI7JXDx
	 is52KF3RlEiQ/KxFXeUoc694gm6zptys1traOSxo1bB5QL7RZ5KaLzn7+xIqWq4G5T
	 cgOIlkWVn6kBBjMFb84yipYaDv21ntrKRCvnLkStiapBQXGaHeelgyCee7TWcEM1zy
	 w4M16F89BxaW+fxPE4BLMCYmmTKiXGhjRy5Rpy5P3MW30st2t4iK+Tx5xIQGkuLsC0
	 cuXu71/Kr6XfGWN66sS004QQBkrXcqFraWhCPFMOz2dpnb6RYiLA/jzKv/56B+strN
	 GYWzknKtmnuzA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bdb3eb93e20so1498699466b.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:01:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9tK7XrTtwJ45FjMDiHmL/cgXeG9D0aZmJ1OxT8kbw8g6rJWVLqSIy6xT4q0fYl0IsrRVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQv063FoIRqDkRygenh0fn+yqIh1Z+Qkv2A01hUuvkZkcsYBFM
	vK8s6vT79KCtOEnfg2lURbO2SslEy37UZb376hAPll3rb/6XJ0218g+BWwE/CLY4Qj2VmoE5BrR
	Uke5p/pIwFra0PjaHYDostJHmcqtNjRg=
X-Received: by 2002:a17:907:1c1c:b0:bd5:18e8:1ae4 with SMTP id
 a640c23a62f3a-beab542b2demr92790966b.34.1780095674750; Fri, 29 May 2026
 16:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com> <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
 <ahmUPsB2nOPFCRrW@google.com> <CALMp9eQ+XmKbpY8QePbjZMA9fNm4-77zbDBNX2M-ZOdumNGyxw@mail.gmail.com>
 <ahoZfWeYsAICk9xc@google.com>
In-Reply-To: <ahoZfWeYsAICk9xc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 29 May 2026 16:01:03 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMrXbGevTgNttshFf88RDKrsaa_r5WryczFK8OMVcdHDA@mail.gmail.com>
X-Gm-Features: AVHnY4IUwJWA-UctmZMC8tEAs5R7LbT-tjQyrzEiA6CmcrawTdcBJPJFOx8R9Kg
Message-ID: <CAO9r8zMrXbGevTgNttshFf88RDKrsaa_r5WryczFK8OMVcdHDA@mail.gmail.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 3:56=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, May 29, 2026, Jim Mattson wrote:
> > On Fri, May 29, 2026 at 6:29=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Thu, May 28, 2026, Yosry Ahmed wrote:
> > > > > +int main(int argc, char *argv[])
> > > > > +{
> > > > > +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > > > > +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > > > > +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > > > > +                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > > > > +
> > > > > +       if (!kvm_cpu_has(X86_FEATURE_NPT))
> > > > > +               goto skip_npt;
> > > > > +
> > > > > +       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt=
_enabled =3D true);
> > > > > +       gpat_test("Nested NPT enabled", l1_guest_code, npt_enable=
d =3D true);
> > > > > +skip_npt:
> > > > > +       gpat_test("Nested NPT disabled", l1_guest_code, npt_enabl=
ed =3D false);
> > > > > +       return 0;
> > > > > +}
> > > >
> > > > The goto is really unnecessary here:
> > > >
> > > > if (kvm_cpu_has(X86_FEATURE_NPT)) {
> > > >        gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat,
> > > > npt_enabled =3D true);
> > > >        gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled =
=3D true);
> > > > }
> > > > gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled =3D fal=
se);
> > >
> > > Well, it's necessary to avoid the indentation.
> >
> > Or refactor as:
> >
> > if (kvm_cpu_has(X86_FEATURE_NPT))
> >         run_npt_tests();
>
> Anyone have a strong preference?  I like the goto approach (obviously), s=
o that
> that all the gpat_test() invocations are prettily aligned.  But I can liv=
e with
> an if-statement as Yosry suggested.  I think the only option I don't like=
 is
> moving the NPT tests to a separate helper (it's two lines of code, and te=
sting
> the NPT case really is the focal point of the test).

No strong preference, I obviously also like my suggestion :)

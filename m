Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0560833987F
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095360; cv=none; b=Y3JuXGwW8Ptx40m9BA11xxKHEShODRndvOmLYF58Z++7uBBfgjeCRFFq8uP25maic9kQ9tac73853N0OKvf+Yq4M6eTEq75oe7JBY8cIftGYilaszw8Nq+T+uZU34ioWleFx4xLdtkY0ueKuiT07a2892aCn2WLIBpv0mNNCJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095360; c=relaxed/simple;
	bh=iV4YGhPySmlBM78aNDWKoQdgGPcNG91fb4mH4mboztg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i0iM7cTL45NY5EiYYXGzR9V5pLRR0JV06VdAACdfIp//NyYoG1weMEEgY2vJDoydjMfN/IEMnvJmtt2sORzOdzoso5kcMaD4kkohXasUvSn8XG+29RW6twEYbfH8M1C2DNBv+yUzHn2ppK90IHuc/PTNpFpjYR29rA4+a2Wg9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O9WkpdLZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O9WkpdLZ"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso9736557b3a.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780095358; x=1780700158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqQ8bdOd2IYgycthQS91C6c2MIAnsjTH7vSsVIpw1VA=;
        b=O9WkpdLZxzZDhjVtzlV7XBBNbqhQcJteV7BcBJsGfMVM01+RzSVha8QnkG6cNQ5zv6
         JiXNKzj8LO/vtxWK7Tmi+ovkBiM1s5/XuHH0wPugEOwbWOvFzjc8yb5uBcpbqbj5WvVQ
         S3mNTmPI3+4l7hEVgUT1QiRMGPxnRbGNekhIb9FgIzHcc04Esq0QUxG/xGFS3e8Usnqi
         K/vv+pXAhRh3XcF55c+SYfH8EywX+zafywU9GEUJkMGK9aocl2XXkCg+OdQIFdEC0C45
         l9kB363xX/lA6pYLIhcjMYln1V1zcgr/2+zEfU+ppRAiRve/U+rze88y/cixbvDX6JKC
         FBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780095358; x=1780700158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HqQ8bdOd2IYgycthQS91C6c2MIAnsjTH7vSsVIpw1VA=;
        b=R9SlAqEWbr2kMkRQUZ8iiz3zngDKki1CybiGyoYj/nTRtJ7PD9+WzjiP4vZXPsLnnU
         FHQY2buwL3UVhHGanAO/NUQRvD0ch6/ExIkHWpbLSNFKvnLMj1x511MNfjEbW7Gu64qh
         w1vb2+aFHfalLHGpq8DnlhcLDzdUCYI6ITZCZvcS3SeBCJlaBtBvqa0r4XskfvRIaH1L
         nNPsE6/ACWfoqnByMgMy4rOqSf48n5W/VHEZUo/nstGzSiSRCEmTxa0mJ9e2wJnYFuKh
         OXs6CmnukPqbVVoCt5qj38VuwaOqZ3uMsb3gD66GZm60ED6gNr0AkxUxgKsQHwSiRk08
         aQyA==
X-Forwarded-Encrypted: i=1; AFNElJ/eliIYpL0cpWCzrEkedMMXv6MPzdb6wmVm48VU78ow9XRjYo0WrIgFpN52bPMgH9mOXHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKNGhYv5PgH+m62ydw6c+5cBW0tCzYyusp16ky3g2Rojyw2J3Q
	h2nbtSNMEgqMY8sR+Xw4rVqK7VwdnXArTVoibvwFxFd/722UNGw25qAUo7DicPlr1+de3TVKd2s
	DhE8spQ==
X-Received: from pfbls23.prod.google.com ([2002:a05:6a00:7417:b0:835:4568:a5a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4488:b0:842:2419:6bfe
 with SMTP id d2e1a72fcca58-842253d0998mr1379817b3a.7.1780095357948; Fri, 29
 May 2026 15:55:57 -0700 (PDT)
Date: Fri, 29 May 2026 15:55:57 -0700
In-Reply-To: <CALMp9eQ+XmKbpY8QePbjZMA9fNm4-77zbDBNX2M-ZOdumNGyxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com> <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
 <ahmUPsB2nOPFCRrW@google.com> <CALMp9eQ+XmKbpY8QePbjZMA9fNm4-77zbDBNX2M-ZOdumNGyxw@mail.gmail.com>
Message-ID: <ahoZfWeYsAICk9xc@google.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026, Jim Mattson wrote:
> On Fri, May 29, 2026 at 6:29=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Thu, May 28, 2026, Yosry Ahmed wrote:
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > > > +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > > > +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > > > +                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > > > +
> > > > +       if (!kvm_cpu_has(X86_FEATURE_NPT))
> > > > +               goto skip_npt;
> > > > +
> > > > +       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_e=
nabled =3D true);
> > > > +       gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled =
=3D true);
> > > > +skip_npt:
> > > > +       gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled=
 =3D false);
> > > > +       return 0;
> > > > +}
> > >
> > > The goto is really unnecessary here:
> > >
> > > if (kvm_cpu_has(X86_FEATURE_NPT)) {
> > >        gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat,
> > > npt_enabled =3D true);
> > >        gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled =3D=
 true);
> > > }
> > > gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled =3D false=
);
> >
> > Well, it's necessary to avoid the indentation.
>=20
> Or refactor as:
>=20
> if (kvm_cpu_has(X86_FEATURE_NPT))
>         run_npt_tests();

Anyone have a strong preference?  I like the goto approach (obviously), so =
that
that all the gpat_test() invocations are prettily aligned.  But I can live =
with
an if-statement as Yosry suggested.  I think the only option I don't like i=
s
moving the NPT tests to a separate helper (it's two lines of code, and test=
ing
the NPT case really is the focal point of the test).

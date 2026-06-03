Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1D3EAC65
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511594; cv=none; b=V40CClqnJX7rDyVhmEmpK8SkQ7Jof66rpjxDE6bS5Qxzt7Oo8wyofoyO7hyyD/UH8AkKCFhXV/70Rvt0ZE46G3zH/lWoxG2XMuYkca40Sn3g6wZxWnYTAwsRJ0NaLKAFXyKrK+7yuqAkc470+dq341qWm0pT0+z7cTP427qT+Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511594; c=relaxed/simple;
	bh=WP3PaU8xk7PP40r7+x0tmncLTxx6FhCdNXnkwWPj514=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dCMB2x56lMufhn3kkCGKsUu8TQQyUMwwOadCGR+DI4687DMG/ASYYcSonO0ZTm+SjMdxTeBxs8ZVTVwT8R6oHitV9kTNY9sby370DktyG+B6tpxDbGjSntl/jmpEVvwLdfud+YH66VAYKAbjHTGCzc5Za+sjhg4p/JaWm/QaWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFoFrehy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFoFrehy"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2beff6b6e74so84036385ad.1
        for <kvm@vger.kernel.org>; Wed, 03 Jun 2026 11:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780511591; x=1781116391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZy+voWf3x2Gv3lQ9Pa78RTr5b+SHglPFwDOo5r2M3w=;
        b=bFoFrehyDiFUsYX3BQR/Ht3hE7Fmun3npsV4lbyGoNMNcHCn521ikXgmBMktA4mnv+
         qoPapENBNwSk36BU1N+za4YaN+V8kPFelpqkXaWQwiHbBR68vGnBKLbk/z1dm5Jvc8EM
         8ceH1NNQ38c6zj+jMlgqHA4qu43lGc3Us71JpPYFwxV+RSfZ5ZA13LRvABbt7CIslbMA
         CnJNuX0p6F4s7s7pJ/twKmiRBGvpiU8MSFt4Kr7nNHNQm3TK1oOgd5CqRNdzhZG5UK8w
         roANhTYQWxX7qWFu8uGUGE69pP7VwK1X8wYztErrpG+5zVJOwQbnfBCd7opjOfl8AClW
         6rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511591; x=1781116391;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mZy+voWf3x2Gv3lQ9Pa78RTr5b+SHglPFwDOo5r2M3w=;
        b=j3vf7cz32b4k/nArW0nO6Bckp/Xz8ig4Hnu4pjgAynsLHksEZygizD/S7C2M1u4xyb
         Oxbzgi0D8ubhMSG8UW2tvOcapNPpYx1yz5a19rsrV4Hreg7VUJD83R5o2e0xAEbbFIDR
         uClAgS0Zvd9hyhd1tTB8t65ij6IXvH+8+Vgvaau/yV3Kj9PbA1vHf+6MY5GaO00AkvQv
         FmETOmFFUYt/kznANwwBAbZpNSltdpUL8RL6rUkATEm64x/0/Vwyv9oZkOxzjVDNuP1P
         oxueln7g+5raQIIbkWw90veecl1V9GhR7e0hdRzkcTtC6uK3Jf9FAHHUs06Bgo6Dm0Vp
         6UcA==
X-Forwarded-Encrypted: i=1; AFNElJ/D6iCdGRq0VRgufq6dkdPkH8+fhm8UYpzSQg33LjwtUijHz6kw/HHFW0hsLgDBmbE0kV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxnkPnJTHrVR1fmvJ/TAdBA+T/9tPpT7KWT6PLihGBdWspfHTx
	P5QDbVRdXmWOt04mwbGfkycooGo7dqSGqNQvfJDvYPrmYxeIZK3CGXaUCRCVcc1xKWebawvGmXW
	f1Gf5sQ==
X-Received: from plbmv7.prod.google.com ([2002:a17:903:b87:b0:2be:f9c0:8cd4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a8f:b0:2bd:5026:ca11
 with SMTP id d9443c01a7336-2c163a28b84mr48318645ad.2.1780511591276; Wed, 03
 Jun 2026 11:33:11 -0700 (PDT)
Date: Wed, 3 Jun 2026 11:33:10 -0700
In-Reply-To: <CAO9r8zMrXbGevTgNttshFf88RDKrsaa_r5WryczFK8OMVcdHDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260528231052.404737-1-seanjc@google.com> <CAO9r8zPA7RTwAD+_-knnTJvFbLJgXzsHYa7a_N2j0JdPAoSoUw@mail.gmail.com>
 <ahmUPsB2nOPFCRrW@google.com> <CALMp9eQ+XmKbpY8QePbjZMA9fNm4-77zbDBNX2M-ZOdumNGyxw@mail.gmail.com>
 <ahoZfWeYsAICk9xc@google.com> <CAO9r8zMrXbGevTgNttshFf88RDKrsaa_r5WryczFK8OMVcdHDA@mail.gmail.com>
Message-ID: <aiBzZuSk-9d7YnzT@google.com>
Subject: Re: [PATCH v4] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026, Yosry Ahmed wrote:
> On Fri, May 29, 2026 at 3:56=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, May 29, 2026, Jim Mattson wrote:
> > > On Fri, May 29, 2026 at 6:29=E2=80=AFAM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > On Thu, May 28, 2026, Yosry Ahmed wrote:
> > > > > > +int main(int argc, char *argv[])
> > > > > > +{
> > > > > > +       TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > > > > > +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > > > > > +       TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > > > > > +                    KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > > > > > +
> > > > > > +       if (!kvm_cpu_has(X86_FEATURE_NPT))
> > > > > > +               goto skip_npt;
> > > > > > +
> > > > > > +       gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, n=
pt_enabled =3D true);
> > > > > > +       gpat_test("Nested NPT enabled", l1_guest_code, npt_enab=
led =3D true);
> > > > > > +skip_npt:
> > > > > > +       gpat_test("Nested NPT disabled", l1_guest_code, npt_ena=
bled =3D false);
> > > > > > +       return 0;
> > > > > > +}
> > > > >
> > > > > The goto is really unnecessary here:
> > > > >
> > > > > if (kvm_cpu_has(X86_FEATURE_NPT)) {
> > > > >        gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat,
> > > > > npt_enabled =3D true);
> > > > >        gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled=
 =3D true);
> > > > > }
> > > > > gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled =3D f=
alse);
> > > >
> > > > Well, it's necessary to avoid the indentation.
> > >
> > > Or refactor as:
> > >
> > > if (kvm_cpu_has(X86_FEATURE_NPT))
> > >         run_npt_tests();
> >
> > Anyone have a strong preference?  I like the goto approach (obviously),=
 so that
> > that all the gpat_test() invocations are prettily aligned.  But I can l=
ive with
> > an if-statement as Yosry suggested.  I think the only option I don't li=
ke is
> > moving the NPT tests to a separate helper (it's two lines of code, and =
testing
> > the NPT case really is the focal point of the test).
>=20
> No strong preference, I obviously also like my suggestion :)

Ok, third option, which I've pushed to kvm-x86/svm (but not kvm-x86/next, y=
et)
in anticipation of overwhelming support:

#define gpat_test(test_name, guest_code, npt_setting)			\
do {									\
	npt_setting;							\
									\
	if (npt_enabled && !kvm_cpu_has(X86_FEATURE_NPT)) {		\
		pr_info("Skipping: " test_name " (no NPT support)\n");	\
		break;							\
	}								\
									\
	pr_info("Testing: " test_name "\n");				\
	run_test(guest_code, false, 1);					\
									\
	if (guest_code =3D=3D l1_guest_code) {				\
		pr_info("Testing: " test_name " Save/Restore\n");	\
		run_test(guest_code, true, 1);				\
									\
		pr_info("Testing: " test_name " Multiple VMRUNs\n");	\
		run_test(guest_code, false, 10);			\
	}								\
} while (0)

int main(int argc, char *argv[])
{
	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
		     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);

	gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled =3D true=
);
	gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled =3D true);
	gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled =3D false);
	return 0;
}

Which (obviously) allows printing out which subtests are being skipped:

# ./x86/svm_nested_pat_test=20
Random seed: 0x6b8b4567
Skipping: Invalid gPAT (no NPT support)
Skipping: Nested NPT enabled (no NPT support)
Testing: Nested NPT disabled
Testing: Nested NPT disabled Save/Restore
Testing: Nested NPT disabled Multiple VMRUNs


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95B3B1EFC
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889116; cv=none; b=rk7naBh2wUAnqkzc9alAkJcqpLPYZ+dT+cxOxlHNs1onzjRBNl1YUICJSPuk0/8aJahtNz3XrE9O2Gb0j0wteqbbQMOGxSfUSx27NjDD1eQLW5USh7ZldOFG0OTXQDoKl8Inr0ArsszpDRmWtIAv8QvtQpy9P0DP9VkA16KhfqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889116; c=relaxed/simple;
	bh=OSxKuQU9blydA7z3UyaLJUM5clMCvPHnvraDhCaYhg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIVfyYve4kvspgV+v0kVkVF4zPAqiU/GA66+CcjDyS8Nl1RxXN23q3/tQFUFtwUn0QjtWN7J7+R7uqKDqIXKN75EKFt5hxwUn6fDBn6FeSx9ffvGKR+nNy6efgcEI6A40Qu/7gdeb3NfJCf3oiUxo+SMpuMWXu7ZPkIKiR1xhjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC2CJmTq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC2CJmTq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594861F00A3D
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 06:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782889115;
	bh=woSofrP5WTJbErYpMgun4CWCtNv+L3OjsKwS/qCrAS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WC2CJmTqiW60GWZm82Pfl5EhulZ1B124/09pLVqbu4huSV0+P/xHmeaSyj+OGNFdV
	 YmU2VfK6uGj3YlY6BGxjR94lJE3kaO2nXRK2tjHCmNA7zee2WbuUmztQ3iw6UNK2No
	 Pggt8XFZij1gZ41NaCQvfr+2wPewUea05R/Xd/CR5FAgTZbFBhd7y1hxsoZpUgSiWi
	 lRQrbblJfAiSEMQi4LrxocQQgaCWZQRA8oX7WuTrvNz8hCgzm0kzuB8hRyXedSiME4
	 A8svViPdymLkkQ1g5jR2QNoRqNaZedrWc2o9/qIMAj03E/A0rJARrqUoJ0GjNsb2yI
	 zwxIXlOC8x8Cg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c0e124d2a21so42037866b.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 23:58:35 -0700 (PDT)
X-Gm-Message-State: AOJu0YyKt16P497EqlaXBWSKYQwqZhZ4BSeFRRKGScj62P9TWsYlsa88
	UzC8lqKPgPw+BMaD+k8veKwBiDDo4cL2y2mco+QgYlktfcaCrg6a44w9DsILr5dTXzVHx1SadAQ
	PSXNI1gSzrGFYzZrzgjI825H7Ur79foc=
X-Received: by 2002:a17:907:a893:b0:c12:a588:4113 with SMTP id
 a640c23a62f3a-c12a9dcba49mr11041366b.29.1782889114308; Tue, 30 Jun 2026
 23:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630234716.3039031-1-yosry@kernel.org> <20260630234716.3039031-6-yosry@kernel.org>
 <20260630235208.0FEBD1F000E9@smtp.kernel.org> <CAO9r8zOBQxSNO==og6b1kX6WLYVimHrTs9owy8UrttpSs2pyaA@mail.gmail.com>
In-Reply-To: <CAO9r8zOBQxSNO==og6b1kX6WLYVimHrTs9owy8UrttpSs2pyaA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 30 Jun 2026 23:58:23 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNgnMoa5+X-hbDo1BK7XEu+euYO2vyoVV15VOJmK2S7gw@mail.gmail.com>
X-Gm-Features: AVVi8CffLr779ASl52FHnJzzlZu1bJO4GPxQGhIC1GoPXj1pHanKGMtZPx4Jmwc
Message-ID: <CAO9r8zNgnMoa5+X-hbDo1BK7XEu+euYO2vyoVV15VOJmK2S7gw@mail.gmail.com>
Subject: Re: [PATCH 5/7] KVM: x86: Reverse the polarity of efer_reserved_bits
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:54=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, Jun 30, 2026 at 4:52=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [High] Incorrect bitwise logic in EFER validation rejects valid zero =
values (breaking guest boot) and allows guests to set reserved bits (trigge=
ring VMENTRY failures).
> > --
> >
> > commit 4bd740e43933efd5aaca18b2bd83e1696dbbd7dd
> > Author: Yosry Ahmed <yosry@kernel.org>
> >
> > KVM: x86: Reverse the polarity of efer_reserved_bits
> >
> > This commit reverses the polarity of the EFER validation variable, rena=
ming
> > efer_reserved_bits to efer_supported_bits to align with other fields in
> > kvm_caps. The stated intent is that no functional change is introduced.
> >
> > > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > > index 17d4c813a9e8a..b9a16a27f6c23 100644
> > > --- a/arch/x86/kvm/msrs.c
> > > +++ b/arch/x86/kvm/msrs.c
> >
> > [ ... ]
> >
> > > @@ -606,7 +606,7 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcp=
u, u64 efer)
> > >  }
> > >  bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> > >  {
> > > -     if (efer & efer_reserved_bits)
> > > +     if (!(efer & efer_supported_bits))
> >
> > [Severity: High]
> > Does this bitwise logic inadvertently reject valid zero values and allo=
w
> > guests to set reserved bits?
> >
> > If a guest writes 0 to the EFER MSR, (efer & efer_supported_bits) evalu=
ates
> > to 0, and the negation makes this condition true, improperly rejecting =
it.
> >
> > Additionally, if a guest writes an EFER value containing both a support=
ed
> > bit and a reserved bit, the condition evaluates to false, allowing the
> > reserved bit to be set.
> >
> > Should this check instead be (efer & ~efer_supported_bits)?
>
> Yes, I completely screwed this up :)
>
> The tests don't fail because we only have tests for SREGS setting EFER
> (added in this series), and __kvm_valid_efer() still properly catches
> invalid bits for this path (because KVM caps =3D=3D guest caps).

For the record, I was curious why my hacky AI-generated reproducer
didn't fail with this bug.

Turns out it was trying to write efer=3DEFER.SVME, which means that:
(a) If nested=3D1, (efer & efer_supported_bits) would be 1, and
set_efer() would succeed as expected.
(b) If nested=3D0, (efer & efer_supported_bits) would be 0, and
set_efer() would (accidentally) fail as expected.

I updated the reproducer to read the value of EFER first, then write
efer=3D(old_efer | EFER.SVME). With nested=3D0, setting EFER.SVME would
(unexpectedly) succeed with the incorrect check above, because (efer &
efer_supported_bits) is non-zero. Fixing the check to be (efer &
~efer_supported_bits) makes the reproducer pass as expected.

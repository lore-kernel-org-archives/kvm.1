Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C3E3905E0
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 18:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779389289; cv=none; b=Br4i6IezDj4GSlUSwilr5VFbpn/8dPUP/w4aeVRwgcRJn54U2NY8a919ZyIT8Y8nbRryfvdtDBZEi0s4VLJH/yjlG41rDgzSnAPggeXovTDRYPJ5N4JxAPkuJqnC1yoyqWDHTRq+rp3gXxfpFSbu1/Y4amhLns+yw4tSpU9penI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779389289; c=relaxed/simple;
	bh=YUNv3MTY3tC2jjOgCa0t+Z2FPE1cUyrX82V+dta0218=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXXbleLWdm0dp5w9QMhxoweZj/Hv+wAwqLlXPFqBPWLTVicIory7MfqhFFDXrcEEI0TqBNeiKkOvGTSp0XcSL1aeAP/fKYo4QnN6Wn2zqixtG8b5s7PcwgnFzyLycBzTKCoOuDxFLW4GZR+kbSR2sil8MFDX/twPNZsGkujs28Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7weSXc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7weSXc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432F21F00A3D
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779389288;
	bh=BvCUukItYUpyz5H3dJwk31OpQyQKb3byOAcmsK9JtMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=h7weSXc54Fq6caiyDYOiQPBoe9vuMLNtOuNePauFjLoIJGBga5US/fFNMurHBIYdi
	 yJaLjcZ/VMU0q8j2hfgK2ps4lC03zxZfnyF98dM9Cj3vX58CLNhtDtThVC5trWLyqG
	 VgYbRZmCse4EK3/8QFbqP0+HYC/C4SMSxGYxe+WrXferBbteUGBCEM8qz2k0BqCUnw
	 miiU90qR0IfUU0ORQdLh2UQAUfyfENAxSTFZLOgd0qwR+5e/sQfLMwG17O3WfcyxMJ
	 WWlEzL7qxQLjTNrbxM+2f61qsG309GlOGBcDxhoozVCBWYPL/kJKR/mH2tI9WUeLIV
	 wB/vVOaTw6VKQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bdbcc6c4500so217663966b.1
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 11:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8DTZXzS3FEkOhm1R74Y+U3AKVdD3N/eDrIKWtABAgIMVIPrV1cl3tJmYhA5/OIR5sanq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wCO0d1UwtKZ038LYQDSR1P2xl0rIRJDl7d2Hl0IkX4pUOiLU
	OJ4h9VAxoe5Pe2njzmHSkTFQlojJYrLA8QH06TTvZeDpUNVoRyEHeleHHTa0bM4WmEe/Z4wy3kN
	kuWxizuMVAY+QymnFdN2EYO3txaCsniU=
X-Received: by 2002:a17:907:9289:b0:bd5:1482:930a with SMTP id
 a640c23a62f3a-bdd272d1c46mr32526266b.39.1779389287235; Thu, 21 May 2026
 11:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514210500.1626871-1-seanjc@google.com> <20260514210500.1626871-4-seanjc@google.com>
 <CAO9r8zNW+dwWykUsALO-BKTg_dX8rT8cFBCR+Y9z2NjXoGJGtA@mail.gmail.com> <ag9SDjTdeXEszAsk@google.com>
In-Reply-To: <ag9SDjTdeXEszAsk@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 21 May 2026 11:47:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPdb5dLsFuEeKxBK98spJx6MhBVYbt6jh9mVGF3vJ74Fw@mail.gmail.com>
X-Gm-Features: AVHnY4ItMXCUmhCgrgg07YYia79rBB89JaN1pLoCFhMoA5bc4EV8qGKNsMyIVpE
Message-ID: <CAO9r8zPdb5dLsFuEeKxBK98spJx6MhBVYbt6jh9mVGF3vJ74Fw@mail.gmail.com>
Subject: Re: [kvm-unit-tests PATCH v3 03/20] x86/svm: Sort (and swap) GPRs by
 their index, not alphabetically
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Mathias Krause <minipli@grsecurity.net>, Andrew Jones <andrew.jones@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:42=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, May 21, 2026, Yosry Ahmed wrote:
> > On Thu, May 14, 2026 at 2:05=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > Sort all GPRs in the nested SVM infrastructure by their index, not
> > > alphabetically.  This will allow sharing code between SVM and VMX for
> > > context switching GPRs between guest and host.
> >
> > Potentially a naive question, why do we sort them by index if the xchg
> > instructions just use the offset for each register anyway?
>
> So that the offset into the "array", ignoring that this particular implem=
entation
> doesn't use an array, can be computed from the architectural index of the=
 register.
>
> Does it matter _here_?  Probably not, because there's not actually an arr=
ay (yet?).
> But my goodness is it confusing to look at KVM's vcpu->arch.regs[] and th=
en switch
> to selftests or KUT and stare at a set of GPRs that don't align with thei=
r index.
>
> And code mechanics aside, sorting RAX, RBX, RCX, and RDX alphabetically m=
akes me
> foam at the mouth :-)

You'll be very happy with my selftests patch then :P

>
> > I ask because I have a patch [*] undoing this for selftests (and
> > removing the 'rsp' spot), so I think I am missing something.
> >
> > [*] https://lore.kernel.org/kvm/20260518202514.2037078-2-yosry@kernel.o=
rg/

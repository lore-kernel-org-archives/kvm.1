Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885F23507B
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777336659; cv=none; b=fsMqA9PE0yvF3/09SNwvJVkGR1uWfchi5cMHGRDboUXad6vea5H9ahvktxME6yHuNw1TgpW/WqA1e0svh7xXk7Uxr6vkKXfYNhSmPch0h5bo0s6toqMYx93FEpZBR9IzWC1BcLf3Aqs408nyJPQklUWZjCNZyyCHavCAmuyELiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777336659; c=relaxed/simple;
	bh=xldXiXW12wKZgF8yZGXX6JIIkmm6qM9b48ykTSKRiwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mE17jtBnVDZe5lWqO6aXkh3yXtQuX0dOQuJpzZ2pCjMRnaSY3YyrkOV7mi55BAt8qvWMvVcCwIgkh/k0iBij6GuRRx3m3xZ3xO2INiJQm5VBZJBOoGYSDao1PNaFoRLJKfpZTg9T7DLgiiopUUa5dFfE+Cpcje6nUNVQYYvfqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4+bv63C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4+bv63C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4657BC4AF0B
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 00:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777336659;
	bh=xldXiXW12wKZgF8yZGXX6JIIkmm6qM9b48ykTSKRiwg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J4+bv63CQNC7EMM3rG7Syb1QfYE6xZT076zG1lvgW9VaVPEf+Wvl7OSFKXHja56p7
	 luTq6YVl47aths9M/7v/ZD/keTq835CbyYe1CVUVe4VDWwDXRybgWN56OA3G9drsTr
	 gFxhymDrjIVjtL6IHGs3FHB0K9LyMcBny8bmuPv7wGFwQ4MzvLw1ayEGr81YsTmMNy
	 xEzWCnaijevdELR8OF+eJDP0SzeUwjdiiwUwfhnEuJbT2Vu4NCRRwdENBswipkJunM
	 Wrr3DyOd0BykVOZSD43uXI6FzsEZot1vRvGeyrPq9Wetuj6VBWUskUXTgOTLvGspfl
	 8csMCBY+vVmuQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1277703166b.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Y9qCwLFg036v30+wRgcJYJmEED9Eqz/CVhoUAhTW0MTZQcr5o1+i0QB/rMLewAElxuGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSnv6fJC4KQF489BSf25iehyX+w34yyXoC3iaCpiW1aYliRuZs
	KpTko+gMVmc0yaaZe2S5jkGP0e/JAXpCNRq1Sz32njicGE6B5gAylQEJ8mQWFEpfrSWTu2abUht
	2RlyaNYk0PM8S+0RqSHXGWJOMfNytuWY=
X-Received: by 2002:a17:907:1b10:b0:b9d:c374:6e33 with SMTP id
 a640c23a62f3a-bb80377e051mr49362466b.26.1777336658156; Mon, 27 Apr 2026
 17:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zNzyp4X8Pny7aFAjX8swSxpfmwu7GF9Ry7Kz9GSKpw+bw@mail.gmail.com>
 <ae_3BWwjHiYC3hzm@google.com> <CAO9r8zN-qru58rsBaTDae+5zGp=6eJRkYFDqdGhy7SYPwt9+pg@mail.gmail.com>
 <CAO9r8zPdnMK7oqjz_6i_0=Bh5hyw96BLY=x71emTNCwLtqyoww@mail.gmail.com>
In-Reply-To: <CAO9r8zPdnMK7oqjz_6i_0=Bh5hyw96BLY=x71emTNCwLtqyoww@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 17:37:25 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNSbRAdAapsUGrg_DJxKu4jKfQHYWXcBRp5G+_0xO5KQg@mail.gmail.com>
X-Gm-Features: AVHnY4Kyin5zEsEHZZ9g2NE4mRMDIADU2bXCsYDyXiG-axCwkxDivzHHebVlyRE
Message-ID: <CAO9r8zNSbRAdAapsUGrg_DJxKu4jKfQHYWXcBRp5G+_0xO5KQg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:35=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Apr 27, 2026 at 5:34=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Mon, Apr 27, 2026 at 4:53=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > > > > We can have our cake and eat it too.  Add svm_pmu_handle_nested_t=
ransition(),
> > > > > but then also rename and rework reprogram_counters() to support b=
oth deferred and
> > > > > synchronous operation, e.g. something like so:
> > > > >
> > > > > ---
> > > > > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *p=
mu, u64 diff,
> > > >
> > > > I don't like 'diff', I think just 'unsigned long *bitmap' and pass =
a
> > >
> > > Hard no.  I agree @diff is a weird name (I was literally just copy+pa=
sting the
> > > existing code), but I _really_ don't like passing a pointer, especial=
ly not to
> > > an unsigned long.  The bitmap usage throughout the PMU code is mostly=
 internal
> > > implementation details.  But for what is reprogram_counters(), and wh=
at will be
> > > __kvm_pmu_reprogram_counters(), the "counters to reprogram" is very t=
ightly
> > > coupled to the architectural layout of PERF_GLOBAL_CTRL and PEBS_ENAB=
LED.  And
> > > more broadly in the PMU, for the layout of GLOBAL_STATUS_BUFFER_OVF_B=
IT,
> > > MSR_CORE_PERF_GLOBAL_STATUS, and probably at least one other MSRs.  T=
hat all
> > > should be captured in the APIs.
> > >
> > > The other reason I don't want to pass a pointer is so that even when =
the source
> > > _is_ a PMU-internal bitmap, it's super duper obvious that the source =
bitmap isn't
> > > modified, and that it's operating on a snapshot in time.
> >
> > Sounds good, I will keep u64 (and maybe name it 'counters'), or maybe
> > s64 as that's what kvm_pmu_handle_event() uses (and what the atomic
> > helpers take).
> >
> > >
> > > > bitmap in here like most PMU code?
> > >
> > > FWIW, AFAICT, passing a bitmap as a function argument isn't common at=
 all.  I
> > > only see kvm_for_each_pmc() and kvm_pmu_trigger_event() taking a bitm=
ap.  There
> > > is a lot of bitmap _usage_, but rarely does KVM pass around a bitmap =
as a function
> > > argument.
> >
> > We still need to pass a bitmap as an argument to the
> > reprogram_counters() callback that we'll add in
> > kvm_pmu_handle_event(), or would you rather we cast the bitmap to s64
> > here as well?
>
> Hmm I think we should pass the bitmap as-is, otherwise we'll cast it
> back when calling kvm_for_each_pmc().

intel_pmu_cross_mapped_check() actually does this. I will pass in a
s64 and cast it in this case.

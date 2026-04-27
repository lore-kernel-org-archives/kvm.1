Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485ED2E1F02
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320161; cv=none; b=HO3ZECiSmdPcPj6z6nkdwloQFvYn4jYfyPKSjQ0Z6XoAlpU5MK6cGNcqFd4cDfReTReMvrtOEe1rTTcZc8Hz8A08HjIgxEr/9jAuIoj3J8d9sNuoHkuf1unGAD0plxGDaSAItKpCQdH6N4c+IS6fdLsaBvXGxd+kl3hkIWZIvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320161; c=relaxed/simple;
	bh=Ak7zIurVfKJnA1KxT7uUY7TtGDPKxFN6x2cyC6w6ua0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGxOiRBw+U+a1qqn6yZNgZlTuWS3UT/69C4zyFavx4iq2gBijBwQJoERmebv0xgYsMT2kL+zotFqBRfS4Vrb0lebw21YNtXMyyRFZz34qRaxCiZ6IkBkJSyh7G7liGhUbX/TfjSePMR0l+nHFqwKqouhQY+2wFj78VHdxIPNHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+DG8lh3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+DG8lh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA1EC2BCB5
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777320161;
	bh=Ak7zIurVfKJnA1KxT7uUY7TtGDPKxFN6x2cyC6w6ua0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=k+DG8lh3wOI9ZcnMzFC3hVTWleIb598wiBYh+08kPFbdCe+FoqNvB7KrMaEc1w9jI
	 hj19febwlE1IT3gb4HYD6dSqfjtBe1s6hXaq/eUmJOw61N+o56bQTMe0AEcdhuPySw
	 F2yPAl1mtfcGTdQpKDlDTLuz3ZcDMwRMyrni3V51GDUroiygAY5zzlQD6Fm67tZg9e
	 EZwEhS6KdVj6Xg6/AwAnllhQicRI5brpM8yabX7vwePE6W6+a3B+VWXNZc1LoGI9Nu
	 WiF3BI3EGwdkJo2Dx1TpM6s9kNVpvYfnlqal4PESYHzfAjM0nv/HsfuFGC8NmKQvfL
	 rGt8/7uvZhXwQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-baebe98afa0so412813666b.3
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 13:02:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8EAKGZBX7FGN6l6kU515/Yj46AOtLvslagqQsZ7erE9Llec4brkndwlZ/SP7T6XYOAXnE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VOAD0Nr04Pi4EHBFrKD55kkEeYAz7nuFaHI6720nRwC8dcZa
	Iv3azKb+m6+q5ycCS7LfQ/rd9vx8gSMjnLgyI30ahbHJQIx8eIsU+iprZhnr4MnHAjGN5uJjMlY
	d3W7YR2hFEWDoEeYB4Bl7sVPN4/a0bVc=
X-Received: by 2002:a17:907:1805:b0:ba7:4cd9:ca26 with SMTP id
 a640c23a62f3a-bb80443e879mr13415166b.35.1777320159679; Mon, 27 Apr 2026
 13:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zO9YxhkfQAXu6ocDD7=SQ7ia1stTmOS4Z6JbMa00hz97w@mail.gmail.com>
 <ae--4AYNLshM5_zJ@google.com>
In-Reply-To: <ae--4AYNLshM5_zJ@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 13:02:27 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMyOvvt=TH93O9=wAGCNvVtuUg2m3e8CF4No1SqdRNmpg@mail.gmail.com>
X-Gm-Features: AVHnY4L08QSGIaOfI7MQXRMgd0sJ-KeQ6NkpmkrMBq4eSvT4GbiduleRfO_9Nf8
Message-ID: <CAO9r8zMyOvvt=TH93O9=wAGCNvVtuUg2m3e8CF4No1SqdRNmpg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 12:54=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, =
u64 diff,
> > >                                                 bool defer)
> > > {
> > >         struct kvm_vcpu *vcpu =3D pmu_to_vcpu(pmu);
> > >
> > >         lockdep_assert_once(defer || kvm_get_running_vcpu() =3D=3D vc=
pu);
> > >
> > >         if (!diff)
> > >                 return;
> > >
> > >         atomic64_or(diff, &pmu->__reprogram_pmi);
> > >
> > >         if (defer)
> > >                 kvm_make_request(KVM_REQ_PMU, vcpu);
> > >         else
> > >                 kvm_pmu_handle_event(pmu_to_vcpu(pmu));
> > > }
> >
> > I like that the KVM PMU code is now presenting a generic API to
> > reprogram counters rather than handling nested transitions, even
> > though reprogram_on_nested_transition fits better semantically in
> > kvm_pmu (than svm_nested_state).
> >
> > I do have a few questions:
> >
> > 1. Do we want to do all of the work in kvm_pmu_handle_event() on every
> > nested transition (rather than just reprogram counters)? Genuinely
> > asking as I am not sure if the rest of it is significant.
>
> Yes, we have to for correctness.  And somewhat sneakily, it's not that as=
 much
> work as it might seem at first glance because the Host/Guest stuff is lim=
ited to
> the mediated PMU.  Specifically, pmu->need_cleanup will never be true and=
 so the
> heavy-ish kvm_pmu_cleanup() will never be invoked.
>
> As for correctness, we either need to run through this code:
>
>         kvm_for_each_pmc(pmu, pmc, bit, bitmap)
>                 kvm_pmu_recalc_pmc_emulation(pmu, pmc);
>
> or pend a KVM_REQ_PMU so that it's done before re-entering the guest, so =
that
> KVM does the right thing when skipping/emulating guest instructions.  Tha=
t flow
> is relatively cheap, so I don't see any reason to defer it.

As a micro-optimization, should kvm_pmu_handle_event() clear KVM_REQ_PMU?

>
>
> > 2. This approach will reprogram all counters that need it on nested
> > transitions. In my proposed approach above, I only iterate over
> > counters in reprogram_on_nested_transition and reprogram them. Do you
> > think it matters? I guess if other counters need reprogramming we'll
> > probably do it in kvm_pmu_handle_event() before running the vCPU
> > anyway,
>
> Correct.  KVM has to do the work before the next VMRUN, all we're doing i=
s
> completing the work earlier than is strictly necessary.
>
> > but then we're repeating the work here?
>
> No, it's not repeated.  That's why I want to callkvm_pmu_handle_event(): =
it
> updates pmu->reprogram_pmi to clear bits for PMCs that are successfully r=
eprogrammed.

Yeah kvm_pmu_cleanup() is the only thing that could be done, I didn't
know that doesn't apply to the mediated PMU.

>
> > 3. In this world we still keep the mediated_reprogram_counter() callbac=
k, right?
>
> Weren't we planning on a callback that would take the diff of counters?  =
I.e. one
> callback per kvm_pmu_handle_event(), not one callback per PMC?

Yeah I initially dismissed this because it cannot be done with the
implementation I proposed above, as we don't always go through
kvm_pmu_handle_event(). But with your proposed implementation we can
have a single callback in kvm_pmu_handle_event().

Thank you!

Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A242DCF74
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320406; cv=none; b=GWmb81oWT+JIzoyt9WJKsQ3g18yrNgTdVv2DVzvbbvrB5ATqfeh93A21IfqywjohmIObDvs7f3BhDx5r5/rBiOf82VRipB77uApu69YAJ28r+s2zKCrBcjTzJilz+kCMMsQDfLR/dI1DnrgZtstuH7ghBTgzd60DIoIBmrAfyUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320406; c=relaxed/simple;
	bh=mchmBOninHmBPN1mzPiVNuzZOFh/Z1wHaMQzLRMfJDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=igjn0oNSOG3L+xynopYlbwIUJd1cj+GJzNGV4npWENMgLR52DIk0sDTmIM8DUegir0mqbhzuwa+WU00yLHY4NuFwkgtoMDNkCQ5f1DnqmWmBl1QtfdbNaz1yigJkpYuh2DCCWUBDfU5XftT9VX6F374zjV6EwHmJZMRqRR3soVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXq62yQX; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXq62yQX"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f803658d5so12763650b3a.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 13:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777320405; x=1777925205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C0f7IVbit3tXPHjM+yWF3WzqBRFhWjNUsC8bD83FHeM=;
        b=CXq62yQX7TQMTNbBK8Z1Z8zt+A31gLfz6IEDizhOmlfjWPg7VCxCqstcg+WrN2uFWl
         iM3jiHcx9Fb1oRXZagpYa2wxEABYO1s/eSIhp17l6/CJigu8EsNXkmHB8mBeM/Yq36Eg
         0DRG0qw1F+KL4m1XadMQ8xrNLLfWc0WRN0qEBHJI88HVs3ZteL/DWOVlfE5ED71qKQLF
         2+zIclGkELZN66exy1eTIe92/NM3bJJ1+dd5z77AG+NpghFGcWYgAVa0WfgCUjjx5mvC
         HhVRijIyHDS+bbfAOSLiqMvdcYgBSbPwv6Ob0QNV5ACP3nRhjj/5FHel8N3ZrrDeLrDa
         ksDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320405; x=1777925205;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C0f7IVbit3tXPHjM+yWF3WzqBRFhWjNUsC8bD83FHeM=;
        b=Z5CK2W4RRdwjUGghPzNJ9YCFtFw9vX+SYdrvxlvbBPEFsfBzVbYqPAL4GZSpxLiifK
         ArOHogWYJ6uBRvgJvXzFHeY+8axWx5M5nxgREeYAWlTUjdVO1F8T3R+8BtNGCKAXlnwp
         aH7fRIVjCPG0Ra1V8PG7WpXX4i6rRbKCPMfhqN6y/Vx4ffjLfKIMewHtDPdRPqis6H1l
         noJJLedDTVSukJxqYdhMFRHxQkFX18R9YCZDJ6pbX3tAZobYvdRLTk0kNOn8bavkmOjX
         vCWDK4wKZnrpDobWPzKouJ5f2Nn11SsHjBhv963bovxyBC8Di7yIVUQoNfsHT683T1Mt
         haNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/S2AqBXAcLJh121tiWwajIOwVSy26AawPvAfThoUkQYz5zKW4rI0AvgZeQfAMS5BIhisQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbakN5H4U65sZMxDwaZ3r5Ed8qsZbUJhhTtA/doIw1H31PNBpM
	mEKFtlg7Ebb6HYv+ixRNyapnmupUiy/XHmuDuOPrmlFIo+WXkuAT7KyFk/VQlJzBSST7ZalhDMk
	prTgNhg==
X-Received: from pfbij6.prod.google.com ([2002:a05:6a00:8cc6:b0:82f:b839:2d80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc8:b0:82f:4628:4198
 with SMTP id d2e1a72fcca58-834dc22ad90mr433312b3a.31.1777320404779; Mon, 27
 Apr 2026 13:06:44 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:06:43 -0700
In-Reply-To: <CAO9r8zMyOvvt=TH93O9=wAGCNvVtuUg2m3e8CF4No1SqdRNmpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zO9YxhkfQAXu6ocDD7=SQ7ia1stTmOS4Z6JbMa00hz97w@mail.gmail.com>
 <ae--4AYNLshM5_zJ@google.com> <CAO9r8zMyOvvt=TH93O9=wAGCNvVtuUg2m3e8CF4No1SqdRNmpg@mail.gmail.com>
Message-ID: <ae_B0zRVKe6HfRGj@google.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> On Mon, Apr 27, 2026 at 12:54=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > > > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu=
, u64 diff,
> > > >                                                 bool defer)
> > > > {
> > > >         struct kvm_vcpu *vcpu =3D pmu_to_vcpu(pmu);
> > > >
> > > >         lockdep_assert_once(defer || kvm_get_running_vcpu() =3D=3D =
vcpu);
> > > >
> > > >         if (!diff)
> > > >                 return;
> > > >
> > > >         atomic64_or(diff, &pmu->__reprogram_pmi);
> > > >
> > > >         if (defer)
> > > >                 kvm_make_request(KVM_REQ_PMU, vcpu);
> > > >         else
> > > >                 kvm_pmu_handle_event(pmu_to_vcpu(pmu));
> > > > }
> > >
> > > I like that the KVM PMU code is now presenting a generic API to
> > > reprogram counters rather than handling nested transitions, even
> > > though reprogram_on_nested_transition fits better semantically in
> > > kvm_pmu (than svm_nested_state).
> > >
> > > I do have a few questions:
> > >
> > > 1. Do we want to do all of the work in kvm_pmu_handle_event() on ever=
y
> > > nested transition (rather than just reprogram counters)? Genuinely
> > > asking as I am not sure if the rest of it is significant.
> >
> > Yes, we have to for correctness.  And somewhat sneakily, it's not that =
as much
> > work as it might seem at first glance because the Host/Guest stuff is l=
imited to
> > the mediated PMU.  Specifically, pmu->need_cleanup will never be true a=
nd so the
> > heavy-ish kvm_pmu_cleanup() will never be invoked.
> >
> > As for correctness, we either need to run through this code:
> >
> >         kvm_for_each_pmc(pmu, pmc, bit, bitmap)
> >                 kvm_pmu_recalc_pmc_emulation(pmu, pmc);
> >
> > or pend a KVM_REQ_PMU so that it's done before re-entering the guest, s=
o that
> > KVM does the right thing when skipping/emulating guest instructions.  T=
hat flow
> > is relatively cheap, so I don't see any reason to defer it.
>=20
> As a micro-optimization, should kvm_pmu_handle_event() clear KVM_REQ_PMU?

I vote no.  The odds of introducing a race, now or in the future, far outwe=
igh
the benefits.

> > > 2. This approach will reprogram all counters that need it on nested
> > > transitions. In my proposed approach above, I only iterate over
> > > counters in reprogram_on_nested_transition and reprogram them. Do you
> > > think it matters? I guess if other counters need reprogramming we'll
> > > probably do it in kvm_pmu_handle_event() before running the vCPU
> > > anyway,
> >
> > Correct.  KVM has to do the work before the next VMRUN, all we're doing=
 is
> > completing the work earlier than is strictly necessary.
> >
> > > but then we're repeating the work here?
> >
> > No, it's not repeated.  That's why I want to callkvm_pmu_handle_event()=
: it
> > updates pmu->reprogram_pmi to clear bits for PMCs that are successfully=
 reprogrammed.
>=20
> Yeah kvm_pmu_cleanup() is the only thing that could be done, I didn't
> know that doesn't apply to the mediated PMU.

It's a less-than-awesome name.  It's a flag that says "go ahead and release
perf_events that haven't been used for an entire time slice".  I.e. it's ga=
rbage
collection for the legacy PMU.

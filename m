Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34277223DFF
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777606513; cv=none; b=X9zwrq4YQWFyqT5qC/duutoI0W7O6QFNDFmb5kO7B8EOJXyO2OEVPPXbia9Qyzc8a99PDv79acKgihKIKAGBxTLF7MW9joOMdS5z0DCT0cE+ffDIimuYJx538TshHXySRqboHe3AOgth8Zu3qEpzK/M0GxKF4OJduvH/nS9/VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777606513; c=relaxed/simple;
	bh=wMOff3L7vo4NlTvymXNWl4uuW3vMa1LwHz1mnUc7f+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnBSMSfpS42ASmDdhMIm7oQtxOfLvIC8NG6eVFHnQZs3hbqW+ZW7inaM5cE2WL9T/vCGV2Aklq3cSmabnd9C7oKzjce9DSCADUIdB+Yvhr0VIMMi66EOUGC0HTt5c5LhXDvaRozr5t2v1sy8W9NCoZ6rPA1hc3qfPDggB2l/WaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zz8WtCNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zz8WtCNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D63C2BCB3
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 03:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777606512;
	bh=wMOff3L7vo4NlTvymXNWl4uuW3vMa1LwHz1mnUc7f+M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zz8WtCNWrK54fcIpGMm+gJDiTHFZGsWTUN8/jhVxJTtjiZIzK6tNvF6AcWmeX5R8L
	 kzTuBCgdv7b81RGES1heKSR3+egjbj7au6qjTYFI+3AMb7eYvPtghwJ/aKy9ByXlNH
	 +ocU4hrV9lU6bcwxrTGELZc7o7YC2lS4nSYWZxZsP39J45L7fdsoRqd7hHRggXJrny
	 RUiUioTyOtWOCkaWQHkaa/IxW5ERu//AMGZlbv/GmfWswHFLnHK/+5vhIaWOaYhsxb
	 bVuBiVsIIgll2JL1sLx4bNrCQsNLZGxVm7hxyYZHDKTN+TM6sliN3XMBZYHV95d64D
	 JkVL9Y3XAugWg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba3115fe0d5so480282966b.1
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 20:35:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9V/DraOi3em7CsuHuk02c0yXyBXjtbUaqq3s4SA260WEVQNXUgxMs6wc1SVhQMuurbf0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvhljD238OHZD+fPoZIZ5Qq9Qme8viBeDlzfskjjVHb8O+2ZG
	O4hp2KmLAkyTsJ7gh3K9cUt0Ap5iaO4uFjcAnC+HsLn3bVzf3CjOM1fX7nvUKYxq3g9TAqCRzbG
	JzT+dTmj17Vd9ZQmir44mqgxeRLkX1gA=
X-Received: by 2002:a17:907:3c89:b0:bab:f568:38ea with SMTP id
 a640c23a62f3a-bbb97b8946bmr282079666b.7.1777606511620; Thu, 30 Apr 2026
 20:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org> <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
In-Reply-To: <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 30 Apr 2026 20:34:59 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
X-Gm-Features: AVHnY4JlYNTJL5qCwLEet9WknamJDi4ht6isEtLL6-xJq0fTtKlELJpz0CiwMuM
Message-ID: <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
Subject: Re: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 4:24=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > index 0e99022168a85..0c372b9f8ed34 100644
> > --- a/arch/x86/kvm/pmu.h
> > +++ b/arch/x86/kvm/pmu.h
> > @@ -36,6 +36,7 @@ struct kvm_pmu_ops {
> >         void (*reset)(struct kvm_vcpu *vcpu);
> >         void (*deliver_pmi)(struct kvm_vcpu *vcpu);
> >         void (*cleanup)(struct kvm_vcpu *vcpu);
> > +       void (*reprogram_counters)(struct kvm_vcpu *vcpu, u64 counters)=
;
> >
> >         bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *ho=
st_pmu);
> >         void (*mediated_load)(struct kvm_vcpu *vcpu);
> > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > index 7aa298eeb0721..fe6f2bb79ab83 100644
> > --- a/arch/x86/kvm/svm/pmu.c
> > +++ b/arch/x86/kvm/svm/pmu.c
> > @@ -260,6 +260,48 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *=
vcpu)
> >                 wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->glob=
al_status);
> >  }
> >
> > +static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *v=
cpu,
> > +                                                   struct kvm_pmc *pmc=
)
> > +{
> > +       u64 host_guest_bits;
> > +
> > +       if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> > +               return;
> > +
> > +       /* Count all events if both bits are cleared */
> > +       host_guest_bits =3D pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_M=
ASK;
> > +       if (!host_guest_bits)
> > +               return;
> > +
> > +       /*
> > +        * If EFER.SVME is set, the counter is disabledd if only one of=
 the bits
> > +        * is set and it doesn't match the vCPU context. If EFER.SVME i=
s
> > +        * cleared, the counter is disable if any of the bits is set.
> > +        */
> > +       if (vcpu->arch.efer & EFER_SVME) {
> > +               if (host_guest_bits =3D=3D AMD64_EVENTSEL_HOST_GUEST_MA=
SK)
> > +                       return;
> > +
> > +               if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) =3D=
=3D is_guest_mode(vcpu))
> > +                       return;
> > +       }
> > +
> > +       pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
>
> Sashiko raised a good point here. In the following patch, we reprogram
> the counters synchronously on nested transitions to update the
> counters' enablement before counting VMRUN or WRMSR(EFER.SVME).
> However, this updates pmc->eventsel_hw while
> kvm_pmu_recalc_pmc_emulation() checks pmc->eventsel to check if the
> counter is enabled.
>
> I think either pmc_is_locally_enabled() needs to check
> pmc->eventsel_hw or we need to update pmc->eventsel here.
>
> AFAICT, pmc->eventself has the value written to the MSR, so I think we
> want to keep that as-is.
>
> On the other hand, ARCH_PERFMON_EVENTSEL_ENABLE is cleared in
> pmc->eventsel_hw in kvm_mediated_pmu_refresh_event_filter() if the
> event is not allowed, and kvm_pmu_recalc_pmc_emulation() has a comment
> about intentionally ignoring event filters.
>
> We can also separately track enablement for nested purposes, but that
> would add one more thing we need to check aside from general counter
> enablement and event filtering.
>
> None of these options are ideal, perhaps directly clearing the bit in
> pmc->eventsel would do the least damage as (pmc->eventsel &
> ARCH_PERFMON_EVENTSEL_ENABLE) is only checked by
> pmc_is_locally_enabled().

No, we can't really clear the bit in pmc->eventsel as that's what the
guest reads with RDMSR.

The more I think about this, the more I think we should drop
pmc->eventsel_hw. It serves two purposes AFAICT:
1. On AMD, we use it to clear HOSTONLY and set GUESTONLY in actual HW.
2. For event filtering, we use it to clear EVENTSEL_ENABLE.

But maybe it's easier to explicitly track the changes we need to apply
to eventsel rather than a HW version?

(1) is trivial, we can just clear HOSTONLY and set GUESTONLY before
doing the actual write as that's constant.

For (2), instead of eventsel_hw, maybe add a boolean called 'filtered'
to track if that PMC should be filtered out or not. Then, we can add
another boolean to track if the counter is disabled due to
nested/HG-bits (e.g. 'nested_disabled').

With that, pmc_is_locally_enabled() would check:
  (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) && !pmc->nested_disabled

, and then before writing to HW we check pmc->filtered,
pmc->nested_disabled, as well as do the HOSTONLY/GUESTONLY changes for
AMD.

Actually, instead of a boolean, maybe add 'disabled_reasons' flags,
with possible flags like PMC_DISABLED_FILTER and PMC_DISABLED_NESTED.

This might all be unclear, I will draft some diff on top of the series
tomorrow and send it in case it makes things clearer.

Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE62D9EFB
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006955; cv=none; b=PvbtsWgqGRMYqQpqJjAgKiF8MKeNvIcfpYwBilazoQDJ2H+Di3XyuvramUMklLcOv5ySCC5Lpg4EmlPOACcQYfBTA+TPxwzL8OYxyhVo2r7mVGFcPciu53ahwQWq2YBpS1tpLbO4OREsx1ltsz2vDitsm+SV7wUNOCLaE9zOA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006955; c=relaxed/simple;
	bh=5zP82cyVU4IyOHLV43G3xJU+LY/ju7pe6k4Rpc/NVto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GduXCs1QBRMp2yIoKZmY3Q70AE78P9onpw2bGMe7qfep9Oueaz3xGxy3G30iOD9XxWkRh44rYBK25RBMucwJdLuY2WdHpJcn6UWpJ7nYw9PznhRn9iwDwXVj25XvH6GrfS86H7KaRyQ+sdkVH1n/wvkqci39+vDvBpDj5tpgw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgByotJI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgByotJI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so58795845ad.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778006953; x=1778611753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXtpS07tBEv3WQr9Lo010ZB646RMAloupbb7TUk/iMY=;
        b=LgByotJIsiYgJ9QMiGaxMOtqldgzDJ96Y2iwa1EzGoIt+yJN0h4fxLSIqm9w+LJe0D
         rt29IU70SgwNGNZ52fWHnJvrMtLnHBzp9rnKF4RANnSLB0HjTe1WIqGukU5dqC6xRf+E
         M3PE+Rk4NZ9CzOJpV5f2qnXWVAfgJv1wnDN4p7SHFRBx4WYO/E4nG156Efl0qs6m1GkB
         sd9C8GLyQ2zwQvKo4lY3bSGTLfpGjoeIx1wtlvPRCGiwqpFCmILExcaRd54BCNeAwkh2
         UqfDWXfvki1BvGTfzjLDv2KQQQL2cXrwj25fPW4UlMbDrb1Z5AFXO1LHS4390qJlGVMb
         t7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778006953; x=1778611753;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXtpS07tBEv3WQr9Lo010ZB646RMAloupbb7TUk/iMY=;
        b=d8OSmutTLOMyzLKbiE7TU0GPoQm7iJn0aIpoR4NGqAVtUK08Uahu0FIK6GNxHTv3rg
         9/o3f+NsNeJtkYh/kzz/tR6NNvHSkvX35t9LlzXYepUFPTtXB3Y6DHdT0vmNMLRKzgpD
         Jjyk8IfLbUTJQZqmnmerlpqxuaONdnPzs9JQ1v23qvWy96t1Nc2iJw6Xz0gzaTcs6RBy
         pS3CaszeNjfrHWYqJdkNvaUpWPEHpSOv52olB0H4AZpfH/iVsQB8qYfPT7GDNS4Ue2wQ
         gQWsir/ATKan6NOYjM2SCw/v+Y1eMVTtPNXbhueBA1zMzO4zvYvi8dlZm5DY+79D59qy
         n+Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9ozbY00IOL587oXEIfMBTBNQtzc2nTdRoZE/fMLvuQSDC9fn044lwd7faGBHJed4y4NCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzksLFViCuNAPXM+EJ4oul2L5x5qHxX0ZphZxR112ULOFf0qHu5
	jBS7VO4lp64DiBWAI8CcH9GjGagC6flf2WezuIU8KDgfv8h55VHVr273eWSeYUDqRRXP4e7563A
	selPT6Q==
X-Received: from plbkb8.prod.google.com ([2002:a17:903:3388:b0:2b2:a6ef:8235])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:187:b0:2b9:fb9a:1103
 with SMTP id d9443c01a7336-2ba79ad08e6mr1442675ad.38.1778006952787; Tue, 05
 May 2026 11:49:12 -0700 (PDT)
Date: Tue, 5 May 2026 11:49:12 -0700
In-Reply-To: <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org> <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
 <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
 <afTnlv_cAWFfouqk@google.com> <afoytsu6LzzpeTfc@google.com> <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
Message-ID: <afo7qB3hyrD_9Jme@google.com>
Subject: Re: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2026, Yosry Ahmed wrote:
> On Tue, May 5, 2026 at 11:11=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > So I think we actually want to handle this in pmc_is_locally_enabled(),=
 because
> > the host/guest bits are "local" controls.  One option would be to add t=
he guest/host
> > masks as constants in kvm_pmu_ops, and bleed the logic into pmc_is_loca=
lly_enabled(),
> > e.g. to avoid the CALL+RET overhead.  But if make the callback a "negat=
ive", then
> > we can make the static call OPTIONAL_RET0, which will turn the call int=
o a glorified
> > nop for everything except AMD with a mediated PMU.  E.g.
> >
> > diff --git arch/x86/kvm/pmu.h arch/x86/kvm/pmu.h
> > index 0925246731cb..d8ce0938fcbe 100644
> > --- arch/x86/kvm/pmu.h
> > +++ arch/x86/kvm/pmu.h
> > @@ -190,7 +190,8 @@ static inline bool pmc_is_locally_enabled(struct kv=
m_pmc *pmc)
> >                                         pmc->idx - KVM_FIXED_PMC_BASE_I=
DX) &
> >                                         (INTEL_FIXED_0_KERNEL | INTEL_F=
IXED_0_USER);
> >
> > -       return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
> > +       return (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) &&
> > +              !kvm_pmu_call(pmc_is_locally_disabled(pmc));
>=20
> We still get the overhead on AMD with mediated PMU enabled, but more
> importantly, I am not sure what pmc_is_locally_disabled() would test
> for here? Do we re-check EFER, guest mode, etc to figure it out? I
> don't think this is what you mean as it would be redundant, but I am
> not sure what else.

Yep, that's exactly what I mean.

> Did you see my other replies and code snippet tracking disabling
> reasons? I think the code snippet would still work, I just need to
> move the pmc_is_nested_disabled() check into pmc_is_locally_enabled().

I did.  IMO, all of what you proposed is an optimization to avoid the "cost=
ly"
checks at the time of pmc_is_locally_enabled().  In quotes because I don't =
think
the _overall_ cost is actually all that high.  pmc_is_locally_enabled() is =
only
called in relatively slow paths, and my guess is the CALL+RET (or untrained=
 RET,
ugh) is probably more expensive than the logic itself.

The very nice side effect of incorporating the logic into pmc_is_locally_en=
abled()
is that I _think_ we can drop kvm_pmu_ops.reprogram_counters(), because
amd_mediated_pmu_handle_host_guest_bits() will instead be:

  static bool amd_pmc_is_locally_disabled(struct kvm_pmc *pmc)
  {
	struct kvm_pmu *pmu =3D pmc_to_pmu(pmc);
	struct kvm_vcpu *vcpu =3D pmu_to_vcpu(pmu);
	u64 host_guest_bits;

	/* Common code is supposed to check the common enable bit. */
	if (WARN_ON_ONCE(!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)))
		return false;

	/*
	 * If both bits are cleared, always keep the counter enabled. Otherwise,
	 * counter enablement needs to be re-evaluated on every nested
	 * transition (and EFER.SVME change).
	 */
	host_guest_bits =3D pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
	if (!host_guest_bits)
		return true;

	/* If either bit is set and EFER.SVME=3D0, the counter is disabled. */
	if (!(vcpu->arch.efer & EFER_SVME))
		return false;

	if (host_guest_bits =3D=3D AMD64_EVENTSEL_HOST_GUEST_MASK)
		return true;

	return !!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) =3D=3D is_guest_mode=
(vcpu);
  }


reprogram_pmcs_on_nested_transitions would need to be handled somewhere els=
e, but
(a) that's probably the correct approach anyways (hook writes to the events=
el)
and (b) is _also_ an optimization, because KVM can start with the naive app=
roach
of always reprogramming counters on nested transitions (if guest/host bits =
are
supported).

And if we're clever, we can optimize pmc_is_locally_enabled() by putting
reprogram_pmcs_on_nested_transitions in kvm_pmu, e.g. as something like
pmc_has_mode_specific_enables, and then doing:

	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
		return false;

	if (!test_bit(pmc->idx, &pmu->pmc_has_mode_specific_enables))
		return true;

	return !kvm_pmu_call(pmc_is_locally_disabled(pmc));

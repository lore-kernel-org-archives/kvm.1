Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A24921B2
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778004665; cv=none; b=YPJbiK4VdC/qEE4T0eQtztPE1HFWog4IbNxv/L4BJMksRoWVL3gQp8rfkrPCnrRori5ED8N3i7XVVJkkVlFy5kx10OCdZnYC8VxdQXZ/yOeof1UKngweAjc726WXDHHLmg3Dt4kpN+Tr0RDYm+j/GLsR2IB/Js9WW4WdcsGebu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778004665; c=relaxed/simple;
	bh=OUHOHvnYp+bCqi2N3tBeIL2Q+7tLWLNDVe9Aef9C7p0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gc5fSZ3r6jN/wFTFv4sgqdza0PfgS7LCaPlvTBbpkLlIfUzDyZbgZWunITHgD+Pz/AjM+tGqC5WReECSDXSjS4e+mcKi+MT0iTvAXaNlmkct4aPG1Z5QnR1dGBMuKDRWBAWs5MaoijKdC48HvM5s6kzGzwcgxu7m3RjCswf5CEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBQN/oqu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBQN/oqu"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c709551ec08so6842312a12.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778004664; x=1778609464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqv0EnEXw9SqS7xgyxAHVdLynKTNb2D6rT984dy2Pns=;
        b=CBQN/oquTUMymr0xEY4bwq8a/aO3wTlHca9ndBdp6YjZ6jRADhkDw0vlznCpplCQ+L
         gGsdF2Ac4bFV5sM2sViRRttPYqldI75ZgK7s9AugEVqZgO5j8cqMs71DfS+uXlsrQy8I
         YWec/Od75VfyhBbDrd48CV2o8xXA733Z4qqBTaG5PfnRn3Un9N18ac4oWgfl/MwnpEMA
         uVyrYTvt46ihaZAUcC9FBiPbJS8d1RdLBka2H1W5moQ1m+vEV2fZiYvIj4FC6iYThJYd
         1vlJZ2hX8wI6uiuClvjRqgzcfBmilHVw60JicTNhcCK6PG/7IekcmkIQzQFkZMOIB8iF
         9EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778004664; x=1778609464;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqv0EnEXw9SqS7xgyxAHVdLynKTNb2D6rT984dy2Pns=;
        b=k56ILXdq+pW4P5EflTCqDeVvpmILof3WGwVysVxs7qmShrXT3terDFZ6JiHJvN57ey
         KQVfuD3mVeXuf/6CemCJTgLcWYaFDRH9pg+mG9RPdKYYv6jouN/Lok/NrmGdbVsNU6db
         lHgmDWoCNQ3e1Iq/4X2e1qb8mDiQ2HbWP7fituX86mM3giAuctAmXZjGIS4fIOUx2m6+
         Eh5wrsvBl/5BaApoatoIZPvrX/CMAvPuQbPSXFI3S80ad/e1wYy3riFDrgREyCIkNiIL
         hkz2UMEV+1xxpnCcu+DZ5juNXtE8djsr67CmZ1ax9T1Gb3vRRGU+bOhZyjpkWuqismvI
         K1zw==
X-Forwarded-Encrypted: i=1; AFNElJ/aZ1GCtGvY7iP3JzekY8zz5qsgHUFFsRBwOWhGabIlW7EtHdHl28PKWRw+2poc5FXuv9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxI5otu8VFC17Z58n25qdz/q+S16mwbptenIf2jR9WSqmIcO1
	xaSYIDJhHvrGjDYdSqFMzVGpX9+y3mBzPkr3NpYTTBBPebXlDl/Jjogk3+9DHv30M7VVkYPBEnI
	dMHZoXw==
X-Received: from pfbbe14.prod.google.com ([2002:a05:6a00:1f0e:b0:835:4315:3453])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e83:b0:839:f1c0:13ce
 with SMTP id d2e1a72fcca58-839f1c017e1mr1930434b3a.40.1778004663397; Tue, 05
 May 2026 11:11:03 -0700 (PDT)
Date: Tue, 5 May 2026 11:11:02 -0700
In-Reply-To: <afTnlv_cAWFfouqk@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org> <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
 <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com> <afTnlv_cAWFfouqk@google.com>
Message-ID: <afoytsu6LzzpeTfc@google.com>
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

On Fri, May 01, 2026, Yosry Ahmed wrote:
> On Thu, Apr 30, 2026 at 08:34:59PM -0700, Yosry Ahmed wrote:
> > On Thu, Apr 30, 2026 at 4:24=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > > > +static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcp=
u *vcpu,
> > > > +                                                   struct kvm_pmc =
*pmc)
> > > > +{
> > > > +       u64 host_guest_bits;
> > > > +
> > > > +       if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> > > > +               return;
> > > > +
> > > > +       /* Count all events if both bits are cleared */
> > > > +       host_guest_bits =3D pmc->eventsel & AMD64_EVENTSEL_HOST_GUE=
ST_MASK;
> > > > +       if (!host_guest_bits)
> > > > +               return;
> > > > +
> > > > +       /*
> > > > +        * If EFER.SVME is set, the counter is disabledd if only on=
e of the bits
> > > > +        * is set and it doesn't match the vCPU context. If EFER.SV=
ME is
> > > > +        * cleared, the counter is disable if any of the bits is se=
t.
> > > > +        */
> > > > +       if (vcpu->arch.efer & EFER_SVME) {
> > > > +               if (host_guest_bits =3D=3D AMD64_EVENTSEL_HOST_GUES=
T_MASK)
> > > > +                       return;
> > > > +
> > > > +               if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) =
=3D=3D is_guest_mode(vcpu))
> > > > +                       return;
> > > > +       }
> > > > +
> > > > +       pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
> > >
> > > Sashiko raised a good point here. In the following patch, we reprogra=
m
> > > the counters synchronously on nested transitions to update the
> > > counters' enablement before counting VMRUN or WRMSR(EFER.SVME).
> > > However, this updates pmc->eventsel_hw while
> > > kvm_pmu_recalc_pmc_emulation() checks pmc->eventsel to check if the
> > > counter is enabled.
> > >
> > > I think either pmc_is_locally_enabled() needs to check
> > > pmc->eventsel_hw or we need to update pmc->eventsel here.

Hmm.  I don't think either of those is the correct approach.  Unlike the MS=
R filter
case, the H/G stuff is architectural.  I.e. KVM doesn't just need to disabl=
e the
counter in hardware, KVM _always_ needs to treat the counter as disabled.

So I think we actually want to handle this in pmc_is_locally_enabled(), bec=
ause
the host/guest bits are "local" controls.  One option would be to add the g=
uest/host
masks as constants in kvm_pmu_ops, and bleed the logic into pmc_is_locally_=
enabled(),
e.g. to avoid the CALL+RET overhead.  But if make the callback a "negative"=
, then
we can make the static call OPTIONAL_RET0, which will turn the call into a =
glorified
nop for everything except AMD with a mediated PMU.  E.g.

diff --git arch/x86/kvm/pmu.h arch/x86/kvm/pmu.h
index 0925246731cb..d8ce0938fcbe 100644
--- arch/x86/kvm/pmu.h
+++ arch/x86/kvm/pmu.h
@@ -190,7 +190,8 @@ static inline bool pmc_is_locally_enabled(struct kvm_pm=
c *pmc)
                                        pmc->idx - KVM_FIXED_PMC_BASE_IDX) =
&
                                        (INTEL_FIXED_0_KERNEL | INTEL_FIXED=
_0_USER);
=20
-       return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
+       return (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) &&
+              !kvm_pmu_call(pmc_is_locally_disabled(pmc));
 }
=20
 extern struct x86_pmu_capability kvm_pmu_cap;


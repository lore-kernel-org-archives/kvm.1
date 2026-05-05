Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B2492195
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005438; cv=none; b=pIY7Kq9AUVPZHa8hx/Biy+iJZJu+CRuKUvrE+H/Cf8ASqMCbg+IbNbrVJ6UZOF8HnEcWU/iPPvz+zWp7MXeofyYPXbbMQ6AGmGtR9+w5DKRj9Qu9kuXe7920rJNxw3NBXYaaGBrhNKMfQ6Kr37YOPSWzsn1KRhl6Es15lo7rGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005438; c=relaxed/simple;
	bh=X6hd5yCUoGWjL3NBE4wK5cDlbemei3qXHNIXMUjNik4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR5+Fklqg9BpcDpmypf07XbSwmJ3XnuzFt3hGzGWh21fWNY5WJ64cN4MJW++Waf1UbGaXttcRbfblbwbUEfwSyWrwDOufdFEvRF5Nk+h7mk+LauQes4QW/W4P2QhTCSCrNNq6GD7Sai+Szhvt0NUbeMfPoI8rZSiVbiJLdhK490=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1w06wd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1w06wd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DD2C2BCC7
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005437;
	bh=X6hd5yCUoGWjL3NBE4wK5cDlbemei3qXHNIXMUjNik4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U1w06wd2uxem+HnnTQA5XHoNalTwp54ydT0Gnir6lA8st69gJPvaQdbMadSneiZ23
	 YNrKL2/gJe+0t87eqM3XI8EP9nE6/Q4sZpOv9dkUKqwqoqiCp4OUelKC3a+Oy3ZKP9
	 aXqPptye7URRtaqY3DemGB2ZZcVPWxqK9OSVJt1Nc/6i4RRrLu1i4BcIuJuzT95pnu
	 03lywkVtQlnxuf1sJJDfPOE2Gw8e0Q8hvYelqTQicefJgTqkwie6OZscZ2A242FSH6
	 TC5xQ+wT/kLOm+T7pH5dUEhGGEEBX4Uoj5FnBKEjrAOMWB9h6m0bjhMgakWXb/8X62
	 y7xDHQQjgSeeQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6729c6f0ca7so7204250a12.0
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 11:23:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8deNqQOV6XWcltyIYxxRvfin+Um32wMEefX2nK782+oJFy4EOCQMAZ2+To7XZ1zPxzxfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuSAgiI7hOFyC2ijtRhwrVdi3Bl9m2nyAQzkDJKTBrmcb8pGMp
	+Bg0NyajmCtU36x+JmxmcG59mIBq7gJqjVCroytMCIHPgiq60dD6bx9feeG0q7L/VJmQOPn0xnb
	XSE/5XC+qr6u0mRdtCWZckayMki2FCaI=
X-Received: by 2002:a17:907:a0a:b0:ba7:34cb:388b with SMTP id
 a640c23a62f3a-bbffbf78e40mr923188966b.42.1778005436742; Tue, 05 May 2026
 11:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org> <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
 <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
 <afTnlv_cAWFfouqk@google.com> <afoytsu6LzzpeTfc@google.com>
In-Reply-To: <afoytsu6LzzpeTfc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 5 May 2026 11:23:45 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
X-Gm-Features: AVHnY4Kx5I1GPXYgUtNZTvCY0ohhZ79q4rplEfCYTH1IbSOCkIGyYNwB7R9-ZYo
Message-ID: <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
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

On Tue, May 5, 2026 at 11:11=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, May 01, 2026, Yosry Ahmed wrote:
> > On Thu, Apr 30, 2026 at 08:34:59PM -0700, Yosry Ahmed wrote:
> > > On Thu, Apr 30, 2026 at 4:24=E2=80=AFPM Yosry Ahmed <yosry@kernel.org=
> wrote:
> > > > > +static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_v=
cpu *vcpu,
> > > > > +                                                   struct kvm_pm=
c *pmc)
> > > > > +{
> > > > > +       u64 host_guest_bits;
> > > > > +
> > > > > +       if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> > > > > +               return;
> > > > > +
> > > > > +       /* Count all events if both bits are cleared */
> > > > > +       host_guest_bits =3D pmc->eventsel & AMD64_EVENTSEL_HOST_G=
UEST_MASK;
> > > > > +       if (!host_guest_bits)
> > > > > +               return;
> > > > > +
> > > > > +       /*
> > > > > +        * If EFER.SVME is set, the counter is disabledd if only =
one of the bits
> > > > > +        * is set and it doesn't match the vCPU context. If EFER.=
SVME is
> > > > > +        * cleared, the counter is disable if any of the bits is =
set.
> > > > > +        */
> > > > > +       if (vcpu->arch.efer & EFER_SVME) {
> > > > > +               if (host_guest_bits =3D=3D AMD64_EVENTSEL_HOST_GU=
EST_MASK)
> > > > > +                       return;
> > > > > +
> > > > > +               if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY=
) =3D=3D is_guest_mode(vcpu))
> > > > > +                       return;
> > > > > +       }
> > > > > +
> > > > > +       pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
> > > >
> > > > Sashiko raised a good point here. In the following patch, we reprog=
ram
> > > > the counters synchronously on nested transitions to update the
> > > > counters' enablement before counting VMRUN or WRMSR(EFER.SVME).
> > > > However, this updates pmc->eventsel_hw while
> > > > kvm_pmu_recalc_pmc_emulation() checks pmc->eventsel to check if the
> > > > counter is enabled.
> > > >
> > > > I think either pmc_is_locally_enabled() needs to check
> > > > pmc->eventsel_hw or we need to update pmc->eventsel here.
>
> Hmm.  I don't think either of those is the correct approach.  Unlike the =
MSR filter
> case, the H/G stuff is architectural.  I.e. KVM doesn't just need to disa=
ble the
> counter in hardware, KVM _always_ needs to treat the counter as disabled.

Yeah I agree both are not correct.

>
> So I think we actually want to handle this in pmc_is_locally_enabled(), b=
ecause
> the host/guest bits are "local" controls.  One option would be to add the=
 guest/host
> masks as constants in kvm_pmu_ops, and bleed the logic into pmc_is_locall=
y_enabled(),
> e.g. to avoid the CALL+RET overhead.  But if make the callback a "negativ=
e", then
> we can make the static call OPTIONAL_RET0, which will turn the call into =
a glorified
> nop for everything except AMD with a mediated PMU.  E.g.
>
> diff --git arch/x86/kvm/pmu.h arch/x86/kvm/pmu.h
> index 0925246731cb..d8ce0938fcbe 100644
> --- arch/x86/kvm/pmu.h
> +++ arch/x86/kvm/pmu.h
> @@ -190,7 +190,8 @@ static inline bool pmc_is_locally_enabled(struct kvm_=
pmc *pmc)
>                                         pmc->idx - KVM_FIXED_PMC_BASE_IDX=
) &
>                                         (INTEL_FIXED_0_KERNEL | INTEL_FIX=
ED_0_USER);
>
> -       return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
> +       return (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) &&
> +              !kvm_pmu_call(pmc_is_locally_disabled(pmc));

We still get the overhead on AMD with mediated PMU enabled, but more
importantly, I am not sure what pmc_is_locally_disabled() would test
for here? Do we re-check EFER, guest mode, etc to figure it out? I
don't think this is what you mean as it would be redundant, but I am
not sure what else.

Did you see my other replies and code snippet tracking disabling
reasons? I think the code snippet would still work, I just need to
move the pmc_is_nested_disabled() check into pmc_is_locally_enabled().

>  }
>
>  extern struct x86_pmu_capability kvm_pmu_cap;
>

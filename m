Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD05F3D524E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012708; cv=none; b=I5OY62wKBTrvaY5xvo0baZFejg4b/ZG5gKf20EOfMj1kxXUXjXBQQ47/GJBkuhuK/b5tNa1mRA3eWo/IBCRJ3eRPQtWmGn0hbJKUqQep8euUEloFIgp9v/mtaNP/7fc1F7RNMjDIQGtbk2EZtFKEw+vERwXbW1wCfJzAerH3TwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012708; c=relaxed/simple;
	bh=IJpiKgFjBX+Xei/cM6LwPtkv5zPy4MGNZ4Kf9qJgWQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGfKT1UEphxwdP3BCVFEeVccUaipxDawtgYH5l1E/g9qibiRdd8pAOthDnMOjnzR6meGLr4SjyPX7/FGfSoAl/NknHopgSUhrbccJ1L7dsEkYN2XMG1GrpJctzipcWXYNwkSCQQx5v4s5GuSKfq1UGOLjSzl9QlL6/CZHDqRHW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frw1L5WY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frw1L5WY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E544C2BCFA
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778012708;
	bh=IJpiKgFjBX+Xei/cM6LwPtkv5zPy4MGNZ4Kf9qJgWQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=frw1L5WYGuMOrHfh7yS4Ym3P3zBQkSfvoBSjX/kkr052RDcH+JLRxF21pR+cw5KYW
	 /I28UdR518kEFjHD9KvTLjQTSDGOMQiy6cTD72ghWybPjss0us0Li5YRsc7A97of5T
	 BlstiYqETk/EPaJXU/7k9m43wfm+OUmFg8lPrTy1xM5cr0DTyDObqLKc1y769AH6c6
	 OlYkXJ98PK6rd88RM7+7sA4BlmprYhtjaOTsuItElOAElf4PDPOaY0j3BJYf+igPQP
	 Oyy6mQY7fayu12L4ALJrh4+mEk4vOagpGJ0f81Li/wssSTEkOLuuYH+fXBCyM1cXPN
	 0Np0DKRSYFRNw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bc2a455fd55so365204766b.2
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 13:25:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+gNDsCCwAcm5fe4sebaus4S36+gRqjDJPMmoIXyfdEwxtn1k6agXaflz49U8rSjBkTWf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGZSAaTRiu0UxTMEvKFHDUuueWTJ37O8B0lEZqTI7aCl1NYeY
	TSiNNJCbP6hjnounHo7UeSGw9x5ZgF2EFzYXaGaDvqwiGdJqzaYxhxOmgHFEIuoPGI/NdxgrSgO
	UaxseF+JFWw52SnyTnXSqsSKVurHvrQo=
X-Received: by 2002:a17:907:7ba6:b0:bc3:d996:684f with SMTP id
 a640c23a62f3a-bc56dd129famr1783966b.42.1778012707349; Tue, 05 May 2026
 13:25:07 -0700 (PDT)
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
 <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
 <afo7qB3hyrD_9Jme@google.com> <afpAw3UkbVMbXptv@google.com> <afpL7QTODL5JbJsN@google.com>
In-Reply-To: <afpL7QTODL5JbJsN@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 5 May 2026 13:24:55 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOFfFNSgmpDXK6_xrXVsfMq-K=Qg5UT5qZrK3CMzJ0b9A@mail.gmail.com>
X-Gm-Features: AVHnY4KjLEQTa7yyvkxAL-FPSSkLCbHus-UFnU_aYSLAx5qvgnRiC-qS_w_ncqQ
Message-ID: <CAO9r8zOFfFNSgmpDXK6_xrXVsfMq-K=Qg5UT5qZrK3CMzJ0b9A@mail.gmail.com>
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

> > We'd also probably want to rename it. I would honeslty just use 'nested'
> > instead of 'locally_disabled' and 'mode_specific_enables' as that's the
> > only current user.
>
> But it's not strictly nested specific.  E.g. even the vCPU doesn't support nested
> virtualization, a (stupid) guest can still set HOST_ONLY and effectively disable
> the counter, thanks to the bizarro behavior of HOST_ONLY when EFER.SVME=0.

Well, that is still 'nested'-related behavior. Anyway, that's
irrelevant, I like your suggestion below.

> > Something like this with your proposed amd_pmc_is_locally_disabled()
> > above, which is similar to the kvm_pmu_ops.mediated_reprogram_counter()
> > implementation in v4 except that the vendor-specific callback is more
> > targeted:
> >
> > static void pmc_check_nested_disabled(struct kvm_pmc *pmc)
> > {
> >       if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> >               return;
> >
> >       if (!test_bit(pmc->idx, &pmu->pmc_has_nested_enables))
> >               return;
> >
> >       pmc->is_nested_disabled = kvm_pmu_call(pmc_is_nested_disabled)(pmc);
> >       if (!pmc->is_nested_disabled)
> >               pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>
> I don't want multiple paths mucking with eventsel_hw's ARCH_PERFMON_EVENTSEL_ENABLE.
> That's how we end up with ordering bugs.  E.g. pmc_check_nested_disabled() *must*
> be called after kvm_mediated_pmu_refresh_event_filter(), which is gross and brittle.
>
> E.g. something like so.  We can even optimize away the PMU filter lookup (which
> I suspect would be more expensive in the common case?) if the counter is disabled
> thanks to H/G bits.
>
> diff --git arch/x86/kvm/pmu.c arch/x86/kvm/pmu.c
> index 7b2b4ce6bdad..4ca4a0078d35 100644
> --- arch/x86/kvm/pmu.c
> +++ arch/x86/kvm/pmu.c
> @@ -530,21 +530,24 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
>         return is_fixed_event_allowed(filter, pmc->idx);
>  }
>
> -static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
> +static void kvm_mediated_pmu_refresh_eventsel_hw(struct kvm_pmc *pmc)
>  {
> -       bool allowed = pmc_is_event_allowed(pmc);
>         struct kvm_pmu *pmu = pmc_to_pmu(pmc);
>
>         if (pmc_is_gp(pmc)) {
>                 pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> -               if (allowed)
> +               if (!test_bit(pmc->idx, &pmu->pmc_has_mode_specific_enables) &&
> +                   kvm_pmu_call(pmc_is_locally_disabled(pmc)))
> +                       return;
> +
> +               if (pmc_is_event_allowed(pmc))
>                         pmc->eventsel_hw |= pmc->eventsel &
>                                             ARCH_PERFMON_EVENTSEL_ENABLE;
>         } else {
>                 u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
>
>                 pmu->fixed_ctr_ctrl_hw &= ~mask;
> -               if (allowed)
> +               if (pmc_is_event_allowed(pmc))
>                         pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
>         }
>  }
>
> Actually, this code is being silly.  It unnecessarily performs the PMU filter
> lookup when the _guest_ disables the counters via eventsel.  If you first "fix"
> that by querying pmc_is_locally_enabled() before checking the event filter, then
> you won't even need to touch that code when introducing H/G bits, because it will
> Just Work thanks to pmc_is_locally_enabled() doing the right thing (as it should,
> becase as mentioned early, that logic is architectural).

Believe it or not, I thought about adding this in
kvm_mediated_pmu_refresh_event_filter() from the beginning for the
same reason, to have a single path that updates eventsel_hw. I didn't
pursue it because I started overthinking the new function name and
ended up ditching the whole idea -- which is extremely silly now that
I think about it :)
>
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 7b2b4ce6bdad..c84f2f971ab1 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -530,22 +530,23 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
>         return is_fixed_event_allowed(filter, pmc->idx);
>  }
>
> -static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
> +static void kvm_mediated_pmu_refresh_eventsel_hw(struct kvm_pmc *pmc)
>  {
> -       bool allowed = pmc_is_event_allowed(pmc);
> +       bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
>         struct kvm_pmu *pmu = pmc_to_pmu(pmc);
>
>         if (pmc_is_gp(pmc)) {
> -               pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>                 if (allowed)
> -                       pmc->eventsel_hw |= pmc->eventsel &
> -                                           ARCH_PERFMON_EVENTSEL_ENABLE;
> +                       pmc->eventsel_hw |= ARCH_PERFMON_EVENTSEL_ENABLE;
> +               else
> +                       pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>         } else {
>                 u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
>
> -               pmu->fixed_ctr_ctrl_hw &= ~mask;
>                 if (allowed)
> -                       pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
> +                       pmu->fixed_ctr_ctrl_hw |= mask;
> +               else
> +                       pmu->fixed_ctr_ctrl_hw &= ~mask;
>         }
>  }
>
> @@ -558,7 +559,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
>         u8 fixed_ctr_ctrl;
>
>         if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
> -               kvm_mediated_pmu_refresh_event_filter(pmc);
> +               kvm_mediated_pmu_refresh_eventsel_hw(pmc);
>                 return 0;
>         }
>
> > Also, would you rather I send a new version with everything, or do you
> > want to pick up some of the patches in this version independently?
>
> Uh, probably just send a new version.  I doubt I'll get through the first few
> patches before you're ready to send the next version.

Makes sense, thank you!

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795023122;
	b=iBC1cPFw7hullsqKThi2RwlQSrnb1qpkfQYnjcdRx6XsDvAru1kEfUPMedwYo9nX31Z6
	 yb5GoDLtyKYsFvIvF3bKI1S4ZFLZH1tPvaGJsmlrDzMWA5qgnh22alQh8iaRWPmYT5QHU
	 osdhDL99bARVFCf5DfzHhzTmWWaxjFwaqN20fa0E+usPeZ6GPWVxn8hrrIWFqWekLwYdI
	 a9whsZgCazpFICwl9kvLUWm7JXpXXgzhy8PT510Rxuzh93Gp9jIxaJ49LBnpfODMsgMVF
	 fjgMF53P99DTiqhgUQVWHTD2aChSeyWNr/bGKfxUPrJsY64ZGAcYFVsJnP3gPtYwPcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795023122;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=39Kj0a+AfqIU6zZ4WAZjcFe8Lx6dEFRny4Q4EJpO0IA=;
	b=WyjBLJ/HW4CJAfkRwmqf/0XDlyhH9u/QZfc4ubo0PAiwcmVQpVBDAx3WiLaTfLKGifse
	 BGqidB3tXdb1wcfFJdalDtior4VewWvKSTwSVNbqseXZM3uUxOJbvr8aDIfQhvTQTiATR
	 rPp6W8F5kxrla8nWgvqG8ggF2l29W86KXaehyY733pW3x844nxt1+zo+i1iSSs4werU+G
	 biXzpInO0SfE85KPVRXGaYHMXV36j4qy+s1/1HZTDa7UPEJD2RUYvWZoBAAwAQrMBhfiF
	 igtoCiGO/r8S1gaagOLcgtjnt4WIFTWa5pcBHH3vTc3LNjmCAaJHMi0C7N9EV3T1blA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmDoi5O+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499F606A33D
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmDoi5O+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC901F000C9
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 17:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795023122;
	bh=39Kj0a+AfqIU6zZ4WAZjcFe8Lx6dEFRny4Q4EJpO0IA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nmDoi5O+h3BUG/3BBH7O4M/gY7cnFtu8Hm7ir5akXnI6h5aKX9Unh3RLBOTRq6sQk
	 O25dt+PAwg6GsfoUVvSQJj1adK0iFOqJFk1AkZe19ihjK+Y2CMS4af472rj2+sqlua
	 CCy0sZ5/YiQwivSHVRYkf4NYFx7os3kmfQac/ZGqSM44+NU/AUjLLSvLbGcFAf4rQ8
	 GNiNqZFZZpTC4H9oBM88e0RVic9Uq9AcbHMUTfU1WVKgMgqr7Go17X8klwtNplpIfE
	 iVCHJivEuKG5H9hZFnmNFx08eMRWHTemlxV02Lrzqv31vvyiGwT/vguMoUyVqKzrED
	 KTBdyD5kIcdkQ==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso172564166b.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 09:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF39E+x+i5lqaKyrWsWLLStdNCqAP6pLwA2YrVU+WFmas9qbuskatwBJaGcbf3AW+xwRXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9p1HQ6kER75DULDoWPR6G1p2FQTQgoYQaHv8y1usaPVT4XXqW0
	tEbR87xf4JUd4TvM+5WMwZVcdRoFmCFCE7qaUrzutAI6ZpHF+nPD320xYMpPuuludJWGktfKaWl
	JPb7ZTbh6p5pRiIi0PNlTnXMHHggBxSA=
X-Received: by 2002:a17:907:3e91:b0:c4d:2f6b:435 with SMTP id
 a640c23a62f3a-c510e1482b4mr325692966b.18.1795023121232; Wed, 18 Nov 2026
 09:32:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112203227.289379-1-zide.chen@intel.com> <20261112203227.289379-7-zide.chen@intel.com>
 <avz3U-w-CBtTM0uH@google.com> <77f19d29-224d-474d-afc2-25f0ae1bd6cc@intel.com>
In-Reply-To: <77f19d29-224d-474d-afc2-25f0ae1bd6cc@intel.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 18 Nov 2026 09:31:50 -0800
X-Gmail-Original-Message-ID: <CAO9r8zPEBNXRDGYJizZfwmAJnDXFt9rXD6RLsm5_4Uh-Yph0fA@mail.gmail.com>
X-Gm-Features: AclHuK-QAloYM5bZYl_NwSGnKQbux45mb5yhFTfUjIZFBJxqmN0Gt84rDgH6No4
Message-ID: <CAO9r8zPEBNXRDGYJizZfwmAJnDXFt9rXD6RLsm5_4Uh-Yph0fA@mail.gmail.com>
Subject: Re: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"

> >> @@ -88,6 +88,18 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
> >>      return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
> >>  }
> >>
> >> +static inline u64 kvm_gp_pmc_mask(struct kvm_pmu *pmu)
> >> +{
> >> +    return pmu->pmc_exists64 &
> >> +           GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
> >> +}
> >> +
> >> +static inline u64 kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
> >> +{
> >> +    return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
> >> +           GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
> >
> > Why do we need to & with the
> > KVM_MAX_NR_GP_COUNTERS/KVM_MAX_NR_FIXED_COUNTERS mask here? Isn't
> > pmc_exists64 already clamped?
>
> For kvm_gp_pmc_mask(), masking with GENMASK_ULL(31, 0) is required to
> strip off the fixed counter bits [34:32] and bit 58.
>
> For kvm_fixed_pmc_mask(), bit 58 (INTEL_PMC_IDX_FIXED_VLBR) could show
> up at bit (58 - 32) = 26 in the returned fixed mask. So the mask is
> necessary to strip it off.

I lost track of it being shared, ignore this, sorry.

>
> >
> >> +}
> >> +
> >>  static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> >>  {
> >>      return idx < KVM_MAX_NR_GP_COUNTERS &&
> > [..]
> >> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> >> index fadc466cd600..68d23c7877a2 100644
> >> --- a/arch/x86/kvm/vmx/pmu_intel.c
> >> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> >> @@ -71,14 +71,14 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
> >>
> >>      pmu->fixed_ctr_ctrl = data;
> >>      pmu->fixed_ctr_ctrl_hw = data;
> >> -    for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> >> +    kvm_for_each_fixed_counter(i, pmu) {
> >>              u8 new_ctrl = fixed_ctrl_field(data, i);
> >>              u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
> >>
> >>              if (old_ctrl == new_ctrl)
> >>                      continue;
> >>
> >> -            pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
> >> +            pmc = &pmu->fixed_counters[i];
> >
> > By bypassing the helper we lose the array_index_nospec(), right? Same
> > applies if we directly access the array elsewhere.
>
> Right, but array_index_nospec() is only needed when the index comes from
> untrusted guest input (like in get_fixed_pmc()).
>
> Here 'i' is an internal loop iterator bounded by
> KVM_MAX_NR_FIXED_COUNTERS and kvm_fixed_pmc_mask(). Direct indexing
> &pmu->fixed_counters[i] matches kvm_pmu_{load,put}_guest_pmcs() in pmu.c.

Ack.


> >> @@ -535,8 +541,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
> >>      if (!pmu->version)
> >>              return;
> >>
> >> -    pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
> >> -                                     kvm_pmu_cap.num_counters_gp);
> >>      eax.split.bit_width = min_t(int, eax.split.bit_width,
> >>                                  kvm_pmu_cap.bit_width_gp);
> >>      pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
> >> @@ -544,6 +548,14 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
> >>                                    kvm_pmu_cap.events_mask_len);
> >>      pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
> >>
> >> +    nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
> >> +                              kvm_pmu_cap.num_counters_fixed);
> >> +    fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
> >
> > Probably clearer to move these right above where fixed_mask is used.
>
> Agreed. Additionally, fixed counters only exist starting in PMU v2, so
> it makes sense to move the fixed-counter setup down after the
> 'pmu->version == 1' check.
>
> The reason it was originally placed higher up is that in the upcoming
> patch ("Populate CPUID.0AH:ECX fixed-counter bitmap"), fixed_mask will
> also incorporate CPUID.0AH:ECX. But 'entry' is repurposed to look up
> leaf 7.0 right above the version == 1 check, which clobbers leaf 0AH.
>
> To move fixed_mask down cleanly, we need separate entry_10 and
> entry_7 variables. Since that adjustment is not tiny, I propose
> splitting it out into a separate preparation patch, not to mess up this
> already large patch.

Ack.

> >> @@ -575,8 +586,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
> >>                                               INTEL_FIXED_0_USER |
> >>                                               INTEL_FIXED_0_ENABLE_PMI);
> >>
> >> -    counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
> >> -                     ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
> >> +    counter_rsvd = ~(kvm_gp_pmc_mask(pmu) |
> >> +                     (kvm_fixed_pmc_mask(pmu) << KVM_FIXED_PMC_BASE_IDX));
> >
> > Can we use pmc_exists64 here like the AMD code?
>
> Unlike AMD, Intel's may have bit 58 (INTEL_PMC_IDX_FIXED_VLBR) set.
> counter_rsvd is sued to specifically restricts the unreserved bits to
> valid GP and fixed counters.

That's a shame :)

Thanks for patiently answering my questions.

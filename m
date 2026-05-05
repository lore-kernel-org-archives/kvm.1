Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AA47ECD9;
	Tue,  5 May 2026 19:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009558; cv=none; b=QIO/3E04u4KNs1GHc9iJN5hGx+voUrej7XGujVfcKPrPLgiIp3FIh+tLvcfEPXh/qDjF0hQJyH4amOIxuh3iPxjp7cJ3/mjoFsPyg9uGXcLbMEW4X0+fe5JT6x116Np+Si1j/ywGm/kxO50LD9Izftn2jk7CkP+/QLLSWw7LyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009558; c=relaxed/simple;
	bh=jYq6AI/fPz5hho9LrkE9S3epnRL7OW/Cz2HIRTaUUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l67dGF4DqZPlQPD5menxK3o7ZHIUosl2n2y9oo6NVmMgQlcOEttQAoxS7an+JmBEXf/myXi9Gh40H5KsWxLEiUJhcPTcB1rpnFB+cZ5OWBTSNC+UHlJOfqrwfW4/X0HC04SnHFnEk8ch4sV0cTRTY48PsVDw2p89WVeAgl09kYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP9qputI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP9qputI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB6EC2BCC7;
	Tue,  5 May 2026 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778009558;
	bh=jYq6AI/fPz5hho9LrkE9S3epnRL7OW/Cz2HIRTaUUl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SP9qputIY2kKyWg4Y8J3nZ7D9qYNNdDwUn4etktKpjC2oe+DVEygCBT9hrxkdGTGQ
	 AKWw5jb69W5H/eZXpm1A77rm9Afc1Rf6r5P/IAM6aXIHoS7Wm5PxN+3U8ZcOiJe61C
	 PiPL0zG8lq9G0J7SUQp440UfvGsduzV1nBkbD0kerFXFGfyl2Vvi+wxzOBhr+CCJN+
	 HdLx7MnSXmMdLQpnabQYJpjf74/BCxH5jANRz4RzmJJ6Tv7ksnHuCnamKnPe0zXtPT
	 MzJzRyvC2KACAX4ZLjHLpUr/gHjarMik430X3Qpg+FcSHTGZBAc2JcnYMWYnhnsgge
	 GsYQnTwqOwLeQ==
Date: Tue, 5 May 2026 19:32:36 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
Message-ID: <afpAw3UkbVMbXptv@google.com>
References: <20260430202750.3924147-1-yosry@kernel.org>
 <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
 <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
 <afTnlv_cAWFfouqk@google.com>
 <afoytsu6LzzpeTfc@google.com>
 <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
 <afo7qB3hyrD_9Jme@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afo7qB3hyrD_9Jme@google.com>

> > Did you see my other replies and code snippet tracking disabling
> > reasons? I think the code snippet would still work, I just need to
> > move the pmc_is_nested_disabled() check into pmc_is_locally_enabled().
> 
> I did.  IMO, all of what you proposed is an optimization to avoid the "costly"
> checks at the time of pmc_is_locally_enabled().  In quotes because I don't think
> the _overall_ cost is actually all that high.  pmc_is_locally_enabled() is only
> called in relatively slow paths, and my guess is the CALL+RET (or untrained RET,
> ugh) is probably more expensive than the logic itself.
> 
> The very nice side effect of incorporating the logic into pmc_is_locally_enabled()
> is that I _think_ we can drop kvm_pmu_ops.reprogram_counters(), because
> amd_mediated_pmu_handle_host_guest_bits() will instead be:
> 
>   static bool amd_pmc_is_locally_disabled(struct kvm_pmc *pmc)
>   {
> 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> 	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
> 	u64 host_guest_bits;
> 
> 	/* Common code is supposed to check the common enable bit. */
> 	if (WARN_ON_ONCE(!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)))
> 		return false;
> 
> 	/*
> 	 * If both bits are cleared, always keep the counter enabled. Otherwise,
> 	 * counter enablement needs to be re-evaluated on every nested
> 	 * transition (and EFER.SVME change).
> 	 */
> 	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> 	if (!host_guest_bits)
> 		return true;
> 
> 	/* If either bit is set and EFER.SVME=0, the counter is disabled. */
> 	if (!(vcpu->arch.efer & EFER_SVME))
> 		return false;
> 
> 	if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
> 		return true;
> 
> 	return !!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu);
>   }

If we do this and drop kvm_pmu_ops.reprogram_counters(), we still need
somewhere to actually clear ARCH_PERFMON_EVENTSEL_ENABLE in eventsel_hw.

What if we call kvm_pmu_ops.pmc_is_locally_disabled() at the top of
reprogram_counter(), cache the result, and use that for eventsel_hw
modification and in pmc_is_locally_enabled()?

We'd also probably want to rename it. I would honeslty just use 'nested'
instead of 'locally_disabled' and 'mode_specific_enables' as that's the
only current user.

Something like this with your proposed amd_pmc_is_locally_disabled()
above, which is similar to the kvm_pmu_ops.mediated_reprogram_counter()
implementation in v4 except that the vendor-specific callback is more
targeted:

static void pmc_check_nested_disabled(struct kvm_pmc *pmc)
{
	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
		return;
	
	if (!test_bit(pmc->idx, &pmu->pmc_has_nested_enables))
		return;

	pmc->is_nested_disabled = kvm_pmu_call(pmc_is_nested_disabled)(pmc);
	if (!pmc->is_nested_disabled)
		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
}

static int reprogram_counter(struct kvm_pmc *pmc)
{
	...

	if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
		kvm_mediated_pmu_refresh_event_filter(pmc);
		pmc_check_nested_disabled(pmc);
		return 0;
	}
	...
}

Then pmc_is_locally_enabled() also checks pmc->is_nested_disabled. This
completely avoids the extra calls in pmc_is_locally_enabled() and
provides a place for us to actually clear ARCH_PERFMON_EVENTSEL_ENABLE.

> 
> reprogram_pmcs_on_nested_transitions would need to be handled somewhere else, but
> (a) that's probably the correct approach anyways (hook writes to the eventsel)
> and (b) is _also_ an optimization, because KVM can start with the naive approach
> of always reprogramming counters on nested transitions (if guest/host bits are
> supported).
> 
> And if we're clever, we can optimize pmc_is_locally_enabled() by putting
> reprogram_pmcs_on_nested_transitions in kvm_pmu, e.g. as something like
> pmc_has_mode_specific_enables, and then doing:

Yeah I more-or-less incorporated this above. pmu->pmc_has_nested_enables
would be set for a counter in amd_pmu_set_msr() if either bits is set.
Then, svm_pmu_handle_nested_transition() (in the next patch) will use
pmu->pmc_has_nested_enables instead of
svm->nested.reprogram_pmcs_on_nested_transitions.

WDYT? This is essentially the v4 approach except that the per-counter
callback now returns a boolean that we cache and reuse in
pmc_is_locally_enabled(). We have come full circle with the per-counter
callback vs. single callback for all :)

Also, would you rather I send a new version with everything, or do you
want to pick up some of the patches in this version independently?

> 
> 	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> 		return false;
> 
> 	if (!test_bit(pmc->idx, &pmu->pmc_has_mode_specific_enables))
> 		return true;
> 
> 	return !kvm_pmu_call(pmc_is_locally_disabled(pmc));
> 

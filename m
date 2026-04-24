Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D888029D26C;
	Fri, 24 Apr 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013753; cv=none; b=ER6QJhtXEIXjepgPd4A6lwf1s9fDPM7j86gxMteDU/x4upKl8gHzHFB7yEIinVXIi7zYo7wPC5Uz/+sf63ADwfcXzEbc9Tfq0fgFXCC/QLYw2OG8p3+njZzE7gristldF+BBcsSPKW2k/pnYl80/6q8Xg1kbY33/ED6I5PN6+T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013753; c=relaxed/simple;
	bh=UO47jDqbNMeCylYu/Q+bO9UV7lBC7lqwIJnlngk3VPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC9zrq99BpJx9jtRX+110ciLrbmIl0FYn36GXQEuqgYrvT8IhHRAc9TzNjxMIED41jGtIiXN69YIVQnKFrwUgP/HT+IwRTuQ7vBfq23RxYFZ26oFu9oIxyRLHgV2eRd0Izwi8dt2szPpt5ZvjXxfLIjjUoSiAjbCuqa3wEXk2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz0yYXRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz0yYXRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897CAC19425;
	Fri, 24 Apr 2026 06:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777013753;
	bh=UO47jDqbNMeCylYu/Q+bO9UV7lBC7lqwIJnlngk3VPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hz0yYXRE5mjarK7b7f8ooCZh7I9J4WdfzoMZOdztRUTnsEQQvBCeED1hxKdt9/f/S
	 EGZG4NL+KzQ1B6Zkwvg04UxmCMbfj6KHfh7L5C6SVayR1AjQFGu4PQycxLDvlMi7tX
	 ZwxcX9pxAEiIzr9DCbQVF4izYl2ivBUvxUR0R7iPYGbyAmVHa3thcyL4jD8zxxXxNl
	 bjOtPSXqY+XbeFqy/ixe1QmR4Ea51MFzcnsmR/IUUVMs5/swCNNWbb4/m53tZSVlyU
	 soqLalQysyg84hPH6HMbD7BIXxzhdvoRsAvzXUuABAVHTUi2yUauglkyh3+JI6vRnD
	 f0dVS9BA03S4A==
Date: Fri, 24 Apr 2026 06:55:52 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
Message-ID: <aesRPt5Vpco29vAt@google.com>
References: <20260326031150.3774017-1-yosry@kernel.org>
 <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adReHbkVRDGOihb4@google.com>

On Mon, Apr 06, 2026 at 06:30:05PM -0700, Sean Christopherson wrote:
> On Thu, Mar 26, 2026, Yosry Ahmed wrote:
> > diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> > index ff5acb8b199b0..5961c002b28eb 100644
> > --- a/arch/x86/include/asm/perf_event.h
> > +++ b/arch/x86/include/asm/perf_event.h
> > @@ -60,6 +60,8 @@
> >  #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
> >  #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
> >  #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
> > +#define AMD64_EVENTSEL_HOST_GUEST_MASK			\
> > +	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
> >  
> >  #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
> >  #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index d6ac3c55fce55..e35d598f809a2 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -559,6 +559,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
> >  
> >  	if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
> >  		kvm_mediated_pmu_refresh_event_filter(pmc);
> > +		kvm_pmu_call(mediated_reprogram_counter)(pmc);
> 
> I would rather make a single call from kvm_pmu_handle_event(), and let the vendor
> deal with mediated vs. legacy.  I want to avoid mediated-specific ops as much as
> possible, and I think kvm_x86_ops.reprogram_counters() would be easier to
> understand overall.

I think this doesn't apply anymore now that most nested transitions
won't be handled through kvm_pmu_handle_event(). Also because we need
kvm_mediated_pmu_refresh_event_filter() to still be called before
re-evaluating H/G bits and EFER.SVME.

I think leave this callback as-is and handle everything through
reprogram_counter(). Export reprogram_counter() and rename it to
kvm_pmu_reprogram_counter(), and end up with something like this:

void __kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu, bool defer)
{
	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);

	if (bitmap_empty(pmu->reprogram_on_nested_transition, X86_PMC_IDX_MAX))
		return;

	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
	bitmap_zero(pmu->reprogram_on_nested_transition, X86_PMC_IDX_MAX);

	BUILD_BUG_ON(sizeof(pmu->reprogram_on_nested_transition) != sizeof(atomic64_t));
	if (defer) {
		atomic64_or(*(s64 *)pmu->reprogram_on_nested_transition,
			    &vcpu_to_pmu(vcpu)->__reprogram_pmi);
		kvm_make_request(KVM_REQ_PMU, vcpu);
		return;
	}

	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
		kvm_pmu_reprogram_counter(pmc);
}

void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu)
{
	__kvm_pmu_handle_nested_transition(vcpu, false);
}

Actually, if that's desired, we can move this logic into SVM code now.
We won't be calling kvm_pmu_handle_nested_transition() from inside
enter_guest_mode() and leave_guest_mode() anyway so that we can only
defer for the svm_leave_nested() path.

So we can move:
- kvm_pmu_handle_nested_transition() to
svm_pmu_handle_nested_transition()
- pmu->reprogram_on_nested_transition to
svm->nested.reprogram_on_nested_transition

Not sure if we want to keep SVM-specific logic in SVM code, or if we
want to keep code generic as much as possible. I can see good arguments
for both stances.

> > +
> > +static void amd_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
> > +{
> > +	amd_mediated_pmu_handle_host_guest_bits(pmc);
> 
> And then this doesn't need to be such a wonky wrapper, and the "reprogram on
> nested transition" logic can also clear the entire bitmap instead of doing things
> piecemeal, e.g. it can be something like so in the end:

We can still clear the entire bitmap in one go with the above
suggestion, but we'll keep the wonky wrapper :)

> 
> 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
> 		return;
> 
> 	bitmap_zero(pmu->pmc_reprogram_on_nested_transition, X86_PMC_IDX_MAX);
> 
> 	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
> 		amd_mediated_pmu_handle_host_guest_bits(pmc);

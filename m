Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB8330C34E;
	Fri,  1 May 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777657819; cv=none; b=PpRUY8kn7H5OYZaPWyjqFbsXxAsvKHWIse3LoncKgXpEKxGOsefOUe83+NsX2mQBs/y4rP4d+e/25PEUl+hXSr0anctC0lrVPGPraYnQraBNquRVXYgNHpqzwXOebxgn5hLvjRZBGMfIZ3qoqhgFNnEsI3J3czH+PTAobQwdB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777657819; c=relaxed/simple;
	bh=A2eOy2osIRIj01qOx3MxKB2u9J2BUIXVVx5SZRER1vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWr8+R0ZzLYCzkQ+PWRG5aC/sa6USIwttMbqS+iIGtUfBR6036B8Ca6wngIBA7novm//rtgYeUzwZoSeHV+uEopjc28ADKLiqW2RhvSM+tmYKIKtfnpeYx/ZGdWlhPigByG2Qjp/C8ixUVYCUBSzVrOFcBZOAFq+52b5RkY1S8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4J5gEOp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4J5gEOp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB7DC2BCB4;
	Fri,  1 May 2026 17:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777657819;
	bh=A2eOy2osIRIj01qOx3MxKB2u9J2BUIXVVx5SZRER1vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4J5gEOpRkQO7osIedURmSUFW/Tpe0tMqesVsuqlz73SkkQA/+VR/m2tabZ+ej+YG
	 amFV+ZFSz6itp6EwSe5rD4vYe6RmA2Sget/ayWoMsbEk1EAs7mg11A64qkOG3AZSdV
	 57rYUnLZj2N2v674M+rpW3S/L+uXPchpQb5fGJjkLxwNGFgyjd3NE0tlJSPCGaCuaq
	 o3l4tHZ+At+sNcdoZvRSbegcZtvJK6Ae5adFipcd0/E9+0vmIrcp8vC3bTFgae5N6D
	 SAxiuTBqZCuoND5nTZudZNS/Bsyumz74pL6Z+ZKQjZ+du8XGvIJyg6kYAHAhakj0IG
	 SqXdPd/IgGuhQ==
Date: Fri, 1 May 2026 17:50:17 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
Message-ID: <afTnlv_cAWFfouqk@google.com>
References: <20260430202750.3924147-1-yosry@kernel.org>
 <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
 <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>

On Thu, Apr 30, 2026 at 08:34:59PM -0700, Yosry Ahmed wrote:
> On Thu, Apr 30, 2026 at 4:24 PM Yosry Ahmed <yosry@kernel.org> wrote:
> >
> > > diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> > > index 0e99022168a85..0c372b9f8ed34 100644
> > > --- a/arch/x86/kvm/pmu.h
> > > +++ b/arch/x86/kvm/pmu.h
> > > @@ -36,6 +36,7 @@ struct kvm_pmu_ops {
> > >         void (*reset)(struct kvm_vcpu *vcpu);
> > >         void (*deliver_pmi)(struct kvm_vcpu *vcpu);
> > >         void (*cleanup)(struct kvm_vcpu *vcpu);
> > > +       void (*reprogram_counters)(struct kvm_vcpu *vcpu, u64 counters);
> > >
> > >         bool (*is_mediated_pmu_supported)(struct x86_pmu_capability *host_pmu);
> > >         void (*mediated_load)(struct kvm_vcpu *vcpu);
> > > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > > index 7aa298eeb0721..fe6f2bb79ab83 100644
> > > --- a/arch/x86/kvm/svm/pmu.c
> > > +++ b/arch/x86/kvm/svm/pmu.c
> > > @@ -260,6 +260,48 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
> > >                 wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
> > >  }
> > >
> > > +static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *vcpu,
> > > +                                                   struct kvm_pmc *pmc)
> > > +{
> > > +       u64 host_guest_bits;
> > > +
> > > +       if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> > > +               return;
> > > +
> > > +       /* Count all events if both bits are cleared */
> > > +       host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> > > +       if (!host_guest_bits)
> > > +               return;
> > > +
> > > +       /*
> > > +        * If EFER.SVME is set, the counter is disabledd if only one of the bits
> > > +        * is set and it doesn't match the vCPU context. If EFER.SVME is
> > > +        * cleared, the counter is disable if any of the bits is set.
> > > +        */
> > > +       if (vcpu->arch.efer & EFER_SVME) {
> > > +               if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
> > > +                       return;
> > > +
> > > +               if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
> > > +                       return;
> > > +       }
> > > +
> > > +       pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> >
> > Sashiko raised a good point here. In the following patch, we reprogram
> > the counters synchronously on nested transitions to update the
> > counters' enablement before counting VMRUN or WRMSR(EFER.SVME).
> > However, this updates pmc->eventsel_hw while
> > kvm_pmu_recalc_pmc_emulation() checks pmc->eventsel to check if the
> > counter is enabled.
> >
> > I think either pmc_is_locally_enabled() needs to check
> > pmc->eventsel_hw or we need to update pmc->eventsel here.
> >
> > AFAICT, pmc->eventself has the value written to the MSR, so I think we
> > want to keep that as-is.
> >
> > On the other hand, ARCH_PERFMON_EVENTSEL_ENABLE is cleared in
> > pmc->eventsel_hw in kvm_mediated_pmu_refresh_event_filter() if the
> > event is not allowed, and kvm_pmu_recalc_pmc_emulation() has a comment
> > about intentionally ignoring event filters.
> >
> > We can also separately track enablement for nested purposes, but that
> > would add one more thing we need to check aside from general counter
> > enablement and event filtering.
> >
> > None of these options are ideal, perhaps directly clearing the bit in
> > pmc->eventsel would do the least damage as (pmc->eventsel &
> > ARCH_PERFMON_EVENTSEL_ENABLE) is only checked by
> > pmc_is_locally_enabled().
> 
> No, we can't really clear the bit in pmc->eventsel as that's what the
> guest reads with RDMSR.
> 
> The more I think about this, the more I think we should drop
> pmc->eventsel_hw. It serves two purposes AFAICT:
> 1. On AMD, we use it to clear HOSTONLY and set GUESTONLY in actual HW.
> 2. For event filtering, we use it to clear EVENTSEL_ENABLE.
> 
> But maybe it's easier to explicitly track the changes we need to apply
> to eventsel rather than a HW version?
> 
> (1) is trivial, we can just clear HOSTONLY and set GUESTONLY before
> doing the actual write as that's constant.
> 
> For (2), instead of eventsel_hw, maybe add a boolean called 'filtered'
> to track if that PMC should be filtered out or not. Then, we can add
> another boolean to track if the counter is disabled due to
> nested/HG-bits (e.g. 'nested_disabled').
> 
> With that, pmc_is_locally_enabled() would check:
>   (pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE) && !pmc->nested_disabled
> 
> , and then before writing to HW we check pmc->filtered,
> pmc->nested_disabled, as well as do the HOSTONLY/GUESTONLY changes for
> AMD.
> 
> Actually, instead of a boolean, maybe add 'disabled_reasons' flags,
> with possible flags like PMC_DISABLED_FILTER and PMC_DISABLED_NESTED.
> 
> This might all be unclear, I will draft some diff on top of the series
> tomorrow and send it in case it makes things clearer.

This is what I had in mind essentially:

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b191967c9c1e4..9c38c47581e75 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -515,11 +515,21 @@ enum pmc_type {
 	KVM_PMC_FIXED,
 };
 
+#define KVM_PMC_DISABLE_FILTERED	BIT(0)
+#define KVM_PMC_DISABLE_NESTED		BIT(1)
+
 struct kvm_pmc {
 	enum pmc_type type;
 	u8 idx;
 	bool is_paused;
 	bool intr;
+
+	/*
+	 * Reasons why the PMC should be disabled in eventsel when written to HW
+	 * with the mediated vPMU.
+	 */
+	u8 eventsel_hw_disable_reasons;
+
 	/*
 	 * Base value of the PMC counter, relative to the *consumed* count in
 	 * the associated perf_event.  This value includes counter updates from
@@ -538,7 +548,6 @@ struct kvm_pmc {
 	 */
 	u64 emulated_counter;
 	u64 eventsel;
-	u64 eventsel_hw;
 	struct perf_event *perf_event;
 	struct kvm_vcpu *vcpu;
 	/*
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7b2b4ce6bdad9..5128858610d83 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -536,10 +536,9 @@ static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
 	if (pmc_is_gp(pmc)) {
-		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-		if (allowed)
-			pmc->eventsel_hw |= pmc->eventsel &
-					    ARCH_PERFMON_EVENTSEL_ENABLE;
+		pmc->eventsel_hw_disable_reasons &= ~KVM_PMC_DISABLE_FILTERED;
+		if (!allowed)
+			pmc->eventsel_hw_disable_reasons |= KVM_PMC_DISABLE_FILTERED;
 	} else {
 		u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
 
@@ -630,7 +629,7 @@ void kvm_pmu_recalc_pmc_emulation(struct kvm_pmu *pmu, struct kvm_pmc *pmc)
 	 * omitting a PMC from a bitmap could result in a missed event if the
 	 * filter is changed to allow counting the event.
 	 */
-	if (!pmc_is_locally_enabled(pmc))
+	if (!pmc_is_locally_enabled(pmc) || pmc_is_nested_disabled(pmc))
 		return;
 
 	if (pmc_is_event_match(pmc, kvm_pmu_eventsel.INSTRUCTIONS_RETIRED))
@@ -944,7 +943,7 @@ static void kvm_pmu_reset(struct kvm_vcpu *vcpu)
 
 		if (pmc_is_gp(pmc)) {
 			pmc->eventsel = 0;
-			pmc->eventsel_hw = 0;
+			pmc->eventsel_hw_disable_reasons = 0;
 		}
 	}
 
@@ -1313,6 +1312,19 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
 	return kvm_pmu_ops.GP_EVENTSEL_BASE + idx * kvm_pmu_ops.MSR_STRIDE;
 }
 
+static __always_inline u64 gp_calc_eventsel_hw(struct kvm_pmc *pmc)
+{
+	u64 eventsel = pmc->eventsel;
+
+	if (pmc->eventsel_hw_disable_reasons)
+		eventsel &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+
+	eventsel |= kvm_pmu_ops.GP_EVENTSEL_ALWAYS_SET;
+	eventsel &= ~kvm_pmu_ops.GP_EVENTSEL_ALWAYS_CLR;
+
+	return eventsel;
+}
+
 static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -1329,7 +1341,7 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 
 		if (pmc->counter != rdpmc(i))
 			wrmsrl(gp_counter_msr(i), pmc->counter);
-		wrmsrl(gp_eventsel_msr(i), pmc->eventsel_hw);
+		wrmsrl(gp_eventsel_msr(i), gp_calc_eventsel_hw(pmc));
 	}
 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
 		pmc = &pmu->fixed_counters[i];
@@ -1387,7 +1399,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 		pmc->counter = rdpmc(i);
 		if (pmc->counter)
 			wrmsrq(gp_counter_msr(i), 0);
-		if (pmc->eventsel_hw)
+		if (gp_calc_eventsel_hw(pmc))
 			wrmsrq(gp_eventsel_msr(i), 0);
 	}
 
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 4a9148cf779df..fcfce6a213aef 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -52,6 +52,9 @@ struct kvm_pmu_ops {
 	const u32 GP_COUNTER_BASE;
 	const u32 FIXED_COUNTER_BASE;
 	const u32 MSR_STRIDE;
+
+	const u64 GP_EVENTSEL_ALWAYS_SET;
+	const u64 GP_EVENTSEL_ALWAYS_CLR;
 };
 
 extern bool enable_pmu;
@@ -197,6 +200,11 @@ static inline bool pmc_is_locally_enabled(struct kvm_pmc *pmc)
 	return pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE;
 }
 
+static inline bool pmc_is_nested_disabled(struct kvm_pmc *pmc)
+{
+	return pmc->eventsel_hw_disable_reasons & KVM_PMC_DISABLE_NESTED;
+}
+
 extern struct x86_pmu_capability kvm_pmu_cap;
 
 void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops);
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index b12c35b4fccbf..2ac00e729d04b 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -166,8 +166,6 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		data &= ~pmu->reserved_bits;
 		if (data != pmc->eventsel) {
 			pmc->eventsel = data;
-			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
-					   AMD64_EVENTSEL_GUESTONLY;
 			kvm_pmu_request_counter_reprogram(pmc);
 		}
 		return 0;
@@ -270,6 +268,8 @@ static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *vcpu,
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u64 host_guest_bits;
 
+	pmc->eventsel_hw_disable_reasons &= ~KVM_PMC_DISABLE_NESTED;
+
 	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
 		return;
 
@@ -296,7 +296,7 @@ static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_vcpu *vcpu,
 			return;
 	}
 
-	pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
+	pmc->eventsel_hw_disable_reasons |= KVM_PMC_DISABLE_NESTED;
 }
 
 static void amd_pmu_reprogram_counters(struct kvm_vcpu *vcpu, u64 counters)
@@ -336,4 +336,7 @@ struct kvm_pmu_ops amd_pmu_ops __initdata = {
 	.GP_COUNTER_BASE = MSR_F15H_PERF_CTR0,
 	.FIXED_COUNTER_BASE = 0,
 	.MSR_STRIDE = 2,
+
+	.GP_EVENTSEL_ALWAYS_SET = AMD64_EVENTSEL_GUESTONLY,
+	.GP_EVENTSEL_ALWAYS_CLR = AMD64_EVENTSEL_HOSTONLY,
 };
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 9bd77843d8da2..05b68f40f189e 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -431,7 +431,6 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 			if (data != pmc->eventsel) {
 				pmc->eventsel = data;
-				pmc->eventsel_hw = data;
 				kvm_pmu_request_counter_reprogram(pmc);
 			}
 			break;

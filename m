Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258780;
	b=m0jdt/d7lDm+uFmo+E5FzSONZ+OfqKF69xt33RZ/Y3NQN2YWxUuXRoOTdwYNeFBT+9aH
	 Mou1UXMSQ6JV1TLHH60qDX0pJPTZZR7As5fEaZYaH+3Rvs+WISx5lz12+QDstIPRB580E
	 NWwrEBIOUKoOX9/cvEHUUS/tmot5nJ+GcX89vxQnqlU8VryIEk+3r8Nr9XpBcHevn0vYL
	 VzuZM1TSFUrrFzyscgJrG7SW5AhfTizEt/g30JKBUc64gaR/0oGzuxz9jFT2i1+FIGoUS
	 iUpkUkagvhf6LvA0HaujG36pdnR+yZ/bAWPZsX8b5jb1VYGpEZZWGN4Lt3tVbyeY+5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258780;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wSH/DQOT88tW+MfhVryjWdaFHOf/OVH5pZJUhCRAHp8=;
	b=tOAurBsSwXjldRLSQye6RoMMncS2mfGoCrGwDpsgQjb8RLrrSWeYhYK9hRWwRo0WH/8r
	 +Pqn2srtCP3quZNrC5RR8DoAwYdKshOp9NedG5yunU09EdtR3xks6A2IVLqzb6KPOzxGZ
	 mhNgAFccW/9BuyIc0VumBz4xNffcilEc3JONfrrRlzi4NGdhJTnK+2ZE7m+ciegUXca8g
	 toF3dFcZ4MJBMDzJCqBdBB2qNLl4ha+MpxAwnpUMbuTkcYOfIyLkVUYvsUTqtAHvQVyEY
	 qlshhA/AfEz4BWa7IUcXABj98r+JceC/CbD/VIG/vghtRr3erstBmlY5aqxF/uaCbXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsxNcMeD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99267606A31C;
	Mon,  9 Nov 2026 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsxNcMeD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B551F0089F;
	Mon,  9 Nov 2026 21:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258780;
	bh=wSH/DQOT88tW+MfhVryjWdaFHOf/OVH5pZJUhCRAHp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FsxNcMeDM08/3I4TV1/3pivquZehCEemjIhTRYxFaI6kxFeDB1UYwsQL3J6bwTuJ6
	 TpKBKs9yTNmSHzEI2yN4hIpI/+8MbXqrblu3GMGWfmUY0l5+m6OIZfNL6b9jQRw4Ur
	 yQte2W8uUBh36JH9Bizy/rMO3Z6C2NbJ1TtLn7BR2WCuSi2p7kAfIjqawLSohhvlSU
	 j/mcvfF1kbDx6by1zEq5LcHbYQSwRIRnluQFM2HsWvuyNneixFMkgIyY6uGzk1LtmK
	 ysl/YPcmYpJaHxlCYAuvZZGMAuZhtEguVU50UjC9gaVrPbhNxanCW8oqJlyg0aI+3W
	 cqZSR7IOKKZcw==
Date: Mon, 9 Nov 2026 21:12:58 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
Message-ID: <avI20tEzyvIshy2f@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com>
 <au4kyULjUYdqbfIq@google.com>
 <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
 <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
 <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
 <c2844568-f8f6-450e-a718-1e9e3b7b3e4b@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2844568-f8f6-450e-a718-1e9e3b7b3e4b@intel.com>

On Mon, Nov 09, 2026 at 12:59:01PM -0600, Chen, Zide wrote:
> 
> 
> On 11/9/2026 12:07 PM, Yosry Ahmed wrote:
> >>>>>> +/*
> >>>>>> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
> >>>>>> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
> >>>>>> + * so iteration up to KVM's maximum counter count is safe.
> >>>>>> + */
> >>>>>> +#define kvm_for_each_gp_counter(i, mask)    \
> >>>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> >>>>>> +
> >>>>>> +#define kvm_for_each_fixed_counter(i, mask) \
> >>>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> >>>>>
> >>>>> These are not used in this patch, are they?
> >>>>>
> >>>>> They should probably be introduced when they are used. Also, do we
> >>>>> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
> >>>>> yes, maybe we should pass in the pmu here instead?
> >>>>
> >>>> The intent was to group all bitmap accessor helpers together in this
> >>>> patch for easier review so that the big patch 5/18 could be kept to
> >>>> mostly mechanical replacements.
> >>>>
> >>>> But if you prefer introducing them on first use, I'll move their
> >>>> definitions to patch 5.
> >>>
> >>> Yeah I think it's clearer to see what their definitions are with their usage.
> >>
> >> OK, then I can move these two macros to the next patch.
> >>>>
> >>>> Regarding passing 'pmu' directly, I initially implemented it in this
> >>>> way, but I can't recall why I discarded it. I will take another look.
> >>>
> >>> Thanks.
> >>
> >> How about these? With them, we can remove the {gp,fixed}_mask variables
> >> that you pointed out in your review of 5/18. The APIs are more
> >> complicated, but the caller code is much cleaner.
> > 
> > I don't understand why we can't keep the macros as-is, but just move the
> > calls to kvm_gp_pmc_mask() and kvm_fixed_pmc_mask() inside the macros?
> 
> for_each_set_bit() requires a pointer (`const unsigned long *`) as
> input, but AFAICT a loop macro cannot declare a temporary local
> variable, nor it can use do { ... } while(0). So something like:
> 
> #define kvm_for_each_gp_counter(i, pmu)                              \
>         unsigned long gp_mask = kvm_gp_pmc_mask(pmu);                   \
>         for_each_set_bit((i), &(gp_mask), KVM_MAX_NR_GP_COUNTERS)
> 

Gemini suggested compount literals, and it seems to at least compile and
I see a few instances around the kernel:

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index f949fdbf359c6..3930680937577 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1347,8 +1347,6 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
 static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
-	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	struct kvm_pmc *pmc;
 	u32 i;
 
@@ -1357,14 +1355,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
 	 * is intercepted if hardware has counters that aren't visible to the
 	 * guest (KVM will inject #GP as appropriate).
 	 */
-	kvm_for_each_gp_counter(i, gp_mask) {
+	kvm_for_each_gp_counter(i, pmu) {
 		pmc = &pmu->gp_counters[i];
 
 		if (pmc->counter != rdpmc(i))
 			wrmsrq(gp_counter_msr(i), pmc->counter);
 		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
 	}
-	kvm_for_each_fixed_counter(i, fixed_mask) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		pmc = &pmu->fixed_counters[i];
 
 		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
@@ -1407,8 +1405,6 @@ void kvm_mediated_pmu_load(struct kvm_vcpu *vcpu)
 static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
-	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	struct kvm_pmc *pmc;
 	u32 i;
 
@@ -1416,7 +1412,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 	 * Clear selectors and counters to ensure hardware doesn't count using
 	 * guest controls when the host (perf) restores its state.
 	 */
-	kvm_for_each_gp_counter(i, gp_mask) {
+	kvm_for_each_gp_counter(i, pmu) {
 		pmc = &pmu->gp_counters[i];
 
 		pmc->counter = rdpmc(i);
@@ -1426,7 +1422,7 @@ static void kvm_pmu_put_guest_pmcs(struct kvm_vcpu *vcpu)
 			wrmsrq(gp_eventsel_msr(i), 0);
 	}
 
-	kvm_for_each_fixed_counter(i, fixed_mask) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		pmc = &pmu->fixed_counters[i];
 
 		pmc->counter = rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i);
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 98e6f2443b82e..37a6664fdb9c9 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -149,11 +149,11 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
  * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
  * so iteration up to KVM's maximum counter count is safe.
  */
-#define kvm_for_each_gp_counter(i, mask)	\
-	for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
+#define kvm_for_each_gp_counter(i, pmu)	\
+	for_each_set_bit((i), &(unsigned long){ kvm_gp_pmc_mask(pmu) }, KVM_MAX_NR_GP_COUNTERS)
 
-#define kvm_for_each_fixed_counter(i, mask)	\
-	for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
+#define kvm_for_each_fixed_counter(i, pmu)	\
+	for_each_set_bit((i), &(unsigned long){ kvm_fixed_pmc_mask(pmu) }, KVM_MAX_NR_FIXED_COUNTERS)
 
 static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
 {
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6dade9d26d1ad..9b25590469712 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -704,8 +704,6 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
-	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	int i;
 
 	/*
@@ -715,12 +713,12 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
 	if (!kvm_vcpu_has_mediated_pmu(vcpu))
 		return;
 
-	kvm_for_each_gp_counter(i, gp_mask) {
+	kvm_for_each_gp_counter(i, pmu) {
 		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PERFCTR0 + i);
 		nested_vmx_merge_msr_bitmaps_rw(MSR_IA32_PMC0 + i);
 	}
 
-	kvm_for_each_fixed_counter(i, fixed_mask)
+	kvm_for_each_fixed_counter(i, pmu)
 		nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_FIXED_CTR0 + i);
 
 	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 961d16e7f31f5..d3a00ae8018eb 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -57,11 +57,10 @@ static struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
 
 static u64 intel_pmu_fixed_ctrl_bits(struct kvm_pmu *pmu, u64 bits)
 {
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
 	u64 fixed_ctrl_bits = 0;
 	int i;
 
-	kvm_for_each_fixed_counter(i, fixed_mask)
+	kvm_for_each_fixed_counter(i, pmu)
 		fixed_ctrl_bits |= intel_fixed_bits_by_idx(i, bits);
 
 	return fixed_ctrl_bits;
@@ -85,13 +84,12 @@ static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 	 * hardware, e.g. to ensure the event filter is enforced.
 	 */
 	u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw;
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
 	struct kvm_pmc *pmc;
 	int i;
 
 	pmu->fixed_ctr_ctrl = data;
 	pmu->fixed_ctr_ctrl_hw = data & ~intel_pmu_fixed_anythread_mask(pmu);
-	kvm_for_each_fixed_counter(i, fixed_mask) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		u8 new_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl_hw, i);
 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
 
@@ -369,21 +367,19 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
 static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
-	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
 	bool pmi_inuse = false;
 	u64 eventsel, data = 0;
 	u32 fixed_ctrl;
 	int i;
 
-	kvm_for_each_gp_counter(i, gp_mask) {
+	kvm_for_each_gp_counter(i, pmu) {
 		eventsel = pmu->gp_counters[i].eventsel;
 
 		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
 			data |= BIT_ULL(i);
 		pmi_inuse |= !!(eventsel & ARCH_PERFMON_EVENTSEL_INT);
 	}
-	kvm_for_each_fixed_counter(i, fixed_mask) {
+	kvm_for_each_fixed_counter(i, pmu) {
 		fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
 
 		if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))

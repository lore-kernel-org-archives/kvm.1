Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3624E4C3;
	Thu, 23 Jul 2026 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784850261; cv=none; b=kcrRRsaCJ1CFnERQRXrIuVqmViE2jyHQZUPDV9JY9/MF6GniW8vruZxGa+R7lk/8e2JGFwkzmJgihRiiHedGN0MbfVkay1c6c1L76bShseuHtVONPNTy7/2WI4C7uVHs9bTVYGRYSa/KN11Jkv+D5HgvOZ+7fsQKOQF4cfp+cDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784850261; c=relaxed/simple;
	bh=9TyjDA+TRbVory6/xhWjTsF9jQv109yb5lIhnTw4czI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cowEZh9I8RC0dgcMtPavvmeEa59FcH89uGPWykOR4PlFQ29UfuF05wx3fU+/NuG6Hbwco+HFCOHhFpDeh3743Yhlx53OM9xOcSZPzX64MLK+OKkHoEwP+P49ImNeJGrMyQKXUw4/MHTe1zWdeYt5kcVx/Gr/h06QiSeMDidEgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZIeSqmn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZIeSqmn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784850259; x=1816386259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9TyjDA+TRbVory6/xhWjTsF9jQv109yb5lIhnTw4czI=;
  b=MZIeSqmnj1stXrOYeptgqWbMWYy7Y7jd8FavMNgRcpLDxP6n3prUrCWb
   hl9tvFOKiwg1/TLAy2FzZAYkSTjT3zkWCnvlIPZiWH5NTqNlTJth0DowC
   HsQQPNg0vqcUE7bx8hZB87JX+NEW44jslYU+xpQI7mlN1st5Mc4Ca5GDo
   b67Za7BZD1JL++sdRhSttprR0iJtag7yOgNqLetqAHTugwIJ50ofBhRyS
   XrL3wwz4RAW+Q7hEpLZQYJPpVzrC6IzjuMt0+d503pjoC2JQt60PZr6/E
   jpq3U3+Bar6CzJdqYnb1n+PoH0ZamvGwlylrze+SXWw/ORsEpXBO723Bz
   Q==;
X-CSE-ConnectionGUID: qIvA01dbTKestLPhQu6BRg==
X-CSE-MsgGUID: C1vOhAUoQrOf6Rg9jhTywQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="97030831"
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="97030831"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 16:44:19 -0700
X-CSE-ConnectionGUID: sl5HcrBfQtimi7ndhtU6VA==
X-CSE-MsgGUID: Yf5bBvynQjq3RnX7SbZMbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,181,1779174000"; 
   d="scan'208";a="256779708"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 16:44:17 -0700
Message-ID: <6fa18abe-4cb0-42e5-88f6-880a9ecaf769@intel.com>
Date: Thu, 23 Jul 2026 18:44:16 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/8] KVM: x86/pmu: Support PERF_METRICS MSR in mediated
 vPMU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-6-zide.chen@intel.com>
 <CALMp9eQv3Z8w2UoxDFMyb-zpSAD7RpL6Bzc9kfk=oGpDF7VySA@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eQv3Z8w2UoxDFMyb-zpSAD7RpL6Bzc9kfk=oGpDF7VySA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2026 12:59 PM, Jim Mattson wrote:
> On Mon, Jun 29, 2026 at 4:28 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Bit 15 in IA32_PERF_CAPABILITIES indicates that the CPU provides
>> built-in support for Topdown Microarchitecture Analysis (TMA) L1
>> metrics via the IA32_PERF_METRICS MSR.
>>
>> Expose this capability only when mediated vPMU is enabled, as emulating
>> IA32_PERF_METRICS in the legacy vPMU model is impractical.
>>
>> Pass IA32_PERF_METRICS through to the guest only when mediated vPMU is
>> enabled and bit 15 is set in guest IA32_PERF_CAPABILITIES.  Allow
>> kvm_pmu_{get,set}_msr() to handle this MSR for host accesses.
>>
>> Save and restore this MSR on host/guest PMU context switches so that
>> host PMU activity does not clobber the guest value, and guest state
>> is not leaked into the host.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v5:
>> - Remove host_initiated check in set/get MSR handlers.
>> v4:
>> - Remove WARN_ON_ONCE() and simply reject the guest accesses by checking
>>   host_initiated. (Sashiko)
>> - Passthru MSR_PERF_METRICS only if has_mediated_pmu is true. (Sashiko)
>> - Remove the redundant !! in vcpu_has_perf_metrics().
>> v3:
>> - Replace WARN_ON() with WARN_ON_ONCE(). (Dapeng)
>> - Add comments to explain why we don't validate writes on PERF_METRICS.
>> ---
>>  arch/x86/include/asm/kvm_host.h   |  1 +
>>  arch/x86/include/asm/msr-index.h  |  1 +
>>  arch/x86/include/asm/perf_event.h |  1 +
>>  arch/x86/kvm/msrs.c               |  6 +++++-
>>  arch/x86/kvm/pmu.h                |  5 +++++
>>  arch/x86/kvm/vmx/pmu_intel.c      | 31 +++++++++++++++++++++++++++++++
>>  arch/x86/kvm/vmx/vmx.c            |  7 +++++++
>>  7 files changed, 51 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 80f638588bf7..96376d8a5199 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -630,6 +630,7 @@ struct kvm_pmu {
>>         u64 global_status_rsvd;
>>         u64 reserved_bits;
>>         u64 raw_event_mask;
>> +       u64 perf_metrics;
>>         struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>>         struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 18c4be75e927..fdcaeb6c8352 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -331,6 +331,7 @@
>>  #define PERF_CAP_PEBS_FORMAT           0xf00
>>  #define PERF_CAP_FW_WRITES             BIT_ULL(13)
>>  #define PERF_CAP_PEBS_BASELINE         BIT_ULL(14)
>> +#define PERF_CAP_PERF_METRICS          BIT_ULL(15)
>>  #define PERF_CAP_PEBS_TIMING_INFO      BIT_ULL(17)
>>  #define PERF_CAP_PEBS_MASK             (PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
>>                                          PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE | \
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 1eb13673e889..bc2e1cbcd9b9 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -447,6 +447,7 @@ static inline bool is_topdown_idx(int idx)
>>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT  54
>>  #define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD      BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
>>  #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT     48
>> +#define GLOBAL_STATUS_PERF_METRICS_OVF         BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)
>>
>>  #define GLOBAL_CTRL_EN_PERF_METRICS            BIT_ULL(48)
>>  /*
>> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
>> index 3bf42d90ad14..c751a8dbd45d 100644
>> --- a/arch/x86/kvm/msrs.c
>> +++ b/arch/x86/kvm/msrs.c
>> @@ -230,7 +230,7 @@ static const u32 msrs_to_save_pmu[] = {
>>         MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>>         MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>>         MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
>> -       MSR_CORE_PERF_GLOBAL_CTRL,
>> +       MSR_CORE_PERF_GLOBAL_CTRL, MSR_PERF_METRICS,
>>         MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>>
>>         /* This part of MSRs should match KVM_MAX_NR_INTEL_GP_COUNTERS. */
>> @@ -2625,6 +2625,10 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>>                      intel_pt_validate_hw_cap(PT_CAP_num_address_ranges) * 2))
>>                         return;
>>                 break;
>> +       case MSR_PERF_METRICS:
>> +               if (!(kvm_caps.supported_perf_cap & PERF_CAP_PERF_METRICS))
>> +                       return;
>> +               break;
>>         case MSR_ARCH_PERFMON_PERFCTR0 ...
>>              MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>>                 if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index 1b2f66a2e915..3066cade5790 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -279,6 +279,11 @@ static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
>>         return vcpu->arch.perf_capabilities;
>>  }
>>
>> +static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
>> +{
>> +       return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
>> +}
>> +
>>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
>>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
>>  int kvm_pmu_check_rdpmc_early(struct kvm_vcpu *vcpu, unsigned int idx);
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index e426ddc8add4..225afd3937c3 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -188,6 +188,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>         switch (msr) {
>>         case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>                 return kvm_pmu_has_perf_global_ctrl(pmu);
>> +       case MSR_PERF_METRICS:
>> +               return kvm_vcpu_has_perf_metrics(vcpu);
>>         case MSR_IA32_PEBS_ENABLE:
>>                 ret = kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PEBS_FORMAT;
>>                 break;
>> @@ -345,6 +347,9 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>         case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>                 msr_info->data = pmu->fixed_ctr_ctrl;
>>                 break;
>> +       case MSR_PERF_METRICS:
>> +               msr_info->data = pmu->perf_metrics;
>> +               break;
>>         case MSR_IA32_PEBS_ENABLE:
>>                 msr_info->data = pmu->pebs_enable;
>>                 break;
>> @@ -394,6 +399,15 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>                 if (pmu->fixed_ctr_ctrl != data)
>>                         reprogram_fixed_counters(pmu, data);
>>                 break;
>> +       case MSR_PERF_METRICS:
>> +               /*
>> +                * On platforms that support only hardware level-1, bits [63:32]
>> +                * are reserved and ignored by hardware. If hardware level-2 is also
>> +                * supported, they may contain valid metric data.
>> +                * Either way, guest writes are passed through verbatim.
>> +                */
>> +               pmu->perf_metrics = data;
>> +               break;
>>         case MSR_IA32_PEBS_ENABLE:
>>                 if (data & pmu->pebs_enable_rsvd)
>>                         return 1;
>> @@ -589,6 +603,11 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>                 pmu->global_status_rsvd &=
>>                                 ~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
>>
>> +       if (perf_capabilities & PERF_CAP_PERF_METRICS) {
>> +               pmu->global_ctrl_rsvd &= ~GLOBAL_CTRL_EN_PERF_METRICS;
>> +               pmu->global_status_rsvd &= ~GLOBAL_STATUS_PERF_METRICS_OVF;
>> +       }
>> +
>>         if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>>                 if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
>>                         pmu->pebs_enable_rsvd = counter_rsvd;
>> @@ -632,6 +651,9 @@ static void intel_pmu_init(struct kvm_vcpu *vcpu)
>>
>>  static void intel_pmu_reset(struct kvm_vcpu *vcpu)
>>  {
>> +       struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +
>> +       pmu->perf_metrics = 0;
>>         intel_pmu_release_guest_lbr_event(vcpu);
>>  }
>>
>> @@ -803,6 +825,9 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>         u64 global_status, toggle;
>>
>> +       if (kvm_vcpu_has_perf_metrics(vcpu))
>> +               wrmsrq(MSR_PERF_METRICS, pmu->perf_metrics);
>> +
> 
> Our internal Sashiko asks:
> 
> Does this write to MSR_PERF_METRICS violate the architectural requirement to
> write IA32_FIXED_CTR3 first?
> According to the Intel SDM, software must write to IA32_FIXED_CTR3 before
> writing to IA32_PERF_METRICS to properly clear the TMA internal state machine.
> During VM-entry, kvm_pmu_load_guest_pmcs() is called before
> intel_mediated_pmu_load() to load the fixed counters. However, it
> conditionally skips the write if the guest's counter value matches the host
> hardware's current value:
> kvm_pmu_load_guest_pmcs() {
>     ...
>     if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
>         wrmsrq(fixed_counter_msr(i), pmc->counter);
>     ...
> }
> If skipped, KVM will unconditionally write to MSR_PERF_METRICS here in
> intel_mediated_pmu_load() without a preceding write to IA32_FIXED_CTR3. Could
> this omission fail to reset the TMA state machine and potentially break
> TMA metrics?

IA32_PERF_GLOBAL_CTRL is already cleared before either fixed counter 3
or MSR_PERF_METRICS is restored.

The SDM does not appear to require an explicit WRMSR to fixed counter 3.
If the write is skipped, the hardware already contains the guest's fixed
counter 3 value.


>>         rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
>>         toggle = pmu->global_status ^ global_status;
>>         if (global_status & toggle)
>> @@ -831,6 +856,12 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>>          */
>>         if (pmu->fixed_ctr_ctrl_hw)
>>                 wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
>> +
>> +       if (kvm_vcpu_has_perf_metrics(vcpu)) {
>> +               pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);
>> +               if (pmu->perf_metrics)
>> +                       wrmsrq(MSR_PERF_METRICS, 0);
> 
> And here:
> 
> Will clearing MSR_PERF_METRICS here occur before clearing
> MSR_CORE_PERF_FIXED_CTR3, reversing the architecturally mandated write order?
> In KVM's mediated PMU context switch out (VM-exit), kvm_mediated_pmu_put()
> calls the mediated_put callback before clearing the guest PMCs:
> kvm_mediated_pmu_put() {
>     ...
>     kvm_pmu_call(mediated_put)(vcpu);
>     kvm_pmu_put_guest_pmcs(vcpu);
>     ...
> }
> This means intel_mediated_pmu_put() writes 0 to MSR_PERF_METRICS here, and
> then kvm_pmu_put_guest_pmcs() conditionally writes 0 to
> MSR_CORE_PERF_FIXED_CTR3 later. Additionally, if the fixed counter is already
> 0, the write to FIXED_CTR3 is skipped entirely.
> Could this write to MSR_PERF_METRICS without a preceding initialization of
> FIXED_CTR3 corrupt the hardware state machine or cause undefined behavior?

Similarly, IA32_PERF_GLOBAL_CTRL is already cleared at this point, so
both EN_FIXED_CTR3 and EN_PERF_METRICS have already been disabled.

The SDM guidance that "fixed counter 3 must be restored before
PERF_METRICS" appears to apply only to a running PMU, which is not the
case here.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793295938;
	b=gZE6qIlywUGsHtF0BbEvG9HI9OTnPUdtQuy5HeLV3QOa+u1LuSVE/bokGXjhdoGZCM0x
	 XA4lBBmIFFh9oLS/sDD+mRr+hpFHCRM2KWh7oHEfgVwu9jFNv/JE0hrxyP1FcZL+ozcDd
	 y3CbOTAoLVJFHABJNaLymcBr86gw/WjymOaKVa16UteyDEUhkwdS8GYvkHL2WeIwtECtg
	 HGVSv8Cka/nClArD+fIsP6xE8ij96+LxoEiuLYroG7xVnRIHsQot1aQjUceDeMf72wxzj
	 h/4bwpVQwOOz3x1UnFmn9tc/AZKd2VtSGmU9TWFJotJI8zsDz06jfmvSrChlUqDcjpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295938;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=h+wDw9ZEB7NUHefnTxZdKCC5Sj/+uXPkrr8WyE9br6M=;
	b=zU1hqnOKw0BCpEMzFS4dfBStqp/Vj6/2kpUVrnVcMYbTtw2QhLXLyk6Wa/bGmPpLPI4y
	 UOAn/ccddg7adaqb2g0pHMNNg+fEEUl2YbBSpi59/uPUljdK94/slfn+NP1xQ2/w3G3Os
	 0wVYADvXlgjJZrBUgLRlBr7Ote1o9sHtwsF/R3Lp6isZqe1cjw+e/XY/AMvjUf9FD1/J9
	 sIWYNj+rLHA7Hr+f+9fpvFDAURXM8QS7vofICLmz0fby5HXKt8NeN590S5iATw+vYWUw6
	 URrAiVkZbqBn5OFrEax0WjU5TI8hWxbEeO7Xj+wPDFD91KFLdXL458VBpX5g8a9RgXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MPAKLR4i;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F9B606A31A;
	Thu, 29 Oct 2026 17:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49F9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MPAKLR4i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793295936; x=1824831936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1qaFPKbR9zaLKxFmrtdcDnANlP7YBWgOS5i+ZcE7ORE=;
  b=MPAKLR4ijstTfuc4eP16FPQgghUvProkeoZmJk7+Xax2DvVG9fuI0rxX
   re2D61CtzLapdq2BjRJhUjOeZ54Z32i9v5yYQ5zpM56/2BqbNur/e/xN9
   YT3VNHmBnd5WA319OlS8cNt2aNt9CsmEUzsF3RbYN7K39PehIBZS8Qm09
   bLxFoe21yD9LH+44Vr835KnS+z2g8+RKHSVoTCNqiSEPEVgs+5082lZ5+
   CIU1LDx3++K9cKP93IWPZY+MkeKDzFakU3IEIRUgXoIQuIjhsDdcBhmEv
   0BBQf17OZyCS12+affmAGE2gDa4a4aeI4z3faPwKDlmQNPkMj8/mwJV6C
   Q==;
X-CSE-ConnectionGUID: l1hJEpcFS2mNl99npzG/QA==
X-CSE-MsgGUID: XCZAb3fPReqfl0XsPYC9Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1932218"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1932218"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 10:45:35 -0700
X-CSE-ConnectionGUID: 9Qr11LDjTPCENXFS65Rdgg==
X-CSE-MsgGUID: YVwQ5kSpSP6Ww0Tx9ZdWjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5093726"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 10:45:33 -0700
Message-ID: <b3dcb403-ec19-4d23-9bab-336e2eb344bd@intel.com>
Date: Thu, 29 Oct 2026 12:45:32 -0500
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 4:24 PM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> Intel PerfMon v4 introduces IA32_PERF_GLOBAL_STATUS_SET (0x391) to
>> allow software to set individual bits in the global status MSR. Reads
>> of IA32_PERF_GLOBAL_STATUS_SET always return zero.
>>
>> IA32_PERF_GLOBAL_INUSE (0x392) is also introduced in v4, to track
>> which counters and the PMI are currently claimed by other agents,
>> allowing independent software agents to check counter availability
>> without a shared scheduler arbitrating between them.
>>
>> IA32_PERF_GLOBAL_INUSE is an read-only MSR, and any write attempt
>> results in a #GP.
>>
>> Neither MSR is part of the VM state, so they don't need to be
>> advertised to userspace, nor saved and restored during live
>> migration.
>>
>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2:
>> - Change intel_pmu_get_global_inuse() to return u64, to match the
>>   surrounding code style.
>> - Add the missing vmcs02 updates for these two MSRs.
>> - Change "> 3" to ">= 4" to make the "v4-gated" more obvious and match
>>   the existing code style.
>> ---
>>  arch/x86/include/asm/msr-index.h |  4 ++++
>>  arch/x86/kvm/pmu.c               |  9 ++++++++
>>  arch/x86/kvm/vmx/nested.c        |  2 ++
>>  arch/x86/kvm/vmx/pmu_intel.c     | 37 ++++++++++++++++++++++++++++++++
>>  arch/x86/kvm/vmx/vmx.c           |  4 ++++
>>  5 files changed, 56 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 11b99d237e05..0b093cf41edf 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1240,6 +1240,10 @@
>>  #define MSR_CORE_PERF_GLOBAL_CTRL      0x0000038f
>>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL  0x00000390
>>  #define MSR_CORE_PERF_GLOBAL_STATUS_SET        0x00000391
>> +#define MSR_CORE_PERF_GLOBAL_INUSE     0x00000392
>> +
>> +/* Intel IA32_PERF_GLOBAL_INUSE MSR */
>> +#define PERF_GLOBAL_INUSE_PMI_INUSE    BIT_ULL(63)
>>
>>  #define MSR_PERF_METRICS               0x00000329
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 437a7bc49bf8..7c05cf5157bf 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -832,6 +832,8 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>         case MSR_CORE_PERF_GLOBAL_CTRL:
>>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>>                 return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +               return vcpu_to_pmu(vcpu)->version >= 4;
> 
> MSR_CORE_PERF_GLOBAL_STATUS_SET should be handled in pmu_intel.c? It is an
> Intel-specific MSR (note that commit 79a71cc2568f ("KVM: x86/pmu: Move
> Intel specific MSRs to pmu_intel.c") moved all of MSR_CORE_PERF_GLOBAL_*
> into pmu_intel.c).

Right. In v3 (rebased on top of 79a71cc2568f), both MSRs are handled in
pmu_intel.c, so it won't be exposed on AMD.

> Moreover, checking "vcpu_to_pmu(vcpu)->version >= 4" here without checking the
> vendor will expose MSR_CORE_PERF_GLOBAL_STATUS_SET on AMD when AMD's
> pmu->version reaches 4.
> 
>> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>                 msr_info->data = 0;
>>                 break;
>>         default:
>> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>                 if (!msr_info->host_initiated)
>>                         pmu->global_status &= ~data;
>>                 break;
>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +               if (data & pmu->global_status_rsvd)
>> +                       return 1;
>> +               if (!msr_info->host_initiated)
>> +                       pmu->global_status |= data;
>> +               break;
> 
> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"),
> IA32_PERF_GLOBAL_STATUS.CondChgd[bit 63] cannot be set by writing to
> IA32_PERF_GLOBAL_STATUS_SET, because IA32_PERF_GLOBAL_STATUS_SET[bit 63] is
> reserved.  In other words, it is not possible to save/restore
> IA32_PERF_GLOBAL_STATUS when bit 63 is set.
> 
> Because bit 63 is clear in pmu->global_status_rsvd:
> 
> 1. An intercepted guest WRMSR(MSR_CORE_PERF_GLOBAL_STATUS_SET, BIT_ULL(63))
>    succeeds instead of injecting #GP(0) and sets bit 63 in
>    pmu->global_status.
> 2. When bit 63 is set in pmu->global_status (whether it was set by
>    kvm_pmu_set_msr() or by intel_mediated_pmu_put()), the next
>    intel_mediated_pmu_load() will try to write an illegal value to
>    MSR_CORE_PERF_GLOBAL_STATUS_SET. I don't think we get a #GP, because
>    every wrmsr is "safe" these days, but the write will be ignored.

Thank you for the detailed analysis. Seems the following change is
needed if the below proposal is not adopted:

@@ -939,7 +939,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct
msr_data *msr_info)
                        pmu->global_status &= ~data;
                break;
        case MSR_CORE_PERF_GLOBAL_STATUS_SET:
-               if (data & pmu->global_status_rsvd)
+               if (data & (pmu->global_status_rsvd |
GLOBAL_STATUS_COND_CHG)

> OTOH, what about PerfMon v4 bits 58 (GLOBAL_STATUS_LBRS_FROZEN), 59
> (GLOBAL_STATUS_COUNTERS_FROZEN), and 61 (GLOBAL_STATUS_OVF_UNCORE)?  Per
> Intel SDM Vol. 4, Table 2-2, those bits are valid in
> IA32_PERF_GLOBAL_STATUS, IA32_PERF_GLOBAL_STATUS_RESET, and
> IA32_PERF_GLOBAL_STATUS_SET when CPUID.0AH:EAX[7:0] > 3.
> 
> When those MSRs are passed through in mediated mode, the guest can set bits
> 58, 59, or 61 in hardware via IA32_PERF_GLOBAL_STATUS_SET. Leaving those
> bits set in pmu->global_status_rsvd for pmu->version >= 4 will break
> KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) as well as any intercepted guest
> writes to GLOBAL_OVF_CTRL / GLOBAL_STATUS_SET.
> 
> As I pointed out in patch 04/16, we can't pass through the PMU global
> controls unless their reserved bits match hardware.

Totally agree. Then the handling of bit 55 breaks this rule as well.

if (vmx_pt_mode_is_host_guest())
        pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;

Always intercepting GLOBAL_OVF_CTRL and GLOBAL_STATUS_SET can solve this
problem, but it may impair guest performance, especially for nested.

Instead, I'd propal to have separate reserved masks:
- pmu->global_status_rsvd: unchanged, strictly tracking virtualized
guest state and preserving live migration validation.
- pmu->global_status_{clr,set}_rsvd: unmasking all architecturally valid
hardware bits for the corresponding MSRs on v4+.

Any bits allowed by hardware but unvirtualized by KVM are
scrubbed/filtered in intel_mediated_pmu_{put,load}().
> [ ... ]
> 
>> +static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
>> +{
>> +       struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +       unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>> +       unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>> +       bool pmi_inuse = false;
>> +       u64 eventsel, data = 0;
>> +       u32 fixed_ctrl;
>> +       int i;
>> +
>> +       kvm_for_each_gp_counter(i, gp_mask) {
>> +               eventsel = pmu->gp_counters[i].eventsel;
>> +
>> +               if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
>> +                       data |= BIT_ULL(i);
>> +               pmi_inuse |= eventsel & ARCH_PERFMON_EVENTSEL_INT;
>> +       }
>> +       kvm_for_each_fixed_counter(i, fixed_mask) {
>> +               fixed_ctrl = fixed_ctrl_field(pmu->fixed_ctr_ctrl, i);
>> +
>> +               if (fixed_ctrl & (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER))
>> +                       data |= BIT_ULL(KVM_FIXED_PMC_BASE_IDX + i);
>> +               pmi_inuse |= fixed_ctrl & INTEL_FIXED_0_ENABLE_PMI;
>> +       }
>> +       pmi_inuse |= pmu->pebs_enable;
> 
> Nit: I am always complaining about unnecessary use of '!!', but I
> think it is warranted in the two assignments to pmi_inuse above.

True, !! isn't required since pmi_inuse is a bool, but adding it makes
the intent clearer. I'll add it.

> [ ... ]
> 
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index 56daf5c61082..2dabb7e64956 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -4282,6 +4282,10 @@ static void vmx_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>                                   MSR_TYPE_RW, intercept);
>>         vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
>>                                   MSR_TYPE_RW, intercept);
>> +       vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_STATUS_SET,
>> +                                 MSR_TYPE_RW, intercept || pmu->version < 4);
>> +       vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_GLOBAL_INUSE,
>> +                                 MSR_TYPE_RW, intercept || pmu->version < 4);
> 
> When a PMU event filter denies a fixed counter in mediated mode,
> kvm_mediated_pmu_refresh_event_filter() clears the entire 4-bit control
> nybble in pmu->fixed_ctr_ctrl_hw (written to physical IA32_FIXED_CTR_CTRL),
> while pmu->fixed_ctr_ctrl contains the guest-written value.

Good point. Clearing the entire 0xf nibble was overly aggressive and
clobbered non-enable bits (ENABLE_PMI, AnyThread, and METRICS_CLEAR_EN).

But as long as we always intercep the INUSE MSR, then this is irrelevant
here. I can refined kvm_mediated_pmu_refresh_event_filter() to only mask
out bits [1:0] (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER), in the
Topdown patch set.

> If MSR_CORE_PERF_GLOBAL_INUSE is passed through, a guest RDMSR of
> IA32_PERF_GLOBAL_INUSE will see FCx_InUse == 0 (and potentially PMI_InUse
> == 0) from hardware even though RDMSR(IA32_FIXED_CTR_CTRL) reports the
> fixed counter as enabled (and intel_pmu_get_global_inuse() reports it as
> in-use when MSR_CORE_PERF_GLOBAL_INUSE is intercepted).

Agreed.

The architectural purpose of the INUSE MSR is software resource
allocation within the OS, not a physical hardware sensor.

The purpose of KVM_SET_PMU_EVENT_FILTER is to stop hardware counting
while letting the guest believe the event was successfully configured.

Thus, if an event is filtered out, the INUSE MSR should still consider
the counter to be in use. Since kvm_mediated_pmu_refresh_event_filter()
needs to mask out the (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER) bits
anyway, passing through the INUSE MSR fails to reflect this.

So it seems better to always intercept the INUSE MSR.

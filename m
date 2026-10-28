Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228743;
	b=rgqgk58it2jCaeokfHRFwUuOPcGYHDhW7KLpE9G6cz1CYhs0oLdQLHvy8Rp/72W4+8Bp
	 ucVvkolPTRxKCz7NXj3p9R7OaCu4mJgPGDrCPUizI1iygbIIHdb4sEwbNCwrb9T9vtZiH
	 PuotzkupPv+uFO3+tjKhuXg3DAUw63ynXCqrpfZNqm1PxBQfk4Nt8iVj8SJg5+gV0Di9O
	 lYWaBJipiAsUJ5XEz4kesCNW37SKOFhibozRZU0XHEnbAEDUeGyxCERJmmDZxwlHWi6k/
	 LBoYrO11zxcKzvMIpp3kmjcXvvPaKLvTdlWW16C++Mw//xhL/w1hxqrB8mGZLyJcC3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228743;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=suVSzY2WLsNNi/QlNmuXbGKhXaTdt+DarJhzp+o3EiQ=;
	b=SzZvbFbaXPodRwrV0KtfHKW4NfCaD/BhFNqUvqNgdyCoQEGPzFaOnsVWjQ7rDaMxykPR
	 J/6Ok8cIaF3+qckPa75IA7g+U2FG+7B49Zl/TkUedrjoIOyCrInJkS5Vq4UJ7/+io51VU
	 d7E4rx306WGHXAIab+eCxJSXIWlLan5UUEClX3rBjRekRqRoZHyXxC7SB7qT9tfA3bSuA
	 s+au9Ic3kdZ7eM4g/zhbh1dZCEa2ohj315+Wa2t/7p8H/p+D0i13ZX4k2zhZb3LryPEf3
	 Gh2uH0Y8Cjw7PzFx7kRmxVcS8cwwBap8j4iWPDxdHMgN9xKCzbY3OAtWV0iAU1a2Hag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ALmAifdY;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9E8606A31A;
	Wed, 28 Oct 2026 23:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A9E8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ALmAifdY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793228736; x=1824764736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KJFNR0pW7YC9NPV5so4T42k9SYy0Y5VBgbxqpg2In0I=;
  b=ALmAifdYl9lz/Q6KmU/MtmigrgVWw+sHHItKbSNuo1aIRlPCz2chTYjx
   0zzJqNMDnwL06BYPAcrfvbce6vP5Ffs9Al5e1f16doLJ4Ve5sincKKmhw
   Q4wk2X3EjdYxVGi69SdhJ+UXdhlaPnnvvP7b4k7GhMeisC83HR5gn0lxS
   SjdDq0tMacmhUf/DOP74jFA1fW6zw+xWo8XQs5HeGVtL6UVMwKJDmAUHE
   5gtQktEqYxQx0M5JPwnz0qcytPiQnaVvLP1ov4d95yIpmFZSDqAvED9id
   +1738wa95YtS7ggFwsY2bqM8ur6g2cfyXHf2WtjoaRPxPjxzBRyodp/p+
   w==;
X-CSE-ConnectionGUID: 151+3cBrTuSyMaQm7z/gJg==
X-CSE-MsgGUID: +IqYLXr4Tyqb746XYHKUvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1848062"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1848062"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 16:05:34 -0700
X-CSE-ConnectionGUID: PwU4Gh+YTxCzIBmc5EDpCw==
X-CSE-MsgGUID: k6+5y11wQvmDdjDv5QVLrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="6732040"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 16:05:32 -0700
Message-ID: <82af5e57-c4f0-452a-b484-ec9270a960b8@intel.com>
Date: Wed, 28 Oct 2026 18:05:32 -0500
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
Subject: Re: [PATCH v2 14/16] KVM: x86/pmu: Ignore AnyThread bit if
 CPUID.0AH:EDX[15] is set
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-15-zide.chen@intel.com>
 <CALMp9eRypTqSvMUes6PVB8z30EcppLJ3i_votpMnJOawP1c4sA@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eRypTqSvMUes6PVB8z30EcppLJ3i_votpMnJOawP1c4sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 4:50 PM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
>> (CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
>> and that writes to the AnyThread bit in IA32_PERFEVTSELx are ignored.
>>
>> When ANYTHREAD_DEPRECATION is present in the guest CPUID, emulate the
>> architectural behavior and silently ignore writes to the AnyThread bit
>> instead of injecting #GP.
>>
>> Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
>> guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
>> not configured for a PerfMon v5+ guest.
>>
>> Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
>> bit doesn't exist below version 5.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2:
>> - Advertise anythread_deprecated only if kvm_pmu_cap.version >= 5.
>> - Add the missing AnyThr bit handling for IA32_FIXED_CTR_CTRL.
>> - Update the comments to be clearer.
>> ---
>>  arch/x86/kvm/cpuid.c         |  2 +-
>>  arch/x86/kvm/vmx/pmu_intel.c | 19 +++++++++++++++++++
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 63201d4ea4a1..ef208906b3ee 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1542,7 +1542,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>                                             KVM_MAX_NR_FIXED_COUNTERS);
>>                 edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
>>
>> -               if (kvm_pmu_cap.version)
>> +               if (kvm_pmu_cap.version >= 5)
>>                         edx.split.anythread_deprecated = 1;
>>
>>                 entry->eax = eax.full;
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index c7472778137a..599c69dfa6e3 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -446,6 +446,12 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>                 if (data & pmu->fixed_ctr_ctrl_rsvd)
>>                         return 1;
>>
>> +               /*
>> +                * This is to emulate ANYTHREAD_DEPRECATION. Guests without
>> +                * support for it would have had the write rejected by
>> +                * pmu->fixed_ctr_ctrl_rsvd above.
>> +                */
>> +               data &= ~intel_pmu_fixed_ctrl_bits(pmu, INTEL_FIXED_0_ANYTHREAD);
>>                 if (pmu->fixed_ctr_ctrl != data)
>>                         reprogram_fixed_counters(pmu, data);
>>                 break;
>> @@ -494,6 +500,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>                         if (data & eventsel_rsvd)
>>                                 return 1;
>>
>> +                       /* See above comments for MSR_CORE_PERF_FIXED_CTR_CTRL. */
>> +                       data &= ~ARCH_PERFMON_EVENTSEL_ANY;
>>                         if (data != pmc->eventsel) {
>>                                 pmc->eventsel = data;
>>                                 pmc->eventsel_hw = data;
>> @@ -603,6 +611,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>         pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
>>                             kvm_pmu_cap.cntr_mask64;
>>
>> +       /*
>> +        * AnyThread counting is not supported by KVM due to cross-VM
>> +        * information leakage concerns on SMT cores. Therefore, AnyThread
>> +        * remains unavailable for PerfMon v3/v4 guests, where AnyThread
>> +        * deprecation is not enumerated.
>> +        */
>> +       if (pmu->version >= 5 && edx.split.anythread_deprecated) {
>> +               pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
>> +               fixed_enable_bits |= INTEL_FIXED_0_ANYTHREAD;
>> +       }
>> +
> 
> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"), only
> Fixed Counters 0, 1, and 2 have an AnyThread bit (bits 2, 6, and 10 of
> IA32_FIXED_CTR_CTRL). FC3 has never had an AnyThread bit;
> IA32_FIXED_CTR_CTR[bit 14] is reserved in PerfMon v5 and becomes
> METRICS_CLEAR_EN in PerfMon v6. Passing INTEL_FIXED_0_ANYTHREAD to
> intel_pmu_fixed_ctrl_bits() will wrongly clear bit 14 in
> pmu->fixed_ctr_ctrl_rsvd once Fixed Counter 3 is enabled.

Right, the IA32_FIXED_CTR_CTR[bit 14] should be handled differently.
Thanks!
> On hardware with CPUID.0AH:EDX.ANYTHREAD_DEPRECATION[15] = 1, if software
> sets the AnyThread bit in IA32_PERFEVTSELx or IA32_FIXED_CTR_CTRL and then
> reads the MSR back with RDMSR, does hardware return 0 for the AnyThread
> bit, or does it return 1 but otherwise ignore the bit?

It returns 1. That said, the current implementation, which clears the
AnyThread bit in intel_pmu_set_msr(), breaks this behavior.

To make matters more subtle, in the case of an invalid configuration
where ANYTHREAD_DEPRECATION is set in the guest CPUID while deprecation
is not supported by the host (Ice Lake, for instance), it is better for
KVM not to pass the AnyThread bits to the host hardware and expect them
to be ignored by the host.

Is the complete solution to keep the AnyThread bits set in the
guest-visible states (pmc->eventsel and pmu->fixed_ctr_ctrl) for RDMSR
readback, but drop them from the hardware-visible states (their _hw
counterparts)?

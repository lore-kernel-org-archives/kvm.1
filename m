Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6677C43C069;
	Fri, 24 Jul 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784908348; cv=none; b=oyjvrtLQ+gImm2n/FYBNX/XRpZkv98iMCvu2h7/baOkc2u+HxS9yGI1YITxyLdgcLFvnal+Cxrx69zGvHWs4dHrfScsZBZJFKx3qwtFZhnDVhp3zMmt7/lcqPP7AWwQC9ctUfeskBbn/I1EhJphh45qoAxsn6kwozgKEQKg46yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784908348; c=relaxed/simple;
	bh=J06cG4Hynxadt5csjbeVbmx8vI1cpG8WyhDXvp9xqck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlBRsjMxVaOqomuJpo6WTBFl/LOF+//TwWu5HbYxGQ2VA4WQosRy0mILY8ibeVAcFJ7u2cAlQDUjJI64gxLKHcuIXnon/X677Uxr0wL4OqkY715yiKHbyS+4X8IKCLk8Ee3lAepLqP+XyWEUFJRQfnmfoubWBBkNFncXcMKnkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMKww3m3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMKww3m3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784908344; x=1816444344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J06cG4Hynxadt5csjbeVbmx8vI1cpG8WyhDXvp9xqck=;
  b=TMKww3m3K3tSAaka0CGaee02Qz9TsokjqK5802ki0erCCDa3SmzK6Tmt
   IV1jgcZVvcSGK7cc3oXKKsB259t0W21awXhHJaWKN/zS2R90lbl7QK5hX
   bJTtDwoSb682TWztD7vkSa75QkRRqBvGICiQ3X6pzT1tbBoCk0QTpY233
   Z/kRH6h1qnkzCPDF3AET1DLdTj4pQmPCI1QSm6FhGyIt72OHfcnW6kys/
   sOg51SzqJDenof/DdQUGF1jy6AP3W4c6bLJiig5SUOPe+Tn1dWEbh78BE
   5Js2u7L1vM6Sx2PMzKfO0y1exQide90SkBjDMcvCMj0eX+OnDg9v9qXif
   g==;
X-CSE-ConnectionGUID: EVsF2LmnQNCaVvzZyyQ5fg==
X-CSE-MsgGUID: JObJMQC5Shi2aUv0EfKpPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85428846"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85428846"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:52:23 -0700
X-CSE-ConnectionGUID: CiJIa/USSIScPFnjL6nVLw==
X-CSE-MsgGUID: N6z8Y18fTFW8zpJcCFwNvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="254433187"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:52:21 -0700
Message-ID: <5184ad20-37d0-4267-9a34-376fb38848b5@intel.com>
Date: Fri, 24 Jul 2026 10:52:20 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] perf/x86: Remove num_counters_{gp,fixed} from
 x86_pmu_capability
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-10-zide.chen@intel.com>
 <CALMp9eQ7QwV_bmgCCwQuEMu64Qqi0oMAyoH=p=gkt8Z9RLYVTQ@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eQ7QwV_bmgCCwQuEMu64Qqi0oMAyoH=p=gkt8Z9RLYVTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2026 4:49 PM, Jim Mattson wrote:
> On Tue, Jul 7, 2026 at 11:44 AM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Now that KVM has switched to bitmap-based PMU capabilities,
>> num_counters_{gp,fixed} can be removed from x86_pmu_capability.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/core.c            | 2 --
>>  arch/x86/include/asm/perf_event.h | 2 --
>>  2 files changed, 4 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 65349819ba43..5bcd2a48d2b3 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -3132,8 +3132,6 @@ void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
>>          * base PMU holds the correct number of counters for P-cores.
>>          */
>>         cap->version            = x86_pmu.version;
>> -       cap->num_counters_gp    = x86_pmu_num_counters(NULL);
>> -       cap->num_counters_fixed = x86_pmu_num_counters_fixed(NULL);
>>         cap->cntr_mask64        = x86_pmu.cntr_mask64;
>>         cap->fixed_cntr_mask64  = x86_pmu.fixed_cntr_mask64;
>>         cap->bit_width_gp       = cap->cntr_mask64 ? x86_pmu.cntval_bits : 0;
> Our internal Sashiko says:
> 
> This isn't a bug introduced by this patch, but since KVM is switching
> to bitmap-based PMU capabilities here, I noticed an issue with how legacy
> AMD PMU intercepts are calculated in
> arch/x86/kvm/svm/svm.c:svm_recalc_pmu_msr_intercepts():
> /* Legacy counters are always available for AMD CPUs with a PMU. */
> for_each_set_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
> svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>   MSR_TYPE_RW, intercept);
> Does this fail to re-enable intercepts for counters in ~gp_mask up to
> AMD64_NUM_COUNTERS?
> If a guest's CPUID dynamically disables previously enabled legacy counters
> while mediated PMU is active, the intercepts for these counters are skipped.
> Could this leave the guest with unauthorized, direct read/write passthrough
> access to host performance counters?
> The code just below this handles the ~gp_mask case correctly for
> MSR_F15H_PERF_CTR by iterating over host_only_gp_mask:
> host_only_gp_mask = kvm_pmu_cap.cntr_mask64 & ~gp_mask;
> kvm_for_each_set_pmc_idx(i, host_only_gp_mask, AMD_GP)
> svm_enable_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>      MSR_TYPE_RW);
> Would the legacy MSR_K7_PERFCTR0 handling allow a guest-to-host privilege
> escalation and information leak without a similar fix?


Seems this is the same issue raised for patch 8/15:

https://lore.kernel.org/kvm/CALMp9eTYWFvB-ji31Mu=vzJo2HFPL0jZFAiXVGpJx-H8S2mHOw@mail.gmail.com/

It should be addressed by the previously proposed fix:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e9f39c884765..2360865651bc 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -763,6 +763,9 @@ static void svm_recalc_pmu_msr_intercepts(struct
kvm_vcpu *vcpu)
        for_each_set_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
                svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
                                          MSR_TYPE_RW, intercept);
+       for_each_clear_bit_from(i, &gp_mask, AMD64_NUM_COUNTERS)
+               svm_enable_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
+                                            MSR_TYPE_RW);

        intercept |= !guest_cpu_cap_has(vcpu, X86_FEATURE_PERFCTR_CORE);
        kvm_for_each_set_pmc_idx(i, gp_mask, AMD_GP)




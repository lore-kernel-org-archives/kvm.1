Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96F32143D;
	Fri, 24 Jul 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906121; cv=none; b=stNBAJ2HAd6yXfAPvywtC5b2Z3uy5vxUG/Kvuw9oNVx4WilPmnk4eWGAqQjwXz6rnZYIahyHHrbLBH+Q9+oG9RZ6VM61LbbcFzenYwNtYOPX17bcuOKxHnqWR0C4bK4emGm8Ctn+HzkvCFftzJLB+RInDiPsH6wH/Y9RkrKvV/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906121; c=relaxed/simple;
	bh=0BLOh2yiQ3diUQnvH9gcYyLuOerCIiQ8gp0sPWMUfLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+qff9c3StqxhXNEyXSXmw6Hq7Q8s3tKFQc36ouHKfNqsiLBRVo4fyUUz95N5562WADpEAmohVka0i9OiTR7qZlfAl6e51i6fRrZK5D7+bqGeQ7tBZnfmQO8JtlJMaBMpvZKO3u04Iu3xcK4p4DF6/Mx63LrjI3nZI//HGZh3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LhThxUIq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LhThxUIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784906118; x=1816442118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0BLOh2yiQ3diUQnvH9gcYyLuOerCIiQ8gp0sPWMUfLc=;
  b=LhThxUIqbeuQ912j8JhEfdWh08/dztpD8exolv14zxk1KFrKsyOhutx4
   PtdjpDKGeIt8d7AlVKm2D3MBFYw5MPOKG4fk8AZb3iFNqHOEDbqc/TqWO
   Jkq+pxWlMhsZLugbZL+rpqgA8rxij+k91ihVvORMAyABDc3NpMhQkNzO3
   pmQrsNzId0O47gufCRe6Jl8zGLgUmvt6misle33VToIYshOWaVTNzzXWT
   /88kh7Nl6SNFGpELXuO+n7RhjeB0Imq95zWKlCFwkdaHPxg8S9Wz5Z4hK
   xTHYjU2eu1Lrmd62Db24Rgkbxj0Wlq43idRGGwTKcq2w92LxxIh+oy4CA
   w==;
X-CSE-ConnectionGUID: 2Ujfh020QJafso5cG/yK4w==
X-CSE-MsgGUID: bRQi/EhsQOuFqSYs89V5Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85620369"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85620369"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:15:16 -0700
X-CSE-ConnectionGUID: qpY0GJJHQma+ZvCzGYymXA==
X-CSE-MsgGUID: bmjNvZLnSH6RFsnuDZnXpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="256080254"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 08:15:16 -0700
Message-ID: <65026581-daf9-45b5-8104-a4845544ebe7@intel.com>
Date: Fri, 24 Jul 2026 10:15:15 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-9-zide.chen@intel.com>
 <CALMp9eTYWFvB-ji31Mu=vzJo2HFPL0jZFAiXVGpJx-H8S2mHOw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTYWFvB-ji31Mu=vzJo2HFPL0jZFAiXVGpJx-H8S2mHOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/23/2026 4:47 PM, Jim Mattson wrote:
> On Tue, Jul 7, 2026 at 11:44 AM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Intel platforms support non-contiguous fixed counters via CPUID.0AH:ECX
>> starting with PerfMon v5, and support non-contiguous GP counters
>> through the Architectural PerfMon Extension (CPUID leaf 23H).
>>
>> struct x86_pmu_capability now exposes {,fixed_}cntr_mask64 bitmaps,
>> which may contain sparse bits representing non-contiguous counters.
>> Switch KVM's kvm_host_pmu and kvm_pmu_cap consumers over to the new
>> bitmask fields.
>>
>> CPUID.0AH:EAX[15:8] and CPUID.0AH:EDX[4:0] enumerate only contiguous
>> counters. Derive these values from kvm_pmu_cap.{,fixed_}cntr_mask64 as
>> the number of consecutive counters starting at index 0.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/kvm/cpuid.c         | 14 +++++++++++---
>>  arch/x86/kvm/msrs.c          | 12 ++++++------
>>  arch/x86/kvm/pmu.c           | 34 +++++++++++-----------------------
>>  arch/x86/kvm/svm/pmu.c       |  2 +-
>>  arch/x86/kvm/svm/svm.c       |  9 +++++----
>>  arch/x86/kvm/vmx/pmu_intel.c |  7 ++++---
>>  arch/x86/kvm/vmx/vmx.c       |  7 +++++--
>>  7 files changed, 43 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 2698fa42cd97..151a4794f834 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1514,10 +1514,18 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>                 }
>>
>>                 eax.split.version_id = kvm_pmu_cap.version;
>> -               eax.split.num_counters = kvm_pmu_cap.num_counters_gp;
>> +
>> +               /* Contiguous GP counters only. */
>> +               eax.split.num_counters =
>> +                       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +                                           KVM_MAX_NR_GP_COUNTERS);
>>                 eax.split.bit_width = kvm_pmu_cap.bit_width_gp;
>>                 eax.split.mask_length = kvm_pmu_cap.events_mask_len;
>> -               edx.split.num_counters_fixed = kvm_pmu_cap.num_counters_fixed;
>> +
>> +               /* Contiguous fixed counters only. */
>> +               edx.split.num_counters_fixed =
>> +                       find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>> +                                           KVM_MAX_NR_FIXED_COUNTERS);
>>                 edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;
>>
>>                 if (kvm_pmu_cap.version)
>> @@ -1882,7 +1890,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>
>>                 cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>>
>> -               ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
>> +               ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);
>>                 entry->ebx = ebx.full;
>>                 break;
>>         }
>> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
>> index c751a8dbd45d..7524d019f1be 100644
>> --- a/arch/x86/kvm/msrs.c
>> +++ b/arch/x86/kvm/msrs.c
>> @@ -2631,20 +2631,20 @@ static void kvm_probe_msr_to_save(u32 msr_index)
>>                 break;
>>         case MSR_ARCH_PERFMON_PERFCTR0 ...
>>              MSR_ARCH_PERFMON_PERFCTR0 + KVM_MAX_NR_GP_COUNTERS - 1:
>> -               if (msr_index - MSR_ARCH_PERFMON_PERFCTR0 >=
>> -                   kvm_pmu_cap.num_counters_gp)
>> +               if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_PERFCTR0) &
>> +                     kvm_pmu_cap.cntr_mask64))
>>                         return;
>>                 break;
>>         case MSR_ARCH_PERFMON_EVENTSEL0 ...
>>              MSR_ARCH_PERFMON_EVENTSEL0 + KVM_MAX_NR_GP_COUNTERS - 1:
>> -               if (msr_index - MSR_ARCH_PERFMON_EVENTSEL0 >=
>> -                   kvm_pmu_cap.num_counters_gp)
>> +               if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_EVENTSEL0) &
>> +                     kvm_pmu_cap.cntr_mask64))
>>                         return;
>>                 break;
>>         case MSR_ARCH_PERFMON_FIXED_CTR0 ...
>>              MSR_ARCH_PERFMON_FIXED_CTR0 + KVM_MAX_NR_FIXED_COUNTERS - 1:
>> -               if (msr_index - MSR_ARCH_PERFMON_FIXED_CTR0 >=
>> -                   kvm_pmu_cap.num_counters_fixed)
>> +               if (!(BIT_ULL(msr_index - MSR_ARCH_PERFMON_FIXED_CTR0) &
>> +                     kvm_pmu_cap.fixed_cntr_mask64))
>>                         return;
>>                 break;
>>         case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 3647ce3f0e3f..bc2ca60114e9 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -20,7 +20,6 @@
>>  #include <asm/perf_event.h>
>>  #include <asm/cpu_device_id.h>
>>  #include "x86.h"
>> -#include "cpuid.h"
>>  #include "lapic.h"
>>  #include "pmu.h"
>>
>> @@ -136,8 +135,6 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>  {
>>         bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
>>         int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
>> -       union cpuid10_edx edx;
>> -       u32 eax, ebx, ecx;
>>
>>         /*
>>          * Hybrid PMUs don't play nice with virtualization without careful
>> @@ -159,8 +156,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>                  * there are a non-zero number of counters, but fewer than what
>>                  * is architecturally required.
>>                  */
>> -               if (!kvm_host_pmu.num_counters_gp ||
>> -                   WARN_ON_ONCE(kvm_host_pmu.num_counters_gp < min_nr_gp_ctrs))
>> +               if (!kvm_host_pmu.cntr_mask64 ||
>> +                   WARN_ON_ONCE(hweight64(kvm_host_pmu.cntr_mask64) < min_nr_gp_ctrs))
>>                         enable_pmu = false;
>>                 else if (is_intel && !kvm_host_pmu.version)
>>                         enable_pmu = false;
>> @@ -180,23 +177,14 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>
>>         memcpy(&kvm_pmu_cap, &kvm_host_pmu, sizeof(kvm_host_pmu));
>>         kvm_pmu_cap.version = min(kvm_pmu_cap.version, 2);
>> -       kvm_pmu_cap.num_counters_gp = min(kvm_pmu_cap.num_counters_gp,
>> -                                         pmu_ops->MAX_NR_GP_COUNTERS);
>> -       kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
>> -                                            KVM_MAX_NR_FIXED_COUNTERS);
>> +       kvm_pmu_cap.cntr_mask64 &=
>> +               GENMASK_ULL(pmu_ops->MAX_NR_GP_COUNTERS - 1, 0);
>> +       kvm_pmu_cap.fixed_cntr_mask64 &=
>> +               GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
>>
>> -       /*
>> -        * Currently, KVM doesn't support non-contiguous fixed counters; make
>> -        * sure only contiguous ones are retained in kvm_pmu_cap.
>> -        */
>> -       if (kvm_host_pmu.version >= 5) {
>> -               cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
>> -               if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
>> -                       kvm_pmu_cap.num_counters_fixed = edx.split.num_counters_fixed;
>> -       }
>> -
>> -       if (!enable_mediated_pmu && kvm_pmu_cap.num_counters_fixed > 3)
>> -               kvm_pmu_cap.num_counters_fixed = 3;
>> +       /* Legacy vPMU exposes at most 3 fixed counters. */
>> +       if (!enable_mediated_pmu)
>> +               kvm_pmu_cap.fixed_cntr_mask64 &= GENMASK_ULL(2, 0);
>>
>>         kvm_pmu_eventsel.INSTRUCTIONS_RETIRED =
>>                 perf_get_hw_event_config(PERF_COUNT_HW_INSTRUCTIONS);
>> @@ -796,8 +784,8 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>>          * KVM's capabilities are constrained based on KVM support, i.e. KVM's
>>          * capabilities themselves may be a subset of hardware capabilities.
>>          */
>> -       return kvm_gp_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_gp) - 1 ||
>> -              kvm_fixed_pmc_mask(pmu) != BIT_ULL(kvm_host_pmu.num_counters_fixed) - 1;
>> +       return kvm_gp_pmc_mask(pmu) != kvm_host_pmu.cntr_mask64 ||
>> +              kvm_fixed_pmc_mask(pmu) != kvm_host_pmu.fixed_cntr_mask64;
>>  }
>>
>>  bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
>> index 02cf960a215a..d519eba518bf 100644
>> --- a/arch/x86/kvm/svm/pmu.c
>> +++ b/arch/x86/kvm/svm/pmu.c
>> @@ -208,7 +208,7 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>>         }
>>
>>         pmu->all_valid_pmc_mask64 = (BIT_ULL(nr_gp_counters) - 1) &
>> -                                   (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
>> +                                   kvm_pmu_cap.cntr_mask64;
>>
>>         if (pmu->version > 1) {
>>                 pmu->global_ctrl_rsvd = ~pmu->all_valid_pmc_mask64;
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 3b3e98b6abb6..002cdd074fd7 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -754,6 +754,7 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>         bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>         unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>> +       unsigned long host_only_gp_mask;
>>         int i;
>>
>>         if (!enable_mediated_pmu)
>> @@ -769,7 +770,8 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>                 svm_set_intercept_for_msr(vcpu, MSR_F15H_PERF_CTR + 2 * i,
>>                                           MSR_TYPE_RW, intercept);
> 
> Our internal Sashiko says:
> 
> This is a pre-existing issue, but does the legacy MSR intercept need to be
> reverted here as well when gp_mask shrinks?
> When guest PMU capabilities are updated and gp_mask shrinks, the new
> host_only_gp_mask loop correctly reinstates the intercepts for
> MSR_F15H_PERF_CTR. However, looking at the code just above this hunk in
> svm_recalc_pmu_msr_intercepts():
>     /* Legacy counters are always available for AMD CPUs with a PMU. */
>     for_each_set_bit(i, &gp_mask, AMD64_NUM_COUNTERS)
>         svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>                                   MSR_TYPE_RW, intercept);
> There does not seem to be a corresponding loop to reinstate the intercept
> for MSR_K7_PERFCTR0 + i.
> If userspace initially exposes 4 counters, disabling intercepts for
> MSR_K7_PERFCTR0 through MSR_K7_PERFCTR3, and later updates CPUID to expose
> only 2 counters, could the removed legacy counters remain unintercepted?
> This sequence might allow an unprivileged userspace to grant the guest
> direct read/write access to host MSR_K7_PERFCTR MSRs without KVM
> intercepting them.
If gp_mask shrinks after intercepts have been disabled, counters that
are no longer guest-visible will not be revisited by the
for_each_set_bit() loop. Since the AMD counters are contiguous,
restoring intercepts for the cleared bits should address the userspace
reconfiguration case:

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



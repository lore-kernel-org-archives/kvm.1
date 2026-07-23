Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F830F924;
	Thu, 23 Jul 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820990; cv=none; b=CSOh4d87MIH3eiHPh7154+FvRiCE2enhRXUP7nQQ5Ftn5eTNy8WO7SwgAZxrBxN7JLexzdih3J1Rk1AW7IYfP4QgzsoIiwPW3nZGsteWJgsVsCzWPGMVsS6eu8BycAL4XWUSfJjTbBOYNUjGnPMcCIs+TILBSawttZITJhWsYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820990; c=relaxed/simple;
	bh=x4Pebje9omfpIctF+qw24hh/+WNM6ldoy14ojAuBjIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXEEHrstNYsC8icjMEpgoFcSXqvopN6GGe0vRvXNJ4BRr8nr+pk0DuXK2miCxgcwwdhHbBq7N3kkYD2wQZHaR9x1BFdJ+L6yiwdItue361wsUW0z2NiIQA1GYmb7MF9HWT3XZx8NLINBusr2wzWd3NlJdkBXRgaIcaeuQHQe4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mN4PruLs; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mN4PruLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784820988; x=1816356988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x4Pebje9omfpIctF+qw24hh/+WNM6ldoy14ojAuBjIE=;
  b=mN4PruLsbx5d3UNWf1CyLA8e5VcbRStO06LJDKAUuPL1YlpTfxYGvwDf
   aR8o0H72N0vX0zbM7v1f58mlNOhTeCJS3X+w4+0pCFEq11WbgS+VNV5Cu
   CgCfgSduI5/badIG2U7vjE84HsBj0QxfLmAbCCFh+F7KzEUt4ZsIG4fZb
   8awbhyBiYKJR5onVPW3BJshyF7u4I1EGeiQ6VgO0QUV+EAE1BWRQWEA/T
   dEs7TOV3XQLpSWBPcybw8G3/IH/mndLSbRVHkZNlEcl8suH65bLRdYGbc
   VHgCoQyEN3hpPprqyki0/aGEqVrJuYMunQIbm9LSFpKpB+BsL90fHdxrF
   A==;
X-CSE-ConnectionGUID: gIvdqCMFRfy99np+7i8uRw==
X-CSE-MsgGUID: WFURrcOSS0idE9jX/ztzvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85570611"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85570611"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 08:36:28 -0700
X-CSE-ConnectionGUID: Io+e283bSY+ycLgM0mgO5Q==
X-CSE-MsgGUID: icegZvHQRfiyJvppqmErxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="258511755"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 08:36:26 -0700
Message-ID: <3a9a40e9-da98-4650-af12-6de2174c5898@intel.com>
Date: Thu, 23 Jul 2026 10:36:19 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/8] KVM: x86/pmu: Support Intel fixed counter 3 on
 mediated vPMU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-3-zide.chen@intel.com>
 <CALMp9eQoHnj2QYBtOZisjB4oTaAUeoWbk3Hoj4+CdTGD2EJB3Q@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eQoHnj2QYBtOZisjB4oTaAUeoWbk3Hoj4+CdTGD2EJB3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/22/2026 5:17 PM, Jim Mattson wrote:
> On Mon, Jun 29, 2026 at 4:28 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Starting with Ice Lake, Intel introduced fixed counter 3, which counts
>> TOPDOWN.SLOTS - the number of available slots for an unhalted logical
>> processor.  It serves as the denominator for top-level metrics in the
>> Top-down Microarchitecture Analysis method.
>>
>> Emulating this counter on legacy vPMU would require introducing a new
>> generic perf encoding for the Intel-specific TOPDOWN.SLOTS event in
>> order to call perf_get_hw_event_config().  This is undesirable as it
>> would pollute the generic perf event encoding.
>>
>> Moreover, KVM does not intend to emulate IA32_PERF_METRICS in the
>> legacy vPMU model, and without IA32_PERF_METRICS, emulating this
>> counter has little practical value.  Therefore, expose fixed counter
>> 3 to guests only when mediated vPMU is enabled.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v6:
>> - Update comments to replace 2 with KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1.
>> v3:
>> - Move the non-contiguous counter filter code to pmu.c
>> v2:
>> - Don't advertise fixed counter 3 to userspace if the host doesn't
>>   support it.
>> ---
>>  arch/x86/include/asm/kvm_host.h |  2 +-
>>  arch/x86/kvm/msrs.c             |  4 ++--
>>  arch/x86/kvm/pmu.c              | 18 +++++++++++++++++-
>>  3 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index d8700eb848b4..dc9e4e8bfc07 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -609,7 +609,7 @@ struct kvm_pmc {
>>  #define KVM_MAX_NR_GP_COUNTERS         KVM_MAX(KVM_MAX_NR_INTEL_GP_COUNTERS, \
>>                                                 KVM_MAX_NR_AMD_GP_COUNTERS)
>>
>> -#define KVM_MAX_NR_INTEL_FIXED_COUNTERS        3
>> +#define KVM_MAX_NR_INTEL_FIXED_COUNTERS        4
>>  #define KVM_MAX_NR_AMD_FIXED_COUNTERS  0
>>  #define KVM_MAX_NR_FIXED_COUNTERS      KVM_MAX(KVM_MAX_NR_INTEL_FIXED_COUNTERS, \
>>                                                 KVM_MAX_NR_AMD_FIXED_COUNTERS)
>> diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
>> index c230b18d87e3..3bf42d90ad14 100644
>> --- a/arch/x86/kvm/msrs.c
>> +++ b/arch/x86/kvm/msrs.c
>> @@ -228,7 +228,7 @@ static const u32 msrs_to_save_base[] = {
>>
>>  static const u32 msrs_to_save_pmu[] = {
>>         MSR_ARCH_PERFMON_FIXED_CTR0, MSR_ARCH_PERFMON_FIXED_CTR1,
>> -       MSR_ARCH_PERFMON_FIXED_CTR0 + 2,
>> +       MSR_ARCH_PERFMON_FIXED_CTR2, MSR_ARCH_PERFMON_FIXED_CTR3,
>>         MSR_CORE_PERF_FIXED_CTR_CTRL, MSR_CORE_PERF_GLOBAL_STATUS,
>>         MSR_CORE_PERF_GLOBAL_CTRL,
>>         MSR_IA32_PEBS_ENABLE, MSR_IA32_DS_AREA, MSR_PEBS_DATA_CFG,
>> @@ -2688,7 +2688,7 @@ void kvm_init_msr_lists(void)
>>  {
>>         unsigned i;
>>
>> -       BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 3,
>> +       BUILD_BUG_ON_MSG(KVM_MAX_NR_FIXED_COUNTERS != 4,
>>                          "Please update the fixed PMCs in msrs_to_save_pmu[]");
>>
>>         num_msrs_to_save = 0;
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 62d0ed99ebe9..f82ba63767d0 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -99,7 +99,8 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
>>   *        all perf counters (both gp and fixed). The mapping relationship
>>   *        between pmc and perf counters is as the following:
>>   *        * Intel: [0 .. KVM_MAX_NR_INTEL_GP_COUNTERS-1] <=> gp counters
>> - *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX + 2] <=> fixed
>> + *                 [KVM_FIXED_PMC_BASE_IDX .. KVM_FIXED_PMC_BASE_IDX +
>> + *                  KVM_MAX_NR_INTEL_FIXED_COUNTERS - 1] <=> fixed
>>   *        * AMD:   [0 .. AMD64_NUM_COUNTERS-1] and, for families 15H
>>   *          and later, [0 .. AMD64_NUM_COUNTERS_CORE-1] <=> gp counters
>>   */
>> @@ -134,6 +135,8 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>  {
>>         bool is_intel = boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
>>         int min_nr_gp_ctrs = pmu_ops->MIN_NR_GP_COUNTERS;
>> +       union cpuid10_edx edx;
>> +       u32 eax, ebx, ecx;
>>
>>         /*
>>          * Hybrid PMUs don't play nice with virtualization without careful
>> @@ -181,6 +184,19 @@ void kvm_init_pmu_capability(struct kvm_pmu_ops *pmu_ops)
>>         kvm_pmu_cap.num_counters_fixed = min(kvm_pmu_cap.num_counters_fixed,
>>                                              KVM_MAX_NR_FIXED_COUNTERS);
>>
>> +       /*
>> +        * Currently, KVM doesn't support non-contiguous fixed counters; make
>> +        * sure only contiguous ones are retained in kvm_pmu_cap.
>> +        */
>> +       if (kvm_host_pmu.version >= 5) {
>> +               cpuid(0xa, &eax, &ebx, &ecx, &edx.full);
>> +               if (kvm_pmu_cap.num_counters_fixed > edx.split.num_counters_fixed)
>> +                       kvm_pmu_cap.num_counters_fixed = edx.split.num_counters_fixed;
>> +       }
> 
> Nit: Should this CPUID.0AH decoding be left to perf? Perhaps struct
> x86_pmu_capability should include an additional field:
> num_contiguous_counters_fixed?

This is a temporary workaround that will be removed once non-contiguous
fixed counter support is added in the vPMU v5 series:

https://lore.kernel.org/kvm/20260707183405.15571-9-zide.chen@intel.com/

BTW, the vPMU v5 series is based on top of this Topdown series, so it
cannot be merged to the Sashiko branch for review. I will post a
kvm-x86/next based v2 shortly with a new cleanup patch and minor
changelog/comment fixes.

> Reviewed-by: Jim Mattson <jmattson@google.com>


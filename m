Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84B33D9050;
	Thu, 27 Aug 2026 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870721; cv=none; b=S2eW95AHYE9MmBWvCOqAnV7RY+Y47ndb40Dy+Mee6zbcmugaZxMUFGGMmuT3etIdtBC1UKetM1xTHAUaT0dpNC8+sO4F3/uM60JGSiOoh5KEWy8R1lb8LeXKoEv5Ep7yx2X3jwAr9VaBHybblD0tYuo5v3IsoBkkUk0kTctXP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870721; c=relaxed/simple;
	bh=Py8JZQPsVHRBR8KBKorDX74skd56kgYOi1EMPrN094U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sh3VTUF+ouapdqKDd9J12IcY/fuGQ2+4mVcSDUQw6FSG/+gtDq78ON87qACsAAiZIXlsim2vClUK3UgZ7E/cpuM9SPMXEghSojN3HRobl1j+hZhgUqk75JYNR3J/im3NLPynnG5c1Hn/hYreNPDW9rL8Y8XXK4zMYX+iGI9dojI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IkMplTU6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IkMplTU6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787870719; x=1819406719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Py8JZQPsVHRBR8KBKorDX74skd56kgYOi1EMPrN094U=;
  b=IkMplTU6E1uGSjydKI1MYejH3ud4iLKklcPEHwjsxA2S4YxhQ81Vs0i4
   2ZVBzbAYw62Sq4lhP9+hzpwDOFfyjvlt/nr2swgXt9i/y65l0e8W5/L7w
   Tes2GTMRHKiygyd+wN2Kor4OFEHKXZm9Z3cNBG9j5+gvskBzQA1U5eEGO
   mPckk1MqHNFV5YYFdWTcL2egEf1ANLc702u1Nt9Sa/neV9VC97+jc9KXO
   /CzUNji5q9mP5BU6q9ikkoEA060MuHIaW0f/e4ZuFiq9pRyKzBcW8CClT
   0DI7zTzq007rhjDPaNWW2jGiL5pJaxymK/sn0Szgk5ptyW8XoMhjjuRx8
   g==;
X-CSE-ConnectionGUID: rZE8QafPRs+SVDRQwOdK9A==
X-CSE-MsgGUID: uk0rsuuIQwC05L9Soe7Bvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99732163"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="99732163"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:45:18 -0700
X-CSE-ConnectionGUID: nT/gB0FZT6y9iTOEvmxVMg==
X-CSE-MsgGUID: FliWteH6TVCkj0GBEVYUhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="268566862"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 15:45:16 -0700
Message-ID: <686cab53-132c-4550-9e64-55a8f8164755@intel.com>
Date: Thu, 27 Aug 2026 17:45:16 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] KVM: x86/pmu: Add the perfmon_mask module parameter
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
 <20260821222002.54907-13-zide.chen@intel.com>
 <c804747d-9214-4587-8f53-e6cb219268bf@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <c804747d-9214-4587-8f53-e6cb219268bf@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/2026 3:18 AM, Mi, Dapeng wrote:
> I don't remember why to set the perfmon_mask to be a kvm_intel module
> parameter, but per my understanding, it seems better and more
> straightforward to set perfmon_mask to be a perf/x86 parameter. It's also
> consistent with current perf/x86 behavior. Host exposes all PMU
> capabilities to KVM instead of the opposite.

Perfmon Masking can be enabled only after perf_create_mediated_pmu()
succeeds, but the following conditions are not determined by perf/x86:

- Host VMX capability support.
- mediated PMU is enabled.
- perf/core does not block the mediated guest creation.

If perf/x86 owns the parameter, but whether the parameter takes effect
depends on actions taken by a loaded module at runtime, it does not
sound reasonable.

BTW, in this approach, an additional interface between KVM and perf/x86
would be needed to communicate the enablement of Perfmon Masking.

Additionally, this is less flexible, as the mask cannot be changed
without rebooting the host. I might be wrong, but not sure whether
different masks may be needed to accommodate different guests for live
migration.

Also, given that the format of this parameter is complicated, it is not
surprising that an administrator may provide an incorrect or undesired
value at boot time, and repeatedly rebooting the host to correct it may
not be convenient.
> Thanks.
> 
> On 8/22/2026 6:19 AM, Zide Chen wrote:
>> Only Intel CPUs support PerfMon masking, so this new parameter is
>> Intel-specific. Mediated vPMU must be enabled for PerfMon masking.
>>
>> PerfMon masking lets a VMM partition PMU resources between host and
>> guest: each mask bit determines whether the guest (set) or host
>> (clear) owns a counter's MSR(s), RDPMC access, and the corresponding
>> bit in the global MSRs (e.g. IA32_PERF_GLOBAL_CTRL) in non-root mode.
>>
>> The setting is system-wide and caps what any individual guest may be
>> given; each guest may configure a subset of it.
>>
>> The parameter is configured with a text-based, semicolon-separated
>> list of terms. Currently supported for a mediated vPMU guest:
>>
>>   guest_gp=<list>    general purpose counters (0-based) owned by the guest
>>   guest_fixed=<list> fixed counters (0-based) owned by the guest
>>   perf_metrics       PERF_METRICS is owned by the guest
>>
>> For example:
>>
>>   kvm-intel.perfmon_mask=guest_gp=0-3;guest_fixed=0,2-3;perf_metrics
>>
>> Internally, the parsed terms are folded into a 64-bit perfmon_mask
>> variable that uses the same layout as the PERFMON_MASK VMCS field,
>> i.e. the IA32_PERF_GLOBAL_STATUS layout. An empty (default) value
>> behaves the same as a plain mediated vPMU.
>>
>> Using IA32_PERF_GLOBAL_CTRL in the generic VM-exit MSR-store area
>> while the PerfMon masking VM-execution control is set is undefined,
>> so PerfMon masking requires the dedicated Save-IA32_PERF_GLOBAL_CTRL
>> VM-exit control.
>>
>> cpu_has_vmx_perfmon_mask() is hardcoded to false temporarily until
>> later patches.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         | 30 ++++++++
>>  arch/x86/kvm/pmu.c                            |  3 +
>>  arch/x86/kvm/pmu.h                            |  1 +
>>  arch/x86/kvm/vmx/capabilities.h               |  5 ++
>>  arch/x86/kvm/vmx/pmu_intel.c                  | 68 +++++++++++++++++++
>>  arch/x86/kvm/vmx/vmx.c                        | 54 +++++++++++++++
>>  arch/x86/kvm/vmx/vmx.h                        |  1 +
>>  arch/x86/kvm/x86.c                            |  2 +-
>>  8 files changed, 163 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index b5493a7f8f22..e0ff16746a08 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3284,6 +3284,36 @@ Kernel parameters
>>  			[KVM,Intel] Control nested virtualization feature in
>>  			KVM/VMX. Default is 1 (enabled).
>>  
>> +	kvm-intel.perfmon_mask=
>> +			[KVM,Intel] Defines the host-wide PMU resource
>> +			partition between guest and host. Resources assigned
>> +			to the guest are unavailable to the host, and vice
>> +			versa, while a guest is running.
>> +
>> +			The value is a semicolon-separated list of terms:
>> +
>> +			  guest_gp=<list>    General purpose counters
>> +					     (0-based) assigned to the guest.
>> +			  guest_fixed=<list> Fixed counters (0-based) assigned
>> +					     to the guest.
>> +			  perf_metrics       PERF_METRICS is assigned to the
>> +					     guest. Requires fixed counter 3
>> +					     to also be assigned to the
>> +					     guest.
>> +
>> +			<list> is a comma-separated list of numbers and/or
>> +			ranges, e.g. "0-2,5". Terms and the resources they
>> +			don't mention default to being host-owned. For
>> +			example:
>> +
>> +				kvm-intel.perfmon_mask=guest_gp=0-3;guest_fixed=0-1,3;perf_metrics
>> +
>> +			assigns general purpose counters 0-3, fixed counters
>> +			0, 1 and 3, and PERF_METRICS to the guest, while all
>> +			other resources remain with the host.
>> +
>> +			Default is "" (disabled).
>> +
>>  	kvm-intel.unrestricted_guest=
>>  			[KVM,Intel] Control KVM's use of unrestricted guest
>>  			feature (virtualized real and unpaged mode). Default
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index c022337d0bec..92ff685d11b3 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -43,6 +43,9 @@ module_param(enable_pmu, bool, 0444);
>>  bool __read_mostly enable_mediated_pmu;
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(enable_mediated_pmu);
>>  
>> +u64 __read_mostly perfmon_mask;
>> +EXPORT_SYMBOL_FOR_KVM_INTERNAL(perfmon_mask);
>> +
>>  struct kvm_x86_pmu_event_filter {
>>  	__u32 action;
>>  	__u32 nevents;
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index 8322bbed2d64..2dc12e3f3af0 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -64,6 +64,7 @@ struct kvm_pmu_ops {
>>  
>>  extern bool enable_pmu;
>>  extern bool enable_mediated_pmu;
>> +extern u64 perfmon_mask;
>>  
>>  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops);
>>  
>> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
>> index 810119167f79..d4c362093966 100644
>> --- a/arch/x86/kvm/vmx/capabilities.h
>> +++ b/arch/x86/kvm/vmx/capabilities.h
>> @@ -296,6 +296,11 @@ static inline bool cpu_has_vmx_ipiv(void)
>>  	return vmcs_config.cpu_based_3rd_exec_ctrl & TERTIARY_EXEC_IPI_VIRT;
>>  }
>>  
>> +static inline bool cpu_has_vmx_perfmon_mask(void)
>> +{
>> +	return false;
>> +}
>> +
>>  static inline bool cpu_has_vmx_flexpriority(void)
>>  {
>>  	return cpu_has_vmx_tpr_shadow() &&
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index e2e51006ca47..62e542eac05e 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -955,6 +955,74 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>>  	}
>>  }
>>  
>> +static bool intel_pmu_validate_perfmon_mask(void)
>> +{
>> +	u64 guest_fixed_mask, guest_gp_mask;
>> +
>> +	/*
>> +	 * Combining VM-exit MSR-store with PerfMon masking produces
>> +	 * undefined behavior, so it requires hardware support for this
>> +	 * dedicated save control.
>> +	 */
>> +	if (!cpu_has_save_perf_global_ctrl())
>> +		return false;
>> +
>> +	guest_gp_mask = perfmon_mask & GENMASK_ULL(INTEL_PMC_MAX_GENERIC - 1, 0);
>> +	guest_fixed_mask = perfmon_mask >> INTEL_PMC_IDX_FIXED;
>> +	guest_fixed_mask &= GENMASK_ULL(INTEL_PMC_MAX_FIXED - 1, 0);
>> +
>> +	if ((guest_fixed_mask & ~kvm_pmu_cap.fixed_cntr_mask64) ||
>> +	    (guest_gp_mask & ~kvm_pmu_cap.cntr_mask64))
>> +		return false;
>> +
>> +	/*
>> +	 * Without KVM Arch PerfMon extension support, the guest cannot own
>> +	 * non-contiguous GP counters.
>> +	 */
>> +	if (guest_gp_mask & (guest_gp_mask + 1))
>> +		return false;
>> +
>> +	if ((perfmon_mask & GLOBAL_STATUS_PERF_METRICS_OVF) &&
>> +	    !(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS))
>> +		return false;
>> +
>> +	/*
>> +	 * PERF_METRICS and fixed counter 3 must both be host-owned or both
>> +	 * guest-owned.
>> +	 */
>> +	if (!!(perfmon_mask & BIT_ULL(GLOBAL_STATUS_PERF_METRICS_OVF_BIT)) !=
>> +	    !!(perfmon_mask & BIT_ULL(INTEL_PMC_IDX_FIXED + 3)))
>> +		return false;
>> +
>> +	/*
>> +	 * The guest must not own all PMU counters. Otherwise, the configuration
>> +	 * degenerates into plain mediated vPMU and adds unnecessary complexity
>> +	 * to the perf scheduler.
>> +	 */
>> +	if ((guest_fixed_mask == kvm_host_pmu.fixed_cntr_mask64) &&
>> +	    (guest_gp_mask == kvm_host_pmu.cntr_mask64))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +void intel_pmu_perfmon_mask_setup(void)
>> +{
>> +	if (!perfmon_mask)
>> +		return;
>> +
>> +	if (!enable_mediated_pmu || !cpu_has_vmx_perfmon_mask()) {
>> +		perfmon_mask = 0;
>> +		return;
>> +	}
>> +
>> +	if (!intel_pmu_validate_perfmon_mask()) {
>> +		pr_warn("Invalid perfmon_mask=%#llx, disabling PerfMon masking\n",
>> +			perfmon_mask);
>> +		perfmon_mask = 0;
>> +	}
>> +}
>> +
>>  struct kvm_pmu_ops intel_pmu_ops __initdata = {
>>  	.emulate_rdpmc = intel_emulate_rdpmc,
>>  	.msr_idx_to_pmc = intel_msr_idx_to_pmc,
>> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
>> index ded63e2e39ce..cdd141d22efa 100644
>> --- a/arch/x86/kvm/vmx/vmx.c
>> +++ b/arch/x86/kvm/vmx/vmx.c
>> @@ -14,6 +14,7 @@
>>   */
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>  
>> +#include <linux/bitmap.h>
>>  #include <linux/highmem.h>
>>  #include <linux/hrtimer.h>
>>  #include <linux/kernel.h>
>> @@ -25,6 +26,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/sched/smt.h>
>>  #include <linux/slab.h>
>> +#include <linux/string.h>
>>  #include <linux/tboot.h>
>>  #include <linux/trace_events.h>
>>  
>> @@ -164,6 +166,56 @@ module_param(allow_smaller_maxphyaddr, bool, S_IRUGO);
>>  
>>  module_param(enable_mediated_pmu, bool, 0444);
>>  
>> +/*
>> + * See the "kvm-intel.perfmon_mask" entry in
>> + * Documentation/admin-guide/kernel-parameters.txt for the full syntax.
>> + * Example: kvm-intel.perfmon_mask=guest_gp=0-3;guest_fixed=0-1,3;perf_metrics
>> + */
>> +static int perfmon_mask_set(const char *val, const struct kernel_param *kp)
>> +{
>> +	unsigned long gp_bitmap = 0, fixed_bitmap = 0;
>> +	char *buf, *orig, *tok;
>> +	size_t prefix_len;
>> +	u64 mask = 0;
>> +	int r = 0;
>> +
>> +	buf = orig = kstrdup(val, GFP_KERNEL);
>> +	if (!buf)
>> +		return -ENOMEM;
>> +
>> +	while ((tok = strsep(&buf, ";")) != NULL) {
>> +		if (!*tok)
>> +			continue;
>> +
>> +		if (!strcmp(tok, "perf_metrics")) {
>> +			mask |= GLOBAL_STATUS_PERF_METRICS_OVF;
>> +		} else if ((prefix_len = str_has_prefix(tok, "guest_gp="))) {
>> +			r = bitmap_parselist(tok + prefix_len, &gp_bitmap,
>> +					     INTEL_PMC_MAX_GENERIC);
>> +		} else if ((prefix_len = str_has_prefix(tok, "guest_fixed="))) {
>> +			r = bitmap_parselist(tok + prefix_len, &fixed_bitmap,
>> +					     INTEL_PMC_MAX_FIXED);
>> +		} else {
>> +			r = -EINVAL;
>> +		}
>> +
>> +		if (r)
>> +			goto out;
>> +	}
>> +
>> +	mask |= gp_bitmap | ((u64)fixed_bitmap << INTEL_PMC_IDX_FIXED);
>> +	*(u64 *)kp->arg = mask;
>> +out:
>> +	kfree(orig);
>> +	return r;
>> +}
>> +
>> +static const struct kernel_param_ops perfmon_mask_ops = {
>> +	.set = perfmon_mask_set,
>> +	.get = param_get_ullong,
>> +};
>> +module_param_cb(perfmon_mask, &perfmon_mask_ops, &perfmon_mask, 0444);
>> +
>>  #define KVM_VM_CR0_ALWAYS_OFF (X86_CR0_NW | X86_CR0_CD)
>>  #define KVM_VM_CR0_ALWAYS_ON_UNRESTRICTED_GUEST X86_CR0_NE
>>  #define KVM_VM_CR0_ALWAYS_ON				\
>> @@ -8824,6 +8876,8 @@ __init int vmx_hardware_setup(void)
>>  	else
>>  		vt_init_ops.handle_intel_pt_intr = NULL;
>>  
>> +	intel_pmu_perfmon_mask_setup();
>> +
>>  	setup_default_sgx_lepubkeyhash();
>>  
>>  	vmx_set_cpu_caps();
>> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
>> index dc8517f15bc4..ccda5c5c8c2c 100644
>> --- a/arch/x86/kvm/vmx/vmx.h
>> +++ b/arch/x86/kvm/vmx/vmx.h
>> @@ -667,6 +667,7 @@ static __always_inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
>>  void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
>>  int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
>>  void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
>> +void intel_pmu_perfmon_mask_setup(void);
>>  
>>  struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
>>  void free_vmcs(struct vmcs *vmcs);
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 5f3215915c76..26a3b7a267b5 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -9328,7 +9328,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>>  	if (enable_mediated_pmu && kvm->arch.enable_pmu &&
>>  	    !kvm->arch.created_mediated_pmu) {
>>  		if (irqchip_in_kernel(kvm)) {
>> -			r = perf_create_mediated_pmu(0);
>> +			r = perf_create_mediated_pmu(perfmon_mask);
>>  			if (r) {
>>  				pr_warn_ratelimited(PERF_MEDIATED_PMU_MSG);
>>  				return r;


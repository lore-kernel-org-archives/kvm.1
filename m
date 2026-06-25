Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFE3AA1B0;
	Thu, 25 Jun 2026 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782405064; cv=none; b=Y8Dp4BiyS0OE1VNGBPKv8rwp5xpZGxn1ESf3TENn4qmewfTQAZbXCMK4FzAp5tOFbqAd2Q4LZ1nA1eNabolyD0GMyss55kxg9Vlbp4K81aZ6DESHz/7W8QkwHyu9w0plsiavDiV7WG35QPzJL3glITzLB02+NghnF77OvGOESUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782405064; c=relaxed/simple;
	bh=FlflHI6eZ2LJMOCo0rE1cuVEvdNt3PMJD1t19srOLnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fp0Fw8l9NO/Z0gJcGBWvetg85F9W0Xvd9Zh0lKhd40XnX6OQYnt2enxBebhfGgeJ478qDTHbmMYTfObwCk8bJRW6Krci4gKCybqYl3u5uFUG6srA1fBlA76Kk2Qby59ksFDAvKJUojk7gG5m9szb2LyOmx2vXzRj8nVUBscJoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2BoyQUX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2BoyQUX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782405063; x=1813941063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FlflHI6eZ2LJMOCo0rE1cuVEvdNt3PMJD1t19srOLnU=;
  b=f2BoyQUXQTimJYJ1tdyDKed9nKs6tdTBFhRahO9sx3pXEGqjhtoa9ud0
   txmrJCQUoEtEazaXdImzvHS/hJ+zNVqen5A2dNWS60ynTcUvi1yPtuS8z
   6wBxle1HeX/lt7WUYxOgwza2K4OQBqLfs7Rx760ukcxKbidgeosjhZs1p
   cQsGVqb9xsEfjkduAxcbYZY5vKcS9f6MOAhDa9UBqpebvxh+A852ECEF3
   DnhKqdSGWRUgW4vVm1olu6QEF77AEZjlrHy6R28vBNwqTUi13VkqBHkql
   tiwQj6WJ+oQBY7/DzJdcIxClkxaRbqqshSyey8Io3SA0+Z7gPffTs2kbt
   Q==;
X-CSE-ConnectionGUID: 99gR02kFQGuknlF+bWv/AA==
X-CSE-MsgGUID: SnhNG6MZRQmPjzR3CjA43g==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="70696995"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="70696995"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 09:30:59 -0700
X-CSE-ConnectionGUID: 7lFSDcONQFW0srDlCcLGvA==
X-CSE-MsgGUID: djbSK/wHTTK5eY4iljoz0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="249278334"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 09:30:59 -0700
Message-ID: <1f1c2f34-1f89-4886-a115-41666532f032@intel.com>
Date: Thu, 25 Jun 2026 11:30:57 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 6/7] KVM: x86/pmu: Emulate RDPMC on performance metrics
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260625034555.141453-1-zide.chen@intel.com>
 <20260625034555.141453-7-zide.chen@intel.com>
 <e3058805-9215-48dc-ad37-ec530a6c8212@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <e3058805-9215-48dc-ad37-ec530a6c8212@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/2026 4:17 AM, Mi, Dapeng wrote:
> 
> On 6/25/2026 11:45 AM, Zide Chen wrote:
>> If the host has the PERF_METRICS capability but it's not present on
>> the guest, RDPMC interception must be enabled and KVM should inject
>> an #GP when the guest attempts to read it.
>>
>> If the guest has PERF_METRICS, but RDPMC interception is enabled for
>> other reasons, KVM needs to emulate RDPMC with type 2000H.
>>
>> For simplicity, Metrics Clear Mode is not supported.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v5: new patch.
>> ---
>>  arch/x86/kvm/pmu.c | 30 ++++++++++++++++++++++++++----
>>  1 file changed, 26 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 7aafc5db1346..af5b14f44e4b 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -755,6 +755,16 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>>  	return 0;
>>  }
>>  
>> +static int kvm_pmu_rdpmc_metrics(struct kvm_vcpu *vcpu,
>> +				 unsigned idx, u64 *data)
>> +{
>> +	if (!kvm_vcpu_has_perf_metrics(vcpu))
>> +		return 1;
>> +
>> +	*data = vcpu_to_pmu(vcpu)->perf_metrics;
>> +	return 0;
>> +}
>> +
>>  int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>>  {
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> @@ -767,15 +777,18 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
>>  	if (is_vmware_backdoor_pmc(idx))
>>  		return kvm_pmu_rdpmc_vmware(vcpu, idx, data);
>>  
>> -	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
>> -	if (!pmc)
>> -		return 1;
>> -
>>  	if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
>>  	    (kvm_x86_call(get_cpl)(vcpu) != 0) &&
>>  	    kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
>>  		return 1;
>>  
>> +	if (idx & INTEL_PMC_FIXED_RDPMC_METRICS)
> 
> I'm not quite sure if this check is good enough. Although the SDM vol.2
> says "Performance metrics use type 2000H. This type can be used only if
> IA32_PERF_CAPABILITIES.PERF_METRICS_AVAILABLE[bit 15]=1. For this type, the
> index in ECX[15:0] is implementation specific." It doesn't say the PMC
> index must be 0, but we always set the PMC index to 0 when reading topdown
> metrics.

Simply AND the idx is problematic for two reasons: 1) it doesn't catch
invalid type. for example 6000H; 2) fundamentally,
INTEL_PMC_FIXED_RDPMC_METRICS is Intel specific and it can't be compared
in common code.

The proposal is to change the callback rdpmc_ecx_to_pmc() to
emu_rdpmc(), and mode the RDPMC metrics code into vendor. Part of the
proposed code:

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7aafc5db1346..af6fc8c96037 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -758,8 +758,6 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu
*vcpu, unsigned idx, u64 *data)
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
        struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-       struct kvm_pmc *pmc;
-       u64 mask = ~0ull;

        if (!pmu->version)
                return 1;
@@ -767,17 +765,12 @@ int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned
idx, u64 *data)
        if (is_vmware_backdoor_pmc(idx))
                return kvm_pmu_rdpmc_vmware(vcpu, idx, data);

-       pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
-       if (!pmc)
-               return 1;
-
        if (!kvm_is_cr4_bit_set(vcpu, X86_CR4_PCE) &&
            (kvm_x86_call(get_cpl)(vcpu) != 0) &&
            kvm_is_cr0_bit_set(vcpu, X86_CR0_PE))
                return 1;

-       *data = pmc_read_counter(pmc) & mask;
-       return 0;
+       return kvm_pmu_call(emu_rdpmc)(vcpu, idx, data);
 }

 static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 3066cade5790..24634aa92875 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -24,8 +24,7 @@
 #define KVM_FIXED_PMC_BASE_IDX INTEL_PMC_IDX_FIXED

 struct kvm_pmu_ops {
-       struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
-               unsigned int idx, u64 *mask);
+       int (*emu_rdpmc)(struct kvm_vcpu *vcpu, unsigned idx, u64 *data);
        struct kvm_pmc *(*msr_idx_to_pmc)(struct kvm_vcpu *vcpu, u32 msr);
        int (*check_rdpmc_early)(struct kvm_vcpu *vcpu, unsigned int idx);
        bool (*is_valid_msr)(struct kvm_vcpu *vcpu, u32 msr);
@@ -84,14 +85,12 @@ static void reprogram_fixed_counters(struct kvm_pmu
*pmu, u64 data)
        }
 }

-static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
-                                           unsigned int idx, u64 *mask)
+static int intel_emu_rdpmc(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 {
        unsigned int type = idx & INTEL_RDPMC_TYPE_MASK;
        struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
-       struct kvm_pmc *counters;
+       struct kvm_pmc *counters, *pmc;
        unsigned int num_counters;
-       u64 bitmask;

        /*
         * The encoding of ECX for RDPMC is different for architectural
versus
@@ -104,7 +103,7 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct
kvm_vcpu *vcpu,
         * as KVM doesn't support such PMUs.
         */
        if (WARN_ON_ONCE(!pmu->version))
-               return NULL;
+               return 1;

        /*
         * General Purpose (GP) PMCs are supported on all PMUs, and
fixed PMCs
@@ -118,23 +117,28 @@ static struct kvm_pmc
*intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
        case INTEL_RDPMC_FIXED:
                counters = pmu->fixed_counters;
                num_counters = pmu->nr_arch_fixed_counters;
-               bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
                break;
        case INTEL_RDPMC_GP:
                counters = pmu->gp_counters;
                num_counters = pmu->nr_arch_gp_counters;
-               bitmask = pmu->counter_bitmask[KVM_PMC_GP];
                break;
+       case INTEL_RDPMC_METRICS:
+               if (!kvm_vcpu_has_perf_metrics(vcpu))
+                       return 1;
+
+               *data = vcpu_to_pmu(vcpu)->perf_metrics;
+               return 0;
        default:
-               return NULL;
+               return 1;
        }

        idx &= INTEL_RDPMC_INDEX_MASK;
        if (idx >= num_counters)
-               return NULL;
+               return 1;

-       *mask &= bitmask;
-       return &counters[array_index_nospec(idx, num_counters)];
+       pmc = &counters[array_index_nospec(idx, num_counters)];
+       *data = pmc_read_counter(pmc);
+       return 0;
 }

 static inline struct kvm_pmc *get_fw_gp_pmc(struct kvm_pmu *pmu, u32 msr)


> Could you please test to run the rdpmc instruction to read topdown metrics
> with valid and invalid PMC index on real HW and look what would happen? Thanks.

RDPMC with invalid type, for example 0x6000 got an #GP. non-zero index
(ECX[15:0]) with type 2000H got an #GP on SPR/NVL/GNR as well.

I haven't found any documentation talking about non-zero index on type
2000H. Since it's implementation specific, for now seems it's OK to
reject (#GP) non-zero index.


>> +		return kvm_pmu_rdpmc_metrics(vcpu, idx, data);
>> +
>> +	pmc = kvm_pmu_call(rdpmc_ecx_to_pmc)(vcpu, idx, &mask);
>> +	if (!pmc)
>> +		return 1;
>> +
>>  	*data = pmc_read_counter(pmc) & mask;
>>  	return 0;
>>  }
>> @@ -803,6 +816,14 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>  }
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>  
>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!(kvm_host.perf_capabilities & PERF_CAP_PERF_METRICS))
>> +		return false;
>> +
>> +	return !kvm_vcpu_has_perf_metrics(vcpu);
>> +}
>> +
>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> @@ -815,6 +836,7 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>  		return true;
>>  
>>  	return kvm_need_any_pmc_intercept(vcpu) ||
>> +	       kvm_need_perf_metrics_intercept(vcpu) ||
>>  	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>>  	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
>>  }


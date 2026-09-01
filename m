Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE0372663;
	Tue,  1 Sep 2026 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272441; cv=none; b=K53mtgcv6lvgG53OIaEU4VtWexTFCBSmTD0yQdYB9isy4Ymxjiv3iPz9dZ+9IDcotFrXZRZ6dfMswryC1bg4WTksEH5n0nGVxEIOTV1iqKY84DuMxI8Vm5P7oDDFPs+InuiZnw/qW7PQmWQoNTv9awDPw3KxTlzX7rjpwP9w/xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272441; c=relaxed/simple;
	bh=zd/fIEEYMnMH3UWLNBfAjaY+K6SztpiJkJuUGOBwOMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQ35fn47VLTiEhew9ULQ7WvI2OAzhwCRKUNfI+KEQWrRHu9rkreClvRY5bZtF/xEmjYUVYQFsfanhO0p63PGk0qfzx2Z0BI7fKz3Ls/vpGm+StOP6wj43Oz4wR8fET1moUYEsnkq4JEhjh3DDUfa373Gbzy/aVTmwEYEVlekkkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByiWL7c4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByiWL7c4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788272439; x=1819808439;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zd/fIEEYMnMH3UWLNBfAjaY+K6SztpiJkJuUGOBwOMQ=;
  b=ByiWL7c434jx4L3HI3T9mIjM4wkyVNHcLUDzeAD/nYppdVhYXFaM4/JD
   N0Rj1zqMLNxjFfHAESU3nB5/tUcLJvrj8KNo5mPApvX0BKUy8eliDd9L6
   ez8eAAjAvKn84lCvUES+r4X9rLDZfSTT0hQmMDpie1jgIdCJAN3gZor7i
   QWvqAkOSxbX+ckej+QvPmfJG1prcx/lqDCUI01P8oKSj76J8bGVVgvJdJ
   ijF+yjuYaaMs8I3CTbacJrs0P/JlXTUTfDVj7GpnN/vr+lKhq9iPBIjbh
   Uxvsu0l7sZeGVcbugfG9dwmCUERwnrgTBmLc3jQE5klq1xkPluBkvgM7n
   w==;
X-CSE-ConnectionGUID: u7EX+OyKRhWaOgrdktnHmQ==
X-CSE-MsgGUID: 6NHn0GiVQlqh0tNA+d/ydA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88909617"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88909617"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:20:38 -0700
X-CSE-ConnectionGUID: F7cF9cMCQGG7mr2OPBMphA==
X-CSE-MsgGUID: 7oUiwgDWTfKQdgg2VCkSrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="267803038"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 07:20:38 -0700
Message-ID: <8e9aeb61-30fc-4a1a-8a6d-9104f9ebdd6f@intel.com>
Date: Tue, 1 Sep 2026 09:20:36 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <d2285a85-e5b5-4fd5-8f2f-68f2dee5763d@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <d2285a85-e5b5-4fd5-8f2f-68f2dee5763d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/1/2026 1:45 AM, Mi, Dapeng wrote:
> 
> On 8/28/2026 6:37 AM, Zide Chen wrote:
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
>>  #define MSR_CORE_PERF_GLOBAL_CTRL	0x0000038f
>>  #define MSR_CORE_PERF_GLOBAL_OVF_CTRL	0x00000390
>>  #define MSR_CORE_PERF_GLOBAL_STATUS_SET	0x00000391
>> +#define MSR_CORE_PERF_GLOBAL_INUSE	0x00000392
>> +
>> +/* Intel IA32_PERF_GLOBAL_INUSE MSR */
>> +#define PERF_GLOBAL_INUSE_PMI_INUSE	BIT_ULL(63)
>>  
>>  #define MSR_PERF_METRICS		0x00000329
>>  
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 437a7bc49bf8..7c05cf5157bf 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -832,6 +832,8 @@ bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>  	case MSR_CORE_PERF_GLOBAL_CTRL:
>>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>>  		return kvm_pmu_has_perf_global_ctrl(vcpu_to_pmu(vcpu));
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +		return vcpu_to_pmu(vcpu)->version >= 4;
>>  	default:
>>  		break;
>>  	}
>> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>  		msr_info->data = 0;
>>  		break;
>>  	default:
>> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status &= ~data;
>>  		break;
>> +	case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>> +		if (data & pmu->global_status_rsvd)
>> +			return 1;
>> +		if (!msr_info->host_initiated)
>> +			pmu->global_status |= data;
>> +		break;
>>  	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>  		if (!msr_info->host_initiated)
>>  			pmu->global_status |= data & ~pmu->global_status_rsvd;
>> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
>> index 0cff369982ae..ae7dd3636e70 100644
>> --- a/arch/x86/kvm/vmx/nested.c
>> +++ b/arch/x86/kvm/vmx/nested.c
>> @@ -719,6 +719,8 @@ static void nested_vmx_merge_pmu_msr_bitmaps(struct kvm_vcpu *vcpu,
>>  	nested_vmx_merge_msr_bitmaps_rw(MSR_CORE_PERF_GLOBAL_CTRL);
>>  	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_STATUS);
>>  	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
>> +	nested_vmx_merge_msr_bitmaps_write(MSR_CORE_PERF_GLOBAL_STATUS_SET);
>> +	nested_vmx_merge_msr_bitmaps_read(MSR_CORE_PERF_GLOBAL_INUSE);
>>  }
>>  
>>  /*
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 4df55a3e21da..3070fba2687f 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -194,6 +194,8 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>  	switch (msr) {
>>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
>>  		return kvm_pmu_has_perf_global_ctrl(pmu);
>> +	case MSR_CORE_PERF_GLOBAL_INUSE:
>> +		return pmu->version >= 4;
>>  	case MSR_IA32_PEBS_ENABLE:
>>  		ret = vcpu_get_perf_capabilities(vcpu) & PERF_CAP_PEBS_FORMAT;
>>  		break;
>> @@ -341,6 +343,38 @@ static bool intel_pmu_handle_lbr_msrs_access(struct kvm_vcpu *vcpu,
>>  	return true;
>>  }
>>  
>> +static u64 intel_pmu_get_global_inuse(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>> +	bool pmi_inuse = false;
>> +	u64 eventsel, data = 0;
>> +	u32 fixed_ctrl;
>> +	int i;
>> +
>> +	kvm_for_each_gp_counter(i, gp_mask) {
>> +		eventsel = pmu->gp_counters[i].eventsel;
>> +
>> +		if (eventsel & ARCH_PERFMON_EVENTSEL_EVENT)
> 
> Why to check ARCH_PERFMON_EVENTSEL_EVENT instead of
> ARCH_PERFMON_EVENTSEL_ENABLE here? Suppose only
> ARCH_PERFMON_EVENTSEL_ENABLE is set, then the counter is in use.

This implementation strictly follows the SDM, which checks the event
bits, not the enable bit. This is also verified on bare metal.

"IA32_PERF_GLOBAL_INUSE.PERFEVTSEL0_InUse[bit 0]: This bit reflects the
logical state of (IA32_PERFEVTSEL0[7:0] != 0)."

That's why, in the reply above to Sashiko, I noted that on bare metal
without a vCPU scheduled in, after a perf event is closed, the counter
could still show as in use. perf/x86 clears the enable bit while keeps
the event bits set.


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794351417;
	b=tk7eFrbu47ycnWb3zG0SKf+pW+67TZnVyFTbhnHbX/zxwsL5pT4GUk/R633aUjPvmknL
	 v2VBsm2vQpQMcgHcnbZ7gpLjnvv0LPtRyKyRtAbBqsmrjXM+SDXlKpk9JrymwnS5EWYbH
	 H6xtTWg7y8vd2PZOU9H0R9ZWbkj0u8iDC73Uzycs6dNwCJ1FXMoFazKXyW7HyzqYx0M0f
	 PnEl4emcfN3vV45tb317NJ3+aKAci+2QKJdIhoAcV86XvoGLM//4GyhHUQPPXd/WtdX4T
	 m02w8bpdhpNFcOSBpo9z9Kzxg7IT+pzQ1tpEF1fZWsSp2CdqLqrjKbhHjWExviUG/CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794351417;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ai3Znd/fj8Zr3JKcSZdZwoxGKhVrA9YIfM8A8QuJLtE=;
	b=RDb7c4l3Lx6M1po5qwdFhYMfr2+bXFYNy4BXgW7VnUZssEvkXvU7q329LJndhaB0urq9
	 C6C7eDYfoprNc7t52NY/4d7obKJf5ZN/YmNfE/Ept7vpGNegUXdD89Wd7jrBEjA9BqRLm
	 ShtPqOkjZ+bd4+MurT1Y4UdRlCCTjWejuE3ZFQYbJ2JL+tmUpc8JI0Tl4B25FBxclykM8
	 9q0pmaXBcgZ+9wKZCYj2BMopdIGMUvtoY5zgrrG1OLVb1OAyzzrUEJrQ4quu+BrdhRul7
	 Azx4blQ9Fq7nyiEV6AnFLDSuy/4FIVVcuyUAAUP6UZ3QBxVQ8MHtrUObiynOcG3Eehw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CZFmGdv6;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB18606A31C;
	Tue, 10 Nov 2026 22:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEB18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CZFmGdv6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794351417; x=1825887417;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=FBElfXLbvZHe93oQxM7b2MP1+tCsFlwyM/KiLupIqxk=;
  b=CZFmGdv63L55MZeTkr6BfFH9pe1kHzTWp9lrbnJOG06D0C4fmDcnKQ0E
   9XPE6RAy3+A3GL7fdAFTEHUKE4yhRI4rgtbWT2HdbZPLdVCTjCR5rWZ8+
   p7nE4097grgwDnwPI8A9V1KmnNq8tAbc0sszGNYbGS6RB+jVCbJr1S6Yy
   qTxFe55q/m7VgbBYPPSIRDpZvwWyfPzdL/DFk0ptIicRFcUh4Rp2mx/IV
   JgTf+rkoVEEjNvgweuWdLRdgyg8p/dah8Hmv/b9tfKmRDyPQcvGx8mEpD
   jkRrd4Nb5ZrHShp+sIiHpHc73DrHFPyfLgjUdhs2JGd0bD8wzcjEAIIkh
   Q==;
X-CSE-ConnectionGUID: mtfooArJQ6O1/aLZg1VLGQ==
X-CSE-MsgGUID: ZZ8Gqgk4Tmm8Jtg5Rot3nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3014080"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="3014080"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 14:56:55 -0800
X-CSE-ConnectionGUID: /lmGekUeT0Kk30RBl86s7A==
X-CSE-MsgGUID: QCvXktl4Q9eVwb3BoLXkJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8267196"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 14:56:53 -0800
Message-ID: <51089074-1be0-47e3-8d53-732ca33f29a2@intel.com>
Date: Tue, 10 Nov 2026 16:56:52 -0600
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
Subject: Re: [PATCH v3 13/18] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
From: "Chen, Zide" <zide.chen@intel.com>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-14-zide.chen@intel.com> <au491iiV7koeP0t6@google.com>
 <f20b59bb-a3c6-4129-ba61-5cec4d975601@intel.com>
 <f12bcb27-9c17-4b8c-b48c-c36a17e70ab6@linux.intel.com>
 <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com>
Content-Language: en-US
In-Reply-To: <5f129d63-10c6-414b-86a9-a604e42038ce@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/10/2026 10:29 AM, Chen, Zide wrote:
> 
> 
> On 11/10/2026 12:28 AM, Mi, Dapeng wrote:
>>
>> On 11/10/2026 4:41 AM, Chen, Zide wrote:
>>>
>>> On 11/6/2026 3:00 PM, Yosry Ahmed wrote:
>>>> On Thu, Nov 05, 2026 at 06:39:22PM -0700, Zide Chen wrote:
>>>>> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
>>>>> This is the superset of EDX[4:0] which indicates the contiguous
>>>>> counters starting from 0. For backward compatibility, it's recommended
>>>>> to use the following to determine if a fixed counter is supported:
>>>>>
>>>>> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
>>>>>
>>>>> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>>> ---
>>>>> v3:
>>>>> - Remove '&' when populating entry->ecx. (Jim)
>>>>> - Gate entry->ecx on kvm_pmu_cap.version >= 5 in intel_pmu_refresh() to
>>>>>   avoid enabling v5 fixed counters on hosts where KVM caps PMU at v2.
>>>>> ---
>>>>>  arch/x86/kvm/cpuid.c         | 5 ++++-
>>>>>  arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
>>>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>>>>> index 3310c370c5fa..00a2ca6d3049 100644
>>>>> --- a/arch/x86/kvm/cpuid.c
>>>>> +++ b/arch/x86/kvm/cpuid.c
>>>>> @@ -1554,7 +1554,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>>>>  
>>>>>  		entry->eax = eax.full;
>>>>>  		entry->ebx = kvm_pmu_cap.events_mask;
>>>>> -		entry->ecx = 0;
>>>>> +		if (kvm_pmu_cap.version >= 5)
>>>>> +			entry->ecx = (u32)kvm_pmu_cap.fixed_cntr_mask64;
>>>>> +		else
>>>>> +			entry->ecx = 0;
>>>>>  		entry->edx = edx.full;
>>>>>  		break;
>>>>>  	}
>>>>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>>>>> index 1372091dc1f8..37b34b588601 100644
>>>>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>>>>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>>>>> @@ -597,7 +597,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>>>>  				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>>>>>  						      KVM_MAX_NR_FIXED_COUNTERS));
>>>>>  
>>>>> +	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
>>>>>  	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>>>>> +	/*
>>>>> +	 * Do not enable fixed counters via the v5 ECX bitmap if KVM caps
>>>>> +	 * PMU version below 5 (e.g. when mediated PMU is disabled or on
>>>>> +	 * older hosts), matching KVM's advertised CPUID.0AH:ECX capability.
>>>>> +	 */
>>>>> +	if (kvm_pmu_cap.version >= 5 && pmu->version >= 5)
>>>> Having to check both versions is confusing. Can they go out of sync?
>>>> Should we clamp pmu->version to kvm_pmu_cap.version and only check the
>>>> former?
>>> Yes, actually, other fields (bit_width, mask_length, and
>>> nr_{gp,fixed}_counters) in intel_pmu_refresh() are clamped to
>>> kvm_pmu_cap as well.
>>>
>>> pmu->version = min_t(int, eax.split.version_id, kvm_pmu_cap.version);
>>
>> I'm not quite sure if we could do such clamp. I remember Sean ever said KVM
>> should allow user space to set the PMU capabilities which KVM doesn't
>> support, like what currently kselftest pmu_counters_test does, e.g., KVM
>> only supports up to PMU version 2 in non-mediated vPMU mode, but
>> pmu_counters_test can set PMU versions larger than 2.
>>
> 
> KVM's principle of "not policing guest CPUID" means KVM allows userspace
> to configure an arbitrary guest CPUID without rejecting the ioctl or
> mutating the vCPUID entries.
> 
> However, KVM's internal vCPU state (pmu->version) tracks the "effective
> PMU version" that KVM can actually virtualize.
> 
> This distinction is documented in commit 4f1bd6b16074 ("KVM: selftests:
> Test Intel PMU architectural events on gp counters"):
> 
> "KVM only officially supports up to version 2, but the behavior of the
> counters is backwards compatible, i.e. KVM shouldn't do something
> completely different for a higher, architecturally-defined vPMU version.
> Verify KVM behavior against the effective vPMU version, e.g. dvertising
> vPMU 5 when KVM only supports vPMU 2 shouldn't magically unlock vPMU 5
> features."
> 
> pmu_counters_test itself explicitly mentions this rule:
> 
> /*
>  * Return the effective PMU version, i.e. the minimum between what KVM
>  * supports and what is enumerated to the guest.  The host deliberately
>  * advertises a PMU version to the guest beyond what is actually
>  * supported by KVM to verify KVM doesn't freak out and do something
>  * bizarre with an architecturally valid, but unsupported, version.
>  */
>   return min_t(u8, kvm_pmu_version,
> this_cpu_property(X86_PROPERTY_PMU_VERSION));
> 
> In my understanding, clamping pmu->version perfectly reflects the above
> rule, and it's similar to other KVM code, e.g.:
> 
>         eax.split.bit_width = min_t(int, eax.split.bit_width,
>                                     kvm_pmu_cap.bit_width_gp);
>         eax.split.mask_length = min_t(int, eax.split.mask_length,
>                                       kvm_pmu_cap.events_mask_len);
> 
> Without a PMU version cap, guest resource validation could become
> increasingly complicated as more advanced PMU features are supported, as
> KVM would need to allow the guest to access PMU resources only when it
> satisfies both the vPMU version and the KVM capability.

The above sounds reasonable at first glance, but in practice it is
problematic because it arbitrarily masks out features that can be 100%
emulated in software even when there is zero host hardware dependency:

- Features that can be emulated entirely in software (e.g. there is no
problem emulating the PerfMon v5 AnyThread deprecation, or emulating
MSRs like GLOBAL_STATUS_SET or GLOBAL_INUSE on a v2/v3 host). Clamping
the version unnecessarily prevents the guest from using features that
correspond to its configured PMU version.

- Features that actually need host hardware support need to be checked
against both guest and host PMU capabilities.

I'd propose something like this instead, leaving pmu->version unclamped:

static inline bool kvm_pmu_has_version(struct kvm_pmu *pmu, u8 version)
{
        return pmu->version >= version &&
               kvm_pmu_cap.version >= version;
}

/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
if (kvm_pmu_has_version(pmu, 5))
      fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);

And potentially this API can be used for other advanced features like
CPUID leaf 0x23H, PMUv6, etc.

>>>
>>> Without this, as more advanced PMU features are supported in KVM, we
>>> will have to manually validate guest features, and it seems this doesn't
>>> violate the general principles of "not policing CPUID configurations"
>>> and using the "effective vPMU version".
>>>
>>>>> +		fixed_mask |= entry->ecx;
>>>>>  	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
>>>> I see why this is needed now, to re-apply KVM's fixed counter mask after
>>>> reading it, but if this is only needed there, it's probably clearer to
>>>> do:
>>>>
>>>> 	if (version >= 5)
>>>> 		fixed_mask |= (entry->ecx & kvm_pmu_cap.fixed_cntr_mask64);
>>> Agreed, this is cleaner. Will update accordingly. Thanks!
> 


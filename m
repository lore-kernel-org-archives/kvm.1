Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD38286A4;
	Fri, 31 Jul 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459025; cv=none; b=s4H9MXOnn6681hrIVdBqY7qZMXTeCSMdjCUZ47YBvrWRKGUPu6XMkdKscWf1/uvx/cKacXK+ua1EyCVP49oC1wbxSqKelhWkcfRbYkeHFs6WZqPuxfXNqRmMwLwBjUR25owSg/27TZB4GWsFYJydpluMTdQXcsYb/SFAcZqn+ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459025; c=relaxed/simple;
	bh=GQgUCicHeFn563f1WIJfLzxhTUk47BUk/CIQaaBqbss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f+YOvY/epC8hpE43hHhaRLMVs8oM7zUexNQ7SVBkwYt1dRsy3TaThiFHzqdmgR5zRv392k8uOvAbWPN3utTdFs4FqWLjrDaSasVbV2fywMiP6+bkrWsctTBoJSSYL6RkhbfC7pciJyyMejFbZDS6+HlDfc4Q4ga76LGtyn8TkkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnhW1CWv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnhW1CWv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785459022; x=1816995022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GQgUCicHeFn563f1WIJfLzxhTUk47BUk/CIQaaBqbss=;
  b=dnhW1CWvz8g4y3tPep24pPCeQxbE/FCpU0crBDOXwxSnm+8KQZ1OIg8S
   mVnu3Rzpv8zCTgEGUUNy0/VH3FjEQjVbAuOfNjLI7+NtdjU0PxlvTVps6
   dZ6XUNZXFprnYQ/pLY8u15SE2s7YZpKyZaotPLnHDivHZ4AqJAWSDXcBH
   r6oUKox0GnGUEhYkXuWaqT02Z0r3btXRA8/oPvLuTHP4As29dgwsnFShu
   FYD0ayXeiKbajgaKm/2ai/+Zie/nHtD6KueU/xcLfGjML64Sf0znF/IXF
   YH15tzdr+B/OrphJgro0i6LzZAfDW4CxntC9ktXleMC/S4LiqLxbH7cJ9
   A==;
X-CSE-ConnectionGUID: 8JrIWgDFQwujRYaPVQi9xQ==
X-CSE-MsgGUID: lw+YpBaXRzqAlgPDWQl1xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86036746"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="86036746"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:50:22 -0700
X-CSE-ConnectionGUID: YsInxz/dSduRH1Ns6TmKyQ==
X-CSE-MsgGUID: ktw/BC8qS7mH2qkgjPsPNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265506980"
Received: from ylu48-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 17:50:20 -0700
Message-ID: <b96073d4-6e6e-4188-bcee-5ff0feeebc96@linux.intel.com>
Date: Fri, 31 Jul 2026 08:50:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to known
 CPUs
To: "Chen, Zide" <zide.chen@intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-8-zide.chen@intel.com>
 <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
 <f8f9fc13-fafc-4828-ad5b-79e3677d9536@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <f8f9fc13-fafc-4828-ad5b-79e3677d9536@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/30/2026 11:05 PM, Chen, Zide wrote:
>
> On 7/29/2026 9:51 PM, Mi, Dapeng wrote:
>> On 7/28/2026 3:21 AM, Zide Chen wrote:
>>> RDPMC type encodings are vendor-defined and could theoretically be
>>> extended on future CPUs. An unknown RDPMC type could leak host
>>> PMU information to the guest through RDPMC passthrough.
>>>
>>> Rather than assuming future CPUs are safe, explicitly permit only
>>> reviewed CPU models and require RDPMC interception everywhere else.
>>> This ensures RDPMC passthrough is enabled only on CPUs whose RDPMC
>>> encodings are audited and supported by KVM.
>>>
>>> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> Suggested-by: Jim Mattson <jmattson@google.com>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> v7: new patch.
>>> ---
>>>  arch/x86/kvm/pmu.c | 32 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 32 insertions(+)
>>>
>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>> index 51c6d00a485f..092809bd757d 100644
>>> --- a/arch/x86/kvm/pmu.c
>>> +++ b/arch/x86/kvm/pmu.c
>>> @@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
>>>  	{}
>>>  };
>>>  
>>> +/*
>>> + * CPUs whose RDPMC encodings have been audited for KVM RDPMC
>>> + * passthrough support.
>>> + */
>>> +static const struct x86_cpu_id kvm_rdpmc_known_cpus[] = {
>>> +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
>>> +	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
>>> +	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
>>> +	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
>>> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
>>> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
>>> +	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
>>> +	{}
>>> +};
>>> +
>>>  /* NOTE:
>>>   * - Each perf counter is defined as "struct kvm_pmc";
>>>   * - There are two types of perf counters: general purpose (gp) and fixed.
>>> @@ -807,6 +822,20 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>>  }
>>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>>  
>>> +static bool kvm_rdpmc_encoding_supported(void)
>>> +{
>>> +	/* KVM understands all RDPMC encodings prior to PMU v6. */
>>> +	if (kvm_host_pmu.version < 6)
>> I'm not sure if this works for AMD platforms. Jim said current AMD
>> platforms already have security holes and I believe the PMU version of AMD
>> platforms are less than 6.
>>
>> Need AMD guys to confirm. @Sandipan, @Manali.
>>
>>
>>> +		return true;
>>> +
>>> +	/*
>>> +	 * Future PMU v6 implementations and future PMU versions require RDPMC
>>> +	 * interception until their RDPMC encodings are audited and supported
>>> +	 * by KVM.
>>> +	 */
>>> +	return x86_match_cpu(kvm_rdpmc_known_cpus);
>> x86_match_cpu() returns structure x86_cpu_id pointer or NULL instead of a
>> boolean variable. Better explicitly covert it to a boolean variable.
>>
>> return x86_match_cpu(kvm_rdpmc_known_cpus) != NULL;
> I think the implicit conversion is valid here. In C99, implicit
> conversion from a pointer to bool is well-defined, and is commonly used,
> e.g. if (x86_match_cpu(...)).
>
> bool is a typedef of _Bool.
>
> C99 6.3.1.2 "Boolean type":
>
> When any scalar value is converted to _Bool, the result is 0 if the
> value compares equal to 0; otherwise the result is 1.

Yeah, the implicit conversion is fine in theory. But the explicit
conversion seems more intuitionistic for me. Anyway, you can decide which
way you want. :)


>
>
>>> +}
>>> +
>>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>>  {
>>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>> @@ -818,6 +847,9 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>>  	if (enable_vmware_backdoor)
>>>  		return true;
>>>  
>>> +	if (!kvm_rdpmc_encoding_supported())
>>> +		return true;
>>> +
>>>  	return kvm_need_any_pmc_intercept(vcpu) ||
>>>  	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>>>  	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);
>

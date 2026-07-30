Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38C42D73B5;
	Thu, 30 Jul 2026 15:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423906; cv=none; b=VZ2k/1XmaKyMVNEv2Ra+22z2f2NM57uw3pXzzxM4B7qLs8HwdWjo38H0rNwIVcopvzmcTlb726HFrq6qpalD992vzZf+HNQfSeUz+yToReneyBOFY5I/qKnPRTeapg2VhIq7Q+6hX1dqjwCm3qz5Ici21VLlYgiDDYgON58+Qro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423906; c=relaxed/simple;
	bh=gJ7TnPhEIeOzIIuibxIp7mmsCMwz2MLwe9ZswdSYqMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OagSSVN6o6KRH2yrhnr41LqD1BfJ/HHDWqn7Em0kuiSEELqDg+mSAP5kRgSHI/I6kmsBUvKHShRaaWqumogiqXxrolN19gBVVgHBfQEmO4sgKPJRqnJlzZVS9ijNm2Ekm0LAxu2YflOO0vf7Hocbeaiy/BxsCuCfHV604RaH01c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6MDvQYL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6MDvQYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785423904; x=1816959904;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gJ7TnPhEIeOzIIuibxIp7mmsCMwz2MLwe9ZswdSYqMw=;
  b=E6MDvQYLWb+cUK4JEs2dO+K3Zsaa4/0JqWFLFkwT0FqwRPrzKWh7IKH+
   SuwOxwkG6XRDFuBfXAg27JXARnHNbn7/53HDfvrV+rOsbPMxoR7pzQ7hM
   S+pqsEFU6IMgulYDhQtSqVduAScIZ9fdJSDdQ4aYOXaHLO9toVhbjty3D
   DmFqq2w2K5Uwg/Utz/ONlNqyLfrOOYlq9SYbUWzlvk1pLM3Nl66ZAyVyO
   /XP0r2u2dFWArUeINzBUTQfcgec7x5yaWf4BYhd9Klkkmhot3SGgzefU1
   NBkKQdhDyAArxWhIh6poxb7OTc8Wsb1UoBXSwHYBDBTyKEPv86FH838Oo
   w==;
X-CSE-ConnectionGUID: a3CQmfuzQAW4LLtZI+5o2w==
X-CSE-MsgGUID: ovgOQT94Qkm2wfFND7KkBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="103452218"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="103452218"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 08:05:03 -0700
X-CSE-ConnectionGUID: rErET3YTTFOcHvqJfg+OBA==
X-CSE-MsgGUID: RWv7+4oWSYaWz7kdvDpS3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="260380510"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 08:05:03 -0700
Message-ID: <f8f9fc13-fafc-4828-ad5b-79e3677d9536@intel.com>
Date: Thu, 30 Jul 2026 10:05:01 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] KVM: x86/pmu: Restrict RDPMC passthrough to known
 CPUs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-8-zide.chen@intel.com>
 <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <a6481eb0-0480-41f2-97c3-ab5f278f7e50@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/29/2026 9:51 PM, Mi, Dapeng wrote:
> 
> On 7/28/2026 3:21 AM, Zide Chen wrote:
>> RDPMC type encodings are vendor-defined and could theoretically be
>> extended on future CPUs. An unknown RDPMC type could leak host
>> PMU information to the guest through RDPMC passthrough.
>>
>> Rather than assuming future CPUs are safe, explicitly permit only
>> reviewed CPU models and require RDPMC interception everywhere else.
>> This ensures RDPMC passthrough is enabled only on CPUs whose RDPMC
>> encodings are audited and supported by KVM.
>>
>> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Suggested-by: Jim Mattson <jmattson@google.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v7: new patch.
>> ---
>>  arch/x86/kvm/pmu.c | 32 ++++++++++++++++++++++++++++++++
>>  1 file changed, 32 insertions(+)
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 51c6d00a485f..092809bd757d 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -77,6 +77,21 @@ static const struct x86_cpu_id vmx_pebs_pdist_cpu[] = {
>>  	{}
>>  };
>>  
>> +/*
>> + * CPUs whose RDPMC encodings have been audited for KVM RDPMC
>> + * passthrough support.
>> + */
>> +static const struct x86_cpu_id kvm_rdpmc_known_cpus[] = {
>> +	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X, NULL),
>> +	X86_MATCH_VFM(INTEL_LUNARLAKE_M, NULL),
>> +	X86_MATCH_VFM(INTEL_NOVALAKE, NULL),
>> +	X86_MATCH_VFM(INTEL_NOVALAKE_L, NULL),
>> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_L, NULL),
>> +	X86_MATCH_VFM(INTEL_PANTHERLAKE_R, NULL),
>> +	X86_MATCH_VFM(INTEL_WILDCATLAKE_L, NULL),
>> +	{}
>> +};
>> +
>>  /* NOTE:
>>   * - Each perf counter is defined as "struct kvm_pmc";
>>   * - There are two types of perf counters: general purpose (gp) and fixed.
>> @@ -807,6 +822,20 @@ bool kvm_need_perf_global_ctrl_intercept(struct kvm_vcpu *vcpu)
>>  }
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_need_perf_global_ctrl_intercept);
>>  
>> +static bool kvm_rdpmc_encoding_supported(void)
>> +{
>> +	/* KVM understands all RDPMC encodings prior to PMU v6. */
>> +	if (kvm_host_pmu.version < 6)
> 
> I'm not sure if this works for AMD platforms. Jim said current AMD
> platforms already have security holes and I believe the PMU version of AMD
> platforms are less than 6.
> 
> Need AMD guys to confirm. @Sandipan, @Manali.
> 
> 
>> +		return true;
>> +
>> +	/*
>> +	 * Future PMU v6 implementations and future PMU versions require RDPMC
>> +	 * interception until their RDPMC encodings are audited and supported
>> +	 * by KVM.
>> +	 */
>> +	return x86_match_cpu(kvm_rdpmc_known_cpus);
> 
> x86_match_cpu() returns structure x86_cpu_id pointer or NULL instead of a
> boolean variable. Better explicitly covert it to a boolean variable.
> 
> return x86_match_cpu(kvm_rdpmc_known_cpus) != NULL;

I think the implicit conversion is valid here. In C99, implicit
conversion from a pointer to bool is well-defined, and is commonly used,
e.g. if (x86_match_cpu(...)).

bool is a typedef of _Bool.

C99 6.3.1.2 "Boolean type":

When any scalar value is converted to _Bool, the result is 0 if the
value compares equal to 0; otherwise the result is 1.


>> +}
>> +
>>  bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> @@ -818,6 +847,9 @@ bool kvm_need_rdpmc_intercept(struct kvm_vcpu *vcpu)
>>  	if (enable_vmware_backdoor)
>>  		return true;
>>  
>> +	if (!kvm_rdpmc_encoding_supported())
>> +		return true;
>> +
>>  	return kvm_need_any_pmc_intercept(vcpu) ||
>>  	       pmu->counter_bitmask[KVM_PMC_GP] != (BIT_ULL(kvm_host_pmu.bit_width_gp) - 1) ||
>>  	       pmu->counter_bitmask[KVM_PMC_FIXED] != (BIT_ULL(kvm_host_pmu.bit_width_fixed) - 1);


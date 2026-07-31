Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1A35C6B1;
	Fri, 31 Jul 2026 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529738; cv=none; b=rux0zWduVIDQLXsZ9ey+3dhE20qrWR2xM5rWQmPS6yaicXL8/GgfdMdtPK1gvnW2rNBk+wzREGq7JfvleGEIC95vMdLrAPr+JMU9+EpADkdqLv2HD8BJaajYnYlNT0APZY0t+SpamNGReFm0Tir3hICxNWBKqErqm6ZzfPCDv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529738; c=relaxed/simple;
	bh=4X6+7Qi9rentiho+U9TWI6rXHYVOMBxs/UVAtq+13sE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D/9w+N2JIxfdppt2oSa/Ss5nigsi/ukbv6cqD0T9uU8oB3i3jI45P+l0c9IQp5lYL1KkQERAu+F1O7oxziKMS2GFU8l9kh8ChFlp6hAerxBG9JnQmPffucPT/NerivpWMjnYyz4gNW9OaVqylA0Otw1W/CSng+MNEs4aTRptQNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZulNCeS+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZulNCeS+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785529737; x=1817065737;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=4X6+7Qi9rentiho+U9TWI6rXHYVOMBxs/UVAtq+13sE=;
  b=ZulNCeS+mirPFYCVninZmNVrykn9WoZpoLkxn3lcvtVBYoltpvKyu/ou
   cvNzAihkrN+QLg8pkTzvgobdC++sMHNP1AGCWpUGsevMfMFr5erHAkEFZ
   G85kxpTNM3/uYHi1vAQTYJk9gd4Hg/oX+ejG33E0aDQAJQoxdLcQQNAHd
   /4/XcyNvpNR8VRA3KD/4drnDIXMw8+CofXQg2ecvpdJBUsvj8m38WPGRH
   9QtjVQVzolR54XYtGZYNet7vGhbVfFAsIkIRO1qhTeeZf0iq9vzuIeHML
   z2H+sIJ6OWlHKsjUDEbptXaEHIgP6KpTyRQxnDzilZZp+7pRj5ulvJfRA
   g==;
X-CSE-ConnectionGUID: 4ZWvgUC+RyOJwobFhenW4w==
X-CSE-MsgGUID: yc+yb/lPSNWJxpyqslQUeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86175703"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="86175703"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 13:28:56 -0700
X-CSE-ConnectionGUID: QT+jL2NERwGOhpa0zncZYA==
X-CSE-MsgGUID: KR9BDgYcSLGPY50Y4rU7Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="284007975"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 13:28:55 -0700
Message-ID: <0997911f-3605-4ff7-b89b-bbe6c7a04095@intel.com>
Date: Fri, 31 Jul 2026 15:28:54 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Chen, Zide" <zide.chen@intel.com>
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
 <a3fd76f2-96cd-4d56-8a58-f86b2270c56e@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a3fd76f2-96cd-4d56-8a58-f86b2270c56e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/2026 8:12 PM, Mi, Dapeng wrote:
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
> 
> Zide, it seems this list is incomplete. The
> DMR/ARL(INTEL_ARROWLAKE/INTEL_ARROWLAKE_H) should be secure as well. Thanks.

Thanks for pointing that out. I didn't realize that some Arrow Lake
models are PMU v6.

However, all of the client CPUs listed above are hybrid CPUs, and KVM
does not currently support vPMU on hybrid platforms.Therefore, only
Clearwater Forest and Diamond Rapids need to be included in this list
for now. I'll add a comment documenting the exclusion of hybrid CPUs.

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
>> +		return true;
>> +
>> +	/*
>> +	 * Future PMU v6 implementations and future PMU versions require RDPMC
>> +	 * interception until their RDPMC encodings are audited and supported
>> +	 * by KVM.
>> +	 */
>> +	return x86_match_cpu(kvm_rdpmc_known_cpus);
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


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD13221265;
	Fri, 27 Mar 2026 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644804; cv=none; b=YpoD0MVE106KDLvOZMUiLf+shWtQmuv3mf0Miul4jwp3KJBOOWbltLK4XvCOv4I+uwkSRQoWgtrMC/7wDhgnHwjZIskaeieA/GtbW+Y39YQhX8SBY1+DYRZ18qrQPRs90sBzwTjWGqvL2J3zvkqMT8JI7ysZM4BHcyoRgiI9O4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644804; c=relaxed/simple;
	bh=eEugc8t5pgiuzczKwsspjpIM3kBN+pWWZIDzezaPAmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrLah2VACFVUcTzBHStrAO24eGT2TOkJ8ecpwtER0avaH2KPBlwcYWcfpafOOI2l1OdrF5Wi+AC72L56W3+ZeEmoXP3/tuzTSorHJE+UYIq3fJV1L3qDY2Aq+wyuysjXDqAyMODEuYGH8gHJJ21bsBL+B2KRg0RUmYeyaLZ9dJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVhXDd64; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVhXDd64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774644803; x=1806180803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eEugc8t5pgiuzczKwsspjpIM3kBN+pWWZIDzezaPAmc=;
  b=WVhXDd64sBj1nVX3FdnCZiO4klDotuvwkP+07+RGLarOWTOK/tni26Yv
   vvIfX9rQuzo2Rv/6lKPopKjNsTLT8zOOfRKl77mcTaaciP9JDz/ceVORo
   aUoeMAcCGafCXZmiqugCvk5uAdw2SQl7+XstPNB75Q27/YlT/Kam/wdXr
   tXtnhObpixzQYGMwx3gb7XoF2kYNjmwlcrznG4C6QNQLJlx/F/G1e7cjg
   ekTj/xY2LK65nI/fH+7ftA0tJ6IUvbAjiBU3V0SfZDCG6Mv+oOoGdxZyl
   Os3DNYGb5eOqTffP+qD9YN0wHtSDwWvQ84TAKBAR6UNpyK7AZ4PLtbXN3
   Q==;
X-CSE-ConnectionGUID: vLqsiPg2Rziog0mOavgt0g==
X-CSE-MsgGUID: j3CJTqCeRuStXT550vdnRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="63279569"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="63279569"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:53:22 -0700
X-CSE-ConnectionGUID: wbXB46noTLi7HFsl5MYUAg==
X-CSE-MsgGUID: 9XuiyE0rSsWjqmcFtm54kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="222104554"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.241.240.169]) ([10.241.240.169])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:53:22 -0700
Message-ID: <d7827dd3-a37e-42a5-ba84-3517147d10a4@intel.com>
Date: Fri, 27 Mar 2026 13:53:21 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: x86/pmu: Do not map fixed counters >= 3 to
 generic perf events
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260226230606.146532-1-zide.chen@intel.com>
 <20260226230606.146532-2-zide.chen@intel.com>
 <e94e4b40-11e4-4dce-adc7-6a9ce4993480@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <e94e4b40-11e4-4dce-adc7-6a9ce4993480@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/23/2026 10:48 PM, Mi, Dapeng wrote:
> 
> On 2/27/2026 7:06 AM, Zide Chen wrote:
>> Only fixed counters 0..2 have matching generic cross-platform
>> hardware perf events (INSTRUCTIONS, CPU_CYCLES, REF_CPU_CYCLES).
>> Therefore, perf_get_hw_event_config() is only applicable to these
>> counters.
>>
>> KVM does not intend to emulate fixed counters >= 3 on legacy
>> (non-mediated) vPMU, while for mediated vPMU, KVM does not care what
>> the fixed counter event mappings are.  Therefore, return 0 for their
>> eventsel.
>>
>> Also remove __always_inline as BUILD_BUG_ON() is no longer needed.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/kvm/vmx/pmu_intel.c | 26 ++++++++++++++------------
>>  1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
>> index 27eb76e6b6a0..4bfd16a9e6c7 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.c
>> +++ b/arch/x86/kvm/vmx/pmu_intel.c
>> @@ -454,28 +454,30 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>   * different perf_event is already utilizing the requested counter, but the end
>>   * result is the same (ignoring the fact that using a general purpose counter
>>   * will likely exacerbate counter contention).
>> - *
>> - * Forcibly inlined to allow asserting on @index at build time, and there should
>> - * never be more than one user.
>>   */
>> -static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>> +static u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>>  {
>>  	const enum perf_hw_id fixed_pmc_perf_ids[] = {
>>  		[0] = PERF_COUNT_HW_INSTRUCTIONS,
>>  		[1] = PERF_COUNT_HW_CPU_CYCLES,
>>  		[2] = PERF_COUNT_HW_REF_CPU_CYCLES,
>>  	};
>> -	u64 eventsel;
>> -
>> -	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
>> -	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
>> +	u64 eventsel = 0;
> 
> I'm not sure if we can directly add the "slots" event support in the
> perf_hw_id list. It looks more straightforward, but it need to involve perf
> changes and impact all architectures. Not sure if it's worthy to do it.
> Current way is fine for me if we decided not to support the fixed counter 3
> for  the legacy emulated vPMU.

If the emulated vPMU does not intend to support fixed counter 3 and
above, which is currently the case, I do not see any benefit in
extending enum perf_hw_id, which is generic across platforms.

> Maybe one minor optimization, we can directly return here and then don't
> need to add so much indents, e.g.,
> 
> if (index >=3)
> 
>     return eventsel;

Yes, Agreed. The code is cleaner and it's more logical.

> 
> 
>>  
>>  	/*
>> -	 * Yell if perf reports support for a fixed counter but perf doesn't
>> -	 * have a known encoding for the associated general purpose event.
>> +	 * Fixed counters 3 and above don't have corresponding generic hardware
>> +	 * perf event, and KVM does not intend to emulate them on non-mediated
>> +	 * vPMU.
>>  	 */
>> -	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
>> -	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
>> +	if (index < 3) {
>> +		/*
>> +		 * Yell if perf reports support for a fixed counter but perf
>> +		 * doesn't have a known encoding for the associated general
>> +		 * purpose event.
>> +		 */
>> +		eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
>> +		WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
>> +	}
>>  	return eventsel;
>>  }
>>  


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7F377A80
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190766; cv=none; b=q9LSQNU9USuI+aew0EkJVmdHzTAcG2hh/R65wl31OzjGNrrv+ml3fufwHUgP3qOP84+M6zX0zclDkc3IRD7iYwqEK/t65UgkwpCz+HP6jH6BNXU5aQARw97zBD78SYNz54QrfRqpmICnVoUdzQZsVv85/qqZuRDxDM7tPhL56cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190766; c=relaxed/simple;
	bh=MszF1Kaa/fggKH06U54W/zvEcJZW7NGNN1vbgNvfIjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2Ii2bL9v4BHauWrIps5HIG9DK3VthlQanPsxRLq2Go+gHypCfyN/eXZF/9FJwBIUKi0PsmtHm0WfxCw+Woy7xl4C+kFhddmTX19oUV4nAj/jGAlZ8UXSFwqBlgw6AiWu04CVdC9IGXfHGxNozRast8HyfP6Dv+ud1X2bfMZhMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fb69jo1w; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fb69jo1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785190764; x=1816726764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MszF1Kaa/fggKH06U54W/zvEcJZW7NGNN1vbgNvfIjs=;
  b=fb69jo1wlMFGbTuscMpUmxAJ0SNC9O56c9uG5w3J1ZLY7X0T758Wv/Yy
   wTPcFVkSRK1W8I1RNyhzcfHBBHgoZPjNpCy5hK1rw0Awj09cH/B0D5/hF
   glA+uFoVDCa0DdGCT9nJH0j7SaRe4z85gxZP690237h+wWVETuFO4WKT+
   dXgoxy7lRFHcH1f0nCFf0QIOluoe+M0mvDO1LWS1ku76Vm2oRu2gaI9lu
   Z16p/9wKmppZaVFg2ihB3YzUa1q+QyNpsbUIKAwPC+OHFJv0zaQ5jhPrL
   XEqRiYuX5+Er+gOR0uhe+mQpyMMzYjAtYkCo5b9HO/LtvEWGZ8Ve65MiB
   w==;
X-CSE-ConnectionGUID: hNmqkAzgRsmyF1APcQ9fng==
X-CSE-MsgGUID: 6JLp9iOdSPSsEKOahIL//Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="89659165"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="89659165"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:19:23 -0700
X-CSE-ConnectionGUID: 32Xx4bhvSfacv9mqH+JxEg==
X-CSE-MsgGUID: s80FvdNeTVCBUHNrRsCDaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="289493441"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 15:19:24 -0700
Message-ID: <9920cca0-b94f-4dc1-9bc8-6c9c91579e19@intel.com>
Date: Mon, 27 Jul 2026 17:19:22 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] KVM: x86/pmu: Rename and move
 vcpu_get_perf_capabilities() to pmu.h
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260727192131.582105-1-zide.chen@intel.com>
 <20260727192131.582105-4-zide.chen@intel.com>
 <20260727194246.159341F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260727194246.159341F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/27/2026 2:42 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing explicit header inclusions after refactoring.
> --
> 
> --- Patch [3]: [PATCH v7 3/9] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h ---
> commit fb5ce8bc24fb7de4e71c57bef960ab9beca9bc0b
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
> 
> This commit renames vcpu_get_perf_capabilities() to kvm_vcpu_get_perf_caps()
> and moves it from pmu_intel.h to pmu.h to make it accessible to common x86
> code.
> 
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index a5821d7c87f93..1b2f66a2e9153 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -271,6 +271,14 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
>>  				  X86_PMC_IDX_MAX);
>>  }
>>  
>> +static inline u64 kvm_vcpu_get_perf_caps(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
>> +		return 0;
> 
> [Severity: Low]
> Does this file need an explicit include for cpuid.h?
> 
> Since kvm_vcpu_get_perf_caps() relies on guest_cpu_cap_has() defined in 
> cpuid.h, it seems like pmu.h should now explicitly include cpuid.h to remain
> self-contained, even if it happens to compile due to implicit includes in
> the compilation units.

It sounds reasonable, but I'd prefer to keep it as-is.

Adding cpuid.h to pmu.h would make pmu.h more self-contained, but it
would also naturally lead to removing now-redundant cpuid.h includes
from PMU-related files such as vmx/pmu_intel.c, svm/pmu.c, and
potentially others.

I'd like to keep the current patch focused on the functional change and
avoid mixing it with include dependency cleanup.

>> +
>> +	return vcpu->arch.perf_capabilities;
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
>> index 5d9357640aa18..afdbbc9991d6d 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.h
>> +++ b/arch/x86/kvm/vmx/pmu_intel.h
>> @@ -6,17 +6,9 @@
>>  
>>  #include "cpuid.h"
>>  
>> -static inline u64 vcpu_get_perf_capabilities(struct kvm_vcpu *vcpu)
>> -{
>> -	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_PDCM))
>> -		return 0;
>> -
>> -	return vcpu->arch.perf_capabilities;
>> -}
>> -
>>  static inline bool fw_writes_is_enabled(struct kvm_vcpu *vcpu)
>>  {
>> -	return (vcpu_get_perf_capabilities(vcpu) & PERF_CAP_FW_WRITES) != 0;
>> +	return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_FW_WRITES) != 0;
>>  }
> 
> [Severity: Low]
> Is the include for cpuid.h at the top of this snippet still needed now that
> the function relying on it has moved out of pmu_intel.h?

Yes, I think #include "cpuid.h" can be cleanly removed now.

> Also, since fw_writes_is_enabled() now calls kvm_vcpu_get_perf_caps(), would
> it be better to add an explicit include for pmu.h here to ensure header
> dependencies are fully self-contained?

I don't think that's necessary, since it's natural to include the common
pmu.h before the vendor-specific pmu_intel.h.


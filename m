Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696473AC0DD
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 21:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003111; cv=none; b=QRN9MbKE8Pj8MxAWMlINSsgulLTWvyk5T4MYRUbE5BSFW3K0AEoFzDIzIR7JoVYKtfA6/R6yaQmjBJ9SFrXe7yJiHV9eckb0suE6M3btyu6HVwGq0nvH+WHtoS4ri/M1aYBCzCDagZdMGt1RC2qFkM1mQJiJ7p7CVC2v3Ne3Z1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003111; c=relaxed/simple;
	bh=U5rbhSr6xqEfux6hu+NbOHBIwlQc0MOPm6nX42CS0uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYIjKfFu8jTjPIVb10EUxv8xhoH1GHOLqVe3UIhVTu8UwVGMGRwMIOb3my6suTnJLbwztk/Ky8d9RbBNulvaMlremTEvZq0U3rPSvg4pFR0jZ3rMudpOE2OoTeW7PBoGJ/I5upu2KWf4rTA+G8+TQ0CfJFUpnUj7wproDe6wGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+pZEnsj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+pZEnsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787003109; x=1818539109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U5rbhSr6xqEfux6hu+NbOHBIwlQc0MOPm6nX42CS0uE=;
  b=J+pZEnsjgdMx6KyriQ9z1/zAAKB3hU4JWpqFJycngZX3m/ENbq84gHY7
   JzoYyMONQD8oBLPZIjhb2CGfVj2g7p7VSfp4TQOXmG7N60UGvd3Grluof
   E8Aj8G+2MAf4iEg/X7KYewPMFV8tD3mL265lf+RDW+ujPWgjl6kG1jypn
   6uyp92M5PRCsocAsTAPIeLpz7CDZ+e24Eud+W3K4kbQvUBRPj6Jncm2RL
   o0IcUyqlKpjvr0hqvsjMd2bwZyGfEu8EW5BidXOHCEBGOk4gMd6ligOgM
   QuNU/QGLOzJjIXA4eOVxZTkzpGGS91prHDRC5JXkwcAvwzvQk12z5ypTU
   Q==;
X-CSE-ConnectionGUID: /p6xHUIJTayttmbTxcDaMw==
X-CSE-MsgGUID: Fl5Al2I4R0KHQpFdwqRNGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="75017791"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="75017791"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 14:45:08 -0700
X-CSE-ConnectionGUID: xSWDHz0sSEiNWVzYsuGxwg==
X-CSE-MsgGUID: VMbRh32sRQus1kXceMUnlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="263275593"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 14:45:08 -0700
Message-ID: <04be3602-dfd6-4415-bec1-33ff062e2980@intel.com>
Date: Mon, 17 Aug 2026 16:45:07 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] KVM: x86/pmu: Rename and move
 vcpu_get_perf_capabilities() to pmu.h
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260817183143.226156-1-zide.chen@intel.com>
 <20260817183143.226156-4-zide.chen@intel.com>
 <20260817185210.C9FA61F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260817185210.C9FA61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/17/2026 1:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Header files pmu.h and pmu_intel.h lack required includes, violating self-contained header practices.
> --
> 
> --- Patch [3]: [PATCH v8 3/8] KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h ---
> commit 7eb009fb5328b80368e10acda6cfe621b3e1e1c0
> Author: Zide Chen <zide.chen@intel.com>
> 
> KVM: x86/pmu: Rename and move vcpu_get_perf_capabilities() to pmu.h
> 
> This commit renames vcpu_get_perf_capabilities() to kvm_vcpu_get_perf_caps()
> and moves it to the common x86 PMU header. This prepares the function to be
> called from common x86 code to check the guest's PERF_METRICS capability.
> 
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index 090c9bbb74f48..82f955e5a4507 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
> [ ... ]
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
> Does this file need to include cpuid.h? guest_cpu_cap_has() is used here,
> but pmu.h does not include the header that defines it.

Copied from my reply in v7 review:

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
>>  void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
> [ ... ]
>> diff --git a/arch/x86/kvm/vmx/pmu_intel.h b/arch/x86/kvm/vmx/pmu_intel.h
>> index 5d9357640aa18..dd447d8b6fdde 100644
>> --- a/arch/x86/kvm/vmx/pmu_intel.h
>> +++ b/arch/x86/kvm/vmx/pmu_intel.h
>> @@ -4,19 +4,9 @@
>>  
>>  #include <linux/kvm_host.h>
>>  
>> -#include "cpuid.h"
>> -
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
> 
> [Severity: Low]
> Should pmu_intel.h include pmu.h? It calls kvm_vcpu_get_perf_caps() which
> is now defined in pmu.h, but the include appears to be missing.
> 
>>  }
>>  
>>  bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);
> 


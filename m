Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64334D929;
	Tue, 28 Apr 2026 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370228; cv=none; b=T+UFxMhZpaMtTceFlPIubfVqT9j9ePUXzB5Lzn902Pr+7ocPC4D1muIUEX5IKHHxGE9WrGDZ0amWjf8kk0CxWZEoGhs9g+LJjpX2J1nzD7niifGTWLmutCZcwkZ72zvhCzTJnw+kgAwe36cZ4a25KNlzFkFB4Cw74wE8OM8klcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370228; c=relaxed/simple;
	bh=ivjX7c8hOdX72Jb8wVPa7zi9Lf92o05+IfwqAPmQCzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn2+bOAtZOOjh6TFlq6fCQxkae8aNP/3ys/q1v7NlfBlX+PgjSgsQyCPTdx2/CtPSSLQRlGjcVjzX/Rvxu9KWeSsl/URxnE4NBcb3AIs4kRQIktvQmi2b75o6MtSvawgWzo+amY8OE6B2z6bMxyhRBhRxk57lZ54VtAvFXVIuBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=feRQn7Nd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="feRQn7Nd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370226; x=1808906226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ivjX7c8hOdX72Jb8wVPa7zi9Lf92o05+IfwqAPmQCzc=;
  b=feRQn7Nd4YndcuDCgqxOkHyS/El4G+EAIy2BAzyJVHyq0+TQOOpvjZ21
   ip7J+i+7ogcptkZcYtk9KKKegxAZS4QxOG0KOa+AqKd2+IwW+0dkjua5a
   a4xyRGmAmGHzUYOUfIS2gRJgH3PX9yfVrZq3rXWSoZNXBu3IRKQSkLIeN
   YUMw7sicuOMfxTEbcsDusFXbNlfZHstr91A6sGizhBiN42N5H8b7aK5Qs
   Dp8vSZnLv61S9XHMWlLZ6RR2U1vRwZxnNh115S9qb718e98hdZCLBP2Yr
   hyzchxi390IMfSFPW9N1PI/4wdzDpRamGPE9ahbLJETi2fWaVn5nYeOOS
   w==;
X-CSE-ConnectionGUID: VzTOOGM3RfyG5VsFSvPyOg==
X-CSE-MsgGUID: i6dYQ5HwQbWx10+abgcKcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82126278"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82126278"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:57:06 -0700
X-CSE-ConnectionGUID: EuTAx5ylS9evVRPKmLzLZg==
X-CSE-MsgGUID: TK4+lodVTMeMANDn9Gy1jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238250281"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 02:57:03 -0700
Message-ID: <59bcc3d3-1a6f-47e0-86af-3cb5b08cbacb@linux.intel.com>
Date: Tue, 28 Apr 2026 17:57:01 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 pbonzini@redhat.com, seanjc@google.com, dave.hansen@intel.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 chao.gao@intel.com
References: <20260428024746.1040531-1-binbin.wu@linux.intel.com>
 <20260428024746.1040531-3-binbin.wu@linux.intel.com>
 <36c64a53-0041-4638-b6cd-7deff38bd37d@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <36c64a53-0041-4638-b6cd-7deff38bd37d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/28/2026 2:01 PM, Xiaoyao Li wrote:
[...]

>> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
>> index 37ac4afe0972..cb93e4ea410e 100644
>> --- a/arch/x86/kernel/cpu/microcode/intel.c
>> +++ b/arch/x86/kernel/cpu/microcode/intel.c
>> @@ -147,6 +147,10 @@ u32 intel_get_platform_id(void)
>>       if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
>>           return 0;
>>   +    /* Don't try to read microcode bits when virtualized. */
> 
> The platform ID is not only used by microcode update. I don't think calling them microcode bits is proper. It's also stashed in struct cpuinfo_x86::intel_platform_id and used in x86_match_cpu() as a factor as the generic FMS (Family, Model, Stepping) bits.

It's still related to microcode though.
The platform id is used to detect whether the microcode is old or not in this
case.

> 
> We skip things due to hypervisor is set usually when the thing is known unable to be virtualized. From the perspective of microcode update, it's OK to skip reading it due to hypervisor bit. However, from the perspective of generic platform ID, it seems not that reasonable to skip reading it due to hypervisor bit. Especially KVM has supported this MSR for normal VMs.

Considering the microcode related code, Linux kernel does special handling when
running as a guest, microcode_loader_disabled() sets dis_ucode_ldr and
cpu_has_old_microcode() also skips to check whether the microcode is old
if it's running in a virtualized environment. I.e. the special handling for
virtualization make it meaningless to read the MSR.

> 
> So how about using the safe version of RDMSR, if we want the enhancement?

I am open to this.
Let's wait to see if the change on guest side is wanted or not.

> 
>> +    if (x86_cpuid_has_hypervisor())
>> +        return 0;
>> +
>>       /* get processor flags from MSR 0x17 */
>>       native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
>>   diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
>> index 3b93c0676b4f..0233e074d76b 100644
>> --- a/arch/x86/kernel/cpu/microcode/internal.h
>> +++ b/arch/x86/kernel/cpu/microcode/internal.h
>> @@ -100,6 +100,11 @@ static inline unsigned int x86_cpuid_family(void)
>>       return x86_family(eax);
>>   }
>>   +static inline bool x86_cpuid_has_hypervisor(void)
>> +{
>> +    return native_cpuid_ecx(1) & BIT(31);
>> +}
>> +
>>   extern bool force_minrev;
>>     #ifdef CONFIG_CPU_SUP_AMD
> 
> 


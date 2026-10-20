Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460072;
	b=RochbPHcpk/xbADtGWM9zufZkXIv6KNRNHVJDD42/gOthhqyPqd0LSpNzl040xko5eeg
	 rGZJnNmvCq3luwXwiicchDuq09tDDWWsxxLQJoNzvW+yYrv7uWHiebXixx/mE86+OKPPP
	 OHdtZTibFQwtPTjULjQ4jAN196dLNAsrt29Zy+BYRlZR2yYgeg1lJiUZ/Fe7xoLlEHkrk
	 gumzm5zubf+B65weWCJIokJ+hwBRR7WrvwZBTu1/wgxCovJv6oF8LxGYcClf+q3m1nFIH
	 qQS20dXLq5P9VzxvXyp5VFMO1u+miu1q1Edlc8uroEOH/9dBSCD7qnT6MkVz67oMb8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460072;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eR/cOCrwQmS0N6R3T5GOdfznB2yvVxMXGDleK4MrTAQ=;
	b=eFis0XXdcOOWA0JCRmf+yoMron8H0tIivIHiXLlb71oxyjXgE9IcZhb2ZxvtS88cbolj
	 eSaMZdwlCbEdmLZG5BkRfjDK7LRSU7gVgl6mSsBzqZ/QajAu+Ab0u/JEB4TZnOpGbso0z
	 0XnAegiIJj1em6Ph7ZxgG1khHQQk6ZK9vGCCEOT2RqpyeAbbJvx2yIiPJ6uK1DPricW0C
	 xrvUA3e3rPneJgkxm25pusX7eTqo1F1/USvTmBmo11q6rxHzRj2vXYEXkhgBmMQGaxhc4
	 32xpgnhlbqv0rMGPjWwkMRuuSPy3zmIZHx6jBmRkFc91MZN03oXt6MgwRnYYN7D4LaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="aR1/T6uN";
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6518A606A330
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 01:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6518A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aR1/T6uN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792460066; x=1823996066;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=WYkfFJ8dYFnxT/zzajQu7+TW4tdrg5h/NwL5ms69pVc=;
  b=aR1/T6uNcrDdzRGsWvixdvFr0Kh+UGdVb8FJ+Y2nIr3LP7WhUsQg5A98
   h3fmrEGD/dtxKPdh/fVA8VfHEGjUGNggUJU0JODMJr623AvhDayiHV81i
   Vb6yZUHARRP1UStzlo+gEifZePUdKTvAKNpOzIOhCLT7OHbrg2m2yMmip
   ktzyOn6F4dkmNWMKFvvBTSe2WQlsU4r0S4/8klZ9oSDD9fRGhzw9gblG8
   ZhWqJETOjD0yeA6OptNV2n3TqJ8wGLYsDYvHBkdR3JXOyw0jA6YKOtj7P
   17iISQ9Q6jICmt1cSTh1O+Mj6pj8L8MgWXd6Z8qAfnloenZpMPNnOIvzx
   w==;
X-CSE-ConnectionGUID: FlqA9bSpQm2Qpom35p+THg==
X-CSE-MsgGUID: EtKlaRPBQ0yw2I4tqkUm2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1034544"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1034544"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 18:34:26 -0700
X-CSE-ConnectionGUID: HRWKmMI4QGKJevhh5VohHQ==
X-CSE-MsgGUID: UfEstqP8TuuYGdyrwpu/kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="4504078"
Received: from unknown (HELO [10.238.0.148]) ([10.238.0.148])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 18:34:25 -0700
Message-ID: <e8943657-10e6-4f95-a143-e6867a39343f@linux.intel.com>
Date: Tue, 20 Oct 2026 09:34:22 +0800
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
Subject: Re: [PATCH v5 5/5] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
 <20261016091422.3182216-6-binbin.wu@linux.intel.com>
 <sashiko-outbox-174077@kernel.org>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-174077@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2026 5:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] kvm: KVM_TDX_INIT_VM rejects CPUID.0x7.0.EAX breaking guest subleaf enumeration
> - [High] mm: heap buffer overflow in setup_tdparams_cpuids() via unbounded td_conf->num_cpuid_config
> --
> 
> commit 8ec54e6006917e96837000de9e4002c7f4499444
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
> 
> This commit validates the CPUID configuration provided by userspace
> through KVM_TDX_INIT_VM against KVM's TDX allowlist. It drops the
> hardcoded denylist-based check in favor of a strict allowlist.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index e53f1e98bb04a..80c6519c13ff5 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> @@ -2567,6 +2548,14 @@ static int setup_tdparams_eptp_controls(struct kvm_cpuid2 *cpuid,
>>  	return 0;
>>  }
>>  
>> +static bool tdx_has_unsupported_cpuid_cfg_bit(const struct kvm_cpuid_entry2 *e, u32 index)
>> +{
>> +	return (e->eax & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EAX)) ||
>> +	       (e->ebx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EBX)) ||
>> +	       (e->ecx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_ECX)) ||
>> +	       (e->edx & ~tdx_get_cpuid_cfg_mask(e->function, index, CPUID_EDX));
>> +}
> 
> [Severity: High]
> Does this strict allowlist check inadvertently break guest subleaf enumeration
> by rejecting valid KVM_TDX_INIT_VM inputs?
> 
> CPUID leaf 0x7 subleaf 0 EAX contains the maximum supported subleaf index,
> which is non-feature information. However, tdx_get_cpuid_cfg_non_feature_mask()
> completely omits leaf 0x7, and reverse_cpuid does not track 0x7.0.EAX as a
> feature word.
> 
> Because tdx_get_cpuid_cfg_mask(0x7, 0, CPUID_EAX) returns 0, this new check
> will reject any non-zero value for CPUID.0x7.0.EAX. This strictly requires
> userspace to provide 0, effectively preventing exposure of subleaves 1+
> (such as for AMX or AVX-VNNI) and breaking valid VM initialization requests.

This is false positive.

CPUID.0.EAX is not directly configurable in TDX.
Userspace is not allowed to provide non-zero value for it.

> 
>>  static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>>  				 struct td_params *td_params)
>>  {
> [ ... ]
>> @@ -2596,7 +2585,7 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>>  		 * not the index of the userspace entry, which may differ if
>>  		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX isn't set.
>>  		 */
>> -		if (tdx_unsupported_cpuid(entry, tmp.index))
>> +		if (tdx_has_unsupported_cpuid_cfg_bit(entry, tmp.index))
>>  			return -EINVAL;
>>  
>>  		copy_cnt++;
> 
> [Severity: High]
> Can the loop enclosing this code write past the end of the td_params heap
> allocation?
> 
> td_conf->num_cpuid_config is read from the TDX module and bounded to 128
> by KVM in get_tdx_sys_info_td_conf():
> 
> 	if (sysinfo_td_conf->num_cpuid_config > ARRAY_SIZE(sysinfo_td_conf->cpuid_config_leaves))
> 		return -EINVAL;
> 
> However, td_params->cpuid_values is an array inside a union with
> u8 reserved3[768], which limits it to 48 tdx_cpuid_value structures:
> 
> arch/x86/kvm/vmx/tdx_arch.h:struct td_params {
>     ...
>     union {
>         DECLARE_FLEX_ARRAY(struct tdx_cpuid_value, cpuid_values);
>         u8 reserved3[768];
>     };
> } __packed __aligned(1024);
> 
> td_params itself is dynamically allocated as a fixed 1024-byte object via
> kzalloc_obj(struct td_params) in setup_tdparams().
> 
> If the hardware returns a num_cpuid_config value greater than 48, the loop
> in setup_tdparams_cpuids() will exceed the 48-element capacity when assigning
> value = &td_params->cpuid_values[i] just below this snippet, causing a heap
> buffer overflow.
> 

Here is the to reply to the same issue reported in an earlier version:
https://lore.kernel.org/kvm/c31eb9c5-6cae-488a-bcaf-26160c282e0b@linux.intel.com/


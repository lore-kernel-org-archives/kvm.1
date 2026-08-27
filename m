Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B013630B0
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815530; cv=none; b=m9PmK/8l2wddJOK4aEDbfDH//u76kRZFc942+cHJNhuTHZ1nmeKaXR5UPo/KkzQmPFD5Ik1JnD4Z24xvjuOJvUV1xFKBekye7NEvX0E/hf442pxwRt/aimCyB7kqBybZ5nYcNmxPQDHeN3dY6kYW0beF9b1Y4w926N29TAwCQbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815530; c=relaxed/simple;
	bh=kvMN/4TgJKcyBZDBVFOxrL6wTCJSj13E+b5IWWJLZ4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A98I0OO1l82QDpX+YlS9LOF993PZnvwFar8wqxYxsIIOOzZuAmwWgwIQrvAdeWvmn2kXpVRdXFk53UxKX9FVfbor80yblenq5kQB6YliW9mjonuncPXkkndG3Oy6Yf1A+h/N23UTAvUgGWi7iwCvRxZhCXlsiTA/uDoNhAd7a3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsBfe8p3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsBfe8p3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787815529; x=1819351529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kvMN/4TgJKcyBZDBVFOxrL6wTCJSj13E+b5IWWJLZ4U=;
  b=MsBfe8p31DKIJI3kDFzWFyF+s/RDsrIX1GRjDvfsL/IWVxMKDJvHqkOM
   4mpc9XNhJZPW6VOxwRHgJ2BQXPuuuLPRmAoqLFPJCY+0tVwUWXwLRocH+
   N5XLbzy6i+q/le/Mf8n2GF47b+CVZtDo7ISOBT+K1I6LiknklJ0NLM5wC
   buVgylMxv+li8aSbRl9G3bF/qPYaOdfDHIHRrscW4tWeG+jf96fy15xEM
   im1Bjw27Fwnz8AhhW0OFvs9FQzRGmmJZKuDpVOZbechuG1CUJb/5uLvga
   QhgXSKCnk9xFiTM8Nw+UqlsJ5e5JJLQUtZlNUZLuf0Je0AYBV7uCcN5Qj
   Q==;
X-CSE-ConnectionGUID: v3dCON6UQHqk4oIm1g24qw==
X-CSE-MsgGUID: XCCHvnxWQJerPnd4LLXHmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88326717"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88326717"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:25:27 -0700
X-CSE-ConnectionGUID: 1ZT5gryJSvqCCAfscjnCaw==
X-CSE-MsgGUID: rw/gospTRKaNDaAHFBJplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="306013683"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:25:27 -0700
Message-ID: <c31eb9c5-6cae-488a-bcaf-26160c282e0b@linux.intel.com>
Date: Thu, 27 Aug 2026 15:25:24 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] KVM: TDX: Validate userspace CPUID input for
 KVM_TDX_INIT_VM
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-5-binbin.wu@linux.intel.com>
 <20260827032449.489E31F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260827032449.489E31F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/2026 11:24 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Missing bounds check on the hardware-reported `num_cpuid_config` leads to an out-of-bounds heap write when initializing TD parameters if the TDX module reports more than 48 CPUID configuration leaves.
> --
> 
> commit 491ef15b15a75d61b2ded06ddb90ff6562206292
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
> 
> This commit validates the CPUID configuration provided by userspace
> through KVM_TDX_INIT_VM against KVM's TDX allowlist. It drops the
> hardcoded denylist-based check and instead rejects entries matching
> unsupported CPUID bits or entries with mismatching subleaf indices.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index e8951353de73c..12dea8775fd4f 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> [ ... ]
>> @@ -2556,7 +2548,16 @@ static int setup_tdparams_cpuids(struct kvm_cpuid2 *cpuid,
>>  		if (!entry)
>>  			continue;
>>  
>> -		if (tdx_unsupported_cpuid(entry))
>> +		/*
>> +		 * Reject entries whose index does not match the expected one.
>> +		 * This catches userspace passing a CPUID entry with the
>> +		 * KVM_CPUID_FLAG_SIGNIFCANT_INDEX flag cleared when the index
>> +		 * is significant.
>> +		 */
>> +		if (entry->index != tmp.index)
>> +			return -EINVAL;
>> +
>> +		if (tdx_has_unsupported_cfg_cpuid_bit(entry))
>>  			return -EINVAL;
>>  
>>  		copy_cnt++;
> 
> [Severity: High]
> This is a pre-existing issue, but does this loop in setup_tdparams_cpuids()
> lack a bounds check on the hardware-reported td_conf->num_cpuid_config?
> 
> Looking at the loop just below this diff in arch/x86/kvm/vmx/tdx.c:
> 
>     for (i = 0; i < td_conf->num_cpuid_config; i++) {
>         ...
>         value = &td_params->cpuid_values[i];
>         value->eax = entry->eax;
>         ...
> 
> The target td_params is allocated with a strict 1024-byte size bound
> in tdx_td_init():
> 
>     td_params = kzalloc_obj(struct td_params);
> 
> However, the hardware-reported num_cpuid_config can be up to 128. Because
> struct td_params contains preceding fields and is bounded to 1024 bytes,
> the cpuid_values flex array can safely hold a maximum of 48 entries.
> 
> If a TDX module supports more than 48 CPUID configuration leaves, this
> iteration will blindly index past the 48th element, resulting in an
> out-of-bounds heap write with user-controlled CPUID values.
> 
> Should num_cpuid_config be validated against the maximum capacity of
> the td_params allocation?
> 

td_conf->num_cpuid_config is reported by the TDX module and gives the
number of leaves with directly configurable CPUIDs. struct td_params is
defined per the TDX spec with a fixed size of 1024 bytes, which is large
enough to hold every directly configurable CPUID leaf, i.e. exactly
num_cpuid_config entries. So the TDX module should never report a number
larger than td_params can accommodate.

So I think the finding is not a real vulnerability, but a cheap one-time
sanity check is still defensible.

I will send it as a separate hardening patch if there is no objection.


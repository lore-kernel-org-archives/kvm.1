Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6F3AC0EF
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780541692; cv=none; b=jsmEFc74mS4qeYBvf4ycJQs/JZJSyKK2s/iJjIQVoTkCJ0DjBmgc+pgspshaHTa8dCGvwwooR4rX35RD0UwZ6W3Cks5U0cqx/ypCtTJeyY8u93f2BcYR69Pjj14YRPz7SZyjCfPvgg/IdpYgjx/GMnk/nRTUkewUN6KFObx4PAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780541692; c=relaxed/simple;
	bh=QwL6diGUVPs3irTGpndZkAlVzmKc1IPtnBT5494zAQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=euYd8bf3VrZR85SL5mS256x1H1x0GSyG7t4jH9hgxT84pvzU6gCVUhvEh5DfdDtnlnBZNXqWtQ34f3HhdsWKOKas8zZUTDq6Lm++ukLRp/+0NepVZpaGJR/E5+3m3osnTABKeXE9cSyPFT26A3WmQsXqQe01W1YDKSamT9ESTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6Q95Vcb; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6Q95Vcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780541692; x=1812077692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QwL6diGUVPs3irTGpndZkAlVzmKc1IPtnBT5494zAQE=;
  b=C6Q95VcbLqxLKBg/tVu/Gat6VDevpV6jIpLf+XHfEvj2Os52TDPKZ1GN
   6DJ/DInxnb9Qvf5yOCtetxulBr8oayQPsM39KCzoRTL8RrJx8/8CyY+pZ
   mRII/PJKmYaV62gh2TgMhT0gBSg973orQ1Vhj1RieqovwV4su2NEacFSm
   PEFBuiDm6x6k3xDDok3dw26ncoakj/UvHZ9qdTXzWeRJzL1ZvoeoZMcUd
   JtyGGDkPxqvthy3j2CHLCezNc/dbn5mmdzi7fYAho6Y/V/ui0HKJr87iJ
   HsquTOpy2Kctckpu61eV2g9qdbUlAOOGnUQPonswMpO2xMjOvk6oMOvVG
   w==;
X-CSE-ConnectionGUID: iD+Za5f8SUWf3BlmMSb+sg==
X-CSE-MsgGUID: +KLh2MrFQyy+pcMBxSTG4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81395716"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81395716"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:54:51 -0700
X-CSE-ConnectionGUID: j9rUERyoRQOMlnAWHh4pAA==
X-CSE-MsgGUID: 0FLTgoPuQyuWUjikjLX2Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246240712"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 19:54:50 -0700
Message-ID: <0c09d581-1efe-4ddb-8bd5-75f78e946a23@linux.intel.com>
Date: Thu, 4 Jun 2026 10:54:47 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/4] KVM: x86: TDX: Hide unsupported configurable
 CPUID bits
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
References: <20260604023314.3907511-3-binbin.wu@linux.intel.com>
 <20260604024718.497F21F00893@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260604024718.497F21F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 10:47 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The secure-by-default CPUID allowlist is applied to KVM capability reporting but missing from TD initialization validation. This allows a malicious userspace VMM to bypass capability enumeration and supply unsupported configurable CPUID bits directly to the TDX module, potentially causing host state corruption.
> --
> 
> commit e4dd30c1f72bbeeb74f3ba5a865ab30e0c17bcf6
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: x86: TDX: Hide unsupported configurable CPUID bits
> 
> This commit introduces get_supported_cfg_cpuid() to filter the CPUID 
> capabilities reported by KVM_TDX_CAPABILITIES. It replaces a hardcoded 
> denylist with a secure-by-default allowlist approach to prevent exposing 
> unsupported features that could lead to host state corruption.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 028d54c76b81e..befda6bc17b1e 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> 
> [ ... ]
> 
>> -static void clear_waitpkg(struct kvm_cpuid_entry2 *entry)
>> +static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
>>  {
>> -	entry->ecx &= ~__feature_bit(X86_FEATURE_WAITPKG);
>> +	return has_tsx(entry) || has_waitpkg(entry);
>>  }
> 
> [Severity: High]
> This is a pre-existing issue, but by keeping this legacy denylist active, is
> there a risk that userspace can bypass the new secure-by-default allowlist
> during TD initialization?
> 
> While this patch updates capability reporting to explicitly mask unsupported 
> features, the configuration path in setup_tdparams_cpuids() still appears to 
> use this older denylist function to validate user input:
> 
> arch/x86/kvm/vmx/tdx.c:setup_tdparams_cpuids() {
>         ...
>         if (tdx_unsupported_cpuid(entry))
>                 return -EINVAL;
> 
>         value = &td_params->cpuid_values[i];
>         value->eax = entry->eax;
>         value->ebx = entry->ebx;
>         value->ecx = entry->ecx;
>         value->edx = entry->edx;
>         ...
> }
> 
> Because these user-provided CPUID values are copied directly into the hardware 
> initialization parameters without being masked against the newly introduced 
> get_supported_cfg_cpuid() allowlist, could a VMM explicitly request and pass 
> unsupported configurable CPUID bits directly to the TDX module?
> 
> Does this still leave the door open to the host state corruption mentioned
> in the commit message if the TDX module only enforces hardware-level support
> rather than KVM's software constraints?

This is addressed by the next patch.

> 
>>  
>> -static void tdx_clear_unsupported_cpuid(struct kvm_cpuid_entry2 *entry)
>> +static u32 get_supported_cfg_cpuid(u32 function, u32 index, u8 reg)
>>  {
> 
> [ ... ]
> 


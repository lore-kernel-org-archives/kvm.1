Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366D353EE0
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551159; cv=none; b=Y5MUZa+RMjI7S40t+JP9U0fA/O1HN4AImffyGB999MeSrBTX8T8AeB2VQJKES122zNnPa5C9XFEQS7tuno+mShINqq9LfGrEXQyYH0uH9L4cqy68raBQr7vxHZ+VVfbpsqAEQoOQ8I7Xd6RQpq3UHrvpXGHB6xXmMjLMf2mSZO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551159; c=relaxed/simple;
	bh=A2J9LO8Lgt+UPtTSt8kPI2wRLARc5uc90oOItpIkw9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mG8FV0k8QOIMAw7Z8+A8VObnWyys/SLM8RUuz190R42GuqNbQTRi333w3wPduuzLy1Zwe0f9kdTmNXuz6pHnoiIQeEuNK8wKkwkGU4gRpS18WBP4nQcXOMFlXZdoPvOzs8R+KmZZrV8IzV0xlw89FDQHWUOMMmv/48tQAe8bVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6n25gWa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6n25gWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780551158; x=1812087158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A2J9LO8Lgt+UPtTSt8kPI2wRLARc5uc90oOItpIkw9A=;
  b=W6n25gWat3NsM+PP/9/eww+vltqTjgto0YscZ9AWq3NfAvHIhGBvMuDX
   6nyCl+wXNIQGgFVAYnz/xMYfuvhbpO42E8YBEfAAbipUfMYGMIx4kwYIH
   /ntoOKIbFQTe8RGq69vDnExtHcFQIJjb6FCIG3IMMAVbatRHCMp5iSEPe
   lDrBJfX71MTnler9BVsqhFMNk5Pg7fcheXhoCOBAEXaNQ6Rcl66e6Y7fJ
   5hPsC7yDowPbOUidNbXEou9fCpraAvGzeFZW817LOVDrG1u2qqp6+kwaH
   rqiueJXIYOeV2zXARgTTJ4+RGidVTQ/WEjmZUpqyniV5aSdRsHZzlg2ek
   w==;
X-CSE-ConnectionGUID: nxPZBSoITrux7csc7S07dw==
X-CSE-MsgGUID: HOa2IitwQr28iUPOTD8yeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="83947710"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="83947710"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:32:37 -0700
X-CSE-ConnectionGUID: MHBpgH+9R0qEOnE9L624KA==
X-CSE-MsgGUID: Zq0ITMpzTTesM6aN4g42HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="249366437"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:32:36 -0700
Message-ID: <f33a2ef6-0f81-4417-89c4-ecf3d3e11e56@linux.intel.com>
Date: Thu, 4 Jun 2026 13:32:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: TDX: Report CORE_CAPABILITIES as
 supported
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260604023314.3907511-5-binbin.wu@linux.intel.com>
 <20260604025142.200341F00893@smtp.kernel.org>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260604025142.200341F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 10:51 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing handling of MSR_IA32_CORE_CAPS in tdx_set_msr() causes KVM_SET_MSRS to fail, breaking VM initialization and live migration.
> --
> 
> commit 217a78047d73d2be68ef27e206470a6c237db79a
> Author: Binbin Wu <binbin.wu@linux.intel.com>
> 
> KVM: x86: TDX: Report CORE_CAPABILITIES as supported
> 
> This commit adds CORE_CAPABILITIES to the TDX configurable CPUID allowlist
> to accommodate legacy TDX module behavior. It also modifies tdx_get_msr()
> to return 0 for MSR_IA32_CORE_CAPS.
> 
>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>> index 26a5ad59a5694..b7661ba98a8d4 100644
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> 
> [ ... ]
> 
>> @@ -2319,6 +2319,14 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>  			return 1;
>>  		msr->data = vcpu->arch.mcg_ext_ctl;
>>  		return 0;
>> +	case MSR_IA32_CORE_CAPS:
>> +		/*
>> +		 * KVM doesn't support MSR_IA32_CORE_CAPS, however, in some old
>> +		 * TDX modules, CPUID.0x7.0.EDX[30] is fixed-1. As a workaround,
>> +		 * just return 0 for this MSR.
>> +		 */
>> +		msr->data = 0;
>> +		return 0;
> 
> [Severity: High]
> Since MSR_IA32_CORE_CAPS is now exposed to userspace via tdx_get_msr(), does
MSR_IA32_CORE_CAPS is not exposed to userspace via KVM_GET_MSR_INDEX_LIST.
I suppose userspace should retrieve the supported MSRs via KVM_GET_MSR_INDEX_LIST
before KVM_GET_MSRS/KVM_SET_MSRS?


Had a second thought, this MSR code could be dropped.
In Linux kernel, MSR_IA32_CORE_CAPS is either read by the safe version or skipped
when it's running in virtualized environment. Also, there was no complain about
the access of this MSR in any guest so far.

We can just report CORE_CAPABILITIES as a TDX configurable CPUID bit to userspace.
Userspace can do some change to remove any bit that reported as configurable from
fixed1 bits. Since KVM doesn't support CORE_CAPABILITIES via KVM_GET_CPUID2,
userspace then should not enable CORE_CAPABILITIES bit for TDX guests.


> tdx_set_msr() need a corresponding update to accept host-initiated writes?
> 
> During VM migration or state restore, userspace typically reads MSRs on the
> source and writes them to the destination. If tdx_set_msr() doesn't handle
> MSR_IA32_CORE_CAPS, the KVM_SET_MSRS ioctl will fall through to the default
> case.
> 
> Because tdx_has_emulated_msr() does not include MSR_IA32_CORE_CAPS, won't
> tdx_set_msr() return an error and immediately abort the migration?
> 
>>  	default:
>>  		if (!tdx_has_emulated_msr(msr->index))
>>  			return 1;
> 





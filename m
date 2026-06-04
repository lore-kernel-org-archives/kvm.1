Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DB3C0A1C
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551647; cv=none; b=d5KNFmkOYJRR9bPhZGS+uu+kTWMTxizGuXMIzKt9TzbVTppV3rr6cpZjOB1+NpwMp4XANpR31zkiP1d6Z+093Z1oEcm+sj5IVWcJVN8YhBsV3hXMJi1UVTjjsrWPVLvpjizMcDnDGIONZ4kGgaM1BeDOJGIcanViy3fFxD8HUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551647; c=relaxed/simple;
	bh=PcWtUR6/j3nhRCK+F8WtuYdCMUYxKu071SwSfcj6gDE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nCKtsYMkK7vQ6Y7C9iYEt2xeJEzOXMDM973hLgmY377vWNV0p5YcD8vcEAzLgdWjfJ9uPwAOCCLahELZkDl5dlOaIhCAyWkrEClVOGVcTLY5KbInm/4hI4NeeuPlYJXCNR0e64Chs70FDJ0WpNdNK1fKPxbsl2hZcxIvFKTSxeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoCTWN3V; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoCTWN3V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780551645; x=1812087645;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PcWtUR6/j3nhRCK+F8WtuYdCMUYxKu071SwSfcj6gDE=;
  b=EoCTWN3VlqCe5e7Orrg3zoKHlIfBzx0D7chpSd+CQaMs6E8hDsq1WZ0h
   pdNjNJI+l9xLUx/Hre1uDoAyBCDT8cENgR+TNJ2iAkfjTE/wtWiTGgPk/
   1sA+ODMFMvC5YmDqOahMYTi+UZSb5zNeIFU9pM8I+TXvP6lie3KoQ52ar
   Wa9xslA0gugU761LNkDr15P5RNrgCyJFHPxZ+ArRM9Lw+sSi5Ml2RgTyh
   aNnsTsZKWSo+6H8iz4A/JNBDredl8Z3AFrZEUWd37If8YT+WsFaIJ7fkV
   ZnV6tPWgYdK/U+pVleqvelYSMFS8ugKRofZiijy3d1/Wj5nHr68hXnP27
   A==;
X-CSE-ConnectionGUID: 2ZoytULxRRGcKbTsv34/Zg==
X-CSE-MsgGUID: zIXfGzArTc2OLFKFq7NaQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="84995232"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="84995232"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:40:45 -0700
X-CSE-ConnectionGUID: JYV40xaNQla/BLZO/CwiHw==
X-CSE-MsgGUID: Ug42bbt8QmW26s0zXVNhaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="240248405"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:40:43 -0700
Message-ID: <84ed35cd-9767-4fc3-916b-05c5db9f200e@linux.intel.com>
Date: Thu, 4 Jun 2026 13:40:41 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] KVM: x86: TDX: Report CORE_CAPABILITIES as
 supported
From: Binbin Wu <binbin.wu@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20260604023314.3907511-5-binbin.wu@linux.intel.com>
 <20260604025142.200341F00893@smtp.kernel.org>
 <f33a2ef6-0f81-4417-89c4-ecf3d3e11e56@linux.intel.com>
Content-Language: en-US
In-Reply-To: <f33a2ef6-0f81-4417-89c4-ecf3d3e11e56@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 1:32 PM, Binbin Wu wrote:
> 
> 
> On 6/4/2026 10:51 AM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] Missing handling of MSR_IA32_CORE_CAPS in tdx_set_msr() causes KVM_SET_MSRS to fail, breaking VM initialization and live migration.
>> --
>>
>> commit 217a78047d73d2be68ef27e206470a6c237db79a
>> Author: Binbin Wu <binbin.wu@linux.intel.com>
>>
>> KVM: x86: TDX: Report CORE_CAPABILITIES as supported
>>
>> This commit adds CORE_CAPABILITIES to the TDX configurable CPUID allowlist
>> to accommodate legacy TDX module behavior. It also modifies tdx_get_msr()
>> to return 0 for MSR_IA32_CORE_CAPS.
>>
>>> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
>>> index 26a5ad59a5694..b7661ba98a8d4 100644
>>> --- a/arch/x86/kvm/vmx/tdx.c
>>> +++ b/arch/x86/kvm/vmx/tdx.c
>>
>> [ ... ]
>>
>>> @@ -2319,6 +2319,14 @@ int tdx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
>>>  			return 1;
>>>  		msr->data = vcpu->arch.mcg_ext_ctl;
>>>  		return 0;
>>> +	case MSR_IA32_CORE_CAPS:
>>> +		/*
>>> +		 * KVM doesn't support MSR_IA32_CORE_CAPS, however, in some old
>>> +		 * TDX modules, CPUID.0x7.0.EDX[30] is fixed-1. As a workaround,
>>> +		 * just return 0 for this MSR.
>>> +		 */
>>> +		msr->data = 0;
>>> +		return 0;
>>
>> [Severity: High]
>> Since MSR_IA32_CORE_CAPS is now exposed to userspace via tdx_get_msr(), does
> MSR_IA32_CORE_CAPS is not exposed to userspace via KVM_GET_MSR_INDEX_LIST.
> I suppose userspace should retrieve the supported MSRs via KVM_GET_MSR_INDEX_LIST

or KVM_GET_MSR_FEATURE_INDEX_LIST

> before KVM_GET_MSRS/KVM_SET_MSRS?
> 
> 
> Had a second thought, this MSR code could be dropped.
> In Linux kernel, MSR_IA32_CORE_CAPS is either read by the safe version or skipped
> when it's running in virtualized environment. Also, there was no complain about
> the access of this MSR in any guest so far.
> 
> We can just report CORE_CAPABILITIES as a TDX configurable CPUID bit to userspace.
> Userspace can do some change to remove any bit that reported as configurable from
> fixed1 bits. Since KVM doesn't support CORE_CAPABILITIES via KVM_GET_CPUID2,
> userspace then should not enable CORE_CAPABILITIES bit for TDX guests.
> 
> 
>> tdx_set_msr() need a corresponding update to accept host-initiated writes?
>>
>> During VM migration or state restore, userspace typically reads MSRs on the
>> source and writes them to the destination. If tdx_set_msr() doesn't handle
>> MSR_IA32_CORE_CAPS, the KVM_SET_MSRS ioctl will fall through to the default
>> case.
>>
>> Because tdx_has_emulated_msr() does not include MSR_IA32_CORE_CAPS, won't
>> tdx_set_msr() return an error and immediately abort the migration?
>>
>>>  	default:
>>>  		if (!tdx_has_emulated_msr(msr->index))
>>>  			return 1;
>>
> 
> 
> 
> 
> 


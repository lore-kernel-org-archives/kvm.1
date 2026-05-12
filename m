Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AB2E413;
	Tue, 12 May 2026 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551085; cv=none; b=LbRBYZw16MBtFAOH71NtLcjHmaU8XGxtElTwsqlKoOg1jo0HoKUOP3re0GAnPcBOi7hHLSu4GGo5wm+V3tcLjHyUDhbAevMffDCi69fzE8sKQW0wHalFGojvlMDjgawjSqHVQEU8yt0NrUmxsmj4Nfpf6qqfQG/9Ewy9fZBJv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551085; c=relaxed/simple;
	bh=EgMDJ590uo9KLyq5nyrnIP1cOHLNirC5KhAQf/i55sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ewnz00iwBP5xf1IgXoLn4L5hlzd5g7bmgUETW6XoWel9WI9XWjlaLcC0NBk+RKRSIsb1PrbPOdqT8I5TTTdaiUiY3JxwyK2jzXqb54ijaUyIvGKN7mUInXCRnWUlBkAj9qI+FGxppPaswVB0tsH71zOm2RD6B7joAZCW4F+vv4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuwAfqq0; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuwAfqq0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778551084; x=1810087084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EgMDJ590uo9KLyq5nyrnIP1cOHLNirC5KhAQf/i55sM=;
  b=ZuwAfqq0UAeQsm4hnMcDiKoPonEedOg3rSjdk48W/D+eSikN/plX6De5
   Gsr3nGUPS2n7sjk/T1z5P42QviovrZ/haqZ755oQz6QgJTxbHm6LoEDxZ
   cJmaGLA+Q3rmWcYnggu8k+vl0OIZgt8ozK8FjDhdGlduWjZ9gROXqaDsj
   HVSay1pyAsfuZq7u1KlFFy1smrvLcHAbKujDOWlG3haPsxiXjeyan3+g8
   3qV5oVE3WSE04j381gPDx15zJGj4dJM1yOajV2INhK95ZDYnCkvdzrgf6
   6TWaTNDXTov9ioJt8ZHft4KKT2P6+rMGedHJHu3+F6+ll/NJecklVfWR3
   Q==;
X-CSE-ConnectionGUID: DyqKJRiUS26shAPq11tSBg==
X-CSE-MsgGUID: 7kEAoL/aQdGruv8lDgUoCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="102113675"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="102113675"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:58:04 -0700
X-CSE-ConnectionGUID: vDojhQ9TQoa9HlXOEugagw==
X-CSE-MsgGUID: GCtHKsvMR0uKcuKPVxRKVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="237711383"
Received: from fanlilin-mobl.ccr.corp.intel.com (HELO [10.238.1.228]) ([10.238.1.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:58:00 -0700
Message-ID: <d88d19f5-0a96-4115-97f7-8daf1edd625a@linux.intel.com>
Date: Tue, 12 May 2026 09:57:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/cpu: Skip reading MSR_IA32_PLATFORM_ID in
 virtualized environment
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 dave.hansen@intel.com, seanjc@google.com, pbonzini@redhat.com,
 kas@kernel.org, rick.p.edgecombe@intel.com, vishal.l.verma@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260430020953.1405535-1-binbin.wu@linux.intel.com>
 <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260511100451.GBagGpw7jRBDdHkBgp@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/11/2026 6:04 PM, Borislav Petkov wrote:
> On Thu, Apr 30, 2026 at 10:09:53AM +0800, Binbin Wu wrote:
>> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
>> index 37ac4afe0972..1bc0c350726c 100644
>> --- a/arch/x86/kernel/cpu/microcode/intel.c
>> +++ b/arch/x86/kernel/cpu/microcode/intel.c
>> @@ -147,6 +147,10 @@ u32 intel_get_platform_id(void)
>>  	if (intel_cpuid_vfm() <= INTEL_PENTIUM_II_KLAMATH)
>>  		return 0;
>>  
>> +	/* Don't try to read microcode bits when virtualized. */
>> +	if (cpuid_ecx(1) & BIT(X86_FEATURE_HYPERVISOR & 0x1f))
>> +		return 0;
>> +
>>  	/* get processor flags from MSR 0x17 */
>>  	native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
>>  
>>
>> base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
>> -- 
> 
> Does that work too?
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 18d2eff7a4b7..1b24de94bdd5 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -139,6 +139,9 @@ u32 intel_get_platform_id(void)
>  {
>  	unsigned int val[2];
>  
> +	if (hypervisor_present)

hypervisor_present could be uninitialized if dis_ucode_ldr is true.
intel_get_platform_id() is also called during the normal cpu initialization.


> +		return 0;
> +
>  	/*
>  	 * This can be called early. Use CPUID directly instead of
>  	 * relying on cpuinfo_x86 which may not be fully initialized.
> 


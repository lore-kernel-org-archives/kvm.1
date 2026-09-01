Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4235201F;
	Tue,  1 Sep 2026 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252146; cv=none; b=ngpOOqNHGSQLeUKpBs3QJ/foWyeETClDQYu872EROgO/uvHh3+z60TEMxYib/Hqd/H12HLZCoks9ShXvLqvzGVYZUyG7hcpAqBxIE3tJ6bQLEHtSqe6ASyF6PWsE5dw6cFIyEtD+yNFFsAxFGAJuVtXZiU00SBx1yXoRmkWLvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252146; c=relaxed/simple;
	bh=ihGvPjQTk5na0APzRgCSPFbvEgr6XTY1I7mZ7EQ24JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/mNZw3YMXMJvIKh+ArQQpJpSxUQJZdJrukWv2L+KCpwTM7RPkFQ7n0Rgi8gKOVAanvz8xou7R26gG0il6e15AjzLimFGlrfZAgL5/97cRaUaf71xp1gZlaghse06aUJAyI0oGE2H71MwcQf5+oDwqddifaLdFDb6OAZ84ucntI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpFxWQpV; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpFxWQpV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788252146; x=1819788146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ihGvPjQTk5na0APzRgCSPFbvEgr6XTY1I7mZ7EQ24JM=;
  b=YpFxWQpVVp7hKtPX2WXxb5L7UZBM5a56RT8G+9wqoBE+dIiONVXVyg1c
   oHRKjvDL8Ch1adbxFM9Ka0n5Z77gzwkOjYZk1rC1Jhibm67TRUr3mCaVS
   t1MrO/yWsEUeEe1yXSvMXS7P6pCkWe8eFcy0iyArs2I1ktAojjTXJozEZ
   vWcKvBgb0Nzs0JYJwjUhC2zZY4MdNSdK6RqrDBqJ0wVCDHqiUMfZpCU0X
   SeCbnEG3qWmNVMko/XsqxEUCFbwsv/aitC3qIKCLEC+TY98k4tSfONpV+
   P/MdgIEUSpaaJYWFoUAt9B6HRj9LmV0xUh8sjX10iQesB53eEhYVvmQef
   A==;
X-CSE-ConnectionGUID: nG/Exr9bSuCoA7BcfYTrvg==
X-CSE-MsgGUID: ctRxdX6JRByFpQAx24+2qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88879803"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88879803"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:42:25 -0700
X-CSE-ConnectionGUID: LJcN1CnbSnOEd2dIbxR0vQ==
X-CSE-MsgGUID: rZLlQgnGRR6nYc92U6yxww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272820859"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 01:42:23 -0700
Message-ID: <09c2f755-d822-4aac-993a-878d58c3b47b@linux.intel.com>
Date: Tue, 1 Sep 2026 16:42:20 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Filter configurable CPUID bits
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
 nik.borisov@suse.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-4-binbin.wu@linux.intel.com>
 <apZ0X8J31bVCoc9E@tlindgre-MOBL1>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <apZ0X8J31bVCoc9E@tlindgre-MOBL1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/2026 2:44 PM, Tony Lindgren wrote:
> On Thu, Aug 27, 2026 at 11:18:36AM +0800, Binbin Wu wrote:
>> --- a/arch/x86/kvm/vmx/tdx.c
>> +++ b/arch/x86/kvm/vmx/tdx.c
> ...
>> +static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
>>  {
>> -	if (has_tsx(entry))
>> -		clear_tsx(entry);
>> +	/*
>> +	 * For a leaf/subleaf/register that will never be repurposed to hold
>> +	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
>> +	 * leave the TDX module's CPUID config mask intact.
>> +	 */
>> +	switch (function) {
>> +	case 1:
>> +		if (reg == CPUID_EAX || reg == CPUID_EBX)
>> +			return TDX_CPUID_ALL_ALLOWED_MASK;
>> +		return 0;
>> +	case 4:
>> +	case 0x18:
>> +	case 0x1f:
>> +		return TDX_CPUID_ALL_ALLOWED_MASK;
>> +	case 0x24:
>> +		if (index == 0 && reg == CPUID_EBX)
>> +			return GENMASK_U32(7, 0);
>> +		return 0;
>> +	case 0x80000008:
>> +		if (reg == CPUID_EAX)
>> +			return TDX_CPUID_ALL_ALLOWED_MASK;
>> +		return 0;
>> +	default:
>> +		return 0;
>> +	}
>> +}
> 
> How about rename the above to something simpler like tdx_get_cpuid_bits()?
> Sorry I don't have anything better to suggest for naming.
> 
>> +static u32 tdx_cfg_feature_mask(u32 function, u32 index, int reg)
>> +{
>> +	for (int i = 0; i < NR_KVM_CPU_CAPS; i++) {
>> +		const struct cpuid_reg *cpuid = &reverse_cpuid[i];
>> +
>> +		if (!cpuid->function)
>> +			continue;
>> +
>> +		if (cpuid->function == function && cpuid->index == index &&
>> +		    cpuid->reg == reg)
>> +			return tdx_cpu_cfg_caps[i];
>> +	}
>> +
>> +	return 0;
>>  }
> 
> And then the above to tdx_get_cpuid_feature_bits()?
>   
>> -static bool tdx_unsupported_cpuid(const struct kvm_cpuid_entry2 *entry)
>> +static u32 tdx_get_allowed_cfg_cpuid_mask(u32 function, u32 index, int reg)
>>  {
>> -	return has_tsx(entry) || has_waitpkg(entry);
>> +	u32 non_feature_mask = tdx_cfg_non_feature_mask(function, index, reg);
>> +
>> +	if (non_feature_mask == TDX_CPUID_ALL_ALLOWED_MASK)
>> +		return TDX_CPUID_ALL_ALLOWED_MASK;
>> +
>> +	/*
>> +	 * It's possible that a CPUID register contains both feature and
>> +	 * non-feature bits.
>> +	 */
>> +	return non_feature_mask | tdx_cfg_feature_mask(function, index, reg);
>>  }
> 
> And then tdx_get_cpuid_mask()?

How about:
tdx_get_cpuid_cfg_non_feature_mask()
tdx_get_cpuid_cfg_feature_mask()
tdx_get_cpuid_cfg_mask()


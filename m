Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34522348C73;
	Mon, 25 May 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706300; cv=none; b=Suyx7inoOeRAxrL/lEvsizABbsY7lxzAwOtfDE9PsaZqWAceo9F2MTVHhmT7UN6zfxZ7zEMFVSR6OkiyiITX4tfmBvUM+OZrWcjOv0gMHINhKeLEe3cMWyJkb/BMXSwMXwEi3YmVt0BrZdVp3mQaeb1T2cZxoB2DoU2h1OpwIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706300; c=relaxed/simple;
	bh=WHhh7BSoR9UrFiBzLJml/5squKR//6wSP8qG+SZ6DMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH7K6PTjY1o471EAkiOJie8kcg9KwLVClgBz5rzUqSrJ054YlDbMg0zcB5mGr1PMXefP33kDoANaHe1IzCIMKTC+yvOkihaHnknv43LU8Hl/AAiOLWd+LPS0RoSaSPm6fSxB86vlzj/IpsesqHCVfiMcgT0dwreB2VHO3CWfE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSjL7kR9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSjL7kR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779706299; x=1811242299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WHhh7BSoR9UrFiBzLJml/5squKR//6wSP8qG+SZ6DMw=;
  b=CSjL7kR96C8rFibyM0enIGqbQsvhTYrFPwfqHCnzCx/FJ3cJJhIEx/C6
   2oaNj2t0b0NtOZxGRbcU1bi/26YG1tGLHIZuRtQ7dXeaJTXEiPGhaDrAq
   8BF++ZcD/QECvGBM1FcMnKcXoYZG9z1gEA00GD9tCkDZ+Ja69i1F8v4Yw
   dVzGxlPDpW+PmJtU3t5SL+xM5itfV8JNJmGrPc0YHg/caPLaycph8f3PA
   DzKh9iEZCCHGDSpiDylCYeQbZbCba5o+9qOrkzULbZkr1xCEa/Chas5Nt
   VGvfPlVqDHA9fu8LVTIIv3r6Bxjz7UbSl35R/GmiIm58ZyAYtJVq9Mz/b
   Q==;
X-CSE-ConnectionGUID: Fp5OdfHOTyy4tM44voWMAA==
X-CSE-MsgGUID: 9rqjUYfRR5Oj/Q/QdFe04g==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80711467"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="80711467"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 03:51:34 -0700
X-CSE-ConnectionGUID: w9YDZJDLR5iV3v9R0xBOuA==
X-CSE-MsgGUID: r6P8TIL4SsiLutdusURMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="271897140"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.239.158.44]) ([10.239.158.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 03:51:30 -0700
Message-ID: <892508b2-6c61-4db2-a12f-902f62385e71@intel.com>
Date: Mon, 25 May 2026 18:51:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/15] x86/virt/tdx: Enable TDX Quoting extension
To: Tony Lindgren <tony.lindgren@linux.intel.com>,
 Xu Yilun <yilun.xu@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
 x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sohil.mehta@intel.com,
 yilun.xu@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-16-yilun.xu@linux.intel.com>
 <ahPbb1Ws9hBruJ2d@tlindgre-MOBL1>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahPbb1Ws9hBruJ2d@tlindgre-MOBL1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/25/2026 1:17 PM, Tony Lindgren wrote:
> On Fri, May 22, 2026 at 11:41:28AM +0800, Xu Yilun wrote:
>> From: Peter Fang <peter.fang@intel.com>
>>
>> TDX Module updates global metadata when add-on features are enabled.
>> Host should update the cached tdx_sysinfo to reflect these changes.
> 
> This should be made clearer IMO. How about mention that get_tdx_sys_info()
> needs to get called again to reload the TDX module global metadata?

Ah ha! This patch answers my comment to patch 1:
https://lore.kernel.org/all/956fa1e6-2920-4b2e-8037-d4b9d812ae53@intel.com/

sysinfo_ext->memory_pool_required_pages and sysinfo_ext->ext_required 
will be updated after extensions are enabled by TDH.SYS.CONFIG.

Patch 06 in this series already reads the tdx_sys_info_quote out of 
get_tdx_sys_info(), which mean get_tdx_sys_info() doesn't ensure all the 
global metadata will be update again.

So how about move the read of memory_pool_required_pages and 
ext_required out of get_tdx_sys_info() and put them after 
TDH.SYS.CONFIG, so that we don't need call get_tdx_sys_info() again?

>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -1049,6 +1049,7 @@ static __init int construct_tdmrs(struct list_head *tmb_list,
>>   static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
>>   				    u64 global_keyid)
>>   {
>> +	u64 seamcall_fn = TDH_SYS_CONFIG_V0;
>>   	struct tdx_module_args args = {};
>>   	u64 *tdmr_pa_array;
>>   	size_t array_sz;
>> @@ -1074,8 +1075,22 @@ static __init int config_tdx_module(struct tdmr_info_list *tdmr_list,
>>   	args.rcx = __pa(tdmr_pa_array);
>>   	args.rdx = tdmr_list->nr_consumed_tdmrs;
>>   	args.r8 = global_keyid;
>> -	ret = seamcall_prerr(TDH_SYS_CONFIG, &args);
>>   
>> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE) {
>> +		args.r9 |= TDX_FEATURES0_QUOTE;
>> +		/* These parameters require version >= 1 */
>> +		seamcall_fn = TDH_SYS_CONFIG;
>> +	}
>> +
>> +	ret = seamcall_prerr(seamcall_fn, &args);
>> +	if (ret)
>> +		goto free_tdmr;
>> +
>> +	/* enabling TDX Quoting may change tdx_sysinfo, update it */
>> +	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_QUOTE)
>> +		ret = get_tdx_sys_info(&tdx_sysinfo);
> 
> The comment above helps, but the change in the handling will be easy to
> miss.
> 
>> +free_tdmr:
>>   	/* Free the array as it is not required anymore. */
>>   	kfree(tdmr_pa_array);
>>   
> 
> So I think it would be good to also add a comment to get_tdx_sys_info()
> to make it easier for folks to follow that it may get called multiple
> times.
> 
> Regards,
> 
> Tony


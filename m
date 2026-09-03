Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078443CE65;
	Thu,  3 Sep 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423793; cv=none; b=HhkAWrTKOPYYB3VsjDuDfFAS0hoesy1Wa0PjdkeQnqXM32L/3MU0QVS57QX3mOk8IEP24/r1+DbuzpF+9E0AT+iSjvtxa9KV5gp45H0Udpys5/3lbxxZAdHraw8wcuS5avGayhnAswLbLNiQtXC/TbysWunnvk7dwB2ZTGm1gk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423793; c=relaxed/simple;
	bh=jFE0VzsMvXTAVGaU1BVdnu2W97FMWlfFEw0yCVouvIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjdSVQ8Z88wINzqGdOBTtzrsUHjq7hLIBwfeX0ESBWc5YC24w/dA4r5wVTmg7xMpQ2pzmWhoQx8PyDLGexUHWFViQBFpeDQtaQFR3LptH2loB4eWlWo+R2Ms3lDmteL8auh4r9Ufh36RxEJlphFrv7uExGhZLUZdK2ua18ZJlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G63q+rc3; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G63q+rc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788423792; x=1819959792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jFE0VzsMvXTAVGaU1BVdnu2W97FMWlfFEw0yCVouvIk=;
  b=G63q+rc34DLdWutxPoCp9OCRwIf+Z9s6CDimhf86CpgcJXwB0BcswS/S
   7ITAYzXlWmYXYMvgPkPC/P/4JoEylhD92VN/XwSm+Rb0SJPDDUunDAVyz
   5w0DijGeQXtHpIs2b/JrfFDWZM3teSopf6G73iCSouhynb/dU7I37d+ev
   dTn2tfvBvf9eqkUC56T2Ed3X2tQoHKWPwoweJvnArhN6npiap9y8zCWcR
   M4JQm0AaZN3hWsSiD9xn65gieeF8HnGQj2Iq2HQvXc4ewAUuYGputz1kh
   QFiXHB0UZjPUyOjHgnnP5DB518nkPLLik2SovJaH8ruSU2CIQ4nq6kqtd
   g==;
X-CSE-ConnectionGUID: Ve6icCiOTu6Bj2sHfgQUSQ==
X-CSE-MsgGUID: qpdZ9m1QTimEpUabdXP9rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88039064"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88039064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:23:11 -0700
X-CSE-ConnectionGUID: RQ4bNxbYR6KnCiWXiHqyIQ==
X-CSE-MsgGUID: VkgMdFy6SGWeIdvXGnaFnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307857196"
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:23:09 -0700
Message-ID: <8a302351-43fd-4d08-b27b-c30e2be3dff3@linux.intel.com>
Date: Thu, 3 Sep 2026 16:23:07 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] KVM: TDX: Filter configurable CPUID bits
To: Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org,
 rick.p.edgecombe@intel.com, chao.gao@intel.com
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
 <20260827031837.2863609-4-binbin.wu@linux.intel.com>
 <96aaabba-678b-4dc9-bf96-a01c605dad04@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <96aaabba-678b-4dc9-bf96-a01c605dad04@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/2026 4:04 PM, Xiaoyao Li wrote:
>> +static u32 tdx_cfg_non_feature_mask(u32 function, u32 index, int reg)
>>  {
>> -	if (has_tsx(entry))
>> -		clear_tsx(entry);
>> +	/*
>> +	 * For a leaf/subleaf/register that will never be repurposed to hold
>> +	 * feature bits, it's safe to return TDX_CPUID_ALL_ALLOWED_MASK, i.e.
>> +	 * leave the TDX module's CPUID config mask intact.
>> +	 */
> 
> I don't think blindly return TDX_CPUID_ALL_ALLOWED_MASK, i.e. all-1s, is a
> good idea. It's just like the current behavior that KVM doesn't gate
> anything and allows userspace to set anything that is allowed by TDX
> module. For example, ...

Sean suggested that "Realistically, CPUID.0x1.E{A,B}X are never going to be
repurposed to hold feature bits, and so generating a mask of allowed bits adds
unnecessary cognitive load and maintenance.  Ditto for CPUID 0x4, 0x18, and 0x1F."
https://lore.kernel.org/kvm/aj1fi_0SBxMK5WOB@google.com/

And I added 0x80000008.EAX as well.

> 
>> +	switch (function) {
>> +	case 1:
>> +		if (reg == CPUID_EAX || reg == CPUID_EBX)
>> +			return TDX_CPUID_ALL_ALLOWED_MASK;
> 
> ... TDX module returns 0x0fff3fff for CPUID.1.EAX currently. If KVM makes
> the mask as all-1s, then if in the future the reserved field [15:14] and
> [31:28] are defined for new things and new TDX module starts to report them
> as configurable, then the bits will be configurable by userspace on old
> kernels while we don't know if its safe for KVM/kernel.
> 
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


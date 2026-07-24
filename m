Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A350F3DAAA0;
	Fri, 24 Jul 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882667; cv=none; b=LCEORYpd++FcdLpTMb4sx170Ji6VsxefvxCNp23ROVO0xVRz9h4toYgUODrgzY0BIOlwmnkHVdFJ2aFcC3et7TE6qRZcLGVroiuDZBDvfg5MT62cVag3m6oerf8/oM0kyTAFfjBHM+U0JCEf9hybH1dWxj6zTGLH50Mz7RGyBP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882667; c=relaxed/simple;
	bh=wc9s1C+qaNFSR4zC+G4oIK97Itt9CbrRtqB9k5JLszE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k77NL79w7Gvd9fejL36dnrzhkOQ/vmeK11Vt4jI+Om/4wYS9CubyCrjtSJANJD8I8TdtKl3kdtRWkFYoeXAxGFE7pFLldn2zY0LcATqTkxwbAk3M37nE7oDfyBk9FAU76WwbPBujwgV8aYYf01LbVDm3NXCTPXDNg83VCnXJB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3fiHLCr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3fiHLCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784882666; x=1816418666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wc9s1C+qaNFSR4zC+G4oIK97Itt9CbrRtqB9k5JLszE=;
  b=R3fiHLCr+EUFBlNQQNY8LnTZgWbfyGDWAH71zzUakLl+WELvfTtTMDa0
   HTj4dGaHg9bXNXvN8qoBjd7uMNwYGSw8yujuX7oQYbhPdRo8u+49OOcsm
   5XPwNtD7IvFab4LtZOOkSBKD2zngF8oAlmXLl2vUlcMKO44pAupnpV6B8
   UOCYL1mP0MBQeThxuipR5OABqsu57MiIxN6ZjotkyX0GJc9IA6aLRQRQI
   4H+tw6j6oJg5SAnbRe4BjDEqTqBJIs3bfl5cBEYcHDzjEW5pKhzLLY3HX
   nFaEkucRHFjCELTIk8mLxFpQ8QRxJg8xJ/nc0NapbSpFDyt6b+eH5n2Z+
   g==;
X-CSE-ConnectionGUID: cq4oOh9GQYaQ2qvmpBu1kg==
X-CSE-MsgGUID: mUsMP4VFQeST94CsYB9K3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96139882"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="96139882"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 01:44:25 -0700
X-CSE-ConnectionGUID: xiuuO3u8Tj+CU7UTGG3iDA==
X-CSE-MsgGUID: wX7Ic+cGQTGFRfSpkh7+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="263629517"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 01:44:19 -0700
Message-ID: <907d28d7-6355-43a8-b5bc-d61d5c640141@intel.com>
Date: Fri, 24 Jul 2026 16:44:15 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/17] x86/virt/tdx: Detect if the extensions
 initialization is required
To: Xu Yilun <yilun.xu@linux.intel.com>, Chao Gao <chao.gao@intel.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, djbw@kernel.org, kas@kernel.org,
 rick.p.edgecombe@intel.com, yilun.xu@intel.com, sohil.mehta@intel.com,
 adrian.hunter@intel.com, kishen.maloor@intel.com,
 tony.lindgren@linux.intel.com, peter.fang@intel.com,
 baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, seanjc@google.com
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
 <20260618081355.3253581-4-yilun.xu@linux.intel.com>
 <akIR1ClnTs1bRsD9@intel.com> <akOkGqH6RQEs/RWN@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <akOkGqH6RQEs/RWN@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/2026 7:10 PM, Xu Yilun wrote:
> On Mon, Jun 29, 2026 at 02:33:56PM +0800, Chao Gao wrote:
>>> +static __init int init_tdx_module_extensions(void)
>>> +{
>>> +	struct tdx_sys_info_ext sysinfo_ext;
>>> +	int ret;
>>> +
>>> +	if (!(tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_EXT))
>>> +		return 0;
>>> +
>>> +	ret = get_tdx_sys_info_ext(&sysinfo_ext);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	/* Skip if no feature requires TDX module extensions. */
>>> +	if (!sysinfo_ext.ext_required)
>>> +		return 0;
>>
>> What would happen if the kernel doesn't do this 'ext_required' check
>> and always does the extension initialization?
>>
>> If TDH.EXT.INIT returns success when no extension is configured, we
> 
> No, TDH.EXT.INIT fails when ext_required==false

What is the SEAMCALL return code in this case?

>> could drop this 'ext_required' from this series entirely.


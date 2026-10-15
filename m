Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8023D954F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042591; cv=none; b=FZ0pq6k+uA7F/NBzMd98dYWx+xbLVX4EvsEfe0l4tj82P8NCZZ0vH02JEPw94uosuiE62bs9L/z3XNbBn1mi/M3kQdvTyjr7TAPFbLFaMGfohziI7AA0FCNCsLV/6dE9mMmVhai/kNe4j+AfqTrLVfKpWhu835EIimnBg23P6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042591; c=relaxed/simple;
	bh=YHcSKOLBJOoNtJyB5aOgcwXpa+18e1BEYIgtyJY2ceI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a9nRsof1zNk1rLKHQcgJNbEA3mlyYUigmTQObBnz+OnwOR+JoWq/xyE2YSJO9Cjgm+f+AAkf3NEQoTPgqaMvoGAdCvCfb4rS6S1WXh2GFWvZc3aP8nF6YYrz8UkkhgEUxaKht+7qVZhG1wRpPOFtLECVAljjWu7UNQxkKADkG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgHV0+7z; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgHV0+7z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792042589; x=1823578589;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YHcSKOLBJOoNtJyB5aOgcwXpa+18e1BEYIgtyJY2ceI=;
  b=jgHV0+7zCqpNfdztOhPBj6gismijBJrGncuQkRFKHS1Bnl4ybRee3FuK
   caAa9awIcw7Kp32RTSPYPO3fAk8GEqIsK1MYnkxl6wsTYrvLTqY/D+cgy
   EuyEDOsrK0Ga/DZvN86vmXPZ3EA0ijbBXy10dgoat2vVw5xCvCasUpYyw
   ID7P3tfeogF6+It7rK8xUDl9+K1lkAYx+Ip3CpVCgl5X9YsOpw4s6sAkW
   CIVzt3UAWSRa8UEQmvLNBTJ6EV/HRuTRUSYbK18PezNckpkQFlvQROwy7
   ZVY9e3Z3u/xY785lWzZ/1KYgd7w+hF6gjTwoIwjS5rPUNsjiVQqdplTJp
   g==;
X-CSE-ConnectionGUID: N4PvRq9aSqemeMMLBS2kKA==
X-CSE-MsgGUID: lrgo7iVKReCwyjO/MnZRMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="707821"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="707821"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 22:36:29 -0700
X-CSE-ConnectionGUID: hcapkMVfRTCxLKj00KQljg==
X-CSE-MsgGUID: hYDCCH7WSaaYCkmp2xKhNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2046568"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 22:36:28 -0700
Message-ID: <7c545051-063d-4604-8304-28f42bfe95f3@linux.intel.com>
Date: Thu, 15 Oct 2026 13:36:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 1/4] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
To: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org
References: <20261015010705.1973284-1-baolu.lu@linux.intel.com>
 <20261015010705.1973284-2-baolu.lu@linux.intel.com>
 <sashiko-outbox-172091@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <sashiko-outbox-172091@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/2026 9:28 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] x86/virt/tdx: missing clflush on IOMMU parameter pages
> --
> 
> commit ea38aa1a74969b72895a018349277b8a5b88cfb3
> Author: Lu Baolu<baolu.lu@linux.intel.com>
> 
> x86/virt/tdx: Add SEAMCALL wrappers for IOMMU setup/clear
> 
> This commit adds SEAMCALL wrappers for TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR.
> These functions transition an IOMMU into and out of Secure TDX Mode to
> provide the trusted foundation required before enabling TEE-IO security
> protocols.
> 
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 1b9ff749dd8e0..5d31c1b0890ae 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
> [ ... ]
> 
>> @@ -2034,3 +2034,59 @@ void tdx_sys_disable(void)
>>   	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
>>   		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
>>   }
>> +
>> +/*
>> + * Wrapper for TDH.IOMMU.SETUP leaf, which transitions the IOMMU and related
>> + * I/O stack into Secure TDX Mode.
>> + *
>> + * The @root page format is defined by the TDX Connect ABI spec (Table 3.35,
>> + * Structure of IOMMU_MT Parameter): the first two entries describe the size
>> + * and HPA (Host Physical Address) of the two contiguous buffers for the
>> + * invalidation queue; the remaining entries provide HPAs of
>> + * IOMMU_MT_PAGES_COUNT metadata pages. IOMMU_MT_PAGES_COUNT is obtained from
>> + * trusted IOMMU global metadata.
>> + */
>> +u64 tdh_iommu_setup(u64 reg_base, void *root, u64 *tdx_iommu_id)
>> +{
>> +	struct tdx_module_args args = {
>> +		.rcx = reg_base,
>> +		.rdx = __pa(root),
>> +	};
> [Severity: High]
> Does the root page need to be flushed from the CPU cache before being passed
> to the TDX module?

No. The hardware handles cache coherency when memory moves between
KeyIDs, so the VMM doesn't need to flush pages before handing them to
the TDX module. The TDX architecture is being updated to drop the
requirement for VMM-assisted flushing, and the existing flushes in the
TDX code are being removed by this series:

https://lore.kernel.org/r/20260922205215.870563-1-rick.p.edgecombe@intel.com

Thanks,
baolu

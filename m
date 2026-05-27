Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B254317173;
	Wed, 27 May 2026 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863917; cv=none; b=sHWAUcKl4MEaXCgnqeJwYKwapczgsnyaJL6NdBeAGxLfgdy00R4AwojO34RkPRzHwRkmD4+cmmIKP9OnnjuuIx22oiTJVasrZuwH+WFLQTlFp7Fw2owFpMGIfW6Ca1GfU86QRTHJ5qQwdtN5rkOJLvtiQv1rN8KyihlLimkyzXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863917; c=relaxed/simple;
	bh=VSu4XacPTfAAH8TU3ziJiUZvBWBgsgB8TWw5Zo7aixc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huq8linzTMXSRMtGZV3ejQRopJNF/kMkxzXa31JrDzxVqI1QwN+lrNr7SXWcwlwEMfHhq19HD3Rtz7Ae2fuEUfE604jKREufCDcRL69U+uFyWEHNS/BdpSSvPuHdyRYKAAaQ+9pZf1uqGbieNwcdhjnuJoKTbcPaSz1AuOAPa1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfLncmD7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfLncmD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779863915; x=1811399915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VSu4XacPTfAAH8TU3ziJiUZvBWBgsgB8TWw5Zo7aixc=;
  b=OfLncmD70bVfJvRHW/7c0rnNu7cALKKnXIcDYF39mvFqI/PZjbK7tqR0
   tjMTtxcfb3rlJmYWA4esP8KWrAFA43jBvXvl7Gq6041w5ATfjELPBxLYE
   S32Pzic26MizFRISehMCBwVZ20mKvT60s3fcMZsY7gxy3fw6943fuTIlC
   aU08EnbcNkINq/pHfM+cx+cffgNNV2bhn5dc9GGFaGyfK+UGniBUA3UnK
   tFpD3kcygB227VxsPXEX6SjJUvPM/k9ePz51CSmQ7uA7ok5cfPFPH40/2
   AVmIDr5bg6OJHh7Z7tQk4dDEqHqNJQwgi1fKsfakAur6XnRXiwGMGQRiT
   Q==;
X-CSE-ConnectionGUID: 4MKbSAVaTSGQxSh+e6aIaw==
X-CSE-MsgGUID: xXOfNSG0SmKWclR966MDIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="92158794"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="92158794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:38:32 -0700
X-CSE-ConnectionGUID: Quk2jmmASI6UVSAQSf603g==
X-CSE-MsgGUID: DpkUDCMMRsOKxfD2sC+3FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="246170051"
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 23:38:30 -0700
Message-ID: <9073ac91-3aa4-41e2-bb81-8878409498e5@intel.com>
Date: Wed, 27 May 2026 14:38:27 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/virt/tdx: Add extra memory to TDX Module for
 Extensions
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
 x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sohil.mehta@intel.com,
 yilun.xu@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-3-yilun.xu@linux.intel.com>
 <7139c55b-b949-415d-ab82-fca1b1cc3880@intel.com>
 <ahZpUA62NRdNrkvZ@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahZpUA62NRdNrkvZ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/2026 11:47 AM, Xu Yilun wrote:
>>> +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
>>> +{
>>> +	u64 *entries = page_to_virt(root);
>>> +	int i;
>>> +
>>> +	for (i = 0; i < nr_pages; i++)
>>> +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
>>
>> Is the page flush only needed when CLFLUSH_BEFORE_ALLOC is true?
>>
>> If so, it inherits the same decision to always flush as what
> 
> Yes it is basically the same as tdx_clflush_page().
> 
>> tdx_clflush_page() did. Then, any chance we can use tdx_clflush_page() here
> 
> But I don't think we should convert hpa/page/va back and forth just for
> re-using one line of code.

Because we want/need to flush page as late as possible so that the page 
flush needs to happen right before SEAMCALL?

How about we pass in the struct page * and number into tdx_ext_mem_add() 
and construct the root page inside it?

>> so that we have a single central place of the comment to explain the kernel
>> design decision.
> 
> How about I add a comment here to connect this wrapper to
> tdx_clflush_page():
> 
> /*
>   * Unconditionally flush the pages regardless of CLFLUSH_BEFORE_ALLOC. Inherit
>   * the same decision as tdx_clflush_page().
>   */
> static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
> ...

It works either. I don't have strong preference. Let's see if anyone 
else say something about it.


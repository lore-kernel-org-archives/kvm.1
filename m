Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EC2C0298;
	Wed, 27 May 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869917; cv=none; b=M91B7t59Yjtq0QvgIPmurq7apt5hT6Fg6ZoAJqtVP+WqIMBgMWCxRXOas94kpzMuSwTqEwfqBJoMH9sxJZf6USSDz8KnayOegpqHMDYLfymaQDTGsdjoY7OhUal4s8LPF+sgxvxNPUn4F7uiThqGm+DLNe/P0i8Dd4qPBHmcM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869917; c=relaxed/simple;
	bh=b55VKgZiKOSG2FPMrZJzbwIxqWhf76qsIHBgDm2uw+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UckUGm//z/kFRvLseL362HETx2TD2AXeIR6UIpDQA7WW+YCW17X341bXgDWH8NuAin03V29scWV9e0MWAmCMzHgY7aKDQ5FsOecTZJTSVCnHZrvy/qeYTRW3VqV8liReXeIby7AvD30JmGY6FjEhLUasdFwjbhDkDETksteAtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV3EJ1ps; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV3EJ1ps"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779869915; x=1811405915;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b55VKgZiKOSG2FPMrZJzbwIxqWhf76qsIHBgDm2uw+8=;
  b=jV3EJ1pschxYw23oxkdcTuo2CDVJl68YovIPYk/rWdfeE/Nr2ZUQK41Y
   kdgrNdxYzYSfvOQhTr2/VfjVxD1H6oJfj3FKGR1FQAGg5LD/MlDpDROHP
   ZFeI/z+O1g98pCzLTiNQptiAm1ALXBYSD+fbfI9n5yByL9ji2MsVwyjRp
   DXYw6HpHmAxYu8jSB60Jl/qGTFPqlGBiHh1EMXlSutWdOfXwExqcwOeHi
   fmz/6RiXUiBK5QW1LRDLbiIsf75gNOdMLea4DFbXjPPQXL98RrWL1ZRjJ
   GY6XVSAe/fadl+46b20eI8lOn4h/tmEN8sXM3bc9ShzD9vVkqjMv+xV3m
   A==;
X-CSE-ConnectionGUID: DTRHef3bRVSMNs+5yTN2CQ==
X-CSE-MsgGUID: BN1Xx4VCRxSLyj5PUYnJNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="84320724"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="84320724"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 01:18:35 -0700
X-CSE-ConnectionGUID: D5o+KFTNSTSlwNvmbE8HDw==
X-CSE-MsgGUID: O0cjRpl6Qhyq1Uex2j8Uqw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 01:18:30 -0700
Message-ID: <534aa31c-c643-4b64-ab0f-59cf29a52d99@intel.com>
Date: Wed, 27 May 2026 16:18:28 +0800
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
 <9073ac91-3aa4-41e2-bb81-8878409498e5@intel.com>
 <ahaeCGLPEfmYNFtC@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahaeCGLPEfmYNFtC@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/2026 3:32 PM, Xu Yilun wrote:
> On Wed, May 27, 2026 at 02:38:27PM +0800, Xiaoyao Li wrote:
>> On 5/27/2026 11:47 AM, Xu Yilun wrote:
>>>>> +static void tdx_clflush_hpa_list(struct page *root, unsigned int nr_pages)
>>>>> +{
>>>>> +	u64 *entries = page_to_virt(root);
>>>>> +	int i;
>>>>> +
>>>>> +	for (i = 0; i < nr_pages; i++)
>>>>> +		clflush_cache_range(__va(entries[i]), PAGE_SIZE);
>>>>
>>>> Is the page flush only needed when CLFLUSH_BEFORE_ALLOC is true?
>>>>
>>>> If so, it inherits the same decision to always flush as what
>>>
>>> Yes it is basically the same as tdx_clflush_page().
>>>
>>>> tdx_clflush_page() did. Then, any chance we can use tdx_clflush_page() here
>>>
>>> But I don't think we should convert hpa/page/va back and forth just for
>>> re-using one line of code.
>>
>> Because we want/need to flush page as late as possible so that the page
>> flush needs to happen right before SEAMCALL?
> 
> I think so. Let the flushing be part of the tdh call semantic.
> 
>>
>> How about we pass in the struct page * and number into tdx_ext_mem_add() and
>> construct the root page inside it?
> 
> I assume you don't suggest allocate root page inside the call, then we
> need 3 parameters for the HPA_LIST_INFO:
> 
>    struct page *, unsigned int nr_pages, struct page *root
> 
> which I think too much.

yeah, sort of.

> I think your concern is to try not to introduce another tdx_clflush_
> variant, but I believe this will happen, pfn based memory description is
> on the way:
> 
> https://lore.kernel.org/all/20260430014929.24210-1-yan.y.zhao@intel.com/

I don't object the variant of tdx_clflush_hpa_list(), but suggest if 
tdx_clflush_page() can be used instead of raw clflush_cache_range()

Maybe we can try to put tdx_clflush_hpa_list() along with 
tdx_clflush_page() and tdx_clflush_pfn()? This way, I think we can save 
the separate comment.


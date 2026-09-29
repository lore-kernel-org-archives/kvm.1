Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C503A873A;
	Tue, 29 Sep 2026 07:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790667808; cv=none; b=bc7JWVVj1zANBre67TMVkg5c3IGhS/VW90AgSdhagnqjP/eHzaOceBB81QG1p8yf8vP8EcJOxj+DYKWRXJ35++4TZOsfJkXO5tw/WeBL2kpGLuThA89BZq4+3mm3lMzlbrVpWxKZnWtq9dSfaYjvuXH5YLU0bChwTEyiOfPSX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790667808; c=relaxed/simple;
	bh=ZS3Uwb8xM0JRyf4ECojhTiKdryKdMbYSqg1pPBs1pAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fheHdztWBQTrAJZhMGyLBRbVZRNsxUiBv5TArEtTmrh4LOuDvGk/M+YVQGYaYsW4Puh2LyTtkeDiB5N5F93V21Ct4OTWvMygwfz5rSmSuQRDnGGn5+OWO3+Mi69fbeJvod2H/KL8solOIAc9xWWij6XCDaRgFLxmOrtPDcIqdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awT5NkRY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awT5NkRY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790667807; x=1822203807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZS3Uwb8xM0JRyf4ECojhTiKdryKdMbYSqg1pPBs1pAo=;
  b=awT5NkRYfiFzJjZqKEEZdphcvt+nzEwwUJlHzuAVhWiXyeK+xpnQAt45
   thZFUj7FfhEE6fZqzAwGfT5Mdm52oXul/Ii32W5rtFyF9P73JgI9eXp8O
   mph/Y9PUUvI216Oc9TLp9L7NuTWLZe4f8K0DQ/xAxYGE3kPMXnezV2lTK
   ZqpmOjX0ddVz0VHvOY8/1f2ap1ObXBGrBrbW1U5K8VYeKBWVHp07pm/pg
   9BHo0ShiMWJZ0aReF3p/KQJ0HKTc8JQw6yYr3TS9jJTqQPjIBhsk/dgvZ
   OM+1svgbngvSX2RtRdmvtsd+hBl+DAkynRYElpUleEmH1+SidmlQU/xx8
   g==;
X-CSE-ConnectionGUID: Ej1FIA5gRoa5Rk+UgE5WqA==
X-CSE-MsgGUID: GJExWsfTQy++5/4edc9G/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90431648"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90431648"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:43:24 -0700
X-CSE-ConnectionGUID: q5CLkmCiQ6WWyZgTlePKGA==
X-CSE-MsgGUID: Bx4OISMOSya+fzByzBmhhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274403098"
Received: from unknown (HELO [10.238.1.46]) ([10.238.1.46])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:43:19 -0700
Message-ID: <6df0a7cf-e88f-409b-8601-1e98367e4930@linux.intel.com>
Date: Tue, 29 Sep 2026 15:43:17 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] virt: tdx-guest: Give the Quote buffer an explicit
 type
To: Peter Fang <peter.fang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, kvm@vger.kernel.org,
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Tony Lindgren <tony.lindgren@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>,
 Artem Bityutskiy <artem.bityutskiy@intel.com>
References: <20260928100913.2265687-1-peter.fang@intel.com>
 <20260928100913.2265687-3-peter.fang@intel.com>
 <bd46aaba-2c07-4b4d-b76a-30a1dff21b0f@linux.intel.com>
 <artrprfgz7Q5CEz7@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <artrprfgz7Q5CEz7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/29/2026 3:41 PM, Peter Fang wrote:
> On Tue, Sep 29, 2026 at 10:13:32AM +0800, Binbin Wu wrote:
>> On 9/28/2026 6:08 PM, Peter Fang wrote:
>>> The Quote buffer is always a "struct tdx_quote_buf", but its global
>>> pointer is a "void *". A function would have to convert it back to make
>>> sense of it.
>>>
>>> Declare the global with its actual type, and give it a better name.
>>>
>>> This creates variable shadowing in wait_for_quote_completion(), so
>>> rename its parameter for clarity.
>>>
>>> AI was used under supervision to collect/apply feedback, review code and
>>> workshop logs.
>>>
>>> Signed-off-by: Peter Fang <peter.fang@intel.com>
>>
>> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> 
> Thanks Binbin!
> 
>>
>> One nit below.
>>
>>> ---
>>> v5:
>>>  - New patch. [Dave]
>>> ---
>>>  drivers/virt/coco/tdx-guest/tdx-guest.c | 35 ++++++++++++-------------
>>>  1 file changed, 17 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> index d0303e31e816..896eb0a09c4a 100644
>>> --- a/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> +++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
>>> @@ -192,7 +192,7 @@ struct tdx_quote_buf {
>>>  };
>>>  
>>>  /* Quote data buffer */
>>
>> The comment should be updated as well.
>>
>> "Quote buffer" or "Quote request buffer"?
> 
> Hmm... I think with this refactoring, either one becomes kind of
> redundant. I was thinking of adding something like "GHCI Quote buffer",
> but that's pretty much documented by struct tdx_quote_buf itself.

Agree.

> 
> How about I just drop the comment?

It's OK for me.

> 
>>
>>> -static void *quote_data;
>>> +static struct tdx_quote_buf *quote_buf;
>>>  


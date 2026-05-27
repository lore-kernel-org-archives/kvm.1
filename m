Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBB3C942C;
	Wed, 27 May 2026 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867893; cv=none; b=UfqQmOAWNpxHsWOqOCNnQpU+X/L5E8ScsVXL4EoVvEK8C3eC+gaxoPVuyl/paa3Q+sAlGtQPgLvUCGLZZ40rJ7FPlijzGOodtjwOCBFIq3oF0d1GxmYXs4KVZWSZBZ8H3piepcTs5PbFkp8wnD9OYErcZAuR59tPw/JMZqik/8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867893; c=relaxed/simple;
	bh=ozTte0BPwNdQBHJiGla2o7AXE7eUx+UmAxnUXu2Ky3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZv5Y5C7pMG/dvMNNp2i13ZRVGz7I/DqrdvC2eEjDHXvPZC5048nw0CRXANPFtUPJ6op3+3KMsefzX/oTr8LsKsdq24p5MaLjRZzGkpVxi6Wm80mfQKU/qFtxgaaQSEe1tDDFhwfWdbPirQBUC/XdqHD//xXeIXCmsXwxcp7XWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8rI6o95; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8rI6o95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779867892; x=1811403892;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ozTte0BPwNdQBHJiGla2o7AXE7eUx+UmAxnUXu2Ky3M=;
  b=R8rI6o95/eEvTByw9S3NY8YkhCOEf79YMm5MUfra4iSSM4oESwjmVkgI
   YcEp4AksSCReR+LjFzAqEurOCK1iaS1+RgzBNyV94HppfDSzPBNVP+zFv
   TuWkP0jV+nWYG96mZS8sAaRLHvQ6S3r5MsOLGGtYJPdLUSTSrbq47KU8l
   uneRFv4AUAwQ+pO1QITuTuqSIlzb6zeXXlSVngWGJFhDPovdUziUD6m0/
   cFCw22KeJhe91ceYJxWpa2EBRCaFnZJjHKCtg3HYq90DLgNKMB20y0nxf
   xTHlSwXLpqnIpsr4h0P/a8m1owYIskUozYIWUgEOQXAsOMOYse/V7Vt+a
   Q==;
X-CSE-ConnectionGUID: 3wn55UA9SEmqJR/No+0fjQ==
X-CSE-MsgGUID: CW45+ZLPRtuvmFHJPoD2Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80540624"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="80540624"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:44:52 -0700
X-CSE-ConnectionGUID: ogpwk6xURDeHw5xpPmxqyA==
X-CSE-MsgGUID: X2M247fxQ4uIWZBSd9O9Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="280280973"
Received: from unknown (HELO [10.239.158.45]) ([10.239.158.45])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 00:44:48 -0700
Message-ID: <df4eb3b2-a11e-4d73-b298-af1beb92d53f@intel.com>
Date: Wed, 27 May 2026 15:44:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/15] x86/virt/tdx: Embed version info in SEAMCALL
 leaf function definitions
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: kas@kernel.org, djbw@kernel.org, rick.p.edgecombe@intel.com,
 x86@kernel.org, peter.fang@intel.com, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sohil.mehta@intel.com,
 yilun.xu@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
 <20260522034128.3144354-15-yilun.xu@linux.intel.com>
 <90a4835f-bc11-4415-a7b6-84347f40861b@intel.com>
 <ahaTH+O8YGxEXSpz@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ahaTH+O8YGxEXSpz@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/2026 2:45 PM, Xu Yilun wrote:
>>>    /*
>>>     * TDX module SEAMCALL leaf functions
>>>     */
>>> @@ -31,7 +44,7 @@
>>>    #define TDH_VP_CREATE			10
>>>    #define TDH_MNG_KEY_FREEID		20
>>>    #define TDH_MNG_INIT			21
>>> -#define TDH_VP_INIT			22
>>> +#define TDH_VP_INIT			SEAMCALL_LEAF_VER(22, 1)
>>
>> how about
>>
>> #define TDH_VP_INIT			22
>> #define TDH_VP_INIT_V1			SEAMCALL_LEAF_VER(TDH_VP_INIT, 1)
>>
>> and use TDH_VP_INIT_V1 below?
> 
> I'm trying to avoid a _Vx postfix if unnecessary. Don't make callers
> have to choose between versions. The main MACRO should always point to
> the latest version since later versions are backward compatible.

I don't agree.

The later versions are backwards compatible, but the later versions 
might not be supported by the loaded TDX module.

Usually the callers will have to choose between versions due to the TDX 
module being used varies, just like the case in the next patch.

We can make TDH_VP_INIT represent the v1 as this patch because Linux 
mandates v1 when the code was merged. So it can be made the default.

> The next patch is an exception. I've found there is no public TDX Module
> release available for TDH.SYS.CONFIG v1. I expect people just use the
> un-versioned MACRO for development, but have to keep the explicitly
> versioned _V0 macro for compatibility for now.


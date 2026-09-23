Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A852414A27;
	Wed, 23 Sep 2026 07:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148623; cv=none; b=pT+l2HBxuSQy/pmex3+sOSkALmhqgPawwPnvA0w8ipMKRhEsydm9gZ1pQmXuZCjN+vh9aGiqBuUVyaYLxX/zb+XZEbh9UepuJK764TzIY1f/iCkBtpq7kShHvcAyjjUR+adYj8SagJFExnTuhXyzZQ8NLMJXJgy3owk7IsuoKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148623; c=relaxed/simple;
	bh=C1iVFAsRGzQ01xpSelZwvWYCC+dug6K7I4nqba/msFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAlfF0u84eUBWskP/Vy1u1NX+KBMYbYpN7sp6DRjqy7cbdDj8M+EDLrXHwpOZKIQt3gGMEMUTSC7WGlhfj4xUqVcOdUBdmCLL7C6xvoPPqRz/QMeLO3tKDHYyWmprVNy8tLRmBmmO1kbM7VuaLyc17mNo5zbOqIl5vE2vzzBTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LY4MtG/N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LY4MtG/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790148622; x=1821684622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C1iVFAsRGzQ01xpSelZwvWYCC+dug6K7I4nqba/msFc=;
  b=LY4MtG/N5l3sSR+1KUYS2kLrVU9xkBgHIzWNFg9QArXa0ZEeOk13nnGu
   MHuadRdF0TDkJdFqqMdZ8vsjaY2Lzun60xNzsHR/zO7Dv2/1zMbS4PEIw
   4rPEGgnTBMTRc0MTX0mi3s6yUmUj0lSb2L3UKM53fJWy/+XMmZnSxiwm1
   Poi/gXsJxFdCkWfL/OXtH0vppG3BJ3ONF9x43Ve2VTFynYdUwTffTG/AZ
   igRYydbz98JajQlTzzi7X5kGHDPilx1tRDcMHBnJSv0pZ8JtqIGeEj24h
   8ci47HF37z5fKtE7LJGCGHuwgd0s9fYlcwDje5LVOl1WnKDt4sju9ahVv
   Q==;
X-CSE-ConnectionGUID: Q35m9yxgRKic92SPddxGug==
X-CSE-MsgGUID: 75cRdhNcRTm8C8YGikKgEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108314340"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="108314340"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:30:19 -0700
X-CSE-ConnectionGUID: PiTlRojYS4STvyIKuL3YIQ==
X-CSE-MsgGUID: YXsGaH0rQk2IEGhrPFSBCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="4778806"
Received: from unknown (HELO [10.238.2.139]) ([10.238.2.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 00:30:14 -0700
Message-ID: <7698d2fc-fd72-4772-a017-a4a16f34cda6@linux.intel.com>
Date: Wed, 23 Sep 2026 15:30:11 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/virt/tdx: Drop tdx_clflush_*()
To: Yan Zhao <yan.y.zhao@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: pbonzini@redhat.com, dave.hansen@intel.com, seanjc@google.com,
 x86@kernel.org, kas@kernel.org, adrian.hunter@intel.com,
 binbin.wu@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20260922205215.870563-1-rick.p.edgecombe@intel.com>
 <20260922205215.870563-2-rick.p.edgecombe@intel.com>
 <arNirJownovqY66q@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <arNirJownovqY66q@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/2026 1:25 PM, Yan Zhao wrote:
> On Tue, Sep 22, 2026 at 01:52:14PM -0700, Rick Edgecombe wrote:
>> The TDX module exposes a bit (CLFLUSH_BEFORE_ALLOC) to say whether it
>> requires some memory to be flushed from the cache before being handed
> Drop "some"?
> 
>> to the TDX module.
>>
>> During the initial TDX upstreaming, it was decided it would be simplest
>> to just always flush in these cases, rather than checking for the bit and
> "in these cases" is ambiguous.

I assume "some memory" and "these cases" refer to memory pages allocated for
TD private memory or TD control structures. I agree with Yan that it would be
better to just state that explicitly.

> 
>> having conditional logic. So currently the kernel flushes in several
>> places when handing memory to the TDX module.
>>
>> In practice this bit has never been set by any TDX module, so flushing
>> is unneeded. Going forward the TDX docs will be updated to clarify that
> "Going forward, ...".
> 
>> CLFLUSH_BEFORE_ALLOC will never be set in any future TDX module either.
>>
>> So make code even simpler by just deleting all the CLFLUSH_BEFORE_ALLOC
>> handling.
>>
>> AI was used to review the change.
>>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>

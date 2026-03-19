Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE23E23EAB3;
	Thu, 19 Mar 2026 03:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889338; cv=none; b=EmRll+TKwWbb0t8miEOd0yol/u/k/Cbn6TvdixIh7lwfB1pYT58m3If5UuI6OWJy3WPiK8M9/Q1/sRiDne2UmCqHGWZVyvjKUN+ZK725gNLzBB5zuaJ976kdC1gHX7MzIE/zrj/awgOSGuOz9ou7bYIs7FHyZfVk7FLVHEcMvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889338; c=relaxed/simple;
	bh=gFNjpQJN39uu4Al2ExkTEGIz348KzOd8eXSmAAk4A3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgJI1iLYE6RuBC4jWfiHNFcJjWBOotEEgItNa3FVH+pM6biH7zE3LYq6KQLPm4j6ua/TjLjcaJB/5DFYktwZj4Fk6reKdA+mx8a7BeJFosX4HgKu7KwtMrSu9+z3F5r1XpANYXDgvt8yig3HkJq99BRjWJupm/fDNjbC7fypOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LzKDYNVR; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LzKDYNVR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773889337; x=1805425337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gFNjpQJN39uu4Al2ExkTEGIz348KzOd8eXSmAAk4A3w=;
  b=LzKDYNVRlzKS0g0WUQxH516qGZAdS4CMbbkbdzt3XnRApit5klroYVDy
   4PLIg9+EPpELefY7qKX/2Sfg8IwtADJWnu1BuMW56yOa8yi1cc7M3oVFI
   qo7z9N/owWpsB0YalhLMEs0rSkyWs6QOxz/41ugxNmXVuQQM2TsNcqlbj
   8atd8y4pPiTmslj83tHBeaPtJXBFYKJDhh6dXMU/JKQNg1o30wYiZHjn/
   dY7RlQbqCEX3P2BFiuFhFzfC3gwntwtgmvjVavf5fcAcGjsJcAK7L4PE3
   WS0XT0dOtD05OGKYC+aAuEJbwqoYxhf2H4waR5U7riwLhu0aYknxT0GZM
   g==;
X-CSE-ConnectionGUID: 46qcbedcS7WXFKYJtS3LYA==
X-CSE-MsgGUID: 0pVcHJhxT5md7UVO0PnNgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="74932535"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="74932535"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:02:17 -0700
X-CSE-ConnectionGUID: UWoxtB6QSiWc2il/ysgejg==
X-CSE-MsgGUID: 9+rjIA5zSAWkXAyVWpe33A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="216936923"
Received: from unknown (HELO [10.239.158.72]) ([10.239.158.72])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 20:02:08 -0700
Message-ID: <8c319f32-b088-4594-a1b6-d6a755074a1b@intel.com>
Date: Thu, 19 Mar 2026 11:02:06 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for
 P-SEAMLDR SEAMCALLs
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, binbin.wu@linux.intel.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, kai.huang@intel.com,
 kas@kernel.org, nik.borisov@suse.com, paulmck@kernel.org,
 pbonzini@redhat.com, reinette.chatre@intel.com, rick.p.edgecombe@intel.com,
 sagis@google.com, seanjc@google.com, tony.lindgren@linux.intel.com,
 vannapurve@google.com, vishal.l.verma@intel.com, yilun.xu@linux.intel.com,
 Farrah Chen <farrah.chen@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
 <20260315135920.354657-5-chao.gao@intel.com>
 <935081ba-9f66-4bdf-a408-c19be32c6ad3@intel.com> <abpxvVk9XrEU6ssJ@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <abpxvVk9XrEU6ssJ@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/2026 5:34 PM, Chao Gao wrote:
> On Wed, Mar 18, 2026 at 03:13:06PM +0800, Xiaoyao Li wrote:
>> On 3/15/2026 9:58 PM, Chao Gao wrote:
>>> The TDX architecture uses the "SEAMCALL" instruction to communicate with
>>> SEAM mode software. Right now, the only SEAM mode software that the kernel
>>> communicates with is the TDX module. But, there is actually another
>>> component that runs in SEAM mode but it is separate from the TDX module:
>>> the persistent SEAM loader or "P-SEAMLDR". Right now, the only component
>>> that communicates with it is the BIOS which loads the TDX module itself at
>>> boot. But, to support updating the TDX module, the kernel now needs to be
>>> able to talk to it.
>>>
>>> P-SEAMLDR SEAMCALLs differ from TDX module SEAMCALLs in areas such as
>>> concurrency requirements. Add a P-SEAMLDR wrapper to handle these
>>> differences and prepare for implementing concrete functions.
>>>
>>> Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
>>> ("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
>>> callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
>>> the kernel does not need to interact with it for runtime update.
>>>
>>> For details of P-SEAMLDR SEAMCALLs, see Intel® Trust Domain CPU
>>> Architectural Extensions, Revision 343754-002, Chapter 2.3 "INSTRUCTION
>>> SET REFERENCE".
>>
>> SDM started to contain SEAMCALL definitions. How about just dropping this
>> paragraph to avoid people from reading the old doc?
> 
> I didn't realize that. Thanks for the information.
> 
> But I don't think this is a stale reference. The SDM description is high-level
> and points to the same spec for details:
> 
>    The details of such transitions are specified in the Intel® Trust Domain CPU
>    Architectural Extensions.

The old "Intel® Trust Domain CPU Architectural Extensions" spec has 
bugs. Remember 
https://lore.kernel.org/all/20251014231042.1399849-1-seanjc@google.com/ 
? They have been corrected in SDM.

I'm not trying to say it's a stale reference. I just think directing 
people to an old doc (especially with an exact revision number) can make 
them get outdated and incorrect information.

>>
>> ...
>>
>>> +static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
>>> +{
>>> +	guard(raw_spinlock)(&seamldr_lock);
>>> +	return seamcall_prerr(fn, args);
>>
>> How about adding the reason of why choosing seamcall_prerr() instead of
>> seamcall_prerr_ret() in the changelog?
> 
> Sure. Will add:
> 
> Use seamcall_prerr() (not '_ret') because current P-SEAMLDR calls do not use
> any output registers other than RAX.

looks good to me.

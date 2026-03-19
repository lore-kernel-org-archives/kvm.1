Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29103AEF54;
	Thu, 19 Mar 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773910580; cv=none; b=GpCSrsf3odUnX7v8VdjUkP00VbbnPO3Hy9T0kUob/uytiRq8AHsOFzkBZfcGA/D6BxzPYS+f1zV6XihDszwwyvkPME3K4m1CLPU8v4X+EpDApatcp1mKWhZlrKdwZYTZ+MHqmn+Jn9SP1BxkZPyn5rlpZnJWqBYeJ5uf4Z/If6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773910580; c=relaxed/simple;
	bh=AM9Ca6izb+1mQmXs16F3D4WDBQ7w+heKs1wpaUQK/zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgLn+skd+g7VOXnB8ebNRmWHI+tadOpVB6IhjO1o9l2Y8YeaT8gsNh2EVqzdXT2ffLWjJnxssy+FYEGNO6Aqk7WkViGUrz9WTzFssAAzNXXWzjoMctKbo1eSJEVS4VI6BkJrV2IBDMCL1oNqYVhiUkGhOhtkn403jBNV1VsI6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=igQKqrd9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="igQKqrd9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773910578; x=1805446578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AM9Ca6izb+1mQmXs16F3D4WDBQ7w+heKs1wpaUQK/zs=;
  b=igQKqrd9j1EGtCT6W9sppAGA5Z7xyz13PrIWm9ynASChJuNMgeJdkNLd
   0jK5IwJEadzQNysqcXLE3nBWYlNTznXxdgQHBcK7gB4xI3LRMW8lnSouI
   K8VzVXERFTXs15RdSNneuD+oou5psWeZhkNAp+sc+/OWHFTTyqTV5UkUa
   Zd98vxyaZV7BbqjQ551xoAbexFenPEzA7vSSiIWlsAe9d6OqZ3u/Rzu0k
   Nu9bKTw4+k5CfCsPQJ0Dgu162W0/Yp0WxO3ex2m6ykV2etZqI63oYWSch
   0bat4jvDMEuQfpQisnCuVfiDG2UsSWpWstOmboCAFng9o6sTm2+MxKJ3f
   w==;
X-CSE-ConnectionGUID: 5n569IG8Q1SB5ViInUjD8A==
X-CSE-MsgGUID: GpMjSfiqTny/GlmUfDe33g==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="75009655"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="75009655"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 01:56:17 -0700
X-CSE-ConnectionGUID: 9/HuI9/gTmmMy5i8otPHmw==
X-CSE-MsgGUID: v+9JezG0QBe1fC45yHF25Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="227598395"
Received: from unknown (HELO [10.239.158.72]) ([10.239.158.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 01:56:12 -0700
Message-ID: <b74acb4b-4658-4113-9fce-9faf972975c4@intel.com>
Date: Thu, 19 Mar 2026 16:56:10 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/virt/tdx: Use PFN directly for unmapping guest
 private memory
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com,
 yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com,
 sagis@google.com, binbin.wu@linux.intel.com, isaku.yamahata@intel.com
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
 <20260319005808.9013-1-yan.y.zhao@intel.com>
 <623ac08e-07a7-4823-bd0a-777d8df5c128@intel.com>
 <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <abubmi7BjMwgnrvC@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/2026 2:45 PM, Yan Zhao wrote:
> On Thu, Mar 19, 2026 at 11:20:48AM +0800, Xiaoyao Li wrote:
>> On 3/19/2026 8:58 AM, Yan Zhao wrote:
>>> From: Sean Christopherson <seanjc@google.com>
[...]
>>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>>> index a9dd75190c67..2f9d07ad1a9a 100644
>>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>>> @@ -730,9 +730,9 @@ static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
>>>    	mb();
>>>    }
>>> -void tdx_quirk_reset_page(struct page *page)
>>> +void tdx_quirk_reset_page(kvm_pfn_t pfn)
>>
>> So why keep the function tdx_quirk_reset_page() but expect passing in the
>> kvm_pfn_t? It looks werid that the name indicates to reset a page but what
>> gets passed in is a pfn.
> I thought about introducing tdx_quirk_reset_pfn(). But considering
> tdx_quirk_reset_pfn() has to be an exported API, I'm reluctant to do that.
> 
> Given that even with tdx_quirk_reset_pfn(), it still expects TDX convertible
> RAM, I think having tdx_quirk_reset_page() to take pfn is still acceptable.
> 
> We just don't want KVM to do pfn --> struct page --> pfn conversions.

Only tdx_sept_remove_private_spte() is doing such conversions. While 
tdx_reclaim_page() and tdx_reclaim_td_control_pages() already have the 
struct page natively.

So why not considering option 2?

   2. keep tdx_quirk_reset_page() as-is for the cases of
      tdx_reclaim_page() and tdx_reclaim_td_control_pages() that have the
      struct page. But only change tdx_sept_remove_private_spte() to use
      tdx_quirk_reset_paddr() directly.

It will need export tdx_quirk_reset_paddr() for KVM. I think it will be OK?

Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86E28980F
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970188; cv=none; b=pCtMjTtTAZeClZLs/GI9rxw/DIkUkwQVgxyHtzuwOWkLes3W6AybkJ/3kpiMUUEen/KbuNlng8YgjjdIFpCs2X5zPKNRcMGjrQ2z+12LVcWzgfXYFXHu8VXAg8aMpH32XvTWyD75m97PW2eHD9pLj6rg29kU8MNE0MxO6V78saE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970188; c=relaxed/simple;
	bh=qnFjluhbPPO0+WMlQldDrpcpBgOuQUGugXIPgx7I9vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKiOm910GaMpLUw5cTLkdC5Z/jnBnNfr460Nog3XzdmgYACOy+BZk3hfd2rS2NB4m0hzKSyCgE1IIT9xpdttnC9AE0l+GdMRKxZC2XQXkueGu49DIQlqGJ0EWaIGbFuV1I/PdZ6Ymg/m2Z4wBebnfT8o9zJ/V94hm1svqBD7bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYRjwQdy; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYRjwQdy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780970186; x=1812506186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qnFjluhbPPO0+WMlQldDrpcpBgOuQUGugXIPgx7I9vw=;
  b=mYRjwQdyeRe2uPXV0OA4Bi8Xri/B2b2xLdERElMKZt8MZ53hmE0KonKq
   BE+BJmiyptjam7y1m0cxmK84TZ5dI8G149J7SixtBOV2sNoUwoO52jluN
   Oqt7wOfB32tE6M7pq72pu8hMld/b6tpxlkHeSE/SiRspqurvBCCeXVTbc
   EJ4zkT6GszCujscLqVtjIK4x+gdSA8GTPTCgcQR6nMVeTljed7T+2UcMG
   1lREWA6hcehZKNFCD7kT5GPmVojnKRTvLBg4LfanMqUEt1FCx2MiJtglN
   pt3ykb+YntUfY5nXWUtu19A4p0sCpY4YWkgPey0nfzc5KDADVX0J552bZ
   w==;
X-CSE-ConnectionGUID: n7chIO/tR36r+yvYwqbn0w==
X-CSE-MsgGUID: KLtI4g9NSASzSoxxG/ESyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93108214"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93108214"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:56:25 -0700
X-CSE-ConnectionGUID: ckZeUZ2IQBu8fVUcs6srvw==
X-CSE-MsgGUID: WQ4CmCQXRkuT0cv+/Squ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="241543069"
Received: from unknown (HELO [10.238.2.24]) ([10.238.2.24])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 18:56:24 -0700
Message-ID: <cb8d64e6-dfc6-4984-a46a-157e57e55aaf@linux.intel.com>
Date: Tue, 9 Jun 2026 09:56:21 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/27] KVM: x86: Fix emulated CPUID features being
 applied to wrong sub-leaf
To: Sean Christopherson <seanjc@google.com>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, kai.huang@intel.com
References: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
 <20260417073610.3246316-2-binbin.wu@linux.intel.com>
 <4e5b6b9c-4f7d-4d62-874a-4bcb745e9a47@linux.intel.com>
 <aibPZMfxabh6meOk@google.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <aibPZMfxabh6meOk@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/8/2026 10:19 PM, Sean Christopherson wrote:
> On Mon, Jun 08, 2026, Binbin Wu wrote:
>>
>>
>> On 4/17/2026 3:35 PM, Binbin Wu wrote:
>>> Guard the use of cpuid_func_emulated() with a check that the CPUID
>>> sub-leaf index is 0, as cpuid_func_emulated() unconditionally returns
>>> emulated features for index 0 and does not account for indexed leaves.
>>>
>>> Without the guard, when iterating over reverse_cpuid[] entries that
>>> share the same CPUID function but have a non-zero index, e.g.
>>> CPUID_7_1_ECX (function=7, index=1), the emulated features for index 0
>>> are incorrectly OR'd into the wrong capability word.  For example,
>>> RDPID (CPUID.7.0:ECX[22]) gets erroneously applied to CPUID_7_1_ECX,
>>> which would allow userspace to set bit 22 of CPUID.7.1:ECX in the vCPU's
>>> capabilities.
>>>
>>> This is currently benign as the affected bits in the non-zero index
>>> words happen to not correspond to meaningful features, but it could
>>> cause problems as new features are defined in those positions.
>>>
>>
>> Hi Sean/Paolo,
>>
>> While the bug is currently benign, I still think it's worth fixing.
>>
>> There could be two options:
>> - Considering cpuid_func_emulated() probably would not be extended
>>   in the future, still keep this simple implementation, but add some
>>   comments to cpuid_func_emulated() to call out only subleaf 0 is emulated
>>   as suggested by Xiaoyao.
>>   https://lore.kernel.org/kvm/fa47d520-1de9-4ddc-94ca-6bb53ac30f10@intel.com/
>> - Add the index input parameter to cpuid_func_emulated().
> 
> Definitely handle this in cpuid_func_emulated().

Thanks, the diff looks good to me.
I will send a separate patch for this.

BTW, do you want to provide your SOB?

> 
> diff --git arch/x86/kvm/cpuid.c arch/x86/kvm/cpuid.c
> index db8be9173bd0..737ca3e7bda2 100644
> --- arch/x86/kvm/cpuid.c
> +++ arch/x86/kvm/cpuid.c
> @@ -400,7 +400,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
>                 if (!entry)
>                         continue;
>  
> -               cpuid_func_emulated(&emulated, cpuid.function, true);
> +               cpuid_func_emulated(&emulated, cpuid.function, cpuid.index, true);
>  
>                 /*
>                  * A vCPU has a feature if it's supported by KVM and is enabled
> @@ -1369,11 +1369,15 @@ static struct kvm_cpuid_entry2 *do_host_cpuid(struct kvm_cpuid_array *array,
>         return entry;
>  }
>  
> -static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func,
> +static int cpuid_func_emulated(struct kvm_cpuid_entry2 *entry, u32 func, u32 index,
>                                bool include_partially_emulated)
>  {
>         memset(entry, 0, sizeof(*entry));
>  
> +       /* KVM doesn't currently emulate any non-zero indices. */
> +       if (cpuid_function_is_indexed(func) && index)
> +               return 0;
> +
>         entry->function = func;
>         entry->index = 0;
>         entry->flags = 0;
> @@ -1411,7 +1415,7 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>         if (array->nent >= array->maxnent)
>                 return -E2BIG;
>  
> -       array->nent += cpuid_func_emulated(&array->entries[array->nent], func, false);
> +       array->nent += cpuid_func_emulated(&array->entries[array->nent], func, 0, false);
>         return 0;
>  }
>  
> 
> 


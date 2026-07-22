Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA13AA195;
	Wed, 22 Jul 2026 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784690748; cv=none; b=TpfUzcMkyAMc2M7g+Po6As2IhnsviFpXJZWD8j7o6SaKqsaiOR27GxeXRQgOsw1oHikad9FFOpK9CewdbcAFCItPrGItr5SpMpEo0OIlVkmGoIwexAX4QFs43RKm/RZBqihTQVn765MNAiyrztmz+h28G0nhcJwB3YxvW7S2JcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784690748; c=relaxed/simple;
	bh=dJyAFKV9avURsNJuR/lmbe6+nXdy+oFMTwmVRY+xG7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7YhvPUOXgTcsO4/kw0Hi/ivh0KJF8femyJQSjyq1Dzwm4GAkF4kG8MYvPE6Auqm0ZSEXsCNJl80GKrq+y1Yz14zSV755hCcqUrEk31ru6NehP02xESntn9vqkXWqPUF3zOjPuCQfcQnGiXsoAe31E/UNiAAXhQ0NCfqwDUqgB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqEeQg70; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqEeQg70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784690742; x=1816226742;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dJyAFKV9avURsNJuR/lmbe6+nXdy+oFMTwmVRY+xG7o=;
  b=IqEeQg70LUBaFYIDuSOcNcEinE7QkTs7iZx7s7d4cwm3Pc5mr4Ajoz/y
   3C3v1Ouqzno2ydC4toPYzXFBl81tys1ffpuztRg1FiHi/J9Osx7u7Bvn9
   XvlU+txUJJ765Kt30klm3zKisDhwRTQmjLxbo+Vpl5fnfnmrPBYQnEqDk
   KRRSniPyKLNRfh8BRE06gRJGrEI7zgZlHUSx4hWJCfcHkFWOCk4FKKhA3
   Meh6zXZbzdDqYITL4yJyUrvrXSeRRcfNXKmnWiC+SS92DfIO/eATadSNF
   JknmqkjDYhnH7CqFxLewADqbd4wBlcPQTa/SSdkxWZrGYwFECfhaBr4vf
   w==;
X-CSE-ConnectionGUID: sRJjGE3bR/qGbKLYZQaTPA==
X-CSE-MsgGUID: bod9zatkTSaYHUQ2h5DpZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="72853603"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="72853603"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 20:25:38 -0700
X-CSE-ConnectionGUID: LSrGoOtXQ0+b6Crh6A1lUg==
X-CSE-MsgGUID: Lh0hOU4vTvG34w8BZf4T7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="251637460"
Received: from unknown (HELO [10.238.208.132]) ([10.238.208.132])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 20:25:37 -0700
Message-ID: <6c560199-1461-443a-b68e-e0297398c731@intel.com>
Date: Wed, 22 Jul 2026 11:25:34 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
To: Sean Christopherson <seanjc@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-8-seanjc@google.com>
 <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com>
 <CAEvNRgGz_Qm1z+e-7Rh2OZ1bfjVBMEB91-Ki+3Vi3mBf5uMdiQ@mail.gmail.com>
 <36036850-2d73-4c0f-84bc-64ba542ba425@intel.com>
 <al-dQ1EBD272HY4a@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <al-dQ1EBD272HY4a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/2026 12:24 AM, Sean Christopherson wrote:
> On Fri, Jul 17, 2026, Xiaoyao Li wrote:
>> On 7/17/2026 5:42 AM, Ackerley Tng wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>> @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
>>> kvm_memory_slot *slot,
>>>    		folio_mark_uptodate(folio);
>>>    	}
>>>
>>> -	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
>>> +	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>>
>>>    	folio_unlock(folio);
>>>
>>> I'll move just this renaming to [1] like you suggested.
>>>
>>> I think it's okay to continue to always call prepare_folio(), and within
>>> the prepare_folio() function, only do conversion when the CONVERT CONFIG
>>> is defined.
>>
>> I don't think so.
>>
>> This patch not only renames kvm_arch_gmem_prepare() to
>> kvm_arch_gmem_convert(), but also adds one more parameter
>>
>>    'bool to_private'
>>
>> and hardcodes the new parameter to true. This mean the arch callback will
>> convert the folio to private unconditionally in kvm_prepare_folio() when
>> CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT is enabled.
>>
>> Note the CONFIG is not a per-VM thing but a build time thing. The
>> unconditionally-converting-to-private semantic can also be applied to
>> gmem-only memslot for non-Coco VMs whenever the HAVE_KVM_ARCH_GMEM_CONVERT
>> is enabled when building the kernel.
>>
>> Though the code won't do anything for gmem-only memslot for non-Coco VMs,
>> the literal semantic of the function and parameter is wrong.
> 
> Agreed.  How about I add a patch to guard the call with:
> 
> 	if (kvm_arch_has_private_mem(kvm) &&
> 	    !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
> 		r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> 
> which is semantically correct pre-in-place conversion.  And then when in-place
> conversion comes along, that will get switched to:
> 
> 	if (kvm_gmem_is_private_mem(inode, index))
> 		r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> 
> Which IMO yields a very clean and intuitive diff.
> 
> Actually, even better would be to insert a patch to provide kvm_gmem_is_private_mem()
> and kvm_gmem_is_shared_mem() as part of this prep, and pull in "KVM: guest_memfd:
> Only prepare folios for private pages" with a massaged shortlog+changelog.

yeah. This looks good!

> I.e. have this at the end of this prep work:
> 
> static bool kvm_gmem_is_private_mem(struct inode *inode, pgoff_t index)
> {
> 	return kvm_arch_has_private_mem(kvm) &&
> 	       !(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED);
> }

I'm wondering if we really need to check kvm_arch_has_private_mem() 
here. It looks checking GUEST_MEMFD_FLAG_INIT_SHARED is sufficient.

> static bool kvm_gmem_is_shared_mem(struct inode *inode, pgoff_t index)
> {
> 	return !kvm_gmem_is_private_mem(inode, index);
> }
> 
> 	if (!kvm_gmem_is_shared_mem(inode, vmf->pgoff))
> 		return VM_FAULT_SIGBUS;
> 
> 	if (kvm_gmem_is_private_mem(inode, index))
> 		r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> 
> 	
> And then "KVM: guest_memfd: Introduce per-gmem attributes, use to guard user mappings"
> isn't changing the semantics of the callers, it's only changing the internal
> plumbing for PRIVATE vs. SHARED.


Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BD31D381;
	Fri, 17 Jul 2026 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784260616; cv=none; b=QqjGzxfxuVYbpp5/km0QX5yqqFZpO/hsVGNvXP4H48w92ZkkGydSFq4CX1AlxQflOUfKJZDc9YoBa2AS+DihlV7Jojo+bXzjtuYoNKEI2gxE/HVexBLK5/URguBRkUYx229zmzf/KSiUW1OoMhPgAGhZKJRpfomqWKLoQhtYpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784260616; c=relaxed/simple;
	bh=Cy7bUY8SN4eLrlWnDo2VbhzBy39q70bUvf6w9wB363c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rnm2bRb6ZzpMyOhPaH2nLPSGvtCNu92FCvqSf5MrogwXGm+pIC54xbJ22PVTssIm/yac8oTytGu3gi7G3LzUvbx69S+VEAXajH2+hXSIkh5qNDA+TKQj3GG4e6mkiIJ78e+CseLRMZac4gwEl+RlhkheYkyLBOMQ9KCHENGnLng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UL4Rl4M5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UL4Rl4M5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784260614; x=1815796614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cy7bUY8SN4eLrlWnDo2VbhzBy39q70bUvf6w9wB363c=;
  b=UL4Rl4M5kWFhB3nrf4fW97we1K1N+9W7XTwhUmHkBQ41HgltTxcpQ8KH
   KQxE6DWSxMbpYwuNtGxzMYHTjpsFj5hwVCyWeMzw3yf9DR22xFu3nNZ64
   tscaCiuMz1fmwEjuvsnY+QTtrvZLC314ZA7Pg9ltb5B+P3Lt/1hRVHkDk
   0EFpnWCrMFFuY5H0dnviFsvKG4p7a9LiCrPu7SXYfXccXOQ7APZ//PI6p
   tk96YRIn6k2UI4KXkHObI7u/PC7KoU36ZbX3AREM+txhyYWLhfRtlmLXM
   jetsr7G0rzh//fQW7HjVBE8zcuCYMmwixzqrANhOTu9eqbngrvWnkoiST
   Q==;
X-CSE-ConnectionGUID: aZ441L9kRKmjYr3MkpHm4Q==
X-CSE-MsgGUID: EoJ7kiVvR4WBFkRC5Fg0dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84052132"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84052132"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:56:53 -0700
X-CSE-ConnectionGUID: C4H0DGINSgmAJ6x1J00lsQ==
X-CSE-MsgGUID: A7AI4Q4VRPqcsFtxxJVL8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="258676828"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 20:56:51 -0700
Message-ID: <36036850-2d73-4c0f-84bc-64ba542ba425@intel.com>
Date: Fri, 17 Jul 2026 11:56:48 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
To: Ackerley Tng <ackerleytng@google.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-8-seanjc@google.com>
 <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com>
 <CAEvNRgGz_Qm1z+e-7Rh2OZ1bfjVBMEB91-Ki+3Vi3mBf5uMdiQ@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgGz_Qm1z+e-7Rh2OZ1bfjVBMEB91-Ki+3Vi3mBf5uMdiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/2026 5:42 AM, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 7/15/2026 7:10 AM, Sean Christopherson wrote:
>>> Rework guest_memfd's "prepare" hook into a more generic "convert" flow in
>>> anticipation of supporting in-place conversion, at which point KVM will use
>>> the hook for both to-private and to-shared conversions, not just to
>>> "prepare" PRIVATE memory.
>>>
>>> Opportunistically rename kvm_gmem_prepare_folio() to kvm_gmem_make_private()
>>> to better reflect its role.
>>>
>>
>> [...]
>>
>>> @@ -90,8 +90,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>>>    	gfn = ALIGN_DOWN(gfn, nr_pages);
>>>    	index = kvm_gmem_get_index(slot, gfn);
>>>
>>> -	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
>>> -				     nr_pages, folio_order(folio));
>>> +	return kvm_arch_gmem_convert(kvm, gfn, folio_file_pfn(folio, index),
>>> +				     nr_pages, folio_order(folio), true);
>>>    #else
>>>    	return 0;
>>>    #endif
>>> @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>>    		folio_mark_uptodate(folio);
>>>    	}
>>>
>>> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>> +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
>>
>> I think this and above renaming don't make sense, because
>> kvm_gmem_get_pfn() can be invoked for shared memory for non-Coco VMs
>> when KVM_MEMSLOT_GMEM_ONLY is set.
>>
> 
> Makes sense.
> 
>> Maybe this patch can be moved to gmem in-place series and after [1]?
>>
>> [1]
>> https://lore.kernel.org/all/3b64e897-93a8-4f9c-88a9-f416ff44b09d@intel.com/
>>
> 
> How about doing everything else in this patch in this patch, other than
> this:
> 
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 173a7ed008d17..9df6927dd8f55 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -66,8 +66,8 @@ static pgoff_t kvm_gmem_get_index(struct
> kvm_memory_slot *slot, gfn_t gfn)
>    * On successful return the guest sees a zero page so as to avoid
>    * leaking host data and the up-to-date flag is set.
>    */
> -static int kvm_gmem_make_private(struct kvm *kvm, struct kvm_memory_slot *slot,
> -				 gfn_t gfn, struct folio *folio)
> +static int kvm_gmem_prepare_folio(struct kvm *kvm, struct
> kvm_memory_slot *slot,
> +				  gfn_t gfn, struct folio *folio)
>   {
>   #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>   	unsigned long nr_pages = folio_nr_pages(folio);
> @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct
> kvm_memory_slot *slot,
>   		folio_mark_uptodate(folio);
>   	}
> 
> -	r = kvm_gmem_make_private(kvm, slot, gfn, folio);
> +	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> 
>   	folio_unlock(folio);
> 
> I'll move just this renaming to [1] like you suggested.
> 
> I think it's okay to continue to always call prepare_folio(), and within
> the prepare_folio() function, only do conversion when the CONVERT CONFIG
> is defined.

I don't think so.

This patch not only renames kvm_arch_gmem_prepare() to 
kvm_arch_gmem_convert(), but also adds one more parameter

   'bool to_private'

and hardcodes the new parameter to true. This mean the arch callback 
will convert the folio to private unconditionally in kvm_prepare_folio() 
when CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT is enabled.

Note the CONFIG is not a per-VM thing but a build time thing. The 
unconditionally-converting-to-private semantic can also be applied to 
gmem-only memslot for non-Coco VMs whenever the 
HAVE_KVM_ARCH_GMEM_CONVERT is enabled when building the kernel.

Though the code won't do anything for gmem-only memslot for non-Coco 
VMs, the literal semantic of the function and parameter is wrong.


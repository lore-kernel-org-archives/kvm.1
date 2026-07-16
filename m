Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC03392C39;
	Thu, 16 Jul 2026 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194552; cv=none; b=HhREVg65X8XNKK7m5Mh0iM3WRo0eqxP0PWNMFobJTfh+hAB7uUKkqC145I4lmJrM76bbuynu9OJnZ0nzOUaiH9MC5dRJK8bBFF88uDGCBLVM+WJnExrSmiusnvYDGL/C8+/NmwLrZ0A83mQ/u0LdLe9EK1VgchtfBHeaZqdSxFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194552; c=relaxed/simple;
	bh=2+AMEW9SPSQU8ccJ972l9x31vWWmoF7Ev0sJLhkkzHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMC26wydOGl4S0mCIB5g6p/K/qKo5SFMfnAS7Qk8TFTDdEJ5jOmERHzdvJfbZrWqY8AvUHiZv0OItrJGZLdcvmUOS+/eqImMoIQU3j6RrCM3xvdHy7hl4dQLAzJS4v5n7wEEzeudv32+FJ30R4XqI2HymXwQMJyPNWOQtectKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPFEIpk6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPFEIpk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784194551; x=1815730551;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2+AMEW9SPSQU8ccJ972l9x31vWWmoF7Ev0sJLhkkzHM=;
  b=MPFEIpk6cMRJ2Ota9KGjWnMnCq+59l2a9YWnuWTBn6tk2DXtLBiEk5Ar
   5UNMHolh9iT1S0P3bWbNoe4pnjipcH+yDNUTa0YdN1BGgq28jtSy9KqwV
   xIPxzpwok8CC2eoMZu+b9rPhSvJuXIHqvA/dLuDO7twsV93lkmuiNOqA1
   qY0G3Ave+Yy95zs7K6NbgVIUwGlNbgwS543gJUqtuDTsGMF8lq5BJITQB
   bAVFvQGHNvGeOacAOnR0+wuOg2KDiepL1yEGp/Km+Dnao1r9D6W5zNqff
   3dviaC28P7v6jw6oGnEB4Mv3Wyr9ENNc80dcx/SczcNbAwXi5a3dXQG1f
   w==;
X-CSE-ConnectionGUID: z4//dONpRCuVTO4Wmh+7QA==
X-CSE-MsgGUID: SMJKiMq1R0GsA635YeAeDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84703005"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84703005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:35:51 -0700
X-CSE-ConnectionGUID: i7uAN0hxT5WIenfpg+qrRQ==
X-CSE-MsgGUID: VyO9hWHRRBGFT7p01sIgLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="255310699"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.232]) ([10.124.240.232])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 02:35:49 -0700
Message-ID: <a236d1ba-8d13-4151-a7df-a8c390b33a24@intel.com>
Date: Thu, 16 Jul 2026 17:35:40 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] KVM: guest_memfd: Rework PREPARE config and hook
 into a more generic CONVERT
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, Ackerley Tng <ackerleytng@google.com>
References: <20260714231015.3337831-1-seanjc@google.com>
 <20260714231015.3337831-8-seanjc@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260714231015.3337831-8-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/2026 7:10 AM, Sean Christopherson wrote:
> Rework guest_memfd's "prepare" hook into a more generic "convert" flow in
> anticipation of supporting in-place conversion, at which point KVM will use
> the hook for both to-private and to-shared conversions, not just to
> "prepare" PRIVATE memory.
> 
> Opportunistically rename kvm_gmem_prepare_folio() to kvm_gmem_make_private()
> to better reflect its role.
> 

[...]

> @@ -90,8 +90,8 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
>   	gfn = ALIGN_DOWN(gfn, nr_pages);
>   	index = kvm_gmem_get_index(slot, gfn);
>   
> -	return kvm_arch_gmem_prepare(kvm, gfn, folio_file_pfn(folio, index),
> -				     nr_pages, folio_order(folio));
> +	return kvm_arch_gmem_convert(kvm, gfn, folio_file_pfn(folio, index),
> +				     nr_pages, folio_order(folio), true);
>   #else
>   	return 0;
>   #endif
> @@ -798,7 +798,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>   		folio_mark_uptodate(folio);
>   	}
>   
> -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
> +	r = kvm_gmem_make_private(kvm, slot, gfn, folio);

I think this and above renaming don't make sense, because 
kvm_gmem_get_pfn() can be invoked for shared memory for non-Coco VMs 
when KVM_MEMSLOT_GMEM_ONLY is set.

Maybe this patch can be moved to gmem in-place series and after [1]?

[1] 
https://lore.kernel.org/all/3b64e897-93a8-4f9c-88a9-f416ff44b09d@intel.com/

>   	folio_unlock(folio);
>   


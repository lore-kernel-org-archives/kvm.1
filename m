Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7832C8B;
	Tue,  1 Sep 2026 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245452; cv=none; b=T7sLmlVzuuHbnFWazt/njlXVOpnHLzPqMNmAm/0XdN1RCWWMMhdB//0NtpyDjGPWe3DolilM1OA85h6wQJIcYBZTmo2fFbVTSUYyoaSUEX6mZFYyp9WrkPrk0z1Y6/qEOB5ISlM/BoDm3qoLopRO3Xp9Bspk0PUS9JlNXMqA8FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245452; c=relaxed/simple;
	bh=ukUEdUIq4V8E0DB6478BariAz5ATTjKx90QmyLRXQuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGuJ4qqTE0u6EfkCRUpdADJ6lTd7b49NHNLED3IfFSiodFMZQeac1fr1m20vGpLSwT2wau2l9GzfcSOvTL4mQtfJ09ADaxpnZ3Rj4vsO3OgVC+cYXWjy2YzmD4rJX9cWzsrKmPQa9Knf3IXiTKEB5t+rKaqmIbjM81Elo/sYkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9sr1jyU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9sr1jyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245450; x=1819781450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ukUEdUIq4V8E0DB6478BariAz5ATTjKx90QmyLRXQuU=;
  b=I9sr1jyUlv+oZdaXe0N0EecG0tSHHv3rY8uYieZPObmuSMycZrbNOEHR
   /wbqh4VAT5YaCi/QC2HsKTRwQKhhC1yRS6SycxmlgWbPhd1GWcKrzHv7i
   LrSmx3UoxNjjgrjmLDITEkxTdjWgqDjMba3W8E7gfTSWwVpqR2+o00fAu
   2YGXxmQRH8XgpzGkFu3w2i5qA7U/S4p7QGDAUQJcrd2uQzR7aHYa4hw8e
   0FNm7kcuzc7KYDCtKsCCe0sMu3Ugz6o0pbpTCqO9BhS4bhxSW5qEQK6xt
   lyhfIcRRaibqgAy16S1t4LhgyWNfjlfMBCck2A+iL9W9szufvHCHi7uHm
   Q==;
X-CSE-ConnectionGUID: d+fp5a7rSWmBs7Rw1HF0Uw==
X-CSE-MsgGUID: 7hsV1SPsRe2OBRYVbQtnHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="92477791"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="92477791"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:50:50 -0700
X-CSE-ConnectionGUID: cPyQcD3JTqGacMsvgea5MA==
X-CSE-MsgGUID: en4BSrYlTDarE/rzCT6hwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272794691"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:50:47 -0700
Message-ID: <3242caef-0693-4fba-98c6-f0b6ca9b80ed@linux.intel.com>
Date: Tue, 1 Sep 2026 14:50:44 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] KVM: x86/pmu: Populate CPUID.0AH:ECX
 fixed-counter bitmap
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-13-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-13-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 8/28/2026 6:37 AM, Zide Chen wrote:
> PerfMon v5 adds a fixed-counter support bitmap in CPUID.0AH:ECX.
> This is the superset of EDX[4:0] which indicates the contiguous
> counters starting from 0. For backward compatibility, it's recommended
> to use the following to determine if a fixed counter is supported:
>
> FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i);
>
> Originally-by: Yang Weijiang <weijiang.yang@intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/cpuid.c         | 5 ++++-
>  arch/x86/kvm/vmx/pmu_intel.c | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 106e719e7aee..63201d4ea4a1 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1547,7 +1547,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  		entry->eax = eax.full;
>  		entry->ebx = kvm_pmu_cap.events_mask;
> -		entry->ecx = 0;
> +		if (kvm_pmu_cap.version >= 5)
> +			entry->ecx &= (u32)kvm_pmu_cap.fixed_cntr_mask64;
> +		else
> +			entry->ecx = 0;
>  		entry->edx = edx.full;
>  		break;
>  	}
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index a6d2ebff7cc9..1ce69e764ae1 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -585,7 +585,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  				      kvm_pmu_cap.events_mask_len);
>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>  
> +	/* FxCtr[i]_is_supported := ECX[i] || (EDX[4:0] > i) */
>  	fixed_cntr_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
> +	if (pmu->version >= 5)
> +		fixed_cntr_mask |= entry->ecx;
>  	fixed_cntr_mask &= kvm_pmu_cap.fixed_cntr_mask64;
>  
>  	/*

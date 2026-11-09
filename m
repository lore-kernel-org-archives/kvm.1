Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264452;
	b=QKLl+F40bv4zb2IQSNFddciiM5sFXoge4BoFMmH6D5mFHJCLTo6R4FWAcO5DuFJca7zD
	 9vMDVJOrMzxJ4Elo6rVOKRHjilmlQALPYB/ugaFoxMp3pUe/jp4GcJJM4RWtxd3g3o1CP
	 eNDj57HGgGXZsNSK5R9FJdrCC6YuXse3Ps6Ow+grKYIhn/FZC+EyikH0sKI0b6Neh8cIc
	 vF7+16dnlI0TKOTwIZTGDpq2IM8tnB0DVyIhg1SKJm6tHuQrPInTL213kG4vQ9ELD1ao/
	 Jab8Y1yUXFzUe1Cf+ChsEwfYR+KacL2z8Slh+V4xd4fZzNDlF2VMy1CDuLa6MgQebaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264452;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Jlzmar/euHNEUvWRPT6BsGs349OMLa8umjKQvQHst0k=;
	b=XuuwIW75qofZJwSb3Jxh1L//n7XBiNLylHihUekz90eEzxtjKDafMpJPlZiIyVKVdnzm
	 FHyCujgHr+RufH38CdS99C+qBM5n+JItYwZM8gK6r+5smZLHsjYlM8i5fJDwDfap9WJxm
	 3kIoFJQJ30a/RBBhMY9pcE0DCneMfT1xvelXHP7hfT2YiAQeiJOQBMxHroy2NHfnZwO9X
	 jj4bhxGT2rPlso7mYcLEL/uTcw+u3rizwFoQza5xi1RuiOhVwV47QT8ltrNwI0HhyN9WW
	 6IHykEOcAti2rMigQzoB/v60J5gNnZG77leW4N64LjuU/Ua1Z5cLGKK0v4LOlNwKMbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gFr2fIXW;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B71606A31C;
	Mon,  9 Nov 2026 22:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gFr2fIXW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794264453; x=1825800453;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wN7iqT3Zfyf0BuyClcGwRkrXst99MKqbthjYaR8ZaZw=;
  b=gFr2fIXWVZr1NHhukzjC5SGxpaMB2pl/ElGZ7fGOUClRI/2+mBeJIZiw
   dLL2qb0P8iLaoJqYOcWabFctb9FMg8u8378V2FlnLBMYJXLIT7eDYarbR
   GndJWdyAnIYuuDptLwAy611f/yO2MVrFR0VEpKbEofs01sjWue0lGfh/f
   ZPpR4yQpi9hgqHbbtg7Hqo6lsCI5dNWTQP2BZtbD25fM9wpu1DjeK2Cmd
   nwZntpY00d97ZkF0fy58EzuP4vuuERezT4Wc5HXSwoSVvn+aUtm/zIb+f
   8Q7t0xSI8fRB3X1NGuUHUXst7qBH8O3JAjGzPdb+d16pqMNiYiM6VV9/1
   A==;
X-CSE-ConnectionGUID: WpM1JT/kSru4/DgYVBY5dg==
X-CSE-MsgGUID: tFz/gED5Qf+dfYGRe1RerA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2886753"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2886753"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:47:32 -0800
X-CSE-ConnectionGUID: UOw+7vpkTw6dtzkIQ6EmFQ==
X-CSE-MsgGUID: 3Y0F8D+2QY2zovbEwXxSDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7873124"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:47:30 -0800
Message-ID: <8778ee92-640e-4d20-8929-ae7212888f3e@intel.com>
Date: Mon, 9 Nov 2026 16:47:29 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/18] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-6-zide.chen@intel.com> <au4pSeg5AcHEbfDv@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <au4pSeg5AcHEbfDv@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 1:34 PM, Yosry Ahmed wrote:
>> @@ -979,8 +979,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	kvm_pmu_reset(vcpu);
>>  
>>  	pmu->version = 0;
>> -	pmu->nr_arch_gp_counters = 0;
>> -	pmu->nr_arch_fixed_counters = 0;
>>  	pmu->counter_bitmask[KVM_PMC_GP] = 0;
>>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
>>  	/*
>> @@ -1008,16 +1006,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	 * in the global controls).  Emulate that behavior when refreshing the
>>  	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
>>  	 */
>> -	if (pmu->nr_arch_gp_counters &&
>> +	if (kvm_gp_pmc_mask(pmu) &&
>>  	    (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_pmu(vcpu)))
>> -		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
>> +		pmu->global_ctrl = kvm_gp_pmc_mask(pmu);
>>  
>>  	if (kvm_vcpu_has_mediated_pmu(vcpu))
>>  		kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
>> -
>> -	bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
>> -	bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
>> -		   pmu->nr_arch_fixed_counters);
> 
> I understand the vendor modules are responsible of initializing this
> now, but should we clear it before calling into the vendors like other
> fields above?
> 
>>  }
>>  
>>  void kvm_pmu_init(struct kvm_vcpu *vcpu)
>> @@ -1328,6 +1322,8 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
>>  static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>> +	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
> 
> All these should go away if we pass the pmu into the iterators.

This is great!
>> @@ -117,7 +116,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>  		return pmu->version > 1;
>>  	default:
>>  		if (msr > MSR_F15H_PERF_CTR5 &&
>> -		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
>> +		    msr < MSR_F15H_PERF_CTL0 + 2 * hweight_long(kvm_gp_pmc_mask(pmu)))
> 
> This assumes the MSRs are contiguous, which IIUC is always true, but I
> wonder if it should also be handled since the series claims to also
> prepare for discontiguous GP counters.

As Jim pointed out, this is dead code as KVM_MAX_NR_AMD_GP_COUNTERS is
capped at 6. Yes, I agree it is better not to assume contiguity if this
code is not removed.

> 
>>  			return pmu->version > 1;
>>  		break;
>>  	}
> [..]
>> @@ -107,6 +108,8 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>>  	if (WARN_ON_ONCE(!pmu->version))
>>  		return NULL;
>>  
>> +	idx &= INTEL_RDPMC_INDEX_MASK;
>> +
>>  	/*
>>  	 * General Purpose (GP) PMCs are supported on all PMUs, and fixed PMCs
>>  	 * are supported on all architectural PMUs, i.e. on all virtual PMUs
>> @@ -117,23 +120,25 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
>>  	 */
>>  	switch (type) {
>>  	case INTEL_RDPMC_FIXED:
>> +		if (!kvm_is_fixed_pmc_supported(pmu, idx))
>> +			return NULL;
>> +
>>  		counters = pmu->fixed_counters;
>> -		num_counters = pmu->nr_arch_fixed_counters;
>> +		num_counters = KVM_MAX_NR_INTEL_FIXED_COUNTERS;
>>  		bitmask = pmu->counter_bitmask[KVM_PMC_FIXED];
>>  		break;
>>  	case INTEL_RDPMC_GP:
>> +		if (!kvm_is_gp_pmc_supported(pmu, idx))
>> +			return NULL;
>> +
>>  		counters = pmu->gp_counters;
>> -		num_counters = pmu->nr_arch_gp_counters;
>> +		num_counters = KVM_MAX_NR_INTEL_GP_COUNTERS;
> 
> num_counters is no longer an accurate name, is it? Maybe max_counter
> (and use KVM_MAX_* - 1) or max_nr_counters?

Good point, I can rename it to max_nr_counters. >
>>  		bitmask = pmu->counter_bitmask[KVM_PMC_GP];
>>  		break;
>>  	default:
>>  		return NULL;
>>  	}
>>  
>> -	idx &= INTEL_RDPMC_INDEX_MASK;
>> -	if (idx >= num_counters)
>> -		return NULL;
>> -
>>  	*mask &= bitmask;
>>  	return &counters[array_index_nospec(idx, num_counters)];
>>  }
>> @@ -495,9 +500,10 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>>  
>>  static void intel_pmu_enable_fixed_counter_bits(struct kvm_pmu *pmu, u64 bits)
>>  {
>> +	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
>>  	int i;
>>  
>> -	for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
>> +	kvm_for_each_fixed_counter(i, fixed_mask)
>>  		pmu->fixed_ctr_ctrl_rsvd &= ~intel_fixed_bits_by_idx(i, bits);
>>  }
>>  
>> @@ -509,6 +515,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	union cpuid10_eax eax;
>>  	union cpuid10_edx edx;
>>  	u64 perf_capabilities;
>> +	u64 fixed_mask;
>> +	int nr_gp_counters;
>>  	u64 counter_rsvd;
>>  
>>  	if (!lbr_desc)
>> @@ -535,8 +543,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	if (!pmu->version)
>>  		return;
>>  
>> -	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
>> -					 kvm_pmu_cap.num_counters_gp);
>>  	eax.split.bit_width = min_t(int, eax.split.bit_width,
>>  				    kvm_pmu_cap.bit_width_gp);
>>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
>> @@ -544,6 +550,17 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  				      kvm_pmu_cap.events_mask_len);
>>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>>  
>> +	fixed_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
>> +	fixed_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
> 
> Why not do min() like the old code?
> 
>> +
>> +	/*
>> +	 * The number of counters comes from guest CPUID data. Clamp the value
>> +	 * to avoid a shift-by-64 in BIT_ULL().
>> +	 */
>> +	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
>> +	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
>> +			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
> 
> Why not just do min(eax.split.num_counters, kvm_pmu_cap.num_counters_gp)
> directly like it used to be?

Agreed. I will simplify both to use min_t() directly:

        nr_gp_counters = min_t(int, eax.split.num_counters,
                               kvm_pmu_cap.num_counters_gp);
        pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;

and:

        nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
                                  kvm_pmu_cap.num_counters_fixed);
        fixed_mask = BIT_ULL(nr_fixed_counters) - 1;

Then patch 8 can simply replace kvm_pmu_cap.num_counters_* with
find_first_zero_bit().



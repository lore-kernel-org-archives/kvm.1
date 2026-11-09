Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259346;
	b=quj/kjw+fA3p7hot/5Tk+pAOG6GhD7RpJGNCyRkfC4vykKzxWF+jIcRZ/6urSwiCITej
	 rinbsQXcCuV8srOHehgk4vdk/o2PemYKDlgT43T6ZmNKpHE6TB/jbj2Em15sz+XQMurmP
	 +EJoIGM4sXwPGSY6cyjI8cJsC43zNGdea7AiPEEQ/I+lEUq01DLdy06Nn5f+sHt+L1nNK
	 VMBzw3vLv09GhbC/1twYipkQYb9OwQapXmYdRnydTa44Zq99H2EXco9yDBQ+ZvB1+UEjK
	 Lc1LaP6KKug/FU3lCbko+gnAnYZPREPJ/2Mrdl9RNZySF8OOZH9YE+NJm/7vuOw/xGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FhfVdhojJpMeeNomLecT6c4tFoa3s3kZ5o8eLqboMh4=;
	b=w1TiuWMty+ng2nB+KZxV30UIxkjmFrSKjvsbGsIND2H7sx+hDn+2ZE6Ha0qj9CWXhMN2
	 1y/0D6fMQLwzKip+hsZfQuNxB0JwIE6C2TSsCHJcebgLqeAbZi7AEYQWlPPfwQecB6ebu
	 mvl5TBuSPVDICoIz2MgGAXO2nfWngNa76JjwvccIxP+vliqPG2Lpbr2ssBLhC7I4KxPx7
	 WDNTqZLqsPat/+HPAMRMnLpop2HTbmg6lRte1cnr1syl7Yq80xp/VAEYFBT8Rgd302/qb
	 RnWr1wQYwRw6UBpruORzSgq+P7xTJdaa48GBFXLU1T5OV9NYp/V9OLnAv9qzvdcZq8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V2aJml5O;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AA606A31C;
	Mon,  9 Nov 2026 21:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE7AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V2aJml5O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794259345; x=1825795345;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cVhJd0pnC5OsYFBXA6X2/zqry4ZBdYYkf4sH3rUgLsI=;
  b=V2aJml5Oz0iqt7Y0Hd1i6Dwunk7aVPM10xqssHfaIwXhz2ZtghQKdg3w
   lnDje8GMCTaq3oyojAQ+hLdGszDf47liDu1uEXUjAITDgtsOKOA54hEZM
   bNuuofb/9oJWHLS+ery6cpvYO3vwKjoGrwjyKN3gezDjuP+CnSO21xSIl
   FItohQ7fUWOjcQbK//ZO6SVUiD7AcNhkuA96+/Z9Md7iSxjAPCJO3U/l3
   r8W+2Mx3dkymo2C+G6YcTlrrjZhbiQN48sqjXipSvS0BsXRBOuwSkt3RZ
   MoRZ0T/ccAg0lg+2NbzchdiPOS+nC/jenOoQfYeEAO5eP1OmhvDZIIiuo
   g==;
X-CSE-ConnectionGUID: Fit7LQpvSk+qPDhY5MF6Lw==
X-CSE-MsgGUID: FquwKd3QSa6BGKthl4evYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2875508"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2875508"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:22:24 -0800
X-CSE-ConnectionGUID: Lf1k0+cqSamDuc/khpQMPQ==
X-CSE-MsgGUID: Un76Rh90R+CsQUWfZsvr5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7985513"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:22:23 -0800
Message-ID: <a403740c-e4dd-4180-a19e-ac3e504b4828@intel.com>
Date: Mon, 9 Nov 2026 15:22:22 -0600
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
Subject: Re: [PATCH v3 08/18] KVM: x86/pmu: Switch to bitmask-based KVM PMU
 capabilities
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-9-zide.chen@intel.com> <au4wUM4fwB47Yss9@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <au4wUM4fwB47Yss9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 2:05 PM, Yosry Ahmed wrote:

>> @@ -1903,7 +1911,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  
>>  		cpuid_entry_override(entry, CPUID_8000_0022_EAX);
>>  
>> -		ebx.split.num_core_pmc = kvm_pmu_cap.num_counters_gp;
>> +		ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);
> 
> Should this be the number of contiguous counters?

Yes, to match the Intel code, and to be defensive, I may update it to this:

--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1903,7 +1911,10 @@ static inline int __do_cpuid_func(struct
kvm_cpuid_array *array, u32 function)

                cpuid_entry_override(entry, CPUID_8000_0022_EAX);

-               ebx.split.num_core_pmc = hweight64(kvm_pmu_cap.cntr_mask64);
+               /* Contiguous GP counters only. */
+               ebx.split.num_core_pmc =
+                       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
+                                           KVM_MAX_NR_GP_COUNTERS);

And replace other places of hweight64(kvm_pmu_cap.cntr_mask64) to
find_first_zero_bit() in AMD code.

> 
>>  		entry->ebx = ebx.full;
>>  		break;
>>  	}
> [..]  
>> @@ -516,7 +517,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  	union cpuid10_edx edx;
>>  	u64 perf_capabilities;
>>  	u64 fixed_mask;
>> -	int nr_gp_counters;
>> +	int nr_gp_counters, nr_fixed_counters;
>>  	u64 counter_rsvd;
>>  
>>  	if (!lbr_desc)
>> @@ -550,16 +551,25 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>>  				      kvm_pmu_cap.events_mask_len);
>>  	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
>>  
>> -	fixed_mask = BIT_ULL(edx.split.num_counters_fixed) - 1;
>> -	fixed_mask &= BIT_ULL(kvm_pmu_cap.num_counters_fixed) - 1;
>> +	/*
>> +	 * CPUID.0AH:EDX[4:0] can only enumerate contiguous counters. Clamp the
>> +	 * value to the number of contiguous fixed counters supported by KVM.
>> +	 */
>> +	nr_fixed_counters = min_t(int, edx.split.num_counters_fixed,
>> +				  find_first_zero_bit(kvm_pmu_cap.fixed_cntr_mask,
>> +						      KVM_MAX_NR_FIXED_COUNTERS));
>> +
>> +	fixed_mask = BIT_ULL(nr_fixed_counters) - 1;
>> +	fixed_mask &= kvm_pmu_cap.fixed_cntr_mask64;
> 
> Isn't nr_fixed_counters already clamped to the number of contiguous bits
> in fixed_cntr_mask?

Yes, you are right.
I will drop this redundant '&=' statement from this patch:

> 
>>  
>>  	/*
>> -	 * The number of counters comes from guest CPUID data. Clamp the value
>> -	 * to avoid a shift-by-64 in BIT_ULL().
>> +	 * CPUID.0AH:EAX[15:8] can only enumerate contiguous counters. Clamp the
>> +	 * value to the number of contiguous GP counters supported by KVM.
>>  	 */
>> -	nr_gp_counters = min_t(int, eax.split.num_counters, X86_PMC_IDX_MAX - 1);
>> -	pmu->pmc_exists64 = (BIT_ULL(nr_gp_counters) - 1) &
>> -			    (BIT_ULL(kvm_pmu_cap.num_counters_gp) - 1);
>> +	nr_gp_counters = min_t(int, eax.split.num_counters,
>> +			       find_first_zero_bit(kvm_pmu_cap.cntr_mask,
>> +						   KVM_MAX_NR_GP_COUNTERS));
>> +	pmu->pmc_exists64 = BIT_ULL(nr_gp_counters) - 1;
>>  
>>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003574;
	b=aj8AG4MRViQYAFF22gT38EyePbNw80mtZbJkkFbsvabEzBZZ8XeWiEhuCp/82wVU+6vO
	 OmU47tSfN8kPf83oY9U68nUgYmOYYsqsU+AtYkkp2Zo4uqLm+a3wU27SmXC8+NZRLRzf8
	 8X7I75Nw2AQiK8SpK8Oo0CT+AxbhlmkAtRgSv3hEBH3IT3hFx6105tLO10X0lB2n2IexU
	 ZIJBRbUprwy3FfpoMonUw5rVLNHuPfaXwnhtZD66oSBr8S1/bYMit6PIzGa601QxIJ5F0
	 UpOv8gY4CnhE2vZ6OIwdJS8zaep8KQ3OBCteJbwep628TFhlzDZsF+Ibix4Nhbo6Hjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003574;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1zCuzHohC5b/CUEfdv5fZDG/hMbseqishkj29tGgCF8=;
	b=cDgQKNn9XPic/y64BYos227KGIS44xhZig4nD7ojyLmCgTbYl6ZRyytGksyK5/EhK2SO
	 nbAyCLRoLo2PoBowV7ABVJQ/D6YFhE60VQx6G0/3MluiDj31EdB71UP7/ovIv8wGyGCKE
	 3iGkXcMSNNmD/5PrhwehdseP21J6M6DF19RLH3HBV/S2tu/1q/PUMaiAEazX/jzOsRulO
	 FtFxvX7bqhh6odh5HVfKpGqoJDybLhYQ5dXwodBnXYnF15513Xz3anJjngr2K+KaQq9+E
	 Wc2VUXGlFjrRKtHKEl164UeLsbxw6e8rTzenghkH8B4ehJFxJ2biFB8br0dKRwpFZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZN0NZ9q+;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F0606A32C;
	Fri,  6 Nov 2026 22:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 476F0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZN0NZ9q+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794003572; x=1825539572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4VneRkBa1l3Igkh7ktlEK8Q22+2qdQIcynnaqMYNisM=;
  b=ZN0NZ9q+br0Z4IhZI1F94knI2TdnsdK5vh04eoTn13ipKaQFjYo4ovHG
   jg9l2Jzpp+CJp6Nl5h4qNJItbS9qkbeDtgEZCpUyZkwEObMlSgsVeMJuF
   dgCYjwOW0UK/aAL/2fCojg2/WjNiop5jNmHVDBedIs/Odhg55txA7leCZ
   qbCrnX0QkiSuq4NoEb7Y2ckIvW96xH1zwoHlK9RubwvfL6C7oUpv1Lf5i
   u9o+S+wiJrnlNoI7LRoN5HZUn4wJV5USYVliCa/YJ9HSsNOq0TZyQUezP
   NST0oGcVsHO2mvo79wrS+wo+hzDLOwtF6N50+bFYxVcqfw1zbB5aq61d4
   A==;
X-CSE-ConnectionGUID: lwsfTVMqSC6mK6N9T98FYw==
X-CSE-MsgGUID: FeOV+6NxQg+kQcYId2P/bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2710587"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2710587"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 14:19:32 -0800
X-CSE-ConnectionGUID: mT3fDVW1Tj6CLhAFsJSIlw==
X-CSE-MsgGUID: 15WtYQyzTEOPOgIp2m2xKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7820706"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 14:19:31 -0800
Message-ID: <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
Date: Fri, 6 Nov 2026 16:19:30 -0600
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
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com> <au4kyULjUYdqbfIq@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <au4kyULjUYdqbfIq@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/2026 1:09 PM, Yosry Ahmed wrote:
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index b8875ed5502c..4f192429ed93 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -595,7 +595,10 @@ struct kvm_pmu {
>>  		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>>  		atomic64_t __reprogram_pmi;
>>  	};
>> -	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>> +	union {
>> +		DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>> +		u64 pmc_exists64;
> 
> __pmc_exists would be more consistent with __reprogam_pmi above.

I used the *64 suffix and without '__' to match the cntr_mask/cntr_mask64
and fixed_cntr_mask/fixed_cntr_mask64 pattern in struct x86_pmu_capability
(patch 7), whereas __reprogram_pmi used '__' because it is an atomic64_t
rather than a scalar mask.

Also, arch/x86/events/perf_event.h has similar names:

        union {
                        u64             cntr_mask64;
                        unsigned long
cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
        };
        union {
                        u64             fixed_cntr_mask64;
                        unsigned long
fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
        };

Seems either way won't be absolutely unifie

>> @@ -120,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>>  			continue;				\
>>  		else						\
>>  
>> +/*
>> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
>> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
>> + * so iteration up to KVM's maximum counter count is safe.
>> + */
>> +#define kvm_for_each_gp_counter(i, mask)	\
>> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
>> +
>> +#define kvm_for_each_fixed_counter(i, mask)	\
>> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> 
> These are not used in this patch, are they?
> 
> They should probably be introduced when they are used. Also, do we
> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
> yes, maybe we should pass in the pmu here instead?

The intent was to group all bitmap accessor helpers together in this
patch for easier review so that the big patch 5/18 could be kept to
mostly mechanical replacements.

But if you prefer introducing them on first use, I'll move their
definitions to patch 5.

Regarding passing 'pmu' directly, I initially implemented it in this
way, but I can't recall why I discarded it. I will take another look.
>> @@ -183,9 +221,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
>>  {
>>  	int base = MSR_CORE_PERF_FIXED_CTR0;
>>  
>> -	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
>> +	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
>>  		u32 index = array_index_nospec(msr - base,
>> -					       pmu->nr_arch_fixed_counters);
>> +					       KVM_MAX_NR_FIXED_COUNTERS);
>> +
>> +		if (!kvm_is_fixed_pmc_supported(pmu, index))
>> +			return NULL;
> 
> Do all callers handle NULL correctly? At least
> reprogram_fixed_counters() doesn't look like it. It may be fine since
> NULL can already be returned today. Not sure if this series makes it
> more likely.

All other callers properly check NULL.

In reprogram_fixed_counters(), 'i' comes from
kvm_for_each_fixed_counter(), so it is guaranteed supported and cannot
return NULL (just as it was safe previously via "i <
pmu->nr_arch_fixed_counters").

However, calling get_fixed_pmc() in reprogram_fixed_counters() was
unnecessary indirection. In patch 5, I can clean this up to index directly:

@@ -98,7 +98,7 @@ static void reprogram_fixed_counters(struct kvm_pmu
*pmu, u64 data)
                if (old_ctrl == new_ctrl)
                        continue;

-               pmc = get_fixed_pmc(pmu, MSR_CORE_PERF_FIXED_CTR0 + i);
+               pmc = &pmu->fixed_counters[i];

>>  
>>  		return &pmu->fixed_counters[index];
>>  	}
>> -- 
>> 2.56.0
>>


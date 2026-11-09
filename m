Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246948;
	b=BD7/f0A7cp+GVUY9/8Io5y5reyDlNYz4HkLuJ0DmZh3CyRFsOPZc7L983xMoRUYmCI/4
	 Rr0nYNUYJpV5Pzvug6hgjwrO4DlBB0m0+5szTFv9gSGT+ORcyZw6zMy//l5YJzPWK4QA4
	 4VgxY9JSuEfc/pvrB6yEmycOOprWoAruSKZ/TOc0aFIVaKWqJ37CAJBFWLTmhKHMGcAvv
	 pKXwazb1BOLarvWTZ8KCe6sH/C4jNK+HlXhk+tu+Y6Bukf2DwOBzfwgK1au3gTpEeQ/Vj
	 vxvrA7vQsllSFYivXWqJSzQCnpoYbdss5Mea7rG6FNiTyhMbsg9exj0LP7ZepovDgrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246948;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6bKX3aMMhixRTUNzDdHxk7FZKlQ3NYr1JIqZdM+Irpc=;
	b=pGgfE41FxKk/WMcmRhfcEBz2I9ooerf1DL+ow3NVwqK+pIb8TM7Oeb9NGFDpgf7IWTlC
	 AzUmWvXECXgzRMwrg1jN/8LHVvtiYW7Zn4Qz2lK3DCBVsews1DtEwiLY8JwuU+++h57g6
	 JsvQN8/hkU2g1TDMY4BMp4qk/G1rwAr/1pL+IUzd9YIp7uF72qcA9Ly/NeUptB7aRcJvP
	 JdwyxTO01OTU/rS7jGYnakL0U8iK3Q3ig0JmfDnXCX1m0xxACvWRVgt1veENwDvlCndOS
	 cLh1AR+i4OfEFcizAoAFrL3Y2pXrIwX4Yx4ncpg3/HJK3Z7HB5DELlWFpCHFK1i63Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kN1nFyIr;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE26606A31C;
	Mon,  9 Nov 2026 17:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE26606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kN1nFyIr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794246948; x=1825782948;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8rkFS1gDTEYHVkLMdZ+zlX60pR3SDfNCsmHMqLuoh18=;
  b=kN1nFyIrtI1E/j8/vTXFRKhdZDxpgSn+SHthu3ibxjqqudzyMhRM0rbL
   rKEixvHWjI2x63X+FMKiHjzoUjke9FgZoJMO0sSMgb7HbtLRxVRtJyyR9
   u8GS4E/giqIRHptl16zTj36HOY4T0bmYdAdseddKS8+Jgoy1b64afRSR8
   tdGp6CGZmJR2pgu2utZRM1V/jnXyb7wqCZ7uZZxNLyR6oeOTzMWFJnyfu
   R9Hlok+E83eCwMPUo5w5r777TSyt7rsZkU508sSOQXHWYQxBeDB3n/6Sc
   kxzjnD1mzKYUJkjK+cYGdziP2GVVMXllXTNjAovf1CevEEpsdK4M15tej
   Q==;
X-CSE-ConnectionGUID: wfgVPIWvQriCtXbK8emzCw==
X-CSE-MsgGUID: caWi0VCHR/2EQDgGktzmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2878648"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2878648"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:55:44 -0800
X-CSE-ConnectionGUID: U8vhVYsyR7euGllKRrqZTA==
X-CSE-MsgGUID: o2O6LOgOTKS6H7TLgCe9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8248962"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 09:55:41 -0800
Message-ID: <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
Date: Mon, 9 Nov 2026 11:55:39 -0600
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
 <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/6/2026 4:35 PM, Yosry Ahmed wrote:
> On Fri, Nov 6, 2026 at 2:19 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>>
>> On 11/6/2026 1:09 PM, Yosry Ahmed wrote:
>>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>>> index b8875ed5502c..4f192429ed93 100644
>>>> --- a/arch/x86/include/asm/kvm_host.h
>>>> +++ b/arch/x86/include/asm/kvm_host.h
>>>> @@ -595,7 +595,10 @@ struct kvm_pmu {
>>>>              DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>>>>              atomic64_t __reprogram_pmi;
>>>>      };
>>>> -    DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>>>> +    union {
>>>> +            DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
>>>> +            u64 pmc_exists64;
>>>
>>> __pmc_exists would be more consistent with __reprogam_pmi above.
>>
>> I used the *64 suffix and without '__' to match the cntr_mask/cntr_mask64
>> and fixed_cntr_mask/fixed_cntr_mask64 pattern in struct x86_pmu_capability
>> (patch 7), whereas __reprogram_pmi used '__' because it is an atomic64_t
>> rather than a scalar mask.
> 
> I don't follow why the '__' prefix is specific to atomics, but anyway,
> I will leave this up to you and Sean.
> 
>>
>> Also, arch/x86/events/perf_event.h has similar names:
>>
>>         union {
>>                         u64             cntr_mask64;
>>                         unsigned long
>> cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>>         };
>>         union {
>>                         u64             fixed_cntr_mask64;
>>                         unsigned long
>> fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>>         };
>>
>> Seems either way won't be absolutely unifie
>>
>>>> @@ -120,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>>>>                      continue;                               \
>>>>              else                                            \
>>>>
>>>> +/*
>>>> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
>>>> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
>>>> + * so iteration up to KVM's maximum counter count is safe.
>>>> + */
>>>> +#define kvm_for_each_gp_counter(i, mask)    \
>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
>>>> +
>>>> +#define kvm_for_each_fixed_counter(i, mask) \
>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
>>>
>>> These are not used in this patch, are they?
>>>
>>> They should probably be introduced when they are used. Also, do we
>>> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
>>> yes, maybe we should pass in the pmu here instead?
>>
>> The intent was to group all bitmap accessor helpers together in this
>> patch for easier review so that the big patch 5/18 could be kept to
>> mostly mechanical replacements.
>>
>> But if you prefer introducing them on first use, I'll move their
>> definitions to patch 5.
> 
> Yeah I think it's clearer to see what their definitions are with their usage.

OK, then I can move these two macros to the next patch.
>>
>> Regarding passing 'pmu' directly, I initially implemented it in this
>> way, but I can't recall why I discarded it. I will take another look.
> 
> Thanks.

How about these? With them, we can remove the {gp,fixed}_mask variables
that you pointed out in your review of 5/18. The APIs are more
complicated, but the caller code is much cleaner.

static inline unsigned int __kvm_find_next_counter(struct kvm_pmu *pmu,
                                             unsigned int base,
                                             unsigned int max,
                                             unsigned int prev)
{
        return find_next_bit(pmu->pmc_exists, base + max, base + prev) -
base;
}

#define __kvm_for_each_counter(i, pmu, base, max)                       \
        for ((i) = __kvm_find_next_counter((pmu), (base), (max), 0);
     \
             (i) < (max);                                               \
             (i) = __kvm_find_next_counter((pmu), (base), (max), (i) + 1))

/*
 * Iterate over all general-purpose or fixed counters supported by @pmu.
 */
#define kvm_for_each_gp_counter(i, pmu) \
        __kvm_for_each_counter(i, pmu, 0, KVM_MAX_NR_GP_COUNTERS)

#define kvm_for_each_fixed_counter(i, pmu) \
        __kvm_for_each_counter(i, pmu, KVM_FIXED_PMC_BASE_IDX,
KVM_MAX_NR_FIXED_COUNTERS)

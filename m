Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794250744;
	b=t/FId4NeaF9S3DH3Muua0OVhYBF9zLef8vaIQ0ApIsKMwzoLholu9auqywG8d37pL2EC
	 ZRoJhmNkIAmbES9SxQXKNiPnE5NfvhL88/McjQgR30Di91nRopXskCDkk7L680dfXy5eS
	 2oKaixzXVvdRWB/E0EMx3KuPIQw42VPO3rlq0+valbogt25hAMdSilnFIDwTN1ugk+xAd
	 mDNTmA4YWgAVLQOK0vG7rqzHPYHZJ/WPMXB/Sz19wc3OEnqbVg96rhyFk0FSR7PWwpIJq
	 fd1/WhBfCJl9RN5stRAb/imLLHg3szMLd2BPFjuKqZnvHnNgdJAqTh7BhEtQ3+fl2gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250744;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=LqNUCTwonD4qgQd7U3RjoH/3r5q1OfnLhIwKQqjeFFY=;
	b=SEBnIGoRLuaZt0JRcGt6lhIuoYl9T2/4fjzAA3Iomp/+xCZ/J6Ym6sUI86ByF3Sce9VS
	 F3js6Ja9LzJ+ZGOYXohAxGsNDLXPzS3VoOoo5g7ri0amXDM6Qdjevt60b2isj1c6q9AS+
	 vueGQP7efVeXZe+WM6yg3EBg0MLou54OTFsUiKOoasBEkKLFiEEVMD9Ql50NuvhDkBC75
	 gUMfSmJMFWf2nX4py/jCmiOpZ2I9MShqcZ31cNPmq2SQNZClmaaUfIjVEcbSh9xZpEU4F
	 1z/VvmxAy5aEQqsKknXGsFHpm3w1RZvSD55aeyRfBlyVxNLfWbB4DClC/J5P4540DEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ke9yLAU1;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C574606A326;
	Mon,  9 Nov 2026 18:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C574606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ke9yLAU1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794250743; x=1825786743;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zl86r/WqsMRqvdcxZq1TAYG1DXcTzNj8CbVMSFqnAlk=;
  b=ke9yLAU1Koh7ur8iXbT4esSkdUcQhtW+zMVm12vwNQukGwX56rVPPU2C
   U5gaXF1nU5QlUXoDKvITbc+e+XyHjTVIJCMamcRVPFARdz30C9YVSXCcs
   3PW6ZmGJ6N4vJDZsMg3TpVG/dHzyAdPT+Sa+sVZgP4FXsQBlagfppHrRC
   fSTzBlMiTsyiUpr2pZD1AJb7KMdBOv8qo+BaFip60JgnOpX/+LLCDjPBA
   qE+8AzXf3k4s+wvwpoyx3elq036ccbezcqfwZEI4pjKtBLnGs6ANWRJRW
   4XZUeNCZeYjDcpoyi2pxucl/xvQ/TjcpaanQ69dhan09lkzjUL2vhD07/
   Q==;
X-CSE-ConnectionGUID: RjIMUTa7RoCed+h+BsGpgw==
X-CSE-MsgGUID: dbWGMxgcRNGh9PKDkG+aUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2995999"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2995999"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:59:03 -0800
X-CSE-ConnectionGUID: l7OWGRkJTTaBqE69Dgk0dQ==
X-CSE-MsgGUID: G1svxf/VSD+X3tvVbc+Msg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7961067"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 10:59:02 -0800
Message-ID: <c2844568-f8f6-450e-a718-1e9e3b7b3e4b@intel.com>
Date: Mon, 9 Nov 2026 12:59:01 -0600
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
 <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
 <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/9/2026 12:07 PM, Yosry Ahmed wrote:
>>>>>> +/*
>>>>>> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
>>>>>> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
>>>>>> + * so iteration up to KVM's maximum counter count is safe.
>>>>>> + */
>>>>>> +#define kvm_for_each_gp_counter(i, mask)    \
>>>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
>>>>>> +
>>>>>> +#define kvm_for_each_fixed_counter(i, mask) \
>>>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
>>>>>
>>>>> These are not used in this patch, are they?
>>>>>
>>>>> They should probably be introduced when they are used. Also, do we
>>>>> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
>>>>> yes, maybe we should pass in the pmu here instead?
>>>>
>>>> The intent was to group all bitmap accessor helpers together in this
>>>> patch for easier review so that the big patch 5/18 could be kept to
>>>> mostly mechanical replacements.
>>>>
>>>> But if you prefer introducing them on first use, I'll move their
>>>> definitions to patch 5.
>>>
>>> Yeah I think it's clearer to see what their definitions are with their usage.
>>
>> OK, then I can move these two macros to the next patch.
>>>>
>>>> Regarding passing 'pmu' directly, I initially implemented it in this
>>>> way, but I can't recall why I discarded it. I will take another look.
>>>
>>> Thanks.
>>
>> How about these? With them, we can remove the {gp,fixed}_mask variables
>> that you pointed out in your review of 5/18. The APIs are more
>> complicated, but the caller code is much cleaner.
> 
> I don't understand why we can't keep the macros as-is, but just move the
> calls to kvm_gp_pmc_mask() and kvm_fixed_pmc_mask() inside the macros?

for_each_set_bit() requires a pointer (`const unsigned long *`) as
input, but AFAICT a loop macro cannot declare a temporary local
variable, nor it can use do { ... } while(0). So something like:

#define kvm_for_each_gp_counter(i, pmu)                              \
        unsigned long gp_mask = kvm_gp_pmc_mask(pmu);                   \
        for_each_set_bit((i), &(gp_mask), KVM_MAX_NR_GP_COUNTERS)

It compiles in current code, but it may cause a few issues:

1. It fails to compile if called twice in the same function.

 kvm_for_each_gp_counter(i, pmu) { blahblah; }
 kvm_for_each_gp_counter(i, pmu) { blahblah; }

This would result in a redefinition of gp_mask.

2. It could fail to compile or lead to subtle bugs when used under if (...):

if (pmu->version >= 2)
	kvm_for_each_gp_counter(i, pmu)
		foo(i);

which would expand to:

if (pmu->version >= 2)
	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
for_each_set_bit((i), &(gp_mask), ...)
	foo(i);

>>
>> static inline unsigned int __kvm_find_next_counter(struct kvm_pmu *pmu,
>>                                              unsigned int base,
>>                                              unsigned int max,
>>                                              unsigned int prev)
>> {
>>         return find_next_bit(pmu->pmc_exists, base + max, base + prev) -
>> base;
>> }
>>
>> #define __kvm_for_each_counter(i, pmu, base, max)                       \
>>         for ((i) = __kvm_find_next_counter((pmu), (base), (max), 0);
>>      \
>>              (i) < (max);                                               \
>>              (i) = __kvm_find_next_counter((pmu), (base), (max), (i) + 1))
>>
>> /*
>>  * Iterate over all general-purpose or fixed counters supported by @pmu.
>>  */
>> #define kvm_for_each_gp_counter(i, pmu) \
>>         __kvm_for_each_counter(i, pmu, 0, KVM_MAX_NR_GP_COUNTERS)
>>
>> #define kvm_for_each_fixed_counter(i, pmu) \
>>         __kvm_for_each_counter(i, pmu, KVM_FIXED_PMC_BASE_IDX,
>> KVM_MAX_NR_FIXED_COUNTERS)


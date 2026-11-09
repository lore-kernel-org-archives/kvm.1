Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210797;
	b=yqnLwOGPn29q3xL+LVyU6PX44yp+S/olIcSZ44sy88noHPanLvsEewkP1b5IHc7oMUXs
	 hkZhQy5wSdhml0frE6cHhAkOgntBU+h5YssrjZG4sZpPc46lgvySq6SN+vWO9vjkHu/oT
	 u5++3JZMME/RiZ/df0UXC8c7zqaQN16Ly0I8RiEuor581G+6D3Z8PSFZlE1JIB/kmSFWM
	 6Pq2T6QHAd+EDt8x2Oz9kvfAQ8YRvLobFPvBSDF7p2MWPo22alNLKLnsJxeduNAvCk9tU
	 OR8Ut57gFbv0VxZEBHHi/9IIYrst5OOswIVYO51rmlw4lfzSu9x2VMu92ihFkFStLjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ekIw17i4+Cy0WA0lfjGw3LVAomYDJS2Tj+aYGoSnnao=;
	b=gy1qEoB1baQ2fEKxeVTiFduqdd1FoEoZ4x/qQxlyMm9LqTQ4nJ3G94Jo6fQkB92atR0c
	 8FslxQ8XpM1ptFjSRXqV29Zggit1YOBlfVqrXZoqmDkq74Q4+tU+GvBTG7hkjCQ6z0ANW
	 mDmfL+hTSMXyZPzDYr7CJym+YRambzqjVrfd/J01Rz4g083egi02kVyVpUHjrF/rn8a0D
	 QhXlUBpR0GPTfL/tRTUQZk2N6Cn6C9sxQZrGLlJbO30uksupYeXhp8YZ1eVwUIYP0GxFR
	 Fw/EzAfqeaxG4gc8tFjz9b1ZVOxxMBtO4Qdyy2stZN2ywL39ezYfRVHDYEAOt6ca1qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=faCEPrtp;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76C606A321;
	Mon,  9 Nov 2026 07:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C76C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=faCEPrtp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794210796; x=1825746796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ohVP8VdMNiP3olnLQYYifetx/XcaqaIFJmgBOWF4Gw=;
  b=faCEPrtp8OqnmjXgKhdfEb7kptBZ55V1rv4BKd3DeDcoKHo8SltXYtoG
   MtpiNZXOAb8TAOtf1l5qtMCP0TNH54De+gEI0r84t0QVHiRXbPyc50+h/
   V6A9qQp1WWXCo56LZ5GpLYm6gCJ7KR8ewaiS5aj8GCayzl3HdDWuqCN56
   kpcloISYr2pw1O3KGF+nr6RY0uBDUvLvW5bLUBClbABOwp72+o746cMBF
   bOZ3b6ojKfW6BQqiDxvrt+MMaPEvR9rVULwOM4TcJ+kltaoWgtTqh/3Yt
   35yHJhUZaXRmTe4d/3cF2k47qtI6GACz1N60mmgfQTfYyDq7ERe4Ns6Rt
   w==;
X-CSE-ConnectionGUID: vKMn/+90RT2wAj9gbH36CA==
X-CSE-MsgGUID: n83HlRejRdWmpEnhS+MbwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2917629"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2917629"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:53:15 -0800
X-CSE-ConnectionGUID: XO1L8Ht/Ro+eKqGLHg8BNg==
X-CSE-MsgGUID: vpVNX5mRQZWxkuFwmWEvYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8375725"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:53:12 -0800
Message-ID: <2aeaac02-368c-40b4-9b2d-feef5e9d9ea8@linux.intel.com>
Date: Mon, 9 Nov 2026 15:53:09 +0800
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
To: Yosry Ahmed <yosry@kernel.org>, "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com> <au4kyULjUYdqbfIq@google.com>
 <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/7/2026 6:35 AM, Yosry Ahmed wrote:
> On Fri, Nov 6, 2026 at 2:19 PM Chen, Zide <zide.chen@intel.com> wrote:
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
>>> __pmc_exists would be more consistent with __reprogam_pmi above.
>> I used the *64 suffix and without '__' to match the cntr_mask/cntr_mask64
>> and fixed_cntr_mask/fixed_cntr_mask64 pattern in struct x86_pmu_capability
>> (patch 7), whereas __reprogram_pmi used '__' because it is an atomic64_t
>> rather than a scalar mask.
> I don't follow why the '__' prefix is specific to atomics, but anyway,
> I will leave this up to you and Sean.

Per my understanding, '__' prefix hints this function/variable should not
be accessed directly, it should be accessed via some wrapper helpers. So I
think it depends on if we hope the variable pmc_exists64 should be accessed
directly.

Thanks.


>
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
>>> These are not used in this patch, are they?
>>>
>>> They should probably be introduced when they are used. Also, do we
>>> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
>>> yes, maybe we should pass in the pmu here instead?
>> The intent was to group all bitmap accessor helpers together in this
>> patch for easier review so that the big patch 5/18 could be kept to
>> mostly mechanical replacements.
>>
>> But if you prefer introducing them on first use, I'll move their
>> definitions to patch 5.
> Yeah I think it's clearer to see what their definitions are with their usage.
>
>> Regarding passing 'pmu' directly, I initially implemented it in this
>> way, but I can't recall why I discarded it. I will take another look.
> Thanks.

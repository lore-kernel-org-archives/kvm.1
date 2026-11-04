Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805601;
	b=AVZxxNXrvVVwUsdUcA+O99aEtWAYRSx+PnzxLzbJfm6AOW2EiR9R7VhvEKmYpb0YyOCo
	 1zZk0I34EaFUTaZzgNraKhz63pbAbH92dzaLeDVEf14GpIcBaOpPBusMql5fIK/XyVPoD
	 AUkePnqkY5Ehs1/qphzmWmOBxRBib5Xj9k8bTaVqMTvfPNUMXEnIM5HQLWGZStPT5cLSZ
	 Zv996FqY9qrx4FjgK/Q1NsXMeI4nYl6cEY1HU2SMfLnbtQqkYTM/TVpWN0GaEd88OFhUC
	 FyzdDucjPlMPWD8qV58sgWxFLSAQEZnruhf7M5pxntbWATOKofcY/MZ7WXAILkT3tgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805601;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sQJfLyQzxTgltNdCGCLoY8dC0UuRGGX7WaXv/CVim2k=;
	b=mFaP7Nwn+CA4G0b0VH0rIfQUD7h2MdvYH5AVFzCl1IHEsC/jJyyHSDSOkABvOSsA1Cfe
	 RHVkP1qUn23uFPAEiYnqeZKCF8Z/cY4zP/Z2hWTrG2ORRjpdzgNt6X3id+CcnZipGcpH0
	 3X2KzGiozmpO5iFN8ba/wzFeL9fPoJEqXBg6AOy8Te1L0w+RVLD8LyRJAJ9AHop1Iu62i
	 jkINUcaHIY3oOIutbQBMEWZmrfL1Gx9IU8h1epHeNP9ln7hfxqrQCFj32fjZDk7YDbwIG
	 HD4T/9U71T3QQlperhXRlSNsbuyVEO8TVUi6V56poZi8a01Vl+i067cLgA/9cCnipxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mtcn/p5n";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87776082BE7;
	Wed,  4 Nov 2026 15:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D87776082BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mtcn/p5n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793805600; x=1825341600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VRitswM6EnswGaj+ZpC1cTr4Nyj2vom0BR4pl7bFx/s=;
  b=mtcn/p5nY/Gn+QCqsndzKGuBmpRRneKSSCA5Fn9lfJVxUHOUPQEqvr8g
   OeRijjRzIHLrK4U1rMwVb30E/KjjOSyNM60MkpWIcd3mfOSlwCGBF3s2F
   iBlVhQZy/HlEXLcmXdZcugM44PEmE0F4xOx+U/Iow0H8RB7+4n4r0JuYK
   q6A/PwJ3+viK8cGwWxGTiWv7MbLnGm88/5f2q2JlDoS1UOxBsTeCJrppZ
   xMFAyBb4XD9DbRd5es3F9fUwzqIVYNWqe11oHyLNCS3hIADN4g96Fwjol
   8DhqJptjn+8Y0pN3slfcHS8OQdHxIPU4CyrpVBvvrhmyhgQnp+uuARd4j
   Q==;
X-CSE-ConnectionGUID: rayA/blwQ/SIQ8dkHcgs1w==
X-CSE-MsgGUID: eB2EP2WhTFmXpVzkAIXI8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2451211"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2451211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:20:00 -0800
X-CSE-ConnectionGUID: yc4EIq36T0K7t95NHNVq7g==
X-CSE-MsgGUID: gvJweND8S7KvSNvY1UPqaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6605792"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:19:58 -0800
Message-ID: <d97ab0ff-a6a5-408b-b2be-78d9c3352dc6@intel.com>
Date: Wed, 4 Nov 2026 09:19:57 -0600
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
Subject: Re: [PATCH v2 11/16] KVM: x86/pmu: Emulate the GLOBAL_STATUS_SET and
 GLOBAL_INUSE MSRs
To: Jim Mattson <jmattson@google.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com>
 <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
 <CALMp9eTiAMLsH7cO9Mc982WwDTAFcYOua+32Ykpj3gR_Oscfww@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTiAMLsH7cO9Mc982WwDTAFcYOua+32Ykpj3gR_Oscfww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/2/2026 12:32 PM, Jim Mattson wrote:
> On Mon, Nov 2, 2026 at 9:38 AM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>>
>> On 10/30/2026 5:13 PM, Yosry Ahmed wrote:
>>>>> @@ -865,6 +867,7 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
>>>>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET:
>>>>>         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>>>>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>>>>                 msr_info->data = 0;
>>>>>                 break;
>>>>>         default:
>>>>> @@ -931,6 +934,12 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>>>>>                 if (!msr_info->host_initiated)
>>>>>                         pmu->global_status &= ~data;
>>>>>                 break;
>>>>> +       case MSR_CORE_PERF_GLOBAL_STATUS_SET:
>>>>> +               if (data & pmu->global_status_rsvd)
>>>>> +                       return 1;
>>>>> +               if (!msr_info->host_initiated)
>>>>> +                       pmu->global_status |= data;
>>>>> +               break;
>>>>
>>>> According to Intel SDM Vol. 4, Table 2-2 ("IA-32 Architectural MSRs"),
>>>> IA32_PERF_GLOBAL_STATUS.CondChgd[bit 63] cannot be set by writing to
>>>> IA32_PERF_GLOBAL_STATUS_SET, because IA32_PERF_GLOBAL_STATUS_SET[bit 63] is
>>>> reserved.  In other words, it is not possible to save/restore
>>>> IA32_PERF_GLOBAL_STATUS when bit 63 is set.
>>>>
>>>> Because bit 63 is clear in pmu->global_status_rsvd:
>>>>
>>>> 1. An intercepted guest WRMSR(MSR_CORE_PERF_GLOBAL_STATUS_SET, BIT_ULL(63))
>>>>    succeeds instead of injecting #GP(0) and sets bit 63 in
>>>>    pmu->global_status.
>>>> 2. When bit 63 is set in pmu->global_status (whether it was set by
>>>>    kvm_pmu_set_msr() or by intel_mediated_pmu_put()), the next
>>>>    intel_mediated_pmu_load() will try to write an illegal value to
>>>>    MSR_CORE_PERF_GLOBAL_STATUS_SET. I don't think we get a #GP, because
>>>>    every wrmsr is "safe" these days, but the write will be ignored.
>>>
>>> On SPR, it does produce a #GP that gets ignored (and logged) and the bit
>>> is not set.  Interestingly, on CLX, the write goes through and the bit
>>> is set. Didn't check other CPUs.
>>
>> Good catch! I tested a few more CPUs (DMR/CWF/SRF/GNR/NVL/LNL), and all
>> of them #GP on writes that set bit 63.
>>
>> However, SKX, CLX, and ICX accept writes with bit 63 set and do not
>> generate #GP. On those systems, bit 63 also becomes visible when reading
>> back GLOBAL_STATUS. This behavior is documented in their errata:
>>
>> SKX95/CLX89/ICX166. Bit 63 of IA32_PERF_GLOBAL_STATUS_SET MSR (391H) is
>> reserved. Due to this erratum, setting the bit will not result in #GP.
>>
>> SKX:
>> https://cdrdv2-public.intel.com/336065/336065_Intel%20Xeon%20Processor%20Scalable%20Family%20Public%20Specification%20Update_rev17.pdf
>>
>> CLX:
>> https://cdrdv2-public.intel.com/338848/338848_2nd%20Gen%20Intel%C2%AE%20Xeon%C2%AE%20Scalable%20Processors%20Specification%20Update_Rev028US.pdf
>>
>> ICX:
>> https://cdrdv2-public.intel.com/637780/637780_3rd_Gen_Xeon_Scalable_Spec_Update_026US.pdf
>>
>> Given that SKX95/CLX89/ICX166 document this behavior as an erratum,
>> while SPR and newer CPUs appear to follow the SDM and #GP, should KVM
>> continue to inject #GP for writes that set bit 63?
> 
> Ugh. It seems like we have two options, neither of them all that appealing.
> 
> 1. KVM fixes the errata and raises #GP. To ensure consistency, KVM
> always intercepts the MSR on affected CPUs.
> 2. KVM mimics the errata and allows writes to bit 63 when virtualizing
> affected CPUs. This allows the MSR to be passed through, unless an
> unaffected CPU masquerades as an affected one.
> 
> Sean? WDYT?

After looking into this more closely, I think KVM should simply reject
guest writes to bit 63 (CondChgd).

In platform-specific documentation (EDS for SPR, ICX, DMR, PTL, etc.),
this bit is explicitly described as: "Set in case of a change to
IA32_MISC_ENABLES.PERFMON_AVAILABLE (bit 7)", clarifying the SDM
wording "changes to the state of performance monitoring hardware", or
"CondChgd: Status bits of this register have changed.".

This is also consistent with my testing, where I was unable to trigger
CondChgd on the host while exercising other PMU functionality that sets
GLOBAL_STATUS bits.

Since IA32_MISC_ENABLE is intercepted by KVM and is read-only for the
guest, CondChgd should never be set on GLOBAL_STATUS in the guest.

KVM cannot preserve this bit on GLOBAL_STATUS across vPMU context
switches, since it cannot be restored through GLOBAL_STATUS_SET.
That is fine, however, since CondChgd is not set on the guest.

BTW, the history on early CPUs is somewhat messy. As mentioned earlier,
some CPUs have errata that accept writing to bit 63 without #GP
(SKX95, CLX89, CPX89, ICX166, ICL019, etc.). Additionally, the reset
value of this bit is not consistent on some early CPUs, as noted in
commit b292d7a10487 ("perf/x86/intel: ignore CondChgd bit to avoid
false NMI handling").

I'd suggest splitting this into two separate patches: one patch
to emulate each MSR, for clarity.

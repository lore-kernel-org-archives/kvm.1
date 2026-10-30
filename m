Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793390474;
	b=eVXM+hoaWCzTWM9bmEyvap4hgfoYjfVLLZZ0nReHwWLUTLeRrCcqNnjOCVY58gmbN95i
	 1I+wI81Nj1o7eomdNenrudzTJm7EgyWJeG8whzLLvqySoS0wdERo4wU0YLD7DOpM88evk
	 PlgniETUcr3Xf8pBrM1fHL+GJadLziJ/wQKwI9EzmKtJiBBsWWuzSVkDAnALCWoIrsGTf
	 ejMYop7khXPz7/F/7svjlXDu/99fpzSrZxl6B5PELlZFdFE+VYcUoFRRfOL0CDLp+nlFC
	 38pcGZu6jRSrkXZGX7+tHHQQTW8CaJhHC9H3AXhsZJ+iPMwd6Fjr5WLT7QN+1FXcVpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793390474;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=pFrcOXhViBdH28F/rO42mZGNABj+tFhweJ/WrDNE/kg=;
	b=wdrgb3JeZQC4fFLwayAnUisejA4QSFadTy0vqOCcA+PbUSbBWnlvNfOliZ+ddkLmISQH
	 yRzjrvey1UfbrdTMsbNEV5Fqbq5/SRT5FMLDIhfBMlngDKnCikQP3r/iQFF0nkfWzn97W
	 9DwVwtzUw5C5lroozddeK2MGAQ0NKraK7Mp9TQ5NKMsPo2naD33MzILLN5W9+pNaT6TMS
	 Oi2KfFeMoseVS3tZMEbkyerSLMmjPj7rqa3z8H+2R4h3NFkzev9eZBdBeb4Ia/u7HEu6R
	 9v1bJDNXag0fcoa/TOZz6jNpL6f7LxxhnNEosQxwu200jjFkpsBLRfSqkfvY96ruyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vslcx7Dr;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED13606A31C;
	Fri, 30 Oct 2026 20:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED13606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vslcx7Dr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793390473; x=1824926473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=csjH2mric7kGbdZqhswZMkEiW0X3FsU+SuPN42EQ9Wc=;
  b=Vslcx7DrLM86GDbOQQ1KCowoD/3W+rJourrCd0Ix+M4N8Wa6dwbjTnHd
   2GqUHd7s39MM/ncbhYpaiiRqwG5LO5FeCZxph7Gu5x5m//nKcRbz1ykeL
   I9LjTmOX/oU9JU+L8ZPaLSx82dne16c4zFwpWIWflRrCXOrduV6WKUUPC
   AcuBrOqcn+i3OTf3hICjy2R2IwFhyaWrQA+TAF2183dQGnPu07rJqJrGg
   0XJiClTX0S6xMsmfE9jWJQQoXpmZSjz4/0uTen3M41GXSVPRafjF8itaJ
   Xd9v1rMqphvN9WfN1tPbWVVI5cV81RSvZVLfF04IYolpgiokorUDjJpM6
   A==;
X-CSE-ConnectionGUID: WTgrvaoLSouPFQ3TPUizTg==
X-CSE-MsgGUID: J1UVyBuOSgiC7aHwEY3gbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2040670"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2040670"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 13:01:12 -0700
X-CSE-ConnectionGUID: ekxGTmPLS0+BfToRrPu8wA==
X-CSE-MsgGUID: 6FiM6dEZT+CcNIfUHLp6/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5522460"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 13:01:11 -0700
Message-ID: <d0e5f936-8203-459a-b9e0-1bb796943644@intel.com>
Date: Fri, 30 Oct 2026 15:01:10 -0500
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
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <b3dcb403-ec19-4d23-9bab-336e2eb344bd@intel.com>
 <CALMp9eTHRzXXm1gpKR3u1nzJU3i9M1a_wUjp9+bD8_r4eoPQ_Q@mail.gmail.com>
 <dc0e6998-6b8c-4b0c-a04e-b6af0a1cf653@intel.com>
 <CALMp9eTRTLGziPtrSG9tQWLqoUuz9zmrRwUis5gb-wSeJeA7-w@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eTRTLGziPtrSG9tQWLqoUuz9zmrRwUis5gb-wSeJeA7-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/30/2026 1:23 PM, Jim Mattson wrote:
> On Fri, Oct 30, 2026 at 10:20 AM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>>
>> On 10/30/2026 6:55 AM, Jim Mattson wrote:
>>> On Thu, Oct 29, 2026 at 10:45 AM Chen, Zide <zide.chen@intel.com> wrote:
>>>> On 10/28/2026 4:24 PM, Jim Mattson wrote:
>>> [ ... ]
>>>>> As I pointed out in patch 04/16, we can't pass through the PMU global
>>>>> controls unless their reserved bits match hardware.
>>>>
>>>> Totally agree. Then the handling of bit 55 breaks this rule as well.
>>>>
>>>> if (vmx_pt_mode_is_host_guest())
>>>>         pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
>>>>
>>>> Always intercepting GLOBAL_OVF_CTRL and GLOBAL_STATUS_SET can solve this
>>>> problem, but it may impair guest performance, especially for nested.
>>>>
>>>> Instead, I'd propal to have separate reserved masks:
>>>> - pmu->global_status_rsvd: unchanged, strictly tracking virtualized
>>>> guest state and preserving live migration validation.
>>>> - pmu->global_status_{clr,set}_rsvd: unmasking all architecturally valid
>>>> hardware bits for the corresponding MSRs on v4+.
>>>>
>>>> Any bits allowed by hardware but unvirtualized by KVM are
>>>> scrubbed/filtered in intel_mediated_pmu_{put,load}().
>>>
>>> That is a terrible proposal. MSR bits that vanish at unpredictable
>>> times?!? No. If an MSR contains bits that aren't virtualized, that MSR
>>> can't be passed through. Full stop.
>>
>> OK, I agree. I will intercept GLOBAL_STATUS_SET (0x391) and remove the
>> nested_vmx_merge_msr_bitmaps() for it.
>>
>> However, I propose we keep GLOBAL_OVF_CTRL (0x390) passed through, even
>> though its reserved bits don't match hardware. Since it is
>> write-1-to-clear, it cannot manufacture unvirtualized state or leak host
>> data.
>>
>> The only divergence is the lack of a #GP if the guest writes an
>> unvirtualized but hardware-valid bit. If we want to eliminate this
>> behavior by intercepting it, it will force an additional VM-exit on
>> every single guest PMI.
>>
>> What do you think?
> 
> That seems reasonable to me, as long as the architectural misbehavior
> is documented in Documentation/virt/kvm/x86/errata.rst.

How about add something like this to errata.rst:

IA32_PERF_GLOBAL_STATUS_RESET
-----------------------------
To reduce VM-exits to performance-critical paths, KVM passes through
writes to IA32_PERF_GLOBAL_STATUS_RESET (0x390) in mediated PMU mode,
even if the MSR has bits that are not supported by KVM.  Consequently,
KVM does not inject #GP if the guest writes bits that are valid in
hardware but unvirtualized by KVM.

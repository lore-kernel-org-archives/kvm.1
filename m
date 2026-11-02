Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654990;
	b=R8gbtGgRBVRL/W8Gjr9btknF8r8ulf0szuzbcdaKcrFmLOW7+y9wsT2Sq5+mCr0JV5Y9
	 yqwgBN9ous5dTFBDl2f9xpZrURs83WrTnVZwOiEc96zDj2R3QvwcO1AwiuYLQxQEs0gHf
	 zlg2IT17JQbprKqjC8OVSwkbUFqkkcEBiuJuKTKrlHxoxFon9xlshCwddq5IdAns/IAiy
	 shtCfvzKVhYgtK/EIhJavySBqrufksv1QvfwaXpxxBtKJe/MFT46cpRuv7gkgVOq7fUw4
	 BV32st0/iL8VesCQu2x1xdceuQg3opKAbYCWTC9e7SQ3hasH3oF/JM8Zj6Z+W1wz31A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654990;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4x/8m1FBYoP1cRclqzCfOrS0dYnbYeqPVhu7UPr9Vg4=;
	b=x66ksIDFtZ6fnFAKCLYy9mHDDUIqamtBSvavTf7n2bUPq+RmCO+2m6BBS9LvVAhwPtxD
	 X6yxbQF8n3dEe45gdHx6gJXqcy5z26BXVUdDAx5QnfqIfTQUNqGlsXKZVsX9nxRtOB30o
	 UEE6DdMJ5xlA9u85s+PUB+CPNs9/3nL15SRFhrKUPxfHRKO1zDpW1oP9EBGJ3Q26Neh39
	 3Ag93K+v/yzw1kgm+gx4Qv8zcooAXJlbeHssH3E8kChLYcVQz1e/szYzIgC1WFcxvaUNS
	 5M0Xgw4++hm1rlG5ysoXQKHvFfjp/4jgJbEcXV0yOx/RpVxg3Sr9NWL4bp42UPQuHYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QveWtzFP;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E290606EE82;
	Mon,  2 Nov 2026 21:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E290606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QveWtzFP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793654989; x=1825190989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0AAFSmAsu+r5QOHMwFL7eRdGUJum5paaN98p+0Untmo=;
  b=QveWtzFPcU0bKo7AACZdVHSna2zqOqEiK/doJ0fLg/pN54x3ObU6AJAV
   KbYjvznxqOFxDGRie4V2CnBzimhsrNTjLwsxLv7s9yDAossgexPyb/7HY
   k0uwGZ1CLjl8iMVS1luvMjbq8LLadPxGEYVKdKxVKd8/gmbZnwtqy07u3
   zOlsYGOvVXwhNBIrA0S2NcZMoMl9WArEWxeBhaQtI8543To+L0tBjx1QE
   gXC/+9Z8gEWy1XnHzRU30PmsfJTvPn7EhDtx/QwT9kUBHOkEgGMDiNLtf
   apd7qfnDE7Ev4HG9R/GTXmnf7t3qfbC7h9iMQh+vdoWwuWUa8FiVMMilU
   g==;
X-CSE-ConnectionGUID: 2mqCq7e7TseLa8vUklzSGg==
X-CSE-MsgGUID: PZxR0wkxQGeP/JVjgrhj5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2267939"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2267939"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:29:49 -0800
X-CSE-ConnectionGUID: mWTKvRJCQNmJHbv6HnNaYg==
X-CSE-MsgGUID: ZPuqtrRKRJq4bNnpGs5Xtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6342739"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:29:48 -0800
Message-ID: <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com>
Date: Mon, 2 Nov 2026 15:29:47 -0600
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
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Sean Christopherson
 <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-12-zide.chen@intel.com>
 <CALMp9eRvQ+iQdw_dWPLqZCrO7zpLut+O27pb-EPNa33hkegaBw@mail.gmail.com>
 <auUQgRVFASkWtkoK@google.com>
 <3276824d-f6a0-455a-bf0c-703fc6d52cf1@intel.com>
 <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zMxQnRLKGrW69rX7703AatWMp6KOXMObL9baHRPs4dW8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/2026 12:49 PM, Yosry Ahmed wrote:
>>>> OTOH, what about PerfMon v4 bits 58 (GLOBAL_STATUS_LBRS_FROZEN), 59
>>>> (GLOBAL_STATUS_COUNTERS_FROZEN), and 61 (GLOBAL_STATUS_OVF_UNCORE)?  Per
>>>> Intel SDM Vol. 4, Table 2-2, those bits are valid in
>>>> IA32_PERF_GLOBAL_STATUS, IA32_PERF_GLOBAL_STATUS_RESET, and
>>>> IA32_PERF_GLOBAL_STATUS_SET when CPUID.0AH:EAX[7:0] > 3.
>>>>
>>>> When those MSRs are passed through in mediated mode, the guest can set bits
>>>> 58, 59, or 61 in hardware via IA32_PERF_GLOBAL_STATUS_SET. Leaving those
>>>> bits set in pmu->global_status_rsvd for pmu->version >= 4 will break
>>>> KVM_SET_MSRS(MSR_CORE_PERF_GLOBAL_STATUS) as well as any intercepted guest
>>>> writes to GLOBAL_OVF_CTRL / GLOBAL_STATUS_SET.
>>>>
>>>> As I pointed out in patch 04/16, we can't pass through the PMU global
>>>> controls unless their reserved bits match hardware.
>>>
>>> I think there are two other relevant (but pre-existing) problems here:
>>>
>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
>>> guest. If a host PT PMI arrives while the guest context is loaded, bit
>>> 55 will be set for the guest, and the guest won't be able to clear it if
>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
>>> Similarly, the value can't be restored through KVM_SET_MSRS.
>>
>> I think mediated vPMU assumes that no host PMIs can be generated while
>> guest PMU state is loaded.
>>
>> If PT state can leak into the guest via bit 55, similar leakage can also
>> occur for other status bits, e.g. when the guest exposes fewer
>> general-purpose or fixed counters than the host.
>>
>> The scenario where both host and guest can be active simultaneously is
>> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
>> filter guest-owned status bits.
> 
> Looking at the code:
> 
> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
> perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
> 
> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
> schedule them out.
> 
> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capabilities
> 
> Please correct me if I am wrong.

My apologies, this bug is indeed real because pt_pmu lacks the
PERF_PMU_CAP_MEDIATED_VPMU capability.

Adding this capability to pt_pmu seems intuitive, but unlike

                       the core PMU (which merely toggles enable bits),
Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
transition is heavier, and I'm not sure whether it could introduce a
noticeable performance penalty.

However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU or
some other mechanism to enforce mutual exclusion between pt_pmu and
mediated vPMU, we can address that in a separate patch.

To immediately protect guest state and live migration in this series,
I'm thinking of adding the following defensive filter in
intel_mediated_pmu_put():

+ /*
+  * Scrub bits that are not virtualized for the guest to prevent
+  * possible host state from leaking into guest state and breaking
+  * live migration.
+  */
+  pmu->global_status &= ~pmu->global_status_rsvd;

> 
>>
>> https://lore.kernel.org/kvm/20260821222002.54907-1-zide.chen@intel.com/T/#m90394fda6d71ed0dd539a579abfb0c1df1e044fe
>>
>>> (I think the PMI may also be lost as LVTPC points at the mediated vPMU
>>> vector)
>>>
>>> 2. On AMD, bit 58 and 59 have a similar problem. HW accepts those bits
>>> but they are reserved for the guest, so the guest can set them if
>>> GLOBAL_STATUS_SET is passed through, but userspace cannot restore them.
>>
>> Right. That seems orthogonal to this series and could be addressed with
>> follow-up fixes.
> 
> Maybe AMD folks on the thread will take a look :)


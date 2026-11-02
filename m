Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657590;
	b=lP9un+gLY/Gz7MQON7+WaYP0tU/A/c1p3AcaMud98PlZGc3o9waUKJWiUGF4g3xYEXyj
	 TN8woppm7ikCFhVbSoHASeuWcruvkxp2otc9p9x9r1axRfR03XsfGtNQOj3T5AvT/c7wg
	 qLSbfgVGZancJCyXc26lQ0CTjyVuLLHNgdB+OQwKlQso8icZ96U8W8aQr2AOvf5gPNZZJ
	 DVZ5EZIjWuy5BYOpBC38SY313vfDRTcsvPa1hKlUX9BRhp9SbctDxTLZ5x+UMuQE31KEL
	 5ayTgy8tPkE9zK3wZatXIVspfzwGmXdhBHSr7BsBlKCHfOWIRopeDRp8XtOFTuIdyAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657590;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=II8S/L1C+UfHdReInLGdSlBNzgpg/69Ug85MwjbR7Dw=;
	b=S2wkpxUZR6onVB5lHmSvEjNair0ENZZp+I5I8I9sjvFiFwfy3nxnqxcufq98yXzRH9+I
	 pUONRt8keDFRmy+NZE01YwsGn+f1inNb/U9/QKTkZ+nv3m/e/cEJZiC6D08vr8ovjEoBp
	 G2+VNS2LN27N0GfKaYeqh3lDWuiKTQC9Ddv39VNbOSepjSkNG9MEiGG/MAPVo1l9p38YA
	 5Kl31ION38yJgQLF4N3hp7yyrrYsBkB1Fa8KtblB/a6slhWv4/dzYoe7aL6ILWTVlViKH
	 Hi3Tdlowa7ZAF1IORxeiPfN+eR3arYK50ZdFswUVfmOGb6kCRjT8xgWq7YyGyJYD1FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LtSv8sWC;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4B606A326;
	Mon,  2 Nov 2026 22:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F4B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LtSv8sWC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793657589; x=1825193589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kM6eJZCvglrGrpZCy6u4Xik4g8xbY66wdicpAUvDjyU=;
  b=LtSv8sWCtZ0V4lETSPNDhp/37s+1IS5hNkW5j5w/W2afuO/HmNd916VS
   SvdtxszmhYNHtM8d/6+X6HFnsCCdlFlV1UL0NDMOiigyAMXxgET/4IJKi
   1Qdh7sBRVbtKGh4lpt7/Iw0KDsTaxtceEew0G+B/+iMIy05TJVU8jjHFe
   zLxqJnjsERaW2d2/3M2qxcAsLiapZfKbyuEUvKPKSK4exTziWOmBDl9Q6
   u6nu2OZlD6ReTXg/fFArLWCHdkU3uASEzV6k2KmQpWs9O8ZO7Aebfhr3t
   +p1IiSG5pgz4RVGpakZul+9A4HNXoi6sj0IyW152nfcHzMnb7991gXBra
   w==;
X-CSE-ConnectionGUID: ZkuALszYS7ObRnSxti2eBw==
X-CSE-MsgGUID: g/fE0Bi1TEugcClpkvrCIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2271615"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2271615"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:13:08 -0800
X-CSE-ConnectionGUID: Uzu8tGm3Tmy25F4iXIYm4Q==
X-CSE-MsgGUID: mktOVBulRxqN71gBdfvGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6147011"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:13:07 -0800
Message-ID: <69c428d7-239a-485e-9494-32b8aa82da05@intel.com>
Date: Mon, 2 Nov 2026 16:13:06 -0600
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
 <6c9a13c9-e6c1-4540-a8ca-1f0e800f3571@intel.com>
 <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zOWzr61pkkF01AvEp+YSOo6bA1N=L91RYiM=ETtK5+D9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/2026 3:36 PM, Yosry Ahmed wrote:
>>>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
>>>>> guest. If a host PT PMI arrives while the guest context is loaded, bit
>>>>> 55 will be set for the guest, and the guest won't be able to clear it if
>>>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
>>>>> Similarly, the value can't be restored through KVM_SET_MSRS.
>>>>
>>>> I think mediated vPMU assumes that no host PMIs can be generated while
>>>> guest PMU state is loaded.
>>>>
>>>> If PT state can leak into the guest via bit 55, similar leakage can also
>>>> occur for other status bits, e.g. when the guest exposes fewer
>>>> general-purpose or fixed counters than the host.
>>>>
>>>> The scenario where both host and guest can be active simultaneously is
>>>> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
>>>> filter guest-owned status bits.
>>>
>>> Looking at the code:
>>>
>>> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
>>> perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
>>> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
>>>
>>> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
>>> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
>>> schedule them out.
>>>
>>> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capabilities
>>>
>>> Please correct me if I am wrong.
>>
>> My apologies, this bug is indeed real because pt_pmu lacks the
>> PERF_PMU_CAP_MEDIATED_VPMU capability.
>>
>> Adding this capability to pt_pmu seems intuitive, but unlike
>>
>>                        the core PMU (which merely toggles enable bits),
>> Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
>> transition is heavier, and I'm not sure whether it could introduce a
>> noticeable performance penalty.
>>
>> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU or
>> some other mechanism to enforce mutual exclusion between pt_pmu and
>> mediated vPMU, we can address that in a separate patch.
>>
>> To immediately protect guest state and live migration in this series,
>> I'm thinking of adding the following defensive filter in
>> intel_mediated_pmu_put():
>>
>> + /*
>> +  * Scrub bits that are not virtualized for the guest to prevent
>> +  * possible host state from leaking into guest state and breaking
>> +  * live migration.
>> +  */
>> +  pmu->global_status &= ~pmu->global_status_rsvd;
> 
> This doesn't prevent the leakage, it just clears it on the guest->host
> switch. So it helps live migration but I am not sure if it's better or
> worse if the guest sees the bit unexpectedly appear AND then
> unexpectedly disappear.

Right, as long as the GLOBAL_STATUS is passthru, the leak can't be
prevented.
> We can clear it when the MSR is read by userspace, which should fix
> live migration, but the guest will still see the bit, and it will
> still disappear unexpectedly but only during live migration.
> 
> The guest still won't be able to clear it when OVF_CTRL is intercepted.

GLOBAL_STATUS and OVF_CTRL share the same interception policy. If they
are passed through, the guest can see the bit and clear it; if both are
intercepted, then bit 55 can't leak to the guest.

It's not perfect, but at least the guest won't observe bit 55 and then
get an unexpected #GP when attempting to clear it.


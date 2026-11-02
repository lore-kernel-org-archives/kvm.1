Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661972;
	b=VKta+FVQeLWrog7zpTPTcFw8NQvyY6JRlcvrezPglwFYhWsCQT9ejS0nqu70zXuczLhk
	 IzvcW2d/JbkBhB6IhJNnxKZ6UJd5+EpzZW/3KbcnigugXASF3r0htClPuvQUw3aveQ4SR
	 r/e8e/bmqX0lpbv/35mGTmpJ7vgyxBC8YOabkMOXqa4Vpw6BbfA/BvX6VIR64+2NBRoYT
	 QmdmYvw6vyPREeo8QZGVzB2gRvYU40hgMGJT/gGcNPVnW4vpW+pucxXxQuwHDS4s3rQOb
	 yolBZ+ZLNPN3EC0Ly69IGBWQ6Ul0UNCsVDowtNozlF9Ab2d3/vdmu3QMmdA6JTCB4aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661972;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=W6JHpSmxxXi4wrtj47YYY3ABNffhQA0kAKjpuUyzWMk=;
	b=Lzbn8zlOt7r4loxTCT2Ui4jEYGiVprKEGxb0N2H0tNqgGJ9y7muoJFlxWJ2Gb9IUDjhY
	 o4+dH/xOGSuxUioktNsmEC3p8l0namVBoypEoRjSvLcTfN4nmHIqgIu/Wb3zXsVzdoG1Y
	 v4Vmpi+dZipbXG5GuwP5ClOukzL31LDJS0ll51NiS0u6Z0C9SLPlKqSROX/AjfXkhon9o
	 vwDNz9n7iilws4WM1MPYsc7CP6gkW56wHWdKDCdude9uL6o4ejL7IJAFgGzRmu1Tl/CKl
	 jhvKG1N5TIr9MON3CmJkWnNTNHrP1l6hMfUf8N6OGP1M7BytSXwwuJm1dFIgblCckmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDrUqwDh;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE6606A330;
	Mon,  2 Nov 2026 23:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CE6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDrUqwDh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793661971; x=1825197971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=di2LeUKhy5cTvKnuGF32Eef9G54E0Zhn+genGk97NTo=;
  b=UDrUqwDhRwGMSi9TWUZ8t0MryNZ0Kek4NQpKA4b+OBobwW2HxdweaPeR
   ULbr6coovXNoDI/YDywALoq0UgZeeTDn7xbiRBazR4nmxmu3wUDSFGVdg
   HaVYybyw+9dhuaweMrEMOu2i1e53yaYDAgFax86YM2ZjLsyRlsIi9R9Lv
   DxuEzHFPRSdhN6KepC//pvltPRTaV1LZZZky1Y1z6oYkKXlcRDLzP8IAJ
   5FCEsxQU1fq+sf1Pf7OmwgrUFfCJalxIhtgycW2FJuM4xFYrmi1gJ3DWR
   PMUS7TPhvlxyDrAJ+Un74oqeX6WO6wRgG3ZKIHiGKH8HlwXsIfEX0L4D3
   g==;
X-CSE-ConnectionGUID: 6/vr/grcTySDgyQIvEdKzg==
X-CSE-MsgGUID: Ap0okXiQQ8eq+OGEaPNouw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2261195"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2261195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:26:11 -0800
X-CSE-ConnectionGUID: iBTOuXN2SZidv0DJJwKzvg==
X-CSE-MsgGUID: 0k4Ax+ttSNWLuaIQDIrdQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6255708"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:26:10 -0800
Message-ID: <6d84ab57-a702-4ac0-9e29-579449b3d826@intel.com>
Date: Mon, 2 Nov 2026 17:26:08 -0600
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
 <69c428d7-239a-485e-9494-32b8aa82da05@intel.com>
 <CALMp9eRsR8xaUmQyVu5QmYx1cZ2qFGGk+31bMymhmN9_iaPuMg@mail.gmail.com>
 <f7213eba-5b61-4514-a315-bce64823fad5@intel.com>
 <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zM4eWD538L3osqSVoB0VHnjgRREtv2k419a1Vvuq+Q9rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/2/2026 4:51 PM, Yosry Ahmed wrote:
> On Mon, Nov 2, 2026 at 2:48 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>>
>> On 11/2/2026 4:25 PM, Jim Mattson wrote:
>>> On Mon, Nov 2, 2026 at 2:13 PM Chen, Zide <zide.chen@intel.com> wrote:
>>>>
>>>>
>>>> On 11/2/2026 3:36 PM, Yosry Ahmed wrote:
>>>>>>>>> 1. GLOBAL_STATUS_TRACE_TOPAPMI_BIT can leak from the host into the
>>>>>>>>> guest. If a host PT PMI arrives while the guest context is loaded, bit
>>>>>>>>> 55 will be set for the guest, and the guest won't be able to clear it if
>>>>>>>>> OVF_CTRL is intercepted (it will #GP as it is reserved for the guest).
>>>>>>>>> Similarly, the value can't be restored through KVM_SET_MSRS.
>>>>>>>> I think mediated vPMU assumes that no host PMIs can be generated while
>>>>>>>> guest PMU state is loaded.
>>>>>>>>
>>>>>>>> If PT state can leak into the guest via bit 55, similar leakage can also
>>>>>>>> occur for other status bits, e.g. when the guest exposes fewer
>>>>>>>> general-purpose or fixed counters than the host.
>>>>>>>>
>>>>>>>> The scenario where both host and guest can be active simultaneously is
>>>>>>>> handled by the perfmon_mask case, where intel_mediated_pmu_{load,put}()
>>>>>>>> filter guest-owned status bits.
>>>>>>> Looking at the code:
>>>>>>>
>>>>>>> kvm_mediated_pmu_load() -> perf_load_guest_context() ->
>>>>>>> perf_ctx_disable() will iterate PMUs with for_each_epc() and disable
>>>>>>> them, which skips PMUs without PERF_PMU_CAP_MEDIATED_VPMU.
>>>>>>>
>>>>>>> Same for kvm_mediated_pmu_load() -> perf_load_guest_context()
>>>>>>> ->ctx_sched_out(), it also uses for_each_epc() to iterate PMUs and
>>>>>>> schedule them out.
>>>>>>>
>>>>>>> pt_init() does not set PERF_PMU_CAP_MEDIATED_VPMU on pt_pmu.pmu.capabilities
>>>>>>>
>>>>>>> Please correct me if I am wrong.
>>>>>> My apologies, this bug is indeed real because pt_pmu lacks the
>>>>>> PERF_PMU_CAP_MEDIATED_VPMU capability.
>>>>>>
>>>>>> Adding this capability to pt_pmu seems intuitive, but unlike
>>>>>>
>>>>>>                        the core PMU (which merely toggles enable bits),
>>>>>> Intel PT is an AUX-based PMU. Stopping and restarting it on every VM
>>>>>> transition is heavier, and I'm not sure whether it could introduce a
>>>>>> noticeable performance penalty.
>>>>>>
>>>>>> However, whether the solution is adding PERF_PMU_CAP_MEDIATED_VPMU or
>>>>>> some other mechanism to enforce mutual exclusion between pt_pmu and
>>>>>> mediated vPMU, we can address that in a separate patch.
>>>>>>
>>>>>> To immediately protect guest state and live migration in this series,
>>>>>> I'm thinking of adding the following defensive filter in
>>>>>> intel_mediated_pmu_put():
>>>>>>
>>>>>> + /*
>>>>>> +  * Scrub bits that are not virtualized for the guest to prevent
>>>>>> +  * possible host state from leaking into guest state and breaking
>>>>>> +  * live migration.
>>>>>> +  */
>>>>>> +  pmu->global_status &= ~pmu->global_status_rsvd;
>>>>> This doesn't prevent the leakage, it just clears it on the guest->host
>>>>> switch. So it helps live migration but I am not sure if it's better or
>>>>> worse if the guest sees the bit unexpectedly appear AND then
>>>>> unexpectedly disappear.
>>>> Right, as long as the GLOBAL_STATUS is passthru, the leak can't be
>>>> prevented.
>>>>> We can clear it when the MSR is read by userspace, which should fix
>>>>> live migration, but the guest will still see the bit, and it will
>>>>> still disappear unexpectedly but only during live migration.
>>>>>
>>>>> The guest still won't be able to clear it when OVF_CTRL is intercepted.
>>>> GLOBAL_STATUS and OVF_CTRL share the same interception policy. If they
>>>> are passed through, the guest can see the bit and clear it; if both are
>>>> intercepted, then bit 55 can't leak to the guest.
>>>>
>>>> It's not perfect, but at least the guest won't observe bit 55 and then
>>>> get an unexpected #GP when attempting to clear it.
>>> I'm not sure what imperfect solution you are referring to, but Yosry's
>>> proposal that the bit gets cleared on a guest->host switch is a
>>> non-starter. MSR bits must not vanish unpredictably.
> 
> I don't think I proposed this? :)
> 
>>
>> Agree, then maybe Yosry's suggestion is what we can do for now: filter
>> out unsupported bits when the MSR is read by userspace.
> 
> This I did propose, but I also noted that the MSR bit will still
> vanish unpredictable, just on save/restore instead of guest->host
> switch, which should be better.

Yes.
>>
>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>> index 38c7a4fa1007..3849b3f5234a 100644
>> --- a/arch/x86/kvm/pmu.c
>> +++ b/arch/x86/kvm/pmu.c
>> @@ -862,6 +862,8 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct
>> msr_data *msr_info)
>>         switch (msr) {
>>         case MSR_CORE_PERF_GLOBAL_STATUS:
>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
>> +               if (msr_info->host_initiated)
>> +                       pmu->global_status &= ~pmu->global_status_rsvd;
>>
>> The underlying issue still requires proper mutual exclusion between
>> Intel PT and mediated vPMU, which I think can be addressed separately.
> 
> Or maybe handle the host PT while the guest is running? Not sure if
> that would be correct.

Since KVM switches APIC LVTPC in guest context, it seems difficult to
correctly handle host PT PMIs while the guest is running.

I guess Intel PT virtualization could be re-enabled sooner or later, and
addressing the exclusion issue would be a must at that point anyway.

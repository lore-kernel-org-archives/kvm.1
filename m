Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375228;
	b=zWyU/yVAMLWG0Wi1CRyB5f6WJlCaFehcRm4Hd+5hSwpdPd7+2eOeI5nmoCVAGxha6eEx
	 iMnB0L3gWgJ6ghOPYTb3H481kXaTTzzzvyLQu5Vd8RnoEBPOZqae3E8WVOXO9y7khJX9T
	 lhvoHZ5Ht3RbjJ6cNx8pQDmV2MEsm00Tycg5SCPWT54KophVHIgHOoY4dHgWrB7BF1FlI
	 aLNjlIL554yFm6pdBM8g3OhEbuRRHQkcWcbamcOwK9R5YeLX86nQwoZdwONXEuxDhvIoa
	 R7H27FwaDcscA6igvYh5ZFXUhnTkwsm/VFNi/tQ6+7OmwRXqrIrLonU/jWvblMDzX/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375228;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=iHHJCT8V1e+GhwrDlolHdIQJgqdcZxzOW/RwtDvAMVw=;
	b=P+M3DT/MsLC/zno071wH7k/qG8Xwc2/XjiFjQy2Wx8+991ZwJS9fRr63iZV6xjgRp7eX
	 jweOqYATc3VRWJaK283w5ZVVGvBo/PPjOxdC6j5HKsfE73fJPuggojMSKSoO36XXcaiAb
	 O42P29UiVjSFUd0jJhfRZRkP6/qO4JfOzXTO5+yGr6KlGnFEW5r/D1V4YJXTN+sWtlKFi
	 /zJUttOP8g/X7LIVvkJyyGz0Tw6/n4zj7lbtkaxUvDgT3byZdrL8ENE1Sr2fdqc4kSTYw
	 fXTub1ZH1IGcKLHMQvTmaaxjSx801wA0VaN8qRrPhe3aYLOJFKwrLTxURnWOsHqeRrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hr4PTcEr;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13551606A31A;
	Fri, 30 Oct 2026 15:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13551606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Hr4PTcEr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793375228; x=1824911228;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0GQpPRwRkvQi5lci0iQEvAZ5avB6N9jjqt94Rp7Pz8=;
  b=Hr4PTcErwWwzWo6yuNvw6U3pguGzLi4rzQGr+/hRMV+9s4NakRHT3541
   dJXRswYMOI4FHpRG9Wi5lM+f9vIsqTjUTWxHL3X5v3D//1M8bW4yvCO8t
   OS0eztG/JWCipxssMfxdhBpmNC1BieNuwokmqX9sXimVt3t6LiZRsDzu7
   6nvmZuJaClhXucvEpbVIjnqfmoT6deAXbKUOl+ObO3a8DBq7lYo4/RgWm
   VVdTyV5KQ/H98bsZ3taCQbWlgXI6BH1uBrLbqhTuTW5R1UMMXwiSY4oHO
   kQ3ra3uDQ4qmtnTJUPgXcrOEAta6xzCPY8JDqBX9V+2f1IzXkhQt78aTD
   A==;
X-CSE-ConnectionGUID: 5iG0N9b/TsSf10zTp53c5g==
X-CSE-MsgGUID: VHWwsZNPSvq1uc9108qi7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2036129"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2036129"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:47:08 -0700
X-CSE-ConnectionGUID: 16oM7Hw+QVOK49sv805iyQ==
X-CSE-MsgGUID: E082+iOkS1qpQHKsd0Tp5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5562639"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 08:47:06 -0700
Message-ID: <0ccdf391-4c38-48c5-bb74-db36e55e800b@intel.com>
Date: Fri, 30 Oct 2026 10:47:05 -0500
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
Subject: Re: [PATCH v9 05/12] KVM: x86/pmu: Support PERF_METRICS MSR in
 mediated vPMU
To: Yosry Ahmed <yosry@kernel.org>, Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-6-zide.chen@intel.com>
 <CAO9r8zOY8W6s5U8O_tZ3dERA4h+mnWWjeS2GDgF=gbo+CQDNLg@mail.gmail.com>
 <e5e719ec-7012-413c-a446-86fd35aca33d@intel.com>
 <CAO9r8zOLCBhWZ5P1BEU24p8++3jVLTPSOdNreBk3RUC10Z79TQ@mail.gmail.com>
 <CALMp9eTOvhiLw7L--DQp_0QaFS=O1TaCQ3q0jPh=70273DA+=w@mail.gmail.com>
 <CAO9r8zM0rTuROCTYdMQhdghDcbYBhfK=ezU_wU2GeM_w7FBPDw@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zM0rTuROCTYdMQhdghDcbYBhfK=ezU_wU2GeM_w7FBPDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/2026 6:32 PM, Yosry Ahmed wrote:
> On Thu, Oct 29, 2026 at 4:26 PM Jim Mattson <jmattson@google.com> wrote:
>>
>> On Thu, Oct 29, 2026 at 4:19 PM Yosry Ahmed <yosry@kernel.org> wrote:
>>>
>>> On Thu, Oct 29, 2026 at 4:17 PM Chen, Zide <zide.chen@intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/29/2026 5:06 PM, Yosry Ahmed wrote:
>>>>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>>>>> index 448044a2b121..f4d3801b97bc 100644
>>>>>> --- a/arch/x86/kvm/pmu.c
>>>>>> +++ b/arch/x86/kvm/pmu.c
>>>>>> @@ -806,9 +806,16 @@ static bool kvm_need_any_pmc_intercept(struct kvm_vcpu *vcpu)
>>>>>>                pmu->nr_arch_fixed_counters != kvm_host_pmu.num_counters_fixed;
>>>>>>  }
>>>>>>
>>>>>> +static bool kvm_need_perf_metrics_intercept(struct kvm_vcpu *vcpu)
>>>>>
>>>>> The name is confusing, this doesn't control the intercept of
>>>>> PERF_METRICS (and it wouldn't be correct to use it for that AFAICT).
>>>>
>>>> Right, these two APIs do not directly determine whether the mentioned
>>>> resources need interception:
>>>>
>>>> kvm_need_any_pmc_intercept()
>>>> kvm_need_perf_metrics_intercept()
>>>
>>> Jim suggested folding kvm_need_perf_metrics_intercept() into
>>> kvm_need_any_pmc_intercept(). The name of kvm_need_any_pmc_intercept()
>>> might be confusing as well, but at least it's one less interface to
>>> worry about?
>>>
>>>>
>>>> This is different from kvm_need_perf_global_ctrl_intercept() and
>>>> kvm_need_rdpmc_intercept().
>>>>
>>>> How about change them to something like these?
>>>>
>>>> kvm_pmu_has_unexposed_pmcs()
>>>> kvm_pmu_has_unexposed_perf_metrics()
>>>>
>>>> Or merge them into one single API? kvm_pmu_has_unexposed_resources()
>>>
>>> I don't like this name any better, but I don't have better
>>> suggestions. Since we already have kvm_need_any_pmc_intercept(), let's
>>> just use it for now?
>>
>> How about kvm_pmu_incomplete_passthrough()?
> 
> Better than kvm_need_any_pmc_intercept() imo.

OK, I can rename it in v3.


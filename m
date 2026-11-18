Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017493;
	b=SgamFnQrMBa8b0o3vXZOJQFwzeaL7aXo7+xnoXB+7e12vxk0q471WNqB8RUzrdlE3nVL
	 4c2hN5ymkx2i6rkPTZtR3ZhrJ0nSsUi1LeY/dBUwauSSoUnJgxBP356r804Cds2jd0XtL
	 satZew1C5JNxb3aqqeA7BGH1DWxWoqnDJPo9o4Vf9fmcJT5KKOqWKAS0220TOPwew8iTe
	 TlSFZR+dLn7oOVeI8wvwCS+/Tijdn7OJFPG2LXRv2jdfknF7eNJvY36B07LX2YmeJBQ8l
	 mmnUjp0SgywOuEA4wxQ3n/tgBZvtiKQhwji79zig2F+BXUUJ39Z1X3WwBKvLRqm4PQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017493;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZfNY41VuY4GG+DxfzrXt++1PaCI072s19lBZNt2S0us=;
	b=ASGfZUJCiWnk7SHJ/RbwbhDSxixxSqHYbAG72eCS+rIEA0Q0PAs3V4BL9saqnoTZKqL6
	 sDPax9AzezyAW4UAZ5nbjvNlu/U7cXQo8syw3efUKtZVFe6BsyG/MCJqLWqQJGnVLvokf
	 ACc59w0h7+EVNiuJJFJ+tVvh3vdJPahD9lmqKZEl3F9j0yQ8kSc67JBFbLGAaZgy+Si2q
	 b/LzOXdJjPKsWkwwJ9I+atIlNfKbvaEls2skLFtXcEnB4imrVS2l+PD0e4obko7OKYc2s
	 /8IdMfJVsgEty5UVbEghZumgcyqtDwrXcwNhpHkePUBzNXEleoDCMoJK26BlhAi06kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A9cOV6Lw;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6425C606A320;
	Wed, 18 Nov 2026 15:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6425C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A9cOV6Lw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017493; x=1826553493;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OMbPF/ioFd9NsURv3tOIi9SdQwquaqo+UJkRfErmrkk=;
  b=A9cOV6Lw0wHyBm7lAPkt/meKDZR70G4+WW8sdPxRVffWnW2kBLiU/3M0
   zeOxL+p5zJnbtGbC3Yj+uS1/iIftnBHz1LbjlbrpIqLyGDbWdYoYhiSN1
   rVp8dJOrhy17psKvTTPRnaOWi3PQFZ7iDeNLPItdo5GDvgvLLRaNd3gDD
   82CoijKZf/FyafbMGldDDlNWbsFnLc37rqxfUxmiokANmbRxE+wytetGM
   hCV3aoIquAheYzYwcyQpvRcm6X00hQZ2LWzGbM6wUiVJfF3zKStt94E18
   gFGUgv7oDbeXzEpE37UN1nsLtCwIJdG+PxI/zEbxkvmY6b8ttH48/Y3Jh
   A==;
X-CSE-ConnectionGUID: J5D1c4gwQPauXgzZZs83pg==
X-CSE-MsgGUID: FUMytS6BQUqLksyW6qBzmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3754820"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3754820"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:58:12 -0800
X-CSE-ConnectionGUID: mVoEB5/DRM+OO4yqM6Z0Tg==
X-CSE-MsgGUID: zCurHgw2SOmP+LTPvAzjRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10083643"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 07:58:10 -0800
Message-ID: <750a0c0f-631e-4c77-b745-06f1d0780924@intel.com>
Date: Wed, 18 Nov 2026 09:58:09 -0600
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
Subject: Re: [PATCH v4 06/21] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261112203227.289379-1-zide.chen@intel.com>
 <20261112203227.289379-7-zide.chen@intel.com>
 <CAO9r8zPD_i2aWc3jaKRr-=1Pz0td=6nqBpgBfVVaV3jfzVTAjw@mail.gmail.com>
 <e090723f-cc02-40c2-af57-ab5dfda91dcc@intel.com>
 <avz4LTEOcubVykim@google.com> <av3IHMi-DiXMk1f3@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <av3IHMi-DiXMk1f3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/2026 9:46 AM, Yosry Ahmed wrote:
> On Wed, Nov 18, 2026 at 12:59:07AM +0000, Yosry Ahmed wrote:
>> On Tue, Nov 17, 2026 at 02:02:08PM -0600, Chen, Zide wrote:
>>>
>>>
>>> On 11/17/2026 11:23 AM, Yosry Ahmed wrote:
>>>>>  static void amd_pmu_init(struct kvm_vcpu *vcpu)
>>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>>> index 136069dfcd44..e21abcedea70 100644
>>>>> --- a/arch/x86/kvm/svm/svm.c
>>>>> +++ b/arch/x86/kvm/svm/svm.c
>>>>> @@ -761,24 +761,21 @@ static void svm_recalc_pmu_msr_intercepts(struct kvm_vcpu *vcpu)
>>>>>  {
>>>>>         bool intercept = !kvm_vcpu_has_mediated_pmu(vcpu);
>>>>>         struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>>>>> +       unsigned long gp_mask = kvm_gp_pmc_mask(pmu);
>>>>>         int i;
>>>>>
>>>>>         if (!enable_mediated_pmu)
>>>>>                 return;
>>>>>
>>>>>         /* Legacy counters are always available for AMD CPUs with a PMU. */
>>>>> -       for (i = 0; i < min(pmu->nr_arch_gp_counters, AMD64_NUM_COUNTERS); i++)
>>>>> +       for (i = 0; i < AMD64_NUM_COUNTERS; i++)
>>>>>                 svm_set_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>>>>> -                                         MSR_TYPE_RW, intercept);
>>>>> +                                         MSR_TYPE_RW, intercept || !test_bit(i, &gp_mask));
>>>>
>>>> This fixes a pre-existing bug that was reported internally, that can
>>>> happen if a malicious VMM reduces the number of counters after
>>>> initiating KVM_RUN but before VM-entry. The current code would fail to
>>>> re-enable the intercept on the counters that become unsupported.
>>>>
>>>> Might be worth splitting this out into a standalone fix.
>>>
>>> My hesitation on a separate patch was to avoid throwaway code churn.
>>> A standalone patch would add:
>>>
>>>         for ( ; i < AMD64_NUM_COUNTERS; i++)
>>>                 svm_enable_intercept_for_msr(vcpu, MSR_K7_PERFCTR0 + i,
>>>                                              MSR_TYPE_RW);
>>>
>>> and then it will be immediately overwritten and collapsed into a single
>>> loop in this patch.
>>>
>>> So basically cleaner logic vs. avoiding immediate churn. I'm happy to
>>> split it out if you prefer.
>>
>> I think it's fine. You can also fix it by using the same loop struct we
>> end up with instead of adding another loop? i.e. loop until
>> AMD64_NUM_COUNTERS and intercept based on i < nr_arch_gp_counters
>> instead of testing the GP mask?
> 
> Thinking about this a bit more, I think having two different loop
> structures might be confusing when they are later changed/dropped. So
> I'd rather do what you suggested initially and add the second loop as a
> standalone fix.

Sounds good, I've split it out as a standalone fix with the second loop
for v5.


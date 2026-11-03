Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793680375;
	b=HpLYXtVJHoKsecL76TFenE7hYAccGHBiQNj1hzKKudtnyv1E6Gu2im8n+mWFo/lV7e5P
	 0Aayt2jomE56QDWhZU8xLVRHF4Ju/sFmlGlYt4r4jaJ/voST5LrbjtBtT0mdA67LXUrxs
	 nL2VeRrodN6S/YXl2qGuJdAEI1ZxVLXEBYl4rD5iT4upANZUxPQ/KPW9bPHc8oQNNY4aO
	 VfQ4mGKJO4O7L7upOm4KxvPguJ+aVdQdO61RKTRLGo6pM8rTOL76jHSxH5daS7GNnOE69
	 bfA+hFBJSh+p5Qs1rCYPGzfngqIm3oPOk/cF1HDyd7XqJXze2WAOV07uFUX6B4oCQgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793680375;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=19q9vzigX8jqYcPqoOoX69jW3y9J00k0rPbllW25cAw=;
	b=l/Gb/FkO3POChytys2mE3BOnKwX3WvlmmcZ6JhjqGXJFtzxdi7jkMkRSjfFJ+MamqSSx
	 fstSW5hT0CKRzWy6UaRbuVN9KdLpPh0428FNjeCDX3WKtyoV823rsB09MnZk9zswF1Klg
	 hdwMTu0tD0AFAlE9l4N36kva+Fo/JzFFUMliXGT+QO8YG1jf5ZMeWtdsjvGBdAmlyK/C6
	 82S/D6tgKWqxt+ghvWkB4YPPQR/zZQSOTmDlQf/PgbRpQVu2DdzetEzZ17IOL/Sg6Ub2g
	 qqpVaWk8wKB5zJRs+2ZtB1F1pklRewiu1DRKoX7031fPwHd1lm5rZ/1fVl5aPSbucaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PysSDeQb;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC143606A326;
	Tue,  3 Nov 2026 04:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC143606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PysSDeQb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793680373; x=1825216373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQbiMKS8DDpnCaGekHAZjggNEETizZpIkdral2UW2Fw=;
  b=PysSDeQbtwQEy41UlTj5MqrxdgHkg3n04BFWJeiz4iP3as/uThteoGxO
   BfbX+pj/3LyaFnw1awSMx5XyEC7jrOIcIRsev6Gd4iQT9eB8ZzxJPrLNj
   knrHbZQnniHw14jW7bU3EP/HgPEBbDPUS1ywxMvA0jRI7u/aVkveaZyZJ
   XOTFFcYBRfCJBOOcMlaX4kgvI7WPsgU7sBsjTrWR7ZwUSapHphrsz7PjW
   lfFXhbtsNguBd3gcfxdALK90fYVOh8jIOcs5mc44EZ3MigRFvAoNWa6L7
   4PzHT8HzD2QLppV1ovK6slvfAWLXwvcfAicy278N7/z0RVU25A+L1HZru
   Q==;
X-CSE-ConnectionGUID: OOhEo8p/Qj2+K0ZE3Ha3VA==
X-CSE-MsgGUID: 5OsSXU0eS5CNU02GPaqnoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2271062"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2271062"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 20:32:53 -0800
X-CSE-ConnectionGUID: 7LdIg2GCQO2tyEEivUKyJg==
X-CSE-MsgGUID: ihSsea4lSLmeG2p6tjmzAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6314625"
Received: from jstevens-mobl.amr.corp.intel.com (HELO [10.246.165.69]) ([10.246.165.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 20:32:52 -0800
Message-ID: <5051866d-ff33-4b09-a4d0-756f305f5154@intel.com>
Date: Mon, 2 Nov 2026 22:32:51 -0600
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
 <6d84ab57-a702-4ac0-9e29-579449b3d826@intel.com>
 <CAO9r8zMvkGzxUR7jBPVFWK+Fry4wk49J3WdwFqa22bSgGaS4YQ@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zMvkGzxUR7jBPVFWK+Fry4wk49J3WdwFqa22bSgGaS4YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/2026 5:37 PM, Yosry Ahmed wrote:
>>>> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
>>>> index 38c7a4fa1007..3849b3f5234a 100644
>>>> --- a/arch/x86/kvm/pmu.c
>>>> +++ b/arch/x86/kvm/pmu.c
>>>> @@ -862,6 +862,8 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct
>>>> msr_data *msr_info)
>>>>         switch (msr) {
>>>>         case MSR_CORE_PERF_GLOBAL_STATUS:
>>>>         case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
>>>> +               if (msr_info->host_initiated)
>>>> +                       pmu->global_status &= ~pmu->global_status_rsvd;
>>>>
>>>> The underlying issue still requires proper mutual exclusion between
>>>> Intel PT and mediated vPMU, which I think can be addressed separately.
>>>
>>> Or maybe handle the host PT while the guest is running? Not sure if
>>> that would be correct.
>>
>> Since KVM switches APIC LVTPC in guest context, it seems difficult to
>> correctly handle host PT PMIs while the guest is running.
> 
> One hacky way to do it is to make perf_guest_handle_mediated_pmi()
> handle host PT before calling into KVM. This doesn't completely stop
> the guest from seeing the bit tho. Also, I think we may have no way of
> finding out if we still need to inject a PMI into the guest for a
> different reason or not :/

Right, and the host perf subsystem doesn't know which GLOBAL_STATUS bits
it is supposed to handle.

The hardware-assisted perfmon_mask solution seems like a clean way to
avoid this problem. :)

And I think if Intel PT virtualization is re-enabled at some point,
addressing the mutual exclusion issue would probably be necessary
regardless.

>>
>> I guess Intel PT virtualization could be re-enabled sooner or later, and
>> addressing the exclusion issue would be a must at that point anyway.


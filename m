Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388320;
	b=RDnQkqzxe97nueUvy9j2aTzI/FSK48s9xLqx3xKEJM8kLzb2UN9PLv4hXUxVlRxGqge8
	 1+g4fyojBEoa9zO0MSeUl2yDm4oaNI036d7GCp1ssh1IZXgAXSGF7Zm7xm3BW3YHEgyN5
	 0YONL/izcWJtG/7lTECvCZagrqqbbZ5MD6W+hUg+1wtGS4GXZ0vBWYPE/2xTsfVo13s3/
	 LqMha6Uyz3wlyvg1174gNoO7auQiwfBi0/o07z0LTX4OIYba5hHB8/SXvJK9xi2vlEuPm
	 QmW11XdLaTEtqI+MThXz9AFefVCCuKtnbcjgowh/ulLsOWIC3xZDd5pT8Sg7dlcgdQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388320;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Yf0r59h/rQ7dgSv/KaJ4S+8p0+oxyog5F51pLcnO+dc=;
	b=Otc/52H2pM4FuWHzJ7fvu7Kfs+mszg40A+8CiFo0N5F8W9YTip68ZQuYqjLr8VYTr5qt
	 cDOAZ28kHdhs0xmu2cyZNC08IM8cm1jaLQYnOn9L7C6/RzAqZF2gjSflM+n/UcUhTkEgU
	 Rk2iSEe9qIq2d1I7XC+WJge168Zlit0wRuFkpS1W8qNSSma5Ij9MXan4lLBo8XNowIqtt
	 qXMSKNyopyB924MpqGvekXSEkBqN6Vjwk8sZTnXMA94vsix5sU5lUkAsfsuntXvJWMRT+
	 wOoeTEFPsVlap+XFarXREI744YOSH3lXccxIYRw+MOaJyjAzz8yW5reGyrzUpigeovw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LCTRu9VX;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D5606A31A;
	Fri, 30 Oct 2026 19:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 854D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LCTRu9VX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793388319; x=1824924319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KbVK3KH4BybtnxV7XDRH86tuErlmKMHSpbbdZGxJ4ic=;
  b=LCTRu9VXGN824RvIKF2XXelVNCc6ytaqM+ZlQRXRfstZjdC+Am5lBKpp
   RkRSYDDhtX1ijP0pq6OtQyRVV0wcgU1EMNLKpW3yFl61LNaJvKGFkuimn
   BLsh8eDqsYRgM9JVorkF7RxaFQrBBD3jfWXZZ54qhSatRSCXM7xuAr32O
   DRGi+bb5kLWW8T262sN+YeZ3dBBLMWb7x4xv9K38F1HWmYu9P/O0fWWWs
   HCvFs5Vypa52w18YSoOvAD5a/sz2Mlsd3R5op5WhDUSRH/eAmEDMNt0BO
   KxfvBLp478QqNGhU7JjKGTBkRJltD8gO77bWp+94qTqeMaJ9kiYv1Oy2i
   Q==;
X-CSE-ConnectionGUID: cRvWyh/ZSAKZZKFoysGMAw==
X-CSE-MsgGUID: Xfz4Yu28TbyO3xkomHETcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2037490"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2037490"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 12:25:18 -0700
X-CSE-ConnectionGUID: JC+iRR6ETdaP/GymM482Qw==
X-CSE-MsgGUID: 70/FtxXTRQ6dWFVPvvumhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7350462"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 12:25:16 -0700
Message-ID: <897ffd39-a64b-4f77-a688-b8490d07980a@intel.com>
Date: Fri, 30 Oct 2026 14:25:14 -0500
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
 <20261023182743.3248481-1-jmattson@google.com>
 <98ed42e6-8c10-40f1-affa-2333188572bb@intel.com>
 <CAO9r8zNO6X2-LDx_3n44Uc+9ODtXoH7oLvn8i5yzAa+EUy_qxg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CAO9r8zNO6X2-LDx_3n44Uc+9ODtXoH7oLvn8i5yzAa+EUy_qxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/2026 4:28 PM, Yosry Ahmed wrote:
> On Tue, Oct 27, 2026 at 2:31 PM Chen, Zide <zide.chen@intel.com> wrote:
>>
>>
>>
>> On 10/23/2026 1:27 PM, Jim Mattson wrote:
>>> On Fri, Sep 18, 2026 at 12:39 PM Zide Chen <zide.chen@intel.com> wrote:
>>>>
>>>> +static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    return kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS;
>>>> +}
>>>
>>> The SDM, volume 3, section 22.3.9.3, says:
>>>
>>>> IA32_PERF_GLOBAL_CTRL. EN_PERF_METRICS[48]: If this bit is set *and*
>>>> fixed-function performance-monitoring counter 3 is enabled, built-in
>>>> performance metrics are enabled. [emphasis mine]
>>>
>>> and
>>>
>>>> The values in MSR_PERF_METRICS are derived from fixed-function
>>>> performance-monitoring counter 3.
>>>
>>> Hence, a dependency on fixed counter 3 belongs in this predicate.
>>> Perhaps something like:
>>>
>>>       static inline bool kvm_pmu_has_fixed_counter(struct kvm_pmu *pmu,
>>>                                                    unsigned int idx)
>>>       {
>>>               return idx < pmu->nr_arch_fixed_counters;
>>>       }
>>>
>>>       static inline bool kvm_vcpu_has_perf_metrics(struct kvm_vcpu *vcpu)
>>>       {
>>>               return (kvm_vcpu_get_perf_caps(vcpu) & PERF_CAP_PERF_METRICS) &&
>>>                      kvm_pmu_has_fixed_counter(vcpu_to_pmu(vcpu),
>>>                                                INTEL_PMC_IDX_FIXED_SLOTS -
>>>                                                INTEL_PMC_IDX_FIXED);
>>>       }
>>>
>>> with intel_pmu_refresh() calling kvm_vcpu_has_perf_metrics() instead of
>>> testing perf_capabilities directly. (nr_arch_fixed_counters has already
>>> been computed at that point; all_valid_pmc_idx has not.)
>>
>> Thanks for the detailed analysis. That makes total sense.
>>
>> Initially I didn't gate PERF_METRICS on fixed counter 3 out of concern
>> about policing userspace configurations. Additionally, as in the quoted
>> SDM text above, it means PERF_METRICS can't function without fixed
>> counter 3, but strictly speaking, the SDM doesn't prevent other
>> operations, for example, writing the METRICS_CLEAR_EN bit.
>>
>> But having IA32_PERF_CAPABILITIES[15] set in the absence of FC3 is not
>> going to happen natively, so I think it doesn't break any rules if KVM
>> chooses to gate PERF_METRICS on FC3. And as you pointed out, it's a
>> simple and effective way to protect KVM invariants and migration integrity.
>>
>> I will add the FC3 check to kvm_vcpu_has_perf_metrics().
> 
> If userspace sets IA32_PERF_CAPABILITIES[15] but not FC3 (for some
> reason), I think architecturally it should still be valid to
> read/write PERF_METRICS. KVM disallowing access to PERF_METRICS while
> IA32_PERF_CAPABILITIES[15] is set would not be correct
> architecturally, right?

Right. Per SDM 22.8, MSR_PERF_METRICS is available as long as
IA32_PERF_CAPABILITIES[15] is set, so disallowing access to it when bit
15 is exposed seems architecturally incorrect. However, TMA metrics
cannot be enabled or computed without FC3 (SDM 22.3.9.3).

Instead of gating kvm_vcpu_has_perf_metrics() on FC3, seems it's better
off to do some changes to fix the invariants where they belong:
1. Untie FC3 from kvm_vcpu_has_perf_metrics() so the MSR remains accessible.
2. In intel_pmu_refresh(), compute perf_metrics_rsvd before the PMU v1
early return so save/restore works properly.
3. Explicitly check for FC3 when unmasking GLOBAL_CTRL[48] (TMA enable)
and FIXED_CTR_CTRL[14] (METRICS_CLEAR_EN), and guard pmc in RDPMC emulation.

This seems satisfy the SDM while keeping migration and invariants intact.

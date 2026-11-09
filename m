Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264160;
	b=3PDhCEQc1am2MiuogohH2mgPvBl8FQEIUj98UAZN5NrniVwOj6WgbLrHbKuFxbXqJUy7
	 a15p6FQMmBsEwbDC48ifZfWS3CTc8OraEN0Gfu3zWorkVm2UT/WCideaIVhHmxQXHb6li
	 yh26FEEic5b3Q0LKBdyr/zf6ymvf0R4LWX5IFRkQupiF+ZsBOqaxbmEI84dwgYOjrdmS3
	 23PyGRcvOt3f9SXceEYU83hEEKOSydp5wHadth2v7WfjArFtXjEYhw0xW02nu9H6dDYgB
	 ZrJsU7wiYxPxktqy9c3GKdKt9wltALyW500fIVAtlfo5Tgrt41jM0LukK5auhgxpvoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264160;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=dDQGMloFqhGszUXg8zBfvfmPvBGFlp5yEqefjMt1g4o=;
	b=OHuj4na8aOlKbsttga8acbSbNhpbu52sPsr0/OHHU2p7Fh3Eqz1gM/SV9T0aVf24Oh1H
	 gbyohxHK7C176Wa5HmcdcujlcpdUtjbAshcpsgY8cQfOR6SEuUNv1L81B1z5+KJTRtcwC
	 DzTl0YhsMueX3lsBrxNBo03PkulqfWOta2fd5/oTqG4CAWfHGRnogoN7tcALWkBpXE0Fx
	 9PfdOKOtQLgjRnl/VQhcN04E2TW9yi9yRQlUGpGW/29dAQcI4ZMTlkccTDmeWOz+HokGA
	 lvaVc2QIlfMgQS+S3eUb6fjD6vDTdRSFSwmh+f5BFOz67PV9MEXPXphJU9sV+7K70Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rid7lsLY;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF72606A31C;
	Mon,  9 Nov 2026 22:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF72606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rid7lsLY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794264160; x=1825800160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=II0Mw9gEmKdJ5j2EJO6fzIaeB2fV+lSTP1+PoTxy5gA=;
  b=Rid7lsLYz7qYKVH0BXT7DCg1ZhGqIYGIeR9q5447KcxL/JV/QJRkn0KM
   XzuMttMyLKXjBh0UJYTVimvffCJ/eihyRFY8nXiErRca4pyv9cKuoRY/b
   VGlkX90c7sgnSWVYuk7zD/L5aMUx/bjA+kmdY4AFszTUqdIgH3Y1+iDKI
   lfOPp9La7sjOUaYWVMxAoyyr2NDkV8felD1EsdDKZsqNti6u3iLZxdMaN
   9G4dtCtKeYPxZXXD/UCIbWT6oVVx/L8vE4KvwwPHcTWA8pSRtxvE3dmNp
   P1weaAWIXuuG7UTRpS3bZV4eYyDbj5Fb3wkvi2og8XQ2g7rhvCi/3LffP
   A==;
X-CSE-ConnectionGUID: nvirPBlMS2S+SCl/Bjq3rg==
X-CSE-MsgGUID: nnAZx0nWSNaOFkMSR+fPqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2886136"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2886136"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:42:22 -0800
X-CSE-ConnectionGUID: 78o+vWRkRTOvFdGKM+lcZA==
X-CSE-MsgGUID: /Hc1B200R0OijwvXW8BMhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7871959"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:42:21 -0800
Message-ID: <6ba5f5ae-6fd6-4c7d-ad7d-9a3c439cdbb0@intel.com>
Date: Mon, 9 Nov 2026 16:42:19 -0600
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
Subject: Re: [PATCH v3 05/18] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Jim Mattson <jmattson@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-6-zide.chen@intel.com> <au4pSeg5AcHEbfDv@google.com>
 <CALMp9eQZQ7-cGgmssAn5xd5hd7Yqi7fzFJVrTawJpdxZBS4Btg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eQZQ7-cGgmssAn5xd5hd7Yqi7fzFJVrTawJpdxZBS4Btg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/6/2026 6:42 PM, Jim Mattson wrote:
> On Fri, Nov 6, 2026 at 11:34 AM Yosry Ahmed <yosry@kernel.org> wrote:
>>
>>> @@ -979,8 +979,6 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>>>       kvm_pmu_reset(vcpu);
>>>
>>>       pmu->version = 0;
>>> -     pmu->nr_arch_gp_counters = 0;
>>> -     pmu->nr_arch_fixed_counters = 0;
>>>       pmu->counter_bitmask[KVM_PMC_GP] = 0;
>>>       pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
>>>       /*
>>> @@ -1008,16 +1006,12 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>>>        * in the global controls).  Emulate that behavior when refreshing the
>>>        * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
>>>        */
>>> -     if (pmu->nr_arch_gp_counters &&
>>> +     if (kvm_gp_pmc_mask(pmu) &&
>>>           (kvm_pmu_has_perf_global_ctrl(pmu) || kvm_vcpu_has_mediated_pmu(vcpu)))
>>> -             pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);
>>> +             pmu->global_ctrl = kvm_gp_pmc_mask(pmu);
>>>
>>>       if (kvm_vcpu_has_mediated_pmu(vcpu))
>>>               kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
>>> -
>>> -     bitmap_set(pmu->pmc_exists, 0, pmu->nr_arch_gp_counters);
>>> -     bitmap_set(pmu->pmc_exists, KVM_FIXED_PMC_BASE_IDX,
>>> -                pmu->nr_arch_fixed_counters);
>>
>> I understand the vendor modules are responsible of initializing this
>> now, but should we clear it before calling into the vendors like other
>> fields above?
> 
> pmc_exists is zeroed further up in kvm_pmu_refresh. See patch 02/18.
> 
> [..]
> 
>>> @@ -117,7 +116,7 @@ static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>>>               return pmu->version > 1;
>>>       default:
>>>               if (msr > MSR_F15H_PERF_CTR5 &&
>>> -                 msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
>>> +                 msr < MSR_F15H_PERF_CTL0 + 2 * hweight_long(kvm_gp_pmc_mask(pmu)))
>>
>> This assumes the MSRs are contiguous, which IIUC is always true, but I
>> wonder if it should also be handled since the series claims to also
>> prepare for discontiguous GP counters.
> 
> Actually, since KVM_MAX_NR_AMD_GP_COUNTERS is 6 and MSR_F15H_PERF_CTR5
> is MSR_F15H_PERF_CTL0 + 11, this condition is always false today,
> rendering the default case dead code. What situation is this intended
> to address?

This was carried over from commit 4a2771895ca6 ("KVM: x86/svm/pmu: Add
AMD PerfMonV2 support"). My best guess is that it anticipated supporting
>6 core counters under PerfMonV2 (since CPUID 0x80000022 EBX[3:0] allows
up to 16).

Should we remove this dead code for now (as a small, separate patch) and
add it back when KVM_MAX_NR_AMD_GP_COUNTERS is expanded?


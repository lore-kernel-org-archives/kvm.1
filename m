Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793207078;
	b=AwU60rXZw2+ycNbjRK9M/3vGvNxGyDIiMIc/6yIK+HjS2ptBzZqpGdW54hyZcDX59aJL
	 E55qVE9ofZifR2wJh2L9X+zCKECBPGLzc6gnXg0l0lMTT4kWmIxVUX0t2Psjv7EvFesFm
	 LEaqexFwaMZXNUUP+JBkfHko2EfmUDQyKWdpcn4EEwkOAZqLIA5aXnnzUiO9mRWxuiPXs
	 w3tl85bijNe0or+WqCOzhXdFI5ehnmK1DdKVeyc3gFCGdS2ulGzPqA0lE1tjvLlXzb/db
	 yh77KwfKsFMtsI28BX0y37ehu320FAYu82kV1WOvH+II31Gomm1pbBNN+ZL/ou+SixA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793207078;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7u6epdxCRzzqEJ+g4x5/I9qZne8VNQ2rvwh6ewHJxGI=;
	b=3mPwWTWmBLguyJb5J7eh1jHuQmjVe/y3dIqL7I8AtSk64C4yfJEmhOX3hBx68OBkqh99
	 i94VV/75BPIJAJo4z4iX9yoUT/KR6Pv5jDt8W4ndBhcnqS+/HqEkY3TWv2Id9S+egomhS
	 AKWhjPTZRRgfivwCC5rZdnwZ9O+qIeECpJWcE6aIHWz5DQElVch35wWIRoX7/ELNVodcW
	 VlRLQUiSDiAGmoKjlS6sEjVWkF8VNSdRBTb9hKB0iEMhIQIdn2ZhEiCYOzkAJIMd1CGTM
	 KVDqzD3Z81DJXE+EZvF7ZQDFah5nCGfN4KQz8LthyKqaX1YuV9KDNwbdAoJBL9cpX7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MlznExYP;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59498606A325;
	Wed, 28 Oct 2026 17:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59498606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MlznExYP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793207077; x=1824743077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yRZrXN5GFxu0MlVfZUZ1S2TnnWoC/2UKZVvWM7X82eI=;
  b=MlznExYP77RB4nWVn5sPTgMZh0UkwEoj9ksI0NTu/cJeeUcqx0Q4AufG
   f80vAIotXcT3EzSMoaJub7AwwB+VYCaddm7PgLBQ0h480oLeuG/zfg+CR
   qdZZzMoni327hEdx08OXO+X7Tqnpv6lYKLhqTiyN8oa1VwHD2LnyfOAYL
   BPPDRBTQwPsmDdL93s2TIwCzHVRsJMop2qJoeGWvoIyZIoalmLcfhX2p9
   1/G7ykjABmh05za9yknbex6usULLzc94v1nngvZD1Ns69uIFeOQpsOGbO
   ayEVtsWELBKG4tJKHJBdwYguYOwTr/Fo7jzEa259oueVWpdB9wbHy7kYd
   g==;
X-CSE-ConnectionGUID: /bPWuVF7SBilUVRJhdf1lA==
X-CSE-MsgGUID: +V2ppeJyT+u8pVv7XMZZow==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1960817"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1960817"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 10:04:37 -0700
X-CSE-ConnectionGUID: Y6g6Vhd3Rgq8j2C7yOtevw==
X-CSE-MsgGUID: Kyp+cRjATfeEe3pQkwugcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="4953324"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 10:04:36 -0700
Message-ID: <dbe6599b-2eb0-474d-b4ce-370b0adc4b28@intel.com>
Date: Wed, 28 Oct 2026 12:04:35 -0500
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
Subject: Re: [PATCH v2 06/16] KVM: x86/pmu: Drop nr_arch_{gp,fixed}_counters
 from kvm_pmu
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>,
 Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi
 <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-7-zide.chen@intel.com>
 <CALMp9eQ2D2BjX8ZNqRuNp9h46Rw-_7pJD=50JAXbNHf5KEVj2A@mail.gmail.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <CALMp9eQ2D2BjX8ZNqRuNp9h46Rw-_7pJD=50JAXbNHf5KEVj2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/28/2026 9:49 AM, Jim Mattson wrote:
> On Thu, Aug 27, 2026 at 3:48 PM Zide Chen <zide.chen@intel.com> wrote:
>>
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> This is a preparatory step toward fully bitmap-based PMU capability
>> handling. Later patches switch KVM's view of host PMU capabilities from
>> counter counts to counter bitmaps.
>>
>> Populate and use pmc_exists directly when walking guest-visible PMCs,
>> instead of relying on pmu->nr_arch_{gp,fixed}_counters as intermediate
>> state.
>>
>> Iterate counters via the newly added pmc_exists based helpers, and
>> remove the now-redundant nr_arch_{gp,fixed}_counters fields from struct
>> kvm_pmu.
>>
>> Note: {vmx,svm}_recalc_pmu_msr_intercepts() may leave stale intercepts
>> on GP MSRs after CPUID narrowing. This corner case is resolved by the
>> following patch: "KVM: x86/pmu: Switch to bitmask-based KVM PMU
>> capabilities".
> 
> Are you saying that you are deliberately breaking bisection?!? Shame on you!

Yeah, I feel bad about this... the other solution could be to
temporarily use for_each_clear_bit().

-       for ( ; i < kvm_pmu_cap.num_counters_gp; i++) {
+       for_each_clear_bit(i, &gp_mask, kvm_pmu_cap.num_counters_gp) {
                vmx_set_intercept_for_msr(vcpu, MSR_IA32_PERFCTR0 + i,
                                          MSR_TYPE_RW, true);

And then remove for_each_clear_bit() in the coming patch when
kvm_pmu_cap.num_counters_gp is dropped:

-       for_each_clear_bit(i, &gp_mask, kvm_pmu_cap.num_counters_gp) {

+       host_only_gp_mask = kvm_host_pmu.cntr_mask64 & ~gp_mask;
+       for_each_set_bit(i, &host_only_gp_mask, INTEL_PMC_MAX_GENERIC) {

>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Co-developed-by: Zide Chen <zide.chen@intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2:
>> - Fix AMD legacy PMU MSR intercept handling for guest PMU
>>   narrowing reconfiguration by adding for_each_clear_bit_from().
>> - Re-word the stale interception changelog part.
>> ---
> [ ... ]
>> -       for (i = 0; i < pmu->nr_arch_fixed_counters; i++)
>> +       kvm_for_each_fixed_counter(i, fixed_mask)
>>                 vmx_set_intercept_for_msr(vcpu, MSR_CORE_PERF_FIXED_CTR0 + i,
>>                                           MSR_TYPE_RW, intercept);
>>         for ( ; i < kvm_pmu_cap.num_counters_fixed; i++)
> 
> Doesn't this potentially leave stale intercepts on FC MSRs after CPUID
> narrowing as well?

Yes.

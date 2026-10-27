Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793137158;
	b=h0aB7coxzakjqtWVfKyvf52UCtg9aj7L8LeKHxXHIdafEvR+gWLKH1VAYBlXKY4BVof7
	 bk8lmkAsdenExIWPWDEhantGLdUrxLS6YICWOqTHH+/pJVouNIp3OteaINVoy9G4wk8PE
	 CD/1raqCqMQrxkK0l1NFaaDPXpmF9yqsvMptfQrJkf3hhXPKiVms2DAHGoRFzkd4hizzC
	 HKxuKeByHv384BuqIGZM7qXLlzs8Pon0J4sFykhRsBtnpxNI5YOtV2pdh9eSNc1sSOoJN
	 5VubECjsYQ3m9Tg9Kmz/EvI1pASAFgbit2f8AVVZGp/unFK0cwzPXrqQf0lHfFARY7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793137158;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=j5221omMActoQkDHF4RaC0GAmHgj+tP1MLFSio0coJk=;
	b=eGbuPpLeyWlzpHpwFY+BhU3oU1FEpOv7XUQZmuxM2kDtCBxX2PajgEkDfsDfiC54623/
	 wVA3EgrWsqqWYfQ1F8MRBiuCWVzH0UJfdkezQwpK98YDGxmt0K9Y9Jx9TJq5+VyKTN4bm
	 bggezPGw0vI0dtt0R1nwYU2pyjLqi5B8OVychROBrv0/tv1J6YRhVMup1CjZJjKwe59gn
	 75Zybna3NLybmjOS7J87yl3I+G2VAdNRu4J020ouBUkIXMeL3DuQBe5ToOwM+KIWmdA4c
	 1y6N4efeLQL0+th7b1yXX9Pg3Ca0vbt97n+/fXx0v/R7yWND3G+VvjsGPwxvoOIE/lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NwaEJJmF;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6C606A31A;
	Tue, 27 Oct 2026 21:39:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CF6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NwaEJJmF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793137158; x=1824673158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P3oWki5m/mrnhxYk4sKgWwU2lL7VHJaW83IqKWGyeZ8=;
  b=NwaEJJmFosqo/zkGFhz01KFbGzrE/6aQwxPLmnm6BllRl8No9Iy5H10F
   lOPnQLjtP+X9Bb1ew0iVOClmvjfppEVwAE4b6BJaHXdHwxLL6u/hfauqr
   IDThu7sgpXxtDIAXrnu6olGgiYFyW5tdkSVC04oLDcCW/jjcHfXyRdvon
   axw1QXMplMuAOZeteSfa4oMyexS6+jnax/6ns31xlHbae4aFOTsZYXyOl
   cO7mAYwDPGRd58XiIO25p8LIbOB2lQobwp6tzKdM/Fv/BgbX/5Fswcfjp
   gWNW7A4+zNav2PlbMku5JrfV4z1bdKLRikRnL6A6NNfa7Li+SHLpb3ebg
   Q==;
X-CSE-ConnectionGUID: iKHRHyCTQASHDxfWuyxOpw==
X-CSE-MsgGUID: Ecx7FvysSjGLM+GDhv1CKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1728479"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1728479"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:39:17 -0700
X-CSE-ConnectionGUID: O8xsiCs+QVCwPruINTCAAg==
X-CSE-MsgGUID: cVpPdMFAQ2C3Gc3y+/WugQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4755535"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 14:39:16 -0700
Message-ID: <8bb51068-461d-4eba-8e4c-0adf35a80839@intel.com>
Date: Tue, 27 Oct 2026 16:39:16 -0500
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
Subject: Re: [PATCH v9 09/12] perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK}
 constants
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-10-zide.chen@intel.com>
 <b73ffa7d-29ce-44b3-be1c-88068fc2f443@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <b73ffa7d-29ce-44b3-be1c-88068fc2f443@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/21/2026 2:01 AM, Mi, Dapeng wrote:
> 
> On 9/19/2026 3:39 AM, Zide Chen wrote:
>> Replace the hard coded field width (8) and the equivalent 0xff mask
>> used for PERF_METRICS MSR field access with named constants
>> INTEL_TD_METRIC_FIELD_{BITS,MASK}.
>>
>> INTEL_TD_METRIC_FIELD_BITS will be used by a subsequent KVM patch to
>> validat reserved bits in the PERF_METRICS MSR.
>>
>> No functional change intended.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> ---
>> v9: new patch.
>> ---
>>  arch/x86/events/intel/core.c      | 8 +++++---
>>  arch/x86/include/asm/perf_event.h | 4 ++++
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index cc13164d948f..cbc9a179f2e5 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3159,6 +3159,7 @@ DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period
>>  
>>  static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
>>  {
>> +	int shift = (idx - INTEL_PMC_IDX_METRIC_BASE) * INTEL_TD_METRIC_FIELD_BITS;
>>  	u32 val;
>>  
>>  	/*
>> @@ -3166,8 +3167,8 @@ static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
>>  	 * summing up to 0xff.
>>  	 * slots-in-metric = (Metric / 0xff) * slots
>>  	 */
>> -	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
>> -	return  mul_u64_u32_div(slots, val, 0xff);
>> +	val = (metric >> shift) & INTEL_TD_METRIC_FIELD_MASK;
>> +	return mul_u64_u32_div(slots, val, INTEL_TD_METRIC_FIELD_MASK);
>>  }
>>  
>>  static u64 icl_get_topdown_value(struct perf_event *event,
>> @@ -4742,7 +4743,8 @@ static int core_pmu_hw_config(struct perf_event *event)
>>  }
>>  
>>  #define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
>> -					 ((x86_pmu.num_topdown_events - 1) << 8))
>> +					 ((x86_pmu.num_topdown_events - 1) << \
>> +					  INTEL_TD_METRIC_FIELD_BITS))
> 
> Sashiko comments,
> 
> "
> 
> Is it safe to replace the UMASK shift here with the hardware MSR metric
> field width?
> The original << 8 was used to shift the metric ID into the UMASK field
> (bits 8-15) of the software perf event configuration (attr.config).
> INTEL_TD_METRIC_FIELD_BITS represents the hardware width of metrics within
> the PERF_METRICS MSR.
> When evaluated in is_available_metric_event() during perf_event_open(), this
> currently functions because both values are 8. However, conflating a software
> API layout offset with a hardware register field width could cause this macro
> to calculate an invalid configuration mask if the MSR field width changes in
> future hardware.
> 
> "
> 
> It looks reasonable, we either don't change this, or define a macro to
> represent the UMASK shift. Thanks.

Yes, I can revert this change.

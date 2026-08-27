Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82593290A5;
	Thu, 27 Aug 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787871688; cv=none; b=UZmFvEM83LEWtxhKs7PI7oTdmxT2mbRzfOUHgqWRRe7XYVl8OIArUrbBUV3PMn3wCsySLnSiRliiV9iQ/JYKpYYqPtDYV6rVvkdz1E64l4G5MgIpmQ4UFN4UgR35zIRNAFGaMB797iD1n8Sv4dFO60b+cud80fNj/+avYKDcc9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787871688; c=relaxed/simple;
	bh=fMQcW1aexhi5Ay/MHORDdn9i9uBYSep6pWh9b1WOvVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUO9h6opKRc7EgJhs+B/HlxFe5xNX/+4kOrW3xLe9/jsIbIFZkmrMkb0paGeBJXl7OPnwV5XlTHYUfPoH1UoEj/l+HugENzU+pFlcFjVtm7UYKvCszQWpGWn4NS2rHC/Sk1vcEZ8VyuqFpGFGoLtD6G9eXfXxbZvX4b8Z26wyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJs0Sql5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJs0Sql5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787871687; x=1819407687;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fMQcW1aexhi5Ay/MHORDdn9i9uBYSep6pWh9b1WOvVk=;
  b=eJs0Sql5oFkTR6670FaDdxRDeWS44GVcHG+C8bnpVZjhKwa95DeACjBu
   TxsOkeDJU8p388Zh116n84C/tWhahVbc5VxBo/1XMJJCZ5vTRgI1uUF/0
   riqXiyo1hWmtvCDy6itI33hGJa48xQtMUa7d2CJWZWXsCSNLO55OGQdsz
   xCd7Ipjw8YYEvb5Wr77NkA3VXHlfTLi0HuuZ7ShNKBCT7SXnCsciueWZO
   gcOM2cPfIu3fkynW6QAYdm3ZbKIVZLm3LQv1FQEfy5El7d7gR4I5R3/i2
   kXvUd6zHn/dqqH80SQh4WuDN7kqSZvASWwKPlQGxeC4i1LIvkWXyclIsT
   g==;
X-CSE-ConnectionGUID: qJITEVQOQd+bC6YugjkNKA==
X-CSE-MsgGUID: yBm4jRkGRLiKnHvCNSPa3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="92196900"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="92196900"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 16:01:26 -0700
X-CSE-ConnectionGUID: QTZI9P9xTcWcyTCTN9gbCA==
X-CSE-MsgGUID: KEFD47NUQrqekknRYndBkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="272218861"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 16:01:26 -0700
Message-ID: <efb6f286-97da-4d5f-955b-29310d99d478@intel.com>
Date: Thu, 27 Aug 2026 18:01:24 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/23] perf/x86: Apply PMU partition mask on static
 constraints
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
 <20260821222002.54907-8-zide.chen@intel.com>
 <09251cc4-c795-411c-a9d9-9133a0d73e03@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <09251cc4-c795-411c-a9d9-9133a0d73e03@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/26/2026 3:12 AM, Mi, Dapeng wrote:
> It seems not a good practice for me to modify all the places calling these
> static constraints. We could have to add new get_event_constraints()
> helpers for future platforms, and we have to duplicate these
> part_constraint() code.
> Could we leverage the dynamic constraint mechanism?  We can set the
> event->hw.dyn_constraint to be host counters mask, then we don't need any
> specific change for these static constraints.

In all code paths that use these static constraints, for example,
counter0_constraint, it is assumed that GP counter 0 is available on the
host. However, with PMU partitioning, any counter may be unavailable,
even in the model-specific code path, and this assumption is broken.

So, adding a wrapper seems unavoidable.

Additionally, part_constraint() already makes use of dyn_constraint, right?

> Thanks.
> 
> On 8/22/2026 6:19 AM, Zide Chen wrote:
>> Static, counter-specific constraints used for attr.precise_ip == 3, or
>> other special cases bypass intel_get_event_constraints(), which is
>> where partition_mask is applied via dyn_constraint().
>>
>> As a result, such a host !exclude_guest event can still be scheduled
>> onto a counter that partition_mask reserves for the guest, causing
>> host and guest to share the same hardware counter.
>>
>> Some of these static constraint paths, e.g. glp or cmt, are currently
>> only reachable on platforms that don't support PerfMon masking. Still,
>> apply part_constraint() to all of them uniformly, so future platforms
>> that combine PerfMon masking with these constraint paths are not
>> silently exposed to this bug.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 7951accfcf2c..0f76e56fd2db 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4459,6 +4459,9 @@ dyn_constraint(struct cpu_hw_events *cpuc, struct event_constraint *c, int idx)
>>   * Mask out guest-owned counters from a constraint when PMU partition has been
>>   * entered, so !exclude_guest host events are not scheduled onto them while
>>   * the CPU is in non-root mode.
>> + *
>> + * This is also used by PMU-specific get_event_constraints() wrappers
>> + * that hard-code a static, counter-specific constraint.
>>   */
>>  static struct event_constraint *
>>  part_constraint(struct cpu_hw_events *cpuc, int idx,
>> @@ -5568,7 +5571,7 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  	/* Handle special quirk on in_tx_checkpointed only in counter 2 */
>>  	if (event->hw.config & HSW_IN_TX_CHECKPOINTED) {
>>  		if (c->idxmsk64 & (1U << 2))
>> -			return &counter2_constraint;
>> +			return part_constraint(cpuc, idx, event, &counter2_constraint);
>>  		return &emptyconstraint;
>>  	}
>>  
>> @@ -5585,7 +5588,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  	 */
>>  	if ((event->attr.precise_ip == 3) &&
>>  	    constraint_match(&fixed0_constraint, event->hw.config))
>> -		return &fixed0_constraint;
>> +		return part_constraint(cpuc, idx, event, &fixed0_constraint);
>>  
>>  	return hsw_get_event_constraints(cpuc, idx, event);
>>  }
>> @@ -5607,7 +5610,7 @@ glc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  	if ((event->attr.precise_ip == 3) &&
>>  	    !constraint_match(&fixed0_constraint, event->hw.config)) {
>>  		if (c->idxmsk64 & BIT_ULL(0))
>> -			return &counter0_constraint;
>> +			return part_constraint(cpuc, idx, event, &counter0_constraint);
>>  
>>  		return &emptyconstraint;
>>  	}
>> @@ -5623,7 +5626,7 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  
>>  	/* :ppp means to do reduced skid PEBS which is PMC0 only. */
>>  	if (event->attr.precise_ip == 3)
>> -		return &counter0_constraint;
>> +		return part_constraint(cpuc, idx, event, &counter0_constraint);
>>  
>>  	c = intel_get_event_constraints(cpuc, idx, event);
>>  
>> @@ -5645,9 +5648,9 @@ tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  	if (event->attr.precise_ip == 3) {
>>  		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
>>  		if (constraint_match(&fixed0_constraint, event->hw.config))
>> -			return &fixed0_counter0_constraint;
>> +			return part_constraint(cpuc, idx, event, &fixed0_counter0_constraint);
>>  
>> -		return &counter0_constraint;
>> +		return part_constraint(cpuc, idx, event, &counter0_constraint);
>>  	}
>>  
>>  	return c;
>> @@ -5705,22 +5708,30 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  	if (event->attr.precise_ip == 3) {
>>  		/* Force instruction:ppp on PMC0, 1 and Fixed counter 0 */
>>  		if (constraint_match(&fixed0_constraint, event->hw.config)) {
>> +			c = &fixed0_counter0_1_constraint;
>> +
>>  			/* The fixed counter 0 doesn't support LBR event logging. */
>>  			if (branch_sample_counters(event))
>> -				return &counter0_1_constraint;
>> -			else
>> -				return &fixed0_counter0_1_constraint;
>> +				c = &counter0_1_constraint;
>> +
>> +			return part_constraint(cpuc, idx, event, c);
>>  		}
>>  
>>  		switch (c->idxmsk64 & 0x3ull) {
>>  		case 0x1:
>> -			return &counter0_constraint;
>> +			c = &counter0_constraint;
>> +			break;
>>  		case 0x2:
>> -			return &counter1_constraint;
>> +			c = &counter1_constraint;
>> +			break;
>>  		case 0x3:
>> -			return &counter0_1_constraint;
>> +			c = &counter0_1_constraint;
>> +			break;
>> +		default:
>> +			c = &emptyconstraint;
>> +			break;
>>  		}
>> -		return &emptyconstraint;
>> +		return part_constraint(cpuc, idx, event, c);
>>  	}
>>  
>>  	return c;
>> @@ -5744,7 +5755,7 @@ rwc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>>  		 */
>>  		if (event->attr.precise_ip == 3)
>>  			return &emptyconstraint;
>> -		return &counters_1_7_constraint;
>> +		return part_constraint(cpuc, idx, event, &counters_1_7_constraint);
>>  	}
>>  
>>  	return c;


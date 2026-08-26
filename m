Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE143B71DF;
	Wed, 26 Aug 2026 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731931; cv=none; b=QAY7avRo1YBdO6xa9mahM5GsVC3TOsY9/yppCXIN+MVkk6uiNLmzFJ/EMh7lbL6VP+cJfLqWADaFyFgNFh3CdjoVQIzUZf2W9PGpwiLYzrsc1pUXrU33lDTWF43bu9mpO3q+B98O3r9yYV7e9FjiKOl47Zg3rOJMlMhEI8GNF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731931; c=relaxed/simple;
	bh=MFgg6EWXejfiNnyLCgXDeD85zcgPIITSuYZIMF/cOGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FA149dHGLiBFy7ThICTkybSKwu7RUpbUS1MRSOB8iKT3yOWX9CqEG4v7GmtvpOfDlb8qN3i7ENUENAO3Q/7fXkOYfY7dT7aFFr5HTpSwtp99MTj07+ARhz9d6O5as/TZ+Yp19p8dR9T0xzg8Oyk2894v+/xMn/RK0oMOlhWxvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekWFKbxu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekWFKbxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787731928; x=1819267928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MFgg6EWXejfiNnyLCgXDeD85zcgPIITSuYZIMF/cOGA=;
  b=ekWFKbxuDgp/oNlUPr2e+/XyxejYBeHHaQ0JT453nM6W8O9f4QgxEI0y
   IE2zbz2FH5B4x/Bfa+ooZTYUOH+gIiZSJO/qt1Him+7zowHyzPCE+R7AG
   a9oxlH9/BYdqbT+ibWrd7HF8k/GTBc/FjvjwASvNDSLsO0Me4bIudLCPT
   MTp2zMMOe2pg/xp0MeE3arcB9LGI7BghIyc1x/N3rCAMxMV9BTujlVkXD
   oNFOQ9W0x/flFzeM02nqNhvI54P7JH1veTVHXVBtCuQHrHGTFudN2cqNR
   dJ7C0PtH8zAOcZqpdAOUpku+lOaScu8PqcITi34cMmCx24Ms24064uITx
   A==;
X-CSE-ConnectionGUID: SGboeRf+TgCQp4EK+rN77A==
X-CSE-MsgGUID: XrHrunnrSES+741dbXprEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="90719588"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="90719588"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:12:06 -0700
X-CSE-ConnectionGUID: iXehGez/Rxi7BvJEDAZDUw==
X-CSE-MsgGUID: mXB2Nt+uSPOPIYczbe6bmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="269460243"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:12:03 -0700
Message-ID: <09251cc4-c795-411c-a9d9-9133a0d73e03@linux.intel.com>
Date: Wed, 26 Aug 2026 16:12:00 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/23] perf/x86: Apply PMU partition mask on static
 constraints
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
 <20260821222002.54907-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260821222002.54907-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It seems not a good practice for me to modify all the places calling these
static constraints. We could have to add new get_event_constraints()
helpers for future platforms, and we have to duplicate these
part_constraint() code.

Could we leverage the dynamic constraint mechanism?  We can set the
event->hw.dyn_constraint to be host counters mask, then we don't need any
specific change for these static constraints.

Thanks.

On 8/22/2026 6:19 AM, Zide Chen wrote:
> Static, counter-specific constraints used for attr.precise_ip == 3, or
> other special cases bypass intel_get_event_constraints(), which is
> where partition_mask is applied via dyn_constraint().
>
> As a result, such a host !exclude_guest event can still be scheduled
> onto a counter that partition_mask reserves for the guest, causing
> host and guest to share the same hardware counter.
>
> Some of these static constraint paths, e.g. glp or cmt, are currently
> only reachable on platforms that don't support PerfMon masking. Still,
> apply part_constraint() to all of them uniformly, so future platforms
> that combine PerfMon masking with these constraint paths are not
> silently exposed to this bug.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 7951accfcf2c..0f76e56fd2db 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4459,6 +4459,9 @@ dyn_constraint(struct cpu_hw_events *cpuc, struct event_constraint *c, int idx)
>   * Mask out guest-owned counters from a constraint when PMU partition has been
>   * entered, so !exclude_guest host events are not scheduled onto them while
>   * the CPU is in non-root mode.
> + *
> + * This is also used by PMU-specific get_event_constraints() wrappers
> + * that hard-code a static, counter-specific constraint.
>   */
>  static struct event_constraint *
>  part_constraint(struct cpu_hw_events *cpuc, int idx,
> @@ -5568,7 +5571,7 @@ hsw_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  	/* Handle special quirk on in_tx_checkpointed only in counter 2 */
>  	if (event->hw.config & HSW_IN_TX_CHECKPOINTED) {
>  		if (c->idxmsk64 & (1U << 2))
> -			return &counter2_constraint;
> +			return part_constraint(cpuc, idx, event, &counter2_constraint);
>  		return &emptyconstraint;
>  	}
>  
> @@ -5585,7 +5588,7 @@ icl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  	 */
>  	if ((event->attr.precise_ip == 3) &&
>  	    constraint_match(&fixed0_constraint, event->hw.config))
> -		return &fixed0_constraint;
> +		return part_constraint(cpuc, idx, event, &fixed0_constraint);
>  
>  	return hsw_get_event_constraints(cpuc, idx, event);
>  }
> @@ -5607,7 +5610,7 @@ glc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  	if ((event->attr.precise_ip == 3) &&
>  	    !constraint_match(&fixed0_constraint, event->hw.config)) {
>  		if (c->idxmsk64 & BIT_ULL(0))
> -			return &counter0_constraint;
> +			return part_constraint(cpuc, idx, event, &counter0_constraint);
>  
>  		return &emptyconstraint;
>  	}
> @@ -5623,7 +5626,7 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  
>  	/* :ppp means to do reduced skid PEBS which is PMC0 only. */
>  	if (event->attr.precise_ip == 3)
> -		return &counter0_constraint;
> +		return part_constraint(cpuc, idx, event, &counter0_constraint);
>  
>  	c = intel_get_event_constraints(cpuc, idx, event);
>  
> @@ -5645,9 +5648,9 @@ tnt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  	if (event->attr.precise_ip == 3) {
>  		/* Force instruction:ppp on PMC0 and Fixed counter 0 */
>  		if (constraint_match(&fixed0_constraint, event->hw.config))
> -			return &fixed0_counter0_constraint;
> +			return part_constraint(cpuc, idx, event, &fixed0_counter0_constraint);
>  
> -		return &counter0_constraint;
> +		return part_constraint(cpuc, idx, event, &counter0_constraint);
>  	}
>  
>  	return c;
> @@ -5705,22 +5708,30 @@ cmt_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  	if (event->attr.precise_ip == 3) {
>  		/* Force instruction:ppp on PMC0, 1 and Fixed counter 0 */
>  		if (constraint_match(&fixed0_constraint, event->hw.config)) {
> +			c = &fixed0_counter0_1_constraint;
> +
>  			/* The fixed counter 0 doesn't support LBR event logging. */
>  			if (branch_sample_counters(event))
> -				return &counter0_1_constraint;
> -			else
> -				return &fixed0_counter0_1_constraint;
> +				c = &counter0_1_constraint;
> +
> +			return part_constraint(cpuc, idx, event, c);
>  		}
>  
>  		switch (c->idxmsk64 & 0x3ull) {
>  		case 0x1:
> -			return &counter0_constraint;
> +			c = &counter0_constraint;
> +			break;
>  		case 0x2:
> -			return &counter1_constraint;
> +			c = &counter1_constraint;
> +			break;
>  		case 0x3:
> -			return &counter0_1_constraint;
> +			c = &counter0_1_constraint;
> +			break;
> +		default:
> +			c = &emptyconstraint;
> +			break;
>  		}
> -		return &emptyconstraint;
> +		return part_constraint(cpuc, idx, event, c);
>  	}
>  
>  	return c;
> @@ -5744,7 +5755,7 @@ rwc_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>  		 */
>  		if (event->attr.precise_ip == 3)
>  			return &emptyconstraint;
> -		return &counters_1_7_constraint;
> +		return part_constraint(cpuc, idx, event, &counters_1_7_constraint);
>  	}
>  
>  	return c;

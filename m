Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8241B38E8C6;
	Mon, 21 Sep 2026 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974074; cv=none; b=iwXwXkX82NGYsPPZlVPLuVsMkNZGW/0hrHZZ9SrC9Zi2vaquI6X8LVL5p6iMW7droZLLBjbJHSQdywTG1coECx+O1rAAec/FlEebADl3MCiRA1P3WGPl9A0+sKJqkGwD6MiaeilLqNLHqYkT29DFDc9Ocaatb0FyWM5RkJ/RRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974074; c=relaxed/simple;
	bh=M8ulvWZlByngyAem3DaOsHS+QmhN2fD1YQVtQkMcMuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLGkSMHCf3BYJbzRSNPfJqUR4+dcKX9jZ9eSaX0ucstkrmTe49x8AzbqUate+V8/DLH3bfaCqbvhfxC1QPtV8QJln0kx6POvKi5jXXPDaJvfSbLfedlLYa6Dg9HDluSbCj+F+vjW3drBA/E3f/gLA8H0K3lUPWJj+S/pcvRPTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6sA85fx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6sA85fx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789974072; x=1821510072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8ulvWZlByngyAem3DaOsHS+QmhN2fD1YQVtQkMcMuw=;
  b=A6sA85fxc0fSns6zh1M9CUxqAUA650yh/MaNzwi3LskwVRPS4dsKHqN5
   xqrPaamqqg2blQdQSraA0Wm/NMyyecsgZkE+us/wOJ+2jEcbBDziQm4lB
   y7oDHTDomhhNwZVzs7aThw6a63Gc3FStsUQ8ctQKcivkMdzoDIMRAvbrC
   lnkKz9U/g35nZWWzI8zdZIm26xCDDJ7LQZEUpfwGuKY7gsdd1N4JjY2vD
   tKmfkmBiYzHpm13uCsZHIvDeT3mJTfAyNqzThXpj/OPtgGuYLAxdRqV9E
   AN0NyfI+5+wvssQGSCHgjMbi8hwaoo7rpKO2GnycTBbvPxm4wUN2DshVR
   Q==;
X-CSE-ConnectionGUID: TCsTBYzNQ9OlWSB+BNDJxg==
X-CSE-MsgGUID: JxykLF5BQZ+XMFwk0liVhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="90485497"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="90485497"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 00:01:11 -0700
X-CSE-ConnectionGUID: GQ3XONWfQKm7S/t6if/0pw==
X-CSE-MsgGUID: UTkG1EKTSB2IHG7Fq35dRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="3830986"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 00:01:08 -0700
Message-ID: <b73ffa7d-29ce-44b3-be1c-88068fc2f443@linux.intel.com>
Date: Mon, 21 Sep 2026 15:01:05 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/12] perf/x86: Add INTEL_TD_METRIC_FIELD_{BITS,MASK}
 constants
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260918193937.569414-1-zide.chen@intel.com>
 <20260918193937.569414-10-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260918193937.569414-10-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/19/2026 3:39 AM, Zide Chen wrote:
> Replace the hard coded field width (8) and the equivalent 0xff mask
> used for PERF_METRICS MSR field access with named constants
> INTEL_TD_METRIC_FIELD_{BITS,MASK}.
>
> INTEL_TD_METRIC_FIELD_BITS will be used by a subsequent KVM patch to
> validat reserved bits in the PERF_METRICS MSR.
>
> No functional change intended.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
> v9: new patch.
> ---
>  arch/x86/events/intel/core.c      | 8 +++++---
>  arch/x86/include/asm/perf_event.h | 4 ++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cc13164d948f..cbc9a179f2e5 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3159,6 +3159,7 @@ DEFINE_STATIC_CALL(intel_pmu_set_topdown_event_period, x86_perf_event_set_period
>  
>  static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
>  {
> +	int shift = (idx - INTEL_PMC_IDX_METRIC_BASE) * INTEL_TD_METRIC_FIELD_BITS;
>  	u32 val;
>  
>  	/*
> @@ -3166,8 +3167,8 @@ static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
>  	 * summing up to 0xff.
>  	 * slots-in-metric = (Metric / 0xff) * slots
>  	 */
> -	val = (metric >> ((idx - INTEL_PMC_IDX_METRIC_BASE) * 8)) & 0xff;
> -	return  mul_u64_u32_div(slots, val, 0xff);
> +	val = (metric >> shift) & INTEL_TD_METRIC_FIELD_MASK;
> +	return mul_u64_u32_div(slots, val, INTEL_TD_METRIC_FIELD_MASK);
>  }
>  
>  static u64 icl_get_topdown_value(struct perf_event *event,
> @@ -4742,7 +4743,8 @@ static int core_pmu_hw_config(struct perf_event *event)
>  }
>  
>  #define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
> -					 ((x86_pmu.num_topdown_events - 1) << 8))
> +					 ((x86_pmu.num_topdown_events - 1) << \
> +					  INTEL_TD_METRIC_FIELD_BITS))

Sashiko comments,

"

Is it safe to replace the UMASK shift here with the hardware MSR metric
field width?
The original << 8 was used to shift the metric ID into the UMASK field
(bits 8-15) of the software perf event configuration (attr.config).
INTEL_TD_METRIC_FIELD_BITS represents the hardware width of metrics within
the PERF_METRICS MSR.
When evaluated in is_available_metric_event() during perf_event_open(), this
currently functions because both values are 8. However, conflating a software
API layout offset with a hardware register field width could cause this macro
to calculate an invalid configuration mask if the MSR field width changes in
future hardware.

"

It looks reasonable, we either don't change this, or define a macro to
represent the UMASK shift. Thanks.



>  
>  static bool is_available_metric_event(struct perf_event *event)
>  {
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 1eb13673e889..ceb6188e5217 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -418,6 +418,10 @@ static inline bool use_fixed_pseudo_encoding(u64 code)
>  #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
>  #define INTEL_TD_METRIC_NUM			8
>  
> +/* Width, in bits, of each metric's field within the PERF_METRICS MSR. */
> +#define INTEL_TD_METRIC_FIELD_BITS		8
> +#define INTEL_TD_METRIC_FIELD_MASK		GENMASK_ULL(INTEL_TD_METRIC_FIELD_BITS - 1, 0)
> +
>  #define INTEL_TD_CFG_METRIC_CLEAR_BIT		0
>  #define INTEL_TD_CFG_METRIC_CLEAR		BIT_ULL(INTEL_TD_CFG_METRIC_CLEAR_BIT)
>  

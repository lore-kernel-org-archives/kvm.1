Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1F2882B7;
	Tue, 30 Jun 2026 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782785616; cv=none; b=OQRtF4KdTJSwd9xOwwTStfD1S0/bSUkPhjlc5kbbxfEExDhxyVIKxKy8yJ6iE6ffQRvQzLMXDp8ekELXZnumCekfQ+mxNEI7mE9nQsmL3ahCZ0Cj7cfPN/nzCJiHJGJBCLkNtLdn+g9f6Bt2BNGwE7EQ7CIb1EsZXOZCB3Y7pyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782785616; c=relaxed/simple;
	bh=pW+Z1zgQGHJLYHuIgJ+yUqmA7RkBAS3DkBSZ3kXQqZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLgyuuWA3ane1ChsWHWccbFrWU8X5bV/YEVyVYBARlYj6EuEfOWBTWK5Uf0tJQFKsFtT+0CP4SLZCVR2WvBmEmSsoCFFIXyue449sFNtmHv56+aXrJ/qkMrCRYUuJ6EbCiPvaUMDO8vVvoP39Nr90lkrUH8JTkfSGZY+9NR4IFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ukv5FZ8h; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ukv5FZ8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782785615; x=1814321615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pW+Z1zgQGHJLYHuIgJ+yUqmA7RkBAS3DkBSZ3kXQqZk=;
  b=Ukv5FZ8hs2Zt5rmH7H+H1HNxk3lruA5XyeAdtz7CwUJYV9k+cu3Rz9Ud
   H7FS5kVAn9TPDX2miJ3qlKds7yvCHD6X72uPNQAUy0D7faeepHU4l8DxH
   7zABo6WXEICpmEUesNd9tK7TIa+iYvtWOzO8IOZ6AwWq4w3WxbYaaA3F3
   V4Xr5QE2DH7IcyNeWuN23jBUUk99kOQD3TI9FSqB2IQpc83snni06g/15
   oiSxJM3oT+ux7f+kENsgsK64ac9S2FXzHke8HGbYkHW9dp/6llxoC+sVs
   oOS4/dM3mgfHmV+0dTZL2pEYsygkOA0WKxfyb80XOhRy7/qOFKTqewI4/
   g==;
X-CSE-ConnectionGUID: bXCFOXc9QmqYIcT3HIUBsg==
X-CSE-MsgGUID: 4rEmRRtCRsCY5GmLPtUtbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83577121"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="83577121"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:13:34 -0700
X-CSE-ConnectionGUID: GFGxAJAVTq6ePmaGP7+ozg==
X-CSE-MsgGUID: 69W6v5MLTLmZG56Qt/HIkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="282192127"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 19:13:32 -0700
Message-ID: <10af2777-404d-4393-a202-b8b48d331941@linux.intel.com>
Date: Tue, 30 Jun 2026 10:13:29 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] KVM: x86/pmu: Do not map fixed counters >= 3 to
 generic perf events
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260629231938.15129-1-zide.chen@intel.com>
 <20260629231938.15129-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260629231938.15129-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 6/30/2026 7:19 AM, Zide Chen wrote:
> Only fixed counters 0..2 have matching generic cross-platform
> hardware perf events (INSTRUCTIONS, CPU_CYCLES, REF_CPU_CYCLES).
> Therefore, perf_get_hw_event_config() is only applicable to these
> counters.
>
> KVM does not intend to emulate fixed counters >= 3 on legacy
> (non-mediated) vPMU, while for mediated vPMU, KVM does not care what
> the fixed counter event mappings are.  Therefore, return 0 for their
> eventsel.
>
> The two BUILD_BUG_ON() checks are no longer needed, so drop them along
> with __always_inline.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v6:
> - Re-arrange the code for early return. Clearer.
> v2:
> - Replace 3 in "if (index < 3)" with ARRAY_SIZE(fixed_pmc_perf_ids).
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index a73a9515d96c..f15af497d27f 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -464,11 +464,8 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>   * different perf_event is already utilizing the requested counter, but the end
>   * result is the same (ignoring the fact that using a general purpose counter
>   * will likely exacerbate counter contention).
> - *
> - * Forcibly inlined to allow asserting on @index at build time, and there should
> - * never be more than one user.
>   */
> -static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
> +static u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  {
>  	const enum perf_hw_id fixed_pmc_perf_ids[] = {
>  		[0] = PERF_COUNT_HW_INSTRUCTIONS,
> @@ -477,8 +474,13 @@ static __always_inline u64 intel_get_fixed_pmc_eventsel(unsigned int index)
>  	};
>  	u64 eventsel;
>  
> -	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
> -	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
> +	/*
> +	 * Fixed counters 3 and above don't have a corresponding generic
> +	 * hardware perf event, and KVM does not intend to emulate them on
> +	 * non-mediated vPMU.
> +	 */
> +	if (index >= ARRAY_SIZE(fixed_pmc_perf_ids))
> +		return 0;
>  
>  	/*
>  	 * Yell if perf reports support for a fixed counter but perf doesn't

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7223BCF7;
	Thu, 30 Apr 2026 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514145; cv=none; b=avT5NCPM2iLq/9QoZdZ1Vh37yC7jlVr4r3vUjVOLMuacNGSwEC2hkDxBbOc05Pr7a9lOMLkksIdBx6VwMJdYfUJr5aflt3GQbgzskdonUyuk3w5ApqQycbPGXUb0ho5H9fMuxebYI1pWCUyuwX5eGFVERBXgU95yLr+jPsZXsA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514145; c=relaxed/simple;
	bh=FRcrDvHtiYsTRyqXrRdh9YKMIL0/EKMfvtEznVjJ89U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3bBHgaGIhXbme87O2KArX+2PkQYQ3L4ITxOyEmQJgZ56IInB5e0KCumUGHqiz31YJzxs7vJ0uNJBbTNCLLPZdPmvya3XdxnKJOFYcCLjJBWNa41zR+2nGXLeKJJEUKv0Kqhevwu7oIzhqUZGvHhyNWVp7EYLfs1Lto4tBkeSR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HqCMrmi3; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HqCMrmi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777514144; x=1809050144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FRcrDvHtiYsTRyqXrRdh9YKMIL0/EKMfvtEznVjJ89U=;
  b=HqCMrmi3azbMHgEUh8UkBkx5xXy9xrf2WWfxhVLbZyFVWOWOCdgweok0
   Y5t5ngr9nhlZefcKqLOgB0S78698KTfYciv6x87vNwMIDMSG4X4gWtXZr
   dxzI2uYiBhGtKfs7yIuMUosgUJiEu59zOuoFtthuEk+qH6sWPBeQ+YsOj
   CDwGBIAguNUmRbo6OYWyoVHahe2lFXrGx+eBYI9XzDP7uuBQ7uEnydb0m
   kCJknsah0N8fqrPKpHhahQ5tqjwHfow6ErM77IbED2caFHrst6dQq32uQ
   AIBWBDuME2r2wxQ2y7EFBhG5MMVyk4BXkiEC7SLJca/AHv0fmH02USWZ4
   Q==;
X-CSE-ConnectionGUID: EZ96YU1LRoy0uRRUyuBLuA==
X-CSE-MsgGUID: tyBOOQ9ZR+2y/lHC95Yxrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82320200"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="82320200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 18:55:44 -0700
X-CSE-ConnectionGUID: V0FnxMY9SEOKGLfk582lvQ==
X-CSE-MsgGUID: tVGJpI6JQc23aWwsHnZQmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="258023787"
Received: from unknown (HELO [10.238.2.250]) ([10.238.2.250])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 18:55:40 -0700
Message-ID: <f672b965-26f3-4c7a-a2ef-b18cc44f0bf0@linux.intel.com>
Date: Thu, 30 Apr 2026 09:55:37 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] KVM: x86/pmu: Do not map fixed counters >= 3 to
 generic perf events
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260423174639.56149-1-zide.chen@intel.com>
 <20260423174639.56149-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260423174639.56149-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/24/2026 1:46 AM, Zide Chen wrote:
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
> Also remove __always_inline as BUILD_BUG_ON() is no longer needed.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Replace 3 in "if (index < 3)" with ARRAY_SIZE(fixed_pmc_perf_ids).
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 27eb76e6b6a0..05a59f4acfdd 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -454,28 +454,30 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
>  		[1] = PERF_COUNT_HW_CPU_CYCLES,
>  		[2] = PERF_COUNT_HW_REF_CPU_CYCLES,
>  	};
> -	u64 eventsel;
> -
> -	BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_perf_ids) != KVM_MAX_NR_INTEL_FIXED_COUNTERS);
> -	BUILD_BUG_ON(index >= KVM_MAX_NR_INTEL_FIXED_COUNTERS);
> +	u64 eventsel = 0;
>  
>  	/*
> -	 * Yell if perf reports support for a fixed counter but perf doesn't
> -	 * have a known encoding for the associated general purpose event.
> +	 * Fixed counters 3 and above don't have corresponding generic hardware
> +	 * perf event, and KVM does not intend to emulate them on non-mediated
> +	 * vPMU.

The above comments are ambiguous. Fixed counter 3 and above indeed have
dedicated perf event, but they are not supported perf_hw_id{} yet. So KVM
has no way to get their specific event code now.

Thanks.


>  	 */
> -	eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> -	WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
> +	if (index < ARRAY_SIZE(fixed_pmc_perf_ids)) {
> +		/*
> +		 * Yell if perf reports support for a fixed counter but perf
> +		 * doesn't have a known encoding for the associated general
> +		 * purpose event.
> +		 */
> +		eventsel = perf_get_hw_event_config(fixed_pmc_perf_ids[index]);
> +		WARN_ON_ONCE(!eventsel && index < kvm_pmu_cap.num_counters_fixed);
> +	}
>  	return eventsel;
>  }
>  

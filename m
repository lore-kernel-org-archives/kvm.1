Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1C351C11;
	Tue,  1 Sep 2026 02:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229867; cv=none; b=PPJw981lvwM8jCEuH/nSkfHGIi5iTgEAleK24L7t6hpzbH3H8xGnCSxVkLpMnOH7zhW+NCC8KZl9QyMtqxH//OtsKVrFoAbfLKxsPic/oPpV1y6iou9lPHO8QipzHzfF2izunxV5ag41Szv05p2ibQruVWwrSkKXIxqtL6/vLLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229867; c=relaxed/simple;
	bh=Xt/JgRAjIpg2DakA2+bI2O2ctCZoAKVxKp649lRoIy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TD9BPhumbUH2AeBg/NpyxdO+bbGEhc/mHgg3TDmg7l6jEipXqoDP28qNH/TKcsFvJjMyIgSv5I+efx3awBK0SZsgro5zrS/RCab02AHmCaMoVdfpomEsS9SO7y9hRRxy55uH0HyMzVCJvwguOMXqgaZ61DcD9fe1KBm13F6QbUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aa9pDuA7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aa9pDuA7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788229864; x=1819765864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xt/JgRAjIpg2DakA2+bI2O2ctCZoAKVxKp649lRoIy4=;
  b=Aa9pDuA7UokYQX6TjGRLUYreNE/RQpk+EqLlSueI6XOtzA5ONMMdaZtn
   yo9nr44e3XXbBFLeVFXETNf4Dx+zk7WWN1AvGsLQmQyFwwYGt4PhzJ/iL
   kFy3YoqqWAoXiyMli++r6UCA8Q0kqJdwBvmjlp+/eqhaHaXlhZF0u/03y
   Aix08ZYfrD2KGtf9VK9CR3be6xzLXCC+qYeVUI20iWe9+ssUeKAL25Bup
   FzVk+LIiJlhHTHKxjbIPAEw4PVdYDTFYFiA+cOUSwimARY94VKA8lcXY/
   va4Pd2MxOwth57PBBhNeo21i1IvpqqevrkBXvpnjIA93mlW9mkOqe5tmw
   Q==;
X-CSE-ConnectionGUID: YdCzFwf/SoC9Aehme375eA==
X-CSE-MsgGUID: b4Hi0sMDQgO2ILZEJ9kQ5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88657317"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88657317"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:31:03 -0700
X-CSE-ConnectionGUID: /sVRQfwXT8myN3NYbh8NAg==
X-CSE-MsgGUID: iiUw0egYQmOtAk0W51td0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="292447406"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:31:00 -0700
Message-ID: <253df5b9-e13a-4d19-aa46-d6432384985e@linux.intel.com>
Date: Tue, 1 Sep 2026 10:30:58 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] KVM: x86/pmu: Gate BUFFER_OVF reserved bit on
 guest DS
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/28/2026 6:37 AM, Zide Chen wrote:
> global_status_rsvd unconditionally clears GLOBAL_STATUS_BUFFER_OVF
> (bit 62), even when the guest does not have X86_FEATURE_DS feature.
> Clear it only when guest_cpu_cap_has(vcpu, X86_FEATURE_DS), matching
> hardware behavior.
>
> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a guests")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2: new patch.
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 11c9161dc853..9fdae437e569 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -576,8 +576,16 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
>  	pmu->global_ctrl_rsvd = counter_rsvd;
>  
> -	pmu->global_status_rsvd = pmu->global_ctrl_rsvd
> -			& ~(GLOBAL_STATUS_BUFFER_OVF | GLOBAL_STATUS_COND_CHG);
> +	/*
> +	 * Layout of bits 48:0 in IA32_PERF_GLOBAL_CTRL is identical to
> +	 * IA32_PERF_GLOBAL_STATUS, but IA32_PERF_GLOBAL_STATUS has additional
> +	 * bits.
> +	 */
> +	pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_DS))
> +		pmu->global_status_rsvd &= ~GLOBAL_STATUS_BUFFER_OVF;
> +	pmu->global_status_rsvd &= ~GLOBAL_STATUS_COND_CHG;
> +
>  	if (vmx_pt_mode_is_host_guest())
>  		pmu->global_status_rsvd &= ~GLOBAL_STATUS_TRACE_TOPAPMI;
>  

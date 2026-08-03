Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE4341D20F;
	Mon,  3 Aug 2026 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792763; cv=none; b=mhHWU1RImh4OuJ1Cqd6lD+LnLfuW7PKWgKPrHPUxomv+6Pfon/0eDQac1XPRHfdkat9HwY5xwdA57qCaw1w+AMe5wBxr6ltyECbmy75pTUkQmIwgwCGupUg+b1YG8SktlJx+k5SnjY9hTm8AyJCH2AD0N6rN+e5LvBa6C4J0xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792763; c=relaxed/simple;
	bh=8Ifd0+ae8OJlhUs7anX5iE5GkK8wkNKvK4GMC7qQFZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN9fFDz+XfA2duxHM9boKaLPDFLVXfj/2lMy0NRdKqFCcfjRgTQJm8uHWd/DHv7pdeZByUJ5dEXZvyYnaJvET0Qaa3kK2LuBq5aTdzPIzDOwCjd/hQ5RBsYXmqm4qWK1mLv2qNjDQ6qKzvdNHPw3ZUbRG7zUDkaobBkzAUS4vc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFIo80Jh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFIo80Jh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785792761; x=1817328761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8Ifd0+ae8OJlhUs7anX5iE5GkK8wkNKvK4GMC7qQFZI=;
  b=QFIo80Jh0HXxSOquIYnVVq0t9TNi6p7tknHZw2i8NRI2zk1t3HYYoh1D
   JoA8evXohE/bjfctuxcLKfpd4GyTse7XGmOat2JD1j8EiCGLr5ThzwyeO
   GCqEIUhoFOv8EBqOQcotgYdn4kb5Gzh+TTCKj0XBURa8L0v+BM0WQmCXs
   N28JgxF3Uf5g8/aOo61xKR2X4gQVzkCcbeaODvY5eDtS4BBZvhShNJyWj
   QZgA1xMuqHw11vn18EwtEf6W53QMT4jpdmYXCIGpKLLGxTKogoBDioxSt
   LtmVwA+thS9cRXI964YNfWUcvYjZ1Yicj9VARxRIdsgpfpqHAf7nfqKKL
   g==;
X-CSE-ConnectionGUID: OlF96PYaT3uWW9n6oUI9eg==
X-CSE-MsgGUID: TFohu6+zQIWs4gG9007wUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="73875345"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="73875345"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 14:32:40 -0700
X-CSE-ConnectionGUID: s8tBM/hhT/SRcrmjwMY0IA==
X-CSE-MsgGUID: 0wx0TAgmSMqS7BB4VP9nQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="265160750"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 14:32:39 -0700
Message-ID: <34cce79f-e4e2-4d08-bc80-f87da001f573@intel.com>
Date: Mon, 3 Aug 2026 16:32:38 -0500
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] KVM: x86/pmu: Ignore AnyThread bit if
 CPUID.0AH:EDX[15] is not set
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260707183405.15571-1-zide.chen@intel.com>
 <20260707183405.15571-14-zide.chen@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260707183405.15571-14-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/7/2026 1:34 PM, Zide Chen wrote:
> Intel PerfMon v5 introduces the ANYTHREAD_DEPRECATION capability
> (CPUID.0AH:EDX[15]) to indicate that AnyThread counting is deprecated
> and that writes to the AnyThread bit in IA32_PERFEVTSELx are ignored.
> 
> When ANYTHREAD_DEPRECATION is present in the guest CPUID, emulate the
> architectural behavior and silently ignore writes to the AnyThread bit
> instead of injecting #GP.
> 
> Continue to inject #GP when ANYTHREAD_DEPRECATION is not present in the
> guest CPUID, e.g. for PerfMon v3/v4 guests or when the capability is
> not configured for a PerfMon v5+ guest.

Advertise CPUID.0AH:EDX[15] only for PMU version 5+ guests, since the
bit doesn't exist below version 5.

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7fa5d6d51fe9..2dcce8119f1c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1542,7 +1542,7 @@ static inline int __do_cpuid_func(struct
kvm_cpuid_array *array, u32 function)
                                            KVM_MAX_NR_FIXED_COUNTERS);
                edx.split.bit_width_fixed = kvm_pmu_cap.bit_width_fixed;

-               if (kvm_pmu_cap.version)
+               if (kvm_pmu_cap.version >= 5)
                        edx.split.anythread_deprecated = 1;

                entry->eax = eax.full;

> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 3f41e4916986..2c2a54ac55ad 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -508,6 +508,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			if (data & eventsel_rsvd)
>  				return 1;
>  
> +			/*
> +			 * On PerfMon v5+, KVM may allow writes to the AnyThread
> +			 * bit and silently discard them.
> +			 */
> +			data &= ~ARCH_PERFMON_EVENTSEL_ANY;
>  			if (data != pmc->eventsel) {
>  				pmc->eventsel = data;
>  				pmc->eventsel_hw = data;
> @@ -627,6 +632,9 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->all_valid_pmc_mask64 = (BIT_ULL(nr_gp_counters) - 1) &
>  				    kvm_pmu_cap.cntr_mask64;
>  
> +	if (pmu->version >= 5 && edx.split.anythread_deprecated)
> +		pmu->eventsel_rsvd &= ~ARCH_PERFMON_EVENTSEL_ANY;
> +
>  	entry = kvm_find_cpuid_entry_index(vcpu, 7, 0);
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&


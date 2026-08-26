Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFBD3B8BDB;
	Wed, 26 Aug 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733807; cv=none; b=ZJdmcJJW8MZ0lsi4JuG9rsxdy+gsiuM3l+8VibAyCYTUwbvmGVgHFgagVqiJFaNIYhjI36t2YHcIcAjrsxRzCzA3jC+tfoolLWSPMGaVzuCSxc+q+GA3evjDVStejKiQFEvNOKArIOtN7be9MFf6QMgEZq6eL/Sgo9s9wp5BrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733807; c=relaxed/simple;
	bh=YNP44XDaUI5cSr3SXwqpRppcfOp7U0fNLwuZG3l6u6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SZTeyQrzWyMwP0VK5g14cyWE2U6kfGiFoolZs1UUombo2Up4L4ygWI1YQspHamKzKFFRM0XkKrGzNu3B82PiAFcQjrCEemTfgQF5rvrJi/r42SWyeuw1tP+kQzDAbFbkZHqr2mkSfK9doiFi3Rchlyem5CsE/qiwr6l7MRp60nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwhomrTG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwhomrTG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787733805; x=1819269805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YNP44XDaUI5cSr3SXwqpRppcfOp7U0fNLwuZG3l6u6A=;
  b=QwhomrTGNTXz4hWzBnj/sRQvPeuqAWt3UNPywwItBRrlqyO3u+RUoH4E
   zEHjf6Eg/8C0dW9+hRZwoBD95E/A6u1hdQq4D85/5KaWtOTbm669AVYYy
   elX6Mp1wiJuP6NvYOWOS1m7kBsaXRpbNczh5pHStBkP7ViC7HnmmfhWNj
   h5OINOnwJ0fBICeV5yUEvy5K423V5wr4exUqpBuWzYwiD6Y8NOOf9ytgV
   ByJ50TcHOFbWiVXFjkolTtL39tgJ4e+0tAAVuHwY9mmbOjqMqVP3Sgcfp
   SNsCk+2JE5hx75dvbTzZd7M0Nv+NouYXblad4ETUZshsdJH9y15jRN9e4
   Q==;
X-CSE-ConnectionGUID: kieZpNPqTmuYG/7/tgLnqA==
X-CSE-MsgGUID: c+MLusBTSE68HVjm85gkiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="98545392"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="98545392"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:43:25 -0700
X-CSE-ConnectionGUID: Kiosmn2+Q9KjpwPnusJFWA==
X-CSE-MsgGUID: 22OMgb+XRY6PAJIFUJ2isQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="265720316"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:43:22 -0700
Message-ID: <86696454-bf73-4d06-83f6-1f85e6540259@linux.intel.com>
Date: Wed, 26 Aug 2026 16:43:19 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/23] KVM: x86/pmu: Handle FIXED_CTR_CTRL under PerfMon
 masking
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260821222002.54907-1-zide.chen@intel.com>
 <20260821222002.54907-17-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260821222002.54907-17-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/22/2026 6:19 AM, Zide Chen wrote:
> PerfMon masking affects reads from and writes to this MSR. The effective
> mask is defined as bits 4n+3:4n and bits 4n+35:4n+32 being set if and
> only if bit 32+n of the PerfMon mask is set (for 0 <= n <= 7).
>
> KVM doesn't support some fixed-counter features, and
> pmu->fixed_ctr_ctrl_rsvd is a subset of the effective mask above, so the
> existing gating in intel_pmu_set_msr() is sufficient even under PerfMon
> masking.
>
> Upon guest PMU context load, OR the guest-owned bits with whatever the
> hardware currently holds for every fixed-counter index the guest does
> not own, before writing the result to the MSR.
>
> During PMU context put, host-owned fixed counters may still be scheduled
> for system-wide host events, so the host-owned bits should remain
> unchanged.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 40 +++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 19ccc7cd319c..9236bfa15c41 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -920,6 +920,33 @@ static void intel_pmu_write_global_ctrl(u64 global_ctrl)
>  	vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL, global_ctrl);
>  }
>  
> +static u64 intel_fixed_ctrl_host_bits(struct kvm_pmu *pmu)
> +{
> +	unsigned long fixed_mask;
> +	u64 fixed_ctl;
> +	int i;
> +
> +	if (!kvm_vcpu_has_perfmon_mask(pmu_to_vcpu(pmu)))
> +		return 0;
> +
> +	fixed_mask = kvm_fixed_pmc_mask(pmu);
> +
> +	rdmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, fixed_ctl);
> +
> +	/*
> +	 * Use the full per-counter nibbles (bits 4n+3:4n and 4n+35:4n+32) to
> +	 * strip all bits belonging to guest-owned counters.
> +	 *
> +	 * pmu->fixed_ctr_ctrl_rsvd can't be used here since it can't gate bits
> +	 * that are not supported by KVM.
> +	 */
> +	kvm_for_each_fixed_counter(i, fixed_mask)
> +		fixed_ctl &= ~intel_fixed_bits_by_idx(i, GENMASK_ULL(3, 0) |
> +						      GENMASK_ULL(35, 32));
> +
> +	return fixed_ctl;
> +}

Strictly speaking, this should be a perf/x86/intel function and then
exposed to KVM. Perf host side may also need this function.


> +
>  static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -935,7 +962,8 @@ static void intel_mediated_pmu_load(struct kvm_vcpu *vcpu)
>  	if (pmu->global_status & toggle)
>  		wrmsrq(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status & toggle);
>  
> -	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl_hw);
> +	wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL,
> +	       pmu->fixed_ctr_ctrl_hw | intel_fixed_ctrl_host_bits(pmu));
>  }
>  
>  static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
> @@ -953,9 +981,15 @@ static void intel_mediated_pmu_put(struct kvm_vcpu *vcpu)
>  	 * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage and
>  	 * also to avoid accidentally enabling fixed counters (based on guest
>  	 * state) while running in the host, e.g. when setting global ctrl.
> +	 *
> +	 * Keep the host-owned counters unchanged.
>  	 */
> -	if (pmu->fixed_ctr_ctrl_hw)
> -		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> +	if (pmu->fixed_ctr_ctrl_hw) {
> +		u64 fixed_ctl = intel_fixed_ctrl_host_bits(pmu);
> +
> +		fixed_ctl &= ~pmu->fixed_ctr_ctrl_hw;
> +		wrmsrq(MSR_CORE_PERF_FIXED_CTR_CTRL, fixed_ctl);
> +	}
>  
>  	if (kvm_vcpu_has_perf_metrics(vcpu)) {
>  		pmu->perf_metrics = rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS);

Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46D026ED37;
	Tue,  1 Sep 2026 02:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229067; cv=none; b=ZtWnjl5/HXfm8Z9UnRGendgVd+Pp4eYv8JFiw3ljHNobGJW61ZHR0xFfoOwfqwPoHp3atPxuXWyxETPiLcwtva1esZz7vpvAPWBIFB9oMTYr/SyVM5lSkuJ+lh7puDayUqOBZdigvcHVUoVhOfyyxRBqJCITxwIqHWUPcYnjGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229067; c=relaxed/simple;
	bh=g0ZOFn3ymyEN7Pkjwe19qwf1DGayRKUC94+C/ByW1gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1WF74uJwg0AFUCPSiuT8BhF/B+esJQAj+V80M6rgLByRaHh6md4dxLPbS2OXaqKugARWADrxoMsHkFnmUu4PchUfwd3CATCedsGFSuF+/bUuTYLyC+pcwpKxsqsjodNapqucGFnGNFFUGYlJKLC9AoaVEx9m0tWXY+/jZzMisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhBngR/a; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhBngR/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788229065; x=1819765065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g0ZOFn3ymyEN7Pkjwe19qwf1DGayRKUC94+C/ByW1gg=;
  b=RhBngR/a5sTDHZh2G48d5j76Nl0tsHmu9p7YD6epmhV4BQ+ixvk3ISGN
   NySFW1IYgmQYOd2xQyoKJiqukgyC8C55kqM2Xc/6spCQi2SXb10zYCpDW
   lQF9B01RDXcuyDAXoJnnsZuvuhGVykY87PLxbtnkvxEM5i1DdQ+mkh5Gp
   A3gQqw8eqTXAW9eM6L3rejVewHLDiyY+tKiDC/DBJ5KwKoqm13aL4ZZzk
   PxAhrmkLFEOSCTD6KNPEgn6xl1TELR1ZFDyZcdPseQLkGMD59NIoLArMa
   pS7ndRCQvgDtqj/TyXnwwmOpSiq85Fx3f5unJuMbTJbOYIeOSDRHK6pUc
   A==;
X-CSE-ConnectionGUID: KFWtVPlpQ7mKrntj4pDOZQ==
X-CSE-MsgGUID: INdXfhUWRH210a65gbz94w==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88498774"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88498774"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:17:43 -0700
X-CSE-ConnectionGUID: alTf26w3TGa16UP5nVpEcA==
X-CSE-MsgGUID: sS1pM9s1Sg+GDwcSG0U61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272464286"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 19:17:40 -0700
Message-ID: <37a416c8-ccd9-4f57-a21f-1e663a8e9fca@linux.intel.com>
Date: Tue, 1 Sep 2026 10:17:38 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] KVM: x86/pmu: Rename reserved_bits to
 eventsel_rsvd in kvm_pmu
To: Zide Chen <zide.chen@intel.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Jim Mattson <jmattson@google.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260827223755.143247-1-zide.chen@intel.com>
 <20260827223755.143247-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260827223755.143247-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 8/28/2026 6:37 AM, Zide Chen wrote:
> This field stores the bits that are reserved in guest IA32_PERFEVTSELx
> MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
> align with other field names in struct kvm_pmu.
>
> Opportunistically, replace the magic number 0xffffffff00200000ull with
> macros.
>
> No functional change intended.
>
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Replace magic numbers in AMD pmu->eventsel_rsvd.
> ---
>  arch/x86/include/asm/kvm_host.h |  2 +-
>  arch/x86/kvm/pmu.c              |  6 +++++-
>  arch/x86/kvm/svm/pmu.c          | 12 +++++++++---
>  arch/x86/kvm/vmx/pmu_intel.c    | 12 ++++++------
>  4 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e473796da7d9..90d80483df7f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -580,7 +580,7 @@ struct kvm_pmu {
>  	u64 counter_bitmask[2];
>  	u64 global_ctrl_rsvd;
>  	u64 global_status_rsvd;
> -	u64 reserved_bits;
> +	u64 eventsel_rsvd;
>  	u64 raw_event_mask;
>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 8f2effee3b7b..964e74bdaaa7 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -989,7 +989,11 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->nr_arch_fixed_counters = 0;
>  	pmu->counter_bitmask[KVM_PMC_GP] = 0;
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
> -	pmu->reserved_bits = 0xffffffff00200000ull;
> +	/*
> +	 * KVM is not able to emulate the AnyThread bit due to cross-VM
> +	 * information leakage on SMT cores.
> +	 */
> +	pmu->eventsel_rsvd = GENMASK_ULL(63, 32) | ARCH_PERFMON_EVENTSEL_ANY;
>  	pmu->raw_event_mask = X86_RAW_EVENT_MASK;
>  	pmu->global_ctrl_rsvd = ~0ull;
>  	pmu->global_status_rsvd = ~0ull;
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index c18286545a7a..52224872e0d4 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -163,7 +163,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	/* MSR_EVNTSELn */
>  	pmc = get_gp_pmc_amd(pmu, msr, PMU_TYPE_EVNTSEL);
>  	if (pmc) {
> -		data &= ~pmu->reserved_bits;
> +		data &= ~pmu->eventsel_rsvd;
>  		if (data != pmc->eventsel) {
>  			pmc->eventsel = data;
>  			pmc->eventsel_hw = (data & ~AMD64_EVENTSEL_HOSTONLY) |
> @@ -214,9 +214,15 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  
>  	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
>  
> -	pmu->reserved_bits = 0xfffffff000280000ull;
> +	/*
> +	 * AMD PerfEvtSeln registers do not support PinControl, and KVM does
> +	 * not emulate AnyThread due to cross-VM information leakage on SMT
> +	 * cores (as on the Intel side).
> +	 */
> +	pmu->eventsel_rsvd = GENMASK_ULL(63, 36) | ARCH_PERFMON_EVENTSEL_PIN_CONTROL |
> +			     ARCH_PERFMON_EVENTSEL_ANY;
>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
> -		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
> +		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
>  
>  	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
>  	/* not applicable to AMD; but clean them to prevent any fall out */
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 322a3ad580dd..11c9161dc853 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -385,7 +385,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	struct kvm_pmc *pmc;
>  	u32 msr = msr_info->index;
>  	u64 data = msr_info->data;
> -	u64 reserved_bits, diff;
> +	u64 eventsel_rsvd, diff;
>  
>  	switch (msr) {
>  	case MSR_CORE_PERF_FIXED_CTR_CTRL:
> @@ -433,11 +433,11 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			pmc_write_counter(pmc, data);
>  			break;
>  		} else if ((pmc = get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0))) {
> -			reserved_bits = pmu->reserved_bits;
> +			eventsel_rsvd = pmu->eventsel_rsvd;
>  			if ((pmc->idx == 2) &&
>  			    (pmu->raw_event_mask & HSW_IN_TX_CHECKPOINTED))
> -				reserved_bits ^= HSW_IN_TX_CHECKPOINTED;
> -			if (data & reserved_bits)
> +				eventsel_rsvd ^= HSW_IN_TX_CHECKPOINTED;
> +			if (data & eventsel_rsvd)
>  				return 1;
>  
>  			if (data != pmc->eventsel) {
> @@ -545,7 +545,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (entry &&
>  	    (boot_cpu_has(X86_FEATURE_HLE) || boot_cpu_has(X86_FEATURE_RTM)) &&
>  	    (entry->ebx & (X86_FEATURE_HLE|X86_FEATURE_RTM))) {
> -		pmu->reserved_bits ^= HSW_IN_TX;
> +		pmu->eventsel_rsvd ^= HSW_IN_TX;
>  		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
>  	}
>  
> @@ -584,7 +584,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	if (perf_capabilities & PERF_CAP_PEBS_FORMAT) {
>  		if (perf_capabilities & PERF_CAP_PEBS_BASELINE) {
>  			pmu->pebs_enable_rsvd = counter_rsvd;
> -			pmu->reserved_bits &= ~ICL_EVENTSEL_ADAPTIVE;
> +			pmu->eventsel_rsvd &= ~ICL_EVENTSEL_ADAPTIVE;
>  			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
>  			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
>  		} else {

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990224;
	b=l8bph0/7+be4y/bgu7G3wm8DV6kX3D3IdLoAjEUrS849O7KlXcV2Ebtt9/K0lecoa/ky
	 QMT5LsZTF3Y1XHANDIMmI9kay7jE1udEoS7xuCBH7BEB+UJSBILl4nHv9VhX51ypFq/J2
	 3phv9/NN38a2xdO/bLG7jBxoBdlWuOyzZ4Sx6lWYRmG+v2ZQFahKqcCbY4QY3BjyuIiu+
	 8OKTsV11V862D8TjBTETDIDGTC8gzM6ZftllcIzqBbgynANCwgw038rPr2ZOwAjkcDwkR
	 1Z0VOQjLiVqzAigCMD4aVdF+JLt2sFeU5ATE3AdzdM9dghzrzhc0PuXTLU8+y2/MbDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990224;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nwmGbMmc/+3I+KKxxtFTReRzpqbjsS9Rdng+DNRWEjM=;
	b=HlwEb+s4VYt+Ut2UKSy9O4AkT9W5kSQeu2oppqLYTEvM4e6LPD/XI69yK8X8HlOoAzFe
	 BU7rkI6sQaaHml/kFbkxIzRp5+PwUR3qBgDTzyublas4jzw1E9ribyU843/E2tPjN5Fs6
	 DQv5AcnhCtv+UCUeNM/+KEtO5DYV0s/MGOSpy+3fjJ0ko0g5FgG+a7n/9SFm+/f7GUsE3
	 dmw8McA30AlARu1rMm85SZGTg90qNkG4EZn7RdlJrkSXJ73B+q+58z2BS1zzKeEK9Swpz
	 ZccO09rWobuVIuDTsID8Q0cPhqAu32dyM0u7OqnvX9NIexAqKXgF/7gMPJYVRp2Znbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTlarG8g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268D3606A335;
	Fri,  6 Nov 2026 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NTlarG8g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A24F1F00906;
	Fri,  6 Nov 2026 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990223;
	bh=nwmGbMmc/+3I+KKxxtFTReRzpqbjsS9Rdng+DNRWEjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NTlarG8g1mzPMEiwawgpKwZLsA+lya3SE4HOyO+AkbnfybQOSBn97TOBcoBI08Hwn
	 18WYc+9qmyLhFkPlc0ja4+zcz08uVo3lGs6AykaTPp0zxF5PB/moG/wu1v//A7p2mj
	 oLAWyye5C8kszrSY6cAhWxuUrXYmdnI4BdLabLTuXkjCGkTdP6tmaZ4YZY8oDwXgv2
	 csIFTvCZ3N5aU+Ccgt4H+m/CO8F2ggLv8h4a0JiXNlvDiQ3HVk+sRmD4dsGGmV/JZY
	 +WmSPEWbJuDHA9rXeXSPL4aAX4q9DkSRlXx6VyvH5eTV1dyapq8UYNZyrStIH1T0li
	 cIuQZoVofbZjQ==
Date: Fri, 6 Nov 2026 18:37:01 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 03/18] KVM: x86/pmu: Rename reserved_bits to
 eventsel_rsvd in kvm_pmu
Message-ID: <au4dVD2cZbvoqEa4@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-4-zide.chen@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106013927.166209-4-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:12PM -0700, Zide Chen wrote:
> This field stores the bits that are reserved in guest IA32_PERFEVTSELx
> MSRs. Rename it to eventsel_rsvd to better reflect its purpose and to
> align with other field names in struct kvm_pmu.
> 
> Opportunistically, replace magic numbers with macros.
> 
> No functional change intended.
> 
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>
> ---
> v3:
> - Mention "magic numbers" in changelog to cover AMD as well.
> 
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
> index 72b8fbf432a2..b8875ed5502c 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -581,7 +581,7 @@ struct kvm_pmu {
>  	u64 counter_bitmask[2];
>  	u64 global_ctrl_rsvd;
>  	u64 global_status_rsvd;
> -	u64 reserved_bits;
> +	u64 eventsel_rsvd;
>  	u64 raw_event_mask;
>  	struct kvm_pmc gp_counters[KVM_MAX_NR_GP_COUNTERS];
>  	struct kvm_pmc fixed_counters[KVM_MAX_NR_FIXED_COUNTERS];
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 83883191d124..cbd63329cf13 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -983,7 +983,11 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
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

It's probably better if we diff against the generic pmu->eventsel_rsvd
set by kvm_pmu_refresh(), and explicitly add/remove bits as needed here,
like the Intel code. Then we also avoid re-iterating the AnyThread
rationale here.

What do you think?


>  	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) && kvm_vcpu_has_mediated_pmu(vcpu))
> -		pmu->reserved_bits &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;
> +		pmu->eventsel_rsvd &= ~AMD64_EVENTSEL_HOST_GUEST_MASK;

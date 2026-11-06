Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992188;
	b=czjQNtsiXosFDN4puu0M7gdX5/hN7+GnXmhMLvh+oaoKzMsOBxcots50RQGbtel209Ls
	 L7fPFHsQMjHGFZpheu2rjmpGempiWvwaWyhBF3syZhlyDTyzHdQW9VBy39TUhB/2QGk8w
	 r78nNKswqxOQ/90n2wflw5giLnyCFI+QHetGuY2db9C38RLhuUWk2maS6lOQoHahnff3r
	 AQHvtN481Pc2f26MZUtx2Ig6vBjX5xT7c9nnHj6q8+LBO/jXbh9WM+2y1iu5Pp3gOyIzA
	 YU9s4OlsNpjCwu98AqvOb2Km+jPrZet8MKrdk1bBwG5+3oZkBobTl8sDdMiUi+uWjQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992188;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RDhcP0lja7u7niC0lecBHjsnrUkUgFUO1GdcbY/uzWU=;
	b=k3KoLrPHEdyoORGgDwZoG+q6+XtyKw5KoUX/aCHiwEpstrWKdvVea2uEI3nofS2rYCcX
	 +UZZvazch151Tavsn9dFbFnPoSEjyYCX3NxOBaa5yMCHl2ctzUs1fcIJ7WZqb0wS1nuds
	 hIaG2w7dB+hciA0TYBrPO71OenEJ1OqNmGRk7rMf/hO4HOkJMCb7iJASgaXB3liVsvc1B
	 lxmytTbjeuBdtya6HDAOYwZk+cOMivQQYEj756cjmS61RUqb2I2BDTvRqMiPDObHOGo5V
	 YqKQ1Xvn6Wmj90Is6PPDbgziK685NDTH7I6KLpTocuQAg+K1R5Qoj2lTOzzZxIG1FwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flc3ByXq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5238606A326;
	Fri,  6 Nov 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flc3ByXq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228721F0089F;
	Fri,  6 Nov 2026 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793992187;
	bh=RDhcP0lja7u7niC0lecBHjsnrUkUgFUO1GdcbY/uzWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=flc3ByXq2Rg/PYxoDGoDeuND0i5eBLtbotiMyfexYbsrSQztDdkn3K4xfmV/hShQd
	 7kpabE5dZ1rEBQSvLJYEYqjn4EQpLFMengvjmRg9jiQlQ76By7mJfVZCu6g0dg16Wh
	 HFE1r/huW7d2qevgBOUq3iWLA6F66QzsfXhd5LyK/nwjJmjTYpYfr2E5DCL1wXSj/e
	 4Tg9eXjhM6Ar3sBoJ7CyjNTUMAiJRNg6AxzbXdvoVlZXAbYzEYo2AFAnhUkIjeyJMl
	 PKc9GaCvOIUIUVLeMuqTgq24YQzLodLyU1P3cyBb/4xJ7hsG0utk1xwnPyjTSWHBMk
	 YZH52Jm/HfnUQ==
Date: Fri, 6 Nov 2026 19:09:45 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>, 
	Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
Message-ID: <au4kyULjUYdqbfIq@google.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com>
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
In-Reply-To: <20261106013927.166209-5-zide.chen@intel.com>

On Thu, Nov 05, 2026 at 06:39:13PM -0700, Zide Chen wrote:
> pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
> may include non-contiguous GP or fixed counters.
> 
> pmu->pmc_exists already holds a bitmap indicating both fixed and
> general-purpose counters, and loops over valid counters can be done via
> pmu->pmc_exists alone. Extend it to a union so that the u64 alias is
> available for convenient mask arithmetic operations.
> 
> Add the necessary helpers to prepare for bitmap-based PMC counter
> implementation.
> 
> No functional change intended.
> 
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> ---
> v3:
> - Add BUILD_BUG_ON(). (Jim)
> v2:
> - Rename kvm_{gp,fixed}_pmc_supported() to kvm_is_{gp,fixed}_pmc_supported()
>   and simplify them by removing the temporary bitmap. (Sean)
> - Split kvm_for_each_set_pmc_idx() to kvm_for_each_gp_counter()
>   and kvm_for_each_fixed_counter(). (Sean)
> ---
>  arch/x86/include/asm/kvm_host.h |  5 +++-
>  arch/x86/kvm/pmu.c              |  2 ++
>  arch/x86/kvm/pmu.h              | 53 +++++++++++++++++++++++++++++----
>  3 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index b8875ed5502c..4f192429ed93 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -595,7 +595,10 @@ struct kvm_pmu {
>  		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>  		atomic64_t __reprogram_pmi;
>  	};
> -	DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> +	union {
> +		DECLARE_BITMAP(pmc_exists, X86_PMC_IDX_MAX);
> +		u64 pmc_exists64;

__pmc_exists would be more consistent with __reprogam_pmi above.

> +	};
>  	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
>  
>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index cbd63329cf13..5e174d95f3b7 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -1024,6 +1024,8 @@ void kvm_pmu_init(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
>  
> +	BUILD_BUG_ON(sizeof(pmu->pmc_exists) != sizeof(pmu->pmc_exists64));
> +
>  	memset(pmu, 0, sizeof(*pmu));
>  	kvm_pmu_call(init)(vcpu);
>  }
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 090c9bbb74f4..016935c3a8ec 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -88,6 +88,30 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>  }
>  
> +static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return pmu->pmc_exists64 &
> +	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
> +}
> +
> +static inline unsigned long kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return (pmu->pmc_exists64 >> KVM_FIXED_PMC_BASE_IDX) &
> +	       GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
> +}
> +
> +static inline bool kvm_is_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> +{
> +	return idx < KVM_MAX_NR_GP_COUNTERS &&
> +	       test_bit(idx, pmu->pmc_exists);
> +}
> +
> +static inline bool kvm_is_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> +{
> +	return idx < KVM_MAX_NR_FIXED_COUNTERS &&
> +	       test_bit(KVM_FIXED_PMC_BASE_IDX + idx, pmu->pmc_exists);
> +}
> +
>  /*
>   * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
>   * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
> @@ -104,11 +128,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>   */
>  static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>  {
> -	if (idx < pmu->nr_arch_gp_counters)
> +	if (kvm_is_gp_pmc_supported(pmu, idx))
>  		return &pmu->gp_counters[idx];
>  
>  	idx -= KVM_FIXED_PMC_BASE_IDX;
> -	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
> +	if (kvm_is_fixed_pmc_supported(pmu, idx))
>  		return &pmu->fixed_counters[idx];
>  
>  	return NULL;
> @@ -120,6 +144,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>  			continue;				\
>  		else						\
>  
> +/*
> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
> + * so iteration up to KVM's maximum counter count is safe.
> + */
> +#define kvm_for_each_gp_counter(i, mask)	\
> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> +
> +#define kvm_for_each_fixed_counter(i, mask)	\
> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)

These are not used in this patch, are they?

They should probably be introduced when they are used. Also, do we
always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
yes, maybe we should pass in the pmu here instead?

> @@ -183,9 +221,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
>  {
>  	int base = MSR_CORE_PERF_FIXED_CTR0;
>  
> -	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
> +	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
>  		u32 index = array_index_nospec(msr - base,
> -					       pmu->nr_arch_fixed_counters);
> +					       KVM_MAX_NR_FIXED_COUNTERS);
> +
> +		if (!kvm_is_fixed_pmc_supported(pmu, index))
> +			return NULL;

Do all callers handle NULL correctly? At least
reprogram_fixed_counters() doesn't look like it. It may be fine since
NULL can already be returned today. Not sure if this series makes it
more likely.

>  
>  		return &pmu->fixed_counters[index];
>  	}
> -- 
> 2.56.0
> 

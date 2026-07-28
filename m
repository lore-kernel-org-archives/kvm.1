Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B63D9DA0
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266912; cv=none; b=Gy/z2QuI5dTq2hQ+R7tMNS9jICObJr/WsigHHuMkiRRGOIn7cG4d9ElT73Q8Ln2RG5jI3T8A9eXMxIyPnDt9v+5CmGA0bnUv+56qV0fXiUtM6LbTBcS7SVpxDaWnRn/TI3eBvGmrOqqVEkHc3ZRwacM5/EqthbsALh00MWTBsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266912; c=relaxed/simple;
	bh=c8rc1ooakAdwyrFj/ge4EiYA7nGIfY+Q9+oq6GxMo3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sM2QOXtuCISZN3DHx/ax3m5HuTUGQhO0ISjvitk7v/969eXW15i8NTFO9Z1KBmM2ARha/cOEtCipvwOuToyArTN81hgzXnMNWAejTOycVGU6GsMTsTDVJoBZQlokRXb+OJhe4qPeu7olHG/6wHuMkkz6YXl041B545BPU7CaXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GNL0nukV; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GNL0nukV"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so191095a91.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785266910; x=1785871710; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WljxIoakW4bzVRogXO2Fd04lTybnc8bYrlaiEJNac+k=;
        b=GNL0nukVUEK+utVhK9be7oMLb23b7+8ZXIDVSzoPfRTYRSmOUFdGtVoh++USD1wPDx
         DcAQDdaFX8NCk0Mi1AQ0ULtnJwmLbNZ6H/UKuM347YGGvakokNqqARfERql8ztIxiiAy
         LKpwrUk+PFARvzJJeGNE7BiTHNuwOYxho8xKwOeEwfGVIA6grZCMa46rUj2s96m0spUB
         QrKsp6iZ1t/f+rAVbbU8ukvhsPWZZNLivgh+7dh1GlocEo+fwYRPlIuxIPzbcMUqPdk8
         r+gNlbHi9N8AgwYlXB6Gs4uC7UFZ1OHAk2+ylMnnuResL3OUgrLySWcZtuFTKTrlHP20
         bqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266910; x=1785871710;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WljxIoakW4bzVRogXO2Fd04lTybnc8bYrlaiEJNac+k=;
        b=eUsAE77o0R+ZuNRRz3vDMEFUqz2wey74D2007Wlf33YRR15pP5T9ig8URIWWQZ7vkQ
         WmYa/ZBlxkmW36K4CtCapYkLOsQ0M+dhcFUmz99QHxTGauEoxF8A+mpBHCBcu6Z6b4l4
         /NKGoU2PEtjSZxERpUJ475+HAi94X86PliroE2hYKG279avySnUgWtx1tQaWoai+t3D7
         u0fff3t1atdqz3GMcZ2egZfgf0xaG9oECDRPFOeM36KVM0ChbXYKLfEFEKBR2yQyi7JZ
         yb0a6SQllOrIbdEt2Jz92d3srUAme6mhE590JAn2v7ZSW8m2GV0WxSWcHSSK14CI2egO
         6sbw==
X-Forwarded-Encrypted: i=1; AHgh+RqcqdNQOsr9HxT07IPSiDz+rpDmdPFmot9y1ClpHKtz+tla23ggSkZWSc8ujjbvdiCIic8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbc2A73GIOdljGB6QnlfY3E12/Vni/Nh3yhbAQABO9ejt5yaf+
	0bSr9SDu1nYiN72UcHMT6Hq9psOHT/jcBeEOYlwpiQy7aRoWgIZf8OTgnbc2MLToNlovbsCBRma
	9WKf8WA==
X-Received: from pjbnk13.prod.google.com ([2002:a17:90b:194d:b0:380:ce47:d7c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f94c:b0:37e:10d1:c05b
 with SMTP id 98e67ed59e1d1-38f6a3db2d8mr2610100a91.22.1785266910215; Tue, 28
 Jul 2026 12:28:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:28:29 -0700
In-Reply-To: <20260707183405.15571-5-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-5-zide.chen@intel.com>
Message-ID: <amkC3aR32DMkjdzH@google.com>
Subject: Re: [PATCH 04/15] KVM: x86/pmu: Add PMC bitmap accessor helpers
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 07, 2026, Zide Chen wrote:
> pmu->nr_arch_{gp,fixed}_counters is not able to represent that a PMU
> may include non-contiguous GP or fixed counters.
> 
> pmu->all_valid_pmc_mask already holds a bitmap indicating both fixed
> and general-purpose counters, and loops over valid counters can be
> done via pmu->all_valid_pmc_mask alone. Extend it to a union so that
> the u64 alias is available for convenient mask arithmetic operations.
> 
> Add the necessary helpers to prepare for bitmap-based PMC counter
> implementation.
> 
> No functional change intended.
> 
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  5 ++-
>  arch/x86/kvm/pmu.h              | 55 +++++++++++++++++++++++++++++----
>  2 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 395b6f20e9ac..f648dc168685 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -643,7 +643,10 @@ struct kvm_pmu {
>  		DECLARE_BITMAP(reprogram_pmi, X86_PMC_IDX_MAX);
>  		atomic64_t __reprogram_pmi;
>  	};
> -	DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
> +	union {
> +		DECLARE_BITMAP(all_valid_pmc_mask, X86_PMC_IDX_MAX);
> +		u64 all_valid_pmc_mask64;
> +	};
>  	DECLARE_BITMAP(pmc_in_use, X86_PMC_IDX_MAX);
>  
>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index cdbefda844b9..95dc95a9ae37 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -88,6 +88,32 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>  	return enable_mediated_pmu && vcpu_to_pmu(vcpu)->version;
>  }
>  
> +static inline unsigned long kvm_gp_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return pmu->all_valid_pmc_mask64 &
> +	       GENMASK_ULL(KVM_MAX_NR_GP_COUNTERS - 1, 0);
> +}
> +
> +static inline unsigned long kvm_fixed_pmc_mask(struct kvm_pmu *pmu)
> +{
> +	return (pmu->all_valid_pmc_mask64 >> KVM_FIXED_PMC_BASE_IDX) &
> +		GENMASK_ULL(KVM_MAX_NR_FIXED_COUNTERS - 1, 0);
> +}
> +
> +static inline bool kvm_gp_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)

kvm_is_gp_pmc_supported()
    ^^

> +{
> +	unsigned long bitmap = kvm_gp_pmc_mask(pmu);
> +
> +	return idx < KVM_MAX_NR_GP_COUNTERS && test_bit(idx, &bitmap);

Why generate the full bitmap?  Isn't this equivalent in practice?

	return idx < KVM_MAX_NR_GP_COUNTERS &&
	       test_bit(idx, pmu->all_valid_pmc_mask);

> +static inline bool kvm_fixed_pmc_supported(struct kvm_pmu *pmu, unsigned int idx)
> +{
> +	unsigned long bitmap = kvm_fixed_pmc_mask(pmu);
> +
> +	return idx < KVM_MAX_NR_FIXED_COUNTERS && test_bit(idx, &bitmap);
> +}
> +
>  /*
>   * KVM tracks all counters in 64-bit bitmaps, with general purpose counters
>   * mapped to bits 31:0 and fixed counters mapped to 63:32, e.g. fixed counter 0
> @@ -104,11 +130,11 @@ static inline bool kvm_vcpu_has_mediated_pmu(struct kvm_vcpu *vcpu)
>   */
>  static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>  {
> -	if (idx < pmu->nr_arch_gp_counters)
> +	if (kvm_gp_pmc_supported(pmu, idx))
>  		return &pmu->gp_counters[idx];
>  
>  	idx -= KVM_FIXED_PMC_BASE_IDX;
> -	if (idx >= 0 && idx < pmu->nr_arch_fixed_counters)
> +	if (kvm_fixed_pmc_supported(pmu, idx))
>  		return &pmu->fixed_counters[idx];
>  
>  	return NULL;
> @@ -120,6 +146,17 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>  			continue;				\
>  		else						\
>  
> +/*
> + * @mask must be an lvalue of type unsigned long because for_each_set_bit()
> + * takes its address.
> + *
> + * @type is token-pasted into KVM_MAX_NR_##type##_COUNTERS to match one of the
> + * counter defines, e.g. GP, FIXED, AMD_GP, INTEL_GP, or INTEL_FIXED. This
> + * reflects what KVM supports, not the underlying host's PMU capabilities.
> + */
> +#define kvm_for_each_set_pmc_idx(i, mask, type)		\
> +	for_each_set_bit((i), &(mask), KVM_MAX_NR_##type##_COUNTERS)


Provide dedciated macros instead of requiring the caller to pass in a type and
then doing token pasting, e.g.

  #define kvm_for_each_gp_counter()

  #define kvm_for_each_fixed_counter()

>  static inline u64 pmc_bitmask(struct kvm_pmc *pmc)
>  {
>  	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> @@ -168,9 +205,12 @@ static inline bool kvm_valid_perf_global_ctrl(struct kvm_pmu *pmu,
>  static inline struct kvm_pmc *get_gp_pmc(struct kvm_pmu *pmu, u32 msr,
>  					 u32 base)
>  {
> -	if (msr >= base && msr < base + pmu->nr_arch_gp_counters) {
> +	if (msr >= base && msr < base + KVM_MAX_NR_GP_COUNTERS) {
>  		u32 index = array_index_nospec(msr - base,
> -					       pmu->nr_arch_gp_counters);
> +					       KVM_MAX_NR_GP_COUNTERS);
> +
> +		if (!kvm_gp_pmc_supported(pmu, index))
> +			return NULL;
>  
>  		return &pmu->gp_counters[index];
>  	}
> @@ -183,9 +223,12 @@ static inline struct kvm_pmc *get_fixed_pmc(struct kvm_pmu *pmu, u32 msr)
>  {
>  	int base = MSR_CORE_PERF_FIXED_CTR0;
>  
> -	if (msr >= base && msr < base + pmu->nr_arch_fixed_counters) {
> +	if (msr >= base && msr < base + KVM_MAX_NR_FIXED_COUNTERS) {
>  		u32 index = array_index_nospec(msr - base,
> -					       pmu->nr_arch_fixed_counters);
> +					       KVM_MAX_NR_FIXED_COUNTERS);
> +
> +		if (!kvm_fixed_pmc_supported(pmu, index))
> +			return NULL;
>  
>  		return &pmu->fixed_counters[index];
>  	}
> -- 
> 2.54.0
> 

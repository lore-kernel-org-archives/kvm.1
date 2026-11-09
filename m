Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261614;
	b=cErUu3ZV57+X09WE01wq2pNj0tPm2HfNI4mn6I0kXPS8Vs1scZGYfVgcB/tErOdjZQ9o
	 eOzanDfG2Y4AElKgaO5LXUWRK7ck1201PKaa8t4EOxSsX5kd1+kD0FDaz+1wacRIL3YYv
	 mm4M94LjbXXTjnrsTQjCOZwno7gQ3L8Cu0vHUCesAmSrNpYTT2XsIp8jxB1LtmkEI7esi
	 AwOXPBXtuaAL98ltMd66Soe9hzKCxAxd8E+uDI8ZzoAfcSlIwF4yYKie2LsaBaxoR8Bsv
	 OBLzcGz2Aq57Nj7Hbs0xdDYkwQDgqU+rTyJrrY64AyNr+Az1vmaevrQyLq77vbXuUnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261614;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/tIMJ84JZNY36MRroCaRF81WiSus/b/UO47cyKClHKA=;
	b=tLc/uRwLSr0e7TmC5ouJPBT8IJjn3OXuk4c8okljakE+coU2Gt+36vV2mhafqmbFBamj
	 KFRThFH7l9ZgZngRYQs/9yotoCHjjqD5m4qGfgN6ha+zb8G89w0kOyf9o9WSOJx9O3if3
	 3bTE06L5o9dQyPL0iCMPZ6q21SzN4++e5mZ0DY48Cq/cpxNtIbgTpFPzsCtjYqxEkW5M4
	 bBbWso8E1mFNR0pMAUFZ7yGrja+2Hu+jairhOLYkIoPKkUBy10vYTBbR17V7+pT6IbRuP
	 UGyQyqXBWlhmEkixuuWfoImdu2mA08X31Skd3kLpxAHXRmvn0Puqk7m8pi7TaSLGohA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O8iua+t7;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A8606A31C;
	Mon,  9 Nov 2026 22:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF1A8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=O8iua+t7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794261614; x=1825797614;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XA6H0x3ntr/Cc1TmCFZhqqstcdGHUz1VfSRh9Nu+IzQ=;
  b=O8iua+t7DGtAAJF3anvBZkx0EVLFXdpeDs3VuPJtZaNDfqUKtNnBbGPE
   X6mxbFueCnWvp8qpF+Ca0O17MEELse9MvvtI7u/GNZ9KwCgBDqXf3WI3v
   idGHLtfaPr3tntubz00HPJ1zLQ8AOSgf4HWOZjHbrt7RcBydxtdYHU9C9
   8z3jd8Uozvv0Rclpob4kciHDkpI76i6SRNkw4z21Gbc3P3JqZIQ55U8NJ
   1m1lZj2uWcYAMUb1sTIHKFn26iJE6EpaiFNMmckCT74RioaWbiOsobbvX
   IMa1SIXzrjIdYAEChm23s1dNWJ6Mm26wb9Y8UqUzORwqv+rp4KDwZejXf
   Q==;
X-CSE-ConnectionGUID: oGHOJyD5RpSppp7zaAz2gw==
X-CSE-MsgGUID: v1YmuL+SQEWbryx8vuO6cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3083033"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3083033"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:59:47 -0800
X-CSE-ConnectionGUID: 3TN/MOurRhKAiAia3RpTuw==
X-CSE-MsgGUID: DdzIP4OsQ96zDL0G9A3n2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8289484"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.184.228]) ([10.122.184.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:59:28 -0800
Message-ID: <650a864a-2f20-4864-b29f-7cbe822e894a@intel.com>
Date: Mon, 9 Nov 2026 15:59:27 -0600
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] KVM: x86/pmu: Add PMC bitmap accessor helpers
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
 linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Das Sandipan <Sandipan.Das@amd.com>, Shukla Manali <Manali.Shukla@amd.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261106013927.166209-1-zide.chen@intel.com>
 <20261106013927.166209-5-zide.chen@intel.com> <au4kyULjUYdqbfIq@google.com>
 <531bd088-dc5e-4b2e-953a-6d9d6f14b61e@intel.com>
 <CAO9r8zMs+aBPN-w7L3nZxwVV-Dr2f0tBYBjicDsdYVp_Mc2AWg@mail.gmail.com>
 <e977b107-7762-46d3-ba31-832eb9ae609c@intel.com>
 <CAO9r8zPVt++jgZD3-Jd-DYKMjYyAfUuQkvEXD4pKqe0bdYE29A@mail.gmail.com>
 <c2844568-f8f6-450e-a718-1e9e3b7b3e4b@intel.com>
 <avI20tEzyvIshy2f@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <avI20tEzyvIshy2f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/9/2026 3:12 PM, Yosry Ahmed wrote:
> On Mon, Nov 09, 2026 at 12:59:01PM -0600, Chen, Zide wrote:
>>
>>
>> On 11/9/2026 12:07 PM, Yosry Ahmed wrote:
>>>>>>>> +/*
>>>>>>>> + * @mask is expected to be a scalar unsigned long derived from pmu->pmc_exists,
>>>>>>>> + * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
>>>>>>>> + * so iteration up to KVM's maximum counter count is safe.
>>>>>>>> + */
>>>>>>>> +#define kvm_for_each_gp_counter(i, mask)    \
>>>>>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
>>>>>>>> +
>>>>>>>> +#define kvm_for_each_fixed_counter(i, mask) \
>>>>>>>> +    for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
>>>>>>>
>>>>>>> These are not used in this patch, are they?
>>>>>>>
>>>>>>> They should probably be introduced when they are used. Also, do we
>>>>>>> always end up passing kvm_gp_pmc_mask() and kvm_fixed_pmc_mask()? If
>>>>>>> yes, maybe we should pass in the pmu here instead?
>>>>>>
>>>>>> The intent was to group all bitmap accessor helpers together in this
>>>>>> patch for easier review so that the big patch 5/18 could be kept to
>>>>>> mostly mechanical replacements.
>>>>>>
>>>>>> But if you prefer introducing them on first use, I'll move their
>>>>>> definitions to patch 5.
>>>>>
>>>>> Yeah I think it's clearer to see what their definitions are with their usage.
>>>>
>>>> OK, then I can move these two macros to the next patch.
>>>>>>
>>>>>> Regarding passing 'pmu' directly, I initially implemented it in this
>>>>>> way, but I can't recall why I discarded it. I will take another look.
>>>>>
>>>>> Thanks.
>>>>
>>>> How about these? With them, we can remove the {gp,fixed}_mask variables
>>>> that you pointed out in your review of 5/18. The APIs are more
>>>> complicated, but the caller code is much cleaner.
>>>
>>> I don't understand why we can't keep the macros as-is, but just move the
>>> calls to kvm_gp_pmc_mask() and kvm_fixed_pmc_mask() inside the macros?
>>
>> for_each_set_bit() requires a pointer (`const unsigned long *`) as
>> input, but AFAICT a loop macro cannot declare a temporary local
>> variable, nor it can use do { ... } while(0). So something like:
>>
>> #define kvm_for_each_gp_counter(i, pmu)                              \
>>         unsigned long gp_mask = kvm_gp_pmc_mask(pmu);                   \
>>         for_each_set_bit((i), &(gp_mask), KVM_MAX_NR_GP_COUNTERS)
>>
> 
> Gemini suggested compount literals, and it seems to at least compile and
> I see a few instances around the kernel:
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index f949fdbf359c6..3930680937577 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -1347,8 +1347,6 @@ static __always_inline u32 gp_eventsel_msr(u32 idx)
>  static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> -	unsigned long fixed_mask = kvm_fixed_pmc_mask(pmu);
> -	unsigned long gp_mask = kvm_gp_pmc_mask(pmu);

I am very happy to see these variables go away. Thank you!

>  	struct kvm_pmc *pmc;
>  	u32 i;
>  
> @@ -1357,14 +1355,14 @@ static void kvm_pmu_load_guest_pmcs(struct kvm_vcpu *vcpu)
>  	 * is intercepted if hardware has counters that aren't visible to the
>  	 * guest (KVM will inject #GP as appropriate).
>  	 */
> -	kvm_for_each_gp_counter(i, gp_mask) {
> +	kvm_for_each_gp_counter(i, pmu) {
>  		pmc = &pmu->gp_counters[i];
>  
>  		if (pmc->counter != rdpmc(i))
>  			wrmsrq(gp_counter_msr(i), pmc->counter);
>  		wrmsrq(gp_eventsel_msr(i), pmc->eventsel_hw);
>  	}
> -	kvm_for_each_fixed_counter(i, fixed_mask) {
> +	kvm_for_each_fixed_counter(i, pmu) {
>  		pmc = &pmu->fixed_counters[i];
>  
>  		if (pmc->counter != rdpmc(INTEL_PMC_FIXED_RDPMC_BASE | i))
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 98e6f2443b82e..37a6664fdb9c9 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -149,11 +149,11 @@ static inline struct kvm_pmc *kvm_pmc_idx_to_pmc(struct kvm_pmu *pmu, int idx)
>   * which is already constrained by KVM_MAX_NR_{AMD,INTEL}_{GP,FIXED}_COUNTERS,
>   * so iteration up to KVM's maximum counter count is safe.
>   */
> -#define kvm_for_each_gp_counter(i, mask)	\
> -	for_each_set_bit((i), &(mask), KVM_MAX_NR_GP_COUNTERS)
> +#define kvm_for_each_gp_counter(i, pmu)	\
> +	for_each_set_bit((i), &(unsigned long){ kvm_gp_pmc_mask(pmu) }, KVM_MAX_NR_GP_COUNTERS)
>  
> -#define kvm_for_each_fixed_counter(i, mask)	\
> -	for_each_set_bit((i), &(mask), KVM_MAX_NR_FIXED_COUNTERS)
> +#define kvm_for_each_fixed_counter(i, pmu)	\
> +	for_each_set_bit((i), &(unsigned long){ kvm_fixed_pmc_mask(pmu) }, KVM_MAX_NR_FIXED_COUNTERS)

Right, I didn't realize C99 compound literals could be used here.

However, with this suggested code, kvm_gp_pmc_mask() would be
re-evaluated on every iteration. It seems this “expression with side
effects evaluated more than once” is not encouraged by the coding style,
is it?


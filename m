Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8D3A8732
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875623; cv=none; b=BPX26A6uxZ5u4mbIr5Y5RaujiMPuT38pet/bHHFQzc3c5hHr1Vlizz13smwITM4i6usrP6QmgSIIjPwCw55BKRf0/d3Urm+tILjBPhA8KFwSIuQYwMhAEGExPqsdf6Jnq26kcUKFLkmKkIr4Wv7Z2E8D5Q3fxw9WshFItmmOgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875623; c=relaxed/simple;
	bh=vRUGJw9BAMFCGnXscACwZJ+tG0aDtT69KLt/YulbvrE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BRve65PCBz9oUfZjwXACK590JBHBqfi50spra8EOb4A3572eda31wRDYBSvzjCXj2WQ9FOkRWu9SkaNJgHMf3jLzqp5sqaDxO2WYx9Qh0ND2cCsmhTICHSJCtxPZU/OPUW02I8YgWAarswdw4gcNQ77IGFR0qWfQvc+0Kn3NrhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dn+/jGH2; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dn+/jGH2"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84842381150so349375b3a.3
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785875622; x=1786480422; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rgR3cl9eKhmIgasAHpP260L2tvxwInY+KO3KZG837T0=;
        b=dn+/jGH2I3tXngtBv5rE/zC3Zowd2zf5IKB4squqPmLSGH/8LVzLmSofkDGyzn7DUY
         RVJ+t9x8ZRDbGdqUhahAKaT/pvbaBnMxe2OByJBM0qLMr+KoebkzEZLax3WaYBLSv34a
         byogVgkgtV7wXI4GprKZ/0ujbYEHWIyZS/8iA5fAKzMov5WMLjyrg7kQHt+7mbwso0CL
         Mo5tgTaW5OfLe53ay/yUcQQMIHFqTIz9NT7NFRnMrz6uUz8IOinOpLotKVtu5T+2gM8D
         CFAyFrboQ5ppynweyYNNBEBO9nwDBYHV71k7mCr3QW8zXCMJD4a9GBesp5pu1qGesKTR
         4jVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785875622; x=1786480422;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgR3cl9eKhmIgasAHpP260L2tvxwInY+KO3KZG837T0=;
        b=DLM+a2nP17bp8D9iNK7ueSooR+YfUiZNhjouYb8fNprHXXfEmyDZ12ZFMxoNwRsQvv
         V24M0n9gHqvsQRXUC+XVLWFWAMOZYtKvKbEEu8uwC4YG0g4UzBg16lrggGAqbO9R3R4G
         DxWMA+GwpbD+WE0eIYeq2r9I1ccGkPh1MITJKnS8HyNGDt4o5BjkK12BF1JQUpAluF09
         yfuWpZJ6LiV6LGwZzFtoAyaxJzJpje4qUdeUUVHATPW4VV/v0ehIVCp8z6ajSFWAZz2g
         nqIzZOVSK/HBkRU6K00LTlymB2SkFaJ5pxNXtH+Me5S9H4kvpu1bFAK44ndXZRGGStFq
         WYdA==
X-Gm-Message-State: AOJu0YyNVRN6mLgzmihwUA4rKwXO+zhqtui9jg1QO91XaCQ1zV/62kQ+
	5DJXSqQx3xDsRjOMmLVCw2zLdD0u+YD+a9m53wHgSmJtfyRx/Kh4wZWgityKredNZ/zM484F+1R
	Ri3qEBA==
X-Received: from pgiz17.prod.google.com ([2002:a63:c051:0:b0:c9f:dabd:440f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4482:b0:848:42d0:bc91
 with SMTP id d2e1a72fcca58-84f2dfc89bemr1475759b3a.12.1785875621604; Tue, 04
 Aug 2026 13:33:41 -0700 (PDT)
Date: Tue, 4 Aug 2026 13:33:41 -0700
In-Reply-To: <20260804174616.465821F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804173437.3339269-1-seanjc@google.com> <20260804173437.3339269-3-seanjc@google.com>
 <20260804174616.465821F00A3E@smtp.kernel.org>
Message-ID: <anJMpZjFaWwsmiME@google.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Create one VM with many vCPUs for
 each major PMU counters test
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] In `test_gp_counters`, the refactoring incorrectly configures every vCPU with the maximum number of GP counters, losing test coverage for intermediate values.
> - [Low] The `vcpus` pointer array is allocated using the size of `struct kvm_vcpu` rather than the size of a pointer.
> --
> 
> --- Patch [2]: [PATCH 2/2] KVM: selftests: Create one VM with many vCPUs for each major PMU counters test ---
> commit f846c14eae6ee2689b438ef9a6cdf2439244aee5
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Create one VM with many vCPUs for each major PMU counters test
> 
> This commit refactors the PMU counters test to create a single VM per 
> test category (arch events, GP PMCs, fixed PMCs) and provisions multiple
> vCPUs within that VM. This drastically reduces the test runtime by
> avoiding repeated VM creation overhead.
> 
> > diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> > --- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> > +++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
> [ ... ]
> > -static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
> > -						  void *guest_code,
> > -						  u8 pmu_version,
> > -						  u64 perf_capabilities)
> > +static struct kvm_vm *pmu_vm_create_with_vcpus(u32 nr_vcpus, void *guest_code,
> > +					       u8 pmu_version,
> > +					       u64 perf_capabilities,
> > +					       struct kvm_vcpu **__vcpus[])
> >  {
> > +	struct kvm_vcpu **vcpus = calloc(nr_vcpus, sizeof(struct kvm_vcpu));
> 
> [Severity: Low]
> Is this allocating the correct size?

Gotta love Sashiko's "questions" :-)

> It looks like vcpus is an array of pointers, so this might need to be
> sizeof(struct kvm_vcpu *) instead of sizeof(struct kvm_vcpu). While it
> just results in a minor memory over-allocation here, it could be slightly
> confusing.

Ya, I'll change it to:

	struct kvm_vcpu **vcpus = calloc(nr_vcpus, sizeof(*vcpus));

> [ ... ]
> > -static void test_gp_counters(u8 pmu_version, u64 perf_capabilities,
> > -			     u8 nr_gp_counters)
> > +static void test_gp_counters(u8 pmu_version, u64 perf_capabilities)
> >  {
> > -	struct kvm_vcpu *vcpu;
> > +	u8 nr_gp_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS);
> > +	struct kvm_vcpu **vcpus;
> >  	struct kvm_vm *vm;
> > +	u8 j;
> >  
> > -	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
> > -					 pmu_version, perf_capabilities);
> > +	pr_info("Testing %u GP counters, PMU version %u, perf_caps = %lx\n",
> > +		nr_gp_counters, pmu_version, perf_capabilities);
> >  
> > -	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
> > -				nr_gp_counters);
> > +	vm = pmu_vm_create_with_vcpus(nr_gp_counters + 1, guest_test_gp_counters,
> > +				      pmu_version, perf_capabilities, &vcpus);
> >  
> > -	run_vcpu(vcpu);
> > +	for (j = 0; j <= nr_gp_counters; j++) {
> > +		vcpu_set_cpuid_property(vcpus[j], X86_PROPERTY_PMU_NR_GP_COUNTERS,
> > +					nr_gp_counters);
> 
> [Severity: Medium]
> Does this inadvertently lose test coverage for the intermediate counter values?
> 
> By setting X86_PROPERTY_PMU_NR_GP_COUNTERS to the loop upper bound 
> (nr_gp_counters) instead of the loop variable (j), we end up configuring
> every vCPU with the maximum number of GP counters. This seems to bypass
> testing edge cases like 0 GP counters entirely. Should this be passing j
> instead of nr_gp_counters?

Doh, yes.  I copied the code out of the helper and missed that it led to a subtle
variable "collision".

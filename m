Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7652236EE
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 01:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525756; cv=none; b=WI0o9F1FoPydA9SFJ3A9/7+hV079JS78+QWtJGgsVnr2M/+Bsp6jeSQOWODn9LYsSYmynNvGKd13BBBatoGukFYa6I9cJ54P1umbSHo0na0V1FgAQy5jhe1A0RtQvrBIpe32ER19l//S7EkVQZtnSJkgnBaBXey3DaGSf7z0PpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525756; c=relaxed/simple;
	bh=NvXwkZs1Eb67W4/dx1XlUmax3q+B1Go9SNeOYPYBG2I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CT+idvyuSN/hswBIddvxXgonm8fT8xZLrsj3N3qDlSBfzvoQgP2TmgooWyqnYtN6SCwzxezh6k21UbnrIgOxhj5K8/XndbyxwfoT9C9Wc0urbqkvb5kodsqRI6q7NxRJDyKXwoL+81mOBFemVx9ms0Wz+uD4CdC6jzGtmGEGlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mJBywtWf; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJBywtWf"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so2868764a12.2
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 18:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775525753; x=1776130553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dTZU3VLvQ7mZRxrIcUNKCVncTp1ttiyd0/q3RqIiJzk=;
        b=mJBywtWfP3d6scaKEE9hVUJPLkk+wcRn+JnsSLqrEtW+XcSepbd+4JC9nllYHpX/Yx
         q1HhPeacr8HJvXnBrTTvn70Vi7EUbbRnV8B7GT4mm0+l5FOX0dfQqfSmCTvPIDkr07qx
         S/6kpJHUho1fdIwdzEqZ40XwQly8FVlsKKJIeSqoJORuSU6TQBrQFTFV9QdPa6RZ5xXP
         +jvnZZsiQnND8e4as7FO1kT+JQ1PvQR4tINliohrw1yjcg+/ED2d6dI8Mo2fufr1o+/A
         kOvEuWpuOxWfTeCqOXXARASDAlIYC5C4BafU/0b46JHqZ98IvHXt+GSW4vAeEf/aRgLW
         n/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525753; x=1776130553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTZU3VLvQ7mZRxrIcUNKCVncTp1ttiyd0/q3RqIiJzk=;
        b=Ut1C3NwdV+t3r5KeWueOs1f88CgYdw8NBJ9Zy6V3GY+nv8rOMaMdCF7gNuQSaWomBy
         V/vq3jeI2O1hTa610W4Zv0rm9D3Np6voXJGYWEXVF29mqw8jxp5hW+5xLpr4wquKwn8R
         2EJ9VoklsgVfNYxbDixpPGt8ZhA5hZj32d4ALIe2ePCt3nX9gFZP4JCwbwDK4aV47qzw
         qa/Qq+/FAlDUfJ9hkDs/onydWw53K7cmNYjKnNe4QDdZY5IvHYslrUrrT8Ts5RJu/uHf
         HSgdKXSrLtTRyVj+x472YllhIHn4jLpmoDs+glh6hf50BQ2Hmpcwi9czRvTiBg1KY0FQ
         rxaA==
X-Forwarded-Encrypted: i=1; AJvYcCUThq8OeTYRfhqLgOl5It2szuU1MHo4gogXTFGoMQFKQGVgZHnKVWKj+4Y1bvXU4HhujI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeJEWpLI5RxiDJe88jMDUz1H3CLF+HFc0hjK7BH/W4TW3FiOQM
	rLmfQW2gfzx7fXlZERBGQ/jI9ZVHBBxEtHdJKYxtGeN70jeT2qW7OPJOrUEIRD+o4OGBOUVPMmv
	zr3DfzA==
X-Received: from pfnx19.prod.google.com ([2002:aa7:84d3:0:b0:824:9c5c:98f3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:301f:b0:82c:9fe1:aa4e
 with SMTP id d2e1a72fcca58-82d0da8f68amr14780861b3a.21.1775525753151; Mon, 06
 Apr 2026 18:35:53 -0700 (PDT)
Date: Mon, 6 Apr 2026 18:35:51 -0700
In-Reply-To: <20260326031150.3774017-5-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
Message-ID: <adRfdw5jpvibQkOq@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 26, 2026, Yosry Ahmed wrote:
> Reprogram all counters on nested transitions for the mediated PMU, to
> re-evaluate Host-Only and Guest-Only bits and enable/disable the PMU
> counters accordingly. For example, if Host-Only is set and Guest-Only is
> cleared, a counter should be disabled when entering guest mode and
> enabled when exiting guest mode.
> 
> Having one of Host-Only and Guest-Only set is only effective when
> EFER.SVME is set, so also trigger counter reprogramming when EFER.SVME
> is toggled.
> 
> Track counters with one of Host-Only and Guest-Only set as counters
> requiring reprogramming on nested transitions in a bitmap. Use the
> bitmap to only request KVM_PMU_REQ if some counters need reprogramming,
> and only reprogram the counters that actually need it.
> 
> Track such counters even if EFER.SVME is cleared, such that if/when
> EFER.SVME is set, KVM can reprogram those counters and enable/disable
> them appropriately. Otherwise, toggling EFER.SVME would need to
> reprogram all counters and use a different code path than
> kvm_pmu_handle_nested_transition().
> 
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/include/asm/kvm_host.h |  6 ++++++
>  arch/x86/kvm/pmu.c              |  1 +
>  arch/x86/kvm/pmu.h              | 13 +++++++++++++
>  arch/x86/kvm/svm/pmu.c          | 13 ++++++++++++-
>  arch/x86/kvm/svm/svm.c          |  1 +
>  arch/x86/kvm/x86.h              |  5 +++++
>  6 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index d3bdc98281339..b2f8710838372 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -594,6 +594,12 @@ struct kvm_pmu {
>  	DECLARE_BITMAP(pmc_counting_instructions, X86_PMC_IDX_MAX);
>  	DECLARE_BITMAP(pmc_counting_branches, X86_PMC_IDX_MAX);
>  
> +	/*
> +	 * Whether or not PMU counters need to be reprogrammed on transitions
> +	 * between L1 and L2 (or when nesting enablement is toggled).
> +	 */
> +	DECLARE_BITMAP(pmc_needs_nested_reprogram, X86_PMC_IDX_MAX);

Hmm, I think this should be reprogram_pmc_on_nested_transition, or something like
that.  I don't like using "needs" because KVM tends to use "needs" for one-shot
things, e.g. "xyz needs to be sync'd on the next whatever".  And while the code
kinda-sorta takes that approach, in practice it doesn't; clearing the bits and
then setting them again is really just an implementation quirk to keep things
simple.

Conceptually, these flags are much "stickier" in that they are kept set across
all nested transitions, and only cleared when the event selector itself is
changed in some way.

> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index bdbe0456049d0..fb73806d3bfa0 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -248,6 +248,19 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
>  				  X86_PMC_IDX_MAX);
>  }
>  
> +static inline void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	if (bitmap_empty(pmu->pmc_needs_nested_reprogram, X86_PMC_IDX_MAX))
> +		return;
> +
> +	BUILD_BUG_ON(sizeof(pmu->pmc_needs_nested_reprogram) != sizeof(atomic64_t));
> +	atomic64_or(*(s64 *)pmu->pmc_needs_nested_reprogram,
> +		    &vcpu_to_pmu(vcpu)->__reprogram_pmi);

And here especially I think reprogram_pmc_on_nested_transition works better,
e.g. it's a bit more obvious that leaving reprogram_pmc_on_nested_transition
as-is is intentional.

> +	kvm_make_request(KVM_REQ_PMU, vcpu);

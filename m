Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCA02206A7
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 01:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525409; cv=none; b=J8i4gTJKHLg5Min7topeWKiTDRQaKUYh2jjxJLBCDkJmGWNLkA66WkTkHZqHnOUW8DZN0q0MjaVWRcmy+Dk0/a3ptf4p7e8UgSb8Zjt79zCa16tbweOvOw4Ya4kg8iFC4ibvzLc0TE/J44BGVkmy/8foLX+1AfaDbQmLFLokQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525409; c=relaxed/simple;
	bh=IGMAi2wiCGCXadTTXjpuZo65dXEaVwVAvdnCzLaS3do=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nDn+dkmvyIny1h5W2q+dFOpKeedgRJetrj2wmpJetL1LRq62IfifTL+IctCD0AKnSM+OTcysJPzsQZnM5r3hVQda9FUEZRfmzh93g3L6AAEYxleDfT6vaDy/hE1EieZbNW+FIOdAi5wfgEl/1FHhH8++Da+VtzEMSC4sZNgc9+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bT+CHJO1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bT+CHJO1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c6929bd26so5769984b3a.3
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 18:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775525407; x=1776130207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qykw9lHkfBZLP11Nb6RskPAZMdgC2br+eyv7YbybDBQ=;
        b=bT+CHJO1UOGGki41YSvinWZ4IoJw4YhZGY+Q4W0iMc6+wGnJZYVqqyPHEbcuVXGxSf
         79qjNTXERud3ORQexiE3HstO7ab5G87i8eX0H4An9V7vbF+MyXaj1LWZpyTHAh2EZM+V
         rEcbLp1Rucn/ovgdhugQN6NMcKq7916WKAvJmCkb8labqQHKmJmFj/2hktmTS6xxOw6u
         p53kocknCPhm+wxwKfF/XpxzhqpCtRVFfohsse2simCYxVkh4lXcJydLQS2lOMcIL/Ok
         zurmJ3X5XFHtX/2YMy4JEKLwHbZTJgalZhhFrtNtBvY6v/WBAiQB7zGZwS4fe/6GlHiT
         zSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525407; x=1776130207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qykw9lHkfBZLP11Nb6RskPAZMdgC2br+eyv7YbybDBQ=;
        b=Qc4j6+ZuCnkwlLkoeZRnklE1bk05JlxqA7s/Mxu09qrJ+3dalniin2RDcAXe3CKyHu
         KhVXqjvh+/6eb3kxVWcHd6xJz9TdbhJI6dfalNXe+Wwt8FHMYx52TAY82Q3BQcZZ6csg
         AWqQF506NANSXVZ0MPJiz8hVMvtMejas7YbCULVDp2tcOdQ51/ywnwgjCCjjMMovhQEE
         yKBrOFTt5RBgIY8/xozxyInSg8Qc6KqXlTlFOjuEUj8e7cuus/0Ok8lTdXvYjtHA076O
         gO63KEA3eqp9v+Bs43ANHvFpYvjgdKMbPYyKUFxUgK/DdsPg8kCnrNoICthLfA/I81ec
         3T/w==
X-Forwarded-Encrypted: i=1; AJvYcCUXVovIlVXTlhTli9GJFzUW5s2Z4cfmUAppwjI/+C8NNKQiL15N1TK5i2z6Yh0eMeGwJeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQwBv8SjorWfKP0tBgM8+4d40f+W4p7vIpa+T5E4sJAVoeAHCB
	2CtE5hgqGY4wGH6zWVHGQp6h6ToT1zQfW2uvpEffk5Ao+7p8fKwlpDJeyITjxlbNlViDT7auRyf
	nKgbasQ==
X-Received: from pfri1.prod.google.com ([2002:aa7:8d81:0:b0:82c:e328:c2eb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:301f:b0:81f:3fa0:8c38
 with SMTP id d2e1a72fcca58-82d0da90c83mr14676785b3a.20.1775525407009; Mon, 06
 Apr 2026 18:30:07 -0700 (PDT)
Date: Mon, 6 Apr 2026 18:30:05 -0700
In-Reply-To: <20260326031150.3774017-4-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
Message-ID: <adReHbkVRDGOihb4@google.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 26, 2026, Yosry Ahmed wrote:
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index ff5acb8b199b0..5961c002b28eb 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -60,6 +60,8 @@
>  #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
>  #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
>  #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
> +#define AMD64_EVENTSEL_HOST_GUEST_MASK			\
> +	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
>  
>  #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
>  #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index d6ac3c55fce55..e35d598f809a2 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -559,6 +559,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
>  
>  	if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
>  		kvm_mediated_pmu_refresh_event_filter(pmc);
> +		kvm_pmu_call(mediated_reprogram_counter)(pmc);

I would rather make a single call from kvm_pmu_handle_event(), and let the vendor
deal with mediated vs. legacy.  I want to avoid mediated-specific ops as much as
possible, and I think kvm_x86_ops.reprogram_counters() would be easier to
understand overall.

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7b38c104d06..7da0077ae24c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -670,6 +670,8 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
                        set_bit(pmc->idx, pmu->reprogram_pmi);
        }
 
+       kvm_pmu_call(reprogram_counters)(vcpu, bitmap);
+
        /*
         * Release unused perf_events if the corresponding guest MSRs weren't
         * accessed during the last vCPU time slice (need_cleanup is set when


> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 7aa298eeb0721..60931dfd624b2 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -260,6 +260,34 @@ static void amd_mediated_pmu_put(struct kvm_vcpu *vcpu)
>  		wrmsrq(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, pmu->global_status);
>  }
>  
> +static void amd_mediated_pmu_handle_host_guest_bits(struct kvm_pmc *pmc)
> +{
> +	struct kvm_vcpu *vcpu = pmc->vcpu;
> +	u64 host_guest_bits;
> +
> +	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> +		return;
> +
> +	/* Count all events if both bits are cleared or both bits are set */
> +	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> +	if (hweight64(host_guest_bits) != 1)
> +		return;
> +
> +	/* Host-Only and Guest-Only are ignored if EFER.SVME == 0 */
> +	if (!(vcpu->arch.efer & EFER_SVME))
> +		return;
> +
> +	if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu))
> +		return;
> +
> +	pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
> +}
> +
> +static void amd_mediated_pmu_reprogram_counter(struct kvm_pmc *pmc)
> +{
> +	amd_mediated_pmu_handle_host_guest_bits(pmc);

And then this doesn't need to be such a wonky wrapper, and the "reprogram on
nested transition" logic can also clear the entire bitmap instead of doing things
piecemeal, e.g. it can be something like so in the end:

	if (!kvm_vcpu_has_mediated_pmu(vcpu))
		return;

	bitmap_zero(pmu->pmc_reprogram_on_nested_transition, X86_PMC_IDX_MAX);

	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
		amd_mediated_pmu_handle_host_guest_bits(pmc);

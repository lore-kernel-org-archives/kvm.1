Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132219CD1B
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101303; cv=none; b=KmFmjVuTMbJI/ay1XjMI69n427Kfi8OHBc07M5ZT8zZSc0jExFJBSR7eZx21IvGMv8jtdmxkdBHkmNg8YCLyr5Mn2KfmZqAvOFAGRbANuD5psadm+dvl+AC7p2loM+6FaPLzxVTAend77MWtPS7YSvPkxz0u0eTCZhGkHkk7Tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101303; c=relaxed/simple;
	bh=LXrbqgGHJ5TCns2d/WLysB14JNxmqc26djxAVUrnz0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D2Lsm4gRnDZoWvXXFPxId7EUb6TrlJYnI4YjyAyuS2MCE94Mg2PxVin7AUFA8dmzZa0QVM3FifVTj2Za9juaS75VHOzYWphqRKmXTWrI+bVvIGDFBjF6dSl1/B3OqHfWzjFEvZn82QjgJD3wAxPnkxrFxccz2FYWnfbgGfic6lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVndYmH+; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVndYmH+"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0a81c1738so252475ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 17:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780101301; x=1780706101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nNBaqn7MVJGrLWJWnaVdqprmzYHk2rkmEwyyXy4tIQU=;
        b=tVndYmH+CdttiMICNrUdIThGv/OuDu5p4alaB2RwPnCRvgQPnO8RNmfwgcfEI6H4zM
         V64Ctp4N/x/H+iQbutGl/Ak594VdE5xxvJyMS1G0Eax9cLzjGnb5OP2aivqi8j4oCFU5
         GrkUrOjU48PlcGmmLQXQ0bJcn5ne6SmouCjbhSoT890JBUB/Tc40aPR6vBu4pVNkGIat
         VvlwSS5H1+sI9ic+aOk1cJ143Hj0xheVIHX8NjJd5zlZARdKoeh3mbeHn/gr9rBY4goK
         Ucok6otMuiUF07UFUIbDWLugHwe0Zyk8dd6/cPeFBWoZfr1fX2VCwl9uDlgbgWMctRlg
         Jodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101301; x=1780706101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNBaqn7MVJGrLWJWnaVdqprmzYHk2rkmEwyyXy4tIQU=;
        b=pAko6VST7yvLFa8kblk2+Iz6dTLvlRRDaBYtx98ibiLpZJwzrPr0VasNJ/5MmFzYII
         zHl1K1PQmM12srq7hZFU5ICZgH+le/0/AdB1ksXTbutgWnPxytRpES1mcubCkSNh2Blw
         yV+NMrwjMdKdIinh7RJNIeM71/VluiFBxM//HE32qayCTqIsrCONNeCyos/+zbJnqkB1
         glqXMyT4z+me2XreEX8U7uS3KCW7T2OjLkR/9fWWKPtxqnMl72Vd2hzpx/Mqr6PHqWYO
         KWLZQABbYrq2VY1+w+XSRyq+8AIr1SylaZ16aYZ2jaR9JDTa7f1Yc9T1UCzOaDXwpoRU
         /Kag==
X-Forwarded-Encrypted: i=1; AFNElJ8wkwuFIVTD88HJ6b/dZKY6p/GGqESCYrcHIOkC3yYVCGvMozOUhXxGn8CpVGYkAm25DLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gUMpsP2qIQny7emvowKBqp+RI5oiZxFnNZMj7NZ7OK7BEHWL
	WT7gxauBx0S2oq3X62wyVZmZsYKN0z7f3wlSTkc40iQuoJwQtrv0ZIPRtQ4Cs0v/PIhVYYkKzXN
	sMG3vhg==
X-Received: from plblh4.prod.google.com ([2002:a17:903:2904:b0:2b2:488e:b71])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4ce:b0:2bf:800:19f8
 with SMTP id d9443c01a7336-2bf367e071dmr24203735ad.17.1780101300733; Fri, 29
 May 2026 17:35:00 -0700 (PDT)
Date: Fri, 29 May 2026 17:35:00 -0700
In-Reply-To: <20260528005419.0228F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-9-yosry@kernel.org> <20260528005419.0228F1F00A3A@smtp.kernel.org>
Message-ID: <ahowtCCtnr9t5DGy@google.com>
Subject: Re: [PATCH v7 08/17] KVM: x86/pmu: Check mediated PMU counter
 enablement before event filters
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Guest can bypass PMU event filters for fixed counters by modifying MSR_CORE_PERF_FIXED_CTR_CTRL.
> --
> 
> commit 270fc772a7eb457f31ead154a0c426817961ae8a
> Author: Yosry Ahmed <yosry@kernel.org>
> 
> KVM: x86/pmu: Check mediated PMU counter enablement before event filters
> 
> This commit checks if a PMU counter is enabled by the guest before performing
> the potentially expensive PMU event filter lookup. It modifies
> kvm_mediated_pmu_refresh_event_filter to use pmc_is_locally_enabled.
> 
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index afbc731e72174..67dbbd4c73036 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -532,7 +532,7 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
> >  
> >  static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
> >  {
> > -	bool allowed = pmc_is_event_allowed(pmc);
> > +	bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
> 
> [Severity: High]
> This is a pre-existing issue, but was it intended for guests to be able to
> bypass PMU event filters for fixed counters by writing to the MSR twice?
> 
> Looking at reprogram_fixed_counters() in arch/x86/kvm/vmx/pmu_intel.c,
> pmu->fixed_ctr_ctrl_hw is unconditionally overwritten with raw guest data
> before checking which counters changed:
> 
> arch/x86/kvm/vmx/pmu_intel.c:reprogram_fixed_counters() {
>     ...
> 	pmu->fixed_ctr_ctrl = data;
> 	pmu->fixed_ctr_ctrl_hw = data;
> 	for (i = 0; i < pmu->nr_arch_fixed_counters; i++) {
> 		u8 new_ctrl = fixed_ctrl_field(data, i);
> 		u8 old_ctrl = fixed_ctrl_field(old_fixed_ctr_ctrl, i);
> 
> 		if (old_ctrl == new_ctrl)
> 			continue;
>     ...
> 		kvm_pmu_request_counter_reprogram(pmc);
> 	}
> }
> 
> Because kvm_pmu_request_counter_reprogram() is skipped when the counter's
> control bits haven't changed, kvm_mediated_pmu_refresh_event_filter() is
> never called to apply the filter mask.
> 
> Could a guest enable a rejected counter (which gets correctly filtered and
> cleared in fixed_ctr_ctrl_hw by the first write), and then write the MSR a
> second time to enable a different counter while leaving the rejected
> counter's bits set?
> 
> The second write would inject the unfiltered enable bits into
> fixed_ctr_ctrl_hw, and since the software state (old_ctrl == new_ctrl)
> matches, KVM skips reprogramming it. Does this allow the rejected counter to
> remain enabled in hardware upon the next VM-enter, completely bypassing the
> event filters?

Hrm, does look like that's the case.  If the guest toggles a different PMC, KVM
will update pmu->fixed_ctr_ctrl_hw and reprogram the PMC that is changing, but
not the others that are enabled in pmu->fixed_ctr_ctrl_hw.

Aha!  I think this is quite easy to fix: use fixed_ctr_ctrl_hw as the basis for
the diff.  For the perf-based PMU, fixed_ctr_ctrl_hw == fixed_ctr_ctrl at all
times.  For the mediated PMU, "reprogramming" means changes the values that are
loaded into hardware, and so unless I'm missing something, this?  I'll test and
send a patch next week.

idiff --git arch/x86/kvm/vmx/pmu_intel.c arch/x86/kvm/vmx/pmu_intel.c
index 453cb3d3ec9b..a73a9515d96c 100644
--- arch/x86/kvm/vmx/pmu_intel.c
+++ arch/x86/kvm/vmx/pmu_intel.c
@@ -56,8 +56,16 @@ static struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
 
 static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
 {
+       /*
+        * Compare against the value the mediated PMU shoves into hardware, not
+        * the guest's desired value.  For the emulated PMU (proxied via perf),
+        * they are one and the same (fixed_ctr_ctrl_hw isn't used other than
+        * here).  For the mediated PMU, KVM needs to reprogram the actual MSR,
+        * and so needs to react to potential changes in the value shoved into
+        * hardware, e.g. to ensure the event filter is enforced.
+        */
+       u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw;
        struct kvm_pmc *pmc;
-       u64 old_fixed_ctr_ctrl = pmu->fixed_ctr_ctrl;
        int i;
 
        pmu->fixed_ctr_ctrl = data;


Note, general purpose counters (thankfully) don't have the same bug.

			if (data != pmc->eventsel) {
				pmc->eventsel = data;
				pmc->eventsel_hw = data;
				kvm_pmu_request_counter_reprogram(pmc);
			}

Oh, and for posterity, using fixed_ctr_ctrl_hw won't mess up pmc_in_use, because
it's unused by the mediated PMU.  It's purpose is solely for releasing perf events
that are no longer being actively used.  It's a bit hard to see, but need_cleanup
will never be set for the mediated PMU, because pmu->event_count will always be
zero.

	if (vcpu->scheduled_out && pmu->version && pmu->event_count) {
		pmu->need_cleanup = true;
		kvm_make_request(KVM_REQ_PMU, vcpu);
	}

To make that more obvious, I think it makes sense to add

  static inline void __kvm_pmu_mark_pmc_in_use(struct kvm_vcpu *vcpu, u8 idx)
 {
	if (kvm_vcpu_has_mediated_pmu(vcpu))
		return;

	__set_bit(idx, vcpu_to_pmu(vcpu)->pmc_in_use);
  }

and then use that everywhere, and WARN if kvm_pmu_cleanup() is ever called with
a mediated PMU.

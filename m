Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9B3C061F
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011120; cv=none; b=LfXAKdXSxLtw47y6hGvXkhRSGHWa5BFJ9JNVKDujA7JpAE26X9wk2+gjDjibUr6EJIYtMt4cV/LHBEmpc0mcEtJsxfooDNkt6z4vM8x3kqi45LMf47ojPWaNux19PnsNa9hZY/PTysyrC3NO8IOAchQTFbSG9hc9VaKRxKjfVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011120; c=relaxed/simple;
	bh=wZ+4e4bdgtA+cnZnsi1sCsZpKcgiP7bLYcdq96UmCG8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mPIf27iiIC03etJ5zzURKTiJLn0oDQfv8NAaeafd2/u8tCFS2DHC+MY/+4I75Gr/iG4oPD5KQm87G09l4PW9MhMSuQFZDq4SzaWbKaorty4Q0Nvgca4oqiH5bkX+Z+3KgjkOa6AMxmvuhaMENVIFKjSvUhODipKE2d4zv4CUUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5kxg8fw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5kxg8fw"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba603a7d2cso1814465ad.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778011118; x=1778615918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0N8pahFNFpVRIbsdReJ0xAb2DOf33TA/Z1AFvPeKNcA=;
        b=k5kxg8fwnKsRaK+SPA2KgFFy1+a56vNBQ74gok7XVFO2ltfNbSznU5vKRUWwrM02yA
         j+1elym+nr1+3ngGqPW4R8uZMucfzOCtGm6QUkCWUEk11XuycaKb0iRMIA82jw2zjy91
         fhQICs2otAjyVnM7FmakNsVsV1akysxjM4GrwZ49rMIXURcMDoju8O+I8pT0THFSIlGA
         ky/iJr5pORakUka0JzufWZBNG8YyS6MPlZn42DFR/r3LgUHzECfNR3XmOqGoVJmwGOZ7
         p5bYZSx5fS9KZiW4jdiiFut4wVJj/VA29oiFUd7KMF9AQxqMOovvKQB8NTq2WT3kghh+
         aPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778011118; x=1778615918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N8pahFNFpVRIbsdReJ0xAb2DOf33TA/Z1AFvPeKNcA=;
        b=T/QRcE7Rx5DRjBg84WNOuJG4mPhGhsELHTTgMJengCrBUKtQ1rWdjzLpI49t61NYRp
         e22ZEosqPKwkQc1gm01Z+BKke2lm59KWW+tkiBgZhyJWJVXh+d1iuUvoLtwGdmPq593H
         CkAJzR1WRR2QznKxPaLSFsUZtzqyG7uHeGv6Pyiyak2p0PTLu7zuzCx1Uh9HaZ2IuLje
         HikSHpIkK/eAT82e8MptAXb6GLtx53qlYeXS/jg5v1PhQUOopfFM5IfARzPXOeKwL+CE
         PlRxXb9keHxo/DgJXB//mJV8WKGZr7At0eh6T7UlZA8s7cfxQvT6uG1HKwDnYwID6B5C
         +xXA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ww6PPaNOjIB+ZkYF5PNf7UzfCqMEGmX8AIhdSSdlWpQhLOJYuyxoJs7ppPhP98/jAgJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM0/IkMez2Bc9uVfEcuI/eOhSx67JJjNeg6aPxcrk7bja91jjk
	sHzWbPW8V+HEAxIKjIiSjrd4NJU3GM9vIGJ6bqf26uWkZdgjBl7eP+Mkd5x/j6y8VlnxkoE8hjB
	ZorAsaQ==
X-Received: from plhq10.prod.google.com ([2002:a17:903:11ca:b0:2b2:a488:ae47])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4d:b0:2b4:6122:10f8
 with SMTP id d9443c01a7336-2ba4e4d0cc0mr37140905ad.21.1778011117786; Tue, 05
 May 2026 12:58:37 -0700 (PDT)
Date: Tue, 5 May 2026 12:58:37 -0700
In-Reply-To: <afpAw3UkbVMbXptv@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430202750.3924147-1-yosry@kernel.org> <20260430202750.3924147-8-yosry@kernel.org>
 <CAO9r8zMX=_zGm1Qmnd51=ca96aj=c+CkPfxzf9uinUGwxdP_Gg@mail.gmail.com>
 <CAO9r8zNM-ECiiSKGS4Z7eM2S_06_6+fDO4mEeKiWFM-NFgHOUg@mail.gmail.com>
 <afTnlv_cAWFfouqk@google.com> <afoytsu6LzzpeTfc@google.com>
 <CAO9r8zPqvBY0=O2L6DterLyN3nZrtOCs-mv_4hvZ+gt=bxRbDg@mail.gmail.com>
 <afo7qB3hyrD_9Jme@google.com> <afpAw3UkbVMbXptv@google.com>
Message-ID: <afpL7QTODL5JbJsN@google.com>
Subject: Re: [PATCH v5 07/13] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, Yosry Ahmed wrote:
> > > Did you see my other replies and code snippet tracking disabling
> > > reasons? I think the code snippet would still work, I just need to
> > > move the pmc_is_nested_disabled() check into pmc_is_locally_enabled().
> > 
> > I did.  IMO, all of what you proposed is an optimization to avoid the "costly"
> > checks at the time of pmc_is_locally_enabled().  In quotes because I don't think
> > the _overall_ cost is actually all that high.  pmc_is_locally_enabled() is only
> > called in relatively slow paths, and my guess is the CALL+RET (or untrained RET,
> > ugh) is probably more expensive than the logic itself.
> > 
> > The very nice side effect of incorporating the logic into pmc_is_locally_enabled()
> > is that I _think_ we can drop kvm_pmu_ops.reprogram_counters(), because
> > amd_mediated_pmu_handle_host_guest_bits() will instead be:
> > 
> >   static bool amd_pmc_is_locally_disabled(struct kvm_pmc *pmc)
> >   {
> > 	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> > 	struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
> > 	u64 host_guest_bits;
> > 
> > 	/* Common code is supposed to check the common enable bit. */
> > 	if (WARN_ON_ONCE(!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)))
> > 		return false;
> > 
> > 	/*
> > 	 * If both bits are cleared, always keep the counter enabled. Otherwise,
> > 	 * counter enablement needs to be re-evaluated on every nested
> > 	 * transition (and EFER.SVME change).
> > 	 */
> > 	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> > 	if (!host_guest_bits)
> > 		return true;
> > 
> > 	/* If either bit is set and EFER.SVME=0, the counter is disabled. */
> > 	if (!(vcpu->arch.efer & EFER_SVME))
> > 		return false;
> > 
> > 	if (host_guest_bits == AMD64_EVENTSEL_HOST_GUEST_MASK)
> > 		return true;
> > 
> > 	return !!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu);
> >   }
> 
> If we do this and drop kvm_pmu_ops.reprogram_counters(), we still need
> somewhere to actually clear ARCH_PERFMON_EVENTSEL_ENABLE in eventsel_hw.

Yep.  I was thinking we'd do that as part of reprogram_counter().

> What if we call kvm_pmu_ops.pmc_is_locally_disabled() at the top of
> reprogram_counter(), cache the result, and use that for eventsel_hw
> modification and in pmc_is_locally_enabled()?

Why bother caching it?  I suspect it will make the code harder to read, I would
generally prefer pmc_is_locally_enabled() be self-sufficient, and I don't think
the caching will elide any lookups.  Legacy PMU doesn't care, and even if it did,
it should only query pmc_is_locally_enabled() once.  And the mediated PMU should
only query it once.

> We'd also probably want to rename it. I would honeslty just use 'nested'
> instead of 'locally_disabled' and 'mode_specific_enables' as that's the
> only current user.

But it's not strictly nested specific.  E.g. even the vCPU doesn't support nested
virtualization, a (stupid) guest can still set HOST_ONLY and effectively disable
the counter, thanks to the bizarro behavior of HOST_ONLY when EFER.SVME=0.

> Something like this with your proposed amd_pmc_is_locally_disabled()
> above, which is similar to the kvm_pmu_ops.mediated_reprogram_counter()
> implementation in v4 except that the vendor-specific callback is more
> targeted:
> 
> static void pmc_check_nested_disabled(struct kvm_pmc *pmc)
> {
> 	if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> 		return;
> 	
> 	if (!test_bit(pmc->idx, &pmu->pmc_has_nested_enables))
> 		return;
> 
> 	pmc->is_nested_disabled = kvm_pmu_call(pmc_is_nested_disabled)(pmc);
> 	if (!pmc->is_nested_disabled)
> 		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;

I don't want multiple paths mucking with eventsel_hw's ARCH_PERFMON_EVENTSEL_ENABLE.
That's how we end up with ordering bugs.  E.g. pmc_check_nested_disabled() *must*
be called after kvm_mediated_pmu_refresh_event_filter(), which is gross and brittle.

E.g. something like so.  We can even optimize away the PMU filter lookup (which
I suspect would be more expensive in the common case?) if the counter is disabled
thanks to H/G bits.

diff --git arch/x86/kvm/pmu.c arch/x86/kvm/pmu.c
index 7b2b4ce6bdad..4ca4a0078d35 100644
--- arch/x86/kvm/pmu.c
+++ arch/x86/kvm/pmu.c
@@ -530,21 +530,24 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
        return is_fixed_event_allowed(filter, pmc->idx);
 }
 
-static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
+static void kvm_mediated_pmu_refresh_eventsel_hw(struct kvm_pmc *pmc)
 {
-       bool allowed = pmc_is_event_allowed(pmc);
        struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
        if (pmc_is_gp(pmc)) {
                pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-               if (allowed)
+               if (!test_bit(pmc->idx, &pmu->pmc_has_mode_specific_enables) &&
+                   kvm_pmu_call(pmc_is_locally_disabled(pmc)))
+                       return;
+
+               if (pmc_is_event_allowed(pmc))
                        pmc->eventsel_hw |= pmc->eventsel &
                                            ARCH_PERFMON_EVENTSEL_ENABLE;
        } else {
                u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
 
                pmu->fixed_ctr_ctrl_hw &= ~mask;
-               if (allowed)
+               if (pmc_is_event_allowed(pmc))
                        pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
        }
 }

Actually, this code is being silly.  It unnecessarily performs the PMU filter
lookup when the _guest_ disables the counters via eventsel.  If you first "fix"
that by querying pmc_is_locally_enabled() before checking the event filter, then
you won't even need to touch that code when introducing H/G bits, because it will
Just Work thanks to pmc_is_locally_enabled() doing the right thing (as it should,
becase as mentioned early, that logic is architectural).

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 7b2b4ce6bdad..c84f2f971ab1 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -530,22 +530,23 @@ static bool pmc_is_event_allowed(struct kvm_pmc *pmc)
        return is_fixed_event_allowed(filter, pmc->idx);
 }
 
-static void kvm_mediated_pmu_refresh_event_filter(struct kvm_pmc *pmc)
+static void kvm_mediated_pmu_refresh_eventsel_hw(struct kvm_pmc *pmc)
 {
-       bool allowed = pmc_is_event_allowed(pmc);
+       bool allowed = pmc_is_locally_enabled(pmc) && pmc_is_event_allowed(pmc);
        struct kvm_pmu *pmu = pmc_to_pmu(pmc);
 
        if (pmc_is_gp(pmc)) {
-               pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
                if (allowed)
-                       pmc->eventsel_hw |= pmc->eventsel &
-                                           ARCH_PERFMON_EVENTSEL_ENABLE;
+                       pmc->eventsel_hw |= ARCH_PERFMON_EVENTSEL_ENABLE;
+               else
+                       pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
        } else {
                u64 mask = intel_fixed_bits_by_idx(pmc->idx - KVM_FIXED_PMC_BASE_IDX, 0xf);
 
-               pmu->fixed_ctr_ctrl_hw &= ~mask;
                if (allowed)
-                       pmu->fixed_ctr_ctrl_hw |= pmu->fixed_ctr_ctrl & mask;
+                       pmu->fixed_ctr_ctrl_hw |= mask;
+               else
+                       pmu->fixed_ctr_ctrl_hw &= ~mask;
        }
 }
 
@@ -558,7 +559,7 @@ static int reprogram_counter(struct kvm_pmc *pmc)
        u8 fixed_ctr_ctrl;
 
        if (kvm_vcpu_has_mediated_pmu(pmu_to_vcpu(pmu))) {
-               kvm_mediated_pmu_refresh_event_filter(pmc);
+               kvm_mediated_pmu_refresh_eventsel_hw(pmc);
                return 0;
        }

> Also, would you rather I send a new version with everything, or do you
> want to pick up some of the patches in this version independently?

Uh, probably just send a new version.  I doubt I'll get through the first few
patches before you're ready to send the next version.

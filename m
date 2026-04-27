Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7C3E63BA
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319651; cv=none; b=hG2jc330xWlgdwHmmsQaHNXEhfRUzXZaITEUk6K7gdQ16KhemQMVudWpBdkwxDOZrwCqfm6dgif4HztAVCWyJwx1WAEV4IXtbuZsqj/4c3WTAHzvcz5frA3x+4OvpKW8j5wHL3Syc/ZZdrJMtlcKAsXCIEI3ZR/iP9L6N+jb1f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319651; c=relaxed/simple;
	bh=Xrmfw1W/kcbNikGO6K41ny2rx56P3Pusbrdj68AkTMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ec3f82CWIsU503uLoXKdRKVHtwcY5o/15zIc6nlK1ESOIR0c4DyUDhHHTuu8NX1MFaNwxPIsVbKJdQ6/1KmLb84AUedpAhvslLyPUUI3VelYcAfilOLZ4fuAX/r63iDi+egtKtOLGT4cVTZioj5Pn+sc1YN29U7ULxqUZp/xX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lqFk9pJ4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqFk9pJ4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa366fb79so10567486b3a.2
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777319650; x=1777924450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOXcEExJXV3U9TTvPR70ZmBD6kcqsoxWQb4Bm/2nTAM=;
        b=lqFk9pJ48LSh99joclH0MYK7nAy3n9z+kTAWeHR05BPon/5qf4lXjqRkB9X2PjuaOS
         97QkX3EiDREa1vTpEm5YZEWAVZ/Wp1o2CJu+c+GaWir5zcEVr3psb15CwsPgolmdmLO5
         sUtSlvC744nAvCllp7JUit5PxTe/S/bmR37ydUYGbAscdowxy4UDSyz9eRiy4Lo1G1w7
         zE6Op9zbe5/Xa46a/gkqOE4ydTBnvIF3AjqlM4nkk3q+Sy+wHj9kgZvoDYdFh89nssM3
         mSZbstPPAlX+SMERey1FTLE4lYk7j7k741wfngGqusYgU8SA7M4Ch6RbADd3J6JsP77e
         6yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777319650; x=1777924450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOXcEExJXV3U9TTvPR70ZmBD6kcqsoxWQb4Bm/2nTAM=;
        b=JbLkQeryZPuhByM3bTKmUgMPV1BnxQmWHNz0N7bFKrJBctflcpTASp3Zx2aGGCvAS2
         ljrnA53duR+yupUaeKEzeAjooFhVpeeKOU4k9wtFzzPFZjd6HohWteFSwzz5EUu9JZ/3
         KQKt9+c5XqjTJYxYQ59Pogsw6Mtxlu8VgnoChLtUHjVmDqMBfJjMolMqd54zPyLvodeA
         SxHaPl/JaGccUgAfbDhmAnLFuGShXU9Y4muYApDrPG6Fmv4Gu+wRpt/hWFVdGkLrjSpF
         bgqZ0AFglowpYsxFfPTW9s1yfKAxLRT5/U7LU9scA5lTL9eA0xAZAdfQYvdPFH9qM21A
         rz+g==
X-Forwarded-Encrypted: i=1; AFNElJ+83Fj83pq/U3bjXoSmaZXvW5zhUAEqT5Jr5x+h6pwJEzKvGQXowVKOs9tTIyuxqbB1KJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmDYdrGl5yFQpA2sfYJd8QfEsSscBhkOVvub0MgDCBmFxlXHXG
	aIX/v+sERR9A6tTnftbAY2fNJ6xGSIhxRYJdT1lSM1hvN0xJt4KNusAsmB818VC/bBVtAEOJUy7
	KvMO7kg==
X-Received: from pfbay28.prod.google.com ([2002:a05:6a00:301c:b0:82f:a0ba:50d5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ccf:b0:82f:9e98:1356
 with SMTP id d2e1a72fcca58-834dc1a7767mr402738b3a.20.1777319649789; Mon, 27
 Apr 2026 12:54:09 -0700 (PDT)
Date: Mon, 27 Apr 2026 12:54:08 -0700
In-Reply-To: <CAO9r8zO9YxhkfQAXu6ocDD7=SQ7ia1stTmOS4Z6JbMa00hz97w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com>
 <ae-v3aGftsAQuG5E@google.com> <CAO9r8zO9YxhkfQAXu6ocDD7=SQ7ia1stTmOS4Z6JbMa00hz97w@mail.gmail.com>
Message-ID: <ae--4AYNLshM5_zJ@google.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 27, 2026, Yosry Ahmed wrote:
> > static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff,
> >                                                 bool defer)
> > {
> >         struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
> >
> >         lockdep_assert_once(defer || kvm_get_running_vcpu() == vcpu);
> >
> >         if (!diff)
> >                 return;
> >
> >         atomic64_or(diff, &pmu->__reprogram_pmi);
> >
> >         if (defer)
> >                 kvm_make_request(KVM_REQ_PMU, vcpu);
> >         else
> >                 kvm_pmu_handle_event(pmu_to_vcpu(pmu));
> > }
> 
> I like that the KVM PMU code is now presenting a generic API to
> reprogram counters rather than handling nested transitions, even
> though reprogram_on_nested_transition fits better semantically in
> kvm_pmu (than svm_nested_state).
> 
> I do have a few questions:
> 
> 1. Do we want to do all of the work in kvm_pmu_handle_event() on every
> nested transition (rather than just reprogram counters)? Genuinely
> asking as I am not sure if the rest of it is significant.

Yes, we have to for correctness.  And somewhat sneakily, it's not that as much
work as it might seem at first glance because the Host/Guest stuff is limited to
the mediated PMU.  Specifically, pmu->need_cleanup will never be true and so the
heavy-ish kvm_pmu_cleanup() will never be invoked.

As for correctness, we either need to run through this code:

	kvm_for_each_pmc(pmu, pmc, bit, bitmap)
		kvm_pmu_recalc_pmc_emulation(pmu, pmc);

or pend a KVM_REQ_PMU so that it's done before re-entering the guest, so that
KVM does the right thing when skipping/emulating guest instructions.  That flow
is relatively cheap, so I don't see any reason to defer it.


> 2. This approach will reprogram all counters that need it on nested
> transitions. In my proposed approach above, I only iterate over
> counters in reprogram_on_nested_transition and reprogram them. Do you
> think it matters? I guess if other counters need reprogramming we'll
> probably do it in kvm_pmu_handle_event() before running the vCPU
> anyway,

Correct.  KVM has to do the work before the next VMRUN, all we're doing is
completing the work earlier than is strictly necessary.

> but then we're repeating the work here?

No, it's not repeated.  That's why I want to callkvm_pmu_handle_event(): it
updates pmu->reprogram_pmi to clear bits for PMCs that are successfully reprogrammed.

> 3. In this world we still keep the mediated_reprogram_counter() callback, right?

Weren't we planning on a callback that would take the diff of counters?  I.e. one
callback per kvm_pmu_handle_event(), not one callback per PMC?

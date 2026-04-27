Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A439FCBF
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777317110; cv=none; b=Sj6Wd0SQiMI+88n1gMGX6oWQUF0c2t9iJCMHbe4gI15cD6AnYsxvHbceF7U0jwNzeIRg9TdXNJtfBPsaNgJ9aD876FCJcB2dQdtzDSxfiD53Mej9WOTJPOXtjSF5QVBZntBslShlzbVNcFYfpCHxJiMWCpwpiEcZ3oHX5GwjvH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777317110; c=relaxed/simple;
	bh=bXV5u2PSjMu7gVc4XPJL2r1CI+QeaOLlQgcv3hImhRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNTY1wfn3uBSuOEdbG1MwTq+CJbqlKeLzMYQm2tsH/HUNI3rCXeqsf1egaDLoQ11F5kpp5OIccGtNVUyLojcCT6Es5yEJzkrUSc4PP8UrW4/i1E1NqVXqVxIcysfOXnSqiEf0440gAW+wbQs8EiTDshrXE3w+gMSztkddNn//9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atuY3hyj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atuY3hyj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8A2C2BCB7
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 19:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777317110;
	bh=bXV5u2PSjMu7gVc4XPJL2r1CI+QeaOLlQgcv3hImhRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=atuY3hyjo/crEVcfOtUAD7DEIYy1XmfByOGe2ZGrsEQ8aR4C251rxaGExoI8MFcKf
	 Qcp4dgkZ3Md+VDHK4xIAd/GgIN4f1n5XPnZrVbyNyDPkDNhHudbqRsb/IReiVon7G3
	 KRsogz6Q3O1h1DypdR40osDqUK6otyQ9H0T8ZfTm9jdHDBcB+HoBl8UJzsdw3ItIT3
	 Ni6GJVlnIV/Hew6+eqwTKajVwcOwZSoT+BVjQybN6I7CtRy9c52XHGu+pvRr+wagCH
	 PNREIonrE+68V4GL0UXuPrAeXaHCdIOPtG4SiRD4b70Iqnxt7P1vYB8POxeoSlpK09
	 dpKJHFvOuiHxA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba8472c1613so1496106666b.0
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 12:11:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9oxJbNd91MS21ta+TO2dNIAl4yBM5iJJG+pdlGQsktrxbhmaBbxgvWvpkZmd46cIWFOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZLXT1ZYY/TaM6rId6Srlf8a9VUXexVaQE6m+VNO8gnmMQcwx
	3Y6ONsWEfiv8kpvfwBwwQz/hwmkKtXOod80kzq+rp2d+xqhahv7r0Xy70t7+/lXZ/c0QH+XIYcm
	UTN9YpKNdmt5I/sWV53GO1rlR+YABevw=
X-Received: by 2002:a17:906:c105:b0:bab:c646:dc7c with SMTP id
 a640c23a62f3a-bb803e63664mr5883566b.34.1777317108855; Mon, 27 Apr 2026
 12:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-4-yosry@kernel.org>
 <adReHbkVRDGOihb4@google.com> <aesRPt5Vpco29vAt@google.com> <ae-v3aGftsAQuG5E@google.com>
In-Reply-To: <ae-v3aGftsAQuG5E@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 12:11:36 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO9YxhkfQAXu6ocDD7=SQ7ia1stTmOS4Z6JbMa00hz97w@mail.gmail.com>
X-Gm-Features: AVHnY4Kx819myI3_wtWH_LfgPNfvyUX0iDndUEYI5b0ocdPcaaTf6LmByuelWvw
Message-ID: <CAO9r8zO9YxhkfQAXu6ocDD7=SQ7ia1stTmOS4Z6JbMa00hz97w@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > I think leave this callback as-is and handle everything through
> > reprogram_counter(). Export reprogram_counter() and rename it to
> > kvm_pmu_reprogram_counter(), and end up with something like this:
> >
> > void __kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu, bool defer)
> > {
> >       struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> >       DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
> >
> >       if (bitmap_empty(pmu->reprogram_on_nested_transition, X86_PMC_IDX_MAX))
> >               return;
> >
> >       bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
> >       bitmap_zero(pmu->reprogram_on_nested_transition, X86_PMC_IDX_MAX);
> >
> >       BUILD_BUG_ON(sizeof(pmu->reprogram_on_nested_transition) != sizeof(atomic64_t));
> >       if (defer) {
> >               atomic64_or(*(s64 *)pmu->reprogram_on_nested_transition,
> >                           &vcpu_to_pmu(vcpu)->__reprogram_pmi);
> >               kvm_make_request(KVM_REQ_PMU, vcpu);
> >               return;
> >       }
> >
> >       kvm_for_each_pmc(pmu, pmc, bit, bitmap)
> >               kvm_pmu_reprogram_counter(pmc);
> > }
> >
> > void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu)
> > {
> >       __kvm_pmu_handle_nested_transition(vcpu, false);
> > }
> >
> > Actually, if that's desired, we can move this logic into SVM code now.
> > We won't be calling kvm_pmu_handle_nested_transition() from inside
> > enter_guest_mode() and leave_guest_mode() anyway so that we can only
> > defer for the svm_leave_nested() path.
> >
> > So we can move:
> > - kvm_pmu_handle_nested_transition() to
> > svm_pmu_handle_nested_transition()
> > - pmu->reprogram_on_nested_transition to
> > svm->nested.reprogram_on_nested_transition
> >
> > Not sure if we want to keep SVM-specific logic in SVM code, or if we
> > want to keep code generic as much as possible. I can see good arguments
> > for both stances.
>
> We can have our cake and eat it too.  Add svm_pmu_handle_nested_transition(),
> but then also rename and rework reprogram_counters() to support both deferred and
> synchronous operation, e.g. something like so:
>
> ---
> static inline void __kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff,
>                                                 bool defer)
> {
>         struct kvm_vcpu *vcpu = pmu_to_vcpu(pmu);
>
>         lockdep_assert_once(defer || kvm_get_running_vcpu() == vcpu);
>
>         if (!diff)
>                 return;
>
>         atomic64_or(diff, &pmu->__reprogram_pmi);
>
>         if (defer)
>                 kvm_make_request(KVM_REQ_PMU, vcpu);
>         else
>                 kvm_pmu_handle_event(pmu_to_vcpu(pmu));
> }

I like that the KVM PMU code is now presenting a generic API to
reprogram counters rather than handling nested transitions, even
though reprogram_on_nested_transition fits better semantically in
kvm_pmu (than svm_nested_state).

I do have a few questions:

1. Do we want to do all of the work in kvm_pmu_handle_event() on every
nested transition (rather than just reprogram counters)? Genuinely
asking as I am not sure if the rest of it is significant.

2. This approach will reprogram all counters that need it on nested
transitions. In my proposed approach above, I only iterate over
counters in reprogram_on_nested_transition and reprogram them. Do you
think it matters? I guess if other counters need reprogramming we'll
probably do it in kvm_pmu_handle_event() before running the vCPU
anyway, but then we're repeating the work here?

3. In this world we still keep the mediated_reprogram_counter() callback, right?

>
> static inline void kvm_pmu_reprogram_counters(struct kvm_pmu *pmu, u64 diff)
> {
>         __kvm_pmu_reprogram_counters(pmu, diff, true);
> }
> ---
>
> and then have SVM code pass in the reprogram_on_nested_transition or whatever.

Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE28F47F791
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318923; cv=none; b=X0e3XyROSi/krPup0e9YDg9Svc2s34IPDRCYNo6ZS5iR6zPH5JGDc56NXmzJh4WSjXM9AgMXq6fKGkyQ3XR1f09T1cULhiH0HdqI8sb05xU8hCrhqOx6bHtAKgHyPMNBVTj4MmEFfsRZvf4e3GfWHpjgMFPlZxmNURZA9exNJnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318923; c=relaxed/simple;
	bh=8MXAlRp/lZOVNsZeGJaf8IGjpdU3o5msgIcYcSAxHvA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wcjd48G4+c3wtcsDMYsjOjETYq9PKPuHhw3Nxg+Jpiahhxv5L2ObT02TZ6qnbTGbMQ53NOmuNRe6LQaD0EYSvhtPAKAN/cjUabIJDHptXNa1pojPIC3I6f0qSbGVE0TND3OiZoy4TxPBo7UwGwcFdE3m/Nnr5ebgJnXbOMZKWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLpjHETs; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLpjHETs"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so2314932a91.0
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787318921; x=1787923721; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YX0fQ7Qjdf1AGjRX2lzd8yREGufMUdE4nTQS2ZIadXU=;
        b=WLpjHETs8XcuwLhsAPERLOAsKOWQWPgjowK+/U9jpiGN2Nlcgl4z0EOnTS/fHmAHZB
         rXQ9g/3husxTfZGPd1nYv1+ZmpHwiW5x8Xzt/xSNWNoFtKwkU33fmQEkXt4cR2KxDrhe
         1CJXb87R4xxs6pwioAoLfeILhOIX4ArQEbEdvEZJwDoMed/18Z3B4PMvahSzqz+d270I
         7axmYKluagCcQNRsubOwjRzGn3D/XlVf1WWuW3XAC6zlcD8NRXHkoxTlfYuKGXJWAUXU
         oTHiW7hoVYU/end87Vj0LFGy7ZBkFw7oLAv1WwJzEr7jtitEB3NxaAO7OYslGNULpvNh
         6/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787318921; x=1787923721;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YX0fQ7Qjdf1AGjRX2lzd8yREGufMUdE4nTQS2ZIadXU=;
        b=M7Av9Vn/fbUOtjy6Q7NRL5ejUiv01cKUoL1WtUIjApEO96+oydYj6A3lRfhbqwLUM4
         NtAzRirG4fY5FL5xWLK5JwTKzIUKT14tO8qvkJWiaohVYPW8Cr0zk/fJTMDkTSr/yg6D
         nUHD6Mgg7s0CMA1HHJV7YeXnqUr4HOysW5QDvTqQYDDN9cObWU0UssVUlPe3wLNd323O
         V7no5V9K2asXrHM8/LuFVsPDLCLJh7WLW+ARUk0jOMRJbChp97sNtnazouSzOpv0+Y4z
         lEZ0FbLBftN4ccD4fxAV9C51Hr6L1u/v6qPdlBNU24wtWYyWUW0m1DbMfgd6X10aMq8o
         UfRQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqCiQ5gATVdwyATC6mk8VTWdX5KFYYuOk9+ZTq56QBIqytwvP0iNyu7bSO6pzgucoLbZ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lQ3YTp/6e/196yNzxFN4P56hiiqwlzfVx7AUnKVGl2pK0PZgQg
	pAiCvKBzn5rnRjjc4boSyYiTxMc2PJuImO06byfLSpQ6HVj2bIYO5ARK2vDFkO4sr6W7I1VBWDJ
	DCJzU2A==
X-Received: from pgg24.prod.google.com ([2002:a05:6a02:4d98:b0:cbe:dc9e:aa41])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57ef:b0:36d:b12b:f57d
 with SMTP id 98e67ed59e1d1-395a06363a2mr17704953a91.12.1787318920864; Fri, 21
 Aug 2026 06:28:40 -0700 (PDT)
Date: Fri, 21 Aug 2026 06:28:40 -0700
In-Reply-To: <829b5c18-6ffe-46fe-bfed-03d5ddde92d9@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260129063653.3553076-1-shivansh.dhiman@amd.com>
 <20260129063653.3553076-8-shivansh.dhiman@amd.com> <aauJ80pZrw_SfF31@google.com>
 <db768f80-dfda-42a2-8601-8d0af35c2959@amd.com> <an0BbcxUNRKqnUSJ@google.com> <829b5c18-6ffe-46fe-bfed-03d5ddde92d9@amd.com>
Message-ID: <aohSiFQbfqpKoBX9@google.com>
Subject: Re: [PATCH 7/7] KVM: SVM: Enable save/restore of FRED MSRs
From: Sean Christopherson <seanjc@google.com>
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>, pbonzini@redhat.com, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, xin@zytor.com, 
	nikunj.dadhania@amd.com, santosh.shukla@amd.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 19, 2026, Shivansh Dhiman wrote:
> On 13-08-26 04:57, Sean Christopherson wrote:
> >> Would you prefer it handled in svm_recalc_fred_msr_intercepts() instead
> >> while setting intercepts? Or is there a better way to deal with this?
> > 
> > Take a hard dependency on an upcoming APM update that states the control area
> > is valid after shutdown, and rework KVM to not clobber control fields on shutdown
> > interception.
> 
> Sure, Sean. I'm thinking something like the diff below. It contains three
> parts:
> 
> 1. Clear the save area and offsets 60h, 61h, and 68h of the control area,
>    as per the APM.
> 
> 2. Zero the intercepts as well. The APM doesn't require it, but it seemed
>    worthwhile so that the new intercepts are computed on a clean slate
>    rather than on top of whatever survived the triple fault. Is that worth
>    doing?

My gut reaction is I don't see how this can possibly be safe or correct.  How
does the guest taking a series of faults have anything to do with what accesses
KVM needs to intercept?

> 3. For nested, same fields are copied to vmcb12 when a shutdown is intercepted
>    in L2. Clear them while copying so L1 gets a deterministic value
>    rather than whatever the hardware left behind. Does that seem like right
>    thing to do?

No, because that violates the rule of "don't make stuff up".  It could also be
actively detrimental to L1's ability to debug issues (e.g. if hardware leaves
breadcrumbs in the save area), and risks creating guest<=>host ABI that we don't
want to support.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 83de3456df708..38843b29b21ec 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1149,6 +1149,11 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
>         vmcb12->control.event_inj         = svm->nested.ctl.event_inj;
>         vmcb12->control.event_inj_err     = svm->nested.ctl.event_inj_err;
> 
> +       if (vmcb02->control.exit_code == SVM_EXIT_SHUTDOWN) {
> +               vmcb12->control.int_ctl &= ~GENMASK(15, 0);
> +               vmcb12->control.int_state = 0;
> +       }
> +
>         if (!kvm_pause_in_guest(vcpu->kvm)) {
>                 vmcb01->control.pause_filter_count = vmcb02->control.pause_filter_count;
>                 vmcb_mark_dirty(vmcb01, VMCB_INTERCEPTS);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 519249e75420d..62b4feb9c3909 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2090,7 +2090,11 @@ static int shutdown_interception(struct kvm_vcpu *vcpu)
>          * cannot be reinitialized, i.e. synthesizing INIT is futile.
>          */
>         if (!sev_es_guest(vcpu->kvm)) {
> -               clear_page(svm->vmcb);
> +               struct vmcb_control_area *control = &svm->vmcb->control;
> +               memset(&svm->vmcb->save, 0, sizeof(svm->vmcb->save));
> +               memset(control->intercepts, 0, sizeof(control->intercepts));
> +               control->int_ctl &= ~GENMASK(15, 0);
> +               control->int_state = 0;
>  #ifdef CONFIG_KVM_SMM
>                 if (is_smm(vcpu))
>                         kvm_smm_changed(vcpu, false);
> 
> 
> Cheers,
> Shivansh
> 

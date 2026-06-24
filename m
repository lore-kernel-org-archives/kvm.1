Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2043AE18D
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340089; cv=none; b=m8N+KH6WIYVhXjKXxerMjvP+bnNJhgitAQPokfzTAqQM7SXCfsB5iBOofSO82GnGVzgGaQsGCfTcTdZavQhf5oF0lIWdGR1Gs1HxeWZy2lcI/jmP7FmG8jtc6lKtNTAZOnNXe4iw4ksp17VynSE93HqKyt6G95W30d2kFFXetU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340089; c=relaxed/simple;
	bh=iYzlXFFtwrNOSeUItoEwOA4kQ6hwth+tnUdJV4zAI3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5q6SpO+trKpZHOA25X0K0bxjmSNJDGHKDH5GR1tGs3m1RBppRJ7j8kGLsa2tUqFW2+rpsy6bmCVK+OBdfxS+gUrHcUXqnhyhy8aCKfNHMXcq67HEtNWZidPVYst4y2jLmLbC/QZnCKlGzBeAAIQoYE4RD3qjpkWQ2rwkJZAWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F6CLWuzY; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F6CLWuzY"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8894570b58so839726a12.3
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782340065; x=1782944865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dE4wtlwd4UKJdKkZ5EnOOlpdhdJbc1e0cnd+7Jbu9n0=;
        b=F6CLWuzYvArFG7X1J7ipRM7I51rrxgCKKuNhSpcVJxsNXtbcF4X4+DQp+e8zr6ieRC
         iY3TCUL/ozhEJuPbF4dppZgLqXYtnHqvfcl6uQk2DN3Yu29TMkh6Pff5OI8uklF/SgCC
         ItUAStv6amKRD5n75vUg8b07H3Nn1JhMY5E8OGY23QYuY2g/+aWNIRxx3JQlWAaZMNun
         ShuzP1KZ5eEuiiXhaa8jLvOXYpPNIm/J4gm+fzaNl4XBssApvirvBygqUolZDV29rTYQ
         Gb0zyvOD4/7SSDqMXXxzVm2EzMQCoJBwCEgKGr8gY/9JKFp1icKa5aaAkePGmp2yQZNS
         BKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340065; x=1782944865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dE4wtlwd4UKJdKkZ5EnOOlpdhdJbc1e0cnd+7Jbu9n0=;
        b=KV9AT5wp0zyc4bfLtW09iIj57Mhq6X9kSAW/IM6RvBvenmZ1aTKvt/42QEpTILRB43
         SCIaBpPNcUa1xsdYertQ6PUb6IOSY/VUyDalMwjMGy1OiLGiKuLrFbpufYZgO8/bXJHN
         XNABIZx4C2BVYlkWJdAlheHxeWmS310r6c16n09B/2D9q6wef+2gDv+P67kWKYp+pkF6
         dnEJ/lWB2uRC2CwzRKvR55freBaoJd6wFa5q1R0/fZNmMz8oDRGHupHtlF82v7OY+9zX
         0IdUII37zF7AroM7FrQrIcFyQPfgnR7sqf/woG8sv1084xBKgRIhqxTB4gx8BeUPFF/H
         aKMA==
X-Gm-Message-State: AOJu0YzwZBPx8dOPs2VEZqmXwRgJGamsA5VrhccgfbHeh/UXxiTHyuhZ
	R+lbROGkOFcfZtN7USSp6yXsnoWUshzZMzz3XL/++2GbstM+WmSeKQz7/25z9Gf9WOSsU47Q0pC
	Ptg29aw==
X-Received: from pgjd16.prod.google.com ([2002:a63:d650:0:b0:c86:2413:1f39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918e:b0:3b5:52b4:87a7
 with SMTP id adf61e73a8af0-3bd4abed5abmr1654637.6.1782340064967; Wed, 24 Jun
 2026 15:27:44 -0700 (PDT)
Date: Wed, 24 Jun 2026 22:27:44 +0000
In-Reply-To: <20260624221757.393111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624220516.3033391-1-seanjc@google.com> <20260624221757.393111F000E9@smtp.kernel.org>
Message-ID: <ajxZ4PLDkaZ698ht@google.com>
Subject: Re: [PATCH] KVM: x86: Ignore pending PV EOI if the vCPU has since
 disabled PV EOIs
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 24, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> > --- a/arch/x86/kvm/lapic.c
> > +++ b/arch/x86/kvm/lapic.c
> [ ... ]
> > @@ -3382,8 +3388,6 @@ static void apic_sync_pv_eoi_from_guest(struct kvm_vcpu *vcpu,
> >  	 * KVM_APIC_PV_EOI_PENDING is set, KVM_PV_EOI_ENABLED is unset:
> >  	 * 	-> host enabled PV EOI, guest executed EOI.
> >  	 */
> > -	BUG_ON(!pv_eoi_enabled(vcpu));
> > -
> >  	if (pv_eoi_test_and_clr_pending(vcpu))
> >  		return;
> >  	vector = apic_set_eoi(apic);
> 
> [Severity: High]
> This is a pre-existing issue, but if pv_eoi_test_and_clr_pending() encounters
> a memory access error, does it skip clearing the pending bit?

Yes, that's what this patch is fixing.

> Looking at pv_eoi_test_and_clr_pending():
> 
> arch/x86/kvm/lapic.c:pv_eoi_test_and_clr_pending() {
>     if (pv_eoi_get_user(vcpu, &val) < 0)
>         return false;
>     ...
>     __clear_bit(KVM_APIC_PV_EOI_PENDING, &vcpu->arch.apic_attention);
>     ...
> }
> 
> If a guest provides an invalid memory address, pv_eoi_test_and_clr_pending()
> returns false early without clearing KVM_APIC_PV_EOI_PENDING.
> 
> Will this cause apic_sync_pv_eoi_from_guest() to falsely assume the guest
> performed an EOI and proceed to call apic_set_eoi() below?
> 
> Since the pending bit remains set, will KVM continue calling apic_set_eoi()
> on every subsequent VM exit, erroneously clearing valid in-service interrupts
> and making the VM completely unresponsive?

Yes, but the alternative is to "falsely assume" the guest did NOT perform an EOI,
in which case in-service IRQs will never be cleared, and the guest be completely
unresponsive because it will stop receiving IRQs.

I.e. the problem isn't KVM's behavior, it's that the guest is hosed if the PV EOI
page goes missing.

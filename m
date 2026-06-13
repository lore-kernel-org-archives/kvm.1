Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F91A2C0B
	for <kvm@vger.kernel.org>; Sat, 13 Jun 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781310029; cv=none; b=HDzYxVcJZL377S81OZOuJUf1UEbvgyDaVfMeq3ZMnw3B7Z2lrDucjqh7sVdapKZtwTLXUwto3ymwUCe01QN9cE0Sqw6xBZaw9JSOuaKEgnSMQC4X6lSptwkiurG/p4RXAYH9q6c5O/Mpb0LRJ7OiUl7B5uUOMgUok0G3liafH7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781310029; c=relaxed/simple;
	bh=pFzcrLzSWkUP1eJvW3lGG2DvcARF6j1tkN7/i7nSNgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdPZpMRAZZX37dGxJC3ZLDqKYt4cXxHZAwc8YWeLTNbKo+4wXyamfasUFBrW2xQdgDsvwVH36Yydavh5TqZrYgyXiZZPcops87wySs4LVDZb0MK/lkm/UG87oIw6WIayB2Q9C6JQ1rACWj56xrgmqf14YKEbO7OQXODVEnHxPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQtHpJ4x; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQtHpJ4x"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423770d72dso1987732b3a.3
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 17:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781310028; x=1781914828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=31IiaAqN5Ew/pmLAdduQflk0iW5H/bc3usr/zVzw4k0=;
        b=JQtHpJ4xLHGurmoqhqjSt3rPy+Km4fYWBGWea/SWtG5ojR5UnvWzUCI0r8Io9kOYFI
         5Ex0068j4FXkE39HmVsrhVVb0FLnIZsefLTYkyQI9L2K8SqMegUlB9kM0G1aFjB79ZTD
         +6jCKFIcIjpl79kl8kk6EQ1X5X0vwhfDtH1OipyeI/xpmVD2s4jAfZOqEOtN86JVfN/Q
         bDx4hCdW6EAjBqGLsva6dl0alOh2IIUVgi23Jm20zHBYIiBzCpU0odN0iDKw9REFjlsZ
         HOtGpgLkzRXe8yeQoPOrUvdeqZoHe9KvG8VvyFc9rnwTQKcmVkYwXXt2QBceHIffli0W
         GC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781310028; x=1781914828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31IiaAqN5Ew/pmLAdduQflk0iW5H/bc3usr/zVzw4k0=;
        b=Kf1p149flmXebBrCFKPRTYFYxFPXd4WxwmXEJ3gqTgJgI8pG6ecNt/uslPCtRwxFy4
         VRxU11wT55YvdWb7I5hAinJi5Q9RT777VzZ9/Y6OJ5c1I3Ut3qifHCPTSTGbOBPKI46Q
         9lsEPbk3sbgXjGpeZhQdVzKSt6pmZDW/GqQLi7rElr74CfFC9xptXBRg8rmIXH61r06p
         tto8xb6IeAgwMubbF5qZt5uENDh0mhaE+Hh/fvwy5UC8KjcnyyljYL/aZAuSrL0iQi51
         1yr3ecAtALjJMPNnZrW4rwpRlNX5iRRyUBJShjAQDf6BUesiv0XPGA1HD7zNdwDfw2IR
         qnJA==
X-Gm-Message-State: AOJu0Yz3uXR6ZGRKwPxNCp3EDlRS+uaDWyUvZo6H40GJv7MtjUWcKnGS
	CncqQhu4Sc7nO2GhkM61wjN0eUzvFOcLiyMpUXVs7xC+f+Wfj11ePHXEOWhso73TJ4wrMnlFt4K
	ltBOoSQ==
X-Received: from pfnu8.prod.google.com ([2002:aa7:8488:0:b0:82f:790c:3922])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:888e:0:b0:842:4612:55f6
 with SMTP id d2e1a72fcca58-844e1a29d48mr1958075b3a.21.1781310027838; Fri, 12
 Jun 2026 17:20:27 -0700 (PDT)
Date: Fri, 12 Jun 2026 17:20:27 -0700
In-Reply-To: <20260612232258.0D9131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230622.687665-4-seanjc@google.com> <20260612232258.0D9131F000E9@smtp.kernel.org>
Message-ID: <aiyiSyTu4xzCN3hL@google.com>
Subject: Re: [PATCH v2 3/8] KVM: x86/hyperv: Ensure vCPU's Hyper-V object is
 initialized on cross-vCPU accesses
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 12, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> > index e6c74cfbb1cb6..821b586ed7464 100644
> > --- a/arch/x86/kvm/hyperv.h
> > +++ b/arch/x86/kvm/hyperv.h
> > @@ -61,6 +61,18 @@ static inline struct kvm_hv *to_kvm_hv(struct kvm *kvm)
> >  	return &kvm->arch.hyperv;
> >  }
> >  
> > +static inline struct kvm_vcpu_hv *to_hv_vcpu_safe(struct kvm_vcpu *vcpu)
> > +{
> > +	/*
> > +	 * Ensure the HyperV structure is fully initialized when accessing it
> > +	 * without holding vcpu->mutex (or some other guarantee that KVM can't
> > +	 * concurrently instantiate the structure).
> > +	 *
> > +	 * Pairs with the smp_store_release() in kvm_hv_vcpu_init().
> > +	 */
> > +	return smp_load_acquire(&vcpu->arch.hyperv);
> > +}
> > +
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but should 
> kvm_hv_has_stimer_pending() also be updated to use to_hv_vcpu_safe()?
> 
> It currently still uses the unsafe to_hv_vcpu() accessor:
> 
> static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
> {
> 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
> 	...
> 
> Since kvm_hv_has_stimer_pending() can be reached cross-vCPU without holding
> the target vcpu->mutex via the spin-loop yield path:
> 
> kvm_vcpu_on_spin() -> vcpu_dy_runnable() -> kvm_arch_dy_runnable() ->
> kvm_arch_vcpu_runnable() -> kvm_vcpu_has_events() ->
> kvm_hv_has_stimer_pending()
> 
> Could this bypass the necessary memory barriers and result in reading an
> uninitialized stimer_pending_bitmap?
> 
> Also, won't using the unsafe accessor here unconditionally trigger the lockdep
> assertion introduced later in the series when accessed cross-vCPU?

*sigh*

Yes and yes.

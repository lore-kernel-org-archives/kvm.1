Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF445279DC3
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 01:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779932601; cv=none; b=NkkX/mrpUtF5UmsJhJqXk5VSpCSpXLSD9TmsWKqAWIZqhSAvzybmRPdMVFXQVEs1luvZ6f0oCqqWEeDP6bZaIFn5J+BCNpa3dfV3Q0kE9/R7omsWFvxAbuuaQp/VBVCy2rVf0tZYmrJpg0e4o5NJM92Y6rTMkq96VXIFgGHIi4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779932601; c=relaxed/simple;
	bh=JfSktUJOyWdwH7TyFs2Ee/NbtmwJ8qaa3GUTw+NIG0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Txf6CezOvUzdcWVi2cBv5Ty5J+39KYKFN9Vl/hV262YO3rjROZYO/+09jVYLfbsNSUBSlInoKcBmzG1FZRk9tynevNEZkjrc+IZYM6eAmO/WqhO0JTJQdN8ZNyU6d585KisRWhIP8BEP0J7MV4RUXtRT7mkHTR0NVVb7Yvjpla4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D++XNNFd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D++XNNFd"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso81240135ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779932599; x=1780537399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7/k0yWKOrPshF9jv7c3p2roI5HQdZlFHQmxVPy6DDis=;
        b=D++XNNFdad0ao9uNBmgL0azFdwMm8cEWdryDgg1x9Y30e/S+9i7rMoZwjAfj1jZldc
         tL95hzUpLTtn7Z1ScuQ83E8j/IKMf3W7ZO/qEyQmRd683r/UQktFwRP8DfyLxuDYQCI1
         CdTgxCD/OGJMaDpiMFcOnOqnPBVt4Kqf3MmDExaDYCzc+S66B5CzMdBcj6tFVqhF51RJ
         MbOWFz+SYs01JmkUnERHl00svg6H226IJYovW9uM6UGZ/2VF+Wl/pTaKChdL7GLiUYyy
         S20Baj05XyjsJ2zw8knWmdYWUQ0uoiV5djFKZoXD/G1e7fTKtsLy6/vZAD5789aT2tsF
         tZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779932599; x=1780537399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/k0yWKOrPshF9jv7c3p2roI5HQdZlFHQmxVPy6DDis=;
        b=IF6ylrzMOCkK29+OAL8h13uKu9fIiCCOM9AFBlNFV3ldxwqwLsOFe5mtPJ2L36jCHP
         HtwHcP7QECnLz0UWU5Jq0fs2rX9GMLlqU97jRQytd0gDwdBF54ajK9J8dgNxnCUuw5Sk
         cpoC0JrouRjF6trAUqMjwL1VMy4xxncdzMrRm1kYq6bEi4FFt2B5e2AUc6NqSnplNAmS
         2yRAQsfpc5s/bRVpVuV/5Hnbgal0H4iOsMMBt20GfessNUWbJFkEm4Gi9UVPOZdm6PzG
         zetCFEBsijVn0ZEv2tqJjK2r3y3tDQjt+JpkErpb/wFNESz2VQvMDzwRjaL/ATw5B92C
         14wg==
X-Forwarded-Encrypted: i=1; AFNElJ+LCeUDDf8W6AZrEuC45DIRXxvwOx5t/cygnE4H66QSC+ccNxv1uyJ5Cb5BHeafQC/5zCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPwN96AeBy91dNkCKwSfHs1R1Bdfw5WhDHWy0cICUM5DlaYlE
	r1Pmvu+gWa86pcSM1NaP9T+8/jN6P/xWRJs1gNmMP/BYDk9iYQvqDeegoPvRhanFuHnSgAr686o
	Ofdic2Q==
X-Received: from plry21.prod.google.com ([2002:a17:902:b495:b0:2bf:ce7:ae06])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a0f:b0:2bf:82c:6322
 with SMTP id d9443c01a7336-2bf082c66dcmr10968485ad.3.1779932598848; Wed, 27
 May 2026 18:43:18 -0700 (PDT)
Date: Wed, 27 May 2026 18:43:18 -0700
In-Reply-To: <20260528003452.7577E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260527234711.4175166-11-yosry@kernel.org> <20260528003452.7577E1F000E9@smtp.kernel.org>
Message-ID: <ahedtk6TyzgmgNOa@google.com>
Subject: Re: [PATCH v7 10/17] KVM: x86/pmu: Disable counters based on
 Host-Only/Guest-Only bits in SVM
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yosry Ahmed <yosry@kernel.org>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > index 7aa298eeb0721..41ee6532290e9 100644
> > --- a/arch/x86/kvm/svm/pmu.c
> > +++ b/arch/x86/kvm/svm/pmu.c
> [ ... ]
> > +static bool amd_pmc_is_disabled_in_current_mode(struct kvm_pmc *pmc)
> > +{
> > +	struct kvm_vcpu *vcpu = pmc->vcpu;
> > +	u64 host_guest_bits;
> > +
> > +	if (!kvm_vcpu_has_mediated_pmu(vcpu))
> > +		return false;
> > +
> > +	/* Common code is supposed to check the common enable bit */
> > +	if (WARN_ON_ONCE(!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)))
> > +		return false;
> > +
> > +	/* If both bits are cleared, the counter is always enabled */
> > +	host_guest_bits = pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MASK;
> > +	if (!host_guest_bits)
> > +		return false;
> > +
> > +	/* If EFER.SVME=0 and either bit is set, the counter is disabled */
> > +	if (!(vcpu->arch.efer & EFER_SVME))
> 
> [Severity: High]
> Does this correctly evaluate the L1 guest's EFER.SVME bit, or does it evaluate
> the L2 guest's EFER.SVME bit during nested execution?
> 
> When L1 programs a Guest-Only PMU counter to profile the L2 guest, KVM
> evaluates L1's PMU configuration. However, during nested execution,
> vcpu->arch.efer reflects the L2 guest's EFER.
> 
> Since most L2 guests do not enable nested SVM (meaning L2's EFER.SVME is 0),
> could this cause the counter to be incorrectly disabled, preventing L1 from
> profiling L2?

VMRUN fails if EFER.SVME isn't set in the VMCB save area, i.e. in vmcb12, and
clearing EFER.SVME while in guest mode is architecturally undefined (KVM triple
faults the entire VM).  I.e. this can't happen.

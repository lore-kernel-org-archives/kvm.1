Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000254EEB1
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085446; cv=none; b=Ib3AMIzuEV5/Nc1ColV0xmQjUO+3SBPi4YUPPh0Ma7sBtJ9yvzFrkljP7otIzOefcCVIoRml8AJv6FbrcndcSVS+8bEc2Qh3QXLILzAhqYtcTwefbtl7UMkbMEZFstbzQEDy+Xh7StgGK/h/pAO7u1kXLeOMS4OxXE57J9BG258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085446; c=relaxed/simple;
	bh=Fu3Ddg5gltjwll26D0GeabvW9Z4l4liKG7V1O+2Mld8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aZU4c8qZ8sPR575CHF7pdd6Fw+eeau78hSgY+IiJaKWS654+olWQkGvlayC8BQLkUMagBSPDFXA8BsY3Yi0PWxw0uhgHj3JRcHYm3xK4tFUddtm20D/sGnyOGbfwKyeTucbkIMe5q31HjvEwiBZdabGrdkNJxApuDgoL2L6KnnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zl6q59CG; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zl6q59CG"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2db87f759c5so79143645ad.1
        for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 06:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790085444; x=1790690244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LoR363Bok3mhAgop8XTST+t0fiNNL3cVY2T2m7iNRac=;
        b=Zl6q59CGL5qAeLmlhAu59kvA92jjp/HNFY6SDoP6vEL1FapVGBfRobCBzgC1gzqrtg
         FLLYk3a8wY0scdEn0jt/H29UaPSIaC2hGWPINgZD9rieVN+O3OxjPY/z2Y5rz1A14dVg
         5Y7VNgksW7P0mV4/kOpSD7ZM5qhcZql2UCW/ln/ysTx2h7QIZpWZxp07LZh6JmrVLH0p
         7GYMYyIMhgrC7MeTBq1bf0CdjNFkOuupaZslv/KYh1KDSnk0oknsQLP+nUPaIo24zH5/
         1bvBhJEcy7O6REu00VsWToxMUVsNIrx6UmC8rsRcxj2fjgsdQ7wIXM/hgaIS44k3swEF
         U6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085444; x=1790690244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoR363Bok3mhAgop8XTST+t0fiNNL3cVY2T2m7iNRac=;
        b=Lv5Sn4DAjUH/2kUSWaptCWwSO/UIQpLrR28nAMU7ZQwTMjYb8StLDj70HiJT8/O4PC
         tA+08BdUTr6OYT6fBj5atgKgkwc315bsPZj3oCXurwYR9PPSAZgo1pdaGHsYyztNc9Wc
         7CtPo9BTB2W62rPYCCQ7PVjAVKsTJVAP4ksfu/dhZFS+/jUYWNcikrzksYeHF5wCqPoQ
         NIc8onrVkM3nqJbm4aKq5zmW191SMZNaz0K2H65cvelWLIBoXIPc/ry8oz/dz5hbj97J
         BowuGBA3TivvpBkYVbQcc6G4gDztplBikUL6y74VY0Lq7hb59U4EtunYZG2BNs3rlRVg
         IaOA==
X-Forwarded-Encrypted: i=1; AKwUvBxnZFg/ysnOP58T/rbzNnK1CTFNrJc38TQ3mrqN+6mqaWSsnTzz5UXTCeH5I+vUyggDf84=@vger.kernel.org
X-Gm-Message-State: AFuF++md3AmZdDKaaaeFKDyQbLHf1E9CpqsDVEF6N/anGw3rPUifmWJ9
	iR9io5Kn2mBUnZq2/bXznKPeg2Cpk3tumRTVKYXNKrsKhBGASmOPM0NgW+TewbeRTvjs9LoTpYA
	rex0BQw==
X-Received: from plad11.prod.google.com ([2002:a17:902:e14b:b0:2df:42b8:5047])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf03:b0:2dd:c100:b2d0
 with SMTP id d9443c01a7336-2df60b7debfmr16320845ad.59.1790085443958; Tue, 22
 Sep 2026 06:57:23 -0700 (PDT)
Date: Tue, 22 Sep 2026 06:57:23 -0700
In-Reply-To: <20260918160109.E76B81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918154530.4129698-1-jmattson@google.com> <20260918160109.E76B81F000FF@smtp.kernel.org>
Message-ID: <arKJQwAPvApkeESD@google.com>
Subject: Re: [PATCH] KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported
 is set in guest CPUID
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: x86: EFER.LMSLE fix is ineffective due to dropped CPUID bit
> --
> 
> commit 0daddb3cb6cd07afcd9545a8e1643427a1542393
> Author: Jim Mattson <jmattson@google.com>
> 
> KVM: x86: Disallow EFER.LMSLE when EferLmsleUnsupported is set in guest CPUID
> 
> This commit updates KVM to reject guest writes to EFER that set EFER.LMSLE
> when the EferLmsleUnsupported bit is set in the guest's CPUID. It aims to fix
> an issue where a guest could enable EFER.LMSLE on hosts that support it, even
> if the VMM hid the feature for migration compatibility.
> 
> > diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
> > index 37d5bed3529f5..c8f894ccfb0f9 100644
> > --- a/arch/x86/kvm/msrs.c
> > +++ b/arch/x86/kvm/msrs.c
> > @@ -598,8 +598,11 @@ static bool __kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer)
> >  	if (efer & EFER_NX && !guest_cpu_cap_has(vcpu, X86_FEATURE_NX))
> >  		return false;
> >  
> > -	return true;
> > +	if (efer & EFER_LMSLE &&
> > +	    guest_cpu_cap_has(vcpu, X86_FEATURE_EFER_LMSLE_MBZ))
> 
> [Severity: High]
> Does this check actually work as intended on hosts that support LMSLE?
>
> Because X86_FEATURE_EFER_LMSLE_MBZ is defined as a PASSTHROUGH_F,
> kvm_cpu_cap_init() clears this bit in kvm_cpu_caps when the host hardware
> CPUID does not set it (which is the case when the host supports LMSLE).
> 
> Since the bit is missing from kvm_cpu_caps and is not an EMULATED_F,
> kvm_set_cpuid() ANDs the VMM-provided CPUID with 0 for this capability.
> Consequently, vcpu->arch.cpu_caps does not retain the bit, and
> guest_cpu_cap_has() here will unconditionally return false.
> 
> Does this mean the bug remains triggerable by a guest running on a host with
> LMSLE support when the VMM attempts to hide the feature?

Gah, I hate the negative "feature" bits, I've gotten completely turned around
multiple times trying to sort through this.

IIUC, you're trying to "fix" setups where host CPUID.EFER_LMSLE_MBZ=0, but userspace
configured guest CPUID.EFER_LMSLE_MBZ=1?  If so, then Sashiko is right, it needs to
be declared with EMULATED_F().  I would even argue that technically this isn't a KVM
bug, because KVM won't advertise EFER_LMSLE_MBZ in KVM_GET_SUPPORTED_CPUID on such
hosts.

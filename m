Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DD2609C5
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200465; cv=none; b=exll6GYBA9SKs4mH2VBTuXvGdhcuTazuZL6wNOOE0CUR54MTG0JG0H4wu40o2IRoZnEN41M7UJsGT+ozRlRVhaAMeia6WdvbFAutk1M8ntiUtNpkxTMxkmRInLpG1waiYovT+miWrWyXfXthsssg8lrzkYjA6Vj7NiwNZyRAWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200465; c=relaxed/simple;
	bh=PimpcPnu/HCiRsRLYqpWDsqSbgXlOYJZFEqNFHLBIfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tq7DZ/IkjJ/DGAihaUWEu+gq8Dat3B79iwszb93gcZZ5uxthOue2du152ann7DETh7XgFkRwTFJQL2H7MI7iCgiAekp9fB8lJSIeKpdI2AX6EgNtY1ijwBr6S1MDC2RYqPN9FY+vHKRCs5YRqA/SV8f9+B1adYc3gqjE6U5QnBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IW1QqAjs; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IW1QqAjs"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cccfa32670so43692455ad.2
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785200463; x=1785805263; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3MQ2ppBxGdOC/Mg9PkZYye2SrWSAeiiRLHe45A5wceI=;
        b=IW1QqAjsn0+rwznPi7iUCBOUSedlSgVQijQvUOELAkg57+Zty4YN6azrv7lTTI/rho
         u+hzGrT/mg1QF9A7JKOVmSv8Znq7KrHSK9bHizq3AB4SIRd0P5MIHGsaDsYTxgC6fkVg
         oH665XjglZCMXK+aMGH0VzGoktSqvyLDegeMuQDrcZeo0WHZQDv+jtUILnBvO+FxY5YL
         9zZiGfwBlOxiAltdWET/cZNxdYqsXdInZcTygh5ss/PbCTAkzffC/iW6uYG/n+kQUJeM
         R3HmPh1TNjcX2H7v3EIHAKP+D677tvW7g4TxDqlMYfGn/8dpVL02YXSo4RGjyrr2ddrT
         WG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785200463; x=1785805263;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3MQ2ppBxGdOC/Mg9PkZYye2SrWSAeiiRLHe45A5wceI=;
        b=ZRkxxusEBUgT6jy/gY4be4u+XjchYPLFmFhM0hUK/Q3vK2eSWkyb3A2Na4BFDpOThs
         nj55a7Lk0gnEhV/0/Zvw0NzkVh86yapeSj1awf2Zr39m5ITVRuLYeN8DTOA2CGEz/aYl
         jpdkTr+55GePqV0+bwzDKwEIiLvGluoTziyeqwyGlwj34ZW+HWdufFiwSRckPvDADm/+
         H6RObYCIji/ECebh6nmxZSrcrhrS0JAuROg5GFeA3dQv1Nss0ffm8tEwt+M+26GI5LAA
         fOpaKo6W1uQwPS2dexH0uyKJmR6qPeIQoAF8Dnbgkp4Ohrpga5GadtaWjFua36nMfB9M
         MVxQ==
X-Gm-Message-State: AOJu0YyL2xZAdEoOpIXh1+165+0ZvN0RAjB6K09SbPrB5G05gKP9tfsx
	yx/Tr5HOsfjiJKl097X/i4B05p2hJVN8BHs385W/t/KNwWV0XvECQjZ+FeLkPuBuNYadS175VcU
	3LdqLbA==
X-Received: from plnl15.prod.google.com ([2002:a17:902:fd8f:b0:2cc:2c68:b71b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8a:b0:2ca:bf68:2a54
 with SMTP id d9443c01a7336-2d015d238a7mr1997475ad.22.1785200463091; Mon, 27
 Jul 2026 18:01:03 -0700 (PDT)
Date: Mon, 27 Jul 2026 18:01:02 -0700
In-Reply-To: <20260728005847.6EF2F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728004351.887076-1-seanjc@google.com> <20260728004351.887076-2-seanjc@google.com>
 <20260728005847.6EF2F1F000E9@smtp.kernel.org>
Message-ID: <amf_TkUA-etGt_CX@google.com>
Subject: Re: [PATCH v4 1/6] KVM: x86: Extract VMX's unhandleable emulation
 check to common x86
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 28, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> > index 04f986e3d439a..924a629c21e2f 100644
> > --- a/arch/x86/kvm/vmx/main.c
> > +++ b/arch/x86/kvm/vmx/main.c
> [ ... ]
> > @@ -939,11 +949,12 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
> >  	.flush_tlb_gva = vt_op(flush_tlb_gva),
> >  	.flush_tlb_guest = vt_op(flush_tlb_guest),
> >  
> > -	.vcpu_pre_run = vt_op(vcpu_pre_run),
> > +	.vcpu_pre_run = vt_op_tdx_only(vcpu_pre_run),
> 
> [Severity: High]
> Does this conditionally assigned NULL pointer cause a module load warning on
> systems without CONFIG_KVM_INTEL_TDX enabled?
> 
> Since vcpu_pre_run is declared as a mandatory hook (KVM_X86_OP(vcpu_pre_run))
> in arch/x86/include/asm/kvm-x86-ops.h, setting it to NULL when TDX is
> disabled will trigger a WARN in kvm_ops_update().
> 
> [ ... ]
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 960ff7fcd8dba..8c3efc1be1fa4 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8867,6 +8867,11 @@ static int kvm_x86_vcpu_pre_run(struct kvm_vcpu *vcpu)
> >  	    !kvm_apic_init_sipi_allowed(vcpu))
> >  		return -EINVAL;
> >  
> > +	if (kvm_x86_call(unhandleable_emulation_required)(vcpu)) {
> > +		kvm_prepare_emulation_failure_exit(vcpu);
> > +		return 0;
> > +	}
> > +
> >  	return kvm_x86_call(vcpu_pre_run)(vcpu);
> 
> [Severity: High]
> Could this break KVM_RUN by returning an uninitialized register value when TDX
> is disabled?
> 
> When kvm_x86_vcpu_pre_run() calls this static call with a NULL target, the
> static call machinery will patch the call site with a NOP or RET. The CPU will
> execute the NOP and fall through, leaving the return value in the RAX register
> unmodified.
> 
> Since the preceding call to unhandleable_emulation_required() is a boolean
> function that typically returns false (setting AL=0), the uninitialized RAX
> will evaluate as <= 0. This would cause kvm_arch_vcpu_ioctl_run() to
> immediately exit to userspace instead of entering the guest.

Gah, that's what I get for splitting the diff just before posting.  I'll fix
both of these in v2, and make sure to test patch 1 in isolation.

Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A094030FC33
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 21:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289079; cv=none; b=DG/X+LM3hZFyQem3yBmlVjmoSOJ71+thCb2+ph0xm4ENERuLAltgPjHsNr8CXB717VEiAStH40X9W22DoWyDb3QxVP5eBzDt7K8USHjgmfXRFr+mo2olw05htaLi7I1NBDTeGGnf8MC5m2mxgIPDz/Z8XaUgFAoIHHCnouoj6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289079; c=relaxed/simple;
	bh=32bm9Xxg1TOci3XYz23eS/DTvTlmmzdftVOx7xsiBe0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3ueT5iYJXKRQPhkkT6O4R9yMhGwPiNH24MlvuFk2BIWQdGyyaiBvd4M+JtL0z0g0cVR+gy3FiIvLJoi/mzODQx5GOOW2s9I6USw4MGJqL5BAjDpJg55HMnrjCSU7oZqppFiUWZataz2TKpmixx+abSOC8eaevwp0if3XZIs03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KA/cdZLs; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KA/cdZLs"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b458add85aso43940955ad.2
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776289077; x=1776893877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6yj8SN9UKwtYWyKH0a4I661ApOIb3FsNFx//CycZLRI=;
        b=KA/cdZLswGOx7bPwAiq7hEVIc/qvfZyaueBkQHZ4ZKixgK+8IGslRbIBR4oorDdrD1
         zMnxJPLzXZARNcLJFJO0H3xw7qO0P5triGK7jJlGS1O6aby+3ZJ5Nq6JiAOdZaZpYCs1
         lMpKr/2x+PzlVdihJaeopBhxV6AeM1kjllVpapaaNYC0g6rQPdvxgi7oUsXwHm8683tQ
         4NTLm0Pdd/PhvJIn/iMKtGkRtEbJbuhLoOEFgpT0fNs0Q0vY8MeCJlauHUCCdKhjzhXQ
         lfs3YpgiE1nfHYn0vmtjo4/1kFa3/K2wWuwNFYUjbzBhdDzYapiZBdOw6bOiJm2C+ws5
         Do+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289077; x=1776893877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yj8SN9UKwtYWyKH0a4I661ApOIb3FsNFx//CycZLRI=;
        b=T0L74eMEn5IblMNUOw22vVrQsPcVZ8zdPywmhJu3+otJ7bGTWlqYZQcHFcVNbyLlKo
         mU9VE8Hpg1XyhSJ/CGCnoYP8+fU/W9W2lMgMGQmDBhP1SCX4mgnx2EoI2i6KMLRjLJUF
         xgjt3pJU6tOtTYjpLvFb/YzpPbukWxriWikfFy+Rt1CjvmDt66ONk+OFRcFwvZWJFT/2
         n+aV6ajq/AT/bxeHL9DRsOjwgDTUVHtfB/XnFspjbRz5z6CWqPfe5lKS4DmbnQs32Gsi
         eRKy32HwJNIK4manIMyWaQsIS40wMhpAy0pDSxjlQVLuNGs70cc1SB9q6yWPBbBXVMYM
         O/qQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aAk8prP2Yupj6Gp1tALWnXnaEYbSskZvVR9Qz7cqnC2RB6MUavQQO1AOCqIShbOiFnbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz58bd8wXLY9OycUTMMvYKvWPLYRdR95X/55F6IPP95dLYbi1R
	qh40qwqbymmC3I0GfTDtTNx3UaPlclJWIghR91nnhCubAAmCmMZLNYx1O3cTt8bO1uPISIahMG5
	Wj3o9PQ==
X-Received: from plop2.prod.google.com ([2002:a17:902:8a82:b0:2ae:66c7:db93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac6:b0:2b0:60db:7927
 with SMTP id d9443c01a7336-2b2d5a168bcmr239560035ad.28.1776289076795; Wed, 15
 Apr 2026 14:37:56 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:37:55 -0700
In-Reply-To: <dea50f27311d88dcb09ea98261ca280853396a42.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-5-seanjc@google.com>
 <dea50f27311d88dcb09ea98261ca280853396a42.camel@intel.com>
Message-ID: <aeAFMwBTUCdeq1JS@google.com>
Subject: Re: [PATCH 04/11] KVM: VMX: Read 32-bit GPR values for ENCLS
 instructions outside of 64-bit mode
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 13, 2026, Kai Huang wrote:
> On Thu, 2026-04-09 at 16:56 -0700, Sean Christopherson wrote:
> > When getting register values for ENCLS emulation, use kvm_register_read()
> > instead of kvm_<reg>_read() so that bits 63:32 of the register are dropped
> > if the guest is in 32-bit mode.
> > 
> > Note, the misleading/surprising behavior of kvm_<reg>_read() being "raw"
> > variants under the hood will be addressed once all non-benign bugs are
> > fixed.
> > 
> > Fixes: 70210c044b4e ("KVM: VMX: Add SGX ENCLS[ECREATE] handler to enforce CPUID restrictions")
> > Fixes: b6f084ca5538 ("KVM: VMX: Add ENCLS[EINIT] handler to support SGX Launch Control (LC)")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/vmx/sgx.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
> > index df1d0cf76947..4c61fc33f764 100644
> > --- a/arch/x86/kvm/vmx/sgx.c
> > +++ b/arch/x86/kvm/vmx/sgx.c
> > @@ -225,8 +225,8 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
> >  	struct x86_exception ex;
> >  	int r;
> >  
> > -	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 32, 32, &pageinfo_gva) ||
> > -	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva))
> > +	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 32, 32, &pageinfo_gva) ||
> > +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva))
> >  		return 1;
> >  
> >  	/*
> > @@ -302,9 +302,9 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
> >  	gpa_t sig_gpa, secs_gpa, token_gpa;
> >  	int ret, trapnr;
> >  
> > -	if (sgx_get_encls_gva(vcpu, kvm_rbx_read(vcpu), 1808, 4096, &sig_gva) ||
> > -	    sgx_get_encls_gva(vcpu, kvm_rcx_read(vcpu), 4096, 4096, &secs_gva) ||
> > -	    sgx_get_encls_gva(vcpu, kvm_rdx_read(vcpu), 304, 512, &token_gva))
> > +	if (sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RBX), 1808, 4096, &sig_gva) ||
> > +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RCX), 4096, 4096, &secs_gva) ||
> > +	    sgx_get_encls_gva(vcpu, kvm_register_read(vcpu, VCPU_REGS_RDX), 304, 512, &token_gva))
> >  		return 1;
> > 
> 
> Is there any case where bits 63:32 can have non-zero value?

Yes, GPR values aren't modified on transitions to/from 64-bit mode.  E.g. if
software loads 64-bit values in 64-bit mode, under the hood those values will
still be there while the CPU is in 32-bit/compat mode.

Well, that's not strictly true, per the SDM.  Values are only preseverd for R8-R15
on compat<=>64-bit transitions:

  Registers only available in 64-bit mode (R8-R15 and XMM8-XMM15) are preserved
  across transitions from 64-bit mode into compatibility mode then back into
  64-bit mode. However, values of R8-R15 and XMM8-XMM15 are unde- fined after
  transitions from 64-bit mode through compatibility mode to legacy or real mode
  and then back through compatibility mode to 64-bit mode.

And "legacy" GPRs are never preserved:

  Because the upper 32 bits of 64-bit general-purpose registers are undefined in
  32-bit modes, the upper 32 bits of any general-purpose register are not preserved
  when switching from 64-bit mode to a 32-bit mode (to protected mode or
  compatibility mode). Software must not depend on these bits to maintain a value
  after a 64-bit to 32-bit mode switch.

But IIRC, that's "just" the architectural behavior.  Hardware implementations may
choose to preserve values.

> If vCPU is in 32-bit mode then it should not be able to access 64-bit GPR?

Yes and no.  Mostly no.  Architecturally, they're all off limits.  But, again
going from memory that's ~15 years old at this point, IIRC the behavior is that
writes in 32-bit modes zero bits 63:32, same as 32-bit writes in 64-bit mode.

Take all of my memory with a huge grain of salt, it's very possible I'm
mis-remembering hallway discussions from a long time ago.

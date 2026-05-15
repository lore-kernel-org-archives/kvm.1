Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51053250C06
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778849727; cv=none; b=YMJFS6e/9SqaBiZjZjiQAOInfTrZy96MH1DOq/d1bZpgS8yWJYCY2YCxklLoVg3CfG70FlClKYgJOckyy5lH6TqI2N+R0f99ldXJWTLg2RMMhWO0lEme6S5RRGtI9M9cCvmpP/CnF0+PzaZQAyot2uNFyHcApySHkM4gWaxCRyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778849727; c=relaxed/simple;
	bh=44RP69sPTtq9JEi9bpgbdn/yGIvfT4t9nmIg1PVAgfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxwBFJ2UyzcZYmgj7wKwyv2QXIeoV3LmFxL9yppC7aCobSVf++hr6q/Fo7v7t5ixyHB1SME89rmZJJ7QMkgHV4feTaHUboiRyV2N4fV4chFCUjciC6Sd4AWpC8xb2935cJcE5mVykrBbnWtWfmxrIX2HDjUwGvKn6VPsEo4OUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnfIDeW3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnfIDeW3"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83544d05c5aso4946487b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778849724; x=1779454524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8R1ixx0UWdwtZn2mIf1Xzrj0hOLehMAvsgFWFCX8EE=;
        b=jnfIDeW3Cg8ws/dlTrm5rGglseFkQztINryzUvskBfQ+RHyh1Qo1O/XvNVepidqEHA
         pePzP8yvhCEqFHZAv2fcqn9Tz/ybtFf0AOnD9zsD4GKr6NO+p6gZajuk3eT2l73PnlGw
         J+viLnEB8D+x6hTab9ZTQZfKiVyWGLvp7RmfGEzTAm3HrEs4UhnExEG2HbSfO6ReOAQl
         fnEKc8fWW6JGbbRECnwHedGUE5veEzugllNUCAG1kPQdZcZaWxF1a8E1XvAVedDJ4m42
         526PCBR4FS/nFPDICqmkxwCQxwd593jQUIZEZslLh+yrT4DGoskpSbGQmbRT8XO7vkzU
         rBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778849724; x=1779454524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8R1ixx0UWdwtZn2mIf1Xzrj0hOLehMAvsgFWFCX8EE=;
        b=rffWso2LrcTTy8Q7mqTBNOexzLtswnoz4DojMiAcFD75K5RO8Y6SNXXWMrKKv6L8FF
         yzevV6M76ETHilUbhqlwTvlBrZmukMhwPu0We1/2l1hjyk3j6/e6f5WxUfthoFVRyPhD
         jOCZfd8VzLiRwCwJyWufO2uPMXmn+nM20VmM55or2sh0jVsw/wtwoO9X4SYnYFuZ+V1a
         oisqEA+wje74AFeOOEHyfnC9fmbO8mA2Y9DMuqwLrxD3mwDbriR77uxg58omA7PSSoVq
         ggW3r6r137x7menPx2cThKVqJJb5SYu637n03pm9xwsw+wMIFLcOMWsSLV3wb7nOb/b5
         qluw==
X-Forwarded-Encrypted: i=1; AFNElJ8b/DZUvM18NS/bmOcXzVFCPAPnubKLn7Xb13UizJRox9yUlFvQcvqFqEQq4vx8ckwrNbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZi+kgq5fBcUyiQwi5c8Rj2tctoew0ST0gbEBG2udCF3U+Ipn
	+hsW8/7m+3XuQw1rsxDaKVNPpL4bjfzksI5KfAa3gq5n2NLUYDoDd9z8nGqohxlBwAgVaDKlnlG
	ofrJ6RQ==
X-Received: from pfde26.prod.google.com ([2002:aa7:8c5a:0:b0:82f:dd9:c650])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2449:b0:82c:21af:a7bf
 with SMTP id d2e1a72fcca58-83f33c25127mr4255212b3a.13.1778849724212; Fri, 15
 May 2026 05:55:24 -0700 (PDT)
Date: Fri, 15 May 2026 05:55:11 -0700
In-Reply-To: <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-4-seanjc@google.com>
 <27ba35fd-5563-4bbd-8f95-2285b50efa7a@linux.intel.com>
Message-ID: <agcXr2FP4C3I_jbQ@google.com>
Subject: Re: [PATCH v2 03/15] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 15, 2026, Binbin Wu wrote:
> 
> 
> On 5/15/2026 5:53 AM, Sean Christopherson wrote:
> > Don't truncate RAX when handling a Xen hypercall for a guest with protected
> > state, as KVM's ABI is to assume the guest is in 64-bit for such cases
> > (the guest leaving garbage in 63:32 after a transition to 32-bit mode is
> > far less likely than 63:32 being necessary to complete the hypercall).
> > 
> > Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> The patch looks good to me, but one question below.
> 
> > ---
> >  arch/x86/kvm/xen.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> > index 6d9be74bb673..895095dc684e 100644
> > --- a/arch/x86/kvm/xen.c
> > +++ b/arch/x86/kvm/xen.c
> > @@ -1678,15 +1678,14 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
> >  	bool handled = false;
> >  	u8 cpl;
> >  
> > -	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
> > -
> >  	/* Hyper-V hypercalls get bit 31 set in EAX */
> > -	if ((input & 0x80000000) &&
> > +	if ((kvm_rax_read(vcpu) & 0x80000000) &&
> >  	    kvm_hv_hypercall_enabled(vcpu))
> >  		return kvm_hv_hypercall(vcpu);
> >  
> >  	longmode = is_64_bit_hypercall(vcpu);
> 
> Is the variable name misleading?

It most definitely is.  However, @longmode is passed around quite a few locations
in xen.c, and so I don't want to opportunistically fix this one variable.  Though
I'm definitely not opposed to a separate patch to rename them all to is_64bit or
something.

> If the vcpu is in compatible mode (when guest state is not protected),
> it's in long mode, but the code goes to !longmode path.
> 
> >  	if (!longmode) {
> > +		input = (u32)kvm_rax_read(vcpu);
> >  		params[0] = (u32)kvm_rbx_read(vcpu);
> >  		params[1] = (u32)kvm_rcx_read(vcpu);
> >  		params[2] = (u32)kvm_rdx_read(vcpu);
> > @@ -1696,6 +1695,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
> >  	}
> >  	else {
> >  #ifdef CONFIG_X86_64
> > +		input = (u64)kvm_rax_read(vcpu);
> >  		params[0] = (u64)kvm_rdi_read(vcpu);
> >  		params[1] = (u64)kvm_rsi_read(vcpu);
> >  		params[2] = (u64)kvm_rdx_read(vcpu);
> 

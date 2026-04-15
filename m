Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0B9386549
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776288573; cv=none; b=aNhg/pJ8MDnvhpKIUdQg0tPIMb9C1uzXIpsLP9FTNf9geV+x947bLp4TRcdfP7jJP46tQmt0QQohZx9gbSlzboY5UCDaEE397p747mXH7pdVC0+ugTKM7D/i309hCkYY6VL+vaJuTrr+D4lHvYpF3T5tPE9tMG5UeqRVf5JgvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776288573; c=relaxed/simple;
	bh=0siSUL2S+nppBa0pJAIjFc6g+7R2A/K2TGCSE59/BVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MLUpTZ9Dr4A3Bgjsf2cdNkjygvQ2aoQEHtNjLGoVZRj8ttwVlKiI1adKL7eQLOZykhQlNSIrkyMzXXv5hwnT6MIIjM8rrzQuLTjvZDXv1aNyXsv837r29o0gT+4ddY38al2XitG76YgJ1mj70/QD4oYcACHnoF4lIdVDjoQADyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HCrALy/M; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HCrALy/M"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354bc535546so6947221a91.3
        for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 14:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776288572; x=1776893372; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLuVSKe13krUDt0Wi3UZVnEMWUJ1LNX2IauqW3oAG14=;
        b=HCrALy/MD5B5uXgH1cbtiNP+9VgrCpGawlO89670QCPn28QzxkXYVvMlCUmmDkXa+/
         IVT0Sie312gB7DRlhXySczWYoq+tSBNx3c5+eSoFKPHEj+gxz/VPkctO6RwroUDWtfru
         nUJO+BrudE/A/unORFQGaJ9v+c6gRwaIzFOAMLH6L2FuJkOOEEHBJfvO7sY0nYMtZ4v9
         uxvSx3ZtfoXWY/Z8LjmXMQBwjvpKpG7bjhV5ahQIrvPETQ5YwOn4WC7cRUOPUE+KkiFh
         iZo663YYRQr51z6MNSZ7Sb704ZoeHxei2QlDm1GUt2Cl1eeibokgP7Jy76iA7A5JyGL6
         m8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776288572; x=1776893372;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLuVSKe13krUDt0Wi3UZVnEMWUJ1LNX2IauqW3oAG14=;
        b=FpKmf/uQtdoWAFUpDQlgu4KnesL5gkbWc+qWXUrYhSTR2n9ZyPodyQaHcuCI9r3T18
         ZAv0nI8d3LuhyySbcFPjyroZJTfnlFUAGNWNI20XoxbEejQwPw8j53KkUVrLVOUxBhiB
         UB4lALsGYEuxVbLGSGYr1HfZra+pMRSn2J4tKAJXxojMd2PmFgx/0xbOj3otVoo1vJE8
         p4MwDhgV8I4+7ufkxNp8p7Rfgj6NZgen2cHeB+6CeLHBP9wLlS9H3c9mzQTyw86wxq7T
         YPuj3XlHO1zXBge9tMz2ZdscOSkJ3BiqIHREhCWEw7ZBdyLjPdFEqgMnDYZIJhl56ErL
         FUUA==
X-Forwarded-Encrypted: i=1; AFNElJ9WcmEDzmDP85KNOYCQVcGZgtfubZgXsNeaXuyARbtSAI0PFVJ/kBI0ndRJHuk1n2+O86Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRn773lnTHFhQM8O1cH/zvhE5Gl6Y893C66FI9/+0lbVDbbet9
	icDq9DUlO/eclXdl0Wi1KDvRDuZ/HafAVEY/2zjrggf8SQi1VuZnef3BPb8vi5MukNbX9LQnk0S
	HvF4aKQ==
X-Received: from pllo16.prod.google.com ([2002:a17:902:7790:b0:2b2:4331:5552])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d403:b0:35d:9560:3efc
 with SMTP id 98e67ed59e1d1-35e427e6277mr21438024a91.14.1776288571754; Wed, 15
 Apr 2026 14:29:31 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:29:30 -0700
In-Reply-To: <38309411-b86c-43cc-8451-cfdf43d84302@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-4-seanjc@google.com>
 <38309411-b86c-43cc-8451-cfdf43d84302@linux.intel.com>
Message-ID: <aeADOo9f-wW4opEH@google.com>
Subject: Re: [PATCH 03/11] KVM: x86/xen: Don't truncate RAX when handling
 hypercall from protected guest
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 13, 2026, Binbin Wu wrote:
> 
> 
> On 4/10/2026 7:56 AM, Sean Christopherson wrote:
> > Don't truncate RAX when handling a Xen hypercall for a guest with protected
> > state, 
> 
> It sounds like KVM supports Xen hypercalls from a guest with protected state

"supports" is a strong word.  It's theoretically possible.  I highly doubt anyone
has evern actually tried to smush the two together.

> normally, but it seems that a warning would still be triggered by
> kvm_rax_read() for checking whether it's a Hyper-V hypercall even after the
> whole patch set when the userspace enables KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL
> for the guest.

Ooh, fun.

> > as KVM's ABI is to assume the guest is in 64-bit for such cases
> > (the guest leaving garbage in 63:32 after a transition to 32-bit mode is
> > far less likely than 63:32 being necessary to complete the hypercall).
> > 
> > Fixes: b5aead0064f3 ("KVM: x86: Assume a 64-bit hypercall for guests with protected state")
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
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
> 
> Should this function call be replaced with kvm_rax_read_raw() in patch 7/11
> if KVM allows the Xen hypercalls from a guest with protected state to avoid
> triggering the warning?

Yeah, that does seem like the correct behavior.

> >  	    kvm_hv_hypercall_enabled(vcpu))
> >  		return kvm_hv_hypercall(vcpu);
> >  
> >  	longmode = is_64_bit_hypercall(vcpu);
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

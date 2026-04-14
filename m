Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FD93E557E
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181359; cv=none; b=NnYv/jeyWOCr0WW+BxtHN2eXbfmZ0ekKrVDgPDEFspAxQJpGHYKRSdge9l2D5bIN1Er8gg5wXj4RArRlzVPpMYKBFRZi1zBP6NtuOBHtTOgxJMKrkfsct2o53NaV+q6wcvPRCB2YnJKE1fr+HsWGksLTHqk25qJvIk9UPfsIf1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181359; c=relaxed/simple;
	bh=d85uZONoPFYoyhHBTP/5AhOjoJ1nqGGLyStv6g8XHvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZtvKZ4R9N2RbVHA3plKimM7ibhPUsQfhgv/BvqWH/5ki3TYgafX+UOgbJDO5Zflu9jpOyrcZD+K2O+2BeSK+wYBape0kYDw2E4uRFwHmkzxoBMHq7pLDXjZfV+5fzdEYrotti4HEziBSrDSDGiiH22Ns9xa11zm0w4BUku0fdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOahAm00; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOahAm00"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c76bd4feb9fso3126005a12.0
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776181357; x=1776786157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CU1ukJvg9ZrAJq3bDmKLyZtYd2mUofGAeeHs08e5UJ0=;
        b=EOahAm00gQ7c57vw6ZH8u3Kp51gRuwFuoHAg9gk9WDrtfPEdMqad0NaIfcI79rOgQc
         IwFTXppZqK5FcRfsD867mrxaapMJC8ZdnDCAfDN5slVi8944kpGYQOMPJlRcUZhgB4A3
         exXKUMSN+pY1QXTS7hHiNoiY+800XRq6OBPWy8ah4shAO4oo5FDAiGUS84HUzVevP/ua
         61jHYTVgAKkT7WfodgGfn1nsNPv5U5fllnUpAblll00yCuTjrGG7ndRs7aMfdAndbzmx
         b+4mNJfUuc5B/NokDqEAa7LSffu18mpEu9788liEWq1N6vG5Cxo6Feje6tC3BOxal/8J
         aaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776181357; x=1776786157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CU1ukJvg9ZrAJq3bDmKLyZtYd2mUofGAeeHs08e5UJ0=;
        b=Y9rgmOjl/EbxmKxk5K7vpRaOGHkoBZ11SSHSQogckhSiObJ9GJ4gwONiHWrb1usv0/
         W9uPuezhpXVveN5U9g4t0Cwul2JKD0bQ1WuxJtZWLaa0yixmhYs2UOiq3vKxxOuqUYmD
         7Q/7i9/rldINLdS0xzQ/0aWAHQbAa6oqne0srcCvtqiE+a9mJmckbj8oQKq3DU98WBcS
         Re7u11yB/725Wy6HLeIsNsCg4Ax/cY5+pc73LaqB0GhY+BV5bjI0Rat9Gfv/EiyHB1n3
         JCWD67im7p6IGClk4j3J4szkyNSE8L2gXdpmSXS8pJ5GTreghCftScIBJG7tHdwVFs66
         +8LA==
X-Forwarded-Encrypted: i=1; AFNElJ9krVDfqTIqVTu2yk06a0QG+HiW9qTB+5WBwsz5SGCL8A+72IVumZ6ZcUXnrS2SwnV82w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBE7mM1IukYP+9Hy4s3wqz1GaAAnut9qRBq8fNk0TEL0fsidWi
	x58nenN3Ae5LMbfN+ly6nubK//7pQyE6RnRcwgaj00j8Zlw1mXla6Or1fmqKtmiqkfoCpDDjs05
	4PCA1sA==
X-Received: from pgfw21.prod.google.com ([2002:a63:c115:0:b0:c6d:c043:2cb4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4305:b0:39f:5c38:8cf9
 with SMTP id adf61e73a8af0-39fe4033ed6mr20923797637.40.1776181356884; Tue, 14
 Apr 2026 08:42:36 -0700 (PDT)
Date: Tue, 14 Apr 2026 08:42:25 -0700
In-Reply-To: <04265eaad625a7e594f1f1b273cfde3c90b84934.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409235622.2052730-1-seanjc@google.com> <20260409235622.2052730-8-seanjc@google.com>
 <04265eaad625a7e594f1f1b273cfde3c90b84934.camel@intel.com>
Message-ID: <ad5gYWAQAkkxqOza@google.com>
Subject: Re: [PATCH 07/11] KVM: x86: Add mode-aware versions of
 kvm_<reg>_{read,write}() helpers
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 14, 2026, Kai Huang wrote:
> 
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -757,7 +757,7 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm *svm)
> >  
> >  	svm->vcpu.arch.cr2 = save->cr2;
> >  
> > -	kvm_rax_write(vcpu, save->rax);
> > +	kvm_rax_write_raw(vcpu, save->rax);
> >  	kvm_rsp_write(vcpu, save->rsp);
> >  	kvm_rip_write(vcpu, save->rip);
> >  
> > @@ -1238,7 +1238,7 @@ static int nested_svm_vmexit_update_vmcb12(struct kvm_vcpu *vcpu)
> >  	vmcb12->save.rflags = kvm_get_rflags(vcpu);
> >  	vmcb12->save.rip    = kvm_rip_read(vcpu);
> >  	vmcb12->save.rsp    = kvm_rsp_read(vcpu);
> > -	vmcb12->save.rax    = kvm_rax_read(vcpu);
> > +	vmcb12->save.rax    = kvm_rax_read_raw(vcpu);
> 
> Not sure whether it matters, I think there's an inconsistency here:
> 
> The "rax" one has "raw" postfix, but "rsp" doesn't, despite in practice it
> is also a "raw" operation.  Ditto for "rip", although it will be moved out
> of the "regs[]" GPR array.

Oh, there's very much an inconsistency.  RIP probably "fine", as it should be
impossible to get a 64-bit RIP into the CPU when it's not in 64-bit mode.  RSP
is likely not "fine", i.e. should probably use a "raw" version.

But most importantly, for this patch, I want to avoid introducing functional
changes, which means using the "raw" variant to read RAX.

> But maybe they are different?
> 
> [...]
> 
> >  	case EXIT_REASON_MSR_WRITE:
> > -		kvm_rcx_write(vcpu, tdx->vp_enter_args.r12);
> > -		kvm_rax_write(vcpu, tdx->vp_enter_args.r13 & -1u);
> > -		kvm_rdx_write(vcpu, tdx->vp_enter_args.r13 >> 32);
> > +		kvm_ecx_write(vcpu, tdx->vp_enter_args.r12);
> > +		kvm_eax_write(vcpu, tdx->vp_enter_args.r13 & -1u);
> 
> Nit:  the "& -1u" isn't needed anymore with using kvm_eax_write(), but maybe
> we should just focus on replacing the functions in this patch but leave
> cleanup in the future.

Gah, good eyeballs.  I intended to drop it here.

> [...]
> 
> 
> > @@ -12184,23 +12185,23 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
> >  	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
> >  	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
> >  
> > -	kvm_rax_write(vcpu, regs->rax);
> > -	kvm_rbx_write(vcpu, regs->rbx);
> > -	kvm_rcx_write(vcpu, regs->rcx);
> > -	kvm_rdx_write(vcpu, regs->rdx);
> > -	kvm_rsi_write(vcpu, regs->rsi);
> > -	kvm_rdi_write(vcpu, regs->rdi);
> > +	kvm_rax_write_raw(vcpu, regs->rax);
> > +	kvm_rbx_write_raw(vcpu, regs->rbx);
> > +	kvm_rcx_write_raw(vcpu, regs->rcx);
> > +	kvm_rdx_write_raw(vcpu, regs->rdx);
> > +	kvm_rsi_write_raw(vcpu, regs->rsi);
> > +	kvm_rdi_write_raw(vcpu, regs->rdi);
> >  	kvm_rsp_write(vcpu, regs->rsp);
> > -	kvm_rbp_write(vcpu, regs->rbp);
> > +	kvm_rbp_write_raw(vcpu, regs->rbp);
> > 
> 
> Ditto, the "rsp" one stands out. :-)

Yeah, same thing as above.  I don't think the currently code is 100% correct, but
in practice it probably doesn't matter.

If we want to clean up RSP handling, it should definitely be done in a separate
patch (or patches, plural).  But I'm hesitant to even try, especially for this
path since it's very much part of KVM's ABI.  I.e. if ain't broke, don't fix it.

> 
> [...]
> 
> > +static __always_inline void kvm_e##lname##_write(struct kvm_vcpu *vcpu,	u32 val)	\
> 
> It seems tab is used before the 'u32 val'.  Seems no need.

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976773;
	b=n4vggowlmHZmMlA6qtatKzFqYzfbi3NhpfV9t38kzEnrUiXBSpasc6CUqGggEujEaZen
	 Gxb2I/jd0StDSIOPbWoJqMIXoXHle1Q7yTgjl8aP3CeAravuCa8c8pZlZ4cUOIIg3U7i0
	 E8SCd9ndWclnllNVQn3+auRlT6/SjWcXH8A25DJn7SmfDwVMkY6MHPI5+nXljQni7ckX9
	 lYT3I4eZW4wKTp7jAtHTjDGDn75m7EKnm8zQEwNGnmL/R5jj9Hc69/EiEnqTcnO3xX/M3
	 jhhkCwE6VAFx8o017jBI3F6EjfdmpX/IjxjgS+8e4q5/mKHUx02a/Lls+iDe0Tlflqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976773;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mTZoZl82Wnsn4g/swOfuMpM27YOTs61qdqkI+/vOOPI=;
	b=iygBug8sP5SVkDksb2VQC621taNgJQxbeHUa2vUtuPyJWK5oSh/Md7O4wRRYxcu9nttn
	 NP+ZSkvBjLahPCJfAPClKVlqJtz6xBVaJXbLa0Nn++tMb2TVrgDLmcPEA1zdHwYcuZQEP
	 qYJtz1sJwS6nXMeOlc7yz/08nog6+SarndFAbKJAjxCCUvUy1C7b4E+uGzSK4ZdjwMbMm
	 nRDgjqXN1rOzsw4CjGLo49KSCT48wnC3UVgZA0yRdRExDqaYypyvxFyLUVftZJO4qV2xM
	 0yXybOrbK2TgLUNzFobmCrFJypiMIDnxXwSe4BlyP5NhPHVcvBLUwpLBkfvSC/Nr+XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QjFy6PkQ;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277B606A330
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 14:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F277B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QjFy6PkQ
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ade5b3ae97so681847a91.1
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 06:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793976771; x=1794581571; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mTZoZl82Wnsn4g/swOfuMpM27YOTs61qdqkI+/vOOPI=;
        b=QjFy6PkQuGay6ea5S+xm/gnvCXq3afG5H1SEYm52pR55mi7jne1by7zR9FhAPK0jfm
         arr+XtYm7rWpEwNlUsoz8QDe1vfi3qDgRTqaGJ/Twk9AcUDAFLnywsBF1GJIyDNsxqG8
         Tdqt4vglFwAdk3E3ebmI+UlKDONlZUZDC/NcTnAF+M4sfc5H6DztzXNJ3oBwXFsVdN5q
         wd3UuvgKV2sMjgYB4Gr5kaMmPBciwXTULucvs5BoN394kw3ZcsYAktvyX1G8qnk7tiN0
         u9FQnZv+WHNmREfgrHvMiCbvFUnpK2Omf+5cAhKq2rrENnzhBgerwx84T+Y8jGQPF/Xz
         JSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976771; x=1794581571;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTZoZl82Wnsn4g/swOfuMpM27YOTs61qdqkI+/vOOPI=;
        b=UHfLXqd/Q/L9KJcv16yLOL3V2px0DXIBeH1zDlJ8z6mT/tG44TYkNr4f0wKoMtW1eJ
         9dSsEfiM+XeaAqYvIOOy7Ioruzh2p7MQYIOQNB8fCqXHYCRZyqRNLUam1WJlsEgMlI8s
         6bwyD0aSBKFQNGhHh+vCm+0U1c+G73hWPAtsn9EBzbg/fPwRfdYoYtRfEjNKCahxXhV7
         F+Jb8AnxAJU8PEvDX1NX/CQnsVCPUemUVCn4q/4jQxp4Js9cRiJvSm1Gv8Rysz9rNiDf
         ++gO2xMqFICaIzFIBHiIpzUBGiBiCEYWuYXHb34tWUk9q3Z12jmKnmMIkyvLOzBXt/M8
         LJUg==
X-Forwarded-Encrypted: i=1; AL+hErFv5tkA7n8zN+yTzw3fnrsLdt5iMiO5KTkGBr2N3+62EhdzdoWd7NA6G0GRr5EYPHkCWlk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ETcZd8CV6ybQ861g636nXrJPlORt/bX/aWRBW9aTySlW7JJiO
	4uhHMb/8SeN9vlfOV62wjr8EACuLwSmubAykGwGQYaJUR2wCqtNO+0GWvnfQLZi4IgcCh3Tr1Or
	osMgdXA==
X-Received: from pjbch23.prod.google.com ([2002:a17:90a:f417:b0:3b0:98dd:7ee1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164e:b0:3a0:e568:ed63
 with SMTP id 98e67ed59e1d1-3b0db6b6e58mr1611679a91.8.1793976770968; Fri, 06
 Nov 2026 06:52:50 -0800 (PST)
Date: Fri, 6 Nov 2026 06:52:50 -0800
In-Reply-To: <sashiko-outbox-200423@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105-tdx-selftests-v16-0-2024e8fa517a@google.com>
 <20261105-tdx-selftests-v16-18-2024e8fa517a@google.com> <sashiko-outbox-200423@kernel.org>
Message-ID: <au3pwtxF9Qs97mfu@google.com>
Subject: Re: [PATCH v16 18/20] KVM: selftests: Add support for per-VM ucall
 ops on x86
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Lisa Wang <wyihan@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 06, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] KVM: selftests: ucall_x86_ops is a host global instead of per-VM state
> --
> 
> commit 220d73be4cec0aafb094f8711c312a5a8ae361c9
> Author: Sean Christopherson <seanjc@google.com>
> 
> KVM: selftests: Add support for per-VM ucall ops on x86
> 
> This commit introduces an ops structure for x86 ucall handling so that
> different VM types, such as TDX VMs, can wire up their own do_ucall and
> get_ucall callbacks.
> 
> > diff --git a/tools/testing/selftests/kvm/lib/x86/ucall.c b/tools/testing/selftests/kvm/lib/x86/ucall.c
> > index 38050c60a0670..3aec4dd46d1b2 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/ucall.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/ucall.c
> [ ... ]
> > @@ -26,3 +26,26 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> >  	}
> >  	return NULL;
> >  }
> > +
> > +static struct {
> > +	void (*do_ucall)(gva_t uc);
> > +	void *(*get_ucall)(struct kvm_vcpu *vcpu);
> > +} ucall_x86_ops = {
> > +	.do_ucall = ucall_x86_do_ucall,
> > +	.get_ucall = ucall_x86_get_ucall,
> > +};
> > +
> > +void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
> > +{
> > +	sync_global_to_guest(vm, ucall_x86_ops);
> > +}
> > +
> > +void ucall_arch_do_ucall(gva_t uc)
> > +{
> > +	ucall_x86_ops.do_ucall(uc);
> > +}
> > +
> > +void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> > +{
> > +	return ucall_x86_ops.get_ucall(vcpu);
> > +}
> 
> [Severity: Medium]
> As reported by Sashiko on v15 [1], ucall_x86_ops in
> tools/testing/selftests/kvm/lib/x86/ucall.c is defined as a single
> process-wide static variable on the host rather than per-VM state.
> 
> While ucall_arch_init() uses sync_global_to_guest(vm, ucall_x86_ops) to copy
> the structure into each guest VM's private address space for guest-side
> ucall_arch_do_ucall() execution, ucall_arch_get_ucall() executes on the host
> and dispatches through the single host-side ucall_x86_ops.get_ucall pointer
> instead of per-VM state associated with vcpu->vm.
> 
> In the following patch ("KVM: selftests: Add support for TDX ucalls, via
> TDVMCALL_REPORT_FATAL_ERROR"), ucall_arch_init() mutates the host
> ucall_x86_ops in place when is_tdx_vm(vm) is true without restoring the
> default x86 callbacks when is_tdx_vm(vm) is false. If a selftest process
> creates a TDX VM via __vm_create() -> ucall_init() -> ucall_arch_init() and
> concurrently or subsequently creates and runs a non-TDX VM, won't the
> non-TDX VM inherit the TDX ucall callbacks both in guest memory and on the
> host in get_ucall() -> ucall_arch_get_ucall()?

/facepalm

I over-engineered this.  OMG, and I complete forgot about write_guest_global(),
which I added specifically to make ucalls multi-VM friendly, i.e. we can even
make the initialization thread safe.  Hilarious.

We can either do:

  void (*x86_do_ucall)(gva_t uc);
  
  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
  {
    	write_guest_global(vm, x86_do_ucall, is_tdx_vm(vm) ? ucall_tdx_do_ucall :
  							     ucall_x86_do_ucall);
  }
  
  void ucall_arch_do_ucall(gva_t uc)
  {
  	x86_do_ucall(uc);
  }
  
  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
  {
  	if (is_tdx_vm(vcpu->vm))
  		return ucall_tdx_get_ucall(vcpu);
  
  	return ucall_x86_get_ucall(vcpu);
  }
  
or:

  static bool ucall_is_tdx_vm;
  
  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
  {
  	write_guest_global(vm, ucall_is_tdx_vm, is_tdx_vm(vm));
  }
  
  void ucall_arch_do_ucall(gva_t uc)
  {
  	if (ucall_is_tdx_vm)
  		ucall_tdx_do_ucall(uc);
  	else
  		ucall_x86_do_ucall(uc);
  }
  
  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
  {
  	if (is_tdx_vm(vcpu->vm))
  		return ucall_tdx_get_ucall(vcpu);
  
  	return ucall_x86_get_ucall(vcpu);
  }

or a very slight variant on option #2 to make the paths visually similar:

  static bool ucall_is_tdx_vm;
  
  void ucall_arch_init(struct kvm_vm *vm, gpa_t mmio_gpa)
  {
  	write_guest_global(vm, ucall_is_tdx_vm, is_tdx_vm(vm));
  }
  
  void ucall_arch_do_ucall(gva_t uc)
  {
  	if (ucall_is_tdx_vm)
  		return ucall_tdx_do_ucall(uc);
  
  	return ucall_x86_do_ucall(uc);
  }
  
  void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
  {
  	if (is_tdx_vm(vcpu->vm))
  		return ucall_tdx_get_ucall(vcpu);
  
  	return ucall_x86_get_ucall(vcpu);
  }

I strongly vote for the simple flag, with a preference for the double-return
variant.  I'm going to violate my own "don't do in-reply-to patches" rule and
post a v16.1 patch in response, to see if that's trigger another round of Sashiko
review.

P.S. I'VE GOT THE POWER:

# ./tdx_vm_test
Random seed: 0x26085169
TAP version 13
1..1
# Starting 1 tests from 1 test cases.
#  RUN           global.verify_td_lifecycle ...
#            OK  global.verify_td_lifecycle
ok 1 global.verify_td_lifecycle
# PASSED: 1 / 1 tests passed.
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

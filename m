Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FD386C14
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441862; cv=none; b=LGSv41o4zvxaxXsOYz9kTIiaR0c06vv2a4lMhUEkQlTxuGg0rrDZFcaCpRjcp/bSCuYUutGoXlhXHb7sc9nQDpg+Y9i6oM5y4xo8pgw2gyYrK55VqUp3GQ98pbwQXAa44+2y3Cidu6kkOhDG7fRMsNX7PjwS/VT62v71NuOBxLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441862; c=relaxed/simple;
	bh=RObk2NFlAzoFFoAQT6+r/hBDrwrVcqFayke1/YF2S8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tq9oNXmebMsdUYmRitIfRlvpfI13l2hjFnOur2civO9hGxOKLTtubmdVE8ZFOWg9htUBR8eLZSRbhJ7XUzjmzqhtM6DCEk+F9DF5Be60GAMvqjaLuZCh2vNeIjs2/ZMwp7rjdBf7MTS39LJ0myOyZtThVHRJWcTSn8WycgM6ho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEdDT5TU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEdDT5TU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae3badc00dso31497265ad.3
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773441861; x=1774046661; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KTfWNvyTyFDvUjwuk0h7vPzttNOXgvJQjH6JyowUq8A=;
        b=qEdDT5TUGupspHtiFm2ngHiaIxCJ1qqwTPIzQTztiF8rpd8+OrU7rZSsrtd5rmhpzs
         C3Do3+oCTHPX1rIg7mdbhiSpk5oLsz0HxhnvOSHBb9beNPynooavCtcHAK14XjoN53SU
         VSgBUs7tzsW8DHfCAu7vvnghzUZT3r7YEGJKPeZb0UeClFdwpUR1r93Y0QuOk21LjUnf
         5J6CRkx+E0Xkkp6pTCEFtQWiPn2ZyLDFqyrX3maYUcpLUHtwZ3cFK2fj2rujexQz+Ee4
         ejyag3gueCYGuL0MGVz8NHOqO+NMXSLDYo1mtY5tzy8Ce7b9hLwunVfuUk3sCN3Pz5sk
         Q4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773441861; x=1774046661;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTfWNvyTyFDvUjwuk0h7vPzttNOXgvJQjH6JyowUq8A=;
        b=mDojAup08cGGMMLcUXjpTfebgRF67H8xjA4H8rEfNNCrqsYv1nvqcS/NaKYXnr48Uc
         qjJvkA8QHPZrgoOasUaNEXt6FE3jnJebVL7yOqsULQ1nFBcihLE/vab41tbpSCzMmmgr
         JoW9w8GNWGKAQJPutMSY79TfLBfBi7j7rc2rauvN7n79ZV1oYxbMvTsgiMxYJrrk8u+X
         PRrl1TGHQ47rFk4/XQ83zrzEz681MyD3IJ0t0VkyZ2Ao/ozQu0CGbMbD3f8H/0pKPqI5
         2sGLqNxcPZlWQbRgATEEFj3+guTfhSTXhbF3RgxtX4jXcsmV2Ytj35GBfkWYq+7VSp3Q
         ilYA==
X-Forwarded-Encrypted: i=1; AJvYcCXPGlKmiwkp6wuMyAc3Zb0Tufbw8kPn85HSYByfYznwKCGr905VDitnduoHvLWJodTbgJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ4Fmw4m5k/nHvhnb0YO1t3EPGg3C9UOI+Ze5FRRnQ04EennNP
	9DkNR70+tr95XTBnz/T2ej7d4nJiXHbC6JD2peu8TiHrEUDNFoIoRZjhJVEYpW+1zR4Y5V76VHK
	Fm/YhOA==
X-Received: from plblf8.prod.google.com ([2002:a17:902:fb48:b0:2ae:54c3:f6d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f70a:b0:2ae:5044:8dd4
 with SMTP id d9443c01a7336-2aeca960929mr47051415ad.19.1773441860493; Fri, 13
 Mar 2026 15:44:20 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:44:18 -0700
In-Reply-To: <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313001024.136619-1-yosry@kernel.org> <20260313001024.136619-4-yosry@kernel.org>
 <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>
Message-ID: <abSTQifukogF5yEF@google.com>
Subject: Re: [PATCH v3 3/7] KVM: SVM: Move RAX legality check to SVM insn
 interception handlers
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Mar 13, 2026, Yosry Ahmed wrote:
> > @@ -2306,24 +2312,18 @@ static int gp_interception(struct kvm_vcpu *vcpu)
> >                 goto reinject;
> >
> >         opcode = svm_instr_opcode(vcpu);
> > +       if (opcode != NONE_SVM_INSTR)
> > +               return emulate_svm_instr(vcpu, opcode);
> >
> > -       if (opcode == NONE_SVM_INSTR) {
> > -               if (!enable_vmware_backdoor)
> > -                       goto reinject;
> > -
> > -               /*
> > -                * VMware backdoor emulation on #GP interception only handles
> > -                * IN{S}, OUT{S}, and RDPMC.
> > -                */
> > -               if (!is_guest_mode(vcpu))
> > -                       return kvm_emulate_instruction(vcpu,
> > -                               EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
> > -       } else {
> > -               if (!page_address_valid(vcpu, svm->vmcb->save.rax))
> > -                       goto reinject;
> > +       if (!enable_vmware_backdoor)
> > +               goto reinject;
> >
> > -               return emulate_svm_instr(vcpu, opcode);
> > -       }
> > +       /*
> > +        * VMware backdoor emulation on #GP interception only handles
> > +        * IN{S}, OUT{S}, and RDPMC.
> > +        */
> > +       if (!is_guest_mode(vcpu))
> > +               return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
> 
> AI review pointed out that we should not drop the page_address_valid()
> from here, because if an SVM instruction is executed by L2, and KVM
> intercepts the #GP, it should re-inject the #GP into L2 if RAX is
> illegal instead of synthesizing a #VMEXIT to L1. 

No, because the intercept has higher priority than the #GP due to bad RAX.

> My initial instincth is to keep the check here as well as in the intercept
> handlers, but no, L1's intercept should take precedence over #GP due to
> invalid RAX anyway. In fact, if L1 has the intercept set, then it must be set
> in vmcb02, and KVM would get a #VMEXIT on the intercept not on #GP.

Except for the erratum case.

> The actual problem is that the current code does not check if L1
> actually sets the intercept in emulate_svm_instr(). 

Oh dagnabbit.  I had thought about this, multiple times, but wrote it off as a
non-issue because if L1 wanted to intercept VMWHATEVER, KVM would set the intercept
in vmcb02 and would get _that_ instead of a #GP.  But the erratum case means that
hardware could have signaled #GP even when the instruction should have been
intercepted.

And I also forgot the KVM could be intercepting #GP for the VMware crud, which
would unintentionally grab the CPL case too.  Darn kitchen sink #GPs.

> So if L1 and KVM do not set the intercept, and RAX is invalid, the current
> code could synthesize a spurious #VMEXIT to L1 instead of reinjecting #GP.
> The existing check on RAX prevents that, but it doesn't really fix the
> problem because if we get #GP due to CPL != 0, we'll still generate a
> spurious #VMEXIT to L1. What we really should be doing in gp_interception()
> is:
> 
> 1. if CPL != 0, re-inject #GP.
> 2. If in guest mode and L1 intercepts the instruction, synthesize a #VMEXIT.
> 3. Otherwise emulate the instruction, which would take care of
> re-injecting the #GP if RAX is invalid with this patch.
> 
> Something like this on top (over 2 patches):
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index cf5ebdc4b27bf..8942272eb80b2 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2237,10 +2237,11 @@ static int emulate_svm_instr(struct kvm_vcpu
> *vcpu, int opcode)
>                 [SVM_INSTR_VMLOAD] = vmload_interception,
>                 [SVM_INSTR_VMSAVE] = vmsave_interception,
>         };
> +       int exit_code = guest_mode_exit_codes[opcode];
>         struct vcpu_svm *svm = to_svm(vcpu);
> 
> -       if (is_guest_mode(vcpu)) {
> -               nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
> +       if (is_guest_mode(vcpu) &&
> vmcb12_is_intercept(&svm->nested.ctl, exit_code))
> +               nested_svm_simple_vmexit(svm, exit_code);
>                 return 1;
>         }
>         return svm_instr_handlers[opcode](vcpu);
> @@ -2269,8 +2270,11 @@ static int gp_interception(struct kvm_vcpu *vcpu)
>                 goto reinject;
> 
>         opcode = svm_instr_opcode(vcpu);
> -       if (opcode != NONE_SVM_INSTR)
> +       if (opcode != NONE_SVM_INSTR) {
> +               if (svm->vmcb->save.cpl)
> +                       goto reinject;

Don't you need the page_address_valid() check here?  Ooooh, no, because either
emulate_svm_instr() will synthesize #VMEXIT, or svm_instr_handlers() will take
care of the #GP.  It's only CPL that needs to be checked early, because it has
priority over the #VMEXIT.

>                 return emulate_svm_instr(vcpu, opcode);
> +       }
> 
>         if (!enable_vmware_backdoor)
>                 goto reinject;
> 
> ---
> 
> Sean, do you prefer that I send patches separately on top of this
> series or a new version with these patches included?

Go ahead and send an entirely new series.  The less threads I have to chase down
after I get back, the less likely I am to screw things up :-)

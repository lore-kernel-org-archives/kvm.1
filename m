Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5F735B126
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425886; cv=none; b=OydhI2IvNwrqNN3dcBECGYGrEx3B6JxfhlKjWw3bZJK8QMWVrRpRz+dLaXj4j9bSIeFMeR+KwqNZVJQD983YaMyh6L9bFPV+YqDRnRLIFxndMCL5AlcA6g2rcYqJ9e2NPPxBD2gFPK3htTA17DnzltO2AW9OjANuAjq518BLUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425886; c=relaxed/simple;
	bh=GFCN8CvqPvt36O3WvapS03/CpdLAADkzHtGu21v2ozU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d50yeUB+0YqxxFtAmCO7LdEXZZUFWE2OZWt3Vp5UVsYiRivMOdVSYBNHAyPxIDU6qyJhWcBE9FVtSMZQWczUFDG3SjL5g339yhRDkj5iOwiPF0fF8WlgCNBxsmE1mDSMIkwRix6p6jWVAxqTaByDA9s0J51GgRYXL2GRRUelvj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbdjfgKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbdjfgKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97E0C2BC86
	for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773425885;
	bh=GFCN8CvqPvt36O3WvapS03/CpdLAADkzHtGu21v2ozU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jbdjfgKoLnxyMuKBr1/hjWn6aV/+chI6WJxeefqJMrYdccAm/NgMNeS6v5/mOvV+a
	 LQTzi4Q2aDNaG9lfg5yy7vORILLfyxSUkt767REH8O36+X9h1bA6B8SACDAEyTZhEw
	 RfhjUndyzOhlNe+cLzNoifjvkkWdEgLg7gLVhLapEV6gY3rk7hbI8C65YXVIbk5oHZ
	 RDQDUym9gxSRMJ3UDR5pcVQFbrSKMOeSWSiea+E535k1bkUb2k9Ij7moBwZhJA68PM
	 RXmnJNDoJfzeyMeeiAWw/3ix0lOs5Pj5X6SAvpBbQ8ttN8EmJPwGB+OWZR+q2ni6E4
	 XU2BHGmJD/rYg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b96e9c59339so380895266b.1
        for <kvm@vger.kernel.org>; Fri, 13 Mar 2026 11:18:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwmi5KSeHH/Aes9Plchknf5HCDW1vjvX4I5Qi0aRq38pXC0RrC8zRnt5m+ad5hGWkSnOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsthimbCAp0ZJHPtEhnzjaKzdJHpHJnNHeYnqt8ezcb0l9irH
	UVAQjPERR2LQYNVPED0l19q3+Onp6hSUgv2Gy15ogrS4Nnhezq0D2ZFIRmQ9hncbrKQ11uMbiyM
	L6F2Chan7i3rVZWz0HxItPuXRmJlzpE0=
X-Received: by 2002:a17:907:a089:b0:b97:6647:994b with SMTP id
 a640c23a62f3a-b9766479cb7mr270517666b.45.1773425884377; Fri, 13 Mar 2026
 11:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313001024.136619-1-yosry@kernel.org> <20260313001024.136619-4-yosry@kernel.org>
In-Reply-To: <20260313001024.136619-4-yosry@kernel.org>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 13 Mar 2026 11:17:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>
X-Gm-Features: AaiRm50Z7EVOXmXRcKB6U-9P-yKO_wkSN_6egdiLNUMf-fEr5ROeB7kw41C-LDQ
Message-ID: <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] KVM: SVM: Move RAX legality check to SVM insn
 interception handlers
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -2306,24 +2312,18 @@ static int gp_interception(struct kvm_vcpu *vcpu)
>                 goto reinject;
>
>         opcode = svm_instr_opcode(vcpu);
> +       if (opcode != NONE_SVM_INSTR)
> +               return emulate_svm_instr(vcpu, opcode);
>
> -       if (opcode == NONE_SVM_INSTR) {
> -               if (!enable_vmware_backdoor)
> -                       goto reinject;
> -
> -               /*
> -                * VMware backdoor emulation on #GP interception only handles
> -                * IN{S}, OUT{S}, and RDPMC.
> -                */
> -               if (!is_guest_mode(vcpu))
> -                       return kvm_emulate_instruction(vcpu,
> -                               EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
> -       } else {
> -               if (!page_address_valid(vcpu, svm->vmcb->save.rax))
> -                       goto reinject;
> +       if (!enable_vmware_backdoor)
> +               goto reinject;
>
> -               return emulate_svm_instr(vcpu, opcode);
> -       }
> +       /*
> +        * VMware backdoor emulation on #GP interception only handles
> +        * IN{S}, OUT{S}, and RDPMC.
> +        */
> +       if (!is_guest_mode(vcpu))
> +               return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);

AI review pointed out that we should not drop the page_address_valid()
from here, because if an SVM instruction is executed by L2, and KVM
intercepts the #GP, it should re-inject the #GP into L2 if RAX is
illegal instead of synthesizing a #VMEXIT to L1. My initial instinct
is to keep the check here as well as in the intercept handlers, but
no, L1's intercept should take precedence over #GP due to invalid RAX
anyway. In fact, if L1 has the intercept set, then it must be set in
vmcb02, and KVM would get a #VMEXIT on the intercept not on #GP.

The actual problem is that the current code does not check if L1
actually sets the intercept in emulate_svm_instr(). So if L1 and KVM
do not set the intercept, and RAX is invalid, the current code could
synthesize a spurious #VMEXIT to L1 instead of reinjecting #GP. The
existing check on RAX prevents that, but it doesn't really fix the
problem because if we get #GP due to CPL != 0, we'll still generate a
spurious #VMEXIT to L1. What we really should be doing in
gp_interception() is:

1. if CPL != 0, re-inject #GP.
2. If in guest mode and L1 intercepts the instruction, synthesize a #VMEXIT.
3. Otherwise emulate the instruction, which would take care of
re-injecting the #GP if RAX is invalid with this patch.

Something like this on top (over 2 patches):

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cf5ebdc4b27bf..8942272eb80b2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2237,10 +2237,11 @@ static int emulate_svm_instr(struct kvm_vcpu
*vcpu, int opcode)
                [SVM_INSTR_VMLOAD] = vmload_interception,
                [SVM_INSTR_VMSAVE] = vmsave_interception,
        };
+       int exit_code = guest_mode_exit_codes[opcode];
        struct vcpu_svm *svm = to_svm(vcpu);

-       if (is_guest_mode(vcpu)) {
-               nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
+       if (is_guest_mode(vcpu) &&
vmcb12_is_intercept(&svm->nested.ctl, exit_code))
+               nested_svm_simple_vmexit(svm, exit_code);
                return 1;
        }
        return svm_instr_handlers[opcode](vcpu);
@@ -2269,8 +2270,11 @@ static int gp_interception(struct kvm_vcpu *vcpu)
                goto reinject;

        opcode = svm_instr_opcode(vcpu);
-       if (opcode != NONE_SVM_INSTR)
+       if (opcode != NONE_SVM_INSTR) {
+               if (svm->vmcb->save.cpl)
+                       goto reinject;
                return emulate_svm_instr(vcpu, opcode);
+       }

        if (!enable_vmware_backdoor)
                goto reinject;

---

Sean, do you prefer that I send patches separately on top of this
series or a new version with these patches included?

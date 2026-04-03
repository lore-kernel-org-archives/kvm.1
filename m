Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CA2459CF
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252734; cv=none; b=iY/Jk9cIIroQISS+Jz5PwLNBhKwLSBmVN5TULiMwT/+x/n4UuhcZrhiI/3HwCClUvi0cRxiOHo8kIweBdJxbNJMwalfQg+k3xhMOcSzLs0m8ktQhN/dueKGu2bJrzWLGvFavGal9I53RNc4nIWopChmj+COWqHCx3Vmm0/r/mzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252734; c=relaxed/simple;
	bh=WRrxMcgkGJ0PoyFComhmHcKGC/lgoKFwu6xEw0JeV6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUAnSNHsKdsE5RpHei4vD5jM7wj6CzrwtB3XKXtCUx2S6o7LNpcA38UosQYuOvvpuY4JFyKWqHz43ygfalQsYgLhC0vFkXx2YHzE8YsfA76VyTlnYqbSkKLgTXoj+q9CIiQ7G4fM7eeRO16eGr5HIY6n62F74sW97k69hlYOS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH/y63Ab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH/y63Ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09B2C2BCB1
	for <kvm@vger.kernel.org>; Fri,  3 Apr 2026 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775252733;
	bh=WRrxMcgkGJ0PoyFComhmHcKGC/lgoKFwu6xEw0JeV6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mH/y63AbM1sz4X4+Yry7cJ6piBvpgL9pkId9e0jnpOlMEEreXCapWQTJS38yZ3D++
	 GsJBzpJWAhgJ+0bTT9499vrD6j1pAFTiWRvmlEp0FHmpvb6lZ4aqszBKC1s1UACGT/
	 HkTVpQyROZC3PAunv5rb+XeoZ+y1XHNVmqt+THXthr94SnO8Uyv461UZVVxgIYP83c
	 bQh3QtwzgPtom4WLksJjYR/0FBHK7ebpl0UkL6F3HSQULeLOQXL3qh+c1f79r+8h4Y
	 y1A8rUyrfxNelGcQwKCoBqsezqORl/SbY2fNH9plaDzGfg42a0NcgM+ppIykDUD0R3
	 ttmRY+2VuvOeA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so385663266b.2
        for <kvm@vger.kernel.org>; Fri, 03 Apr 2026 14:45:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIynkRhosFxi775CCfQPVUGMn7ZVW43WZA2U+uRtKV6iwtgwYMCIr3qmSL1ZyZzeQa8bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX33wMXAQxV8ynCDB0qE257CIMgc0TOZprxg8D24+kA51zYvPZ
	fscGU7PqBFBDmdi13bOtFdgksYUhxAUG6PakOJvFwft01svlmoxMI/I4wy1quF5o028jnEYE32v
	gxkIR92CXbM+1q1ky+rSPKM6BRIwG578=
X-Received: by 2002:a17:907:e113:b0:b96:fcf1:ede9 with SMTP id
 a640c23a62f3a-b9c67a10b5amr157138766b.36.1775252732386; Fri, 03 Apr 2026
 14:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316202732.3164936-1-yosry@kernel.org> <20260316202732.3164936-3-yosry@kernel.org>
 <adAEjw56f_4cuUNR@google.com>
In-Reply-To: <adAEjw56f_4cuUNR@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 3 Apr 2026 14:45:20 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMw21N7DKWsFT2M5z6EH2WzUmm_NfiQ9w2axsF1E0h0EQ@mail.gmail.com>
X-Gm-Features: AQROBzBa-_OEDmNSZa0fJ1f83u2jsske2mQehnXMD9laffOAOEYFt3m0McIXhsI
Message-ID: <CAO9r8zMw21N7DKWsFT2M5z6EH2WzUmm_NfiQ9w2axsF1E0h0EQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] KVM: SVM: Refactor SVM instruction handling on #GP intercept
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 11:18=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Mar 16, 2026, Yosry Ahmed wrote:
> > +/* Return 0 if not SVM instr, otherwise return associated exit_code */
> > +static u64 svm_instr_exit_code(struct kvm_vcpu *vcpu)
>
> To make it very clear what this is doing how about:
>
> static u64 svm_get_decoded_instr_exit_code(struct kvm_vcpu *vcpu)

Yeah I like this better.

>
> >  {
> >       struct x86_emulate_ctxt *ctxt =3D vcpu->arch.emulate_ctxt;
> >
> >       if (ctxt->b !=3D 0x1 || ctxt->opcode_len !=3D 2)
> > -             return NONE_SVM_INSTR;
> > +             return 0;
>
> This should assert to ensure there's no collision with '0', i.e.
>
>         BUILD_BUG_ON(!SVM_EXIT_VMRUN || !SVM_EXIT_VMLOAD || !SVM_EXIT_VMS=
AVE);

I was gonna add this but I don't think these values can change anyway.
It's good for readability tho so I am fine with it.

>
>
> > +     if (!is_guest_mode(vcpu))
> > +             return kvm_emulate_instruction(vcpu,
> > +                             EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
>
> Since you're moving this anyways:
>
>         if (!is_guest_mode(vcpu))
>                 return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP |
>                                                      EMULTYPE_NO_DECODE);
>
>
> Actually!  Better idea, for this code and for the page_address_valid() ch=
ecks:
> invert the checks to reduce indentation, i.e. end up with:
>
>         /* FIXME: Handle SVM instructions through the emulator */
>         svm_exit_code =3D svm_get_decoded_instr_exit_code(vcpu);
>         if (svm_exit_code) {
>                 if (!is_guest_mode(vcpu))
>                         return svm_invoke_exit_handler(vcpu, svm_exit_cod=
e);
>
>                 if (nested_svm_check_permissions(vcpu))
>                         return 1;
>
>                 if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCP=
U_REGS_RAX)))
>                         goto reinject;
>
>                 /*
>                  * FIXME: Only synthesize a #VMEXIT if L1 sets the interc=
ept,
>                  * but only after the VMLOAD/VMSAVE exit handlers can pro=
perly
>                  * handle VMLOAD/VMSAVE from L2 with VLS enabled in L1 (i=
.e.
>                  * RAX is an L2 GPA that needs translation through L1's N=
PT).
>                  */
>                 nested_svm_simple_vmexit(svm, svm_exit_code);
>                 return 1;
>         }
>
>         /*
>          * VMware backdoor emulation on #GP interception only handles
>          * IN{S}, OUT{S}, and RDPMC, and only for L1.
>          */
>         if (!enable_vmware_backdoor || is_guest_mode(vcpu))
>                 goto reinject;
>
>         return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYP=
E_NO_DECODE);
>
> > +
> >  reinject:
> >       kvm_queue_exception_e(vcpu, GP_VECTOR, error_code);
> >       return 1;


The end result looks good to me.
